Return-Path: <stable+bounces-105234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3D59F6F1F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195C216DFFF
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF631ACEB9;
	Wed, 18 Dec 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKtgpHoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3015697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555671; cv=none; b=DOlQdrPpgTAcTjnhy1pxcwJj4bvnWKBBOGVKRiAcITgxKem0s0MY1HU5KAbfJRh5N47glUyMPebv9Qzl4cvva5sQ1frSMHvIgDKStSV/8Togjoj0ZAsWCUIS/V4Yg95NCZC+aFNUPfBZaFNTryWQ+KdLYySlqcKPwzB/icIvIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555671; c=relaxed/simple;
	bh=tp6hk0Hp7a/+hqLNcbqjFYgE+MBczNESZgZGWQYrC+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Buj9/qIH1Q8O6KsFZO6XfMOhRRvCzX5B9/PdmATUQkp6hxUhFaIs/3bsQ3z7kLyuwPejpA1Tp0j8nEcEFyhvKiFS65EnG1AG8KX70Rq6zzigh4+3FgxCXXXP0UCxsZFzQuyiu7oUjY3XOLOB0elLiNT45p1TodyEJD+VAWUGauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKtgpHoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E5AC4CED7;
	Wed, 18 Dec 2024 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555671;
	bh=tp6hk0Hp7a/+hqLNcbqjFYgE+MBczNESZgZGWQYrC+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKtgpHoNHX7RIwuB5h0q7/pTO93AJGqpF8B+xbsnwzLwETKdT5u7DbSx3LrzgbX7P
	 QTRGllkpnKGOVe1ZcP2oSQvZteUjwIuoaIPoMjBCkNrh3/lqCadEQ5lJaBSqQSavau
	 /kw8frYpWnxNIoR2lK2mnblYDgca/dhrXzeZv/uErRzGCO+eJIgegKvuGcKnn0KAXT
	 dWwWeDeLg3A63YEya/Lc828aYv/NLO/UoVuWLno9JKZWUqo253VMoF7dbbPN4g1m5U
	 vShpg+dYw8vYvAmLl36Gad3ET6NgQLLG9xJP/t5EAtSFIaq2ZDmFVtzIZSsFsXKVtq
	 rJa0Z+Q2HfmqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 04/17] xfs: declare xfs_file.c symbols in xfs_file.h
Date: Wed, 18 Dec 2024 16:01:09 -0500
Message-Id: <20241218151632-00e90c9b12643e24@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-5-catherine.hoang@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 00acb28d96746f78389f23a7b5309a917b45c12f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Darrick J. Wong <djwong@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  00acb28d9674 ! 1:  df97eac7fc84 xfs: declare xfs_file.c symbols in xfs_file.h
    @@ Metadata
      ## Commit message ##
         xfs: declare xfs_file.c symbols in xfs_file.h
     
    +    commit 00acb28d96746f78389f23a7b5309a917b45c12f upstream.
    +
    +    [backport: dependency of d3b689d and f23660f]
    +
         Move the two public symbols in xfs_file.c to xfs_file.h.  We're about to
         add more public symbols in that source file, so let's finally create the
         header file.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/xfs_file.c ##
     @@
    @@ fs/xfs/xfs_file.h (new)
     
      ## fs/xfs/xfs_ioctl.c ##
     @@
    + #include "xfs_reflink.h"
      #include "xfs_ioctl.h"
      #include "xfs_xattr.h"
    - #include "xfs_rtbitmap.h"
     +#include "xfs_file.h"
      
      #include <linux/mount.h>
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

