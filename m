Return-Path: <stable+bounces-150599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389DACB959
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C671D3A7F1B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F4224245;
	Mon,  2 Jun 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qicEr0j9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BF70814
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880873; cv=none; b=C93pI71itxmZ6tr2OUwS05PLktM+wAKKj0Awqv7FuLCJeKmZyLdksqBjElRYuZNE74QvGdBVjJQ39+pGW1Qa4gyP78Idcvb1+p6fLRhm3vhAcfyrsAtLh8FAFGnfpBKm8mh8hB3NefsG20q2xOGkiCgLsriWi9RUyormZzq1wpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880873; c=relaxed/simple;
	bh=Fr6yExkzeLm+ahj/cMO+Cr16Gdl3dxQtJOUia5azcrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbiCRGumk02b9FW73k0osTH6BuPf1TOhyyg51GwTYls6TcMlxfncRlCzsxfe2vTIb8zLtVovU5l5f0Nxiu3KcaDCgupfp0W00lrcuuEtNOJezvKpCz7wXMfc2TguUb1bvYaCmt3GVgkCY4NP0XICwVTkBGLPZTPbWnmVAF+NEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qicEr0j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5069C4CEEB;
	Mon,  2 Jun 2025 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748880873;
	bh=Fr6yExkzeLm+ahj/cMO+Cr16Gdl3dxQtJOUia5azcrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qicEr0j9Rk115/N6tN2O2U0x9viL6ESPjH812HijrP+9PWqiDBrYbpVF9Rw39BPQr
	 /Qc6ZWKGrrYuulcdJQHgCEVwv7i6zHYZtK/O5dEDSR33thq1oFdv3hnlWXY+2rQwjU
	 zwnAJs6Nkz/dffkAshj9uD4Ns241RyvrCDnuRrm/NjRkbdO+kiXQNszCyKRmgiQiMB
	 hVHKkqOK/iUuCxL1Sj1RQoo9bXTFlQNeZA+wEqUl9LMrCKsUaMlmiSaAYVAaA0guRD
	 2Q8X39E52uvZdtZbnj+XMYluful6kofOvTEp0W2qptoDBICMBSVN+rJ/B0Ie7EKbYj
	 2taCLqJ2FWOtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10/5.15] perf/arm-cmn: Initialise cmn->cpu earlier
Date: Mon,  2 Jun 2025 12:14:31 -0400
Message-Id: <20250602093940-487065edd0d224fa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <32923ed9af28f3857fd64f7cd884895e717258b0.1748861349.git.robin.murphy@arm.com>
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

The upstream commit SHA1 provided is correct: 597704e201068db3d104de3c7a4d447ff8209127

Status in newer kernel trees:
6.15.y | Present (different SHA1: 7b6afec7588f)
6.14.y | Present (different SHA1: 6a7fed0595c2)
6.12.y | Present (different SHA1: fb3a1c1d24ae)
6.6.y | Present (different SHA1: 711b013373b0)
6.1.y | Present (different SHA1: 57c8a80f0b02)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  597704e201068 < -:  ------------- perf/arm-cmn: Initialise cmn->cpu earlier
-:  ------------- > 1:  ff356633c92f4 perf/arm-cmn: Initialise cmn->cpu earlier
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |

