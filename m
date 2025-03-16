Return-Path: <stable+bounces-124518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8164A63471
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6F816E11D
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194FA17D346;
	Sun, 16 Mar 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0jYGOhun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5C8BE5
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109521; cv=none; b=GN9ex6hgitRfV+ox/l+qT9ZxHi1RxzQ8tmvcVmRK0RrDULxsCjQBUJdDOUknlz2EWgFJ4Ube9X1Wxh2fKb0855BajZF1u66YjrSJUVwNDJW8zvBdLgnsE4cjr53ioxQKgmqZCfF8OtoN/C2iG5HMz/MMdU321r4Mhtcxoyg8yJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109521; c=relaxed/simple;
	bh=SGL6uJruhAWVbgJYt5JC8KwRIQlMUuxmQQfBJSEPdLU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lM8jCYjjjHXrCUsgDoCQ7kHggadOq400hY818JxiArRmVhMq4uaAfhB5UrncS/PfGs9drm30bhaohWy5QI3uMBX9nqB7kB2wruFAXHZoaRHH9Uc3ji/kQGuPR7jBpAGKNsh51+Ilu/nvzZVOGaJ+9XlFm+71Na7AdAFhT8yt0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0jYGOhun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD4C4CEDD;
	Sun, 16 Mar 2025 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742109521;
	bh=SGL6uJruhAWVbgJYt5JC8KwRIQlMUuxmQQfBJSEPdLU=;
	h=Subject:To:Cc:From:Date:From;
	b=0jYGOhunePcZeutS6qmq96nNmSRx96ttKS3Y/H3adHYGqRfcGecwT70ReAiJE9zme
	 TRg+9HfYrPQZPs3SQ/ut5NJGG6r75Hfka9ZuIGlo6Ei0B0jW7NIxlwGZZHI0nOi5ZP
	 eWhAehhF/h6Tvj+TPNCzejZfy6wJrB7/6W1n+Dqg=
Subject: FAILED: patch "[PATCH] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()" failed to apply to 6.12-stable tree
To: arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:17:14 +0100
Message-ID: <2025031614-broiler-overgrown-4bd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9360dfe4cbd62ff1eb8217b815964931523b75b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031614-broiler-overgrown-4bd4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9360dfe4cbd62ff1eb8217b815964931523b75b3 Mon Sep 17 00:00:00 2001
From: Andrea Righi <arighi@nvidia.com>
Date: Mon, 3 Mar 2025 18:51:59 +0100
Subject: [PATCH] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()

If a BPF scheduler provides an invalid CPU (outside the nr_cpu_ids
range) as prev_cpu to scx_bpf_select_cpu_dfl() it can cause a kernel
crash.

To prevent this, validate prev_cpu in scx_bpf_select_cpu_dfl() and
trigger an scx error if an invalid CPU is specified.

Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0f1da199cfc7..7b9dfee858e7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6422,6 +6422,9 @@ static bool check_builtin_idle_enabled(void)
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		goto prev_cpu;
+
 	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
 


