Return-Path: <stable+bounces-145960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C10AC0209
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F320D1B634A7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0D2B9B7;
	Thu, 22 May 2025 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCocuSkv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067571758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879463; cv=none; b=CRDfqFUPHZHaE39a/q+Q/AX+gvqKcv7gjNLJhY6dqqBTM/MezYzFOMZQnFxAFFN5qZ12xjN5tYqp5ablXyCOH1lR67J+bYHSm5AfrOrsQEfYQjKmNJYzq5B5LKe0Tpu20CkVTJWQwwJ5R6/TOEW4bWbnPYXJSZFFCMHL0pueolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879463; c=relaxed/simple;
	bh=/xPGX963YVWl5dDJqIOislm+rLB3jcmZJt7q0ZqWYuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKUahLMdKHJDjGa1pOnzCljnZylJlUJGYxRnh8cAOlk3dhItcW2oIbq/pf4mHpWIKssmK4dOl06epGGHOQnj5Gqw2X0tKH+284xXZN9T3Wc9YQYoPitfp5Ss6OaGUWCicHTkFzF26Lyxm+v8DkhKzEmLNtDx8fcHB2oQhiXEcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCocuSkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0D9C4CEE4;
	Thu, 22 May 2025 02:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879462;
	bh=/xPGX963YVWl5dDJqIOislm+rLB3jcmZJt7q0ZqWYuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCocuSkvtYDmsmOFQC7hn1UGA2UKDS6XyfLdDxAOhgmY61H/KDXjevjSG/qqPHUs5
	 +7ATToaZKgL34twO5cqA39KDDBUUIyo5FU6/t5Kap+T4+VtFZu4KWlZ4DpS00dCGlz
	 V3B5ParB5VgfTI2IiWt4KcXCqhaeJ2Ui2YRU1Lt2MTibz5xG5ReZiJbHz94Evcxbjb
	 zZgG+g3/CtQYqsSeL7QAe40rLyL7s7xG4EX+XGxPpwTdrC/W4YOBV1qBa6yH6WOmpE
	 KHHbq5KDR4VBKXAGddUFxNwE2E1x/AjbxJ6qyiYDOx/eCtQXWTD/MGlAJEEmM+Jnuw
	 D5RpvYLZkwC3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 27/27] af_unix: Fix uninit-value in __unix_walk_scc()
Date: Wed, 21 May 2025 22:04:19 -0400
Message-Id: <20250521215943-2e9435bbd9f0bd1c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-28-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 927fa5b3e4f52e0967bfc859afc98ad1c523d2d5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Shigeru Yoshida<syoshida@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  927fa5b3e4f52 ! 1:  3996bfbf88f0e af_unix: Fix uninit-value in __unix_walk_scc()
    @@ Metadata
      ## Commit message ##
         af_unix: Fix uninit-value in __unix_walk_scc()
     
    +    [ Upstream commit 927fa5b3e4f52e0967bfc859afc98ad1c523d2d5 ]
    +
         KMSAN reported uninit-value access in __unix_walk_scc() [1].
     
         In the list_for_each_entry_reverse() loop, when the vertex's index
    @@ Commit message
         Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://patch.msgid.link/20240702160428.10153-1-syoshida@redhat.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 927fa5b3e4f52e0967bfc859afc98ad1c523d2d5)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

