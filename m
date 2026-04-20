Return-Path: <stable+bounces-239994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHk2AGGF5mnTxgEAu9opvQ
	(envelope-from <stable+bounces-239994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:58:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE04337A1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81743302A2DD
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B633C9EC3;
	Mon, 20 Apr 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deGlpvDL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133F3C2769;
	Mon, 20 Apr 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776715096; cv=none; b=Tz9gbskYHA93JlnEOd3ZJ4nFpQZPtOVMoVHlr1n4zf0Bayhtka1e2srSIW3ZLOIjXnFo/jtRbkbL3FbrQPvkOh0ztZrMUZo6FUhBSddkrF0yAWR1PIlo+OxARmA3JpnPM624vffE1JritJhHoUsKEs/TlfBbKKiPaULMRRnLflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776715096; c=relaxed/simple;
	bh=7imKsxasw8FzboIX7GWKa18kk7I+PnoGpwZk19NkCp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlPoQ4H5Hxe5dM2jrtmOBCFUc6EKpCtUHoTVHO9D9L8oGj1eyUG2sDzVIJdnbGQljW7txBJayiEfAv50khM5qg2qg32avKuRy7di6OrYq/uzhdHvIuS/x8GDuwR8xMd6JDt/TIfU/ITANOzOZk95bUTtzMs0IINzrXOE3TOyUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deGlpvDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1B5C2BCB0;
	Mon, 20 Apr 2026 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776715096;
	bh=7imKsxasw8FzboIX7GWKa18kk7I+PnoGpwZk19NkCp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=deGlpvDLgGw/fVfLhNYws/HG3Qqprh041CzfycNK8hQIxVBq80dBF+kIT1mYyv85/
	 QwblwfMsIoigJhhD8/AewBZ1NOg8M93JMv9AUWHGZFV+7bZyn+fn6tsps+YLzFqjsJ
	 vFArN4WpbeGygMHyxqN8m3FE9VFElXDYrrPDWL7AkJFtXkm+Fzf1V+d/XVOS56zj1p
	 o4xza5lTrE4GAjIRpirKCOycWKcBiuOWkLf1LS5zGJlRAcuvZAVtZdKqlgPV2yQOgj
	 fOK2WDjkpK1EI8fjD31dHdZw8vlojFu/c5NDgZuB9DGmikuDv6ERyWFIqkawe8OLyl
	 ko3hJZHPeZ3jA==
Date: Mon, 20 Apr 2026 12:58:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: David Carlier <devnexen@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Weiming Shi <bestswngs@gmail.com>,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
Message-ID: <20260420125815.3a920d9a@kernel.org>
In-Reply-To: <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
References: <20260417055408.4667-1-devnexen@gmail.com>
	<b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239994-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,gnumonks.org,lunn.ch,google.com,redhat.com,lists.osmocom.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CCE04337A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 21:02:55 +0200 Justin Iurman wrote:
> On 4/17/26 07:54, David Carlier wrote:
> > gtp_genl_send_echo_req() runs as a generic netlink doit handler in
> > process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
> > which eventually invokes iptunnel_xmit() =E2=80=94 that uses __this_cpu=
_inc/dec
> > on softnet_data.xmit.recursion to track the tunnel xmit recursion level.
> >=20
> > Without local_bh_disable(), the task may migrate between
> > dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
> > per-CPU counter pairing. The result is stale or negative recursion
> > levels that can later produce false-positive
> > SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
> >=20
> > The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
> > the data path runs under ndo_start_xmit and the echo response handlers
> > run from the UDP encap rx softirq, both with BH already disabled.
> >=20
> > Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
> > commit 2cd7e6971fc2 ("sctp: disable BH before calling
> > udp_tunnel_xmit_skb()"). =20
>=20
> Why not fix iptunnel_xmit() directly, rather than fixing all possible=20
> callers? Basically, jut like we did for lwtunnel_{output|xmit}(). The=20
> advantage would be that we no longer have to worry about BHs in the=20
> callers, and BHs would only be disabled when necessary.

Oops, I pushed this already. The bot hasn't caught up yet.
Let's revisit this if we find another caller in process context?

