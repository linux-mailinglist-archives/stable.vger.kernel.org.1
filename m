Return-Path: <stable+bounces-193000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489EFC49B30
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2313A9E36
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 23:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D250F2FE58D;
	Mon, 10 Nov 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbnxWY6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910CC2F5A10
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815875; cv=none; b=r0bhHbLG+GVrgF2MMSdJvAzn3PXr47s9rrKC/S4YMQT4+KsnnV01MfpdScpjtpO67RMIBguWo43Fv2cvEk8iJffh/FXVUqqbqvbFTHLtDamFUjTiyQGBHEp3jruJZK9HAhCoFcJlQUKc4dFtjMTEd5Pj2AMqXEKrrveD7mdUrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815875; c=relaxed/simple;
	bh=AkFYcLcRhAYfQVLASpBxOYJ2IOPaffORpvY4KdO2muc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCeGdfgoq9fc6QOaziwDwwMzzti/vE4BiESQmXzXLK8zNeGqv1T+NOpTBf23ui/Tr8sQAPeOD/C6slNR1Sg58iRf6KYtN9iWPYkCcg9bhyBmmj0e529etjiYTqDtDTixmgRAgVUwtEQhL3uoldXd54NbkUFrGgGs8Ngn9gAEqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbnxWY6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B82C116B1;
	Mon, 10 Nov 2025 23:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762815875;
	bh=AkFYcLcRhAYfQVLASpBxOYJ2IOPaffORpvY4KdO2muc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbnxWY6niRJ8T7a41YFOuX7hvG0gDhyYJoVY9cxPALa7PaZ9lB5kI0TY3x/7M/Kv8
	 aqB8BNo0Tm5r2gqEweYc9qnri1AtdM7F294o2Ka4i63r4Cw7Wp/FAbSlFuGwhqpNZd
	 o3yJo5NzF8kAzRV49AGAYzOxWyMTbdrlYmlDfLLmfMHSW9hBdYjNZHKsrXqtjI7Kde
	 NvRc14HfzhtlQq6D/Tr6kF4Tpg4Q81s9DI1zbC0dfDq6LDcaJlZuHCOgPF7lvrtq+s
	 qqPQWJ1tPXdiaI7lseobtQVO7qU+A+cIH8az5kYWiE7iRR64Ufdcu/dt2eWnfYwBgZ
	 rUlMKvtGvSNjQ==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Omar Sandoval <osandov@fb.com>,
	Samir M <samir@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicolas Schier <nsc@kernel.org>
Subject: [PATCH 6.17.y] kbuild: Strip trailing padding bytes from modules.builtin.modinfo
Date: Mon, 10 Nov 2025 15:38:18 -0700
Message-ID: <20251110223818.3951521-1-nathan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2025111057-slick-manatee-7f63@gregkh>
References: <2025111057-slick-manatee-7f63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a26a6c93edfeee82cb73f55e87d995eea59ddfe8 upstream.

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
[nathan: Apply to scripts/Makefile.vmlinux_o, location of
         modules.builtin.modinfo rule prior to 39cfd5b12160]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Makefile.vmlinux_o | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index b024ffb3e201..a7cd04027b04 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -76,11 +76,24 @@ targets += vmlinux.o
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
 modules.builtin.modinfo: vmlinux.o FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,modules_builtin_modinfo)
 
 # modules.builtin
 # ---------------------------------------------------------------------------
-- 
2.51.2


