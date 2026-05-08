Return-Path: <stable+bounces-244674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHJzDtKG/WmefQAAu9opvQ
	(envelope-from <stable+bounces-244674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:46:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74A4F2983
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B462301CCC2
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D5374758;
	Fri,  8 May 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gYa32qQm"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A5377561;
	Fri,  8 May 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222797; cv=none; b=gPuXw+xBMysrlnG48BoQfzx1iVkxuIXGAZ4s7UzPS/naPG7Si+2i9RrXLjLEHBDzfwf5FTfop/XqcO1msqcdth/DdYSCfa+uj8qppu8yAWtLa2boxTny8XSZZjCt33gs20ZCq9oe/JYoraEXboC3PjxHvwO2J88WSNZL6T3ngQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222797; c=relaxed/simple;
	bh=05nZ+gIzppm+BLZBfpcPgMdNGhEbEugPLSX//8bpPp0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMvQtCDmujCfKFGiOLDyLhxTYq9P3W/SzK0MetiMup6yzj79eMOi9AmxqqEGldJkHKNUYF2qZG6imuvWcx8Cm9V92U+eyYT4b6VCQfyW+1yL0c1v+g2bbhmiYway7Iu84VyKOjrh+eeBoPE/cSFEPuh0Oj2tG4266bdZS5EuPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gYa32qQm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 34574207BE;
	Fri,  8 May 2026 08:46:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AO8moCBcSTVj; Fri,  8 May 2026 08:46:14 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BF1F8206B0;
	Fri,  8 May 2026 08:46:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BF1F8206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778222774;
	bh=g2RV2sN+jzmrGkn4ZV3GjuywoldoUqX9Pel8LWivNrw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=gYa32qQm7axhs8CWSzB8b+Vry+3lO9qOfomax+LQeGMEs3iQQlUyFDqiQQ0GjShcd
	 QT8Os2VrZPYUEUEQCV7DlUY2TOprGkx2xkLIeu0OFUAO8QmNC0E08JlSzXxobTlwvu
	 I8m4BgkDM7aUhl3SOum6g0x7omMSyktafCfq8QekxoKoTqy922TmOXnRPs4MbZcgdm
	 JRk+g4Zwhg/I8sE1ap3oGHZW8QqHPwdO3NNOgag84sZ1CG5Hg3nyzKAgrdOfUVnKz+
	 X6oYi2EO0bpPHeS0IyXA3rK6nKSscpvB0Pm+aOkKjBQ4GONK3SnVbYBwjDObBO7wvi
	 eMB2fm7DZZOAQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 08:46:14 +0200
Received: (nullmailer pid 2712693 invoked by uid 1000);
	Fri, 08 May 2026 06:46:13 -0000
Date: Fri, 8 May 2026 08:46:13 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <horms@kernel.org>,
	<antony.antony@secunet.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: route MIGRATE notifications to caller's netns
Message-ID: <af2GtRO3hhGKa0ek@secunet.com>
References: <20260504142736.1228425-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504142736.1228425-1-maoyi.xie@ntu.edu.sg>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 8E74A4F2983
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email,secunet.com:mid,secunet.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 10:27:36PM +0800, Maoyi Xie wrote:
> xfrm_send_migrate() in net/xfrm/xfrm_user.c and pfkey_send_migrate()
> in net/key/af_key.c both hardcode &init_net for the multicast that
> announces a successful XFRM_MSG_MIGRATE / SADB_X_MIGRATE.
> 
> XFRM_MSG_MIGRATE arrives on a per-netns NETLINK_XFRM socket, and the
> rest of the xfrm/af_key netlink path was made netns-aware in 2008.
> The other 14 multicast paths in xfrm_user.c route their event using
> xs_net(x), xp_net(xp) or sock_net(skb->sk); only the migrate path
> was missed.
> 
> Two consequences of the init_net hardcoding:
> 
>   1. The notification (selector, old/new endpoint addresses, and the
>      km_address) is delivered to listeners on init_net's
>      XFRMNLGRP_MIGRATE / pfkey BROADCAST_ALL groups rather than on
>      the issuing netns. An IKE daemon running in init_net therefore
>      receives migration notifications originating from any other
>      netns on the host.
> 
>   2. An IKE daemon running inside a non-init netns and subscribed
>      to its own XFRMNLGRP_MIGRATE / pfkey groups never receives the
>      notification of its own migration. IKEv2 MOBIKE / address-update
>      handling inside a netns is silently broken.
> 
> Thread struct net through km_migrate() and the xfrm_mgr.migrate
> function pointer, drop the &init_net override in xfrm_send_migrate()
> and pfkey_send_migrate(), and pass the caller's net (already in
> scope in xfrm_migrate() via sock_net(skb->sk)) all the way down.
> struct xfrm_mgr is in-tree only and not exported as a stable API,
> so the function-pointer signature change is internal.
> 
> pfkey_broadcast() is already netns-aware via net_generic(net,
> pfkey_net_id) since the pernet conversion. The five other
> pfkey_broadcast() callers in af_key.c already pass xs_net(x),
> sock_net(sk) or a per-netns net, so this only removes the
> &init_net outlier.
> 
> Fixes: 5c79de6e79cd ("[XFRM]: User interface for handling XFRM_MSG_MIGRATE")
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

Applied, thanks a lot!

