Return-Path: <stable+bounces-241900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEzyJIwb8mljnwEAu9opvQ
	(envelope-from <stable+bounces-241900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:54:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA749651A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8C13004253
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72AF329C66;
	Wed, 29 Apr 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o23adduu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F42727FD;
	Wed, 29 Apr 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474331; cv=none; b=cErV9uBH1FwRPH4/3X70wqLlyDNkhMpkG5n0kHZTDISuorBWB+vTGP/hdGtwq/h375LSUqewKYo8tSnUXY0Q2G8WBcCi9m3STcQNj1Ecn3du5Xt6gd8y/E0gEFgAkXnLEjahW6JPICXnO5LcX1KdTaWzu2uN0BD+lUN9r3M2LuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474331; c=relaxed/simple;
	bh=aRZ9Zlne/5aUbQXvGNjewxA024+sqHWPF2yMItjn92A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Q0vG8eaIXRZu0Uj8qyqyj7iKEA9DCoWjPBWK7A1PV6+ZG35jhJdROHQI08QjGr5C+4wsRko9bmQWSiIQBqT07tXkjAeLGxKdc6FH9YeThY/+9XVH+aFFHoTFnXmQS2hs2HPGh1jc+HleaBP0PKdRguV28hv7/i5QD3EdOn2Go2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o23adduu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F029EC19425;
	Wed, 29 Apr 2026 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474331;
	bh=aRZ9Zlne/5aUbQXvGNjewxA024+sqHWPF2yMItjn92A=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=o23adduuagYBfTSwKJra5OE2eZO58EDlZcmA4C8G1QMrMfnnyrtzMezFgrSniluJs
	 a84vz6FloT1jECCOXmp+5a56arcWSXh2pZe2cBEBGUcMEi/iRBM7XoxBdFc9fChJ/b
	 xBAnGpJsyNGQ9MiNa/QGXLPmmXI/O2NrRLu8z7FGjx6/g9qzQykbeTuP0gx0Ntn8vf
	 EkKrsmwDGIHxn44589WGj5WesEZ28rzR6QsJhBsJyHvGJ0xHdzsOCJMNxvTO9XPIHc
	 QccQ9HrNx6e15P2KX8W+uqD6ZQJrGqU4b7OCNTmev4GNMMzooue6MrqsyNfOcUl9hH
	 WT59nNI11jf1w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 16:52:08 +0200
Message-Id: <DI5Q29QMNVNH.1B2N4VBA2ZVQW@kernel.org>
Subject: Re: [PATCH] driver core: reject devices with unregistered buses
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427102852.2174-1-johan@kernel.org>
 <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
 <afHZWasOhRaeBCnt@hovoldconsulting.com>
 <DI5LDIQW45PE.LPIWCARJV7WC@kernel.org>
 <afHsgv9SUqfn-G1x@hovoldconsulting.com>
In-Reply-To: <afHsgv9SUqfn-G1x@hovoldconsulting.com>
X-Rspamd-Queue-Id: 5EDA749651A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

On Wed Apr 29, 2026 at 1:33 PM CEST, Johan Hovold wrote:
> It seems we have differing definitions of "bug", but to me this is
> clearly a bug in driver core.

I think we do -- you are saying it is a bug that the driver core does not p=
rint
a warning when a caller introduces a bug on its own due to an ordering
violation.

While it clearly is an improvement, I indeed do not consider this a bug.

