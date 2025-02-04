Return-Path: <stable+bounces-112132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38843A26F5F
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81E83A5EE5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A020A5CF;
	Tue,  4 Feb 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gKKtsOwM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kNL5jQBA"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C72080D7
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665378; cv=none; b=qpYFxwGfYyvE6whSeJAgo7W58UUqAZcTRALQalVJtRMQ5ivcnkBlQoDbQrfZTbsvxVrkRPe06FjvK3dFaDn39szRbH5sMdokaLwDwmK98zoDmU6QoFFE8cfMjRjR1iFXH/GfMYpuWqD7Lfp7tpcg8AI8sz2zvRZmuzsVi/IZBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665378; c=relaxed/simple;
	bh=5BUcqUp8t1HUljnDS7sw9hJ1jgwF6iksGJjCv4nL19g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx3uJJcOR/dAiOq7MgTSYomhB8NzkkY2diaptjnqa69mKtwPphHzzDARJ01XYZd7lUAT6N+zagC5qR8n97hMzdfiKYKmK4BtPQFHNFYC2+iTHhcFXwgfwPQ6YLE0lQV74v94guTyoovZdaiBKqt/vyxp5HL9dQQ1bUihDcZN8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=gKKtsOwM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kNL5jQBA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C466811401F4;
	Tue,  4 Feb 2025 05:36:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Feb 2025 05:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738665373;
	 x=1738751773; bh=iVmx8efuJxnUc9GEKW/cgSxvyzBTddFYS0vN0ClC3ls=; b=
	gKKtsOwM0vqg/9CrCQsdX3neJhF6ZhmGxM+Q7MywrEA2eM+7o90wKdxdodgzbEXe
	E+4RJQdo5NODZfwRgtFxzPx51lyBchtvj18ls5fUmhnEC/ypMougn8pkue64PFWi
	CIqLaJH9CXMcPsRS+pCTSOsZGyP6XEiropQnnzpq5bBwm3+EDueWO2F73BspMaaV
	9B6/2z84N6SVkcctE8pAYYuWlfVcfj0lC+7IbgnwecMaVIhD2l7ev5Q0rzecDjti
	XH5Szr3izopocN4t24ZThfb4KRA7bwFVvejo6H7r+HcDhwhu8Y2YNzrfBlYOQ2PA
	nBMz5fBIjqzGQMwE5n2Vxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738665373; x=
	1738751773; bh=iVmx8efuJxnUc9GEKW/cgSxvyzBTddFYS0vN0ClC3ls=; b=k
	NL5jQBA9r45WMIgnzC3m7TrHiTp6I3BJb5KBvTJj8D0tdb6KF4si5coQc+Mq6eZz
	mx6TlyC/8o9KjI4UrXFi2Ru13Ugx3dx1xq0QHQA67JtbApTnvEtYnS4T/77zXj7p
	ySAT4vMIPkHiYVn9U8viAcWDiz9bV506AdHR78v3dKWw/WAZv6ITEcxc7UhFKkjb
	MakXfclG1tamQcF09RRMK9YNEifeKm/vv1rtMyO28hFNIPAxgn+DbOYKzoYq/l1P
	cING3kF8QaPIjmcUbToo0L3tLcfIwoC4CqE5f3H7iYiqvZhBa5i+7iELXUeOUt4+
	WL2QLoiUieyh/Rdyk/zUw==
X-ME-Sender: <xms:ne2hZ8fugMkOWBVRxGvf4rzXU3ClVV7hMXVTtGmfQVLt34Y4_jt_Dg>
    <xme:ne2hZ-OQ1ptXY1JE8Q5dAfC7LfDjaVoWlBu1bfB5lIbb4rBdT9UM9UcOpvlguodl1
    nL1qtrs2MkFCA>
X-ME-Received: <xmr:ne2hZ9j6K4PTJOKtlXt_4zQ-PhCWYiJ2B9e9rvD27zrXp1QVodV9s3YxuhiG9RB5FCSafTziHYpMvSJZgoczK97E3wKE3TqjXDA9dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhr
    vghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevheeuffffjeejvedvhe
    etheffffeftdetieelhfekieetkeffuddtveegteehhfenucffohhmrghinhepkhgvrhhn
    vghltghirdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsohhtsehkvghrnhgvlhgtihdrohhrghdprh
    gtphhtthhopehkvghrnhgvlhgtihdqrhgvshhulhhtshesghhrohhuphhsrdhiohdprhgt
    phhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hguhhssegtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:ne2hZx9KGzGr8dwhdU_9riGNY7G-dB2m6aGWu1be32t9bRiihfwAmw>
    <xmx:ne2hZ4stDuDZ11Ocul72CFSISTRi1KcVw2FkSk9L5ZaQD7AFcOUxSQ>
    <xmx:ne2hZ4Hi_innnw4Ut3NQ0MHIRGitl33GynkYYk6Qr3C0BAHmYF3YPA>
    <xmx:ne2hZ3PojwAvDTqEguYugtfV-2DdDjV8WqsWYBeNwxL5wC0QzQBWZA>
    <xmx:ne2hZ2BJr4eEVXKHDjx1eyt41FWYzbNkyc8grkcShWnk29fS42fMZc_q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 05:36:12 -0500 (EST)
Date: Tue, 4 Feb 2025 11:36:10 +0100
From: Greg KH <greg@kroah.com>
To: KernelCI bot <bot@kernelci.org>
Cc: kernelci-results@groups.io, stable@vger.kernel.org, gus@collabora.com
Subject: Re: stable-rc/linux-5.4.y: new =?utf-8?Q?b?=
 =?utf-8?B?dWlsZCByZWdyZXNzaW9uOiBleHBlY3RlZCDigJg94oCZLCDigJgs4oCZLCA=?=
 =?utf-8?B?4oCYO+KAmSwg4oCYYXNt4oCZIG9yIOKAmF9fYXR0cmlidXRlX18=?=
 =?utf-8?B?4oCZ?= before ...
Message-ID: <2025020459-aversion-recount-0c44@gregkh>
References: <CACo-S-1EmQkbiykZQYV4yvBZqVe0zNgm9pLYxu6E4bVAPCSrfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACo-S-1EmQkbiykZQYV4yvBZqVe0zNgm9pLYxu6E4bVAPCSrfQ@mail.gmail.com>

On Mon, Feb 03, 2025 at 04:27:00PM -0800, KernelCI bot wrote:
> Hello,
> 
> New build issue found on stable-rc/linux-5.4.y:
> 
>  expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘__free’ in
> drivers/soc/atmel/soc.o (drivers/soc/atmel/soc.c)
> [logspec:kbuild,kbuild.compiler.error]
> 
> - Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:040dcc33328a47e528c393a656a52b340b4ccc8b
> - Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=maestro:040dcc33328a47e528c393a656a52b340b4ccc8b
> 
> 
> Log excerpt:
> drivers/soc/atmel/soc.c:277:32: error: expected ‘=’, ‘,’, ‘;’, ‘asm’
> or ‘__attribute__’ before ‘__free’
>   277 |         struct device_node *np __free(device_node) =
> of_find_node_by_path("/");
>       |                                ^~~~~~
> drivers/soc/atmel/soc.c:277:32: error: implicit declaration of
> function ‘__free’; did you mean ‘kzfree’?
> [-Werror=implicit-function-declaration]
>   277 |         struct device_node *np __free(device_node) =
> of_find_node_by_path("/");
>       |                                ^~~~~~
>       |                                kzfree
> drivers/soc/atmel/soc.c:277:39: error: ‘device_node’ undeclared (first
> use in this function)
>   277 |         struct device_node *np __free(device_node) =
> of_find_node_by_path("/");
>       |                                       ^~~~~~~~~~~
> drivers/soc/atmel/soc.c:277:39: note: each undeclared identifier is
> reported only once for each function it appears in
> drivers/soc/atmel/soc.c:279:51: error: ‘np’ undeclared (first use in
> this function); did you mean ‘nop’?
>   279 |         if (!of_match_node(at91_soc_allowed_list, np))
>       |                                                   ^~
>       |                                                   nop
>   CC      drivers/spi/spidev.o
> cc1: some warnings being treated as errors
> 
> 
> 
> # Builds where the incident occurred:
> 
> ## multi_v7_defconfig(gcc-12):
> - Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a119e4661a7bc87489b6f5
> 
> ## multi_v5_defconfig(gcc-12):
> - Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a119e0661a7bc87489b6f2
> 
> ## multi_v7_defconfig(gcc-12):
> - Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a119d8661a7bc87489b4f0
> 
> 
> #kernelci issue maestro:040dcc33328a47e528c393a656a52b340b4ccc8b

Now fixed for 5.4, 5.10, and 5.15, thanks!

greg k-h

