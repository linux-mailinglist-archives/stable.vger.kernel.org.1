Return-Path: <stable+bounces-93746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499619D0660
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD1B2823F6
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916B1DD877;
	Sun, 17 Nov 2024 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jawuIPoj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAC84A4E
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731880113; cv=none; b=lTvwV8c1p6eRfWYMcH5qwndd3QVVQ8Z90ggA8BzimrJW79+QF8PtPjtOnGUAjJBVQ4PGXRDKRSqRJUMktbScOicmm7yTKs7kA+Re/lRIvfwv7NZA8alHYmYF6D5Pi3VNTyhVdEWuOhW2XX/cq32LGK/IfwoWIfd9eB1eWYmvSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731880113; c=relaxed/simple;
	bh=IEw6P8ZsPLw1RifKFWjOgeTt2YhlscXGGxX65bLWlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3v9mEySbUpWQXKISleuTEJxBEb6kN5xiMIP/qh4/iSSd6KGVwQnMSf1pbprRc6tbcycF4kT/2dy7BJcQJwABsfHD1Z8F4U9gkmLqGQAA0D5sGDmuuzrIgZGSABLoWHMaLYusoCep3W7DNu2/e4X/x6ajW/hEqy2l8biq7p/a1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jawuIPoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A482C4CECD;
	Sun, 17 Nov 2024 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731880112;
	bh=IEw6P8ZsPLw1RifKFWjOgeTt2YhlscXGGxX65bLWlKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jawuIPojdFJs6KRt0morwEOCaPRj0C1Ny4UtvSojiIN/4kPaPo0pESxtRD7tDVR2w
	 F5Frq3GEsExsSjS8pQJqyQdfYzmpYzVU7bH2f6T3RRldDn68Iq6sYu93dyFO5SnCdK
	 Vo78KMxGx33k1O7rV7VoovWEgd7hCd2gUsUw3cao=
Date: Sun, 17 Nov 2024 22:48:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: airlied@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	daniel.vetter@ffwll.ch, david@redhat.com, dongwon.kim@intel.com,
	hch@infradead.org, hughd@google.com, jgg@nvidia.com,
	junxiao.chang@intel.com, kraxel@redhat.com, osalvador@suse.de,
	peterx@redhat.com, stable@vger.kernel.org,
	vivek.kasireddy@intel.com, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] mm/gup: avoid an unnecessary allocation
 call for" failed to apply to 6.11-stable tree
Message-ID: <2024111701-footsore-bouncing-7834@gregkh>
References: <2024111754-stamina-flyer-1e05@gregkh>
 <b79ed291-ad60-4be7-a2c2-19fedfde74c7@nvidia.com>
 <2024111722-humped-untamed-d299@gregkh>
 <406112aa-1909-4075-9e90-ed59cb7b1660@nvidia.com>
 <0b27eaaa-2ae7-422b-8b22-e92e49ab439c@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b27eaaa-2ae7-422b-8b22-e92e49ab439c@nvidia.com>

On Sun, Nov 17, 2024 at 01:38:42PM -0800, John Hubbard wrote:
> On 11/17/24 1:27 PM, John Hubbard wrote:
> > On 11/17/24 1:25 PM, Greg KH wrote:
> > > On Sun, Nov 17, 2024 at 01:19:09PM -0800, John Hubbard wrote:
> > > > On 11/17/24 12:33 PM, gregkh@linuxfoundation.org wrote:
> > ...
> > > Patch is line-wrapped :(
> > > 
> > > Can you resend it in a format I can apply it in?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > OK, I'm going to use git-send-email after all. Thunderbird is clearly
> > not The Way here.  Just a sec. :)
> > 
> 
> OK, I've sent the fixed up version, here:
> 
> https://lore.kernel.org/20241117213229.104346-1-jhubbard@nvidia.com

That worked, thanks!


