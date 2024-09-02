Return-Path: <stable+bounces-72647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110E967D40
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 03:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973841F2160D
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 01:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD9679C0;
	Mon,  2 Sep 2024 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Mx8lzy16"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DC02F30
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725239754; cv=none; b=Rd8Rtjm6duGGQHFJ1AGr8nn2FVO18iqGEteVgdlk/Wv3Gqtf28NUN82TAfgjAh+07CGjpywGfSZqCiB+EIHI/Siw04JMrwsRNdO90Y964TW6RnEaWOOakbOPmgznWmGdVZm4ZVKWlO5LxDfKF7El1dNRoIQ0u5GIGO9wUdLZops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725239754; c=relaxed/simple;
	bh=DHelPONrrGuP94Ep8CDeXojOJOEwWE6+O5SSi5VY4Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grpdBlSM8nkZOVS2tZrVySXs+NZyeYebMIIuu1q2yyU7MbMWqnA++J76WGiookdrYyaSmt54oBkL2mVm7gZI/lQy69J/MgW67mFgezqZqC+adr7RN+KXN3ly0Lbms94ebKAvomgrf/uugIGd3kR1PK5YfOLVY+2yEcw/obpJRCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Mx8lzy16; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AF8D014C1E1;
	Mon,  2 Sep 2024 03:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1725239749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sQJR2ONbfC8kwd5wz2n0IpjJsfQljFhf/xj3xdxkih8=;
	b=Mx8lzy16BSBNXE63YI/iTuwun/WDfvMpSIs55+K44oMh8W2UJjYlwy/sQmPTQ5mVsFVSqU
	whb6moqMz+D+SMYiyGq7/5DCdslagbruAkO5IUztLRO42N2RqdUBUQ7IhlYBmk6WeVwFAk
	yV+8KwKQ8m+BQqN/RRD4lua9KFK4KDEC6E+oJDoG3AB7n5czX4D5ivYs8OFBSqYWSCBnsJ
	dA+6pAgCnCgdfRugJW4nhZdtO5x02ww4QfyGkZ/le3DCl8Mb3rmFC1cGv4SEw80gBrPDkO
	ofIVwZ7UztrhX1Rj1i7TvCSblfg4/MeuMEgS/nH9FKHXqZfGY8MqdmT3US1qOw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7f28c78b;
	Mon, 2 Sep 2024 01:15:45 +0000 (UTC)
Date: Mon, 2 Sep 2024 10:15:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 130/151] Revert "Input: ioc3kbd - convert to
 platform remove callback returning void"
Message-ID: <ZtURsofEb-WmU69f@codewreck.org>
References: <20240901160814.090297276@linuxfoundation.org>
 <20240901160818.998146019@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901160818.998146019@linuxfoundation.org>

Greg Kroah-Hartman wrote on Sun, Sep 01, 2024 at 06:18:10PM +0200:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This reverts commit 0096d223f78cb48db1ae8ae9fd56d702896ba8ae which is
> commit 150e792dee9ca8416f3d375e48f2f4d7f701fc6b upstream.
> 
> It breaks the build and shouldn't be here, it was applied to make a
> follow-up one apply easier.
> 
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>

It's a detail but if you fix anything else in this branch I'd appreciate
this mail being updated to my work address:
Reported-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

(Sorry for the annoyance, just trying to keep the boundary with stable
kernel work I do for $job and 9p work on I do on my free time; if you're
not updating the patches feel free to leave it that way - thanks for
having taken the time to revert the commit in the first place!)

Cheers,
-- 
Dominique

