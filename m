Return-Path: <stable+bounces-124900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA536A68A08
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD619C276F
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D430254844;
	Wed, 19 Mar 2025 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/1PRYju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC10251796
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381653; cv=none; b=BzF4pQVXdqj/24TvRlGcxlINDs9c2ftZDOjniEWQ4qqiY+ums1hOL2PemsT0WD13N4xa6H3Ryy6QM3iFOpPwe+T3u0sp5MwekRNoGS8PEhc4ktt/MiwOhKQzH3DglOfg3mLpJFB94PcKLw0nqefSVpJZj1efN6ft5RND1Tgd/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381653; c=relaxed/simple;
	bh=K0H6fye0ze8SP6EQ+ZIZatHc7Wgir1TIIaEVVp3eyZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aR5vV5KefJPGV2ZP8stxMBFMN9evUg9O9IRqHnSbuaOi3FCFmZhsk/BAX3PnjCSZux0It/JCnkbAzzP3P4ScjrrTRNjIE6bGhrUd3t/ZLAt5PjH4C8Q2lhCgeiaXs9aEjEpOFdduJhdGc5+PWePGp3dz0O30GBWee9xkqMxPuiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/1PRYju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8B0C4CEE9;
	Wed, 19 Mar 2025 10:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381652;
	bh=K0H6fye0ze8SP6EQ+ZIZatHc7Wgir1TIIaEVVp3eyZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/1PRYjuGpQ/HGx83FipJdAapFBBs1wrARYjS3vOhJe8o0m0rKCfLL9opHi4myei9
	 lJTepRff+RDaJAcpBkpx1Uby5pLBikz0UzahOI4Ixvm4ZQi34690Cg3isKMO3GKbiq
	 4/nsdEAtMovx8pVETaS/1mLIt6FFdN6cP56TRbKC/lUG5kxlJNUgtQX0MvQ5zuQE8W
	 4byQJagM7BAPrW0FmUQvOzH97TxUncGhzjKjU+NsgNevfWdTkjwZFxGHUFkcHD5HWC
	 7WVEL1+uRqsNRdVgbJX6avoVUvJb38wFDj6KatgoKtN6dbvT1w8UhXEIrqOzGM6Db2
	 K/TPVmdd3y0OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,6.6 2/2] netfilter: nf_tables: use timestamp to check for set element timeout
Date: Wed, 19 Mar 2025 06:54:10 -0400
Message-Id: <20250319065239-e7bcbc6a7aa34268@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318220305.224701-3-pablo@netfilter.org>
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

The upstream commit SHA1 provided is correct: 7395dfacfff65e9938ac0889dafa1ab01e987d15

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  7395dfacfff65 < -:  ------------- netfilter: nf_tables: use timestamp to check for set element timeout
-:  ------------- > 1:  594a1dd5138a6 Linux 6.6.83
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

