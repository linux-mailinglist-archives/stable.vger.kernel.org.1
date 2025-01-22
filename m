Return-Path: <stable+bounces-110237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F349A19B01
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765903AB518
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 22:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1B1C5D60;
	Wed, 22 Jan 2025 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2aEiUpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67E1C4A06
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585535; cv=none; b=AGPqVKX4sHa0t/TzYpBbDhqCiFLy0xBYX+Ky2XB5OpG6hkG38Xlt0ENhcHSRCRJpJ5r49aVDcTXNCviEXrOYf46OPGtZ3wGGAT/X+ln4wRwDKXJYbk9vQZf4A4bcsRiUsiSEFJC7Kt6EL4cCT57Alof0CfwPJo2A2ayoBxbb984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585535; c=relaxed/simple;
	bh=lkRSndS8hyef6xuTmNfZcTdeJVttg8KIBBMQ99CmiYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMXw/HZ57Ox8teQSG65x/ZrlX5RptJQxO/35Q3ejEP+k7T8h7QDf51PufbI+BtlDSH55ysM7L6bj8Out18A+YOegy0x6XNuZ+6DjkjxVs5hv8q1nw4hZl87tJHljoy5nk7h2WliDauSo93C3YDTVx/Y8fTKO6yssvi8Czgx9SXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2aEiUpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2947C4CEE0;
	Wed, 22 Jan 2025 22:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737585534;
	bh=lkRSndS8hyef6xuTmNfZcTdeJVttg8KIBBMQ99CmiYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2aEiUpA5/mfzVtodpLdSkNl88MQh2j6OQ8/dQUeIzsuJUeE6jlTsxYhrzwJDR9vI
	 HJ327W4vupPiOzmTmhIMN0PI9xIhkPzqoAzMF7DCoSiRBPGB+VnRzeMQt1iMLUebKn
	 2cEaBIu6aF4XbLrtJWiWYmOVE1jaEarLuP0bdHBmLTpmD2lQeCBBs6OegqAOcmQ64p
	 yJrF8PRFL3YitiA6ULPZs7aEPAOVbh0Ry0ZVHXlzNQHIdZsoSQHTB5wXrtY22HPFpy
	 PxCN/ElqBWggnALohDOM3q7f8Y55D9gV28+TTTN5shwv6n7+QVR3DlvD+zBPwk1Fuu
	 5jI8GeegdGA6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] net: xen-netback: hash.c: Use built-in RCU list checking
Date: Wed, 22 Jan 2025 17:38:52 -0500
Message-Id: <20250122143830-2c63e93d0cc2d07f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250122174344.10000-1-hagarhem@amazon.com>
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

The upstream commit SHA1 provided is correct: f3265971ded98a069ad699b51b8a5ab95e9e5be1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Madhuparna Bhowmik<madhuparnabhowmik04@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f3265971ded98 ! 1:  3a1397498ef8f net: xen-netback: hash.c: Use built-in RCU list checking
    @@ Metadata
      ## Commit message ##
         net: xen-netback: hash.c: Use built-in RCU list checking
     
    +    commit f3265971ded98a069ad699b51b8a5ab95e9e5be1 upstream.
    +
         list_for_each_entry_rcu has built-in RCU and lock checking.
         Pass cond argument to list_for_each_entry_rcu.
     
         Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
         Acked-by: Wei Liu <wei.liu@kernel.org>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
     
      ## drivers/net/xen-netback/hash.c ##
     @@ drivers/net/xen-netback/hash.c: static void xenvif_add_hash(struct xenvif *vif, const u8 *tag,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

