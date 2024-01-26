Return-Path: <stable+bounces-16003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82983E669
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B3B28AB0C
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC305821E;
	Fri, 26 Jan 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygIyDtz2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104A604A9
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310858; cv=none; b=aoyAbvnugcp7GvRHEHZw/Q3vU6B5owf0ge/Jxi9VOe0SJm9qTyQfvBpaN14a936LYapURYJtL9cJXo7GH4CViPdE4T9Cs8ZoIJjwQifHKhzscJfO0pOJzmK9T7M27yVx3sI62NZyMGscuoEyD9Nw+TcYPqzz/75/eG/j+mAHoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310858; c=relaxed/simple;
	bh=NkgC+6Up6Q7cL22jziBimvmPK2K49qM6/AWpy6sOIm8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ciNIqiw70vZfQcoeTIEXvJFRbgpBPBAH4l1I/OYeWvJEoCzlC4lPjhdfjF7tNjR8oLMQc0AN3+UlAE8i3ucnwJSoUrqzpvXk0/i2Eq6XdlvueLu6Z+yjoe6Pjlh/mbgMtunWA42YA8mZS4b/d5pf++WN48MyJxiVIsbFqgtU9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygIyDtz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FC4C43390;
	Fri, 26 Jan 2024 23:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310858;
	bh=NkgC+6Up6Q7cL22jziBimvmPK2K49qM6/AWpy6sOIm8=;
	h=Subject:To:Cc:From:Date:From;
	b=ygIyDtz2S7GgexEW/rp0zI5pFtmmTDjRQpHMJRb1XflZgldoDBUOYJONBIAEaRLMA
	 9mRZF2AIahML5FgYW02/dzyEUr3fudIwtfrNQj28ucNlQ+g8nFjEjK1B6pnLSKtT/4
	 n+NKYX6RypGQvEkmlH9CRFa6DcooAsfGF0Gscxls=
Subject: FAILED: patch "[PATCH] arm64/sme: Always exit sme_alloc() early with existing" failed to apply to 6.1-stable tree
To: broonie@kernel.org,stable@vger.kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:14:17 -0800
Message-ID: <2024012617-overlap-reborn-e124@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x dc7eb8755797ed41a0d1b5c0c39df3c8f401b3d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012617-overlap-reborn-e124@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

dc7eb8755797 ("arm64/sme: Always exit sme_alloc() early with existing storage")
5d0a8d2fba50 ("arm64/ptrace: Ensure that SME is set up for target when writing SSVE state")
f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
ce514000da4f ("arm64/sme: Rename za_state to sme_state")
1192b93ba352 ("arm64/fp: Use a struct to pass data to fpsimd_bind_state_to_cpu()")
deeb8f9a80fd ("arm64/fpsimd: Have KVM explicitly say which FP registers to save")
baa8515281b3 ("arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE")
93ae6b01bafe ("KVM: arm64: Discard any SVE state when entering KVM guests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc7eb8755797ed41a0d1b5c0c39df3c8f401b3d9 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 15 Jan 2024 20:15:46 +0000
Subject: [PATCH] arm64/sme: Always exit sme_alloc() early with existing
 storage

When sme_alloc() is called with existing storage and we are not flushing we
will always allocate new storage, both leaking the existing storage and
corrupting the state. Fix this by separating the checks for flushing and
for existing storage as we do for SVE.

Callers that reallocate (eg, due to changing the vector length) should
call sme_free() themselves.

Fixes: 5d0a8d2fba50 ("arm64/ptrace: Ensure that SME is set up for target when writing SSVE state")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240115-arm64-sme-flush-v1-1-7472bd3459b7@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 0983be2b1b61..a5dc6f764195 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1217,8 +1217,10 @@ void fpsimd_release_task(struct task_struct *dead_task)
  */
 void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.sme_state && flush) {
-		memset(task->thread.sme_state, 0, sme_state_size(task));
+	if (task->thread.sme_state) {
+		if (flush)
+			memset(task->thread.sme_state, 0,
+			       sme_state_size(task));
 		return;
 	}
 


