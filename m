Return-Path: <stable+bounces-120384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B075A4EFF0
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 23:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFABC188F397
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2024EAA8;
	Tue,  4 Mar 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbBkFbMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8C1FBC98
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126435; cv=none; b=Xn5QSztPjxIKtDcsGNostXPCvr3bO3/yHq5dLp/NF8WdgAZuc5Y8i6Y2rD1U7kdKqZoiLdma3tibtB905vE/hLgaJKqVBy9PCbrp5lLigAlvGwi/fC++6x4VfJK1+9OCVFHPTHf/UQOTw4lpCReV/tCziKc6IInaSbkW9Lv+VlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126435; c=relaxed/simple;
	bh=U52b81e1RAPvO26CJs9geDI4MfVBzyqTyrNmPpEfQSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNegA7YIcVrbrBK18tiiKrZF9EgoV68J5Z1BoHrM0WGoDLAPSHaidDI5e3T9duDemu+jYf8egf8fB5UZfFjfhQAkZkc4odnOgufLUc/vqBr8wsy1R2usizSunKuYC+OLmKA5N6VYf4cUti51kGKwLo6p4uDTW8nvfLHFErNp+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbBkFbMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35569C4CEE5;
	Tue,  4 Mar 2025 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741126434;
	bh=U52b81e1RAPvO26CJs9geDI4MfVBzyqTyrNmPpEfQSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbBkFbMtpDUgcwdvi/EyRCDWy80+14saSYOHkSFcfBCVfjxqBxpCmReixu/OsWv+x
	 WwDEU+2ljBJnRB7KXx2pbRGvKZtw90yTK+BapPUrxw+8v7eEc3wWNndlMeG3qGivMV
	 JQVENC3qK/2OYK0zDgDalkL4hyWhET27UyIcJ+C1nmMYc9V0e2xe+sZlLc49QZl9rg
	 l4lKGclvVIRWRS7FdaEFWLyXfwIhvOAW86fj5SRzFZ7d2jUyQ85aFYiYQ9AZIcajDY
	 QuDCOA42sU5b+HgzNncMYQV5GuL7pFcIyXcXbTTMM8efBcFLGExokR0PyNjgORaqKm
	 jCsteoP6vKeQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kuniyu@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in scan_inflight().
Date: Tue,  4 Mar 2025 17:13:52 -0500
Message-Id: <20250304142915-28afde2108e0471d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250304030149.82265-1-kuniyu@amazon.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

