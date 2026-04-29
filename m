Return-Path: <stable+bounces-241804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNEaMKJv8WkIgwEAu9opvQ
	(envelope-from <stable+bounces-241804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:40:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918E48E64E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07DD530515D8
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7A3845DC;
	Wed, 29 Apr 2026 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2UT6JMC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897F382395
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430363; cv=pass; b=EPobt3nyWy2mUJKUulShGF+Qxbum6xNpEVIiduAzvIsAHMmd3rfKEf7JX30TVAs5nXUE4BPTo3xf+2H/YXwSdTpgwtZKOvGfikwSKXvzwMfvkosWTR5ndAfFkjEj1YXNhD3B9m6ZHzPGCeo2CZfA0xyT0vAGZyfqXV891TQr5mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430363; c=relaxed/simple;
	bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzFZRJVJRYpoUbyokEz+nryn4kBFJHUj7CRdKtVu9N4PLIlW38WR7io4fejM2SlHIHLDh10tMIy5YhKNXPUB8a+lwu5SsExC3r/VCbT9jRiS6Qoc1iLZiR6In9wyr0Tabgrcg0HASRZ3z6dPps6LigvkS3DRYqUl/2IpYayBGIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2UT6JMC; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso83213375e9.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 19:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777430360; cv=none;
        d=google.com; s=arc-20240605;
        b=EBeux7P/fYSBXssT8bNvig9R/ypEcrwWTSkWNCbK0eZ1CHxpQld24YKIeKXKt7GeCx
         Aomc3/hshtmix6ZjU6QaIyrCpN+BfmonbuoLUZxHAxPUD9bAnlcl4nOeGLopqZ4S2YXG
         IjlHrV563Kgrsn9UsdYi6n+q6AGjNhAAynoODhRG8LcioJ/6eK5Kmtq1BfRxKkoBX046
         ahJQywlxTPzf+qt1HdE9mZMyuHINfA/zKjZiLhKweusIlNfRaMAgnWHBb07vpA72ztr5
         IsmZk9hfOd2NcDXzJyh3m9DbOTUcXnVv4hLdG9jgbWyNeyEAAsoDhYVrudxnVuynGKby
         CrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
        fh=++ilSGiBO4Pz8/rMK9pPoNZCG55D5XYvXV4E12ZVT0o=;
        b=gQrKprNCdPYTI6zo16bcvaXxriTP5tNcL96VfKxqGu+5HSnagmw9TGuCxrAuNvhNJB
         D7g6FYpmHIVDVbpgAhzSswBye6ebrzj2kesFXPSVo3AfkonMTGk9wj1fBzv8vqD8NBxM
         YRo2cddP9ZpbR0Zy+0mWqzZjn0y7ZjpTmgtzndFOTHPDM5OlvNrlnK7KhFjkBeAVCo1w
         Cch6AAi76JAZVmzT/CeZf6nkIBW71fLrnsy+6xvAqkD3CsZ/H6Q1gd9nK1oRRkNGVhsT
         PY6Qc49XFcq2af/2mAuY3MbcULx0TkBE+gd+VEZ+frQfwGjSXt4Moi6psBPZKeI7uUGh
         U3XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777430360; x=1778035160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
        b=F2UT6JMCDHS4+k+vhk3lJOGy45zJjEgLLedAFtnFRyIRCZABmmwHZLLtl6q41YOHUc
         4chDfd91aV9zWIb2MX3nOIOsGtt9JRzkIMHoKYS5mi8hRv5z0gr6ofqwUmfuZQ12vclr
         YpjYRd39q0r7sIXZTht8TedUL5n+f1uqoP75/OvYGm7kADaSOGI2fptkighbxxre9n0z
         ui3AsUkxjRueN8s4JuLRpr1xbxbSLJtLz0K0fuIy6KSrEt+6qlJL4eLJkamrlkwu7sCp
         ymhOLeRkIq71YQ+HqN5oDkK36HrDAPHwYxAUXEGV3+J9XVUMkQY3CwX/aCaA8+vnnwug
         kTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777430360; x=1778035160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
        b=jBm2OommNiN7yR1ffOzPHuguTTJyuSZRT/r3yYF0Isi++FWpmnvJ6k+qcOIYn/qWbc
         Kh/NUh7ZgkxsDv62V183CBu/DPp5ghFnHYF8QGntd0FbW7ljL7dMj/thVzHp70Gk1OBS
         MhD55eAs15po+XmcqqyPI5eyGSjeMKN8O9ZTANqSRn5TOctlPDPh7rWzau7EP/nCXd+g
         /potyPJf4zq07dP+jHcFS7JMRxrrNDtVAJ6PWxJk+iWd7no/oTYbMiGHefS6M5Zd6fMm
         U+fCB2ODis9QU9f86pfK7eyIN4+O4FnMyOJwuBOlY5YVl/NrwJ9dWmD/YTEtRPvEvuIS
         ulGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/44jDtdVpMa2kJJznJsuizJhSFWCitM3gsue8NMwKc3/czL8zA/q+PMNcc7+B7VpV1jpjIwuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywHk1+R6qRJlvd/sUrzkWpALrG110Y3sJd08Bzvv4ohx06Ch+k
	ll8+kFI/3Zj/wRD8a7BlxDprI7ONPzM+aTCVIF1Dt55YaKiDuBLzlowLkq1thztX/ESxKtdZZeK
	84F3rWFuTkjNwMmarY7uHM4W7bHJiFz4=
X-Gm-Gg: AeBDiesamYGx4qW+5tKhxCqGEgtJBVuaV0ASF9amkpKv+fILbpajreERPQOGmGwNwPm
	X2vvMJisdF/Mu85bcwTNl2/ZzyOGHdRgqDDzTfizMKA1YSIhWuGx4BRRr5I7R6HnjCJYMPg4OL2
	Sxe7UORzQLrXZRYEf7AArBPVr/Q1z0H9pIvRnQUmxMiQZtkDybeDefsrstf8X8tf6+LO+LzHE1F
	26x8WtlJwjgVUog6TR2mZhOXsoFUS2A5yBr5oT9Art+ZQM9kXYOcJyUxsZkIc0wBUTZUvanYddw
	mscslSAlDPkQZiHBadmVDqlLWHpVc+mZO53egbYMS8lQ4aDh
X-Received: by 2002:a05:6000:2dc2:b0:43f:e791:a333 with SMTP id
 ffacd0b85a97d-446496d7a5fmr9453139f8f.29.1777430359955; Tue, 28 Apr 2026
 19:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
 <20260428110713.2550315-3-maoyixie.tju@gmail.com> <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
 <CANn89iJzu1zXpx5G-3jVDS0duLB_tbm+ULzLk1ZW68fayoF9qQ@mail.gmail.com>
In-Reply-To: <CANn89iJzu1zXpx5G-3jVDS0duLB_tbm+ULzLk1ZW68fayoF9qQ@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 29 Apr 2026 10:38:42 +0800
X-Gm-Features: AVHnY4LZocalNrJgv7vMB2vdTcn-atowI7erBu9gVSevVS-P9DwrltOsUKB23To
Message-ID: <CABAhCOSFvmxQjnxcdkJV8mx-d163tKz2ykgyciHSFOqs-yBrmg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Eric Dumazet <edumazet@google.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, netdev@vger.kernel.org, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5918E48E64E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241804-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ntu.edu.sg:email]

On Wed, Apr 29, 2026 at 10:00=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Apr 28, 2026 at 6:58=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> =
wrote:
> >
> > On Tue, Apr 28, 2026 at 7:07=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.c=
om> wrote:
> > >
> > > From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> > >
> > > After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> > > rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> > > ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> > > that series and still uses dev_net(dev), which diverges from the
> > > device's creation netns after IFLA_NET_NS_FD migration.
> > >
> > > This re-inserts the tunnel into the wrong per-netns hash, leaving a
> > > stale entry in the original creation netns. When that netns is later
> > > destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> > > slab-use-after-free reported by KASAN, followed by a kernel BUG at
> > > net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
> > >
> > > Reachable from an unprivileged user namespace ("unshare --user
> > > --map-root-user --net"); cross-tenant scope on container hosts.
> > >
> > > Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> > > file) already uses the cached t->net correctly. The bug is specific
> > > to ip6erspan_changelink() copying the wrong shape.
> > >
> > > Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_=
link_ops")
> >
> > The changes look good to me. But why is 5e72ce3e3980 mentioned
> > here? It neither introduced nor was intended to fix this bug.
>
> Which patch added the bug then in your opinion?

Maybe 2d665034f239 ("net: ip6_gre: Fix ip6erspan hlen calculation")
which initially introduced ip6erspan_changelink using the wrong
dev_net()?
And ab5098fa25b9 ("ip6_gre: fix tunnel list corruption for x-netns")
fixed this for ip6gre, but ip6erspan was left.
Anyway 5e72ce3e3980 doesn't exist before v6.15.

