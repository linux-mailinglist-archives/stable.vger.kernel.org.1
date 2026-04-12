Return-Path: <stable+bounces-235835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNizEfXa22mlHgkAu9opvQ
	(envelope-from <stable+bounces-235835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:48:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B33E5372
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE50300F5D7
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88381359A90;
	Sun, 12 Apr 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4sQV6Yl"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A42C325C
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016103; cv=pass; b=jnBsrXGxT+eEFJOADcxiIaqyzQi556vE11jIgNoI1d0fGFPU7AtqXfPtIXvOSfC39inc5la9lfmGQeTX5ctRUqJjJ7QmNTItkXjYLCgkUr/lMYpXC0Va9Trrub0ao2wktwqTXWNmzkRj/ojPmmwwmOgx1OkEr7ToXng9QcIpEHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016103; c=relaxed/simple;
	bh=1U9YXGvaFLWp/pMA/TbhPIX0/XY0ub2iN4cWCFnziwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSazvYxG6DCqHrkJuQgXd4gGfCdGoLzPU8qtz5btF2pjj9SYCTE85dv08vOnT89Vk/xxnt79Mt+XQBoNVEvSstUkFtBfTVwT9kiQWcEfOWBzO2UTcLZ5hbIsbF3RLBXyG3FL1RvBaCA5oeV8wyg98bzUuG+iqIZT5QF8QeRBPUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4sQV6Yl; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-650775f427eso3472006d50.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 10:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776016101; cv=none;
        d=google.com; s=arc-20240605;
        b=fDpgixZpcnhVqnfOcwIF3GAC98mQNdExuhA3Je/CyRLv3KMQ+A2p/OO2i0K77kdzyZ
         CeE6Ntu6TpUGJ1u31fbb4KlKu7PIHn6nRWMl4JxlcoPFtXBxp+d237zzD2R8J+aEZbBv
         TTnpxc15bd4Btrvn2FEXhWZJkHKV4+uHtIi4iHMFpRUzMXkxpWt9aVb0ARbjubaGP8bZ
         rTAglObf7+aSagkr9IBn4a+gh8d+ZyIcogISbIfD081W+vqY0zDj2zc7oMVeI7384pRd
         0HZ+3VBQRXG0NlxEIRgHP9YeTQxrK+qKMJyoW4bPctu7SbFO6NlkmP2u38n17zv2XvjQ
         49Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rm8zl5J35CpU3jnFsSRYIzi1x6YziVzsrJSoZV0+Zq4=;
        fh=eTuxFz2wnl6wW5SMgj1x5upZ6bMkOCr2S+deqo4pYq0=;
        b=i3DCZUAAI6QH85NNk3GNcmGSWyyG8ziagiGXNGKs6ad2RTdiKvXKBRp6sx7g9FEA2y
         KufDeHfMRm8Zo01hK4Bh77PWacZ8ZwFENad8JLvdYws+WmAb9DJpQZ4q/p9hPA7O566S
         fquuUHMNJfT+amgxeLMILS6Tcb2i/0rBOoS1XNJwYXcm0lDmtpNfcAMcSKh+jE7VfDTS
         hg/vR6Lhd+dTCmMZncTRxsuct4H4r0rbQlmLd667+tMgT4JqBmN+V8HPNyg26zwg6scu
         HY9cxdNChTSOihxiu7j1JoGxIWUkSUaEHorcRjGbgESiZSBxgpg6kopK1oDzvj3RtP0T
         dVKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776016101; x=1776620901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm8zl5J35CpU3jnFsSRYIzi1x6YziVzsrJSoZV0+Zq4=;
        b=S4sQV6YlaxIod1IIDgEGaeQ6gMKS8hzfFu0febT5co6KjzZD2Ru5P1veXndQmIAaMb
         PpwB4RkesuEw9xfPAveLsLPT9h5h5tI95a0Nfq+iH7Tf+bABNj0eZtHzWVpAKMPMfQkE
         unHaAxxTAcNZa0jX1h+PKugpMbvVIoKWErCPvd7T0BKXDqI4rkAAfDbe1TowYHL/OXNR
         NPvbe6bORiaWgdruue4ogndGBrkqqAM1LEcCjARqfmSh4PrjGAJlMSyDWNf+Y8NUR6lO
         4wxm+BZjimEMOlQROX6JPqW5s2ICrCmibuNBK/xB1wLuCsOtZVFPQdm8J7Uh14xrovl3
         SuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776016101; x=1776620901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rm8zl5J35CpU3jnFsSRYIzi1x6YziVzsrJSoZV0+Zq4=;
        b=QvN6GuT4NbV2EPOrozBTQV5dBD7VQVftWHVcU5v8Phq/s6hYzQ6rPa8C7+uon9+t+Y
         n2fuQTy5wvb798GAidYC+BFzMh4FZq/v6FRj8Q+ankLLNc1oEWwjc/OSh+oxRu0HXWaN
         9/+jlEiOEvpQXDLOp+M1QG4ZXySN/MWamD4J1EIT8L+9s+IjcJJGR5zhPd76tPtuW3EN
         j99fID0FFm+XdwzhV8uNXyuzYo4fmRW5+uw76gSbYPtjVfmXHa+18fN/0g2rQRjxk+vW
         sLZBK5nQEgxZGeRqSDGr/MeLithcqZsPo8FGB6xO4m588VxOAQMteyl0fBps/Dbf5qGk
         2GCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+av6DucOKMkdYIpsbB8aRDv1EAnDn1mCQmSDt4njz3o8V/Wmbzcr+yiPteSiNzABx7xxwnmkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCnPF6ixxaC/TUC0Y+rrcFU503hXOpTqaB3bVPlXulsfQcj2c
	Lh1kPsOkcA72sEx9jutv064nn5ePDTK2i5JUEmr7umH5UEy9VQRv7bIjuciCCou3V8d58ij+Nu/
	GySZEa5X+zuMrU95EEg4FYiZ46vqTf0k=
X-Gm-Gg: AeBDietO2ol7MVEUN+GqATn8XAECv+jLODsGWWbl30k3voUMR7ojrfnEa2+5tFdI9Nu
	XZeU3zEiAMsCP3XR1H3LRSqHWFEAyB7GaDKH8utsVf17oRKKkboVqUY00Vn7ojrmlJ05ijqfdzx
	R+sgQHu4pzh4qkbTbRQ66wykLmGifPdJhjFJxSlz/9QLdVJ2kOGBhoeyQuR2tE+rQgXJ/5h3YCX
	2tFcITJrgHuo3+ftJr9IKhHsWh9zJTaVVoIWgzH1ZnYp7cagU6p/tboaO8aXp7wyr50EmQKWJV5
	KEaFxIHW
X-Received: by 2002:a05:690e:4841:b0:649:e6de:8f4a with SMTP id
 956f58d0204a3-65198b72cdemr7352447d50.42.1776016101031; Sun, 12 Apr 2026
 10:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411062152.2092967-1-lgs201920130244@gmail.com>
 <20260411142858.85496-1-lance.yang@linux.dev> <848180C7-F98C-44B2-AB1F-579BF9EEA28E@nvidia.com>
 <3e688ea1-05ba-4e75-9d92-2751ff6f3b7b@linux.dev> <75F536FE-6710-4AE7-B6DB-2997D846237E@nvidia.com>
In-Reply-To: <75F536FE-6710-4AE7-B6DB-2997D846237E@nvidia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 01:48:11 +0800
X-Gm-Features: AQROBzCTa9E1N3xrHdXc-IGVPR5wSvNpHV_7nILnImYBrIIchwBXudfJpaQLPfQ
Message-ID: <CANUHTR_F3gZpzV0YHmJw_6yBwgG5a6-M2aaNNjmLq5Q9cZ-0KQ@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
To: Zi Yan <ziy@nvidia.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, david@kernel.org, 
	lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235835-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A03B33E5372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Lance, Zi,

Thanks for the review and for pointing this out.

You are right =E2=80=94 that was my mistake in the changelog wording. After
rechecking the failure path more carefully, I do not think a
use-after-free can actually happen here. The real issue is that the
error path skips the proper kobject cleanup flow, so the problem is
better described as an unbalanced kobject reference / refcount
handling issue rather than a potential UAF.

I will update the commit message accordingly and send a v2 shortly.

Thanks,
Guangshuo

Zi Yan <ziy@nvidia.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8812=E6=97=A5=E5=91=
=A8=E6=97=A5 21:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11 Apr 2026, at 23:24, Lance Yang wrote:
>
> > On 2026/4/12 09:49, Zi Yan wrote:
> >> On 11 Apr 2026, at 10:28, Lance Yang wrote:
> >>
> >>> On Sat, Apr 11, 2026 at 02:21:52PM +0800, Guangshuo Li wrote:
> >>>> After kobject_init_and_add(), the lifetime of the embedded struct
> >>>> kobject is expected to be managed through the kobject core reference
> >>>> counting.
> >>>>
> >>>> In thpsize_create(), if kobject_init_and_add() fails, thpsize is fre=
ed
> >>>> directly with kfree() rather than releasing the kobject reference wi=
th
> >>>> kobject_put(). This may leave the reference count of the embedded st=
ruct
> >>>
> >>> Right. As documented for kobject_init_and_add(), once it has been
> >>> called, the error path should go through kobject_put():
> >>>
> >>> /**
> >>>   * kobject_init_and_add() - Initialize a kobject structure and add i=
t to
> >>>   *                          the kobject hierarchy.
> >>> ...
> >>>   *
> >>>   * This function combines the call to kobject_init() and kobject_add=
().
> >>>   *
> >>>   * If this function returns an error, kobject_put() must be called t=
o
> >>>   * properly clean up the memory associated with the object.  This is=
 the
> >>> ...
> >>>   */
> >>> int kobject_init_and_add(struct kobject *kobj, const struct kobj_type=
 *ktype,
> >>>                      struct kobject *parent, const char *fmt, ...)
> >>>
> >>>> kobject unbalanced, resulting in a refcount leak and potentially lea=
ding
> >>>> to a use-after-free.
> >>>
> >>> IIUC, this looks more like wrong kobject lifetime handling and likely=
 a
> >>> leak, not a clear UAF :)
> >>
> >> kobject_put() ends up with calling kobj_type->release(), which is just
> >> kfree(to_thpsize(kobj)), equivalent to kfree(thpsize) in the old code.
> >> IIUC, there is no leak. Let me know if I miss anything.
> >
> > Right, the fix is correct. I was only commenting on the changelog
> > wording, especially:
> >
> > "resulting in a refcount leak and potentially leading to a use-after-fr=
ee"
> >
> > The old code does skip the required kobject cleanup path, but is
> > a UAF actually possible there?
>
> That is my question too. The original code might not cause any real issue=
.
>
> Guangshuo, let us know if we get it wrong. Thanks.
>
> >
> > Just a wording nit.
>
>
> --
> Best Regards,
> Yan, Zi

