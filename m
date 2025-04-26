Return-Path: <stable+bounces-136756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C68A9DB19
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB091BC321A
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EA13665A;
	Sat, 26 Apr 2025 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0+XCq9/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A11AAC4
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673832; cv=none; b=f3fo/KmpvKCMGvBkMKSJDZ0ekxW0l+AhW8TXcpymj0vCb5KFxKrpR/w1JqH8w9WQNCUuPzy+kYVk1PmyGqCxm37vTKgU5TMQH8DQB6vBvHoee5jcaaGEIFI/kX96oiOPAh1KHRqQ6xu2bWx7Z2kyT0/fqgMFsCaomcZKTAo2YSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673832; c=relaxed/simple;
	bh=wGHvFjczho0sJlAQTEGA5+/MWJgMCPVy70ShnBxRu0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqhERecKzWwNIMBtvKONkZ8twVOxZakmw7rZ8B7+3NSisEyHLDHxY3lPD6o2hpAjkqeeA8PcYD1FlWCDIWJUlzskf+vxrCNdxmA/wKzdMwj+U/sZxeH35kx9wPixIg1xQX5i6ha0Bo7e9RC9wxJZhFDQxzUHMkJlmTGJ2cuobAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0+XCq9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22266C4CEE2;
	Sat, 26 Apr 2025 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673831;
	bh=wGHvFjczho0sJlAQTEGA5+/MWJgMCPVy70ShnBxRu0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0+XCq9/Z3nYNrglvpAqArV+beh6AwfOhFyn145Wl4tugeRwcWbhvDTL3GVRMs1NM
	 TFVM6fv1F/8SV8MM8raaCtxbMTiY874/OUoy5pO2iPoiBzPunI295S6IyPhXQ3DKlO
	 bbhki9nQUIb2Lz+r77zLiGoM4YWyqUHjnrR+HD6R3an8KE9x86VCgcu1jlNIRXdtAU
	 x3JwHmg/Up5rP9RBkK3Z94/fy9ifJ93lcgopRjikQg/1ACukr5Zl+lr644g/bbkB/O
	 oIwscUpGF0Cgrhwuz4LQv8J0y2GwdUq/nM83QHWQ/5A6kSlCgmjrCDsHALAup9Y9FL
	 94SY5Q7Wh84Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 1/4] selftests/bpf: fix bpf_map_redirect call for cpu map test
Date: Sat, 26 Apr 2025 09:23:49 -0400
Message-Id: <20250426044800-082f2ee2914e0a1c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425081238.60710-2-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: ac8d16b2d3772934f4cba44cb01bad05b4b2864c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Alexis Lothoré (eBPF Foundation)<alexis.lothore@bootlin.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ac8d16b2d3772 ! 1:  1118d35b74efb selftests/bpf: fix bpf_map_redirect call for cpu map test
    @@ Metadata
      ## Commit message ##
         selftests/bpf: fix bpf_map_redirect call for cpu map test
     
    +    commit ac8d16b2d3772934f4cba44cb01bad05b4b2864c upstream.
    +
         xdp_redir_prog currently redirects packets based on the entry at index 1
         in cpu_map, but the corresponding test only manipulates the entry at
         index 0. This does not really affect the test in its current form since
    @@ Commit message
         Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
         Link: https://lore.kernel.org/r/20241009-convert_xdp_tests-v3-1-51cea913710c@bootlin.com
         Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c ##
     @@ tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c: struct {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

