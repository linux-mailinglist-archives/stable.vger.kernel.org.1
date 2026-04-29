Return-Path: <stable+bounces-241866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC/PN43n8WlZlAEAu9opvQ
	(envelope-from <stable+bounces-241866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:12:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2D4935DF
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A493029E42
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41339A7FE;
	Wed, 29 Apr 2026 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUsXX4pp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DA367F23;
	Wed, 29 Apr 2026 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461108; cv=none; b=tcIYxtSClnYDPH3s9J4INlxTjx4QTwffK4YbAwZ56RAZPzIqPiHilKFP9RM1cakZatFdatwz9xNhtMFz/Obmeo+OYAgBrqVW6HZg2hKNEg+Awq1WFJCRFQO/fFlz+AhykxKOFgxxXnE2C2G1Oi40Pp7k4XYE8XiRtBeqxvxv4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461108; c=relaxed/simple;
	bh=syOXPPeZen3ifAWWngoKt0dD5VvYsSa/znr9tGMdl/4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ToUXYpEG3JFf8nLwXZyUZRlZHkwDCqJc+sgyNrw2D4VSNA5E2CznlS1C0KAOHlfkwklNRbSZquJqHzwGElHC6g8CywimHYAmzsyRYLvcEowSlOYp5HIRetBy9gtyJd4HPIDYMhX9DFakCAzrRSg5sopBVjobXJOeNMf5PoLoC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUsXX4pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2938EC2BCC4;
	Wed, 29 Apr 2026 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777461107;
	bh=syOXPPeZen3ifAWWngoKt0dD5VvYsSa/znr9tGMdl/4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cUsXX4ppZ6leE+BuPDsK9XgvhkMk4fef9UCEaBKFQzGu9cSuaYGty7av6Loxms6uw
	 EktHjTzrV3PT6DRJFemlNR8EVj1AC36muvng+lPEKx3HmZZxvP//6OpBuOLRuOc4nY
	 obUTgsxLFXMtn1mrXOGmjrQWD1s6x+8cVH1nkVNGUAmxLMYkDstXACPEfTbbIYnTsE
	 x5AHYiu6bI5ohpKh8WaoyMRVo4Ia/kV6ArCv1Oj18YrozFoPjpYWJZwiKTUZk31rjl
	 CBVongUUEVQ/ce20B/WJY/gSWhhPCljQWAvvL8F95M6j7Iw52Rldn9+BOrE4NY+5Of
	 L83bFZIouUaeA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:11:44 +0200
Message-Id: <DI5LDIQW45PE.LPIWCARJV7WC@kernel.org>
Subject: Re: [PATCH] driver core: reject devices with unregistered buses
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427102852.2174-1-johan@kernel.org>
 <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
 <afHZWasOhRaeBCnt@hovoldconsulting.com>
In-Reply-To: <afHZWasOhRaeBCnt@hovoldconsulting.com>
X-Rspamd-Queue-Id: 62A2D4935DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241866-lists,stable=lfdr.de];
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

On Wed Apr 29, 2026 at 12:11 PM CEST, Johan Hovold wrote:
> On Tue, Apr 28, 2026 at 09:09:04PM +0200, Danilo Krummrich wrote:
>> On Mon Apr 27, 2026 at 12:28 PM CEST, Johan Hovold wrote:
>> > Trying to register a device on a bus which has not yet been registered
>> > used to trigger a NULL-pointer dereference, but since the const bus
>> > structure rework registration instead succeeds without the device bein=
g
>> > added to the bus.
>> >
>> > Reject devices with unregistered buses to catch any callers that get
>> > the ordering wrong and to handle bus registration failures more
>> > gracefully.
>> >
>> > Fixes: 5221b82d46f2 ("driver core: bus: bus_add/probe/remove_device() =
cleanups")
>> > Cc: stable@vger.kernel.org	# 6.3
>>=20
>> Hm...this sounds like hardening and not like a "real" bug fix. Do you ha=
ve a
>> specific reason why you added Cc: stable?
>
> It's certainly a bug fix and this change in behaviour was clearly
> unintended.
>
> Any caller getting the ordering wrong would now succeed in registering
> devices, but no driver would ever be bound which is harder to detect
> than the earlier crashes.=20
>
> Whether any offenders have snuck in since 6.3 I don't know, but I still
> think this warrants a backport.

I see where you are coming from, and I agree that having an explicit error =
print
is an improvement over "the device just never got probed".

However, this isn't an actual bug -- it just happens to make a "real" bug l=
ess
obvious to catch.

That said, I don't see how this warrants a stable backport, i.e. it doesn't=
 even
fall under the "this could be a problem" or "theoretical bug" category, whi=
ch
typically are not accepted either.

As mentioned in the other thread, if this was relaxed, I'm happy to hear ab=
out
it.

