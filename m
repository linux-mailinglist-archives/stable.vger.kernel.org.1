Return-Path: <stable+bounces-132167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FDCA848CB
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F447B5B8C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E701EB1B9;
	Thu, 10 Apr 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIApfk4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F91E9B2F
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300511; cv=none; b=LtkcoxRBr50RsEU2nsEdVbFBNt1qPnBVYNHwtuKagRk31MEt7Fb6FjJx2ZVEyxyer+e0Kue5DzL+/UR4tmSdjPx6bIRqlvJ8t7fURsElOmXv3k+7DjfcF9sT6q6KdhvtDEUZKM7ETP3t4ky7/gH73HOuTOF0dTLMYIMPi5DBl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300511; c=relaxed/simple;
	bh=0Vbid78fKM7kXvGt+kJoqx1C4FwP3avM0NfY1/MuxXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erInyhMkHXtXqX3sjG2do3o+eyLskAVsFD/QPbAxII7Kci9SWlKMBdW2rwVGs5+KaULNfmcI1PeQTaMcUwGnY0/4yvng+CsR7FQ0IcO/InEDJIhNIqhMD1IObFDbPMuocL8ot9W8XRqR/r+I/UVwXrkNnR7/XpZQ2VJcFQ3MnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIApfk4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D0DC4CEDD;
	Thu, 10 Apr 2025 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300511;
	bh=0Vbid78fKM7kXvGt+kJoqx1C4FwP3avM0NfY1/MuxXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIApfk4yhL3SHgSxh8odXMnkX8T6cjscvPyczq+psaOmsuDXwJSW++3oCjLowN8fF
	 0dRJeE8lAab3Ae7ObsHZOToZ6GMDWU9EBm2khMRUuR/P2yC4qiI33Oo+g16+X99tJa
	 oBrRkq+7XMSyiKm6cOgSCuCIGD5G7kt3SqLVwNJTD2maozwnzwBrywIzm3UqE3HURN
	 lU4p8z/dwvtqGsFrzMINV/48rSAv5fL9gsIy2yp79vc8yKwM71HS+a8fwbnyIHtYxg
	 nKRYF1YzUO8eaIFaQuOpkv3Qmo3PNmTRKk+njCjxg7o6A7S07dIazZqBxj3u26Uwsh
	 naDOvQig0hIYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/i915/gt: Cleanup partial engine discovery failures
Date: Thu, 10 Apr 2025 11:55:09 -0400
Message-Id: <20250410081147-aa3fec33c54a663b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250409014856.2484814-1-Zhi.Yang@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 78a033433a5ae4fee85511ee075bc9a48312c79e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Chris Wilson<chris.p.wilson@intel.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 5c855bcc7306)

Note: The patch differs from the upstream commit:
---
1:  78a033433a5ae ! 1:  2d37eb85bd845 drm/i915/gt: Cleanup partial engine discovery failures
    @@ Metadata
      ## Commit message ##
         drm/i915/gt: Cleanup partial engine discovery failures
     
    +    commit 78a033433a5ae4fee85511ee075bc9a48312c79e upstream.
    +
         If we abort driver initialisation in the middle of gt/engine discovery,
         some engines will be fully setup and some not. Those incompletely setup
         engines only have 'engine->release == NULL' and so will leak any of the
    @@ Commit message
         Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
         Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
         Link: https://patchwork.freedesktop.org/patch/msgid/20220915232654.3283095-2-matthew.d.roper@intel.com
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/i915/gt/intel_engine_cs.c ##
     @@ drivers/gpu/drm/i915/gt/intel_engine_cs.c: int intel_engines_init(struct intel_gt *gt)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

