Return-Path: <stable+bounces-144527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA478AB86A6
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 14:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691129E5AF5
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4705F298CDD;
	Thu, 15 May 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fUJOgOU/"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20C298C37;
	Thu, 15 May 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312945; cv=none; b=bAMJGHf3JlO21eLfTc+Wd9kjs/pl2HTDrr7lAUI+kHdoUebqryN/AoOz79EYHAmJ6usVrlLCW4xetBj6Hnuvlcn2EEug2WM/wcKhqPvP5CdE0Z4AVJN+hqLt6XhVqnTgKt3TOV0J/bdpjHqlSEeDlFtjCwpwlGb9DAEZQEBqcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312945; c=relaxed/simple;
	bh=sEG7OVaC85XYl+HpUbe2Ff3pZmsx7rHQwv3NZnBrrdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlDDw+zgNXPIffbOdnGSJAmkSBMQimXDEE9c/VQdMfPpov0z4CpV9jNoc/NMQ3tLdbf1bHOvIHaMxQUXrPjOn0TaFlKlsqWH4S7JY8GIP+ZI2Hnh6O2oMqWPMwRr5GloQnxT8ViK9UhxfX+/ArtZRsdLvV//zRfP9SmapKCzD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fUJOgOU/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cNTuXkkuvsEfgIEUL6i9vw+CjUWCFS2WGIry+JlM6nE=; b=fUJOgOU/hCDCJc+zM19+yxqn7g
	0/mus2JVBADogordoH1Hd0pvjYUCtObeMO8OUp8idsK/fAWkbuPrlWZ0ka5gonvaJt9WrUX5nLOF5
	rIbAoBjVetl1ZeFfXB4CXGNZJDAogS6jLHGXDmelUu80VDkosqbwY/saM6aulCkGCr7p2LNKcIT8R
	bHZb/c4ASQjnT7CrLJ64X+EeRmsEDbAgTsOOFnPdACjGhQ7nQbuaMhBrct6fkOv1gcQOAuyMKiV8J
	WFFK4M+PHBcmUvmrtdAMpZYHJNkf9VJkoRj701cxpfayEXfMhXsdtoMvILKBH+FdG8x4MqCUd/GT1
	fEtSkq2Q==;
Received: from i53875a50.versanet.de ([83.135.90.80] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uFXug-0004e2-L9; Thu, 15 May 2025 14:42:14 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>,
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject:
 Re: [PATCH v2 2/5] dt-bindings: usb: cypress,hx3: Add support for all
 variants
Date: Thu, 15 May 2025 14:42:13 +0200
Message-ID: <18791204.sWSEgdgrri@diego>
In-Reply-To: <2025051550-polish-prude-ed56@gregkh>
References:
 <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
 <3784948.RUnXabflUD@diego> <2025051550-polish-prude-ed56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 15. Mai 2025, 13:49:19 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Greg Kroah-Hartman:
> On Thu, May 15, 2025 at 01:43:59PM +0200, Heiko St=C3=BCbner wrote:
> > Am Freitag, 25. April 2025, 17:18:07 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Lukasz Czechowski:
> > > The Cypress HX3 hubs use different default PID value depending
> > > on the variant. Update compatibles list.
> > > Becasuse all hub variants use the same driver data, allow the
> > > dt node to have two compatibles: leftmost which matches the HW
> > > exactly, and the second one as fallback.
> > >=20
> > > Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 U=
SB 3.0 family")
> > > Cc: stable@vger.kernel.org # 6.6
> > > Cc: stable@vger.kernel.org # Backport of the patch ("dt-bindings: usb=
: usb-device: relax compatible pattern to a contains") from list: https://l=
ore.kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3=
029f14e800@cherry.de/
> > > Cc: stable@vger.kernel.org # Backport of the patch in this series fix=
ing product ID in onboard_dev_id_table in drivers/usb/misc/onboard_usb_dev.=
c driver
> > > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> >=20
> > Looking at linux-next, it seems like patch1 of this series was applied =
[0].
>=20
> It is in 6.15-rc6, not "just" linux-next

yeah, I mainly used linux-next to see if a part of this series was applied
anywhere :-) . Because neither my inbox nor the list archives seem to have
gotten any form of "patch applied" mail.


> > The general convention would be for the binding (this patch) also going
> > through a driver tree.
> >=20
> > I guess I _could_ apply it together with the board-level patches, but
> > for that would need an Ack from Greg .
> >=20
> > @Greg, do you want to merge this patch ?
>=20
> I thought a new series was going to be sent for some reason, which would
> make this a lot easier.  But if you want to just take this one now,
> that's fine with me as it's not in my queue.

As we're close to -rc7 now, I assume the chance is low of someone
needing this before 6.16-rc1, so thanks for the blessing, I'll do that :-) .

Heiko



