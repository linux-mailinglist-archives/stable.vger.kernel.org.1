Return-Path: <stable+bounces-124739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CCDA65F0F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A7617B684
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251B1F4162;
	Mon, 17 Mar 2025 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JW2hCI33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUUao1yv"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F371EDA19
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243157; cv=none; b=VyMkqJhkz9i9qDra15IzzGARI0lnWnyYJTMR3wtxmAoBkt91Lh9pvmoaFMvZmhg1Auvaiqbd2ZiiPVi1QcHSE/M81F5c18HZhHcGqJvvjlGdZCJ9uyvfEuDEToozYJIfbPHFLKA1w6c9Wz1CArSzEJH/Dk0Su5mGP7EKvn98TUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243157; c=relaxed/simple;
	bh=YfMW3FrGVlKJCAQFsdkXxBVJeXuZjEJDNBCB1iIRybs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXEUUadKxkYre1bAMZAdXpafKUB+fXldRCWWVlOx2XwBvNwt7j2kN8NVomiPB9N9bVuu+AE/F7LnioWPza3WfJa0l2yNhVm8Saebl8/HfR1/G/OnVtelvC61YtTKMJcTrjBsgpKXmvni22OCh0/o8cAUH/xK0aaWV4vNIDZsQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=JW2hCI33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUUao1yv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5163F1140250;
	Mon, 17 Mar 2025 16:25:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 17 Mar 2025 16:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742243154;
	 x=1742329554; bh=0ECZezzs8UElqagGyX+rg62duMx2Dt58nysTcTEQ9sI=; b=
	JW2hCI33kji2qzO5nhtlaZPUxTSeAlPZHzw9S7WAhafgcITswC75spgXlH+VA4QM
	9bxvIbemgSFM4LmIssaqKmYrwwJ0pdSHjvyYWCctEqvBsxx+nYb7de49ILy5vdOT
	uTLZo/I4bQoQHtF64vyeC3x2KQ0kQi2eQzowP9KICwSAMo/XX9G0pMWqufSHdhzQ
	zf+kpDyZqjuUS8edF0LzD8Qgo9ttevQ/sSVRqTHnLQj5OkWjL6iDEjbunthjKiAj
	Qu/gFL+RbUph7irps1fFCOLRfzHUovy+D4Ov28bdTE0KPFJgiUUajP46dKDEA6dN
	CoH3h0K4AnVo4bEJXkgvZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742243154; x=
	1742329554; bh=0ECZezzs8UElqagGyX+rg62duMx2Dt58nysTcTEQ9sI=; b=K
	UUao1yvHnRG+EP3A2J6m29neFGWwviQjOysWGna5F/vNMAmMjcs7PvOCFOU+psXB
	6KQC2WjG3VFDmVuedcvs9wKUgAnifz6rcaQBAtK18S3jILCSAELhEGm4oTcbNkFd
	UnZaf9O4IwtHn7NmjCMzq8AeT48H/e9MzdJTLddr4qITUEZM2mZr1fevmI2aqmTv
	I+M7UP4OpFZ14MKWMscvWa6xIk4AdQWEG/ixBd1WNtEtP5aQ6y+pOz6yJtwX1fGR
	ZY33JPaEHXOqHqaKymRXrwTpG2uCWSOkCf9rXfV1D0aVbZSZC/IVTQ1gVtzz6WRn
	WAlQ/FP27Hs3EzKjdvz3g==
X-ME-Sender: <xms:UYXYZ6twZ_oqfGY1VF1SIOD6gwxqlrcKoi6O7kGaOGu-dVOzIs2X4w>
    <xme:UYXYZ_e23vxTCw6cLes1aC9CNedsO4k-Zf-60ojnJOOPxo7m9CFzDLnhhOYSfI88a
    hPy5wQvhV0UWg>
X-ME-Received: <xmr:UYXYZ1wpSpi1daTqbTHOPurmFW1z_Bg2QIPI4MEP5YCeCiyJGwqdgjngUApC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefgkeffieefieevkeelteejvdetvddtledugfdvhfetjeejiedu
    ledtfefffedvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguoh
    hnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohep
    rghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusg
    horhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UoXYZ1Owb6azuSywFblB3fapKCurtyXBvYWMj3G9I0QD8q3nDgUWTg>
    <xmx:UoXYZ69pwPi8PawTLLLKIYjTY6F6RnFQR69yK4Lkm_IQL2bXavrvXg>
    <xmx:UoXYZ9XVGnmwKogsOuTYGF0e15diLitpqWpqxmEixTrByLPkAvZJFA>
    <xmx:UoXYZzf7g_VTNkk1clybZrImQMLEzy0zRtrtS7Y_BsAvZiyOaec1gw>
    <xmx:UoXYZ1U3EXo_LzTI9N1x-aE-y4Ar3slo_3OQwaQvaJUJZAYLW4DzJOlR>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 16:25:53 -0400 (EDT)
Date: Mon, 17 Mar 2025 21:24:27 +0100
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<Box<T>>`
Message-ID: <2025031729-dizziness-petunia-c01a@gregkh>
References: <2025031635-resent-sniff-676f@gregkh>
 <20250316160935.2407908-1-ojeda@kernel.org>
 <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com>
 <2025031624-nuttiness-diabetic-eaad@gregkh>
 <CANiq72m9EcxPcaJ0M9Wb9HVjLEi+g2r59WR8=H7F+ikgQeYGHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m9EcxPcaJ0M9Wb9HVjLEi+g2r59WR8=H7F+ikgQeYGHA@mail.gmail.com>

On Mon, Mar 17, 2025 at 07:21:18PM +0100, Miguel Ojeda wrote:
> On Sun, Mar 16, 2025 at 5:33 PM Greg KH <greg@kroah.com> wrote:
> >
> > In the future, sure, that would help.  Don't worry about it this time.
> 
> Sounds good, thanks!
> 
> In stable-rc I see the original title/message used, is that expected?

I didn't notice that you changed the title, so yes, it's expected as the
tool takes what you send and picks out the diff portion, and leaves the
changelog text alone (unless you add some more lines).

Why did the title change?  That's just going to confuse things.

thanks,

greg k-h

