Return-Path: <stable+bounces-139599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC27AA8D31
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD8B16BDA8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7581B424A;
	Mon,  5 May 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JFyCNYKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD128EA
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430861; cv=none; b=CtUYTVt6wFMl5XZHI9VfLZ1ben9oYdrlS14zRQYY0SZ3OpW+NNUZNZW6oHkVGMkeKy0gFX5V2gVIuTpNkbcJEvi49bnCp7l8y7JWUJ8ZycUB8jxjsov3gD9jDMvKewluGVNYzTnr8TKOhhnFsKtx6xZq4YCCoQVbfHIh7FrUkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430861; c=relaxed/simple;
	bh=xAKhSMx9bXgikXdU8+eHDQIMmnOexO5tyfoogI8gSJ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WAqM79LxFfY4B+vwIQpxCDLXWXH5rbCGliBTGnEr/oNcWObLqBX++0iTSybnihWxEWFSi0z2BTcIHwLw1UCY9+2LgEkFAwQv9VqdrpOtaut9S1y8mM+Eto5fvy9ntHhjTe+ceq9flCiKlmoX1N0nXjDaX5KerdDp+oavtIEEIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JFyCNYKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1922C4CEE4;
	Mon,  5 May 2025 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746430861;
	bh=xAKhSMx9bXgikXdU8+eHDQIMmnOexO5tyfoogI8gSJ4=;
	h=Subject:To:Cc:From:Date:From;
	b=JFyCNYKdp1RvENFUo7BvpOtEjSv91BUaAFxqNaRk21Ib0Xk4P+UweDnL8piDZ4fe3
	 1M0l+wNQACRNW2VeOKvuTC3YyNcAR+aUBvhqXtOzVPh0ylTKbxWWw4YRlWfY7iFUqs
	 uYFJZzUJtnYBUzEfzaP4yzBqrgJVkgqdCADdVrX4=
Subject: FAILED: patch "[PATCH] drivers: base: handle module_kobject creation" failed to apply to 6.6-stable tree
To: shyamsaini@linux.microsoft.com,gregkh@linuxfoundation.org,linux@rasmusvillemoes.dk,petr.pavlu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:40:48 +0200
Message-ID: <2025050548-pursuable-absence-aa7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f95bbfe18512c5c018720468959edac056a17196
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050548-pursuable-absence-aa7d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f95bbfe18512c5c018720468959edac056a17196 Mon Sep 17 00:00:00 2001
From: Shyam Saini <shyamsaini@linux.microsoft.com>
Date: Thu, 27 Feb 2025 10:49:30 -0800
Subject: [PATCH] drivers: base: handle module_kobject creation

module_add_driver() relies on module_kset list for
/sys/module/<built-in-module>/drivers directory creation.

Since,
commit 96a1a2412acba ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
drivers which are initialized from subsys_initcall() or any other
higher precedence initcall couldn't find the related kobject entry
in the module_kset list because module_kset is not fully populated
by the time module_add_driver() refers it. As a consequence,
module_add_driver() returns early without calling make_driver_name().
Therefore, /sys/module/<built-in-module>/drivers is never created.

Fix this issue by letting module_add_driver() handle module_kobject
creation itself.

Fixes: 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
Cc: stable@vger.kernel.org # requires all other patches from the series
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250227184930.34163-5-shyamsaini@linux.microsoft.com
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 5bc71bea883a..218aaa096455 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -42,16 +42,13 @@ int module_add_driver(struct module *mod, const struct device_driver *drv)
 	if (mod)
 		mk = &mod->mkobj;
 	else if (drv->mod_name) {
-		struct kobject *mkobj;
-
-		/* Lookup built-in module entry in /sys/modules */
-		mkobj = kset_find_obj(module_kset, drv->mod_name);
-		if (mkobj) {
-			mk = container_of(mkobj, struct module_kobject, kobj);
+		/* Lookup or create built-in module entry in /sys/modules */
+		mk = lookup_or_create_module_kobject(drv->mod_name);
+		if (mk) {
 			/* remember our module structure */
 			drv->p->mkobj = mk;
-			/* kset_find_obj took a reference */
-			kobject_put(mkobj);
+			/* lookup_or_create_module_kobject took a reference */
+			kobject_put(&mk->kobj);
 		}
 	}
 


