Return-Path: <stable+bounces-50501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1366B906A8F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7D41F21EDA
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56914265F;
	Thu, 13 Jun 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TRaOwsow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B513D534
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276313; cv=none; b=FUixRHjgQDo0j4xKVM4bhDcm4Fx470vLHk8q98KKzK1pv1/1kuhh5NH8UcOjuIYsGhOf6tt4m4Qa0ZnzXFf4HVphp6spUr/pbJJtck0WBSPWW5YOjKOWccVkL6DfbvnaeO3nUvEMuyfQ5MlbrD0dxud392BTRr8bIaaUXKF5Pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276313; c=relaxed/simple;
	bh=GJ0rLC5PODJpfaojPWmywQEUwceZLajQRLK0Ivu5DeA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tv7svqxy1lUE1fUV8Y+FXAnt4o2pxq35HsLz8zx7avzyvw9S6xc2l+6yzDDFKd/k0Ourc4szajnPZalxX5h4v3V7BYlSvOUupHP8W1Nio8QOBOHsWDjCE9h9XnQkA37jX4gCtrn3RdLk1dIG1f7JreBK/jLNb1DKiUO0THjWz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TRaOwsow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8AAC2BBFC;
	Thu, 13 Jun 2024 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276313;
	bh=GJ0rLC5PODJpfaojPWmywQEUwceZLajQRLK0Ivu5DeA=;
	h=Subject:To:Cc:From:Date:From;
	b=TRaOwsowSzD+QzR3WlI8aF0RjsLODyp+/QbHxKAeAxl8IMGdhxQNFZCYQwlhs+o84
	 ZRcVB/BkktIVR85sfnvxqQHVcle8KYRwWi2++ASpai9SgpiNCsWtMjV4luCOH1dEMG
	 qySc/xqEFujbhU3FXbbToAc5AMnA4oQqZ/RRhTlk=
Subject: FAILED: patch "[PATCH] bpf: fix multi-uprobe PID filtering logic" failed to apply to 6.6-stable tree
To: andrii@kernel.org,ast@kernel.org,jolsa@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:58:30 +0200
Message-ID: <2024061330-custody-resolved-131a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 46ba0e49b64232adac35a2bc892f1710c5b0fb7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061330-custody-resolved-131a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

46ba0e49b642 ("bpf: fix multi-uprobe PID filtering logic")
f17d1a18a3dd ("selftests/bpf: Add more uprobe multi fail tests")
0d83786f5661 ("selftests/bpf: Add test for abnormal cnt during multi-uprobe attachment")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46ba0e49b64232adac35a2bc892f1710c5b0fb7f Mon Sep 17 00:00:00 2001
From: Andrii Nakryiko <andrii@kernel.org>
Date: Tue, 21 May 2024 09:33:57 -0700
Subject: [PATCH] bpf: fix multi-uprobe PID filtering logic

Current implementation of PID filtering logic for multi-uprobes in
uprobe_prog_run() is filtering down to exact *thread*, while the intent
for PID filtering it to filter by *process* instead. The check in
uprobe_prog_run() also differs from the analogous one in
uprobe_multi_link_filter() for some reason. The latter is correct,
checking task->mm, not the task itself.

Fix the check in uprobe_prog_run() to perform the same task->mm check.

While doing this, we also update get_pid_task() use to use PIDTYPE_TGID
type of lookup, given the intent is to get a representative task of an
entire process. This doesn't change behavior, but seems more logical. It
would hold task group leader task now, not any random thread task.

Last but not least, given multi-uprobe support is half-broken due to
this PID filtering logic (depending on whether PID filtering is
important or not), we need to make it easy for user space consumers
(including libbpf) to easily detect whether PID filtering logic was
already fixed.

We do it here by adding an early check on passed pid parameter. If it's
negative (and so has no chance of being a valid PID), we return -EINVAL.
Previous behavior would eventually return -ESRCH ("No process found"),
given there can't be any process with negative PID. This subtle change
won't make any practical change in behavior, but will allow applications
to detect PID filtering fixes easily. Libbpf fixes take advantage of
this in the next patch.

Cc: stable@vger.kernel.org
Acked-by: Jiri Olsa <jolsa@kernel.org>
Fixes: b733eeade420 ("bpf: Add pid filter support for uprobe_multi link")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240521163401.3005045-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..1baaeb9ca205 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3295,7 +3295,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_run_ctx *old_run_ctx;
 	int err = 0;
 
-	if (link->task && current != link->task)
+	if (link->task && current->mm != link->task->mm)
 		return 0;
 
 	if (sleepable)
@@ -3396,8 +3396,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
 	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
 	cnt = attr->link_create.uprobe_multi.cnt;
+	pid = attr->link_create.uprobe_multi.pid;
 
-	if (!upath || !uoffsets || !cnt)
+	if (!upath || !uoffsets || !cnt || pid < 0)
 		return -EINVAL;
 	if (cnt > MAX_UPROBE_MULTI_CNT)
 		return -E2BIG;
@@ -3421,10 +3422,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		goto error_path_put;
 	}
 
-	pid = attr->link_create.uprobe_multi.pid;
 	if (pid) {
 		rcu_read_lock();
-		task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
+		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);
 		rcu_read_unlock();
 		if (!task) {
 			err = -ESRCH;
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 8269cdee33ae..38fda42fd70f 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -397,7 +397,7 @@ static void test_attach_api_fails(void)
 	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
 	if (!ASSERT_ERR(link_fd, "link_fd"))
 		goto cleanup;
-	ASSERT_EQ(link_fd, -ESRCH, "pid_is_wrong");
+	ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong");
 
 cleanup:
 	if (link_fd >= 0)


