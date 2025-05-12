Return-Path: <stable+bounces-143846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E513AB420C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3760188AA4F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57652BD916;
	Mon, 12 May 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAXr830s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CD2BD90B
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073119; cv=none; b=gawrHPaqP3u0tBi1ZdvxpRVbuPqG0qv5wy8a5hhltGnqW7czLXiCgXHZRi7XSvGrqNX/cIrsGI4GjbkDehBCfkqOKxHrSCNoQtUaFbT8ARrFTRoMdJp25bPidcle2KmM/p4kKJ77lXCfrDOClKR3Rpo7T6u7tG8XHFgCa1NWKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073119; c=relaxed/simple;
	bh=jdn4uvfrhUBuyN3RiV+1EXHOXALP/6I9NfOrVZzp+nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAL4gnGTk0YDH9W3ibHwji/RMRj9Vzp2q33pRwifiRFuPtGoRDicOyeID49fHEQOGHS4AEis7pGRogH8mJiQ/P53KA+eTyZO789ZKFRsyHiOkZI8qVOiMFCMsLpjwOPeqXQfMHGKE0EdWb/uRGTxJvKrrZMApSdXfS84ma8rDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAXr830s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757CBC4CEE7;
	Mon, 12 May 2025 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073118;
	bh=jdn4uvfrhUBuyN3RiV+1EXHOXALP/6I9NfOrVZzp+nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAXr830s4UfQMMrKSwz/jTBEVzFATDZblBYJt1pxTxUlfndbxeqWoHjT6TfIeOhWU
	 3LZdMo1ECi4s6HIGdq2iHuc5bWzCdMUZaD9tF2nYyBqyvT8zyqf1jsIBS/gOnAQSaU
	 uEBj0tKGF7zNe41Nrr7MTyzNLZZXpM96D5OJLB47kWFep0U+2MERy3m3fVwFM5U80f
	 l+1EfumT/wNMjHXwtPxxC7w3sR/cZeun7PNfBu7Zyk3IOr8Y25dnj290vQPxFvODWX
	 eTHOCsE0tNtpRsTZGP2u1akk0OY8oduzSwtPhcfijHxfQm2Iaj6g8FcLOmATDMnyXY
	 6kLNv0ejMcMaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Mon, 12 May 2025 14:05:14 -0400
Message-Id: <20250511225440-97b4ddec047a0297@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509061740.441812-2-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: b0e525d7a22ea350e75e2aec22e47fcfafa4cacd

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: GONG Ruiqi<gongruiqi1@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 976544bdb40a)
6.6.y | Present (different SHA1: e8336d3c9ab7)

Note: The patch differs from the upstream commit:
---
1:  b0e525d7a22ea < -:  ------------- usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
-:  ------------- > 1:  3f0ebfaf79640 usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

