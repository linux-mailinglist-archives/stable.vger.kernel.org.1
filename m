Return-Path: <stable+bounces-271580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KUzpGXzqRmrlfQsAu9opvQ
	(envelope-from <stable+bounces-271580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 00:47:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61956FD4A1
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 00:47:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mLdlgw89;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271580-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271580-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01E730AEDA5
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 22:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE203C584D;
	Thu,  2 Jul 2026 22:42:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707ED335067
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 22:42:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032157; cv=none; b=ZAKXZcTmVpD/x/WKQ4B08eTiH9Kkcw41RUx/4SoBLTU6XibITkUzeXhpztjTcm7qUshg9oiiyoSdTZB2yD9u9JD2/7rQycl7vQLR/ZQyGZ6H4CBlcrqR8xf4EV0uzH7PchkVTbw07ItwiT0FlSMXTHz+YOYfCCMbbV4gu2+dXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032157; c=relaxed/simple;
	bh=6G79Ji4NeuIWF2cos93QCaEoIu/4Cufc86YF2qkp2EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZSVne5LH8slFNppqPUQvIxHwZQI+4izSHNWblnmXrVjsF4OBql6xN/gwwSB6DID+iRjFG7krj16vPVli5axWy0ZdhAHe/4MSJaidREFnSD8dW8Nj7mLX15qs9io9hUjgu+8bCOM3/uiLRE0enUZlUFNi6FDeZ83SRf5B74X/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLdlgw89; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F01E1F000E9;
	Thu,  2 Jul 2026 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783032154;
	bh=dIKDS9HR4plaqfzTOZAq9jlTWr8EKXEJ+e+Ebx1Sl20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mLdlgw894RGEARbP33M8zU3zE0z8ip1NOFMJaG0z1/gYKi6nDV1vc63fUiwDh8nR5
	 avX3NhcA/muecyI1W4qD29xo5nSlKn79zf0Vf6pQuvffG/CySylhcL8GGJ/GsCts9a
	 TJ/GDfq4EVa6wnw7cAnDWiC820lu+2yVFzxvZ8XxCclCKV2ZxkxmOa+RvQWdRGBuSU
	 Yw19lqn/fQVDtPXJ5WGkLTQB1zSSaW86yuI4VBvKpHgzbZehZWWzwf/tgkmYKkgB0/
	 VyzTEoZ7py09e7Xl8UFTbdqKnnN+sexMqIMUQE0QbkSgvFZLzAB34B0cOKbOSf+qCf
	 1EtRU3V+RkHjA==
Date: Thu, 2 Jul 2026 15:42:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y] fscrypt: Fix key setup in edge case with multiple
 data unit sizes
Message-ID: <20260702224229.GA116181@quark>
References: <2026070242-action-undermine-e5ce@gregkh>
 <20260702222323.3702129-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702222323.3702129-1-sashal@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271580-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B61956FD4A1

On Thu, Jul 02, 2026 at 06:23:23PM -0400, Sasha Levin wrote:
> [ added explicit GFP_KERNEL argument to kzalloc_obj() since the 6.18 macro lacks the variadic default-gfp form ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

At this point I just have to nack any patch that isn't Cc'ed to the
subsystem mailing list and isn't a clean cherry-pick.  I always mention
to include the mailing list, but clearly that's not working, as I just
get ignored.

Nacked-by: Eric Biggers <ebiggers@kernel.org>

It would also be a good idea to make k[mz]alloc_obj() on 6.18 have the
same behavior as on mainline, as every patch using those is going to
have the same issue.

- Eric

