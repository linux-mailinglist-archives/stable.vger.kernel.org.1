Return-Path: <stable+bounces-109754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A048A183BE
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54AD16638E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04241F7545;
	Tue, 21 Jan 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zr3SUO57"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF51F55E3;
	Tue, 21 Jan 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482341; cv=none; b=lP1LA0uBkUpXH8ZREmuTlW3zwFWRCIXlwj5pGaXIdoCNLtqUH/ft2XmU0vFioyWAmMlLh0xX8ZrmbVVAeS63YenpkzfolrSPLRaF7dqR/n5Lq/cv5kJcc10uHTWP7oPkQQGFabW9YDHyBLo1BycZPdzXuywGB10M15EC0Zo9y1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482341; c=relaxed/simple;
	bh=AYTGtx04aVWx7aS4hV6D9wEBNW+6FRUhmbr8ZSsM2MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jflMs9C93UKaLEFfozyZUy4/dQ4797OuJzWcr1EPNl8UCeBsVwdPvdOUzC/8cP5tkyKjPA3s27piGoJSKz00n26NebL6SKNjldR3qEW+VniInG8bifV3rswY9/VaW5YuOOy83uilFsRk9ZtS5ib8roin00rpxRgrpcLkduk0XK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zr3SUO57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0DCC4CEDF;
	Tue, 21 Jan 2025 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482341;
	bh=AYTGtx04aVWx7aS4hV6D9wEBNW+6FRUhmbr8ZSsM2MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zr3SUO57/jwzJQGZ0p03GdGJmAuNhJ7loGLaIOs4IMJxBuUJTub4cdDNJCaqQjYyE
	 Md3mdjQt/xMCCrbMS1C4jcUQl5MX5f3XxJiqLu5Cou5cCu9V4HNVQnpPJBQb87w7hq
	 QpnXEt5KZjuLI7DidMOMt+tsZDuqWBfDXW8Q5PMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/122] i2c: mux: demux-pinctrl: check initial mux selection, too
Date: Tue, 21 Jan 2025 18:51:32 +0100
Message-ID: <20250121174534.681617495@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit ca89f73394daf92779ddaa37b42956f4953f3941 ]

When misconfigured, the initial setup of the current mux channel can
fail, too. It must be checked as well.

Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 7e2686b606c04..cec7f3447e193 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -261,7 +261,9 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 	pm_runtime_no_callbacks(&pdev->dev);
 
 	/* switch to first parent as active master */
-	i2c_demux_activate_master(priv, 0);
+	err = i2c_demux_activate_master(priv, 0);
+	if (err)
+		goto err_rollback;
 
 	err = device_create_file(&pdev->dev, &dev_attr_available_masters);
 	if (err)
-- 
2.39.5




