Return-Path: <stable+bounces-240338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FOgFgDg6GnURAIAu9opvQ
	(envelope-from <stable+bounces-240338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:49:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A38464477D1
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5587E30CA65F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E43ED5CD;
	Wed, 22 Apr 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gszs6oBd"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F03EDAD6
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869092; cv=pass; b=AwEExNpz5V2lpa/xwXcUafISaRnZoItXiuqpeeTA+NWVjeu/VGTAfkSiedgUfRxccj/Q0K9IVFsz1rVbs5aHOhUkV5UgnQ8CxB/RSDiQh25loqqmKE5mPXsfCklbcMqA9zJ1yvU0O4bQAdYr3AMPhP+S+Pk67YiujAsxWCY2M9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869092; c=relaxed/simple;
	bh=v32TmCmNq/RD+F6k7dV0huH6idthcU99m+aMPZoi1hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKAPw3hMCoIsOLDs/ybOgiT5ejrYWnsYtovneRJMsALWgrxW0iVX2IfhTAIoO3UIknyx8UJ8TAj0NVgt7EhWjM/F8q0BU2aRGVY938rFPzBVUT8DJpOd3Hwvq3mHrzho0a/GHGlsgKmc9PmkUCFShfPVsJlyOa25yfcWC/7ZNR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gszs6oBd; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-688a8e5fe5eso2603728eaf.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869086; cv=none;
        d=google.com; s=arc-20240605;
        b=EqFI7LEXHbaMg9bVjxJvx4/dGpVVusbOTHnMZVLRupRx+8On0MDf0YV1LNV1ekj0v1
         KmmQYvy17dvSPGOgLIYJkHAX+cT88tFpXVWiA4TnzFEFg8uo+ua2MJuNVNnajeIJS2Av
         FzARetrFWEz6LRZXVNtgK5taur326SHpdPm0CKnpCRlctqnP/jpcCS9714Ma17JD7QNc
         3XSL7bZZn8N+W5TzdZI64lxLI5ovMLcAKJ0I6SsBH382gbyVDkMrRzKiQEwZTD38Cn1d
         /70HgScNsEPD1v3rGPrYho3R73+dxTVB9bIwrikEXQtVu4jb/56wODseqg7L6uSwbm9c
         jm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gz6UAYat0RkKM4CbANaYAtGchON7PySza/VCdUZ5Dq0=;
        fh=auNg/sS/aQA2EKl3W0eyyzQUXNikB/uovv0cCm10+Zg=;
        b=aWtphWnrIWI/rZQ6WmdZm8kKikSWYy9uj5LuV5sVx0eSAS3vv4J7ZeI9UoGOb1UXUD
         7KsW4flnQYCQZnRO7A4+dqDLKDmAZtcAtLpe0eVRVxZ9+oQv6gm36/MnjpBLspRalE/b
         orLGqJcILmZ2b17kSaQbjM5Aw937F+gyMr1dmGwd4lO9f+cLLM9gUkn3bkNem2iEnkBZ
         I/6sTDuw3Omx2T7fhVyvhTi2Wi8jaSkiPdfi6cDcBKSeHmOIaJIomcT+8yEuA4Phziy3
         5R3VFMpvMYbenmiR+w8Urx4vdSsLyjSZ61skL1O/BpZESbPZRlXMnffWvpuzZfDA4hxE
         QrbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869086; x=1777473886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz6UAYat0RkKM4CbANaYAtGchON7PySza/VCdUZ5Dq0=;
        b=Gszs6oBdsdEDGRzRtwVGyl5CnB1kxrTxXrx6++WTfn7NOv/dckCHaTcJ+unt11wKTH
         wsHP+YFfATdFoWnOoGLZPnAavZPqtGhS/AzP0LlEQjtzVRPaa8/wFHgre0asUmabOEg5
         TvRuHcWhi23n0bWcyoLIEMc2we2z1YSuWAw78/ObmaSJPHpqsYWVC2cxHEcc0WJUHRKH
         eYKZ4TuVpAtH2iybcAaHC2ZpaogM6Dpdr6RDhwyt2H2ygGVTmf4W0ilpVwl48U8TD62J
         AfyYdN1tGo8v9PrsD9jmVTRDuDjQdTL36yYgRdYU0ulnvOWbABBtmb1vUt4AURd6QeTM
         IJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869086; x=1777473886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gz6UAYat0RkKM4CbANaYAtGchON7PySza/VCdUZ5Dq0=;
        b=R4VwSg6DpOT7ZRx7/EhfewsqiAxu1GLnaTN6WU3okY7kBRS7DW1azxJ5bDdLx5ElCm
         46/ef8xSnwA8o3/n6ajwsAsv6j65KnAupatfHDWiIi4sTcATwFM0LE6kxHJxBX3JrLoB
         DRnJT2MQL6BPYXChABP3ycaKh2onDE0BzkDB+YSx43VwWUWG7x28sHSmxA4a5ZfSDVD2
         AIiuiqfNQl7cNPF5Nx4wJUche1+upISDHnf5F7IuCzVAFgq0PQBNKKnGBPCYkPDxh7cu
         mc6LJE+rEsft9cyrv61rz1zdErim3qCCmWTmtd1QAtq905wm6BL/4Q/2U9HOmb94K8Fw
         25kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wa60MsWSMxCCSBGa/oVt70t62KAb2bdwQKdO9h0BEwm3byZZ7v6zkIqXzGU7g4EALAnlwwxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwizEbPdsfQ0xnIBZ6bvoABsfbNJ1Dz4waTNIUAOYZtn4gJVaJr
	1U21Ru0cTU1RIb3c7r2Mw5jUkU+pLwwX1RDAANaqaaiXjU8Rl4TslfiZyoOTOGpCQmjx6i35YP0
	Lte+Qs0nk03AGdQKUFBMA9KCsEndRNrQ=
X-Gm-Gg: AeBDiev+kqp/YTKdrafRJGC227YZFHPlkDkFhoLLfpbwNrGQOZJGvt1EExi+VDl+2uf
	UnytnTo1sVQAmxDwp2PDBdmnnjT0lo0KzRHJLZ9GzkgGaWHhy/3vvXRir9jDUmkoH0AUQXUAFit
	43Q1RgPTgpea2Ln58XNLLQSJfcdM5MitaWTq0H0q7safUxb0s+WdnW5YglpDiNpHF2TQ/qaSUER
	Lps/sMqIDUCltH1y6fMqGpjpBbSXDnzIxxtT1Ch7lLxMM7Aw0AstC5iAlBLa5VGfMkxOmnqLLo2
	UFImJVT6AB05T4HrldAwAWl0z9nvM0SstMNeuG7kI7JqF4unL8i1pGqFp4x5nXb0zwDr/jPOnvO
	Qsw==
X-Received: by 2002:a05:6820:220d:b0:689:7ad4:cba2 with SMTP id
 006d021491bc7-69462ed34c4mr12412601eaf.35.1776869086092; Wed, 22 Apr 2026
 07:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com> <20260421135639.3185653-2-michael.bommarito@gmail.com>
In-Reply-To: <20260421135639.3185653-2-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 10:44:34 -0400
X-Gm-Features: AQROBzBk-rigpQSaLKFocLT0t5YdnBlXkxlJCl3AdoKv2wzeySP57ww4q73Vi_c
Message-ID: <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240338-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A38464477D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Tue, Apr 21, 2026 at 9:56=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> Peer-supplied ERTM RFC txwin_size =3D 0 can still propagate into the
> ERTM transmit-window state, and the same invalid value can be
> introduced locally through L2CAP_OPTIONS. In the request path that zero
> reaches l2cap_seq_list_init(..., 0); in the response path it can shrink
> ack_win to 0 and leave ERTM sequencing in a nonsensical state.
>
> Normalize zero tx window values back to L2CAP_DEFAULT_TX_WINDOW
> wherever they enter the ERTM state machine: local socket options,
> outgoing tx_win setup, incoming config requests, and config-response
> parsing. Also make l2cap_seq_list_free() clear its metadata after kfree
> so an init failure after freeing srej_list cannot be freed a second time
> during later channel teardown.
>
> Fixes: 3c588192b5e5 ("Bluetooth: Add the l2cap_seq_list structure for tra=
cking frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> Changes in v2:
> - drop the v1 `l2cap_seq_list_init(size =3D=3D 0) -> -EINVAL` approach
>   and instead normalize zero tx window values at the socket /
>   request / response inputs
> - clamp the local `L2CAP_OPTIONS` txwin_size =3D 0 case back to
>   `L2CAP_DEFAULT_TX_WINDOW`
> - make `l2cap_seq_list_free()` clear its metadata after `kfree()` so
>   later teardown cannot trip over a previously freed list
> - split the repeated `CONFIG_RSP` ERTM re-init fix into patch 2
>
>  net/bluetooth/l2cap_core.c | 23 +++++++++++++++++++----
>  net/bluetooth/l2cap_sock.c |  3 +++
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..7ffafd117817 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -345,6 +345,10 @@ static int l2cap_seq_list_init(struct l2cap_seq_list=
 *seq_list, u16 size)
>  static inline void l2cap_seq_list_free(struct l2cap_seq_list *seq_list)
>  {
>         kfree(seq_list->list);
> +       seq_list->list =3D NULL;
> +       seq_list->mask =3D 0;
> +       seq_list->head =3D L2CAP_SEQ_LIST_CLEAR;
> +       seq_list->tail =3D L2CAP_SEQ_LIST_CLEAR;
>  }
>
>  static inline bool l2cap_seq_list_contains(struct l2cap_seq_list *seq_li=
st,
> @@ -3234,8 +3238,15 @@ static void __l2cap_set_ertm_timeouts(struct l2cap=
_chan *chan,
>         rfc->monitor_timeout =3D cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
>  }
>
> +static inline u16 l2cap_txwin_default(u16 txwin)
> +{
> +       return txwin ? txwin : L2CAP_DEFAULT_TX_WINDOW;
> +}
> +
>  static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
>  {
> +       chan->tx_win =3D l2cap_txwin_default(chan->tx_win);
> +
>         if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
>             __l2cap_ews_supported(chan->conn)) {
>                 /* use extended control field */
> @@ -3593,6 +3604,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>                         break;
>
>                 case L2CAP_MODE_ERTM:
> +                       rfc.txwin_size =3D l2cap_txwin_default(rfc.txwin_=
size);
> +
>                         if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
>                                 chan->remote_tx_win =3D rfc.txwin_size;
>                         else
> @@ -3715,7 +3728,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *=
chan, void *rsp, int len,
>                 case L2CAP_CONF_EWS:
>                         if (olen !=3D 2)
>                                 break;
> -                       chan->ack_win =3D min_t(u16, val, chan->ack_win);
> +                       chan->ack_win =3D min_t(u16, l2cap_txwin_default(=
val),
> +                                             chan->ack_win);
>                         l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
>                                            chan->tx_win, endptr - ptr);
>                         break;
> @@ -3756,7 +3770,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *=
chan, void *rsp, int len,
>                         chan->mps    =3D le16_to_cpu(rfc.max_pdu_size);
>                         if (!test_bit(FLAG_EXT_CTRL, &chan->flags))
>                                 chan->ack_win =3D min_t(u16, chan->ack_wi=
n,
> -                                                     rfc.txwin_size);
> +                                                     l2cap_txwin_default=
(rfc.txwin_size));
>
>                         if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
>                                 chan->local_msdu =3D le16_to_cpu(efs.msdu=
);
> @@ -3970,10 +3984,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan =
*chan, void *rsp, int len)
>                 chan->monitor_timeout =3D le16_to_cpu(rfc.monitor_timeout=
);
>                 chan->mps =3D le16_to_cpu(rfc.max_pdu_size);
>                 if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -                       chan->ack_win =3D min_t(u16, chan->ack_win, txwin=
_ext);
> +                       chan->ack_win =3D min_t(u16, chan->ack_win,
> +                                             l2cap_txwin_default(txwin_e=
xt));
>                 else
>                         chan->ack_win =3D min_t(u16, chan->ack_win,
> -                                             rfc.txwin_size);
> +                                             l2cap_txwin_default(rfc.txw=
in_size));
>                 break;
>         case L2CAP_MODE_STREAMING:
>                 chan->mps    =3D le16_to_cpu(rfc.max_pdu_size);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 71e8c1b45bce..3b53e967bf40 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -765,6 +765,9 @@ static int l2cap_sock_setsockopt_old(struct socket *s=
ock, int optname,
>                         break;
>                 }
>
> +               if (!opts.txwin_size)
> +                       opts.txwin_size =3D L2CAP_DEFAULT_TX_WINDOW;
> +
>                 if (!l2cap_valid_mtu(chan, opts.imtu)) {
>                         err =3D -EINVAL;
>                         break;
> --
> 2.53.0

This seems to be going sideways:

https://sashiko.dev/#/patchset/CABBYNZ%2Bf3pur4cSsanQ1kvv-yORp2E0qmVLt9si_%=
2BFnnJup4Ng%40mail.gmail.com

Patch 2/2 seems totally broken.

--=20
Luiz Augusto von Dentz

