Return-Path: <stable+bounces-110983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B54A20E56
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5E01657DF
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636A1D63CE;
	Tue, 28 Jan 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq8SEtH0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACA1917D9
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081068; cv=none; b=eRuXysl7lHwrN631HdFS+5QASMh7Ulg02cKhAXlZQZtf83s+k6AkOB1UZU1TrfwdlkCqoWlRTfjJKPjaFNj/xNe9uhae3JDlzcISh9tIsEGQ+EAfLbDoNVdpDn+l62X6wdZxNPH4hU+uFcGaVOE62QfAtBHgBr9Vf8gxWLkCFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081068; c=relaxed/simple;
	bh=JQcVSU5oc0ZCd+jGsxP+SOYajqMLwL1FjKR2AL2NsJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCVa9IUkWeOvPUhQgVhSlGQ6QmQkcApZq2lyZacGhnOtLGu07j8YAhbiioWnCAF7ORkCRO2qtHIF9NYDEG2nIQa6jiiDc8Ub4bSaReSFb4mU2xDwUndEe2l/SWI3s51AwX4Gn8hB//GpXihzONCMgBKH40yOYPh/GkulallxUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq8SEtH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87704C4CED3;
	Tue, 28 Jan 2025 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081068;
	bh=JQcVSU5oc0ZCd+jGsxP+SOYajqMLwL1FjKR2AL2NsJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qq8SEtH02KcHJ/T64Q2jU/mCiJLcrGoEEjPz/3iyOKfnYZoFjth+DZtt6ssF/HQvA
	 BhSqoR4Qd5hEUspmCoRAHvB1hkN9wrBb+s7dWqO9wb3b5qmuC/syEjruFNamVY3jZt
	 7u9+Z7+4vlAaQ99ALfTF1grYmsG3Ol8PqZmVMsDTixHDMiqYKfOOZF1QENRjHsE5+D
	 nrjPQJvNLfRUry8Z/QngSbnqLXGvKOVhJ7Jf0nlYhkdzZRgAJFfv/nTgS+EC0qKRRE
	 XLl667JER+Pz1g5s3VZdVOTXyVmmXeaUCmAZObG23QrUZbxB/QrKIae0YHweyx6+VW
	 p7RciNSKip9sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Tue, 28 Jan 2025 11:17:46 -0500
Message-Id: <20250127155609-ef370411832dbb35@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127183030.68130-1-eahariha@linux.microsoft.com>
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
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d2138eab8cde6 ! 1:  3683115b8be9f scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
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
| stable/linux-6.1.y        |  Success    |  Success   |

