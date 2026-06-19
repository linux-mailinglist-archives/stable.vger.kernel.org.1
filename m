Return-Path: <stable+bounces-267429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hEVsBOx1NWrEwwYAu9opvQ
	(envelope-from <stable+bounces-267429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 19:01:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 804656A72A9
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 19:01:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Zrdc2G/b";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267429-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267429-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B97CC3003363
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836233B38B4;
	Fri, 19 Jun 2026 17:01:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC363B440F
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 17:01:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888486; cv=none; b=HXVwXpXoGb/nYbfJGJVK12gWabgVj0fu2rjl7ujABuHtpZOivkpms9zoWxvR83Ro1wDkjJbfILjMG/GPOpGxv6196dpQ5Fq+QxLhy2JWvPyZbW01EMcDK5GxeZbXcInhI9K2+IABK8TJAIJ4eJpop0x7OrX7yCm65Ys5VWbaHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888486; c=relaxed/simple;
	bh=blk0sLmKG/9G+0vVOQ1FwFXKH6K8YceXzpsNctNXO/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAYeRFgvJu1Eu0ChxYRVRnZtKx2cj02gFS9zAS/XMicxn0VWGXY8QTMCGfMbCeXVBhLjTg94qt7venwfxTExVRTJSQXnwE3JeYCEtNQNSVo5j+xp6ILcQ49IHORELHd6WomwSAvJKhOlWI7d9JQQ+E4038V6ifZb2V85lk4DsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Zrdc2G/b; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 521581FEF7;
	Fri, 19 Jun 2026 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781888077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAsEXsjcjCFDxWh6TsARyUFmjzp9lkxD2mv/Y4WeXk8=;
	b=Zrdc2G/bOiJT7aa+ByVEZmR18s/JFORgHAxJxNqJydKferSGxtwChuuYGoQ/0C3G7ucCPC
	PIUH75PxUBKo4sYjz/PzSFF7Driu0rOban8vvZmcuRTZTQNcQ7QsiiiRgB6lFvUmYOihb5
	rfuGEc+fRglABTqcM5murZrtEQy9ySI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 stable@kernel.org, Sasha Levin <sashal@kernel.org>
Subject:
 Re: [PATCH 6.12 125/307] batman-adv: tt: prevent TVLV entry number overflow
Date: Fri, 19 Jun 2026 18:54:33 +0200
Message-ID: <8696716.T7Z3S40VBb@sven-desktop>
In-Reply-To: <20260607095732.348045111@linuxfoundation.org>
References:
 <20260607095727.647295505@linuxfoundation.org>
 <20260607095732.348045111@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10869751.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267429-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,narfation.org:dkim,narfation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 804656A72A9

--nextPart10869751.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 Jun 2026 18:54:33 +0200
Message-ID: <8696716.T7Z3S40VBb@sven-desktop>
In-Reply-To: <20260607095732.348045111@linuxfoundation.org>
MIME-Version: 1.0

On Sunday, 7 June 2026 11:58:42 CEST Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.

No real objection for 6.12. But it was missed in

* 6.6: https://lore.kernel.org/all/20260529181639.417037-1-sven@narfation.org/

  - applied when using the correct order - no actual change in the patch

* 6.1: https://lore.kernel.org/all/20260529194529.471742-1-sven@narfation.org/

  - applied when using the correct order - no actual change in the patch

* 5.15:

  - it depends on the also missed patch (with context conflicts):
    https://lore.kernel.org/all/20260529200201.476164-1-sven@narfation.org/
  - applied when using the correct order - no actual change in the patch:
    https://lore.kernel.org/all/20260529200323.476654-1-sven@narfation.org/

* 5.10:

  - it depends on the also missed patch (with context conflicts):
    https://lore.kernel.org/all/20260529201109.479022-1-sven@narfation.org/
  - applied when using the correct order - no actual change in the patch:
    https://lore.kernel.org/all/20260529201235.479508-1-sven@narfation.org/



In case of questions regarding the order of patches, you can refer to:

* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/7.1
* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/7.0
* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.18
* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.12
* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.6
* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.1
* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/5.15
* https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/5.10

Regards,
	Sven
--nextPart10869751.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCajV0SQAKCRBND3cr0xT1
yz4iAP4vZStcHduf48GIm3WEX3lbGoavCrwDG4MGgormdy1dfgD/V7oe7QkbcoRF
Nf1Mn834c1kUbkN0XQ8L3fH0KkkTBgI=
=BZrv
-----END PGP SIGNATURE-----

--nextPart10869751.nUPlyArG6x--




