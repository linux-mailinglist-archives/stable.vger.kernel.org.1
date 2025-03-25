Return-Path: <stable+bounces-126031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7177DA6F441
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B30F18887A6
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00CC1EA7F5;
	Tue, 25 Mar 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPCjcOHZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91CBA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902443; cv=none; b=UFey+b+kX4ttAyhJrErNUlt3SjXA7q+QNPAa7xU5MQVZEp6WZnOBIK5h/LO16+AcT1AuwOpsqiIEJgPJXOh8MRpSGS1CNEDpECaOxxwfw6RAheFol81w3OVQFGQB75TpX7i//37bsNzNk0R6YP0ov2ZEIKNcyAEXfAnJjQAfSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902443; c=relaxed/simple;
	bh=4GFYnb+VQ8E7K8qxUhkONsA9ucV+NnrD9Q/WOc/Kavo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVY08UoANMdBqbohRnieV6qLfvFNOUdOVAr9mtjxtFAWZfgSiRtOGzWVBHpLuBVW/dC2jhQKNX3NJaaLRmlg1PdBsbQH6qZfTaBWtJ6kznYkEXvOdb07mVYIp8zZbP26LdjksXfwL1ZOCGlNS3OJpN+CRAIl3GoMwASXb72UEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPCjcOHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1D0C4CEED;
	Tue, 25 Mar 2025 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902443;
	bh=4GFYnb+VQ8E7K8qxUhkONsA9ucV+NnrD9Q/WOc/Kavo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPCjcOHZmDgVb7qcMA5Q3Dy58CXGytayfm9dTZyC3C3CaQ7DiCB51FX3YxysBCASk
	 IfoibbzvANSYZ6oa9DYdtb6OmqS3COJdjSJOIg1iTjuJMYghLrYinbjMM4srufvoZb
	 FyK7X+LDvmu3WruV33dDs9MMAllCQwHAHPQ2MGXWy6B2ksfBm2LCUr/R/RUESbQ1IV
	 bdr05UXxik+k8xjm2vftlUTIDK7M05CGJlfLkMR/PKTNAiVhp+5y9NBbJucftSfqVq
	 zxhyvEWBSpPVa9ghgwVMLv+H5FvFzwELg3N/SvvrXZ4bNpo2k9X8v/dN4+4Gfge0/Y
	 72004L5r/mcng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] btrfs: make sure that WRITTEN is set on all metadata blocks
Date: Tue, 25 Mar 2025 07:34:01 -0400
Message-Id: <20250324205608-f86e6d0f7f4412b3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324073454.3796450-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: e03418abde871314e1a3a550f4c8afb7b89cb273

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Josef Bacik<josef@toxicpanda.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  e03418abde871 ! 1:  41b79978995a1 btrfs: make sure that WRITTEN is set on all metadata blocks
    @@ Metadata
      ## Commit message ##
         btrfs: make sure that WRITTEN is set on all metadata blocks
     
    +    [ Upstream commit e03418abde871314e1a3a550f4c8afb7b89cb273 ]
    +
         We previously would call btrfs_check_leaf() if we had the check
         integrity code enabled, which meant that we could only run the extended
         leaf checks if we had WRITTEN set on the header flags.
    @@ Commit message
         Reviewed-by: David Sterba <dsterba@suse.com>
         [ copy more details from report ]
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/btrfs/tree-checker.c ##
     @@ fs/btrfs/tree-checker.c: enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

