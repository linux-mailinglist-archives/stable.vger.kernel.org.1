Return-Path: <stable+bounces-272272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CjlMK+fMS2r2aQEAu9opvQ
	(envelope-from <stable+bounces-272272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:42:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B518712BC2
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:42:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Uy4pWw45;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272272-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272272-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 895DE3034185
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433F37F744;
	Mon,  6 Jul 2026 15:10:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8137E30C
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 15:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350645; cv=none; b=W2eZtiZJpDOtQS/h7D6oiOdGaVZp7UAq3xCp3I+iejhPLK5dTP5a8jKUUgVEL/gmDpE5zZgr5Q9quYvgnPA5f15pOUxvFwEfATXz5J/yNDUOgQLJU/L5mZOUYwJMvVuaRCbV7eFBM8hLpbKHTUtnzOvdVoieXgqdHF5Q7mKsyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350645; c=relaxed/simple;
	bh=y/pmSHkz/8gPGdm8kOcY1nN3wygy+A4pLcM3wr23QwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rom6LGnDqkqrI0Oz5u/4X0vTw0AdYmHnRTbdRADqRX/Cnne2pILAXqwtdkC230+T7DmbnAdS/dQYnul+Yge2IpZDwAbmBoS+1KlLycyBqQ5CclUOMQL9Kljc89PkHOWA95e3tBbnXAzNTksaEVlw0lhj1HmiVjcCoyKYspYVcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uy4pWw45; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C783AC8EC7B;
	Mon,  6 Jul 2026 15:10:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8386A601A2;
	Mon,  6 Jul 2026 15:10:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C99F11BBA440;
	Mon,  6 Jul 2026 17:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783350640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y/pmSHkz/8gPGdm8kOcY1nN3wygy+A4pLcM3wr23QwU=;
	b=Uy4pWw45EUQjRJgl/8CxRktl8n2Fq7GPge/m+5TF+ZrVnn5NDsWTL/aDU8WFb7ho/Y3plr
	RO0EP44ADZBNbTw31eoRs4qtYuW/AGw1Nc61H4InZHTIOXF3eJPvLn3vazMlHG3qTaFa6s
	DMTSYTBW52I3BrkYFuysvY+7tdKdauJoP3xABhMFx5vem/VVhbMGlj8PjiQqF6B4O4nRKY
	UDGdAgyT+nDZj4y9u2kWhhUqvfjC3T8C5Yh8yMQj8l/mFTv0aS4DwutVi8Ja6Sx2+JHnav
	nz6urEVKU6b9LESssE+z5/MKXkiIUqz6cjAlMYtySreIBQ0ABpvgbJw/VgNAvA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  andrew+netdev@lunn.ch,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,
  syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering
 hardware
In-Reply-To: <CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
	(Yousef Alhouseen's message of "Fri, 3 Jul 2026 04:19:42 -0700")
References: <20260627235805.17310-1-alhouseenyousef@gmail.com>
	<877bncnx25.fsf@bootlin.com>
	<CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 06 Jul 2026 17:10:35 +0200
Message-ID: <87jyr8jgr8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272272-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com,m:alexaring@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,4707bb8a43a42fca2b97];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B518712BC2

Hello Yousef,

On 03/07/2026 at 04:19:42 -07, Yousef Alhouseen <alhouseenyousef@gmail.com>=
 wrote:

> Hello Miquel,
>
> After ieee802154_unregister_hw() returns, the driver callbacks that
> can replace phy->pib have been quiesced, and hwsim_del() has exclusive
> ownership of the final teardown. The pointer is no longer being
> fetched inside an RCU read-side critical section, so rcu_dereference()
> is not appropriate there.

That's right.

> rcu_dereference_protected(phy->pib, 1) expresses that there can no
> longer be a concurrent updater at that point; the protection condition
> is the completed unregister rather than a locally held lock. The value
> is only fetched so the final object can be passed to kfree_rcu().

While I believe this is indeed true, it actually feels slightly overkill
since there is no updater anymore and, as far as I understand, the only
thing that we need here is to get the pointer value for freeing, right?

> rcu_access_pointer() would also be sufficient for that limited use if
> you prefer it, and I can use that spelling in a v2.

If you don't mind, I feel like rcu_access_pointer() is exactly what we
need here. It is also more understandable, even though I agree in
practice there are no differences in this case.

Thanks,
Miqu=C3=A8l

