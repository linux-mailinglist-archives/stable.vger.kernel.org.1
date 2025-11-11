Return-Path: <stable+bounces-193003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C26C49E01
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3A73AA8A3
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B42153D8;
	Tue, 11 Nov 2025 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYeELPbj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7243212550
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821085; cv=none; b=bRI/l8zV+f6I8+HQ5oxEBH69WFm1r5KKDu58Sbh/Ow2xmgbhyb4DPuksCHgQ+NHVGkN3Wv0+Ci1REWbQPVJQqrkEQh9PbNf0lJ0ZIw2maDJ2TRX+Xqfozk0LJv/YvcpNoxJ8PA4QM0B7mc3MDToU45opBuoDhANh0f0nNLyKZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821085; c=relaxed/simple;
	bh=uW1VAaSDtoyBi9NyyyB5fe3vyOfu+wrxphwWULKnHo4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Dj70KUf784dR29ABiOHYMz16OTEqfFeE2KqrOufC2yyl65yWrxzXtuLpkCjpD6rOXOuJGcjTiplyPLDjBGGSLiZtCqZk3Ae2kYjlWu7my35nhIevWf58UZ02WjsgHHCThzmKUUEuOWg/zvI6YCvixcXBN/SB0y+UjIXua5k4L4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYeELPbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3479C116B1;
	Tue, 11 Nov 2025 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762821085;
	bh=uW1VAaSDtoyBi9NyyyB5fe3vyOfu+wrxphwWULKnHo4=;
	h=Subject:To:Cc:From:Date:From;
	b=xYeELPbjlzT1YTS4v8dtUf20DrteXz05Dejrsjz3OoqttRBgrsL4shh+FyvawO/OJ
	 hEPKmw8+c75Eeqoc3Tk8agHdC1SkDhKiAuWZoG39Oqmd3lQArGTumn5WgEn9G/IYrX
	 NTi9sEJvhJ8reJUEEUg5fKzPyye1sGpdPF6a3wjc=
Subject: FAILED: patch "[PATCH] kbuild: Strip trailing padding bytes from" failed to apply to 6.17-stable tree
To: nathan@kernel.org,nsc@kernel.org,osandov@fb.com,samir@linux.ibm.com,venkat88@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Nov 2025 09:31:22 +0900
Message-ID: <2025111122-suitor-absently-2164@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x a26a6c93edfeee82cb73f55e87d995eea59ddfe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025111122-suitor-absently-2164@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a26a6c93edfeee82cb73f55e87d995eea59ddfe8 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 5 Nov 2025 15:30:27 -0700
Subject: [PATCH] kbuild: Strip trailing padding bytes from
 modules.builtin.modinfo

After commit d50f21091358 ("kbuild: align modinfo section for Secureboot
Authenticode EDK2 compat"), running modules_install with certain
versions of kmod (such as 29.1 in Ubuntu Jammy) in certain
configurations may fail with:

  depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix

The additional padding bytes to ensure .modinfo is aligned within
vmlinux.unstripped are unexpected by kmod, as this section has always
just been null-terminated strings.

Strip the trailing padding bytes from modules.builtin.modinfo after it
has been extracted from vmlinux.unstripped to restore the format that
kmod expects while keeping .modinfo aligned within vmlinux.unstripped to
avoid regressing the Authenticode calculation fix for EDK2.

Cc: stable@vger.kernel.org
Fixes: d50f21091358 ("kbuild: align modinfo section for Secureboot Authenticode EDK2 compat")
Reported-by: Omar Sandoval <osandov@fb.com>
Reported-by: Samir M <samir@linux.ibm.com>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com/
Tested-by: Omar Sandoval <osandov@fb.com>
Tested-by: Samir M <samir@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Link: https://patch.msgid.link/20251105-kbuild-fix-builtin-modinfo-for-kmod-v1-1-b419d8ad4606@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index ced4379550d7..cd788cac9d91 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -102,11 +102,24 @@ vmlinux: vmlinux.unstripped FORCE
 # modules.builtin.modinfo
 # ---------------------------------------------------------------------------
 
+# .modinfo in vmlinux.unstripped is aligned to 8 bytes for compatibility with
+# tools that expect vmlinux to have sufficiently aligned sections but the
+# additional bytes used for padding .modinfo to satisfy this requirement break
+# certain versions of kmod with
+#
+#   depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix
+#
+# Strip the trailing padding bytes after extracting .modinfo to comply with
+# what kmod expects to parse.
+quiet_cmd_modules_builtin_modinfo = GEN     $@
+      cmd_modules_builtin_modinfo = $(cmd_objcopy); \
+                                    sed -i 's/\x00\+$$/\x00/g' $@
+
 OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
 
 targets += modules.builtin.modinfo
 modules.builtin.modinfo: vmlinux.unstripped FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,modules_builtin_modinfo)
 
 # modules.builtin
 # ---------------------------------------------------------------------------


