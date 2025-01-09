Return-Path: <stable+bounces-108131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C6A07CBE
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC9A3A8D7E
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E372185B3;
	Thu,  9 Jan 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pStXPF4o"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2621A424
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438499; cv=none; b=aFCHCWm7SI90fwJmI92lfh/DOGFdbhw2M4tJQLhNmoxI0DVvewUjmaCbB4MfXcx+OBLGSQFU7X7VndscnTwud/1GXauuPqBfkqyvbtkUdEHN5RP+/pfC3AwShY6m4QVGaJsoQmi2SnGev8IgUDfjXl5S0PP2FS3pN14WqFPHtfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438499; c=relaxed/simple;
	bh=9oP27jereGLgY5eBvy/AnuERETJGryU0Pe9YulYtEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neKdXw9I8K4X0tJ3utGq3hg+yt7R6b9T7ZL45xrCBjUMiC204AwAYVdk8ejjN/jSQIh/LkkRBj7xzbjPXcs+QgkK9qBYvavhtfKEpibxgbG+szib+EezBLOa4AqGyFKN6hmax3FPRYETGBBtGlIh9wv/o7I41r0zo++eDcmURgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pStXPF4o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vr+rmLFcUT53V/TKaw+JbeKZ1qrqIgHBpwiHSZZ8pkk=; b=pStXPF4on95mBvYRvvaA0CVmqY
	cS8c5GWmcdiclB2+ixh1/9tOT91UWKXQ7Xq0yv5VrOVXSzWUt5yvAJsro/XVzsa/miXmfT/08l4a7
	z7vENabAaYyJ/7LXPv7EIquq78JNzEwiQ0yt+g8nrD7jYKHHPW0aulH8MmqG7acN38KWgtruWBsFo
	CBuzALNPleYZuyw3z8ByNsv68+9N6TYMA3xinEUKjIptG7zhEVXGvP6tMyz0b+0VP+ZDt2m7Ddacs
	k1gfS7umonNnHu9Qq63uizYrgiuJWYrB0x2/PgEkQLurfj/zZIL/zjLlYleS0kRmD7dPMbpsq3z49
	QZkpECow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVuyR-00000006taM-3HvN;
	Thu, 09 Jan 2025 16:01:31 +0000
Date: Thu, 9 Jan 2025 16:01:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, balbirs@nvidia.com, hannes@cmpxchg.org,
	hch@lst.de, mhocko@suse.com, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	stable@vger.kernel.org, urezki@gmail.com
Subject: Re: FAILED: patch "[PATCH] vmalloc: fix accounting with i915" failed
 to apply to 5.10-stable tree
Message-ID: <Z3_y2-mV3eSWmqYQ@casper.infradead.org>
References: <2024122301-uncommon-enquirer-5f71@gregkh>
 <Z2nGG8WpNJB__fhR@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2nGG8WpNJB__fhR@casper.infradead.org>

On Mon, Dec 23, 2024 at 08:20:43PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 23, 2024 at 11:18:01AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> The 5.15 patch also applies to the 5.10-stable tree.  Thanks,

Seems to have been missed?  The 5.15 patch made it into 5.15.176
but the 5.10 patch isn't in 5.10.233 released the same day.

