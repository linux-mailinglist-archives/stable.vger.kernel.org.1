Return-Path: <stable+bounces-145084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977BABD996
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307317ADF79
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907122DA1A;
	Tue, 20 May 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xds7eZMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39A22DA16
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748213; cv=none; b=JTWBQElgAy71GsCAsrwdda2iOJggQTZNAqB0blvTuk7L0sLDGyG0BQsJb7PKId3Vl4qn/fCclL0t0PyZuwyYRlqsObManGqUoeodtWNTR4AF5GI5Fu2Tvbf1HmsflbkcMlvoWtxLFOWn38SwLMAcgsoGvBiQOCyh7SQgGFmxfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748213; c=relaxed/simple;
	bh=vnJDwI7/CEMVHjgDwzAAb61EToEQJDPX7L4oPTwl3Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+1BvHRzEqRdKmcTC8BJgkQ66cIi7cm2NUuR1nTAaahWOBVrjkrjDMyzIYSQawJHI8DGpU5K3fYZ4eIap0BIhokL+BboTV4usYWyuhWwcf8MuVqXsPucsUE/cpKbZhbFTpxdDnpcs6pp6audxUUKhioIgN8bz/HzbIOMAEvqAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xds7eZMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A268C4CEE9;
	Tue, 20 May 2025 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748213;
	bh=vnJDwI7/CEMVHjgDwzAAb61EToEQJDPX7L4oPTwl3Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xds7eZMpnQa2HrmML86D7ynFI8AwXTVd1fI9PURUkwLj5ry7/umzkso9MGYi2JRqp
	 uceyw8yJPiXvApkor9ILDScuN/oT4hr33/nG0u3Kl/LFU8hVBiOgI1h+KnsMHMvv2h
	 JVSGaMo0/b6siABnz4HlwMWrqzvPY/aBb3Ok5afFjeIRqiJtf5WQ2vl7ytL/XWEfhv
	 6f/SFehFHd+IcwyQMvfTopP0i7GlJ/SMn+DvBUVZwiXUvS0iIUHJMKRML1KPUsAbrd
	 udlg2CvZmgQ8yrnp22B22V+W4QNn36OXPIw/9kwR91mskaZx2UkOHlEhiEySwAUL4W
	 PUnJSz253xHUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pablo@netfilter.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,6.1 2/3] netfilter: nf_tables: wait for rcu grace period on net_device removal
Date: Tue, 20 May 2025 09:36:52 -0400
Message-Id: <20250520064605-377b545683c1a469@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519233438.22640-3-pablo@netfilter.org>
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

Summary of potential issues:
ℹ️ This is part 2/3 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: c03d278fdf35e73dd0ec543b9b556876b9d9a8dc

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: bfd05c68e4c6)

Found fixes commits:
b04df3da1b5c netfilter: nf_tables: do not defer rule destruction via call_rcu

Note: The patch differs from the upstream commit:
---
1:  c03d278fdf35e ! 1:  d6fc62cb7e09f netfilter: nf_tables: wait for rcu grace period on net_device removal
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: wait for rcu grace period on net_device removal
     
    +    commit c03d278fdf35e73dd0ec543b9b556876b9d9a8dc upstream.
    +
         8c873e219970 ("netfilter: core: free hooks with call_rcu") removed
         synchronize_net() call when unregistering basechain hook, however,
         net_device removal event handler for the NFPROTO_NETDEV was not updated
    @@ Commit message
     
      ## include/net/netfilter/nf_tables.h ##
     @@ include/net/netfilter/nf_tables.h: struct nft_rule_blob {
    +  *	@use: number of jump references to this chain
    +  *	@flags: bitmask of enum nft_chain_flags
       *	@name: name of the chain
    -  *	@udlen: user data length
    -  *	@udata: user data in the chain
     + *	@rcu_head: rcu head for deferred release
    -  *	@blob_next: rule blob pointer to the next in the chain
       */
      struct nft_chain {
    + 	struct nft_rule_blob		__rcu *blob_gen_0;
     @@ include/net/netfilter/nf_tables.h: struct nft_chain {
      	char				*name;
      	u16				udlen;
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

