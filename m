Return-Path: <stable+bounces-89917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C19BD5CD
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611DC284129
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B7F1EABD7;
	Tue,  5 Nov 2024 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS/Q8SrU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC241E2007;
	Tue,  5 Nov 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834645; cv=none; b=P6+5nNH3LQGruMEvusHHEBdf+SMuXg4l8czA08WAa3bJDpwfqV7oiFXAqTW46Ni2HpnPoUoeEetMhNjwYDhSrA0Ci0wI4gN9hXCI64t3952lYhYGnNonzylpj2s3ESfvXpwEHpW0L4cpovnIXajUFRhxxfuI+YbRiysBlfB7CrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834645; c=relaxed/simple;
	bh=g+2efGR3dbdcPr1Nw5UNBnPimF0qmnyHzg9hIT10bfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdIpw6oHG6HTVEn8H8ZV6xoQzYBTwAfzSO1ytlQgSe6COIqQwMrfBhO/DNzsLUjZ/VX3qaOZnNHcVc8pMmM+xnU94I2oMfl/DSFAuAOzhu/Ihx4g7CZUgZphlImCf09HCDzX998XMB4qM3NFzRFWSupkBUIKmOSDlZVq/knjWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS/Q8SrU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so189102a12.1;
        Tue, 05 Nov 2024 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730834642; x=1731439442; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSZJcZhNNgaAJYyZ3UhxJyhh0uxdQZk+eTwkMHAe5g8=;
        b=iS/Q8SrUTttp3IxtgYei7hdBnV6iExg9xse8zTbZYq+A7XpXjWmUJEXKaL2ZF86hOv
         CUxHi8Aj5+I+mkBlACAiNS7ojYugbk+aEjkyXGVnoTUFKU0qhrKKcYL7j3sce2shwIeb
         /lyUcEm81QZ6NqrZKIyKk7m3dSrKqQ0rKmuYUJHt8pr5SK/Y3Oh4HA+SpYYfnAD7OLnz
         EmOh1wqJZOo6gf6P9RPit2VhvWh4UcvokRqOANezafK+y7v8oXlQe6aFU3c9LOTiNrgn
         0oShdnqu+oXFwIeeiQucVrNUEfPLV7XqVm9y3iUql6AIyao0Nh6Nl+7aiPSxM+c/1xhk
         0k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730834642; x=1731439442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSZJcZhNNgaAJYyZ3UhxJyhh0uxdQZk+eTwkMHAe5g8=;
        b=JbYeFbHU2POIznrPp+pWYHNPdvCQfLml86F/0f6rEnJtXWt3PBCWRLDYhTTNTDZVHa
         tUbsR4P2c3yhmOIkzB38wQXuN0LWrvktehCh6aTFUSP487jiQ//YovYRuRv2DpjqzXi+
         XFf6exGRivFmdw84F543E+mWse3mQJSBhffsrrk53qezn6L+/Nxdx8ElSQy9aqhWOjEP
         uXqrLGtq9SGHpgrQada/aO+izTHJ692UE646INgWrRNEggj4DBmglMrNsUcXOMxE7vMQ
         NK0p65nO1KDufl9E6bBDoyX3FRgKM+Bh9Jskn3JItau99bn8nK1c4c3IU32rag/3lgIO
         NXBg==
X-Forwarded-Encrypted: i=1; AJvYcCWfYztg/Btznb4OHWzBBQk1oW+ws/k8WeM0KKfBxhjOi13U3RryQyYHGuzWTv8L3NiFq6c4Kn4Spq+NG1lbme4=@vger.kernel.org, AJvYcCWiWUj6ww37+vgJP0szzmrWh306IcEVyPpNvrfAa+UDzpHCEsf1T+yrH7BHcy1VrpyrPir9ru2r@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg19FPxNxnGTuTxUvaFigVDh/Y6+FnjOSyIj7lnmQ1tNg8ElUP
	V1mgsiF9/fnwMn6d2kKvJ+HHdRFxhXHnGx3KWjeIPtghK4Q4wpiE
X-Google-Smtp-Source: AGHT+IFqmxGKbX+wPZMvD7DNqJ/lCN4Fe1cK8sPG0leKEKeUroKvuDOSZ/LS2QoVoCTnXi7430au1g==
X-Received: by 2002:a17:907:9446:b0:a99:f209:cea3 with SMTP id a640c23a62f3a-a9e55a4f2b9mr1920250966b.11.1730834642033;
        Tue, 05 Nov 2024 11:24:02 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16aecbasm173841666b.32.2024.11.05.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:24:00 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id D0506BE2DE0; Tue, 05 Nov 2024 20:23:59 +0100 (CET)
Date: Tue, 5 Nov 2024 20:23:59 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Mike <user.service2016@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>,
	Jeremy =?iso-8859-1?Q?Lain=E9?= <jeremy.laine@m4x.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
Message-ID: <Zypwz65wRM-FMXte@eldamar.lan>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
 <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
 <ZyMkvAkZXuoTHFtd@eldamar.lan>
 <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
 <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>

Hi Luiz,

On Tue, Nov 05, 2024 at 12:53:50PM -0500, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Nov 5, 2024 at 12:29 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > On 31.10.24 07:33, Salvatore Bonaccorso wrote:
> > > On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
> > >> On 12.06.24 14:04, Greg KH wrote:
> > >>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
> > >>>> On 03.06.24 22:03, Mike wrote:
> > >>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
> > >>>>> [...]
> > >>>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
> > >>>>> time to be
> > >>>>> included in Debian stable, so having a patch for 6.1.x will be much
> > >>>>> appreciated.
> > >>>>> I do not have the time to follow the vanilla (latest) release as is
> > >>>>> likely the case for
> > >>>>> many other Linux users.
> > >>>>>
> > >>>> Still no reaction from the bluetooth developers. Guess they are busy
> > >>>> and/or do not care about 6.1.y. In that case:
> > >>>>
> > >>>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
> > >>>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
> > >>>> cause this or if it's missing some per-requisite? If not I wonder if
> > >>>> reverting that patch from 6.1.y might be the best move to resolve this
> > >>>> regression. Mike earlier in
> > >>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
> > >>>> confirmed that this fixed the problem in tests. Jeremy (who started the
> > >>>> thread and afaics has the same problem) did not reply.
> > >>>
> > >>> How was this reverted?  I get a bunch of conflicts as this commit was
> > >>> added as a dependency of a patch later in the series.
> > >>>
> > >>> So if this wants to be reverted from 6.1.y, can someone send me the
> > >>> revert that has been tested to work?
> > >>
> > >> Mike, can you help out here, as you apparently managed a revert earlier?
> > >> Without you or someone else submitting a revert I fear this won't be
> > >> resolved...
> > >
> > > Trying to reboostrap this, as people running 6.1.112 based kernel
> > > seems still hitting the issue, but have not asked yet if it happens as
> > > well for 6.114.
> > >
> > > https://bugs.debian.org/1086447
> > >
> > > Mike, since I guess you are still as well affected as well, does the
> > > issue trigger on 6.1.114 for you and does reverting changes from
> > > a13f316e90fdb1 still fix the issue? Can you send your
> > > backport/changes?
> >
> > Hmmm, no reply. Is there maybe someone in that bug that could create and
> > test a new revert to finally get this resolved upstream? Seem we
> > otherwise are kinda stuck here.
> 
> Looks like we didn't tag things like 5af1f84ed13a ("Bluetooth:
> hci_sync: Fix UAF on hci_abort_conn_sync") and a239110ee8e0
> ("Bluetooth: hci_sync: always check if connection is alive before
> deleting") that are actually fixes to a13f316e90fdb1.

Ah good I see :). None of those were yet applied to the 6.1.y series
were the issue is still presend. Would you be up to provide the needed
changes to the stable team?  That would be very much appreciated for
those affected running the 6.1.y series. 

Thanks a lot for pointing out the fixes!

Regards,
Salvatore

