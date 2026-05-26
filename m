Return-Path: <stable+bounces-254298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKdbAk93FWrHVAcAu9opvQ
	(envelope-from <stable+bounces-254298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:34:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1F5D43E4
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCCBB302DF65
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE883DD841;
	Tue, 26 May 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AM2Oa65E"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AC2C326F;
	Tue, 26 May 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791419; cv=none; b=oFrRIDOEWU4wOSd19eqXf8172tTyQ8LdSaFibt4bORX3vKSYot1Qeue9Mlik6X5pDOmwk1MQrhQGczDiq8FFQAfBmgLLZN8s4muqNIGfNQzz1kt60tVr/fTKBspAXhtGO0+TZjnTEBMvs97GSEYc+yzfJi58/pdnggvncTKI5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791419; c=relaxed/simple;
	bh=RTstCOb6AtmXU6bU6trvm2Qqjs6+DgrFN4BlFwsHraU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpOZ/898KG51W+4tMQx8EUu7sDzmDa53VnJHTVJ2WAh9OGJXa9hhb06dNwPKZv5gO4urRc/T+ixoJzpn7A7Nh2Q1/cSPLolHIKtOd30xE+5BVl4v6gum6VnlLGkee62Hb9Rl4mKe13Ypyecn8ssChKlIWahtqLXATJnDa9rjJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AM2Oa65E; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0FA38206B0;
	Tue, 26 May 2026 12:30:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03ipp3RjgGqs; Tue, 26 May 2026 12:30:15 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 73B6C201D5;
	Tue, 26 May 2026 12:30:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 73B6C201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779791415;
	bh=1tJOBC6RgUfctiWtdnMwrlRb31wlOuFPGItmL9H+Uqk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AM2Oa65Ecs5FkbQt41RUpjAMCRVnS8yhDyZbhC5ZS48J3Gxiiy+osvKGHP7lw6Hrs
	 ZSaqPitp3FeWZMThvHsDuPCArXwpV0RiGBlfegiT0a37kB23zX0eglH3PNBAhpuztb
	 7jn1zlIUTJ313Puqa0I9pC4c9G/94n2OTU1nEEfEwEkJYC9hd8hsgO6J5vfdQyZANr
	 uuZaNLccG4L6AdlRKSvzBdJwydctfelw0AYq1T9jIgRKAMo1IefANpCaxO1uUvuSy8
	 dNlzhHqv4bBcHFo2KyFhslKgXBkMzLk7SUiRpmttR1AzSqR7DKKKEV0OiHCCIT6WXQ
	 uzrXW8NFw/sfA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 12:30:14 +0200
Received: (nullmailer pid 228777 invoked by uid 1000);
	Tue, 26 May 2026 10:30:13 -0000
Date: Tue, 26 May 2026 12:30:13 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Takao Sato <takaosato1997@gmail.com>
CC: <netdev@vger.kernel.org>, <w@1wt.eu>, <davem@davemloft.net>,
	<herbert@gondor.apana.org.au>, <chopps@chopps.org>, <pfalcato@suse.de>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v4] xfrm: iptfs: preserve shared-frag marker in
 iptfs_consume_frags()
Message-ID: <ahV2NRIqdbW-kDDx@secunet.com>
References: <20260526004035.1023696-1-takaosato1997@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526004035.1023696-1-takaosato1997@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254298-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A1F1F5D43E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 09:40:35PM -0300, Takao Sato wrote:
> iptfs_consume_frags() transfers paged fragments from one socket buffer
> to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
> the same class of bug that was fixed in skb_try_coalesce() for
> CVE-2026-46300: when fragments backed by read-only page-cache pages are
> merged, the marker indicating their shared nature must be preserved so
> that ESP can decide correctly whether in-place encryption is safe.
> 
> Apply the same two-line fix used in skb_try_coalesce() to
> iptfs_consume_frags().
> 
> Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
> Cc: stable@vger.kernel.org # 6.14+
> Signed-off-by: Takao Sato <takaosato1997@gmail.com>
> ---
> Changes since v3:
> - Corrected Cc: stable tag from "# 6.8+" to "# 6.14+". IPTFS was
>   introduced in v6.14, so earlier stable branches do not need this
>   fix. Pointed out by Pedro Falcato.
> 
> Changes since v2:
> - Removed security impact paragraph from commit message as requested
>   by Steffen Klassert.
> 
>  net/xfrm/xfrm_iptfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 97bc979e5..4db85e158 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
> 	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
> 	       sizeof(fromi->frags[0]) * fromi->nr_frags);
> 	toi->nr_frags += fromi->nr_frags;
> +	if (fromi->nr_frags)
> +		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
> 	fromi->nr_frags = 0;
> 	from->data_len = 0;
> 	from->len = 0;

Your patch does not apply to the ipsec tree, please
rebase on top of it.

Thanks!

