Return-Path: <stable+bounces-145088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CEAABD9B8
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3C31BA4BF7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7782242D72;
	Tue, 20 May 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8EZhQ62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D924293F
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748430; cv=none; b=esbSqq+TI3xovsXC7gg/TgRS/D+pghmlYKzhggfc4/opkBBahUBzNPnlXvtdqHb0Wygx09HvOkJFnk5Ku136iEjsqPEed5XRPX14vad++gYQ3UCUv/KY+YaehqxJl8KUIgS6UxB8y3TKr+kONZcoNslqSEi+d7ERKQe5tp+m9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748430; c=relaxed/simple;
	bh=JN1XEXebO/0ntcRG+0XKSV0/CaOXVMtuEnxLOhv52uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPXn28l1p5Hixdz/M5DWYMG+SjYu313ud6jZDJdxSoGlDyzTbuH9rO/6w/p07srnStlsifjPirgYCGehwq5mdfejVXr7xUgUg4RIFn6MFlJU3HVFklYoBiDs6UgH/BgbYhhh4xg7Xj9BNQEZ6QBS0LOwrhURLFOKrAXrabnzlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8EZhQ62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39BAC4CEE9;
	Tue, 20 May 2025 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748430;
	bh=JN1XEXebO/0ntcRG+0XKSV0/CaOXVMtuEnxLOhv52uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8EZhQ62BUQ3cTLTTfv/+aP2I2WpSXNXVxW/ZrnHCRvAGfPXTOGzRvxAoiE+ve9iv
	 q1+E6QiF/XjSnKtY0KIu9JErpnLaDohlqSIrZ/DKx3jBuDB0PfKxRY7rJmsRNn1Cq7
	 aRjV2wrHHnZvGt/YHS9xoDnoDZjA0eUBif0oE/I8NM+5+QH8ySa1B4dum9b2ENR4zU
	 RnU7oh7R5331OTYMJhXlCPYc863bewaFKa0lwc1SpdQ/r7JaLhRdP04naqzYbR+Fwi
	 /2bUzcC1fZyTadblHZ62XsmgSI76cqYYgXB4daz4rX6+C3o5piObEPYYRtImJSO/AV
	 TBofLZwQNs0aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,6.1 3/3] netfilter: nf_tables: do not defer rule destruction via call_rcu
Date: Tue, 20 May 2025 09:40:28 -0400
Message-Id: <20250520065817-6b886892979688e9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519233438.22640-4-pablo@netfilter.org>
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

Note: The patch differs from the upstream commit:
---
1:  b04df3da1b5c6 ! 1:  5ecb99b42454b netfilter: nf_tables: do not defer rule destruction via call_rcu
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

