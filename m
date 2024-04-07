Return-Path: <stable+bounces-36196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E331489B077
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 12:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F5A1F21996
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D31773A;
	Sun,  7 Apr 2024 10:34:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7F1642B
	for <stable@vger.kernel.org>; Sun,  7 Apr 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486079; cv=none; b=sPc2a5CL1Tx3C+racxp4Im1A9bpauzg6sAvXdy7itmHLvOyPQI3gAHtjZPUu9mCoFXSAsdRxHoi+043SanDzM2I4fne4vIuR4ZMSoMfkVJZOQ/vuuC/eL/wNGlaM3pZrDeE1YYEt/Y41B46y77SLVjtEUsxTzD7HYJ3e1/qCqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486079; c=relaxed/simple;
	bh=5J19MuH65/krdnVcg9I72ISYfhsvRosLHd5HirI23Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5dz6E7k06OmFnvJH6DrSo9HVxkSZT3SBYxmspjgi1Lch7JswFM39FO2HOhKPSjTX/5gJT6elh3o8Y48ykfKmm4OPZ7V0X+OTaHYDZ6bnmLhEZWof9Wf+UF46vRR02LTyVnw9G7tgoF5AZE/XCewByPPFJTCsjiEm6peXld7/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=62.142.5.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from ydin.reaktio.net (unknown [85.76.255.15])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 6d285837-f4ca-11ee-a9de-005056bdf889;
	Sun, 07 Apr 2024 13:34:35 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
	id 9815F20089; Sun,  7 Apr 2024 13:34:34 +0300 (EEST)
Date: Sun, 7 Apr 2024 13:34:34 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Norbert Preining <norbert@preining.info>,
	stable@vger.kernel.org, regressions@leemhuis.info
Subject: Re: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
Message-ID: <20240407103434.GA31628@reaktio.net>
References: <ZgvkIZFN23rkYhtS@burischnitzel>
 <6139700.lOV4Wx5bFT@natalenko.name>
 <20240406182943.GG1099@reaktio.net>
 <2724514.mvXUDI8C0e@natalenko.name>
 <20240407093931.GA28090@reaktio.net>
 <20240407094458.GB28090@reaktio.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407094458.GB28090@reaktio.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Apr 07, 2024 at 12:44:58PM +0300, Pasi Kärkkäinen wrote:
> On Sun, Apr 07, 2024 at 12:39:31PM +0300, Pasi Kärkkäinen wrote:
> > > > 
> > > > I noticed possible related USB problem/regression also with Linux 6.7.11, eg. my USB headset is not detected at all anymore when running Linux 6.7.11. USB headset works OK with Linux 6.7.9, so the regression is included/backported to also either in 6.7.10 or in 6.7.11.
> > > 
> > > It wound be nice to narrow this range down even further with bisection because there are too many changes between v6.7.9 and v6.7.11 that could cause this.
> > > 
> > 
> > I just tested more Fedora kernel rpms, and it seems Linux 6.7.10 still works OK,
> > but 6.7.11 has the regression (eg. USB devices not detected, laptop does not reboot 
> > as it gets stuck before resetting the machine).
> > 
> > So the regression was backported to Linux 6.7.11.
> > 
> 
> And with more testing interestingly it seems Linux 6.7.12 already fixes the problem.
> 
> I tried multiple times: 6.7.10 works, 6.7.11 doesn't, and 6.7.12 again works.
> 

Looking at the Linux 6.7.x changelogs I'm *guessing* it's these commits:


6.7.11 (broken):

commit 963b977bc4204cc1dcc0c190d1ba255aa5c5dd19
Author: Sean Anderson <sean.anderson@seco.com>
Date:   Tue Jan 23 17:51:09 2024 -0500

    usb: phy: generic: Get the vbus supply
    
    [ Upstream commit 75fd6485cccef269ac9eb3b71cf56753341195ef ]
    
    While support for working with a vbus was added, the regulator was never
    actually gotten (despite what was documented). Fix this by actually
    getting the supply from the device tree.
    
    Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
    Signed-off-by: Sean Anderson <sean.anderson@seco.com>
    Link: https://lore.kernel.org/r/20240123225111.1629405-3-sean.anderson@seco.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>


6.7.12 (working):

commit fc3b5406b75472e1353073d1f410421aed62b793
Author: Alexander Stein <alexander.stein@ew.tq-group.com>
Date:   Thu Mar 14 10:26:27 2024 +0100

    Revert "usb: phy: generic: Get the vbus supply"
    
    commit fdada0db0b2ae2addef4ccafe50937874dbeeebe upstream.
    
    This reverts commit 75fd6485cccef269ac9eb3b71cf56753341195ef.
    This patch was applied twice by accident, causing probe failures.
    Revert the accident.
    
    Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
    Fixes: 75fd6485ccce ("usb: phy: generic: Get the vbus supply")
    Cc: stable <stable@kernel.org>
    Reviewed-by: Sean Anderson <sean.anderson@seco.com>
    Link: https://lore.kernel.org/r/20240314092628.1869414-1-alexander.stein@ew.tq-group.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>



-- Pasi


