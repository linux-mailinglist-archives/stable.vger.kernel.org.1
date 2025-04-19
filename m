Return-Path: <stable+bounces-134684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67CA94333
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71716189A0A6
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3B41C84A1;
	Sat, 19 Apr 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LicyLjzt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65B18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063233; cv=none; b=f645lEViFc5vdQObBLPW1NB0RnXPHIRKHGeHLFkubQ4S4r/+muuZ68Nlp+OPTnExGBb06LEjdYFYDAaFRoNeMEtcx8ojdTTtcVsCZzwk8DO2JDh6Elk/fZa0DEneYPuvRxsxkyEcBEog77vZZ6qD6/Ii/xCeh448tLy2EjnmitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063233; c=relaxed/simple;
	bh=3O/E9Tl4I8IiiwgxRgOiNvntFiwHm2imjNSdkim7kTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dw4nPjTyMl8gA2aIIm5iGTzr5hnFgQ0Rf0yNYjA6zsC9mMbpjDoDLYU8EGJ5lIrr0hNcj7oetFFkBr2OS9kSGwwORBla0axjOVyZLUUdUNLbIrASFNYbcs6JeLnJMrFB36iBotjRTh6SK0JEUnHjgt5JBTi586Gd8HzogPyLdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LicyLjzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3461C4CEE7;
	Sat, 19 Apr 2025 11:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063233;
	bh=3O/E9Tl4I8IiiwgxRgOiNvntFiwHm2imjNSdkim7kTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LicyLjztc5aH7+PEWqnqAlVRwmVurDgi9YwrJkdtuu9WPBvonY3og+q0hDbFuc157
	 4E+xwB32eg5Es1YkZj3YykbYSsoFgd6psMbdg4x6uiAxaBZaCSUzYofcBwYhiFgTNT
	 UJD47GZAvvtwjGZGHkGtAbxdAfjBSgcqDmwTRHzPdUTn39pNxcUBFLLA/fGH1cCBbW
	 BYzbgdMtUs1kxFPWxoQcTMV4fUXEVEugitM3KJmd7mJG+eVOZzd47hI8X/ZjS1hBHU
	 C3fwZAMRD5o5VNrG1eYiQPMWkClvfj0795c0e61WdMX/e6ixEcgOWduFDoJqWMeERs
	 +xgrMGKS6iXUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
Date: Sat, 19 Apr 2025 07:47:11 -0400
Message-Id: <20250418192336-a756757767d6030e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418122531.2031985-1-hayashi.kunihiko@socionext.com>
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

Found matching upstream commit: 919d14603dab6a9cf03ebbeb2cfa556df48737c8

Status in newer kernel trees:
6.14.y | Present (different SHA1: ca4415c3a46f)
6.13.y | Present (different SHA1: c52bd0b9e72b)
6.12.y | Present (different SHA1: 4616cf3fc00c)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  919d14603dab6 < -:  ------------- misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
-:  ------------- > 1:  a5476ac6e22f7 misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

