Return-Path: <stable+bounces-73776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C0796F381
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC98B238DC
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED91CBEA2;
	Fri,  6 Sep 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cxm6y9EY"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D41CB339;
	Fri,  6 Sep 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623295; cv=none; b=lXyRT1bxAMn98FIktm29rzSUz+n4KtOcznARGvOicsoZ9szqYI0j+8QYJKJ9K4BXfEGdsX4NDdstUbwGZZ/KYA9QKtFnD38+j1eVxfOVg5pcAF0KFLsRJBZaXl4mEe9IgaSN7ompiei4WvhkEA/CJWQdfIXjgY1ATsEnjvYBaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623295; c=relaxed/simple;
	bh=7UW2+fR4GkYqbvz/zOI4Fzzk1gidpNwK/Tz4gzjkTsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AztHIPjZZBAh+tpVUQF7+siFRGpQrGMjicgsvFU6gxQDIILQpRwQ797EtmsRWNqok1dqzEW1+26nL3Lj2gh1gEcLYT3SEIC8wk9ilaOPlSHUCQA580zpm/rUYv6Nzwb2xwXDms5+aaFKJ4G/6zpwN0piuk2ZWN9/7QjJrvFlATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cxm6y9EY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725623291;
	bh=4yBsZEY7Hesn67awFwYAy75xg1NngpI4UOwPcvd0DGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cxm6y9EYtW7EDJdt2IxMs03JP1S/HYOaJyuRFN3suKcyUuku92Tr8Jd/SAjgUMAiC
	 77huDQjvRHjYvhTZUgi2nQpF/0jKsmHvp2WP2pS58VErHviDNdfQfOIZ4HjhMh8RDR
	 +mU1xbuT/29p6z+tgiEpSKIzMgQi8Tap2TruyLjHRGHe+U95d8+tgSriLBRGLdoh8S
	 amSfRMFH9GM+0WSfA8mDYgO5inzog1OcjpSjXY2gFxcq3m0VJ1aKl+ZADWUFRcVBga
	 shKJAGTmnN2ZpDI+jjVuR3GaS08f3y13yb/ObFM1Q5HdF+E8h/kCv/NgnghSnE0GNO
	 dAMO86RKSgr0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0ZHH0CX9z4wxx;
	Fri,  6 Sep 2024 21:48:11 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: stable@vger.kernel.org, Geetika Moolchandani <geetika@linux.ibm.com>, Vaishnavi Bhat <vaish123@in.ibm.com>, Jijo Varghese <vargjijo@in.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240829022830.1164355-1-nysal@linux.ibm.com>
References: <20240829022830.1164355-1-nysal@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/qspinlock: Fix deadlock in MCS queue
Message-Id: <172562323422.464302.13801524851924660182.b4-ty@ellerman.id.au>
Date: Fri, 06 Sep 2024 21:47:14 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 07:58:27 +0530, Nysal Jan K.A. wrote:
> If an interrupt occurs in queued_spin_lock_slowpath() after we increment
> qnodesp->count and before node->lock is initialized, another CPU might
> see stale lock values in get_tail_qnode(). If the stale lock value happens
> to match the lock on that CPU, then we write to the "next" pointer of
> the wrong qnode. This causes a deadlock as the former CPU, once it becomes
> the head of the MCS queue, will spin indefinitely until it's "next" pointer
> is set by its successor in the queue.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/qspinlock: Fix deadlock in MCS queue
      https://git.kernel.org/powerpc/c/734ad0af3609464f8f93e00b6c0de1e112f44559

cheers

