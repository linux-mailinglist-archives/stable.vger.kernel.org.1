Return-Path: <stable+bounces-114203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2EA2BBE5
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 07:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C141886B1D
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3B19CC3A;
	Fri,  7 Feb 2025 06:59:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58E199238;
	Fri,  7 Feb 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911553; cv=none; b=f2WB7ArS2r/wgz2UU/lGevy0GA/WEpx9+xFXUjO9m+AQdG4rk/LkO19JdkZJo03QKTvizBgIifrER5r7Jt23iABvWjOUjH+dMFFQhtQO+EiM11y4+MTJ85A640LYeclqI9maN9oiv9cgaYbNfGaI3d59QIC6y7ND9YuS4ONpJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911553; c=relaxed/simple;
	bh=sQPauGVYFUvdUbBLw5jDAST028vG91moT9s41QDprpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc8Z7Qh+iuDBGq9X/H1C27gsOoMi+G+mzFbmtsSq9tGwXa5tJvrJkfGj22mmNtvWXcMQlCk1zicTuYu03WjOsUOQaJx+XAKcgdVFz7iRv6I00Rlyjx5ywkxsQpzk+wplPws9J6pMIFw/C3CO0GKah9jMv3/4tfj1U4j/VyB6CRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 05D5514033D; Fri,  7 Feb 2025 07:51:46 +0100 (CET)
Date: Fri, 7 Feb 2025 07:51:46 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Fedor Pchelkin <boddah8794@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] acpi: typec: ucsi: Introduce a ->poll_cci method
Message-ID: <Z6WtgqH5CaKTfaDX@cae.in-ulm.de>
References: <20250206184327.16308-1-boddah8794@gmail.com>
 <20250206184327.16308-2-boddah8794@gmail.com>
 <CAA8EJpr=SBQ29m8_iCigUKMHzrdbTFRSpTHv4Aapo55hMVOcaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr=SBQ29m8_iCigUKMHzrdbTFRSpTHv4Aapo55hMVOcaw@mail.gmail.com>


Hi,

On Fri, Feb 07, 2025 at 02:38:03AM +0200, Dmitry Baryshkov wrote:
> On Thu, 6 Feb 2025 at 20:43, Fedor Pchelkin <boddah8794@gmail.com> wrote:
> >
> > From: "Christian A. Ehrhardt" <lk@c--e.de>
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
> 
> Should the ucsi_init() also use ->poll_cci instead of ->read_cci?
> Although it's executed with notifications enabled, it looks as if it
> might need the additional resync.

I don't think it should be neccessary. The command completion event
for the ucsi_send_command just above should have synced already and
anything that happens after that ought to generate an event.

Best regards,
Christian


