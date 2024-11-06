Return-Path: <stable+bounces-91368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4B9BEDA7
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E01F254FB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27281EE035;
	Wed,  6 Nov 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bd+2zxzT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E751E0083;
	Wed,  6 Nov 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898530; cv=none; b=QqdKra5nl/OVfsdtGXX4+Xzn/gfBqWNXjX5TKTOVTdf6LPsnICnqcEGS847ORpmsz4oD2UVmELSwnQi/w5MPB5T0PdjkKd9l6YBg6g6SbqXVdm+BI38TyVqNg7Gf82tATyfwcvA8neP7/ok2edcqgbK2+KpGILwtdYUIVwAoX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898530; c=relaxed/simple;
	bh=rFtWXMJ2sbI4Wf1uhatw14ir3/VhtYWu7qmfvU1rPq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgrvsJ9jUExX5Z1xv8nzkImio2wXDW9yKvmC/tluqsUcr3fkqL7HWjavJnfPyQZh7K4Uxp5icWXtdr4/Em3M0MnGfYMuOi7yO8H07aV3LRrMBth7jk3IcQxblCP7DXPeEKZzg1BdsxMCPQqQ8sr+6IMH2ar5f8aKA2muYYNgl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bd+2zxzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA92FC4CED5;
	Wed,  6 Nov 2024 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898530;
	bh=rFtWXMJ2sbI4Wf1uhatw14ir3/VhtYWu7qmfvU1rPq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bd+2zxzTTwnffi0sJtWLpxLL5qO2mAqgBA1Y1M5nKCaSab7OzX2eFwjpfBavTB0dX
	 TdRg5Eajeew0fgS+f3jMWBU/UcXMWwXf3JOTav213ukbNidiGAOc8Kkz4hcmQMmZ9s
	 l0FoQKbdwHXKSC4k727VpNKNJmnjS13jyB+Z2tFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 232/462] of/irq: Refer to actual buffer size in of_irq_parse_one()
Date: Wed,  6 Nov 2024 13:02:05 +0100
Message-ID: <20241106120337.254766511@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 39ab331ab5d377a18fbf5a0e0b228205edfcc7f4 ]

Replace two open-coded calculations of the buffer size by invocations of
sizeof() on the buffer itself, to make sure the code will always use the
actual buffer size.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/817c0b9626fd30790fc488c472a3398324cfcc0c.1724156125.git.geert+renesas@glider.be
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index ad0cb49e233ac..70ac9cb3b2c67 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -301,8 +301,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
-	if (addr_len > (3 * sizeof(__be32)))
-		addr_len = 3 * sizeof(__be32);
+	if (addr_len > sizeof(addr_buf))
+		addr_len = sizeof(addr_buf);
 	if (addr)
 		memcpy(addr_buf, addr, addr_len);
 
-- 
2.43.0




