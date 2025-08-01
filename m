Return-Path: <stable+bounces-165735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B2B181EF
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFF63ADEC6
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF024729C;
	Fri,  1 Aug 2025 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b="hooaJxhw"
X-Original-To: stable@vger.kernel.org
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286757260D;
	Fri,  1 Aug 2025 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.145.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051944; cv=none; b=kVDPmFAI0V4c6qDN2ugQJ/fbKh81KLXvnPBo80tatzHAHutYr0XvrshQE0up436jf2KEC8AAfF97Ek9gwFPwh5IAIaB6lGdGFV8pSDn1BjRbl7npAuSwzGlTdZRkzlvYVWlgUlXbrJVbXdgJJXWyWDMGv5ckr/bED7MjyGovStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051944; c=relaxed/simple;
	bh=AIgaXLU6VVb21Oq2YknimM6q0Lj3pcJxXxaBsB43KOQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=anoFXzstcV93nHNmvna1sg8HBm4EwgimzRVnHxTaerfUDB8GD9awx+FQMU4O6Id6jpunDRttplKqSsZUpVAhuJQBQGpfTrGCZ0g5BdQe2pcI1vvc18v5dxqJ6gEjsuBIQ/vfrrdtmv/6RKmMhFYjRTiRVIMEgFx7NtbJweQ4Flo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com; spf=pass smtp.mailfrom=ifm.com; dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b=hooaJxhw; arc=none smtp.client-ip=132.145.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
	by pp2023.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 5719jZBl027083;
	Fri, 1 Aug 2025 14:06:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc : content-type : date
 : from : in-reply-to : message-id : mime-version : references : subject :
 to; s=pps; bh=lpH3xkMAjRdqOgEf0utAOyXzcKUV6T2rnEhq3u+IzPA=;
 b=hooaJxhwctkWK4rZUeBNW4ffD2FQRtJ3xgHdjCT9xDyL3UbbIM/SkagCTfL4BAmoCC98
 /atcNbv5wQ3lOj/JSqGSHsFzzkKbd71SrXgv8fdLncFJqmXs4fJsvspbhTvt7CzWvpe7
 XjDnZrtJbl8Os0BTRP/PsVHNuaw3DyCsZrpKRl6ZdZRE+8vSA1uneDA4UKnSygusjqju
 jjSXEqA0OOL8bWzxNXMmopqx1VikddEUc0gqM0gSKM0McjrhsTzTKU5V3ZcL3iC735Sm
 GuJ0owBcrwn2RGsLnyL+XS+XH339skz9dzwljEcpSl0rZfyGbOHBpojRBfJijUUrIq3t 4w== 
Date: Fri, 1 Aug 2025 14:06:28 +0200
From: Christoph Freundl <Christoph.Freundl@ifm.com>
To: Xu Yang <xu.yang_2@nxp.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <peter.chen@kernel.org>, <sashal@kernel.org>, <stable@vger.kernel.org>,
        <hui.pu@gehealthcare.com>
Subject: Re: [GIT PULL] USB chipidea patches for linux-5.15.y and
 linux-6.1.y
In-Reply-To: <20240903021135.5lzfybyv7rzty33d@hippo>
Message-ID: <36406dea-f876-b3e-5ad7-69fdae97366a@ifm.com>
References: <20240902092711.jwuf4kxbbmqsn7xk@hippo> <2024090235-baggage-iciness-b469@gregkh> <20240903021135.5lzfybyv7rzty33d@hippo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ID: SID=48578gpnjh QID=48578gpnjh-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-07-31_03,2025-03-28_01

On Tue, 3 Sep 2024, Xu Yang wrote:
> On Mon, Sep 02, 2024 at 02:14:04PM +0200, Greg KH wrote:
> > On Mon, Sep 02, 2024 at 05:27:11PM +0800, Xu Yang wrote:
> > > Hi Greg,
> > >
> > > The below two patches are needed on linux-5.15.y and linux-6.1.y, please
> > > help to add them to the stable tree.
> > >
> > > b7a62611fab7 usb: chipidea: add USB PHY event
> > > 87ed257acb09 usb: phy: mxs: disconnect line when USB charger is attached
> > >
> > > They are available in the Git repository at:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch usb-testing
> >
> > We don't do 'git pull' for stable patches, please read the file:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> >
> > Just send them through email please.
>
> Okay. I'll follow the rules.

I want to bump this topic as this is still an issue, not only on the
mentioned branches but also on linux-5.10.y. For the affected devices (a
custom i.MX6 board in our case) you have to either revert commits
e70b17282a5c3c and cc2d5cdb19e3 or apply above commits in order to make
the USB interface work properly.

Many regards,
Christoph


