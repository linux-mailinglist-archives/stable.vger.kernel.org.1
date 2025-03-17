Return-Path: <stable+bounces-124730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F373A65AF9
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2421F188C65E
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7921ACEAD;
	Mon, 17 Mar 2025 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JaS2+V42"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00081A76BB;
	Mon, 17 Mar 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233168; cv=none; b=cmhZd7MpGTF1W0KDwE4JXe3Mi7dkXAD5kgHDpc6Jkjdf2ZflJfXk4BthWEje4po9rRcf4wH+syS2pevkTp1GsdxaLSseM5+wqGkPN4IqcBeGpjsWYBQk5HUcGj1hALHDn0VdpwaB+aRVQa0jVQj8xYe/oKZ/4A57iceyZIHO2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233168; c=relaxed/simple;
	bh=yo+U9za/ELC6Al/URE1mWfwXOp6oTyRM0vjOE02WCtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEqFNixc1FKV0618RAehYLZdGQSnDdBAEA23UW6Dt6FNIQyZrQKEQ8tDhWRxsOzON3M6GPgvc4T11PL97zNCflCYuGec9xPh8pCISU+66lf4cuLsGVyqafkiJ2YMnuOQptSyCNvzdPDyLx4k7uv26Lp9MvQayC5HvrvLiGeI0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JaS2+V42; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEF1B4453A;
	Mon, 17 Mar 2025 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742233163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2aP9JOjwWHmiPktb3zwtlZkjkfIxkDiir2T4v3t/MYY=;
	b=JaS2+V42vHbaAEt9KhQ0pC7pdk8jC7/iFFjcZr2FQxv/E7C8fRGMHaWicimiCmC3A10MyP
	AVRf17VDgtxGjGv5RHyzbbEKnxxKiA89geI6BAqQhPji3f/gilLDisQ2VSW+ixyUHz1XZr
	75GzLn4YGtGA0LMZdmKEb10RaYxo+//ZrqvdXYa9xuqFisrnOgf+92/Pz2EeS6wse/EoSE
	ueZQ0ehLespuz89f9NO6bB3n5HIUjUMJuSXJGXAU2t5oMJ5kKXYWGtm7BLvCWrKEuL9kY0
	RGYdCT3kMF7tXfbfuK8UEtyt7gdpVSY01Xv6oUDaa4eoZqSFhbKcJm2cretbhg==
Date: Mon, 17 Mar 2025 18:39:22 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Message-ID: <2025031717392264f19f1a@mail.local>
References: <20250312135356.2318667-1-manjunatha.venkatesh@nxp.com>
 <Z9HSdtD1CkdCpGu9@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049644F3287C378E9CC75EF8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810>
 <VI1PR04MB1004979B7D38486FD1E1CC8508FDF2@VI1PR04MB10049.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB1004979B7D38486FD1E1CC8508FDF2@VI1PR04MB10049.eurprd04.prod.outlook.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptddtgfeuvedtheejtdethfdthfegfeelvdelffdtudevjeehieekgfekheevledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepmhgrnhhjuhhnrghthhgrrdhvvghnkhgrthgvshhhsehngihprdgtohhmpdhrtghpthhtohepfhhrrghnk
 hdrlhhisehngihprdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegtohhnohhrrdgtuhhlhhgrnhgvsehsihhlvhgrtghordgtohhmpdhrtghpthhtoheplhhinhhugidqiheftgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvhhmrghnjhhumhgtvgesghhmrghilhdrtghomh
X-GND-Sasl: alexandre.belloni@bootlin.com

On 17/03/2025 15:46:52+0000, Manjunatha Venkatesh wrote:
> 
> 
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Monday, March 17, 2025 6:57 PM
> > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> > Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
> > svc_i3c_master_ibi_work()
> > 
> > On Thu, Mar 13, 2025 at 05:15:42AM +0000, Manjunatha Venkatesh wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <frank.li@nxp.com>
> > > > Sent: Wednesday, March 12, 2025 11:59 PM
> > > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> > > > Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable
> > > > memory at
> > > > svc_i3c_master_ibi_work()
> > > >
> > > > On Wed, Mar 12, 2025 at 07:23:56PM +0530, Manjunatha Venkatesh
> > wrote:
> > > > > As part of I3C driver probing sequence for particular device
> > > > > instance, While adding to queue it is trying to access ibi
> > > > > variable of dev which is not yet initialized causing "Unable to
> > > > > handle kernel read from unreadable memory" resulting in kernel panic.
> > > > >
> > > > > Below is the sequence where this issue happened.
> > > > > 1. During boot up sequence IBI is received at host  from the slave device
> > > > >    before requesting for IBI, Usually will request IBI by calling
> > > > >    i3c_device_request_ibi() during probe of slave driver.
> > > > > 2. Since master code trying to access IBI Variable for the particular
> > > > >    device instance before actually it initialized by slave driver,
> > > > >    due to this randomly accessing the address and causing kernel panic.
> > > > > 3. i3c_device_request_ibi() function invoked by the slave driver where
> > > > >    dev->ibi = ibi; assigned as part of function call
> > > > >    i3c_dev_request_ibi_locked().
> > > > > 4. But when IBI request sent by slave device, master code  trying to
> > access
> > > > >    this variable before its initialized due to this race condition
> > > > >    situation kernel panic happened.
> > > > >
> > > > > Fixes: dd3c52846d595 ("i3c: master: svc: Add Silvaco I3C master
> > > > > driver")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Manjunatha Venkatesh
> > <manjunatha.venkatesh@nxp.com>
> > > > > ---
> > > > > Changes since v3:
> > > > >   - Description  updated typo "Fixes:"
> > > > >
> > > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct
> > > > work_struct *work)
> > > > >  	switch (ibitype) {
> > > > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > > >  		if (dev) {
> > > > > -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> > > > > -			master->ibi.tbq_slot = NULL;
> > > > > +			data = i3c_dev_get_master_data(dev);
> > > > > +			if (master->ibi.slots[data->ibi]) {
> > > > > +				i3c_master_queue_ibi(dev, master-
> > > > >ibi.tbq_slot);
> > > > > +				master->ibi.tbq_slot = NULL;
> > > > > +			}
> > > >
> > > > You still not reply previous discussion:
> > > >
> > > > https://lore.kernel.org/linux-i3c/Z8sOKZSjHeeP2mY5@lizhi-Precision-T
> > > > ower-
> > > > 5810/T/#mfd02d6ddca0a4b57bc823dcbfa7571c564800417
> > > >
> > > [Manjunatha Venkatesh] : In the last mail answered to this question.
> > >
> > > > This is not issue only at svc driver, which should be common problem
> > > > for other master controller drivers
> > > >
> > > [Manjunatha Venkatesh] :Yes, you are right.
> > > One of my project I3C interface is required, where we have used IMX board
> > as reference platform.
> > > As part of boot sequence we come across this issue and tried to fix that
> > particular controller driver.
> > >
> > > What is your conclusion on this? Is it not ok to take patch for SVC alone?
> > 
> > I perfer fix at common framwork to avoid every driver copy the similar logic
> > code.
> > 
> [Manjunatha Venkatesh] : As per your suggestion tried the below patch at common framework api i3c_master_queue_ibi()
>  and looks working fine, didn't see any crash issue.
> if (!dev->ibi || !slot) {
>              dev_warning("...");

Do we really need a warning, what would be the user action after seeing
it?
>              return;
> }
> Will commit this change in next patch submission.
> 
> > Frank
> > 
> > >
> > > > Frank
> > > >
> > > > >  		}
> > > > >  		svc_i3c_master_emit_stop(master);
> > > > >  		break;
> > > > > --
> > > > > 2.46.1
> > > > >
> > >
> > > --
> > > linux-i3c mailing list
> > > linux-i3c@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-i3c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

