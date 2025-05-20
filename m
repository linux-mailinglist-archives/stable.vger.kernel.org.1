Return-Path: <stable+bounces-145083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623EABD9AC
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFD616992C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B62417F8;
	Tue, 20 May 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU7kOeic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734324110F
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748212; cv=none; b=hhsxOGAo6Exa7b8MDJnU8gFPesCEPKbKdeQWfeEpisSsHZYLS02DQ5A6/9l65OhpbD/SudSO5bdki7iZh4rvJbUydmcW6J8EsYjzkJanvOz6W/7N7v/x9hEFcx8eDh7PL2Wsm0SVmrR2yAq6V3ovS0sh6mXKR+VqAHAPozqUPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748212; c=relaxed/simple;
	bh=hlnwWGf+swLIVDhb3ItGLfwGKsZzsF8N5WSHhryTzxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCKdFPAp/P2OHX4163/LXJlp3LFyUVVfynHeW1S1CSO9nsfxz7/ZmyuwbWanMoCPaigOXPX4WS+rw/Qr7I0b1NdjRjg8SWVwAZZ9+65HKKI9nMqwtsv/l2VNg+VT+MCdHC44TZQLEjf88qvhIuiCDab4kFGoELEQK4cix96BAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU7kOeic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9ADC4CEE9;
	Tue, 20 May 2025 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748211;
	bh=hlnwWGf+swLIVDhb3ItGLfwGKsZzsF8N5WSHhryTzxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU7kOeicRrkdXpPX4dYI+/VE7CbhfbWrda+0Hq2YoHfH9KQGMYqLXOXbe5SPnWbjA
	 eR9fXMUmNLKxNhq/pGYSL74iQQPrTIszj9K/F6pqG54HnMD9uaU6zgSP3Z7IC1ncS8
	 V2WIm1+Leklm5Zu8lOkGhmk1/TA77UjciqE8zwghiCTTXSKsVfiF1BQZKofVElCOKP
	 98MdSPX8HM//cOLlZlVrTonQqT6eUSr2+x12NrOgxvrPMvKOILy/3fyfsv5qgT50Af
	 qLFqX/wTuayChP33I84CTSkB4kaIJQWnYLhl/qmJkQHEuOCKKu6Mn9ojrsPpClJ2bZ
	 6kgsW+SX78kZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,5.15 3/3] netfilter: nf_tables: do not defer rule destruction via call_rcu
Date: Tue, 20 May 2025 09:36:50 -0400
Message-Id: <20250520073217-f5c6fe62ef5e3f3b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519233515.25539-4-pablo@netfilter.org>
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

The upstream commit SHA1 provided is correct: b04df3da1b5c6f6dc7cdccc37941740c078c4043

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pablo Neira Ayuso<pablo@netfilter.org>
Commit author: Florian Westphal<fw@strlen.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 7cf0bd232b56)
6.6.y | Present (different SHA1: 27f0574253f6)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b04df3da1b5c6 ! 1:  a847bddc4639b netfilter: nf_tables: do not defer rule destruction via call_rcu
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: do not defer rule destruction via call_rcu
     
    +    commit b04df3da1b5c6f6dc7cdccc37941740c078c4043 upstream.
    +
         nf_tables_chain_destroy can sleep, it can't be used from call_rcu
         callbacks.
     
    @@ Commit message
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
     
      ## include/net/netfilter/nf_tables.h ##
    -@@ include/net/netfilter/nf_tables.h: struct nft_rule_blob {
    -  *	@name: name of the chain
    -  *	@udlen: user data length
    -  *	@udata: user data in the chain
    -- *	@rcu_head: rcu head for deferred release
    -  *	@blob_next: rule blob pointer to the next in the chain
    -  */
    - struct nft_chain {
     @@ include/net/netfilter/nf_tables.h: struct nft_chain {
      	char				*name;
      	u16				udlen;
    @@ include/net/netfilter/nf_tables.h: struct nft_chain {
     -	struct rcu_head			rcu_head;
      
      	/* Only used during control plane commit phase: */
    - 	struct nft_rule_blob		*blob_next;
    + 	struct nft_rule			**rules_next;
     @@ include/net/netfilter/nf_tables.h: static inline void nft_use_inc_restore(u32 *use)
       *	@sets: sets in the table
       *	@objects: stateful objects in the table
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

