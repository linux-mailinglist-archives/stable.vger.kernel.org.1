Return-Path: <stable+bounces-164383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A1AB0E9A6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C13563EC9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B9188CC9;
	Wed, 23 Jul 2025 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNFNi/mw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808822AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245267; cv=none; b=FML7IBFJlgIFcJSUKtXlEqQycgFApFoLWsag+1Kr+TzFbXkhrFYtt+kfqxVS5K6tP98k/0OYyqg9GPcspBWqOl5xcFFJnZJcqSzxWUOQ8N5UBDhsiFO8OxhJza6pqBg27utE+AE+tibErGBSWA0NVibJQfVY9Cl5lt6IhbvuKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245267; c=relaxed/simple;
	bh=rTO6bLLR1YNmBBPSgwSH4ipVe0CUkBaFWFPiznoftM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJIC0QecN8zo810HxQTQjVdOb6TFcvmIfTGcx8faWC63Yfs28H5OAYn3egXcwdGQ83r4AEFCrM5HPqJgjwu6dOtBRDTQkAvq8842le4ZAjQRi3BsGbaxvf1BsH/SNdNzbQf3z8lJP0npWtApiIFvM6oqDMxbeKVmAKWCIrdb69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNFNi/mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49DFC4CEE7;
	Wed, 23 Jul 2025 04:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245267;
	bh=rTO6bLLR1YNmBBPSgwSH4ipVe0CUkBaFWFPiznoftM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNFNi/mwUbIchLa7AqHEZfBeN770S+7H095UrNKH1haYqDwY7lPb6wMwr+WoK+Gpl
	 yXmhVZBvSlZ9NLei6YzBvbwWPgtwLLnp3wB8++fSbK5ZdzBocasJagdrZ7NlPZcM6t
	 +gPdss0BiFFwS1ucldDmrg3PnmtkSyZhn6qywm6q1se+oQxCSg+HNPXibJfr85kc4f
	 NcTptNjzAaGPEZCdXfC8PdAAYenCSw4mmiLe7Gq8IeEEmHG8rEroQqwcSL8/7ZMflV
	 CnKCCTuEqB5Q7ExNhJoBgcPShnV8lE1aXaeuWspNZ4ckAEuV4cv+Kg+zzRS8Fq1dcW
	 dof9tr0q386DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 5/5] erofs: address D-cache aliasing
Date: Wed, 23 Jul 2025 00:34:24 -0400
Message-Id: <1753229358-3611a41e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722100029.3052177-6-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 27917e8194f91dffd8b4825350c63cb68e98ce58

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

