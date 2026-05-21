Return-Path: <stable+bounces-253612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCRyI142D2qSHgYAu9opvQ
	(envelope-from <stable+bounces-253612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22E5A9856
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8A3331B968
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED63355F2A;
	Thu, 21 May 2026 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7qN6/Ao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86A33A6E2;
	Thu, 21 May 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378474; cv=none; b=D8aXAmbehhjDULt+wcCEu3o0AxXVIYl7RTCOSbR6Bts4J/hyaLag2SyXcdRkFX/kYkyIa4MSaJa7JPjuAmIueElQBOJQvLdolNIZC8ZxtAavZfBmfCytJCIblWzRcX5XjLuZeak0rL14/oIjp48D4g751qFJtmm2hG6dVcG4Y/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378474; c=relaxed/simple;
	bh=kdxdsCTJYPFCPL15txwu8YZWu+pnj+zc9d+hgV7hYv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFDL6FO+f3rACnSJec/LWDvk5Bc7ZD6tOQHoIUBAQ9p/Wwbe0Nw+dZueYg6UWV+GDGrBanUh4d06zobSiHN73bSnRpNBBflz6k29jMrAUC9PJEQr+NN46/sGsoucPwTs/N7oWzJ+YOyNGbS84FR6A16qRKrzB9Ol0VowQZH0xW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7qN6/Ao; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E7C1F000E9;
	Thu, 21 May 2026 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378472;
	bh=UknqHVJPQzhmFNL32MPkIe/DCfPCA9va+n4v13KmBwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F7qN6/Ao0uZisBlQB2pr58NxM+wA5aueDDK+kFKJgBNU4JIcy7uDURb1ZgcuXdzR0
	 +Lrf6hnSKk7VFQD9uCRl8Z6ag6wiSIge60Fr2Lq2abq4VB0vfBkSWGLPQsD8cC3XVV
	 OPIcdzodEaau/sGoX062zkiL5QZaGn9+bkbeCnsjERyKypguzFLNxZzvCcdyd3wZXm
	 rfCCYKC/cXX4FtnMuLm+BTbAQcOCZo3hBuDi+JIv9Rk/PhX/1mP8qr9uM0gslEdgKM
	 6W7ixusivG2nGzwhBBqIw2eFb1PYbyVuRNFZBlYInWYODyOrOs5YCOoAupTxdksEmC
	 CWWqmtX5Fqapg==
Date: Thu, 21 May 2026 17:47:48 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: Fix OOB write in
 wacom_hid_set_device_mode()
Message-ID: <ag8ozWBDSDckicSS@beelink>
References: <20260513075935.1715836-1-lee@kernel.org>
 <CAF8JNhKTMpT3CGq_oDqaGVygqXK0jjvrvjxbAWUerqtWzdB9+Q@mail.gmail.com>
 <20260519111354.GT305027@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519111354.GT305027@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wacom.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wacom.com:email]
X-Rspamd-Queue-Id: 1E22E5A9856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 19 2026, Lee Jones wrote:
> On Wed, 13 May 2026, Ping Cheng wrote:
> 
> > On Wed, May 13, 2026 at 1:05 AM Lee Jones <lee@kernel.org> wrote:
> > >
> > > wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
> > > usage is always located in the first field (field[0]) of the feature report.
> > > However, a device can specify HID_DG_INPUTMODE in a different field.
> > >
> > > If HID_DG_INPUTMODE is in a field other than the first one and the first
> > > field has a report_count smaller than the usage_index of HID_DG_INPUTMODE,
> > > this leads to an out-of-bounds write to r->field[0]->value.
> > >
> > > Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
> > > hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
> > > this stored field index to access the correct field and add bounds
> > > checks to ensure both the field index and the value index are within
> > > valid ranges before writing.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID generic handling")
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > 
> > Patch looks sensible to me. Thank you for your effort, Lee!
> > 
> > Tested-by: Ping Cheng <ping.cheng@wacom.com>
> > Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
> 
> Thank you Ping, I appreciate your review.
> 
> HID folks - any movement on this please?
> 

I wanted to apply it today, but the patch conflicts with our current
for-7.1/upstream-fixes.

Could you rebase on top of this branch so we can take this without me
messing with your patch?

Cheers,
Benjamin

