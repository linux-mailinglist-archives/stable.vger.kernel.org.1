Return-Path: <stable+bounces-267120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2S7gBQroM2rfHwYAu9opvQ
	(envelope-from <stable+bounces-267120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:43:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 640236A023A
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:43:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=b1n.io header.s=key1 header.b=RbabBeY2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267120-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267120-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=b1n.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5F1303265E
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398313112A5;
	Thu, 18 Jun 2026 12:43:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1651AA1D2
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:43:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786621; cv=none; b=RDwkKzdGgkR+Yfv/bZp4u4CfgYvbEDZokvSW7vL7ynvjDvgN6acVfBpAGVfx0TDinNVkdJhhKdodVIaZUFFKjK3QPYK0wwv7I09Hxkalpo11+AuPrb8BlE3bVZqMISgZtVEvWEHApT2LD6M5EeuGoeUzeWEpMyOLSZHbUuGduMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786621; c=relaxed/simple;
	bh=0xOGb09rTuf9GPV/jBFAQS4RgTq69F7ydy3K5ixrwlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB9j7BZK04lN0I11l5bSUzGz7z8/FEfWnS9dtxpFuDkEE8bD7s7pyRvJtFxP6RlWpi5u256F/2OlssLTql4dSsfh4Qsk5CdElWQjWQv6scVOFbFfg643JNIEacq/j1CYKQhdwaOcPJNIyVslPYOT581t4/Bn6sSAeYpUsdVPq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=RbabBeY2; arc=none smtp.client-ip=91.218.175.189
Date: Thu, 18 Jun 2026 12:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781786607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xOGb09rTuf9GPV/jBFAQS4RgTq69F7ydy3K5ixrwlU=;
	b=RbabBeY29BJbtGj5OwkpJedKIOYaDFFaGYzGpQK0f2k03ZQGocbG215y8oplEfd5lZQJBM
	k8AYSdY1Bq8vAEx73lFgO+Fv397I0mtRS9VPlpjqAUYskIrz+bC3cb/AyLhtVHcZx8eKtv
	hIvyLqI7uX//fNdlzmWNLy6PE0RAsMugzAHkPE1cql6ycNgU6nMhkC2lccODAYRjfgnw50
	E4g+jICYXFws2Bw7ZFy2ho42d2PAfcKKZBgsYr9fwNofdAaGI8CaMgZqC9LA8+HJ31bG1d
	dhdwMnQSvQH9iq0JEaPS3q0JiqQjDy2mwgE3YvJRmfyT0ke9U2539qVAC0WENA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Xingquan Liu <b1n@b1n.io>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
Message-ID: <ajPndLsHz1-d76qj@fedora>
References: <20260616220303.31552-1-b1n@b1n.io>
 <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
 <CAM0EoMmXrZ5pUAkuVScgQjPFm3-dSC03mygDm3sAaFO=TQgvDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eb6zudvooesa7q7h"
Content-Disposition: inline
In-Reply-To: <CAM0EoMmXrZ5pUAkuVScgQjPFm3-dSC03mygDm3sAaFO=TQgvDw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[b1n.io,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[b1n.io:s=key1];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[b1n@b1n.io,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:stable@vger.kernel.org,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267120-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[b1n@b1n.io,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[b1n.io:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fedora:mid,b1n.io:dkim,b1n.io:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 640236A023A


--eb6zudvooesa7q7h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
MIME-Version: 1.0

On Wed, Jun 17, 2026 at 10:23:42AM -0400, Jamal Hadi Salim wrote:
> Do you know how to create a tdc test that will recreate this? If not
> either Victor or myself can help you create one.

Okay, I will try to create a tdc test.

--
Xingquan Liu

--eb6zudvooesa7q7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iPcEABYKAJ8WIQRK8k7aQ0rr/Uwki+E2I1LDHPWnXgUCajPn4ygUgAAAAAAVAApw
a2EtYWRkcmVzc0BnbnVwZy5vcmdiMW5AYjFuLmlvWBhodHRwczovL2tleXMub3Bl
bnBncC5vcmcvdmtzL3YxL2J5LWZpbmdlcnByaW50LzMwQUYxQUMwNzMwODkzRURD
MTQ5Qjc5NUIwMDc5QjEyRTZDOThFQTYACgkQNiNSwxz1p17bDgEAwV1mMS0uKtA8
Z6fej+nWAlg2wf7S5/FFoCsDEoT55EgBAOMa2bgvVTtqFJwQSIZ+YxMIcA1vn+Rv
o1FDHyabauYL
=85ev
-----END PGP SIGNATURE-----

--eb6zudvooesa7q7h--

