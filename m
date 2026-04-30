Return-Path: <stable+bounces-241975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHl6Hjax8mlItgEAu9opvQ
	(envelope-from <stable+bounces-241975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:32:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AE249C051
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A7F302C0CA
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855C17D6;
	Thu, 30 Apr 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGh9/0l8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31B1DE2D3;
	Thu, 30 Apr 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512730; cv=none; b=agvw4btLSELFLyKccMM3aIsMYfCMQ8skT4PO3PM8TxnMCLErc2VEd9+NQGjwDX5zaIXudmAtRclEWCyEJ060nrltfhddqi7PFJKfCqozrgS8A3PyH/49sFRyvh6Sncx3NgOB/xoy+ZyU9PaA+nJJtVbkDCV5YrA5Ki0/DHbTx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512730; c=relaxed/simple;
	bh=GPfPSzp1YJCpnaNQiH/G8TJL9kVKVDTd3wQ5tcMnVn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvOgUdoqiiQ2OI/mq+NIoLIdw5XVgr9wFmifFu8iD1fISRF0qdBMSTV1RLU4bCWxj2p9etYNKTNU9AQ7hSYitpvSSM3Ar6Q3ACEWyPx2RwzydLxtRDSBjcfpDMuU5mgz0VQsdlFtzeQEMmheiwjbZO+4W2Lpv/SmT8PpjfdKi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGh9/0l8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B8BC19425;
	Thu, 30 Apr 2026 01:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777512730;
	bh=GPfPSzp1YJCpnaNQiH/G8TJL9kVKVDTd3wQ5tcMnVn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGh9/0l87EM/HnNW6kz0veKsHsG0TAEaY0jUX2sepU9JVMHGtdsDww30zHaXwm5LC
	 xy2/u396oUNUY1oPDvGoS9W+S+EibC40TRD6QLxj3TCQCig9ztsAfiea6ecPP8LwFZ
	 1/Aj6izP87bik7ZrRIa7/cLTlZqPSpnGWTnc2lIPvEBFoxSuuosuqCIuWJGkMeOowD
	 bZzCtLNvTdCtfmSk2AG2X55An+X26qN+J8hJGQ7yKqrDVLjCBqTzAsjSNeiMGUlIV3
	 LfsPyyqJsXSZ897WAYZTyt1WysASQKl1fWANEW6CZlExrl3papNfqCw/A+l+6nKFuX
	 ti5C9elTQzOtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: maoyixie.tju@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
Date: Wed, 29 Apr 2026 18:18:48 -0700
Message-ID: <20260430011849.2345207-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
References: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19AE249C051
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241975-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,gmail.com,davemloft.net,redhat.com,ms2.inr.ac.ru];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ip6_gre: Use cached t->net in ip6erspan_changelink().

This commit fixes an issue where ip6erspan_changelink() uses the device
creation netns instead of the per-netns ip6gre hash. This ensures the tunnel
is inserted into the correct hash, avoiding a stale entry and subsequent
use-after-free during netns destruction.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 63fc8556b475..c5978e0bdfe3 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2262,7 +2262,8 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  				struct nlattr *data[],
>  				struct netlink_ext_ack *extack)
>  {
> -	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
> +	struct ip6_tnl *nt = netdev_priv(dev);
> +	struct ip6gre_net *ign = net_generic(nt->net, ip6gre_net_id);
>  	struct __ip6_tnl_parm p;
>  	struct ip6_tnl *t;

While reviewing this area, I noticed a regression further down in
ip6erspan_changelink() regarding the metadata tunnel unlinking.

If an existing ERSPAN tunnel with metadata collection enabled is modified via
a netlink changelink request to disable metadata collection, does the unlink
sequence clear the correct pointer?

Looking at the rest of ip6erspan_changelink():

    ip6gre_tunnel_unlink_md(ign, t);
    ip6gre_tunnel_unlink(ign, t);
    ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
    ip6erspan_tunnel_link_md(ign, t);

Because ip6gre_tunnel_unlink_md() is called instead of
ip6erspan_tunnel_unlink_md(), it evaluates the old collect_md state but
clears ign->collect_md_tun instead of ign->collect_md_tun_erspan.

This seems to leave ign->collect_md_tun_erspan pointing to the tunnel.

Since ip6erspan_tnl_change() updates the parameters to disable collect_md,
the subsequent call to ip6erspan_tunnel_link_md() will skip updating the
pointer.

When the tunnel is eventually deleted, ip6erspan_tunnel_unlink_md() would
be bypassed entirely because collect_md is now false.

Could this leave ign->collect_md_tun_erspan as a dangling pointer,
causing a use-after-free when an incoming ERSPAN packet triggers
ip6gre_tunnel_lookup() and dereferences it?

