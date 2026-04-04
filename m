Return-Path: <stable+bounces-233281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJdzA2/60GkzDAcAu9opvQ
	(envelope-from <stable+bounces-233281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 13:47:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E8B39AF81
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CD773006464
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834D332ECB;
	Sat,  4 Apr 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lw1ACzpA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B13321BD
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775303276; cv=none; b=Gq5Zoc7X4fRqdIP343HkKfI1ruRER5uHARRih+NVSu/g+8tRsHuoGyyRH7+EMZFR7tbgjd+tb273/5f4wKmyqcpbXElEoLhLuLON5plYQCfGEltQUkw0wCfcQzC78LN7Cdma0CgTgpnjCFXrNUMnApXfj2nKG3Q0NcrJM/Zdoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775303276; c=relaxed/simple;
	bh=dy8yhJzNiwRlEiywyAKmr/JdveTelkXEUEII/JcVTvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PthxqE3izVaM8IhZqydGLPaYbFQ1eMz8MSGdzHytu2J4UlN7eWeYskN8Lk5uRK9UpV2dPcbR+ZJzRec3+jlFO8Ex5zs9xl+/QSmk+vZYUBuMNc82H22kzaO3ZnCXkYiJcbArJzabCqI+Mo9BSZSGA3ygBbiBv6O8Ud0ZOfv1qE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lw1ACzpA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2489af602so24774375ad.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775303274; x=1775908074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G1qQkwBhPOCSaPNNZcA5R2UExCpSWly+t1LnZq/nHI=;
        b=Lw1ACzpA7Y04E5a02q/Lc+FpOJdES0g9AoMhVBD0F9O5X2i0ymnCTtrb0Na9hQ27EW
         xMn2GCo/I4S2sTh1Y8xEy8TsNe6bl4UF3OmJM7zKVW+M1cXapWkuSjHogwrWxGZiJ1MG
         QXlG86Lt59FBoLGe88LAO5aOnS0v1JliuysHmnQlqccR1Y4lX1D0ZS2T2ngptzZM8kOi
         OBWho+ReIq5Kpz8sCvYq28DRf80xt3hjftZ/vvquJoRWPBsHf/XIvRqGRyPBt5bVP0Cc
         cPH0kJmn336XUeyeoMcWRKiTffbhbZDvIxhIqLCRct+9FQGX7jr+IDm/qpLq8XgyVdXf
         GWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775303274; x=1775908074;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0G1qQkwBhPOCSaPNNZcA5R2UExCpSWly+t1LnZq/nHI=;
        b=DkP1psUtKU+TLd27xWdzfBgQdb8NQro8RDMxqEuiOHvIqlBu2NiZj/QczkkWET3Hdt
         ZaMPecGYShi8XkKOnN3dSs90MrExubkwyBKBW46oIxJ7aLTVk5ApR2LpI73nzpHl5Bp9
         pl9jdSM6IVNFJsWUselux8kkVRZHDpH4xzqin1PFCnrKfBvL7CQWV4aa21zptpkSYYGU
         guMmWwmPFV6Lg/khyeQI3gSy3WarblFzNUsEgNVorwcDF0qFoViGofKQzwooKG+dveBn
         5lmJC9+T83gTvJbPbCtn8MsLpcE0ultCVaQYBO/1xAqFe7AC8eBMUQ8jiRjbrD21ebpA
         Mv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC6+MWQKlIz8eYgk5bMajubXHkVBHk2prs5JsfQJ2XKDyxIrs2CiAiwFhpj3/2APBHJWf+pc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsJh15Qyc5uV8NikbZY/fEJPHApGJoXz+J79U20Y/h9ltN4uz
	5/37w0GPDRBVjyazs+Af7/0USDaFDP9u7oxxNFXWv/TarTz7L2F+PT2nTN1NgpuP1OZov/MnsaD
	VPAbSw/y4qOgN7M6lSt0+vPiKGA==
X-Received: from plbjz3.prod.google.com ([2002:a17:903:4303:b0:2b0:6207:5fd3])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ec8:b0:2b0:aebe:259 with SMTP id d9443c01a7336-2b2821a7fbemr58943675ad.19.1775303273972;
 Sat, 04 Apr 2026 04:47:53 -0700 (PDT)
Date: Sat,  4 Apr 2026 11:47:51 +0000
In-Reply-To: <CABb+yY23aTXeXu6G-8sHjw32DCqmhsJLu2Mt-txenOgTBiyv+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY23aTXeXu6G-8sHjw32DCqmhsJLu2Mt-txenOgTBiyv+A@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404114752.3052748-1-joonwonkang@google.com>
Subject: Re: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error
 code when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: akpm@linux-foundation.org, angelogioacchino.delregno@collabora.com, 
	jonathanh@nvidia.com, joonwonkang@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	matthias.bgg@gmail.com, stable@vger.kernel.org, thierry.reding@gmail.com, 
	lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,collabora.com,nvidia.com,google.com,lists.infradead.org,vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233281-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13]
X-Rspamd-Queue-Id: 94E8B39AF81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, Apr 3, 2026 at 10:19=E2=80=AFAM Joonwon Kang <joonwonkang@google.=
com> wrote:
> >
> > > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@goo=
gle.com> wrote:
> > > >
> > > > When the mailbox controller failed transmitting message, the error =
code
> > > > was only passed to the client's tx done handler and not to
> > > > mbox_send_message(). For this reason, the function could return a f=
alse
> > > > success. This commit resolves the issue by introducing the tx statu=
s and
> > > > checking it before mbox_send_message() returns.
> > > >
> > > Can you please share the scenario when this becomes necessary? This
> > > can potentially change the ground underneath some clients, so we have
> > > to be sure this is really useful.
> >
> > I would say the problem here is generic enough to apply to all the case=
s where
> > the send result needs to be checked. Since the return value of the send=
 API is
> > not the real send result, any users who believe that this blocking send=
 API
> > will return the real send result could fall for that. For example, user=
s may
> > think the send was successful even though it was not actually. I believ=
e it is
> > uncommon that users have to register a callback solely to get the send =
result
> > even though they are using the blocking send API already. Also, I guess=
 there
> > is no special reason why only the mailbox send API should work this way=
 among
> > other typical blocking send APIs. For these reasons, this patch makes t=
he send
> > API return the real send result. This way, users will not need to regis=
ter the
> > redundant callback and I think the return value will align with their c=
ommon
> > expectation.
> >
> Clients submit a message into the Mailbox subsystem to be sent out to
> the remote side which can happen immediately or later.
> If submission fails, clients get immediately notified. If transmission
> fails (which is now internal to the subsystem) it is reported to the
> client by a callback.
> If the API was called mbox_submit_message (which it actually is)
> instead of mbox_send_message, there would be no confusion.
> We can argue how good/bad the current implementation is, but the fact
> is that it is here. And I am reluctant to cause churn without good
> reason.
> Again, as I said, any, _legal_, setup scenario will help me come over
> my reluctance.

mbox_send_message() in blocking mode is not only for submitting the message=
 in
the first place if we read through the API docs.

From the API doc for `mbox_send_message()`:
```
 * If the client had set 'tx_block', the call will return
 * either when the remote receives the data or when 'tx_tout' millisecs
 * run out.
```

From the API doc for `struct mbox_client`:
```
 * @tx_block:		If the mbox_send_message should block until data is
 *			transmitted.
```

With the docs, I think it is apparent that the API covers "transmission" of=
 the
message, not only submission of it. If sumbitting is the sole purpose of th=
e
API, what does the API block for in the first place? We would not need the
blocking mode at all then.

The current return value of the API in failure cases is as follows:

 - When submission fails, returns failure.
 - When submission succeeds but timeout occurs during transmission, return
   failure, i.e. -ETIME.
 - When submission succeeds but transmission fails without timeout, return
   success.

The third case looks problematic. This patch is focusing on this. There is =
also
disparity to handle the failure between timeout(the second case) and
non-timeout(the third case). Why does it not return failure when non-timeou=
t
error occurs during transmission whereas it does when timeout occurs during
transmission? If the API is solely for submission, why does it return failu=
re
instead of success in the second case?

In the third case, the controller(or the client) will inform the mailbox co=
re
of the transmission failure. Then, why not return that failure as a return
value of the API despite having this information in the core?

An alternative to fixing this issue would be adding the API doc by saying l=
ike:

 - In blocking mode, the send API will return -ETIME when timeout occurs du=
ring
   transmission, but it will not return failure but success(since submissio=
n
   itself was successful before transmission) when other errors occur durin=
g
   transmission. Users have to register a callback to collect the error cod=
e
   when non-timeout error occurs.

But, I think we can go away with this unnecessary confusion by fixing the A=
PI
just to return the error code when error occurs regardless of whether it is
timeout or not. Then, we could simply say:

 - In blocking mode, the send API will return failure when error occurs.

Since this patch is pointing out this anomaly of the send API's behavior, I
am not sure what scenario we would need more. In other words, the current w=
ay
of working would be more surprising to the users than the fixed version of =
it
as it was when I found out this issue for the first time.

Do you think that this change will cause any other problem on the client si=
de
than fixing the existing issue? If not, I am wondering why not go fix the
issue with this patch.

Thanks,
Joonwon Kang

