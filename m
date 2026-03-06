Return-Path: <stable+bounces-223293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPwPK58sqmlaMgEAu9opvQ
	(envelope-from <stable+bounces-223293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 02:23:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BB21A38C
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 02:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97734302D5A4
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 01:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503C315D49;
	Fri,  6 Mar 2026 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ETwNKXBN"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F02D2382;
	Fri,  6 Mar 2026 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760218; cv=none; b=p4/XVXb1UdOpowmjWwJPx+UMmscoCPzPy9H4caUlBoASDiW1w5F9n9j+xrsjfAMMJsIsxNT11Pgmi5jz7g97T87daLMIJw6S9LRYxITKNpcwEOyogXrTnqqn17YVxsPp0BE7DzGyBDPAeVcydHmf5JDh4PMlOShJVM9uuWOFJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760218; c=relaxed/simple;
	bh=+fSwAeJfOqryePzovwrmZyRsfwlXOidTguMWiwStvKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPUqxx4cUJHDAv9bJBEU1O/I4y0vb3X5vOFcrBJmuYKD03S9DbYcRtHAfrfje++ouTDvSgzprq9rfNqd3oEyjT1XHAwS96ufZ/26w1gJB/A7kRHiAZPZKS1CCydRkau2iKaL695P4o9XtrsqTJOiA1kquGRIBbDh+IhDUNbKe1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ETwNKXBN; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1772760214;
	bh=+fSwAeJfOqryePzovwrmZyRsfwlXOidTguMWiwStvKU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ETwNKXBNhlmJbKU37O3g2oWZFNizciG17L3YoAVy/tMzJJpQ/8ZJVwYf52EZqnh7H
	 DHduc5VFWbCXdlKe9dV3nrc2m8+Js4FEI1aJNtNZq4Q+JgOMtb6z9lUjPvQn0labW1
	 pT/7Daa7h5n6ts+v/oMJw7oiZsBBroAxlrFZbcsGavjQcYy60PuPldI9OEsYfrolLV
	 JHQ8ggZqHuj9ejS4nWHloZQ5+sOMe1d65maS6vp9UipXTpeccO1D+ZaKcsQn3t5iaL
	 Wk5xS3MCOeG2FE4yeMm/xsont6D1Jx7oYI7nISlyNx7hFvYF+4txtQFyJPQ7VCpVsa
	 VFickH4S4V40Q==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 307FC6000D;
	Fri,  6 Mar 2026 09:23:33 +0800 (AWST)
Message-ID: <942e3fdf0522be797a337669b9a736b56c33e5d2.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: fix device leak on probe failure
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Johan Hovold <johan@kernel.org>, Matt Johnston
 <matt@codeconstruct.com.au>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 06 Mar 2026 09:23:33 +0800
In-Reply-To: <17790d338e59896ff843bbd3a3bf434f20b189c3.camel@codeconstruct.com.au>
References: <20260305104549.16110-1-johan@kernel.org>
	 <17790d338e59896ff843bbd3a3bf434f20b189c3.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6D0BB21A38C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223293-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

+CC Greg

Context is Johan's patch at
https://lore.kernel.org/netdev/20260305104549.16110-1-johan@kernel.org/

Cheers,


Jeremy

> Hi John,
>=20
> > Driver core holds a reference to the USB interface and its parent USB
> > device while the interface is bound to a driver and there is no need to
> > take additional references unless the structures are needed after
> > disconnect.
> >=20
> > This driver takes a reference to the USB device during probe but does
> > not to release it on probe failures.
> >=20
> > Drop the redundant device reference to fix the leak, reduce cargo
> > culting, make it easier to spot drivers where an extra reference is
> > needed, and reduce the risk of further memory leaks.
>=20
> Sounds good, but I would suggest syncing with Greg K-H too; he's in the
> process of doing a v2 for the same thing:
>=20
> =C2=A0 https://lore.kernel.org/netdev/2026022539-punch-supper-884c@gregkh=
/
>=20
> Given the discussion there, this looks in-line with the longer-term move
> from usb_get_dev(), so:
>=20
> Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
>=20
> Thanks,
>=20
>=20
> Jeremy


