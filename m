Return-Path: <stable+bounces-124800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56575A67511
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890993AF438
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403CB20CCDB;
	Tue, 18 Mar 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="b82qQoZT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6Tuksmqg"
X-Original-To: stable@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C92576
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304196; cv=none; b=ZVT67NBwtCam4KDqWTO7Grjvgvb0rQ0RxuJPeaUm+I94Yi/JyTLQTVo44QvFA7gi8pY+t9bihbVy+7j9flkIceNXpTDryC6uJwc7CudHEPa8dAdovKd4YWDe+8V8rOPV04lJXm5Q3U+vZA+nA10D5o8BYUmBXNSRiIUrra1+1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304196; c=relaxed/simple;
	bh=/+NRncxQzBJSVfDsGcAlSlS+WwiKUr9+mtF0BVc5F7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toitxuml4apCSeTLjpmmwa/t52e0GeU8Sby8mNuDdDJXfjO5KIJXJDEkuknQfbKHebk9OQ4zs3F4EQ+yMUrdj2RGdnlj7BWowyzsTacbblOaaXq5gnUJYFGBBWRQpFL8rQgvIb/vGFSYWjg/3RuluHTzVg8m5+mTBtz51onB6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=b82qQoZT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6Tuksmqg; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CDA22114013D;
	Tue, 18 Mar 2025 09:23:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 18 Mar 2025 09:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742304192;
	 x=1742390592; bh=cubXMcBhaWWkL05KvtS58gyIe1CIRwTH2EAsTd977jo=; b=
	b82qQoZTUS6c3xSQ/Mzb/JOsLYYCheEGSu0ONowhYA6svhFkgJOv3C5Qek2bcwlD
	GC4Y256Nb1zkidA2ti7+RRmvXDIuS1QG03Noosj/E+2Cdad6Otk2tY0B9hPY88Zn
	TCaj+Mt9QeG7Yt1VqVnXWsucQs5l5yUqMTf2xibEO1NsT5l0QQjuLMBNx6pHf9fc
	sZguIsCoyxP/jgpkQWY0g9I0jqZw5A8YNC+2DzR/y/ST7FQ/0fi0E7k+0vO8anVW
	6J/r+gh8uTsoO97df6wKuyfUfNIWrYRcCkN+KuxWEURBX0MT5YAOFsUQt4GUSpHe
	/FFvzstw5SLuVvPPtla9yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742304192; x=
	1742390592; bh=cubXMcBhaWWkL05KvtS58gyIe1CIRwTH2EAsTd977jo=; b=6
	TuksmqgTUwYgBdfZ57n3eeC9wSy7DFNVC9XAaHDg8CTU9IKnkhDM9P+2oB5gIUeo
	GH7xomofoCwM0iA53PxMtiIaEE1W47qk/1juQNMM2g//zohv4v4j5iu0phxWimJB
	12tJyVl/5oTqJLaEvZIP9pCgvcLcIEfGW2lJc4GBMvbwcWGTGrrziZwIt4Zp81qf
	dcGuzj8XnfIOARdy2Fbe28eeXdLMhmGbpSzqu/xhs8QlH8tJxpxeujzr5IDcCpWe
	IUSg2DTS3g3ljTCsZ0YKjKxbh05hDILP9lZBoXsTFJwWF0Bs4te1ZbSuAGCoK2mG
	Tk6altX7Qv4ZVtFzCiDug==
X-ME-Sender: <xms:wHPZZ0U3TpCh8Ow0NZa3SM5cm4Ipx7i0cFSnXTR5r7xGgxesvN-9wg>
    <xme:wHPZZ4mih8gFxbRnvTt2cQGlIwyKAGmmkS_EMm3dot86rkSh75YdmvyjNIeKagsK2
    bfD7rSSXwKuTA>
X-ME-Received: <xmr:wHPZZ4aic9kbqcZyFxRMZMASj4BLdwSQpfJVDi5pZQYj6mqPyInctle1jRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wHPZZzUDrMaZz90lgh3w1Ib4tNkC6JBUfsy8HNCY2Rn-cj7c0p46CA>
    <xmx:wHPZZ-m_PkndkOQ-i8BEcMvMSFDhIH5V8HYRHKGCWsAW6VoNdta3zw>
    <xmx:wHPZZ4eo1QmVpoUsbjx5qO5fiK_GYf4U9twIY0JuW3uiBQbYQ8DSHQ>
    <xmx:wHPZZwGdcwYIu5tfre0zeZh9YqCFm6YFDe4qJLq2x7wQTGWN31gjlw>
    <xmx:wHPZZ5_ftLUDaCVRLFnFc1zesSoTv_04dVPvUv8r80hPPybBjhv5cIQD>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 09:23:11 -0400 (EDT)
Date: Tue, 18 Mar 2025 14:21:53 +0100
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<Box<T>>`
Message-ID: <2025031810-untoasted-email-5a46@gregkh>
References: <2025031635-resent-sniff-676f@gregkh>
 <20250316160935.2407908-1-ojeda@kernel.org>
 <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com>
 <2025031624-nuttiness-diabetic-eaad@gregkh>
 <CANiq72m9EcxPcaJ0M9Wb9HVjLEi+g2r59WR8=H7F+ikgQeYGHA@mail.gmail.com>
 <2025031729-dizziness-petunia-c01a@gregkh>
 <CANiq72kKDNzAtVu60AzcHtGhWm5x3oKGcHCh4tWGrhxeXYRKNA@mail.gmail.com>
 <CANiq72=vBzBYkq617zpa2StEN9PYshG3cVPKjqC2-Q3KZSpEmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=vBzBYkq617zpa2StEN9PYshG3cVPKjqC2-Q3KZSpEmw@mail.gmail.com>

On Mon, Mar 17, 2025 at 09:54:03PM +0100, Miguel Ojeda wrote:
> On Mon, Mar 17, 2025 at 9:39 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > So I reworded accordingly: I renamed `KBox` and `Box` in the title and
> 
> s/and/to/
> 
> Anyway, if the policy is to keep titles and original log intact even
> in Option 3, I assume one should avoid [ ] comments in the log, and
> only use the one-line-before-my-SoB style for [ ], since I assume you
> keep the tags.

Yeah, that is good, but really it's not that big of a deal, we can parse
text pretty easily and handle it when it's not "perfect" :)

greg k-h

