Return-Path: <stable+bounces-144680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59641ABAA38
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F8E9E16DA
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E31FF5EC;
	Sat, 17 May 2025 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1kfN6eB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28803155393
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487303; cv=none; b=X8fOflMPJKcE21at9hA3jVIo968plpXO1V8L9OikZGNTQmbV8fPDGAQhkBVWoPv7UplGZMn1MOcCcchs7/ITyWuTgTjiM0h3p3WvxqhiZHmMiuUEbqM78oXDl2EvNMnJh6JBAr0TEEY4ZRaV21CdJfcmYVLvg/Z2HBHJmPcS51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487303; c=relaxed/simple;
	bh=hu6+eEznoasAyCof4I9TRx/yEgfXlCyBfGRJI7V4gzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpXLX7A+KawfOXJbUfBm4CtbSr1jBbGRFYZh8WMCKh/wcmELhqQi/QLqpW3+8p8um8U0vVvbw6HWVa9JUiMdYlTtiwA+Sje/9EGZPyetCXNS1aCZkoA98rTU0u2eM0lyDqgJzmeJV7Tz+t5ZhRsyZQ1BkfEX6DW8mYoWiReO+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1kfN6eB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D633C4CEE3;
	Sat, 17 May 2025 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487302;
	bh=hu6+eEznoasAyCof4I9TRx/yEgfXlCyBfGRJI7V4gzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1kfN6eBgostKm18PbVBvM8TmU2jORViQSbG/I94FKWHzO0rPyuQRG7TwrpgsxyfL
	 DjO35DiaTMVLk03MbCrrL1NRoxwXrRPhoL9jYevJOUhEJx/8C7upu8AMmCRWsNRCFq
	 o69bsDeCDz82q6Pl31ysHN7R7AF7JdpP8TXuk81CmjmKZRymG3rsZpffIxo7k4oKq2
	 CYNsM63RBuojpjrAhfzet4+ny54V/ulFys/6fCsJEfjLnR/oiNQZrAUmDcGnWdZg+Z
	 kmLTK9k42sEGeL3Q2n97pDwcOFl0Las6+ShiQmLj8IBgjfc5upLXo9olcJDb+why5e
	 ytyS3/wwCOLZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 16/16] x86/its: FineIBT-paranoid vs ITS
Date: Sat, 17 May 2025 09:08:20 -0400
Message-Id: <20250516223221-e83488c91ae1667a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-16-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: e52c1dc7455d32c8a55f9949d300e5e87d011fa6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: ca25959b8c58)
6.12.y | Present (different SHA1: 093cb85ddbc5)
6.6.y | Present (different SHA1: 98d84892140b)
6.1.y | Present (different SHA1: 3326321f5b9a)

Note: The patch differs from the upstream commit:
---
1:  e52c1dc7455d3 < -:  ------------- x86/its: FineIBT-paranoid vs ITS
-:  ------------- > 1:  192d94a36841e x86/its: FineIBT-paranoid vs ITS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

