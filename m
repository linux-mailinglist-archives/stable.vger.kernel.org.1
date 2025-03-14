Return-Path: <stable+bounces-124490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06FA62154
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BEE19C5A92
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA101A23B7;
	Fri, 14 Mar 2025 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCpstIQw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF81F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993833; cv=none; b=KAMX6kPaNK0Mh9TBLfJ5UvroT9HueDj7xtAUbjnxCUqL7Xee81yL7gbgfJ4sU7keO56G7bCSIZAn9uEnU0MinObkDwI+Sy8+3Mg+ZWgbc2Mr3ipmB3JIApR6hjAYIVo0EhT7YBAJUYEvbRvsfLq1b5reddBkfgnDzQYzbS4lVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993833; c=relaxed/simple;
	bh=M7wlXIhUtTPYn8Df9KH8tgDrlBz9/2ejYtdI7n/qRAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW4OzFT/AEJD5VHrenuZLaEJRNgai50orikiojibL/WhCjoJODhOSpianO0pTPZBOAWQF8LT0ON2JV6uXH033AQ2jTfxdtApB+DSy125ys8IoRiVf5uYG1tWwYUdlCkcvpIKHKKPHk5wGIahrCNAVCKlNHXbNdkc2aRMxJ23VK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCpstIQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A17C4CEE3;
	Fri, 14 Mar 2025 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993833;
	bh=M7wlXIhUtTPYn8Df9KH8tgDrlBz9/2ejYtdI7n/qRAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCpstIQw4wS7sAQoEhPxjP0D2MF16mVoksBSZcLn5tGy6a0D/cG+xi6g30qrUxi/Y
	 dqlbWqBwiX3cfjtmni3IuUrG8DyJdURhbq3a6fYPRfwuXjB8vgCZ0xDVnt9kwrGjc+
	 SRRWWP1uZleQW28XqsRDRpZAT8jdgtMVzV4pf/861754wCfz4Brjz4Curi32F1R4Zo
	 SvLbcZBoL+PYAKJucHOkwWHDAg/AxoW+zTZzLz4DyQkTfKkVDBvpBJIEaZwx06SCpi
	 0ypXjg8eukwFhM+h0PXocLkFWjQyzuiJNBFBOeOJfSRaKmfpKUmIQsVeVDDyiWnQgN
	 drJkXfqLakgHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 7/8] KVM: arm64: Mark some header functions as inline
Date: Fri, 14 Mar 2025 19:10:31 -0400
Message-Id: <20250314085733-2473d5b3505c5067@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314-stable-sve-6-12-v1-7-ddc16609d9ba@kernel.org>
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

The upstream commit SHA1 provided is correct: f9dd00de1e53a47763dfad601635d18542c3836d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: fda62841c1c3)

Note: The patch differs from the upstream commit:
---
1:  f9dd00de1e53a ! 1:  87c19b0c931b9 KVM: arm64: Mark some header functions as inline
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Mark some header functions as inline
     
    +    [ Upstream commit f9dd00de1e53a47763dfad601635d18542c3836d ]
    +
         The shared hyp switch header has a number of static functions which
         might not be used by all files that include the header, and when unused
         they will provoke compiler warnings, e.g.
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-8-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

