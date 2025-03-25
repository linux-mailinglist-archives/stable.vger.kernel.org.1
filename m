Return-Path: <stable+bounces-126561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4240AA701E6
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C30684646B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA299DF59;
	Tue, 25 Mar 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmXSxYjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0225A627
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907740; cv=none; b=AlcPvU/OwFK7N/I577CUeFAKNOQj/+I3gkajYXKTHFixPsGGWJ8NdlefD+pvv5ztC0WGy10UZej8+MBzSBkWIP8gxtW6j+RH9uCm2YSedmPjJV2AYPi5aDXRdxo1csvCbPIJPIYFPOPDvZ7eS8IZK7T7ZF/9TnPuGuIYDVcwtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907740; c=relaxed/simple;
	bh=SqgtQVpFum6nIDAFf25FHCdfWabw6Q8Ut6LI4dbZSOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSmXDIiYnX/elBGP5CeMmy6+pRdwbeQGqMbRkRZcPub75P4xq7jTb9MkxkbbYVZE8s4MeTCja3Wk3MOJ8myYOfnIO7V0+6CwXuJ7MMVeRVQAJFxlztdwLkCr/v8GBzZc8YN0ypsvvjluX6jW/mapGjg+jURLfqs1iY0Q9AmtSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmXSxYjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D93C4CEE9;
	Tue, 25 Mar 2025 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907740;
	bh=SqgtQVpFum6nIDAFf25FHCdfWabw6Q8Ut6LI4dbZSOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmXSxYjDOtc0/saEyClzheIxAV/tHj458zIbi8n0XXRQVetaHWqFktEn4rNNcgBxd
	 H2PgbJJtArbS9jk16nmwHiTEbvaJNY7qg+NhaRoklZSpEw51qtDLuy0wyNMgi/x08P
	 4eOqs0RAIygtSVtiWSkDaAtXzb5f91tKEX5PTlC74eL7Pm2GA7DIzjbg+qz7PkacGc
	 R0qwCSkOinoE18GTGgY31EV6JUfPGJ7zOla01k5kCU9wALTkDZ7oOJXDKCCrPeYPgE
	 LonMyWGYUn/dGO7Rp4kcnNd8+WuxyC+tRcoDOgKJLXYIHQ/URm/ClDtXJlQrtv9uKb
	 HjbBlcfwYkIjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ipvs: properly dereference pe in ip_vs_add_service
Date: Tue, 25 Mar 2025 09:02:18 -0400
Message-Id: <20250325074447-6364c833411323c6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325055644.3320017-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: cbd070a4ae62f119058973f6d2c984e325bce6e7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Chen Hanxiao<chenhx.fnst@fujitsu.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3dd428039e06)
6.1.y | Present (different SHA1: b2c664df3bb4)

Note: The patch differs from the upstream commit:
---
1:  cbd070a4ae62f ! 1:  520e1a106a9ec ipvs: properly dereference pe in ip_vs_add_service
    @@ Metadata
      ## Commit message ##
         ipvs: properly dereference pe in ip_vs_add_service
     
    +    [ Upstream commit cbd070a4ae62f119058973f6d2c984e325bce6e7 ]
    +
         Use pe directly to resolve sparse warning:
     
           net/netfilter/ipvs/ip_vs_ctl.c:1471:27: warning: dereference of noderef expression
    @@ Commit message
         Acked-by: Julian Anastasov <ja@ssi.bg>
         Acked-by: Simon Horman <horms@kernel.org>
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
    +    Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## net/netfilter/ipvs/ip_vs_ctl.c ##
     @@ net/netfilter/ipvs/ip_vs_ctl.c: ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
    - 	if (ret < 0)
    - 		goto out_err;
    + 		sched = NULL;
    + 	}
      
     -	/* Bind the ct retriever */
     -	RCU_INIT_POINTER(svc->pe, pe);
    @@ net/netfilter/ipvs/ip_vs_ctl.c: ip_vs_add_service(struct netns_ipvs *ipvs, struc
     +	if (pe && pe->conn_out)
      		atomic_inc(&ipvs->conn_out_counter);
      
    + 	ip_vs_start_estimator(ipvs, &svc->stats);
    + 
     +	/* Bind the ct retriever */
     +	RCU_INIT_POINTER(svc->pe, pe);
     +	pe = NULL;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

