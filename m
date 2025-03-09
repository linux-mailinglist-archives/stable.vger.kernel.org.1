Return-Path: <stable+bounces-121625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C4A58847
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368353AC847
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF421ABD9;
	Sun,  9 Mar 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qEA9j6PZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F01E1DF1
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741553777; cv=none; b=WHQYHPVg9ECm0niti4D6uSUs1tpTXB7v85tkIovsJL9pvqUa7385mKTGQoWPxhx1UFWzWwGrMpLmr27kKLeDc+Yftj9jIAmg0Pt585F7BGT8wltvnQr1pqbgz+F1dignPZbw7t2MFnGZ454R7w1Sfl9dP6uUutJz+P5oAtTQgtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741553777; c=relaxed/simple;
	bh=+wIprD5htUOThqNwNN9EIjBCKctur6dEjUgLAQUY/AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKci3st7lMEaZHArEPJHl2xmD+yTsmDkoM1HgZvhnsttQdQ++G+u7ZrNB4WmWT/P8H6cDpCgtqMtNpXJrklDnlqQJtyLXgrWes2FYdjVTvyN95ybP8wXpIDv77rePtanZhTTeJT7NqgNU/gfPa5ZSySsVsx3XSsQB6wf/zs6HsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qEA9j6PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1EDC4CEE3;
	Sun,  9 Mar 2025 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741553777;
	bh=+wIprD5htUOThqNwNN9EIjBCKctur6dEjUgLAQUY/AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEA9j6PZkVnwBqA18lDCxt9LVimvGkiWDZwrg53S5Y5LKwwk5M6pbYYLBodk/qtPv
	 XCraEOXURg42hCpegf24RYkdLPSg4fVplK0ivJYqEk8qQS1X/EnXU0VUR8ROI1y9kh
	 MQOyYmS52XZSNfbZl116xrvM44j0E9mgYA795BwM=
Date: Sun, 9 Mar 2025 21:56:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <boddah8794@gmail.com>
Cc: lk@c--e.de, heikki.krogerus@linux.intel.com, stable@vger.kernel.org
Subject: Re: patch "acpi: typec: ucsi: Introduce a ->poll_cci method" added
 to usb-linus
Message-ID: <2025030951-rally-umpire-66fa@gregkh>
References: <2025021909-thirstily-esteemed-c72c@gregkh>
 <6y2km6lrqjfzgmf6aoetm6ts2b5okzoxzejtqpulkppudwgc5i@ja2oaw6ljqml>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6y2km6lrqjfzgmf6aoetm6ts2b5okzoxzejtqpulkppudwgc5i@ja2oaw6ljqml>

On Sun, Mar 09, 2025 at 11:46:43PM +0300, Fedor Pchelkin wrote:
> On Wed, 19. Feb 15:20, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     acpi: typec: ucsi: Introduce a ->poll_cci method
> > 
> > to my usb git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> > in the usb-linus branch.
> > 
> > The patch will show up in the next release of the linux-next tree
> > (usually sometime within the next 24 hours during the week.)
> > 
> > The patch will hopefully also be merged in Linus's tree for the
> > next -rc kernel release.
> > 
> > If you have any questions about this process, please let me know.
> > 
> > 
> > From 976e7e9bdc7719a023a4ecccd2e3daec9ab20a40 Mon Sep 17 00:00:00 2001
> > From: "Christian A. Ehrhardt" <lk@c--e.de>
> > Date: Mon, 17 Feb 2025 13:54:39 +0300
> > Subject: acpi: typec: ucsi: Introduce a ->poll_cci method
> > 
> > For the ACPI backend of UCSI the UCSI "registers" are just a memory copy
> > of the register values in an opregion. The ACPI implementation in the
> > BIOS ensures that the opregion contents are synced to the embedded
> > controller and it ensures that the registers (in particular CCI) are
> > synced back to the opregion on notifications. While there is an ACPI call
> > that syncs the actual registers to the opregion there is rarely a need to
> > do this and on some ACPI implementations it actually breaks in various
> > interesting ways.
> > 
> > The only reason to force a sync from the embedded controller is to poll
> > CCI while notifications are disabled. Only the ucsi core knows if this
> > is the case and guessing based on the current command is suboptimal, i.e.
> > leading to the following spurious assertion splat:
> > 
> > WARNING: CPU: 3 PID: 76 at drivers/usb/typec/ucsi/ucsi.c:1388 ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi]
> > CPU: 3 UID: 0 PID: 76 Comm: kworker/3:0 Not tainted 6.12.11-200.fc41.x86_64 #1
> > Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN45WW 03/17/2023
> > Workqueue: events_long ucsi_init_work [typec_ucsi]
> > RIP: 0010:ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi]
> > Call Trace:
> >  <TASK>
> >  ucsi_init_work+0x3c/0xac0 [typec_ucsi]
> >  process_one_work+0x179/0x330
> >  worker_thread+0x252/0x390
> >  kthread+0xd2/0x100
> >  ret_from_fork+0x34/0x50
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > 
> > Thus introduce a ->poll_cci() method that works like ->read_cci() with an
> > additional forced sync and document that this should be used when polling
> > with notifications disabled. For all other backends that presumably don't
> > have this issue use the same implementation for both methods.
> > 
> > Fixes: fa48d7e81624 ("usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read operations")
> > Cc: stable <stable@kernel.org>
> 
> Oh, the stable tag has been mangled here.. I didn't notice this, sorry.
> Now Cc'ing the appropriate list.

It's not mangled at all, it's correct.

> Could you apply the patch to stables based on Fixes tag then, please?
> They are 6.12 and 6.13.

Will do so now, it was already in my queue.

thanks,

greg k-h

