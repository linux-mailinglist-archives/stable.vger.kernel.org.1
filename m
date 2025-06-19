Return-Path: <stable+bounces-154757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6619AE0116
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC323177799
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0341A2741AB;
	Thu, 19 Jun 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKKhLb46"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C021C9E3
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323760; cv=none; b=rdQCmzIHkpxPH1NCIVRMRdpGDecX2Qh6NLHtHEfdxG/alXvWv0JokK8vrZw4AxibQsxkWVK+hJrITx3NI53ietS6UfyxsNjiwMG+Xu6+sKh3KMefDNtW0dnqJiN4ZmlHj+X5Xuof4JkndD1NeiF++WW6m4aEclliqTl9oaaUHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323760; c=relaxed/simple;
	bh=mYDO7isNfhg3I3nrt7wLVnwxAdr3PTyaTEi9cPXj+MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4vv/YZOLkicJuZ0pglh1ConmESxmt8qlRKEZWwSKf5i4LonSvXiIvW38jIYBwc1OY/Ao1q+xBZp6Jy6PNOluoufJU0wQsVmB4F+j6Y1yo5et4WYzlHMaagp2Gag+5qs0gUryX0gJVK5waQqp33ZPeJElubA2vtkMevu4qlzWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKKhLb46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EE7C4CEEA;
	Thu, 19 Jun 2025 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323760;
	bh=mYDO7isNfhg3I3nrt7wLVnwxAdr3PTyaTEi9cPXj+MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKKhLb46yCILcCG5vQ4GYtq46T2bBKFIpbKbVeSTFUd4M2xJkSoQ4Gae5SdMrV55S
	 bneyE/NiPYligKk+My+GU75ri8q5b0Bh5rWDcXT/pYnMfhQ0ZDRJSXCSbpTtC51vPZ
	 /jIQ+VlgsRvMaXii1Zb4tS1G6749WoidwZL1+hMGoMaRHjWUHiblgN2UJ0CJq12l0m
	 V+Z0y6FrRIBDOqfLJCfVSluHJ/Pzec8dtFJea+qQ0x9LkRSy1S/x6/KU5T0RujQtuE
	 NkCJzAOvJ/BrDYgpVwgap0ku2+DXXZrQJyhiSPQmFeD2FuQllfVq1eaukvqWL6k+GY
	 fQ2RDVZqXtSqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jetlan9@163.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
Date: Thu, 19 Jun 2025 05:02:38 -0400
Message-Id: <20250618141729-b29222ccaa6efa0e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617111756.970-1-jetlan9@163.com>
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

The upstream commit SHA1 provided is correct: 426db24d4db2e4f0d6720aeb7795eafcb9e82640

WARNING: Author mismatch between patch and upstream commit:
Backport author: jetlan9@163.com
Commit author: Dhananjay Ugwekar<dhananjay.ugwekar@amd.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  426db24d4db2e < -:  ------------- cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
-:  ------------- > 1:  d77c661c72a28 cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

