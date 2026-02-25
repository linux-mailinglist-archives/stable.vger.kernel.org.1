Return-Path: <stable+bounces-219624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JUSF4b9nmlAYgQAu9opvQ
	(envelope-from <stable+bounces-219624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:47:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060619858B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03A7B302A7C8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C33B530C;
	Wed, 25 Feb 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="U029ypQj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277543D1CDB
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027265; cv=pass; b=UJoMH8A72i5fHc9Mx/fn7THx0jDOb3s5SC/ibu6U3ZGLNfIdEQhBku5J0hr2Uh9BbLLJkiYKNhK5kQVmSOZFdd1izGG69fIH5wHtggkEgGdayUHvnVPfZOrahqlMilWoqSIPs6BP+v/3k1qorl9uEN7jT2QIZo6p3R6W1KPQhEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027265; c=relaxed/simple;
	bh=ovELUbnz9MhlUEU54Oo2ZU9Jpyx6+5dPAdAfKI8KdGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QShOKGkjRyinXvAFUfSfMkc/8p7RsBwXRb4YSi7BaNRXJSogJFLL7HEOtqexnvTpyCSX+PvObScSBl54NBYPGij1zDH2JoIvCKGJO7KKFpWtA/HCz8xioinTMloHAQz6c7WQ6klEgE6n613ugEPxOP+cg2JaKt8rNBKeuZIQCv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=U029ypQj; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae146b604so47138505ad.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 05:47:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772027261; cv=none;
        d=google.com; s=arc-20240605;
        b=gl6zCl8WN0WNY4+wLi+flmqCMfQf3d2LL3LhfQ2Qvdxn7K7/2FFfXUdkBXTXkiJLhY
         iez9Gft9/1XIpbYjT6SrhWV97JOR1wT9A34vfJL0dS/MXfDn+PhHWr9IbXH/5n+Dnae7
         mH9fxuopkTPcJzqpoCYAlkYnwuyBurT9+TVPY3xIhdMZI1H/wkTY/OM4hSDhdt6QX1wC
         J5nYyyzZIA1Lm+6gAV221ioiTXeQNoqoJaZHiSi8wnPIFdRsZcbb+ds1vhN01fEyrt+L
         osoq0XqqmxlPnmpzopr7OUn6b9h1s9XCCc9ICURYZisGbgBocW0E86dvKo/uF+m6nE4T
         LFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7iIZNaBQSYUVo9grkEyao3Lov7n84k8BEyjOwlqS6c=;
        fh=jFuW2uAbEOagq0uzkjP+i4q3uZaI8GbgR27T2eBTlKA=;
        b=UL36YCEl8JNRTFTxYaUI0zAnyTeWbYCxne+VERa4dPmUEDI9etUmMtzdKhzqeoKtMh
         dtX+Zkqw1m2WmB6vxmkLiFd6CRYYDzGWI/hWMobU85FOX4suSApjWWagfUCQ9fQIfxsU
         gvNdAqWQ2uVa6JD9LevXMLlTzunXSIjfYTd/xRySnbADojthfc+30v1ClyIUkI6LBVPZ
         jV0/7HgZYqQyh4tPtdbtN9oWQevWmStffC21SdpXLrncWAYZpsrTHA1v6J1gY72prybq
         ndApzcSsCQY558ETpbiZaAcUWy/DA0cbCykRSsyv9PB+/USj1MqAoDtsKoXWtjwli8Ya
         vq7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027261; x=1772632061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7iIZNaBQSYUVo9grkEyao3Lov7n84k8BEyjOwlqS6c=;
        b=U029ypQjSr/10HZPeRK/I/q5iOyJDVVhoHXUfeBvwwMRMoThyr8pPipvPayMhB/Suq
         v7/ei7CwnbltmLhS+xZwCskvmI8fyK2TYhbFRx67hta/JTUWUkU2oCJxL0OwSwmx8rmW
         VKvLzrXrdjelOYfEPuwIx9heOYS5sKgCwfqdwY6nqKFtGd/u0oTf/OEkrDoihbmA5l0I
         ajQDO6rSEy8+fPnZy2kDur8P89ShIctDg9Hwr2MNzRmHdWDmxG+MQFvLt4oeZ4xohJqz
         /E+3eH5ICha630Ay5X6lX+mNWeDPt2vE8uUitcSXAEH1p+EdoUbuto3K2+BT/D8iAVZw
         KX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027261; x=1772632061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b7iIZNaBQSYUVo9grkEyao3Lov7n84k8BEyjOwlqS6c=;
        b=vb5bPlVU4MlurNgZ9jfEM20x2g2f4ks5aBs3HQDBowq16tcdpi+BhwabdP0CghQV9C
         Bo4XvyxoMeHlMviaR6JdvZx+nyEX4sb3NMaP062wajR36h0UEtrGsOl1kUH+guxRt+mf
         TudA/eOIlQITejQboLfdZa2kdj9FqfnBADBFaklaqq3clmArcZh5aFhcHuDP9fH7/Jn0
         bSK9x7r4cmJELcJcXJI3tsItVkUB1HwkEKOdUYHjiL9gegcPX/+qMMkA+nuCgfqE+hr8
         6ms8At5t2WamgOV8z255/8yd9MF9OdTULVs/Nq5DKJH4mz+eRrecWYvYt1jeOMOqgn+q
         0eOg==
X-Forwarded-Encrypted: i=1; AJvYcCXZOvOlTWUppC5wiZGMTTLo1ItxGbfqTbHwbw4XPg6wlFLaVftUlLGlPCqi8e8J0Y2mpztWtgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywei20Hb5gGga/Ti+DgHYuc0xnuKtmG8UFMKlffVu18YMb97hVP
	wox/rLVSYwctLWi6VJKZFqJvAe7J/SLN3AKMYOfCGT0/E9gPbYWWWMoXg0IGox7PPkfVHhdHLv7
	epJBwkby7+RqwVho6s6LtpJ2RRR5dgA6Kn2CXADQDlo7xqkegfGw=
X-Gm-Gg: ATEYQzx6yRzrFa9kQ6rLfqlWq5MR5ya5aad7z4uinBp2PgqAHKksnOqExFxkSWP6fa7
	z82QFOlibje4eI8OPTc3/ZC93QQek+p+YYlNLIjdvb1I6dlMztwTlR2bUSqgMuYC9bFTe0VObxF
	xZAjrqYRLheRaBBVXIOUb9VZwWFtemiOs2deeYgIUBPti5EFQIY/TVUX063tp00nvkuIHiRb5ue
	2WsE8NgZIioU74iH7BjvBGoEqi5fDRIQ6ZajO3JLudYLZtajNfdFSkW/07+47iq+3KSuJhiOXgc
	p1UpgmpKdk7JUvA=
X-Received: by 2002:a17:902:f60f:b0:2ab:3cba:42fa with SMTP id
 d9443c01a7336-2ad7453257bmr163619475ad.46.1772027261300; Wed, 25 Feb 2026
 05:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225134349.1287037-1-victor@mojatatu.com>
In-Reply-To: <20260225134349.1287037-1-victor@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Feb 2026 08:47:29 -0500
X-Gm-Features: AaiRm53px7rqGdRW5gfANKpKc4H6K9kJBUzWMN2Ho4EClKUlj0-gvbVFsYYS_dw
Message-ID: <CAM0EoM=8odYZJ7ccvVB3YqAwssRD9CcB=D1UcKcMifT9dEcTqA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: Only allow act_ct to bind to
 clsact/ingress qdiscs and shared blocks
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, taoliu828@163.com, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, km.kim1503@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219624-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,163.com,vger.kernel.org,mojatatu.com,gmail.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8060619858B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:44=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> As Paolo said earlier [1]:
>
> "Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engin=
e
> later on tries to tuch again such packet."
>
> act_ct was never meant to be used in the egress path, however some users
> are attaching it to egress today [2]. Attempting to reach a middle
> ground, we noticed that, while most qdiscs are not handling
> TC_ACT_CONSUMED, clsact/ingress qdiscs are. With that in mind, we
> address the issue by only allowing act_ct to bind to clsact/ingress
> qdiscs and shared blocks. That way it's still possible to attach act_ct t=
o
> egress (albeit only with clsact).
>
> [1] https://lore.kernel.org/netdev/674b8cbfc385c6f37fb29a1de08d8fe5c2b0fb=
ee.1771321118.git.pabeni@redhat.com/
> [2] https://lore.kernel.org/netdev/cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@o=
vn.org/
>
> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo fr=
ags")
> CC: stable@vger.kernel.org
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  include/net/act_api.h | 1 +
>  net/sched/act_ct.c    | 6 ++++++
>  net/sched/cls_api.c   | 7 +++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 91a24b5e0b93..2ba40eb45aad 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -70,6 +70,7 @@ struct tc_action {
>  #define TCA_ACT_FLAGS_REPLACE  (1U << (TCA_ACT_FLAGS_USER_BITS + 2))
>  #define TCA_ACT_FLAGS_NO_RTNL  (1U << (TCA_ACT_FLAGS_USER_BITS + 3))
>  #define TCA_ACT_FLAGS_AT_INGRESS       (1U << (TCA_ACT_FLAGS_USER_BITS +=
 4))
> +#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT     (1U << (TCA_ACT_FLAGS_USE=
R_BITS + 5))
>
>  /* Update lastuse only if needed, to avoid dirtying a cache line.
>   * We use a temp variable to avoid fetching jiffies twice.
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 81d488655793..7de6eb3ff53b 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct nla=
ttr *nla,
>                 return -EINVAL;
>         }
>
> +       if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "Attaching ct to a non ingress/clsact =
qdisc is unsupported");
> +               return -EOPNOTSUPP;
> +       }
> +
>         err =3D nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
>         if (err < 0)
>                 return err;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index ebca4b926dcf..8c72faf3314d 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 classid)
>         return (TC_H_MIN(classid) =3D=3D TC_H_MIN(TC_H_MIN_INGRESS));
>  }
>
> +static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *=
q)
> +{
> +       return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRE=
SS));
> +}
> +
>  static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>                           struct netlink_ext_ack *extack)
>  {
> @@ -2420,6 +2425,8 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>                 flags |=3D TCA_ACT_FLAGS_NO_RTNL;
>         if (is_qdisc_ingress(parent))
>                 flags |=3D TCA_ACT_FLAGS_AT_INGRESS;
> +       if (is_ingress_or_clsact(block, q))
> +               flags |=3D TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
>         err =3D tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh=
,
>                               flags, extack);
>         if (err =3D=3D 0) {
> --
> 2.52.0
>

