Return-Path: <stable+bounces-163596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11841B0C5B2
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3743B25ED
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053A2D9ED6;
	Mon, 21 Jul 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n69llYsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EBD19E826
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106349; cv=none; b=S91fEmQNYSUBazSIyMh5aM2dZcfuBUnmA1PVNlYUJPEgqqurpPhNgn78gYx9rB0V57+kW7UJhIE23HwpYkoPlzx1qkCQ3LNS61GH+f55sJ9QwvDWyrDPuYSqZWwIqGrIofdP3KAtdFPzdunENk03B8QlTF1IGKoH6f/KwdVA6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106349; c=relaxed/simple;
	bh=Z//HDJrr9uje0d8mL8kYzNuWM60g2LvEyx8ST1apedw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAC5JSTB6tfDYtLMjlHpVvGNa7QKeNp1u5nP35HZHIVAqqP/8y3msK6SLUDihiQUPb6S9ivdKpRMPRVBeUpysBr5KeuwdzqesMgUEL4n/WHJ0ud947/AV6oW6Cb3MiZf97XiGVFOAQAem0z/A1pMKqUnx1pDz1OIu7xR1aezgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n69llYsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901F8C4CEED;
	Mon, 21 Jul 2025 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753106349;
	bh=Z//HDJrr9uje0d8mL8kYzNuWM60g2LvEyx8ST1apedw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n69llYsR2Y7FfBTt4kCv28zv4FgzEGUMJfYNW49xkZpFxtXqN5dTffYISPhBje/9s
	 ZUmndNirx/J4ItoNBXeO6Hl38nY4IZQqa5EWq0NbBE3zRWZpKtMEA7J9hrhakCRcRB
	 Cwyx407HUY3AZXOY0cGGhw28GoC1okIXtXmcvgtSoEp5QIth0gm+S9LrK2sUcr55Jc
	 eK2VwlQjx2kNe+aGcNdNMILZSR20DTPH8VMENl16T5pNwwQK7PKyNtI5IOlOEKHVuh
	 M3OfkyS0E6Pul8/9DWlNJoZx+5ZBOteQIn4RTOLRbAmYDsSG8WWL63WjIu74zw8lmO
	 BD3aYlLDSVWKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 1/1] selftests/bpf: Add tests with stack ptr register in conditional jmp
Date: Mon, 21 Jul 2025 09:59:06 -0400
Message-Id: <1753105552-4ba14ead@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721084531.58557-1-shung-hsi.yu@suse.com>
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

Status in newer kernel trees:
6.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5ffb537e416e ! 1:  f5e86b1f0ca1 selftests/bpf: Add tests with stack ptr register in conditional jmp
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
    +      backtracking bookkeeping", which was incorporated since v6.12.37. ]
    +    Link: https://lore.kernel.org/all/9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev/
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: static int check_cond_jmp_op(struct bpf_verifier_env *env,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

