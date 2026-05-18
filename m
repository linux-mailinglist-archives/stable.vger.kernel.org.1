Return-Path: <stable+bounces-249265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDfZMen/CmoH/QQAu9opvQ
	(envelope-from <stable+bounces-249265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:02:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3189C56C299
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C73B30B308B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DEF3F8EC0;
	Mon, 18 May 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xvt6Y9FL"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775B3EC2DF;
	Mon, 18 May 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105407; cv=none; b=ac0IHzzZGJVULRw3IZvUggQAZk36/ijQK3cKlNHb8FdINEwP4SsxZ/G28ejcoxhE4aUJXD63raCLrvk2BUpKcZnzboVTZ+U3z4vO94Cdn/Oe7GMIsE9AvqqIJGAOxrwNmsbsjiAHJhYeL4i/BhXDHPrZwcQj4XhslhDBZ42Gc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105407; c=relaxed/simple;
	bh=0lRi5TC10tfwVZPqC59MI4zysRNQoBCeqBGlQwSHOrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MM9/uti1Sq4EyvHPhGjVH24cBxMw9ZbhKtlRpMzh98SRpuSIFKLqh3VV2GaqkI6dUdxmM79wHU8bQurosravVJaNx4kpHzjNSP60KHRERTx2xN3OZlMgJk4KXtOcK/U5v4W6tjzhXkQ35o2innmoZPoGrMUb4RJsiuWd9M8wFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xvt6Y9FL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 409AB4E422E1;
	Mon, 18 May 2026 11:56:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 141DA5FFA3;
	Mon, 18 May 2026 11:56:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F04C411AF84A3;
	Mon, 18 May 2026 13:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779105402; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pxpe7iIx2G4tBbQyj/ZO12IXMY9/CrHISr2PmrKBAzU=;
	b=xvt6Y9FLrhmACZU/qfPnfqfPTSG4UKIrKL6ikRnt29aVnqkLQK6od+RVu0EsMBb0gFcSde
	4OWaTfsiDyNfqcoEaTguZZIMHTfDhd0/1pishD0kftaME/kwJcTjdM8OaAXXe16focKkP6
	0OUWBAbLphH8+Pxx7BhrgtCFWk0721oiJLbFkU3PZdoNHrNzkVjE4gvjcgCDswKFnRNF7M
	JvvhQZwwkyn1Uca723m2nHFampilLTRogkItw+m2kPY8eRHqmxG1VH9hZWzxp6yrV9N0yA
	ZVwgS7tnYuzjpqTOmoN8NDG9dvMFDVnimhkWemMzVIlrIBUlkWGVKt3rmpmFrQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S . Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Shitalkumar
 Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH wpan] ieee802154: ca8210: fix pointer truncation in
 kfifo on 64-bit
In-Reply-To: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
	(Shitalkumar Gandhi's message of "Wed, 13 May 2026 21:04:12 +0530")
References: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 18 May 2026 13:56:33 +0200
Message-ID: <87qzn9szgu.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 3189C56C299
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249265-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Shitalkumar,

Thanks for the patch!

[...]

> Found via a custom Coccinelle semantic patch hunting for short-byte
> kfifo I/O on byte-mode kfifos used to shuttle pointers.
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device
> driver")

I don't remember what the net rules are exactly, but this definitely
should be backported:

Cc: stable@vger.kernel.org

[...]

> -	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) !=3D 4) {
> +	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer))
> +	    !=3D sizeof(fifo_buffer)) {

This line becomes unreadable. Can you please use an intermediate
variable? Something like:

          ret =3D kfifo_out(...);
          if (ret !=3D sizeof(...)) {

Thanks,
Miqu=C3=A8l

