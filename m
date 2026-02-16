Return-Path: <stable+bounces-216749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNxKN3lpk2m64QEAu9opvQ
	(envelope-from <stable+bounces-216749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 20:01:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1B14727C
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 20:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1999E303526E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973FF2E0925;
	Mon, 16 Feb 2026 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DF3HR9Ka"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA7139579
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268418; cv=pass; b=S8dlPi6/GguL6QNDqlfyqDZaUgbHFgvEcseTktMVrFgJqKGLgTwq7MW8j2tyDjAy21i/CYliYDFZI0Xi+huoMb9qfmgHPWtoeoEP0EVO013C2dzSHHsLNvAhs0Kz5eps213xLSgfF6oou4CsYwk3JvWQCTZyY8lXA9lnjCj4cDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268418; c=relaxed/simple;
	bh=Ga5Fo+bcIzl/eYt/Ks6U/NQEee3M/us9KJVMxZfcK2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyZaGZlyA16GWmyq9rVDbBm2dkeaQ8XkgaVJz3jw+h+s8L+eHoSfkLHrjTNsxZPoJ3P0eUXrgByvctOKkACjEtMl33TCfLyAAlm21k5TDphIjABBg2ujNlP0hdWm88VQ9ayHV3vWJbXGuGoVFpV4cfuePCIRI5uv3ZUZQLji4Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DF3HR9Ka; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so2727711e87.2
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 11:00:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771268415; cv=none;
        d=google.com; s=arc-20240605;
        b=Q7hs0TGk/8IHvug3mD4349U1LeSbJJfoxr0fBh+C2eI1zkxQuVxPwNZVh5/vmUBd6Y
         yP77Pwu3Z9Q0ekm53RnJpDlad9MBCGkuyb2+yQZVNc0tZK0WEUnG6FDPu6ugqNE4HiVT
         OwmJ2MV0FrB9Zis+6NLdUx5eX5Uexecj5U5FBYq4Ux59YDqQ/kAHILSYIalO1TXVacm4
         dccqHSc7pU+qdPe/dHkmetOoTW5NRDzQOnKX5okbYRYm6n2jnA/7MGQSfxQyVSk+E84d
         HIGhJe2gXUMmia5D/0vSyWBq+Ss/cJnhn75FdvsCLz8R8N3FZuJvbtv0RrRdMv3nHNI2
         x8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jG2+rAaRrsn87ljy4pWId0GXGpI/9AO1yGU6K9ZS4+Q=;
        fh=KERlnmb7EOJsQuObaCb3VoyPJxDtZsX1KX9DYH+Qa+A=;
        b=Uh5v6gOzdA/CATElXplPrttBsK6rRAiZEpzOp0F7PB9YI1ZU5YiYetwJNO+ZWy3kId
         2PDA1YEI52GvfD9bbMhr41lQA9SG/88wMpTtEvbJy62pkLH2dKUpzuQpRtVdQwhC+fsp
         OSfS7s8e7hgNmHtoGYYLx8Ij8hTj1OuzpxCYTTjrGP0QbpoBDZJJNPrbP8zId1h94s8a
         FLB9Vw0EXwcAB65XAqMmYjbn9u8BmhQ4Tml3+HfctW4SecIV1OhqNWxpyYVOa6XltqyO
         cf9l45VvNZJCeoXeYFq1J0bqCrC4H9KzpGNsGM7mZHufGBBKAgdW+nSZj9Co4jxWyJNf
         duBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771268415; x=1771873215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG2+rAaRrsn87ljy4pWId0GXGpI/9AO1yGU6K9ZS4+Q=;
        b=DF3HR9Ka4dEZUKITnKPJ1v5mizQjpSmbnFNBrwE0HWNs51LTfLDpc2ptLOQf2pvFUD
         MXYEHPtWENBs3kjHL2IUpmJxGVnDF3zRVfYPNyY16owIVDarmq00C2QVs6YNQ3MD7hkx
         iaOW/xEX67xVQbpSpIO9XNezB6A0Zvq1cUg9CX8JG0aRb7fOUZLs4w7xpaS8Ost2hm9Q
         qEh/JS5hMRrhIE9ODPnoAR2/TYbeKRCrvgTG9WjtOM8MVyNm0x/TqjXYi5cITpGMkIiR
         hjNdMi/a0O/JXzPocquphtsKWfz/TWYNzMQAvYHQMGfeMELfz2Jt/H+DnyfwNKsdYB7A
         eHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771268415; x=1771873215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jG2+rAaRrsn87ljy4pWId0GXGpI/9AO1yGU6K9ZS4+Q=;
        b=V4V2j8Mws0J/Jjvp4MTAxxGGHy+yvcYMIZfv6V2fJKtJ6Q93lxV0/IVXXfL83DAuVT
         a4OQc0T6XqW73meJBz5Xlyt4oXYFqZUPa+22+zHk6hVuQ/LBndsK/uPrAwyfZu+9xUVT
         a4dn3bXg+sESmXYftLCSCvKCmu4PBaDg1k/UKg0m+ZXVqB2NxxpwCSE5TUlrZGXEfWlc
         DCgvKlZmak2XP+UDe67rjtXMxwYOf4xFGNsDGCvUaR8I6oFTnLTW+bwAfzfvAldgkQiC
         +dQ6l/HnXLHhFJmnioHZie5q4SkuSf9UbC65Xh3md6BIxkxxNsOiK/RN5GkC9T/lk+CA
         J9hg==
X-Gm-Message-State: AOJu0YzJUPtS0AnJrtJjXTMfct2gG0GFC4wRnZg8tDlzjSQCK4VK5oau
	T95UnN2GdoRdqdlk3SjZGkfA4zZVgRjGKYRja9L6w3Hbajf9dPu13uZK0yLQJ8WfsCxyDHIZOm4
	Uahoa8QNOpT8h5axFLvzANbYH2uR9OgVOYD11XVeThAznhkv2P7uFSVIU
X-Gm-Gg: AZuq6aJJDhjc3O4S6LctfeUdOeX9YccQfJ6TAnntvucKWlRTBs+XBZqx0SEcP2ARh3F
	nbf6SAEs8Bref9gOYGW8AUtJPH+p8ujHBusMi3ukWvaWN69Yj4LxY9dV9npmGwUnud+77px7ox/
	5CODkUQmvS9d9Z7hxBDwRSsHyRKjgVA+Lj974SVWdpoZTldLug6AgEgXHWs31hnHOAPWJ917sKN
	bW6JYNJFfoLSUc5+14XxoGIoCweA5+cFPg4bs0TbYEFmWtlZOdDgnWqf7fKTs3Kfs12IiiAtIry
	Z+JmoZaLO9lTmuiO
X-Received: by 2002:a05:6512:4157:b0:59f:6b77:a8d9 with SMTP id
 2adb3069b0e04-59f6b77a90amr2298964e87.44.1771268414229; Mon, 16 Feb 2026
 11:00:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213211702.447894-1-joshwash@google.com> <20260213211702.447894-4-joshwash@google.com>
 <2026021654-catsup-occupier-6753@gregkh> <CALuQH+UsbSxrOwkdUba=AFO7dDOrdtLmM5NOpQ__ASNW0GF5pg@mail.gmail.com>
In-Reply-To: <CALuQH+UsbSxrOwkdUba=AFO7dDOrdtLmM5NOpQ__ASNW0GF5pg@mail.gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 16 Feb 2026 11:00:01 -0800
X-Gm-Features: AaiRm5022GNOxtbATHx5xZr7Cj3bGxFp7RTUOuhX2CpK-Az07LCVCDnxU22WgyE
Message-ID: <CALuQH+Xsai9RWAwinJ6uG6Q9a_ocyaLrq2LtjY=6oVgFctK52w@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] gve: defer interrupt enabling until NAPI registration
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ankit Garg <nktgrg@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216749-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 40B1B14727C
X-Rspamd-Action: no action

Hello,

I was also wondering if the way I'd sent the patches was okay, with
major.minory.y patches for each of the stable kernels, or if I should
send them differently in V2. Lore seems to have grouped all 4 patches
into a series, which seemed a bit odd to me, but was probably related
to the fact that I'd only used a single send-email command.

Thanks,
Josh

On Mon, Feb 16, 2026 at 10:41=E2=80=AFAM Joshua Washington <joshwash@google=
.com> wrote:
>
> Hi,
>
> The original fixes tag was unfortunately attached to a commit that was
> introduced as part of the 6.9 kernel. This mistake was made because
> there was a significant driver refactor made to resource allocation at
> around that time:
> https://lore.kernel.org/netdev/20240122182632.1102721-1-shailend@google.c=
om/.
> I did not realize until later that the logic being fixed should have
> been backported much further back, to the initial commit of the
> driver.
>
> I will send a V2 with the suggested changes, thanks.
>
> Josh
>
> On Mon, Feb 16, 2026 at 1:58=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Fri, Feb 13, 2026 at 01:17:02PM -0800, Joshua Washington wrote:
> > > From: Ankit Garg <nktgrg@google.com>
> > >
> > > [ Upstream commit 3d970eda003441f66551a91fda16478ac0711617 ]
> > >
> > > Currently, interrupts are automatically enabled immediately upon
> > > request. This allows interrupt to fire before the associated NAPI
> > > context is fully initialized and cause failures like below:
> > >
> > > [    0.946369] Call Trace:
> > > [    0.946369]  <IRQ>
> > > [    0.946369]  __napi_poll+0x2a/0x1e0
> > > [    0.946369]  net_rx_action+0x2f9/0x3f0
> > > [    0.946369]  handle_softirqs+0xd6/0x2c0
> > > [    0.946369]  ? handle_edge_irq+0xc1/0x1b0
> > > [    0.946369]  __irq_exit_rcu+0xc3/0xe0
> > > [    0.946369]  common_interrupt+0x81/0xa0
> > > [    0.946369]  </IRQ>
> > > [    0.946369]  <TASK>
> > > [    0.946369]  asm_common_interrupt+0x22/0x40
> > > [    0.946369] RIP: 0010:pv_native_safe_halt+0xb/0x10
> > >
> > > Use the `IRQF_NO_AUTOEN` flag when requesting interrupts to prevent a=
uto
> > > enablement and explicitly enable the interrupt in NAPI initialization
> > > path (and disable it during NAPI teardown).
> > >
> > > This ensures that interrupt lifecycle is strictly coupled with
> > > readiness of NAPI context.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Eng=
ine Virtual NIC")
> >
> > Why did you change the Fixes line here?  Did the original commit lie
> > about it?  If so, that's fine, but this is really going to cause tools =
a
> > mess to keep track of...
> >
> >
> > > Signed-off-by: Ankit Garg <nktgrg@google.com>
> > > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > Link: https://patch.msgid.link/20251219102945.2193617-1-hramamurthy@g=
oogle.com
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Joshua Washington <joshwash@google.com>
> > > ---
> > >
> > > Note: This patch has been modified form the original to re-introduce =
the
> > > irq member to struct gve_notify_block, which was introuduced in commi=
t
> > > 9a5e0776d11f ("gve: Avoid rescheduling napi if on wrong cpu").
> >
> > Can you put this in a "comment" above your signed off like:
> >
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > [ modified to re-introduce the irq member to struct gve_notify_block,
> >   which was introuduced in commit 9a5e0776d11f ("gve: Avoid reschedulin=
g
> >   napi if on wrong cpu"). ]
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> >
> > Also, it's "from", not "form" :)
> >
> > Same for all of the other backports here, can you fix them all up
> > please and send a v2?
> >
> > thanks,
> >
> > greg k-h
>
>
>
> --
>
> Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-4=
423



--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

