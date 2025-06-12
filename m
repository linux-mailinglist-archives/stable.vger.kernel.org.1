Return-Path: <stable+bounces-152506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEBAD658D
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B1C2C0AC4
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7D1C07C3;
	Thu, 12 Jun 2025 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMoTuRN0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551472622
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694948; cv=none; b=bYGT69RyVOsWSAJh4NGEJeefLMCpvMPX+EgpdnZ7WjsWQr6+05igOJwh4Ab5RHtHCSY3nLNt78fNJTuk0aTEBaVlyc6MCdc8+PgNdXFPyn6hPdIJeLAXY3Lfy+HF9YqBYSiua3Prj5rVfGJ1QC7f3AoLRWjh/nwuDPD3NtqijEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694948; c=relaxed/simple;
	bh=Y3TzTy/39BOQLccievmfnduxX3m/NT0+OLLS8uYouJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfQ/sfGl4swD1lvx3FCAvcD456DHCuWaa+xRgK/Tcb5mhz6duxO4JqmxAKF6PZykqKFvDBLGa0hfhma4tAoF/tI81CFiJIzCAE77MBHR7WZTreFG+i8h+gx9oVPaDnx+NA+GuMLuhdZ9pMC/E8Sh/8em3jOYbEJKI0hz0xUnL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMoTuRN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9B3C4CEE3;
	Thu, 12 Jun 2025 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694948;
	bh=Y3TzTy/39BOQLccievmfnduxX3m/NT0+OLLS8uYouJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMoTuRN0ouQkq5+cx2Qun1sOP5EszlhOvKuge/1Z/byhb/sS4K1GGNjz1BbNNHxCl
	 CjkzhbLA2Wj0HoviZotWGYtRU825sK2N8zKsqM1+9z5zHUAUvneyj2IFbTUnUaI4LE
	 i35PyeTLNHx14VvIWLhDhOUTiiClFugJL2gwqUa5r+GCr5cB5NPQcXfAfZmA1u+o1I
	 9CifCf4LU/6wt3ppA04lHuOTTlrPaC+Sk9ii3AnGpUeqH7eLy0hRG5XwAojOQPfdez
	 3e3R53ywPYTYQfnJFFxC2zXmBkJLdcIzQDU2XwwpL2hOWrfF4qf3VyrvN9tovk7VUS
	 4Rh2Y82qMa4kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Larry Bassel <larry.bassel@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] NFSD: Fix ia_size underflow
Date: Wed, 11 Jun 2025 22:22:27 -0400
Message-Id: <20250611095438-6568922294ccce73@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250610235321.3021295-1-larry.bassel@oracle.com>
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

The upstream commit SHA1 provided is correct: e6faac3f58c7c4176b66f63def17a34232a17b0e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Larry Bassel<larry.bassel@oracle.com>
Commit author: Chuck Lever<chuck.lever@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 8e0ecaf7a7e5)
5.10.y | Present (different SHA1: 38d02ba22e43)

Note: The patch differs from the upstream commit:
---
1:  e6faac3f58c7c ! 1:  6dd1d223c9523 NFSD: Fix ia_size underflow
    @@ Metadata
      ## Commit message ##
         NFSD: Fix ia_size underflow
     
    +    [ Upstream commit e6faac3f58c7c4176b66f63def17a34232a17b0e ]
    +
         iattr::ia_size is a loff_t, which is a signed 64-bit type. NFSv3 and
         NFSv4 both define file size as an unsigned 64-bit type. Thus there
         is a range of valid file size values an NFS client can send that is
    @@ Commit message
     
         Cc: stable@vger.kernel.org
         Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    +    (cherry picked from commit e6faac3f58c7c4176b66f63def17a34232a17b0e)
    +    [Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 2f221d6f7b88
    +    attr: handle idmapped mounts]
    +    Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
     
      ## fs/nfsd/vfs.c ##
     @@ fs/nfsd/vfs.c: nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
    @@ fs/nfsd/vfs.c: nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct i
     +		if (iap->ia_size < 0)
     +			goto out_unlock;
     +
    - 		host_err = notify_change(&init_user_ns, dentry, &size_attr, NULL);
    + 		host_err = notify_change(dentry, &size_attr, NULL);
      		if (host_err)
      			goto out_unlock;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

