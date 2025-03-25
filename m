Return-Path: <stable+bounces-126560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A400FA701B6
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E7816AEE8
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D42566FB;
	Tue, 25 Mar 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8j0ACHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DADF59
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907740; cv=none; b=Ex5p+6jCjWvHmtXPFlJYkkqJYATFBbZ1ab8p3kjtFPV/jTFyt54BcIzcRfDKc/NpEqzBg91wwEoqP7ji6zBCCbHiwKTUJtxEd8aUvZQd5LZvf06/cGsU9zQdpszTpiPi/oT0RfKHkkRSbaE1dL9rX7ZFbedISlBjknM3QQ0/rA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907740; c=relaxed/simple;
	bh=ld+mLJGuQQn3+dwEdWMZzqmZdUjdOOJoErJZ9zfhUMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+aA4x7iMOB6YRMdlleIpw4bO5h9LtWmKzT8Ahv4XPfusb3o6Al/O6YFyjQCn9h/iuakFOOxTqJ/wqEK3mDMy9HW5bW4cnBPNxAwweXj43e4JGf5irmR+xzIuYpBIsDESn84F1wRhq+671nKwJmR6OV0WQk6FW84vK1yP8/GCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8j0ACHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48A2C4CEE4;
	Tue, 25 Mar 2025 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907738;
	bh=ld+mLJGuQQn3+dwEdWMZzqmZdUjdOOJoErJZ9zfhUMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8j0ACHwLPAtD6PLatPj15zLU+CNOAKtRXTbq456x2b/tW8VQRy3TjEleJlLODjoo
	 YiwVXr9mKmfqSwp5ZQjBVCorrbZWpSQAAVBplWy3IM9jLanUPFjEVR4U5LrkqCmuq3
	 rLfZR8aJ0LFyEBFiVUV9TMrS1qDnuiYQwsq8SPGdfXyf6n/daDKiHMkgmiM259W5hh
	 CoxFrjRtWaQ3fkyPcI7EJD3rH3FyT+5O818Pf+eU3OqargSaRXJD+iV34WFnwtB1GT
	 c5sWH1MvfSz59O41X7uxN/I7EHvaKKAIDPFDBX3kkKr8vK0rDSNadsUEnZbxXld2hP
	 yOO9CbTDr39jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] ipvs: properly dereference pe in ip_vs_add_service
Date: Tue, 25 Mar 2025 09:02:16 -0400
Message-Id: <20250325075625-994ee91cdf42f593@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325061439.3334363-1-donghua.liu@windriver.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  cbd070a4ae62f ! 1:  11fd9143f92c0 ipvs: properly dereference pe in ip_vs_add_service
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
| stable/linux-5.10.y       |  Success    |  Success   |

