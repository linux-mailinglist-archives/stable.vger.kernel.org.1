Return-Path: <stable+bounces-144669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0EABAA2D
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737151B63975
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237F1F4717;
	Sat, 17 May 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKsO14RX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE835979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487282; cv=none; b=A6SVjutApidzax6Q0lbxJtH5FW3U3Fv+xZYZo2rBw3I5fR+koeJmYb0USAJntkx96+N0qUqhOwHTfRZ3uEsImH81Y0X3ZvlQYWwU8tFtd9jaoRykLTTT1uaZX7DNfGg2rIKbUQdM4ImtVHE6QNOJPo3yftYL0GV/HTa9V7aG1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487282; c=relaxed/simple;
	bh=OA03KwPdRJDq8IqEjYIz2ffN9NP6+p2bV+s7h5D87DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaykezJ8kYXcMDLVl3wvrasATa09FFqQSS2QKpnp2ldTmSbSyZiGQ0enSwAZJib3d8j8Op/0JwGSpN5SXNb6E7L/lJSRNwX8tjYp7oCZBjln0C+Ll1FomHb3jN8J1YGJinHIHawk9BerFO456YfctppeI7wQru10E9fNnupgsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKsO14RX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABCFC4CEE3;
	Sat, 17 May 2025 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487281;
	bh=OA03KwPdRJDq8IqEjYIz2ffN9NP6+p2bV+s7h5D87DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKsO14RXrNuvL8owh7RrKuV8Td487SWtUkxwYCgcJHnyBmAzF+X+BdcSn/I0G5Dar
	 t1MyF+d976N00QuYoPY5+O6MIQHyI3lJfFGad8dihbi7CUTQ4Q7joJcCinciOwI2d8
	 jjT1slXGxSlIvS7KMrklmQkfbLlaSl+3+v8LD5msYAUHo1Czsr6nXK2KKlU0cKHLAC
	 Lf5W2zxjJ9YtEO0W2NXRp2qNi9UrDNcMz35pOHGyhvMqqEgTc7qSYfZhSoVSguM/GX
	 R0pNxc001z/hmPQPmxqKPA0QY0pyskIaNRVot7mhD6ODvQY69T0WPEF+S3YkQq/e92
	 x8CGcMAgCwIiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 15/16] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Sat, 17 May 2025 09:08:00 -0400
Message-Id: <20250516221641-c60e388100aa5259@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-15-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Eric Biggers<ebiggers@google.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 562da7368caf)
6.12.y | Present (different SHA1: 4e02382eca37)
6.6.y | Present (different SHA1: 11982473786f)
6.1.y | Present (different SHA1: b11b8c7be111)

Note: The patch differs from the upstream commit:
---
1:  9f35e33144ae5 < -:  ------------- x86/its: Fix build errors when CONFIG_MODULES=n
-:  ------------- > 1:  6f92400618dd5 x86/its: Fix build errors when CONFIG_MODULES=n
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

