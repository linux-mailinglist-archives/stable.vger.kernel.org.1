Return-Path: <stable+bounces-192883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF9C44BF8
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 02:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE514E040B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248518DB01;
	Mon, 10 Nov 2025 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ip8RTLur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C352C86D
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762739521; cv=none; b=sfp/PHyOpJ9tVhHKH7BpeQNwqoni8GISC93njLWtT+O2kj9cVwaUsdauk/gtMjEeJyLGOB0iuJWIOCsMl0xDhD4O+/rFxX2uRlNflhx02zvKtcw5wPzrFDOCkWvZ52K3D2cKP/IJ9jFixHJfgJdfD96n7uv4gWzrDC4oSz9V15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762739521; c=relaxed/simple;
	bh=D6Y7tBxMqBzhz1RWv8fikranl/E+3vmzlZ37Z40RSxc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tc8V3hW2nGeuYKuPg68Ist6l7Cn1o9USLNIDe/1iHdkDZRTbFO5w+OnxNv1riSajnhdnzvmf6LYKbR/99L2DQZBLlraiL0HwrOAQipGGIxs0BAQKQR1amFq1/YkNK/EsA5kbGPwP6ebCBUp95Sxq+sidVP07IUvu6ROl2cAKCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ip8RTLur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEA2C4CEFB;
	Mon, 10 Nov 2025 01:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762739521;
	bh=D6Y7tBxMqBzhz1RWv8fikranl/E+3vmzlZ37Z40RSxc=;
	h=Subject:To:Cc:From:Date:From;
	b=ip8RTLur+aMnhXhIsst7d+PKlZJ4YAspp3W2fwz1sbXtTqSG6cR/4GfSmY1VRqx9H
	 R/BE83DJMOXdwzwgPOdrzv/txG1IjPt5oReEDLa4yj1bG/hzxb/yf0IVQqPITbPFOJ
	 IRUzEG1IbSz6B8/hTMKse/9eoS3XIB8ER9WBkRvU=
Subject: FAILED: patch "[PATCH] kbuild: Strip trailing padding bytes from" failed to apply to 6.17-stable tree
To: nathan@kernel.org,nsc@kernel.org,osandov@fb.com,samir@linux.ibm.com,venkat88@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Nov 2025 10:51:57 +0900
Message-ID: <2025111057-slick-manatee-7f63@gregkh>
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
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025111057-slick-manatee-7f63@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

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


