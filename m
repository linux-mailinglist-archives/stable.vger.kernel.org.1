Return-Path: <stable+bounces-98747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55249E4EFE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F7F283706
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F21C1F20;
	Thu,  5 Dec 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gx5jrvcw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8901BD9F6
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385295; cv=none; b=Pl0MbgaGcOovB9lEtBONQGKu9qBlPVkZoLlVkXLUz3WOF8Fd4CyrpkyGj/xDi1W2Ws8G0adVOd0YflBra6DXwxhMpBl02Hz4cALfxjnm/uxMGSM3QCTrso0GZ05HdTNnXfBVs35z71VtM86vhjZSFVKH0dzOmxFGVk3CcJ+OwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385295; c=relaxed/simple;
	bh=vx5+qBh850FNYmcGamqyfPmnZAHBfCD8QuI0kcDQPpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I01sMfZuJv0ZJZifWdZ1LLVriRrtmOUslzwFB0ZKcG6Lu+MdaEbvvngifZEBZ+ZZLhuqTF4cjYxY5Sva2Q/jI7wA2MWsOf6r0WFwbiarb7+MswbPY64BKXQF3IOcXBfb/NjQJr1p0Ymngedkaumgg/783Wkv6yMA/L4uGZwmo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gx5jrvcw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa629402b53so48340466b.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733385292; x=1733990092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoveC5NiFJebUr6H/XvuyS4HCl5gaDQMYyE2e5JSYo=;
        b=gx5jrvcwJH+rruOI62eLrlf2k7FMmh3eiIA5/Ws5U6OXXkWGgEslWHHogq3MKzb0CP
         hOcC2Mq4D0FOuw2CJKaIg3CwedpLs/rk09Kq3AW5CLwTIL5EoYg7SP+2Wmr55tidKToM
         717Hoiye2CNNzDf5c1Tagf3XCxB+Gvt7B2CRqaMzKN91fgQJNnMS4cXZmnghsgqG8+MA
         q6/mdb5HoGljY61rmp/qiDYEfxA3m9/KJ9YNWEEpFj9jG6RS+mnkFPCXwEOHuPj/xz5H
         PIU+L5ZQqsuMnGJ/ALiGYlNLncXtfquv6EHghSdgYLthNZmkRDH2eZN5+gOOPhVo8NYE
         v0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733385292; x=1733990092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPoveC5NiFJebUr6H/XvuyS4HCl5gaDQMYyE2e5JSYo=;
        b=KeDnORorLVBgCJnoyzNIsDX985vw+i0fz2KZcphanKZ0BxyKHTGlRuLmePMMW255C4
         p4bA+oI5nzU3cz4kfAiRDXOLA99iL0nh3OmkWSCARfs7ZJ7W0XaV6IqiLj6I1KW3uIuW
         g4JeFSnbREL7HPNON3F/e6Pou72lSsSUhv3De0Ecu5zlPZM9QWOagLQDfGc9jviXtuqN
         gshnRQIeU+lE74WBafE30Axl5MqsuSZNVcBTS+IhvNzhLOkiMSwbqhTZibs50MS3q4e1
         Bt4Am4AXB8OxbHHstD17aAqZPeT4XKOkkQUfjD0+8wltw3WmXuRFkncUkXgVfIDK4gm2
         nIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1sThXQdU7N4Y6jIQUSNYOvTAllrAjDZMncWZHCnDOwE57l1OVwaVi9SAn5LNJcJWfkX92s7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxAIMIfWDN7GiYZndTdzSwL9ySLJ8FztioyllXhORpLaaerEB
	tzu6QObS/Src9wOdCxyh2PlJ/8FckDQ0A3t5a/CuDyrCgqV7aBVkWTkh2v7/sPAYOTxEM5OnrBy
	b/NBsqipYBaRfc6Xzz/xtzviLlqWoEERSSQ9y
X-Gm-Gg: ASbGncu7wUq2mW++YhO1yKknuuBPWjmrJs6+OxP6nTjLdgnLGGzjHAu6X+/GyPoMbHv
	3vR6BKr5m54vk7eiydPL28eweYB/pVkE=
X-Google-Smtp-Source: AGHT+IEkMEJuQYoavObqjfF1Dm1ARxtTM3In+7tdetfMxymzqpHnS3ICi4gVSe4yccpc3ySQA05ZVBU8SNk46yxZksY=
X-Received: by 2002:a17:906:23f1:b0:aa5:639d:7cdb with SMTP id
 a640c23a62f3a-aa5f7d4ec79mr647034466b.22.1733385291482; Wed, 04 Dec 2024
 23:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204085801.11563-1-moyuanhao3676@163.com> <80b6603d-ed52-43b7-a434-0253e5de784a@kernel.org>
 <dcdeaf17-c3ce-4677-a0c0-c391d8bd951f@163.com>
In-Reply-To: <dcdeaf17-c3ce-4677-a0c0-c391d8bd951f@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Dec 2024 08:54:40 +0100
Message-ID: <CANn89iLjhnxkOY7p3zQsyupGowjMt0beWE3=WHTVC2NSM_-2hw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Check space before adding MPTCP options
To: Mo Yuanhao <moyuanhao3676@163.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:31=E2=80=AFAM Mo Yuanhao <moyuanhao3676@163.com> w=
rote:
>
> =E5=9C=A8 2024/12/4 19:01, Matthieu Baerts =E5=86=99=E9=81=93:
> > Hi MoYuanhao,
> >
> > +Cc MPTCP mailing list.
> >
> > (Please cc the MPTCP list next time)
> >
> > On 04/12/2024 09:58, MoYuanhao wrote:
> >> Ensure enough space before adding MPTCP options in tcp_syn_options()
> >> Added a check to verify sufficient remaining space
> >> before inserting MPTCP options in SYN packets.
> >> This prevents issues when space is insufficient.
> >
> > Thank you for this patch. I'm surprised we all missed this check, but
> > yes it is missing.
> >
> > As mentioned by Eric in his previous email, please add a 'Fixes' tag.
> > For bug-fixes, you should also Cc stable and target 'net', not 'net-nex=
t':
> >
> > Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing
> > connections")
> > Cc: stable@vger.kernel.org
> >
> >
> > Regarding the code, it looks OK to me, as we did exactly that with
> > mptcp_synack_options(). In mptcp_established_options(), we pass
> > 'remaining' because many MPTCP options can be set, but not here. So I
> > guess that's fine to keep the code like that, especially for the 'net' =
tree.
> >
> >
> > Also, and linked to Eric's email, did you have an issue with that, or i=
s
> > it to prevent issues in the future?
> >
> >
> > One last thing, please don=E2=80=99t repost your patches within one 24h=
 period, see:
> >
> >    https://docs.kernel.org/process/maintainer-netdev.html
> >
> >
> > Because the code is OK to me, and the same patch has already been sent
> > twice to the netdev ML within a few hours, I'm going to apply this patc=
h
> > in our MPTCP tree with the suggested modifications. Later on, we will
> > send it for inclusion in the net tree.
> >
> > pw-bot: awaiting-upstream
> >
> > (Not sure this pw-bot instruction will work as no net/mptcp/* files hav=
e
> > been modified)
> >
> > Cheers,
> > Matt
> Hi Matt,
>
> Thank you for your feedback!
>
> I have made the suggested updates to the patch (version 2):
>
> I=E2=80=99ve added the Fixes tag and Cc'd the stable@vger.kernel.org list=
.
> The target branch has been adjusted to net as per your suggestion.
> I will make sure to Cc the MPTCP list in future submissions.
>
> Regarding your question, this patch was created to prevent potential
> issues related to insufficient space for MPTCP options in the future. I
> didn't encounter a specific issue, but it seemed like a necessary
> safeguard to ensure robustness when handling SYN packets with MPTCP optio=
ns.
>
> Additionally, I have made further optimizations to the patch, which are
> included in the attached version. I believe it would be more elegant to
> introduce a new function, mptcp_set_option(), similar to
> mptcp_set_option_cond(), to handle MPTCP options.
>
> This is my first time replying to a message in a Linux mailing list, so
> if there are any formatting issues or mistakes, please point them out
> and I will make sure to correct them in future submissions.
>
> Thanks again for your review and suggestions. Looking forward to seeing
> the patch applied to the MPTCP tree and later inclusion in the net tree.

We usually do not refactor for a patch targeting a net tree.

Also, please do not add attachments, we need the patch inline as you did in=
 v1.

As you can see, v2 is not avail in
https://patchwork.kernel.org/project/netdevbpf/list/

Documentation/process/submitting-patches.rst

No MIME, no links, no compression, no attachments.  Just plain text
-------------------------------------------------------------------

Linus and other kernel developers need to be able to read and comment
on the changes you are submitting.  It is important for a kernel
developer to be able to "quote" your changes, using standard e-mail
tools, so that they may comment on specific portions of your code.

For this reason, all patches should be submitted by e-mail "inline". The
easiest way to do this is with ``git send-email``, which is strongly
recommended.  An interactive tutorial for ``git send-email`` is available a=
t
https://git-send-email.io.

If you choose not to use ``git send-email``:

.. warning::

  Be wary of your editor's word-wrap corrupting your patch,
  if you choose to cut-n-paste your patch.

Do not attach the patch as a MIME attachment, compressed or not.
Many popular e-mail applications will not always transmit a MIME
attachment as plain text, making it impossible to comment on your
code.  A MIME attachment also takes Linus a bit more time to process,
decreasing the likelihood of your MIME-attached change being accepted.

