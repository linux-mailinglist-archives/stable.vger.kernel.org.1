Return-Path: <stable+bounces-190154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC9C10089
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C6A462EC8
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D832142E;
	Mon, 27 Oct 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJd0ry3F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4203203A9
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590571; cv=none; b=N+ySemSbNNNmIcFA7rIRmGCBfyEm4vAZ2tahwQlYty6T9Mu4SxJnxLT9y+h2wJTgOX+kS3BPYpozzkpH9uelelBGRVed9F75Al1JQvcDQcQlYw3qCQEl+Lq+fZOclvpw7lIBukatw6V3CUoHEKqbSs4X2e7nwaLcF037qrkDS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590571; c=relaxed/simple;
	bh=kIKcUZnh2nFyWsA4UWLyWkxU58YvRX+YT0H1U4CwxEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMYm2lOiVbzA9SOwVS10F5GFwUPazQ+QvgVehxsa0x/e2oIrzTNilohn1CYkQUnEXEzHJGdAQGQQv5I/nUwnuq9lj8IsX6/g3M5ogcSNOuyfSThzKMwKhyzVaG9Vv2e2zCzVMOiUN9MOCBjlUFwa7wmGC5RTEKB7t9V/wFRCUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJd0ry3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB8BC4CEF1;
	Mon, 27 Oct 2025 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590571;
	bh=kIKcUZnh2nFyWsA4UWLyWkxU58YvRX+YT0H1U4CwxEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJd0ry3FJ479S3v9kUznAqluGoGRc+OLWTIw6oiLyYv6Sr7CpocBfhImhbCXMb7RL
	 WwZSNqszojW599pW5YiPGmLRgV4figj1Q4u1r5trZT7c7O4VASEOoXhcp0KfyEhtnp
	 6uVpPXWL1lOCet2mAuqLGNfbyH2dhNXI9f1Jgax2aO6SEUma6LgucqvMFxemRUvhT9
	 8rtRYUK9XuHe644uJ0XJyWaVtsweIWYNOv7avV1FCtxovwwFZZctTQbY167Nmurfkr
	 ViTI54R/LvS/W7esbsl/HkKA+h/XjY1WnIo7KWbOQ+bLpjfJ4EDI2Sg+/9K23r4Lcf
	 EW3UaLjVZgb+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] serial: sc16is7xx: remove useless enable of enhanced features
Date: Mon, 27 Oct 2025 14:42:46 -0400
Message-ID: <20251027184246.638748-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027184246.638748-1-sashal@kernel.org>
References: <2025102739-casualty-hankering-f9ab@gregkh>
 <20251027184246.638748-1-sashal@kernel.org>
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
index 1fafe3257270a..b5f9a40f4a819 100644
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


