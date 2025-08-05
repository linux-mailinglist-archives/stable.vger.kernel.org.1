Return-Path: <stable+bounces-166664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E542B1BDA2
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B79180D15
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7E2BE028;
	Tue,  5 Aug 2025 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="PlEz6jxQ"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19361D61AA;
	Tue,  5 Aug 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438266; cv=none; b=G/iv/TyF4X9oyHcHWq9bV3AHIKvIOxjqi0qhpAIm/msY6RqT85QFWwMOuIfxXfVbHgIhN5xgKaQg031pFqLBMIr2SRoMHXngWMl+IEp+rdUsmEa/MbsKeTvRVSrhQ5yhtxeJyaakgTqXspGI/8SFlkh+vtAa9RPivJYZYubJUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438266; c=relaxed/simple;
	bh=Azwu2exHhvcNWSkXq+F6f+iwwZa36ojFzn02qKnZGcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlfh1bDm0uHyqVsmEpAgu6nH5SA2QWJtCpTDYDYKDVNEQW10Lodfa0+07qkfBjDlahsnWxUz1nnzUQt2A9timKFMuaaXJuzyTKkRxumxOvmEDY01SUhPo0W296EGcw0eWseyNDVaqwx+CtmgPNOfvbpc5JLk2biI7ov9DYG8oX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=PlEz6jxQ; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754438262;
	bh=Azwu2exHhvcNWSkXq+F6f+iwwZa36ojFzn02qKnZGcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=PlEz6jxQQL/Nh626X64BFWdHp1WHNm/1f70UudtQaY/+ymVO0RPgDaWwlZp6wTNkT
	 735uKh9QRgmJwIcLNTdEAm0xTdaLjOGCyO3Bw+x8OQoONqu+ACthmIXYidbjl7K/ec
	 Sdxd+yZTpN8/dtS9n32KnuNYPvw3VykU5AOaYEqs8XoCiunOtANM5nkXVLSLm448fx
	 5TJr9hMjN2Nboq/H4yFyYUPnxKKttxQoaXwuJBObb2sPf1tdAs+z8xKwa7mXlL1TWG
	 iSgDszzE25T1fnFQnF+rsRawR2tNezN3GfkFEN1Di+QVZEAkrBgYMqfaIwVbzySPIL
	 BWe9ahE5/Dj9Q==
Received: from linux.gnuweeb.org (unknown [182.253.126.229])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 7D8973127C24;
	Tue,  5 Aug 2025 23:57:39 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Wed, 6 Aug 2025 06:57:36 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org,
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on()
 call placement
Message-ID: <aJKacDYMeggdiHxO@linux.gnuweeb.org>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org>
 <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
 <20250805164747.40e63f6d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805164747.40e63f6d@kernel.org>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Tue, Aug 05, 2025 at 04:47:47PM -0700, Jakub Kicinski wrote:
> On Wed, 6 Aug 2025 01:40:37 +0300 Linus Torvalds wrote:
> > So my gut feel is that the
> > 
> >                 if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
> >                         netif_carrier_on(dev->net);
> > 
> > should actually be done outside that if-statement entirely, because it
> > literally ends up changing the thing that if-statement is testing.
> 
> Right. I think it should be before the if (!netif_carrier_ok(dev->net))
> 
> Ammar, could you retest and repost that, since we haven't heard from
> John?

OK, I'll send a v3 shortly.

-- 
Ammar Faizi


