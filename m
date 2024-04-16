Return-Path: <stable+bounces-39978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AAB8A60DA
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 04:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469F4282C08
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 02:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55919101E2;
	Tue, 16 Apr 2024 02:16:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D7F9E8
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233793; cv=none; b=mO2NwdsJdkes+5hH4qQlOIPM/eEWGr2prwfq8kcPNTgsoSnPhUAcm8MBNyZv9M1nj7re0YO+rDtPCy4bAxGxlLUeGzUqMA15Lg6Cywm79TYMyEaVi0cmbLankunb58RTqNSex6zP8EpyfcA27bT89LgIUmDUdgOJTONB2DZNDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233793; c=relaxed/simple;
	bh=v2VaZ0V8LgmEAjHSu8mpK+M5xBi/i2X00pywvIODD4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCa6xK+c50lForukti3GqIYPI3du9pcu/e+JFfz83Dp70q0gjnRwNV7hvf7qqg8LTbKg0jw2MS8fjmkF6canJlN9zRsXVUlQrLLk/1iC3gTOWjgQMy4upXtpj5X4fQDmY7RwMupQn0UF2e6Wvyt2FwwLY5iaag8A8LsD1jZPUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VJSJr5Xpnz1ynKx
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 10:14:04 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A9081A0172
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 10:16:26 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:16:26 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.15.y] kprobes: Fix possible use-after-free issue on kprobe registration
Date: Tue, 16 Apr 2024 10:16:54 +0800
Message-ID: <20240416021654.1184927-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024041524-monoxide-kilobyte-1c44@gregkh>
References: <2024041524-monoxide-kilobyte-1c44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)

commit 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8 upstream.

When unloading a module, its state is changing MODULE_STATE_LIVE ->
 MODULE_STATE_GOING -> MODULE_STATE_UNFORMED. Each change will take
a time. `is_module_text_address()` and `__module_text_address()`
works with MODULE_STATE_LIVE and MODULE_STATE_GOING.
If we use `is_module_text_address()` and `__module_text_address()`
separately, there is a chance that the first one is succeeded but the
next one is failed because module->state becomes MODULE_STATE_UNFORMED
between those operations.

In `check_kprobe_address_safe()`, if the second `__module_text_address()`
is failed, that is ignored because it expected a kernel_text address.
But it may have failed simply because module->state has been changed
to MODULE_STATE_UNFORMED. In this case, arm_kprobe() will try to modify
non-exist module text address (use-after-free).

To fix this problem, we should not use separated `is_module_text_address()`
and `__module_text_address()`, but use only `__module_text_address()`
once and do `try_module_get(module)` which is only available with
MODULE_STATE_LIVE.

Link: https://lore.kernel.org/all/20240410015802.265220-1-zhengyejian1@huawei.com/

Fixes: 28f6c37a2910 ("kprobes: Forbid probing on trampoline and BPF code areas")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[Fix conflict due to lack dependency
commit 223a76b268c9 ("kprobes: Fix coding style issues")]
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/kprobes.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5d713a7d7e87..af57705e1fef 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1564,10 +1564,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	jump_label_lock();
 	preempt_disable();
 
-	/* Ensure it is not in reserved area nor out of text */
-	if (!(core_kernel_text((unsigned long) p->addr) ||
-	    is_module_text_address((unsigned long) p->addr)) ||
-	    in_gate_area_no_mm((unsigned long) p->addr) ||
+	/* Ensure the address is in a text area, and find a module if exists. */
+	*probed_mod = NULL;
+	if (!core_kernel_text((unsigned long) p->addr)) {
+		*probed_mod = __module_text_address((unsigned long) p->addr);
+		if (!(*probed_mod)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	/* Ensure it is not in reserved area. */
+	if (in_gate_area_no_mm((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
@@ -1577,8 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
-	/* Check if are we probing a module */
-	*probed_mod = __module_text_address((unsigned long) p->addr);
+	/* Get module refcount and reject __init functions for loaded modules. */
 	if (*probed_mod) {
 		/*
 		 * We must hold a refcount of the probed module while updating
-- 
2.25.1


