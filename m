Return-Path: <stable+bounces-158508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62129AE7AD6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D23AF350
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED62287517;
	Wed, 25 Jun 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HC6bIxwM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A4271447
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841369; cv=none; b=QPjiR/J80wzQUL6+9ebUwximx7n/KLeP8ApKoPonyYPivIY+q/LfNI7n9Lf9hziil/ql124Hq7VWY+jt9OSd8X8+z1WhgQsanhCBm58tVMEVbfb8Xxr84JXqhMDKnJfV+Eh4cqM02jYQ7UN03M67lJ+9c4tS+3w4pV5odtn//8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841369; c=relaxed/simple;
	bh=P0aj9BdXHxQiJ81TgLpZFEHx3If+tEUymmcUS9IdlUo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=czyRjyrT4UN93ygg4y8Q2T5LL0a5w0XA7/AunqUhZCFPZ4SqNantv96HsOaDnHfXH6mJ9UUCKhVBZ8dMQaR9dQ4fFWEbbsGiT0nRdbzftX3WE0JGZ6spYiwycTMDfrpB3VnmQrzO7sF2RUWpchsfFujdNkDjG/mOPtnUyXjHu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HC6bIxwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1759AC4CEEA;
	Wed, 25 Jun 2025 08:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750841369;
	bh=P0aj9BdXHxQiJ81TgLpZFEHx3If+tEUymmcUS9IdlUo=;
	h=Subject:To:Cc:From:Date:From;
	b=HC6bIxwMwBT/EaaXUD7vHFvMH1HKzzPmvWkrlBfsHdwcglp2eJ8Er7/Tmp5CwskFE
	 S6I5JY8WoKtekGg/ghYCD/vRUM4zY7WU3S/eIQgwoPe3PaKgppHpLSJS6qvAZqVd3O
	 SAbk99k4SuG0fkq9RJOr3rrEuOvTUnu6yQQqDqiM=
Subject: FAILED: patch "[PATCH] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS" failed to apply to 5.4-stable tree
To: masahiroy@kernel.org,nathan@kernel.org,trini@konsulko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Jun 2025 09:49:27 +0100
Message-ID: <2025062527-parkway-hardening-abe3@gregkh>
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
git cherry-pick -x feb843a469fb0ab00d2d23cfb9bcc379791011bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062527-parkway-hardening-abe3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From feb843a469fb0ab00d2d23cfb9bcc379791011bb Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 9 Apr 2023 23:53:57 +0900
Subject: [PATCH] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.

As a result, the linker script is preprocessed with predefined macros
for the build host instead of the target.

Assuming you use an x86 build machine, compare the following:

 $ clang -dM -E -x c /dev/null
 $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu

There is no actual problem presumably because our linker scripts do not
rely on such predefined macros, but it is better to define correct ones.

Move $(CLANG_FLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S
will be processed with the proper target triple.

[Note]
After the patch submission, we got an actual problem that needs this
commit. (CBL issue 1859)

Link: https://github.com/ClangBuiltLinux/linux/issues/1859
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 9076cc939e87..058a4c0f864e 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -34,6 +34,5 @@ CLANG_FLAGS	+= -Werror=unknown-warning-option
 CLANG_FLAGS	+= -Werror=ignored-optimization-argument
 CLANG_FLAGS	+= -Werror=option-ignored
 CLANG_FLAGS	+= -Werror=unused-command-line-argument
-KBUILD_CFLAGS	+= $(CLANG_FLAGS)
-KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS


