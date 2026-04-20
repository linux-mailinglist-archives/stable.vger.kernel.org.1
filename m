Return-Path: <stable+bounces-238697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPgDEtu+5Wl3ngEAu9opvQ
	(envelope-from <stable+bounces-238697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:51:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEDA426F4F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8852B300A607
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D63148C9;
	Mon, 20 Apr 2026 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RUr0v7VJ"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557113C9C4;
	Mon, 20 Apr 2026 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664276; cv=none; b=qAHfarpKSPW4mewekYYrPry1dQOnBxLqWOdZU3c5YBfnX8HgJBaQb54uCOwhiwXdtPNXPEsQF8Z0/gBpmMz2eAke9SssbeKOR5h8sNtSFwya32u99Bi/rNq5grROuPqY+YvrzVe1G8Z0zoB6uqcw16f6SYtc/2InJi3cFck4188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664276; c=relaxed/simple;
	bh=mM7nrILypJTY/P85KRkTSJEidfXBiMKGe3fl6hBpgDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2bhApxKqfO7r69nLC6Ir3iG6jBCA1vC8F+Z1bET8B9AEqqjzy4gU3D251w25i8r/RKRC1Hula/wZTjkl1+FIsMk0DP8yzqD2/2uGtqujhl2jA8j8u/bLx79HEEmMbUflRbHsSgn3I2i24blpISncYXnWYTIocYr1kFJoVo2vT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RUr0v7VJ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1776663668;
	bh=mM7nrILypJTY/P85KRkTSJEidfXBiMKGe3fl6hBpgDo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RUr0v7VJXDXoYgkx7NeicB35aKbqQvj9LNIyZvRG9rXeOvSsxd69YogVaEt5ZhDuU
	 xs0WftUvmsDUMFDDtfHiR0FSbgtzRXHUM5LtAOXvKyouqdSU4o92GMnVbALnOq29Pa
	 e3DsTrQKpYipTlsoiS/8fkLqk4RurZ0/8Tl220/o6Oj9DMJcwsnAXufnGhuHnjbGNY
	 RCgA5TSbuULu/Kq++em+gb+xu80thZcR440tb0zQZCtGdMD1iRl0Q6If/t67VHdMbd
	 +oSLU/ntWeg629g9DXlFc4Y8P/x5kiaUTK7YTw05SorAVHCH1+QAdpAOh6rbbMCQ+x
	 kb0M+R25trwIQ==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9FC4260C8D;
	Mon, 20 Apr 2026 13:41:07 +0800 (AWST)
Message-ID: <28119a94e183d695389f51282d48580adc7703b4.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: fix don't require received header
 reserved bits to be zero
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: wit_yuan <yuanzhaoming901030@126.com>
Cc: yuanzm2@lenovo.com, matt@codeconstruct.com.au, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 20 Apr 2026 13:41:07 +0800
In-Reply-To: <20260417141340.5306-1-yuanzhaoming901030@126.com>
References: <20260417141340.5306-1-yuanzhaoming901030@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238697-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[126.com];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FEDA426F4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> From the MCTP Base specification (DSP0236 v1.2.1), the first byte of
> the MCTP header contains a 4 bit reserved field, and 4 bit version.
>=20
> On our current receive path, we require those 4 reserved bits to be
> zero, but the 9500-8i card is non-conformant, and may set these
> reserved bits.
>=20
> DSP0236 states that the reserved bits must be written as zero, and
> ignored when read. While the device might not conform to the former,
> we should accept these message to conform to the latter.
>=20
> Relax our check on the MCTP version byte to allow non-zero bits in the
> reserved field.
>=20
> Fixes: 889b7da23abf ("mctp: Add initial routing framework")
> Signed-off-by: Yuan Zhaoming <yuanzm2@lenovo.com>

Looks good, thanks for the contribution!

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

