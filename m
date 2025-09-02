Return-Path: <stable+bounces-176996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF05B3FDCD
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A387D201B92
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ADC285C9C;
	Tue,  2 Sep 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="jrh/cEKL"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f62.google.com (mail-lf1-f62.google.com [209.85.167.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E1272E5E
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812696; cv=none; b=s0h4+YUdLjYoeFTTC2e0jBudlXJBS7OBc0dTjeVNdm7m78OUThWt1B5mi32CHubMlkp/xYYXzwHuGFZ03BMnJt+AX5ObhOTZrKuOJc49WNjrsSjyORkgs4lrrCofoFavQkDkFjWPA0n4+TN73yg9NxfShc/KFUHFoUG0Id/IMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812696; c=relaxed/simple;
	bh=oElz8VSO5EYA/wCsnT/rlk6d9OjKV4EVCVIvpIOOBSk=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mjYSotXU6opfUmiX9fKtAGKcyKYQZRgFw3ZgwXwnrEllMJAHl2Qz6WTTd2Geclw2Jj9GS7GGqCPVunWsr3gsFBuEVgeK7hnoRdc6IUCEx0oDBJJ1LnCN6Eqa1Dd56HLCZqB4SwjNhPoD07IBLY2r4/DgRpS79OdrY5NNdUTKFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=jrh/cEKL; arc=none smtp.client-ip=209.85.167.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-lf1-f62.google.com with SMTP id 2adb3069b0e04-55f5f436648so3968004e87.2
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756812692; x=1757417492; darn=vger.kernel.org;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3FuW5weURznHvhWFk4tKYugZwWgzV6QTLSP6i15j1s=;
        b=jrh/cEKLhM7QC3VRvQFHyMRc8xWjZtt9Dp/3og79hKR7hzI3UlduISI1KzeDDpyfET
         dVf+qbBMIdhGsFIs3ijNR56u+oclvwANWGHZHTm8eONIdPPr/B8tFr6+6FfGzBg/qQqb
         tiZVSRUFz37tThdbvH/upgUf417PlmEpwD+fya1MNXFnRSTS71oXHKncEOsmnIqF+Sfz
         k7NZlSdaolRdR1iIDOgLQNkAp1XaQQqqjTaS08znO/OuXCg+ZgeBtWyp1NxO5USzvEXK
         ihQpmvhx8CmFqC2FhjEI7bxr7S7BcG1LU0FhNYg7froI272AnfR5awcGOhEIftkGqKp6
         B00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756812692; x=1757417492;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3FuW5weURznHvhWFk4tKYugZwWgzV6QTLSP6i15j1s=;
        b=T10EbMEsZMR18ORhF3DKfTFnO9JyObbqPBikc+BIxT2BeetPEx60UIUlwkecNcSASn
         iQXsMF5LIivQQDC60CnaHUmqLks5fvsp+GhKvluVgdqjYL3hQas6WrOv6Poq3XfkWdFR
         ZhzEhgax0CJKbI8ToH0rZ6Zt97FJery5EhDLPqAhghAMTFkWbvpkozjcfy6YGOJmAPA4
         zs5GO/2CS/xpadZQ9E/kzSWquBscSqOA65ZvE/OqSqo322z7mlWQmLYAaw5RLZ6mlKUd
         sHzTZbU2hrSTslqLUIhdETY5pyl+DXwLLxXMDn3IA/ZRDNvWW+8tvSxDQEqfp3c8iRX/
         gBAw==
X-Forwarded-Encrypted: i=1; AJvYcCU6HQ/RVNMZ+6C18F2b/Ptvs/AYEX83ltBoeYBbawhkSOjun4eYmawA0grfyWWL/9u5aWM+K1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/tthYQMCCSOiva5EeBXnMmLeLLq1E+PF/7Pho4ogprSyXlRy
	xpVWkGmENvXYwKONwIke5Oq0hsMixVa9DR6OrhFQp/SKf63pwpkevaeZ9EC1bZsDgBNsTUOLDtM
	gs39xmJZjKfuyWA==
X-Google-Smtp-Source: AGHT+IF1LSQ0dwhxQr50cLKK4WhSICuNangjaBSwDVH+C9VMVC8MCEkZB/XmNZsIJWKsxhlBa8g6hBD/6g==
X-Received: by 2002:a05:6512:1594:b0:55f:6831:6ef4 with SMTP id 2adb3069b0e04-55f7089c47amr3234064e87.12.1756812692322;
        Tue, 02 Sep 2025 04:31:32 -0700 (PDT)
X-Google-Already-Archived: Yes
X-Google-Already-Archived-Group-Id: 38d67f2e3d
X-Google-Doc-Id: 116551291f40c8
X-Google-Thread-Id: ec15f2a7194813d2
X-Google-Message-Url: http://groups.google.com/a/aisle.com/group/disclosure/msg/116551291f40c8
X-Google-Thread-Url: http://groups.google.com/a/aisle.com/group/disclosure/t/ec15f2a7194813d2
X-Google-Web-Client: true
Date: Tue, 2 Sep 2025 04:31:29 -0700 (PDT)
From: Disclosure <disclosure@aisle.com>
To: Disclosure <disclosure@aisle.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"security@kernel.org" <security@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Message-Id: <41e965f4-6797-44fd-bb7d-490292bbfeaan@aisle.com>
In-Reply-To: <CANn89iJM3CV-_2jWMMspH52RvfWtep-3srctf47NkYUkTTboSg@mail.gmail.com>
References: <20250827143715.23538-1-disclosure@aisle.com>
 <CANn89iJM3CV-_2jWMMspH52RvfWtep-3srctf47NkYUkTTboSg@mail.gmail.com>
Subject: Re: [PATCH net] netrom: validate header lengths in nr_rx_frame()
 using pskb_may_pull()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26596_571905334.1756812689919"

------=_Part_26596_571905334.1756812689919
Content-Type: multipart/alternative; 
	boundary="----=_Part_26597_1359396716.1756812689919"

------=_Part_26597_1359396716.1756812689919
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric, (cc Kuba and others)

Thank you for the technical feedback on the NET/ROM patch. You were=20
absolutely right about the use-after-free issue in the previous version.=20
That would have made things worse, good point!

I've sent a v2 patch that addresses your concerns:
- Single upfront pskb_may_pull() before any pointer assignments
- Full linearization as you suggested
- Detailed attack vector documentation

The v2 is now on the list:=20
https://lore.kernel.org/netdev/20250902112652.26293-1-disclosure@aisle.com/=
T/#u

I don't have a specific stack trace to show but the call graph flow looks=
=20
convincing enough to me. Given how simple the patch is, could this be=20
sufficient?

Thanks for taking the time to review this carefully. Please let me know if=
=20
anything needs to be modified or resent.

Best wishes,
Stanislav Fort
Aisle Research

On Monday, September 1, 2025 at 10:38:05=E2=80=AFAM UTC+3 Eric Dumazet wrot=
e:

> On Wed, Aug 27, 2025 at 7:38=E2=80=AFAM Stanislav Fort <disclosure@aisle.=
com>=20
> wrote:
> >
> > NET/ROM nr_rx_frame() dereferences the 5-byte transport header
> > unconditionally. nr_route_frame() currently accepts frames as short as
> > NR_NETWORK_LEN (15 bytes), which can lead to small out-of-bounds reads
> > on short frames.
> >
> > Fix by using pskb_may_pull() in nr_rx_frame() to ensure the full
> > NET/ROM network + transport header is present before accessing it, and
> > guard the extra fields used by NR_CONNREQ (window, user address, and th=
e
> > optional BPQ timeout extension) with additional pskb_may_pull() checks.
> >
> > This aligns with recent fixes using pskb_may_pull() to validate header
> > availability.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> > ---
> > net/netrom/af_netrom.c | 12 +++++++++++-
> > net/netrom/nr_route.c | 2 +-
> > 2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> > index 3331669d8e33..1fbaa161288a 100644
> > --- a/net/netrom/af_netrom.c
> > +++ b/net/netrom/af_netrom.c
> > @@ -885,6 +885,10 @@ int nr_rx_frame(struct sk_buff *skb, struct=20
> net_device *dev)
> > * skb->data points to the netrom frame start
> > */
> >
> > + /* Ensure NET/ROM network + transport header are present */
> > + if (!pskb_may_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN))
> > + return 0;
> > +
> > src =3D (ax25_address *)(skb->data + 0);
> > dest =3D (ax25_address *)(skb->data + 7);
> >
> > @@ -961,6 +965,12 @@ int nr_rx_frame(struct sk_buff *skb, struct=20
> net_device *dev)
> > return 0;
> > }
> >
> > + /* Ensure NR_CONNREQ fields (window + user address) are present */
> > + if (!pskb_may_pull(skb, 21 + AX25_ADDR_LEN)) {
>
> If skb->head is reallocated by this pskb_may_pull(), dest variable
> might point to a freed piece of memory
>
> (old skb->head)
>
> As far as netrom is concerned, I would force a full linearization of
> the packet very early
>
> It is also unclear if the bug even exists in the first place.
>
> Can you show the stack trace leading to this function being called
> from an arbitrary
> provider (like a packet being fed by malicious user space)
>
> For instance nr_rx_frame() can be called from net/netrom/nr_loopback.c
> with non malicious packet.
>
> For the remaining caller (nr_route_frame()), it is unclear to me.
>

------=_Part_26597_1359396716.1756812689919
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Eric, (cc Kuba and others)<br /><br />Thank you for the technical feedba=
ck on the NET/ROM patch. You were absolutely right about the use-after-free=
 issue in the previous version. That would have made things worse, good poi=
nt!<br /><br />I've sent a v2 patch that addresses your concerns:<br />- Si=
ngle upfront pskb_may_pull() before any pointer assignments<br />- Full lin=
earization as you suggested<br />- Detailed attack vector documentation<br =
/><br />The v2 is now on the list: https://lore.kernel.org/netdev/202509021=
12652.26293-1-disclosure@aisle.com/T/#u<div><br /></div><div>I don't have a=
 specific stack trace to show but the call graph flow looks convincing enou=
gh to me. Given how simple the patch is, could this be sufficient?<br /><br=
 />Thanks for taking the time to review this carefully. Please let me know =
if anything needs to be modified or resent.<br /><br />Best wishes,<br />St=
anislav Fort<br />Aisle Research<br /><br /></div><div class=3D"gmail_quote=
"><div dir=3D"auto" class=3D"gmail_attr">On Monday, September 1, 2025 at 10=
:38:05=E2=80=AFAM UTC+3 Eric Dumazet wrote:<br/></div><blockquote class=3D"=
gmail_quote" style=3D"margin: 0 0 0 0.8ex; border-left: 1px solid rgb(204, =
204, 204); padding-left: 1ex;">On Wed, Aug 27, 2025 at 7:38=E2=80=AFAM Stan=
islav Fort &lt;<a href=3D"mailto:disclosure@aisle.com" target=3D"_blank" re=
l=3D"nofollow">disclosure@aisle.com</a>&gt; wrote:
<br>&gt;
<br>&gt; NET/ROM nr_rx_frame() dereferences the 5-byte transport header
<br>&gt; unconditionally. nr_route_frame() currently accepts frames as shor=
t as
<br>&gt; NR_NETWORK_LEN (15 bytes), which can lead to small out-of-bounds r=
eads
<br>&gt; on short frames.
<br>&gt;
<br>&gt; Fix by using pskb_may_pull() in nr_rx_frame() to ensure the full
<br>&gt; NET/ROM network + transport header is present before accessing it,=
 and
<br>&gt; guard the extra fields used by NR_CONNREQ (window, user address, a=
nd the
<br>&gt; optional BPQ timeout extension) with additional pskb_may_pull() ch=
ecks.
<br>&gt;
<br>&gt; This aligns with recent fixes using pskb_may_pull() to validate he=
ader
<br>&gt; availability.
<br>&gt;
<br>&gt; Fixes: 1da177e4c3f4 (&quot;Linux-2.6.12-rc2&quot;)
<br>&gt; Reported-by: Stanislav Fort &lt;<a href=3D"mailto:disclosure@aisle=
.com" target=3D"_blank" rel=3D"nofollow">disclosure@aisle.com</a>&gt;
<br>&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" re=
l=3D"nofollow">stable@vger.kernel.org</a>
<br>&gt; Signed-off-by: Stanislav Fort &lt;<a href=3D"mailto:disclosure@ais=
le.com" target=3D"_blank" rel=3D"nofollow">disclosure@aisle.com</a>&gt;
<br>&gt; ---
<br>&gt;  net/netrom/af_netrom.c | 12 +++++++++++-
<br>&gt;  net/netrom/nr_route.c  |  2 +-
<br>&gt;  2 files changed, 12 insertions(+), 2 deletions(-)
<br>&gt;
<br>&gt; diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
<br>&gt; index 3331669d8e33..1fbaa161288a 100644
<br>&gt; --- a/net/netrom/af_netrom.c
<br>&gt; +++ b/net/netrom/af_netrom.c
<br>&gt; @@ -885,6 +885,10 @@ int nr_rx_frame(struct sk_buff *skb, struct n=
et_device *dev)
<br>&gt;          *      skb-&gt;data points to the netrom frame start
<br>&gt;          */
<br>&gt;
<br>&gt; +       /* Ensure NET/ROM network + transport header are present *=
/
<br>&gt; +       if (!pskb_may_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN)=
)
<br>&gt; +               return 0;
<br>&gt; +
<br>&gt;         src  =3D (ax25_address *)(skb-&gt;data + 0);
<br>&gt;         dest =3D (ax25_address *)(skb-&gt;data + 7);
<br>&gt;
<br>&gt; @@ -961,6 +965,12 @@ int nr_rx_frame(struct sk_buff *skb, struct n=
et_device *dev)
<br>&gt;                 return 0;
<br>&gt;         }
<br>&gt;
<br>&gt; +       /* Ensure NR_CONNREQ fields (window + user address) are pr=
esent */
<br>&gt; +       if (!pskb_may_pull(skb, 21 + AX25_ADDR_LEN)) {
<br>
<br>If skb-&gt;head is reallocated by this pskb_may_pull(), dest variable
<br>might point to a freed piece of memory
<br>
<br>(old skb-&gt;head)
<br>
<br>As far as netrom is concerned, I would force a full linearization of
<br>the packet very early
<br>
<br>It is also unclear if the bug even exists in the first place.
<br>
<br>Can you show the stack trace leading to this function being called
<br>from an arbitrary
<br>provider (like a packet being fed by malicious user space)
<br>
<br>For instance nr_rx_frame() can be called from net/netrom/nr_loopback.c
<br>with non malicious packet.
<br>
<br>For the remaining caller (nr_route_frame()), it is unclear to me.
<br></blockquote></div>
------=_Part_26597_1359396716.1756812689919--

------=_Part_26596_571905334.1756812689919--

