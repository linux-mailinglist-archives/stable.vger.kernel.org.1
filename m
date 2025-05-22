Return-Path: <stable+bounces-145996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D2AC0235
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672AE9E84CE
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB449443;
	Thu, 22 May 2025 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bszClCvO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794608BEC
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879648; cv=none; b=UGzUkm6OwIUOKtmUc/KbDWWwtTj4Wlv53bOPk9d5prAgh0lMlVDfBzOMK5FjGXd5XmrfPi6F6Af36h/cKOvYxgP3kSsQJv2vS7RCUMINMNELfrGiUTRebSsZgxsnz0dntn6yUEW7BeLindRMM/KouOnmj7DmXzg//QDwr+l3b78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879648; c=relaxed/simple;
	bh=Ppv/XGek3LeGtFj3/sB5bWcMDJMljP2ewstQyqPIl+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFV+z0FtkVQBPZD4AbLzjBmJryowIZnDpT576r3dqQ3UH+xfBF3kZt0QrJNTquY8hzr//ZKOUrzsAcsJxrj6LnPIuL7sE/5LxAhH7cW0K+zL0NuwQDh2cqYSqbyn4DOtetqkSJMIrHbQyZilVqRvh9f3v7KSMqyr2U+z8OSZjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bszClCvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F510C4CEE4;
	Thu, 22 May 2025 02:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879648;
	bh=Ppv/XGek3LeGtFj3/sB5bWcMDJMljP2ewstQyqPIl+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bszClCvOn6WwThYqPBy/aOeSiD9TNK2SA4Tf1uDpGGOBokUjIgGYMdxsmu0bpWQYT
	 8aMTq1hi600sIcIOVcAKS3ssSlBP6pyauW2K5gfM3EvCpZVtJcr9oBEiLi4OAYwcOr
	 pOijp5s3b9m2LIo3QfpLbCP6CTDWkAFN56GXpLmfHmlPEAmeWvUM1q87EEg4X9yP3r
	 RmMhvuQgwO+Zu7L7VyNqcYBDGzA2JMDlb2/ndKS+QXVEpAuqFI7QYQm21cdTZepC/u
	 rzUEDzD9wFpet/Z9t5oMNXt4HQ81N/wd2zZS+5JGdJnlMq/UvFxbM6uUPMuUhWroFR
	 YjqaELWuwixjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 22/26] af_unix: Try not to hold unix_gc_lock during accept().
Date: Wed, 21 May 2025 22:07:24 -0400
Message-Id: <20250521182608-55876aa62776fc7c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-23-lee@kernel.org>
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
ℹ️ This is part 22/26 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: fd86344823b521149bb31d91eba900ba3525efa6

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
1:  fd86344823b52 ! 1:  62abdb8ad3ff4 af_unix: Try not to hold unix_gc_lock during accept().
    @@ Metadata
      ## Commit message ##
         af_unix: Try not to hold unix_gc_lock during accept().
     
    +    [ Upstream commit fd86344823b521149bb31d91eba900ba3525efa6 ]
    +
         Commit dcf70df2048d ("af_unix: Fix up unix_edge.successor for embryo
         socket.") added spin_lock(&unix_gc_lock) in accept() path, and it
         caused regression in a stress test as reported by kernel test robot.
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240413021928.20946-1-kuniyu@amazon.com
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit fd86344823b521149bb31d91eba900ba3525efa6)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_skb_parms {
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

