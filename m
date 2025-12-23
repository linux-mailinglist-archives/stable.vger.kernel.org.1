Return-Path: <stable+bounces-203255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CCCD7DA1
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 03:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99156300D31A
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 02:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A221CC4F;
	Tue, 23 Dec 2025 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAMZmxAY"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EC1E5B68
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456362; cv=none; b=DZGR7s4/bRBHeYf/jtzteGBhOXnCVBym/+35La32vMnGoKUn4L4joalvSZJkMCXLZ7VwvQGCc91ZUF19JJW83EK2UlI28WlKtIMNq9CvvEakgGD7Ju3+7ZHVmzG0Lc3XcNd7OAbDoZmOerlOb4ICBro7DJQYq7XlG/+RC4SN8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456362; c=relaxed/simple;
	bh=My1A8eZdeudIyv7qw13CGUN2vtMhj7s1ZhtlELvi1gY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jPz5SlHPz6tBGu7c4lkgutNxYY9vw7nZOrZ8q119Hn61rW+oTTkdzrdQ/oiByGfGGo+AGbGX2Ob4TgA+KywK/AH9yKw+JysnjVRVvFuHhciABtVS1WK+TfopAhHXHBs7K0VARsFJO3Ki7FfY9dpH1k2SziH7sjzODt0uGlUwusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAMZmxAY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766456358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=My1A8eZdeudIyv7qw13CGUN2vtMhj7s1ZhtlELvi1gY=;
	b=TAMZmxAY9FwhbLj22oNpHKavUx5cuXi/9rmxV+iGNyZcpNmKZUPY2g/wmOWI70r8S60mLX
	H+xD0Y1uSxo1V5rtcAcNxzdNzC1FJK8z17oLiH7oDM3I+0JilkPW6nNS49bIsLS4FsTQf0
	MECwSzHxgMx5xtdwf9wZrZpo/oWttg0=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when
 called from interrupt context
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20251222201541.11961-3-ionut.nechita@windriver.com>
Date: Tue, 23 Dec 2025 10:18:39 +0800
Cc: ming.lei@redhat.com,
 axboe@kernel.dk,
 gregkh@linuxfoundation.org,
 ionut.nechita@windriver.com,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 sashal@kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4006496F-8A9D-492E-8264-6B1FE7910C20@linux.dev>
References: <20251222201541.11961-1-ionut.nechita@windriver.com>
 <20251222201541.11961-3-ionut.nechita@windriver.com>
To: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 23, 2025, at 04:15, Ionut Nechita (WindRiver) =
<djiony2011@gmail.com> wrote:
>=20
> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> Fix warning "WARN_ON_ONCE(!async && in_interrupt())" that occurs =
during
> SCSI device scanning when blk_freeze_queue_start() calls =
blk_mq_run_hw_queues()
> synchronously from interrupt context.
>=20
> The issue happens during device removal/scanning when:
> 1. blk_mq_destroy_queue() -> blk_queue_start_drain()
> 2. blk_freeze_queue_start() calls blk_mq_run_hw_queues(q, false)
> 3. This triggers the warning in blk_mq_run_hw_queue() when in =
interrupt context
>=20
> Change the synchronous call to asynchronous to avoid running in =
interrupt context.
>=20
> Fixes: Warning in blk_mq_run_hw_queue+0x1fa/0x260

You've added a wrong format of Fixes tag.

Thanks.

> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>

