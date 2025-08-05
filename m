Return-Path: <stable+bounces-166521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD11B1ABE7
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 03:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0A617E86A
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 01:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F90145B3F;
	Tue,  5 Aug 2025 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjoQqRVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C704086A
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356015; cv=none; b=Z4Dt15PK9IIiyoPr4fUlrwxIx/+Y6Y8DtAlEl3xg2ZnxUoaZTizgRI1i79b5srjwnoRPzPklDp+x+juvco9E/122ktnOjdAhIOWd14Rhy6zrndGeko5yyMQ/pRTRYMbVKn8bQCSNoj02Uux+hf9VbOohojVSFFSc022bk6Veum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356015; c=relaxed/simple;
	bh=QrrObuvgFFdpdK8VuvokWccZ9B9pMgzLsV12Gp+3wTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeM/3QdADXCT9y0iy1e4vtGiHqPdb7GwImRrdWH8Whs/bVqqX5L0BiNXcJdC28lTodc7SKurzmsxQSfCNjzBs2ByOouFVdTRPrb4VW5exuyCHPjZh38NZ6J2atlbcyM6AXamppwsQoYU/p/r+8a8nLI0A1Bz5Ci3w6KB1oHaMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjoQqRVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EC3C4CEE7;
	Tue,  5 Aug 2025 01:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754356014;
	bh=QrrObuvgFFdpdK8VuvokWccZ9B9pMgzLsV12Gp+3wTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjoQqRVHbHZ2PPuYybKnNJEjGgIfhuch4MSc8qLioANU+33XyaGRL4B/ohvb2LvBf
	 Sk/LGBHU9FDvk+2IZl9JCTfyf+cRevsTaYC2b+74uAZOQ21WEwx9sidS3j4X+3kGML
	 LsESGtpL1zIGrGhEkC7BvEDFVtPUTq6ZBxc1Sl4yVpXKEFYtLooMKvxEB1IH9BPwCG
	 s7Xru++7heRKz13MiXL9fmrvl1tBzOe1TpYAASqosP8+Usuvfd2p1LJKuDUESFBLX8
	 eKL7xhdt8QHtP2UpA08T8KDo19JCAXPw+D0Ii7GIkG20w5eI6a/GU3WEII6BkQ2/xC
	 OCIgUIBG5E7pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 5/6] drm/i915/display: add intel_encoder_is_hdmi()
Date: Mon,  4 Aug 2025 21:06:52 -0400
Message-Id: <1754321673-e9c24168@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <9da54648dbd77a7eee8a66a1e3a8255bb6cfad32.1754302552.git.senozhatsky@chromium.org>
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

The upstream commit SHA1 provided is correct: efa43b751637c0e16a92e1787f1d8baaf56dafba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sergey Senozhatsky <senozhatsky@chromium.org>
Commit author: Jani Nikula <jani.nikula@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  efa43b751637 ! 1:  7bfe5d895d09 drm/i915/display: add intel_encoder_is_hdmi()
    @@ Metadata
      ## Commit message ##
         drm/i915/display: add intel_encoder_is_hdmi()
     
    +    [ Upstream commit efa43b751637c0e16a92e1787f1d8baaf56dafba ]
    +
         Similar to intel_encoder_is_dp() and friends.
     
         Cc: Sergey Senozhatsky <senozhatsky@chromium.org>

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

