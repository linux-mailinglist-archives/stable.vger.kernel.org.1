Return-Path: <stable+bounces-105230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C03749F6F1C
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66687A40F2
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88614154BE2;
	Wed, 18 Dec 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDKTVR2M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8A16CD1D
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555663; cv=none; b=DcqMM9Rt5uQQCGWK/G3HJdIzSvFKjrmaucbMa/8yKuTzg4kUMHWeZJywUgRFDNrDO9dlEYGhIdGOCZA6geEn/z04MvYaCmZMHQKgWXnQAd/LkxHfitOjIgEGLFWJYcwAhgXQlfKfeLwiPNyxyA78SmFa89bprgZkdXkfdInQnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555663; c=relaxed/simple;
	bh=yCheYHjFavC088h1G/71HRZOfAs4VO7brypgXq/N5MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnfiVZvLG21E9JkB3sxEIDEnMFCde9NwtpwCdk4L7sHYZS4hSRgGfX22uk5wRqJJZxFxhuLVO+Vn34eZfGSdmAOTEYhp0r3uso2Qvf0Ysv/Mzq4+BLMx0UiIwJHmyEEHvFhGXBnX9NER+IL4bEFbg3HrVFL1Nf12cZlhmDH9HVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDKTVR2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C19C4CECD;
	Wed, 18 Dec 2024 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555662;
	bh=yCheYHjFavC088h1G/71HRZOfAs4VO7brypgXq/N5MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDKTVR2MWBNjfMEnGtLC1ep9xog91aomJ0cB+QDbHO4ckd/A9gCZO2epIFIg0P2lK
	 s7dJgTWUBBu4tzSCpDS3m0BClIate8LrUXdzmDHT4vqemmFP0eCb2Z89HIw4vvUsvu
	 wbIPf1WqNjTNFMFy3ZkBx8NjR/oZallqV+H+P2C/q42n8bsQ+FhpS9IS8Xe2E+Ub3K
	 IFTHBWFEB55BgGbhCbzAGAk1p9Fh6ZGYKeQVOFmvjSHK2t/MFlTDi7usYric6d+oZh
	 bD3I2cu++WF3Z8GxMFpjnqL1ZOddOpHX9gmj8yG+Uf4ZS1EecQyiZUSQKiIWezdsMX
	 ezbSo1wIgrMbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 01/17] xfs: fix the contact address for the sysfs ABI documentation
Date: Wed, 18 Dec 2024 16:01:00 -0500
Message-Id: <20241218144916-88beff1a6b59c80c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-2-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: 9ff4490e2ab364ec433f15668ef3f5edfb53feca

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Christoph Hellwig <hch@lst.de>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9ff4490e2ab3 ! 1:  a704d53779d9 xfs: fix the contact address for the sysfs ABI documentation
    @@ Metadata
      ## Commit message ##
         xfs: fix the contact address for the sysfs ABI documentation
     
    +    commit 9ff4490e2ab364ec433f15668ef3f5edfb53feca upstream.
    +
         oss.sgi.com is long dead, refer to the current linux-xfs list instead.
     
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## Documentation/ABI/testing/sysfs-fs-xfs ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

