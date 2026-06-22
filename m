Return-Path: <stable+bounces-267669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vU5xGPcUOWoNmgcAu9opvQ
	(envelope-from <stable+bounces-267669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:56:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1036AEE6F
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:56:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=EbHhjJh7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267669-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267669-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 690A2300B59E
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF51379EE6;
	Mon, 22 Jun 2026 10:56:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8781360EE2;
	Mon, 22 Jun 2026 10:56:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125810; cv=none; b=BofiW7WRcirgdFMcIP3jzTd8c4XdL3B81O2NjgWTgcRNV/JmgB/rxw4zqh9Yq4GcuiGK857NQwwlbFtByiAhthY1LK+eTWliX9vS47wN346GpYPXZuIfa4e/OqqYl/vTo0lLHrZ8KKozxHP0gJ5jcobqfZSRCvjFEG+MrViUBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125810; c=relaxed/simple;
	bh=G2d/F5lIuNZ88vz6q3ApypSyb+YyqYB+oCPq20Q2bZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r5OJB1NJ2S56cdhMcW/WdeeQuWQlSmTrh13eGcBkxEjC1mrofHxA3iYaywNfx/2tN8rY2ptCGUtvit8nwOSFAirC+p9cAELYpIamMlWun10j2klikz9I3gTVCzk9AZ0TDdU8kVWeZCA0J7Vg/oy5Nyr74IofMJudPdGHINveX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EbHhjJh7; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65MAkLirD2483908, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782125182; bh=URHnGG65LYP3ZVacahzioKWmvwkb6Ar9SydTOAJZofE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EbHhjJh7LrXezxTInXnZuoN5P/0GabfBUFbr+oxpxRiDgLe9FBM9OtVSslDGw8F/b
	 B0bmgJqwo2pBOjuFD7pWM9LK8uemiJYY8/lj3pnLDsij4TErlTIlaSPf8R6GVp2pBO
	 k1xBRJZPQo49ZBI97/opt6vngHleY0OM0w9VLJe1bmQ5axqkFSYqiL3gjnILT35eGP
	 VBvTdTNDtBKzdr9acA4gBj7158YiX1hTLDBoWqqj9LQuZY3Wv6JUkpNY8LK0kwdfOb
	 YgYg7jvrHh0xLAkLDEYtmRqSF5F8YqgmA3nGPDhLJeFr7Ye5iig4Li/d26nrGUEYGX
	 3rDAJISBL0K0g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65MAkLirD2483908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jun 2026 18:46:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Jun 2026 18:46:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Jun 2026 18:46:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Mon, 22 Jun 2026 18:46:22 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v3] rtase: Workaround for TX hang caused by short UDP
 packets entering hardware PTP parsing
Thread-Topic: [PATCH net v3] rtase: Workaround for TX hang caused by short UDP
 packets entering hardware PTP parsing
Thread-Index: AQHc/Mk9ctTr65FPK0GOwiW0nIIMYrZB7hOAgAh/KbA=
Date: Mon, 22 Jun 2026 10:46:22 +0000
Message-ID: <0a295c5c3cc64a92964f4f32848334e1@realtek.com>
References: <20260615131653.15730-1-justinlai0215@realtek.com>
 <20260617085416.841731-2-horms@kernel.org>
In-Reply-To: <20260617085416.841731-2-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267669-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:richardcochran@gmail.com,m:david.laight.linux@gmail.com,m:aleksander.lobakin@intel.com,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[justinlai0215@realtek.com,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org,gmail.com,intel.com,realtek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC1036AEE6F

Simon Horman <horms@kernel.org> wrote:
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> rtase: Workaround for TX hang caused by short UDP packets entering
> hardware PTP parsing
>=20
> This patch adds a workaround for a hardware TX hang that occurs when
> short UDP packets matching destination ports 319/320 enter a PTP parsing
> path that reads beyond the packet end. The workaround pads affected
> packets so the transport data reaches RTASE_MIN_PAD_LEN before
> transmission.
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 55105d34bc79..4c295a39c7a0 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
>=20
> [ ... ]
>=20
> > +static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
> > +{
> > +     int no =3D skb_network_offset(skb);
> > +     struct ipv6hdr *i6h, _i6h;
> > +     struct iphdr *ih, _ih;
> > +
> > +     switch (vlan_get_protocol(skb)) {
> > +     case htons(ETH_P_IP):
> > +             ih =3D skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> > +             if (!ih)
> > +                     return false;
> > +
> > +             if (ih->ihl < 5)
> > +                     return false;
> > +
> > +             if (ih->protocol !=3D IPPROTO_UDP)
> > +                     return false;
> > +
> > +             *udp_offset =3D no + ih->ihl * 4;
>=20
> [Low]
> Should ih->ihl also be checked against the actual data present in the
> skb? With ihl up to 15 (60 bytes), if the skb only contains the basic
> 20-byte IP header, the computed udp_offset can exceed skb->len.
>=20
> Downstream in rtase_skb_pad():
>=20
>         trans_data_len =3D skb->len - udp_offset;
>=20
> trans_data_len is u32, so when udp_offset > skb->len this underflows to
> a very large value, which trivially satisfies:
>=20
>         trans_data_len >=3D RTASE_MIN_PAD_LEN
>=20
> and rtase_skb_pad() silently skips the padding. A malformed packet from
> an AF_PACKET sender with CAP_NET_RAW could craft a mismatched ihl and
> bypass the workaround. Would clamping or validating udp_offset against
> skb->len before the subtraction be appropriate?
>=20
Thanks for pointing this out.
=20
I'll add a check for udp_offset > skb->len before calculating
trans_data_len to avoid the potential underflow.
=20
If the computed UDP offset is beyond the packet length, the packet is
malformed and cannot be safely handled by this workaround, so it should
not be transmitted.

> > +
> > +             return true;
> > +     case htons(ETH_P_IPV6):
> > +             i6h =3D skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
> > +             if (!i6h)
> > +                     return false;
> > +
> > +             if (i6h->nexthdr !=3D IPPROTO_UDP)
> > +                     return false;
> > +
> > +             *udp_offset =3D no + sizeof(*i6h);
> > +
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static bool rtase_skb_pad(struct sk_buff *skb)
> > +{
> > +     __be16 *dest, _dest;
> > +     u32 trans_data_len;
> > +     u32 udp_offset;
> > +     u16 dest_port;
> > +     u32 pad_len;
> > +
> > +     if (!rtase_get_udp_offset(skb, &udp_offset))
> > +             return true;
> > +
> > +     trans_data_len =3D skb->len - udp_offset;
> > +     if (trans_data_len < offsetof(struct udphdr, len) ||
> > +         trans_data_len >=3D RTASE_MIN_PAD_LEN)
> > +             return true;
>=20
> [Low]
> When trans_data_len is less than offsetof(struct udphdr, len) (i.e., the
> transport region is under 4 bytes), this returns true and skips the
> padding entirely.
>=20
> The commit message states the hardware "may access data beyond the end
> of the packet" during PTP parsing. If the hardware also reads out of
> bounds while classifying the packet, an IPv4 last fragment with 1-3
> trailing bytes could still be misclassified as PTP based on whatever
> garbage memory the hardware happens to read, and the workaround would
> be bypassed.
>=20
> The implicit assumption here seems to be "if the driver cannot read the
> dest port from the skb, the hardware cannot classify it either", which
> appears to contradict the premise that the hardware reads beyond the
> packet boundary. Should these very short transport-data cases also be
> padded to be safe?
>=20


Thanks for the review.

The out-of-bounds access occurs after the packet has already matched
the PTP classification criteria (UDP destination port 319/320) and
enters the hardware PTP parsing path.

If the transport data is shorter than the destination port field
itself, the packet cannot match the affected PTP classification path.

Thanks,
Justin

> > +
> > +     dest =3D skb_header_pointer(skb,
> > +                               udp_offset + offsetof(struct udphdr,
> dest),
> > +                               sizeof(_dest), &_dest);
>=20
> [ ... ]

