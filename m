Return-Path: <stable+bounces-135174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA5A97545
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2743B5DE5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A51298985;
	Tue, 22 Apr 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgaHs6YR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A302989B1
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349458; cv=none; b=EkY59b/mU/f6dZRmp91gOoVb3LNkUB4tVPOcF+8IAYHGLQFC9JRw8keHxPb73RD7NoECgXoW2afLWK4to/jesVGwUJvSz25VSZn/wO/JkK81FhyjdrRK/PcOYlANfY9NqprI0owQMwcL5s+DOejWUszj/9Qrif7ynoLR+psY9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349458; c=relaxed/simple;
	bh=XWzaH3fMZPGAmLmMX2N+/Fz637fl1hR8IRX4MwyluEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWHJMKz2ttrDiK6uzulLnwPwm9wFQ5J33USv00UTKblArNGSqQahWa1Tp6KNAvYmN17dctB/Lf5st1+5Ka8Q6VKC1jzoraRoAXC/PcpUiqqmlDl2Q1ejQYwY2ePl0EP22V6lph48Ad376lVOyInfRKrxedXAecdWQZ8X68mLuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgaHs6YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA7BC4CEED;
	Tue, 22 Apr 2025 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349457;
	bh=XWzaH3fMZPGAmLmMX2N+/Fz637fl1hR8IRX4MwyluEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgaHs6YR50CGrphG1pq4B1LB+HCBVVDr7qqliCa+xcjvyGRfoJd/w37wKPCi/s2DV
	 mhlrTmgFuez8aRWW0hZAF1ZfFc6jt7IyZzx34oMDIYyUF67sGoUhU60noBzFUZGMDf
	 iutQo9l8RWSSwQNdxZtJGGOvpb6u0va+KIlwEECt+wgSX5xaLdlPIiu2BDITao8M5g
	 FegAu0DhIJGTmVQWLDrdiT0XHMKA9X7WsiZKR40Pbt4eC0DlB5WNdk+fg05CykQPo7
	 UcQArzF36XcBywPG/gYznRTLHDElLKWtnpJ//yW5YBDiVSfL8aRKYGh0ai1rxRtvL5
	 864JCGoovbfxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 V4 2/3] sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
Date: Tue, 22 Apr 2025 15:17:34 -0400
Message-Id: <20250422132948-bc1fa15ea9ad334f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422123135.1784083-3-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 467d60eddf55588add232feda325da7215ddaf30

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  467d60eddf555 ! 1:  35ac08f1b8907 sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
    @@ Metadata
      ## Commit message ##
         sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
     
    +    commit 467d60eddf55588add232feda325da7215ddaf30 upstream.
    +
         ERR_get_error_line() is deprecated since OpenSSL 3.0.
     
         Use ERR_peek_error_line() instead, and combine display_openssl_errors()
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## certs/extract-cert.c ##
     @@ certs/extract-cert.c: int main(int argc, char **argv)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

