Return-Path: <stable+bounces-215747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EubRF9kNjGl/fgAAu9opvQ
	(envelope-from <stable+bounces-215747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 06:04:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA505121496
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 06:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C205F301ECD4
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFB22C11FA;
	Wed, 11 Feb 2026 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WSHyxhdi"
X-Original-To: stable@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05231624D5
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786261; cv=none; b=EoKWJPEjC68ZcBar5MF5SQgD4xcX4ADN0T8DoZWwUsQDdNVli15mnIYWkQNMvwQicXR4Hy8vZ6YVUfPy4+g7jbCRzHHdKbrguDfYSjcCa+45aRNVS70cHT3X3uW+1T59VaiVjQlbFgjvSLzOhLgKFnqm8v+Xl++zSXNFGRsTt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786261; c=relaxed/simple;
	bh=rEC7ePXmBWCCbJcv7AKszCCt1Br9sfFpIwJfm/TXY4g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asPLC3ofMGVyJvdSXHnezyWsM9Y1sUgzv63dO1EKOUoB53OXVrPyZCK0Y9dXIZCbb457A+/qJN0QBPP6SBUbX4zJNeCSJLTGovDway5UMqyg/hIBLsZQVGL+IQf25YOli5VfAGafJIzECalWsc7wNdAtEuqAiP0eE9HMApByxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WSHyxhdi; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=zp4huoyvana7bgkedfyoo6pcx4.protonmail; t=1770786247; x=1771045447;
	bh=rEC7ePXmBWCCbJcv7AKszCCt1Br9sfFpIwJfm/TXY4g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WSHyxhdiixSM3C1z6It+jPKHQjp+5Bhk+G/Ru8pYsWQiT/lETMW8ENRlVzOyEgBzG
	 Bu3BSDjEa6cC7SfAReeacPKBhaAN08J3OfAqI3nx8EArYZREmkFqTqmowstuzItQ/w
	 2560sa2lT/OlWgsaDuPMrq0MbQ6qF900Oe6RcnxynbKJL15QpJ59hSUuJdTOXJ+ZOO
	 fYmbKT8nyBUOTy+Nm6PVx759xLwr0Iepj0NrpY846+9pmPV5bPM/oJozqvAgvtpuPB
	 FMDodRiLyjfNnENRq1EopaTwD861wdmaTnjdUvualI5BbUWfZjDA3PUkNHv28Q0PWY
	 Psu6DJFjW87qw==
Date: Wed, 11 Feb 2026 05:04:04 +0000
To: 1127597@bugs.debian.org, Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
From: Tj <tj.iam.tj@proton.me>
Cc: Bastien Durel <bastien@durel.org>
Subject: Regression: v6.12.67 ip6_tunnel: ip6gre decapsulation fails
Message-ID: <4157ffbe-3974-46f8-a39f-01671d86e224@proton.me>
In-Reply-To: <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org>
References: <177076023892.578113.8206759777477389796.reportbug@sunny> <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: e44812d055a8b619319ed16ba87620956de6866c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[proton.me:s=zp4huoyvana7bgkedfyoo6pcx4.protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215747-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj.iam.tj@proton.me,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: AA505121496
X-Rspamd-Action: no action

ip6gre tunnels fail to be decapsulated in v6.12.67 so never appears on=20
the GRE interface.

Reverting the following commit fixes it:

commit df5ffde9669314500809bc498ae73d6d3d9519ac
Author: Eric Dumazet <edumazet@google.com>
Date:=C2=A0 =C2=A0Wed Jan 7 16:31:09 2026 +0000

 =C2=A0 =C2=A0 ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()

 =C2=A0 =C2=A0 [ Upstream commit 81c734dae203757fb3c9eee6f9896386940776bd ]

v6.19 works but I've not been able to identify a subsequent commit that=20
should also be backported to the stable tree.



