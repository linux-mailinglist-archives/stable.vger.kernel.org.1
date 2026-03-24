Return-Path: <stable+bounces-230071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC+XNxxEwmnvbAQAu9opvQ
	(envelope-from <stable+bounces-230071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:58:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0760304427
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 214E53122C39
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98363350A0F;
	Tue, 24 Mar 2026 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVHDljwc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082433D6FA
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338409; cv=pass; b=Ar7WJmJBlDVGxZX9Jo5b+jphNDp2vX+iDYiLmByK0GDlSgFjmYHcv0Xf57HO0GkwjItd7Z+nbsNN0jwr2f0Pl4Rz9WPH7XQ17G3LOmwgRPLweyI/dt+R3apqt2VJ1xvZgCEArItrbwXrHFpkCbDWLWT8pOMfPypJjjdPab2psjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338409; c=relaxed/simple;
	bh=UD2wbaMFnRxKpWf+z6+HfYus07A2S++EQyCRhHJ9cek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaiJAMiGemNHONCv9g1YoBdJXgbQhqP1kUVf+LlFTp6EFOuTB9rlnyC4Sw56RL+RcD+wOa2U3VTcYAb8ZK+3+HSpC8qCb0grhe5z9xTJJFqLdWwvrZEUzuCghTia2A+hwYJy6ERoMbRVLt0hj/DaG4ObN3GbASpBnPfOwr9lrGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVHDljwc; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso55445706d6.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 00:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774338399; cv=none;
        d=google.com; s=arc-20240605;
        b=g37TRK6D+MHSnymKbpkxsVjBpkHyB9qouaB5gupILS1tJcO/vB3yXts015bb3wG9tN
         +wA8y1qLuUJHtTNhOAX0U9pYZ2GPHolg375nxYcBHsQGkGLkRwfXnb18tnbpfooia/0F
         K2XwGijK26Sk4P/TQVivNk/hzRSPpKTPWSVilEdfHJOExCsyPxkQE8ItANaBsY0x0qXZ
         RMKiXhIN6w2vFH8k4APlaOseg3v98Q9Li4d/E8BR5aNjxJpbK8TIcTg0iHEcuuAc0JbZ
         X39oEwRIM6UHnwCeX4fEZK+WKyut1ynbuXJFfdbE6Q/kUo+WXh8K0vkSgAGbTto7v1tZ
         3x0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xHFEGvyuVueh8l+H85vdxytZmPQSqK2Ng0X2X/FjRmY=;
        fh=ir1VmeEp3BKK4DdpuvsTGTspyvxHEBGFl2R1aYMRJOI=;
        b=FUUi9OyLI0EW8TksXn5OPAMolZr4PSzFTyq6pKbzFmV9Z98PszsBCZ+UxndBvrxwXM
         8pb1cikQlXPEVl1nX4ZolzDzxXgceh8MgovP/CobjnQj/XcbjAb0SiCB+RFFHxCRjSeS
         5nfzkb9wJeRf41m6WnNZhVvnOYtY/HqdAmyXOMCnQ7m9mYZGB+hVui12L+b3FKA4PH52
         //bQpO9/BES+jQ0yMmlHxLlSRzTLE/M+rz3WPOyCvXk6G3YaR0OODqlzJC2xqx5ju3eP
         MPBKEDGYgqmlGpRUOZXhQs2tKPbPnhR28bSWemj29wiSaz/8v8jsQa9vEx1a3kzlUnon
         D5hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774338399; x=1774943199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHFEGvyuVueh8l+H85vdxytZmPQSqK2Ng0X2X/FjRmY=;
        b=IVHDljwckLIKLol7nhi19INQTzeRtFflAkbh88s6VJtfat3zwMm9rsUBTnaMG9899D
         3FdETyKPzZz8wbPlOt4ouyn6pCFuDK9xjKg4YEtFMF74kc10R1DmwJIYEYhi+nq9fOnq
         mhNk3hi1HzzZsfvZ80XNSuJvHCDoFWsj0VlSOIVCDsgJZyV3sLZvtcJuNBykka14jCqh
         G57aLUGxR8PQVvNT7ALpOu4g5yUI8AWugaBOqgYDkliTojku2nhhG64W1UBNiJ43JjlZ
         o6tMQwrWIpj7duA6NgYfaPtb9urpRsA2xuiVGEW6b4fvCTwUzGtFCZnW8UxOSz4l6J2t
         iiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774338399; x=1774943199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHFEGvyuVueh8l+H85vdxytZmPQSqK2Ng0X2X/FjRmY=;
        b=YdroiWI+Lig+VY8CvHaH22aJV1PGOy1thtlTlqZa1Zxw7maCAZTCoCenYdhA4WsCyh
         A79dEbCWL5ER7prJAkPfogrxXcxXHoH777PODVCLUSAzSBstpjc9xwi9V4RFQAfjtoEp
         uebU9YkwhJqPOplasmfEWC28N0rnCjm/e6fc8UzTNqRwTrrB6uA2m87h+JA9kspILhdV
         zrIEHOhfUdWI4lrBtIM24BvOe+nVxZzUEVecN0ePAf5JuuMWjtLoLWzpHQUjrD6r/OQz
         iVwBiwPT68ZuqhnGmByMjvXhwVAbrM2kkKAdrVKeET0INDZMBlHXCLSghQ95/642zuIz
         uh0g==
X-Forwarded-Encrypted: i=1; AJvYcCXLHFQzd0rI1U240TCT+ZbLo+pXgKULa8j9aa/t5SRxuv9Fv978Oqy4NppB+j9IzaE6q6Apsbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQ4C7S1U8rPWpB/iBbULmCAwdp9F6dPA3lqRUNaLiYrym5xli
	rIzC+ifZyRudvT5ilFT09Tmp5OCbSDXPUp5baatWE/NrKGcT6+wWiYgoQBg0cP8Fjvi+RQL+8rh
	VinrEaLAf6Gn1DoJsuo8YXcbmfz2uer9gHnT8mGEf
X-Gm-Gg: ATEYQzwm38sqOai7g753cPo2ywdcEIi5TOqFR/ArZtV7NlKLsDgLzoZuSBRmSGpjBcN
	gWpiPMXAhICoC5oiB1m+eNWIFu8YmyxKxtP+NLWy0F4reJCCqibMvnb+GVn7FUdlFCmeLoFsH/1
	j6ohfqXHbFcdzQw0chDyp8ke5sRzyXK5DagR/PouuPOGDJKWY6ue/2b9cQfQZh//IrFj9J8T5FR
	de4F5NEEbT5NxYsPjJlBq3NEMNLtNeWIF0Jskp5Q0EQbOu2IYFhLGJRYOro00xL1qhYdZrXIFjT
	SRHqBw==
X-Received: by 2002:ad4:5d62:0:b0:89c:a2c8:a874 with SMTP id
 6a1803df08f44-89ca2c8af85mr111671516d6.41.1774338398191; Tue, 24 Mar 2026
 00:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312025406.15641-1-xietangxin@yeah.net> <1774335943.3427165-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1774335943.3427165-1-xuanzhuo@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Mar 2026 00:46:27 -0700
X-Gm-Features: AaiRm51GA4aV1ym9PHNSS4b7XqpUYygD3yfgSv699tCpajq3gs0b1wqLQ4Ac1Ew
Message-ID: <CANn89iJYj9Jc8-usgAYcFMoSo+Po3aOxsMkhg+F8BA_kME2e9g@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: xietangxin <xietangxin@yeah.net>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230071-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[yeah.net,vger.kernel.org,lists.linux.dev,redhat.com,davemloft.net,kernel.org,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,yeah.net:email]
X-Rspamd-Queue-Id: A0760304427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu, 12 Mar 2026 10:54:06 +0800, xietangxin <xietangxin@yeah.net> wrot=
e:
> > A UAF issue occurs when the virtio_net driver is configured with napi_t=
x=3DN
> > and the device's IFF_XMIT_DST_RELEASE flag is cleared
> > (e.g., during the configuration of tc route filter rules).
> >
> > When IFF_XMIT_DST_RELEASE is removed from the net_device, the network s=
tack
> > expects the driver to hold the reference to skb->dst until the packet
> > is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> > skbs may remain in the virtio transmit ring for an extended period.
> >
> > If the network namespace is destroyed while these skbs are still pendin=
g,
> > the corresponding dst_ops structure has freed. When a subsequent packet
> > is transmitted, free_old_xmit() is triggered to clean up old skbs.
> > It then calls dst_release() on the skb associated with the stale dst_en=
try.
> > Since the dst_ops (referenced by the dst_entry) has already been freed,
> > a UAF kernel paging request occurs.
>
> Sorry, this sounds a bit off to me. We know that napi_tx=3DN merely prolo=
ngs the
> presence of the skb on the device side. However, even without napi_tx=3DN=
, there
> is no guarantee that the skb will be freed within any specific timeframe.
> Therefore, napi_tx=3DN just makes the issue more reproducible; it is not =
the root
> cause. Also, I'm surprised that the dst could be freed while it is still
> referenced/held. I have a feeling that something is being overlooked here=
.
>
> Thanks.
>
> >
> > fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> > the dst reference before the skb is queued in virtio_net.
> >
> > Call Trace:
> >  Unable to handle kernel paging request at virtual address ffff80007e15=
0000
> >  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1=
+ #6 PREEMPT
> >   ...
> >   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
> >   dst_release+0xe0/0x110  net/core/dst.c:177
> >   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
> >   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
> >   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
> >   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
> >   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net=
]
> >   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
> >   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
> >   ...
> >
> > Reproduction Steps:
> > NETDEV=3D"enp3s0"
> >
> > config_qdisc_route_filter() {
> >     tc qdisc del dev $NETDEV root
> >     tc qdisc add dev $NETDEV root handle 1: prio
> >     tc filter add dev $NETDEV parent 1:0 \
> >       protocol ip prio 100 route to 100 flowid 1:1
> >     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> > }
> >
> > test_ns() {
> >     ip netns add testns
> >     ip link set $NETDEV netns testns
> >     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
> >     ip netns exec testns ping -c 1 10.0.32.1
> >     ip netns del testns
> > }
> >
> > config_qdisc_route_filter
> >
> > test_ns
> > sleep 2
> > test_ns

I took a stab at this, please look at

https://lore.kernel.org/netdev/20260324073750.1500328-1-edumazet@google.com=
/T/#u

