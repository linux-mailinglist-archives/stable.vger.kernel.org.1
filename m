Return-Path: <stable+bounces-241861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHZ8D+Th8WlZlAEAu9opvQ
	(envelope-from <stable+bounces-241861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:48:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72AF4931E3
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55CBA302B52C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0E3EDAC1;
	Wed, 29 Apr 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4hqbvrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E46395259;
	Wed, 29 Apr 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459676; cv=none; b=jBScf3DMVrJrvarnm+oJGAHoIC4GIWI5jBW/GshIu+rtTDXwv8K+8J8f4K2bl/J48hF/9vpwF/0bO4WS3ycYwk7bwBpdYtrB90VTJsFzjv6wtqfZ0bIGnwU/+PDPAHrU5Qu91DBsYJH/gPyRiWSKC85EdZYrHVglLQtY/HQ6C8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459676; c=relaxed/simple;
	bh=X+w6vGL9UcSBBtEBgWjdNzRjgxSfzHSWQ0Um7fNEPwY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BTT1wtp6UQlzuYbEArZtxzc6BxD21KE8Va/lU0BcGYLi69voq9kM6EMa900PNn3Uv3x+40Hti0kR89SLnQpo/1oWgDHIrshkTmLjos4/wfnRSzSmD7fBTtAVCrVFIVNjt90FSDKtmBoeGmUDUIaGfxpqmhRxEqam82vMzutCGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4hqbvrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E6AC19425;
	Wed, 29 Apr 2026 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459676;
	bh=X+w6vGL9UcSBBtEBgWjdNzRjgxSfzHSWQ0Um7fNEPwY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=C4hqbvrE1np0XBYEtblqBrQ/iPhQqCDc46Ik8w/bPpkaFeN4scK1hjgEznhy5/HoN
	 sNI6WvCE9JbsBP2bxKW7UeHxQ0fdO2CugEO8M/RJiRHWN3W1ll58hSBprdeIcl/5S0
	 JD2hXN8om7lay4BoeAOC3hdXa8eucNKzaH3qbmM5XMTLr8/s8Q/B45RVAhQmq3pBdb
	 E/RdveKSliXNQuarV1j2f/eLh6/aJhOcsd9KlqZyMqG7ec5beJPq4k1xsWuvN+n1id
	 64LAU72tdC960TIrHYFGdNDDHiEbhpYz7jjrEJSWNXUfQIruFHL/2fr4dqYcQQUiCz
	 sou25ewdZYVAw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 12:47:53 +0200
Message-Id: <DI5KV97TNS9D.28EQTYL46PKT1@kernel.org>
Subject: Re: [PATCH v2 1/2] driver core: faux: fix root device registration
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260424153127.2647405-1-johan@kernel.org>
 <20260424153127.2647405-2-johan@kernel.org>
 <DI54XY4CNFCD.30M3UJGK1M3BE@kernel.org>
 <afHapCZz5C42euaD@hovoldconsulting.com>
In-Reply-To: <afHapCZz5C42euaD@hovoldconsulting.com>
X-Rspamd-Queue-Id: D72AF4931E3
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241861-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed Apr 29, 2026 at 12:17 PM CEST, Johan Hovold wrote:
> On Wed, Apr 29, 2026 at 12:19:06AM +0200, Danilo Krummrich wrote:
>> On Fri Apr 24, 2026 at 5:31 PM CEST, Johan Hovold wrote:
>> > A recent change made the faux bus root device be allocated dynamically
>> > but failed to provide a release function to free the memory when the
>> > last reference is dropped (on theoretical failure to register the devi=
ce
>> > or bus).
>> >
>> > Fix this by using root_device_register() instead of open coding.
>> >
>> > Also add the missing sanity check when registering faux devices to avo=
id
>> > use-after-free if the bus failed to register (which would previously
>> > have triggered a bunch of use-after-free warnings).
>> >
>> > Fixes: 61b76d07d2b4 ("driver core: faux: stop using static struct devi=
ce")
>> > Cc: stable@vger.kernel.org	# 7.0
>>=20
>> I think this is more of a theoretical issue, do we need this in stable t=
rees?
>
> Sure, this is borderline, but given that autosel would probably pick it
> up anyway we might as well mark it directly.

In such a case developers should probably give the stable team a hint that =
the
patch in question does not need backporting.

But using the expectation that autosel may pick it up as a justification to=
 mark
it for stable in the first place seems wrong.

The stable documentation [1] is very clear that theoretical issues must not=
 be
backported into stable trees unless an explanation of how the bug can be
exploited can be provided.

If that was relaxed in some way, it probably needs updating.

[1] https://docs.kernel.org/process/stable-kernel-rules.html#everything-you=
-ever-wanted-to-know-about-linux-stable-releases

