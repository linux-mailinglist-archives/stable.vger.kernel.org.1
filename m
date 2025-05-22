Return-Path: <stable+bounces-145951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D5AC01FF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5EE9E15AB
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592762B9B7;
	Thu, 22 May 2025 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjytYNTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C441758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879428; cv=none; b=VRgFVkwjjCcanCY43c9z0SNTSxoMocV7zDRpEs8HWhBJq2sLg7jPsWkI7H7rJBlyImWSaJjCWjtNEUP974UeMoISntX8D9iP4Nl6/XVy7iApEG2SD5fRlJd2lP+TWA0cydpnu5d94h8sQ5IIb4RCiOhaNiqKkrXDXDgStE3KKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879428; c=relaxed/simple;
	bh=XGsxxw2ltvg6ZMzuxYBN5AwkpW0sgORkk1hY+0KcRK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI/B+KuYlD3C1HtiECmRcIYUMzWzy6ZYkU6dTFSLvXNWdDXytXiDDMOlhem4LqM4zq63fLxgfVkYjzivxxryHgD64LVmRQg+AsEd3aFrPFSomI9p1tDM8mCwEHkN29p9gC0heZUEemxP09iMYSxSLHIV6nHOrp99T3XRFgbfSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjytYNTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04349C4CEE4;
	Thu, 22 May 2025 02:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879427;
	bh=XGsxxw2ltvg6ZMzuxYBN5AwkpW0sgORkk1hY+0KcRK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjytYNTXC2U+PWlc5EQyho5pUM/EjXZNpcbnMRz10nj72RWLWLp4ciqoeQmzXONXG
	 +W2wNBJ5y0xn1pcva1lRGnT4qjnMVGRnYcwQgudCWUb1LyIdakDQ6KWRmecu2Kz30Q
	 boR/OfEPMaL+b+G6M7kpsvOyxTGrJv0+TTBor868HraM6Z8nN23Ux5/ndngQCwzRhg
	 +oNK3+G01lXu8D0ub7l2Lm6FSN8IJQhewnjlJWeWrBc/rRnpB4jM80RnA5lhBV3MBl
	 iFilYPppwkHoxW3OnBqnHaROAWLtvclOMU6T8rl0auJ3rXGfIIA6aA7bxnNeEqnghF
	 9sw8OxHpIr6Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 10/26] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
Date: Wed, 21 May 2025 22:03:43 -0400
Message-Id: <20250521173033-867e61230392c367@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-11-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 22c3c0c52d32f41cc38cd936ea0c93f22ced3315

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  22c3c0c52d32f ! 1:  21bb7bc5ddbac af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
    @@ Metadata
      ## Commit message ##
         af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
     
    +    [ Upstream commit 22c3c0c52d32f41cc38cd936ea0c93f22ced3315 ]
    +
         Currently, we track the number of inflight sockets in two variables.
         unix_tot_inflight is the total number of inflight AF_UNIX sockets on
         the host, and user->unix_inflight is the number of inflight fds per
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-5-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 22c3c0c52d32f41cc38cd936ea0c93f22ced3315)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static void unix_free_vertices(struct scm_fp_list *fpl)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

