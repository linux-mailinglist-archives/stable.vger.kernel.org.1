Return-Path: <stable+bounces-192793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31CC43594
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 23:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A2F188CC98
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE926CE0F;
	Sat,  8 Nov 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJqA0/rm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3324469E
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762641611; cv=none; b=AGvjhtQ7OFoVuSQ4JcsLzwgkSba5KOdhvfSWjIaEd82Fqhcol+DoCOjGcIRtePC3/tHqv4i+5puqC2E3y83eYrWs0YRUr4ag52KAyeTkfMZNulnn79xBfKeqSs2vp26cy5/u2dVRDPenidEUt+Ibc4FER3kxxBkz9eFIt0dS0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762641611; c=relaxed/simple;
	bh=v2olXTITm7id/Jbok7SDUxyytcIF0922b41bv/r3gEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KndX1lWDFVFwsaJev4JsX8O3ty/k8xZuhwap7dvLCBqZvXLuiaX/RKStBfx+zTHx44y7XnmqxIZ327ntfCSJNmUlBBpoR2Klg6aqnDxZju9t/zOFVKHyU1F8UNe1RIUh1Q9FeMErJmJWCz6tIieSbw7VgaQ5FhJvmQZYZgqeFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJqA0/rm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632b0621so12870435e9.2
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 14:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762641607; x=1763246407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeISWmTa3vUK5FBNCaamQkWxvL/7eMCUuRL+6ngrP4Y=;
        b=NJqA0/rm4BCXw1p5FOX+GDVCIjt58glkz9Q3ZcfHYl+bQhke5jQF8tHQAoP756LAEN
         RoEO1iHN1pJnsaCwQAJugdstZHDrY7RZHUv9cJZkiyW4eRJHB/HZO8BHEYbgXefjWHfJ
         zzmDbvR+1wBEyS3oVxJmNxGHlRu9NLTwsNmHczq3QpM/P2eYEevH5t9xCFxZ+CFUT3+F
         Bhs3kd1ZQM88X++du1e04gyLGr+NLbxjs+c8xm+v0xs9AbXoxRPSKUXeDx+4v6RHewXE
         Jh4ztCqjxd8faYiMkD1DalrKN923yhr0Xu0kfm9/G9+lE17rUvB6RbfwD5hL5z5H2ppv
         SOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762641607; x=1763246407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GeISWmTa3vUK5FBNCaamQkWxvL/7eMCUuRL+6ngrP4Y=;
        b=RxlRxBHqd+mYYCVKUmkfUZZBylqEqhtGP4U1F6ugoyQvhWWTiSckpvOfHcQ2YCJr6l
         Dodt1POXuWyapx6vvRLulEEee649HYb4qV/LH0P+blyVyyYFX9vRYbzgfmLl5NjVqXFF
         MOd1yt9m5EkG5yH/uIx1NXjBesT6T2XlJN6vhpdsDjhE9Wm+DxkmV52Bf2xYRJj9G2D0
         hGG0V6xLJZA2h5dW3JBZ+CBO8t0ocHEKiDE2rx0gh/6ABmOkZ+cGy1kbsnUVG7oL2+Xs
         H4noblmVlZdpFR9D3kaH6HkK8XcbBbNTCqbGzQFF6lk/rTL+egiHyX1oZLQmR9k98lPK
         PPyA==
X-Forwarded-Encrypted: i=1; AJvYcCVZcoZRNNzJtwPZKs/aCMNGfGa556zgpcQgz5FiVBII5J4CiMWcy0px2rdGUc8CDOVDNrkxB2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oxW7RE7rWkAsP6JQdFylhXisUyOk06UWk2Nxq5Zfj/YxR/71
	wKo9Swa3mKtXC5ICzI0QxnModR8I++XUPfAkNl5hvz5Cmk8k3dMkrJ2m
X-Gm-Gg: ASbGnct523vDcgviwn9OX2XcpTghCghTdBH6N8E5+6cAYqWVn/Ldu9LcR5Lk6U5LETq
	VLbe2FRuDMeaopkYeY249poLhHFFk2CIun20rL17eoUV93lrjLJLCxX/r5gp12qTyajRy/N4DNV
	rVkZmt+hED51b4Cape0H21PscxhRHEXpHkVFUibr721C70b0DKTAAGEcPKhg+UcI/h1/6l+7Gay
	mxsx515yVMxaUEW6JLUsCo+Vxaxz5LrxIurLyUXH6RCrZtr4hvxZE7cyquucgylQ6igmTmFjCNJ
	v0ZGnJoqYzpKDjuz53CU+TjXlLHJx1gP9LveeU0CVbS/kMLgGb9+UXMxz+D4pNkLRXPQZD2gI4q
	Zt/F6mhZPoda5SrQlwAc2zZrOQnzdJYZPuf/EyRC1RMHbjCpazTDAkhpuUBVZZU2k+nWPyhUg/0
	ZwmJ3OXjKfl/Si/63/30oTfC/PA8SGoDSECuyKmKQDqhjiEFo6iSnX
X-Google-Smtp-Source: AGHT+IGsbfXCcLr/eMJsRMvbDro8yZc7tlZ7s2qGXaBx74rmIg1A2WehS9AdBI43idEKThFTSBaWAA==
X-Received: by 2002:a05:600c:8709:b0:471:15c1:45b9 with SMTP id 5b1f17b1804b1-47773288defmr31071275e9.29.1762641606936;
        Sat, 08 Nov 2025 14:40:06 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f89fsm78847315e9.3.2025.11.08.14.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 14:40:06 -0800 (PST)
Date: Sat, 8 Nov 2025 22:40:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David
 Laight <David.Laight@ACULAB.COM>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, speedcracker@hotmail.com
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
Message-ID: <20251108224004.05895f84@pumpkin>
In-Reply-To: <cf9573c2-5fb7-4417-8ff0-eef4172621fb@kernel.org>
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
	<37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
	<20251106192210.1b6a3ca0@pumpkin>
	<176251424056.634289.13464296772500147856@noble.neil.brown.name>
	<20251107114324.33fd69f3@pumpkin>
	<176255578949.634289.10177595719141795960@noble.neil.brown.name>
	<cf9573c2-5fb7-4417-8ff0-eef4172621fb@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 10:49:34 -0500
Chuck Lever <cel@kernel.org> wrote:

> On 11/7/25 5:49 PM, NeilBrown wrote:
> > On Fri, 07 Nov 2025, David Laight wrote:  
> >> On Fri, 07 Nov 2025 22:17:20 +1100
> >> NeilBrown <neilb@ownmail.net> wrote:
> >>  
> >>> On Fri, 07 Nov 2025, David Laight wrote:  
> >>>> On Thu, 6 Nov 2025 09:33:28 -0500
> >>>> Chuck Lever <cel@kernel.org> wrote:
> >>>>     
> >>>>> FYI
> >>>>>
> >>>>> https://bugzilla.kernel.org/show_bug.cgi?id=220745    
> >>>>
> >>>> Ugg - that code is horrid.
> >>>> It seems to have got deleted since, but it is:
> >>>>
> >>>> 	u32 slotsize = slot_bytes(ca);
> >>>> 	u32 num = ca->maxreqs;
> >>>> 	unsigned long avail, total_avail;
> >>>> 	unsigned int scale_factor;
> >>>>
> >>>> 	spin_lock(&nfsd_drc_lock);
> >>>> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> >>>> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> >>>> 	else
> >>>> 		/* We have handed out more space than we chose in
> >>>> 		 * set_max_drc() to allow.  That isn't really a
> >>>> 		 * problem as long as that doesn't make us think we
> >>>> 		 * have lots more due to integer overflow.
> >>>> 		 */
> >>>> 		total_avail = 0;
> >>>> 	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> >>>> 	/*
> >>>> 	 * Never use more than a fraction of the remaining memory,
> >>>> 	 * unless it's the only way to give this client a slot.
> >>>> 	 * The chosen fraction is either 1/8 or 1/number of threads,
> >>>> 	 * whichever is smaller.  This ensures there are adequate
> >>>> 	 * slots to support multiple clients per thread.
> >>>> 	 * Give the client one slot even if that would require
> >>>> 	 * over-allocation--it is better than failure.
> >>>> 	 */
> >>>> 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> >>>>
> >>>> 	avail = clamp_t(unsigned long, avail, slotsize,
> >>>> 			total_avail/scale_factor);
> >>>> 	num = min_t(int, num, avail / slotsize);
> >>>> 	num = max_t(int, num, 1);
> >>>>
> >>>> Lets rework it a bit...
> >>>> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> >>>> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> >>>> 		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
> >>>> 		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
> >>>> 	} else {
> >>>> 		total_avail = 0;
> >>>> 		avail = 0;
> >>>> 		avail = clamp(0, n + sizeof(xxx), 0);
> >>>> 	}
> >>>>
> >>>> Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
> >>>> with 'lo <= hi' otherwise the result is dependant on the order of the
> >>>> comparisons.
> >>>> The compiler sees the second one and rightly bleats.    
> >>>
> >>> In fact only gcc-9 bleats.  
> >>
> >> That is probably why it didn't get picked up earlier.
> >>  
> >>> gcc-7 gcc-10 gcc-13 gcc-15
> >>> all seem to think it is fine.  
> >>
> >> Which, of course, it isn't...  
> > 
> > I've now had a proper look at your analysis of the code - thanks.
> > 
> > I agree that the code is unclear (at best) and that if it were still
> > upstream I would want to fix it.  However is does function correctly.
> > 
> > As you say, when min > max, the result of clamp(val, min, max) depends
> > on the order of comparison, and we know what the order of comparison is
> > because we can look at the code for clamp().
> > 
> > Currently it is 
> > 
> > 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
> > 
> > which will use max when max is below val and min.
> > Previously it was 
> > 	min((typeof(val))max(val, lo), hi)
> > which also will use max when it is below val and min
> > 
> > Before that it was 
> > #define clamp_t(type, val, min, max) ({                \
> >        type __val = (val);                     \
> >        type __min = (min);                     \
> >        type __max = (max);                     \
> >        __val = __val < __min ? __min: __val;   \
> >        __val > __max ? __max: __val; })
> > 
> > which also uses max when that is less that val and min.
> > 
> > So I think the nfsd code has always worked correctly.  That is not
> > sufficient for mainline - there we want it to also be robust and
> > maintainable. But for stable kernels it should be sufficient.
> > Adding a patch to "stable" kernels which causes working code to fail to
> > compile does not seem, to me, to be in the spirit of "stability".
> > (Have the "clamp" checking in mainline, finding problems there,
> > and backporting the fixes to stable seems to me to be the best way
> > to use these checking improvements to improve "stable").  
> 
> I agree with Neil. The LTS code was building and working rather
> universally until recently. The less risky approach is to leave this
> code unchanged and seek another remedy for the OP.

IIRC minmax.h was backported to allow other changes be backported.
So something has to give.
Changing the:
	avail = clamp_t(unsigned long, avail, slotsize, total_avail/scale_factor);
to
	avail = min(avail, total_avail/scale_factor);
fixes everything and leaves this code behaving the same way.
The later:
	num = max_t(int, num, 1);
has the effect that the lower bound of the clamp_t() was expected to have.

I've just looked through the old versions.
The comment when the clamp_t() was added is:
	* Never use more than a third of the remaining memory,
	* unless it's the only way to give this client a slot.
The intention was clearly that 'avail' would be at least 'slotsize',
even though clamp() has never worked that way (and relying on the order
of the comparisons is a bug in itself).
This got 'fixed' by the extra check that ensures 'num' is at least one,
but the code clearly wasn't read properly at that time.
(It has also suffered because clamp_t() was used and truncated significant
bits of the values.)
I've no sympathy for this buggy code that has been bodge fixed several times.

	David



