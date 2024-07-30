Return-Path: <stable+bounces-62695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A1940D65
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D8C1F24AE8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0A194C87;
	Tue, 30 Jul 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxFsPQpQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E8194AF2
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331536; cv=none; b=LqKaNnWbezyYrl7lRZfGmw31j9uosE42Nsnethx2UviHBFBGrQsgBvepKE5NxGbhqyoY0l8xYCTRNRLxV4dw6buvWfZpxBYS5pi33i/D1vf0Igi+gnAYTgVQS3LrlbVIlBhd+mNKoPrxu9Zw/AvU/Oc0cIOx9grHa+WfVGu+IRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331536; c=relaxed/simple;
	bh=QxDURYqeWeqpWHav0cp2PATFtFudZbbCok7ogWz6P/Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y6Nt5420ldBvHDfgXRVWngq1dzrNyw8MHRO53IYrrvFjQap5l1ukBAAKunSUmdeApo4QXneEar+sj84ePlayzzsmAE0mMkEjY+zZE/28Yry0cpqvjyi5cqoa+sJ7utXq/i2kxA0oKbLGNeJLOpdAkUtUKwPSKfd+w4kzSsd/k3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxFsPQpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6CAC32782;
	Tue, 30 Jul 2024 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331536;
	bh=QxDURYqeWeqpWHav0cp2PATFtFudZbbCok7ogWz6P/Y=;
	h=Subject:To:Cc:From:Date:From;
	b=zxFsPQpQN2OtuMGZ65I0o9udSEFDnbK81WxMpfAEiaNvYOQi71wIQZzGbeta2jw9E
	 dJxMN1Y0Y8xH6v22DjYFtlua954eJh5YTwUgEuynI9myNFzZM2CJ0XhLu9oayigcYb
	 F6yN0tKmVN/+M3lI/kFvW41tJmm11n6ZIbOAbsgk=
Subject: FAILED: patch "[PATCH] mm: optimize the redundant loop of mm_update_owner_next()" failed to apply to 5.4-stable tree
To: alexjlzheng@tencent.com,akpm@linux-foundation.org,axboe@kernel.dk,brauner@kernel.org,mhocko@suse.com,mjguzik@gmail.com,oleg@redhat.com,stable@vger.kernel.org,tandersen@netflix.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:24:57 +0200
Message-ID: <2024073057-ogle-vocalist-31c7@gregkh>
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
git cherry-pick -x 76ba6acfcce871db13ad51c6dc8f56fec2e92853
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073057-ogle-vocalist-31c7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

76ba6acfcce8 ("mm: optimize the redundant loop of mm_update_owner_next()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76ba6acfcce871db13ad51c6dc8f56fec2e92853 Mon Sep 17 00:00:00 2001
From: Jinliang Zheng <alexjlzheng@tencent.com>
Date: Thu, 20 Jun 2024 20:21:24 +0800
Subject: [PATCH] mm: optimize the redundant loop of mm_update_owner_next()

When mm_update_owner_next() is racing with swapoff (try_to_unuse()) or
/proc or ptrace or page migration (get_task_mm()), it is impossible to
find an appropriate task_struct in the loop whose mm_struct is the same as
the target mm_struct.

If the above race condition is combined with the stress-ng-zombie and
stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
write_lock_irq() for tasklist_lock.

Recognize this situation in advance and exit early.

Link: https://lkml.kernel.org/r/20240620122123.3877432-1-alexjlzheng@tencent.com
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tandersen@netflix.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..81fcee45d630 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 * Search through everything else, we should not get here often.
 	 */
 	for_each_process(g) {
+		if (atomic_read(&mm->mm_users) <= 1)
+			break;
 		if (g->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(g, c) {


