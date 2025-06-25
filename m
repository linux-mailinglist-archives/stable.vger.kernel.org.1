Return-Path: <stable+bounces-158582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766BAE85C5
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCF06A5824
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB74266580;
	Wed, 25 Jun 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkZZTsV5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB9265CBE
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860450; cv=none; b=GmSiAIjbs6kT3Xp7CkTXLsJSvgqjRlG3mFf+PfsTdeRzzu7m3rDRjbtEtV070CbDxuYu8av4ApM18m+oZgXvq9A9T558F89zv1xUZzT/3WKQSP6ViAVTTA5+7IKE4YGPIGzuND91NPrk0TPqrBcP8cfYa9Il7BxqwRaHBAYxXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860450; c=relaxed/simple;
	bh=P29f6BsrhWbVoftfuaNMoQkZScvNuvxLfEmqsJVhr2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGBpl1xOynibgRVwUQRgCtwN9oUAlQ/JymmGeDsyrbwCuoh3CBrvMKUCXA3BRkZ6zQaXjJzlLItu7k38DfHnKZWHkcn+V43mdp5KZ/La51Z4teT0NfF1yEzHQHtG8r59vL8LjH6TPNQuF3cN6opmLN0WVtEftff17wRdvFant20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkZZTsV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B117C4CEEF;
	Wed, 25 Jun 2025 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860450;
	bh=P29f6BsrhWbVoftfuaNMoQkZScvNuvxLfEmqsJVhr2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkZZTsV5h+FF03dIgCp1eqWnhrgFMfen8pkf5jZvJn/RCcT5z/Cm1UEDnqafw8UXu
	 y4VXlemIElzz2ijnXCxsZFLvHmQpECqpwfbMLqYdWydcUV2Eysk1cjcnMQaN2oFukm
	 yTfoyhd94zquar791YNXTD1b77/U/3XvKcXMbUvE/7B0PGDn2y+AKv2iHWeMPsooaw
	 gZkFckdKM+E0WDhcmNWsmegM3gjrQGjJ7Uq35Ck1a073eSUmiJMhziHvQ0xHJPfxUN
	 9IbjLHVxR9hWzH/aCFLhX6dC2pzLN1i6dqeLxs+iLtE5K5n0LU2RohozQ1I4d0ZEJV
	 Z3cVf1qzt+16g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Wed, 25 Jun 2025 10:07:29 -0400
Message-Id: <20250625001230-cdf2aec1a88afba2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623110859.3456221-1-schnelle@linux.ibm.com>
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
6.6.y | Present (different SHA1: cc789e07bb87)
6.1.y | Present (different SHA1: e0e15f95a393)

Note: The patch differs from the upstream commit:
---
1:  c4abe6234246c < -:  ------------- s390/pci: Fix __pcilg_mio_inuser() inline assembly
-:  ------------- > 1:  2bbce0f219279 s390/pci: Fix __pcilg_mio_inuser() inline assembly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

