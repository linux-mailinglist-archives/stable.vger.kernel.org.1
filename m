Return-Path: <stable+bounces-233516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKnbNMm91GmWwwcAu9opvQ
	(envelope-from <stable+bounces-233516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:18:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FC3AB356
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E665F30058EF
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C9397E83;
	Tue,  7 Apr 2026 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MEUzOSdg"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD603A1E8C;
	Tue,  7 Apr 2026 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549895; cv=none; b=nEZ3HawYR3/6gKvLr5Z+EA6/SL/pNcNMy5HrfzZjG01oPYI06J4rxV4pdmNlhqqFiwpQU51q5pCbLk5PxmVyXjbNOgEW22K1xO4ldgE+bdtk6cZ1W1JSuCFBtg6QRygi6YXBKQnRlWjYbL+dmi4slsysMFuYydfqCcM3WcEMCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549895; c=relaxed/simple;
	bh=5ok4QkEk2ecZ9Neu7GfeMOLUeAH3HVo1IjxeCHN9w8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej6ucQqm4lz5T4XVmXjYspdcQweSwfpr1rHuOql9dpbtUO+ml7rLCBvugNct/fdQs3IENBieWpWjAA10nh/l+56Lm/dwFCdDV3SV/giFAyHQJ+lSUUv6uSMRrbZKLNHnXPhtjHJqNhXb36mjHZPB4wsRX28dkqtrw94Datb4vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MEUzOSdg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BBF4520190;
	Tue,  7 Apr 2026 10:18:11 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id roCMZOOL-IYI; Tue,  7 Apr 2026 10:18:10 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8077C201E4;
	Tue,  7 Apr 2026 10:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8077C201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775549890;
	bh=Vgb6F9weC/Io1CmZ6aEL4II+s0NRunH5mXdjMYJvlas=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=MEUzOSdgo1HPgkvFtPhKE/K2cOxA/yJdyADf3ZZQskqg6cxXEUB/q68e1MN/zldge
	 ckzltEx3F75lvRsVEcEkKlNqijh0CpQX2kWoghBJs6ogjsunwIwrnoG6dELIG2WsPl
	 e+i63hxHiR06NeQWj3Tb1LkVPf5n1VNZYbRot87HKe+Yx8ruT9YezwSy0vm/9QR8Jp
	 wOxcU5QhU/vLzFzHv4NqNMxTzpAWZWbzWkya6tUrHOUpMXq8ysVsN2MZNe7yddHZu6
	 ySzyYHX3+mUlbNybDFMomybjUG/tsBQ6wsRhjyVX+WXod6jsHVhRdcefuZNQbcF7hA
	 rvlVW7goXPUFQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 10:18:09 +0200
Received: (nullmailer pid 1490357 invoked by uid 1000);
	Tue, 07 Apr 2026 08:18:08 -0000
Date: Tue, 7 Apr 2026 10:18:08 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qi Tang <tpluszz77@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] xfrm: hold dev ref until after transport_finish
 NF_HOOK
Message-ID: <adS9wGJ_JlLXdwtt@secunet.com>
References: <20260402114401.62212-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260402114401.62212-1-tpluszz77@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233516-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:email];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B2FC3AB356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:44:01PM +0800, Qi Tang wrote:
> After async crypto completes, xfrm_input_resume() calls dev_put()
> immediately on re-entry before the skb reaches transport_finish.
> The skb->dev pointer is then used inside NF_HOOK and its okfn,
> which can race with device teardown.
> 
> Remove the dev_put from the async resumption entry and instead
> drop the reference after the NF_HOOK call in transport_finish,
> using a saved device pointer since NF_HOOK may consume the skb.
> This covers NF_DROP, NF_QUEUE and NF_STOLEN paths that skip
> the okfn.
> 
> For non-transport exits (decaps, gro, drop) and secondary
> async return points, release the reference inline when
> async is set.
> 
> Suggested-by: Florian Westphal <fw@strlen.de>
> Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>

Applied to the ipsec tree, thanks a lot!

