Return-Path: <stable+bounces-236104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFplNqL73Gk3YwkAu9opvQ
	(envelope-from <stable+bounces-236104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5443ED3D4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A65E6302D08E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BB3D8137;
	Mon, 13 Apr 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdbpBmuT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ksnUPMCW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264463D902A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089726; cv=pass; b=kPCIOkuxNMYx4tKWW6pLUKgSeQjc9AAGrF+Cp4M0YwOGMoMdUlEaRdRN4gC+v90Gw8C/BT2NZeBeMDo1AEpHAfpnDlInqBY+jBGsEep+oBCL7ZciJrNjEX5uC3SKw5sS13bs014BChk1sx0GP7ywMtosg/vpYsfDi3bdPn/w9q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089726; c=relaxed/simple;
	bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEL46BlMQ9aI//jngHE/sKopn/oIwv0wt4syAWMa+NP0+1NtEUp5dIFKa//qbbI7AKDKeuY5tWcHLLSMHJzaICh/6eSgj7nMqs047wswBOkVsstfgut+eU0PtL0TX8FxOc4itVuPIozt9bexNwl7CN57mFqgJ5EV8+qUErA1Ec8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdbpBmuT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ksnUPMCW; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776089724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
	b=SdbpBmuTCq0/fg623E3on6bIBbT/YtUljGlxspI7lCL53uWp62P6gbvn52MHzcHAy7fg/E
	XaCfuNgQUdrJn3Qn86MIZRNbdOMZqDkuuWhrmjFw9aV3c1UeNSlYhV42sZ1zhsD33Y0rFk
	7XJyvv8c0AiRytjOzmNxwMi4lhfdX+E=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-V0jCr-JHOja3JmwFtMC5Wg-1; Mon, 13 Apr 2026 10:15:20 -0400
X-MC-Unique: V0jCr-JHOja3JmwFtMC5Wg-1
X-Mimecast-MFC-AGG-ID: V0jCr-JHOja3JmwFtMC5Wg_1776089720
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64eb0bff77cso6568716d50.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089720; cv=none;
        d=google.com; s=arc-20240605;
        b=V6TTSq1tq8dw4MoGlBEDtGyD4TAwX94JIm773n1h6i7EikeSI0rl0GxDCx69UMSZSc
         wt7dstDk5aFKC/mobpdByPdhO6v313FD2ZHDYx9eNPgIdmMnNp+DJhTS/p94KI3elReq
         SaQupIsICRFBF+ObSiOW8w7UL/vb4QhaxrruqeL8K1OdbsD4bpqZsgZ1UFISYCx1+Xza
         xfdGDg24hyqDpsscHe5ikDWVvPgReLuQqVJqDw2zxcvHlat/i6pQ9bjyqPT2whHs8C1D
         2mCkJgjvGwgXLMF852nvuAyCHFhE6JAo2QnlYMr/1u1sueQZT45QWmM9ePUfeU00cY0a
         dNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
        fh=3mE94SZytU6XW0+7J3I192Pr6SmF3lNBUOLknKeMNRI=;
        b=OfaLAjm0n6zX6MwPITwwhk1jR47HTmXrg8v/IRZ5NMphC5MaNYnxLV74PGhUOeo1TL
         1a5gfknit8NPMgCI9DhzO/UAjsttzgJn1hMPH3Ji1sZe1elQ7heK53oo+Y0KKrq1dGCq
         l/OWgMQodMRlKrbk7GYICb4sRZNFtet0/uBiS7+Toa47O87jLNAB6QddC8f3P3XBqWNH
         mG4+YRaTHfVqDPLzGLuUEbYyKaiZh5UX56mdviC7Bh4mpSz3JtXlFIVJ+D7rb+/QX0mV
         B9iXTXvbr7t9vuhgQlD6RpG0d16MQJL2RjMaiVG5U1xw8vFSkdbPpFxGISq824Tbo5WL
         stag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776089720; x=1776694520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
        b=ksnUPMCWC/oTcpqF/VES0C8rMX2876vo1KW5D+bKwcrTiaFv7gpz/d15E2kFtMFaod
         esjNZzygJUyGEqc+fqV8SVRbOiurNuNFLiqmsHbr1RHfhI6Tbb+12IiNO0xAROFXX3Uw
         9mWo+udOJnLLEC/cNKVZj6cjjexuVPEy2fD7tlEDw4Kazukd2qf0tOu76t+DZ6WTHv2h
         9DMyDfsikPtrQXmYhDi71i/ymebdw2xHJzyS6nfqXVTzAgylNkMD9b/Pe4yMtVRmXaNR
         ZKq4MvknqB6BFnkhOGmr3oT+1RtwHmvGm+Y5tBs+m0XMG1XKSNtijeFRRMIYF6RRYIIO
         SWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089720; x=1776694520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
        b=kODsXHIRkQr4DuYQuCYIUqIuCmETVQ5gyl8tnBQt8HFcfVI/5YEFuSj31ojx+LX+F5
         NFgObh7+TDEe0BDTF1xwwS+5lsKDphuqT3tqOvIlUZ6lWJBWBqDLy5ElZ1j01nhUGXYS
         4Rj43q/NPdpECZdCy8Z5Y7+CMJekWflwLLpIfJkHJGJHGyjHPcO1qIknX86hc/FhTsx5
         qvcHM4N0N+YNu97vRrjKxv+5L4hWWSMOXzad9IYrPxI5pjyNWVobMpSk0aJ8JGdarH02
         QXn8B4JCo7Fg904cR++ej2YQVKvr3bf+x8rixYlofmUptb9St9U3bB/OoQB1DosLRsC2
         Fg7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8JvvGOkOKHjcQBLWTQBBqqML4FFIWPfv6dDLoyE1gbFwb2ofLi5xMpQRuRv8MUqanEewQdEu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGFYDytMT5mbnVWDCBDxoBF9nWHyGLy+rpRwvz17MNlqPwkfE
	FRtpeYNhWvtqBooAS35O4QE6ngIa+1aG0RmQg845vC05a0P2Hubqu3fPLs86WSDy8RQBChN6hXU
	Z1s38hI09olmMwKdI84MbOW9hLSYNymT4E7SHodVXWodT2ODWo42obZopoKOVdGnPAeMfgGfbUV
	0lZ1nfGe/g7+W/HZTWjoFW8aAVjCoueI5A
X-Gm-Gg: AeBDietT8aFeU18dMYpMieHx3ugsfowBZ/4myO7Jqu6xHQn86T/htF6PaTztgyds9YO
	TbQVh4ycdkFN8W2WXKF2kO16ziQZ6GZMFiu/d6BQ17SzvjqFZi5Sl7Ct2v4jsf35klsP2sbGiXc
	l9LwHmKRYyXXdX9HgehUWm2d91HB0F/sQlLrPk2125gpiVZpRO+KJGYXgFh3Z8RA3VCb5FHW5TT
	30=
X-Received: by 2002:a53:b166:0:b0:650:3e1f:907c with SMTP id 956f58d0204a3-6519885e270mr9949162d50.0.1776089719944;
        Mon, 13 Apr 2026 07:15:19 -0700 (PDT)
X-Received: by 2002:a53:b166:0:b0:650:3e1f:907c with SMTP id
 956f58d0204a3-6519885e270mr9949127d50.0.1776089719401; Mon, 13 Apr 2026
 07:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413101759.6323fb68@pumpkin> <20260413122244.534-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20260413122244.534-1-guojinhui.liam@bytedance.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 13 Apr 2026 16:14:42 +0200
X-Gm-Features: AQROBzD19qyh6NwsklNvT55RYRHBsoRhmI6anJ3YQzudDoo1ImWO2NiQf2WiVIc
Message-ID: <CAJaqyWeb3BuW-kK_+P=BK5darshhKn4fHuTJuRY+rvoX_4QUeA@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: David Laight <david.laight.linux@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,resnulli.us,linux.alibaba.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236104-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eperezma@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,bytedance.com:email]
X-Rspamd-Queue-Id: 6D5443ED3D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 2:23=E2=80=AFPM Jinhui Guo <guojinhui.liam@bytedanc=
e.com> wrote:
>
> On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> > Or do the allocate before acquiring the lock (and free it not used
> > in the error path).
>
> Hi David,
>
> Thanks for the suggestion.
>
> Pre-allocating the memory outside the lock is indeed a good practice,
> but unfortunately it doesn't work in this specific virtqueue context.
>
> The kmalloc() in question is not happening at the virtqueue_exec_admin_cm=
d()
> level. Instead, it is deeply embedded inside virtqueue_add_sgs()
> (specifically, in functions like alloc_indirect_split() or
> virtqueue_add_indirect_packed()) to allocate indirect descriptors when
> multiple SG elements are provided.
>
> As a caller, we have no mechanism to pre-allocate this indirect descripto=
r
> memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_ad=
d_sgs()
> needs to atomically check the queue's num_free status, allocate the indir=
ect
> table if necessary, and update the queue pointers. All these operations
> must be protected by admin_vq->lock to prevent concurrent admin command
> submissions from corrupting the virtqueue state.
>

Sounds like a big chunk of that is achieved with virtqueue_map_* and
virtqueue_add_{in,out}buf_premapped functions, isn't it? Or am I
missing something?

> Therefore, allocating before acquiring the lock isn't feasible here, and
> replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
> failure) seems to be the more viable fix.
>
> Does this make sense?
>
> Thanks,
> Jinhui
>


