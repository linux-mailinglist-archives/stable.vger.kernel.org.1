Return-Path: <stable+bounces-254168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBq0EYFrFGoTNQcAu9opvQ
	(envelope-from <stable+bounces-254168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:32:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 943695CC4F6
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85815300A8FA
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C33002BD;
	Mon, 25 May 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV5+PAUW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC552DECCC
	for <stable@vger.kernel.org>; Mon, 25 May 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723111; cv=none; b=aJZ6EtUQczSce2FrxpTyQd9V0Rr356KyvvsJ92Dc6akMeAvNwAbQ6nw7/Gu1TO8jv+29+9mdqCk3LFRXytVsbjGXtyJlrVsna7D5EqNdtArRQD/tyv5lDL3yqPhihlgLzqLfVJct/hqDCyWaUN1Ios/9xsX+FrJFmKD8idDK2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723111; c=relaxed/simple;
	bh=IChBbuQNn9xX8Rj06bX10eOuHAjlJ7tHSYSJUuxq3Pc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EPRJ2EGLZjtYRsHZ1GOHzypjE1TBtqjHsC7F0HH/LTRVdQrBN6I44dX/lPb2ElUPWCiH4ZWOQ0SRW7FM61GyKSbwIx/f9TQgQMPFMro0SBeVuZmmytErPw3aIVthVX8oN6mxeWvO5Ax5kQ/6kDk3Jb2/UOm9HOEqUGuwP2AADwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV5+PAUW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7c58e6eb3edso89498477b3.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723105; x=1780327905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN5aVsXK5EO2I4OcW6386EyMGfUSQ4BgyCyYxg8IgRQ=;
        b=TV5+PAUWFrRZYCmLoE5AQnZ9SncCN1X4oiTa1dtcV/Ep143F7rreW6+71ql4c4xxMY
         H0kAJBuNAXjlGBuSzz7qw+Vi+SQH/NwqfzhxsugigGK4fx07VIZnS9rFKA5pOCkI9G2D
         W2recfSbLFpiSdb7zmNTFyVWUKsz5VueWyFtXjrLGBpgMx2wZ6cN/owhWoLNppOO1bn4
         DkZI3ulj8xB1ZEdxu7i2x+Q5xFfpwtRnAE1ac2kCQ1fZA8p1kQvdHRkwqPmzkOBy1b/Y
         Wy6h1vF7D4ItvrV2g1T1ZKJ1dQ1PfBSY96zFK+DZFFHd21HJbOIj5+0Vh/mCr7GIEe09
         eP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723105; x=1780327905;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pN5aVsXK5EO2I4OcW6386EyMGfUSQ4BgyCyYxg8IgRQ=;
        b=jc+MapLzGQdC2S7Kb1iEPIFUcnEStQMsYMxwdEkeGebP1Gpyeh4k668Hu4mlSyPbRm
         Xq/f4BzlS3MXFzaNM3G9MVEluDzMbpwNxkLi4+sNjDXJ6UeFOmNmUqrmCtfuijmQh2lS
         XmDifT2b/yacWQtEyPjdCtc0qBrOmfGwSf9zqguK8xfDwpYyDt+1joYY1bQ2JCCaZ/lX
         Fz/Ghak9xC1nrUrKClI9laLl+EhaTMD/eMaKMTeNLs/5zxg4GihmMtU/Ff9A9zFXBZaD
         uPooRdX9yNhvqzCxdtNROCD0yoDr7gDmuXFYhXLh/mbq1ZRjO4LHPn401VJQBpUK8X3V
         OpbA==
X-Forwarded-Encrypted: i=1; AFNElJ9H7Gl4FQYqEx2iSjK8XAsGhutu7Vqfm0M0tnErId+QQCsiVK6kDVDBd0YP4iIKic9vYXuTfzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZ6I2xSj0koECZz7rS1aNmP7R9DwXmUNQQmmfLsN4TlKwL1xr
	CMQr/6YAELxvr41me0BJwV0uaK+yerL4EwinSNUGPUX+UdH6XF1CEn03
X-Gm-Gg: Acq92OHsv3mxFZBcU02/I1yMrXXSWCVdndNfODXw5SyR72YhYQedgUSbA6BK5/lN98s
	3ZLmHoPv2HUKvX4DTPEF3lmKuqXSdOUgeqDwFQaMmpj55OjY90NsX2Lu/lykth3bjJC1D290rxc
	zNASVdopQGylc6qB827NCODUyqKhS/r+XTdibWRppRwKR5AsZOf6V9z+jY4oDhBQYDAj7sAIzeI
	dzInZM1Q+dY3NbO6sPCt4My+esf8plaziK3Ulbl8FVpIzhH8M7uSwwyTcdf9msw8woqtibqb4A1
	k2h4Z40t0GeK4ZGlVe882Jidq8VgUPrkUrX/uR3yfeq3VJ7ih5YJVGWjZV0ZxE4QLnpeIQ5T0Qq
	5ywNiU7dG70mWGNRx35rqn23daQ+O03bGFTAyb8hS66OrXXTvW8CLgeZoGtvBJ4cD9KZyW3XVmh
	bPbNpts24H3mc83uGd+B8Z2dYKXEqFuForROoBOuQXwmeH1ohoSnSd/fb/G5NRhQguI/piH/g5n
	0Dl9+4=
X-Received: by 2002:a05:690c:4b92:b0:7bf:3b0:27f0 with SMTP id 00721157ae682-7d3388853bfmr156965947b3.19.1779723105037;
        Mon, 25 May 2026 08:31:45 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389d176c3sm47904417b3.17.2026.05.25.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:31:44 -0700 (PDT)
Date: Mon, 25 May 2026 11:31:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
 <willemdebruijn.kernel.27d7990b24613@gmail.com>
 <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254168-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.361];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 943695CC4F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > lazyming wrote:
> > > > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> > > > the old skb_shared_info header into a new buffer via memcpy(), which
> > > > includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> > > 
> > > These functions are not supposed to maintain zerocopy frags.
> > > 
> > > Both call skb_orphan_frags.
> > > 
> > > I think what may need to happen is to invert the order of that call
> > > and the memcpy. Current code:
> > > 
> > >         memcpy((struct skb_shared_info *)(data + size),
> > >                skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
> > >         if (skb_orphan_frags(skb, gfp_mask)) {
> > >                 skb_kfree_head(data);
> > >                 return -ENOMEM;
> > >         }
> > 
> > Never mind. This actually corresponds to the first Sashiko report you
> > mentioned: if zerocopy skbs are converted, then the memcpy prior to
> > that call will have stale state.
> > 
> > For skbs where skb_orphan_frags does not do a deep copy, we do need to
> > take this extra reference.
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Not sure the potential preexisting issue is reachable.
> 
> Vhost-net and other zerocopy that predates MSG_ZEROCOPY does not
> refcount ubuf_info. Instead it calls skb_copy_ubufs on skb_clone.
> 
> So if such an skb reaches pskb_expand_head, it should be guaranteed to
> not be a clone. Same for the carve methods added later.
> 
> But, the commit that added zerocopy, commit a6686f2f382b
> ("skbuff: skb supports zero-copy buffers"), included this 
> pksb_expand_head call to skb_copy_ubufs from the start. That implies
> that was expected to be reachable. I just don't see how yet.
> 
> If it is reachable, then all that is needed is to clear shinfo->flags.
> Or more neatly,
> 
>     skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;

Also, I'm not the expert on more recent managed frags
(SKBFL_MANAGED_FRAG_REFS).

That calls skb_zcopy_downgrade_managed in pskb_expand_head, but not in
the two other functions with memcpy before skb_copy_ubufs:
pskb_carve_inside_header and pskb_carve_inside_nonlinear.

I assume because those shorten the skb, so no risk of getting mixed
mode refcounted and non-refcounted frags?

In general zerocopy can be split in refcounted and non-refcounted.

Refcounted zerocopy will not downgrade in these cases, so will not
modify shinfo->flags after memcpy.

Non-refcounted should always get converted to copy in skb_clone,
so will not enter the skb_cloned() branch here.

If in doubt maybe warrants a rare WARN_ON_ONCE patch.

