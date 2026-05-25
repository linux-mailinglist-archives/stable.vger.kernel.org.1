Return-Path: <stable+bounces-254160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFKBCKxiFGrsMwcAu9opvQ
	(envelope-from <stable+bounces-254160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:54:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A85CBFAF
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 111F830226A3
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910983F39CB;
	Mon, 25 May 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWeRszVA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A73EDAA3
	for <stable@vger.kernel.org>; Mon, 25 May 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720808; cv=none; b=JhiF3MVZwktzOGN+so6B+2TwmTts7+3pkdOU34go5tYZa7j4UaGk9h/hGjk+aW9SFgd3bBA3XwyMChAzQ6rly4yyE+IQsaLDGWt1rm4u+dtVE5MEqT3xU8w7HCuIr7st3ufN/rdIteOrAWU5mIu8wutgKgR1SKQpT4MO84GIq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720808; c=relaxed/simple;
	bh=nsWZb2BEG1VWJWqV87Olp9WNLBy4lkel/zoAeA+P3Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJoCysdyV6g3+EinkNTnpTePrH9h0gwH09PODhMlsicaIPlJ7iRP1HMjqxmPgKLKMMl/hPzPIubQYlJYk8DSyPCWtz2z2QZDblkgcDiFlyMbWIHVuUjaJx41xo/gFIelImQevEUlGgo0oDB1Rrlx4EqQ+u7Ra+vpA2y2Dhm9jUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWeRszVA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490686877a1so6035735e9.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779720805; x=1780325605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNQExqIvzmBqIV3HHsF+/oq/Xz8fGP9nzIB+KDNJ5qQ=;
        b=UWeRszVAlZ5rHVVjGHS1Vs3GgRU9f+AT3H1s2z1EcF3iGBTZXsuYrvP3uNJi2pxJG3
         TmXtBcwDMkck4gam8hb38/Z7n/y3dvWmud/PSnofqSUkh0DVbQ5NtypR6F72yOH5t1ib
         SXmEeNjBANCgphp4RWu+UmBJQOepfIb2Ji4QuOZu1ccvbxL4cpHu3mt/LLCQvj6XQBSv
         FAzB6GDJoDaDoxYRl4d81sAHdn7KdN4HKLC6iAVufXLK/Ih6FpugC4VBS8+OvZ1GWSNH
         KRCfPTohFxNzvTk5DmIL/2Cp6zpUabeEJT06TelkW8JoX+pOT1exIGnBI49rQq6YyiJC
         D75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779720805; x=1780325605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNQExqIvzmBqIV3HHsF+/oq/Xz8fGP9nzIB+KDNJ5qQ=;
        b=VrKf+SLfqowh0njAJdNgleEtNRluIdGFYKDfT9+xKW20q7Lmn8TzDb9HDwGXduMm4H
         mvgEc5mtJ1Cq+voq19OtwtAediVyr6N4W43qI+8UpXKUSayXIWTrXkm/Xlxzu0uZ/3Yv
         WTKOdWmVcS9XlUS5r1Y1eGw5/dUzD2nhU1thgDIgaXJ33vgM/rSri64V5oAHZr878Ooj
         pbE8+s93Yj7l1Rqe7GnmlM1mDAdd7/40SxHf6ybhTxszEPrnH9pyloMgaBzipKjgaFtB
         Jx9qrb0iQoQpl01Wj4l5+mZl9K7GJKZ9zf52YZqEIwzhxAAAwARtcf6tjmC3YqnuC6co
         kCrA==
X-Forwarded-Encrypted: i=1; AFNElJ9zj0AYzBS3RIb3FCZhRv9g0TvHE/JTDbE5+EXudH5EcEIrcIjBUvvFsjMyBYT5g6tU2g5eNGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImqHhcmhkNy7h2h7g7LD4Eh8Ucnf6oiR++vXlAZMgfXXV1nEf
	xPlQRegd6It9O496oCnunCVaBJh7DHGWxFwpuu0cZYED3qIBjteeQxGp
X-Gm-Gg: Acq92OEQU+vpEfFXDSd97VBd9Kq8NZC/j9BJ1eFuE/+Xk4uAobgzG/e/FDYKqpcVHjl
	huwhn57lwORrj3ZxMGde20f3DmFhhbDp18pz3ISqlSMH1VhJZkZY47bfFGc2TVdoObfPWmgKAQU
	T+x5HOlD7VbFNHvPhqhGwSqYXw8xvsaFKefM3mXQ1hn5TK/PF1V99zg3dHymE8GWgAPkaiJu9Qd
	4LezH/zpmh6yeu1mVwncejjaBEFYFGSOBR7Nmx732sU5VnP+GfF0Urjh/5m/8klvICkRpfPDGA2
	XAzvHO8YTBzMtSNzwrSyOO8Tl34EYS2Np3lCxGt6KeQhdBk/lmg+d0GpQVp//rlMl9tyxEtfPOS
	r5Ymjw/P6DojBtcijPzkbr/gHMx9eZqN3bON/vMrxzHLJBatOKl0MErzwquGtxv1UuvHbkiqyzA
	6XxTSPgtcn8R8dpyTJOzgD39AZhBIT3E2k5oI2nSI8HNq16NqW4zZVPwYeSEToILjn
X-Received: by 2002:a05:600c:4746:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-4904225f7efmr226781295e9.3.1779720804863;
        Mon, 25 May 2026 07:53:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0cd5sm316156485e9.10.2026.05.25.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:53:24 -0700 (PDT)
Date: Mon, 25 May 2026 15:53:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, davem@davemloft.net, jasowang@redhat.com,
 stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525155322.240fbd87@pumpkin>
In-Reply-To: <ahRJS2bN9Bw_AKyo@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
	<20260523173557.5cc4f4f6@pumpkin>
	<ahQbVxvbBEJZ3TBU@sgarzare-redhat>
	<20260525115314.3cf310e6@pumpkin>
	<20260525083859-mutt-send-email-mst@kernel.org>
	<ahRJS2bN9Bw_AKyo@sgarzare-redhat>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254160-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdevbpf];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E9A85CBFAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 15:09:54 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Mon, May 25, 2026 at 08:42:01AM -0400, Michael S. Tsirkin wrote:
> >On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote: =20
> >> On Mon, 25 May 2026 11:57:45 +0200
> >> Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> =20
> >> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote: =20
> >> > >On Sat, 23 May 2026 02:20:29 +0000
> >> > >patchwork-bot+netdevbpf@kernel.org wrote:
> >> > > =20
> >> > >> Hello:
> >> > >>
> >> > >> This patch was applied to netdev/net.git (main)
> >> > >> by Jakub Kicinski <kuba@kernel.org>: =20
> >> > >
> >> > >Did anyone else notice that is isn't a bug?
> >> > >
> >> > >There is no way that a 'count of bytes of kernel memory' can overfl=
ow
> >> > >the size of 'long'. =20
> >> >
> >> > It's more of an estimate than an actual calculation of memory usage =
if
> >> > we queue the incoming packet. In theory, an overflow could occur if =
the
> >> > user sets `buf_alloc` to 4GB. In practice, though, I think you're ri=
ght:
> >> > the memory should run out before we get to that check. =20
> >>
> >> The calculation is:
> >>
> >> 	u64 skb_overhead =3D (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESI=
ZE(0);
> >>
> >> skb_queue_len() will be the number of items on the queue.
> >> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically=
 sizeof(skb)).
> >>
> >> Unless you either corrupt the queue length or manage to allocate skb t=
hat use
> >> less than the minimum about of memory that product can't overflow 'uns=
igned long'.
> >>
> >> The later calculations might wrap - but the multiply can't.
> >>
> >> -- David =20
> >
> >
> >Indeed, I wasn't thinking. For this to even get close to overflowing
> >we'd have to have almost all of 4G available to the 32 bit kernel taken
> >up by this single queue.

Except there is usually only 1G or 2G available to the kernel.
And all the skb would have to contain no data.

> >
> >Revert, I'd say. =20
>=20
> I also blindly added the cast to silence sashiko :-(
> I see now that it could never actually happen, but semantically it=E2=80=
=99s=20
> correct, so maybe we can avoid the revert.

Lots of things are semantically correct :-)

I didn't look any further down the function to see if it could be
'unsigned long' (or even size_t - but I like 'proper' types when they
are always correct, I have to remember that size_t is unsigned long).

The problem with the (u64) cast is that gcc is very likely to make a
'pigs breakfast' of it and do a full 64x64 multiply.
It'll then try to keep the 64bit value in a register-pair which ends
up being spilled to stack as a pair.
I've seen it spill a constant zero and do a multiply by an immediate
zero when doing 64bit maths on 32bit x86.
I think gcc can hold a 64bit value as two separate 32bit values; that
can generate reasonable code. But if they get merged (eg because of an
"=3DA" asm constraint) it all goes horribly wrong.
This is why there are some asm 'helpers' for mixed 32bit/64bit maths.

-- David

>=20
> Thanks,
> Stefano
>=20
> > =20
> >> >
> >> > Thanks,
> >> > Stefano
> >> > =20
> >> > >
> >> > >-- David
> >> > > =20
> >> > >>
> >> > >> On Thu, 21 May 2026 14:47:32 +0200 you wrote: =20
> >> > >> > From: Stefano Garzarella <sgarzare@redhat.com>
> >> > >> >
> >> > >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(=
0) evaluate
> >> > >> > to 32-bit values. The multiplication can overflow before being =
assigned to
> >> > >> > the u64 skb_overhead variable, making the skb overhead check in=
effective.
> >> > >> >
> >> > >> > Cast skb_queue_len() to u64 so the multiplication is always per=
formed in
> >> > >> > 64-bit arithmetic.
> >> > >> >
> >> > >> > [...] =20
> >> > >>
> >> > >> Here is the summary with links:
> >> > >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
> >> > >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> >> > >>
> >> > >> You are awesome, thank you! =20
> >> > > =20
> >> > =20
> > =20
>=20


