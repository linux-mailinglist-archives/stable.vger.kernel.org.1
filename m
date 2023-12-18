Return-Path: <stable+bounces-7609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC91817355
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F279B24921
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA0129EF9;
	Mon, 18 Dec 2023 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXbeg/Xc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE48129EDD;
	Mon, 18 Dec 2023 14:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B497FC433C7;
	Mon, 18 Dec 2023 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908925;
	bh=bIFirJQcXjlXjZXjeI5tK8JyfPr4T6jpYPcrspx8VFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXbeg/XcFmeLzpaq4dbOzbopaEPj0HN1c7q+KwIGbo1lYysY5ji06aQ5cPpBixHwu
	 FBT9dil14U+ZSOxf+7TGMn4bNo0xe6ZYK2ErIYH6mwEhKTmvsVvjH2v3+btLGWD6Lo
	 Z59t3fu/XAfttNcRhcga/PSL9H/qoRpAODgOVmZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hayes Wang <hayeswang@realtek.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 83/83] r8152: fix the autosuspend doesnt work
Date: Mon, 18 Dec 2023 14:52:44 +0100
Message-ID: <20231218135053.398963816@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hayes Wang <hayeswang@realtek.com>

commit 0fbd79c01a9a657348f7032df70c57a406468c86 upstream.

Set supports_autosuspend = 1 for the rtl8152_cfgselector_driver.

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/r8152.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9913,6 +9913,7 @@ static struct usb_device_driver rtl8152_
 	.probe =	rtl8152_cfgselector_probe,
 	.id_table =	rtl8152_table,
 	.generic_subclass = 1,
+	.supports_autosuspend = 1,
 };
 
 static int __init rtl8152_driver_init(void)



