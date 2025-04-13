Return-Path: <stable+bounces-132355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BA8A872B5
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F51E16D6D9
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259C1D7E37;
	Sun, 13 Apr 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY6gT+N9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721F14A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562858; cv=none; b=NI5UPJexecIJR2dC3uTIb3RGfSGTK7M/Ehj2Kg0vGQFFjOAyT9gupKZeUgfQs4WHTLeq8zsOM2pPRFJs02qEKpK6XZbwscZMTwOZRdNo68OgdLB+EZdd5rL8Ioik0CMxBunOPoXSYMHm7kWzbmsOqKAMnFumswf4NHUHEXMv0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562858; c=relaxed/simple;
	bh=3dSgbRQm3dQ0tgWBWUkstTQ8uZn8ut/+dPgx7rlo0SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fqn5Ry8raPIqg7kXISgGbTeC+NCkBkuIpqfoLPdgrI3+qyP4rqpPAEKQwbSXl7e4ao1/Ny090r8VwGaBbhIjsZtax1Hh6UMnJFrmjjL7yUD+W2yX3jBzcbqz51Dz6ak0sjVk4WxBakcG/P1M3DUl3QSHQzPTe35l064WITrGwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY6gT+N9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B73C4CEDD;
	Sun, 13 Apr 2025 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562857;
	bh=3dSgbRQm3dQ0tgWBWUkstTQ8uZn8ut/+dPgx7rlo0SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TY6gT+N9omaZKjxp9g9xQmUz43G1W+axMepzOXT1ljkZIJevOduouL+Ovw32lxUPT
	 xpPUpDGplo6q2zLNeCShUlKC8E1hfq/e30kGSfuXYeC/KskdGaC2y3irFbpHfNtMl6
	 S3ywEgs2NVziTeF9C0qSJ7LnlPs6Ebkgdp0GRkpOKrD78QN30ycuQoBBAxAD5w03eb
	 vzNTvyD32R4jRY1x7vhQ5TjIU2PHxYsI1iKLugprN3eLKP+IH/3fwV9ZDrn89GVpRT
	 /LqHLWUYc7THbpwfXxkPk+uAl0jrdHh7lCzmZXPNAarcZ7togCflMAqegOpDevSatV
	 NNNQ9eI/ZmmNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.12] nfsd: don't ignore the return code of svc_proc_register()
Date: Sun, 13 Apr 2025 12:47:35 -0400
Message-Id: <20250412123343-3854ac696f2b3a1c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411141611.27150-1-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 930b64ca0c511521f0abdd1d57ce52b2a6e3476b

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Jeff Layton<jlayton@kernel.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 9d9456185fd5)
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  930b64ca0c511 ! 1:  7d53ffdf10e3f nfsd: don't ignore the return code of svc_proc_register()
    @@ Metadata
      ## Commit message ##
         nfsd: don't ignore the return code of svc_proc_register()
     
    +    [ Upstream commit 930b64ca0c511521f0abdd1d57ce52b2a6e3476b ]
    +
         Currently, nfsd_proc_stat_init() ignores the return value of
         svc_proc_register(). If the procfile creation fails, then the kernel
         will WARN when it tries to remove the entry later.
    @@ fs/nfsd/nfsctl.c: static __net_init int nfsd_net_init(struct net *net)
      	seqlock_init(&nn->writeverf_lock);
     -	nfsd_proc_stat_init(net);
      #if IS_ENABLED(CONFIG_NFS_LOCALIO)
    - 	spin_lock_init(&nn->local_clients_lock);
      	INIT_LIST_HEAD(&nn->local_clients);
      #endif
      	return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

