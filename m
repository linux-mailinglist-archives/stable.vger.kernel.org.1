Return-Path: <stable+bounces-166516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74441B1ABE1
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 03:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BCB7AA2D4
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD1145B3F;
	Tue,  5 Aug 2025 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPzFWgi+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255514086A
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356002; cv=none; b=k11iaqqdkxOtuw/bFmM5KNiS/XueNs9LNwAVHPoBnGFOL4O0RQl575SPZpYIJasBAJYn9mO2Cv5L8A0CVKElrcBMH3fsFg2f32MR35RlObGaoYZiFUwBTc5Wvj1cC5bys63pzVAgKZDfKHLvL35vqnIJwPnOTr+l1+ey3z17Na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356002; c=relaxed/simple;
	bh=kRoy0i2YW+B46MY1eYrTiWt3xNJ4W7w1vn6jbpN8fO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+G0KMdJYMRbrZAFU+JYW7rKpvnz1a1SQYfH14k8iVLRPmuqOy+IfJxeTkO1arfbNBdpWY9VH5cPqfIxMDAbPRsY8MMiQaXjcotXVt+LQimGPMaysyTm0TvsDjBGxa8nJfKVt5vThtB9wqZlpf08PH0Ba3uBX1+CInlCGvtvMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPzFWgi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20379C4CEE7;
	Tue,  5 Aug 2025 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754356001;
	bh=kRoy0i2YW+B46MY1eYrTiWt3xNJ4W7w1vn6jbpN8fO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPzFWgi+Vc/HNf0GRCbp4ZsmGUed9Bi3HHznAIuSBHuTGY3p3UiluhUW4CVFMGhv/
	 pZNbQQsvO8kz8pzMV+6tvg44Gu1fYpwsUNlzEtpOuWHDL3elLx3dW+asSmgAlWhQ1e
	 vHdyDJqvvgyt+Nai+r92Z9/3Q4wC3QUInU28MD4SC2W0s0zS0YNNa7c4s2QC1eT9C0
	 I64HJud0zWjlQtFck1RAtIFyVMYndGq9GxyaY+SgbDlMANCIiPn35dLd9tawD5qB+3
	 p3/5WfJlHOYfuNmCu0H3vO1HUMFgKXMyWL3ByLwVpK+19EJTglAN80ifky1VyP87D+
	 ePi8DgsWjXW3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 6/6] drm/i915/ddi: only call shutdown hooks for valid encoders
Date: Mon,  4 Aug 2025 21:06:39 -0400
Message-Id: <1754321762-29609c86@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ff10c20ae7a05ef436366e71b609374709f1c517.1754302552.git.senozhatsky@chromium.org>
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

The upstream commit SHA1 provided is correct: 60a43ecbd59decb77b31c09a73f09e1d4f4d1c4c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sergey Senozhatsky <senozhatsky@chromium.org>
Commit author: Jani Nikula <jani.nikula@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  60a43ecbd59d ! 1:  8009a63e9d86 drm/i915/ddi: only call shutdown hooks for valid encoders
    @@ Metadata
      ## Commit message ##
         drm/i915/ddi: only call shutdown hooks for valid encoders
     
    +    [ Upstream commit 60a43ecbd59decb77b31c09a73f09e1d4f4d1c4c ]
    +
         DDI might be HDMI or DP only, leaving the other encoder
         uninitialized. Calling the shutdown hook on an uninitialized encoder may
         lead to a NULL pointer dereference. Check the encoder types (and thus

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

