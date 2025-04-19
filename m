Return-Path: <stable+bounces-134686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B68A94335
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8A17CD46
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061C1B4244;
	Sat, 19 Apr 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4u02uTC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033A18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063237; cv=none; b=pFVTABH0Wm3r5FPFX/Drh/YnhZvaRWLSSa7H5slKVkGjR/DJ/qVlupwvyJMLEmgMBewlfDVEvlP1NeH/wtSNB7MSGgyuRrmsC9IEccRVwMFNK0bC9nIVZN2/N7ycD+IetrNGp2RX8KKjvy/Nki/9P2SW1qg3EA+RQ+c9g6qLlPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063237; c=relaxed/simple;
	bh=Qt1AgFzP8bPWtLfbDzIlRP35xT7tubtWGaOJBR33nng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BV/xwRvgVJoZjjG4Lb18eCE0J/9xHRWePqEOLYYTNTQqpFmrg0BY5BjpsSHGqrucj2J6jNq/sMs0SfDbg0Mjf43ngvYUn/HHtRyBEzXjUG/QHBbAtJu8HTbmrNTe/06OuQLRej79ZAiGRU3NKUcCAeboF75wanphg51vu3QcUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4u02uTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12DAC4CEE7;
	Sat, 19 Apr 2025 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063237;
	bh=Qt1AgFzP8bPWtLfbDzIlRP35xT7tubtWGaOJBR33nng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4u02uTC0tbak6s+qF+gr9a36B7nDaI/6NMmFcXzGJQYfdoPNgwGWFgzTmBhf7Wax
	 ZnvZQskZNZTdGlk20c4N35aJOMkw31EhRDhU1P3ridVQQQM3OoY/pmUzWeXGzb+2fu
	 sYgb+1H2pBnuRfP9IpkhKwJqf0D8xEWld99KC/bFfY+wbKz2KL3CiSm3tEM/I6RPAk
	 GUEZdKebMhptJoslFw09iBDGrZVC74Xg/VVLcwAfySRSYxTPcD9oCuZP2U/emjRPf2
	 Nl5AkiEPvcZU14fTAigYcpkP1R6Xw+EqqZBGqfG8BF92q3e/zpedXJrMEFpP4eUEfB
	 NyBjk/f+751Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Sat, 19 Apr 2025 07:47:15 -0400
Message-Id: <20250418191353-a83bad164ae5a75a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418120624.2019886-1-hayashi.kunihiko@socionext.com>
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

Found matching upstream commit: f6cb7828c8e17520d4f5afb416515d3fae1af9a9

Status in newer kernel trees:
6.14.y | Present (different SHA1: 501ef7ee1f76)
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f6cb7828c8e17 < -:  ------------- misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
-:  ------------- > 1:  33acf27a96921 misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

