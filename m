Return-Path: <stable+bounces-108697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3E1A11DED
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC9F16557E
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C520CCF1;
	Wed, 15 Jan 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H35KiLDG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63E22F832
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933425; cv=none; b=aWhMHoN7I9qrlwiY8opFbWlPwMZWDEp8czbteTiikZmGsYMjZHwHfTNZRU06IX9nRDlvciHh717Fpc8+UO5wd/oBkY6XRmaBT8Cfbd4DeyDKv7H7QwpgDuxf0jJuYLzL4WOYz00iVngTppUd0p0RFaGHyiVZfF42L2BFn2uWECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933425; c=relaxed/simple;
	bh=1tDYoVJndlzU0p06BXuHq60C8USW8urXyfrNrH7AsyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjm10G7gaI250mjFwXHHqvvEWLCdu2cFLHkoE55N0A30bcRZFyFXONXQbh/2QMQjK3NipZX3g01CtJyHp/GDyWpgtyBv2+SYOPJdO+M2UDhozn+q7G/tRXVUcyaKn2ZfbVH9VrYU+E5xQYE+KFz4sUei9/g8grD9qwEICYYS7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=H35KiLDG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a88ba968aso5284701f8f.3
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 01:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736933422; x=1737538222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUvTAUuK+vE10J1nLZZBp9eFGzFCe1s5alimZzVlJt4=;
        b=H35KiLDGYbyzrrBPgV+lorYfLkq32rkdKWM4cGQl7Ek3weK0anXdGEziE2nomhMwsu
         ChkjwGhaLg1T8pG7i36TV4oQWd4p+b5LXSd/qmVuNrG566DbDjDb5lQ4O4DzaOBIm7u4
         waWiwGcR9wj4zrvR7gxJmdOylue9rzjZcy+rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736933422; x=1737538222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUvTAUuK+vE10J1nLZZBp9eFGzFCe1s5alimZzVlJt4=;
        b=KlHftGcDBIATzFX0M8mhcprjwuYpKteAVpEIml7Ml6kCuSGO609APeQiNIIkyf/20l
         bpruC/+ip0MPV2b5JIlSz6F2ClSWikwM8PfxyJwQbWxIEGF/RT1+m9t5+0/TXGC1Qzl7
         HifI1NC3ocBU+1iDWoOGx2vsl+DXatTo21edk91+1059ryWl7LgDnRr5W4Nq3UN8G7Yp
         woI4fCYJyYlzqgpBdQXiaRYPekmRytTR0K9l+b2hcxDfdZvXvnHSf7oV/iLXcJRnyPD8
         NlaRHAUBQCrM1Bco3+s02FUVCVLx8OMrr0lmjQAR1M4leNiuQn+ctlxH/qmwf8rOct/t
         wYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4V0u18oimhc0WTLezqbw+HFryFarRV90WFulV1Yx9X0AM61rFXMtQ95Je4OdARaPXkRoR/Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiUZQq3SB2jyZ8/EPa+/Kv4Z9R3oG4zm1iJzkhk/NEd3NqXPd
	FGAf8AevOX6hVFcD/2n+bECPO+BCML4mUfsviT/fpm3U/g7uWkqjg4Pfe8fjmGY=
X-Gm-Gg: ASbGnct+mxu543bZuqwxI0tBuhwFVq//V3T7CC+fsV10TeoXL5FrtqJhQXzRO4TDxWy
	6PHH+nT6jAnV2Cr2yqFLZqnPEzf9QekprdwF0KYzs1Tvk1XlsmE8ZquBKG10zVJuiapaf3K77qM
	tBIz4XkFudTYHanvW9zQTwFaYuHHkRQXUevVF7Riwa/MTG/bMHhWMAqa/zhqaFkl4NSYQYgGVWG
	jZu+uLl+C5Qm+zjAATTrQDEaB3+nfyDeviHGmAmArcdXLEn2padEGcRXrSa8erpVOwj
X-Google-Smtp-Source: AGHT+IGtldPQMqTNqi9uHaVCsMWaiGg1PqZfK+gt9wwMVCogFlQaUNx7qGV0JPnGS4gfh1zxsjxG3Q==
X-Received: by 2002:adf:9799:0:b0:38a:888c:7df0 with SMTP id ffacd0b85a97d-38a888c8017mr20207223f8f.1.1736933421232;
        Wed, 15 Jan 2025 01:30:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383df8sm17410830f8f.38.2025.01.15.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:30:20 -0800 (PST)
Date: Wed, 15 Jan 2025 10:30:18 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4eAKvX1A3-sV1XE@phenom.ffwll.local>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txHupDKRShZLe8FA2kJwov-ScDASqJouUdxbMZ3X=U1-Q@mail.gmail.com>
 <871px5iwbx.fsf@intel.com>
 <2025011551-volatile-turbofan-52ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025011551-volatile-turbofan-52ab@gregkh>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Wed, Jan 15, 2025 at 10:11:00AM +0100, Greg KH wrote:
> On Tue, Jan 14, 2025 at 11:22:26AM +0200, Jani Nikula wrote:
> > On Tue, 14 Jan 2025, Dave Airlie <airlied@gmail.com> wrote:
> > > On Sun, 12 Jan 2025 at 22:19, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wrote:
> > >> > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
> > >>
> > >> <snip>
> > >>
> > >> > Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close")
> > >> > Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > >> > Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
> > >> > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > >> > Cc: stable@vger.kernel.org # 6.12+
> > >> > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > >> > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > >> > Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.571528-2-umesh.nerlige.ramappa@intel.com
> > >> > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
> > >> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > >>
> > >> Oh I see what you all did here.
> > >>
> > >> I give up.  You all need to stop it with the duplicated git commit ids
> > >> all over the place.  It's a major pain and hassle all the time and is
> > >> something that NO OTHER subsystem does.
> > >
> > > Let me try and work out what you think is the problem with this
> > > particular commit as I read your email and I don't get it.
> > >
> > > This commit is in drm-next as  55039832f98c7e05f1cf9e0d8c12b2490abd0f16
> > > and says Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset
> > > OAC_CONTEXT_ENABLE on OA stream close)
> > >
> > > It was pulled into drm-fixes a second time as a cherry-pick from next
> > > as f0ed39830e6064d62f9c5393505677a26569bb56
> > > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
> > >
> > > Now the commit it Fixes: 8135f1c09dd2 is also at
> > > 0c8650b09a365f4a31fca1d1d1e9d99c56071128
> > >
> > > Now the above thing you wrote is your cherry-picked commit for stable?
> > > since I don't see
> > > (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)
> > > in my tree anywhere.
> > 
> > The automatic cherry-pick for 6.12 stable failed, and Umesh provided the
> > manually cherry-picked patch for it, apparently using -x in the process,
> > adding the second cherry-pick annotation. The duplicate annotation
> > hasn't been merged to any tree, it's not part of the process, it's just
> > what happened with this manual stable backport. I think it would be wise
> > to ignore that part of the whole discussion. It's really not that
> > relevant.
> 
> On the contrary, this commit shows the whole problem very well.  It is
> trivial for people to get confused, the author submitted a backport of a
> commit that is NOT in Linus's tree because they got an email telling of
> a failure and didn't use the correct id because they looked in the
> drm-next branch, NOT in Linus's branch.
> 
> Which is why I flagged it, as the commit id used here was not a valid
> one at this point in time.  Yes, after -rc1 it would be valid, but
> again, totally confusing.
> 
> You all are seeing confusion with this development model.  That's the
> issue.  Whether or not it's intentional, that's the result.  And because
> of it, I am telling you all, the kernel is less secure as it allows us
> all to get confused and mis backports and drop fixes incorrectly.
> 
> So either you all change the process, or just live with it and the
> consequences of having total confusion at times and grumpy stable
> developers because of it, and less secure users due to missed bug and
> security fixes.

We won't change our process, because I couldn't find the maintainer
volunteers to make that happen. And I don't think you can find them for
me.

Full answer here:

https://lore.kernel.org/dri-devel/Z4d6406b82Pu1PRV@phenom.ffwll.local/

And all we need to sort out the fallout is that
- drm maintainers consistently add cherry-picked from lines (which means
  you need to stop shouting about them)
- downstream consumers look at cherry-picked from lines to figure out all
  the sha1 aliases a commit has, which with the dumbest git log script
  here takes less than a second here to check

I've tried to explain this here in a reply to Sasha:

https://lore.kernel.org/dri-devel/Z4aNwGys3epVzf7G@phenom.ffwll.local/

And yes I'm aware this breaks your workflow, we've had these discussions
at regularly scheduled intervals for as long as we've been doing the
committer model. And I've been trying for as long to explain what you need
to adjust to cope, purely using scripts.

This shit is easy, except somehow here we are almost a decade later.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

