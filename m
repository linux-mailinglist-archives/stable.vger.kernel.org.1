Return-Path: <stable+bounces-104194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA99F1F4A
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 15:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8381888EB8
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BAC1922DC;
	Sat, 14 Dec 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIACt5hi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D26169397
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186391; cv=none; b=jNIdW/xJkK5Ku7g7wvF1cXc2AeZfXMf4JXhD5jZWYUyLonog+rWIdL6oUFhldhyj4tu2nOOD+W6ScGuwYYSJGCdtd6aUlyUC6NwaCjcMgbFaMwSqTUu5woUjAbeeIwSfzjk/+OJ7XL7lsZxZ67cs6szCMQJuNfUBCgKdlY+frKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186391; c=relaxed/simple;
	bh=fBLKRj4eKFRzwpnjXBikJouyM2xwEZObFWH2i/MmYRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+itBntWg/kTVU6DWPq25f2WPxOgvxMNVJVV+lrTSLgunQy2Vi0hfSQD4RCsYjAP0Zg5V0NsETDNvsVZVUVOOBsO1auQsjFPtsodlOWDQKOuKIvEIMwXeeC6q2vHf7vPKp+va1qC0ip9v20dK4QdzfO1ugKW0fKGmN738/kFNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIACt5hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD3FC4CED1;
	Sat, 14 Dec 2024 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734186390;
	bh=fBLKRj4eKFRzwpnjXBikJouyM2xwEZObFWH2i/MmYRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIACt5hiVzFls/7kHigJNPXx9uPZSC/pqfaR2MZGpAmAWDqyy/xTnRjbQR8HayUsC
	 AvWSLP2WwD5KkCMkpm3iIuzPoSD+DAHXbxGP4glLx9zK+wS9oEFR/xPGobTs/kiGHi
	 xYK3ZdVbqOJ32OnR6trK0clzlAEzEo2So4QLLY1oy+AQ5Y6tTs/Pi+HyOp42u2fuTi
	 LRY4c4tmU0vunFRZCovBfHL4AO1DzW9kw9y12DFgpNrAVjdOug9Qo2DHyIf/McQu7u
	 OT6DIWGtLpa1Ae/3N/6zZamvEG7SPa4DiqF/298ln8NyYc9dyMRhgyvM1aKIC6ItD5
	 HLxPENBcL2rXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sherry Yang <sherry.yang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y, 5.10.y] exfat: fix potential deadlock on __exfat_get_dentry_set
Date: Sat, 14 Dec 2024 09:26:28 -0500
Message-Id: <20241214091651-0af6196918c18d20@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241213235705.2201714-1-sherry.yang@oracle.com>
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

The upstream commit SHA1 provided is correct: 89fc548767a2155231128cb98726d6d2ea1256c9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sherry Yang <sherry.yang@oracle.com>
Commit author: Sungjong Seo <sj1557.seo@samsung.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a7ac198f8dba)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  89fc548767a2 < -:  ------------ exfat: fix potential deadlock on __exfat_get_dentry_set
-:  ------------ > 1:  9b4fc692990f exfat: fix potential deadlock on __exfat_get_dentry_set
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    

Build error for stable/linux-5.10.y:
    make: *** No rule to make target 'allmodconfig'.  Stop.
    make: *** No targets specified and no makefile found.  Stop.

