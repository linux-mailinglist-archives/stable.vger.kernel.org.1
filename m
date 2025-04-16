Return-Path: <stable+bounces-132862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D6A90659
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4386B1891D08
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29822087;
	Wed, 16 Apr 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcvmKRdp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22F2C9D
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813480; cv=none; b=J2OCdDUkWIhNok1b3toftaIltPm7j74tlUvGp5WHlRt1cBl+hUe3tdFT0OqYzIae7Ar9w6uAmTBYUJCypldfClPneSlyaQ2q04xmkxLomBrvSWo3Eku7G/8XKQ+0E7gYXTxKulDt1Xy19wz8LLOTx3Ifx6MEeuRafKiIFVyrGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813480; c=relaxed/simple;
	bh=7Rf4xz/g2AMyEVAy2TLqPWhFJjr+u9So7L/D64/hSGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+xE+4NFPSn1/azbxFesLdJHtRNHhwDYBf0bfIwgdG54M21f2xMacvaFp+oAEQ9a75Fi+RCdE74/07IeKP3r/dlnr6ylU2XVfvKgi842mjDSvteoHJR7Rqm4bHTA/OC5k3MFIW1o8hnRfOp6i4vpmYGLo4uhf3AqaNHwjoF77G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcvmKRdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C49C4CEE2;
	Wed, 16 Apr 2025 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813480;
	bh=7Rf4xz/g2AMyEVAy2TLqPWhFJjr+u9So7L/D64/hSGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcvmKRdp27EOqJN4XPxavDASsQn4e+7Y3xexwumpf9+nPBhJpi7nGALcih9OD0s6u
	 t6oFq1hfVrfWG/qhgsmfGrD3Ra/oxpG7u6Fy3JDWjge8lgqhMnznHeTlfxyd6dGaqZ
	 iQ4uN2VuQ388o+oT7ur33Wgefgij+f5VeEcj9f46ChRZIl3JINUX3ZcXCRkG17mV09
	 6diKBjcN71YZwhPG1HsPhNQXykx4mqGcZJyEw15oVXuSya5UNbcTulltptBkET76sj
	 dWii+U0rCq29I3MFmKS07hzTLLr4NIec6FQo38WMBjaCqGsj21rYcpM+sXVIN8FdNT
	 tk7cERqOkfuTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] smb: client: fix potential deadlock when releasing mids
Date: Wed, 16 Apr 2025 10:24:38 -0400
Message-Id: <20250416092932-fe1407d02f78bbad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416014726.2671517-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: e6322fd177c6885a21dd4609dc5e5c973d1a2eb7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c1a5962f1462)
6.1.y | Present (different SHA1: 9eb44db68c5b)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e6322fd177c68 < -:  ------------- smb: client: fix potential deadlock when releasing mids
-:  ------------- > 1:  f736d536000d7 smb: client: fix potential deadlock when releasing mids
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

