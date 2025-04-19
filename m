Return-Path: <stable+bounces-134677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA05A9432B
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E651899E44
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C51D61BB;
	Sat, 19 Apr 2025 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6rWJZi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFE18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063218; cv=none; b=W+EXq68Fph9RMgzCNSHnMdf4ylF127PCtTgRh3hkfDqmx54IIsRszjh7L2SjzVpf1mCaVZzErbnoaMjTiAzlimHhglcWS6yItFdjlxcg7jSrcR0FElqvWFOXbH0Skc2Gqc0U36/gcmGBSXpDimtxtqSmWLEIRpOdCVAO9rZqzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063218; c=relaxed/simple;
	bh=PrREcWetjGx473lys1QpL0K9hSmo7ir91p3rzRjmxTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIzodRI1zbUwUwlFgZGBgUvvFJuGRxzJNRJSqqwwCCiCHek6xp4HmcG6MzxFlJOX/yWNknt4Hrs8OmN48NiaCSClQ6o6pMsmR1I1SvvMl75j5y8xkR+Z9eKC6dcDLzNc0jLvtN9oiRUx6b0gTam6WCinngnPM4AmusBq9Y/iTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6rWJZi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE256C4CEE7;
	Sat, 19 Apr 2025 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063218;
	bh=PrREcWetjGx473lys1QpL0K9hSmo7ir91p3rzRjmxTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6rWJZi6VE22pYQrHZ6nKfpXZ5JvaclT7nxE2KLULLbenPmbe4nWakhmJa3cHtVld
	 MuMxTjCI5SHRndyTp+vi+LDDPWCTTtMonYMZWPmm8wBAaWnFhhzkYTkY6MDlUkOL5t
	 9dcdjMPtxewLGDRQoPwRjQHk7rZAlmY0/0QSwXWKPUMHN27EPgOARd9bTQvcoNzyrS
	 liXv74T7znFoIM0yId1mo8Kx5N1AKzbtLo+62eGGz/xEaBUm6LBsL6s6ke6hLxU/Un
	 BqvjH7xQwUl4WPnvspwJK2qI1215c4LKt5Pw0g1Fq/LmUDgvdoqstF/HsaDUJFUP4G
	 iyiJl+4gIBy5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Sat, 19 Apr 2025 07:46:56 -0400
Message-Id: <20250418162106-2ac0ad60ee0591b1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418120603.2019706-1-hayashi.kunihiko@socionext.com>
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

Note: The patch differs from the upstream commit:
---
1:  f6cb7828c8e17 < -:  ------------- misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
-:  ------------- > 1:  6a1e525988589 misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

