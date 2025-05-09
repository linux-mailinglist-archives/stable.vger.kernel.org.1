Return-Path: <stable+bounces-143042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F797AB113D
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3171BC3390
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9B28F92B;
	Fri,  9 May 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZTXmp4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239328F926
	for <stable@vger.kernel.org>; Fri,  9 May 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787870; cv=none; b=VG1Eojv3HTRuv3dL2gTd8k0ybzrdku96Tp0i85Jv5v9mU5Qb+YQrh0dqs+UC+oaWrnLm3EERgVEURPoXAl0iE/xtxxs0GYk98x7E6bOEXC2CHVp1DgGpEpaVSIGWUXnCaweVhztIcRsYN9Z/RHuo5J233HOSj7g+AP+9mCLWQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787870; c=relaxed/simple;
	bh=eGqS4QFxSEjZHGuQ+WLWaJt04NPuZDrlMKvaZt86C0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=re4Ieg06qfDqNbzVc2+kiZZURzbN9XPLVDfPeeCK772UP87/AgkwasnGwdoZRPjjzi7k4JPEEQ+HHwykxhqwJttrm/YhNPS2MLUfXCIhgZ545VXASD5AP45OPZ3D2NnjhDA6WRR/Xe9U/Np/K48aedJc0Tq1VA7Pypzg7182WjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZTXmp4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EB6C4CEE4;
	Fri,  9 May 2025 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746787869;
	bh=eGqS4QFxSEjZHGuQ+WLWaJt04NPuZDrlMKvaZt86C0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZTXmp4pRppWrkikPgKsQtTjwcIq5ewkANYx6CsigT46mmD/stsIhUz80Wx7lSYDz
	 NEOh4sEb3aECF/cAp838TXwxYbJM5JlMNmL8kSMyf/Rx8iSY2qJxwaVCoAE6AOo2TC
	 qVWqXqI72aZR1NYUvdRaIdAU5OaSBt/KSDBoIg3HRtMBqhqreOWRX307BG42k+jTb8
	 oB8X+noSTwrvFDe5ZPPpVed0O8XvZJR+Z03YsUH2kJqxkQAQ+KwV+QrtidwPUJPL9X
	 XNG/amr1KapP47UAFcPiM7Z6FQmbjETipZakA4g5NkO/ux5ANvgDHGtQfYF2yue+57
	 qnklOf9cGCAEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12] sched/eevdf: Fix se->slice being set to U64_MAX and resulting crash
Date: Fri,  9 May 2025 06:51:05 -0400
Message-Id: <20250508145402-e4369d956fad8683@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <9c0ce2024e862b3ee99bda8c16fbe9d863a9b918.1746650111.git.osandov@fb.com>
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

The upstream commit SHA1 provided is correct: bbce3de72be56e4b5f68924b7da9630cc89aa1a8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Omar Sandoval<osandov@osandov.com>
Commit author: Omar Sandoval<osandov@fb.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 50a665496881)

Note: The patch differs from the upstream commit:
---
1:  bbce3de72be56 ! 1:  878496a829cec sched/eevdf: Fix se->slice being set to U64_MAX and resulting crash
    @@ Metadata
      ## Commit message ##
         sched/eevdf: Fix se->slice being set to U64_MAX and resulting crash
     
    +    commit bbce3de72be56e4b5f68924b7da9630cc89aa1a8 upstream.
    +
         There is a code path in dequeue_entities() that can set the slice of a
         sched_entity to U64_MAX, which sometimes results in a crash.
     
    @@ Commit message
     
      ## kernel/sched/fair.c ##
     @@ kernel/sched/fair.c: static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
    - 		h_nr_idle = task_has_idle_policy(p);
    - 		if (task_sleep || task_delayed || !se->sched_delayed)
    - 			h_nr_runnable = 1;
    + 		idle_h_nr_running = task_has_idle_policy(p);
    + 		if (!task_sleep && !task_delayed)
    + 			h_nr_delayed = !!se->sched_delayed;
     -	} else {
     -		cfs_rq = group_cfs_rq(se);
     -		slice = cfs_rq_min_slice(cfs_rq);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

