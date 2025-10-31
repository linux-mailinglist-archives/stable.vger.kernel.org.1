Return-Path: <stable+bounces-191799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24772C24557
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 11:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE761A68474
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B6333729;
	Fri, 31 Oct 2025 10:00:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEC24C068;
	Fri, 31 Oct 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904803; cv=none; b=AFjpyxM1j6XpM75k4e4ddsozJhdN7DNce5Jl4NLC3MzlrOgexgQGt70QelNqiwy8oBXQYkDIMxPGEHzf6g70ttgtsSXKKTSiYmyGYOBgWIieF7DIiZnyFirm7jj+urBlVI3kXJZcOvQkouGuuZrSSX2DP55mRVy9EKy8cJ5GcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904803; c=relaxed/simple;
	bh=ZEhi2Ft7fop8DZXM4+Z56TzYm8lC0546nprbV4iSeTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdgVKYL/EWtr9J2CDgZwf5gfpwyJgBmPS7tqNUPiLecSgnftjvebFR/+lvb8OSMwrui1uZlDJzGIXNrkve0urDGGKzi1YJwc37J8Gs68nxiWA+bNFSus5GHW28UwAGcqerNMZOLokv51NWuym4P4W5bqP2KOvkGoml2fKsUdE2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBCE2227A88; Fri, 31 Oct 2025 10:59:56 +0100 (CET)
Date: Fri, 31 Oct 2025 10:59:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs
 store callbacks
Message-ID: <20251031095956.GB10293@lst.de>
References: <20251030172417.660949-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030172417.660949-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 10:24:17AM -0700, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue slows
> down system boot on systems where sysfs attributes are set synchronously.
> 
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.
> This patch may cause a small delay in applying the new settings.

You'll also need data_race or READ_ONCE annotations to satisfy the
memory model.


