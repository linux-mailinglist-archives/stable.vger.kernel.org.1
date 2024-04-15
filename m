Return-Path: <stable+bounces-39419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68E8A4EEB
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEEF1C21062
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1726995D;
	Mon, 15 Apr 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Up6FGd88"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01C66B5E
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183806; cv=none; b=H9hEEgeeOtVhJ0lgIJS/45jbkn55TqdItT/EaauJy3BcaSCCvoHknlTGHQXoXnRb/lSRDZQNEK0qoH6xaXG/WOWwfo+6tWX+dZoKultg+AhRp80/iVCYxRuqCy0tPNBZday5LWWqnpEyISCWRLgfBm7E5zzuXX4PX1oH0Jdkit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183806; c=relaxed/simple;
	bh=5bKp3kgoHEeTPxUq1Cqxg5kuibNVr7G7COR242oejIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoVqBCOZOJDaqdBG6r3UtSMM/03JwYR9ab9c8B9HdknIqs28GGzI//ugbiKk2y07gaMs9zn6GVM1vo89jPcJpcmUJpcT9+E6QET5I0TXuItCkmOsNAkIW92xO5Ks1DagYETAyX42KUbiIfCw5dj3murdQwsDA9Rb72FW1BX4oN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Up6FGd88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3402FC113CC;
	Mon, 15 Apr 2024 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713183806;
	bh=5bKp3kgoHEeTPxUq1Cqxg5kuibNVr7G7COR242oejIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Up6FGd88fCRx9S2EulJAlxiJ86HksW+LSl8CrcbXfEKl4V/g1k2p4KDLJRoqcPC5w
	 FUG4/dRMEg9X2kpeC/gZfP1C7YJJz2GB/Kid9ytKMG8cgL9kWV2+fq7nWYxOcd/3pl
	 xGmlvgGRKRMriCWNHTRTyEmybRBmTwKOphlPZdeU=
Date: Mon, 15 Apr 2024 14:23:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.1.y] drm/i915/vma: Fix UAF on destroy against retire
 race
Message-ID: <2024041507-helpless-stimulus-df3e@gregkh>
References: <2024033053-lyrically-excluding-f09f@gregkh>
 <20240412070016.273996-2-janusz.krzysztofik@linux.intel.com>
 <2024041521-diploma-duckling-af2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041521-diploma-duckling-af2e@gregkh>

On Mon, Apr 15, 2024 at 12:50:32PM +0200, Greg KH wrote:
> On Fri, Apr 12, 2024 at 08:55:45AM +0200, Janusz Krzysztofik wrote:
> > Object debugging tools were sporadically reporting illegal attempts to
> > free a still active i915 VMA object when parking a GT believed to be idle.
> 
> <snip>
> 
> both backports now queued up, thanks.

And both backports break the build.  Did you test these?

Now dropped.

greg k-h

