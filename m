Return-Path: <stable+bounces-144044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ACFAB46BB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3673B7041
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CE299A8B;
	Mon, 12 May 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra64J2vC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612A299A81
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086708; cv=none; b=A7K6dXHgyOfLT3dMdV3Y6zMT2lZhGz/AJ3YK+kO4EOdG/Mb0ZmrwhfcPleCiF/YYvelu0rFQRqc5hba92PwwsrEJyuCwpDj8p1XtNYGk1HcgbUq4afEywTw7L1jufqnPtBDQ6rcpSSA4SkXWhm61qt67uBV3R4+G8/WKYc3djfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086708; c=relaxed/simple;
	bh=vjfFYPDjG8+qeWCtjfJym1NI/znLPCbZclqRxO8L51g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpXglbm90dNIanrwoRfGNfeQOWe4ZMI7Nf69TvsoCcLBG/4+Aejr5hXiC79NDGb9x6wfh+16u3f0TlEaDNGr8KHiwNM8eyFf1bcPgiBm/AhP3id1qnLoCD0Na4Jw2Z0jme+8SaIoutpYO6YxcnyqR5B+OUP1XrST8mlLPaZoI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra64J2vC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8078BC4CEE7;
	Mon, 12 May 2025 21:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086708;
	bh=vjfFYPDjG8+qeWCtjfJym1NI/znLPCbZclqRxO8L51g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ra64J2vCxIoTk7D5VMFK+Ff+VIDYLFIouOoc7WEJ+4Uze6hT2PI3ynLW3UKe3ZQ8F
	 0VVRRVvp5vpZWo8WILrn2Jd7c4oW1SYQvzct5B1rJ6mBBTuSePC+2HZnmY7pfaKs7J
	 YhN/bt8HNnf2qCfScuPKw2IWqY+qeU84Fx9A+K+WTqJkOV5eR6M76MIm9RjrnojHxH
	 YKcMrD56/RKqcGj4nSR343C7X2UXFndPtOfDX7yBJhWBJB3qtWqPRdjEk1swPU4FYE
	 jZyRDkTbwrWyHXgXiEuY016t03CY/2Fo9+MCsjjchKpzUrO3DYFccvHKB9Ek5yymKB
	 P7rPjXqe2Ph4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] netfilter: nf_tables: fix memleak in map from abort path
Date: Mon, 12 May 2025 17:51:43 -0400
Message-Id: <20250512161557-69c9a4d0f972711c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512031019.3330707-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 86a1471d7cde792941109b93b558b5dc078b9ee9

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Pablo Neira Ayuso<pablo@netfilter.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a1bd2a38a1c6)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  86a1471d7cde7 < -:  ------------- netfilter: nf_tables: fix memleak in map from abort path
-:  ------------- > 1:  e9ad4dbb98c53 netfilter: nf_tables: fix memleak in map from abort path
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

