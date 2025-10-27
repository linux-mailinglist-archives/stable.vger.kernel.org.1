Return-Path: <stable+bounces-190405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C777C10678
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68FA565FC8
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415C132B991;
	Mon, 27 Oct 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqMOTpb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2C32AAC5
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591207; cv=none; b=i6Vzqn/ZW1g7Ra6XvnEBLnFEsaGoG9I20cTE/l//VRQd1rk9qiRd5wmdd99Y2L8huUfjrVhMnbQ5k3hf04jLFAR9u3ppG5cnPNbsfY+JjgbcRh836HZkDvkCanTbTk/KtJBlO+JHz17ZMiDIuGpxxbh3BXCDUhOffiqQNDv2KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591207; c=relaxed/simple;
	bh=gIh5o5zJqzGWp1zvTNPnh2/YBlWC9vARpvjPU7RFYCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETD5SOlWt3kzsneng/kndqNUC9jZr6F/zK/iySW+M1X4SPWdijXtsZzbRp++RwMrTV3bdOayHWP7JXFk2ZsAxAFxhDWq6n2hxxVsFZi/AhRWIQUXFggG1Gf39HydolcXTY13QSPA2cCtzDHTGRcq1tOuYeTqTI1MEsZaDLWOVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqMOTpb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A37C116D0;
	Mon, 27 Oct 2025 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761591206;
	bh=gIh5o5zJqzGWp1zvTNPnh2/YBlWC9vARpvjPU7RFYCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqMOTpb88LWDPITZ5J6xmvZ4qjE2DYF4T5oqKJxnqmorOkauqav6tlkV18tC+1mlt
	 yMr7Arn8cik5Iv+qz1Q6PZUw+LQAtp/zFbuh5o8gZlHsaQBP3FZ8213FQ3H93AL26V
	 lj/3nwQKme8tVCPrMLVTYgatg/LSHKjJ+hUGkt2osJLRH7Mvhcqt9aRfvctHpntvvd
	 NogYmO/S9GxnsKOBz1yfYuZNTHlev76TyBZMIkfM2TY88QHrtwtQJ+C8c21dLTtKf6
	 hECFmGkjV/q/cQo5edOFaJzkMmqk6COWyJhkfzQMvhOgr8eFarHbMnL2sRGKMG3upn
	 u082Sb0EwZHew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] serial: sc16is7xx: remove useless enable of enhanced features
Date: Mon, 27 Oct 2025 14:53:21 -0400
Message-ID: <20251027185321.644316-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027185321.644316-1-sashal@kernel.org>
References: <2025102739-fable-reroute-e6a6@gregkh>
 <20251027185321.644316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 1c05bf6c0262f946571a37678250193e46b1ff0f ]

Commit 43c51bb573aa ("sc16is7xx: make sure device is in suspend once
probed") permanently enabled access to the enhanced features in
sc16is7xx_probe(), and it is never disabled after that.

Therefore, remove re-enable of enhanced features in
sc16is7xx_set_baud(). This eliminates a potential useless read + write
cycle each time the baud rate is reconfigured.

Fixes: 43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed")
Cc: stable <stable@kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20251006142002.177475-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index c0c2c1450e88d..458bf16543724 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -582,13 +582,6 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= prescaler;
 	}
 
-	/* Enable enhanced features */
-	sc16is7xx_efr_lock(port);
-	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_ENABLE_BIT,
-			      SC16IS7XX_EFR_ENABLE_BIT);
-	sc16is7xx_efr_unlock(port);
-
 	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
-- 
2.51.0


