Return-Path: <stable+bounces-146000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED0EAC0239
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CA71890500
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA593F9FB;
	Thu, 22 May 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGsVgkmf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED07539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879662; cv=none; b=IbNrcK+Jfqi9MZvplhpVRgM/6ZmHDXfnR4SrCaym5inYSEx6pJQPIBnHOFj/KDInk4nry0s+DCyTJgdgNiklWitKLQEX2hqiqyKXrcDH1yxRocMoIVtOzVVnnWjpoFv3ZaWbRW+XA4zQSnPogT73AmfhHcmdiiNjnsKIZ900KMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879662; c=relaxed/simple;
	bh=7iBwzblathlMLRMRyp0egMKVlzsdsaFlWv/xnzyecU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lehcK1aH6/SnoN0OlXkSsTnBFNjrPNMfwYjNBrqwYaBkO5D4AylewJUeWOuwG+cCcbdogtO1ayGjGOL4NVu9TcyNORwezTKTu2nJVZAI4ClxCXOovYJeque16xFztKyVguBsijrkxdK/olbvQM86fskfnHMscn2wtFDKPspQM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGsVgkmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F46C4CEE4;
	Thu, 22 May 2025 02:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879662;
	bh=7iBwzblathlMLRMRyp0egMKVlzsdsaFlWv/xnzyecU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGsVgkmfU5Qy70x1mP/735pMImkCZHHT9t9mXn6MLl2qetFp1M4BZR1tJAVJLLARQ
	 agI1XQUxab4/6pI3jLTlUwNAGOYx61mtXxETcErfp3o0oYmqRZBT/XxRThiHSPpHfO
	 jS5tsc0c+7XyqE/7mag6xOj+R+wzd96yiypte3CGfPMQay3s5aUqwN9Iqqw/iGJt0T
	 o6Yvbb3uu/HkeN8k7JJud5SZAlUIEVynAfv7lWobce8TzO7nE1ay8OALM/ut6wYo2a
	 /0M0zfM6qsW8B5iOdnjdWNB9+yS2u1fSDFSaZKAjNfE8FuhiXLvdDLFpGcX2IjdS6k
	 1iq2vZ3rSs7sQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 16/26] af_unix: Skip GC if no cycle exists.
Date: Wed, 21 May 2025 22:07:38 -0400
Message-Id: <20250521175943-416478c0c229d520@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-17-lee@kernel.org>
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

Summary of potential issues:
ℹ️ This is part 16/26 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 77e5593aebba823bcbcf2c4b58b07efcd63933b8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Found fixes commits:
1af2dface5d2 af_unix: Don't access successor in unix_del_edges() during GC.

Note: The patch differs from the upstream commit:
---
1:  77e5593aebba8 ! 1:  7a31b6c2f5f1e af_unix: Skip GC if no cycle exists.
    @@ Metadata
      ## Commit message ##
         af_unix: Skip GC if no cycle exists.
     
    +    [ Upstream commit 77e5593aebba823bcbcf2c4b58b07efcd63933b8 ]
    +
         We do not need to run GC if there is no possible cyclic reference.
         We use unix_graph_maybe_cyclic to decide if we should run GC.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-11-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 77e5593aebba823bcbcf2c4b58b07efcd63933b8)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

