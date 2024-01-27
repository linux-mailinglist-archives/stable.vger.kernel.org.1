Return-Path: <stable+bounces-16098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE3583F035
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B601C215A0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D81A726;
	Sat, 27 Jan 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aJ/HhjsU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6s/RXb0"
X-Original-To: stable@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCD18EA8
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390842; cv=none; b=gDJldIGlYt+6EVGqpw8+LsM4CYCcVzV34GR2ZoAoIzfLEt0ZDIU7RoXe3buEa7rBpMbJED3bgyjE3MXLfZP7IEiNiLjPz80OJUDSPy1lKA+bFzAzX03JaK43bXkYSWzLl3/smmYpPyGaV8B1/62cPf8CGjWP7HX363D619PR3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390842; c=relaxed/simple;
	bh=+ldwBPJIjtvbfxltx2ESJXejroZOhFgC/MyH/TPAfFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr84fbvsoJf+Gicfr4vN+0KQ3k3CSlZZH47a4WrmeltalPnI/6Q1xfBVbYR2YrOHD+cY7ySM44218cT7Chu5+Iu6Q35JOYzmGfy6jKckDjMUNHggN22efdR9dw2cDsD4pqQGz1lSXfRnjziiqJpuAmHVaZQLuElAoV4RNmvgjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=aJ/HhjsU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6s/RXb0; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AB09C5C0099;
	Sat, 27 Jan 2024 16:27:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 27 Jan 2024 16:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706390839; x=1706477239; bh=jSrd+HqI02
	uKp8z2W5pAZ21Ia7uRwjyeJtfcQFCNgR8=; b=aJ/HhjsUHH1cPY3xJNFkt3EvKR
	gJxt548kYWppjHCF4poryuYLdKeQawJXadvK52Lyp8Tji5taR8RpWXBJB3z3puIU
	zjCur4vFTKSiotdkr3t2+/V/h9ToJKfS8UpRsiVSnkHjCESBgEuh/9Z6+1B9bHrn
	uStFyGm0vFs216fVRUpANSnCDKye7uw5X6CrzHkpyjeg4YVVcEEB8ndkGaTzCBmz
	+61+Zz6Q9SYCf7/2JMKrRLZFZrbe8O1K8mSd2EaoEdT8V1/qaF4Vo0OZcTq/dVPF
	sgBwfv3lk4rfaDbGirnJpCA7t7r0cLewQvAtJPXBBziLLJF3pAiRnqiz5uuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706390839; x=1706477239; bh=jSrd+HqI02uKp8z2W5pAZ21Ia7uR
	wjyeJtfcQFCNgR8=; b=B6s/RXb0MtRcXvf9UVDtIq6qNwEwuZ+L6ajEVVUkcbHN
	ooZ/dTASvNs2S5chYq4xipIr4zFuTcqsBtUM39tnBvV/rXC7C0kgZW1LGAr2rJmj
	FPZJVNwT5d5aA8sTXjW7MwEr9x73Dpbmlo/jFhPhsqw27OW2BuVhrcvpzDNVOMHm
	TE55E1PsF7yi+2U3AYZLO8OUdm4Vlnu3VcWq6oOchKC0DzptJy/VKnWgob99PV0R
	f4CmuWxQvtvA2SzrPUXvHzozS36pPu4IBiQ6T+WAoxB0AB5LvLNKzZQGFXK6qqQz
	XC6NZ1es2hZsH8+DEs+T7ZeYyrnhCbmIXQ+ux2lElQ==
X-ME-Sender: <xms:N3W1Zei-r4aQOjOhO8RHm9x1D3eU-ZLBKLL-RiYzJDQCMLsnvbnA4w>
    <xme:N3W1ZfDULrRFd-Vpe_sc2gcVnjrjImpXbnHIUqesWlX2yxkbIvDObF9XKoCb1CS4p
    -y3HUcDkiS07Q>
X-ME-Received: <xmr:N3W1ZWGi4C_KROw_QNaMOPlCIa4TFfPJruxoiJiQZECD7nQ4BekjlPzuUIoe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:N3W1ZXS110j-vjgyY6EW1dfW45i3meLs3a1VZcRv6ofwxwHT12Dxiw>
    <xmx:N3W1Zbw-Euzl1870lEgctW1A2dZr4uVQaY9iCRTke47D7FPgviv4qQ>
    <xmx:N3W1ZV46WEZWASrezB8x6RlNEaKn8J1Ccwq_vPOVpmkR7cubSqODyA>
    <xmx:N3W1ZSnl8BQjUg2HF_0ajVNTMJwTWph6TzaR3CJv3rLIMl5wQ0qw4g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 16:27:19 -0500 (EST)
Date: Sat, 27 Jan 2024 13:27:18 -0800
From: Greg KH <greg@kroah.com>
To: Qu Wenruo <wqu@suse.com>
Cc: stable@vger.kernel.org, Rongrong <i@rong.moe>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.6.y] btrfs: scrub: avoid use-after-free when chunk
 length is not 64K aligned
Message-ID: <2024012709-refract-briar-2d47@gregkh>
References: <2024012740-mating-boxing-dd93@gregkh>
 <2d0c7aa20d79dbb7b77683db0ea9a329526c7ef5.1706389328.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0c7aa20d79dbb7b77683db0ea9a329526c7ef5.1706389328.git.wqu@suse.com>

On Sun, Jan 28, 2024 at 07:32:08AM +1030, Qu Wenruo wrote:
> [ Upstream commit f546c4282673497a06ecb6190b50ae7f6c85b02f ]
> 

Now queued up, thanks!

greg k-h

