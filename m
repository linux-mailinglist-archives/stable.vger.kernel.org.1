Return-Path: <stable+bounces-273648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CNlONiTLVGrkaQAAu9opvQ
	(envelope-from <stable+bounces-273648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6A74A52B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:25:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NDGR2S+n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273648-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273648-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C8B3024CB2
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166EE39B943;
	Mon, 13 Jul 2026 11:24:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274030CD85;
	Mon, 13 Jul 2026 11:24:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941852; cv=none; b=ns/DsS7o+Cw5ZXhSoWpvQ4jkOKk7bBEN6cfTt0rVBHLBgnY4MxljgZ/SiSnzyGCiVdv0E3x56rVT9hR98z82QIAplbidFnB02Deglv6YLQjCpdJEwYcLzyMnhsPTnFOJWe0dth8hEvq7HRzk7Ke+apKgA+eGZy1uf39caw0seg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941852; c=relaxed/simple;
	bh=m1J/d/PYVhC/rKT9VeZk2geeZIQpoUwUBFioUePZgGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irW2f2z21uQ2Mk+k0suwhKmBBH9fppa+q+z3UxOW87m8R7d6AxpeeMY4+snx8WpRlJwVrKBN9JLXRPupCJY/dsjxLeHs66uICORx6nCubfMchSFFY0ve3QK4MGgBIeZ+W4C+cDfbl4dARwNmpSKepLi1KnUID1qmFNFORcw7VvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDGR2S+n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F304A1F000E9;
	Mon, 13 Jul 2026 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783941851;
	bh=72WoxctWpy4wTccgtBZq5D0qoW2IakfKc+DqFExW7hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NDGR2S+nscyYK/UZBG3aj1/uiixAqvvftosFOqXqPUwwn1apj54Syy3b1Nyi1GBMI
	 ByNXp2VgcoycQXfEVRCm0EqL2C8tTqqIeQug6IMTP2n3qzcAzz8K1qW1Gk78wPK24f
	 BbqAplUr6lqMtiiLNmdtWv1X5PbbRNpMQVRipgwCcHEDS0VpV4TDsRcg/jwaDIgGcn
	 grmsHgFxBbBe8LpCYyUzftp4HLtGILO0QVPXkomAEC4YrUrlYY1msdTFdHg+t+otJ3
	 S52EBxaqB9uSSqvauQs0a4BJ/z6X81wzYWD/e8AcKw6sjIyeh8CHW9eTbujHHXM8sl
	 zv2vid4zklhYg==
Date: Mon, 13 Jul 2026 12:24:07 +0100
From: Lee Jones <lee@kernel.org>
To: FirstName LastName <bsevens@google.com>, stable@vger.kernel.org
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: playstation: validate num_touch_reports in
 DualShock 4 reports
Message-ID: <20260713112407.GB3774971@google.com>
References: <20260323124737.3223129-1-bsevens@google.com>
 <20260713112252.GA3774971@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713112252.GA3774971@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273648-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lee@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bsevens@google.com,m:stable@vger.kernel.org,m:roderick.colenbrander@sony.com,m:jikos@kernel.org,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28A6A74A52B

[This time with the Stable Team included #fail]

> Stable Team,
> 
> > From: Benoît Sevens <bsevens@google.com>
> > 
> > The DualShock 4 HID driver fails to validate the num_touch_reports field
> > received from the device in both USB and Bluetooth input reports.
> > A malicious device could set this field to a value larger than the
> > allocated size of the touch_reports array (3 for USB, 4 for Bluetooth),
> > leading to an out-of-bounds read in dualshock4_parse_report().
> > 
> > This can result in kernel memory disclosure when processing malicious
> > HID reports.
> > 
> > Validate num_touch_reports against the array size for the respective
> > connection types before processing the touch data.
> > 
> > Signed-off-by: Benoît Sevens <bsevens@google.com>
> > ---
> >  drivers/hid/hid-playstation.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Could we have this in all branches up to and including linux-6.6.y please?
> 
> Upstream commit:
> 
>   Fixes: 82a4fc463309 ("HID: playstation: validate num_touch_reports in DualShock 4 reports")

-- 
Lee Jones

