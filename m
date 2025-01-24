Return-Path: <stable+bounces-110415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53923A1BCFC
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1F1188FE28
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402DF21A43C;
	Fri, 24 Jan 2025 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWZfbsgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A564A1D
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748324; cv=none; b=IZrY1C+rydL/ExAO85VnxAzP2Pmyq9IMdqHr0JkZXKv3TnQSQPEmPp6iX3P4EHFu3TN8ZgjDpglTYOJiCt/Cl5cX2j1iGMv6PH4s6slek9uPfSS/MZupM5Mvg75zrPVb07Al7dcRxQCnGcypvTALKkFWPd7dXO2QBvMm1AbK244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748324; c=relaxed/simple;
	bh=y3d2Z7OvYcnqIHHJIj5lPrFBZOy3IgxAiSrOWdP91FM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLAToAS1sS9FB+Kj7dS0GiNzKSZD7x1cxGmZxE3GyUrMJ9ft2Xw668XHU6o/HRnzPVH/390BEa0nrkTQvdDQVtAF1JIGQsa1+M/z7+QL4HLcvN6qPPPFoeiw/FwAc7w+bCOJ4ze3P7qagfn8ISa7bHrtPGPX7QjSbmZjmImLjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWZfbsgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155BFC4CED2;
	Fri, 24 Jan 2025 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748323;
	bh=y3d2Z7OvYcnqIHHJIj5lPrFBZOy3IgxAiSrOWdP91FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWZfbsgKR5oAnX3d/adbIS+cVBKJbdawuAHyGzZ61aA/iAS5eV3QdPiW7CCGS5Zis
	 MmeNHBRGiBFPFbrkb0skXJI5Zy4t9YRaOzHKsC7kxBMN0pOpfv6WLBHeeu58GBxclx
	 9c9nA7oEMS2404xivkLbnm9cxUYaOEKGSqsnkcbdt31bAtuhZ3mDUEPPOKb3PPDW/V
	 FkvG2fcf+3+MzC4XEOoWMwDAYPxmWZLnYQsPTppVIGjtjaK5HsD6ANVJX35H6OBnei
	 ITLnl04bPBZuMfek069k51GdvUQYko8OVsHp729jqw33Icq+OSDCfAv4Cje0mQddoE
	 iHrTQM5qwdEvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 v5.15.y 1/2] Bluetooth: SCO: Fix not validating setsockopt user input
Date: Fri, 24 Jan 2025 14:52:01 -0500
Message-Id: <20250124094023-f00b04ca1a322c0f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250124053306.5028-2-keerthana.kalyanasundaram@broadcom.com>
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

The upstream commit SHA1 provided is correct: 51eda36d33e43201e7a4fd35232e069b2c850b01

WARNING: Author mismatch between patch and upstream commit:
Backport author: Keerthana K<keerthana.kalyanasundaram@broadcom.com>
Commit author: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 72473db90900)
6.1.y | Present (different SHA1: 7bc65d23ba20)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Failed     |  N/A       |

