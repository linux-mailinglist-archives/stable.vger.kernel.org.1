Return-Path: <stable+bounces-134707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719CA9434B
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C499189AB79
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E01D63D8;
	Sat, 19 Apr 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7rpSpnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A31B4244
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063450; cv=none; b=jLDaZR1zahgg/QBbfo+wj//51NNSjQ0kogFr+iR68SaPSyjUfhaCRC3kJe7VbkWiXA0/4HDrONBsWrr5aaECsTrN50qHOEj8vjuj2XlYkc16ofcNsXXQnC7msw9ducUv4qiMJH7IHwj1/TZjuO4AM8XK1c92eaI3fyH6N+p7zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063450; c=relaxed/simple;
	bh=HxwLbGHi4S0SkW/o5M7TkyF9aZz8OU2HXOXM4t+ECdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwcHXtxTYX7pI1NMnGugtCxoFX5jLU+mTzx+lScWea5JxiigE8MaVWVphEzWdj0GJS9NmRx9Fr4dl9VZHdKpucU5g7pLS9nmWxJ4T33q2dGnQ9pAokAnoDYgQw48VotE460b3XVPrpcjlHofln7XkrzqedPFI1Kxw437l2lUIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7rpSpnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6848DC4CEE7;
	Sat, 19 Apr 2025 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063449;
	bh=HxwLbGHi4S0SkW/o5M7TkyF9aZz8OU2HXOXM4t+ECdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7rpSpnd30G7q8Hi/dcrPBtMIi+g5ls8TLMX2i/128uwhRfANcDtN4Xwn3hHehB+i
	 bbfEJKYs+wgMdZn3JM3jYsk9kQl5eHAhx0uRrqP5TS9TZPo4aM/k5LHpkav8PiUWeX
	 N5SGmmprwyKNJE2Io1Ewf2w27VnFM9LM1SDPIM+3JL3f7KzWPWOoktucNJzm4sQ7N2
	 L4UZ6pfPMlkpZWocBKu5atiuUmIvmbgxiwrPCQpTIN1OXVogN/hLE5FDRJ99MrUKj0
	 jPF0Dk2DSP4WRCB7EK8FYkaOOfU2TDTlgqj+j7bryj04tj0pElUDHkEB72AgLg+1yN
	 SrRKNnP6Nbgmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
Date: Sat, 19 Apr 2025 07:50:48 -0400
Message-Id: <20250418192710-0addc21b8f2233f7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418122524.2031896-1-hayashi.kunihiko@socionext.com>
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

Note: The patch differs from the upstream commit:
---
1:  919d14603dab6 < -:  ------------- misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
-:  ------------- > 1:  575919693fc4d misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

