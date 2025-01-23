Return-Path: <stable+bounces-110275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6408A1A4C5
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E731C3A3C13
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149F20F094;
	Thu, 23 Jan 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="S0R3F1GM"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31938F83;
	Thu, 23 Jan 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638391; cv=none; b=kCvjPceoqE16cw+WlG3Nf39Qfq6Jm3vPuSVqmBS6FLvl97MnNr5P9DLnm/dkSFjleXLHU5a0RynFMzbdeIm+Du25JBrMvpCyQDV5oO+lYikFYTKM4Djyc/n6MLPltMvCdlk0PkiO0yMr0jGnX/cobrxvG/Pyg3oRCVSEkytvpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638391; c=relaxed/simple;
	bh=/kihfaFGO49thI+Od/KeUYGlC98j80PRn0PUwUiPuTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBEzbiPuAn9W1tXo0CQBLnRvL0Fe4UVT+GyS7ED6uPIA1aSy5B52kuUlda6moh2A0gmVXrGHPsUpBsVDAMt3zsPlHJrA2ruxmjl+8xjivb40LWuzU22NfiGCZhe6PH5M7jtJzNI7Lhxq+1i/Q0gr/NA0PgIqjDYhXHN/8h+Cklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=S0R3F1GM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737638386;
	bh=/kihfaFGO49thI+Od/KeUYGlC98j80PRn0PUwUiPuTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0R3F1GMfZfkBmtT3YlsZb/OFPRVhImdlvD7qen0g9S1oCwbLEW839vszuxKJOwT2
	 lRt6YD2bD6lq9YfErgiYlf4eEgj5h9XRw9l9hhAzBbWetAchgxE4sj/ORcB0i9jD8J
	 A2rJgCONx/enmCRAfZYdzLMBStrT/6sa7/76/S0U=
Date: Thu, 23 Jan 2025 14:19:46 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Stultz <john.stultz@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND net] ptp: Ensure info->enable callback is always
 set
Message-ID: <779708b6-d61c-4688-92cc-6afb987334d6@t-8ch.de>
References: <20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net>
 <Z5IOHVu9L+QpyK4Y@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5IOHVu9L+QpyK4Y@mev-dev.igk.intel.com>

On 2025-01-23 10:38:37+0100, Michal Swiatkowski wrote:
> On Thu, Jan 23, 2025 at 08:22:40AM +0100, Thomas Weißschuh wrote:
> > The ioctl and sysfs handlers unconditionally call the ->enable callback.
> > Not all drivers implement that callback, leading to NULL dereferences.
> > Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.
> > 
> > Instead use a dummy callback if no better was specified by the driver.
> > 
> > Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  drivers/ptp/ptp_clock.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> > index b932425ddc6a3789504164a69d1b8eba47da462c..35a5994bf64f6373c08269d63aaeac3f4ab31ff0 100644
> > --- a/drivers/ptp/ptp_clock.c
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -217,6 +217,11 @@ static int ptp_getcycles64(struct ptp_clock_info *info, struct timespec64 *ts)
> >  		return info->gettime64(info, ts);
> >  }
> >  
> > +static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static void ptp_aux_kworker(struct kthread_work *work)
> >  {
> >  	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
> > @@ -294,6 +299,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
> >  			ptp->info->getcrosscycles = ptp->info->getcrosststamp;
> >  	}
> >  
> > +	if (!ptp->info->enable)
> > +		ptp->info->enable = ptp_enable;
> > +
> >  	if (ptp->info->do_aux_work) {
> >  		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
> >  		ptp->kworker = kthread_run_worker(0, "ptp%d", ptp->index);
> > 
> > ---
> > base-commit: c4b9570cfb63501638db720f3bee9f6dfd044b82
> > change-id: 20250122-ptp-enable-831339c62428
> > 
> > Best regards,
> > -- 
> > Thomas Weißschuh <linux@weissschuh.net>
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> What about other ops, did you check it too? Looks like it isn't needed,
> but it sometimes hard to follow.

I couldn't find any missing, but I'm not familiar with the subsystem and
didn't check too hard.

Note:

A follow-up fix would be to actually guard the users of ->enable and
error out. For sysfs the attributes could be hidden completely.
That would be a nicer user interface but more code change which are not
so easily backportable.


Thomas

