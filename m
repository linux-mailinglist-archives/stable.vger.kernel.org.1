Return-Path: <stable+bounces-145992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80263AC0230
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C16F4A8295
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A416FBF;
	Thu, 22 May 2025 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzhz3RVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A72D7BF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879632; cv=none; b=SMsMgRm4WJUhVtxh8QkqEwJefL/mEa+CctjUNTINSoBuec6T9lMoADfAWYIRXAXVufUzswy3J4VQmc8jy0F3Qb3QNArVfOmcueAkUl9v7Uep1a2at5Y9Oe05Non7HxpInxDNN/SByfh/Fb6tpCRrazHjGe2JvtCyNsjTd9Lbtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879632; c=relaxed/simple;
	bh=o1To+1Rrkd8ilUPmx8bhFn0BFpxaEbTcLpyDdCbqVSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5okSGePPejLnpYNnYKj8pcct8i2zUxSxmhDoz2tIsOIQcBmuQkUwMJUaYtu0jrv47xjjQHItIzIo54loKEy4y2Z7xEIQnMSwRfdvmfpbs91cv14UFU5jDkT7yIiddO5HjOzvSzM035B72iwzzNe3ttQIfZJjZ1/rvXNyFlJb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzhz3RVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836D8C4CEE7;
	Thu, 22 May 2025 02:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879631;
	bh=o1To+1Rrkd8ilUPmx8bhFn0BFpxaEbTcLpyDdCbqVSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xzhz3RVl8QUDDq3WtqShxxvb7Wr/DkcgclHaKk7g5CH6qhwKLlr3cXS2py9mjA/IP
	 2nuhfSPERMPUPOjsEE+WvF7A77sR010evs+hmXyLfQNBQ7KXm7uZfxSnyTFlnxYfzA
	 WgRhczR6aJO+E6CnnFpD18r5ba0cWApIPIUAyrd+6iQhVzwbUZi9rl/ahdCa1+ekPf
	 /ss8kCFNBDakK4TxAUu7lhX3b6TyA+ys2uN5z0LnRFA4zqE58cRAa79HwSIpJKJqBB
	 dEQ0w23EDalXsAZQrJEFlM65p38+czxycNf5T+LEg1tQb5ZW4BDlDu53SOm+dXk+CW
	 j1d4p4U7u6WqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 26/26] af_unix: Fix uninit-value in __unix_walk_scc()
Date: Wed, 21 May 2025 22:07:07 -0400
Message-Id: <20250521185243-dfda1f06e4cfbc84@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-27-lee@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  927fa5b3e4f52 ! 1:  f5c052d475b26 af_unix: Fix uninit-value in __unix_walk_scc()
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
| stable/linux-6.12.y       |  Success    |  Success   |

