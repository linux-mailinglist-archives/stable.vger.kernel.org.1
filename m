Return-Path: <stable+bounces-241792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGv5Cc1P8WmGfwEAu9opvQ
	(envelope-from <stable+bounces-241792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:24:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76E48DBDC
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 058253026753
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A61A683A;
	Wed, 29 Apr 2026 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m95jD2En"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A319CCF7
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422259; cv=pass; b=YFAWxExXuE/m//eCJWrfXV9+iKU91kcNQVTT4+7GjRDvoYOyyuBtvFw/v7CP/FPavURTO3f87EeGfFw8nnO9i0BI2rExLUQRHNHovNXmr6Ixm4MKhF1iokrdZn+vNJH48ZDtu/wclj3cj/3OYp3WxGHe8xlkbHHxXeLe/ZrkC2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422259; c=relaxed/simple;
	bh=UJXPcwA89OjMeIoeEEHrLC4GWyoAx5SCk8QvmlDPxwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8Pl/NoAG703xTWvRfArKHU0n2fp+GYezyYIUfgmoiCifd6eRYM1VfSkgGKoCJFcm8BDicfKks8rxghfXccpEzLZ+SPK5Mohrc2cCETMaTvB9pYyrqxLZSdttBky1gZOwoRKSkRmfNfi7LXabMlP63VHdAYywTowuuLt4DtC+ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m95jD2En; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506362ac5f7so98521541cf.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 17:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777422257; cv=none;
        d=google.com; s=arc-20240605;
        b=Sx7H9cqa0bM3sHkNrh+SewnivR9DTRr7AaSMThiFvlHC21LIClISjv7oUZaqkL0eWm
         1wrsxbzPm9j3J1fG5+8bnEhw442qtHl2Y12d6ObTQyijGeiv/LGXfPxzMCgp6F+6LYGa
         TWRkieqeAJOZT+b4CaNbwkmmxDczxqeXcLl2sGYnbiZyejSTLHifYXSGZ/490Pf6Mvs7
         uTS7X79phidXerwaz7z8IWTFj4yviuAxUyB3a/sZMBsBxJJZXK+Ev9o3A5Y7FnQASg4f
         WQfgM6yLouv5YO6xRwSFGRWUjjfLwPRP2fiQdx5Ffh5ahtfs6DLLO+zEHQMZmhAoFBFM
         busQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5EekIEEAn9zcWSyRffp42SDp9Ty9BQf71SkpBOEt/1k=;
        fh=k1ju8cyMfqGeLxMXuE851BZeNNX8FV6ksm7YcC7vGWY=;
        b=ftpwqDIzYbZ+V3eO71SxUeRvDeU1cLGCDIKjg2OXcJ3wcGNeDeDjt+YE+daEbDBpmD
         OPo9lmjBFr5ifLalO3GzjszROT/8ThT5mMWn2APs2PsOk+Yf3xLkZ7RAOUMVtgNPB8V1
         q5FXuvRs//s2OnAx86c3kfoI34ZnI0ErStylG1EWbTAtjPkd4dDqRWGt80QzbJMSEX8O
         3cE2ZR5JyZX6qgTFgnv8LRMQduW3DsOFOodwyzHOH+ka28afVhGBL2zrBL9LW+wTYdg+
         75pXI7wqa7NZrjRqYTVkRnOUEVUl1HuRoWghfjpDI0Al8WGIvXndv5ufKWOyNrhnnEYn
         FhcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777422257; x=1778027057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EekIEEAn9zcWSyRffp42SDp9Ty9BQf71SkpBOEt/1k=;
        b=m95jD2EnKtKcSXmhejLDIhMzOrmHv6giH1hUWQT84l5ILnJ+8pEI0I/0rkjESwx6Fm
         5aJwcVXbPBs6GybIKBp/Py12uF3y9zl61KqiZhi5eokNb1Alg9y7kOXfjfTLxbC4tzkt
         QtXbUEc31G6bKjJwaN/As1HP8F6I7nWN+DdiNHB69dG2awdDFmRARzpAGzMeLCuM6S2k
         5ffwgtKNsDLZS4K2SSCz65nQIvwTrVR/76xAPVd8OEzzCqVz5l3vFRTjwmLNhgih9lrM
         s9GmaqRP3ktkb63Y4raqsh9HC8DI6KvcOgPeM7NKENB52Zij8CHi3UZio1NI+FUsGS4L
         8m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777422257; x=1778027057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5EekIEEAn9zcWSyRffp42SDp9Ty9BQf71SkpBOEt/1k=;
        b=OabpTzqrVQmrFo/LL2G7ki5JXh997/tCXgEAyyfkXpU0pemOsdRGbBLwSanYw7xQHj
         YL37Aj7FHPkM9pQngVWkymBWNtKCw3IJxaitTvgR7GsLRtg/4pmK3QvyxhFcZtHYFQiH
         sgKvrJAaVduTTQ3x/sXd7JyJw8iUQMBP7FA37DH7IIwJGU5EgE2R+Q2wiG52G1HtqPvQ
         TCuvDOY+mGbNq815IyF6g3EKTPOmcgvoynDk2vQAgaPOi+P+PJn202ByU+tlyuuI7KhC
         QY+WeDtSHMDRwhNAvhw3ZCkO9qlXEqg+e/64VwF3jSsgCcYQ1jBX9HhnBj4GBQmFzGOa
         Hp/w==
X-Forwarded-Encrypted: i=1; AFNElJ8sNse9MAavbq1gNy+8cXfNasj+H21B7lmvo14AVjZovWb4cYbC1UxUCFH7AmcBppEEBVXHEAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6fIFS6WducFf41odXx8vkbanRkgygcKMuCKqMbI57QwF1lScz
	eUYgSIXhal8pKOZm4W6lSem0NrS+V/ASs87Cg9DXbNi8LRl7inZ6WFMPoZ5tCb20C9fTE7Xc2s1
	ltYRFaU3EeZMlX3IzrjUWok0gjEc0VVep7KkXcDf8
X-Gm-Gg: AeBDievHF36KoJjczVJYFWadGGvu8AceTG1knKEru6b4tB9wBsmWX/Jzq4rJ/znLvkG
	qOLmpX5iLuyjzoIRucqu4t6wQ+N1COIe7Ekmg4GYtAA0dk9jP0YnSAlR1VFlMsx4ZC+qxkwV+p/
	BUwlTLmZtyUUvl1aelsszeGhF9XxPDeZbX2D7IS/WS1aL4jcLwmP/gWB3XfFzUc76hrkdwFqfxn
	CJL9LnNdcdQu9JOCKemFZg9tQYTfX0MgluxqCnd0AyBOe7XtOcDA8MtNlmZXwE5bKuQwEQjOs6c
	XqgiowsZsVJWfDP/UcPhN9X1nNOtVSL7MoVa/5zlEISp9jafZU66GReDljmEPpWBTHBXuiSMAeR
	h/nuN2oWd5XqBzoA88Rsw
X-Received: by 2002:ac8:5d90:0:b0:50d:7384:a660 with SMTP id
 d75a77b69052e-5100e0f4cb1mr71639201cf.6.1777422256877; Tue, 28 Apr 2026
 17:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428224816.11223-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260428224816.11223-1-andrea.mayer@uniroma2.it>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 17:24:05 -0700
X-Gm-Features: AVHnY4Lxx2_566jaJobQy5M9DdHNmCDtFn90_njALOpDxBSMh5sD-BAbouWm3xg
Message-ID: <CANn89i+dSEkqgbvsonrC5V=e-vnMPVNdVnD+0KdkkAxM_kxEQw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Justin Iurman <justin.iurman@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7E76E48DBDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241792-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org,uniroma2.it];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 3:48=E2=80=AFPM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
>
> ipv6_rpl_srh_rcv() dereferences idev from __in6_dev_get() without
> a NULL check when reading idev->cnf.rpl_seg_enabled.
> When the device's MTU drops below IPV6_MIN_MTU, addrconf_ifdown()
> clears dev->ip6_ptr through RCU_INIT_POINTER(), which is immediately
> visible to concurrent readers. A packet that already passed the idev
> check in ip6_rcv_core() can race with this and hit a NULL pointer
> dereference.
>
> Reproduced by flooding traffic through a route with RPL source routing
> while rapidly flapping the receiving interface's MTU between 1500 and
> 1200:
>
>  BUG: KASAN: null-ptr-deref in ipv6_rpl_srh_rcv+0xae/0x1050
>  Read of size 4 at addr 00000000000006b4 by task ping6/318
>
>  CPU: 0 UID: 0 PID: 318 Comm: ping6 Not tainted 7.1.0-rc1-micro-vm-dev-g4=
6f74a3f7d57 #82 PREEMPT(full)
>  Call Trace:
>   <IRQ>
>   kasan_report+0xc6/0x100
>   ipv6_rpl_srh_rcv+0xae/0x1050
>   ip6_protocol_deliver_rcu+0x717/0x960
>   ip6_input_finish+0xa3/0x1b0
>   ip6_input+0xdc/0x490
>   ipv6_rcv+0x338/0x460
>   __netif_receive_skb_one_core+0xd1/0x130
>   process_backlog+0x2c7/0x9f0
>   __napi_poll.constprop.0+0x51/0x270
>   net_rx_action+0x322/0x730
>   handle_softirqs+0x119/0x640
>   do_softirq+0xae/0xe0
>   </IRQ>
>
> Add a NULL check for idev after __in6_dev_get() and drop the skb if
> idev is NULL, consistent with the SRv6 fix in commit 064137935262
> ("ipv6: add NULL checks for idev in SRv6 paths").
>
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/exthdrs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 03cbce842c1a..e398a8851031 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -499,6 +499,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>         u32 r;
>
>         idev =3D __in6_dev_get(skb->dev);
> +       if (!idev) {
> +               kfree_skb(skb);

I suggest:

kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED)

