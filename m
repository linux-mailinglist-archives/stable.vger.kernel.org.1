Return-Path: <stable+bounces-241796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOeJKw5m8WlfggEAu9opvQ
	(envelope-from <stable+bounces-241796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:59:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936648E321
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CF463034CAC
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 01:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43FB35BDC2;
	Wed, 29 Apr 2026 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFBldmeQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43F35B634
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427923; cv=pass; b=XlaBHoEZOTYeT7C5r1/yQUdUh7gKOCIXZG3+ih8WDnlw+xP8Nzts9AZ0inYcUY32HFVOl/LyvL8aViui3EywkmHO4LipH8VlTNHHXxx9vtmaEFOdFrubNrVpEAV5nn89Q0aqYN8VfFG72iHrLAyy7ObJXMXZWivRW2icCBQYdRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427923; c=relaxed/simple;
	bh=Pxrojmrc2cY8YLtMnn3WHI2wj4Rjocszi1DAJUpeITE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsJdkWbGpZpiDdXqqn+KEDirEemUQ1tG52BZe2tV108V+NLoGM46YCWLDI8LdKtKd0AICEgKOAwtqkWkRbxTtQaM1hmrrkkr6eY1Q+sgHnFAZr4ZUhYJDML9JS7W1gzrhAFnG15VuILf4QhFXljKrg/A2SwLTw67Ul/r3NV/LnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFBldmeQ; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44509921fbcso1768000f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 18:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777427920; cv=none;
        d=google.com; s=arc-20240605;
        b=eVm0D5BtkJSLwDmzx4iIwgUPmNlUx37yGSWy8o6ZOfSmM3+JRIMSSX2YaH+9xoUZOv
         CHn+XxIrK0hCjpXRRA480236dpSjW1OTaK+IfdCPM5sjnvY1U+26Mofk9CaT4N4OPymm
         BpZ5PEoBIJv5Nta6Ic6FkKWgtlFQDD8tbkPRNSzeN2GELibX1uuCOavW/7+q8D1izIOP
         ziGv6OIxDALM6CROz8fbzXnXb1noiBl/JBlunhOuAr4mmRlZYM6BL81wIewmm4HIZNrB
         VBj5vSYEemOM3NU4SuEadrZXlj9oFQtTH49EdCy+Gm6MUiiSTdXzB+VDtGY/RU7wnDPz
         EzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yuqGeXahbxcUk1u4/2wMgxO+sa3eSW+uWGPH0ECvggc=;
        fh=jVfEWh+rQnKDvmRJ+ZuxOSdQSot5Bdp/d0OYphjGnsA=;
        b=EqeMOYBgHb/SG7iiiMbCL2aTfVUHJFCo0fH28ldhNmdo3VNJUjthUW5/GaOaSW3l2e
         2waKjB70FRgPb5+HbYjhoRPhbSvrQ5qQWQR3OQjYo9j+eej7T+H6ETqwf5JqkiIjicUv
         z7OoByuzMGFBe3dgSzb51ZVY7r7rXs+I8niAY10tuYHER65xwKf5YN1I9AbrzuslZbsZ
         vEB0tNXQnmUZ/XoNoaCrCPbiVkN00YP13S36ehiUwRenzZcP91Zh06iApIlQeoekoY/5
         o7gt3IAJX39aPqrc3khG3aoFGdPQsq0JDO3M3dqbDUDSt2qXwhKPtzpl+Lvsabu3LOc6
         Zwvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777427920; x=1778032720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuqGeXahbxcUk1u4/2wMgxO+sa3eSW+uWGPH0ECvggc=;
        b=nFBldmeQPfcpVzNubkTFn1V/ReisvKU1H1uz0rVgUM6z9F5I4MjjEeopC6jgZWgPpj
         oRUPQw6Zs+Pitn1CG4yz2KEhZblX8MAcTpJNusQRzqrgOcY25X5aONEUOQDL2baZcUBz
         whMjUtqv1bgCkqwrsrpQppBsemsh/CrJHjRLQBdfJGIiDPNb0QQpGwN6XR0tHEnH3x1V
         DqVy3+OgEuzBa1EaDbXlURMoH2QiytRHrVkAH4n7sDnCxipaccG6xGeY6RTHwCcAh5Y5
         wyUo5Sv1OusV7PrrSSnxbDGCyfxO253B4qFB5d1kzAcWIMN45suzKVWOXI7teS1DyrBL
         gPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777427920; x=1778032720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuqGeXahbxcUk1u4/2wMgxO+sa3eSW+uWGPH0ECvggc=;
        b=b+AnQmFogxq9SQuff5rwfaPU/TK0x5b3tNtQUWpCxX5EEa3m2OdOGjWmKIGrOSSkEt
         K0+9qF6fYH9EQ0aR4W9YIIImtQbW82PVTWMx9bGFAByx0u0otsSIeszDJ0arbXiWpKK7
         5lF4zQalFLdgsBB+5Of/F0rNOr9Z7EaoBg8kUSuqf758IgxRse5klipJklMIkjaSjJYr
         s/JPFuw0RcwFk06XVwLuLkH18DBaSTGD7P/CV4oNlr1qo8t/H8s70KG0970iTrAD3r2x
         ikz/8LS8ve5iq5iF3YQovfDGM3yM6wzxIF52OTTTD/ovDwBxRAVbsHVegTCZTwT7cm1u
         s1EA==
X-Forwarded-Encrypted: i=1; AFNElJ90xTTpex/AmzJQIYaH3CBCv5RbhnKvJAva/lGv5t3Nh6fgrz0hB5KUogSYgrpBED0AV+PXVkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SUIzwR6hHZg+0s36S/q65asF0Bz8s7SvWhY4qcvkf+18yZCw
	s4wdMiFzP7RSV8I66ED/NQyxLQv0KbWMJh1iZUEcxgrVGQMEN0JEnHsH0xlZsVmTR4u/2Or3Ckv
	ZNF4yURuhryn9cDqIRVtxcO4cv/ZKSiOd7sxPjm0=
X-Gm-Gg: AeBDieu7JldpphnhMEHfHDwTdQIyRC8wSo/NE83SZ3Vy9/GsPx7El97mbBWjZZkbCDs
	D4TMJMa3OjEFWr7jF7dpRPznUx1dDgwEiyW3FVAUUvReFt7Ody+mPwR/CaQImchUE6l6NW9MBu8
	M9i6m8mYmJg5LuwKQ4YG6aGhk4WiWTsnhaz4I8U3PyAd3WQ5GPVVTa8DTcjboUzCsV6Kbqbw8aZ
	tvJiMgdYSd85hgLyQ/vu9Rz6G7tXGiMCP4o/HEbjJ3LeJV+BQfXt16LEXqB633mLM0GfdpCbEML
	gMWrA4EJW6vuuRB2cfixPZmme/IKM8184SiYMXeKEGxlZBXB4hS7pPz/x0w=
X-Received: by 2002:a5d:5d0f:0:b0:43d:71f4:7ed4 with SMTP id
 ffacd0b85a97d-4478e9943c5mr2778885f8f.15.1777427919385; Tue, 28 Apr 2026
 18:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 29 Apr 2026 09:58:01 +0800
X-Gm-Features: AVHnY4LERK-_-glKNSMAd_6o281Ks5DC7YxO0koEJgi2NjQopuPz9tDFTvsvn7c
Message-ID: <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5936648E321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241796-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,ntu.edu.sg:email]

On Tue, Apr 28, 2026 at 7:07=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
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

The changes look good to me. But why is 5e72ce3e3980 mentioned
here? It neither introduced nor was intended to fix this bug.

Thanks.

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
> --
> 2.34.1
>

