Return-Path: <stable+bounces-210759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFLZMbDfcGnCaQAAu9opvQ
	(envelope-from <stable+bounces-210759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:16:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85E58415
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12053702273
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20D285C85;
	Wed, 21 Jan 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="ATITGszw"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB8280A29
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002799; cv=none; b=tWMrqb1NHbrpnYcaMkMljnionPAa16iaPwjVf7JtYX9DTKVUq6g64YnqJVl4mrEJCOebbe14x+QMYV9ajhMHVZzdoAh/lzMYfXUj+tpA+Ac0abfL/dTRTTvkKdv4zTyus+3xfoWm8FEsjhNymRV7zR3Y7dW73A23U5GQZOm6QG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002799; c=relaxed/simple;
	bh=RmqCf2wR5mujk0thtN0HVfxp4irGJYjIkh+aH0XjYy4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHvFRHzzRemQvb2VZL57MnzKWkmON35BnqBLKeahg17mXxuU1L0XP/xOU0JQXopw5lT8fft1Bod9/DNMTQay/43FTh9bYCYpnWSUVp64bPOBiWL+67Uad2WB+MWeTMIh3Oj0TGzJmCyubbvoTq6hN+kowfVVItmot2DXrXjEb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=ATITGszw; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769002788; x=1769261988;
	bh=RmqCf2wR5mujk0thtN0HVfxp4irGJYjIkh+aH0XjYy4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ATITGszwYIQbcxcSRILU1ZSV9Alw8VZfYlmYyxIuca9eYMwPGJ3WGjEVjIo+o4iPi
	 OAARotb1riwyD8DWKsplci+J8Ez8sbBJ2wRquwOqWPqqxorU+jggQn/iDi4amkzUBO
	 Z18yCumz+S6LxunVL7bLEwmF1y1B44ocbzcERG/GW06mWclHSl8ttPMcAm8mR1mCdc
	 NpDxJKp+xQZL7GdXrwLgs0pxeeRWy617XUTeAkTGdIWt5bPOnnoo7elYlkY+PFix9E
	 WBBlI0J8xP8HYYOFsGU7cnYbn8RKcmaoaQLGYPVrCxky8J7rWxcQaY/62X2T7YgtFM
	 zmHyJGiCUaFnw==
Date: Wed, 21 Jan 2026 13:39:42 +0000
To: Eric Dumazet <edumazet@google.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
In-Reply-To: <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org> <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: b2a462617249e0597036a82c08d089850476b13a
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
	TAGGED_FROM(0.00)[bounces-210759-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,1g4.org:dkim,1g4.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6B85E58415
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yes, it's not proven so you might be right, I knew it was 4 bytes at best. =
We can do next or toss it, I don't feel strongly either way.

On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet <edumazet@google.=
com> wrote:

>=20
>=20
> On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
>=20
> > Zero-initialize the dump struct before selective assignment to avoid
> > leaking stack padding in netlink replies. This matches other actions
> > (e.g. act_connmark) that zero-init their dump structs.
> >=20
> > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses p@1g4.org
> > ---
>=20
>=20
> I do not see a bug to fix, current code is fine.
>=20
> act_connmark problem was that "struct tc_connmark" had a 16bit hole.
>=20
> No such issue for struct tc_gate.

