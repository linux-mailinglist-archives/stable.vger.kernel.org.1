Return-Path: <stable+bounces-274041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DJ2EIwt6VWoKpAAAu9opvQ
	(envelope-from <stable+bounces-274041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:51:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA774FC8B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:51:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mht7bI41;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274041-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274041-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2686C304C7D2
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2F37A839;
	Mon, 13 Jul 2026 23:51:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19F35BDD5
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:51:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986695; cv=pass; b=aDH7u1TECr9I9pS3xdzsxv8puk6OVzaxXGH8a9BsTfbDTiE7Y1WZPIgE89SO3+EUXIu2CwZCmMfveMnQE714sjnyQV4GuBWpeBT3mtcytzvvcKP7PI+SmAuiI+4XI/ETxfbzoWahTHeEprhCg+8WCOKcdkJHy4psQTgbSPbX0Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986695; c=relaxed/simple;
	bh=QIDOrEJ4WepeZV45FGMnOxOTF8vP+LfpfgppYUTtmao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qttzvaldVgiqZZIOJml9Sulm+y8u2HJeKNhsED8tjlpJ0NgRsnBTpk9vxwca0Gqw285P9vSkTs5c0UeIYfoMYfdTt5ynaP6h5tJVegHznw5A6ni6VBCgFC7M6qZzVkbmjLvX9JD53RnRNBNxdA+9l1e7PwL1HhDrWLFv6LhT7/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mht7bI41; arc=pass smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so224349f8f.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 16:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783986692; cv=none;
        d=google.com; s=arc-20260327;
        b=JDdm0bazQDiJVbfqeIVkUQsqhpwKU6JWuJKvYgpbhWSupEefEqcmXGZpBnYNkfjUgd
         vODpcB3BBkGmnJ/sSC09O/ZQkWKHAGCTW/01H+pe3dfPPUBwlTbQ7EF6Q3XgjuNwjyg9
         lMB9rk2hHJ4OYnOhz7vIJLmY3jsV71Di7mbxtlF5Y9vpNdp5n210s3h82y4Y6YrWGrtZ
         Zl0PJlfZN6rj1TJs7hFEh68BYF+nVwZasUL3AYsIwxyOCvsg0qusEIkAd1DBJx04wygI
         c6zw9M5q3AVGm9LneW1q3bOfth/y/+NLrHzL+WXyjf4WuPLfypWm/Y9kc7HodUl8WJmY
         GUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QIDOrEJ4WepeZV45FGMnOxOTF8vP+LfpfgppYUTtmao=;
        fh=77hCFwZLerCm8FC0sL2ZhHz+t2ehQprqEKzKaXAwAXY=;
        b=iE8lKTUzi1S9LRAJvbVtKEIf7XcQ7EQZHVkijP4qZiOjkHFK/hywk6/sKm3mUc0K6J
         mO/yc7gzXXXri9nJu+AJ544RcBjKbPpgQpthSy3RqDx3bJ12R36j6DvYvc4RauaMQ3Xp
         ci7Twjbfamcdow+Piu0sVY1MIjgyUPzDGoc09kAqP8ZASmXdSZ0HciQ66mfBkFK4XZgF
         iL+xGAVqWFR3nLS5LFgDPE+agpeeOmOijdPf+TbqOiRwWYfP+e5o8P7DJfkGWbuj0Q0z
         VDQwV7tI6BZPtBORIPwzPZX3QxDs7GmJ1MqXLWYXr7lEKXNrYSAvses9SaDlq25Pm4kD
         kFZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783986692; x=1784591492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QIDOrEJ4WepeZV45FGMnOxOTF8vP+LfpfgppYUTtmao=;
        b=mht7bI41J2efeG6Hg8kAYY6/PrUDXCJQqXkRqCzmjP980VegFf4i0jvfOJZ1dcXcZP
         X0k+n0J+vo1AuZOWUzAfgtxDbU2xjkAl9V5OZOj+m0Yz/vRZS2H8sU5cId0ZfPCycOiS
         fiNXVNyA3m+TPYvxIPd/+9tvAj6P1VIxENYVamBDnmvvzJo6c1ou3Mv9QlmrMA1aLQDU
         ZmWqCcaEUsJDAv/+XkweChmjq8vPweBsj93ADO3iYKeaRZrZKKeL5EPSC15X4DGdih1T
         JSdGWl9Tx8uK2ft1pQtv2h3fYlhSZwo+6DZxDoqykf/awFimBTF+/pOL1E9hp0W3VytR
         uC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783986692; x=1784591492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIDOrEJ4WepeZV45FGMnOxOTF8vP+LfpfgppYUTtmao=;
        b=KiY6ttZyCGHHVdXu+T396dcRy8KQlb4gt4pics47+Kdiv9A1T9T37nLR4GaxGphQFM
         eQApWKhuA1q7WdimZfXSFv22go8wdtWKMYWqtohdUxMlSFOHp9HLjrGLBVIpF79YIW3M
         4JI3UYi9P+pohuSVm4kjdPfS/NtBPY2yfiaLSwVF3+BlkM4AMkImiRGGaTWuLpDrFJzt
         arjdzRA0FRDjGEmY6Y9szwzuv2rEn9mbNpRtEdaNALiUtqDI7Coi3sYkMO0hU/jNzdMV
         46VcPVHEzMch1Kc3t/N4LCsBBgZQqCVZo+wnOLehxPi28sf4xHfyqEIaDaNvdNmVODJn
         jHXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4fTcnOn9MuxDEptcduvzdpFPQuCCK9rzeucydMrFiP3sdb/UiCzhJ4EYc/kIXeiQqOfcfIpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwianAMYn6a6fEA+WgZhpRHS6aQ/oFhZYhU4mv4x5fWU6DSMgHO
	o34FdTNgdoZxCmrUq/0Rhl29IDuaIDPwBfOcE5Qz3J958p+5iENY0Xw+3YAg0BQP8ZLY6ZCi12b
	SBHf+/Tb/4OsUVTbfPJ0Vd66SRllj2/k=
X-Gm-Gg: AfdE7ckJooJYYLBa4GoKAY3j4KDNbhu0haXA4h3/Ue1skl3eoQKoDKJACfNh5E+XEYU
	jNRGA18AlKFXmvxgK78TvPfsTOgb2eu87K+rb2dfsQnly31WcPnV2nJ/bOhU19Sz95CamgodQEj
	91fGXd5eKXR//VSPfwCLgxIvW4bNL0+3rDVte7kNACG9nvOzZXK/J8hfuMcd2pQGCAZD/v4XHKD
	DYx79Rd4sItToFYMQenezz6dpmzWKu3IFs8j9b8LfIyU1JVOiEIuXyRFqgVB71boUAR+C2AygML
	9iSxEVI5vQygUz2USsFq9Y8lP7sppNe96ZLcjCGMdvMN2iRUC2EGndkT9daeabQspbkIzw==
X-Received: by 2002:a5d:5c89:0:b0:476:cfa0:a976 with SMTP id
 ffacd0b85a97d-47f2dcb60fcmr13603037f8f.5.1783986692301; Mon, 13 Jul 2026
 16:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713175345.2542331-1-joannelkoong@gmail.com> <CAJnrk1b9jjvP6a9PaYAiA0HZcJ0_dR_O2aGWPF44T2NNBJC94w@mail.gmail.com>
In-Reply-To: <CAJnrk1b9jjvP6a9PaYAiA0HZcJ0_dR_O2aGWPF44T2NNBJC94w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Jul 2026 16:51:20 -0700
X-Gm-Features: AUfX_my6FijZPNDEgqBOq4yrwgYzrjba6PmZziF1Sz1HBvGPPiRPm2XXMZ3jWL8
Message-ID: <CAJnrk1Zo_j_QY9Q=jft5=fio9mU36uy5LXP3bC4=xO8DbakzrA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse: fix missing barriers in io-uring init
To: miklos@szeredi.hu, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274041-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:bernd@bsbernd.com,m:fuse-devel@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDFA774FC8B

On Mon, Jul 13, 2026 at 3:11=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Jul 13, 2026 at 10:54=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > These are two pre-existing issues Sashiko reported [1] on the fuse zero=
copy
> > series.
> >
> > [1] https://sashiko.dev/#/patchset/20260630211436.2062816-1-joannelkoon=
g%40gmail.com
>
> Sashiko noted some other places that are also missing barriers [1].
> Will send v2 to add these places as well.

These additional ones aren't real bugs. They're not reachable on a
well-behaved server and on a malicious/buggy server, the failure is
benign / self-correcting.

I think we need some sort of way to help Sashiko understand so it
doesn't keep flagging this on every future patch anyone submits. I
think there's a few other places where some of Sashiko's
assumptions/analysis are wrong (eg uring-cmd sqe stability semantics
[1] in the zero-copy series). I'll look into this unless anyone
already knows how to do this.

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/CAJnrk1Y2tiwCecH-HVyaP79kcmBoEYu--mm=
wRKzp=3D9uZNaiSUA@mail.gmail.com/

>
> [1] https://sashiko.dev/#/patchset/20260713175345.2542331-1-joannelkoong%=
40gmail.com

