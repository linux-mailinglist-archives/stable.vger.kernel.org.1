Return-Path: <stable+bounces-48076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1288FCC12
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE71F24359
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5D1B141D;
	Wed,  5 Jun 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0QC5DyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33F1B1408;
	Wed,  5 Jun 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588441; cv=none; b=X44m1LnhFAckDVSePHtJh9nfg5ECp48ChIsSPQa3oedyiFRCe7hR/Xz8+vASs6FR5pXd3kFX+uWQaoVDs8Kwu+/8RY5FJOgbuUJ6q7zHXzUm+F3WXfVtG0i6m71wBK05GOHqEfuzS41zb3e+Q+ylwnz2FYy1KkZfMtuzPEWXEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588441; c=relaxed/simple;
	bh=I1cLYhMYobYuzz+f5gJeRK0PZzYtjFyd+VHC04L27oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvQyFQJhaoePFu2XWdR1BG9Q8hUgVE9537Tm0gcVTwaZtFGXisLQJ3S0W7Ag4nEArWDpswSM1mtdDO4NLctx7N4AChAjDU+gJ9aqeeDVIdBPqX3HJMyErXHTIrkdsMbiDRXOPtBsosw2sUooRBRYKwcYbY/ekOOw/ybWEV5ZRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0QC5DyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E577C3277B;
	Wed,  5 Jun 2024 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588441;
	bh=I1cLYhMYobYuzz+f5gJeRK0PZzYtjFyd+VHC04L27oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0QC5DyFFnWe4tt3QAYuMa0bJleOl8W1cIm/fkkK5MzAbJf0d5VI2l2D+QZgSVIMb
	 BoaGNhwGMeaNXnCBNDiRVLa25FtCOg/BsvtWyuNkCEiVxWFD+6phoY2nUfLo7Iw9ZM
	 maDpYQBO8ypVxpqmhSTqerkniAtiwARd7UeOy+TWwGoFs3k2tUHA5Xp3kEQN/fn3bD
	 mEXOJSOy2uMh/I9ZxVtI5mzl8sThEICpagrgaVfH61rIy++aWfpfShSlM5s6Yv+GXV
	 RaH6lLERwjx5rx8A0YRFp1OpsLbwue4ZrjUQBSF+n+s9qVvUdJoP+RbExTuFvS+Ldv
	 IjXE1Sl1J6kvA==
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
Subject: [PATCH AUTOSEL 6.1 10/12] usb: gadget: function: Remove usage of the deprecated ida_simple_xx() API
Date: Wed,  5 Jun 2024 07:53:15 -0400
Message-ID: <20240605115334.2963803-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115334.2963803-1-sashal@kernel.org>
References: <20240605115334.2963803-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index f1ca9250cad96..bb558a575cb15 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1025,9 +1025,9 @@ static inline int hidg_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&hidg_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&hidg_ida, GFP_KERNEL);
 	if (ret >= HIDG_MINORS) {
-		ida_simple_remove(&hidg_ida, ret);
+		ida_free(&hidg_ida, ret);
 		ret = -ENODEV;
 	}
 
@@ -1172,7 +1172,7 @@ static const struct config_item_type hid_func_type = {
 
 static inline void hidg_put_minor(int minor)
 {
-	ida_simple_remove(&hidg_ida, minor);
+	ida_free(&hidg_ida, minor);
 }
 
 static void hidg_free_inst(struct usb_function_instance *f)
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index a881c69b1f2bf..8545656419c71 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1316,9 +1316,9 @@ static inline int gprinter_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&printer_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&printer_ida, GFP_KERNEL);
 	if (ret >= PRINTER_MINORS) {
-		ida_simple_remove(&printer_ida, ret);
+		ida_free(&printer_ida, ret);
 		ret = -ENODEV;
 	}
 
@@ -1327,7 +1327,7 @@ static inline int gprinter_get_minor(void)
 
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


