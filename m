Return-Path: <stable+bounces-254496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SChUNviaFmq1ngcAu9opvQ
	(envelope-from <stable+bounces-254496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:19:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547B5E05A0
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7433020A56
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939103BB9F5;
	Wed, 27 May 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHk83MI4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D43BB67B
	for <stable@vger.kernel.org>; Wed, 27 May 2026 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866241; cv=pass; b=LZjWqNIDrroNM6PKkcD7O6/pNNEke2SfdzWLZonLvsJLcauMn0j6lSgXRCiTcWjIoERLXQLn1WzYatPTU78K5Yyura/mLT+4nWkmQd9zR6cfA32jQ7eSxLCKLKGuC9IzZAzWIA+Xy5w2bm97QiYiylsbpeQBV1Wbxq3l5i2RXtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866241; c=relaxed/simple;
	bh=h6/4cyU0+iEDqAXcOFF9v4MSTX9KGlsR1mXaiuZLTiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R36Vcd/Pkk6M4IbxCKi0T58dV485zA+TuF7j+iIRkUXn35v+FOM9+qTxeeDSWQ6mFY5HGIQNDUYmyzfYFp2jGHn6XeCCJTnckW5YoNbS3hzKTVQ4JOMvnbXsMGEQQsuay6b5OX6Rjk8zgdM54WyBfweShNb1cOrWzKDfMmrM4Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHk83MI4; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1370417c01cso3062267c88.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 00:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779866239; cv=none;
        d=google.com; s=arc-20240605;
        b=Wpj6Dc7aXk0oIz2+XCCadfnS2+PyucXEWA5X/c7vayIbJkO2X3ROdfa58b7SKzxaIn
         QirafrN2yqUEsysgA6UQJ4mSCvteo9RAaRNvbWUIbMIDxbRaRkGGZxixb9daltRRrfMd
         mNDHjZl/KiAWU+a01y2paVjxD/oNO2hse8gTDaIAppMDLQumKvTmPG36/IDy3QmxJyDz
         nhDDUCgOOlkT1gUj8l0Jq53ninOdNaTKQ6Bz9iRlvwopNR3f9+J8DsLr0ie9oRXHm+0u
         Ynmbqn7xPbh2bmjzt93GYXU/qXEZNXEujc8vXA86O2gehtOTxgQ/cBieaD7J3UAMlSTs
         NOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AFZzotywTi2mLXKZHjn3ab/EXo/jwO28HmrTN0/MGIE=;
        fh=n8pbv4ibdR5dRq31NYPTwgJjvr1sm4ECuII9/MYPmIg=;
        b=OWiztfPf+M+jzE9IsSALzN1mw0eKifGEkAkuPG5Jrk0MRzVvx8IHYKi6VaDy+EIUhl
         DNzJxm6xlmDp3DT4dVwY8TlIfp0VKt73vHNzMK5HVaFF6FothBsKCu5pIYHcpz+Ua3OI
         1PZx51vJyGEDiKIG/mvqpavpNR4wV4Teo4KHrx5oenOQ1jqv2/dok+JmvahcUvslnAlN
         7d+gB846bMND0bW4SrMvbR6kEuZw7ZlMgN/ddreLCvqubWbgvMAR1caOmavKZc97CX4W
         YzLvfexhR9b8hIncCeQQ9p/cddWQlN7apKxgNUQflickYoq3d1dK1dx8zuF9DauOHbmt
         Gpzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779866239; x=1780471039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFZzotywTi2mLXKZHjn3ab/EXo/jwO28HmrTN0/MGIE=;
        b=vHk83MI4HeDV1QJX3gfLMHlZr4F6jKwyt/IQHD+d/nlhNPCcjs2jUbr2C91t4XzDPt
         aObXUoiUDNpCnBjOhRudD8OHTcNnPc1x8q/4BKga+4XhnSNpfoYGOqhtXYBqqUAWBD4i
         2aEegaDON994LwRhXDB+vF6Yyosyczu4P66Kkw0o0XF50YwXr8IKUpkmvhgR/EhcXDA4
         YgyzCpyyGB4dccJcoOdzbbUTwLCwVPaV3dfEOCpG0boJuweXsIs3wPr2MfHsKIB2JkE+
         3ctpIPlIwiNhQFebed7GKXVNTXa+mdF5xcK8SYhfgddwrqvoBUucY6p5bQziGky2qxqn
         6B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866239; x=1780471039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFZzotywTi2mLXKZHjn3ab/EXo/jwO28HmrTN0/MGIE=;
        b=OtXEkxcXgKvKPwz9E98k1J57e69hPAwmvTAqGUIVvtzoh+AiPEeCIADnPUzNx6s8JV
         WdkmWxGtM9F6aArif+vY5jz8foJuUazxKB4d4cL6Lh04m31Og1pd35xbldDahrtnzy+v
         gXoZ2fsA26Nbyv/bFLkzvk2AbFWWmTz/YwlJoriipFzVoYkxeBZ3Ci+4B7/dEqbvc/+q
         iJ6sCcizNzxTkdO7dwsn31gIZGaIZ+byQzddj2nnXj9tdDsjSLtGYLi5SjVjkFVTLcQF
         upICvIhY4UZDhmEyaAjPM6KmD2pQXKUPExsd/rFSoRVRio6dvyQAVuOfep4fVcEz4ihD
         kFAw==
X-Forwarded-Encrypted: i=1; AFNElJ9USeFxBmcAYKsqSGhCiDbGIqVkGz9N1Z/+KqwUdwkVdjCWNfxJMY6izomD16CyDxo6qhXp+g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7w/dqxk4VbWSsK0oyZ11IoPmry6opNJF+4hhITBQTjAQECLl
	xsEX/hEtV6Nt5p1rjwANNbMSyl0HSMET150ZZM0HyjpFUMO58DlW2bdtpiJ/qcnXe6en27Wpyc4
	Gvb+1nII+VWMvYwkyfSytEZgjF3pO3ZIXLYsh/PaH
X-Gm-Gg: Acq92OGEErUyxTuxoHmD5hDnDbnDKGSU0EJkI8ItnvCdD676kAWZ23GIxoo5lzHsoOA
	KooocI1R0F7jwBqFKgld20mg3WsSMrzR7ZgKdHfWuCdr1kOHh3hljvCoE6T+1jKfui7SOI/qWHb
	N6/wdALYfLOrUei8dllRpusvbgXcEMGoihi3/s5SS2dWu8EBhrLeKA7MUBzYQQwtyrP3LBf89t+
	Q+YzFwPmbk+9+9mH29fvZiueUW7r4PYmNuR/2MmU3PfVxLge19umjosTuAwiUsA3u507iu4Owzn
	Sy9nWIpSU6pxtKxcj0DzESSK24T3BRgGkG5FC1NWDquQnZGkfrwc1gL/NCAf4es5WwHC292ujss
	xZkgtagFrziCIWbhlj6ZXNfjEeo2+H+j/ZHUoa33D416Nhdaw6e5tlCZF438R7w==
X-Received: by 2002:a05:701b:2915:b0:130:6904:8c17 with SMTP id
 a92af1059eb24-1365f8123fdmr4374499c88.18.1779866238318; Wed, 27 May 2026
 00:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 00:17:05 -0700
X-Gm-Features: AVHnY4LuH0mJ82X9RuVeOnxqRkbFBRS9qGgbhqeLwzp4g8sTUSsMdWiSOgMVGog
Message-ID: <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254496-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3547B5E05A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:08=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> Commit 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in
> vti6_changelink().") made vti6_changelink() and vti6_update()
> mutate the vti6 hash of the device's creation netns. The
> rtnetlink path into changelink never checks CAP_NET_ADMIN
> against that netns. The only capability check on the link netns,
> netlink_ns_capable() against link_net->user_ns, runs solely when
> the RTM_NEWLINK message carries IFLA_LINK_NETNSID. A plain
> "ip link set <name> type vti6 ..." does not carry it.
>
> So an unprivileged user holding a migrated vti6 device can
> rewrite an entry in the creation netns vti6 hash. They pick the
> endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use
> ip6_tnl.net in vti6_siocdevprivate().") already closed the
> SIOCCHGTUNNEL path. This patch closes the RTM_NEWLINK path.
>
> Other link_types are affected too. Any type that publishes
> get_link_net and whose changelink touches t->net has the same
> gap: ipip, gre, sit, ip_vti, ip6_tnl, ip6_gre, xfrm_interface.
>
> Check netlink_ns_capable(CAP_NET_ADMIN) against the device's
> link netns before dispatching to rtnl_changelink(). Types
> without get_link_net are unaffected. The newlink path has long
> checked capability in the link netns. The changelink path never
> did.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 06615bed60c1 ("net: Verify permission to link_net in newlink")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  net/core/rtnetlink.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index df042da422ef..ac7a3bf438d5 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3969,8 +3969,26 @@ static int __rtnl_newlink(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
>                 dev =3D NULL;
>         }
>
> -       if (dev)
> +       if (dev) {
> +               /* changelink may mutate the link's creation netns.
> +                * rtnl_link_get_net_capable() above only checked
> +                * tgt_net. When the creation netns differs, also
> +                * require CAP_NET_ADMIN there. Otherwise a migrated
> +                * device lets a caller with caps only in its current
> +                * netns mutate the creation netns.
> +                */
> +               if (dev->rtnl_link_ops && dev->rtnl_link_ops->get_link_ne=
t) {
> +                       struct net *dev_link_net;
> +
> +                       dev_link_net =3D dev->rtnl_link_ops->get_link_net=
(dev);
> +                       if (!net_eq(dev_link_net, tgt_net) &&
> +                           !netlink_ns_capable(skb, dev_link_net->user_n=
s,
> +                                               CAP_NET_ADMIN))
> +                               return -EPERM;

Do all other callers of ->get_link_net(), dev_get_iflink_dev()
and batadv_getlink_net(), require the same capability check ?


> +               }
> +
>                 return rtnl_changelink(skb, nlh, ops, dev, tgt_net, tbs, =
data, extack);
> +       }
>
>         if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
>                 /* No dev found and NLM_F_CREATE not set. Requested dev d=
oes not exist,
> --
> 2.34.1
>

