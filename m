Return-Path: <stable+bounces-235773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIM7Fl/Z2mlI6wgAu9opvQ
	(envelope-from <stable+bounces-235773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:29:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B075A3E1EBB
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A74993011860
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE138423C;
	Sat, 11 Apr 2026 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTW0H71F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4131619C
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775950167; cv=none; b=lWhx2EgewP4WB8dTJch5EVYRjgzDnBr/GoH6qk0P15Zy/fNp7uXLIkmfnrPe5x0Ouu8pRIPMuq0ozfLNsK5UPPO7PbOcev/DvsJJMCdUbJNpv8mEpsPJVdnB2z2J31ePAnsGXIJysP4/bOb1v5IsCpEnHjDeAYnGp2J2gBOgxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775950167; c=relaxed/simple;
	bh=bGYMj1nEU3rTt3DSUk3rq+ORCg6O2I9VqoBBgW/e8ZE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eOZwyg6FGPSdqdf6IzyovM6KbEqUE1JAz7vypmzrZvY34pkv41KDk+9XU0/SugOBVvyPLYH4M2L5agb74SLVoVl7HZTXGSpOiZ/U0ioJojxRyLZtvEQLg7XuZdmVo6+u/Z6ugizdnte+ILIPFPR5Dx6Mjv+UgSA3A7KUh6jgaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTW0H71F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356BEC116C6;
	Sat, 11 Apr 2026 23:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775950167;
	bh=bGYMj1nEU3rTt3DSUk3rq+ORCg6O2I9VqoBBgW/e8ZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PTW0H71FfkjRl1QX4y6k443xaOyYaudhpdTrBQgIp216uINOPXxTscHgzEmi4QvlK
	 ugROyUVSbyqIn9rlyfxZIgcVL79Tj0uO0LSOxdfzKp5Ln68MJRihJSJXWekVunI9e+
	 e/Q83YZhS8fCBstXHuWaUeZPi/KtewsaSS39bXW2oUNDgyNPPz4dM7TG0tPJ0w/uxV
	 O1JdwtTAE3UMJX9jV/fWey2iMkwFszo1yUkUq9vDHComIISede1kiq2HJVHKVS7pdg
	 +IRZpv8REdXjLhhfiWzTEugsVatT2tp+lODoOAqqKP/U16RDikglsXWf9AUHat6CIf
	 oVC+0UDnLAI4Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5F449F40068;
	Sat, 11 Apr 2026 19:29:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 19:29:26 -0400
X-ME-Sender: <xms:VtnaaQViXEzT_3c_vkp0v9eyDsH95g8wzc0sfEbor4-ItlgcpOVrGQ>
    <xme:VtnaaRIhzq13-m1HhVomcLPry2aEW13JC-bWpyv2M8PN-JqY9eLnq8TYwFoxI964h
    U-eVBDQdyakTsjzewMm2sgGGccEl8_oknXJmylJ528mmtW87NOYn7g>
X-ME-Received: <xmr:VtnaaY15uL4oxRyT6e6uu_fAVkAXZK8dkAQrabzfmCGxucyvUILBG1uZUG0G7X9buCXvbIGmfu4h7Ci5q62uu1zblpxPjtv7fU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlghhs
    vddtudelvddtudeftddvgeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvhhishhhrg
    hlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhjihgr
    nhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopehnvhguihhmmheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VtnaaWJwMXZeycWNjiQNAB0ocSUhbnqqeopV4oCaEH3MWJok6S2Bvw>
    <xmx:Vtnaabi9erDa7dLzLKn1g_I5gAkfykv5676W2mhlChTaL_Zo7pDiGg>
    <xmx:VtnaaeCOWLm4KNsynmcuCBdiWmTd794QduiYt3gUd4UJenekD-vPHw>
    <xmx:VtnaaV5-UgUpwBam6oNLcrgDgy8UVKQZBPdZNeg9toLD-3Pmexh1Xw>
    <xmx:VtnaabFSwiYaevjut23MZeWtjqznb_G7fOOG8wYBUWmTRk7xw-hwvA8R>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 19:29:25 -0400 (EDT)
Date: Sat, 11 Apr 2026 16:29:24 -0700
From: Dan Williams <djbw@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <69dad954cbd27_fdcb41005c@djbw-dev.notmuch>
In-Reply-To: <20260411145726.2299438-1-lgs201920130244@gmail.com>
References: <20260411145726.2299438-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] device-dax: Fix refcount leak in __devm_create_dev_dax()
 error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235773-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,linux-foundation.org,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djbw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B075A3E1EBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device is
> expected to be managed through the device core reference counting.
> 
> In __devm_create_dev_dax(), several failure paths after
> device_initialize() free dev_dax directly instead of releasing the
> device reference with put_device(). This bypasses the normal device
> lifetime rules and may leave the reference count of the embedded struct
> device unbalanced, resulting in a refcount leak and potentially leading
> to a use-after-free.

Please do not list "theoretical" problems as justification. Point to
real problems.

> Fix this by assigning dev->type before device_initialize(), so the
> release callback is available for put_device(), and use put_device() in
> the post-initialization error paths. Keep dev_dax range cleanup explicit
> in the error path.

I see a more straightforward way to address just the practical problem
that also incorporates the other feedback I have below. Can you spot
that and fixup the changelog to address the practical impact?

> Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/dax/bus.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..8753115cd371 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1453,6 +1453,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  	}
>  
>  	dev = &dev_dax->dev;
> +	dev->type = &dev_dax_type;
>  	device_initialize(dev);
>  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
>  
> @@ -1499,7 +1500,6 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  	dev->devt = inode->i_rdev;
>  	dev->bus = &dax_bus_type;
>  	dev->parent = parent;
> -	dev->type = &dev_dax_type;
>  
>  	rc = device_add(dev);
>  	if (rc) {
> @@ -1523,14 +1523,21 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  
>  err_alloc_dax:
>  	kfree(dev_dax->pgmap);
> +	dev_dax->pgmap = NULL;
> +
>  err_pgmap:
>  	free_dev_dax_ranges(dev_dax);
> +	put_device(dev);
> +	return ERR_PTR(rc);
> +
>  err_range:
> -	free_dev_dax_id(dev_dax);
> +	put_device(dev);
> +	return ERR_PTR(rc);

Please no gotos with early returns, that makes a mess.

