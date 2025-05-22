Return-Path: <stable+bounces-145954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7FAC0202
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64A81B62FCC
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D22B9B7;
	Thu, 22 May 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFSi+4h+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804F1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879439; cv=none; b=a53uJRMTsFzHxKNe8PT7Or3Yl5Rd3iQqsIGhebHJZ6bHmMSvE67ODBxxLzDcHNdwuDvVDKEQyFBZzX/wLflsMokXKNy3txtMbkW1w7Xv4acW41KMleOAz5gVYH9RZUky6nzfWb/10HTh0eBGGNyqnJS3ympcol8s4t1Ec35XsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879439; c=relaxed/simple;
	bh=ou4iJ3cFn1i0vsP6VJ6gPgAUPLoN1aGp8UoMfjkeZg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dmvz8ZOKoaRf+fAwAzqNdcWQ71MuPaiyqYfYZBk3Fok5eWs4p1m3mCHUCZ8tRw3MA7asiVfCFcGIwJV0LVkQUMKJyrZExkk0aEDbPAgBW98lAVjf69abLYeGf4rPaYq/H99KX9ntWc0i4eJP69HgqPsQqcOa7dYVB2HAzdLHETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFSi+4h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3E8C4CEE4;
	Thu, 22 May 2025 02:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879438;
	bh=ou4iJ3cFn1i0vsP6VJ6gPgAUPLoN1aGp8UoMfjkeZg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFSi+4h+EP5akH/ETqZrFxT6tblVvjc5aAhoWv+p6zZOQjP+zDVdMBdlPTZFbLRZk
	 l1xVpnfE9syFeTq/EpMfH+aQosxo0Q9MoD0Irn5zzl8rel4PxuX5G881IvFjgrJTl1
	 fQmtF5IKkT26deCHtyvGW3oQN0sMEESWMWzf8AzBxQDlHRh/K5fSuxDTxwJvAyQupX
	 pF//VMERrufGbLeyvxDOUYmT15cfhRTetrbDKdto/LOfnuBAsoJWXxDwbEWnfeaZTq
	 yda7vOjX3qauMx6V9j98wXLireQgwXhuvRSR74ZzUDNFEGIh6l+3Cva8SSyJVUrUOh
	 QM1g6HPER7f2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
Date: Wed, 21 May 2025 22:03:54 -0400
Message-Id: <20250521135218-49533875d0300317@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521015934.538871-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: 53dac345395c0d2493cbc2f4c85fe38aef5b63f5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Frederic Weisbecker<frederic@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: e456a88bddae)

Note: The patch differs from the upstream commit:
---
1:  53dac345395c0 ! 1:  1e8712284e346 hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
    @@ Metadata
      ## Commit message ##
         hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
     
    +    [ Upstream commit 53dac345395c0d2493cbc2f4c85fe38aef5b63f5 ]
    +
         hrtimers are migrated away from the dying CPU to any online target at
         the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
         handling tasks involved in the CPU hotplug forward progress.
    @@ Commit message
         Link: https://lore.kernel.org/all/20250117232433.24027-1-frederic@kernel.org
         Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
     
    - ## include/linux/hrtimer_defs.h ##
    -@@ include/linux/hrtimer_defs.h: struct hrtimer_cpu_base {
    +    Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
    +
    + ## include/linux/hrtimer.h ##
    +@@ include/linux/hrtimer.h: struct hrtimer_cpu_base {
      	ktime_t				softirq_expires_next;
      	struct hrtimer			*softirq_next_timer;
      	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
     +	call_single_data_t		csd;
      } ____cacheline_aligned;
      
    - 
    + static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
     
      ## kernel/time/hrtimer.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

