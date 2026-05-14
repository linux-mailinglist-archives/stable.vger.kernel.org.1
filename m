Return-Path: <stable+bounces-247168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOOGABOwBWpqZwIAu9opvQ
	(envelope-from <stable+bounces-247168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:20:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A7540E99
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951313038C6C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B803C09E3;
	Thu, 14 May 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcAWgA6w"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0309D3B7B71
	for <stable@vger.kernel.org>; Thu, 14 May 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757472; cv=pass; b=duVt5ipptslK2ejmbQo2QlkGghA53kSJW1z3x2gNaL3OO5/1Qa+45ce7e5sR8rf/kx1gSCLKJ0lT8sctkF+FJto2Pl7gZa/yhmIV6mAe+KOM6NJM5GgITUiFrNJSXiop2q8KxW7JCOws2MyNBInrwq5++ne1bkqhglk3BI7L+GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757472; c=relaxed/simple;
	bh=1l94VpQH6C489MB7AXIRGHt7qCtMVCo/4SssbeQZ2hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjmggX3sBaGRUJIqXE5SHvori8oRQLbTqizitCof5YI2sxD6jFolXUGYVv5VA6p5R2kmxIZ4nvV4aRC/Oo7ukUPVGgtGfh+2gedDs4nI/okWIHnP56RIbS4joMOAZr72ckt2LlhGJvc3/pymkOg097J7M1ZnZHPrtgBva/j/b6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcAWgA6w; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65e15fb394bso532770d50.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 04:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778757470; cv=none;
        d=google.com; s=arc-20240605;
        b=T7xKPEfMnxNfbbBefhZpkMtWgdrCEUAGYRwqs2Qp6hXeUhzZm7DpG5DLfz5liC/+T2
         ZXVRfR/OwFU4IVUHSp2yuZ9l45yamDndODiw3CH3aoqcp/rBcqfVxSd08LmhvVMi1Ck2
         Ixcj+MYVS8HD3DQkHPHbfBnDa3nM3n65pia/DOwaq4kLvVkmZzimxf1/RxAl5dgrTReL
         maP0LqWFxkKOz3yIymNT2rz58KrLELF8xVOQlzM6wVp7Atze+QHnhzzZ8yhTUNG6buVD
         qJbOuEaI0RNvsRbgGmxRntcecF6iX4AlsheidI4B2xmQZOq+1QQC3/KYc/0LFRwj6rUf
         UuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uJtMdwOZNkWuXVqDHUqsUES/sB/+FbaOGN+im7H9Kl0=;
        fh=9IwiXiL2r76U5Ltqhqw50/2U6erpEVpjMh7QrwY/DHI=;
        b=khPiOQZ7WRd6XNGnN9dw6snYnKNZ0c4e69oSFfhICehMkZhm1Q7Wqe0ihRZcXthHrc
         V9FrTP0ZjycfzeIDpVb8OPV5ReyXleZ99y3rmA5rjPDsrc1KKDR+ptmaos8lsqS1UENC
         CGrOofGrRlpvo/GXOZrL84fGVC/wIMHnKwkZKGq7BgU8V1Ta3TGvbu4KnGfoFE76SAvD
         PmBNM86vqOsadMsjvg5TlmbG2NxcXOyTxmfF4LKYG8d19QaLfeqoblib6waB/cHjVgpl
         mj7InNBCrHbaoo0Af0bsP2WEE14ebWI82xnBkkCjQeRFS70d0RB9eMTS4ZRfk3+KqvG9
         mgDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778757470; x=1779362270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJtMdwOZNkWuXVqDHUqsUES/sB/+FbaOGN+im7H9Kl0=;
        b=RcAWgA6wRQYAqE1UCOK3VuVdwSwEednkyqM/UZsysP2I6LsufS3GRN6v84bWL1V/3f
         aJU9SIGpu7bsNMd2xg7Eh2qS7KSVP8eXHRlLnnSFrchqJMFTuu0f6+rvOgSU6CxX6Tze
         b2/ZmsOdakvPsmEyFkJ3B0dsXPaAfs7JxHiMmJv7MSpk1J8p220s8ed0lFUpLiej3JX9
         5XriZ7UVgfY8K8Ks3g7BMgB3hY6/pO6e7qbuaIcvQ224RvsP2naJ7szfzRRz2W6MSM3V
         kNChFXJaErKgZXn6r0XN+74I1u49lbBBag2+nktrp3xFFKv7YA56v22sUfKW7Icf7J+C
         1P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778757470; x=1779362270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJtMdwOZNkWuXVqDHUqsUES/sB/+FbaOGN+im7H9Kl0=;
        b=AEhB5VhSER9VnE/V1y9JgJM+9Sc9w4eJ8Mk8LQyzf/CJrWAn0e3uIhr0K5WZRjsG/I
         x7ggzaPxjsd6hSO84jWSDxnjvP6dcLlrIeYdOASYoC8JieBYffEccAiEg/AzVNOosPTn
         JV7K8wwicx1Q2k5KKqT+6tgPosr9sFYG9lrHc/nvVo+w+YUsxLsgDcBs7yqVtTbrWzda
         GMlnz0rKepfcaFq0Rg9qMMx8Lpi5tMmjQADmOIJXjVWsQISMv7/WI71MafxCO6o2yjoi
         Xy4/z0HzCsgupZuZSAuFyoNwUPZA9c5l2q5mBcqo1A7trBqkOW4SJ96Cg4WHqhemtJIj
         fIbg==
X-Forwarded-Encrypted: i=1; AFNElJ+PuGQ1XIBQ8/UwecXx+TR9b6nd1qFwdeb/FzkcCtSWkYTSu3Cf7QzxUwk66uHznmrviqlxNLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Vo5Pq4mB88KhC123O+L8iYPWSnXm5gwev8QyW+LNH2QNxxBJ
	5F1+Nrc9DEUxV3/AxWM2NBEJnWBHZPRNT0K5F97s+PBmZp636UEPp00TtUVG/gBK1YzMBisgHfy
	QSvXzCNj9TZVe33RXAGp9RBfFI4o8dUs=
X-Gm-Gg: Acq92OGh9pPfhyGiutsNuhOeMPxOakEnLacGkztm39txNeslJ6SRsLt2lKVar2Rw/t/
	pjrhYdGBSIjlQp5DQf4y9GYpdyqkmGFN5ErQlinxPd++e2/zVAHJ6OxwcIluaqlQn14kyHJACvb
	Xdp/4kYYK7PSLg2AZJf1XVjUuAbpSTvUfFrgEVltjr8y4qy37jfpcMoPkF0F2c0bMGR87XKbGFt
	seG3wWokg6v2T3ii286GXv0jXD/SRx8fI//wUmoAoifnrxX349SnvHRrp3Th36BnFUrTPLqn3rB
	lm444hYp8gX3xX28AY4=
X-Received: by 2002:a05:690e:c4a:b0:654:63e0:d1d1 with SMTP id
 956f58d0204a3-65df82a7d19mr6292286d50.43.1778757469723; Thu, 14 May 2026
 04:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511121649.770529-1-lgs201920130244@gmail.com> <20260514071038.GM15586@unreal>
In-Reply-To: <20260514071038.GM15586@unreal>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 14 May 2026 19:17:29 +0800
X-Gm-Features: AVHnY4JZwr0lsyhUjT6srG-vycQEXslmk5fap4ghBJ1wB98TEW20sTg_JPYIC8I
Message-ID: <CANUHTR_00aG8Lf=cm=KKKK=jvHDiDoEjhEt88-JYByD+iQGLrw@mail.gmail.com>
Subject: Re: [PATCH v5] IB/mlx4: Fix refcount leak in add_port() error path
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Roland Dreier <roland@purestorage.com>, Jack Morgenstein <jackm@dev.mellanox.co.il>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 783A7540E99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247168-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Leon,

Thanks for reviewing.

On Thu, 14 May 2026 at 15:10, Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 11, 2026 at 08:16:49PM +0800, Guangshuo Li wrote:
> > After kobject_init_and_add(), the lifetime of the embedded struct
> > kobject is expected to be managed through the kobject core reference
> > counting.
> >
> > In add_port(), several failure paths after kobject_init_and_add() free
> > struct mlx4_port directly instead of releasing the embedded kobject with
> > kobject_put(). This leaves the kobject reference count unbalanced and can
> > lead to incorrect lifetime handling.
> >
> > Fix this by routing the kobject_init_and_add() failure path through
> > kobject_put(), and by calling kobject_del() before kobject_put() on
> > later failure paths after the kobject has been successfully added. Since
> > the release callback may now be called for partially initialized
> > mlx4_port objects, make mlx4_port_release() tolerate NULL attribute
> > arrays.
> >
> > The duplicated attribute array frees in add_port() are removed, as the
> > release callback now handles them.
> >
> > Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
> > Cc: stable@vger.kernel.org
>
> This line is not needed.
>
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v5:
> >   - split the add_port() error paths after kobject_init_and_add()
> >   - call kobject_del() before kobject_put() for failures after
> >     kobject_init_and_add() succeeds
> >
> > v4:
> >   - route all add_port() failures after kobject_init_and_add() through
> >     a single kobject_put() based error path
> >   - remove duplicated attribute array frees from add_port()
> >   - keep mlx4_port_release() tolerant of partially initialized objects
> >
> > v3:
> >   - make mlx4_port_release() tolerate NULL attribute arrays
> >   - drop the parent kobject reference on the kobject_init_and_add()
> >     failure path before putting the embedded kobject
> >
> > v2:
> >   - note that the issue was identified by my static analysis tool
> >   - and confirmed by manual review
> >
> >  drivers/infiniband/hw/mlx4/sysfs.c | 44 ++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
> > index b8fa4ecfc961..224a6a1c289d 100644
> > --- a/drivers/infiniband/hw/mlx4/sysfs.c
> > +++ b/drivers/infiniband/hw/mlx4/sysfs.c
> > @@ -380,12 +380,17 @@ static void mlx4_port_release(struct kobject *kobj)
> >       struct attribute *a;
> >       int i;
> >
> > -     for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
> > -             kfree(a);
> > -     kfree(p->pkey_group.attrs);
> > -     for (i = 0; (a = p->gid_group.attrs[i]); ++i)
> > -             kfree(a);
> > -     kfree(p->gid_group.attrs);
> > +     if (p->pkey_group.attrs) {
> > +             for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
> > +                     kfree(a);
> > +             kfree(p->pkey_group.attrs);
> > +     }
> > +
> > +     if (p->gid_group.attrs) {
> > +             for (i = 0; (a = p->gid_group.attrs[i]); ++i)
> > +                     kfree(a);
> > +             kfree(p->gid_group.attrs);
> > +     }
>
> You should reorder the add_port() function to make sure that
> kobject_init_and_add() is called after alloc_group_attrs().
>
> Thanks
>
> >       kfree(p);
> >  }
> >
> > @@ -623,7 +628,6 @@ static void remove_vf_smi_entries(struct mlx4_port *p)
> >  static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
> >  {
> >       struct mlx4_port *p;
> > -     int i;
> >       int ret;
> >       int is_eth = rdma_port_get_link_layer(&dev->ib_dev, port_num) ==
> >                       IB_LINK_LAYER_ETHERNET;
> > @@ -640,7 +644,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
> >                                  kobject_get(dev->dev_ports_parent[slave]),
> >                                  "%d", port_num);
> >       if (ret)
> > -             goto err_alloc;
> > +             goto err_put;
> >
> >       p->pkey_group.name  = "pkey_idx";
> >       p->pkey_group.attrs =
> > @@ -649,43 +653,37 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
> >                                 dev->dev->caps.pkey_table_len[port_num]);
> >       if (!p->pkey_group.attrs) {
> >               ret = -ENOMEM;
> > -             goto err_alloc;
> > +             goto err_del;
> >       }
> >
> >       ret = sysfs_create_group(&p->kobj, &p->pkey_group);
> >       if (ret)
> > -             goto err_free_pkey;
> > +             goto err_del;
> >
> >       p->gid_group.name  = "gid_idx";
> >       p->gid_group.attrs = alloc_group_attrs(show_port_gid_idx, NULL, 1);
> >       if (!p->gid_group.attrs) {
> >               ret = -ENOMEM;
> > -             goto err_free_pkey;
> > +             goto err_del;
> >       }
> >
> >       ret = sysfs_create_group(&p->kobj, &p->gid_group);
> >       if (ret)
> > -             goto err_free_gid;
> > +             goto err_del;
> >
> >       ret = add_vf_smi_entries(p);
> >       if (ret)
> > -             goto err_free_gid;
> > +             goto err_del;
> >
> >       list_add_tail(&p->kobj.entry, &dev->pkeys.pkey_port_list[slave]);
> >       return 0;
> >
> > -err_free_gid:
> > -     kfree(p->gid_group.attrs[0]);
> > -     kfree(p->gid_group.attrs);
> > -
> > -err_free_pkey:
> > -     for (i = 0; i < dev->dev->caps.pkey_table_len[port_num]; ++i)
> > -             kfree(p->pkey_group.attrs[i]);
> > -     kfree(p->pkey_group.attrs);
> > +err_del:
> > +     kobject_del(&p->kobj);
> >
> > -err_alloc:
> > +err_put:
> >       kobject_put(dev->dev_ports_parent[slave]);
> > -     kfree(p);
> > +     kobject_put(&p->kobj);
> >       return ret;
> >  }
> >
> > --
> > 2.43.0
> >

I have sent the v6 version according to your suggestion.

Best regards,
Guangshuo

