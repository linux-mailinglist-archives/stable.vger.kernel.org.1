Return-Path: <stable+bounces-89868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C29BD247
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177B11C225DE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1AD17E918;
	Tue,  5 Nov 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tRKf2ZEH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD555674E
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823998; cv=none; b=nWwVLt4ii/Hmz9K9FT2ikBiROWTa3kEoUJaXTn7tMQfMiHzBhbQotgLJwwBZIt4VBIJ5CvWEW43QQPqmE8Q5ErPyV5Zhp82uO0OhTmyUM2UYRc12QuA3ONPVwTxOh6QntfEz/D/eVn3gFxmHcbaPsMMC1pM4/6boae3vASI+QdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823998; c=relaxed/simple;
	bh=COhUZu7yLAej0Icpxl1w1AxOUdQPNd6a9ag0Os/qfqw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=js7EJK7Kuo7TdvtJdV3FoqbgQgzWaguq7gvxKC38W0fD4r7vCVgaeUrgqT60RcZnxPyllnPw1akb5BOuawffOJGQsuZDfDajuKXwr7GqyrgTSSfiRn87qTsCZO6TAtcdg1Wdyt0UOLY3mTZK0TQq1YYGrO07ahep2NROZP+Mh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tRKf2ZEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EC7C4CECF;
	Tue,  5 Nov 2024 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730823997;
	bh=COhUZu7yLAej0Icpxl1w1AxOUdQPNd6a9ag0Os/qfqw=;
	h=Subject:To:Cc:From:Date:From;
	b=tRKf2ZEH8eB+iagoMqg/HpkWWmMxvaIBtSSl5CL+LdC3NJQpEDlDf/05SI0S5dkLl
	 5/3oJgm0CI1+9L8kJPs86v7WbMxoVNOvj4ua0zjXiblLduQtB5QtGBD2DmZ+/7Tp3h
	 +ztkperniARnmkC3/VtOaXHo7f3GXU2I9SFlWJ5k=
Subject: FAILED: patch "[PATCH] RISC-V: disallow gcc + rust builds" failed to apply to 6.11-stable tree
To: conor.dooley@microchip.com,jmontleo@redhat.com,nathan@kernel.org,ojeda@kernel.org,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:26:20 +0100
Message-ID: <2024110519-underage-paying-6d38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 33549fcf37ec461f398f0a41e1c9948be2e5aca4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110519-underage-paying-6d38@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33549fcf37ec461f398f0a41e1c9948be2e5aca4 Mon Sep 17 00:00:00 2001
From: Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 1 Oct 2024 12:28:13 +0100
Subject: [PATCH] RISC-V: disallow gcc + rust builds

During the discussion before supporting rust on riscv, it was decided
not to support gcc yet, due to differences in extension handling
compared to llvm (only the version of libclang matching the c compiler
is supported). Recently Jason Montleon reported [1] that building with
gcc caused build issues, due to unsupported arguments being passed to
libclang. After some discussion between myself and Miguel, it is better
to disable gcc + rust builds to match the original intent, and
subsequently support it when an appropriate set of extensions can be
deduced from the version of libclang.

Closes: https://lore.kernel.org/all/20240917000848.720765-2-jmontleo@redhat.com/ [1]
Link: https://lore.kernel.org/all/20240926-battering-revolt-6c6a7827413e@spud/ [2]
Fixes: 70a57b247251a ("RISC-V: enable building 64-bit kernels with rust support")
Cc: stable@vger.kernel.org
Reported-by: Jason Montleon <jmontleo@redhat.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20241001-playlist-deceiving-16ece2f440f5@spud
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 750ff371570a..54be7ddf3e57 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -17,7 +17,7 @@ Architecture   Level of support  Constraints
 =============  ================  ==============================================
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
-``riscv``      Maintained        ``riscv64`` only.
+``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
 ``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62545946ecf4..f4c570538d55 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -177,7 +177,7 @@ config RISCV
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
-	select HAVE_RUST if RUSTC_SUPPORTS_RISCV
+	select HAVE_RUST if RUSTC_SUPPORTS_RISCV && CC_IS_CLANG
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR


