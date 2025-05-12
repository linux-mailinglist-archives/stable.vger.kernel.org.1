Return-Path: <stable+bounces-144050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E49AB46C0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407CA1895810
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A29266B5C;
	Mon, 12 May 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDBbl3hP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F122338
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086734; cv=none; b=kYPyY5ZZMUEe6b0haj/wGTB8qa70nFNVyjNsc6IbRqpO1Qhv6uTRR62tJlr+z139hz61S451rul5CiH+b6q5SZwlIah4KCduXP5eqnO2/ZtN9pS1/8fTuZcSqRBER0ng1NXmCk3wyWYT5Z6EAQ9uz2r9dHnHUnktxhaAiXeTO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086734; c=relaxed/simple;
	bh=Ih2Z9l+GTxzuDkwt5S+M6RecJw1kqhtR0qkxlV1PFdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mga9WQt8D+ruu2sS2hKnosEaCUIqs7h+dxSoQ1R1d062lNlaue0gLDCBMLJhRrXqXmIOjfshEG25ZzF/EBsx6qzumtgJ51qoL46spG6DfgGxnDIKgezIjntpQuE9aYQAdFR+a9gmmurihtjDXlucnUfB1mVJc+PcCZ4U0po7VBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDBbl3hP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C8C4CEE7;
	Mon, 12 May 2025 21:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086734;
	bh=Ih2Z9l+GTxzuDkwt5S+M6RecJw1kqhtR0qkxlV1PFdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDBbl3hPamYZpenq5zDA3YnsT3kGtFM713iBPPx5Q6b0ynovGGfA6QtVvZC9TH81M
	 1i7eT5OCstrM6S28kObWl//gq18E1sIzZwadaHCgVVR1YlAhBddWFFVhRD3j0YIswm
	 yFjyL0u7K2Ccq4CgCg8XQu1dO19+yJ34RZoZRqQOTw71u6qRHE+VmJGJNSrv0rFNn5
	 tZFPSCN3Z5OO5jemfps5RKkjbKFsik0Fpg4nLdE/liXoHigcQo4LtzXGBT3MX62dnJ
	 /SEfSh1XN8FuGF+RBUuEWrKoFaxcIvc1rYLnB8QVQQme83ssRSoQIRl0G6oQIYzQz/
	 lFTS1rf364hRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jianqi.ren.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] bpf: support deferring bpf_link dealloc to after RCU grace period
Date: Mon, 12 May 2025 17:52:10 -0400
Message-Id: <20250512155858-3ac04f98dd6ba4de@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512031847.3331135-1-jianqi.ren.cn@windriver.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 876941f533e7)

Found fixes commits:
2884dc7d08d9 bpf: Fix a potential use-after-free in bpf_link_free()

Note: The patch differs from the upstream commit:
---
1:  1a80dbcb2dbaf ! 1:  40f6d480a2072 bpf: support deferring bpf_link dealloc to after RCU grace period
    @@ Metadata
      ## Commit message ##
         bpf: support deferring bpf_link dealloc to after RCU grace period
     
    +    commit 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce upstream.
    +
         BPF link for some program types is passed as a "context" which can be
         used by those BPF programs to look up additional information. E.g., for
         multi-kprobes and multi-uprobes, link is used to fetch BPF cookie values.
    @@ Commit message
         Acked-by: Jiri Olsa <jolsa@kernel.org>
         Link: https://lore.kernel.org/r/20240328052426.3042617-2-andrii@kernel.org
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    [fixed conflicts due to missing commits 89ae89f53d20
    +     ("bpf: Add multi uprobe link")]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: struct bpf_link {
    @@ kernel/bpf/syscall.c: void bpf_link_inc(struct bpf_link *link)
     +
      	bpf_link_free_id(link->id);
      	if (link->prog) {
    -+		sleepable = link->prog->sleepable;
    ++		sleepable = link->prog->aux->sleepable;
      		/* detach BPF program, clean up used resources */
      		link->ops->release(link);
      		bpf_prog_put(link->prog);
    @@ kernel/bpf/syscall.c: static int bpf_raw_tp_link_fill_link_info(const struct bpf
      };
     
      ## kernel/trace/bpf_trace.c ##
    -@@ kernel/trace/bpf_trace.c: static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
    +@@ kernel/trace/bpf_trace.c: static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
      
      static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
      	.release = bpf_kprobe_multi_link_release,
     -	.dealloc = bpf_kprobe_multi_link_dealloc,
     +	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
    - 	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
    - };
    - 
    -@@ kernel/trace/bpf_trace.c: static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
    - 
    - static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
    - 	.release = bpf_uprobe_multi_link_release,
    --	.dealloc = bpf_uprobe_multi_link_dealloc,
    -+	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
    - 	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
      };
      
    + static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

