Return-Path: <stable+bounces-224608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 04pcLMKtsGlImAIAu9opvQ
	(envelope-from <stable+bounces-224608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:48:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB4259565
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 388653026B7B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61002356A0B;
	Tue, 10 Mar 2026 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrl5qcPB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CE248F73
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186495; cv=pass; b=TojfVKoeBM39yMOxwsq1JnWwvyKQdHjTrneRT6fBWkm+JuGNgh02hameURvV98zCHfYlYNUIdzu6blv3F8QuCNEf7HZix44Siix4WI8pWS/TKy7u2mAjX4M1Ncs99cYHeuyy6RawNnXkfFTTqE13Yn5oo6P+V4gBrhLlRLuB3hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186495; c=relaxed/simple;
	bh=R0094smBn+blaQezPKH8Xn6NRWq2xCeGfw9O/BSwwYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJcHhovJ4EhzuwlfbrVN28oxPvogiJLvfiMKzBY0O+uEqtyMXBezPdt9y1jDD2Rw+Wdrl97N7S23KJ3OSgU2xnr8/o1jsS5NIB2t8SLhjB/QZq9r4H7Nxldk87jdzzYDavwYXGhZw1kIBNcHSpq4LDytBBQ8m3cqA4sSOvGrgTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrl5qcPB; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40423dbe98bso3588461fac.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 16:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773186493; cv=none;
        d=google.com; s=arc-20240605;
        b=fbbXAAhglF1ICA6jlFkG6kFpr+3kw+U/I355OGn+zlqtZWQ6eq+KqA5PUyudt8gD9P
         6mkdtGTAsheVzGN/7xdapoN2Jh7LotuLXhbo2WI4oYHf9TD+bqGuPt4s/9CaYXaANf3J
         ZIEh2T9/bt4r+ylYeb4OYNFxTmFq/h2/+zHVofaEAUpdpU+8iltUbLWnRE7tjXqENFoX
         X++mQPA87yz/hIpHyjCd06IGls8i3EsvLkPC6HcnMKaH6OYdJM96RdLGlpnOxz8C+ADP
         S7FfqQ8Tm+YdWHdgfbwyXOsOoqDTTcq1QGDMBCbUU6JdrechmG45ibf8L9kBNNPyb4Dq
         CvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nprcmfuZfu4WoZ6R4/mj5wSeSMEuKLNjIqHwGck3l34=;
        fh=wF9rTfWVsbmJ3JO38Aya1c5zlsQF6H1CbG4Bq++5V3o=;
        b=UF7w+LkkdG5clBpd5WKhJ/BmmmARUnm3cerVUxC8YZQesGp0DW+qxYrQeOtJKU+Pip
         UctWAzN9k3pmd9/+2kuah4a7yvXhA3fGznpWIIeWNMnhLB8e37tgwRsCLe7ZIEgrHnSP
         JVOssqVCUJBAgEYPFC+dSdvUmBImCDFexjRPWvYfVGCrl2RiSMmrTeT2DGP0Klm7Vawa
         lX7cmhEEjUhY9tHG/mT6c7aPBQc8xlsm0g2AslrRIZEi2df/IdWL8znhfqY62ZbKiWPx
         WW9vMdnPGrMLoI2A46sHnxJIyB4iqb1jF+q6XEfv9hj11BEG+MAGtT2tEDIOTQdhLZtC
         EaVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773186493; x=1773791293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nprcmfuZfu4WoZ6R4/mj5wSeSMEuKLNjIqHwGck3l34=;
        b=Yrl5qcPBF9VPSrZ5BCMTn+QQDe30+rKV5EgkgvnmXOHToIIA5CZdcF5lp4pAHRqnsj
         FYvGOw61pWPthbykswh9f6ktAzX3S6dp0ra+0FJXhcUWV71l/EPbR5Ww3TmleTGwzoSV
         UKClgnrF3AyObIn2bVFRYcrDTuXHflebsXHrpl5XHBT7IKlABqmQMADieaGvsQME8VOp
         jPZmTH8phw6QKyW1RbPYMjchYMDRZfYLsy/wgzMZdOczK/xQxC4RmI1T9STcLcjZGgKE
         XpyWe5SczQsKINiy41yT44LVJRo8NnLkwOciJinOvhSfopzJS7vcL6qg4ryKU3IJ2HhS
         KRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186493; x=1773791293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nprcmfuZfu4WoZ6R4/mj5wSeSMEuKLNjIqHwGck3l34=;
        b=CByeLUHo0AzsT6JLzCKgCEgdUjm7hmcIxZ2GAL2tXP5VaWetRg1DeQd1XjVFEWxqXr
         bdA2Nx6P7QgmQX6hXHowxsNBmqXpiEURZ9ykd1QACc0mMxOQIcwzoUC2M2icJATc01S8
         OYDTUnqXhFBdhPu548+kP6CsRP5U+yVWetoA3dhHOp2m/7fibR+nFyuCNJun/eDB4E7n
         oRwujxyxzYBwPkhGaUC6ftVsQw1DR/VUyQ2yoZ9TYWuTkWjnKV4U8jYG8A2Mxm37rGuZ
         SjDeb8ZnMRsxJc3BT+CICIh+qT+EeP0HIOrqH5oHjGc47GHpGP1f4zEhz4sVvWWKJmsE
         pSVA==
X-Forwarded-Encrypted: i=1; AJvYcCX2OxI/yVA75IcLtxMgeagZHUDvFrpe9oLrnJD2KIQxc6+/Oqqp7nwzMseOkuCFdZ0HtYa3t9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlmn1fh8E1J0uSuOfVhoXy0M1zwFz8cuaavlpktnovUGajb/JM
	uUH2wLq9jgl6h0EBkxNlk/nIji/0u5gANbBiX01FNhoE33huPjKsfkOPtGLbEVu0A/FG9u+jH9p
	UwUsNBKkBg85UrAOaE8pLofgEqNtoXDQ=
X-Gm-Gg: ATEYQzy5ZGKlJZyO3d86WQMiOh1yn3Ihahm0ULCKfbAjOQ5V3fBdjK2PWzMrdHRgI2F
	hxO6UmdqsKiMA2taGpAyxC09wdb3sOt0tktkML/v7BD+aGizyvny8FPc2JiwthLO/Jz+dsmdDJI
	dfhB7U/rTSOIlYJQ8tF7ZLPXxJf8sZ9OgFG9qNZJ2930eN4rLEiZslfICxmkPOO/MhqYb+4TQeJ
	23jtVwYqVMewwyqfapJ3FDt4eTLa4stq805TBb5ha5V4FeTCcnpjMMTd6G+JwiMogFDiok65vZl
	KPBUUhW++S0saGPSBwQ=
X-Received: by 2002:a05:6871:e7cd:b0:417:2daf:6aa1 with SMTP id
 586e51a60fabf-4177c95ba52mr497268fac.37.1773186492628; Tue, 10 Mar 2026
 16:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310022300.311125-1-jassisinghbrar@gmail.com> <CAD=FV=USFLx1J1+maF3KraYEMPJNq-xjqGLkb_bfozO2LykbAg@mail.gmail.com>
In-Reply-To: <CAD=FV=USFLx1J1+maF3KraYEMPJNq-xjqGLkb_bfozO2LykbAg@mail.gmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 10 Mar 2026 18:48:01 -0500
X-Gm-Features: AaiRm52OAPr_dblD2RF8-dJqU8t0yVbjV1GgHxqDSxOzJVcoVipxYjiIGRHjB5M
Message-ID: <CABb+yY28MYdX1nQYuiNZRb9hFHzamREx+kQUuAJXZNYjxC+pMw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/qcom-mpm: Fix missing mailbox TX done acknowledgment
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, shawn.guo@linaro.org, maz@kernel.org, 
	stable@vger.kernel.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3CBB4259565
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224608-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:22=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Mar 9, 2026 at 7:23=E2=80=AFPM <jassisinghbrar@gmail.com> wrote:
> >
> > From: Jassi Brar <jassisinghbrar@gmail.com>
> >
> > The mbox_client for qcom-mpm sends NULL doorbell messages via
> > mbox_send_message() but never signals TX completion.
> > Set knows_txdone=3Dtrue and call mbox_client_txdone() after a
> > successful send, matching the pattern used by other Qualcomm
> > mailbox clients (smp2p, smsm, qcom_aoss etc) of similar controller.
> >
> > Fixes: a6199bb514d8a6 "irqchip: Add Qualcomm MPM controller driver"
> > Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> > ---
> >  drivers/irqchip/irq-qcom-mpm.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> It's up to you, but according to all the research I did w/ NULL
> messages, the mbox_client_txdone() didn't really do anything useful in
> this case so we don't _really_ need to add it. The fact that it
> historically did nothing is one reason why the new
> mbox_ring_doorbell() series explicitly documents that you need not
> (and, ideally, should not) call txdone() for doorbells.
>
> Specifically, mbox_client_txdone() will just call tx_tick(). That will
> set `chan->active_req` to NULL (it already was). It will call
> msg_submit() which likely doesn't do anything (since we don't queue
> NULL messages in normal situations). It will notice that `mssg` is
> NULL so it will return before calling tx_done() or signalling the
> completion.
>
> If we make this change, then I'll need to spin my mbox_ring_doorbell()
> series to delete the code. That's OK with me if that's what you want
> to do, but I don't see a lot of benefit.
>
This is the only driver that doesn't "do the right thing" by missing
mbox_client_txdone() while being one.
I came across it while looking into if/how we can make
mbox_send_message(NULL) work.
Our root problem is active_req uses NULL as an 'idle' marker (early
days when doorbell
clients weren't known). If active_req used some other marker, NULL
messages would work like any
other message without a new api, even in blocking mode with optional
tx-callbacks respected.

For example, zynqmp-ipi-mailbox.c has 'txdone_poll =3D true' so
zynqmp_power.c can not use this doorbell api -
it needs to block on hrtimer based polling (which never happens when
message is NULL). Such clients still need a solution.

One option is to use the sentinel value ((void*) -1) internally.  The
only catch is then it will no longer be
a legitimate message, though I don't see any client using it (for
example as a bitmask). I personally think that is a
good 'tradeoff' for fixing the existing api without causing churn. I
would appreciate your take on the
 RFC  https://lkml.org/lkml/2026/3/10/2378

Regards
Jassi

