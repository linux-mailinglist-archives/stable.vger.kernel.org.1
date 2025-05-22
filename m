Return-Path: <stable+bounces-145987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8FAC0228
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B739E2836
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225BB35977;
	Thu, 22 May 2025 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDugdgo6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0E2B9B7
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879574; cv=none; b=MnQgGpMU9tu/kqLv1C9H9xdYU7ayVELqhJ1V4LfL4J42vzR/A2CjIs0eDYT+4ER29Hlxe40zJhoWOYmYZADDFbEf1nJTTqIPvhX88aRifwwj9HReqo5FmlqNatKZ+123PEsbUeAGNMYeJc7mVTMgyHYRkH1IaV5zTJkNfzzigMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879574; c=relaxed/simple;
	bh=i6DeJwn/SO818GhDAJksxjOpMUBf/x42nCRWek3ySBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uT9W5Wvx6qmz57obmBzNXuewdzeTatDb4kveAOZt6i65ypwPh6TFr3AjeX6j4QL0uLn9pMnVzTWyeG3LcYHVs3nkKUT79KF1ngNkPEIxewRtL2bUuMAp8e65LPeh76d5HlMQZyEngaiEhjvr5OgFoQg+Uh8MZP/OaOueFQt4J4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDugdgo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6504C4CEE4;
	Thu, 22 May 2025 02:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879574;
	bh=i6DeJwn/SO818GhDAJksxjOpMUBf/x42nCRWek3ySBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDugdgo6TYl/2oGg6ZXuwKZnXkhWxP1D+ExClaDqRyYpqh1iGO5w31Zn1QkjxloY0
	 humCEKn9VhWTPNxy6gWZf0LJBAaTtMU6K/PrLuU0nsWN3IjlOE3reM9weFGYXsjijl
	 hR+PYDdzJHzqvFBNivyvuSjfF6wUenVI9PYgGPxz9axbwk5SAY1IpvCp1QSXASqNhn
	 D+6yZFmoZ5SvdZs7hiSVf+wWryZTzJtPpUbSXskOdtQCMGULs0VWx+N98e7jDT6QRx
	 uOVG3NG5ijoQXf75jNFGzitImz9tkk/dMZVVHQ8tIYezMtzk8LAqeM7xs60cqudxL9
	 9iGHnWikmBlrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 12/26] af_unix: Detect Strongly Connected Components.
Date: Wed, 21 May 2025 22:06:10 -0400
Message-Id: <20250521173923-5c707b6b7b07c65e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-13-lee@kernel.org>
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
ℹ️ This is part 12/26 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 3484f063172dd88776b062046d721d7c2ae1af7c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Found fixes commits:
927fa5b3e4f5 af_unix: Fix uninit-value in __unix_walk_scc()

Note: The patch differs from the upstream commit:
---
1:  3484f063172dd ! 1:  e7604510bcc93 af_unix: Detect Strongly Connected Components.
    @@ Metadata
      ## Commit message ##
         af_unix: Detect Strongly Connected Components.
     
    +    [ Upstream commit 3484f063172dd88776b062046d721d7c2ae1af7c ]
    +
         In the new GC, we use a simple graph algorithm, Tarjan's Strongly
         Connected Components (SCC) algorithm, to find cyclic references.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-7-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 3484f063172dd88776b062046d721d7c2ae1af7c)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: void wait_for_unix_gc(struct scm_fp_list *fpl);
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

