Return-Path: <stable+bounces-36036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A18995E8
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3831C21156
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94D24B28;
	Fri,  5 Apr 2024 06:53:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D214288;
	Fri,  5 Apr 2024 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300018; cv=none; b=KeP9/EVEmZ5++NJRxeVuR6qvhqK7MOm1WVeu9WgiTb9Jiew0AQutyZAGa+dzzsiuQ+aJPRPmJ72e4eazB4cs+MC9M4IGZV150ZlbrgEb8zlizr8pVeE178Pa+z9XECxNtCyWcTGyy8JzPxUygrG58ra65q++YPnBnSspv6dkVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300018; c=relaxed/simple;
	bh=gpgHvvLkx+2p0kJ6tIH1HyH+2ICFlapxokbUJcmMuAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN5My7V+rrfoI9Di2DrDheAELLs8oxwJzdimsCO3tTZH8qL6+JckB9WZIY083QxKRlwaq/+zE5v0sBK3XH/ObsRewRVJcog1gbFD74qMh3DJVEzhC5ExM6C0cNpBPEL8vjZoBcd1D67FLwvcS9NC/vhBPrFJfvegLqATvzflBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 424BC68D07; Fri,  5 Apr 2024 08:53:33 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:53:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Saranya Muruganandam <saranyamohan@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Message-ID: <20240405065333.GB4023@lst.de>
References: <20240405014253.748627-1-saranyamohan@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405014253.748627-1-saranyamohan@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hmm, what is this?  It looks kinda like the patch I sent out, but with
the flag moved into an odd place?


