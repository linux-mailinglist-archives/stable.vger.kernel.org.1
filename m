Return-Path: <stable+bounces-272287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oERDKhThS2rKbwEAu9opvQ
	(envelope-from <stable+bounces-272287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 19:08:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83826713AFA
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 19:08:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=kNiQejzd;
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272287-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272287-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A75130A6851
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB142CB0D;
	Mon,  6 Jul 2026 16:37:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26E377555
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 16:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355857; cv=none; b=lIohCwnPIkKlot+dhE+jpPFQNbLPffY524CDmLKXqLvOOdfE3lKVxKE+tUSgOqzUbbm59RV3CT8iBFWos0pMPWv9qdJy1Kbsb2cGXHAUGOHzExzS57gBQ2dNwDqn5JySPjCc3MFTALKfbZLcJwJpaZeg24tZsWN8UMfD8CEr2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355857; c=relaxed/simple;
	bh=XmJ6wnMPGgS7yPpX3MWDtjcz3HokPoz7NMQ+UHEt2sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1b24/g4yfta6UHY8eeDiRr1G53xLLdotwK4B70oX5+I9tqu1/MH+1A5662WrzpzD/HRcfV5S0Hr+zTrUn1SKhB2G3zV3EpHQnPwbLeRUELIluHQyN0hVQ9Z5k7x5kGGfPdLop9KXWHMZeS5xO//eGIolAM6VWp/9NimKn7Lgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kNiQejzd; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=hzWv+OFVZlg+W/U9J5leRdp6cK6eTOT9BafxwaHxbds=; b=kNiQejzdOlsFR4x5rzttxqk8n7
	HuQm/idJPtQaXCaHR73xBt6F9UQJ8mBxzeviuedqxqwOmSxm2kLd+deHyT2ycVL5TIPI56N7QN3c+
	daDsbEXdiBZ7Jfj+r574b5hvIWspym5hzZpaQahVN4J23bKskRnO/R/xWu7erb5FABpflCNLMlRui
	0fB5HlB1YoSm7uKNe5g77Y73CtZwMio+kKThncmVjZTcRwax7bU9l6JdnjeuVd/2uknwPbZ81WXIc
	F+kR1tjVSBOWYkTAdNUckhz3i05TSdlDsYPwBQAbUk3ZTvmQfXxGPBN2ej+jRKS1T1rJl99TjmhLq
	nyF3INkw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, chenyichong <chenyichong@uniontech.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/vmalloc: take vmap_purge_lock in shrinker
Date: Mon, 06 Jul 2026 18:37:30 +0200
Message-ID: <10194326.ag9G3TJQzC@diego>
In-Reply-To: <20260508191051.1831166-1-sashal@kernel.org>
References:
 <2026050349-operation-curled-2359@gregkh>
 <20260508191051.1831166-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272287-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,uniontech.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:urezki@gmail.com,m:baoquan.he@linux.dev,m:chenyichong@uniontech.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,vger.kernel.org:from_smtp,sntech.de:from_mime,sntech.de:dkim,uniontech.com:email,diego:mid,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83826713AFA

Hi,

Am Freitag, 8. Mai 2026, 21:10:50 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Sasha Levin:
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>=20
> [ Upstream commit ec05f51f1e65bce95528543eb73fda56fd201d94 ]
>=20
> decay_va_pool_node() can be invoked concurrently from two paths:
> __purge_vmap_area_lazy() when pools are being purged, and the shrinker via
> vmap_node_shrink_scan().
>=20
> However, decay_va_pool_node() is not safe to run concurrently, and the
> shrinker path currently lacks serialization, leading to races and possible
> leaks.
>=20
> Protect decay_va_pool_node() by taking vmap_purge_lock in the shrinker
> path to ensure serialization with purge users.
>=20
> Link: https://lore.kernel.org/20260413192646.14683-1-urezki@gmail.com
> Fixes: 7679ba6b36db ("mm: vmalloc: add a shrinker to drain vmap pools")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reviewed-by: Baoquan He <baoquan.he@linux.dev>
> Cc: chenyichong <chenyichong@uniontech.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ kept index-based loop instead of for_each_vmap_node() helper ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

it seems this fell through the cracks?

Because I don't see an applied message and couldn't find it in a 6.12
release up to now as well.

Would be nice to have in 6.12 though :-)


Thanks
Heiko

> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1d2262fb54185..d4a42980b4d02 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -5204,6 +5204,7 @@ vmap_node_shrink_scan(struct shrinker *shrink, stru=
ct shrink_control *sc)
>  {
>  	int i;
> =20
> +	guard(mutex)(&vmap_purge_lock);
>  	for (i =3D 0; i < nr_vmap_nodes; i++)
>  		decay_va_pool_node(&vmap_nodes[i], true);
> =20
>=20





