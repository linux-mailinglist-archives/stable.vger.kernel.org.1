Return-Path: <stable+bounces-48008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8618FCB13
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207221F21FE0
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59236195F1F;
	Wed,  5 Jun 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOvP9frr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F28195F17;
	Wed,  5 Jun 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588206; cv=none; b=c6tsKfce2hHuJPxxZEKGDdOfaZrsr6ywXFZy2EUaYA/DOIK8ILuen0MM+OQL1BN4fEx/M2k9lWq4/OCc1iCpuAtVCULEwtgwVkNoFIZDZd/UAlPz+YZ8/yd19umbS530EfKfCD91Sl1ucnqAew8JMSoXYfE8AO+usSN3S9sZWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588206; c=relaxed/simple;
	bh=ZPF7T9kuWu/BZfONDXqgsMzLC8AUBVBAEKzU6hLpZ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDB7CAkFec78+Hv6/+0ynDbN5WDKye73LjAm9i6dcnF17kUyM6sVDZXiB3cD078lvpg8uBf0cDYrXCUQRQdTiacZXMrPGVLFRPR/KFz6RZvB2Z/Ku0E2KncK7Aj/8lb55AYwQUQRX/Purz6Ha4HOm7hzkgZ7xx3liTIHsRDvU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOvP9frr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AE6C32781;
	Wed,  5 Jun 2024 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588205;
	bh=ZPF7T9kuWu/BZfONDXqgsMzLC8AUBVBAEKzU6hLpZ9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOvP9frrfx/hc2OqJQZKPWRjbatq/8CQjKQCh2azbBJDLd4PWfoVNRrDKksy2TPEM
	 Um6Ibm8j8FalbXL9Au+6ax65APYATHCCnnORzP1nPF5/U88TgM8qkCLHGngQpuo6gJ
	 CopUwfybgV+WnTzJCaUSQ5Fz+n65XJ+sjn1K3p+JkNXC/dCqFIzF1ovnxw6EnPp3hi
	 k7856AzFZqQJOe6SjQryT5fb6TfRH7gNWVCrwcEzLNuBTvcykIA4IYG9BLbnPR6hI7
	 txXtA9wBhpeRaN1TwvFzEk/8sZhXYRQYSfmFdHYTupimKI2beh51XYLhzk0Mos5TnU
	 OmmohAwtxR9Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	aladyshev22@gmail.com,
	ivan.orlov0322@gmail.com,
	azeemshaikh38@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 15/28] usb: gadget: function: Remove usage of the deprecated ida_simple_xx() API
Date: Wed,  5 Jun 2024 07:48:44 -0400
Message-ID: <20240605114927.2961639-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 920e7522e3bab5ebc2fb0cc1a034f4470c87fa97 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/7cd361e2b377a5373968fa7deee4169229992a1e.1713107386.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c     | 6 +++---
 drivers/usb/gadget/function/f_printer.c | 6 +++---
 drivers/usb/gadget/function/rndis.c     | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3c8a9dd585c09..2db01e03bfbf0 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1029,9 +1029,9 @@ static inline int hidg_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&hidg_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&hidg_ida, GFP_KERNEL);
 	if (ret >= HIDG_MINORS) {
-		ida_simple_remove(&hidg_ida, ret);
+		ida_free(&hidg_ida, ret);
 		ret = -ENODEV;
 	}
 
@@ -1176,7 +1176,7 @@ static const struct config_item_type hid_func_type = {
 
 static inline void hidg_put_minor(int minor)
 {
-	ida_simple_remove(&hidg_ida, minor);
+	ida_free(&hidg_ida, minor);
 }
 
 static void hidg_free_inst(struct usb_function_instance *f)
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 076dd4c1be96c..ba7d180cc9e6d 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1312,9 +1312,9 @@ static inline int gprinter_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&printer_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&printer_ida, GFP_KERNEL);
 	if (ret >= PRINTER_MINORS) {
-		ida_simple_remove(&printer_ida, ret);
+		ida_free(&printer_ida, ret);
 		ret = -ENODEV;
 	}
 
@@ -1323,7 +1323,7 @@ static inline int gprinter_get_minor(void)
 
 static inline void gprinter_put_minor(int minor)
 {
-	ida_simple_remove(&printer_ida, minor);
+	ida_free(&printer_ida, minor);
 }
 
 static int gprinter_setup(int);
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 29bf8664bf582..12c5d9cf450c1 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -869,12 +869,12 @@ EXPORT_SYMBOL_GPL(rndis_msg_parser);
 
 static inline int rndis_get_nr(void)
 {
-	return ida_simple_get(&rndis_ida, 0, 1000, GFP_KERNEL);
+	return ida_alloc_max(&rndis_ida, 999, GFP_KERNEL);
 }
 
 static inline void rndis_put_nr(int nr)
 {
-	ida_simple_remove(&rndis_ida, nr);
+	ida_free(&rndis_ida, nr);
 }
 
 struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v)
-- 
2.43.0


