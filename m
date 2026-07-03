Return-Path: <stable+bounces-271731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Af31Ii6bR2pRcAAAu9opvQ
	(envelope-from <stable+bounces-271731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 13:21:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E563701C72
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 13:21:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JTDZ1FAy;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271731-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271731-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95E2F30098B6
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F53C1F5E;
	Fri,  3 Jul 2026 11:19:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AA35BDC2
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 11:19:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077587; cv=pass; b=roJcKUJwe6CSxtXAMQZxV9EJ4BWbT4fgP+VC0+T9BzWvP2Is0PSzG3dyvSlfihKamCdDB4LNZMxOdsly/cek6S88SNZeQh6rN4FpRcehi/8PjByLgRrX0L9mc+FINssmo9I4oUsnUZQ8A/ScsSrWyUZjo2UAkfKnyRaqe9YNzQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077587; c=relaxed/simple;
	bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTbLkAZORcUbBpjURUQG+NxYcR3D665oi9t5/6Ak1t6niRL27CcbOc5iz/QZlcaSklCaO/WiRcKb/smkKcq3mODGRfDG4aRUOouqOHaOsej8W3GQEiBabEGWn3J6KzWWA19snspOWtOWmrxE2Mk/50DNXF7R01TIxwpI62+/5sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTDZ1FAy; arc=pass smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80bb41f7f3cso3519767b3.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 04:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077584; cv=none;
        d=google.com; s=arc-20260327;
        b=ZVGcNWFE4kW2jKFoGwhU8NxgijJV9ITP8pX3W53WJNE/9HAsG4XvLJvLw2lFPSBOfU
         3gxzzL12lAj9WPAcb5wYotgerHhNfSggNxARczakgiqW9b6eImsng5MCKY7Nr17KVyHn
         eGSmDfTr9wjK6zCTO6u+Fs2cqiRhoyZh5Z6kxp2UfCdDJpIzueMGuEQHfpiPEFITDGl9
         LlvWs30XTcEBcqOaN34FklJa6UJCh/dliOG2I2b0yGm0vh0EWP9eODfamZw7AxoRRK0e
         c/2/QoQ1m8wolHk853ljbdZzyX6GlEoD/pBLiLS8u9DuZKiqny3rGRd6gMtIoHUKGvIX
         gDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        fh=xTiXLcjNc2DFrhONyaJoGvuK+EF7haVwr9fzFjak7KA=;
        b=aJ7wC5kAiSMQIpEAVpDdnpUkpyFgIwVN5NIF+/Ra4f/levtYDpGRZMQ4ONavzfETob
         Jz+wj0AJZw4pHM0WGtOmjvNTeePyCiyDz/dgG4RZbRsO6n0mdlvPMUwJ299kZ1woIq3n
         GZWP0MesHq5ike84SA37jfEc4fky6duQw9KPBtT4wmxiZ1muUnIIMMzc/PIGCp1BtPnI
         Iz/AAUkaqW/jkfaaIfa+J34cB/1M1yhSEeWlin6bIUpHovTmHwKf8RbsLBbfgrzvd1Zo
         wYpkJ37LZ48X85WySnhHfUzKgyTpngUE+cntD5KzOw3CrxnGgdeTWeWBfHzDBQeiOkbo
         wNZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783077584; x=1783682384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        b=JTDZ1FAy0nlpJMAUJk4fkIaePwrfF8e7uiKGYwEQQc6VQ9EjRyMHgZyG8rCDATz50G
         AASt8bINGeFULCGM3bF5Uq7GquZ783w9NHJ/iryn/OqkOsK/YbPF8d1MaWiserKBEfU5
         PphJ6xcZGvykbwfxUg2c2oTNoOxIAwHlZBCi1PWzaydsPj2iOi6xMLwUlfi55d5sh39f
         iQ1YbbMEdCLOJ+OzWfNWWK+tv2VjSEdgMZ/CE3C6GUFkJ5GC9geumnyRsPNkm5myGJ7D
         vzYlGpg3IRpuCvOMReRkHyPo92gSv/AKGOlfAMObDAdKf/UL8NLAwM/8rRxm/AmT3gQg
         kVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077584; x=1783682384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        b=kOqNSxRoXB7BJbCYCQehnJ9sUOvlKQlgXgOGrRKdqtcw8ZpfcyeqN9Zo9atp3+LqMm
         l6T4oGM+cKxEW9w60EtVvHdpSKBO9lYksNKvAP9lItXZcJDoXW5cSFdBTFv8rzj/6pJH
         FJSv6jFQJPr7C+uHlpqwmJVLpRoBay+i0OCHiBOzi90vDhY/wzcKgUZihaKJ529cflJA
         DMlsvQeJJDJSzAOOkYjyLmYECZrtlgcJ1cZtcrZ4pGqftKbwUTquxvQ2aw1WMS1TUt8B
         qZEouiIaZqNiw+H/z3SM8YQg1kID/Bl3Fkgrv8hj7XVrNVbGpiOQS1FRjr8FQfiidgdX
         DeeQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBKSZK9kVQDUE2PcOhCVrgpDZZ1eXCLC2JuUIhuuY9Y8WvqqKyjPBEOC2H0Xs7BCdGtFS8nTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbrvQLO/uylbNrqP2gz8SZr35CLKXbKOlxHmmaOaLlpxj/EKz
	KYmffz8RZpa1bq70gQNr7M4U10MzEXY3bUJCNLTAWOPQQ/FsbELQvoCViSklCyAoNjFyokodERb
	meuTG1YAVwFIvDL2UJCrWqipP6T8A4Jg=
X-Gm-Gg: AfdE7cleulkCibH3f/j1IxwpT8ycKpHVnjqJ69IBa6ZXmGR4JoBmMyO6+fLJYa5ayF0
	6I/7Yw6rHKv2hyy6gARHjPGuo+qorslHYnQr8bJQsvsvQbltmiXKbsExOXRtpkv+qoPmmELpusG
	H84cjLbJ9BjItMzRu6FvDsQvzluLjEatawG2dCL4a815UT2O7ij09/w5ZJw+DdeIllAai4kocqH
	xOFeX/bOaaqftw1lfurK7frdny8akV2Z+GrAoAJNqTVc+J0R0SdnKcuJN6PDDzend+OkNm8lA==
X-Received: by 2002:a05:690c:7307:b0:80c:85e5:8749 with SMTP id
 00721157ae682-8138b1721b7mr93282977b3.71.1783077584023; Fri, 03 Jul 2026
 04:19:44 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:19:43 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:19:42 -0700
In-Reply-To: <877bncnx25.fsf@bootlin.com>
References: <20260627235805.17310-1-alhouseenyousef@gmail.com> <877bncnx25.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Fri, 3 Jul 2026 04:19:42 -0700
X-Gm-Features: AVVi8CcoY5btWDQlEBKCdQnuzHazbJEJeoWIsXdznqL3lACOC9I6h18j1gdrN64
Message-ID: <CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
To: miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271731-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com,m:alexaring@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev,4707bb8a43a42fca2b97];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E563701C72

Hello Miquel,

After ieee802154_unregister_hw() returns, the driver callbacks that
can replace phy->pib have been quiesced, and hwsim_del() has exclusive
ownership of the final teardown. The pointer is no longer being
fetched inside an RCU read-side critical section, so rcu_dereference()
is not appropriate there.

rcu_dereference_protected(phy->pib, 1) expresses that there can no
longer be a concurrent updater at that point; the protection condition
is the completed unregister rather than a locally held lock. The value
is only fetched so the final object can be passed to kfree_rcu().

rcu_access_pointer() would also be sufficient for that limited use if
you prefer it, and I can use that spelling in a v2.

Thanks,
Yousef

On Fri, 03 Jul 2026 13:15:46 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello Yousef,
>
> > @@ -1004,12 +1004,11 @@ static void hwsim_del(struct hwsim_phy *phy)
> > list_del_rcu(&e->list);
> > hwsim_free_edge(e);
> > }
> > - pib =3D rcu_dereference(phy->pib);
> > rcu_read_unlock();
> >
> > - kfree_rcu(pib, rcu);
> > -
> > ieee802154_unregister_hw(phy->hw);
> > + pib =3D rcu_dereference_protected(phy->pib, 1);
> > + kfree_rcu(pib, rcu);
> > ieee802154_free_hw(phy->hw);
> > }
>
> Would you mind justifying the choice for the _protected() version,
> please?
>
> Thanks,
> Miqu=C3=A8l

