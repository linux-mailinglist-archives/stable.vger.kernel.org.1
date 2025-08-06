Return-Path: <stable+bounces-166729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E7B1CA0E
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FED563CC3
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1428C5DC;
	Wed,  6 Aug 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsxAp44c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F462882CA
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499281; cv=none; b=IDC2KA/fEW5RgzpudoCGR0Cvpn9j5N92KkSBZNHWrDjRJjekOHq91dv6ggMSb2cGsjXbHr1dSD88DBzu1w+3t77vZjBiutDDMX3eAkU6vDhW/bn0x98BsjC+iCd2Q4ToBcEizwaQzq/3T0O0eFd5HMYLfvYTqM/le6TcVvSICSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499281; c=relaxed/simple;
	bh=vBy+ZykjvEH/Ue/rB5RF46B+KtDALCYDseVhJgZYOxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPrGIM/XDxL43HEN3/AEZbEn2k9gH9p9xRo8jD/vuKAt6HkNwI3gq8btPMTvWxHI/eJohNZlSaBMfG0JGwalSD0oidIYaj3L0Q1a/ohXeki2SBv7QwFSIfd9+E/sOgBPo5D4Y9cjvuoojZv4RTTUFQfU+xuwuICPEf9x9kUllQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsxAp44c; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24070dd87e4so5145ad.0
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754499279; x=1755104079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDlVtQ0H6g/CUBPQBD7y0cJer3GK/W0pDcUx3XisLHE=;
        b=hsxAp44cDcyfWtQwQkzsaBA5ZrTyf3yXVb1e2HFyfCWaBjT71tdtX3KgEB9SAU679R
         wVcRqBeXLbS7wbaIdSYvyrXAI3xjvfkTZO+cz/VWxfxziypH5Q6Ic1w9td6gtkYmTJMH
         yEejy5m/R/Z7IMC+DAYNtQNu7XUEzDav6jzmbYWBMMHVksVKTVfPD9s/+HQADEA6uupi
         7p1j8RNYNcXtX//UqSyPr+2umSm32sQfTU5/k5oC0wagx1Ob8NIQ8GfmfIzGbRXJZHkQ
         HkAu98SNVMGRIw8mbw2Aw76Wb+RAfkZsndXaCSJWZooFoUCPwm7reEzbzx2O/+hoRwfZ
         OlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754499279; x=1755104079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDlVtQ0H6g/CUBPQBD7y0cJer3GK/W0pDcUx3XisLHE=;
        b=TpP994Q7tCngDffU9IVuEWFRzSKte3l8+uNKLKreU3wqDRNtIqS9ASiam8aP1NOML9
         gKOO/lGPRMLgo7Mjiegnq3TDQ2NyxICI8pebgQYEfZk8DLQq95eWJ+TgsY3+18+yswB2
         LhF0FFExLX7wdgV8MfoUumeM+1GcsoFj+d4yzNhgVMQinajLAK4MsOMN3u3LQ/ld6jF+
         0A6XEy5XCxRjg5hG47rv+H1PeXNK45y8DxANRJYuxcHg9/LEVPe2lTAdIDTeZChmqHU8
         kbWw9BRu5H33t2lmvE4vgG0VrgV5brCDc9CowYwTSVNo1Yw6CAY9XwP/mZa/p2fCEYly
         +s4g==
X-Forwarded-Encrypted: i=1; AJvYcCV7tj7FJEC5xhARrgURjCYEG55giwV2R8H+Vk5WCUhKZLoySWX40rCwgkWKiOCOqtratSTUAy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGCBrKwQakytUDiLHswvJLGGy7RkPT4fql+wZGmBL75N7B0vg
	/C7yzXOI3di1E9ZleayJ18KvG0hRMBLiNpDD0PFDDiFYm43HIEiTuyqyUPcJQ6mjdA==
X-Gm-Gg: ASbGncsjvP2VaiVGSiu2uOe8B/N10aRAcdAW+nnp8kguhTUnCAZMFjOri1g9D1zPLaT
	AOoWF9Fhp+EFTyg991WymPnneZuyt5+IDWSVaWggcwR9zjMX8h0fhlyKVNEK8Fo9gC4WF3a2UgA
	k4n7QaR9jejSBnYcq6Y/wuwh2mzXqkhaG/a/9l00/4CkI6O06DZNjqlODPQ6qHb31qbROs+4Pg6
	cMn5VAu2i7FsgsmfSZVfRt7PGrOslqMpFj0qlgFOJVocMY6NRVCbe087EbwzMFEqBzNZvielrK2
	RxpnTo73iygaEvEX6wgezucxA5xicqWvRBkWKeXRCiGGHaihPjJzojpz5o2V+DwyyFUFwZgCFne
	ePMJs7CKFgJsqt48Ev/ee7s6i6mtgPZASBc98byMM50KXacr56RKr1c8a5VjXFIU=
X-Google-Smtp-Source: AGHT+IHvOhPNxLiW+xAIGbnNNf22TDNMhZUZffefIhSybAGYzKw75zFvSLvosmLNNTyPnlIbkjP/UQ==
X-Received: by 2002:a17:902:f70e:b0:234:9fd6:9796 with SMTP id d9443c01a7336-242a0afb404mr3930985ad.19.1754499278376;
        Wed, 06 Aug 2025 09:54:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:1d96:3ebb:8f01:ca9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d21dsm162069155ad.139.2025.08.06.09.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:54:38 -0700 (PDT)
Date: Wed, 6 Aug 2025 09:54:32 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, aliceryhl@google.com,
	surenb@google.com, stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <aJOIyKQtevW0Ov_A@google.com>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
 <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
 <aIpVKpqXmfuITxf-@google.com>
 <d8bfc16a-466d-43b9-9021-91f6b65a3a81@lucifer.local>
 <aIqb-bDjsXppmyPN@google.com>
 <538efa9f-d3e5-41ab-ac82-5b7b799df706@lucifer.local>
 <2025073103-unheated-outbid-11a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025073103-unheated-outbid-11a2@gregkh>

On Thu, Jul 31, 2025 at 06:58:41AM +0200, Greg KH wrote:
> On Thu, Jul 31, 2025 at 05:40:29AM +0100, Lorenzo Stoakes wrote:
> > On Wed, Jul 30, 2025 at 03:26:01PM -0700, Isaac Manjarres wrote:
> > > On Wed, Jul 30, 2025 at 08:34:02PM +0100, Lorenzo Stoakes wrote:
> > > > > >
> > > > > > Having said that, I'm not against you doing this, just wondering about
> > > > > > that.
> > > > > >
> > > > > > Also - what kind of testing have you do on these series?
> > > > > I did the following tests:
> > > > >
> > > > > 1. I have a unit test that tries to map write-sealed memfds as
> > > > > read-only and shared. I verified that this works for each kernel version
> > > > > that this series is being applied to.
> > > > >
> > > > > 2. Android devices do use memfds as well, so I did try these patches out
> > > > > on a device running each kernel version, and tried boot testing, using
> > > > > several apps/games. I was looking for functional failures in these
> > > > > scenarios but didn't encounter any.
> > > > >
> > > > > Do you have any other recommendations of what I should test?
> > > >
> > > > No, that sounds good to me! Thank you for taking the time to implement and
> > > > carefully check this :)
> > > >
> > > > In this case I have no objections to these backports!
> > > >
> > > > Cheers, Lorenzo
> > >
> > > Thanks Lorenzo! Just to confirm, is there anything required from my
> > > end for these patches or they'll get reviewed and merged over time?
> > 
> > No, these should all be good to go, Greg + Sasha handle the stable kernels
> > and should percolate through their process (I see Sasha's scripts have been
> > firing off already :)
> 
> Yeah, give us a week or so to catch up with all of the recently
> submitted changes, the merge window, AND finally, a vacation for the
> stable maintainers....
> 

Understood. Thank you all for this!

--Isaac

