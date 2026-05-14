Return-Path: <stable+bounces-247159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDD5HCaYBWp2YwIAu9opvQ
	(envelope-from <stable+bounces-247159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:38:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0253FE86
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81A56300C0E7
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBFB3A542A;
	Thu, 14 May 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvCy5jGB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6633655D3
	for <stable@vger.kernel.org>; Thu, 14 May 2026 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751521; cv=none; b=dlBOLtlKmriZC56KECEmhRG7ymX+Br2LjL5fhoQa+YJsW6v/WVNdEVVPj9mnIollIOFItPgqDYbr4sO5h1VkrJ+m9L+TbAYlRk13PuViX6MHe0lLxmebkPPZLG8vVtYsiXd22Z5enZJCxPbU9BKYRnwPbuga/MWwAH8V6umjOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751521; c=relaxed/simple;
	bh=wyQryMAcqgKBmpH59WF4pkW+5nGBprWHuGbAgn7gqQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM4o1TcVrFQAGI+zcPs+619gh8CN4NLFgyEbcKY4yEEBIf7aaY5mLpChjxmFydwRGygge6lZEgpQXNJGuyOw81lSPgnUWMKpsqxPvp4EHfmIZMqHfHxmFEUPwHShBGs4IFbClQ48EZrgUG45k7L4ZSKhBNPeBsW8/Xef2tXaew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvCy5jGB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c801912c903so3680051a12.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778751520; x=1779356320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjTEfY1YCfQns58oCl7WBrAFJdM70zfUdAnzlrIHCvU=;
        b=DvCy5jGBA2eYzTSPwwU8JkxilbOuazjVBJeV4Zeatv8VVeKiCDeizZh1ZnEV6AI3HO
         3ud+Oj9bLskVy7hPsx8qgufVX/lTOHAAITjLEVbMD4iarpvo+M3ags3IWzwkvHNjKmYG
         h5lhnTCOHRLS+17/uOZmwPwG0xnXAkmCZ/8AsDFPcgyGpCCZ8DcZ4gBLqyLeBkQfEJpJ
         7T5BSdTpqJ5AWYH47cQMz5rmjVPQgMyH6SX65UFIc0qnMrtEoR9dkWvpgtjH/T8yp8az
         RukrZmGUQmp8ykgUauzk9VwWmwjDPh0b/iZTjuQblVMCcCllOI/dsyp4qOJsoRL0pZqv
         OggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751520; x=1779356320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjTEfY1YCfQns58oCl7WBrAFJdM70zfUdAnzlrIHCvU=;
        b=gbo+hj1xHTGAGyN9EGjew8bIYhoizmnxsJ97KNk8Pmmd7pPUbhYJbELOQh/d2mGHsS
         qfOnOnOmr5BWPXPUbSr/IWLsZmSNcLcFjHUfbYpEgfIImRDJvb/CREYOreoSXXI3rMSS
         Zxe8JJ9EPjAiURpPVYKOHG7thYL6FyE1lW/9C5TX7zlhpjiIWXSwkpND5BZQ/jGBQkJA
         5nsag2IT8n6R+uXx+oFtyZxZRcvfw0EDu2ib+S9n7MS/tzewELTfrkfiHdhBqduXt+u+
         XjXIDGB4wTbjdDH4UAF7pAmu5nvkb4YwdzMyEZ2rV3EE1C3oAsvl7+BoG1hEvYPcyjPP
         dx6w==
X-Forwarded-Encrypted: i=1; AFNElJ9QxfpAjhkslVybGMElZFgiYkB5jfNMhyBS+9oSXvmASiRTHJH4g761/smmSLqP9Exe4mE6BU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNytEwwtYkQ8ucgpM37fhr580mkyVxpMKLb4eejjvxPBrxjEg/
	t4XjnprlRmpWm40mais17YfbNn00O78BNKgcVaY6+wJZ2W44XvLF8TEH
X-Gm-Gg: Acq92OF8BOKacIMeS/u3wYgk9ygO72TYfX8onIr49vK8UMQHwuBWwWufZK5iyvnjnEY
	TE5vDcEy14hM13JayNnuZGEBuuQKkeHXfKJW/yr2539MCboxGkPxXDCErKur3g46yOmLbqbP2m8
	1eh+ii121vJ12czYBYcjPa107+PzGW/V5ipRDVVWlksHQ7DSvzMsH7zBT7b8ptpPukp4YcaBygO
	9UT4rH5DfEEsz1Nksc1lV9DBgWRR/3gOPgHEX785G0gkGTkRgOjATqywN84kAI678+bY+yaz2Uo
	XumKXkl2eYorDkbX9OOG6eY8DM8EPQYyLoV/R55YFsdDmI5LlW1qdsgjBaXFJGIJrboNTSeI/mZ
	xoanalBoCTwxcFui1aoNMwF3tZ6sguI27/r6oZGgJ4hwxeYkBvJPTC7Pkvp9DvsnfGjI67lmyuI
	88s9qU1FlsW8sQ1emYVHGGKXhU+Y061TO9cL9wos0G8J0=
X-Received: by 2002:a05:6a21:3299:b0:398:79a8:5bf4 with SMTP id adf61e73a8af0-3af8197717amr8098006637.37.1778751519422;
        Thu, 14 May 2026 02:38:39 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff4easm1715464a12.18.2026.05.14.02.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:38:38 -0700 (PDT)
Date: Thu, 14 May 2026 18:38:34 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, steffen.klassert@secunet.com, netdev@vger.kernel.org,
	stable@vger.kernel.org, mhal@rbox.co, davem@davemloft.net,
	horms@kernel.org, edumazet@google.com, kerneljasonxing@gmail.com,
	herbert@gondor.apana.org.au, vakzz@zellic.io, kuniyu@google.com,
	jiayuan.chen@linux.dev, ben@decadent.org.uk, dsahern@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, imv4bel@gmail.com
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agWYGuJ__OtpgjnB@v4bel>
References: <agToIEDI4TaTNLRb@v4bel>
 <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
X-Rspamd-Queue-Id: 1DC0253FE86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247159-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,vger.kernel.org,rbox.co,davemloft.net,google.com,gmail.com,gondor.apana.org.au,zellic.io,linux.dev,decadent.org.uk,queasysnail.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:04:29AM +0200, Paolo Abeni wrote:
> On 5/13/26 11:07 PM, Hyunwoo Kim wrote:
> > Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
> > and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
> > skb_shinfo()->flags when moving frags from source to destination.
> > __pskb_copy_fclone() defers the rest of the shinfo metadata to
> > skb_copy_header() after copying frag descriptors, but that helper
> > only carries over gso_{size,segs,type} and never touches
> > skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
> > descriptors directly and leave flags untouched.  As a result, the
> > destination skb keeps a reference to the same externally-owned or
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
> > 
> > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> > Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> 
> WRT the 2nd fixes tag, I *think* f4c50a4034e6 would need
> additionally/instead a follow-up similar to the one mentioned by Jakub here:
> 
> https://lore.kernel.org/all/20260510084520.476745b5@kernel.org/

Agreed. tracing SKBFL_SHARED_FRAG propagation paths one by one is
not a robust direction for the fix. Even minor logic changes elsewhere
could cause the issue to resurface.

As a follow-up,	eliminating the in-place handling in esp_input -- accepting 
the performance trade-off -- seems necessary. That was actually the
direction of my initial proposal:

https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/


Best regards,
Hyunwoo Kim

