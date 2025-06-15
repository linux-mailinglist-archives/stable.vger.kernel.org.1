Return-Path: <stable+bounces-152658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED8ADA216
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8AB188F7F0
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F101534EC;
	Sun, 15 Jun 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="s1z4Cqne"
X-Original-To: stable@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967638FB9;
	Sun, 15 Jun 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749998147; cv=none; b=AqhT4xSRdBwPoqen03pJxWirjFIpuKJjaoyK01IjL6a1KojrzSy512kZYSFzttTQfyQFaTrnuciK/eYd4f9x7OE2R+jnIF8dbzV7+WawTUeRU19VYenzXGogsapnjYOwpdQCoajEyQWy8XdT5feIoKYbt4KTAy+elTAYhFExgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749998147; c=relaxed/simple;
	bh=5+CPvhrAduScbpDVISPMeCluAXnX1qLpqQyuEEyxtjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNuwEs4Il7DPMzca4xpyzxcgXLzHkqhc+e4c8/yi7LzSssvAMAdDaqoKn3ectSlY+nWXGoY03jQuYoD6tJCtqWLggBnrt+Fx9ADhcEbKUErUpBJYxAnpC5poBvp92jdxwycZnGrX7Lve25m4qTLbHI7n6S21is/A5mGSSjyEAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=s1z4Cqne; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=R7U+sM7ko2tIoeiTEIYa+LHqH1RcFs7LsdJyBNsbYZc=; b=s1z4CqnekwsFI8UB
	ay2+5Gah0u3EnexMOGv3KTKesSznT9NzTcI6jxwo67moIDqEjFgvH/G8kCKcnRQBXMKOxz+BgQAKh
	C9YKFsO3XETNMrIyXDN6h/paiTypdmr4HeMqXRbcv90INIh1JFIyZwq/e3vsdV30k/CubyRczRurx
	iDbOB//x7S8CZeYqBF1UyC5GDvHLfyMhbBjeUd+8D62yxFs7oH3Oce9XjnQx5I0zsUgoF/KUHbHob
	vkndZmgVFOPPeEaIbWSfdCH+8hpruihKiixFNM6lMuTsiVnI6ruTl3i7dZFeJEHZMLulObo2606UR
	RQhG3qe8mnH4mAsZaw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uQoSV-009iHR-28;
	Sun, 15 Jun 2025 14:35:43 +0000
Date: Sun, 15 Jun 2025 14:35:43 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Patch "Bluetooth: MGMT: Remove unused mgmt_pending_find_data"
 has been added to the 6.12-stable tree
Message-ID: <aE7aP6Q4D0DQ5qMb@gallifrey>
References: <20250615130532.1082031-1-sashal@kernel.org>
 <aE7GBFMk20Ipl7rn@gallifrey>
 <aE7Ywdz3uQGHPdOI@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aE7Ywdz3uQGHPdOI@lappy>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 14:35:18 up 48 days, 22:48,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sasha Levin (sashal@kernel.org) wrote:
> On Sun, Jun 15, 2025 at 01:09:24PM +0000, Dr. David Alan Gilbert wrote:
> > * Sasha Levin (sashal@kernel.org) wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     Bluetooth: MGMT: Remove unused mgmt_pending_find_data
> > > 
> > > to the 6.12-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      bluetooth-mgmt-remove-unused-mgmt_pending_find_data.patch
> > > and it can be found in the queue-6.12 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > It's a cleanup only, so I wouldn't backport it unless it makes backporting
> > a useful patch easier.
> 
> Right, it was taken as a dependency to make a later patch apply cleanly:
> 
> > >     Stable-dep-of: 6fe26f694c82 ("Bluetooth: MGMT: Protect mgmt_pending list with its own lock")

Oh right, that's fine.

Dave

> 
> -- 
> Thanks,
> Sasha
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

