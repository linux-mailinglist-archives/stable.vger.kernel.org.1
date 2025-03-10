Return-Path: <stable+bounces-121645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1853A58A47
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD0168EC3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64018A6AE;
	Mon, 10 Mar 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUaFqMaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10A156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572867; cv=none; b=rVpsT9C3ArasZH2lidae+07mNK/BJcNtlixXhX1Gn0S+T21aYrGn31df/f0J8F/xCSpX+UVLOCgE0RWlCYTVXd7YqbwsNBd82CM1xRArhmcgy5p45SLajejoh9t7Pi1zUze2pRaee9zwSupDYhmWt0at0ZrAohQVx8ARTVitTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572867; c=relaxed/simple;
	bh=ygQsNzAOC5hQs4NGmBmURJyPgiX9x2QBef9AFLNdAuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMQJeLWQwMuREhLbUSMOSpDIVvm/B8MsDK5Uc4i8lfyEVcsR5dKV0RhEu5tQtKGcbKrdh42ve6ZYUvJ5poARkaf6tMpLmo/I+ZEsLm5r/XBoEJjX4w/lDmATrBz6WliJPTgARO3iHe9LSRiiOF2dvsdGpBOjKInu/MytY3P3Ibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUaFqMaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B46C4CEE3;
	Mon, 10 Mar 2025 02:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572867;
	bh=ygQsNzAOC5hQs4NGmBmURJyPgiX9x2QBef9AFLNdAuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUaFqMaRD4LpATqYzArCv49BSohGSLBlDjSRq+s9rnYDhI5RgX8z9cHoyb7cSXWtK
	 D0O8q4j/mkgrIniapS3Wx1KRmO0Znhi3sOoHc0+Z13nQNsxf+K9MwzbDe4CKpjYqOf
	 pquWeKz7jEeKwGxkr2LDMgP9P4Hr2rjItaFgWxEpfuZwMGSVy21HX1SMJiEZATJssL
	 ifvBLaKl6iERHEFcqKmcw2kMdqwtaO22X1yToyJ588rj0BraVfZUDfZXgYOHEHC+Yb
	 dzxU9k+seFTaSAZC/xp152106GBEDmXXuy56xw5WNGTyIAcetazpmNbvv/HQQafr0t
	 4CDUOpUKW3xcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	miguelgarciaroman8@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Sun,  9 Mar 2025 22:14:25 -0400
Message-Id: <20250309164632-9d60a7abc4aa9e9c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <Z82ruLLR+Z2ge3Vk@pop-os.localdomain>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 91a4b1ee78cb100b19b70f077c247f211110348f

WARNING: Author mismatch between patch and found commit:
Backport author: Miguel =?iso-8859-1?Q?Garc=EDa?=<miguelgarciaroman8@gmail.com>
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  91a4b1ee78cb1 < -:  ------------- fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
-:  ------------- > 1:  da31bbdbd8964 fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

