Return-Path: <stable+bounces-108296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D48A0A58B
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 20:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036F43A8703
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253F1B4237;
	Sat, 11 Jan 2025 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thFWsoCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9B22083
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622298; cv=none; b=LhA4WOg5ycUUiZgGzJ4MGxePGRgVN7goDneT2FCnkesff7esBy67io3hAcAanj7A97rJprsxtDoPcEgKQYU24EtdWg0eB8gEXCKFBhZsLHEinywf8Tp401qNRb0DNe8eEQspwRN3pCeB4TTNhR7/J0Wxa0hX7oXl+DNA1lvPNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622298; c=relaxed/simple;
	bh=xeeTGAxbZzl48hhiE2s2gw7eXv6A6FlFJK59yWOpb+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3FX5fStlRCrVs/hN7AYl640LdcDpOYh8IK4uutt/NWbqi9JxZe/EjDoYweUfMy0db4+jHpx2u3aQt96FKJKUPLzMaPNyI841VuYptVIOJhE7aB+XedwVhwnszv3WnSVA4CCxu0Gn6S/K/An1z26qsAt4fZDXGcBi3X0Ge5v6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thFWsoCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8E3C4CED2;
	Sat, 11 Jan 2025 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736622298;
	bh=xeeTGAxbZzl48hhiE2s2gw7eXv6A6FlFJK59yWOpb+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thFWsoCYau7NYFIbXiMMysR5y17QueT7bfDW41bRHnVEAeFH+sAmxjEh9NFKMSFjJ
	 76f3j9pwMHhvgmcUWRUoUDpEcYH3XpdOXOgWe/oFpryWzZwWutPEVmTp4o1z4TVtFS
	 WmGxL6dGUdSm6dS82/zKR0rjWFTfUm/Xq3LMWIZ3XAtDenOHXNlBwxrNvDh8czLsCk
	 yavCtNB+ToPngBl/ugo2GpTKv2hPlsxSfMKjvtmLn1GyLNfrdopCNC9eY+YIoqcI57
	 Kw3sLXEa6+0rOGyYi/WDBVsG+h+c34ur5eHi8zreCJtPBM0DCltHbnbCh2LkI28tbM
	 qAOz3q4rq1R0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 3/3] zram: fix uninitialized ZRAM not releasing backing device
Date: Sat, 11 Jan 2025 14:04:56 -0500
Message-Id: <20250111134018-34f885f17251392f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250110075844.1173719-4-dominique.martinet@atmark-techno.com>
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

The upstream commit SHA1 provided is correct: 74363ec674cb172d8856de25776c8f3103f05e2f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Dominique Martinet<dominique.martinet@atmark-techno.com>
Commit author: Kairui Song<kasong@tencent.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 6fb92e9a52e3)
6.6.y | Present (different SHA1: 0b5b0b65561b)
6.1.y | Present (different SHA1: ac3b5366b9b7)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

