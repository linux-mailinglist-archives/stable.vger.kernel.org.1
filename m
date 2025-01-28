Return-Path: <stable+bounces-111067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACBA2154B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 00:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA908164245
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 23:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD4BE40;
	Tue, 28 Jan 2025 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbPmoJd2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F85672
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738108173; cv=none; b=fDCiQ5SyT/Kl98p4NZfqgfjxCd9TTrUOnnvga0aytWDy7VrjVrcxjh+CWLRlQfh1u3f/nc6B28IEgXu+uOF8tN8eA5kt/jP42YBdomf/Ryi5UuEPzxfgYszj8Er2NeWkCNinicmQL/t/MuxSc3bc7XMO5Qb4I17bh6S27gngcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738108173; c=relaxed/simple;
	bh=rWK51jIx/3L4RvFXRwdvrkpenBmZV9X8RCuL17/nICU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twmf8mJ+Yp65m8073aGnQiUdbUFMHQkP6QiEA4PshVn9877BqV2vlSbRNoHBvcIFjQe77etqAKFUcQerDzluTp36uPTAonAoNBRYGOzuCvkd+1Dx8Oa1d1Hg8b4M5rbto9I4CZH1xF8sJNS8+ILg5C7dydgQTe6rAjhaWX7Fhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbPmoJd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99235C4CED3;
	Tue, 28 Jan 2025 23:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738108173;
	bh=rWK51jIx/3L4RvFXRwdvrkpenBmZV9X8RCuL17/nICU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbPmoJd2XjpbwI+JHJ4YOi6IQoI8lFH29u7TMAvRgodaZqy7zzIkdkITWqrRf4Eww
	 vwrBtx4rldPCr3m26fob2bcEza4ToGrndnjvtzEvPkbtZE3P6++/MoqGg5QOrjknaI
	 JhSbV9UGAFDfsmGJbtBzWlgWDIjlJJOBHkHwutWSDRdrimS3rkLhT/oq0WlNZPM2t0
	 psJzB4DXHBVE3MSzRU+tZX0fDH/q+Q/mPtw7W2Lb++7KFvU22MVXxVEBRcaEQEuGn7
	 47EoIAVV6OcWh2sSATIMX4SFIK4zn0fRysBxLfuNFSf+boBxsDlpWnvAa61WR9yzMU
	 hjRgtKfgjxm+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Tue, 28 Jan 2025 18:49:31 -0500
Message-Id: <20250128162127-51732338aa97f32e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250128174658.33352-1-eahariha@linux.microsoft.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: d2138eab8cde61e0e6f62d0713e45202e8457d6d


Status in newer kernel trees:
6.13.y | Branch not found

Note: The patch differs from the upstream commit:
---
1:  d2138eab8cde6 ! 1:  83889438dd3b8 scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
    @@ Metadata
      ## Commit message ##
         scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
     
    +    commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
    +
         If there's a persistent error in the hypervisor, the SCSI warning for
         failed I/O can flood the kernel log and max out CPU utilization,
         preventing troubleshooting from the VM side. Ratelimit the warning so
    @@ Commit message
         Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
         Reviewed-by: Michael Kelley <mhklinux@outlook.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
     
      ## drivers/scsi/storvsc_drv.c ##
     @@ drivers/scsi/storvsc_drv.c: do {								\
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

