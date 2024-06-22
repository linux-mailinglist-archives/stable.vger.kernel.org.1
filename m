Return-Path: <stable+bounces-54877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1CA9136A5
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 00:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F349A1C20322
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF35EE97;
	Sat, 22 Jun 2024 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eOJWqUg5"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407B57CBC
	for <stable@vger.kernel.org>; Sat, 22 Jun 2024 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095724; cv=none; b=dE3iE1ipYef+A8d26uamHIWZ95x1pVIyyrBL3/ZqCZWETvOP3lLtreKbt39jKcHrTWOqS7cLwqpf0ClWGk4Tx/X4+orTgaGJ0vr2q6J+W4xUhhAV6yORjKF1V6OxDW7/8QzO/b9VliPA+drwqvgI9j8ptW6XbOVn7HF/2UdbElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095724; c=relaxed/simple;
	bh=Ril5fbE9tQ9dG5CG1ZvIvYEss518/b+JA0boURKCPAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7PzmJTN7PCtFG6SgVcb7HGWlMNesc5Ca6WVlqGUPFgclDhjmgSkSDIaRePidmdHNyeYBshZrc2v34ICLlHqIFKiJFbT/zqaNsfvl5PU9FxE88stVZmemS+x8ElPJEtvu2ySYycvKGkueF2xdxkRgWCpOa/itlwBJwxDaKrOK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eOJWqUg5; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E37C2E0002;
	Sat, 22 Jun 2024 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719095721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzqpThDvqrjJmaXYIlAKEDZ4I8D6/j2Y6Ud0k80pnOw=;
	b=eOJWqUg5+t7ngGhuPqRaMacqYZoeWfZ8v4m3REYoPMRrC98GpIBTh9c2+a3spjzxEogdkC
	dR3CQOjHdyfE4xNkmPvTWSlBhcemTAjwHLPBL1WC5F3Ukrz2wC7QKegszjAcDKCI0XMclr
	q7vwfHRNqI0QB3Y5fk1S+U0v7LSmDkXjR6Flt9JHqAp2ZOOF+isldx3xS9/lzymsRDAAv8
	JHQ680db0pkaCI5/eZhVK0A9o2UAPvF/um30IGyhKoAcfQb71/vWJkIPNnKeGsTDwjrYSC
	11AVSSOMROAqNHG25k4CqQeQyvqD/ZtoFLnJ3A5voz/24lPZ/gFF3dZOO9DPHQ==
Date: Sun, 23 Jun 2024 00:35:20 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI
 versions < 1.1
Message-ID: <202406222235206676ddeb@mail.local>
References: <20240614140208.1100914-1-jarkko.nikula@linux.intel.com>
 <171909557751.2164405.18080145631407814648.b4-ty@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171909557751.2164405.18080145631407814648.b4-ty@bootlin.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 23/06/2024 00:34:01+0200, Alexandre Belloni wrote:
> On Fri, 14 Jun 2024 17:02:08 +0300, Jarkko Nikula wrote:
> > I was wrong about the TABLE_SIZE field description in the
> > commit 0676bfebf576 ("i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes").
> > 
> > For the MIPI I3C HCI versions 1.0 and earlier the TABLE_SIZE field in
> > the registers DAT_SECTION_OFFSET and DCT_SECTION_OFFSET is indeed defined
> > in DWORDs and not number of entries like it is defined in later versions.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1
>       https://git.kernel.org/abelloni/c/17bebfeab08b
> 

Obviously, v2 is the one that has been applied...

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

