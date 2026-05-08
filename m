Return-Path: <stable+bounces-244695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HC7BECZ/WkJgQAAu9opvQ
	(envelope-from <stable+bounces-244695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:05:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF44F376E
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951463009CE3
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7386A373BE9;
	Fri,  8 May 2026 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5MS4k0B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7422423A
	for <stable@vger.kernel.org>; Fri,  8 May 2026 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227513; cv=none; b=Z7PkeasyNzC+ZrIfMWAOGkRHKTYx5p+pwbCXYpIh9JgTsAzuUXN2/nfAWSxGOqso6Ku8B3Uyq9k6+n9+li2DssgLSK8RoWk6NcYFYgFHbe7rxUPKCf7a97jXhQjPHKLheV4FtJxSUSvBZIqWAgNmcIINLNXi7M3EvOTDSnlKR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227513; c=relaxed/simple;
	bh=bUGg1zQZFjk2vrx8iWze362hyCNip3NXDXO8yXbGiyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV4wH3gNsOeJCnLnohyxqXy10KSdH8lIt3qVlOL38y5ZTOe3SgZfAj2v44jK3NhXsUZzil6XLNxgpBKnx41BsmgXgwM5gT0x+JWLCvbpmzfg4Mr/klsNWY2k+NRFdA05P6PVQzqF3IewupvE2dW0UJWlhXQvFYqirVujvKMmt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5MS4k0B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba21d32776so12363605ad.2
        for <stable@vger.kernel.org>; Fri, 08 May 2026 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778227511; x=1778832311; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MiizINovSXJGTZYnX3z1Q643KSdKiG0zUSqLPzbaFsM=;
        b=F5MS4k0BiREGhHGIsfzrRikOXkbDfmEc9LxX7dZDeZL3z77KaDqlIwpfv8S1+CVUfG
         SKQEA2xfJ/SimeafHKILreuUy4dGS7mNrVfDL3McsfsemXfHBIcdgJVX6tm+dvDw6IBZ
         h000pmED1yPFEaI4TovLOcur5ft0ZZTduXSaEK+ZQEJ53f3fFp1jpdnVKrliFdCBHszh
         RjUT+i/E3bskEeAmfESivNgTZzLEwe0rLfp7KjNd8hIK6a1Gke/6IUONkfqoSX/uKe9S
         o2u0s8m11mr6nrcA7X2YbYRLXIKemTh30cOM6nuFYsJzGehqL1pxLkV5nnznrv8O4GJg
         C7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778227511; x=1778832311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiizINovSXJGTZYnX3z1Q643KSdKiG0zUSqLPzbaFsM=;
        b=rfz1bR2nveb2GELuFOuav+Abduz8tyc5LrPZJH2HsMmFxq8BslHHVNGqz9ub1U5i0f
         VPP+chaeNG2Z5a7svYuNp8Q6ti8cCRrG+BtqJV5G5YuKOU7j2SWj4LXADuNnQxx3tjz1
         0jMKINe+RAwUdVuKGp7vsgLTe+fF+nGeTiuBfMZBpIe/cl6+xyr7AO6nVp/wOM78k9eN
         cNStmaDc7Y9lHpTygSRA5FW6/uu4KD6BRxCpkUYe6QI6U4yqjE076Q26l3B+Gdb9UXqE
         NQQaJh1TMXcu+ayCg+2rt/eHXdI/CG93xe9e+oFGyIEO0NFJbWudOGrG7yVAKM6Fv196
         u4bQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HsI6DmgZ5yjlV1uSb8qZevs0lqXTs5OtAt+f0+xlBYym1F3kAtjo70pfsb5cmXe+VGPnnM9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZdsViWHNh9IUKOJKemYnYSXlW0qq4z9kbZv567UW+I0WbZ0V
	jgXp2dkRXG5xpW4+1oGo8rQYxzdzGE7kxIkbjYeHfqR2MY8tqhGUw9ho
X-Gm-Gg: Acq92OHyFEXUmje/2Lf2GiCcIXmbZbmpxNiTJCG4EP4WTxApPq21BuQ+sKzl8EyUDRE
	X0WWASf/y/CpMPe6rwVaChIAYZ5YCFOyS8mTFZk/z7P7CrQcx4Nt1CCBj8eDEbhcQB0suuh/+wK
	rnppERIJ9jH2oIpI2NEQ+m/zkpqgZPMohFpiz2Z4UPhAGVGeavi333j5d2xREIzKPfj9WQ9LHYu
	Qwp5Wq2vhzNig5BaT4YfPoHXp7D7LI9Yg5o6teeJzg0nbnCvZtmQP2DBlnJujMFsIDaNMulf89s
	o8a+KLLZ0sE3BvZSAN0eiFwjq0C8qoWtJpHJxQ2I3S5vYSKgC2DrwhuIDIzCrFH6oavu8G1OrQs
	uUJ9tCA/IKp1Zlrm26iFy03VL8ME+HYp34mI8F72PrHSYJWaGZ36+Z5bop6rJm0CR06sfGBcu9c
	Bjc3qJURqx/63eQSjREsyflIZ36DZ7HGTbCHL9sUn/Rvw=
X-Received: by 2002:a17:903:181:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2ba79287515mr116584445ad.20.1778227511279;
        Fri, 08 May 2026 01:05:11 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebe0e8sm13850335ad.76.2026.05.08.01.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:05:10 -0700 (PDT)
Date: Fri, 8 May 2026 17:05:06 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, qingfang.deng@linux.dev,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <af2ZMmJ4Oa0tscfC@v4bel>
References: <af2F1FU5d4Q_Gn1W@v4bel>
 <6a1a50d1-9aa8-406d-90b1-4d5ca9fe0afb@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a1a50d1-9aa8-406d-90b1-4d5ca9fe0afb@linux.dev>
X-Rspamd-Queue-Id: 63DF44F376E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244695-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:58:34PM +0800, Jiayuan Chen wrote:
> 
> On 5/8/26 2:42 PM, Hyunwoo Kim wrote:
> > The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> > handler in rxrpc_verify_response() copy the skb to a linear one before
> > calling into the security ops only when skb_cloned() is true.  An skb
> > that is not cloned but still carries paged fragments (skb->data_len != 0)
> > falls through to the in-place decryption path, which binds the frag
> > pages directly into the AEAD/skcipher SGL via skb_to_sgvec().
> > 
> > Extend the gate so that any skb with non-linear data is also copied,
> > ensuring the security handler always operates on a fully linear skb.
> > The OOM/trace handling already in place is reused.
> > 
> > Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> > Changes in v2:
> > - Use skb_is_nonlinear() instead of skb->data_len
> > - v1: https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/
> > ---
> >   net/rxrpc/call_event.c | 2 +-
> >   net/rxrpc/conn_event.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> > index fdd683261226..a6ad5ff6ec5f 100644
> > --- a/net/rxrpc/call_event.c
> > +++ b/net/rxrpc/call_event.c
> > @@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
> >   			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
> >   			    sp->hdr.securityIndex != 0 &&
> > -			    skb_cloned(skb)) {
> > +			    (skb_cloned(skb) || skb_is_nonlinear(skb))) {
> >   				/* Unshare the packet so that it can be
> >   				 * modified by in-place decryption.
> >   				 */
> > diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> > index a2130d25aaa9..632cbeff1f5d 100644
> > --- a/net/rxrpc/conn_event.c
> > +++ b/net/rxrpc/conn_event.c
> > @@ -245,7 +245,7 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
> >   {
> >   	int ret;
> > -	if (skb_cloned(skb)) {
> > +	if (skb_cloned(skb) || skb_is_nonlinear(skb)) {
> >   		/* Copy the packet if shared so that we can do in-place
> >   		 * decryption.
> >   		 */
> 
> 
> Why not adopt the same gate as the ESP fix:
> 
> 
>     skb_cloned(skb) || skb_has_frag_list(skb) || skb_has_shared_frag(skb)
> 
> 
> so NIC page_pool RX keeps its zero-copy path while still catching the
> splice-loopback vector?

Yeah, that approach preserves the fast path. I'll test and submit v3.


Best regards,
Hyunwoo Kim

