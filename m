Return-Path: <stable+bounces-119790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C6A4750D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B118E169A88
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC531E8336;
	Thu, 27 Feb 2025 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO409wo8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA03209
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632899; cv=none; b=JSQkY2BRM+EZylhjbEbED2AAGxjvwatGI/F1KRfAvFmquWJXyg6ThTgRdnq4VpACPybtvj1YX2/NfY/MkzDThfBA9xd0PXNnWtHnarq8RFxr4jGHekMnrqG4GeG/dlsPU18CvUCzmoJG+LXA4l7yxqki6BmNMrfTfVvD90aglKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632899; c=relaxed/simple;
	bh=b7B+aEIkgj6bwAx3eF8jAAhzcimpvHhyTEDRNP95hMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFXtbgRx3MtDBv1/58l4WBp6oiioXcawKKbNkFxwTs17lqjXIYBYzFyhl9tsj2p3Ky02kAMmS9K69rpzFHakEoZKpqtfa+CRMvIhDdXastmdpCCb42Yk1I8TjhGEjxn/dRV15gunEynip9NQfKeDFPBpyPvso4XQQFA1P8bShXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO409wo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AB5C4CEDD;
	Thu, 27 Feb 2025 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740632896;
	bh=b7B+aEIkgj6bwAx3eF8jAAhzcimpvHhyTEDRNP95hMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rO409wo81P9SeBkpBjOGJYjLrO6K88xUQ0NkjBI/M38K85Q3icjMKkjWbY9orQdI7
	 /Q/0wzLOT1k12FNYmtl+DsJsZLUPra1SSNKtggKF8hoOIQVhfq02CBS22tD2w9/XL5
	 IqbrPTfJJrYPHiRmJwjl4JRKlPL23+UyfiaupXNBg9b7OuZjwZ8ZXH42Ly697w+lR2
	 fPc21SLeq3FUrPjXbBJZnouhGR/u+QPGkMsf94u4cPcAtCGeiC4JvgkowISei7CjXo
	 eJZjUIyl7qJbR9FyJDbRPsYukcHHPaFc/vbEdPPTsaRdvnl2fQIk3l6t5Nc7VNHQJ9
	 WOxGD6tr+N2vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Squashfs: check the inode number is not the invalid value of zero
Date: Thu, 27 Feb 2025 00:08:14 -0500
Message-Id: <20250227000645-d0d28f48ff85b650@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226081646.1983643-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: [ upstream commit 9253c54e01b6505d348afbc02abaa4d9f8a01395 ]

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: 

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

