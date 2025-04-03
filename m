Return-Path: <stable+bounces-127706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42862A7A7A7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D413F7A4483
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69992250C09;
	Thu,  3 Apr 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/ZaUaj7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4624EF7B
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696836; cv=none; b=S96e4plJE9UP460wnQPaJeKk6P8+7A8X97QEUeyj+s+3re80BZ2nyrwi7OxZYAvD1owBS9/nsGVcA+yfFUZLahFNs7UJ0RHJOpi39ojvX3E3ai1wv6ji/KVQTsd5X6H0FX/x2sTP+i+VBfMEfD6NFC5mGWY9bZvdr3sLo/CL/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696836; c=relaxed/simple;
	bh=ftBJptya+md5T2XRtk+Q2rwZVVnHYf5YNsCr/jQziIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjE9DJtKqx1Whj8oOH4KPhzZJciZR1Eu9WDbX/GkPiS5GywTLEMqSpDDTqijSsY5l+NcBQOCW+dlZBksUPyJmnSF/4P5ACQ9t3QZsIOfFcabUJVsxKLjlN2VPuqJEk+hFV2G3BuU6Qj5a1oUzznm4h7DUn1o+pa1x0UKR+tz/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/ZaUaj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2079FC4CEE3;
	Thu,  3 Apr 2025 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743696835;
	bh=ftBJptya+md5T2XRtk+Q2rwZVVnHYf5YNsCr/jQziIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/ZaUaj7WOaNhs/encP8xsaK+rT19wJFuJtH+VOYNstA7gB0vmGUTlA7rjjoMAzq6
	 Sns+yjdVsiR6Ck3HGHpMBj/E2JQd8JCG/eIIDe1HIlpcj07Q8bXoohwqfGSebqNZKh
	 IzitWzim/r81jGCbAoYcRqTzlSUcO96ED6TIsrG/JM52FuwSy1ZqP8MNhXhZ1GgDAe
	 XpBXrGn4oYWT39fLvcL9hRSue7n8hyiQRlRtN5xZtjyluMuKr8nJKGi5tJcxqGo+im
	 qE9ji6IS1xJimU2QR1Mc/OaRZc1e8+Po5CwTNJXJioePWBH03lqrnPflM9/QuKYCeM
	 rHCo2k5GUNvHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] RDMA/srpt: Support specifying the srpt_service_guid parameter
Date: Thu,  3 Apr 2025 12:13:51 -0400
Message-Id: <20250403115342-4427a17a0370402b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403125955.2553106-1-alok.a.tiwari@oracle.com>
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

The upstream commit SHA1 provided is correct: fdfa083549de5d50ebf7f6811f33757781e838c0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alok Tiwari<alok.a.tiwari@oracle.com>
Commit author: Bart Van Assche<bvanassche@acm.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: fe2a73d57319)
6.1.y | Present (different SHA1: aee4dcfe1721)
5.15.y | Present (different SHA1: 989af2f29342)
5.10.y | Present (different SHA1: 5a5c039dac1b)

Note: The patch differs from the upstream commit:
---
1:  fdfa083549de5 ! 1:  f0d286e4cef27 RDMA/srpt: Support specifying the srpt_service_guid parameter
    @@ Metadata
      ## Commit message ##
         RDMA/srpt: Support specifying the srpt_service_guid parameter
     
    +    [ Upstream commit fdfa083549de5d50ebf7f6811f33757781e838c0 ]
    +
         Make loading ib_srpt with this parameter set work. The current behavior is
         that setting that parameter while loading the ib_srpt kernel module
         triggers the following kernel crash:
    @@ Commit message
         Signed-off-by: Bart Van Assche <bvanassche@acm.org>
         Link: https://lore.kernel.org/r/20240205004207.17031-1-bvanassche@acm.org
         Signed-off-by: Leon Romanovsky <leon@kernel.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Alok: Backport to 5.4.y since the commit has already been backported to
    +    5.15y, 5.10.y, and 4.19.y]
    +    Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
     
      ## drivers/infiniband/ulp/srpt/ib_srpt.c ##
     @@ drivers/infiniband/ulp/srpt/ib_srpt.c: module_param(srpt_srq_size, int, 0444);
    @@ drivers/infiniband/ulp/srpt/ib_srpt.c: module_param(srpt_srq_size, int, 0444);
     +}
      static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
      {
    - 	return sprintf(buffer, "0x%016llx\n", *(u64 *)kp->arg);
    + 	return sprintf(buffer, "0x%016llx", *(u64 *)kp->arg);
      }
     -module_param_call(srpt_service_guid, NULL, srpt_get_u64_x, &srpt_service_guid,
     -		  0444);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

