Return-Path: <stable+bounces-20843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D860285BFBD
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 16:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63532B21A92
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652776029;
	Tue, 20 Feb 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Mx0ItV6G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czXKaZux"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0216F080
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442486; cv=none; b=mR1Y3JegqK6nYDA/BU3Goq8j/c3zwCNs9Y5bf8+fjNn17VUxfKB5AMRX8d2ILus7rG+gxozLntneOvBNAbNStpxZGgxREnz0ugtyVishQWT/AgxZmb6U4e1Y6gaLuYKxTvEQnAxdsZ6P6w+4N4UF2vDSU2IbOkz9OaJ6+EzaXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442486; c=relaxed/simple;
	bh=kjGulcH2hxYQWCzIJzTzAN0QatTZ0LK3qvzcEiesXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhR+nRoa69mvou3s2JxxuPCRgcT/MAPaZX7+bkI5rrDhkFs/orbuTXPrQMod/t8dAXyJ5Lf/K/CCtnIxIzFIzo7HR7bt7DW5Ty86/3wGFuPBN5SNOmYIw2DvSoK3rgCQ6Y1Sn+Dx7xoNoSfI9T+A7NRd52If07NV+FVZMRUT/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Mx0ItV6G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czXKaZux; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0CD4A13800A3;
	Tue, 20 Feb 2024 10:21:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 20 Feb 2024 10:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708442484; x=1708528884; bh=CqBd8HrFvQ
	frUZfCWCKvT0PT9ztXfpZhKDrA6nxXWxc=; b=Mx0ItV6GcNqxXGwUl3t8vJ4jWG
	ylAVqbv7ZODFHjWwM5bwbtPiCgsDjObq2wstVSBDR+ah7/WXV1DRWk0VoyOFQ5lK
	2Y2KmT30ux5V5Nj79U/HzDtB8BJI50BcjmBiCdQ8ZnVFmDsdxLg/RWljnQLb5k3T
	TRkILYH57YETtpqnONXz/6P3rO5B9cy17nOs/f5DmM9gMEs+s09S3jIW42t8Hei1
	7tgYNHVWlqeZd12SsB2Y4W4d1maOPkt7gjtWKmAM2+fIWkTToBZVZp0sV1FiNNI1
	r3uo6DmhZlsNQjj5lIP7sqDetDuE0xShXtfd4J3gkFwMY3aJbK+/Ka3PzEjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708442484; x=1708528884; bh=CqBd8HrFvQfrUZfCWCKvT0PT9ztX
	fpZhKDrA6nxXWxc=; b=czXKaZuxVGuw1o/kgtK8zcJswgr4lQTRhMucJZqG17WG
	3PyQtWTSYm84G4MksmurWI09SOLzaAveRT3iTF4tYzX4zhAAjz3zuQTCJykgzdMs
	46QG48MzjYFy2FpjvYv43MEvdVeJ5GDH1/cXoyRvYb54LjSsDE2wpI3zoRFW/QmS
	NS9QCF5yZFIH3uEDvkb+6z9UQJxreveKYWSqJC0dHo8JEyvXmiT1EXQQHoq9vpxQ
	PKtdiCi6Do1XaLEAgPS3+JXvX1yky/XtIE2w5euxkxJm34wpVTPY4gyss4S1Snnm
	b8q7F4agKt18V0HaFDN3frnvqwMBcDWHRyR0d5LMZA==
X-ME-Sender: <xms:c8PUZVu_BSKdbtn4DxQ-pYdDcbkXTSfmL_w0ePrB2hfXZdQ8iMsauw>
    <xme:c8PUZedXOECssvxb6SD6u-l4u33iqhYFusC1zoojhWfiIw3NE01ZlkapbzckeHhH2
    tXTVAQGab-e5g>
X-ME-Received: <xmr:c8PUZYxPS0lTT0OUUrX2wmcch-zPl_v933KsABCkFjwIdHyNNvIOlU8F_8hf528sh4Xv7vh32NpZl1OrRUydPaYoZ4ZaVgYWqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:c8PUZcMSfOAe-sp6fN7F4Btc6jmlLHtaLEvNE1IoSsT16N3NczhsPg>
    <xmx:c8PUZV_ztq9DeWSN5X4J49yF-qJl-d-Y065IHcGLy4spOikCZtehQg>
    <xmx:c8PUZcWVB27vdpBrPizrLtWH8lltCZKKKMhe5HM36zO8QQGZZfM2vA>
    <xmx:dMPUZZXough-0V9bP3iZdkFhzW9yBnTe477MJg5WzAj6qHl11iv8Qg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 10:21:23 -0500 (EST)
Date: Tue, 20 Feb 2024 16:21:13 +0100
From: Greg KH <greg@kroah.com>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: stable@vger.kernel.org, dave@stgolabs.net, tglx@linutronix.de,
	bigeasy@linutronix.de, petr.ivanov@siemens.com,
	jan.kiszka@siemens.com
Subject: Re: [PATCH v3][5.10, 5.15, 6.1][1/1] hrtimer: Ignore slack time for
 RT tasks in schedule_hrtimeout_range()
Message-ID: <2024022006-charting-repressed-6064@gregkh>
References: <20240220150200.114173-1-felix.moessbauer@siemens.com>
 <20240220150200.114173-2-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220150200.114173-2-felix.moessbauer@siemens.com>

On Tue, Feb 20, 2024 at 04:02:00PM +0100, Felix Moessbauer wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> commit 0c52310f260014d95c1310364379772cb74cf82d upstream.
> 
> While in theory the timer can be triggered before expires + delta, for the
> cases of RT tasks they really have no business giving any lenience for
> extra slack time, so override any passed value by the user and always use
> zero for schedule_hrtimeout_range() calls. Furthermore, this is similar to
> what the nanosleep(2) family already does with current->timer_slack_ns.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20230123173206.6764-3-dave@stgolabs.net
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>

Now queued up, thanks.

greg k-h

