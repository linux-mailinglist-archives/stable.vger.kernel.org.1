Return-Path: <stable+bounces-48058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DF8FCBD3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5ECC1C23986
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD8195B3B;
	Wed,  5 Jun 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5ngsFAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33C195B2A;
	Wed,  5 Jun 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588381; cv=none; b=M8/d65v20wVdmj9OI1VLAlVcL6A1sKZXMNlgKfSGvQvdscs9Db4CGvZtFDfjifnTnwdaBglMJYDwDXeA7BeO9A3Ag73IpiSNYAPfBFE8g0px5hEzecjfRTrxr6ySKFlqLmC6Em4avM9DU93NQ4QZqiz/LClP6ZizWL+xuS3rMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588381; c=relaxed/simple;
	bh=ZPF7T9kuWu/BZfONDXqgsMzLC8AUBVBAEKzU6hLpZ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+86r3ydU4hVaw4wlL8EUA1k8EehE70Y/rIGVKYSG5JlfWU03rasi9lxzDdslCalkPgcCLOhUmWaEYYTtJ5ZKY6nMH/XHNfKNgIW6hNTOAd2Ws7FDXN9J9K79ciRkh9QbZLGJ3ZWdMJIgLHg2AAS5ntgdkUJnhbXsYzHTdIoiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5ngsFAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F499C32781;
	Wed,  5 Jun 2024 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588381;
	bh=ZPF7T9kuWu/BZfONDXqgsMzLC8AUBVBAEKzU6hLpZ9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5ngsFAczP4/Kol7GtgAqIcw7SmXsRPxONEUl5VWmsku6y6IuKPPSGl/kxlg/JPrJ
	 zNWBWuZgtd4V0GMOs1VNXYLRBD7IE5/ELayTu1BmU+tjN3KLDpSyY1dTt6l2u6VHWL
	 T0Oot5eEP/kFXeOYwC3DDqDDCQZgxxxf/xARSDHR302Pmr03U/7G89ZCoOh/sZqbY/
	 9DrGFI+V2UJLtIAYO9+39sa3GM+XHeYh1bd2sHMc+HvEk0lnnfd+6YbEGnINgcsLYG
	 V1Hq7NTtLv/AqGmiTJxePJNgvTRaATQxYdDbuSuNugYBpkRQQUJn3mj0JhkWMKD+tu
	 qXOJ/yU36WJkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	ivan.orlov0322@gmail.com,
	aladyshev22@gmail.com,
	azeemshaikh38@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/20] usb: gadget: function: Remove usage of the deprecated ida_simple_xx() API
Date: Wed,  5 Jun 2024 07:51:56 -0400
Message-ID: <20240605115225.2963242-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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


