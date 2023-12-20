Return-Path: <stable+bounces-7958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0EF8195D1
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 01:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFAD1C20F7E
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB46A1FC6;
	Wed, 20 Dec 2023 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+ujJgUB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D923B8
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e6c8b70766so24310837b3.3
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 16:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703033047; x=1703637847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHFIJdfC1F3WiR/Vnayo6aNrm4aYziDKRtE7fbhaxaQ=;
        b=t+ujJgUBAwhkpLV4qhwm1U8JCq9KtjU1ZO+zZAXcK23EpcC17QFuXKE1yOdXKvpZxd
         yZFrAwZznyfM7J6HQMOuVZOZr26FjGE33fg0mmflO4CMpm4PubwG6jvBcmLNTQGBvSsh
         Puvs+LJZsVueDZlRhYjKzIHLjMRlRGhIvnYDyJdGxT7hQ9XqpcCRS5JNou/8CwOsfi8L
         /pBdza8Kf/j5z/vLP6b+PKT/SF476986M4ORlf6NmZ9YVn0j4Yx/kdICfSdXv1bZuJ7M
         qbHIKIxIEeiPqNu51DDEbcWsQXum69zCWlSB9ZvD904C456lCu1G5vmRdvzigIDAad8u
         tY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703033047; x=1703637847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHFIJdfC1F3WiR/Vnayo6aNrm4aYziDKRtE7fbhaxaQ=;
        b=tbzX0BqoWjvSMwRnqSoFVZ1BxubRbvrRZRehsqCZ1Y7G2qOoncZX9v2nMhBGiXUTAU
         3cuwEc0sF8nYCJudgtRJnSbhwMsQ8NMq2Vf/B9C5VNBwR1GMDJlJy49fTx/iKoq9TTTX
         uiVE/poTA+dP2yU31t/dHM5gUUSNkjgZ3kfvcvV2dxTcKcz/1A81f12ZpHO9U7Z2ogEi
         FmjFVI9BLLAdy6T1Ia0b7CgyNkmjRnXcQh241kdMh4WdlmqUg7PqCWTDeT3tWTDvU5D6
         /qn8xeXi1w6F4sD5Pib+FxjGYo7dqllE/7MQJybaQqtQ8cylMQK8xC8YoRk6XtSLabxE
         anWg==
X-Gm-Message-State: AOJu0YwDsGDOOnxHI5M8Ww8r2/WzUN+TbpvbcBQWdoCX42PAyivA/Hvf
	0HwezhVwVFkK0FZdif4OnM9tEYfgDDHBffmldgeU3Q==
X-Google-Smtp-Source: AGHT+IG+ixtxewnu1cb68kdIkUKSdsH/iLjkp1nBvDHO9fUtWQsDe9ljgkei76vM2wkLx5Q5IraaBDWc0qx7qL1caz8=
X-Received: by 2002:a0d:d646:0:b0:5e7:ea97:5bdc with SMTP id
 y67-20020a0dd646000000b005e7ea975bdcmr1416662ywd.79.1703033046955; Tue, 19
 Dec 2023 16:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <20231218162326.173127-2-romain.gantois@bootlin.com> <20231219122034.pg2djgrosa4irubh@skbuf>
 <20231219140754.7a7a8dbd@device-28.home> <CACRpkdaxy9u=1-rQ+f+1tb8xyV-GYOuq52xhb4_SRPk9-LpnUA@mail.gmail.com>
 <20231219172932.13f4b0c3@device-28.home> <20231219224616.pw32w5eq2dbuja5i@skbuf>
In-Reply-To: <20231219224616.pw32w5eq2dbuja5i@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 01:43:55 +0100
Message-ID: <CACRpkdbo=Oem4PCOtSV6iWJoojRetTgZhx7J91uecTa-DQA8iQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sylvain Girard <sylvain.girard@se.com>, Pascal EBERHARD <pascal.eberhard@se.com>, 
	Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:46=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> On Tue, Dec 19, 2023 at 05:29:32PM +0100, Maxime Chevallier wrote:

> > > I can certainly add a helper such as skb_eth_raw_ethertype()
> > > to <linux/if_ether.h> that will inspect the actual ethertype in
> > > skb->data.
> > >
> > > It's the most straight-forward approach.
> >
> > Agreed :)
>
> If you rewrite that patch to use skb_vlan_eth_hdr() to get a struct
> vlan_ethhdr pointer through which h_vlan_proto and h_vlan_encapsulated_pr=
oto
> are accessible, I don't see much value in writing that helper. It is
> going to beg the question how generic should it be - should it also
> treat ETH_P_8021AD, should it treat nested VLANs?

I guess I should just post the patches inline. (It came from both
Erics and Maximes suggestion really.)

Actually I wrote two helpers, one to get the ethertype from the
ethernet frame which is pretty straight-forward.

include/linux/if_ether.h

+/* This determines the ethertype incoded into the skb data without
+ * relying on skb->protocol which is not always identical.
+ */
+static inline u16 skb_eth_raw_ethertype(const struct sk_buff *skb)
+{
+       struct ethhdr *hdr;
+
+       /* If we can't extract a header, return invalid type */
+       if (!skb_pointer_if_linear(skb, 0, ETH_HLEN))
+               return 0x0000U;
+
+       hdr =3D skb_eth_hdr(skb);
+
+       return ntohs(hdr->h_proto);
+}

Then for *this* driver I need to check for the ethertype
ETH_P_8021Q what is inside it, one level down, and that is a
separate helper. And I named it skb_vlan_raw_inner_ethertype()
It will retrieve the inner type no matter

include/linux/if_vlan.h

+/* This determines the inner ethertype incoded into the skb data without
+ * relying on skb->protocol which is not always identical.
+ */
+static inline u16 skb_vlan_raw_inner_ethertype(const struct sk_buff *skb)
+{
+       struct vlan_ethhdr *vhdr;
+
+       if (!skb_pointer_if_linear(skb, 0, VLAN_ETH_HLEN))
+               return 0x0000U;
+
+       vhdr =3D vlan_eth_hdr(skb);
+       return ntohs(vhdr->h_vlan_encapsulated_proto);
+}

(We can bikeshed the name of the function. *_inner_protocol maybe.)

It does not handle nested VLANs and I don't see why it should since
the immediate siblings in if_vlan.h does not, i.e.
vlan_eth_hdr(), skb_vlan_eth_hdr(). It's pretty clear these helpers
all go just one level down. (We can add a *_descend_*()
helper the day someone needs that.)

> At the end of the day, you are trying to cover in software the cases for
> which the hardware engine can perform TX checksum offloading. That is
> going to be hardware specific.

Yeps and I am happy to fold these helpers inside of my driver if
they are not helpful to anyone else, or if that is the best idea for someth=
ing
intended for a fix, i.e. an -rc kernel.

> I guess we should first try to answer the questions "what does
> skb->protocol represent?" and "does DSA use it correctly?" before
> even thinking about adding yet another fuzzy layer on top it.

Fair point! Let's take a step back. The kerneldoc says:

 *      @protocol: Packet protocol from driver

That's a bit vague and it was in the first commit in git history :/

But Eric probably knows the right way to use protocol.

But we know for sure that VLAN uses this for the outermost protocol
ETH_P_8021Q (etc).

I wonder how the network stack reacts if we set the skb->protocol
to whatever DSA taggers put at the position of the ethertype.

For RTL taggers probably this works because they use an elaborate
custom ethertype, but e.g. net/dsa/tag_mtk.c will just put in
"ethertype" 0x0000, 0x0001 or 0x0002, the two latter which are
formally ETH_P_802_3 and ETH_P_AX25 which I think is maybe
not so good to put into skb->protocol.

Another option is to set it to the ETH_P_DSA ethertype, currently
unused in the kernel.

Now this kind of thinking makes me insecure because:
git grep '\->protocol' net/

There is just sooooo much code inspecting ->protocol in the generic
network stack that this seems like inviting disaster.

Yours,
Linus Walleij

