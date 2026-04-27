Return-Path: <stable+bounces-241437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICKmK/LC72mLFQEAu9opvQ
	(envelope-from <stable+bounces-241437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:11:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33473479BB8
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682C33009CDA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F033043BE;
	Mon, 27 Apr 2026 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpgqVfge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92B2DFA2F;
	Mon, 27 Apr 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320674; cv=none; b=eLqsf3M+1asLMpPFcQjQUIjumKARiXcxE+mx/H7eTh2EWgs4aY3gDdyncr7nmEic2rHId+mSHc3Lhrj2+BZB1iqgczRLBiAbnikd/bP+hjVzu5a5ls+OxXZBDlmlpIEYSjRFUuvC6CyK4Fnx+rnrDenE2ZVN2xiMoSW4RIONXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320674; c=relaxed/simple;
	bh=X/CYRS500u4vUw2Wjrj4cW7tYesg/9YvkrNkGyKKN3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZaVQrGiIan7ss/r+64N8DuaO9Go1KuBeAIsbgADx4oJ8iy4UuxKZJ7XfylsU7hBE5/ZKdPrzceO0+Ex1YNiOFQelyxlVR5gz7ziXMsKtkEa1zLvwsliecg5PqQ9fQGA4rY/c1I+2R6MnHLeeTtdWMjIWvtlmsMHNooV1Uq9wa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpgqVfge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC3EC19425;
	Mon, 27 Apr 2026 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777320673;
	bh=X/CYRS500u4vUw2Wjrj4cW7tYesg/9YvkrNkGyKKN3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mpgqVfgeW9zwS7byqzGdbSi+wM6NIvR2xbqtxSeN8fLgGXYu8MFmt4TRU4fGFuPLr
	 eDTI53uEbkfqOXy6oYAIqxs93ikBqOFcrjs6W1RUBdCJAGzN9DU5CNJEveyzf42jB6
	 urdjNVEhcC6N409drey3jCX5bNv9xldQ0pqUwokQ1asAWli9K8UWjI8ZyH4crTjX7C
	 DL3SuTHSMC4BgODH/hrMgp8RCkJmF5qhwNd6CKk0P3q/y24mINXtQuVN4J7V64B0cL
	 /ZaQE7ui1lt3O6nA6NeY5GwCvgordGqFYwSHNqYXVxBTYOqcdmBJbDGlR71AVMn+Ia
	 QSnPXa9jp8olg==
Date: Mon, 27 Apr 2026 13:11:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ankit Jain <ankit-aj.jain@broadcom.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, pabeni@redhat.com, horms@kernel.org,
 quic_stranche@quicinc.com, quic_subashab@quicinc.com,
 linux-kernel@vger.kernel.org, karen.badiryan@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
 tapas.kundu@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is
 locked
Message-ID: <20260427131111.168ed0dc@kernel.org>
In-Reply-To: <CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
References: <20260427152756.1205-1-ankit-aj.jain@broadcom.com>
	<CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 33473479BB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241437-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 08:38:44 -0700 Eric Dumazet wrote:
> On Mon, Apr 27, 2026 at 8:32=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadco=
m.com> wrote:
> >
> > When an application explicitly sets SO_RCVBUF, the window clamp should
> > not be dynamically recalculated based on the memory scaling_ratio.
> >
> > Currently, tcp_measure_rcv_mss() aggressively crushes the window clamp
> > down when it sees a poor skb->len to skb->truesize ratio. If the
> > application explicitly locked the buffer via SO_RCVBUF, this
> > recalculation causes the advertised window to drop severely.
> >
> > If the window drops below the interface MSS, it triggers Silly Window
> > Syndrome (SWS) avoidance on the sender. The sender defers transmission
> > and drops the connection into a perpetual 200ms PROBE0 timer loop,
> > drastically reducing throughput.
> >
> > This is highly reproducible on loopback interfaces (MTU 65536) using
> > Java-based workloads (like Tomcat/GemFire) where the JVM sets SO_RCVBUF
> > to 32K or 64K. The bloated loopback truesize forces the scaling ratio
> > to drop, crushing the window clamp to ~26K, instantly triggering SWS
> > stalls and causing gigabyte transfers to take minutes instead of
> > milliseconds.
> >
> > Since the application locked the buffer, the kernel should respect the
> > clamp boundary and not dynamically crush it based on runtime ratios.
> >
> > Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> > Cc: stable@vger.kernel.org
> > Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
> > Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com> =20
>=20
> Make sure to add a selftests (in ./tools/testing/selftests/net/packetdril=
l/ )

And I think it makes tcp_rcv_neg_window.pkt fail

reminder - please wait 24h before posting v2 on netdev, and when posting
v2 start a new thread.

