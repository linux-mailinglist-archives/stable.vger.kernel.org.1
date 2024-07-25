Return-Path: <stable+bounces-61781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275093C78E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A51F22B3B
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7719DF59;
	Thu, 25 Jul 2024 17:12:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC619B3F9;
	Thu, 25 Jul 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927555; cv=none; b=k7GN9sYFkAASCYhU7Hh7NywtDkL3JL87QQLKsfcU/xS/DDiqsvg6963I8i36JBQS28mOrcUGpAxA5r48WAYfM+wKe6BMSh3ClGDViV2Wd/1TrzNMal0Wen8yu9Njzhou/SctBqWs81SbLLHDWDkJU6zwbSiv7fKUydcXn6Cf+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927555; c=relaxed/simple;
	bh=aESILkTTLAhrFt1XHjE6bC3STVKK+u3PnkORDF3L4wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNG6EFbAiY+roJE9xsU0HnbAp/grJM0DdHKrKgIAnqzlOHzKXxIAIMsA1ZAvWMV/5mMFh5rVcuJZ7kqeNDXXkVRMbcml3IJJ9b+Wq5RTC1HEuxsk5L3mAuVrQRIrvmbC09cTq9tOZINjladJZTpAbU8j7sLvM160vEKHsgsMmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 46PHBnht030992;
	Thu, 25 Jul 2024 19:11:49 +0200
Date: Thu, 25 Jul 2024 19:11:49 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: include arch.h from string.h
Message-ID: <ZqKHVeZg+Tu6VV5f@1wt.eu>
References: <20240725-arch-has-func-v1-1-5521ed354acd@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725-arch-has-func-v1-1-5521ed354acd@weissschuh.net>

Hi Thomas,

On Thu, Jul 25, 2024 at 06:54:18PM +0200, Thomas Weiﬂschuh wrote:
> string.h tests for the macros NOLIBC_ARCH_HAS_$FUNC to use the
> architecture-optimized function variants.
> However if string.h is included before arch.h header than that check
                                                       ^^^^
then

> does not work, leading to duplicate function definitions.
> 
> Fixes: 553845eebd60 ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`")
> Fixes: 12108aa8c1a1 ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Good catch!

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy

