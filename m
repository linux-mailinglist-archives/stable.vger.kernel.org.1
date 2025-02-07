Return-Path: <stable+bounces-114343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE10A2D108
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA27188F603
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685511C68A6;
	Fri,  7 Feb 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWzKvOhJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FA1B4223
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968695; cv=none; b=kiI6p4sP3V/D3U5s7K4jpNl+9K0OShjmZSdBRWB8jOvZACc0E70L+6HXBVybFmrFKv9MfW0WOIlQryWsfRG2iMlqnHHBoQET13Sl7swZDl6ZCVY19HzH7um0CLStL7y9teMIkM8GLZrRFFmbfpC4z/oufHORNVf7E9SAY83Prxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968695; c=relaxed/simple;
	bh=qT8qLCu4Zjlt7fmNZ+CXTUM3LmfvvvO93vwEyYnutYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVb46ZGwhR+JuKhAd0iHPMbK2/SwG9UUvaM/a9ycjO7RcKhdxBviOAsIwXAWFERBQ/FxWoUjHTkcAeq9lnFvTESWcGDpY9FvGEE8do+m4C3wGF175IWjGuUCL5ifHb8G1+wabD6fiHXlG3JbBa3U66djt2JELnyYtZk1y11ljJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWzKvOhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F45C4CED1;
	Fri,  7 Feb 2025 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968695;
	bh=qT8qLCu4Zjlt7fmNZ+CXTUM3LmfvvvO93vwEyYnutYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWzKvOhJ//iGj6PuIhjvhJq1NTJQclgMAcBrzJmFnu1VkFjP5/WsdJWgudTSvKqY5
	 L7/vHRRfiYTIaIjqGxySLyJkYlzvadYJQQ5+wP0caz2FkMpAqPa3vV3IFAzGAlR2jO
	 q6xi6RmxvjSQGgPqat+AMA+3an5NFqI8ZtQsKw3zFsddlaAT0Vrri6AJ6ONCftDnFP
	 tFBKBqiIJTft7ZmcIZ5WD5YLZsedE7jtVMmFw016MIox2t1SMEenuRQPg2u5/V+VOl
	 3pLAAVEsJFpcT+Da76AiKnak591s0bCV3gbtQZCUSdjSNkqpt0cBUJjDz268uZxgXO
	 GS+ynoPWagZGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 01/24] xfs: assert a valid limit in xfs_rtfind_forw
Date: Fri,  7 Feb 2025 17:51:33 -0500
Message-Id: <20250207170426-8f47cbd78f9df653@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250205214025.72516-2-catherine.hoang@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 6d2db12d56a389b3e8efa236976f8=
dc3a8ae00f0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang<catherine.hoang@oracle.com>
Commit author: Christoph Hellwig<hch@lst.de>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6d2db12d56a38 ! 1:  89e660ba4da80 xfs: assert a valid limit in xfs_rtfi=
nd_forw
    @@ Metadata
      ## Commit message ##
         xfs: assert a valid limit in xfs_rtfind_forw
=20=20=20=20=20
    +    commit 6d2db12d56a389b3e8efa236976f8dc3a8ae00f0 upstream.
    +
         Protect against developers passing stupid limits when refactoring =
the
         RT code once again.
=20=20=20=20=20
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
=20=20=20=20=20
      ## fs/xfs/libxfs/xfs_rtbitmap.c ##
     @@ fs/xfs/libxfs/xfs_rtbitmap.c: xfs_rtfind_forw(
    - 	xfs_rtword_t		incore;
    - 	unsigned int		word;	/* word number in the buffer */
    + 	xfs_rtword_t	wdiff;		/* difference from wanted value */
    + 	int		word;		/* word number in the buffer */
=20=20=20=20=20=20
     +	ASSERT(start <=3D limit);
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

