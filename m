Return-Path: <stable+bounces-241666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA66MZK88Gk9YAEAu9opvQ
	(envelope-from <stable+bounces-241666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:56:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40646486603
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D841233519BC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E881466B70;
	Tue, 28 Apr 2026 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTkiwkQM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B45466B71
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382091; cv=pass; b=sYsR267LXA360o10bFxMDygU8p3O8tFbiaBB26uHKyJ4w8liwTM4W1rduBS+4bp8HnUb1yqd2nKC5DW+M0zxxUV6E0z/si+ktVJaOT8PHoLg/eQQq89pjDLMpPul57UyYz9+FomQX47m456t+VU9fPPkDmy9SOc5igQDQX5zdRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382091; c=relaxed/simple;
	bh=ZwNPsWGyUBWsbKRpWETRmRdi5e9LTVhqmMjD+c8WfRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJrpklbvJ6OicHs8FLBRmzDUT0JjoedrOGthBQxSGmuXMWpjgKRyZ3jfZICq/nxs9mIyHAwJILCM67uE/UVKnaOPPINxjuscbA7GU7FXhaFQtyiwb/G+VokxHtOiNaBgUKfvrviJeJtMKwYTySwUD1tDg8FXfhpdFRYf9811sRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTkiwkQM; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb38e86cf2so1031336185a.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777382089; cv=none;
        d=google.com; s=arc-20240605;
        b=bflmjF54jegvFT6PJMk0Jsf7PA1VirLvITbbs2/sCCzM2VhEWtXjWce+dfWhWE5yoP
         lLTIATmRphCkABFuI0d+kpy7rEo4VQhcOkBZUclGBSzmDYJ6moYzyWieATzu/QF/qIZd
         aXIhcNEFVa/1oeXhOkUGKpc9T+4WzA27CEqhqyON45UNpu3eI6ThvuRzyoaWHo0vYDL5
         uDzudv+OEM7ndNnjEKVgaithf4KJoMtgAuw0KXzXHN159Hb67juYfIjfZ6Uo9D20axj/
         1gImo6Cf/RrKOXA+Ktou0i95t8c++jK1OVfO3CLuXhU/N9eFeZq9nBRXGZy7e7Ym58V8
         spyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YSq9/1cMNyAq7AS9BzXp6MAhePxCxapDKbYhRtlzxjs=;
        fh=1gh4eNdfXi/RR/uR2BsdyMjbLXTUVD9VxQ7Vnx6zO6w=;
        b=fki5su16HlNuH5PDQzgfG0eoSwIZkWCLIlknFI/XT4wl8WS7i2aEbWl15NevdRivrG
         Q9a5bw/qFzwMyGXddHoBe1nxdaZD2yfRwCSKNOWA02SyeHMtxsICLhdPhS6kLw+m1JNB
         +3xtk884l5YkOo4GCWravZHbPB5/lZoy66EHuU4T2cGonnkmmNmRV/F1COGByXqOaHls
         nzjeSPR7X7f+h/JshLY6evO421jickcjdc22ydlhazW2On7onDbTRO1NMIqI8P9yO2w8
         QpXAW0+D9uhXjjurmhQP9KtLrX2gVLyaVxAVf44U07g+NiKmlB6Jz6I23e/H+7RrrMdr
         Lsag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777382089; x=1777986889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSq9/1cMNyAq7AS9BzXp6MAhePxCxapDKbYhRtlzxjs=;
        b=qTkiwkQMLhrU/ZIBMw3JCpz6+4SuvK92QBkMAOu7DLslunmr0McXwC6zZHctPVKHLF
         rzBfc0LzMEcmcoTTxykHY7Y6+RO7/0Z05pCczpFeKSc3lp0vIMcqy6THurHFQbd0kPur
         mLjdRuObodtWdGPap7kM98N6xbtPkJ+3k7AVOY5X03CFoSgJbET5C+NPG/ySdzo5T4bE
         qjp1YdVr3oCopNmvFOuwHmiBxGFyxpgfTebngM5Kgza7/GuD5sG3pJPL5vm9tEaqcbIb
         hge1q7+0U9wPNP86Eb7jJO748jVz3yQbhrBri4nN2hFPXRBc1W8fGW4c+eDTSYQJc7o5
         8rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382089; x=1777986889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSq9/1cMNyAq7AS9BzXp6MAhePxCxapDKbYhRtlzxjs=;
        b=m6BmUKjoD2p9QeSmc4GnU2VOYmEusrY2Y+MU9IuotqJOq7d0mRZO6YfW8Wezwl3PVd
         3Zy0j1rCKON1ywAvLwlKg+KR72PV3xyIhzHBiEqahaR5k6aEJUPFOSrVnMZwV2fVg28F
         vNwQWaBfYZxdKPeML/FLcgFXOzKZ/LuqpJpcea918bzi54r6VTsHA6qd8voIuf/n6ANL
         8aOt1EJqpSB5BbGCIqQIOdNq4RVN3GT51m4ZCQUTkRSteKK9kQ9Ji4wJbmNJxx92rgL0
         xnpb02te3FWf3E9N+KVIAqxxWHCyCEaW6Rd+pcVE1ITiNRiGLAgAa4o5U+4kpf8vCSzD
         /sMg==
X-Forwarded-Encrypted: i=1; AFNElJ8oXYXJsbdpTSJ7ldVccPtvTbWIg78MiJrIsdy7Fsxsh9ffg40DYfs91IifDWZ7l3wjcGnGVos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiAI8n6tDaTA2TO7QSjXQQbF0COgiCgB7v4uRjAh/g2AztrhL
	ovwywssgyaCRBXYZKEI190RYDzyIrnWrNASZ4Gk6nkbKl6l02Rl9eSv1CcH9kmuP/bVCBXvnbK9
	dyHo2DFNz74H5P66cHZX5N3S5Xl6HjKn+IXjKKLfm
X-Gm-Gg: AeBDiessveNOFJSUB2XRs9SFodTDXR8JcgNRFQyHD6G+pIK8iPwBkuwTxNfMPSseVaj
	165df1Kv6mi7rcmI1QjCZQpCEWnq4S2ahm+L0ESDi4qFPs/TUWjGHMqZxrSgVKAmNc8K0zLoSE5
	dU5B3r+vhEW2axfdJb44aHu3tVIdXDCfGd5sa7rnsLe+6UrNmDFho9GGJu9xhKuYwpwtk7UXrtt
	3+m84ipb9+VFOvx8vvuhArKlslzVXbx/sjLiF0eGVZDn0U3dPN73q8hgmO5gfNw0lGMT0zNo5e4
	4DtLHu3dELimeib5GLRpDavwgKVbfeCGx0BTqGry5xPribAEslmpKQc+VJ6EoU/z3HP0sESxQ6f
	5A1PonUza
X-Received: by 2002:a05:622a:1989:b0:50d:9174:cf33 with SMTP id
 d75a77b69052e-5100e123fbamr39330151cf.16.1777382087958; Tue, 28 Apr 2026
 06:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 06:14:36 -0700
X-Gm-Features: AVHnY4LLxwEILt1TTGPsaaRHkW5N_u-1e6yJrI0k1snh5_u9WCEuAoViwZNd9hE
Message-ID: <CANn89iJNXDk6cSeinqfsv+GWFhTV_c02-MwokTAtkEf7tgJntw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 40646486603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241666-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:email]

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
>         struct __ip6_tnl_parm p;
>         struct ip6_tnl *t;
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

