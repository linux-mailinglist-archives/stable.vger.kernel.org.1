Return-Path: <stable+bounces-241766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALOVOTUQ8WmXcQEAu9opvQ
	(envelope-from <stable+bounces-241766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:53:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128448B5EC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0513078623
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF23B0ADD;
	Tue, 28 Apr 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3PHSgoY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75213383C65
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405805; cv=pass; b=XWFi5Krkog0M7dQn3FYbQxexRt/N3IEuYB6IptDtUKhxO31L771evr9oe9WJ2vr+RuZDO/aFh2NXjYcNMVUNqs6vYMu0OFxtpbE9iZgvVZltAjgEHs5DwAVSctxT3jt2pHa2rjNK2LN3+fmEtdGizquIX2SC0CWaIegtv8o2Jx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405805; c=relaxed/simple;
	bh=lkkR2eve38SCI1I2mEgfjrlEnH6RFlw7GnLvYAL9Lb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wdi5ao21cJgzVM1zslaMkiBOFFojM/rsQd/RCxhQ2s/KuHRdrf+RkDylN3APopOxg1jNnW4rzYRRAwf9w8FipCVO4N9Gbd5QFx52JEcwOBh6Hukj6SVj7c4k0K+ZeUVqv320d1nHecIdQXDDTvEr5x3P4m3TuqelfNQW5260UXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3PHSgoY; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c19d23b19so15492178c88.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777405802; cv=none;
        d=google.com; s=arc-20240605;
        b=SzJlV8Ig/MWN1fDBlDvaEBDsePG0aJmfsmclDICHHuQpp8SolREwRjaY02Ypm68Nh2
         SJSVCWmZXbzcq+yWusVzs3yFBfT23ZmIYdW/H/eoOypLd2C2zvYkIBYrJFGq9DAB1t7V
         T+3z25U4QR4AEe+9gj4dE0EYhfEK+M0NaEKtTApERnrUgZy3vyzXcEPFTPglXgTc6HaQ
         NhgnFmLP/b9/v1J1t4JIihIgIkoITc8m4UbK4obKElS0y8ToEnxDrmBtbCE/PYCLEfVR
         XJYYtk3xT9AhgUOyStZMKBZTFTjs1j3Or+mWrEEh6L2h9gRtQgrii/vI0VBemMSMfvbw
         0zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zDNF5CMCpZc0VoA04wRmTutNfv47K/RJM/UWNjIMLYg=;
        fh=cXZy0IxMHZ63jSDf59zasLNV3IUv+sFZqs94IOOTz40=;
        b=UWAPR6ulp8UbgWBtbD3yjh37luMzBvn3vZPoFj0dsUC3zTa5Um4y1b/BxrlsJi+nig
         in3Tq3bCAx1mBJLwszAzT4oWZMtzT+mqpT56DxRjriphXNukdIj6QHFL3MJ74Q1CQMXJ
         e7CO+z5ujcA8BKPB6uQPDENVj+s8wp++Y/D0xa4oCpCnpkzDybJdnUA443wK/3swZjPE
         1J5/eAq0Vtg9vijYQkDoiiHJ2bQEq9MmqB7yb8BuPsYb/RYV/1xaTv4Ibo8IXH2luYSO
         raGafGa9B6dB1xdjcFuST88uMvzwgpgPgOm1Ry5jl2hOtAyU6hS+Gx0/HBMjl2QQHCzT
         dxsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777405802; x=1778010602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDNF5CMCpZc0VoA04wRmTutNfv47K/RJM/UWNjIMLYg=;
        b=h3PHSgoYVv4bndJf/woVAzAWE/honSCfvBbpU49MNWTM0LzRxT1qAMuyWzI1f8Sr+o
         IydRzLGb9NS3CyithdM1rTZNSfV/HjbHgoJs0woXI+2dvA0UPB+Jb8jrGUsLmqD2hRMg
         bRFOiYXgzD1afFm3A/+2LAOdDntxAD0NLxUhX/hkLlqjxRn8hJjdTO3zp+qdp3sVopbw
         8wcZSU/fMI5GW+ZC693C5XGU78Kwps/ONBkgGCdEGvMMVpeln1wMPByjf9pN5Cobdjpp
         DzEbgKwPAzRMRVwyZHdbZQjF4Pk39xNY24bHJd8nJkDnQsvXjOeET9Pwlwv/sTr4FlSP
         eAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405802; x=1778010602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDNF5CMCpZc0VoA04wRmTutNfv47K/RJM/UWNjIMLYg=;
        b=XFAG6KcNYsQy/ebm3NewwKxxB57cr672O6SeNUCARi1AogKgaEq1TNgNJm6b5gFM6t
         2i4gEPa3pdBoDcxgZ5jG9+3rosJ3WFJUs0Soil+LwJaDXkb8D16jxl6y5v8WcS1Vegt5
         X9bqiIq47Tad4eVCd2skyYTLv/jcM8Npow4SBPlPRAN9NrbsqnbQdEnVyE74wxDtjl3O
         /3Wd3xLg/BWcgGuYZJsqSXzE3T3kNbLWkYFZJfeE7PKWSbs5E47RalERbKVn6Wdg0lE5
         ++CCfJVOuvyeyKahT/o245v0q80D4J6Pns+F8vXGE4KGWUTrh9qjnXg39Hy9daekcpfu
         1khA==
X-Forwarded-Encrypted: i=1; AFNElJ8yz11sjh75HxU/SHqjvKjUJg+bM4Qy9pOfpm0qhDiDhbN3Ux5lCu74xxaa0ZBDA0Eo0lF6RgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpz1S/nB3R1bnsOYArt6sG+E4Ms+yeY7SQ/zkesJb1Fm6II/BX
	G3/wMYzctMeTBgzhRF+OLRAm9LrTVKQkkTZsjud3A5wkDnMD86B+6In3D6MuOCucYqd4XLn+r3i
	IIfe4rqM2VOKIu/4+f9u0CKwVIAtVW5c3yixWkxLw
X-Gm-Gg: AeBDiesb/kpjxq1HMFFUW474BeDPK5mBXAoG2xuzVvg7eLzxFAnWdu9FBwky6vzrYYr
	GoUDYgPJZiJJ2Ys66iqAvvxU6alI4jgDL2kOJQDHt+i/2Jwa+c5dAR7j8iJ+YCINZ927pHkvH6r
	PfJwNExQcI2zOJ/Ws6de3xCaIMJgKMMLLFChJvyLfHT12OytGfvwb4xViT/cj8dBvBNkYBQbg+l
	5TvnVoDw/ipHvOdVkOnetkdcKfcn2dF+XytuWK+24gFxzsyDRaA0/DvR3KRRl8+umDeat8vg2Ji
	zProdvLOxqq7NCgh0x9gW0t1l8DbdAYvCpah3CJc4V0F4amCkNEr2NnYL/GyVMzmMYCVo8DdetJ
	hsPA2BiZty8IoOpZJVxuf7Kw37Sz3wbvIJNm0HWfSe8e9oTs2dFbG+ejTwFCqpIob+yvBiU1LyY
	WEsF7i
X-Received: by 2002:a05:7022:689a:b0:12b:f616:1a4e with SMTP id
 a92af1059eb24-12de2a59b5emr255422c88.23.1777405800910; Tue, 28 Apr 2026
 12:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Apr 2026 12:49:48 -0700
X-Gm-Features: AVHnY4IO0ImWe6cwsS4UMoARRrHG4T4KNeiTq62PUuCzHuYBOHLHnzpJhWhU9cQ
Message-ID: <CAAVpQUAVF4T9G22CBwCTHdsNoK=3ARPKkmS5fAA+su+qDiY4tw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, shaw.leon@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6128448B5EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-241766-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,google.com,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 4:07=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
>
> After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> that series and still uses dev_net(dev), which diverges from the
> device's creation netns after IFLA_NET_NS_FD migration.
>
> This re-inserts the tunnel into the wrong per-netns hash, leaving a
> stale entry in the original creation netns. When that netns is later
> destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> slab-use-after-free reported by KASAN, followed by a kernel BUG at
> net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"); cross-tenant scope on container hosts.
>
> Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> file) already uses the cached t->net correctly. The bug is specific
> to ip6erspan_changelink() copying the wrong shape.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")
> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

nit: Reported-by is not needed if it's same with SOB.

> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
>  net/ipv6/ip6_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index dafcc0dcd..38ac14cc0 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2261,7 +2261,8 @@ static int ip6erspan_changelink(struct net_device *=
dev, struct nlattr *tb[],
>                                 struct nlattr *data[],
>                                 struct netlink_ext_ack *extack)
>  {
> -       struct ip6gre_net *ign =3D net_generic(dev_net(dev), ip6gre_net_i=
d);
> +       struct ip6_tnl *nt =3D netdev_priv(dev);
> +       struct ip6gre_net *ign =3D net_generic(nt->net, ip6gre_net_id);

nit: Please keep reverse xmas tree order, and you can
reuse *t below.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-order=
ing-reverse-xmas-tree-rcs

  struct ip6_tnl *t =3D netdev_priv(dev);
  struct ip6_tnl *nt;
  ...

  ign =3D net_generic(nt->net, ip6gre_net_id);


Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks

>         struct __ip6_tnl_parm p;
>         struct ip6_tnl *t;
>
> --
> 2.34.1
>

