Return-Path: <stable+bounces-152887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D8ADD107
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BA63B2C36
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6A22541C;
	Tue, 17 Jun 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GXL8ns4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51041865EE
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172917; cv=none; b=AnPZiJVM4yxPMcqBGeFx1RoeKvo3jNjSgXwIyIjTQPesSD84ECNhz9zUMdL4JtjHKHBt28WxEEk/cZz1gK0By5Da7tL1u30CkjVntJUrioMPZTpJfgplxtBjaAEIzTVDk9s+UpjugGJt2GYIKYb6tZLbNwT+4vnKTogROSNBGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172917; c=relaxed/simple;
	bh=lRS17W4V5LaAJ9OBRJIuRiQoXTJJKD7lhJ56bLIW868=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fIMkqrbLs8z4M2sia+vEb18BI5hV/VkD+Un6FokdOJFKPUx7iIsQO1HWHfaICr+PqHvjeAlRDTKe8OLtIzftYSA+tH6aXnECNbD/BF1C92BUScHYmEkEFUoVua9kUJ0BFb8cDYTwKYmhgwitXM84PkSmGdRgFcd6EwdJ7GVwi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GXL8ns4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8860C4CEE7;
	Tue, 17 Jun 2025 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750172916;
	bh=lRS17W4V5LaAJ9OBRJIuRiQoXTJJKD7lhJ56bLIW868=;
	h=Subject:To:Cc:From:Date:From;
	b=GXL8ns4hJL9zySd0lK2y7VaTdXIUwgOnhtJSAWUVF89SDWfeQn7uHr2Go7x4uSprI
	 bPvQdGdzgj2g/SAUp6mLrs8Jz2HSbi2daauZip8+8I/77OLSYojnke8FWTsCFmqcBy
	 XgGk5wmNE/5G6d3ijhLh6CsiHDXvj+z60HkI+k0s=
Subject: FAILED: patch "[PATCH] kbuild: userprogs: fix bitsize and target detection on clang" failed to apply to 5.4-stable tree
To: thomas.weissschuh@linutronix.de,masahiroy@kernel.org,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 17:08:33 +0200
Message-ID: <2025061733-fineness-scale-bebf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1b71c2fb04e7a713abc6edde4a412416ff3158f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061733-fineness-scale-bebf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b71c2fb04e7a713abc6edde4a412416ff3158f2 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Date: Thu, 13 Feb 2025 15:55:17 +0100
Subject: [PATCH] kbuild: userprogs: fix bitsize and target detection on clang
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

scripts/Makefile.clang was changed in the linked commit to move --target from
KBUILD_CFLAGS to KBUILD_CPPFLAGS, as that generally has a broader scope.
However that variable is not inspected by the userprogs logic,
breaking cross compilation on clang.

Use both variables to detect bitsize and target arguments for userprogs.

Fixes: feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/Makefile b/Makefile
index 52207bcb1a9d..272db408be5c 100644
--- a/Makefile
+++ b/Makefile
@@ -1120,8 +1120,8 @@ LDFLAGS_vmlinux += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 endif
 
 # Align the bit size of userspace programs with the kernel
-KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
-KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
+KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)


