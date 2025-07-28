Return-Path: <stable+bounces-164980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B641FB13DC1
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9B9178B33
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAABD26AAAA;
	Mon, 28 Jul 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwI2eejq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19C34CF5
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714670; cv=none; b=BaTSEVxpyfrP3OUAcoCOA+GYildOc6iMnfnnl86zWeij1GzAU8KFJw+ovVxq9Pd/zBL83iZfqP+Lv+Wv2PyrilGcIb7jZGcWhE5ewWl4QPpiVhV56nQJhYvaIwmuXwRTbvEl0D2vVLqZ6J9qgCOEhcU/vRGrYOChTtr16bbcz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714670; c=relaxed/simple;
	bh=RTqaak+/+8A74P3wV7WRiBkmV3yxVzkT4zfvyeVVU9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fasHxTGHIi4TGpUzH8ocJMDViMwrqc6DEzet+EbDOFbuqQbSc3G7GPtJU668ecF9yJoJJGJlHhJe+fBu+0uzcpu8Uba2MjSpuiYrDJrhE7n24xtz4gS9KOhJfG/kZAcADmaBVaoKY/XAYcCYBFrkBRIi5f6jejWC25tjsCQFotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwI2eejq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B62BC4CEE7;
	Mon, 28 Jul 2025 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714667;
	bh=RTqaak+/+8A74P3wV7WRiBkmV3yxVzkT4zfvyeVVU9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwI2eejqNIHbAmnTBBManOxXUGS2CBOBEqqBmwRHy5gQdOKAu/IC2THpfcuW7s2LB
	 qEfL/uOoNcMWIDhbVPatl5zE+6/XJ9DxBVddnKyMRuJLswqyuyN8RPMblRnMnGuH0Q
	 qYbPsXlsgCg1A6vWVSjz8VLDcalAmMSh/crnqD19hzlDGEketyIcAIfXBB1oA+nwm+
	 r7KAgW54ZwTbbJmlFjSxszq22Ez+/rcOVE13XcWZOjUzSoGQTw+SpKQLFt4VxI2sq8
	 L35LbPZnb2Qc/zkbOJqDB0Sfc3a+b4V9SCjDnA68p/GV+0FNUhqDocrbnOZbSVp7v/
	 bBy0qYtKsPQrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 6.15 1/1] selftests/bpf: Add tests with stack ptr register in conditional jmp
Date: Mon, 28 Jul 2025 10:57:44 -0400
Message-Id: <1753711318-0704b12f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728072018.40760-1-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 5ffb537e416ee22dbfb3d552102e50da33fec7f6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Commit author: Yonghong Song <yonghong.song@linux.dev>

Note: The patch differs from the upstream commit:
---
1:  5ffb537e416e ! 1:  0812c73da513 selftests/bpf: Add tests with stack ptr register in conditional jmp
    @@ Metadata
      ## Commit message ##
         selftests/bpf: Add tests with stack ptr register in conditional jmp
     
    +    Commit 5ffb537e416ee22dbfb3d552102e50da33fec7f6 upstream.
    +
         Add two tests:
           - one test has 'rX <op> r10' where rX is not r10, and
           - another test has 'rX <op> rY' where rX and rY are not r10
    @@ Commit message
         Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
         Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
         Link: https://lore.kernel.org/bpf/20250524041340.4046304-1-yonghong.song@linux.dev
    +    [ shung-hsi.yu: contains additional hunks for kernel/bpf/verifier.c that
    +      should be part of the previous patch in the series, commit
    +      e2d2115e56c4 "bpf: Do not include stack ptr register in precision
    +      backtracking bookkeeping", which already incorporated. ]
    +    Link: https://lore.kernel.org/all/9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev/
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: static int check_cond_jmp_op(struct bpf_verifier_env *env,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.15                      | Success     | Success    |
| 6.12                      | Success     | Success    |

