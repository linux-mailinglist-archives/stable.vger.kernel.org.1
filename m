Return-Path: <stable+bounces-132350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2AA872AE
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DCE3B76D4
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E01D7E37;
	Sun, 13 Apr 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2Ttu3EE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66C14A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562824; cv=none; b=kXGa92qQViy8IDnk/SMysHbXIv2fRHUXSRftjyEGqZyAudbZ5jOg7SXcEQSl2KdO1TlckGRshblwvYTTpAe+YOczKfaqqmIHc3quMjb1S0lllfVmTO0ZwgdWLb2p+lLX6IPC8j8nqCGuEmXJvO493p2GPeac299PY/ZUOMZlssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562824; c=relaxed/simple;
	bh=AHbf0ZCbyC7NtJG/Hjv43Vu9LqWdQqb5AFrbVlyO8Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOkiewac71wkkdDX7JIWyQkrIFq9XfKMD+rzfbkmJCiZq3+TGiOGSGQypTdvtfAu0RJtU9m4okNvxfli5oaqLzyQ1PNxBv4zwrFYLw3EHpmW6bH7Sw5nw8qAJiFGvNe9Xcg9xFB16/a9YpoZZu+0WFhyNKYsZirjUQ3YqbQakj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2Ttu3EE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2A3C4CEDD;
	Sun, 13 Apr 2025 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562824;
	bh=AHbf0ZCbyC7NtJG/Hjv43Vu9LqWdQqb5AFrbVlyO8Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2Ttu3EE05nZvw1vKo97m/y0bWhdmxd5kDEUJaaTps18AuMvb4ZLgL38tgZOZwDpd
	 76oP6XMqteATbkmpGeeN6GLr2PHaOHIy/bIDJeOuW1rJErh53d1Ci/GRjjbY9I0Ezo
	 4ezQdaBIz6VhxnojwN+nYQHpPnx6/p6adA1YymNWPkHoSFOqJNl6knh7YSOsFHx+Vp
	 6L5mZ7tWxBpG7ObbV4r9b5OJj9RNWXmhtrPwVVCchvMTD/0AM502OIXMVskhowWPlC
	 eofHMZuah2KOjrmZ3zjJGAjrJ2L4iqsY028zr/HMq2gXgzfo+ZqR3fQNndCuqI9Zb6
	 rlWqYLeUne+UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] bpf: Prevent tail call between progs attached to different hooks
Date: Sun, 13 Apr 2025 12:47:02 -0400
Message-Id: <20250412105007-9172123c03531e33@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411071015.3418413-1-jianqi.ren.cn@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 28ead3eaabc16ecc907cfb71876da028080f6356

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Xu Kuohai<xukuohai@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 5d5e3b4cbe8e)

Note: The patch differs from the upstream commit:
---
1:  28ead3eaabc16 ! 1:  1b963bf11ac0f bpf: Prevent tail call between progs attached to different hooks
    @@ Metadata
      ## Commit message ##
         bpf: Prevent tail call between progs attached to different hooks
     
    +    [ Upstream commit 28ead3eaabc16ecc907cfb71876da028080f6356 ]
    +
         bpf progs can be attached to kernel functions, and the attached functions
         can take different parameters or return different return values. If
         prog attached to one kernel function tail calls prog attached to another
    @@ Commit message
         Link: https://lore.kernel.org/r/20240719110059.797546-4-xukuohai@huaweicloud.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: struct bpf_map {
    @@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
      
      	if (fp->kprobe_override)
      		return false;
    -@@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
    - 	 * in the case of devmap and cpumap). Until device checks
    - 	 * are implemented, prohibit adding dev-bound programs to program maps.
    - 	 */
    --	if (bpf_prog_is_dev_bound(fp->aux))
    -+	if (bpf_prog_is_dev_bound(aux))
    - 		return false;
    - 
    - 	spin_lock(&map->owner.lock);
     @@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
      		 */
      		map->owner.type  = prog_type;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

