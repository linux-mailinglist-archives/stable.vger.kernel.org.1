Return-Path: <stable+bounces-217910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHESGdqanWnwQgQAu9opvQ
	(envelope-from <stable+bounces-217910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:34:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED218702C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853F8318081D
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A52395DAA;
	Tue, 24 Feb 2026 12:31:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24D37417A;
	Tue, 24 Feb 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936295; cv=none; b=geUh+NfsgQGDZp7ILGsex4ZFsdLjxOcx7+e5zYcGBXopi7/ATSzlKsLb3OTOgD3CwdXLT2izICS+MC1xqNkR8zsRnxqIcMZV8nEP+mFQZqB44+soWTPtZGkY5vTdi609vKp5Dep8wWzRLNClXAvmvrJoy+H3KrHvgaSQMVhh8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936295; c=relaxed/simple;
	bh=6X4d+FM70GZbM3qSklXp7wBJbDEltBSEINeL//XhXok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2RNt2s/wzjTB/yO6NkYnOwt+JIJnITFeQQSwelSzFxCXjLmQzqbnBEpP2OXmwomVC3b3xzy22Ri32oxjjTek/vs7ztM2eSDnpfDryhkj9kb3cwUedVUFlDVw223WhJ8lQwEN8If4pTFUuQM/baXQkT3I1u1SaOZ05hn/tniw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC1F2339;
	Tue, 24 Feb 2026 04:31:26 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD6553F62B;
	Tue, 24 Feb 2026 04:31:29 -0800 (PST)
Date: Tue, 24 Feb 2026 12:31:21 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/4] firmware: arm_scmi: Drop fake 'const' on scmi_handle
Message-ID: <aZ2aBD_u_RVhgsei@pluto>
References: <20260224-handle-not-const-v1-0-90bf93b53e27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-handle-not-const-v1-0-90bf93b53e27@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217910-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,baylibre.com,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cristian.marussi@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBED218702C
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:43:38AM +0100, Krzysztof Kozlowski wrote:
> Severale functions operating on the 'handle' pointer, like

Hi Krzysztof,

> scmi_handle_put() or scmi_xfer_raw_get(), are claiming it is a pointer
> to const thus they should not modify the handle.  In fact that's a false
> statement, because first thing these functions do is drop the cast to
> const with container_of:

Thanks for this first of all...

...but :D

... the SCMI stack attempts to follow a sort of layered design, so roughly
we have transport, core, protocols and finally SCMI Drivers.

Each of these layers has its own responsabilities and the aim was to
enforce some sort of isolation between these layers, OR even between
different disjoint features within the same layer, if it made sense,
like with the notification subsystem within the core...

Now, given that all of the above must be attained using our beloved C
language, such attempt to enforce isolation between such 'islands' with
different responsibilities is based on:

 - fully opaque pointers/handles...like the ph protocol handels within
   SCMI drivers...best way to do it..if you cannot even peek into an
   object you certainly cannot mess with it...

 - some 'constification' when passing around some nonm-opaque references
   across such boundaries

So, when you say that some of these functions sports a fake const
reference, is certainly true to some extent, BUT you miss the fact that
usually the const is meant to stop the CALLER from messing freely with
the handle and instead enforce the usage of a dedicated helper that sits
in another layer...

As an example, when you say that the scmi_protocol_handle *ph is indeed
manipulated by scmi_protocol_set_priv() and so it is NOT const, you are
certainly right, BUT the above function and the protocol handle itself
lives in the core, a different layer from the protocols, and indeed the
protocol_init function cannot change directly the protocol priv value
but instead has to pass through the helper ph->set_priv() which is the
only helper that can touch the ph content...
...IOW you are forced to respect the isolation boundary (as much as
possible) by the constification of ph...if you drop the const in the
protocol_init protoypes you end opening the stack to all sort of
cross-boundary manipulations annd hacks: helpers like set_priv were
added to be able to manipulate the bits that needed to be modifiable
while maintaining separation of resposibilities between latyers.

Similarly for notifications, they are kept isolated as much as possible
from the core.

So, I still have definitely to properly go through all of your
series, but while the usage of container_of_const() is certainly a
welcome addition, because it raises the isolation factor, dropping the
'fake' const seems to me a step back in the enforcement of isolation
boundaries between different layers or different subsystems within the
same layer.

IOW, the last that we want is to be able to freely change the content
of such const handles from outside the 'island' they live in...

Any improvement on such isolation with more modern C tricks, if
possible, is pretty much welcome, i.e. I am not saying that the current
system is perfect and not improvable...but just dropping all of this in
name of some better possible compilation optimization seems not worth in
terms of maintainability...

Does any of the above blabbing of mine makes sense :P ?

Thanks,
Cristian


