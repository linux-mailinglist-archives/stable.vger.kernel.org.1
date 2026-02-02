Return-Path: <stable+bounces-213095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMQwOFTigGleCAMAu9opvQ
	(envelope-from <stable+bounces-213095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:43:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C6CFB90
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC5AC302254C
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6333876C2;
	Mon,  2 Feb 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf7sgFAn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E8263C8C;
	Mon,  2 Feb 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054212; cv=none; b=Ax7ZBWjgBfeD0u4KIzkh/Ey6UI4UWN2ycjMqvoi+fEjHp2bd5SSViE33JEX0AK/eVzAeCfsdczaPdHRJFeVBLVXItBXAiBjgosXmRfCxjEQlmS2pRm16Yj2x7xIH7XG0BO7IZNO+eLBUeCQ82fQPqYZwzN+6MW9B2u6WL7Y536o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054212; c=relaxed/simple;
	bh=6hCMNHY71sItdUtR+eYniZvM8eG0ZV8mq7p8E+CnT+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb26+yVpKmVjorDfqg9n+uIbn57dPyphRFtghSrzFmHBtPNX2dmX+FayOO+K9iS2qn2p2tYTfC/qPzFErLQPMhv7YgiI3ds8iXQ7NCTzZ2pTPle987ML+AZK5/4Unj3nHzte9jKlnsvqS5B7oztVGEYu/MLOu69LgLpSdKHa3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tf7sgFAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0572C2BC87;
	Mon,  2 Feb 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770054211;
	bh=6hCMNHY71sItdUtR+eYniZvM8eG0ZV8mq7p8E+CnT+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tf7sgFAnuQCWij70K68x0L5cVJsVLvU6LbtENxqWSQeBkeXDoYs2ep0JLEhaWSBUe
	 pJBvk4634njvkzKEhFKWZfxDmvuXBhFaWn17ojxEZ8Ykp4sbd+maLUgvw1woTQLrxy
	 l0gXTqzJQlJhfLyB+Bc9tg+EtwJDmJA8EYFsXxib56fhSsXohIwhsX+VQIdg1jrHpw
	 Uquhgd65q/CLfvVyP/OZIq8+psBci6jRrajcKEnp6BtRLamiPBhQKMq+iB5CWvESHk
	 4jFXcG+dXzSsEO93cINjBDd53Ps7VX0OuktGYpMeR2DzkqPKcrqEHknVBWcasaOG7c
	 sM6Mv/T5a0hNQ==
Received: by pali.im (Postfix)
	id 677A848F; Mon,  2 Feb 2026 18:43:22 +0100 (CET)
Date: Mon, 2 Feb 2026 18:43:22 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Olexa Bilaniuk <obilaniu@gmail.com>
Subject: Re: [PATCH] platform/x86: dell-wmi: Add audio/mic mute key codes
Message-ID: <20260202174322.x6fr4atrx5vulxt7@pali>
References: <20260201-mute-keys-v1-1-825e786732fc@gmail.com>
 <20260202081247.vpvbsapdrynr7vtf@pali>
 <DG4NNLOA8MJI.35V2HGOFN3RM8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DG4NNLOA8MJI.35V2HGOFN3RM8@gmail.com>
User-Agent: NeoMutt/20180716
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213095-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[srcf.ucam.org,kernel.org,linux.intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pali@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 602C6CFB90
X-Rspamd-Action: no action

On Monday 02 February 2026 12:34:19 Kurt Borja wrote:
> On Mon Feb 2, 2026 at 3:12 AM -05, Pali Rohár wrote:
> > On Sunday 01 February 2026 23:37:37 Kurt Borja wrote:
> >> Add audio/mic mute key codes found in some Alienware devices.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
> >> Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
> >> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> >> ---
> >>  drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> >> index 28076929d6af..62cf28d1fe19 100644
> >> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> >> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> >> @@ -86,6 +86,9 @@ static const struct key_entry dell_wmi_keymap_type_0000[] = {
> >>  	/* Meta key unlock */
> >>  	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
> >>  
> >> +	{ KE_KEY,    0x0109, { KEY_MUTE } },
> >> +	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
> >
> > Hello, please keep codes in the array sorted.
> 
> Hi Pali,
> 
> I thought I sorted it... I'll fix it, thanks!

Before is value 0xe001 and your new values are 0x01xx. Most of values
are 0xeXXX, so it is quite unusual that Dell allocated values with
different pattern.

Also, could you please include into commit message for which Alienware
devices is change needed? It would help to detect devices which will be
fixed by your change.

And please add some comment into source file above those two new codes
for which are needed, in similar way how we have commented/documented
other key codes.

> >
> >> +
> >>  	/* Key code is followed by brightness level */
> >>  	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
> >>  	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
> >> 
> >> ---
> >> base-commit: 008bec8ffe6e7746588d1e12c5b3865fa478fc91
> >> change-id: 20260126-mute-keys-7f8a27cd317f
> >> 
> >> -- 
> >>  ~ Kurt
> >> 
> 
> -- 
> Thanks,
>  ~ Kurt

