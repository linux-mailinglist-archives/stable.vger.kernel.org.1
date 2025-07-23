Return-Path: <stable+bounces-164376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93174B0E9A1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0346C66F8
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008EC188CC9;
	Wed, 23 Jul 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL5GP6dq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3906149C7B
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245246; cv=none; b=tkdczUmwJE+LPO1h4WyUB3X8ChvxnKZE/9Pd1wDZQqphBpyzvq7UnR4Pe3l/ZINYwCQYX5HXMcyEpzIQVt0lRt09rQnH28y7oJqiUlE7O9zbfaakXWH18KRcmYQbx77hfkkCx1LS6G8bRlBtYLQQXg8btz1y9s62BuFNcmp2nEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245246; c=relaxed/simple;
	bh=YSEopXR89NBPh6cHlEgOTpWFtFTObnLQjmjTHeeYvnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMuJZG9THJedH20i3VuHa04MYfm1ep0vrAgIroJni8OL3hQiuFfnfMUTjexUyW7q0EDsnEiy0Ap1zYG7cbgb6b2EgJRfWZS6kd0/300n89zKepMs/ESujuy+h685azncE0a+7u1lUBIJUh3fRPvgXPXDBf5YEYaXzIi7xTWgLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL5GP6dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039C8C4CEE7;
	Wed, 23 Jul 2025 04:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245246;
	bh=YSEopXR89NBPh6cHlEgOTpWFtFTObnLQjmjTHeeYvnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL5GP6dqjklhgQIm7LPHbVGxpjLVju+8H9ycZMkDoOKwEXC0Cze4XRePdOK9SUfYj
	 nP7bivrD1Kb9VRvrd5iqudriIRM6h/uSSaNhKRLp/iB53fz3kjOUISJrT/d4uODHUe
	 g7Phi9LJ1u+Pvw3jhXO5qm0rkDkW0MBs9mrRNrsHSijqpmjhb2JVioeQZ3OTcI4iCx
	 Nxy01z+1pLIUnBXEmzLm2bZL3kmun5i/J/sjMzSUJbzLPwD2iVN1bvvqI3+Uh9JwnD
	 DmGqupmgSFuYcCiKay6yqX1Br2Rn3fdEaeH/emKs9kmC3Us4mxMuo6viiXSWrMrrK+
	 o7dcQTmUsWPnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/5] erofs: sunset erofs_dbg()
Date: Wed, 23 Jul 2025 00:34:04 -0400
Message-Id: <1753229137-64ac7036@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722100029.3052177-3-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 10656f9ca60ed85f4cfc06bcbe1f240ee310fa8c

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  10656f9ca60e ! 1:  490c3ffa300c erofs: sunset erofs_dbg()
    @@ Metadata
      ## Commit message ##
         erofs: sunset erofs_dbg()
     
    +    commit 10656f9ca60ed85f4cfc06bcbe1f240ee310fa8c upstream.
    +
         Such debug messages are rarely used now.  Let's get rid of these,
         and revert locally if they are needed for debugging.
     

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

