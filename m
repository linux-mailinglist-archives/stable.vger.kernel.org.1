Return-Path: <stable+bounces-100166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1DD9E9665
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A38D188B627
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B822CBCF;
	Mon,  9 Dec 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Wbrbwy9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0uMo6Ax"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CF223C49;
	Mon,  9 Dec 2024 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749639; cv=none; b=VI7Ht5d5eOT+cSMYTzTKggCqIy9mx2AmD8zpbqalf8G437RraLO2t9f1y2h+uVgJAJPOkFruHPKUoy2bS9DPAzEUetUEibTr5kDZm/3qS3mnVl9W4KlOZ7faybUCMOifdt48I5HiObK+Nrf+scmGT6BPgIpNasr/wsLGMDOC2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749639; c=relaxed/simple;
	bh=5jthGFd7BQg4TVzKYwNYTrAGpWJ4/MMLfVA+R9QL+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXwRZFlakg9BoAcjULNM/m+alDDioJczyioo5QAkTRWLk3/SKuLrt29M6lj30jmmPguUM+m3EDtYNBS97hJSPpUk4W6KxG4gXzBRXQ9nT1amNoXCvdg5m5kZ1SO383K1WnbkO/drTdSEbWMEC1cb8ecuQR92WsHU4tlebPfvaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Wbrbwy9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0uMo6Ax; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23DB211400B9;
	Mon,  9 Dec 2024 08:07:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 09 Dec 2024 08:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733749635; x=1733836035; bh=CQ2jXnhY5K
	Q7fSJfa+lAT2Ff1cc3zn1Q/PGhaka2NEY=; b=Wbrbwy9QOmc5h1Hzz1X8yZWlmK
	Y54nlx04FZ40mh2tDfVkLb9CvEGvk8/VYdk+tfv3qUI00wokYFdv38wtcwgRTrR0
	Sx/LM3NeSGBws784jEsTJITmdw+flAP+ZgEnihtHT4Cd59KsrryowrtUSWhxMnUa
	plW9ztIZ+4ek2RrqtJG+XOEp1x7Z3q99MTzi6x/EsXEAH9hpEJerGwKhKV36X5E7
	bocc/pEg7UCOSfQgJ3vsDLvEURnMp8xxJ1rdzjquyN2MV28Xj0x5EOLs0DT+ucL6
	30asq8pVixW4VkDqIQWC8TQDmWw0mg4tN3c9bYZZ1mVDPYaGgNaMpkRaUaeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733749635; x=1733836035; bh=CQ2jXnhY5KQ7fSJfa+lAT2Ff1cc3zn1Q/PG
	haka2NEY=; b=I0uMo6AxwPVvE3aPJ8yZMx397ReLDLgr8KkSzjMmBNACE3Ss7Od
	4vcZZY9sfrXRapwdVJdB9Sl4Y9S6bRtBB2Upr3/z5HBBmVmKh/tZTEkinIApLQMl
	s8NNjViXB6Kx9sgty0vugrrNlXCVgBSRJjYqcfVyPui51ZpW7x2HWScE65NTdakY
	4ixjwfFsnETunl9fBDK7WxHq+AFZF5HMMfA+0l6DMEwyWqF90iLgGUO/FvMKRElc
	4yvXZAVxQK3nvYnqDp5GgHvgZndmQKQZF4tZDt/TC5dWJM3XvwPAPAi/1gNm5Uo4
	3U7sgy0hTm4+oaetTak5JcLK+tKLv9LrpOA==
X-ME-Sender: <xms:gutWZ-_t2AwUQfSK6dR8nLgJ5oge-Tf8oNapQy-Z7krGff8EF4Pacw>
    <xme:gutWZ-skbECR9CkhmajXC7aZahNbKzmkPGNHMLL0ZIkN5KG5PmvVJaqBnV1jrrFd7
    HRefI4yuUzlLw>
X-ME-Received: <xmr:gutWZ0AyO2Ha-VcmnumcgOWuX5Dy060IQE8blLIXRnPu6wSsFhgJ-qrRRSUb0OWtZWncw5FA8i0eQhUIz-t6P_qbNLAxPH07TvvL_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleev
    tddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglh
    igsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprhhitghhrghruggtohgthhhrrghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gutWZ2dRPa0nH31TwmobSldmwRpkagiOnD5Om-GffMcrezuRQiAIOg>
    <xmx:gutWZzP3dXOveUQQ3GAQ0GXQDqAu6MIIg_hjJCJuwRurFDhemkBExQ>
    <xmx:gutWZwmvPMOsvQjHZZIrRrB29S4f9gW6hklpLo08qnAJKEO1gF1ikg>
    <xmx:gutWZ1suAkMxcI9pJFc_fzi0ehQo3u0iaeKvm_zYj7Qu3rDvUlAjIw>
    <xmx:g-tWZ3l70s86vZb5Mb3VEutw8tMuZlqc-eHgUjustMTDIeY-ZemPmI48>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 08:07:14 -0500 (EST)
Date: Mon, 9 Dec 2024 14:07:06 +0100
From: Greg KH <greg@kroah.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: Patch "ntp: Introduce struct ntp_data" has been added to the
 6.1-stable tree
Message-ID: <2024120954-crucial-atrium-31e1@gregkh>
References: <20241209113201.3171845-1-sashal@kernel.org>
 <87ttbdoy1u.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttbdoy1u.ffs@tglx>

On Mon, Dec 09, 2024 at 01:12:13PM +0100, Thomas Gleixner wrote:
> On Mon, Dec 09 2024 at 06:32, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > commit 57103d282a874ed716f489b7b336b8d833ba43b2
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Wed Sep 11 15:17:43 2024 +0200
> >
> >     ntp: Introduce struct ntp_data
> >     
> >     [ Upstream commit 68f66f97c5689825012877f58df65964056d4b5d ]
> >     
> >     All NTP data is held in static variables. That prevents the NTP code from
> >     being reuasble for non-system time timekeepers, e.g. per PTP clock
> >     timekeeping.
> >     
> >     Introduce struct ntp_data and move tick_usec into it for a start.
> >     
> >     No functional change.
> >     
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >     Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >     Acked-by: John Stultz <jstultz@google.com>
> >     Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de
> >     Stable-dep-of: f5807b0606da ("ntp: Remove invalid cast in time offset math")
> 
> I sent a backport of this change, which is a one liner:
> 
>   https://lore.kernel.org/stable/878qssr16f.ffs@tglx/
> 
> There is no point to backport the whole data struct change series for
> that.

Yeah, I'll drop the series and just take your change, thanks!

greg k-h

