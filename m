Return-Path: <stable+bounces-151879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3840DAD120A
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490FB3AAB1F
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0825204F8B;
	Sun,  8 Jun 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIs0dXmc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0301C6FFA
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749386937; cv=none; b=MKOUQr0WYPvgsXHhHeqCZ9LfLRqYWHi3IjoWZ7+ZDmLQzekQHciMY2Ln07v8PZF4bgC8SBPzwc8M5LMPGtWm8dPHJJ78O9Vh7aa2990b00d8idao50J9QUN3kJDzvB3pLRATN+g8CMKf9ILAsc04+uUErGhbfTxa175b5PXmxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749386937; c=relaxed/simple;
	bh=Hg1EJQbuSXuDj2iFP9JPnOTxwl3g7372ywJP1TIer9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuZf9euUKGq8O9WrYQntPObdpQ1dl2lKh4WZ2ysRRUEq+q3eXJecL2Ws6ZezJIol7MAlgQRaF2Guqcmmfp/1lqK9ySCKYmcAtvzlBdUvXhZdaCOCseTCueqH9ly9voP+s2DCkfpsMfonqXLQuLqh3w4N1fo/rYTa3JISIXKJZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIs0dXmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BEDC4CEEE;
	Sun,  8 Jun 2025 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749386937;
	bh=Hg1EJQbuSXuDj2iFP9JPnOTxwl3g7372ywJP1TIer9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIs0dXmcwquCfLaTlLWoGw4V0Q8vE0Wjh/FWjmfX7WsSNpM1u/WzQOedW5UJonb79
	 cReweu9/p2LvR+CQxvJOg98vIzMS9sekQulGHwOwxbC6zDe+8cgS2Rwts7LMyawWHU
	 DTICVyyoo6CM/kU+r4bhEgePsGun5ltJv/iyMzedVmio4iOTo3NWRKEtjst+IeC7HC
	 l/Y1tHWNzdcrvofUbDenzA5U7XMYDUhCx7OtonwnYgvE4vjoVCUZ/n9GPKoC3CV6X3
	 Z8SV/hE/RC8gfqfUNOAMLMSEn/5ZqBXBohR+FnlgIC81HOeURhIXfnB79oU5mDysU5
	 78q0C4f8pMj/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y 2/2] rtc: Fix offset calculation for .start_secs < 0
Date: Sun,  8 Jun 2025 08:48:55 -0400
Message-Id: <20250606231907-7a0bee837195d533@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:   <1243af4fd5d2974b4e77e85873b999fd877161e7.1749223334.git.u.kleine-koenig@baylibre.com>
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

The upstream commit SHA1 provided is correct: fe9f5f96cfe8b82d0f24cbfa93718925560f4f8d

WARNING: Author mismatch between patch and upstream commit:
Backport author: <u.kleine-koenig@baylibre.com>
Commit author: Alexandre Mergnat<amergnat@baylibre.com>

Note: The patch differs from the upstream commit:
---
1:  fe9f5f96cfe8b ! 1:  6c5107e2d5c38 rtc: Fix offset calculation for .start_secs < 0
    @@ Metadata
      ## Commit message ##
         rtc: Fix offset calculation for .start_secs < 0
     
    +    commit fe9f5f96cfe8b82d0f24cbfa93718925560f4f8d upstream.
    +
         The comparison
     
                 rtc->start_secs > rtc->range_max
    @@ Commit message
         Reviewed-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
         Link: https://lore.kernel.org/r/20250428-enable-rtc-v4-2-2b2f7e3f9349@baylibre.com
         Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
    +    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
     
      ## drivers/rtc/class.c ##
     @@ drivers/rtc/class.c: static void rtc_device_get_offset(struct rtc_device *rtc)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

