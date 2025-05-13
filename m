Return-Path: <stable+bounces-144220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C7CAB5CA3
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F220719E7516
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974B1F12F4;
	Tue, 13 May 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElClIBQ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3D748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162102; cv=none; b=Zx92DjEJZjfL5PMReeMq9kfxLB2DUs9Gj19DL8WKiA6UAKEhZYj/NeUYPDaxdAseijQxFJhUNOhYPjuYWkHaDd7JRyU2rcHy5QpSt9XO8BRHpZGe67BznGlS8SkR3k9X4jUbUDxwfijOLdPGTiJt8cvwK87d33bbFM0plBK07Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162102; c=relaxed/simple;
	bh=CIa50uvKtGs+SgLDt8Od5tbnlZjhPt3EEbQiIp2urX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZIGNlXkJ/8rPGkB4m24QNBvzJf4HyTUCoHmXZutcF3fASv/nNgcB0rqeI8Vb+7LTpQb9d84+0UNjYdBwcDpf5GBhyU97QSvrdA5wC6LUVUQSPcGtRyEliGNB1EmXWbxgv0FO6D9nnG/f3omAxt5cZ7ckj2HmTBwyXsUuk0gxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElClIBQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6BAC4CEE4;
	Tue, 13 May 2025 18:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162102;
	bh=CIa50uvKtGs+SgLDt8Od5tbnlZjhPt3EEbQiIp2urX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElClIBQ1Demem4JJ4XIMkFo0/9168Ll2zQqH6k3eI8XrdbcFIS3ZIsN2ew18VI/1R
	 FAzggjlTAPl8+X/LRrGqz8jiifuilQdbeToqB+uHOO5H6ZRxG4I5a+Udq1Jn7FjMDN
	 GbLiTccI1Xv3nXCNbuKCb8ete3TbbB6EiNU+Rcq1hQhuzPLiPJkI9j8F/4H88nHLXW
	 b19mWEceWxySyI7gxIx295rb0EW4ZqsNVaMkXael1le2bGgSLM0wtSvCpqZVKCcmr2
	 4bp2HajdowqQHR5+W7pkcYYneTBtWL/0A/B76IqkYOUzZrzlpsqYN3so3tAfF1PF9L
	 v52YTkE1h8GCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] selftests/mm: compaction_test: support platform with huge mount of memory
Date: Tue, 13 May 2025 14:48:18 -0400
Message-Id: <20250513110922-bc9f3be180787f14@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513024458.20469-1-feng.tang@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: ab00ddd802f80e31fc9639c652d736fe3913feae

Status in newer kernel trees:
6.14.y | Present (different SHA1: cc09dec6cce3)
6.12.y | Present (different SHA1: 72669f82feb1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ab00ddd802f80 < -:  ------------- selftests/mm: compaction_test: support platform with huge mount of memory
-:  ------------- > 1:  85a1d33a0ea39 selftests/mm: compaction_test: support platform with huge mount of memory
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

