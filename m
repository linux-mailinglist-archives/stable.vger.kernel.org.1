Return-Path: <stable+bounces-247235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A2XLCfvBWpWdgIAu9opvQ
	(envelope-from <stable+bounces-247235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:49:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48847544440
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8F9307939D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA52857EA;
	Thu, 14 May 2026 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="D1BVIKXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJdzz2/T"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6539175A6D;
	Thu, 14 May 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773552; cv=none; b=p9aXCXXyZ5aX1ZU4rm0OzGwi7dwoToiRGqIbaC838pS7+gLN+tRdcQuQvpftXwgG0/FJIrYX2HuiuJ7FvweP7dsgAWEfzRwSXokYsyFPcUdEx5ALbdbXvrzqf0RWYm045IsdHcOgjdE/kQ7ORTArBS2U98iab+8JkxlolrZSOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773552; c=relaxed/simple;
	bh=2eZQ28o2aeUb29+g7yRCupFzyRVNMQupfH8jXxpZaOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKGsBmANOWLh4YNRfccH+dJ/nnYEiY5uYromck4rRP4DOd7PchgyqIgpFsfOUc7nWfSDgDItFwiNEIFUtL41DjPMh3HN/cMJRG52vTLnJ9qJO02mSPXKOQPLNqAaXognGx1mH3LX8IYGtMEaLZRUYsQL/81bJHr0fkLHpX41F6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=D1BVIKXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJdzz2/T; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC65B14001D8;
	Thu, 14 May 2026 11:45:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 11:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778773548; x=
	1778859948; bh=UsgCLgF9UwbEiwmeUtgZkK88jnAqNvlDzxdt4itg7V4=; b=D
	1BVIKXX3t118XISFBRL8rWMzGtSS2KpxPIqjLYqAT4Yd0mVS0cpvJDR5lF1KiNBy
	PFmBa0HSNn1SQ3MnyY/Li03JHCjN3OPUyjfneHnhzqHNIfWp+eTr+EuK/2Oel7MB
	DVTiu6DLPxDjDVNb2edWFSe8Oy/7cHD6xk9j1xfLSudbDDhIIUq+a4MBV+XvFbbt
	62nhUNzQpllx+Q/jMiqp0EuQNwOas3fJSFueI6x1vVaDiBKRgOR/F5gDLcow1h7o
	zmfwSsRzodSRVaozpa4uMOpHmOkScp7ffg69m+289trqw+A4GwKNus74vB7TF+mt
	klcB0NvzEJczYRmboO6ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778773548; x=1778859948; bh=UsgCLgF9UwbEiwmeUtgZkK88jnAqNvlDzxd
	t4itg7V4=; b=RJdzz2/TR+QVl1zoMiTFWHiec21D4kFmQ0x7ovD42KVNs8FxzqF
	mqWSTpMJUW8Q9x+22W9YtenEnspnIXFOplhYWe4MnCMHY37hyqPBMjlC5C13IEHE
	eyo4XwsJlk+YDD+hrTpWvlyDFYgX0laTU5jNSUZabl2BmMnU7fCYsAlfkI5s3VSJ
	73omUKCt50huhoXdTqJWijgzWTRuvSWBYjucrIOgnwjKfNCN4FT5vMz6fhY9Bnvo
	7D1iI5w7SXJMlTuo7aUwiKs9wsogMsdYU7lSnxJ1Qmv2XMGXzM+evV/wMuEbx1Vv
	gXH5LCTw5kkE+6Cy9PcTjJZfSTjFHsbHI0g==
X-ME-Sender: <xms:K-4FarvkBKr5b1gO1rTKdYgErAJEhChKJc0uhmTPe0C74qc6kf5D1g>
    <xme:K-4FaoYkPhmSyOY71Cr4hAcgnDm1Mb1bNegZczKAEWyGcrBrlXtwJHtVVSz_K92m1
    X1UclImawhjKfS6v1j_gH5xj9ux1hyJlgQbdRyRqy-gZjHDO2Bq1_o>
X-ME-Received: <xmr:K-4Fak6NrzY0x8wYzSPH5JXyAJOqjHDnzlqjbdRiNZBnYYDU5q18GNTmJqaTJ9MJ9Pk8T47slHXPCk_TZQyDUkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepihhmvhegsggvlhesghhmrghilhdrtghomhdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmhhgrlhesrhgsohigrdgtohdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvght
X-ME-Proxy: <xmx:K-4FagkXQQwfMnTmZ7T5ECYM1M7Umkhwmp7ung3959P03VQ3notdww>
    <xmx:K-4FaqGXdMkQOR-oAgm46DzdNUPxhv90R0XyTO3asgFUKY8EtZlY_A>
    <xmx:K-4FakHRc4p7vcfOGwFI7Ty7ko_TOimfiUHCCihhccQSdRrypZ8yTg>
    <xmx:K-4Fai2e25FYnrtz6vUVhzwObrJA-9DGiU-XzzMt-fP6Ulz2A55Prw>
    <xmx:LO4Far8mub6S-7QFXXVHA-scgYyjyF_Ydv3EFoQfd_RDJZ3rZVxcsW6J>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 11:45:46 -0400 (EDT)
Date: Thu, 14 May 2026 17:45:45 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: David Ahern <dsahern@kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	kuba@kernel.org, steffen.klassert@secunet.com,
	netdev@vger.kernel.org, stable@vger.kernel.org, mhal@rbox.co,
	davem@davemloft.net, horms@kernel.org, edumazet@google.com,
	kerneljasonxing@gmail.com, herbert@gondor.apana.org.au,
	vakzz@zellic.io, kuniyu@google.com, jiayuan.chen@linux.dev,
	ben@decadent.org.uk
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agXuKbQMVTYT5Jgb@krikkit>
References: <agToIEDI4TaTNLRb@v4bel>
 <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
 <agWYGuJ__OtpgjnB@v4bel>
 <agWiDlvu351MSuqO@krikkit>
 <69f72d09-8054-4d26-b277-9e9b7a8854c1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69f72d09-8054-4d26-b277-9e9b7a8854c1@kernel.org>
X-Rspamd-Queue-Id: 48847544440
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247235-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,secunet.com,vger.kernel.org,rbox.co,davemloft.net,google.com,gondor.apana.org.au,zellic.io,linux.dev,decadent.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-14, 08:37:19 -0600, David Ahern wrote:
> On 5/14/26 4:21 AM, Sabrina Dubroca wrote:
> > 2026-05-14, 18:38:34 +0900, Hyunwoo Kim wrote:
> >> On Thu, May 14, 2026 at 10:04:29AM +0200, Paolo Abeni wrote:
> >>> On 5/13/26 11:07 PM, Hyunwoo Kim wrote:
> 
> >> Agreed. tracing SKBFL_SHARED_FRAG propagation paths one by one is
> >> not a robust direction for the fix. Even minor logic changes elsewhere
> >> could cause the issue to resurface.
> >>
> >> As a follow-up,	eliminating the in-place handling in esp_input -- accepting 
> > 
> > It would close this group of vulnerabilities, but there are other
> > parts of the networking stack that consume this flag. For those,
> > chasing missing flag propagation is still a useful task.
> > 
> 
> Seems like this should be an skb helper to manage the flag with really
> good documentation on when it needs to be set, reset and propagated.
> 
> I walked skbuff.c yesterday as well, and there are several places where
> it is not clear if the flag needs to be propagated or not.

Or maybe even something like a skb_transfer_frag that handles updating
the frags array and copying the flag. Then we wouldn't have to chase
functions that mess with frags[] directly and forget to also adjust
flags.

-- 
Sabrina

