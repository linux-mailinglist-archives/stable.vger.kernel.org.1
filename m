Return-Path: <stable+bounces-187592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C21BDBEA6D5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7836583D1D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ABA330B3A;
	Fri, 17 Oct 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcnD08TI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8616330B2D;
	Fri, 17 Oct 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716515; cv=none; b=ZAr6SKmKEITW2x69XoYsYChqxjrjiR8L4xLEDQTx4XmwavMTCR7rzqF3FkV5++xfrXwqJrTRII0N9ekC6JzkbTJcH/7EUGMGkZGFjnVN+puXY1SKNM2JcJsIx/uY/Ybayn2N05oSOvO94aTAJig77binXiiP7RhTWOghySb2plE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716515; c=relaxed/simple;
	bh=FzBh9kPQ9R60WhjFCvJ3Huqd+HH8TSIglRsOtSousgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsKw9WT288xOWYQQ/AgiGQ/ZiC5xbjlydsiXWonNDZMxGevhdmLsW7aOE/6NFURPgep9/KkmurgANyLPKhFd5qjjGuEsQhFR1moyPm8obe3niASVcdDgA0jI/66nZTPxQYk46ur28EDGcQsc+0/ThLHpmvXZ/z2BkYd02KNbrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcnD08TI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D9C4CEE7;
	Fri, 17 Oct 2025 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716515;
	bh=FzBh9kPQ9R60WhjFCvJ3Huqd+HH8TSIglRsOtSousgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcnD08TIXnJYEZNBXsX6BltF7MjSwxYTfsZY2xlMfo5+2OtOeM+wp89BplmVAQIiP
	 1mzmUu/Wix+cBxYqYuUaeEg3qQjdXf9tF01naa4LabnbetO4f80eRUIklcyIFlgaot
	 Qmrz54iiwGcPe6nwENDQm22zVks4ZAYCix1lfBRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 184/276] init: handle bootloader identifier in kernel parameters
Date: Fri, 17 Oct 2025 16:54:37 +0200
Message-ID: <20251017145149.190998360@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit e416f0ed3c500c05c55fb62ee62662717b1c7f71 upstream.

BootLoaders (Grub, LILO, etc) may pass an identifier such as "BOOT_IMAGE=
/boot/vmlinuz-x.y.z" to kernel parameters.  But these identifiers are not
recognized by the kernel itself so will be passed to userspace.  However
user space init program also don't recognize it.

KEXEC/KDUMP (kexec-tools) may also pass an identifier such as "kexec" on
some architectures.

We cannot change BootLoader's behavior, because this behavior exists for
many years, and there are already user space programs search BOOT_IMAGE=
in /proc/cmdline to obtain the kernel image locations:

https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
(search getBootOptions)
https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
(search getKernelReleaseWithBootOption) So the the best way is handle
(ignore) it by the kernel itself, which can avoid such boot warnings (if
we use something like init=/bin/bash, bootloader identifier can even cause
a crash):

Kernel command line: BOOT_IMAGE=(hd0,1)/vmlinuz-6.x root=/dev/sda3 ro console=tty
Unknown kernel command line parameters "BOOT_IMAGE=(hd0,1)/vmlinuz-6.x", will be passed to user space.

[chenhuacai@loongson.cn: use strstarts()]
  Link: https://lkml.kernel.org/r/20250815090120.1569947-1-chenhuacai@loongson.cn
Link: https://lkml.kernel.org/r/20250721101343.3283480-1-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/main.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/init/main.c
+++ b/init/main.c
@@ -540,6 +540,14 @@ static int __init unknown_bootoption(cha
 				     const char *unused, void *arg)
 {
 	size_t len = strlen(param);
+	int i;
+
+	/*
+	 * Well-known bootloader identifiers:
+	 * 1. LILO/Grub pass "BOOT_IMAGE=...";
+	 * 2. kexec/kdump (kexec-tools) pass "kexec".
+	 */
+	const char *bootloader[] = { "BOOT_IMAGE=", "kexec", NULL };
 
 	/* Handle params aliased to sysctls */
 	if (sysctl_is_alias(param))
@@ -547,6 +555,12 @@ static int __init unknown_bootoption(cha
 
 	repair_env_string(param, val);
 
+	/* Handle bootloader identifier */
+	for (i = 0; bootloader[i]; i++) {
+		if (strstarts(param, bootloader[i]))
+			return 0;
+	}
+
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
 		return 0;



