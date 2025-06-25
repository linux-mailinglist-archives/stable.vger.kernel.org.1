Return-Path: <stable+bounces-158584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF5AE85AC
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553537B2F2F
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B21266582;
	Wed, 25 Jun 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMCZa/S8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7769266B6F
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860453; cv=none; b=T1yguZ+SDDcpNojMaQHzp9TGSNxNKPSGQMOT4NiFpPCDToaJ1PtGZFvdEj+VS4kEWz/AL574BCm1055lyAj3GuGWx0zkZ8Patits4uRH3EnreP25iY6N6b9M7aRfbRk8bX6g02R6tVDMn0cA92oL+3WNHwgqT0Cg4MQuZqIquEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860453; c=relaxed/simple;
	bh=7m6ZbY/Pt/BkWKvfet+0hVZhkkEFrS5LYWZWmUpSRVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBID28ORN1EETo2LK9mVmT/q7P50mhWZnZFfv6MpD9oHpTJqKaLyPmu8HUDmiGKcmD96gYL0/D6ilzGj5iIiGFAXMa5qx7o3D7v9Utu7brM2bik5qgmrW5JuRtNZ1U8w2RPxdAXJuc9Rh4nE2YCW2gs09C5UyO2aSkpsRYtHBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMCZa/S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F60C4CEEE;
	Wed, 25 Jun 2025 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860451;
	bh=7m6ZbY/Pt/BkWKvfet+0hVZhkkEFrS5LYWZWmUpSRVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMCZa/S86yR1LOCCd+dQbY714V4KfEH8Ha8bkLPsCyiqCO/XTsf3kgOcpKaeGR7dl
	 plOZjFjOpJ3h+Ir0xTJhRh5/Z9rAuqwUj9Lm+9DupIILoTke6XdhXYA2/nLqPO3WZw
	 PwZBCyhy9Yp4H/veG3FDR2X4lTD+gBISlbitjv/2erdy5pfcC2IqcdJLgo8/8iBP1z
	 dEhqzxmfAIz+VvU7D0KsBu3Pfp6iHSHozY18CgmzeiEPw38v9psaEPqyfAX9iQCAov
	 G6jrB6Va+He0fiMvdalW+S3Gmprj2bNZdqzfZNPXXRS2RA5/4zkSoONdna9BxAfXIm
	 nGzpMKOvVdGcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Wed, 25 Jun 2025 10:07:30 -0400
Message-Id: <20250624193440-22584b39d0dc9bc0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623102349.2826464-1-schnelle@linux.ibm.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: c4abe6234246c75cdc43326415d9cff88b7cf06c

WARNING: Author mismatch between patch and found commit:
Backport author: Niklas Schnelle<schnelle@linux.ibm.com>
Commit author: Heiko Carstens<hca@linux.ibm.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: 003d60f4f2af)
6.12.y | Present (different SHA1: 578d93d06043)

Note: The patch differs from the upstream commit:
---
1:  c4abe6234246c < -:  ------------- s390/pci: Fix __pcilg_mio_inuser() inline assembly
-:  ------------- > 1:  401cf9483456a s390/pci: Fix __pcilg_mio_inuser() inline assembly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

