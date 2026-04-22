Return-Path: <stable+bounces-240285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ME8Jq9y6GlCKgIAu9opvQ
	(envelope-from <stable+bounces-240285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:03:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09458442B61
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA54300CBDF
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE93537F2;
	Wed, 22 Apr 2026 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wJX1KPQc"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065C23D7E3;
	Wed, 22 Apr 2026 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841388; cv=none; b=U5tcrG5l5CqCz842LQ+9vceXDu8uC4W0rRH21tGDi16uUV9Pdyib5WIY2TrLt/xSTldDzu8+astZFAJfKBFhoDQVdPHNKxXr4UOGxmB155wsj9ZS4i1fo85tXUX/ShNwnuA2gwJHkoJXKsJVTLRGgDQfJiBmV7xs6mmv+dZ71+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841388; c=relaxed/simple;
	bh=souXIlQv8+iFw9zCxKwZUGD1h7PhrwEDbv7Rj5/8daE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiLpIRKBcgT3DRGYG7PRD7VFWFId1/dgxliOaOB/cya4oQbwmeiLzbXesvweRgJgui9m8CRT4jOMBL+6cmzfISTJxvzlyBcJ6cu+S6DoOulcYyY6LoUvTmrVrIgp2KqJ8rOdpUh1cT1W0K4TU9WuQ0qlkbAhcv4fepjmCEPDinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wJX1KPQc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YHNRGC1hGWc6m3ZzcDaW9en/CqZpzjUfDH3bqt0lyZw=;
	t=1776841386; x=1778050986; b=wJX1KPQc6S5TmpHv74CjYS8ePA1kWs2754l/HFA8cNMxh+/
	t2IJLZaDzfXl4m7uUUiGhFvmB0HZRxIn+bayT+rl58kKcQA+i9vWYCHPROwENAPbqozqjSMZbzr3C
	sJSQSR4XmDVGhzYM2Yl67UgnIKc/R9ubqJbEwXvxp5IvaoG5d4WqsVeBz2sB/Zs7Kjb7DrqvWzog3
	2K7qLYpUdhQ1ne9nERw3IwuK+Q6eqp8O2N5PcCUpWSCO8MjbYZ5BPeHwz0tavEtUyQA+meSDW70Ua
	dFMWnKOzMXmKuF3GkYK23cauUwdyWBJhAZQvbWljqbZ09NRCUcscEah/u4uQHaMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFRbx-000000067S7-1ywB;
	Wed, 22 Apr 2026 09:03:01 +0200
Message-ID: <2fd57f98e3149ba56c83994a9181e92a0104cfe3.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: fix NULL pointer derefs in queue-less
 transports
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 22 Apr 2026 09:03:00 +0200
In-Reply-To: <20260410203028.3717914-1-michael.bommarito@gmail.com>
References: <20260410203028.3717914-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,nod.at,cambridgegreys.com];
	TAGGED_FROM(0.00)[bounces-240285-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 09458442B61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry, I didn't pay much attention to this before...

On Fri, 2026-04-10 at 16:30 -0400, Michael Bommarito wrote:
> TAP transport sets neither VECTOR_RX nor VECTOR_TX, so
> vector_net_open() never allocates rx_queue or tx_queue.  HYBRID sets
> VECTOR_RX but not VECTOR_TX, so tx_queue is NULL there too.
>=20
> vector_reset_stats(), vector_poll(), vector_get_ethtool_stats(), and
> vector_get_ringparam() unconditionally deref these queue pointers,
> causing a NULL pointer crash on SMP or with any lock debugging option.
>=20
> Guard all queue pointer accesses with NULL checks.

I see how that fixes the crash, but maybe you could write a few words on
why it's still correct?

> -	spin_lock(&vp->tx_queue->head_lock);
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_lock(&vp->tx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>  	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));

I could imagine for example this memcpy() observing a torn write or
something like that and getting strange results out?

Or is that just not a thing because UML is (still) mostly non-SMP?


Also I think there are related issues that wouldn't show up for a broken
configuration, such as if create_queue() fails to allocate memory and we
get an inconsistency between tx_queue / rx_queue pointers and VECTOR_TX
/ VECTOR_RX flags? Though I'll admit that seems highly unlikely.

johannes

