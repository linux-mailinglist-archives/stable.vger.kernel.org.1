Return-Path: <stable+bounces-92783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913779C580C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3973BB3B6D2
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4D1B5829;
	Tue, 12 Nov 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/eC5AFP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8201F7784;
	Tue, 12 Nov 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413046; cv=none; b=g79xP7eoiZGl2cbxfAxgXFaarPSUlXR9J2J3zX6BByzRUQsU+sWyGUOZb0mzcL/DAGCGTWkZ4q/HIuniHdrjyWfvcO2fHET7pdIDAHviIsGRqdttFkoTVd8qDHH0TsHHlbUJTUArZBn6Mn07og5ec3OKoRXr6kdtcFLu/FU9UoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413046; c=relaxed/simple;
	bh=HeP2W/OXmga70MZS97AaNrrWpIe9hridJ7xNHqRDGYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxuctl3KNe2/OQpexrDpKqBCPieit6upGsGNiBKFz7dFSs9waiVZL/uG4wnFTPS6ZDujDsDgdfODwI9/XTm8fM8PWPmNDWp1ZMN/g/jVivBHpdH7VI++8PpxD9CYEWKRofDLEat965ZzWCmaDKqZtvPzSdIN+Z7C6GensdNRRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/eC5AFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A076C4CED6;
	Tue, 12 Nov 2024 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731413046;
	bh=HeP2W/OXmga70MZS97AaNrrWpIe9hridJ7xNHqRDGYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/eC5AFPzmU1kUZTyB4yCpoaBi49jk9YrQPv5eR0cyFdesCZD7OyqvpcFlSFt9gIA
	 paMV0KNZWJb5GJELm4Kzf7DVcGRLpZyA71oLGsFlCYSwVSMCOYpi9RpY4LTvGVjS3V
	 7s7+Its1+ui2S6j1pTaL5IfCf354bLWs/EeaOd+U=
Date: Tue, 12 Nov 2024 13:04:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
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
Message-ID: <2024111225-regulate-ruckus-1a46@gregkh>
References: <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
 <ZyMkvAkZXuoTHFtd@eldamar.lan>
 <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
 <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>
 <Zypwz65wRM-FMXte@eldamar.lan>
 <2024110652-blooming-deck-f0d9@gregkh>
 <Zysdc3wJy0jAYHzA@eldamar.lan>
 <CABBYNZKz_5bnBxrBC3SoaGc1MTXXYsgdOXB42B0x+2dcPRkJyw@mail.gmail.com>
 <2024110703-subsoil-jasmine-fcaa@gregkh>
 <4f8542be-5175-4cf1-9c39-1809a899601c@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f8542be-5175-4cf1-9c39-1809a899601c@leemhuis.info>

On Tue, Nov 12, 2024 at 12:54:46PM +0100, Thorsten Leemhuis wrote:
> On 07.11.24 05:38, Greg KH wrote:
> > On Wed, Nov 06, 2024 at 10:02:40AM -0500, Luiz Augusto von Dentz wrote:
> >> On Wed, Nov 6, 2024 at 2:40 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
> >>> On Wed, Nov 06, 2024 at 08:26:05AM +0100, Greg KH wrote:
> >>>> On Tue, Nov 05, 2024 at 08:23:59PM +0100, Salvatore Bonaccorso wrote:
> >>>>> On Tue, Nov 05, 2024 at 12:53:50PM -0500, Luiz Augusto von Dentz wrote:
> >>>>>> On Tue, Nov 5, 2024 at 12:29 PM Thorsten Leemhuis
> >>>>>> <regressions@leemhuis.info> wrote:
> >>>>>>> On 31.10.24 07:33, Salvatore Bonaccorso wrote:
> >>>>>>>> On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
> >>>>>>>>> On 12.06.24 14:04, Greg KH wrote:
> >>>>>>>>>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
> >>>>>>>>>>> On 03.06.24 22:03, Mike wrote:
> >>>>>>>>>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
> >>>>>>>>>>>> [...]
> >>>>>>>>>>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
> >>>>>>>>>>>> time to be
> >>>>>>>>>>>> included in Debian stable, so having a patch for 6.1.x will be much
> >>>>>>>>>>>> appreciated.
> >>>>>>>>>>>> I do not have the time to follow the vanilla (latest) release as is
> >>>>>>>>>>>> likely the case for
> >>>>>>>>>>>> many other Linux users.
> >>>>>>>>>>>>
> >>>>>>>>>>> Still no reaction from the bluetooth developers. Guess they are busy
> >>>>>>>>>>> and/or do not care about 6.1.y. In that case:
> >>>>>>>>>>>
> >>>>>>>>>>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
> >>>>>>>>>>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
> >>>>>>>>>>> cause this or if it's missing some per-requisite? If not I wonder if
> >>>>>>>>>>> reverting that patch from 6.1.y might be the best move to resolve this
> >>>>>>>>>>> regression. Mike earlier in
> >>>>>>>>>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
> >>>>>>>>>>> confirmed that this fixed the problem in tests. Jeremy (who started the
> >>>>>>>>>>> thread and afaics has the same problem) did not reply.
> >>>>>>>>>>
> >>>>>>>>>> How was this reverted?  I get a bunch of conflicts as this commit was
> >>>>>>>>>> added as a dependency of a patch later in the series.
> >>>>>>>>>>
> >>>>>>>>>> So if this wants to be reverted from 6.1.y, can someone send me the
> >>>>>>>>>> revert that has been tested to work?
> >>>>>>>>>
> >>>>>>>>> Mike, can you help out here, as you apparently managed a revert earlier?
> >>>>>>>>> Without you or someone else submitting a revert I fear this won't be
> >>>>>>>>> resolved...
> >>>>>>>>
> >>>>>>>> Trying to reboostrap this, as people running 6.1.112 based kernel
> >>>>>>>> seems still hitting the issue, but have not asked yet if it happens as
> >>>>>>>> well for 6.114.
> >>>>>>>>
> >>>>>>>> https://bugs.debian.org/1086447
> >>>>>>>>
> >>>>>>>> Mike, since I guess you are still as well affected as well, does the
> >>>>>>>> issue trigger on 6.1.114 for you and does reverting changes from
> >>>>>>>> a13f316e90fdb1 still fix the issue? Can you send your
> >>>>>>>> backport/changes?
> >>>>>>>
> >>>>>>> Hmmm, no reply. Is there maybe someone in that bug that could create and
> >>>>>>> test a new revert to finally get this resolved upstream? Seem we
> >>>>>>> otherwise are kinda stuck here.
> >>>>>>
> >>>>>> Looks like we didn't tag things like 5af1f84ed13a ("Bluetooth:
> >>>>>> hci_sync: Fix UAF on hci_abort_conn_sync") and a239110ee8e0
> >>>>>> ("Bluetooth: hci_sync: always check if connection is alive before
> >>>>>> deleting") that are actually fixes to a13f316e90fdb1.
> >>>>>
> >>>>> Ah good I see :). None of those were yet applied to the 6.1.y series
> >>>>> were the issue is still presend. Would you be up to provide the needed
> >>>>> changes to the stable team?  That would be very much appreciated for
> >>>>> those affected running the 6.1.y series.
> >>>>
> >>>> We would need backports for these as they do not apply cleanly :(
> >>>
> >>> Looks our mails overlapped, yes came to the same conclusion as I tried
> >>> to apply them on top of 6.1.y. I hope Luiz can help here.
> >>>
> >>> We have defintively users in Debian affected by this, and two
> >>> confirmed that using a newer kernel which contains naturally those
> >>> fixes do not expose the problem. If we have backports I might be able
> >>> to convice those affected users to test our 6.1.115-1 + patches to
> >>> verify the issue is gone.
> >>
> >> Then perhaps it is easier to just revert that change?
> > 
> > Please send a revert then.
> 
> We afaics are kinda stuck here .
> 
> Seems Mike (who apparently had a local revert that worked) does not care
> anymore.
> 
> It looks like Luiz does not care about 6.1.y either, which is fine, as
> participation in stable is optional.
> 
> And looks like nobody else cares enough and has the skills to
> prepare and submit a revert.
> 
> In the end the one that asked for the changes to be included in the
> 6.1.y series thus submit one. Not sure who that is, though, a very quick
> search on Lore gave no answer. :-/
> 
> There is also still the question "might a revert now cause another
> regression for users of the 6.1.y series, as the change might improved
> things for other users".
> 
> :-(

I care as this affects Debian, which is the largest user of Linux
outside of Android.  I'll try to do a local version of the revert to
unstick this...

thanks for reminding me.

greg k-h

