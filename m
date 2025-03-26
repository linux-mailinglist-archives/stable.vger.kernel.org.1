Return-Path: <stable+bounces-126665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F76A70EF2
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D9E1738BD
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29FF13777E;
	Wed, 26 Mar 2025 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeCP7JrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729CADDD2
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955835; cv=none; b=XYLV4Jy6XhlmW2531LFMfhStBXjqeCGNp6K6pBV8dlV4Mipue1Eu2k+OMtQEu41zyDQowELSpGiZOitR2A6VFh1Fa2y7avoEboU/1KlOG2M39nqMFwq3iSy0jwjuY8QGY7JYoOK/YwTILqW4iwtWXjc2x9LXC6JODVQ5AtZWiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955835; c=relaxed/simple;
	bh=7G3y45fbWl8jE9SoUt0tHEGaZmNRJHYMR1XyTba3FBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyrmuzQ4h8jyiiBswrUlMydRSPqLXFfKI5MgouL6rvWZGJxMu1f6ZX1so4YiWpUeF1hWpa+4HlPj76Prpg5WwMuX28ZvNczwremb6/LhIumwHavnRY19AUm5ytqIR+cdzWzdhRcDCF4RD4RqNy5cbZgQ52Hz7l4K5fPmj0vc/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeCP7JrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE162C4CEE4;
	Wed, 26 Mar 2025 02:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955835;
	bh=7G3y45fbWl8jE9SoUt0tHEGaZmNRJHYMR1XyTba3FBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeCP7JrAD0+tFBrxXpJp6R92Pel5FyI96ZN0EMNRFpEdNa53Y4SNt938wy5Q8iIxx
	 vddLrGDsSsirObhl9kblgo38hdZeLCvIm7cxpTs0xoS0DmyZMD9vbw+YF912mrh01h
	 BGCuwJ4RmXzQZtpog//hVztUZ5AlxRxiONvN/ow5yt1gecf4c8cfr5KM5ODMx8GuFy
	 D1keATFzs++S6bs7TiXK4j0/E9lOsGOcolcniYCxOOgt7s6B2cBbtP4qjNOOxR3iB4
	 AQ6vScJnFllWpxMIhqffC3bT7/hZ/31KTlgGRirfG23242W2eBFl/VyzpIeECYA5N0
	 +pCsRsNEIOQPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15 v2 2/2] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Tue, 25 Mar 2025 22:23:52 -0400
Message-Id: <20250325221057-e2d36ec53fa2cd7d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325192246.1849981-3-florian.fainelli@broadcom.com>
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
ℹ️ This is part 2/2 of a series
⚠️ Provided upstream commit SHA1 does not match found commit

The claimed upstream commit SHA1 (82f433e8dd0629e16681edf6039d094b5518d8ed) was not found.
However, I found a matching commit: 47e55e4b410f7d552e43011baa5be1aab4093990

WARNING: Author mismatch between patch and found commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Ilya Maximets<i.maximets@ovn.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 82f433e8dd06)
6.6.y | Present (different SHA1: ea966b669878)
6.1.y | Present (different SHA1: ea9e990356b7)

Note: The patch differs from the upstream commit:
---
1:  47e55e4b410f7 ! 1:  66e6e2e57279f openvswitch: fix lockup on tx to unregistering netdev with carrier
    @@ Metadata
      ## Commit message ##
         openvswitch: fix lockup on tx to unregistering netdev with carrier
     
    +    [ Upstream commit 82f433e8dd0629e16681edf6039d094b5518d8ed ]
    +
         Commit in a fixes tag attempted to fix the issue in the following
         sequence of calls:
     
    @@ Commit message
         Reviewed-by: Aaron Conole <aconole@redhat.com>
         Link: https://patch.msgid.link/20250109122225.4034688-1-i.maximets@ovn.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## net/openvswitch/actions.c ##
     @@ net/openvswitch/actions.c: static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

