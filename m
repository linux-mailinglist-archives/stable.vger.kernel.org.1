Return-Path: <stable+bounces-274214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VTJgN2kkVmqUzwAAu9opvQ
	(envelope-from <stable+bounces-274214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:58:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2F7542D7
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:58:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=daxhQ1My;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274214-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274214-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F57630AC3D5
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C337037D123;
	Tue, 14 Jul 2026 11:55:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259F363C50;
	Tue, 14 Jul 2026 11:55:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030128; cv=none; b=MiiH0LWmsDCNDdX13eAkHN0E8ch+OhIVmo8YmKdKT1OpTH2cbDMH2ITHvc90hC8/K0cs57q+JNkV8M/GeyhDvzgH+7jZ8gRfwp4clul9Zh5siPGbpdwSlLRXij/EQMUQ74T6cSOtuvfvG2g3kpGwZY2B5bZgaugV6jdyoiw92ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030128; c=relaxed/simple;
	bh=CHS00y8b6nbLwNrfwrMOKEszdL0AFvXwLKZHCkRgwMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwOVE62dzl8NnT3DNVVHG9Es4ZYx0BAIlc+62wdD+2b93t+Ryb4sb2atPRDHj/DDSk6DZfKTg6mw/hUdnvXC8ng5GTswaVEys1ZPh2dMhW8/wwqaa31SeXL03IGk3UVuM1J8rF0Y/MApt7SQrtsfpVDmSzVjwuiz5yf9j/HGQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=daxhQ1My; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CHS00y8b6nbLwNrfwrMOKEszdL0AFvXwLKZHCkRgwMw=; b=daxhQ1MyF/mslvu3ImHjHEFhJu
	Bw7Db0koveFJz6tXd88D9EV8tSGhuXwk4CL475IwBjbWnqUqtNGmiDv9hZPA9kxH3Q3UqjxuAD/ny
	jWaHfqAAvzb1qheH+Q2Y//8B1Wr1m8LssosgG4odZrlabyCIhT//q8jkrjMRso0M9AN/mgjLjdA+9
	hS8sTamn61f/ITfkihfkNjHy9tIvJDdu4J475FZntgP+xeHtBD6qIuYQ2gjm2ae8L2ZRAAsuoHwmK
	cCxWWa2nMn4CkL4ggW1MnqLp95Fm55VeVTNJZaSGrEz9NydjfmsL9YWgYpJgZ+Mt8Pc00/EAkLfbq
	9jPiF5rg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wjbjK-002G2F-0V;
	Tue, 14 Jul 2026 11:55:21 +0000
Date: Tue, 14 Jul 2026 04:55:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Message-ID: <alYjBty7EtpE5rg7@gmail.com>
References: <20260713082342.3803379-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713082342.3803379-1-4ncienth@gmail.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:4ncienth@gmail.com,m:netdev@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tung.quang.nguyen@est.tech,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274214-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41E2F7542D7

On Mon, Jul 13, 2026 at 05:23:42PM +0900, Daehyeon Ko wrote:
> Clear sock->sk on the failed-insert path so the existing tipc_release()
> NULL check fires and the use-after-free is avoided.

The fix itself looks right: clearing sock->sk on the failed-insert path
is what __sock_create() expects from pf->create() on failure, and it
mirrors the same dangling-sk fix done for AF_SMC in commit d293958a8595
("net/smc: do not leave a dangling sk pointer in __smc_create()").

Reviewed-by: Breno Leitao <leitao@debian.org>

> Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic rhashtable")

Is 07f6c4bc048a the commit that actually introduced this? Or the
sk_free() that got added by commit 00aff3590fc0a ("net: tipc: fix
possible refcount leak in tipc_sk_create()") ?


