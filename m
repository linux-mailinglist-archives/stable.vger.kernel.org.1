Return-Path: <stable+bounces-241797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BrtKkZm8WlfggEAu9opvQ
	(envelope-from <stable+bounces-241797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:00:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878648E349
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98FD33010B73
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466A3783D4;
	Wed, 29 Apr 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pusD8QNF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685A37757D
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428034; cv=pass; b=TBRTRG+LpE9simyjDY+69JLtmT6D0J+ld44z6jP3XcoSNvw2vIyahZtYS4+xRK76pfSdCAzTgNaswaWy/nmf/YiCxRnVfRfqJ8h1koKH6mw6naMy4Q4DY5bco9QcjEXFr197wYOIJHFOFXcsBUayah7zKdZ0mkUcSCfkTRSlyyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428034; c=relaxed/simple;
	bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP8RpOFh26o6kNo9qou64W9vyAmdaKt0OouvmaiVIUMzzr+KYeIMK+Mvjv3BN4bHp1NOr0hZ3Rh18gFsSQyIrxNUhu4x5p8UkJfhUd10r1R0x56Iuv4dWaBWuqjXj8pZyR0Bh8xW7tkJf+akE622FVT34Z1wc84q83tXhCJa93M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pusD8QNF; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e63771d91so108137321cf.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 19:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777428032; cv=none;
        d=google.com; s=arc-20240605;
        b=eEvcmjTulqJs1OpZsUWGQCHuE6GBIjrw3LsfhZ+QQP0rK/fJOTR2Fj7CMr+yGHl1yz
         taMbF31gklDg1hOEweVD1rwqniJ24AsmQbdsz5dsQuZTJwgOy047YR2YkPby5PxHWfhI
         y3HnnPccQhF5xQrzMhdTsaF0Kb9DNQz8NMOvHqhGcD//VPeLISBYPm8kh0VaZaFiqoG8
         VSsrIJskEMyaxytDwjRXN+tbz61Vtf2/X19r64O5vGt8bRln7T0YZPM5zsqBroVI0Mnc
         CuWDzWS7kgLHDAiQSduKFREEFGEMnocrHJVR1ZniReBd0OuVFB+REyaTa1cou57V2HQA
         uM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
        fh=xdvmgynZjvw+XgA3AciT3DtCJgcuOuG0wC9T+NiKxfk=;
        b=ZF2S4spJL1ercp8hGe9jgsevrUVJv/0f4q3d5ljGjvXqP8Ziw7J+ay/uG/9HjMr9eo
         Ub/863rw5QSRSFfp3p2iSxOsn/+pI16rDF82JRYtvWyFkO3HY9WCkMzEqirViT+PNaaC
         Ka6XUIsUd6zPyKJMiVMlSF+9MnpT6Cp2eEAyRGd16ywhnHeCH9K21GHPB1XoRCwJ5SyD
         nnLBL5pFW5f521XjXiuGbIG3wxnCBR/TGD5DqrvZvTX2+5hWRIqCeO0A+cXI/81JYp0H
         vnEbSO1D1+X05kEJXOVftAA4QFiuAwJjM16o5sJqZBKcqysRzsCBWgvtoxaaH1BQbeWa
         VC1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777428032; x=1778032832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
        b=pusD8QNFpJu8/15ycEhgCfOx8QuwA7RQhFWDGDS2AOGV6DIr5qNvXE4UffFEtg3H5n
         tA2wQONYDCXwgDRJhvlU1AIA9y0cbS9f7xw8CHXGJeRu53N0AnCvrElM3ivlpK2jGOWU
         5gioaMcGCs28fxM1xo4O7Z6VuL2Qgu0RL1F6KoWIwIXIF9JagBxpkptdNZ+KQvGXbbl+
         1e3yIpEA32hugRtVcDKLT4STwKWoUpJjkhGBMTnLokAamXWeyN8cFBaBIl8bxq1LUh+P
         9GkQp3g0PE/MO6yhtn4JVfea4cHMnowWIBZUjPjTV/SIMgZc50tAIcWelHe7/S9dA7N3
         63Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777428032; x=1778032832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
        b=WDlCI1m1G3L2mMqQt/r/lAQpq2N2E1Ai39q0ZzKJIZLzH/kadOQ4H5gQgvY4zVjXxo
         ltiPjt3GPVhya2MzZxz+L1Zj+dUnQE6cjkeM9N2vF6Q8XycqkahXzKLdeywgWwX9tYnA
         4pzJ8hLfsn74Nmv+65aSQB2CEb4m1TY1x3PQiceiONhaDHyOjZ+z/bnq+O16M2br2M1U
         08OnWzw2LxgcKwE39cSGqY2zCG3nqmbhdCx/c1JC0h0b6ca+7wyJxWn5EXrVxFEOLJV/
         MT0EcpVpjm0a+voTous/3e9wy965M9mWGCKShZ82ll35BVDECxDP7NtllSUmsHyIps1Z
         kQYw==
X-Forwarded-Encrypted: i=1; AFNElJ80RD+9Nwl4/GsOky3Ut0Kx8ScpS0N04Ql6c4lLUjfPcYiZzXaxRX7VCpLVZegoY24/PzfG1m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgOAkk3BclFBqIWkLpw+VDpMhrwGpVS0uaisBG2uhuC5na/P/
	pL9+GR2ARi84Yabg47ZJIrRg1sNMyuWU0+Z99LAUZyR6ydCqF9Q/7j9LFjBo/98/ZTXnrhcNoJf
	Zu7thw/7bAdDke5q6NkHbcFvfmgni1wh5N8qK388n
X-Gm-Gg: AeBDiesANcKx/wX3BXDfaKaPkIbo9H5ob3n9pqVci+Nl+FX/z/mVrVYw3yhkeKg5i/X
	Q/6MraXbytXkhir9z3ekyo06U8YTNhpcrd1wl95POVaviEChhwm7iBSFSTGBAuAL2MNwJARb/It
	gEym0MxYi9n1VtXl+DmAsfFlWlJGWHt6SC4flho4nlLAUSP0FT0bOx7/Fxdn+HGLLyESlsFEO1C
	KN9cDCvWyuM8jeNxMyWhM5Nl8VFBCzw/+ds/bNr76dfLNM35iwiU40Zxf46Q6ja8sUT//s7gMBA
	chnb32xedK1czK9tAfbW4j1UXzL57QgcympLRiP04hjij3vmVDzrWfPb3B5hLRzwwJOHGSKmUFm
	7R4I13J94qiji8Mwm2MWm
X-Received: by 2002:ac8:5912:0:b0:50f:b003:59d0 with SMTP id
 d75a77b69052e-5100e12587amr79028791cf.21.1777428031193; Tue, 28 Apr 2026
 19:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
 <20260428110713.2550315-3-maoyixie.tju@gmail.com> <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
In-Reply-To: <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 19:00:19 -0700
X-Gm-Features: AVHnY4LMPN3ftzG8WLk9TlJnVnhfyDIJxS4hrw6s4E3ltMk5YCYcEAIXaXlJao4
Message-ID: <CANn89iJzu1zXpx5G-3jVDS0duLB_tbm+ULzLk1ZW68fayoF9qQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, netdev@vger.kernel.org, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4878648E349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241797-lists,stable=lfdr.de];
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 6:58=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> wr=
ote:
>
> On Tue, Apr 28, 2026 at 7:07=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com=
> wrote:
> >
> > From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> >
> > After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> > rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> > ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> > that series and still uses dev_net(dev), which diverges from the
> > device's creation netns after IFLA_NET_NS_FD migration.
> >
> > This re-inserts the tunnel into the wrong per-netns hash, leaving a
> > stale entry in the original creation netns. When that netns is later
> > destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> > slab-use-after-free reported by KASAN, followed by a kernel BUG at
> > net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
> >
> > Reachable from an unprivileged user namespace ("unshare --user
> > --map-root-user --net"); cross-tenant scope on container hosts.
> >
> > Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> > file) already uses the cached t->net correctly. The bug is specific
> > to ip6erspan_changelink() copying the wrong shape.
> >
> > Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_li=
nk_ops")
>
> The changes look good to me. But why is 5e72ce3e3980 mentioned
> here? It neither introduced nor was intended to fix this bug.

Which patch added the bug then in your opinion?

