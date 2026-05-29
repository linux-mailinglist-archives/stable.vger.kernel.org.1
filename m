Return-Path: <stable+bounces-256756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBC+N43vGWoX0AgAu9opvQ
	(envelope-from <stable+bounces-256756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:57:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0D608209
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ECC6304672F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B543E6DFF;
	Fri, 29 May 2026 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="1iMSk1EW"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3A3A9D8B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084514; cv=none; b=dX0RCHE10cilTcsybosyLWlCUZCZiRaNQPj7Fgr3mwJTwQWSs3kJOHOXpbfTFFRgap0PC7GrzDY8RNQ45RnByLOGFRxqsnBZGr2eaJKv5/fAoVzz72g/0lTmxrI5krObenCzcBGWbnDWZwXzKfkJRX0wjkzuNsW3pPdoaHRHc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084514; c=relaxed/simple;
	bh=uZrxP3o2ItWZbzIF3JA8YrxL2irMAioL1wgIniuS4hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pc9NPCAYw25x1wP0leU9VeYFjTd8SfHJB6O4cypstsUvh5mANb3cJcEPnj7A3SQwMLhF93O8Rka3RGZh8vEOqI79iCByY3qUvhKHOo4xCeAHN+6fURYjXS3J/HryUEhKuCAa7n0Vs9zx8D8LDllxLoUo/8YswizA8A/nFE94qnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=1iMSk1EW; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id A05921FEDA
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780084508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EWMLagVf8Wh19oJhIobPMy4EBgrLrCCOMYaMBT7dI2o=;
	b=1iMSk1EWBrl2aDdv3t2OBfTXuRvZ0ICArdmcIYnojWpCyTpR5tILwN9sa2fPV6ROkHr7f5
	UJA69B9VH1ZRXL+//rAZMH7oRRtHZaGJ+U0Rj00pdWNThBOT4HnBt6jwi+V1HFHqTJ37o1
	3xcTBz2t89qQhCgnpj5yrCdeJjeJ6qs=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Subject:
 Re: [PATCH 6.1.y 2/2] batman-adv: tp_meter: fix race condition in send error
 reporting
Date: Fri, 29 May 2026 21:55:05 +0200
Message-ID: <6467119.DvuYhMxLoT@sven-desktop>
In-Reply-To: <20260529194908.473287-2-sven@narfation.org>
References:
 <2026052833-easing-gerbil-ae19@gregkh>
 <20260529194908.473287-1-sven@narfation.org>
 <20260529194908.473287-2-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6741472.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256756-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[narfation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:dkim,open-mesh.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 61D0D608209
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart6741472.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Date: Fri, 29 May 2026 21:55:05 +0200
Message-ID: <6467119.DvuYhMxLoT@sven-desktop>
In-Reply-To: <20260529194908.473287-2-sven@narfation.org>
MIME-Version: 1.0

On Friday, 29 May 2026 21:49:08 CEST Sven Eckelmann wrote:
> Cc: <stable@kernel.org> # 6.6.x: 5c1bf8d batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
> Cc: <stable@kernel.org> # 6.6.x

Grml, meant 6.1.x. But I've sent the required patch too.

Btw. if these dependencies between patches annd the correct order causes 
headaches: I have everything in 
https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.1 (and similar 
branches) and can easily rebase them on top of stable-rc.git/queue/6.1 and 
sent the remaining patches out as a patchset for a specific stable kernel 
(like 6.1).

Regards,
	Sven
--nextPart6741472.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahnvGgAKCRBND3cr0xT1
y15XAPwPw0ilm9eh8pudXYPoZrvyptIf6gZzpihmm9CPAQ3e/gD/ZHQiZ4e2b0FG
CjfQTSGYWkCQUJy/iV3A6l0lfJfpwgU=
=VwU+
-----END PGP SIGNATURE-----

--nextPart6741472.lOV4Wx5bFT--




