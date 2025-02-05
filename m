Return-Path: <stable+bounces-113608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E158FA2927F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64CD7A15FA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D917ADF8;
	Wed,  5 Feb 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iaWxZDP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A41E89C;
	Wed,  5 Feb 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767542; cv=none; b=SUNrgLpI1X7Xw9xoq/WJ3PbilwSdzvhVhH/dIa/V0MyKbifP6vLL3OLE9xNrpvOxYFaSFRnoazhcKMnPEulEIINnpM+XDsmrl/C3gFChOTQcb1qeOFqyZ+aGAFqDHeEYUF6d6IpaK9+FEMBm6lF4lmAc51mxvPTJyOgay88kUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767542; c=relaxed/simple;
	bh=M3yrc+OgBg9sHSBgXj+Jm5H7sqd7bgWci6HeAUz4WTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbidc0+VMkINEJqqXUeitrQe/fh7iYK6dJ/qCwj6Vo97EYrVGkSi6DWpc1c9ZlA13xZV5fuCH4pzdh9KkReHGQ2HLxI1HaJJRw1ip7nKdHLFf5A/mvD0lwKhlYL0v5gmod/kdkkrTVl3ZNj3+6ZgnISFicevu93VV0Yo0S0MlGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iaWxZDP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7898BC4CED1;
	Wed,  5 Feb 2025 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767541;
	bh=M3yrc+OgBg9sHSBgXj+Jm5H7sqd7bgWci6HeAUz4WTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaWxZDP0Xj5hchcTmyzDXugTzj/dDODBFdu+7chPMSo5UCfSWR+4RJmTB5gxl5aEP
	 7EW9rhY9Gr+FU7ZzdfmK6CiWWpTMLuYqUeHVME5zl09BGSdkYUt5+uUcW7sY4fXE1T
	 cUXmIRoMDwdKqioRa453bjRpxZdI8vnEy99JvxIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 448/590] module: Dont fail module loading when setting ro_after_init section RO failed
Date: Wed,  5 Feb 2025 14:43:23 +0100
Message-ID: <20250205134512.408255343@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 110b1e070f1d50f5217bd2c758db094998bb7b77 ]

Once module init has succeded it is too late to cancel loading.
If setting ro_after_init data section to read-only fails, all we
can do is to inform the user through a warning.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com/
Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/d6c81f38da76092de8aacc8c93c4c65cb0fe48b8.1733427536.git.christophe.leroy@csgroup.eu
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12f..93a07387af3b7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2583,7 +2583,10 @@ static noinline int do_init_module(struct module *mod)
 #endif
 	ret = module_enable_rodata_ro(mod, true);
 	if (ret)
-		goto fail_mutex_unlock;
+		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
+			"ro_after_init data might still be writable\n",
+			mod->name, ret);
+
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
 	for_class_mod_mem_type(type, init) {
@@ -2622,8 +2625,6 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
-fail_mutex_unlock:
-	mutex_unlock(&module_mutex);
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
-- 
2.39.5




