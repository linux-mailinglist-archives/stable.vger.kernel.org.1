Return-Path: <stable+bounces-210784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLzECPUMcWlEcgAAu9opvQ
	(envelope-from <stable+bounces-210784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:29:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6F5A8A5
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2379070C73E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1873A63F3;
	Wed, 21 Jan 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="AmkUiZfS"
X-Original-To: stable@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE23EF0AD
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009193; cv=none; b=IhkcZgr2Xc90n5KB1r2Bk+bk3+gbNGACsXfJpPBizicqkbcEtCQBKc0arrSshnDIUdaY6uYN6gK9BLLOysskIzr8bPTRZH6mEpk6gCG5nljU4SNbJv7Kg+QSy4EO2FlfXTTWbp5EbLRrRyw9nhKWlhNXD5DZGGM6cmwCI2blDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009193; c=relaxed/simple;
	bh=oyBymticbDwZrPsHMr0S4yRd+VTTt5K56aJcq45Byjs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5cW6E9RfviPqR63mBYsMC/CAcDxbx4sz60NNHQOncltsyIEg8gOO4Werftc3KV6BjfG0cba0cUHO1oSpK4INIoQTgfVbDefC2ZSbKwow1blz18zLRNfsXMRkbQrQgUIAkIzdUKhZ+du5Lt0sWFBfatkWQTPNXuxTlkCo2ON9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=AmkUiZfS; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769009188; x=1769268388;
	bh=7UQ5Pf+imMikWLYZlBN3h7Sffeu9yLrQkBOWdCS3OO8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AmkUiZfSOskraquHLtlLEp0aCJiZZ0PZKJRpYYx9/dUbhq9dzITXhNHKwvqP7dEKs
	 velKWx2hPyA0+DSIHmbxrMcg08pBuyDfEwPAfL4tAe8eR3ChGnSEgTW3eS9BDoDeDD
	 10kj3/AHHUkabSMUuiuzFfkK4N+U6iMHMgvufxSehHjsAnyj7C5unR8ypCiBfLFVHk
	 2KrU2GIQTuTB80Fo8/IfgWUXqrQHCrc9oOWwQb+x+VDuA+mrbGNR1HtCSIrrh1D25k
	 UHQcwtoZgxZzKYXzZHVxNtur9R/FDXlpnaWYyEC4+Qk0A9H5fcK8o2Me7+8Tf9EfPZ
	 n+aX4Jc6xk3Cw==
Date: Wed, 21 Jan 2026 15:26:22 +0000
To: Eric Dumazet <edumazet@google.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <iSkQcHVqeUy7WNAqfrY9xUAibm1YtrTUPIhZ_yjoHmyDissbQj04N2-quW8BURs4cddEB6bDp0BfXh0LfdYwUYKQudEaHv-4TjEOTI_rCic=@1g4.org>
In-Reply-To: <CANn89i+zuXMZ1Jx226rPG0nHKmRjL1s-m56xk-KD6nWLdrY1Gg@mail.gmail.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org> <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com> <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org> <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com> <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org> <CANn89i+zuXMZ1Jx226rPG0nHKmRjL1s-m56xk-KD6nWLdrY1Gg@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 2df979a47a544552cb4e4b1739c691bd58331a3c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_POLICY_ALLOW(0.00)[1g4.org,quarantine];
	DKIM_TRACE(0.00)[1g4.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9FE6F5A8A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Was looking at tcfg_gate_entry and tcf_gate along with this instance of nla=
_put, but I can't find my notes and I don't see the path currently. Like I =
said, remove it, I don't care.

    if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
        goto nla_put_failure;


I have months invested into the UAF though and only just in the past 24 hou=
rs was able to stabilize into user space, so no effort whatsoever has been =
put into defeating kaslr or anything requiring infoleak.

Look forward to more input on the much larger issue at hand.=20

Thanks
Paul




On Wednesday, January 21st, 2026 at 8:03 AM, Eric Dumazet <edumazet@google.=
com> wrote:

>
>
> On Wed, Jan 21, 2026 at 3:01=E2=80=AFPM Paul Moses p@1g4.org wrote:
>
> > padding? why does fzero-init-padding-bits exist?
>
>
> Which padding are you referring to?
>
> $ pahole -C tc_gate --hex net/sched/act_gate.o
> struct tc_gate {
> __u32 index; /* 0 0x4 /
> __u32 capab; / 0x4 0x4 /
> int action; / 0x8 0x4 /
> int refcnt; / 0xc 0x4 /
> int bindcnt; / 0x10 0x4 /
>
> / size: 20, cachelines: 1, members: 5 /
> / last cacheline: 20 bytes */
> };
>
> I see no padding.
>
> > On Wednesday, January 21st, 2026 at 7:48 AM, Eric Dumazet edumazet@goog=
le.com wrote:
> >
> > > On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > >
> > > > Yes, it's not proven so you might be right, I knew it was 4 bytes a=
t best. We can do next or toss it, I don't feel strongly either way.
> > >
> > > These bytes are cleared by C compilers.
> > >
> > > https://en.cppreference.com/w/c/language/struct_initialization.html
> > >
> > > Only holes might be left uninitialized.
> > >
> > > > On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet edumazet@=
google.com wrote:
> > > >
> > > > > On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrot=
e:
> > > > >
> > > > > > Zero-initialize the dump struct before selective assignment to =
avoid
> > > > > > leaking stack padding in netlink replies. This matches other ac=
tions
> > > > > > (e.g. act_connmark) that zero-init their dump structs.
> > > > > >
> > > > > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow a=
ction")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Paul Moses p@1g4.org
> > > > > > ---
> > > > >
> > > > > I do not see a bug to fix, current code is fine.
> > > > >
> > > > > act_connmark problem was that "struct tc_connmark" had a 16bit ho=
le.
> > > > >
> > > > > No such issue for struct tc_gate.

