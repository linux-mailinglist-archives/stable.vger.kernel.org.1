Return-Path: <stable+bounces-224609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKYsJO+vsGnGmAIAu9opvQ
	(envelope-from <stable+bounces-224609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:57:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B02596E6
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A7A23029744
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C573A63FD;
	Tue, 10 Mar 2026 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a52cRyY1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE335839E
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187049; cv=none; b=qkVaQKvLsgBGZ5w6uBJTg0rlyJA3NNdrqgExeFyKWYwQpCIjk+FClpdnu4Znkv6twbZHXjChKlyKPSX6M8r8fkYJOb7AAqHcfRkTZA8WTb/+VG8Uv18T1D6P4z3rt3re03t1QjdyYIVeqNnytmJVMiDZZcpvlXAkYN/SGW0CKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187049; c=relaxed/simple;
	bh=uMUZjGi/eEKhJpa1u1MfAKdY7fkn89HqDFZA4cWSVhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXLTJmtS4jWwC1/ngc6yKOY+2fWbVavjB7zgQ0bHn5cDAqCPYuedaOwDvMfj2Wcssp+6SDr6Eos/0ThUpoGBWcA3WLCVyTVekVIhvCY0Ia9BX/mnabew3+/Urh6nUGbRUTsZem6Q8KDPTHNsCECO4SuXIvb6evwGfhkfdKvnLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a52cRyY1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6611e4aefdcso11265472a12.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773187045; x=1773791845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNcxXyD4/2ViW74nLDU4ul3wRcsl48d6hrdfqEDQulg=;
        b=a52cRyY19ZFpyl2TxPKf0yUEImOgnILmWbC24OEidTffMq9u6qJtzXvilmgpSVUAXm
         vWuh+na6JP7Aw/Xq8M1VaWlECx6QLm+nmacZA6Dl1HqOwk2NAuj1jzQgMoluNp72p9LM
         dTxIFrlT/T93LYHHGYBZC5JqeV20UDkBCGbAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773187045; x=1773791845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNcxXyD4/2ViW74nLDU4ul3wRcsl48d6hrdfqEDQulg=;
        b=cYXkC7obqg3I4cDuszsZQX2KgEkxj8SixnXMCe5QcDIHuFF+lmZVqq+wGkFraCH1Pd
         GGuLWEQWipIDGRJfnod/QJNCh6aHBRRA967cA11rYeXPVQMUbqLnru+ED3MRnru0VvBW
         tl2e6wTD0APOTDrSToPyNp5itGL8rCz3O1a1g6aFdpGscEhj3ujnMUyUQVQyeOYZO2AH
         Ea76U4EONTWHI/yeLzrSJjDtqtUR1XpQUFkqWOb/pkzn+20uGvQlmgRByAfmJtUNCYRp
         S9782K96vaFhVK/NnCQcRdK+7y2PUhWpnvlTxZptfurFp9izPUxgJso5THcAYN7QOXrC
         ZO9w==
X-Forwarded-Encrypted: i=1; AJvYcCXZg4HNGv7mNBShKRnPJmXMxZQ2R5qaLUHB3K5VQZVhnfTPS8wIo2GsoCm7aWw2oLEkxJMqU6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIx/TAFu1qyB1e+ySulvMXQ8sFhAfH4e9Wxtt6oQUd2nXZRQxn
	/ty1d1LI6eNQx37yqBCIHGRicRpGiPCfTvw5EvCMvtoUbfnNLIF62D+pMet+fRkSOxfzaa4FzgD
	e8cOA3ThR
X-Gm-Gg: ATEYQzwhqaPLj4IVXcBRMUKneA5PnFgfOh+HFn6qe7dXM7uV4vhSAg9L3frZvY6apdR
	1m2RmuSzConQEThsDESDiw2dIwKxyEE1x1S3xZzLUYvhstK0rvYh+ruBL0ruKnWxxmaMCtDP9gu
	dZpfR9Tm/KJqv5NINxr4q6zJA71E8dSVvP6wYnB+b+HPpb10VBqoFfthO7ne5RMGQpruYziV4gt
	Y9Yu9GN6lqBt7Oh92UgryNNY97grFHaTmfJllezNqilEo10jwj4rd6I0tEv0Ds06BH9F48IJt40
	sqzqeW/yRuZusSbGeZqdUiq7O6IPTgUaUhvgGCB+lO85Jl2jJoKGf+YRVAcPPX9OJ6p/9GRWeeF
	6tKq+oeLlr8/G+DaEs7ZD+6HH4NhnvYyVY/od0ZsM7FHEHe5InpiXPiCTGHcvXFaMpcnnfqOhak
	SaeZeCWnl+yjn8vfNFWdQSauN5hi5+2ZV06OUvw8JdgBt3zJs5DB5rwAzkBDj4J4z0/g/6sZLm
X-Received: by 2002:a17:907:1b13:b0:b94:2025:313 with SMTP id a640c23a62f3a-b972e590411mr19294866b.32.1773187045117;
        Tue, 10 Mar 2026 16:57:25 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e1be0dfsm12785966b.60.2026.03.10.16.57.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 16:57:24 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853c3c2fe7so17425345e9.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 16:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW15TqmfgVnz8WgEx+bZ7f01E1jOrOAMnZa0BdgjCKVFWAcThLD6X1802NXgTvceBpWq4YJMCo=@vger.kernel.org
X-Received: by 2002:a05:600c:64cc:b0:485:3d3e:1675 with SMTP id
 5b1f17b1804b1-4854b0b97fdmr9726745e9.8.1773187043386; Tue, 10 Mar 2026
 16:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310022300.311125-1-jassisinghbrar@gmail.com>
 <CAD=FV=USFLx1J1+maF3KraYEMPJNq-xjqGLkb_bfozO2LykbAg@mail.gmail.com> <CABb+yY28MYdX1nQYuiNZRb9hFHzamREx+kQUuAJXZNYjxC+pMw@mail.gmail.com>
In-Reply-To: <CABb+yY28MYdX1nQYuiNZRb9hFHzamREx+kQUuAJXZNYjxC+pMw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Mar 2026 16:57:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDTWLtbtoS_GbvkceYX6VwFcJe_qFtPtkiCRjdec2SaQ@mail.gmail.com>
X-Gm-Features: AaiRm50_0jgq-hJfhk-7UgUd4gHDhTeAbUVqqG_yk1EY6mEzBsNRIUs7K68G5SY
Message-ID: <CAD=FV=XDTWLtbtoS_GbvkceYX6VwFcJe_qFtPtkiCRjdec2SaQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/qcom-mpm: Fix missing mailbox TX done acknowledgment
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, shawn.guo@linaro.org, maz@kernel.org, 
	stable@vger.kernel.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3B2B02596E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,lkml.org:url]
X-Rspamd-Action: no action

Hi,

On Tue, Mar 10, 2026 at 4:48=E2=80=AFPM Jassi Brar <jassisinghbrar@gmail.co=
m> wrote:
>
> On Tue, Mar 10, 2026 at 10:22=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> >
> > Hi,
> >
> > On Mon, Mar 9, 2026 at 7:23=E2=80=AFPM <jassisinghbrar@gmail.com> wrote=
:
> > >
> > > From: Jassi Brar <jassisinghbrar@gmail.com>
> > >
> > > The mbox_client for qcom-mpm sends NULL doorbell messages via
> > > mbox_send_message() but never signals TX completion.
> > > Set knows_txdone=3Dtrue and call mbox_client_txdone() after a
> > > successful send, matching the pattern used by other Qualcomm
> > > mailbox clients (smp2p, smsm, qcom_aoss etc) of similar controller.
> > >
> > > Fixes: a6199bb514d8a6 "irqchip: Add Qualcomm MPM controller driver"
> > > Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> > > ---
> > >  drivers/irqchip/irq-qcom-mpm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > It's up to you, but according to all the research I did w/ NULL
> > messages, the mbox_client_txdone() didn't really do anything useful in
> > this case so we don't _really_ need to add it. The fact that it
> > historically did nothing is one reason why the new
> > mbox_ring_doorbell() series explicitly documents that you need not
> > (and, ideally, should not) call txdone() for doorbells.
> >
> > Specifically, mbox_client_txdone() will just call tx_tick(). That will
> > set `chan->active_req` to NULL (it already was). It will call
> > msg_submit() which likely doesn't do anything (since we don't queue
> > NULL messages in normal situations). It will notice that `mssg` is
> > NULL so it will return before calling tx_done() or signalling the
> > completion.
> >
> > If we make this change, then I'll need to spin my mbox_ring_doorbell()
> > series to delete the code. That's OK with me if that's what you want
> > to do, but I don't see a lot of benefit.
> >
> This is the only driver that doesn't "do the right thing" by missing
> mbox_client_txdone() while being one.
> I came across it while looking into if/how we can make
> mbox_send_message(NULL) work.
> Our root problem is active_req uses NULL as an 'idle' marker (early
> days when doorbell
> clients weren't known). If active_req used some other marker, NULL
> messages would work like any
> other message without a new api, even in blocking mode with optional
> tx-callbacks respected.
>
> For example, zynqmp-ipi-mailbox.c has 'txdone_poll =3D true' so
> zynqmp_power.c can not use this doorbell api -
> it needs to block on hrtimer based polling (which never happens when
> message is NULL). Such clients still need a solution.
>
> One option is to use the sentinel value ((void*) -1) internally.  The
> only catch is then it will no longer be
> a legitimate message, though I don't see any client using it (for
> example as a bitmask). I personally think that is a
> good 'tradeoff' for fixing the existing api without causing churn. I
> would appreciate your take on the
>  RFC  https://lkml.org/lkml/2026/3/10/2378

Hi! Yeah, I already responded there. Let's keep the discussion in
response to that patch to avoid fragmenting the discussion. I'll also
post a pointer from my cover letter in case any mailbox client driver
folks want to post their opinions.

-Doug

