Return-Path: <stable+bounces-210766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIH7BurgcGnCaQAAu9opvQ
	(envelope-from <stable+bounces-210766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:21:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CA58551
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA22172698A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B0E48BD40;
	Wed, 21 Jan 2026 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBHX4/wP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0BF481A88
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004205; cv=pass; b=QfzKrxx3Oun2+XhUjWxWc1JF6lHWBF9fJir1qJch/2Srl1C6H0OOeYxX0GthCjV3ptabcwtESb0QQ7ubJgUJ9LXmZh1ZEiLTQgn/iGKWRHcCF0iWe8F0GeUfM3iH6PKn/NKCasgM/+mXeZ4ts2Qk5G/Z/hOU3AmFq6mHZBzkg+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004205; c=relaxed/simple;
	bh=pVJAlnTPLe7ZRidQC24R/2MJx55kaJqY6OlfkH+uFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opZX5PYalivtMa3BZx5YzXcr9OmFMa2bTso62v5TNNJ3vzryuYfcLtClgpZxuzU32Xy6FNAJQyG66klQr1ueIwLjuWZp/f6LVZiAuqa7raBLXX/5OkLYFEiMT+VuH/MC0MMbeloauZw6unodyX7qAHnuOMxFEmbZA1PHrDGFcl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBHX4/wP; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-502a98c66f7so41582081cf.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 06:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769004203; cv=none;
        d=google.com; s=arc-20240605;
        b=e6RqeOqdh0OMS/T+KUJTd+yiKL+o0ovu+Gy1aNuA2dIbL3bf87B3/Kja+fC0Cjrvgz
         VEAeGjNOElQ8xWOFh/5ZJs6IX42JmJHvbT2wR93OhZT+NgTBrJsOrUfgUA6ptuQB42Gs
         Np3x3sdayuhGBmLJ6TiWGn2dHnUxze1rXkHaADEcGMI/Lfarlgt7GuytExq6HGMuF/Ou
         St5L27QVXDBkmxCEsm7AwrH1vtr3+FpbFbGB9EdjAriIyGFOrBci483W5c/HKAbfjW2N
         9bZNHhFnCAay6IZ69arFVHI9+D16oLZHkdY53kokMKe2UH1yhQXtO/L5pOM4aKIPYKJz
         OXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xQ02uxLunjasR7mlrXJD6HDz/zpqHD9iVNJpMIrXJs=;
        fh=2cUAelO4Yhm6wte2+w2bBxtNUfvF+rGZLdvDYUvrMDc=;
        b=MslGQVpk9dDW90b2F2FUxGZie3T5DJJqQla5ssil6xEvtMTC1RrCadfs5FXnTJ8m82
         PxYDbN6x4UtAAkACEAvxm+KbAKPCG9so56nlM952DyLCHo4uimkcxLqMQU7uw8L2c0zH
         6tFzfzd+8eUKy8m09vcu/hhjv+LHRRoCxCjeCbrSQe/Eo6aIaoBaasLg1o8hwqnu07Bq
         9eaf6bZP3oaEBA6d7C1hrD7RsZ7joe9h5zCaK2RvNNepIFZHtvZMaU/zBJyer7B9UAvr
         NMWojVqb/RJm7DKD7dSIh0A1ZxCkVyshrKStFT5PUwzmRwJfhyCznZQBE3olGrrTlmQz
         ygUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769004203; x=1769609003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xQ02uxLunjasR7mlrXJD6HDz/zpqHD9iVNJpMIrXJs=;
        b=UBHX4/wPtYAMgHqPG8vpWxOipbuLWlNOPVkEp7+09EpKjXVrxxXxhhedYDuLsihIq4
         +5Dm1gFcwvzK8T+sk04H7kCua6eUX1QG/xwRhCpdQRpZpr+fGcnNVoTW+LYjwB4czhgK
         LmGAMWyCZ9VjRM9JZPmLyiy46Vgi78uHQ7REOtJGB0Ou+R2mS65g2JVLwDtmoTaPWxLo
         GVR0BV+g5zw76h8pBpKXnk0L6/wLDBdNy2NSjLMF7vswthYWVU3UHfydbUiMR0HPiQb8
         t2aqJD14s70XpA0nsih8HLWuPhnELEj39AcJ4Hx8J3hvhMk8+8208NdiFirwMKoYkTA/
         JtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769004203; x=1769609003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xQ02uxLunjasR7mlrXJD6HDz/zpqHD9iVNJpMIrXJs=;
        b=YE1k37W15hzaPiTqlS1ZajzqY02aGGus2HjaZ5mHVS1wqdV4FUyy1bC5yAtcoPATAZ
         6qTGNloTR+9/ePgPdqyXkkzXcN+ITEZV+YdjDgkAoudAurOzeK3a7NJLDSTX0YcbPtX9
         GBeAMsevf6r9rht380VkDGEDk0FAsIP5bYxMNfBFhAk6VG4Bb8ixXWZoeDDsLRDmjiIg
         MHwdbDMXLW9ghvvx8ED95/aPbrVoUKFUlFdTE8HD8ZhKsCRj1gnTGjIGrV5UEA4gmp7m
         H7jaz1lh9hAUAPl25WiDg1P6dlgG+uf6UsDcU9kWf4kPMGFOWu8BtG0JoJRvWLQcoiw8
         pSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPr6qwBElSSkb8JMhM5+MWG+wwxnmMYgEIp/krUWdymM9diERn05ULcrgvcNoTc0xXzGHVa4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUg8w4UxhmIaXvmdNW77gnm5GrSoSTo8TC3agmNc32BuAf1QH
	EA0nPcKEbQXxcyYkCHGHO9oQPEy5McoYakTGAXMsyMfGeUma49uTF1CVqN4+7JXbBWoQxj2EbaS
	MsXxFDjUY+ond7JgtuTlIguxqMn2aKT3dAz70AiiG
X-Gm-Gg: AZuq6aKkWX66yjReCElUVSVbeY8GDXP9h2MIje9FXH0U2EA7NWPwVs4xIyrvxAQRBYM
	MOcEbU5Dzv4v/UFhRBKjf1CmMV3VOLI9qYscPTFSdCVcoMWizndHqdHOiHdyvMG65zD12HWJX3p
	dKVbAFJ1Vu5DAIhrhJOz+4p4A+VSL/5T6L/NmI+mzp/qhOFQM5Kbc3eAmyshqB9mpB4+2iDOftO
	3+hTWaSxzC/c2kHJJrU49xI/8B7Rt/Xc0tVSR5lrcXKznaXSXpR9s1wvsg1RZl9+Em9x+A=
X-Received: by 2002:a05:622a:19a0:b0:4ee:17b0:6261 with SMTP id
 d75a77b69052e-502a168e7a9mr262497571cf.29.1769004202263; Wed, 21 Jan 2026
 06:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
 <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
 <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
 <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com> <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
In-Reply-To: <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:03:10 +0100
X-Gm-Features: AZwV_QjJ94otoWXwSoIy5yodC7nHjDCSaaJ1OxKnCSNDwziFa-9aPyMAIDoo6e8
Message-ID: <CANn89i+zuXMZ1Jx226rPG0nHKmRjL1s-m56xk-KD6nWLdrY1Gg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink
 dump struct
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210766-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C21CA58551
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:01=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> padding? why does fzero-init-padding-bits exist?
>

Which padding are you referring to?

$ pahole -C tc_gate --hex  net/sched/act_gate.o
struct tc_gate {
__u32                      index;                /*     0   0x4 */
__u32                      capab;                /*   0x4   0x4 */
int                        action;               /*   0x8   0x4 */
int                        refcnt;               /*   0xc   0x4 */
int                        bindcnt;              /*  0x10   0x4 */

/* size: 20, cachelines: 1, members: 5 */
/* last cacheline: 20 bytes */
};

I see no padding.

>
>
>
> On Wednesday, January 21st, 2026 at 7:48 AM, Eric Dumazet <edumazet@googl=
e.com> wrote:
>
> >
> >
> > On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Paul Moses p@1g4.org wrote:
> >
> > > Yes, it's not proven so you might be right, I knew it was 4 bytes at =
best. We can do next or toss it, I don't feel strongly either way.
> >
> >
> > These bytes are cleared by C compilers.
> >
> > https://en.cppreference.com/w/c/language/struct_initialization.html
> >
> > Only holes might be left uninitialized.
> >
> > > On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet edumazet@go=
ogle.com wrote:
> > >
> > > > On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > > >
> > > > > Zero-initialize the dump struct before selective assignment to av=
oid
> > > > > leaking stack padding in netlink replies. This matches other acti=
ons
> > > > > (e.g. act_connmark) that zero-init their dump structs.
> > > > >
> > > > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow act=
ion")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Paul Moses p@1g4.org
> > > > > ---
> > > >
> > > > I do not see a bug to fix, current code is fine.
> > > >
> > > > act_connmark problem was that "struct tc_connmark" had a 16bit hole=
.
> > > >
> > > > No such issue for struct tc_gate.

