Return-Path: <stable+bounces-246965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ9FChOyBGoQNQIAu9opvQ
	(envelope-from <stable+bounces-246965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:17:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C108C537D8F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C59C3012232
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9393911C0;
	Wed, 13 May 2026 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7DpjLws"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62F2248B4
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692600; cv=none; b=POJCmSMsBR5a4DlI78wWa/ryN0020hYUA7KqDeTHgh8/KZ2Tvp/OkG5p/BNmwSTjeVPNXg/hPeiTOiRBaUfCbXccwui+N0kwty6zCMs4X05JrijccKSaX+0Npfki8gVOy63q9LDN2YNFzX980/hxzpaBgE4/zi+O4JnaJn3kIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692600; c=relaxed/simple;
	bh=faSlA/Gy4+hGhFjhHo18QPT5jT1Kuy+RVGGvkXN4szQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApOJt7h7pofpbJhWvVpFlappAgn7q4z8gkBQ3NtqM7HvA/O/y+om6CLF2LZqaidnUfyNtpAKbKN+S0/H9x1NW7Eb1/Ky9YZ8LD72LyQeKeY9XNjfMN61BS2jcGOZpC5KCNexI3eHH+Ei63YmjcWUL9woVsdlLOyIuxdYWc/yh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7DpjLws; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so5345590a91.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778692596; x=1779297396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZWcV0rAryTMJnbVXU/76vXU1STIeSGIC5/F+Khj1D8=;
        b=K7DpjLwsdDF8MGXRqWdydrjl1Qb0oEYyIvSmu47ohVZwaNOGTNYi4FllQr6alceT7f
         F3jnWfJbE3xOnLdkQo4zSAnGxev8fWkUxVLl+AgMIKdD12aQVG5CWNGaY1djwJnbo4y6
         jZOYR3f3amke4MpTgivCdN2zleQJqEy80fNY3spvdSHwvfKIvDcK+rR5jeD0OmM30bnZ
         5n/giydgPctb6JVyQehb8IGNr1sh408f5MKEkDrLPNhZok89F2Y2QbHs1TeMucGsXd1u
         7tCztZC89zdWbGEJrcoP7OYeQIfmU3KhqJz3An2Rdhdfv57A1R+e5nBBM/HCZ1aSjND3
         KYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692596; x=1779297396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZWcV0rAryTMJnbVXU/76vXU1STIeSGIC5/F+Khj1D8=;
        b=QTg74jV7EnNjAbBHNXAQZGRowHX5roCVlJwPg9tXK+JpW6MqBF+Sj7JCeBrXdHlzuj
         8Lh9sU7NsJDgR1Zi3B246agt/6Q/liUaB1/trD6OKI0N6dn+mC4XIK1Vj7A4yDqBd/W2
         VyjJHTXfxNKOyNfSPByZwbJ6O7wC4USztVO/1+oYTgyYhCOSnc7pWg9IaHYguz1A4uWB
         mDu44Oe2Uy8qFKrlJPQVaikHj9YkEHwxR0dpSRmwTmBVS/zJoZvVuzT8Q7YzNg3TOY59
         idRdUE+yNccJd4hzH4jW6cKcsqD0g9y9JxYuFRMYvgGfOsODmN2wD5dP0vJ9ifczKdYc
         quWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MUNlu4N8vjiInHrcgQS7CS6laLiEZ2qy5/ca0xMWqZydMtPK+/uTUrH/FAEnet4f8wue+kjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIel/8INZhRG1hl2p4Qp1J0ZHlz/PUUZtBdh1l3sISzdIz3r9
	Zb70NJmlNlqmpp9lTi7/QXoQvrweZxFbPB981BoScoxfWpcRdEIHdoIx
X-Gm-Gg: Acq92OEaEHpMOOKNmQH1gJGFYtx8cGVwquoS4+iA+sL0WtwzJOW2ln6sOqBeLNyRpj7
	AL+/bB3pDuhuF05lb4fXHDkv8UdRM/yB3LYagPjr8N7Yc0cW8fj0Q4FS2SsyGnhL0Tu+b/zvPe1
	5Mgz/+o6YhVmszNRmaE17nEewA1+1Pv2tGtQk5k7phzGpqdbJiL2zrQVTXAZMgNvD86LTB/hGFz
	ZFBT6WK/GIGV3T9brTG9CGbUiVMmoqwdBU84pZR01VNTCmXLUU4nwlYleIrraB/6lXM7j5cYKdJ
	HhzeanGSWlb3ewsrUmkgZd0GXuPGQcxiaVw3v3dU0brNrseOLDnSwUV33hUZWo3rUe1RmrKAEkj
	Myz/dtOh3Umu2TzJCirClGcZp0rzs8adH1pQ4LlVLB++Z116SZDw5G1c9qOJ1PNh+84NV7LcxFM
	D8PHQKtpR8q2SpwH6VKOzy/mzQdrLdWDoAV46YE8H8GXruiTFsHbpJ6PoY1A36PtCy
X-Received: by 2002:a17:90a:a81:b0:369:1dff:6bd5 with SMTP id 98e67ed59e1d1-3691dff76dcmr743122a91.17.1778692595883;
        Wed, 13 May 2026 10:16:35 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368eddf5161sm5087917a91.2.2026.05.13.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:16:35 -0700 (PDT)
Date: Thu, 14 May 2026 02:16:31 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org, vakzz@zellic.io,
	stable@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] net: skbuff: propagate shared-frag marker through
 pskb_copy()
Message-ID: <agSx78pXBFCdn08p@v4bel>
References: <agRfuVOeMI5pbHhY@v4bel>
 <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
X-Rspamd-Queue-Id: C108C537D8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246965-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,zellic.io,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 06:21:45PM +0200, Ben Hutchings wrote:
> On Wed, 2026-05-13 at 20:25 +0900, Hyunwoo Kim wrote:
> > __pskb_copy_fclone() shallow-copies the source's frag descriptors and
> > bumps each page's refcount via skb_frag_ref(), then defers the rest
> > of the shinfo metadata to skb_copy_header().  That helper only carries
> > over gso_{size,segs,type} and never touches skb_shinfo()->flags, so
> > the destination skb keeps a reference to the same externally-owned or
> > page-cache-backed pages while reporting skb_has_shared_frag() as
> > false.
> >
> > The mismatch is harmful in any in-place writer that uses
> > skb_has_shared_frag() to decide whether shared pages must be detoured
> > through skb_cow_data().  ESP input is one such writer (esp4.c,
> > esp6.c), and a single nft 'dup to <local>' rule -- or any other
> > nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> > skb in esp_input() with the marker stripped, letting an unprivileged
> > user write into the page cache of a root-owned read-only file via
> > authencesn-ESN stray writes.
> > 
> > Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> > were actually moved from the source.  skb_copy() and skb_copy_expand()
> > share skb_copy_header() too but linearize all paged data into freshly
> > allocated head storage and emerge with nr_frags == 0, so
> > skb_has_shared_frag() returns false on its own; they need no change.
> 
> What about skb_shift()?  It seems like that should also propagate this
> flag.  But I could be missing some reason why it's not necessary.

Yes, since skb_shift() is also a function that moves frag descriptors, 
I think SHARED_FRAG should be propagated as well. The actual trigger 
conditions are tricky (not deterministic) due to TCP write-queue skb 
merging, but I believe the fix is the right thing to do. 

I'm planning to submit a v2 patch. What do you think?


Best regards,
Hyunwoo Kim

