Return-Path: <stable+bounces-126954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A78A74ECD
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AB7A660D
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809ED1D8A0B;
	Fri, 28 Mar 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyZXUsmu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101D3C0C
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181389; cv=none; b=Hikpb2SV2OIDo/HJTg/j7QnRwBUQ07ptNQJXtxJrta7jjg5y4xr7Ke66zWviCZ21pyE+wjAA8nz70daZRv0HEdBfoKTETMjGQqybRn2ATPsHgADPlyQ8f4QuEMU1YPOXPOyifQiLOd7X5hAPo57El1aJqBc7WdZBtU4nNfIhQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181389; c=relaxed/simple;
	bh=41K97/7X+69s1xkqkaKrKO+J+owI9ODAA2Mar0GLTfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIJNYramunQS7tzAyVNyYGZ2YX1lj8uCEuCBvtZm6VhBNPhglKG91Yra/DcyGrnqZt2+WN1isC/jejVuGDYlnLjFUmOwchIglniYRaCJuyZTgJiQ3vfhhwoc8+pKraKdi8E8VGDw1zrPwvEVL1lgBx714Bp9QlAvqQOaURfNr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyZXUsmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52151C4CEE4;
	Fri, 28 Mar 2025 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181388;
	bh=41K97/7X+69s1xkqkaKrKO+J+owI9ODAA2Mar0GLTfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyZXUsmuT1yDTsZKjntyHnUHSIVa7Y0kGaRgenRC/xPs1VQhwSuQEpdluP/KccUnW
	 VuwbG8ZDX4GRPeSx1sn1Jd9w0E5quNpwcYakQw05zHLy24j3usDj8085vfaQCGS19p
	 R2fJqjnrcqx+/l0TTQD6izOEfR2YGNMtgT1yFJBjHW/Y3YUD7xB8GMl7zRhfolQYd3
	 2hFyWu9+KiK25C5rjK+uyh33nJKgTlSFAiGqARZRtaWmE/PARPhBOtow5QfFlE5R0g
	 9jVlMQvguUVyP0lsgtW78iuJUNhcnAb5pBkdDD58q2qqYVSoAXrYwDSE443IRmZt8S
	 Hu0/PrNxHGgNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Fri, 28 Mar 2025 13:03:07 -0400
Message-Id: <20250328121447-f4ced71d6419023c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250328091824.1646736-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 652cfeb43d6b9aba5c7c4902bed7a7340df131fb

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8c77398c7261)
6.1.y | Present (different SHA1: e99faa973596)

Note: The patch differs from the upstream commit:
---
1:  652cfeb43d6b9 < -:  ------------- fs/ntfs3: Fixed overflow check in mi_enum_attr()
-:  ------------- > 1:  8f6e53a6ae4e8 fs/ntfs3: Fixed overflow check in mi_enum_attr()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

