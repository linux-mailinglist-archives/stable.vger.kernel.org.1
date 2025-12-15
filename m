Return-Path: <stable+bounces-200988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A6CBC2E3
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 02:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD833008EBD
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512A271A94;
	Mon, 15 Dec 2025 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg1SG+RL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F6EEAB;
	Mon, 15 Dec 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765761648; cv=none; b=Qa5Lrxg6ezI2/BsnQLPXjOAhFxgLoidEb6aN9Aqkq+blB4XBj0cQ55iLlyAV6weoGys52WweX0Sp2WCzn0XZFaijvnSIMw9TrQvn2opOWpqUnRJ/ZMjXYY5hMmOU3y3AIJCNGprKB0DnaVi2FuNuUwj17D/6E4gHe3PrVN7DiQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765761648; c=relaxed/simple;
	bh=bSXK+LKSAoo8eBvrjFP0fCdYJ/QTpXofKlk4R2BlNQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9ZmQ+XSjnD3C4EU8EaTFARoIiARDvxbvrY39wDaEC1PJc57rj61yDZtBuTbtO+mkQDXWTkG0e050JHEfWPhpmKlNA67eiWc7GHJvmyYuiKxtSFpXmKat5seZuSSGTeRKeLU4PSMMtdnR/viyfz/K1eZshn5Bc+Inu53Dt83pb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg1SG+RL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A38C4CEF1;
	Mon, 15 Dec 2025 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765761646;
	bh=bSXK+LKSAoo8eBvrjFP0fCdYJ/QTpXofKlk4R2BlNQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qg1SG+RL/lou8LVrKAx9Yz7/KSJsCuZJAmPGIk2BEfoOYKCTw2nsfW2c8+Y3SqQ2R
	 pygNolv0gID440yUZrKSGG9wTGxqjq2GfCj2t1MNvrcaWL9qHR1qco3mmblBGC8G9m
	 CFPrvXSkyLhA+svQOk4hh/92sZnNR2Mhv03P5Samdd57JYm7KCEBlVhH5QE79Ub2LJ
	 m1V8sYE1bKSAaxjuUzwTKGWg042PBj/Uz9b15QRa3iozT1GnTnohibPf9bXfnvL41Q
	 JQjy65LdfyxfCietdA0PIvOP5XuJVSF3WkI96yREm8P12aig4+0BWB0gHwBapENlUu
	 NXFc4XxkhyDSA==
Message-ID: <c49b5b4c-a3b2-40f6-8d8a-fb20448eb5ed@kernel.org>
Date: Mon, 15 Dec 2025 10:20:44 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "block: fix cached zone reports on devices with native zone
 append" has been added to the 6.18-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 johannes.thumshirn@wdc.com, Sasha Levin <sashal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251215003707.2750979-1-sashal@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251215003707.2750979-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 09:37, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     block: fix cached zone reports on devices with native zone append
> 
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      block-fix-cached-zone-reports-on-devices-with-native.patch
> and it can be found in the queue-6.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Sasha,

This is a fix for a new feature that was queued for and is now added to 6.19. So
backporting this to stable and LTS kernels is not advisable.


-- 
Damien Le Moal
Western Digital Research

