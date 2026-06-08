Return-Path: <stable+bounces-262085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fNK7KLL8Jmr7pAIAu9opvQ
	(envelope-from <stable+bounces-262085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 19:32:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E76659459
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 19:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=C3jCyN7s;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262085-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262085-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 187CE304B55F
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24D241686;
	Mon,  8 Jun 2026 17:31:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5731D371
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:31:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939875; cv=pass; b=uC1dem7BrJXRfGAZ3Us2A3/+i0FJPPupgO7hYgHGoMFs5DkFL125FApv+7olmc8hy4ZwVSvf7zVNeXXtnXT2DvNHl8xQacPCJp78CuF2a0uyOcE0PRtRZS2BdfFpBsRMUefWxYthwhgLKB2P6cnRakQjaHurzmREktKLVgJ+LGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939875; c=relaxed/simple;
	bh=ZtkTXeVSoIzUreQA69OuszszpzFQa2oNPn6cPDzvSqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU1VgmSdVdr+9eBp4H7eONEgP93/tCNuZOX+Tdj4RYMl8zhbnUyBN71LAUUBpUNBodggsxVbz5Zsi79dSVVju4vL+DcKgbyGTvCLbE+IsGS4x/NIZREh9NchoSZgKyoC/i/UmLQb7ugq8QE4mwGswIEQr7pWXCbwj0/CcCQXJj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=C3jCyN7s; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177b9a02bdso69557721cf.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 10:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939873; cv=none;
        d=google.com; s=arc-20240605;
        b=fVJjqmorsWHQ76B+Y8RjDw6LCwYqpV9mKy4/gnqK93HrhuwYUMLMZd4zq/1xvIUVmk
         OKJIYyiWVHOKkvtT1k0ZE6+XJ6XoWXG1hZjl5Y6I9TkGVJEOdzu7QVW45ZE/7ItwPOrP
         k7VRhxbBbqqU7mDMkttUuTpKeos793XL3IVU1WGVlMGXiSaQiQNjRGRndH4Jgk7rJ/MB
         kPw14aC0MzMkiZFMIeVv3bYWtzaZecnxB62+cZVnkX9yiodFCBQCHnjHC5JH0uyPZwsQ
         s6MNs8pqZ0AA67Mx8jhSANUdvTQbHBBmL3LBxN1rxT4SYctAlqkw7RcF96AR8aMmKV3q
         lTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZtkTXeVSoIzUreQA69OuszszpzFQa2oNPn6cPDzvSqQ=;
        fh=fKRYMquAriJe7e5IOymnPL9CtqbgM2Rp/32VEfCfVcE=;
        b=VmwFLGjMVMiCDIk/21PdW1Vy76XVt+ER8qVQ17HNzBnFw1tVxZYiHcO6u421iHAyxN
         yVjAFcuchygFVgzelhIzqm1d0PmZJ7IZ04FHFzl6PI5uaqXixkK3eyVcd1m7mXQudTbV
         aJ2avtXL3ysW0RF+hkgoqvIItMauUXzO5ys9sMBQ9wgrqnImHSxMTYAmX1rqVJ0sBwfT
         fMPNyWrOAuPFKQsxun+IH2sMTMmBY8WcP5PmH0P4Rz8BK8Eq9NUI2PlDCzppII2czHfm
         ELQNVzMMXYp2t9ZMkEODlEOc5C/ByIA42iwKnOUvqyQMEkLaeGexTswmjMEanjBXsRDO
         9sOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780939873; x=1781544673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtkTXeVSoIzUreQA69OuszszpzFQa2oNPn6cPDzvSqQ=;
        b=C3jCyN7see+Vqt0DREbcJrA3zYsO34geCLABTqqM/g5XcSRZ3KrkXwX3FFTidSyxZi
         Kj1Mz4cdjjMnWVKqeTen5uwFxLw5w550EAIF7QZ1Y+VJgHe9t0CaO5pqu85hKV4i5tx2
         eoORhua3VXIkcx85LDI/H+F4wAf/k2GUgSN/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939873; x=1781544673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtkTXeVSoIzUreQA69OuszszpzFQa2oNPn6cPDzvSqQ=;
        b=oJTa6Kv2i6ZKUPhSW/5vEMIvIcr4Yqi/sF8eZyMUWfmmcoH+8IFoSjbGudFJwQo/FU
         8BD4N1Mkg3twnaY1IzQBDLBfO8Tz9vxSIui9UmZtyGPal2P5QYlb45Vhj5oEVKIGRSrv
         ViXiY6yO16HaFg4SmpQHA17C8Wt/POQlXu7djU0XA7XzEEjc9HlB5LY/x9YznqdehyGG
         5VAkx8WMOgwUUE/zIVVxK9OkJ+HsKsVQjCFXd7SmoAuw56d7LPxVQcFP4y4DK52llkKV
         n3mwfXgofb0HKYCon/xVwfVHJL9kxNCd4EnpNkkJvnxCdCjzh+aRNDs/AcJcfj0Wp2CM
         B5/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+x68u9gRgzTfoubJMAbz/XIgl0j0SlCWtp+tq8DiejndHaKDhuDQto0iPdkb4nOn4gISTInUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCNAY5pltSNyVN2Pz0evWHXk0z13myiv8ZZ53cYsXmbpO4Yx6
	S0+J0F/ozv+O3H4Stn63r9cy3xm7jyxa63cVssv4UX4oSN0vuFgLkc8XLsMNrzQEg4CEikCk2pw
	7xer7KzfDas/1I/Tqj4srQnpm89q+0yvQNSFL+uSfBQ==
X-Gm-Gg: Acq92OGZ3uHZ/cFS3I0zT346+9TViplQ0ymrbQUd0U/B1H89IS8rgj3YF5kBTG52hvt
	W2k34vsq7PgT5O2Kw54XLHKukWy2SRpVaQtZTFw+35HLUiAlEFh1W3jXBIRuDee9IhPAslpQ3yP
	WKzHJgwMElKYCiUG7wIUaFLXGwfHFuHLUh3zWMQyeA2yQr4vXRn++AOjsnB+p4sr/gJ2pIfN2sz
	iSlwHP8dxo4CeJ4eJXAHKA+ESP0JZB7m4lqugW6BeTFGSrdVSHvRE6qi+mpgpJy9BwrcvGBhfrH
	xpgKnlx0OafEzPK/k55IPvhoePVx3mkuc16ldkwxV03183E=
X-Received: by 2002:a05:622a:181e:b0:50f:b904:454 with SMTP id
 d75a77b69052e-51795b4ebbbmr226596791cf.11.1780939854813; Mon, 08 Jun 2026
 10:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605192708.141921-1-joannelkoong@gmail.com> <20260605192708.141921-3-joannelkoong@gmail.com>
In-Reply-To: <20260605192708.141921-3-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 8 Jun 2026 19:30:43 +0200
X-Gm-Features: AVVi8CebtW4VFoRjyS1pkJGcPl0oTu63GC91v_deluCzoHFQI9GHchAVugbxlQU
Message-ID: <CAJfpegvGqm=F8yw6NJTFCrNnx7_jSP9=uFX_SfWXi2C_iU6xBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] fuse: fix data races on ring->ready
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd@bsbernd.com, fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:bernd@bsbernd.com,m:fuse-devel@lists.linux.dev,m:clm@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262085-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,szeredi.hu:dkim,szeredi.hu:from_mime,vger.kernel.org:from_smtp,meta.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16E76659459

On Fri, 5 Jun 2026 at 21:27, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> From: Chris Mason <clm@meta.com>
>
> On weakly-ordered architectures, the store to fiq->ops can be
> reordered past the store to ring->ready, allowing a CPU that sees
> ring->ready == true via fuse_uring_ready() to dispatch requests
> through a stale fiq->ops pointer. Upgrade the store to
> smp_store_release() and the load in fuse_uring_ready() to
> smp_load_acquire() so that the preceding WRITE_ONCE(fiq->ops, ...)
> is visible to any CPU that observes ring->ready == true.
>
> Additionally, fuse_uring_do_register() publishes ring->ready with
> WRITE_ONCE() but the fast-path check reads it with a plain load.
> This is a marked-vs-unmarked access that KCSAN will flag. Wrap it in
> READ_ONCE() to mark it without adding unnecessary ordering.
>
> Also wrap the fc->ring load in fuse_uring_ready() in READ_ONCE() to
> prevent the compiler from reloading it between the NULL check and the
> dereference.
>
> Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Assisted-by: kres (claude-opus-4-7)
> Signed-off-by: Chris Mason <clm@meta.com>

Applied, thanks.

Miklos

