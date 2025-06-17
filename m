Return-Path: <stable+bounces-152888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB2ADD10C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5D53A2E65
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4A2E7F38;
	Tue, 17 Jun 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISAN82Bt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817C1CDA2E
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173009; cv=none; b=InRiOoJxDTw5ujUx2X3dUSzT7nb0QtSeP+Vzd2TohyAWMNWdXRUqSjRF5c/zEqqbtyMkTG7UMT47vQQ3dgjo4xB/Xgh9me2KCUDMIY2RccX4nCRuXWamkWThbjTtPdxgj+iaqu/zOeP987czzRpZUN7XWFriREjZGf6FSKJS/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173009; c=relaxed/simple;
	bh=i60ccWH1SszwES1YLws6NzZe8BVyhEYkATi0TNWgJeY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IQCZqzgCJTS4wUSy3TO0TUhZaWPkyYxGQt/JWc8H1LiChRQveOvmQFGxB2LESjie27iNpppnm021F1gCGE20vP5uGX49tkOCPHjKtJj7Csh/+K0Of8fqFBFi0WHzM/VGl8bW/vTjeDaVqDbngf9AFtMmQWutU7snCulHN+4Px1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISAN82Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF26C4CEE3;
	Tue, 17 Jun 2025 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750173009;
	bh=i60ccWH1SszwES1YLws6NzZe8BVyhEYkATi0TNWgJeY=;
	h=Subject:To:Cc:From:Date:From;
	b=ISAN82BtK9glshkGmPI9ad+M8ZHhYFndY0KIm3OUW3ySOpre5sX0eRjJfg0wMsHEb
	 lK81SluEdxt97dKE6JvvNviN23H1YlrTYMe+SeWfB7JU3ZfnxY4EcKPSUmBu6J3Aqq
	 LwwrfqbjC9BAc5nC0Hu7UFswYDpHZoyVgsgo2zWI=
Subject: FAILED: patch "[PATCH] kbuild: hdrcheck: fix cross build with clang" failed to apply to 5.4-stable tree
To: arnd@arndb.de,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 17:10:06 +0200
Message-ID: <2025061706-stylishly-ravioli-ffa1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 02e9a22ceef0227175e391902d8760425fa072c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061706-stylishly-ravioli-ffa1@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02e9a22ceef0227175e391902d8760425fa072c6 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 25 Feb 2025 11:00:31 +0100
Subject: [PATCH] kbuild: hdrcheck: fix cross build with clang

The headercheck tries to call clang with a mix of compiler arguments
that don't include the target architecture. When building e.g. x86
headers on arm64, this produces a warning like

   clang: warning: unknown platform, assuming -mfloat-abi=soft

Add in the KBUILD_CPPFLAGS, which contain the target, in order to make it
build properly.

See also 1b71c2fb04e7 ("kbuild: userprogs: fix bitsize and target
detection on clang").

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Fixes: feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 6c6de1b1622b..e3d6b03527fe 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 
 # In theory, we do not care -m32 or -m64 for header compile tests.
 # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
-UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
+UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # USERCFLAGS might contain sysroot location for CC.
 UAPI_CFLAGS += $(USERCFLAGS)


