Return-Path: <stable+bounces-124908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C92A68A11
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03164231F9
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA388254875;
	Wed, 19 Mar 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL9cc5as"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FB254871
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381669; cv=none; b=PVE7+iuhsKnmj3JJiMOSxJefAe2ZbrI99wcL+OEXm3CZ1k2t9jcvchaC9eMCLNaZuDNBY+CxghVFk/PUll1TvP8ZGphauM9yzqAo+qtYqSZzgKBTcfyLGgwg1oozprDvVneHqnUKyNxPQRX8lEOom3tq8OMjRRKixQFpM1yrxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381669; c=relaxed/simple;
	bh=K8iKtcu+zblXTG+ePaAlY3bYCTroCbh9saox7n70T20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cC7seROByt7wsy0EcueaHmEAPBnNTTu7WxDBJsnkaipgw4bd3zWJ7qlSyADsSif/opzGOcB9/PkHN/BuKoXMjQYS2blrXiCXgPNLtcpiStY8lyQ6d9m6S9t4+4LJcr03hEmjU2y2TmRsGh8R5LVTWT+WIOtYsO3N1YeTJ78mHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL9cc5as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3475C4CEEC;
	Wed, 19 Mar 2025 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381669;
	bh=K8iKtcu+zblXTG+ePaAlY3bYCTroCbh9saox7n70T20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jL9cc5asXJhXncPh8bPpQtpNIdB52hOMHXqaPC4srLVGrR2h8a5K+Tj8JXHpwpVCc
	 B1fvBUfWGeHoXSDNiqjxfPqC/UyqT9HvCQgoWkuNjxd71GDeJFJO/J6hfkxn6hNjY+
	 e3C6C5BqRtuABjlDr0s/UtabxFJP2Glo5/55JumOvxUi/nCwki3DxfJ2CjDYyVbhT2
	 KiHYGttdw14Kj90Ri8MSRkDK8JzLgBDjqDcJe1sHiAyG//nGkz2E7c+dUcPFOoDkMe
	 3xwLTIBVlFD+i9QYlI2+aw2C2QfG2R074zHwg7J4a2x01NhRcVFb7e/q9fWinvP9Ip
	 qpHlSGkzehsxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,6.6 v2 2/2] netfilter: nf_tables: allow clone callbacks to sleep
Date: Wed, 19 Mar 2025 06:54:27 -0400
Message-Id: <20250319055759-75ffcae0bed77b63@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318221522.225942-3-pablo@netfilter.org>
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

The upstream commit SHA1 provided is correct: fa23e0d4b756d25829e124d6b670a4c6bbd4bf7e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pablo Neira Ayuso<pablo@netfilter.org>
Commit author: Florian Westphal<fw@strlen.de>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  fa23e0d4b756d ! 1:  aba47a0bb9bcb netfilter: nf_tables: allow clone callbacks to sleep
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: allow clone callbacks to sleep
     
    +    commit fa23e0d4b756d25829e124d6b670a4c6bbd4bf7e upstream.
    +
         Sven Auhagen reports transaction failures with following error:
           ./main.nft:13:1-26: Error: Could not process rule: Cannot allocate memory
           percpu: allocation failed, size=16 align=8 atomic=1, atomic alloc failed, no space left
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| Current branch            |  Success    |  Success   |

