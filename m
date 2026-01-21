Return-Path: <stable+bounces-210765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePnyJ6jocGk+awAAu9opvQ
	(envelope-from <stable+bounces-210765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:54:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCF58CD7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F60956DEE7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BDB43E9D6;
	Wed, 21 Jan 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="wcSgHLxJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CCF494A18
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004087; cv=none; b=FT/3+b/x36kNvJNtzRBoZV/eBEgTtsYzbkVr4TzTxf2d1m6EUCyuGHrWGsaC8vXS0b+9V9YbtpAG2MtjkQpD0mUf69nDxT1ZwvMvnzs62bJTBrpFePfxs5uSiKbQlCNGmFiO39St4QYJft9O684QNF9/13QMmSHvMPNWND+CAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004087; c=relaxed/simple;
	bh=htvZ0BFtdntICwpCIHDXiKGuo9UWkej1fagGs3Fm4G0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAprItj3J7ft2p02ANSwT0z7+pf0llhd2x4sGyq//L/ycEo3/mAHZf+KrW0Mv4kKoSV1G06ixJbq4i1guE4inhQk3Zw5KD0l5krOMfJeMQlY+3uOXvVQGD4uPXh8pXFM4Q7QGppcrkCa3dgtPf5PmU9NaoSpnwcRyTMBDJHELfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=wcSgHLxJ; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769004065; x=1769263265;
	bh=htvZ0BFtdntICwpCIHDXiKGuo9UWkej1fagGs3Fm4G0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wcSgHLxJSMc4E4GwCvZ/I20W3voC4J8A6Sc6zym4lWWyvpd95tANmf3/uez401BYk
	 wMfIBGiLfd3g77zCD9n9Ka7oAVaOecEYvVB4oFc6N2EVXCssuRRNNd9y9SksOmay74
	 rPk+ionuH75aTA0MIrdQ5BT30hvH9RYRQPPSKpMaZ4/OhP6UUNmtvAj24r27VphhUg
	 qT/8WsbcswB5oC94GQyevJmcPwRoculIc8CdAxKFKY4LJLme3zjApELVjcu7OkkmVT
	 +TXehdlmVcAIbIHD77xH71xwdHrWyio4nTZ5jx5KkBHLCetp2M3oFMV956CNSpBzHT
	 t7xKYy9NXgueg==
Date: Wed, 21 Jan 2026 14:01:01 +0000
To: Eric Dumazet <edumazet@google.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
In-Reply-To: <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org> <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com> <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org> <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 29fab967485f950b33fe952df9c87630554f7bf2
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
	TAGGED_FROM(0.00)[bounces-210765-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cppreference.com:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,1g4.org:email,1g4.org:dkim,1g4.org:mid]
X-Rspamd-Queue-Id: 10CCF58CD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

padding? why does fzero-init-padding-bits exist?




On Wednesday, January 21st, 2026 at 7:48 AM, Eric Dumazet <edumazet@google.=
com> wrote:

>=20
>=20
> On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Paul Moses p@1g4.org wrote:
>=20
> > Yes, it's not proven so you might be right, I knew it was 4 bytes at be=
st. We can do next or toss it, I don't feel strongly either way.
>=20
>=20
> These bytes are cleared by C compilers.
>=20
> https://en.cppreference.com/w/c/language/struct_initialization.html
>=20
> Only holes might be left uninitialized.
>=20
> > On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet edumazet@goog=
le.com wrote:
> >=20
> > > On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > >=20
> > > > Zero-initialize the dump struct before selective assignment to avoi=
d
> > > > leaking stack padding in netlink replies. This matches other action=
s
> > > > (e.g. act_connmark) that zero-init their dump structs.
> > > >=20
> > > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow actio=
n")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moses p@1g4.org
> > > > ---
> > >=20
> > > I do not see a bug to fix, current code is fine.
> > >=20
> > > act_connmark problem was that "struct tc_connmark" had a 16bit hole.
> > >=20
> > > No such issue for struct tc_gate.

