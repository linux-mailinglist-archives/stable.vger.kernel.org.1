Return-Path: <stable+bounces-76137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C6978F3E
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 10:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D0B2863BE
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E92146D5A;
	Sat, 14 Sep 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="h5Wbsg1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4F2kXmL"
X-Original-To: stable@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574313A26B;
	Sat, 14 Sep 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726303886; cv=none; b=jcTHmbs3DvuGzyu2f/5NeAOhWu0yjMm4jPdz9HstxEtHnqyl6shfVJuw8sLTswy/ldMST1TNfLCpcNemF3BcJNTX4kTWRNgTEhQtyvYYpYfdZZxzzoCtmQss3ASYP0f8ty/8rwT64cvuRacwJ1TRVp3DLAb5RPXjHBjlyZBdDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726303886; c=relaxed/simple;
	bh=8WLND0IJaO1aggizDcbbvVsgkYk0EAibP/YmYqCklts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOo+B0zuvfTi9BDXVrLOs/TpE48m5R5bgYZzh3gFLySkt8m7BQWSLRW28qSKfJStj3FNSjvCgXVtuBLHb3LO4QbzAXdb3lexn4dUcw199eMDS+xd+zOC3qyl84EGkBqkEDwlxtkzIX8dxTe9QujRzWVnamFJfPYs97utFI7cnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=h5Wbsg1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4F2kXmL; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id B6B3E2000A3;
	Sat, 14 Sep 2024 04:51:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 14 Sep 2024 04:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726303883; x=1726311083; bh=z8/eCtWtOg
	54AAgC460vTqUq4qNBX+0zCg3fedRUPnw=; b=h5Wbsg1xUoLc1Z2pbqC0YlT0iI
	k5+KzAobMxbO00pzdEVqk35ra424gyhny6gQc7Vtc4ilWsVbasySNbV0ROELKmkH
	5EHf3AZ1TQbUOUQkPoXVZ19JVuhEQvhfaoOMPIJnTiqVnnFJfJKZk4cAhLFVyY+8
	oVtBhBurmDgk97QUNH0fk8uFhn+2lpiDmQw+q1e9/25UFL1BAsAsaQC6JZ9Q91/8
	CK0OgS//ZBFiwffg+/oXrTQ01aG49mdX3h8GA2Brz4nkSLfzgKPrDB+M8qDK9G38
	xntVBh0YlfxOBD6F7bjATyssViTsTmFn7jR+kzA35ZN6FzvSkb+AHbBniStw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726303883; x=1726311083; bh=z8/eCtWtOg54AAgC460vTqUq4qNB
	X+0zCg3fedRUPnw=; b=q4F2kXmLxJ4qrRvhtkuc3mKCRzGPz9RLKlKYRF9GH/Wa
	UEXkYD6bxcVxHhfEgiuy8qaO3dqUy07gCYml23gxsnOlbwjUkWTezscYI2FUlsqP
	+FdEJ2fV86RNEQnf9VHOQbQSyfkpK3f/dwgESVd9A1iVyqG5Wcan/q2CE7+XBLHM
	KE6XCuz/KR6FB6mgcyl6nnjl9YQ35mXROGdAR7DFy83y0TsPjSYDN7KFmBc7YhAd
	bDwPMtBjjWmWwlz3PHngGU5QSEhM6gCS4sNXEyyvbc9hPI4RPYIDokCC4X6+2osI
	EhOYi8h29KzidWvauac+xOYfdcuUtv0q6bVHMDVmdQ==
X-ME-Sender: <xms:ik7lZm9oPAhlvgUGDm-091yxUz0HH6Gg9Jx3_k3Z167NVPLpigdXfw>
    <xme:ik7lZmtN1pcmVcWxZvlMMK2DvNbWgza3zHC3V6ZRP951SstJPcmlX9TgtaDeeKmtn
    jrITnhTRXp51Q>
X-ME-Received: <xmr:ik7lZsBw0U9W39I5ZdvrVSZF5WoYji75h_J-fDFCxU01NEfNg5bwsHjOWx3rcSnuyY06T0ZcWTEz17DcAJJds7nRqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeigih
    hnghihuhdrfihusehsthgrrhhfihhvvghtvggthhdrtghomhdprhgtphhtthhopehsthgr
    sghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgdqtg
    homhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghshhgr
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsegvshhmihhlrdgukh
    dprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgs
    hheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhm
X-ME-Proxy: <xmx:ik7lZuftXN1quKkd9I555ZgRdOGOngt_F0CKk8C5ZhItv5r0i0vYdg>
    <xmx:ik7lZrOZhp1EduHus-de4ywzVD9dNU-bbCV1iqFkuGMD9nas4eziUA>
    <xmx:ik7lZonfUGySgnWzwzZ34GEfJa0qQBUP8apfU8SJzymv3bVZh4ahMw>
    <xmx:ik7lZtvULRp1iwM5AoCmWi31NXeUJHeac_Cqx_fedCKDYeAf9YHtwA>
    <xmx:i07lZl2yMbl8ZHThUKzouU9ZmUGZyn4zRBJD2-9d0QyxPfkFOj_2L5IM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 04:51:21 -0400 (EDT)
Date: Sat, 14 Sep 2024 10:51:20 +0200
From: Greg KH <greg@kroah.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
Message-ID: <2024091451-partake-dyslexia-e238@gregkh>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>

On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> On 13/09/2024 22:12, Sasha Levin wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq by setting PLL0
> > rate to 1.5GHz
> > 
> > to the 6.10-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
> > queue.git;a=summary
> > 
> > The filename of the patch is:
> >      riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
> > and it can be found in the queue-6.10 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree, please let
> > <stable@vger.kernel.org> know about it.
> > 
> 
> Hi Sasha,
> 
> This patch only has the part of DTS without the clock driver patch[1].
> [1]: https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@starfivetech.com/
> 
> I don't know your plan about this driver patch, or maybe I missed it. 
> But the DTS changes really needs the driver patch to work and you should add the driver patch.

Then why does the commit say:

> >     Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")

Is that line incorrect?

thanks,

greg k-h

