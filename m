Return-Path: <stable+bounces-227882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AExiM9SywGm5KAQAu9opvQ
	(envelope-from <stable+bounces-227882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 04:26:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2E2EC30A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 04:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C637A300C92A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 03:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C341221FD4;
	Mon, 23 Mar 2026 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n01T+QjM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE81514F8
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774236355; cv=pass; b=ZhuaCEwzHrj/1FIWLSF7CnAQ9VOdMEKh0Mv6ToMnDvvmlMCMZ1FUm0jnry4MQKc1XDa22d5MlpnXi2t3QeU3UbMvRNOFu0BhHsSgufj9DEU4WgIqMbSyAx1K8rSbZHyLM4ue3UBcMy5fAxFYmwkQiQ1jmpzaFSuCqYuJBU6tZ3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774236355; c=relaxed/simple;
	bh=trYXd+qS6SYDkW2s6J7OKv/QntNeUFXPU+UGiKH6oik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC1XPsXJNqscCkroJ6VdPqSLSQbNi5tsxVa4TyT5tbsP7u7rKSb6P6bqmaCdJpLdwVDmAmXQMTMSpx9GapgyUQ1FVb34M6ME/phOWl8wc8hTIytK1/nRIvIWWQ/joq5u89/gYghvRIS5/IaPl4+A1OWa6R1M++OlUB1cVcrVz0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n01T+QjM; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b30d61be6so1128831cf.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 20:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774236352; cv=none;
        d=google.com; s=arc-20240605;
        b=JTBL8IcpC9kjGB2fKFzA/jquCdLS7QImYV23vbaL6O2UVyJdHuJvLBYPMXxQQJpKFF
         1T5gZfYcKH+erk1xF+y9Z+TenelPNZ0v2P4Xem7YsZ0dMWttNyMXVqvHzv7QdpfHhbvL
         l6ruBcpteXAkRsEKxMFk/hy8zvDnqKK33pOgdNr5dlhMKqiX588zEdMRVwu62E/jlQaB
         8sg5DwyQtbeRS4QzCFeaQUzoWmFg0DokgF6MKdZqtzfYI9ckxw6e+crYiG266OA83Y3B
         m8g5a2Mge5UTKUH720HMkfA5Dc9muYS1fmXnI+zRmb4SQ9Ry4ehQTwTZKx5vzC9TFzBV
         Im8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vcD8/FOtoP5eQys89kvVHNIWCugf7ZxM3D7c6/oPr4=;
        fh=5tK/yNzn968UTTQthuAg//bWDREBziTppVhezGu/7YI=;
        b=HS7niw+2rDPGk9I3TQ+v8I6En7GfdNQQMthuKYVXpWuq+V97puMjxp6wQfCxpzm0fK
         buOWedrgzWOa7GZwzn2PQGN8pdEs2hgEPlsR72KvGqWTJAKFaotn+eaf1hOLHwlv3QXy
         hz9/vUUehgaMaIVmYPcBUjlXka6HaS7k8jLC02hVj0Hkjz3ugbFUae00FdK8ahthDPXI
         hiv8sW/JcJzVa2e3GuG/Jgo0Uqh1pgB4PL6ihJ1C4NDLLEL8McjtN+oCKl60ctM738H0
         aHyGCb83Bz1vsIjTShj1aTLMWrrkuLSSU75nNWkpf2dzNjxL1KKicptZYuin4cgTJ6Of
         SRGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774236352; x=1774841152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vcD8/FOtoP5eQys89kvVHNIWCugf7ZxM3D7c6/oPr4=;
        b=n01T+QjMtYSn5IyohLYiADB2lgMKdJU94HXv+cFfvDapXlmfXgpst7jm4NXEq/N598
         lCcoRRHbdQ7Fe5OMv67SaRty3y0mCMHwUeGDdrR5zI7yhiFzSBfduUgGSoV6kf+vQyqX
         i9CLySfhrT8Xjj1eZOX2Ak964bVS6OL13uGrTYlk4CiMxOEaM9kMUPtZutS+ETZYAhee
         qz5s/oqsmtbB0av2eB06h8yEWMiohox6YL7WPRdLfsoW4rLBteUc1AFHRMVeIQhjbebc
         VMpYh4OU8SJOQo2J2dctI08JF6o9aF5rGmxwwvA7mapY5jA/4GndKcJu5x64/lxXdDQ0
         OO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774236352; x=1774841152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vcD8/FOtoP5eQys89kvVHNIWCugf7ZxM3D7c6/oPr4=;
        b=UgZjEPkIRNq/fCN7WUWcGVZEM4/nG9quaCSEaOmDntsaCG9haX0tKxpk7ZtalOXtzQ
         hbEDHau885lvTojm2h2SWZ4tLpS3cVxv3gDc4/bCewMlL+3fmyWQxXOOuv03Osgev2Fy
         3hAjlgfCARuzr8qZ13XhqzAaa01RsNZg0vu7Glty4EU1AdL9t+Rz4Rf/bMZ1AsCrdyFf
         klh0Iso6z1aA36r+6D/Wz7RY8YuOVddeekYQUDnXgbu8f823nQafCgxuRlRRy/TLBj9K
         B7WLju3/wXjligHsmsmOWTiA3M1DWUI6rbEpP3GFwknHN1ap1h6HcZckwpSMmVEY1vDJ
         us1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIDkRu0+7AmwyP9ZIENHLqIGT6q/2pXxlgBySKqaILWUGApMnC6kDcE86BOezsC4C7+uuRZLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqPu6UCs1ad41eYjF6ED8CjfcZVxZyTSN4Iap8mJ0FWv/kn27
	q5i0cTqVByL6++pcrIzQsEcW9y3V2SFBP07Jll0boY3TH1VLWWp30Xvg0OMRXejQmldZKZUZiNW
	ulCg2fhw2nkfmkWjCA4n6s6zmWxbhK3fbpAcOQaH4
X-Gm-Gg: ATEYQzy1vHtHwlTWOXH+khIEeqzIN+SDpJYmL02OPH2qUnzVG7xfsb+0IXNB3S8S3Ln
	RnEs3EgclHiH9t4tnnjmcaAV/6PM19ytgMFrbD6b1Qk1RrUica/JvPUShx0iZRT4dAhZ8U4Ltnq
	CRv7FuQWF13IAvQBVnr1JiMPUdm4LvxLHCxyX5FP1xdMdH03CQ8gRQL3JHTczBW4ZEWWwqqRKSq
	SN2s1uu9KYIyw/HXpJd4EAjJgYqJQ4DPmUSEO0zyirAqN5j3avGp147gyDq+WylLCbLUp7xkF3b
	iWQWZQzj6GoFE5dqXvSTd7Zw9e7WF2goKgFixAdjfA==
X-Received: by 2002:a05:622a:d15:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-50b46cb1f1amr1212461cf.8.1774236352226; Sun, 22 Mar 2026
 20:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323024006.1764018-1-johnny_haocn@sina.com>
In-Reply-To: <20260323024006.1764018-1-johnny_haocn@sina.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sun, 22 Mar 2026 20:25:41 -0700
X-Gm-Features: AQROBzBE0tltICFbEdhtxRlByi30YiSRbwEc9vpH7iAjDsuMi-xlsi1VEllXLf8
Message-ID: <CANP3RGf0_FyYRYrLdGTgkC+35q6MePqbLdTBBD2AmyZKUzj5pQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] net: clear the dst when changing skb protocol
To: Johnny Hao <johnny_haocn@sina.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227882-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sina.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maze@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,iogearbox.net:email]
X-Rspamd-Queue-Id: 33E2E2EC30A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 7:40=E2=80=AFPM Johnny Hao <johnny_haocn@sina.com> =
wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> [ Upstream commit ba9db6f907ac02215e30128770f85fbd7db2fcf9 ]
>
> A not-so-careful NAT46 BPF program can crash the kernel
> if it indiscriminately flips ingress packets from v4 to v6:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>     ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
>     ipv6_rcv (net/ipv6/ip6_input.c:306:8)
>     process_backlog (net/core/dev.c:6186:4)
>     napi_poll (net/core/dev.c:6906:9)
>     net_rx_action (net/core/dev.c:7028:13)
>     do_softirq (kernel/softirq.c:462:3)
>     netif_rx (net/core/dev.c:5326:3)
>     dev_loopback_xmit (net/core/dev.c:4015:2)
>     ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
>     NF_HOOK (./include/linux/netfilter.h:314:9)
>     ip_mc_output (net/ipv4/ip_output.c:400:5)
>     dst_output (./include/net/dst.h:459:9)
>     ip_local_out (net/ipv4/ip_output.c:130:9)
>     ip_send_skb (net/ipv4/ip_output.c:1496:8)
>     udp_send_skb (net/ipv4/udp.c:1040:8)
>     udp_sendmsg (net/ipv4/udp.c:1328:10)
>
> The output interface has a 4->6 program attached at ingress.
> We try to loop the multicast skb back to the sending socket.
> Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
> and changes skb->protocol to v6. We enter ip6_rcv_core which
> tries to use skb_dst(). But the dst is still an IPv4 one left
> after IPv4 mcast output.
>
> Clear the dst in all BPF helpers which change the protocol.
> Try to preserve metadata dsts, those may carry non-routing
> metadata.
>

Ugh, I was under the impression this already went into LTS...

> Cc: stable@vger.kernel.org
> Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_=
adjust_room()")
> Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
> Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Link: https://patch.msgid.link/20250610001245.1981782-1-kuba@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ The context change is due to the commit d219df60a70e
> ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_adjust_room()")
> in v6.3 which is irrelevant to the logic of this patch. ]
> Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
> ---
>  net/core/filter.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index c177e40e7077..5360fef468b7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3232,6 +3232,13 @@ static const struct bpf_func_proto bpf_skb_vlan_po=
p_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>  };
>
> +static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
> +{
> +       skb->protocol =3D htons(proto);
> +       if (skb_valid_dst(skb))
> +               skb_dst_drop(skb);
> +}
> +
>  static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>  {
>         /* Caller already did skb_cow() with len as headroom,
> @@ -3328,7 +3335,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb=
)
>                 }
>         }
>
> -       skb->protocol =3D htons(ETH_P_IPV6);
> +       bpf_skb_change_protocol(skb, ETH_P_IPV6);
>         skb_clear_hash(skb);
>
>         return 0;
> @@ -3358,7 +3365,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb=
)
>                 }
>         }
>
> -       skb->protocol =3D htons(ETH_P_IP);
> +       bpf_skb_change_protocol(skb, ETH_P_IP);
>         skb_clear_hash(skb);
>
>         return 0;
> @@ -3545,10 +3552,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, =
u32 off, u32 len_diff,
>                 /* Match skb->protocol to new outer l3 protocol */
>                 if (skb->protocol =3D=3D htons(ETH_P_IP) &&
>                     flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
> -                       skb->protocol =3D htons(ETH_P_IPV6);
> +                       bpf_skb_change_protocol(skb, ETH_P_IPV6);
>                 else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>                          flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
> -                       skb->protocol =3D htons(ETH_P_IP);
> +                       bpf_skb_change_protocol(skb, ETH_P_IP);
>         }
>
>         if (skb_is_gso(skb)) {
> --
> 2.34.1
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

