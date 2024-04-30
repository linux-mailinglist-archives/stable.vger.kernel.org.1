Return-Path: <stable+bounces-41989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D278B70CD
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B366EB21301
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACE12C499;
	Tue, 30 Apr 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sBQ+pnS1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACC12C46B;
	Tue, 30 Apr 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474199; cv=none; b=Kf1KsSksbm0WwUODfMFSCdOi1A9o0Swl5be76/rwEbGLcIuKzVx/5lyK/U8jqix8Ec68i3A2sfAV2B+SwsnMwQ9MXETrTvaHUwXSZJl7BjBpnpbS8O0l67Xxy8dkSwRwU6tgOXHqZDfNMsb8QQDIzcXkbLyhgEUiv3DaLDj+h1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474199; c=relaxed/simple;
	bh=ToIrrOJ7K1KIPFFaoc4DeW2po+QS2kYRa2xPVkB89S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0cPRecltXetSpc+QNVp2sBEqrjbquBYa0zk6DqQP3TaqUMzR4Bbfh54vAERVp0Co4wg6J68czRJZPsMG8LAyao6qUfKZyiU4qJ8QnJKR88HMs2qYSd16+PXuYkRl2wmnbYxQ7tWsb5f5dnQ/f0TO1lj10ARFTVXPivAewBErSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sBQ+pnS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E21FC2BBFC;
	Tue, 30 Apr 2024 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474198;
	bh=ToIrrOJ7K1KIPFFaoc4DeW2po+QS2kYRa2xPVkB89S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBQ+pnS1jmgd9+5GbQjUM68lfQIkV31GPBJ7wf/ednFJUfrDJzECOBvORt98dntyp
	 YB3i725lrqpNkNdNVzK3KpSAVdn2dyQNJYAHl6S0QQBXPSGioNsevT+maueoK7jAI3
	 Tx4F55XpT4j/4gQl+5UlQ9aaXIEnHDn+/vlxGW38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 059/228] bnxt_en: Fix error recovery for 5760X (P7) chips
Date: Tue, 30 Apr 2024 12:37:17 +0200
Message-ID: <20240430103105.511763577@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 41e54045b741daf61e03c82d442227af3d12111f ]

During error recovery, such as AER fatal error slot reset, we call
bnxt_try_map_fw_health_reg() to try to get access to the health
register to determine the firmware state.  Fix
bnxt_try_map_fw_health_reg() to recognize the P7 chip correctly
and set up the health register.

This fixes this type of AER slot reset failure:

bnxt_en 0000:04:00.0: AER: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
bnxt_en 0000:04:00.0 enp4s0f0np0: PCI I/O error detected
bnxt_en 0000:04:00.0 bnxt_re0: Handle device suspend call
bnxt_en 0000:04:00.1 enp4s0f1np1: PCI I/O error detected
bnxt_en 0000:04:00.1 bnxt_re1: Handle device suspend call
pcieport 0000:00:02.0: AER: Root Port link has been reset (0)
bnxt_en 0000:04:00.0 enp4s0f0np0: PCI Slot Reset
bnxt_en 0000:04:00.0: enabling device (0000 -> 0002)
bnxt_en 0000:04:00.0: Firmware not ready
bnxt_en 0000:04:00.1 enp4s0f1np1: PCI Slot Reset
bnxt_en 0000:04:00.1: enabling device (0000 -> 0002)
bnxt_en 0000:04:00.1: Firmware not ready
pcieport 0000:00:02.0: AER: device recovery failed

Fixes: a432a45bdba4 ("bnxt_en: Define basic P7 macros")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6bdd8c2607898..5b4d810748f2a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8906,7 +8906,7 @@ static void bnxt_try_map_fw_health_reg(struct bnxt *bp)
 					     BNXT_FW_HEALTH_WIN_BASE +
 					     BNXT_GRC_REG_CHIP_NUM);
 		}
-		if (!BNXT_CHIP_P5(bp))
+		if (!BNXT_CHIP_P5_PLUS(bp))
 			return;
 
 		status_loc = BNXT_GRC_REG_STATUS_P5 |
-- 
2.43.0




