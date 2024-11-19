Return-Path: <stable+bounces-94032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 156AC9D2893
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53F6B2AEDB
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EE1CEACB;
	Tue, 19 Nov 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQRdzeow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F661CF5FD
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027629; cv=none; b=HcF5Qc4RH6mAe0GzaIU15Ooc7LHU9Ym1FhDZVo5G78PoJN+jIp3o89Jy79xLCXnB3WoEad9mpE3lWva8wgS7f16PCzSda0UXJ+cho3ukOJEL/LoFAEfDZdpEOHHiUYcNqlRd6bsULlEntF1EVk7DmPsJuV8F7UAzvnXPwPlzEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027629; c=relaxed/simple;
	bh=hDdCVj8DEYAn9+1aZTlOHXT6zgWf0IoeM18SDa6V164=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgF7gPdUqMp/9GYgzYDDO6YZD7nJQLszWG5dEe8qAR4bwyrE31kf8mQHkDXGODDqINWCvt2hnQtMpzTAA966WlE2dOMxZQc4OBNnXbeZnKo+RmPn5ALzwkgFEE+gCJqD8YL0wTzJtvWiXQOfUlje8Qs9XykoE+Iw5Op7AMr5Vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQRdzeow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA6C4CECF;
	Tue, 19 Nov 2024 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027629;
	bh=hDdCVj8DEYAn9+1aZTlOHXT6zgWf0IoeM18SDa6V164=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQRdzeowXuZ7cRJEXgSAfGuX1aMC7nBzhnOFA+Vy8RJtbcmSomGoQeMSYdssBJduD
	 xUfJ8y3RP0PJ3l21AQMRlq3ExxoyYS3FIDhsC728EaEA2tE4UfJYDl6OdxwDsgI6wC
	 JYJmd8HoynCkb0XdUrUGol/L+PMMS0/BOrdq+KFYRStmDd+2TMS+d1lQ01tiMvf2hd
	 B1eUVf2bVD4nasxqBt7H0TMZ3QEHYBJj6yyvHQ12Q3zrf4iTE8YQp5QAbOs3ut1dfN
	 pv2KGTg7NQABeQoN29zGGHVMAMO4blBAqbGo9D2YQ0wW76XdL/YZdSChEV56ecVDQl
	 Yd82aGhsctECg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] ipvs: properly dereference pe in ip_vs_add_service
Date: Tue, 19 Nov 2024 09:47:07 -0500
Message-ID: <20241119102010.2572322-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119102010.2572322-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: cbd070a4ae62f119058973f6d2c984e325bce6e7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Chen Hanxiao <chenhx.fnst@fujitsu.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3dd428039e06)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 07:39:13.723692653 -0500
+++ /tmp/tmp.z99Kibx5w4	2024-11-19 07:39:13.716370307 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit cbd070a4ae62f119058973f6d2c984e325bce6e7 ]
+
 Use pe directly to resolve sparse warning:
 
   net/netfilter/ipvs/ip_vs_ctl.c:1471:27: warning: dereference of noderef expression
@@ -7,17 +9,19 @@
 Acked-by: Julian Anastasov <ja@ssi.bg>
 Acked-by: Simon Horman <horms@kernel.org>
 Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
+[ Resolve minor conflicts to fix CVE-2024-42322 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  net/netfilter/ipvs/ip_vs_ctl.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)
 
 diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
-index 78a1cc72dc38a..706c2b52a1ac6 100644
+index 17a1b731a76b..18e37b32a5d6 100644
 --- a/net/netfilter/ipvs/ip_vs_ctl.c
 +++ b/net/netfilter/ipvs/ip_vs_ctl.c
-@@ -1459,18 +1459,18 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
- 	if (ret < 0)
- 		goto out_err;
+@@ -1382,18 +1382,18 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
+ 		sched = NULL;
+ 	}
  
 -	/* Bind the ct retriever */
 -	RCU_INIT_POINTER(svc->pe, pe);
@@ -36,6 +40,9 @@
 +	RCU_INIT_POINTER(svc->pe, pe);
 +	pe = NULL;
 +
+ 	ip_vs_start_estimator(ipvs, &svc->stats);
+ 
  	/* Count only IPv4 services for old get/setsockopt interface */
- 	if (svc->af == AF_INET)
- 		ipvs->num_services++;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    

