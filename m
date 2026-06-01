Return-Path: <stable+bounces-259487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNQ4FWtRHWpfYwkAu9opvQ
	(envelope-from <stable+bounces-259487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:31:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBEB61C76B
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9DA3046EAD
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 09:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1D38E8BD;
	Mon,  1 Jun 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1OF9x3u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dStm3Rbp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2638F24B
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305870; cv=none; b=spuMUzUAYU7iudu6OITC665w0YwyZmLj8Ac6mlPvN/hbbas3oUJm6zH3Yrum4rg6dNVSu+4B8H5/WEQpD0PCTq9hiuh6pJyrkPRXG5WMjaABuEaIfAw6eGT4HFBfbLpa4HmB0mlVztdwlMczmD79e2mRkrbNp298zv9juIXCE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305870; c=relaxed/simple;
	bh=4BC84247A2oiYLOV8M1HSjItie/dGQEWBf26XC0hyHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRM9tuJvGubY0/yf88i/hlDl4mt1sDkkFralpAhvUbq7vW4L/xM3KZA+CWK02elNdbwVJEO6Fp/YDLkKJdqZGvDM0BBNhbAl/Ek23+d77wO4WB33UdIGRw3J6Fjk1NubewuimofH8JiBOQxfxDeGzcKc7HMw0nmntowIyg3u+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1OF9x3u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dStm3Rbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 1 Jun 2026 11:24:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780305867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BC84247A2oiYLOV8M1HSjItie/dGQEWBf26XC0hyHU=;
	b=w1OF9x3u2mnFYdqfxGcFj5M8wSP3fyhvQVz+Fcr3UPRhELu4zkhtXtbO+aqZzP+fyH8mgv
	+/rv/bSVqhU89uxVtE5+X7sZ3X9hJ4W3jAM6vqcIN3Jd5HvSMTCgnEI7wF60KXm4B711mB
	ByHvido/zLo7E0oVfZglDoQM70HkpL7qlMVLiq98c0Y03m6mGYC2PLOW/gwBxz68YRkwNe
	hjLqz9Z18R9Jr+M1C3zuGxos4Nh68Ankzhh/pLXmMw5FhW0BqH9f23Ea0MhbR9pxBbPllT
	O/5mM89pIxrWeiGrEnSXY+kV6iYnpYIGHUeq8JADvu2BLaVATIgSYj+VTpAV7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780305867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BC84247A2oiYLOV8M1HSjItie/dGQEWBf26XC0hyHU=;
	b=dStm3RbpWx/Ch6RxX27MoZRYTQ13K0WcZi7KDIFIJbOu1seXRDSmgRtJmqjNqiMKFkvNRC
	7PDxsHbDVLj9EzDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v6.12-stable 00/14] Backport: arm64: debug: remove hook
 registration, split exception entry
Message-ID: <20260601092426.zQYkhBOD@linutronix.de>
References: <20260528144825.850351-1-bigeasy@linutronix.de>
 <48316697-6c3b-465c-a49a-d2adb749d459@arm.com>
 <a328aaa6-0e34-4dfc-b4ab-0193e8bca6ee@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a328aaa6-0e34-4dfc-b4ab-0193e8bca6ee@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259487-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: ADBEB61C76B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-29 18:05:27 [+0100], Ada Couprie Diaz wrote:
> Given the conflicts do not seem to have required significant code changes,
> I don't know how useful it is but it all looks good to me ; conditional on
> pulling
> the EL0 soft-step fix for pseudo-NMIs with the backport.
>=20
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>=20
> Thanks again for backporting the series !

Should have tested commits against a fixes tag=E2=80=A6
Thank you for the review (and the patches in the first place).

> Kind regards,
> Ada

Sebastian

