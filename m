Return-Path: <stable+bounces-249273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEZAGi0PC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:07:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C1256D4D2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A046306B4DA
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57C6284896;
	Mon, 18 May 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b="S0+syl/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9F478846
	for <stable@vger.kernel.org>; Mon, 18 May 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109092; cv=pass; b=efqzMurvpkMufReFDezaQiEKyqcphLPCehiZR1Zy91aMcKwmbDAPLg+mAiSJjD5n8saQufBhlrTw2nkigjuovANe39qvHZQIEPeh9K0Ny8UmlFt7bwA0qpM1Ii+es7nd1fPbG/rjhSy7C5CVt+XKGFuYbdB9l4fTI+TAX90Cp2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109092; c=relaxed/simple;
	bh=Sqv2/zJbUPZhwfmVPP/6XYmsqc5O0ye1F464HbPnnZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5Cqlg/hl+jicL6z0/ufbs7WYbD0YBxS+G2GzSJVUKQnQcEIj2uis8D7eMPyaPttaQ8YlkcX6VPs4PQXNKsyu/vYMkheh/9gZq9yK2YX+DQXOWdRq935COvDNmygyuGy4HTCtkSZzr0jovEW61VRVheY1YhPx3xoQqVwig8jDDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech; spf=pass smtp.mailfrom=monogon.tech; dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b=S0+syl/4; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monogon.tech
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-63133de7abcso604465137.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 05:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779109087; cv=none;
        d=google.com; s=arc-20240605;
        b=BIRroOa+4cJI1HnSVwLnBER7j89Ftemv+nWk1C/0oKcCVXK5MVyedYUcDZ/2Ui6dWa
         hGnBKAXyESXcicR5cDP8Q9mKPD92ukbjYHgfm5RmHpQ9zhIvbECZPi3zACF4smt4kdRi
         VEyHzzMoxNmwNUdj2SgLeqbXxmoj/RxkXo8kN0XJ4JeyNosbFFVKkJzCdoQVE094ZG0n
         wtzg2wHwEiPc2IvF5jBYp/PADJ7h4acu1Y74ckTigm+e9A6+8tVueZdulBaovZYWDKJA
         JqTAKKsC5X/esapH29TTGWAXJvFprM7BJ1z293pZK22DfGV1JDpR5wDWut3nQCw/LIm7
         ftmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        fh=thUgaYFlXg6Dtcp+33EJ2BVEfK0SXMwyETr5sFiUOuI=;
        b=KwDKMiEyLxkbZSDqcdk4//NDdOUjSsE9AsstmdJ/mMJRANC5OVTvRCWLeF0eKPdD+D
         us8qoXOB5YBQjqNSiN62u7rYak9tIBy92/CnJWXCDn5fBiwwQnNu7A7GQq8RTdxQ/FX7
         4kS4UKFWz778ggD/mY8BVpH8nknqHS3+T0KootcN6w7lqFPxPFmFvmPXI6CN3DCy6Hpf
         9yb4g3qQkbijqWLPgJ92ERY8DR/551fW1dTvR96G6zMiGwbpuy+FEv4GlsLx3oL2ua2L
         9PMNKiaXUKjZHRyhsi0VoBPfNcKhaAEft0dRxGEhWu6UxPjSe3uGNfD1qI2Ao9XG9yJw
         1tZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monogon-tech.20251104.gappssmtp.com; s=20251104; t=1779109087; x=1779713887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        b=S0+syl/4RTeNWzpfJakVAxkUEA4U38NXjBEfyHD2q9YPMDTaV32TovJ2F8M20idxHQ
         NxhA928p0mglemYFzS+cpShbZN8Lsyeu5Ate3EJk4XaEkH6aeXnE/HSiaPRFsBcOZKoA
         c29NJwbZlYBPkq0KfjBQc4av1qjHHzwn7kWVYuZxh9pxhq3r8R1vjMXS/wRLXHA9xd1D
         EKQqVuNOKDPaN5JyyYYCxhxlg0kjOE4hBBRxCxTzze797FUTAxH/UVjc1/PSc01S9f3i
         5M32NkaLc5VG4wuJVgnng18nlZYDH4rK3hoOmY74SGJEQzad24kRDTWhmpzZzOxl7mj+
         yFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109087; x=1779713887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        b=a+qjrWZtMRA4ui9XLtFUa5Kvk9/4x3qNhuYKabZe6jMwIknaAv4/zqe/d/bpRsP15G
         YmLCBs8C+/st7DLYJnOHRkXZ6WE3jSNSNMmBzD2ZsgpdvyCArVzXIfbmR22a5jZq+PCc
         wa5tUIy5E23+dlpOqvThoY2BZMLcZZMSwQpwi/614zsGGUN2RpH7ez7Gcy2XN6wJYNXB
         1NNN3o26PopeTgqi1PTE0twXJtJfDM7SnTQ5lG7gHHHRa/xwKQ4UA/12z4Gj6tdCs//J
         Qi3RNH7Dr5GlRyUdnWxeM94StoWveXzxjcKae7+AH8fJMzPOY7qqylgG5CHUujQIZP+5
         BCwg==
X-Forwarded-Encrypted: i=1; AFNElJ+5lylYRF1oNYGJVkLSQ47Hg6yqIeXisRMMY8kLscMktbHyYiS10sVmM/JQ0mqdK2yg7kyvx20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCzP0Qg1lIDknyyLtBewFgMEBYi8X/zFbMLTDERg7Z419vYU3
	MoC0dXam5ptB0i5wa5YTwViS56sybCBKwLvi6wbnI1TIUBglisbAV9aGlPGrmATwhqBWggcfA9/
	fOGaJHOL/+6WieHNDKPOxWbVI5qyD2dz/GvzrGVkfOw==
X-Gm-Gg: Acq92OEv0uYGVpd+Tn7d+6afQUdF8PUCrwzZqMvNHiWtDuRVaD6ZKZFiNaRxIpmqWtg
	cBodi6wJvPbD479oqJI/D9sw8VLN2jA6ZmMk9lJZ+DHE9li55szA9jKSzVNO+fUowmoEjbFUzW4
	MugmZpHWiHYVyCHdlrir0K2EMWASafbCuM8orLJe2D43lRTGl6UjRBh3zxDKG+yytSj2FIgcfAV
	mCM0lSRqEtKWs6g4O56BGR6lqqnkcdpgJ2WZToVFHiqAkHDILtEKcThFBfMrS8hAjvVVLn7KEp8
	uN5z7nvkfHata5SkA4PX5Bwx+SzTSgp9rz4H
X-Received: by 2002:a05:6102:6047:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-63a3d93b6edmr6378714137.13.1779109087067; Mon, 18 May 2026
 05:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512152658.2818805-1-lorenz@monogon.tech> <9c49ecf7-1d35-4b03-8a71-9d724562594d@intel.com>
In-Reply-To: <9c49ecf7-1d35-4b03-8a71-9d724562594d@intel.com>
From: Lorenz Brun <lorenz@monogon.tech>
Date: Mon, 18 May 2026 14:57:55 +0200
X-Gm-Features: AVHnY4KmAFH7SWcYKpSxBgfiVCiUuxFv1ES63sSXsCXW1j6V3gBDDffnv_CRq5o
Message-ID: <CAJMi0nQN+XB14Z81=W2reEGnax526-MB=Armx+f_miWMWUmRFw@mail.gmail.com>
Subject: Re: [PATCH] xsk: switch xdp_build_skb_from_zc() to napi_alloc_skb()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, stable@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 09C1256D4D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[monogon-tech.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[monogon.tech : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249273-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenz@monogon.tech,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[monogon-tech.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 13 May 2026 at 17:21, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Lorenz Brun <lorenz@monogon.tech>
> Date: Tue, 12 May 2026 17:26:56 +0200
>
> > xdp_build_skb_from_zc() allocated xdp->frame_sz bytes from the per-cpu
> > system_page_pool and built the skb head with napi_build_skb(). The
> > latter places skb_shared_info at the tail of the buffer, but the
> > helper sized the allocation as if the whole frame_sz were usable for
> > data. Whenever the packet plus reserved headroom approached frame_sz,
> > the head memcpy overran shinfo with packet content, corrupting
> > ->flags (SKBFL_ZEROCOPY_ENABLE) and ->nr_frags, which then drove
> > skb_copy_ubufs() off the end of frags[] on the RX path:
> >
> >   UBSAN: array-index-out-of-bounds in include/linux/skbuff.h:2541
> >   index 113 is out of range for type 'skb_frag_t [17]'
> >    skb_copy_ubufs+0x7da/0x960
> >    ip_local_deliver_finish+0xcd/0x110
> >    ice_napi_poll+0xe4/0x2a0 [ice]
> >
> > The overrun bytes come from the packet, so an on-wire sender can
> > corrupt kernel memory remotely whenever the XDP program returns
> > XDP_PASS.
> >
> > Rather than patch the sizing math, switch to the pattern used by other
> > in-tree AF_XDP zero-copy drivers like mlx5 and i40e which use
> > napi_alloc_skb() sized to the actual packet plus skb_put_data().
> > This sizes the head exactly for the data being copied, drops the
> > system_page_pool local_lock from this path, and removes the
> > structural mismatch between frame_sz and the skb head buffer. Frags
> > are allocated with alloc_page() per frag, matching the other drivers.
>
> I used napi_build_skb() + system page_pool to enable PP recycling
> improving XSk XDP_PASS performance a lot.
> Are you sure there's no other way to approach this?
>
> napi_alloc_skb() used in other drivers works, but it's sorta old
> approach which is way slower.
>
> System page_pools always allocate a full page, why can it create an skb
> prone to overruns?
>
> >
> > Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
> Thanks,
> Olek

Hi Olek

I looked at the code again. While your approach is indeed faster, it
is only faster for traffic bypassing AF_XDP, which is generally not
that relevant for performance.

More critically, it currently corrupts kernel memory and panics the
kernel very quickly when running with frame-size set to 2048, 1500
MTU, and passing received packets. To be honest, I'm not familiar
enough with the XSK subsystem to know exactly what specific sizing
assumption was violated here. By comparison, the approach taken by the
other drivers is a lot more obviously correct and works perfectly.

If you want to preserve the current approach, I'm perfectly happy with
that. However, I don't feel comfortable sending patches for it, as I
don't understand exactly what the expectations of the various data
blocks are.

AFAIK, reproduction should be fairly easy. You just need to run a TCP
connection to the receiving node (which gets passed to the kernel)
while receiving some UDP packets via AF_XDP at the same time. As
mentioned, it also needs frame-size 2048 to reproduce quickly.

I checked if I could get you an easy reproducer, but xdp-tools is
quite limited. If you want to keep your approach and can't reproduce
the panic yourself, let me know and I can see if I can synthesize a
minimal reproducer.

Regards,
Lorenz

