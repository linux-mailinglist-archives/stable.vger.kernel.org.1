Return-Path: <stable+bounces-158596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F89AE85CA
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC141895797
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C92652AF;
	Wed, 25 Jun 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyAXyXR3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1BC264A84
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860548; cv=none; b=mlnD2IT0BmxyC9iEq4wOAfoBYCjtopkTJ1U69S09kVTmfLoFY0VnFCqVtHZIC15dA83WIUA+7333yIam3RK4csHvSiZDeoLSTZ7uOT4tztMcss/V9CbxO0PpLGqsBPF79bOe6IvvQ9CsWCUaHwqg4B24p5yf+i4u8l3j7hKgoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860548; c=relaxed/simple;
	bh=DtPRSKlsRkQQar6TDZhRI2LbkVqlNPrpuiBt7oJrsaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7nzyHGiq6+WnvpMEm70RLqO9SPOmbwjwhBx2MUSTNZiaFVEYNfFZs3KHnSv9o+kbVuBz4Zae7m2tYEHd/EZADkb60TpqtkRH2vJbPDVO+SmYgV89V3J09jHuQlKCt9MjFCjWjzLpg9f7N2+hMEsVw1DycZ+Ke91+YRgLA63vAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyAXyXR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2D4C4CEEA;
	Wed, 25 Jun 2025 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860547;
	bh=DtPRSKlsRkQQar6TDZhRI2LbkVqlNPrpuiBt7oJrsaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyAXyXR3LA0pVeXwJivBCIi4FnCB40S414JLsy8WYNh9qf+yLGDWGjjpmF5OVICLw
	 G0VamR06xrER+je3kAfZFiUAUifggacLxRhd8s38+Eab18fnR4zwumuemMOVNHoAdC
	 6zzATfd5rXWWCXcU9dy7lO108aKRmOn6ifMD58G3k3zrB2129iTOE9lEvXboyb/d6E
	 CrC/fSxwaEMwgBEHrMezhN2KQpi9wcDC7Sxn0yYw/hhO5oABxDQPjJ66bqNy5ax8Tm
	 mcNdmOewWuBzXluvRpP7gdqto6SMa32eLXAHwK40fLngd71EX7njPzfDmhf2P57Fk5
	 aW/7rWl7zI2Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
Date: Wed, 25 Jun 2025 10:09:07 -0400
Message-Id: <20250624173422-5f3c01e5e85cebb0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623133914.1024961-1-hca@linux.ibm.com>
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

The upstream commit SHA1 provided is correct: 3b8b80e993766dc96d1a1c01c62f5d15fafc79b9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Heiko Carstens<hca@linux.ibm.com>
Commit author: Nathan Chancellor<nathan@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 593d852f7fe2)
6.6.y | Present (different SHA1: cefbf9f892ce)
6.1.y | Present (different SHA1: 62d33b9e68bd)

Note: The patch differs from the upstream commit:
---
1:  3b8b80e993766 < -:  ------------- s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
-:  ------------- > 1:  10199ccc6ed3c s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

