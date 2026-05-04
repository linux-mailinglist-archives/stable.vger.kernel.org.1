Return-Path: <stable+bounces-243897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHwzN8rp+GlZ3AIAu9opvQ
	(envelope-from <stable+bounces-243897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:47:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5824C2BD2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2205B303A538
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E03E558E;
	Mon,  4 May 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qhTFskNe"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E31C861D;
	Mon,  4 May 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920432; cv=none; b=dsP7LIYI8u/7AyPmMhsWQzqPNAtqyx8pW6i9HKv0INrlFpBhv2hptG/VhzLBw7kMen/+xyiyq3wMGiUsfUKJmSCSHe3Gn6wFaP/dT/450FqaPUQOA4KCca1E8JwN+RogKEx9tXGNSkhmStPcy1Y8f/JtAhfZsDoPXkKP2deJuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920432; c=relaxed/simple;
	bh=ooKABG1UIQOpk4XDvQ4ZgGq/90gV3GBvhbEteUW3Twc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVB1JDbyt/3mUU+fDJBjREcB1TjAIP3CB5uhLcwMfsMrbJScitpOi9GO2vNjmllGzPCjzVlekyi1exGksHdtHl7i0qdI7Z+2it4+H5Jptn7GI/t2SHi8YfRlYqQHBhuMJeVuRRllrcpjmDQ2Seoq9LLyt9k7Nbjuby25LdPdCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qhTFskNe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 88F3C206B0;
	Mon,  4 May 2026 20:47:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id luXGHua3mgxr; Mon,  4 May 2026 20:47:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 94ED9201C7;
	Mon,  4 May 2026 20:47:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 94ED9201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777920425;
	bh=FWNtkGtwPwLmCrtO0zvAOI2hWRI1VUsAUbFF5tXWqRU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=qhTFskNec/vQImAFLA2y97fVLplDsH6ywhmahKyMfbbh14KrwNFFjN80Ee7GEn10G
	 uFJvpjdHdxVmIS6j2066PSKmf7RbZM1YoQcjOSLe4xG+qhzDDUOuJkIKGmmk82hKE/
	 AehhoFsYt9uVrd4cTusT4Zbq9A91HUPVvLVWwGx+vZj6bDFbDlbJsreV52b1IDnhK6
	 NPE7Sp7UsoHNPsmwCgmnpNugMy4DdehflDVVkv4+Kj6bwEBkrZ4S6iDkdtbZGkynnS
	 DcUqK3rez3XIl+Ko4zLzcLPvTgJ/m3UHUnTkyjBF4071aC0WWK5HdcaiWGksi9cQSA
	 Oc55mmLQ99jMg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 20:47:05 +0200
Received: (nullmailer pid 3576883 invoked by uid 1000);
	Mon, 04 May 2026 18:47:04 -0000
Date: Mon, 4 May 2026 20:47:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
CC: HexRabbit <h3xrabbit@gmail.com>, <netdev@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb
 frags
Message-ID: <afjpqNXYFVfZjQl5@secunet.com>
References: <20260504152712.76305-1-h3xrabbit@gmail.com>
 <afje62FxYMuTUpSb@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afje62FxYMuTUpSb@v4bel>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 8C5824C2BD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243897-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Tue, May 05, 2026 at 03:01:15AM +0900, Hyunwoo Kim wrote:
> On Mon, May 04, 2026 at 11:27:12PM +0800, HexRabbit wrote:
> > From: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > 
> > MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
> > marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
> > so later paths that may modify packet data can first make a private
> > copy. The IPv4/IPv6 datagram append paths did not set this flag when
> > splicing pages into UDP skbs.
> > 
> > That leaves an ESP-in-UDP packet made from shared pipe pages looking
> > like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
> > fast path for uncloned skbs without a frag_list and decrypts in place
> > over data that is not owned privately by the skb.
> > 
> > Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
> > TCP. Also make ESP input fall back to skb_cow_data() when the flag is
> > present, so ESP does not decrypt externally backed frags in place.
> > Private nonlinear skb frags still use the existing fast path.
> > 
> > This intentionally does not change ESP output. In esp_output_head(),
> > the path that appends the ESP trailer to existing skb tailroom without
> > calling skb_cow_data() is not reachable for nonlinear skbs:
> > skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
> > tailen is positive. Thus ESP output will either use the separate
> > destination-frag path or fall back to skb_cow_data().
> > 
> > Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> > Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> > Fixes: 7da0dde68486 ("ip, udp: Support MSG_SPLICE_PAGES")
> > Fixes: 6d8192bd69bb ("ip6, udp6: Support MSG_SPLICE_PAGES")
> > Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> > Reported-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
> 
> I dynamically tested this patch and confirm it resolves the
> issue. Clean work.

Feel free to add a Tested-by: tag.

> One correction request before merge -- please drop the
> second Reported-by tag (your own) from the trailer.
> 
> The report and patch for this issue were already posted on
> the public netdev ML 6 days ago, i.e., the bug was already
> publicly reported:
> 
>   https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/
> 
> Credit for patch authorship is adequately covered by
> Signed-off-by alone. Setting aside that your work proceeded
> independently rather than as a review of my earlier
> submission, the trailer should conform to convention to
> avoid future misunderstanding.

The issue was reported independently, so both Reported-by tags
are valid. But indeed the Signed-off-by tag should cover the
second one. I've applied it to the testing branch of the ipsec
tree to make it available to our test systems. I can still fix
the tags on request, no need for a v3.

> No objections to the patch itself.

Thanks a lot for your effort!

