Return-Path: <stable+bounces-241762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKULFtwF8WnhbwEAu9opvQ
	(envelope-from <stable+bounces-241762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:09:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7948B083
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB7AA301D6B7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E537C114;
	Tue, 28 Apr 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9YdESbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8AB254AFF;
	Tue, 28 Apr 2026 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403347; cv=none; b=cwl5ydFASpgj72AkC2c/jERfjNfbyBkHKZWKizE1aEmHYXUOjv/KeI1Kdd7BzVhNgtVdCRffnVl0Yw4R0Zm5pIxdTMZxlXmGtAEyrg5V+rUmVrWRziGgzs7uOJX8o3CPc3GcAoejhTB6XynJIVZCoNMHAPo5y8JXhHyc+2xQ4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403347; c=relaxed/simple;
	bh=ocJvvASwHJXGqul5EgVMznwfHwqEfsA0HFGUJW80Gbo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BaSjVeECmSf4nplo15ozfINc7TXyCxLJ1GZTovOMdTlOtf/NlgCL7a/GTtTCf7TBrgcAwD6tEEfS5+p1DzHA1FI66Q2Fs2mqYOTtQcfAxDMxuJXH+wt/OkwvBFbpt5N084iX2A6NkQkfXBPMIhyYPYSLD1IfbeXHWt5jH3g9RxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9YdESbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3B1C2BCAF;
	Tue, 28 Apr 2026 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777403347;
	bh=ocJvvASwHJXGqul5EgVMznwfHwqEfsA0HFGUJW80Gbo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=J9YdESbZ8b+YWTUZVJ53AXLW+iid7Zo9EUOeH4lFEPaiCtFI4pdmx/Vt7XTl6z4Ur
	 8tFs8+ozDNaVQkZQyobWuh8qILBC6mk931e2uKV9XvyupSu+3agFdKnn5GGtalrWdr
	 S0MG65LNK5u+dkpR2r53VI1/cDwVGFkVkvolXpuo3AJwhsstgRr+Umhs7CC27h1ZiV
	 6nR67VmX7tlkzhMdyH+hpSqrdZrRbT6j3PLGm7FEwmFDqT99706+Im1A4IxMV6TVKv
	 0ZTvjIdIu1icYbQYuQTbLoIKoCQrKkoXolByum5yC8BT5q2MPpF7q/UEo2D36EZtsq
	 CpO2TZKKrbHwA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 21:09:04 +0200
Message-Id: <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
Subject: Re: [PATCH] driver core: reject devices with unregistered buses
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427102852.2174-1-johan@kernel.org>
In-Reply-To: <20260427102852.2174-1-johan@kernel.org>
X-Rspamd-Queue-Id: E2C7948B083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241762-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon Apr 27, 2026 at 12:28 PM CEST, Johan Hovold wrote:
> Trying to register a device on a bus which has not yet been registered
> used to trigger a NULL-pointer dereference, but since the const bus
> structure rework registration instead succeeds without the device being
> added to the bus.
>
> Reject devices with unregistered buses to catch any callers that get
> the ordering wrong and to handle bus registration failures more
> gracefully.
>
> Fixes: 5221b82d46f2 ("driver core: bus: bus_add/probe/remove_device() cle=
anups")
> Cc: stable@vger.kernel.org	# 6.3

Hm...this sounds like hardening and not like a "real" bug fix. Do you have =
a
specific reason why you added Cc: stable?

