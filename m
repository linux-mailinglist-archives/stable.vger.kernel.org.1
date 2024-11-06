Return-Path: <stable+bounces-90713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330859BE9C1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC4F281A0F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321061E104A;
	Wed,  6 Nov 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsjYeHzm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1F1E103C;
	Wed,  6 Nov 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896592; cv=none; b=GATmtra/usiQapnc9JMG/H/ZovPFJZlt4bjz9r/v4rKgQZQ4W5HznJxLyzv9TWYs9GmSaWlaTlzvpUEwfzERrbeOpl88aGKi6Y4RLkK+df43KiBWm6tg/uNHcUwqxL8WQSTiA6fyaDu/IzFec9WUwQ2iU+jE9Q8u37ZzaHoy/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896592; c=relaxed/simple;
	bh=fMApUoBvlRiiJG3ABqgKATOMluJBo0pa3Fe/kWshLrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfpX+k9uLDMYwp5e5/voF0XaYfAEkwY+QJ8RmWI105qQZtZswgD42x0+LvmciSj7d9j+9YB7BTYhYfAdNz29bcbEtVn/NNXRq++kK7hg+/82DCKJ8Ju4LshIzneKlPlqzcgwAORs2Yxd0xdrPhCuxc29yWDYwJ/P09ZZX/p7pcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsjYeHzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FDEC4CECD;
	Wed,  6 Nov 2024 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896591;
	bh=fMApUoBvlRiiJG3ABqgKATOMluJBo0pa3Fe/kWshLrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsjYeHzm+p/v5Au7K2x++L98W7VfdHQ/kA4R7s+D9sokhkaqxn36DThsw5KzDwrDD
	 J+ylIcNuTpOx9VQhvPCf9S/Y1O7ZhZg1jAFtY09rsPrh5f3YOBuzsVfoAzI/j0t5U1
	 yzrpGSDnmtT8efDW93AVHvEAzyWB0TEoArX9IhKQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 234/245] drm/xe: Support nomodeset kernel command-line option
Date: Wed,  6 Nov 2024 13:04:47 +0100
Message-ID: <20241106120325.024596860@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 014125c64d09e58e90dde49fbb57d802a13e2559 upstream.

Setting 'nomodeset' on the kernel command line disables all graphics
drivers with modesetting capabilities, leaving only firmware drivers,
such as simpledrm or efifb.

Most DRM drivers automatically support 'nomodeset' via DRM's module
helper macros. In xe, which uses regular module_init(), manually call
drm_firmware_drivers_only() to test for 'nomodeset'. Do not register
the driver if set.

v2:
- use xe's init table (Lucas)
- do NULL test for init/exit functions

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240827121003.97429-1-tzimmermann@suse.de
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_module.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <drm/drm_module.h>
+
 #include "xe_drv.h"
 #include "xe_hw_fence.h"
 #include "xe_pci.h"
@@ -61,6 +63,14 @@ module_param_named_unsafe(wedged_mode, x
 MODULE_PARM_DESC(wedged_mode,
 		 "Module's default policy for the wedged mode - 0=never, 1=upon-critical-errors[default], 2=upon-any-hang");
 
+static int xe_check_nomodeset(void)
+{
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	return 0;
+}
+
 struct init_funcs {
 	int (*init)(void);
 	void (*exit)(void);
@@ -68,6 +78,9 @@ struct init_funcs {
 
 static const struct init_funcs init_funcs[] = {
 	{
+		.init = xe_check_nomodeset,
+	},
+	{
 		.init = xe_hw_fence_module_init,
 		.exit = xe_hw_fence_module_exit,
 	},
@@ -85,15 +98,35 @@ static const struct init_funcs init_func
 	},
 };
 
+static int __init xe_call_init_func(unsigned int i)
+{
+	if (WARN_ON(i >= ARRAY_SIZE(init_funcs)))
+		return 0;
+	if (!init_funcs[i].init)
+		return 0;
+
+	return init_funcs[i].init();
+}
+
+static void xe_call_exit_func(unsigned int i)
+{
+	if (WARN_ON(i >= ARRAY_SIZE(init_funcs)))
+		return;
+	if (!init_funcs[i].exit)
+		return;
+
+	init_funcs[i].exit();
+}
+
 static int __init xe_init(void)
 {
 	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(init_funcs); i++) {
-		err = init_funcs[i].init();
+		err = xe_call_init_func(i);
 		if (err) {
 			while (i--)
-				init_funcs[i].exit();
+				xe_call_exit_func(i);
 			return err;
 		}
 	}
@@ -106,7 +139,7 @@ static void __exit xe_exit(void)
 	int i;
 
 	for (i = ARRAY_SIZE(init_funcs) - 1; i >= 0; i--)
-		init_funcs[i].exit();
+		xe_call_exit_func(i);
 }
 
 module_init(xe_init);



