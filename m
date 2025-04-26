Return-Path: <stable+bounces-136755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D76A9DB18
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549F71BC31C3
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452913E41A;
	Sat, 26 Apr 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdG1Bggq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D51AAC4
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673827; cv=none; b=nkjS/rQno45/FJRqd4Z7Z0Vl5BjYVvrvKWDMcI/jZOaL36sXBwtGPzWrU01FLHARkt6kgyffp8oYbG5BVKd/GKi/JHcssDHsfJApl4O99yKGnndPkFpUNosZxjCBrakeuhZMor6ZsuA3de6DwMr1EuwRnjKKcuB3Z1BemeGgv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673827; c=relaxed/simple;
	bh=XhznvoqMKZ+POGd+YhEiesAI11uLp+3g3V+57PcX3S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOeijot4kwJX5vb8CEAGhMaMhLnnMfWml7RqwIGF2ms7vKAM+YpLjIvQwddzqSB44U2aPpfhcgGeGPZF3KKnkaBhfqWwJFV5fzZgqldS0wCA4ukRVox2AIBigISmB5Gqc8Y/pE7VFVlm+kMMkqte9+o8vlnE4XEXI+PunT4SS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdG1Bggq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B541C4CEE2;
	Sat, 26 Apr 2025 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673826;
	bh=XhznvoqMKZ+POGd+YhEiesAI11uLp+3g3V+57PcX3S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdG1BggqAbFTT/Y6Jio9EtgM1chpaHhOT4TPajT1LjiyUe2BDukXbUonRvJfALHH9
	 xpawE7oX0pR1s/3XZLSKSIihuGQWmRX+i5Kw4zCoZQR0qPq5Ebig/Oq5DafgCLXGGR
	 rsiOLxLA4j9b6Tc9O6gaBX2CvbrkEU8ZTqxw7auTgdIY3Nnz5Fk0sNqI35omBUB8QP
	 IamLLAgnbbCQGJ181yp6eBq+CcOWBFICmHmrDgi4BB2byVi24MszEYNzomHhP5LCuz
	 jmHWVdYv2Rk+KZprHDOiWZiWsnKQXOKO8MBV2O2o2Anos5RYyhfNYv+tHBM+EQKhoa
	 ahULTjIOv381g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 3/4] selftests/bpf: check program redirect in xdp_cpumap_attach
Date: Sat, 26 Apr 2025 09:23:44 -0400
Message-Id: <20250426051101-cfed10a843955306@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425081238.60710-4-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: d124d984c8a2d677e1cea6740a01ccdd0371a38d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Alexis Lothoré (eBPF Foundation)<alexis.lothore@bootlin.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d124d984c8a2d ! 1:  6678a2106ae30 selftests/bpf: check program redirect in xdp_cpumap_attach
    @@ Metadata
      ## Commit message ##
         selftests/bpf: check program redirect in xdp_cpumap_attach
     
    +    commit d124d984c8a2d677e1cea6740a01ccdd0371a38d upstream.
    +
         xdp_cpumap_attach, in its current form, only checks that an xdp cpumap
         program can be executed, but not that it performs correctly the cpu
         redirect as configured by userspace (bpf_prog_test_run_opts will return
    @@ Commit message
         Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
         Link: https://lore.kernel.org/r/20241009-convert_xdp_tests-v3-3-51cea913710c@bootlin.com
         Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c ##
     @@ tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c: static void test_xdp_with_cpumap_helpers(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

