Return-Path: <stable+bounces-146002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C261AC023B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E41162476
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F12B9B7;
	Thu, 22 May 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6RCcUZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3C539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879670; cv=none; b=eMm9C9KmrOr5BuVh5UTrGumcHxldU20hB2gr/tqFkxrU0q9dei2UmdpZOc3FRZOkx9UOSDQ4TOB2pcefL90wsoDOhNNXG2rOVI9xJpq6z1gXEteor9hyKubYdEVdqJzZBMHygr/2ZDqegxnoPl5DHJgoDFS4P2M8q/qnV2ltqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879670; c=relaxed/simple;
	bh=UagYytllYVFP4D/8KiHyFS2bK0zXRKY7CeZTCFxibHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9S9Wh9orO8mrj0KWpR6KKTkJ2kwNR2/3KgcOk9HaJ/wB53pXkWaBaAPLUBl+LIE3Ajq616nDaIVoAFJ+IoA6Wzx7oHI1IkXPs89IHdENS72ThpTixyoKaSWpuvrEhh4zcWlwAdznuhHNWsyRcejlAF5pUvILUiKcb6DoXIxRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6RCcUZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC91FC4CEE4;
	Thu, 22 May 2025 02:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879670;
	bh=UagYytllYVFP4D/8KiHyFS2bK0zXRKY7CeZTCFxibHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6RCcUZg7AqYzw5dJ5qg7a7i7N0hPZBA2cyGxWb0zlFnrx/23e4bYCMKB/KGqBFwH
	 0jcZv3WDo/+GHGeUEbBXuus/D46Y1QM7NeOrG/6Ma4TDC5ZhkXORv7qJEaChAfQSiS
	 BagCtz+FFntm6uXTTKaGilAR/YohZZN28hk6/3Dud/EA8BuHHj7lsqeGgxBt+RJqP/
	 ZgYk+H1wBjTt6tREeprx6kxJRPjJOM1fLNweW1cfMjKOnMVVmsLSEQIORWBLZaeKVu
	 x46uI9V6+H9B5ITnZw+5KrTvyX/ISMOJ0xe4055Wd7dzfxNZwqOHKksLEHELAcf7wZ
	 uSu0Qg+rvajmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 02/27] af_unix: Return struct unix_sock from unix_get_socket().
Date: Wed, 21 May 2025 22:07:47 -0400
Message-Id: <20250521190922-c2aed6f5119d5aef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-3-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 5b17307bd0789edea0675d524a2b277b93bbde62

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5b17307bd0789 ! 1:  fed4cc80f032b af_unix: Return struct unix_sock from unix_get_socket().
    @@ Metadata
      ## Commit message ##
         af_unix: Return struct unix_sock from unix_get_socket().
     
    +    [ Upstream commit 5b17307bd0789edea0675d524a2b277b93bbde62 ]
    +
         Currently, unix_get_socket() returns struct sock, but after calling
         it, we always cast it to unix_sk().
     
    @@ Commit message
         Reviewed-by: Simon Horman <horms@kernel.org>
         Link: https://lore.kernel.org/r/20240123170856.41348-4-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 5b17307bd0789edea0675d524a2b277b93bbde62)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
    -@@ include/net/af_unix.h: void unix_destruct_scm(struct sk_buff *skb);
    - void io_uring_destruct_scm(struct sk_buff *skb);
    +@@ include/net/af_unix.h: void unix_notinflight(struct user_struct *user, struct file *fp);
    + void unix_destruct_scm(struct sk_buff *skb);
      void unix_gc(void);
      void wait_for_unix_gc(void);
     -struct sock *unix_get_socket(struct file *filp);
    @@ net/unix/scm.c: EXPORT_SYMBOL(gc_inflight_list);
     @@ net/unix/scm.c: struct sock *unix_get_socket(struct file *filp)
      
      		/* PF_UNIX ? */
    - 		if (s && ops && ops->family == PF_UNIX)
    + 		if (s && sock->ops && sock->ops->family == PF_UNIX)
     -			u_sock = s;
     +			return unix_sk(s);
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

