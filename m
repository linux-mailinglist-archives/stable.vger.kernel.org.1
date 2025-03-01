Return-Path: <stable+bounces-119985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756DA4A878
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E06189AAAE
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FE192B82;
	Sat,  1 Mar 2025 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmFQ8PNc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5672C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802858; cv=none; b=uvd7+ojx1py6V/R7WEeJm34DxlXGRrBEWyd/9h9As3Ez4kHGqxS5fwWgup3VBLr/Wz0UeASkL6KyIf7iMHVoA3ZucYnQ4qgEE+Em43a1Rnp5WwMptrhfUh45Cfy+TNlK14y9sDdura36NqLRxF9lZU7HXed9gMh9xIJp2WT4z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802858; c=relaxed/simple;
	bh=WGTURwKh1EJwkSlSPAxGiAAWPzxXYTQpFtUXW1I0ISA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SG7zNH6wy6ukkMjRXM2ZIxZaKO4snTaIVBqlnJt5noKHyLkR9vQWINNspwhUMELPuLpkWWxRU+Z36F51+u/xnH4JgJnL02ZHQijtP5ageLYUNAp1IZvtxzw6sey+6SrXnsulGSjzjNk2N1iqRSnHp6mwqRIPVNBwrPaO4GHLf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmFQ8PNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29FCC4CEE2;
	Sat,  1 Mar 2025 04:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802858;
	bh=WGTURwKh1EJwkSlSPAxGiAAWPzxXYTQpFtUXW1I0ISA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmFQ8PNcFwKcl4IBfT7eqbOE4vAbi15p4udy9wcATm4dX8TqU8CGs/4mBGX745jph
	 oR4wlkIgD370Yg0cgMtGEzzpFt5YihJAbv1tHe69jcM3DBLpoksLCg3TC477WqSA/W
	 gwR5N+QUK/Y9kb2wnnkBkK+jYstrqea4zMDHQFM0J3NPv15+NhZ+W12QZ8Kin4c5Uq
	 E3S2UZ/XOLGRTj45qcoNDEMm+0d2dAFcwqP5yFcBafLYkQ2TVUHPy7iTpk+hw6wcOW
	 Hi61Czy0GcXEc7tnP8vHz7An39YNvO/C0t9hK2UEUH0Yel6azz63OLDMqMYAg2cTdf
	 B8OuPXIq7J8zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Panov <apanov@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 2/2] erofs: fix PSI memstall accounting
Date: Fri, 28 Feb 2025 23:20:35 -0500
Message-Id: <20250228185254-bfcc3535c1953e85@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228165103.26775-3-apanov@astralinux.ru>
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

The upstream commit SHA1 provided is correct: 1a2180f6859c73c674809f9f82e36c94084682ba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexey Panov<apanov@astralinux.ru>
Commit author: Gao Xiang<hsiangkao@linux.alibaba.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 0653fa6ee045)
6.6.y | Present (different SHA1: 14f030a807dd)

Note: The patch differs from the upstream commit:
---
1:  1a2180f6859c7 < -:  ------------- erofs: fix PSI memstall accounting
-:  ------------- > 1:  63f49db1d3fb4 erofs: fix PSI memstall accounting
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

