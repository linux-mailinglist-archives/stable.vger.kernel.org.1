Return-Path: <stable+bounces-90078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7C9BDF8E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49A31C22E8D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27E1CF2A6;
	Wed,  6 Nov 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWuRQkpm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A04198E7B;
	Wed,  6 Nov 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878840; cv=none; b=dR3jf3POkZPfiAPk0L+94p5iI85+TKnasdBunbjAEOCS5xkEkoet37x5gk1/51vbE+4p3psQE+acaNI0rR8GmauDg2DLmYhGkZUrMlP3PgnmVTi02H1yL68cwM3zweJ93xh+30pdhh8ToJTw0mXnR5/rJgP2kIUMU+ceT5IQ2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878840; c=relaxed/simple;
	bh=fb5fzNhwc+lWe3wvvd/q1qYAFFf+KRzbKKz70tt04BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6rUgTRAAha3757ZEsm4KYhWbH0iEaVJUbCyXeLZLyAZpaPzBwSLdBsVKX7Nyib8rIs16WC3oJ66c/kBcrFJ+XuMkDXiK8Agz7A2tFEuc0fwt37zH/y84TMHls3/OiNlb0HI0dBL/j9iGftrDIEhYTRWbFDFqIn28tIKOh+8u9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWuRQkpm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so7191514a12.2;
        Tue, 05 Nov 2024 23:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730878837; x=1731483637; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLQaE2WA4hvrT0CDz4HKos+x3d+Wlb0YolEd04HVFZA=;
        b=DWuRQkpmfO7CX0nbJOArO1T4qAH4huEj/4mEInTlqvuDga7+MJry8ngi+GjTh8VSWy
         KRicb5Uyq89yZendnfmdDYfp+l1pg97Db3KIcc2Ff3iH/C8mQM2VdqM3FXex5yXZbrL2
         4ZUJg+bU5MNauxJUA4tuybDtYNiRyAumW3s+ZwdyiQLMVtHooP4HKZgGSr8HWyR2AYUs
         EdgLF4Ka+kmgcEpP0Sab8SX13o1cPY12jmH8L43KhBzvD728VifTSZUoJhAwmlXHoVsR
         A2KIFCIQ0oLXLH5bLYRgT3rLrr5Zj0VOu4lw2kPv8pkxlOXzThuV1hLtq0ii0v4KCAPa
         9+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878837; x=1731483637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLQaE2WA4hvrT0CDz4HKos+x3d+Wlb0YolEd04HVFZA=;
        b=cspbr6/Tj4Efd51peQOk9u8XU2KolZ8LKnf7x6JMEjmJdxy3q3IuZhkx6qWMkxHqs8
         roo6VHxPtJz4C64FxH6eUx61VYqQRWq6tp57Oks8xWLxMyPoHyzgKQjAUncD+NWoEHxG
         as1iOHfBscHZpHqohMOPKE5/pdMgZy2lPwW2LhTCoVG6bmtd/mZHtTRtRBZqax5smOrp
         zpSAGFejIhvfC4MlW+E56jr5kGVbQfleVL0oswIznuO4yrIrP4Mwm6/EMtIk0F1PFmNN
         KcfLSderselsRc07wMf0rdGRoFWu7H/W/GaxeNJr0c4v9hDelFpJqza9lczDUOTz5q76
         C3pg==
X-Forwarded-Encrypted: i=1; AJvYcCVEzHxEh1Ito8ZMSgWa7+SvkY1xTqFxbn1p68wGqj/OOBz+HUfdY1yxIhC7VBtlHyjQA/0cVf/VumK0E9DBNw0=@vger.kernel.org, AJvYcCW0cQ1nuySOK9i6RC0DJC2xYwQnZhju2ks7Obt1jbHeq2UUsaOZec9oGdE+E2sfvsrDHighlBrv@vger.kernel.org
X-Gm-Message-State: AOJu0YxC65oujeip/VHHe6p5EaHxWxdC8XkvmS5m/mW3+L8Jhc0/2t3W
	bYEYS2JfFZd4H2ETrI1CIQ/X53gRWI5/haIeSYQnve7ZflFP/ef3
X-Google-Smtp-Source: AGHT+IElJg9+yI8f7RqpCIg3pJN1HZV7VkMRbxvF2+K20uhiJiHmX/9sobMGqNWvcKr8NnwzsguvaA==
X-Received: by 2002:a05:6402:3595:b0:5cb:def2:be0a with SMTP id 4fb4d7f45d1cf-5cbdef2bf78mr24296390a12.21.1730878836861;
        Tue, 05 Nov 2024 23:40:36 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe0a2sm2336646a12.60.2024.11.05.23.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:40:36 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 129FEBE2DE0; Wed, 06 Nov 2024 08:40:35 +0100 (CET)
Date: Wed, 6 Nov 2024 08:40:35 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Mike <user.service2016@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>,
	Jeremy =?iso-8859-1?Q?Lain=E9?= <jeremy.laine@m4x.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
Message-ID: <Zysdc3wJy0jAYHzA@eldamar.lan>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
 <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
 <ZyMkvAkZXuoTHFtd@eldamar.lan>
 <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
 <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>
 <Zypwz65wRM-FMXte@eldamar.lan>
 <2024110652-blooming-deck-f0d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024110652-blooming-deck-f0d9@gregkh>

Hi Greg,

On Wed, Nov 06, 2024 at 08:26:05AM +0100, Greg KH wrote:
> On Tue, Nov 05, 2024 at 08:23:59PM +0100, Salvatore Bonaccorso wrote:
> > Hi Luiz,
> > 
> > On Tue, Nov 05, 2024 at 12:53:50PM -0500, Luiz Augusto von Dentz wrote:
> > > Hi,
> > > 
> > > On Tue, Nov 5, 2024 at 12:29 PM Thorsten Leemhuis
> > > <regressions@leemhuis.info> wrote:
> > > >
> > > > On 31.10.24 07:33, Salvatore Bonaccorso wrote:
> > > > > On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
> > > > >> On 12.06.24 14:04, Greg KH wrote:
> > > > >>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
> > > > >>>> On 03.06.24 22:03, Mike wrote:
> > > > >>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
> > > > >>>>> [...]
> > > > >>>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
> > > > >>>>> time to be
> > > > >>>>> included in Debian stable, so having a patch for 6.1.x will be much
> > > > >>>>> appreciated.
> > > > >>>>> I do not have the time to follow the vanilla (latest) release as is
> > > > >>>>> likely the case for
> > > > >>>>> many other Linux users.
> > > > >>>>>
> > > > >>>> Still no reaction from the bluetooth developers. Guess they are busy
> > > > >>>> and/or do not care about 6.1.y. In that case:
> > > > >>>>
> > > > >>>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
> > > > >>>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
> > > > >>>> cause this or if it's missing some per-requisite? If not I wonder if
> > > > >>>> reverting that patch from 6.1.y might be the best move to resolve this
> > > > >>>> regression. Mike earlier in
> > > > >>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
> > > > >>>> confirmed that this fixed the problem in tests. Jeremy (who started the
> > > > >>>> thread and afaics has the same problem) did not reply.
> > > > >>>
> > > > >>> How was this reverted?  I get a bunch of conflicts as this commit was
> > > > >>> added as a dependency of a patch later in the series.
> > > > >>>
> > > > >>> So if this wants to be reverted from 6.1.y, can someone send me the
> > > > >>> revert that has been tested to work?
> > > > >>
> > > > >> Mike, can you help out here, as you apparently managed a revert earlier?
> > > > >> Without you or someone else submitting a revert I fear this won't be
> > > > >> resolved...
> > > > >
> > > > > Trying to reboostrap this, as people running 6.1.112 based kernel
> > > > > seems still hitting the issue, but have not asked yet if it happens as
> > > > > well for 6.114.
> > > > >
> > > > > https://bugs.debian.org/1086447
> > > > >
> > > > > Mike, since I guess you are still as well affected as well, does the
> > > > > issue trigger on 6.1.114 for you and does reverting changes from
> > > > > a13f316e90fdb1 still fix the issue? Can you send your
> > > > > backport/changes?
> > > >
> > > > Hmmm, no reply. Is there maybe someone in that bug that could create and
> > > > test a new revert to finally get this resolved upstream? Seem we
> > > > otherwise are kinda stuck here.
> > > 
> > > Looks like we didn't tag things like 5af1f84ed13a ("Bluetooth:
> > > hci_sync: Fix UAF on hci_abort_conn_sync") and a239110ee8e0
> > > ("Bluetooth: hci_sync: always check if connection is alive before
> > > deleting") that are actually fixes to a13f316e90fdb1.
> > 
> > Ah good I see :). None of those were yet applied to the 6.1.y series
> > were the issue is still presend. Would you be up to provide the needed
> > changes to the stable team?  That would be very much appreciated for
> > those affected running the 6.1.y series. 
> 
> We would need backports for these as they do not apply cleanly :(

Looks our mails overlapped, yes came to the same conclusion as I tried
to apply them on top of 6.1.y. I hope Luiz can help here.

We have defintively users in Debian affected by this, and two
confirmed that using a newer kernel which contains naturally those
fixes do not expose the problem. If we have backports I might be able
to convice those affected users to test our 6.1.115-1 + patches to
verify the issue is gone.

Regards,
Salvatore

