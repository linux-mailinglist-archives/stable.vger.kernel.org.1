Return-Path: <stable+bounces-254188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCytKY+HFGqPOAcAu9opvQ
	(envelope-from <stable+bounces-254188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:31:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5055CD63B
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9757330054F3
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB82BF3D7;
	Mon, 25 May 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxV51+2D"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD41A38F9
	for <stable@vger.kernel.org>; Mon, 25 May 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730317; cv=none; b=JKGsRtudU/22rUil37abM4ZmAwc22tSmys56Fek3b+zLhEwtXt9Xo8kT4BPpAFY7oORtJS3xcfgKWqovAY8lyHOdgxZobGSN3M55xT9XGFeHnvqs+XpI5/ktxG5BsSbn10JlbbSHs5GN+pbSi2sdS5cB6FivP6muEJfvPRt7WV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730317; c=relaxed/simple;
	bh=WzdSh1B+2qm67QydYdUWnUTv+HJ49Td2uHEwz5Mt8Zs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YmpwV1p2Zmz1AmJZoL3XwclWtCKg8/uS/EVQRkfhpy5EaNxp7sEu/GJfiN6ka550BYASzRK5BsMeVPZrKjIY2fP2hSQi0FSZ0errd1eLmldeL2zqHm2vJ1x9tRXYWClcSR4qoTHnTjmWcR8hZmY3GBAB+VGTsYl7p1pnSqyHxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxV51+2D; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7c58e6eb2c8so95106747b3.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779730315; x=1780335115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG7IEgFs/m1oFs1/lf3+pd8kkR0y0NNeYlLItnr/YTI=;
        b=hxV51+2DAhw75Ua02ayLeC5ZdF5p7aCKykbK2CfIhyP37OiL5AaLtjDIkViN7b34/3
         p3IB6f/hQy7TAu2cvFPdzbZYMTgyXwcywhoK4ANru9Ao//jobh59FxoGzGgodj2mj2n8
         SPSLqze/+GC4+x8u/hWvq8x7qc0rh6fB7Dv+cNz9Os6SxgWJN8yzerGzKJ8vQCe8sK3s
         X6VaTQUhZYBmuZGnwVVYBbpuTWPOVwcTJ3HMml//VVeGxO8ht99h6a7/os1dr5ZG9OLc
         fZWsiB49MunnUBUDfngpE+vqwO3EaiK4aFcJX45CKRQiuY2kIXWIVHS9SCCnVGo+PeQY
         wq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779730315; x=1780335115;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HG7IEgFs/m1oFs1/lf3+pd8kkR0y0NNeYlLItnr/YTI=;
        b=sAKopbBxQqambfBdliuewM1wQDa+jYQFG2kArAzDKbIJbKBjrSzCHboB38AG5kGKzr
         Vh2vTV+Ykl6+xNP6tH0MT8cwTE+dw5n+orirVDh8cehUDygct+cUOtvRJuX0eVNWa3MQ
         gwMvaK21PMhTWF29xpnXg4nGkmH6QC1wonfaJ6seuigouWXzvezsWM8P7/UWxkCA91Vz
         iBoz9VqQorSLoiuzz6JD/1uddWHNd299zK1lmk1If5pLW/uAd1wfO8K/CDF2iQQHzVcg
         AvuVgUHpdnOjXK5tQ8M1Mg+get895qFA+BkxKMrOWEhzREreP+ZO0buxywRxf+/n4hKI
         pf4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8sQA1DXW6bx6tnnh99g9c6hDQ5FaYx/6dp/TYOoEtP9ZFkNPzfF2UNUy4DYVPJEqnAny8VOtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xCBpudsqesLB4rCI1PrP+hkN1ysRwE4dJ1So3UYUCCE0fdGO
	10s3tl9tcHxi8mXwRgUnbbfLASXT7Xs4oD8xOBNRl2QvDnyUOlVRmV/A
X-Gm-Gg: Acq92OFbi1RzQ+ZXgLHXeO0NooHKZbFeDi0/F45PFuzMUtiSO9Bi0Jk0qUyqZtOANS/
	7750ydxWBE2FA/Ggm04PKB+dRh6ewfX/elKF3xBviTFg6dxBds4/1b/EeK7x0gUHAgOqdv/8u9+
	JOxN5YzuEEKnMxRvNQpo3f1qH4Z49ZBBM7IqgZ2/mHtxZ6aqG2NUa35a4kfQWuXoa31d1HDQlqt
	aAO2yYRm4W0HJD+bl2UycXi/Ja+4fkL+ZQwzKSzZIjCE3+OmiCIBSX9wJLT75h7MAWOMsI0L79b
	iACzLNXsQfU0WvqaDOhjCX8aBzeWFJV7K1HPLWrOSo0AnJ2blpLsUXWNYo/24k6CVwoBK7DhuGy
	kDmCCKVvIhtrkAs0mLyNXIhkd8Mq2oRfo5ugvaB4unDumxovxuEpTgcFvQXvPgNe8hA1jS46Qgq
	4D87Oq18QhnQTSsHstaC35Q0501pS9+CxRMoi7N3ebx/4XGNE0LMpIxiYgZXYsjTZTiVGeOlDVo
	Oyt21o=
X-Received: by 2002:a05:690c:968c:b0:7d0:354c:6594 with SMTP id 00721157ae682-7d3373ac29dmr173365357b3.33.1779730314707;
        Mon, 25 May 2026 10:31:54 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c435b54sm48694267b3.40.2026.05.25.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:31:54 -0700 (PDT)
Date: Mon, 25 May 2026 13:31:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 lazyming <minhnguyen.080505@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 w@1wt.eu, 
 security@kernel.org, 
 linux-kernel@vger.kernel.org, 
 lazyming <minhnguyen.080505@gmail.com>, 
 stable@vger.kernel.org, 
 asml.silence@gmail.com, 
 achender@kernel.org, 
 mst@redhat.com, 
 jasowang@redhat.com
Message-ID: <willemdebruijn.kernel.2a4ec672bf2d7@gmail.com>
In-Reply-To: <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
 <willemdebruijn.kernel.27d7990b24613@gmail.com>
 <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
 <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.455];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B5055CD63B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Willem de Bruijn wrote:
> > > > lazyming wrote:
> > > > > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> > > > > the old skb_shared_info header into a new buffer via memcpy(), which
> > > > > includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> > > > 
> > > > These functions are not supposed to maintain zerocopy frags.
> > > > 
> > > > Both call skb_orphan_frags.
> > > > 
> > > > I think what may need to happen is to invert the order of that call
> > > > and the memcpy. Current code:
> > > > 
> > > >         memcpy((struct skb_shared_info *)(data + size),
> > > >                skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
> > > >         if (skb_orphan_frags(skb, gfp_mask)) {
> > > >                 skb_kfree_head(data);
> > > >                 return -ENOMEM;
> > > >         }
> > > 
> > > Never mind. This actually corresponds to the first Sashiko report you
> > > mentioned: if zerocopy skbs are converted, then the memcpy prior to
> > > that call will have stale state.
> > > 
> > > For skbs where skb_orphan_frags does not do a deep copy, we do need to
> > > take this extra reference.
> > > 
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > 
> > Not sure the potential preexisting issue is reachable.
> > 
> > Vhost-net and other zerocopy that predates MSG_ZEROCOPY does not
> > refcount ubuf_info. Instead it calls skb_copy_ubufs on skb_clone.
> > 
> > So if such an skb reaches pskb_expand_head, it should be guaranteed to
> > not be a clone. Same for the carve methods added later.
> > 
> > But, the commit that added zerocopy, commit a6686f2f382b
> > ("skbuff: skb supports zero-copy buffers"), included this 
> > pksb_expand_head call to skb_copy_ubufs from the start. That implies
> > that was expected to be reachable. I just don't see how yet.
> > 
> > If it is reachable, then all that is needed is to clear shinfo->flags.
> > Or more neatly,
> > 
> >     skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
> 
> Also, I'm not the expert on more recent managed frags
> (SKBFL_MANAGED_FRAG_REFS).
> 
> That calls skb_zcopy_downgrade_managed in pskb_expand_head, but not in
> the two other functions with memcpy before skb_copy_ubufs:
> pskb_carve_inside_header and pskb_carve_inside_nonlinear.
> 
> I assume because those shorten the skb, so no risk of getting mixed
> mode refcounted and non-refcounted frags?
> 
> In general zerocopy can be split in refcounted and non-refcounted.
> 
> Refcounted zerocopy will not downgrade in these cases, so will not
> modify shinfo->flags after memcpy.
> 
> Non-refcounted should always get converted to copy in skb_clone,
> so will not enter the skb_cloned() branch here.
> 
> If in doubt maybe warrants a rare WARN_ON_ONCE patch.

I was unable to find a path also with the help of Gemini.

It did spot an interesting case where a cloned unrefcounted zerocopy
skb can be created. But it is reduced to uncloned immediately.

skb_morph is like skb_clone (calls __skb_clone), but skips the
skb_orphan_frags check. Its only caller ensures that this is safe.
But I'm inclined to send a patch to net-next that makes skb_morph
itself safe, by orphaning as well (and updating the caller to
gracefully handle skb_morph failure).

