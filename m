Return-Path: <stable+bounces-121651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E5A58A4D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C213A8DFB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835018A6AE;
	Mon, 10 Mar 2025 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8txSR6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9D156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572881; cv=none; b=IsIYf7i6xq/UYfSvJhc40kSEZ4DySMpbrxcSxBDRNyx16XXYTfoDrSstzNgk48qVnMiUJXmRvPSn1jXHD+YWiTUN7F62FBfFKH3rEMdjiiEoFjbFatWkHL1TvbFwSgfDdLqJ9J7uj0tWQjHiix+WAgPgdQeEsQHzthyNpAURULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572881; c=relaxed/simple;
	bh=37Xh2GEh+yprikwmZUhJ59Ri7V1TXScnjKoQAso5s2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7c4ghyF/5AdFuKDOBUuqN456Hu8SA53qAVqJYVdOAPKnhNUatn7raKGTXJme2H99HuzPDjJsaYCQRAKnxj97BUuR/MP5i5EWlKhBgiDHunLmA8y8a+FLLwSDBq6UqUxq9B4Fc5C2RgBVEhIRbR5IXPp8k/C2yD7cOGJWglkTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8txSR6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBE2C4CEE3;
	Mon, 10 Mar 2025 02:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572880;
	bh=37Xh2GEh+yprikwmZUhJ59Ri7V1TXScnjKoQAso5s2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8txSR6IP76b6+YoiQrXDEapDwap4l6F/SnqPpnLK+QWrMUGrr7jZUP66mGzMKk8L
	 QvtH+bj06o6SYZAcJ3o3OH59vSoebkXBm/y5K73/lQ3xH1qhPLGNTTf1RhCsw5TWxb
	 C4mkWYV/YDLwLuvhBYvA+VazwH03guiKNfEvj3JiWRoBZY+ZOwV+dt8DeaSyRO/MFs
	 vUPp/2wEsYBdv93LnFEJuze2hWZaoqdUW4IboS0q25/6v6fjGtFNOtaIDzk2vEY7b4
	 NHRQCbCRgJTi/Ua2+tdGssK961zOr2VotLMLJCj9F8t9fEtURS194iJ0n8VIFdepZi
	 daVm+t8hfm2CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alan.maguire@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH linux-6.12.y] selftests/bpf: Clean up open-coded gettid syscall invocations
Date: Sun,  9 Mar 2025 22:14:38 -0400
Message-Id: <20250309170404-822d7ca7fb4d73b6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307172439.3656157-1-alan.maguire@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 0e2fb011a0ba8e2258ce776fdf89fbd589c2a3a6

WARNING: Author mismatch between patch and found commit:
Backport author: Alan Maguire<alan.maguire@oracle.com>
Commit author: Kumar Kartikeya Dwivedi<memxor@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0e2fb011a0ba8 ! 1:  84ebd5e6d67af selftests/bpf: Clean up open-coded gettid syscall invocations
    @@ Commit message
         Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
         Link: https://lore.kernel.org/r/20241104171959.2938862-3-memxor@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    (cherry picked from commit 0e2fb011a0ba8e2258ce776fdf89fbd589c2a3a6)
    +
    +    This backport is needed to build BPF selftests successfully for
    +    linux-6.12.y, as when currently building BPF selftests, the following
    +    error is seen:
    +
    +      TEST-OBJ [test_progs] raw_tp_null.test.o
    +    prog_tests/raw_tp_null.c: In function ‘test_raw_tp_null’:
    +    prog_tests/raw_tp_null.c:15:26: error: implicit declaration of function ‘sys_gettid’; did you mean ‘gettid’? [-Werror=implicit-function-declaration]
    +       15 |         skel->bss->tid = sys_gettid();
    +          |                          ^~~~~~~~~~
    +          |                          gettid
    +    cc1: all warnings being treated as errors
    +
    +    Fixes: abd30e947f70 ("selftests/bpf: Add tests for raw_tp null handling")
    +
    +    Reported-by: Colm Harrington <colm.harrington@oracle.com>
    +    Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
    +
    +    Conflicts:
    +            tools/testing/selftests/bpf/prog_tests/task_local_storage.c
    +
    +    Conflicts were due to new unrelated context in the upstream version.
     
      ## tools/testing/selftests/bpf/benchs/bench_trigger.c ##
     @@
    @@ tools/testing/selftests/bpf/prog_tests/task_local_storage.c: static void test_re
      	skel->bss->test_pid = 0;
      	task_ls_recursion__detach(skel);
      
    -@@ tools/testing/selftests/bpf/prog_tests/task_local_storage.c: static void test_uptr_basic(void)
    - 	__u64 ev_dummy_data = 1;
    - 	int err;
    - 
    --	my_tid = syscall(SYS_gettid);
    -+	my_tid = sys_gettid();
    - 	parent_task_fd = sys_pidfd_open(my_tid, 0);
    - 	if (!ASSERT_OK_FD(parent_task_fd, "parent_task_fd"))
    - 		return;
     
      ## tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c ##
     @@ tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c: static void *child_thread(void *ctx)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

