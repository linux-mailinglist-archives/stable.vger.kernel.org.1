Return-Path: <stable+bounces-98222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCD49E3278
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2B4284293
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E917156997;
	Wed,  4 Dec 2024 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbWnLyu3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B414A4E9
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284531; cv=none; b=mneiV17+OO9zLnJEPxjRCajiEADwCVePk3DGRTP1fXvGRoOaHVwiewiKUTfa6EZdEs+L9uDYxJXXoqNuwt5un6+2+nMnFgm/hun0MKaoM5CItt56SvQjYKEQRa9PwmmyXAZORKCqa5V+U25+/I42AoNoLCsroOEhil2tsa/GrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284531; c=relaxed/simple;
	bh=EGXxR5SXL+S42X/nxAV5+cXWmDR+N0U20++0fjhx7U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os0I0TiDCSjS2FpenReE2Qrspme3UUjfB7rcc1ZuQbehTefkaWlzqNwmPHiMpebTbZJaTUtEXOvbRjyMdAv0nyEV1AwSWOBcgTmwVXjtxWcbZ3Geey4ailWSuen8y/IgdEzfwhr9BSZZ0fFvG9L5v9yF55t89j4V12JPCA/k2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbWnLyu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069B1C4CED1;
	Wed,  4 Dec 2024 03:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733284530;
	bh=EGXxR5SXL+S42X/nxAV5+cXWmDR+N0U20++0fjhx7U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PbWnLyu3DDWesygXXMUzKo3xiVSH8QvMjCpPf02Pf0QoCn2nD1YmDNocWbS+VHpeW
	 3WfUAMbazF4yJxVX2I9C7xx4XdM9lA5zGKEtTAtybvcEGnc4EmS1QH5iaPIyk9aBAs
	 zBSF6fiIrqGf2tOVDkgaWvVLHCKK9l3Wjkcy2/qxp66/JOwfWzh5SblV4ToSzXE9FL
	 eEZ4oahoKl77gPm5sEgvRK3QNCWfbvn+8zxSAkxMnjKtplPOCm5IXhd8zGq0MKcu6j
	 cFAzVotq+i+yPJhOvWUY+l0yo1F4FxQA48UpTfc9Xu5Rsak/MRAufDYU/AhQ61NTtv
	 AQRYmzOzxSYPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Tue,  3 Dec 2024 21:44:10 -0500
Message-ID: <20241203213832-611194989a871870@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204032913.1456610-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 652cfeb43d6b9aba5c7c4902bed7a7340df131fb

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8c77398c7261)
6.1.y | Present (different SHA1: 7cfa8ae94ffa)

Note: The patch differs from the upstream commit:
---
1:  652cfeb43d6b9 ! 1:  310681bc6d92e fs/ntfs3: Fixed overflow check in mi_enum_attr()
    @@ Metadata
      ## Commit message ##
         fs/ntfs3: Fixed overflow check in mi_enum_attr()
     
    +    [ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]
    +
         Reported-by: Robert Morris <rtm@csail.mit.edu>
         Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Jianqi.ren.cn@windriver.com <jianqi.ren.cn@windriver.com>
     
      ## fs/ntfs3/record.c ##
     @@ fs/ntfs3/record.c: struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
    @@ fs/ntfs3/record.c: struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTR
     +		if (le32_to_cpu(attr->res.data_size) > asize - t16)
      			return NULL;
      
    - 		t32 = sizeof(short) * attr->name_len;
    + 		if (attr->name_len &&
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

