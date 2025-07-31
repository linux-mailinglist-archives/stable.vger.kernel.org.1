Return-Path: <stable+bounces-165702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5902B17912
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3651A1AA6786
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8C4275B1D;
	Thu, 31 Jul 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpSFaq6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2871265284
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000420; cv=none; b=ICQwiqcHB04NujvrCHrWCk2SCmimlZHrbom5wXFn4aXbe0tsxfAaPoNVKFn3yn3Q4X1Afipkvd2D7b7kTBn2a0xuUDSY3Ts+NpOeNYLfoFOxAShMK97YHrfAuuDxdc1HG5A2qfLd7FWgC/XZjgizVXDiowvvuG2ghiPKxfmutCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000420; c=relaxed/simple;
	bh=ZwOVwTmbviOr75CZsJTZtXFhGs3aqQGpAsZ/puc2OR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ci0lPe45yrl0g4pZLkjZDOrz152+CoxQ79+NUFNFutimJn0SdehWgaLVaLbN/cgiVaVjN9ZT2gMyYNBdYEUPgIstTHHD8Xb+flq9yHFczmFJb/7KApkXgS2tD6Vo3AlKQFotbufIF8MlNH0rgLM0iSGMPB4TSa8ISNnLpGerK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpSFaq6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C9FC4CEF8;
	Thu, 31 Jul 2025 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000417;
	bh=ZwOVwTmbviOr75CZsJTZtXFhGs3aqQGpAsZ/puc2OR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpSFaq6YjJHxk+OPmUadBunxcYbUE38xO+QlnbwfQ3ewlwLHtcvedTrE04nG0R5WD
	 QMYshwaK2Ov6ae3Uud2qndWFrGt7Xi8BSfPnXPwz5vq6Yt1wkkCRg//WNd9ZtsAl1T
	 W7lGRfAeTuEAwOFlXYMlilq93SuT1fRdje3NvOWCzB+yXFErPipeb8L4mqxLepsuN1
	 i/8p1a+hU5EyaiNYnsCj471fQy8eOX8917Zo0ui7AV+hmc0Ud+N7MdGv5NbdKY4gOt
	 8z9qblGjPw30JhHZX4AVjtWPmHD9/cDon81WvqjAvojUuCSz0RxruLmN3gdOhEre7n
	 rMekrZXfk8g3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 5/6] mptcp: drop unused sk in mptcp_push_release
Date: Thu, 31 Jul 2025 18:20:15 -0400
Message-Id: <1753976219-106014c2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731112353.2638719-13-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: b8e0def397d7753206b1290e32f73b299a59984c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Geliang Tang <geliang.tang@suse.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  b8e0def397d7 ! 1:  c702d329678d mptcp: drop unused sk in mptcp_push_release
    @@ Metadata
      ## Commit message ##
         mptcp: drop unused sk in mptcp_push_release
     
    +    commit b8e0def397d7753206b1290e32f73b299a59984c upstream.
    +
         Since mptcp_set_timeout() had removed from mptcp_push_release() in
         commit 33d41c9cd74c5 ("mptcp: more accurate timeout"), the argument
         sk in mptcp_push_release() became useless. Let's drop it.
    @@ Commit message
         Signed-off-by: Geliang Tang <geliang.tang@suse.com>
         Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Stable-dep-of: c886d70286bf ("mptcp: do not queue data on closed subflows")
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/protocol.c ##
     @@ net/mptcp/protocol.c: static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

