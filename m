Return-Path: <stable+bounces-120405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B8A4F86D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 09:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5E616F468
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF66170A13;
	Wed,  5 Mar 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="af8dMLy4"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C62E3360;
	Wed,  5 Mar 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162040; cv=none; b=OreH8LLlSCMS9TbjebjhZygGAcdxfwgoU2e6qhVL94xLBYFokDEvZEtvXEuNM7MOVxJxdY3k4QZat7nAEn89NDblDRooiSe8Zw4Gs6oAQ9fmdzdFkB8X/KiA4Gzf6oIFMMdhaWSuywYDVkvKtCjJ16ctKPAi+b8XeZM1E4dEvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162040; c=relaxed/simple;
	bh=6DsWC/+nahLAYdKgf4seqrfXxUEZ8iRaABBCntrYhKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMJx58L/J9qv2wEcGm5+YA+EnMP3sbGDrM3+aNOy08lw94XcbVbeQ8wuBerBugFwqtUPj7Xp3dK5nSObBU+I9tTg6B60PwLgFCpZXYQn90EXHiTpvO+xPFRELeE9wyivuBqYfUt4NndyvR1mNs2I2gQdjD9+w6ot3+jDiT5PVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=af8dMLy4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 136D74429B;
	Wed,  5 Mar 2025 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741162027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDyr92Uh765Z+tERpM9Qj4wP6zVRRYDO3RATjXNlnGI=;
	b=af8dMLy4abxWO1JCP4+dQhpdf3jav/99AL3ZCcWCA/KPZyi8+J+usqtOVoN+Uk+57otTJh
	n21Cqnuld0MNqXqaZ6V0ZkAQMkuoJ8ecG2rf5He135KZ4ASYlOarQEsk60JEScDQsgml1O
	Orm0Me8iC2gajkEB91+2oIVISL7XabQD/c2Bs2OljyPg/mp1HvLhow+aiiemmpPQJTfd1o
	oYhlrhIfe9cxWIe1NJ0aOFbbURhciFrRgWdX5elntm/KLMjrWHesdajmE+fk3R1YHRxYyl
	qIuIA6mJWc5jEmlfVf7YTIPNSFKWIIGJxkmBAKYGsLu1Oy15BeTQqxofve3+zA==
Date: Wed, 5 Mar 2025 09:07:05 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?SGVydsOp?= Codina
 <herve.codina@bootlin.com>, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Message-ID: <20250305090705.4b2eb1e9@booty>
In-Reply-To: <2025030332-tumble-seduce-7650@gregkh>
References: <20250303-fix__fw_devlink_relax_cycles_missing_device_put-v2-1-3854d249d54e@bootlin.com>
	<2025030332-tumble-seduce-7650@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeljeejuddvudetffdtudelfedugfduledtueffuedufefgudegkeegtdeihedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvr
 hhnvghlrdhorhhgpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Greg,

On Mon, 3 Mar 2025 15:07:53 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Mar 03, 2025 at 10:30:51AM +0100, Luca Ceresoli wrote:
> > Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
> > cycle detection logic") introduced a new struct device *con_dev and a
> > get_dev_from_fwnode() call to get it, but without adding a corresponding
> > put_device().
> > 
> > Closes: https://lore.kernel.org/all/20241204124826.2e055091@booty/
> > Fixes: bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize cycle detection logic")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> > Changes in v2:
> > - add 'Cc: stable@vger.kernel.org'
> > - use Closes: tag, not Link:
> > - Link to v1: https://lore.kernel.org/r/20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com
> > ---
> >  drivers/base/core.c | 1 +
> >  1 file changed, 1 insertion(+)  
> 
> This was applied to my tree on Feb 20, right?  Or is this a new version?
> Why was it resent?

I just didn't know it got applied, sorry for the noise. Being a fix, I
was expecting to see it in current master where but it isn't there yet.
Assuming it will be soon, you can ignore it.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

