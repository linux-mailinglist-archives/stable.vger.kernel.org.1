Return-Path: <stable+bounces-245440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDKTC8AMA2pI0AEAu9opvQ
	(envelope-from <stable+bounces-245440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:19:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FD51F405
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C44FD302FA34
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BA47B413;
	Tue, 12 May 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnq6+2Yv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D13859FD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584756; cv=pass; b=jOYLLShELjSGYh1aYZHX+FKfeH3KOI/JTb5i3qYgENLMSaqZypmMH9uPCwaDzPpj9wTk3ZFPxwvlKVIausUoPFimEzWfUOivccxDgE+QxIxIrOdjrjGUmLhLUMRz9ZlIqmCwGDcrwnrMVfzzRo3sP0zmHNXk5K0jgALxwQHkBaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584756; c=relaxed/simple;
	bh=MIxIHIH3CJAVup1aGyzZP5Vqx3tluLei17C5chffE1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUoQ+hCkRqueWuuwuQqRR2LYEbSNDmbFbVIs0kH1UcTd2h+DvQbOu7f7EBCRcQKe4izN1XL29J4SwMdIJoW23fgbXztNnqd9E9aFKHMDB9bUHPvpv0vsDBsdZmuLBYuAjx1t3Gjj6mdJQd0FLsyQsmsGGwyheHxMC9dcdzaVbYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnq6+2Yv; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcd17e19b6so3078667a34.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 04:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778584753; cv=none;
        d=google.com; s=arc-20240605;
        b=Ojkw2nnBpzDCWZkENHvpXdd+jz0JHIZ0bjs/BtYx5gNmdrg5uM2UDgahL3bnXIj5Ed
         p7mL5ikWzctsgWolS7ptFFtycuQ70d7LhjzHHnoy3HUjGHAqiLol/sbmN5WBT9OFue++
         HPZ20mrdIC2yd8kBS7NUciEu/NqtPn6oub0/roWq/BQeyiZiTHZBEZ+imTE1IiXVhHSX
         95BOTkitgRF254b+3LsJPR5hRUhQPCHwX92BsFjdpCHlSgBViofe/sUhw+NFEGXjt8iK
         HtxPkrjKQaMmQbqIbdp2GS03lAxwZjtwUl6VJOGnVb492TVNOTEqdp+qA1hsci5UnaN4
         AsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5mtEH2w3LwavrlBiwkdHe6W2Vm7Xq8WeRiZjP7eFhqs=;
        fh=axzzE00nuHasitSahtrVVfsYp+pDLCwRgrEnGouvIWw=;
        b=bRuBaRDxLDXGL/YTQdtmgi4pcwtCeFQXx15c1YGXAYUvSGCV5CVye57HJjEMPqt3Xg
         fq3kxNo2KmDkmb8w8sVgVY8EG9p155MalBXoBkrGjsLS5FpSDWPVAEsE0qLeLjCRkSDY
         2p5RUw1aN35+jOiboFxLkxu5D/yZ13jsQDS/gv/S/wnzzKDgP6TAxj0WbyAZdnFHrkYC
         H5xhuF4WtILpf0NipM3QfNIGzQ4V9oDLrs3waEb8ve8HL0qmVfJgY0+bY74vau/V3SiA
         n0JmulnDWKq72+D5Pu2nsESK9VI5C3XDwaKQsWQoA5ZM+czzOkIMl5YWj+w7bS9T6fBA
         ONOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778584753; x=1779189553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5mtEH2w3LwavrlBiwkdHe6W2Vm7Xq8WeRiZjP7eFhqs=;
        b=Nnq6+2YvWeaas2ib3YH5a5Zmqwe5C37R2zEiI+dklcWRWq2a15GG4vhb4jiMHiMVgf
         7v9jbACiLBaMZZQHW5PMNd7GY8wa5/YNrW8KCArqAqRIyRYofYtFd6k/2jJu8YH3+UlH
         NAu43jWbqeRGU9VP1fKiEC/QAgTUYNfHsZCMY72qCryZT5KhnREXNYwuukzTX12r2bkj
         TY86yHataWDb9REHlXrSuyB6BgWad7kz0lXNV2zXNV0rrAkb2cmGhsLms7dUyoXZ/ppc
         nR780kMBPlnLtOcFRH2uUA4MYaKeqFYHfnuvdFkt0ZCDze3s8SZC9xe2pkL0ktOjvp0d
         Utuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584753; x=1779189553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mtEH2w3LwavrlBiwkdHe6W2Vm7Xq8WeRiZjP7eFhqs=;
        b=ZoQgbQ+8Cg5IZFBcBi6yhgeyWGro0KDssFk9ShIPYVIPxxCjf8EL5E2PnwBOZ7r2Dy
         qojHIpmxzaGLrOEx19ARY2tphIb9QezeOV3Eyy1Mh4jcnGjV4sPUXUesdwHSewFoloat
         95cOIQdXcq9/MHJzIEhwkgrRGxnQSQVZPtYtpwrka1YNBS1X2PVw4HNaXKvE4sqoAo64
         ftfcOu6r6KtvCX5pbu/aG0kae2SRVRfJQ43ESCrjCeGBUDaw1WSuSBkYfVr17MhMV07P
         F6ZBfubl71HKTvmFrxV6f+NQpUs9UDfylbVqLSmuNHbSCxiHKByo+5L6Nyq2wWZ7bLQz
         oDPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Oe6pCxuhdOlX+IWLap5U9IbvRognAwuoe/XzsUIXPIyHbdOeU2e++ygdGpk16idHiK/Mllv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1N0wRZ6jBqIiw1gPvm18I4bjaFj+MmpOiFLzviSR5035Ohir
	y0sPqw0ljfq2sFqEWF9TTzE9/up9yzp/wGm1P6OoJ2UMsQUfD5nNupY+vWv1UHh5x1W6GMr7IDr
	OLEOx00mY0eNxFtG22d8Hp1ZFaBcTEzI=
X-Gm-Gg: Acq92OFmxxiKzdQQUKcyHPC+DiHRGQpV8v3wW2xU8lTDjnmTcq0PMaecf2UIi5ulBWm
	Bf/f2pMtJMuYIwqNQcJzG3+5IGHcyRh1n01WbHaODOUvrBcIBZZu0tgML1GbVbhGE5DCbQH/WAg
	pJhh9zgwe9OcSfhvMi+040wtAEEWvv15zQWwl//ROWzvL0p6tzvtjKXV7uXdnoK1nYu4pwpErIR
	BOAZec0Sd1NeS20XaCcQJU7q+q7bJGM/FT9GBa15Y3DyVFY9JXwk3g8n7KyZQJO7L/UhxwelOPL
	WXS9nz9eUF5wVeLHDWxJ5yNoUSYrY9Ffsdr1t2meyj+RYHXEHWqk6Ra7+7Ys8M4Il7jP
X-Received: by 2002:a05:6820:4df7:b0:694:9b71:3743 with SMTP id
 006d021491bc7-69b36ec93d4mr7234995eaf.51.1778584753583; Tue, 12 May 2026
 04:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512014343.3770664-1-mendozayt13@gmail.com> <2026051221-glory-macaroni-dce6@gregkh>
In-Reply-To: <2026051221-glory-macaroni-dce6@gregkh>
From: Sebastian EM <mendozayt13@gmail.com>
Date: Tue, 12 May 2026 06:18:54 -0500
X-Gm-Features: AVHnY4LmjCKV23YG8mUs_u94kVase5gG9LFIqjdkQdDi5hMCxypzAWbazOwnxiQ
Message-ID: <CAD89HyBhwxDsat_JCFFfA-tUYVatxByDj=ikpc9Rxj=kAqn=Sw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: composite: fix integer underflow in WebUSB
 GET_URL handling
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000070da2106519d086a"
X-Rspamd-Queue-Id: 927FD51F405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245440-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mendozayt13@gmail.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--00000000000070da2106519d086a
Content-Type: multipart/alternative; boundary="00000000000070da2006519d0868"

--00000000000070da2006519d0868
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for the review.

You are right; the self Reported-by tag does not belong there, so I dropped
it in v2.

The introducing commit is:

93c473948c58 ("usb: gadget: add WebUSB landing page support")

I also added:

Cc: stable@vger.kernel.org

since the issue was introduced with the WebUSB GET_URL handling path and
the fix is a small bounds/underflow fix suitable for stable kernels.

v2 is attached as a plain patch:

0001-v2-usb-gadget-composite-fix-integer-underflow-in-WebUSB-GET_URL-handli=
ng.patch

Thanks,
Jeremy

El mar, 12 may 2026 a las 0:40, Greg Kroah-Hartman (<
gregkh@linuxfoundation.org>) escribi=C3=B3:

> On Tue, May 12, 2026 at 01:43:43AM +0000, Jeremy Erazo wrote:
> > The WebUSB GET_URL handler in composite_setup() narrows
> > landing_page_length to fit the host-supplied wLength using
> >
> >       landing_page_length =3D w_length
> >               - WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH +
> landing_page_offset;
> >
> > If wLength is smaller than WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH the
> > unsigned subtraction wraps, and the subsequent
> >
> >       memcpy(url_descriptor->URL,
> >              cdev->landing_page + landing_page_offset,
> >              landing_page_length - landing_page_offset);
> >
> > ends up copying close to UINT_MAX bytes from cdev->landing_page into
> > cdev->req->buf.  KASAN reports a slab-out-of-bounds in composite_setup
> > on the kmalloc-2k gadget_info allocation, and FORTIFY_SOURCE traps the
> > memcpy as a 4294967293-byte field-spanning write into
> > url_descriptor->URL (size 252).
> >
> > A USB host can reach this from a single SETUP packet against any
> > gadget that has webusb/use=3D1 and a landingPage configured.
> >
> > Handle the small-wLength case before the math: when the host requested
> > fewer bytes than the URL descriptor header, only the header is
> > meaningful and no URL bytes need to be copied.  Setting
> > landing_page_length to landing_page_offset makes the existing memcpy a
> > no-op and leaves the descriptor returned to the host unchanged for all
> > larger wLength values.
> >
> > Reported-by: Jeremy Erazo <mendozayt13@gmail.com>
> > Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
>
> You don't need a reported-by when you are the author and sign off on
> something.
>
> What commit id does this fix?  Why not backport it to stable kernels?
>
> thanks,
>
> greg k-h
>

--00000000000070da2006519d0868
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd">Hi Greg,=
</p><p class=3D"gmail-isSelectedEnd">Thanks for the review.</p><p class=3D"=
gmail-isSelectedEnd">You are right; the self <code dir=3D"ltr">Reported-by<=
/code> tag does not belong there, so I dropped it in v2.</p><p class=3D"gma=
il-isSelectedEnd">The introducing commit is:</p><p class=3D"gmail-isSelecte=
dEnd"><code dir=3D"ltr">93c473948c58 (&quot;usb: gadget: add WebUSB landing=
 page support&quot;)</code></p><p class=3D"gmail-isSelectedEnd">I also adde=
d:</p><p class=3D"gmail-isSelectedEnd"><code dir=3D"ltr">Cc: <a href=3D"mai=
lto:stable@vger.kernel.org">stable@vger.kernel.org</a></code></p><p class=
=3D"gmail-isSelectedEnd">since the issue was introduced with the WebUSB GET=
_URL handling path and the fix is a small bounds/underflow fix suitable for=
 stable kernels.</p><p class=3D"gmail-isSelectedEnd">v2 is attached as a pl=
ain patch:</p><p class=3D"gmail-isSelectedEnd"><code dir=3D"ltr">0001-v2-us=
b-gadget-composite-fix-integer-underflow-in-WebUSB-GET_URL-handling.patch</=
code></p><p>Thanks,<br>Jeremy</p></div><br><img width=3D"0" height=3D"0" cl=
ass=3D"mailtrack-img" alt=3D"" style=3D"display:flex" src=3D"https://mailtr=
ack.io/trace/mail/1d1278f3f46b0425fcef0a2e9a90bcf63807a760.png?u=3D13483695=
"><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">El mar, 12 may 2026 a las 0:40, Greg Kroah-Hartman (&lt;<a =
href=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org</a>&g=
t;) escribi=C3=B3:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Tue, May 12, 2026 at 01:43:43AM +0000, Jeremy Erazo wrote:<br>
&gt; The WebUSB GET_URL handler in composite_setup() narrows<br>
&gt; landing_page_length to fit the host-supplied wLength using<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0landing_page_length =3D w_length<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- WEBUSB_URL_DES=
CRIPTOR_HEADER_LENGTH + landing_page_offset;<br>
&gt; <br>
&gt; If wLength is smaller than WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH the<br>
&gt; unsigned subtraction wraps, and the subsequent<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(url_descriptor-&gt;URL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-&gt;landing_page =
+ landing_page_offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 landing_page_length - =
landing_page_offset);<br>
&gt; <br>
&gt; ends up copying close to UINT_MAX bytes from cdev-&gt;landing_page int=
o<br>
&gt; cdev-&gt;req-&gt;buf.=C2=A0 KASAN reports a slab-out-of-bounds in comp=
osite_setup<br>
&gt; on the kmalloc-2k gadget_info allocation, and FORTIFY_SOURCE traps the=
<br>
&gt; memcpy as a 4294967293-byte field-spanning write into<br>
&gt; url_descriptor-&gt;URL (size 252).<br>
&gt; <br>
&gt; A USB host can reach this from a single SETUP packet against any<br>
&gt; gadget that has webusb/use=3D1 and a landingPage configured.<br>
&gt; <br>
&gt; Handle the small-wLength case before the math: when the host requested=
<br>
&gt; fewer bytes than the URL descriptor header, only the header is<br>
&gt; meaningful and no URL bytes need to be copied.=C2=A0 Setting<br>
&gt; landing_page_length to landing_page_offset makes the existing memcpy a=
<br>
&gt; no-op and leaves the descriptor returned to the host unchanged for all=
<br>
&gt; larger wLength values.<br>
&gt; <br>
&gt; Reported-by: Jeremy Erazo &lt;<a href=3D"mailto:mendozayt13@gmail.com"=
 target=3D"_blank">mendozayt13@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Jeremy Erazo &lt;<a href=3D"mailto:mendozayt13@gmail.co=
m" target=3D"_blank">mendozayt13@gmail.com</a>&gt;<br>
<br>
You don&#39;t need a reported-by when you are the author and sign off on<br=
>
something.<br>
<br>
What commit id does this fix?=C2=A0 Why not backport it to stable kernels?<=
br>
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div></div>

--00000000000070da2006519d0868--
--00000000000070da2106519d086a
Content-Type: application/octet-stream; 
	name="0001-v2-usb-gadget-composite-fix-integer-underflow-in-WebUSB-GET_URL-handling.patch"
Content-Disposition: attachment; 
	filename="0001-v2-usb-gadget-composite-fix-integer-underflow-in-WebUSB-GET_URL-handling.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mp2jf6aq0>
X-Attachment-Id: f_mp2jf6aq0

RnJvbSA0ZDY1ZTM4NmEzMmMyN2MzZWU0NmE5YmYzZjM4MDdmODk4MDViNWIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZXJlbXkgRXJhem8gPG1lbmRvemF5dDEzQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCAxMiBNYXkgMjAyNiAwMTozMToxNiArMDAwMApTdWJqZWN0OiBbUEFUQ0ggdjJd
IHVzYjogZ2FkZ2V0OiBjb21wb3NpdGU6IGZpeCBpbnRlZ2VyIHVuZGVyZmxvdyBpbiBXZWJVU0IK
IEdFVF9VUkwgaGFuZGxpbmcKClRoZSBXZWJVU0IgR0VUX1VSTCBoYW5kbGVyIGluIGNvbXBvc2l0
ZV9zZXR1cCgpIG5hcnJvd3MKbGFuZGluZ19wYWdlX2xlbmd0aCB0byBmaXQgdGhlIGhvc3Qtc3Vw
cGxpZWQgd0xlbmd0aCB1c2luZwoKCWxhbmRpbmdfcGFnZV9sZW5ndGggPSB3X2xlbmd0aAoJCS0g
V0VCVVNCX1VSTF9ERVNDUklQVE9SX0hFQURFUl9MRU5HVEggKyBsYW5kaW5nX3BhZ2Vfb2Zmc2V0
OwoKSWYgd0xlbmd0aCBpcyBzbWFsbGVyIHRoYW4gV0VCVVNCX1VSTF9ERVNDUklQVE9SX0hFQURF
Ul9MRU5HVEggdGhlCnVuc2lnbmVkIHN1YnRyYWN0aW9uIHdyYXBzLCBhbmQgdGhlIHN1YnNlcXVl
bnQKCgltZW1jcHkodXJsX2Rlc2NyaXB0b3ItPlVSTCwKCSAgICAgICBjZGV2LT5sYW5kaW5nX3Bh
Z2UgKyBsYW5kaW5nX3BhZ2Vfb2Zmc2V0LAoJICAgICAgIGxhbmRpbmdfcGFnZV9sZW5ndGggLSBs
YW5kaW5nX3BhZ2Vfb2Zmc2V0KTsKCmVuZHMgdXAgY29weWluZyBjbG9zZSB0byBVSU5UX01BWCBi
eXRlcyBmcm9tIGNkZXYtPmxhbmRpbmdfcGFnZSBpbnRvCmNkZXYtPnJlcS0+YnVmLiAgS0FTQU4g
cmVwb3J0cyBhIHNsYWItb3V0LW9mLWJvdW5kcyBpbiBjb21wb3NpdGVfc2V0dXAKb24gdGhlIGtt
YWxsb2MtMmsgZ2FkZ2V0X2luZm8gYWxsb2NhdGlvbiwgYW5kIEZPUlRJRllfU09VUkNFIHRyYXBz
IHRoZQptZW1jcHkgYXMgYSA0Mjk0OTY3MjkzLWJ5dGUgZmllbGQtc3Bhbm5pbmcgd3JpdGUgaW50
bwp1cmxfZGVzY3JpcHRvci0+VVJMIChzaXplIDI1MikuCgpBIFVTQiBob3N0IGNhbiByZWFjaCB0
aGlzIGZyb20gYSBzaW5nbGUgU0VUVVAgcGFja2V0IGFnYWluc3QgYW55CmdhZGdldCB0aGF0IGhh
cyB3ZWJ1c2IvdXNlPTEgYW5kIGEgbGFuZGluZ1BhZ2UgY29uZmlndXJlZC4KCkhhbmRsZSB0aGUg
c21hbGwtd0xlbmd0aCBjYXNlIGJlZm9yZSB0aGUgbWF0aDogd2hlbiB0aGUgaG9zdCByZXF1ZXN0
ZWQKZmV3ZXIgYnl0ZXMgdGhhbiB0aGUgVVJMIGRlc2NyaXB0b3IgaGVhZGVyLCBvbmx5IHRoZSBo
ZWFkZXIgaXMKbWVhbmluZ2Z1bCBhbmQgbm8gVVJMIGJ5dGVzIG5lZWQgdG8gYmUgY29waWVkLiAg
U2V0dGluZwpsYW5kaW5nX3BhZ2VfbGVuZ3RoIHRvIGxhbmRpbmdfcGFnZV9vZmZzZXQgbWFrZXMg
dGhlIGV4aXN0aW5nIG1lbWNweSBhCm5vLW9wIGFuZCBsZWF2ZXMgdGhlIGRlc2NyaXB0b3IgcmV0
dXJuZWQgdG8gdGhlIGhvc3QgdW5jaGFuZ2VkIGZvciBhbGwKbGFyZ2VyIHdMZW5ndGggdmFsdWVz
LgoKRml4ZXM6IDkzYzQ3Mzk0OGM1OCAoInVzYjogZ2FkZ2V0OiBhZGQgV2ViVVNCIGxhbmRpbmcg
cGFnZSBzdXBwb3J0IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTog
SmVyZW15IEVyYXpvIDxtZW5kb3pheXQxM0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy91c2IvZ2Fk
Z2V0L2NvbXBvc2l0ZS5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3Np
dGUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYwppbmRleCBhOTAyMTg0YmQuLmRj
MzY2NDM3NCAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jCisrKyBi
L2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYwpAQCAtMjE3Miw3ICsyMTcyLDEwIEBAIGNv
bXBvc2l0ZV9zZXR1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCBjb25zdCBzdHJ1Y3QgdXNi
X2N0cmxyZXF1ZXN0ICpjdHJsKQogCQkJCXNpemVvZih1cmxfZGVzY3JpcHRvci0+VVJMKQogCQkJ
CS0gV0VCVVNCX1VSTF9ERVNDUklQVE9SX0hFQURFUl9MRU5HVEggKyBsYW5kaW5nX3BhZ2Vfb2Zm
c2V0KTsKIAotCQkJaWYgKHdfbGVuZ3RoIDwgV0VCVVNCX1VSTF9ERVNDUklQVE9SX0hFQURFUl9M
RU5HVEggKyBsYW5kaW5nX3BhZ2VfbGVuZ3RoKQorCQkJaWYgKHdfbGVuZ3RoIDwgV0VCVVNCX1VS
TF9ERVNDUklQVE9SX0hFQURFUl9MRU5HVEgpCisJCQkJbGFuZGluZ19wYWdlX2xlbmd0aCA9IGxh
bmRpbmdfcGFnZV9vZmZzZXQ7CisJCQllbHNlIGlmICh3X2xlbmd0aCA8CisJCQkJIFdFQlVTQl9V
UkxfREVTQ1JJUFRPUl9IRUFERVJfTEVOR1RIICsgbGFuZGluZ19wYWdlX2xlbmd0aCkKIAkJCQls
YW5kaW5nX3BhZ2VfbGVuZ3RoID0gd19sZW5ndGgKIAkJCQktIFdFQlVTQl9VUkxfREVTQ1JJUFRP
Ul9IRUFERVJfTEVOR1RIICsgbGFuZGluZ19wYWdlX29mZnNldDsKIAotLSAKMi41My4wCgo=
--00000000000070da2106519d086a--

