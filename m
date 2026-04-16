Return-Path: <stable+bounces-238262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mClNBQyF4GmmiwAAu9opvQ
	(envelope-from <stable+bounces-238262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:43:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6CC40ABCC
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 892CE303B5F2
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3A37B022;
	Thu, 16 Apr 2026 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="b1RzviSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKe9p2/3"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BD1B4156;
	Thu, 16 Apr 2026 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321799; cv=none; b=hLJGMTZxAKd6DKrfXdO/0JcwpgHF0za4kKxduxcn2MW7b200t4OvGX7PlO4gVfM0HHJkzA7uf9tNineNwIvq9bureZ4pCBRPVSIBQNXuugRwsNqBAAZZcieOUAVdtkO2PeSFTa67fdLyKNAPbZ4wrTm2y2dyJXrjo52qSx44Baw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321799; c=relaxed/simple;
	bh=EL43GC42YmxIDGnguK6h2F5qT/m6cfOybkmqCOGETKs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rkbg0PhoSOqebVD2yK+o9B/N2rJp5tdiLF1jkIrrgKooMHMg5VHxWgIOpvltnctTNvCs6sQEgnOsp+DIl0K9TASB8y5c65Hkk464fFUx756z1KlAW3O+YEI6x0CnW+EzbmwH6jZTRY2tH31ecD9H7OcRha2YVVFj3K/8SPeaGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=b1RzviSq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKe9p2/3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10EE57A00DE;
	Thu, 16 Apr 2026 02:43:15 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 02:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776321795;
	 x=1776408195; bh=UQSNmbFciiajEDdF1z12iE2Vg6YGNrx/vVkrhizzi7M=; b=
	b1RzviSqdJ07i176zIamh8AmCmNCm/jB7+REjW/PQ+iXF+UzJup2bPgTaGqshfoh
	oHkySQ3j/7lNBsxSClrRyw9UHvPuIcfDVbp9EfJdalRQFwoh6UacxEwBjyaorx3E
	ZFD3auDKOWUxaQLujVf+0QIEBhaoKpLZPsIHTsjkMdn4jSYSOlHFaA8+cyH6gy5/
	KnOEssCcJQf86C64XvK5MG58YmQ0e9+GSoNpvSuHExCYr1NZZrJaOFfEyhNvz7rS
	Me6C7pu64lPD4eDGKbO+F9E6Sgbsi1y56CB96t+1uc9vhpUb5GWy66EIULIOqbe6
	vNl0++Io7QrZjJY8XM5+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776321795; x=
	1776408195; bh=UQSNmbFciiajEDdF1z12iE2Vg6YGNrx/vVkrhizzi7M=; b=h
	Ke9p2/3QCK/07FK9Zd3cjjH+zZm/I/yU1iH7a5kC4+BppBStmYbMC/0XKnBMqIsk
	/rIAn+E58rbI6Axyq7+L9QXRs3OIVhlxutEGxvsjyKb4AvkSHpfvB0NZcJ+LEsBH
	Pi8mnUqOkUnOMu+CRYqGWyeTOWTKSVFrazGTQ1sCtlb/RQHgkTiILBZ2o7rxZyIU
	dYHf+xTIysZvfB1DlOT9GjvXEnr7rxU4wDh2c3xnTa5gNxy+ui9AYEjB+II5JoIp
	bqP6IMXKAnlS5s6S+YdoQOf+ru1hY0py3EhDAaKBkA8qZtQ//Dr9FnC84N4aBItH
	9+4tuVWPRd3beuQrfJgCQ==
X-ME-Sender: <xms:A4XgaXsJ13y1vbXRGoC6Rxx5ofPDvz7iLQJlhZp-uN4FB21cJ3_pAg>
    <xme:A4XgaTRfBp1ScnygtUyh_DjnXICozw7TgpYz8M1luzPmAbW108gyF2fl1lQS4Loux
    BSWCfGocKP3315Ao7H7Fx3z6tUlIf7IBlfZTBfYN0QOR0OiCJUvXZ7b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggr
    rhhrvgdrshhhqeenucggtffrrghtthgvrhhnpeetgeeivdffhfeihedvkeefueekgeeivd
    ekheekjeeuieejiedtffdtjeetvdffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtph
    htthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushes
    tghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuug
    gvsgihthgvrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhr
    tghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehsrghnuggvvghnsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:A4XgacdMFvtmAtD977tuDhllkROdtZBEkBecpr6cQurEszRn3VYCoQ>
    <xmx:A4XgaQxboX17cvL5vkET90e77067Kn2FEwKstx3aWOIia7NokjDq_A>
    <xmx:A4XgaRJhrlPoPQmvaV4yPIUtm9hV6HlYEZF39KXbZs3J1HOyKHgW6g>
    <xmx:A4XgaSE2mnIf_3j57-8VtRxwcmIwzd_OTMg7cczGIzNIYQkpgH59qw>
    <xmx:A4XgaQpwFBfRmbQIDK1nK1oFjbT8m0qfg0bNuTtbAlPaH8x9n1KopFlb>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F21CDB6006E; Thu, 16 Apr 2026 02:43:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Apr 2026 08:42:54 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: asmadeus <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sandeen@redhat.com
Message-Id: <799434da-ec7b-4e97-aeb1-e60927138233@app.fastmail.com>
In-Reply-To: <aeBPEcmAaVv5Vt5d@codewreck.org>
References: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
 <2406037.ElGaqSPkdT@weasel> <aeBPEcmAaVv5Vt5d@codewreck.org>
Subject: Re: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[barre.sh:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[barre.sh];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238262-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[barre.sh:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre@barre.sh,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,barre.sh:dkim]
X-Rspamd-Queue-Id: BF6CC40ABCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Note your patch converted tabs to space and couldn't be applied -- if
> you have to send patches by web mail please attach them instead, that'll
> be easier to apply than a corrupted patch, even if some tooling like
> sashiko won't run (it doesn't run on corrupted patches anyway..)

Argh, I'll just commit to using git-send-email from now on.

> If you're fine with my wording for the comment I'll modify it in place,

Sounds great, thank you.

Pierre.

On Thu, Apr 16, 2026, at 04:53, Dominique Martinet wrote:
> Christian Schoenebeck wrote on Thu, Apr 09, 2026 at 04:51:07PM +0200:
>> > diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
>> > index 057487efaaeb..05a5e1c4df35 100644
>> > --- a/fs/9p/v9fs.c
>> > +++ b/fs/9p/v9fs.c
>> > @@ -413,7 +413,11 @@ static void v9fs_apply_options(struct v9fs_session_info
>> > *v9ses, /*
>> >          * Note that we must |= flags here as session_init already
>> >          * set basic flags. This adds in flags from parsed options.
>> > +        * Access flags are mutually exclusive, so clear any access
>> > +        * bits set by session_init before applying the user's choice.
>> 
>> That phrase is a bit suboptimal, because V9FS_ACCESS_ANY is actually a bit
>> combination of single, user and client. But OK, I currently don't have a
>> better phrase for it since the access fields have to be replaced altogether.
>
> Yeah, it's not so much that they're mutually exclusive that we need to
> clear the default value before applying the settings.
> The key distinction here is that it's not "any access bits set" -- if it
> were arbitrary values then it wouldn't be acceptable to just or the
> flags out, you could risk e.g. creating a client with 2000L but setting
> another protocol in the flags and there'd be no end of things to check.
>
> Something like this?
>            * Default access flags must be cleared if session options
> 	   * change them to avoid mangling the setting.
>
>> As for the actual behaviour change; makes sense to me:
>
> Yes, that works for me.
>
> Note your patch converted tabs to space and couldn't be applied -- if
> you have to send patches by web mail please attach them instead, that'll
> be easier to apply than a corrupted patch, even if some tooling like
> sashiko won't run (it doesn't run on corrupted patches anyway..)
>
>
> If you're fine with my wording for the comment I'll modify it in place,
> otherwise we have a few more days to discuss this before I sent to Linus
> for 7.1-rc1
> (and I'm really sorry for my lack of reactivity, I'm sure I'll miss some
> patches anyway...)
>
> -- 
> Dominique Martinet | Asmadeus

