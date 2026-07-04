Return-Path: <stable+bounces-271937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ya4PN43sSGqrvQAAu9opvQ
	(envelope-from <stable+bounces-271937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 13:20:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA270769B
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 13:20:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dzyMe5S6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271937-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271937-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DC3A301475F
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470C433E8C;
	Sat,  4 Jul 2026 11:20:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F382DECCC
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 11:20:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783164041; cv=pass; b=qwVyQhermFIbGbn15MpubWOYrkMlBJfrqhLqEZTDQNHqRw07CYjSpBkSDONzUcRHZnSsoqkCVrBjD5j6BxmQtL4Qi0j+HSwzSLX3XE8WPWlYyDq3z+LAx2j/LjyRMw1yIwMbAa1D+DGLk5QsSm99j6VbWzRJiIElZpOsrkwTnJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783164041; c=relaxed/simple;
	bh=c/zm7aL5uQAOewymZPg0aiv0Tzi13gUJ/+Q8/o/Cpzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNmVLJ0I+ToIJMrepVZ6cOKXdPa04/COL/a7enJYRFeyakpwRVTf+me3DoaKdp0vaE2ESes8SWZUbXPm8LAa6PZ4Wwx9E1mwJyy5QZbd1R4PfBbzecB1FBwsuSOMPfO/Pz6JliHClWgglCw/h8S2bxKn8tobhb7I/qcF4dKQOgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzyMe5S6; arc=pass smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so699579a12.0
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 04:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783164039; cv=none;
        d=google.com; s=arc-20260327;
        b=B3psgMsDhEAbMpmVTeSk5emLDIMcYHpqB3564pDnB6yjZGCJgFZWIGeo7/fjI/dBuo
         97u8a4JiaiYYQiWiqy89HqrsmzPlKgudx0ieFAIOe4IYBw+eE4VsZv2+YQSWoTQkNTkm
         BgZiHAekVhDziQBjOncnHfg0QUhOaXSIMvaVeoa70Ide1WjZ0v3NvvK+cn6JA+JfpWcX
         6pClMgod3R0l3TZIP/3H7L6kha9sUU7Gf63x2CyjHXTf5L/zUszTELJt9mq9h7n87xdT
         mgk/QrzZXNZdBp6FAouQQgUm3cahNgXmdC0+Aqi9SqVw2yV3TcIOJRAGeTbD9WaYdK3d
         rZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c/zm7aL5uQAOewymZPg0aiv0Tzi13gUJ/+Q8/o/Cpzk=;
        fh=dljNS2ooK6fYvh9vxurHKUMg+Tx+AOHz+/1AkKhkEKc=;
        b=MKXSIeZT2hjZPjqdUjn2XgI/AZPTNmSLQzejnPF2JK9LVm//vA4D9Owr1xrtPbMBYE
         20fO+jWRvMBt30bCM7gUCvVjMyLaCwk/LJ2bwL52kgW+3LlQ5xRXoP+bPEpE6jsADDoD
         K2gG0U6jjRJ6TE+jDk0P0DBMqnueZyIaA137OpjZcOQkKk7cPyurwyTr9Z7FD/SAeP2n
         Z70cPd4vxOogjbKH+TdbT7wK5rB6LwXKXGGaEPQ4StpocKD2h9xaIpE+NuaUtJQpu/k5
         OPCbcwP4UukCcjWgdgyFiCAxscFOWxq5tKi2zsEw615Mzj+qqsJgqoJ26ws+q0GkuIvK
         Yjxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783164039; x=1783768839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c/zm7aL5uQAOewymZPg0aiv0Tzi13gUJ/+Q8/o/Cpzk=;
        b=dzyMe5S62AivBxYdswBWxQvlfkAaLbgT6FTki/ULu5d31MD+3aGvo4v+wH7Ta6CkJT
         DA1lOLEuMz34yTlngbYo7qLgdHhLRLf2ngfllum0LnIxRPxNZilgzazUiZoTYKUSISgL
         vnPiTMZraM+RybFM+65ULs/qBrVkbelhmLkUNQnymXfSilgVlzpeJ2+qJ3PEwq403ADG
         YILEpnVkppWlAgiEJxWwh68Fn574foX9iXI9tmWc6JjRi29G2n3DYsY/WKXOIjXkON3Q
         DO6Ay0tPMoDLejMd2am3SsY0XJBHAy/nnyBzEl89tW5CcG298TbHAKgoSO3WE/El7XdO
         uc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783164039; x=1783768839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c/zm7aL5uQAOewymZPg0aiv0Tzi13gUJ/+Q8/o/Cpzk=;
        b=CedT80o5xkVoLdZlIqWgjBxueYHve4siabsbDM03XDU1rU0YMAnFqTAPcw8DI7BKp6
         CtVe1RrCxvEmWTrnaogW0yEK9JWH5C1HQ8vMFxUIZ0EdtrJYiICf03h09NKcvpjFkNE5
         JIfTOKWtaypeGwu66sx6PP5N/jRquh1q7Ibs05llVqY70J3N2im91M6Tiq+8lbOfx2jo
         45PO/nDkf2xxXWxhEtR/4J9vFV3fnG7GNhrqq7Xw9lBiU5kYl73GrihNDn3nTBpmLu8r
         LomDbk+n1GC6+d/zD0id6tJXotjh/KT9rwX/Ox4ZgSdyNmVlCNoUVX/aGJ1Nh9mX3GPE
         2J0Q==
X-Gm-Message-State: AOJu0YzqGysVOUHEDveWUHd91L8ekwnFg/ZtN/ZeGC6FzolKPhir9XSi
	hMJBLFHuLFJpmUMW7CkDDKMkBm5ojoFpilHWRWisrFNDTgapw4OOzWQgsEfU9rHQD28d8iXh9BR
	UvynZ9Z+zKZaaHnOKRaEhjgfsCWIsqx4=
X-Gm-Gg: AfdE7cnj9dqBQBdvN0FXZgCSoCIFyXsXCX8ZLYbpOAwaWXRSmRnmms0/4nNn7uEAddP
	V4hP8hY2mL9XlMczZcyQqq/+BEAw0TZCjaYSS1rajKW81SSnOGLTVkBr+8/Yv3XxRL7FvJ7Wn72
	56zDKKlCi7dm0Qxfb7I6IAdL5wIuhLOVEaoNBpBDI8rGdUUT6uCsG1rbttHdHfOtCzz5vcCkvT3
	x7l00NHcb4OE1mSrWsywF8+1ujUZHzK0OSA2kyOJv7C+CTvGjmPruFAGLziE/Kr/4Xyf+y6rQ==
X-Received: by 2002:a05:6a20:d48c:b0:3bf:6c08:2b27 with SMTP id
 adf61e73a8af0-3c03e5818b7mr3187982637.47.1783164039478; Sat, 04 Jul 2026
 04:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org> <20260528194657.359703301@linuxfoundation.org>
 <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
 <2026062933-storeroom-amusement-0b66@gregkh> <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
 <2026070446-blank-duckbill-13ec@gregkh> <CAFQ-Uc8AAEGw90BPximQm3cLzB+KiH_PXr-UZEPK9nvueMGtSg@mail.gmail.com>
 <2026070406-squander-geography-213a@gregkh>
In-Reply-To: <2026070406-squander-geography-213a@gregkh>
From: maher azz <maherazz04@gmail.com>
Date: Sat, 4 Jul 2026 12:20:27 +0100
X-Gm-Features: AVVi8CdGnaG_XVJukiNdw0eBZBNxDPUTX5VAcWV5rjI0hAjcFCCuMPd9y8VPQ2A
Message-ID: <CAFQ-Uc8CDnGUH3xhjaVBd+Dr=+b7Lfu1SUrGGh2gQ17WW+gqxQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271937-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:sgarzare@redhat.com,m:mst@redhat.com,m:avkrasnov@salutedevices.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[maherazz04@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maherazz04@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FAA270769B

I sent it like half an hour ago the same way I'm sending you this
email, I sent it in plain text mode with the subject "CVE request for
a patched Linux kernel LPE vulnerability.",I really don't know what is
the issue..
Anyway, can you please take a look, since a CVE should've been issued
a long time ago, Ubuntu 24.04 latest kernel with latest patch is still
vulnerable and many more

On Sat, Jul 4, 2026 at 12:07=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 04, 2026 at 11:41:33AM +0100, maher azz wrote:
> > Hello,
> >
> > Yes, I=E2=80=99m sure I sent an e-mail one week ago to cve@kernel.org, =
and I
> > just re-sent now just in case you didn=E2=80=99t get it.
>
> Nothing came through, please fix your email system?

