Return-Path: <stable+bounces-109466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91843A15EA7
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52E016620A
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8C1ACEC7;
	Sat, 18 Jan 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZN2Jkl3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C554723
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229269; cv=none; b=iqImSWU6pwOHMVrwWIKxn8C7Yu/luWdXGTO2K461B+k7m/s6LfP07XG2NKq5EoFOr3kHF5cBb8LSK5BEsXOasjFX2P2zbkqCIgJZTE1+XvPL6BK+/qBnX937AI58Bzs4kpE6hQJ8evCT8HVisJ8lnivg0GOpU6HdXtpV1g2B0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229269; c=relaxed/simple;
	bh=SX797ZhanMiOoXapdzPMAZYKG222BwTdOpRDkAzdEVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slLbm3oGCF2BTRK29kWm9t03mX9w9CTpiC+mPWY8mtbU86oWniQrf/PufwTJ9woAWEa52Hdp34TvvcqhwIYFmJG63N1qSI/J1bSCyAqgwSBizaujsywfaIP0wkejSCGFutQt6BoNX5788Rq2mwjfJI3m515lcQwEWRMVrQG4Xao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZN2Jkl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64EFC4CED1;
	Sat, 18 Jan 2025 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229269;
	bh=SX797ZhanMiOoXapdzPMAZYKG222BwTdOpRDkAzdEVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZN2Jkl3wJlSQCtwnEQF9MzbrN8SOoyogxlJ0oAg+N8rwEojkDb8KA6fJ621e8BtP
	 6lbxlip/N2oQQdLAY3+KV6oxBImN4TJmYvCOYQZpk83jJVJessh8u6f385a0P93F+g
	 9SO+5Er5LSnmqMzoiW0vt4lTwFunPqv9BVxvNWRYm//FBJmmLsB5qwqzWXKKK2dho1
	 vidDj/PimCzumqcmi9yKQ3CThgeqN3cg6+X8p2kVDXw1BgxU0ixfx/p0TySiD0BDMF
	 pmJH8B+oVvsoIpYP/x/3JDoa2ssqtiCXmS6zwi8sVh7atK4bfo61MkFKihQIhHPOlV
	 eCzt5eL55sX1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Tritton <terry.tritton@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Sat, 18 Jan 2025 14:41:07 -0500
Message-Id: <20250118133119-af8f85e92af86220@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250117151651.6468-1-terry.tritton@linaro.org>
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

The upstream commit SHA1 provided is correct: 7246a4520b4bf1494d7d030166a11b5226f6d508

WARNING: Author mismatch between patch and upstream commit:
Backport author: Terry Tritton<terry.tritton@linaro.org>
Commit author: Vidya Sagar<vidyas@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3e221877dd92)

Note: The patch differs from the upstream commit:
---
1:  7246a4520b4bf < -:  ------------- PCI: Use preserve_config in place of pci_flags
-:  ------------- > 1:  48aaac1a5442f Revert "PCI: Use preserve_config in place of pci_flags"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

