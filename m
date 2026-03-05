Return-Path: <stable+bounces-223287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFP2HxEZqmlfLAEAu9opvQ
	(envelope-from <stable+bounces-223287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 01:00:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E7F2199AE
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 01:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5DE308C2DA
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBE369991;
	Thu,  5 Mar 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lwCu2cUA"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC23352F85;
	Thu,  5 Mar 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755147; cv=none; b=bqOJAWzDJq7+3OD7QQnhNBuFYc9SRAutPJ/PFluC1VhmOV6dcsK1pthvjiiK8fNU60xF9eNToSSG+YWoZEKsmVfKy3gwm0DmPhL0N3Rok374YDEv3D21YJmJnRUHPXttk5pJzPpIs81RTtg4PipqR1WZ3TO2DSxuNqJF7NxaiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755147; c=relaxed/simple;
	bh=QLxo0RAKQmS1rfj80B0uElkCdb68NWudv6UOo2cnB70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8MGJaxJ7qlWyPwcPauAxoD8tcWPmNfXLKHozFcsXR8RwJbIuBcHqLLX5dY14PDVIyaVFp37vJJUwBFyqwiSfcc9nE5HRJne6bwXmGTjONj/LMPKwuHq0hVHoHNZjsChX0Z9yn9tDlL44HtaVFdS9e+a0gz5zeP4/oTi6nDLxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lwCu2cUA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1772755136;
	bh=dW8wX9XYzRgg5ooK55cx/kbvRIBTMsUrpkdIhlp63go=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lwCu2cUApnILjn5lUwF+4A30+pSRjuaqosHTfWvNw/U/dtoElTsyuqRwI8zGw8bja
	 yxAiVuEXbIBQ9nbeLDTp/DVxIT/yvZPubSVQDrwt1+dfEz76nQoHSS0Afcrm8Lzd54
	 0owCL/tPFcEZcsf1OmDPLYYY/1vhXIcfWOJJC6WnvZIArY6SLNV23uuggatAASJGDC
	 inbswKGoapPmqD4rk9aCPT38FYAqfn6+3790V5UcYmepEq1T9+J5QU48AMPdyYjLgW
	 8AzSNcKC1fhJ5m6DRcRc4A9TNMYRg+TRetzu1e3JoW/cxQ/VM5bj40DFkaLwG8213w
	 VG+zDD8PmHaiw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9F6CF6000D;
	Fri,  6 Mar 2026 07:58:54 +0800 (AWST)
Message-ID: <17790d338e59896ff843bbd3a3bf434f20b189c3.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: fix device leak on probe failure
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Johan Hovold <johan@kernel.org>, Matt Johnston
 <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 06 Mar 2026 07:58:54 +0800
In-Reply-To: <20260305104549.16110-1-johan@kernel.org>
References: <20260305104549.16110-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 23E7F2199AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223287-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi John,

> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
>=20
> This driver takes a reference to the USB device during probe but does
> not to release it on probe failures.
>=20
> Drop the redundant device reference to fix the leak, reduce cargo
> culting, make it easier to spot drivers where an extra reference is
> needed, and reduce the risk of further memory leaks.

Sounds good, but I would suggest syncing with Greg K-H too; he's in the
process of doing a v2 for the same thing:

  https://lore.kernel.org/netdev/2026022539-punch-supper-884c@gregkh/

Given the discussion there, this looks in-line with the longer-term move
from usb_get_dev(), so:

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Thanks,


Jeremy

