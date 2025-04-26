Return-Path: <stable+bounces-136752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A31A9DB15
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C079C1BC1F63
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7C14375D;
	Sat, 26 Apr 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGpD//Hn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F341AAC4
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673817; cv=none; b=Z2acQTBG+6uoMV7ATbgmm7GITs0ZElY2MPkDNPqBrSPuRu8dT3KD+KBKkBK6EiCGtcIkC5slGo4zDIAymk+dKuWkOOBfrYaOur+1+QXmWn+R1vHsD8RLL8CYYO013LX9bic3REGdz+xRqvHiRoMNlZRglnY60ItiB6a6kJtCukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673817; c=relaxed/simple;
	bh=7ll/RQQewOZeKQNe1byAVQp2ynBratDcSRfkXTMP4R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFdSFG4yZXwx1NV9+BUlpooa0TksIz1oJxi3yf50IuqmJ7Nyn7xMJ7Z3DUe2jYNxJwd3VjQHlYM3HS32UkTHYZgusi0gJOQQPpMNaghnzv/ZIT5Jv1PVUUiEZMPtsZds9RChl5kPw2XF5rUseD5v/iIFUdaH48q+GSGnAl4oJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGpD//Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A840AC4CEE2;
	Sat, 26 Apr 2025 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673817;
	bh=7ll/RQQewOZeKQNe1byAVQp2ynBratDcSRfkXTMP4R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGpD//HnBFgziLVDzJqxhq77sGGbB1cmC0F+bObK/BHm3OuMBql0ukbRQKvNCFlID
	 KUTLbysidWplPf+JF0W57/xxMS5UJsBWry2J2zJA5/pQLct25X2xsyPPuJ6UccSrVX
	 Dx51rgJmkr7uiNo8FM2IjdTYay9bJIiSrOd4XS4TWkglCGkASJNnZcuKQAd7w5a8Mt
	 3FUR8rBQySV+Ms6CcPaApU93WbfcNf4Qeu+KjlPCVPUlH1E2qtalJx2Zg8TaK+OUBg
	 /58DITrc8CL1Q7D0tJJ1GIBMwo2WwpyMPCEFCcnAAz4oEOYiU7alHtS1uJDpimIvYA
	 VEF3XYcuv5hBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: kan.liang@linux.intel.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
Date: Sat, 26 Apr 2025 09:23:35 -0400
Message-Id: <20250426042117-2492bd6ce9e8ab32@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424233501.676485-1-kan.liang@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 96a720db59ab330c8562b2437153faa45dac705f

WARNING: Author mismatch between patch and upstream commit:
Backport author: kan.liang@linux.intel.com
Commit author: Kan Liang<kan.liang@linux.intel.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 389ee3afddf6)
6.12.y | Present (different SHA1: 8d19c4a3b811)
6.6.y | Present (different SHA1: aea923afeae4)
6.1.y | Present (different SHA1: 8a809a8bcb89)
5.15.y | Present (different SHA1: 95ee595e4dfd)

Note: The patch differs from the upstream commit:
---
1:  96a720db59ab3 ! 1:  0a7c40d042397 perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
    @@ Metadata
      ## Commit message ##
         perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
     
    +    [ Upstream commit 96a720db59ab330c8562b2437153faa45dac705f ]
    +
    +    (The existing patch in queue-5.10 was wrong.
    +    queue-5.10/perf-x86-intel-uncore-fix-the-scale-of-iio-free-running-counters-on-snr.patch
    +    It's supposed to change the array snr_uncore_iio_freerunning_events[]
    +    rather than icx_uncore_iio_freerunning_events[]. Send the patch to
    +    replace the wrong one.
    +    With this fix the https://lore.kernel.org/stable/2025042139-protector-rickety-a72d@gregkh/
    +    can be applied then.)
    +
         There was a mistake in the SNR uncore spec. The counter increments for
         every 32 bytes of data sent from the IO agent to the SOC, not 4 bytes
         which was documented in the spec.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

