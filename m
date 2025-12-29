Return-Path: <stable+bounces-203650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E388ECE7394
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27F5E3000EB7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE126CE2B;
	Mon, 29 Dec 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cJbNddkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KvcaGtM7"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDB325700;
	Mon, 29 Dec 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022593; cv=none; b=XHsFHCBsFhPFif4vridC3/QahETj6kEiNdUsQOU1Lgd1BoMzhXeTK0NC1iSmG41EnZz0qMJ/zJU1Xfs4KCD+QZXtqEZhDoBD+hY2TZKHqvMs3sxIsw29iRFHhwyd2IK3q4ctp5Y11//VcATp7fkUg7eWKlyjFKWcvzt0/LB+HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022593; c=relaxed/simple;
	bh=hhjHo6hjsAsXpdqO9CxIr+/UXyZeZUHUXe70Bh/L6eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCLr8eYDpO3KKvcSKrpkUBARjv/gT9GiihAL9ae5+5wd+r6Vv74pbLwV6MRzPNflOWkooqMeV/KVzrFWyDo5eFnQ7fyyOI/8YV7if35/azON2zaipdDeYYMYITN0KMjo//iopIIIA3bK1P80YumWgOF/J7KElMFt2wgQ3Od1I2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cJbNddkA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KvcaGtM7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9054E7A006A;
	Mon, 29 Dec 2025 10:36:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 29 Dec 2025 10:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767022589; x=1767108989; bh=LwvMRicOYr
	Sb83DfM0ucNExCUF5/a9pL558pa+0Jnc8=; b=cJbNddkAG6krucxPI/Yi2IH4zH
	8qPmFXViUsteA4b590TveI0lihoulnIEat+0jKBDyAoN0YNkOzC67nvBVlNIF9AA
	iuURPRPpR/HFUAoo/VCvQE/wD+3Mb/ZbFvgUVh3qTjyBUrmd+0lHlC7sax+aVd1s
	O2GoOnmGnirVlepWTIPBqI0bgKP5EkqsZKS0rwBqPaTSHWlTLycpwKPcy6gws3eK
	oYW3eTQuLqDfvnf56fXkA19hnzSyJK5qBB/oJlQxJa9736bsQRzj2IX4oIotvJ5P
	GMBHImX3GpFtwbEmgC75tH5bL+dFDTHFc/xXrbT3uXU8cVfI2xsAPnTfzV4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767022589; x=1767108989; bh=LwvMRicOYrSb83DfM0ucNExCUF5/a9pL558
	pa+0Jnc8=; b=KvcaGtM707kUanmQZx6C6L30vfAiRjQcuVR9ouB8tJLI2RcEMFy
	UH2Mh1ySyHu6w64ZEkSolYnu3e50G+S5O6M+KwQml067Vu6wL/LQvDjceuSHskxg
	bYsr87vbrijJLEAufmFlYjevsn9GDiGGJDHVl4lg/sS8aQTQrZEsg2zTRqclrFZe
	Dp0F6S3kOG64rWdu4Qi8oD6obk7euKBa501MSzKDOiouBdgNjiJWqWa2VUtd/p6X
	3RcmCCVw4kA3XxkSRZVHlGiFhr38+MSC3mwEY8UOTcvqt15Cz9uXUrj1YHbXQvev
	omxsE4flLLgUy5iVDVLyEEFZ4RKceRNjADQ==
X-ME-Sender: <xms:_J9SaQRi1XJ9NWbmW58rzfIZn-s9ACTfS3SFFKPxmE1ZZvif6m6QPQ>
    <xme:_J9SaV9kDDHbR7QfREDac11g1zB1yT4DW4uQ5Gm2i-DEBIcKgfX91xfje8A3HYfuW
    GXqk4nTueEy5kKHTuNYUIrOLgTGDolHXCT41f1cj11PpQ7TxeA>
X-ME-Received: <xmr:_J9SaZbYgncAK2KVkl__ORGc9UVL2c-Y3mFjJU0mJgK76nKJdsSq-97_6WqCEWNZa6pR9q97eLnoaJXWhXQSobVKggp4a2VbN1y97w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedutddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrlhdrfhgvnhhgsehsthgrrhhfih
    hvvghtvggthhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:_J9SaeqBDZIJXtJPhv2V8Fn29lnSF3VvIxlbt8iRr5axHCaC9LcYCQ>
    <xmx:_J9SaVTQfvmrVZthuOWsunhlPu59LdnbMed55BEbN_Pw2JFYDWG73g>
    <xmx:_J9Saar-fgaJIpox3INf3Rr-aRloFeG6XBR-GKxaLhf7yFdOT_LgbQ>
    <xmx:_J9SaX1FYt0RItbt9MqTQuSUN-d2n9kOCABMG-sQqLexpJ_oM3urtA>
    <xmx:_Z9SaTqxG_MWv9lZCQVcaQvsMd2jKJH4lcfLMEnb4mkb7SaZRdHlINWl>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 10:36:28 -0500 (EST)
Date: Mon, 29 Dec 2025 16:36:26 +0100
From: Greg KH <greg@kroah.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist"
 has been added to the 6.18-stable tree
Message-ID: <2025122908-skinning-mortuary-89c7@gregkh>
References: <20251219123039.977903-1-sashal@kernel.org>
 <ZQ2PR01MB1307AE907F8899DA89F1085CE6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB1307AE907F8899DA89F1085CE6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>

On Mon, Dec 22, 2025 at 01:54:03AM +0000, Hal Feng wrote:
> > On 19.12.25 20:31, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
> > 
> > to the 6.18-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
> > queue.git;a=summary
> > 
> > The filename of the patch is:
> >      cpufreq-dt-platdev-add-jh7110s-soc-to-the-allowlist.patch
> > and it can be found in the queue-6.18 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree, please let
> > <stable@vger.kernel.org> know about it.
> 
> As series [1] is accepted, this patch will be not needed and will be reverted in the mainline.
> 
> [1] https://lore.kernel.org/all/20251212211934.135602-1-e@freeshell.de/
> 
> So we should not add it to the stable tree. Thanks.

Why can't we take the commit that also landed in mainline for this too?
What is that git id?

thanks,

greg k-h

