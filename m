Return-Path: <stable+bounces-170322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C303B2A313
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194F77B4637
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64383203B3;
	Mon, 18 Aug 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DcT/E11m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D53203AE;
	Mon, 18 Aug 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522260; cv=none; b=s+K+lhx4tj06hUK4u9IKanne2lQpHxsHvoqcdRqRwb2YQ/Qopn3XU4J5VPKgtmznPXxcrfdaKgB0ITFfTSwqSbMqypfTQq3W6EyThtRxmSxv2QVYRX/+IHM/icgNMiP+oAYCgFjc14/yrwJt7mVN6ZDeMEdrr0lw/NZH1yIt3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522260; c=relaxed/simple;
	bh=kwIHW8r82mjvmsOJOB78r+rBZjFuApM0jir7v104Uqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AijxVPFS9vZyGvizaclggYHg+kPce0bkPnedoMcZ0KpKWmJwtvD7bL9LQSSI1aoQXodYjGxAD7VHP3ik1vv9VFtmulS+wEarOV5JrntPlbspiVUsGEEvOwR61xgi3ti+CXPGW0J/7MdcKZdUxOqdFLbgFID3QlzlGj+8Oo5VGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DcT/E11m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1BAC4CEF1;
	Mon, 18 Aug 2025 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522260;
	bh=kwIHW8r82mjvmsOJOB78r+rBZjFuApM0jir7v104Uqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcT/E11mNZJDOWxUuvWZFK/wpls0G3jpmvcm43dSlMsASs3CD8R6jrqI0ChkeWHBT
	 zRMPDG29ibD+ovAWJNSd2pNjtQsRPNXqvlE1GbjIAYKP06xm7ZrYBNzabsgEdCb7ub
	 Y13kxJ36UVSneNDC3rkzE2V5HMX9/94U+N4RCJz0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 264/444] selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB page size
Date: Mon, 18 Aug 2025 14:44:50 +0200
Message-ID: <20250818124458.723178684@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 8c8c5e3c854a2593ec90dacd868f3066b67de1c4 ]

The ringbuf max_entries must be PAGE_ALIGNED. See kernel function
ringbuf_map_alloc(). So for arm64 64KB page size, adjust max_entries
and other related metrics properly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20250607013621.1552332-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c       | 4 ++--
 tools/testing/selftests/bpf/progs/test_ringbuf_write.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index da430df45aa4..d1e4cb28a72c 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -97,7 +97,7 @@ static void ringbuf_write_subtest(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->maps.ringbuf.max_entries = 0x4000;
+	skel->maps.ringbuf.max_entries = 0x40000;
 
 	err = test_ringbuf_write_lskel__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
@@ -108,7 +108,7 @@ static void ringbuf_write_subtest(void)
 	mmap_ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, rb_fd, 0);
 	if (!ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos"))
 		goto cleanup;
-	*mmap_ptr = 0x3000;
+	*mmap_ptr = 0x30000;
 	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
 
 	skel->bss->pid = getpid();
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
index 350513c0e4c9..f063a0013f85 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
@@ -26,11 +26,11 @@ int test_ringbuf_write(void *ctx)
 	if (cur_pid != pid)
 		return 0;
 
-	sample1 = bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample1 = bpf_ringbuf_reserve(&ringbuf, 0x30000, 0);
 	if (!sample1)
 		return 0;
 	/* first one can pass */
-	sample2 = bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample2 = bpf_ringbuf_reserve(&ringbuf, 0x30000, 0);
 	if (!sample2) {
 		bpf_ringbuf_discard(sample1, 0);
 		__sync_fetch_and_add(&discarded, 1);
-- 
2.39.5




