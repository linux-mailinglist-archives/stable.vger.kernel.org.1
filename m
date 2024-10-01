Return-Path: <stable+bounces-78489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D806198BD52
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A32B1F22B20
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3B263B9;
	Tue,  1 Oct 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LAXFHNq+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M8+mofpi"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F78C2E3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788795; cv=none; b=dApjcJEjTc/LHaZSxqsnmLaAcX6xouj03ApKXQktxjvLyTArLWfziYepDjdPlhFeLmq/3oCWs0+GqE0vMQnwqOUJ4iaP0r1/geQjs+Jl1epIoapJp+GIstFTKCvHfo8g5fzOOz4ViAByq1+kaR3U8usQiDgmkCcFOoTWia6Pf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788795; c=relaxed/simple;
	bh=naLSRft1/vp6C9h5dSJiPsykFKCTj4T9l1NHaRQnlpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL2ntaKCxzF4G4BsITZ67OzkRsD0hsXsq5KzyxXjALJVE4MRAeYgXAK3lA7Izd+ub5h0+0P7tvbmAG26BKz1zt9zyqrKO56pmoqDfM79IdcML+BhbtsN3njz4xoMESECYN7ajtBxyOPGwxioXOiIuCuB8T37YhR6XlhvM8B9xjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LAXFHNq+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M8+mofpi; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26FF311413FE;
	Tue,  1 Oct 2024 09:19:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 09:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727788792; x=1727875192; bh=VU6CmkD7Rp
	ydOmGmokmAnA619F2CDN5Gtn7d8DvhVCM=; b=LAXFHNq+OrmclTikPIH0QvXiiv
	apk5IorHUR1ffohpyOND6jhCu0Hj+QGXLgja/gnSkUcvBCoMiUkqNQ2wUK//5Yn+
	ZSfM+c+w99L59XeXqkqXYJJNgbsSlkqJixIc9j0+WtWXcAWS66gh3kd2G1MXhPi1
	89V1XsbG8XvbLkt7xvS6WtXLvPLRXEgseMrmv5lhb+Ak+8n3H7OtH7PsVDCrxNWQ
	UddfDT+2jB7vygKDJH51zsAc5J3MdpM0iozem2NKu7eZAaPnjR2Zlx6El09vhNih
	k4UdKrdVReLNIRUJwZccQHDQoJBS0fyVQhDVwsJgpxcEn3XtEUfK5RBrZpig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727788792; x=1727875192; bh=VU6CmkD7RpydOmGmokmAnA619F2C
	DN5Gtn7d8DvhVCM=; b=M8+mofpiJlHiQFNLf4CNy5Uz40cOugIcgIehjCwfjaAH
	wuS3cd4lobCXpAU7AFIpySx/ny3OP91zdjKeTEIT7pusG5rdwxiFim7s3oB+Hqv8
	dl2z89ms3M8q9mGbL/m3Pb//E7x91H1ODSXkEr/7JEqak3m/JxGLZYHUH5Nh/TzU
	rKofyQgRf6l0wz+Wsv3aAazRHgiDovz8l2euZbWLuuDmNyarzcQFo8M1dwsBYZL3
	pM737f8nzXk+mruZMMgkIv+QCUqw4B5eDA9zx+mu5qm8QNW0orrqf+6/YEhTW765
	8tHLcW2KdN/23MpatwZnUZliocSmcnaeA3XcEeNgyA==
X-ME-Sender: <xms:9_b7ZqtvONlNULyqrFY0sC32ZCm6rMEjzTlUxZHledctQaWtCF3Pwg>
    <xme:9_b7ZvdJ9bR-h6dhcBALsX5SvihDz-kJALbvGlY4XQvzcVowvpRNcuJuyPD6n6ehL
    DmfXv2ZfqOevg>
X-ME-Received: <xmr:9_b7ZlzA-MUFqF557Y83Rp5e8lC0vjbaJVbmO2zTutviYoGX7Ctv5ewauNXtUg8KLK-LbE34Zx9M6H0niHMzGUy_BviRaEs-YjJNZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
    gvkhhsrghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshhhurg
    drrgdrhhgrhiesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhhthhhonhihrdhlrdhn
    ghhuhigvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehprhiivghmhihslhgrfidrkh
    hithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:9_b7ZlP7bylXwq2e3_johawAcSf-D9kpu0J2u_Rb2eFeAFKGNOVovQ>
    <xmx:9_b7Zq9YQidHDWou2bX3pXauFJj0Max_gwbPd7m8O9Ml6qp0RAsRlw>
    <xmx:9_b7ZtWYJ1d2-FIk4wjEWhMc9opDRlrgtSkfWzlad54kJMCMU1bTxQ>
    <xmx:9_b7ZjcCJbwxQqHklE0Ninueb4wuqrokX2wRWG1n6rb72TseirYrCg>
    <xmx:-Pb7Zt1gYpN0WfNG6lMT2WhVrjZw0WRQsfY8kRfZqMumIgISmPpq1P3B>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 09:19:51 -0400 (EDT)
Date: Tue, 1 Oct 2024 15:19:49 +0200
From: Greg KH <greg@kroah.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: stable@vger.kernel.org, joshua.a.hay@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "idpf: enable WB_ON_ITR" has been added to the 6.11-stable
 tree
Message-ID: <2024100142-flagpole-paragraph-8f1a@gregkh>
References: <20240930230835.2554923-1-sashal@kernel.org>
 <8b2988ff-17d0-421e-8cf4-3eafef1276ca@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2988ff-17d0-421e-8cf4-3eafef1276ca@intel.com>

On Tue, Oct 01, 2024 at 02:55:27PM +0200, Alexander Lobakin wrote:
> From: Sasha Levin <sashal@kernel.org>
> Date: Mon, 30 Sep 2024 19:08:34 -0400
> 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     idpf: enable WB_ON_ITR
> > 
> > to the 6.11-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      idpf-enable-wb_on_itr.patch
> > and it can be found in the queue-6.11 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hi,
> 
> This commit should not be applied standalone and requires relatively big
> prerequisites from the series it was sent in, so I'd suggest just
> dropping it from stable.

Now dropped, thanks.

greg k-h

