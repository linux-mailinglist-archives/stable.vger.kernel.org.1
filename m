Return-Path: <stable+bounces-227240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGYXGTPFu2mYoAIAu9opvQ
	(envelope-from <stable+bounces-227240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:43:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198F2C8E6E
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A1D03135890
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7E3B47D5;
	Thu, 19 Mar 2026 09:16:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C83B27E0
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911785; cv=none; b=H2VdTgfSf/xlQqIMzQ0hXqI8agids+vKi/0CD1kKSl4XJ+QpEVpvRbDcaqVfYoz5Ks7V50/Bt0HdkbjDX8pwjGgHeAUYZF5RRQENYfKGZLQ0y+iFWxqzRLCxwC2ATK4Fo+SsIZA41EkQIr3ttxFPix/ucGDX9pE0KpTA3m+Tndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911785; c=relaxed/simple;
	bh=LVkjrkJ9IPdMj7LZgIaPDS8LSm5H1bYTo56ynT6WiO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0qU0BwkHBhYo08wloZgPcGvXpYqfWZameprxVDbueJZ3PZ/h8JUe9ZR1jcbDnyuU7gtE8MI802qety/gzl03JYdn0ABt4LHlh9k0111Z/ZQQxN44Qr8JT0iteCxwfwbuwSVUwVv9G0leptuBzj8UYa9nPmiNZ2KqIkc/kOP1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1w39U6-0000CU-2G; Thu, 19 Mar 2026 10:16:06 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1w39U5-00136C-1T;
	Thu, 19 Mar 2026 10:16:05 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1w39U5-0000000AzAZ-1Rqi;
	Thu, 19 Mar 2026 10:16:05 +0100
Date: Thu, 19 Mar 2026 10:16:05 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Hyungjung Joo <jhj140711@gmail.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com,
	gregkh@linuxfoundation.org, v9fs@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abu-1VmxKlRgHcyX@pengutronix.de>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
 <abs0Q2Sw3WvLYFbe@pengutronix.de>
 <abtDrEQ4ySmhujwG@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i4WYxWkQe8rtZPHj"
Content-Disposition: inline
In-Reply-To: <abtDrEQ4ySmhujwG@codewreck.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ionkov.net,crudebyte.com,linuxfoundation.org,lists.linux.dev,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-227240-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.179];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9198F2C8E6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--i4WYxWkQe8rtZPHj
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 09:30:36AM +0900, Dominique Martinet wrote:
>Michael Grzeschik wrote on Thu, Mar 19, 2026 at 12:24:51AM +0100:
>> On Sat, Mar 14, 2026 at 02:16:59AM +0900, Hyungjung Joo wrote:
>> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> I wonder where greg did this review? Was this in another thread?
>
>Yes, it was when Hyungjung Joo sent this to security@, so the review was
>not public

Since the patch was already reviewed by greg, I decided to keep it
as much as it is and include it in one in my series. This way I can keep
the Reviewed-by and the Fixes tag for stable.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--i4WYxWkQe8rtZPHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmm7vtIACgkQC+njFXoe
LGQMMw//Y75flWnO9S/ayzdszgGvjtGyUBIPxPS2u4qWDL3rkz+MsILQy2MhEVtJ
6UCJ1qNFWE6i6fmlIiP4OtUPqqn8lbeYmevVQQoyDrzSH/MVpv7cwdxtsBZNeM+j
inSJaKd2HTh4BwaIY110NIUomWM7oGONdujN6zTHEQNPyhge5rlRefrhVjN3ksg8
K1b7zlqjak0hE1cZhyQW1XwF7ZRbDPw7h0Q1xXULS1JAKxLyXsmsuDg79rvOIybd
cx/vgZDjgbyZwYPV5R+LpbWu5L91j/VkrstfWX84fKuopcpts+rNbZshEmdlIQ4V
mHkfZMpKJISUzKIvPZNaW53b7rmMy1TE9OybJOm/E4Fd7F4XC/ZxTj/6UQ6IBOwn
RJzyzUOjjkMpts1d/t1SGSBMnAxqVyC/iWFSU1p5XecwAQwk3dNaBF020fpDmc/i
3N6TSfbRpkGyfl2mcAExtdj6DHK4iOBbMyKwr6YeXPPmipdAhoURzbY04zpo/D/N
xxcckrAMbjSE3Q3JJTzAxFdpoMBjgjMDYp08iMvHkoZzU45gn83RfqsexX9RpgOZ
Ats76O/mKnMnKNX8WAl2CJI8QMn9TojU4S+a3xSk5f5hEvKEeETtFS8tiA2HQEkq
K33lgF8d0yo/DCAjvHJF3/PwnOfwH84RKdhGQfqu8BOAuimDce8=
=KKPF
-----END PGP SIGNATURE-----

--i4WYxWkQe8rtZPHj--

