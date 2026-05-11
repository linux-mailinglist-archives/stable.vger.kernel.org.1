Return-Path: <stable+bounces-245096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UrRgAjJuAWqPZAEAu9opvQ
	(envelope-from <stable+bounces-245096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695450849B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3F4300D46C
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5332377563;
	Mon, 11 May 2026 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="s18R2b6a"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54852264D9;
	Mon, 11 May 2026 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778478634; cv=none; b=Tw8wxI5NEzeXP0LOmo6iD9ZMs34mRg8x8H5B1LgM25Cjc1Pv/tfUY46l28RBKPufdWH/n2YkFw08Pg/RnynXCGcoJ/p7TktoIdAoGDDfbG+0Qbr33SZx/FbIcuPDcMcNAtruTobTLQLTyR7l/vRBclPUUSZzJM6Tmj51T96nb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778478634; c=relaxed/simple;
	bh=hITaVkmTUBwCX42V4U+BzWMAmlOZGLB3u3tO8Pxt/80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZJ+0ZoIBOI5ny/RfZwBPddfWzMOArQOy1+AVEMIaAuIgRHZfll1ytpBBq1+GQZ+npnfNgxlQUdd7HWIq94SjrBbmbu7AfhFkFDKiiXSh3BTHgfbYoK8aP9WuPA02sSbeYLdSr4VEt/RS8HYjVfOz3claJ8Dh/ewCsGkfJw+8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=s18R2b6a; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778478612; x=1779083412; i=efault@gmx.de;
	bh=UEEAxBRGXRa1cHSDWDSr8aXCOwVXFh53F6kM/lSIswA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s18R2b6aiVdl8RJ8X+Gve3Qga5Z3CH1wiH/Dvag8UkfILAUgp7WqQNbhUIrSadg7
	 W6e4LfYhJrXi52j7tLJuAYSy2f7eiLPy312AiEBcMxr20yqJNw8glQIvGkysFmqq9
	 InyZNYeoWXleiWNLWxmyEWsDD+kkK529AjypApowYRQXPzcIPLqt6/Lpm7qRpaaN2
	 KmkDciAZ1Qqvyaq+5mv9YqgYDekhgjoxyHc2ZcXw8S1EAcvxDVaTD+NhtSdenric0
	 SvVteMLagPlsc4lLUKl/v11lKpsD1CZC9T87WQ0TDB12klkEYFtoZd7cpuzbOV8op
	 shlahfoMuOr7idDzZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1wflIA3thR-00Y3A9; Mon, 11
 May 2026 07:50:12 +0200
Message-ID: <c3120aeed5b0bc34e96e39a9494986aa0fedd332.camel@gmx.de>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised
 wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
From: Mike Galbraith <efault@gmx.de>
To: Lukas Beckmann <lbckmnn@mailbox.org>, Peter Zijlstra
 <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>, Sasha Levin
 <sashal@kernel.org>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org, 
	linux-rt-users@vger.kernel.org
Date: Mon, 11 May 2026 07:50:10 +0200
In-Reply-To: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:UJsqE6cITQCeGD1xwNumGYt+t2NS3uQ/NbVTwASzZryTUjawul5
 1nQvKGt4R4cpMqtcQ7KTj2382cQ9ISLX2rimmbYqNYgxqSSRy5S9oI3z/cmeUlNSugY4Xn8
 bH0YkoI/ab6UUYYxTF3uXD1zbp8H2Tgd5W40yEsfk/diSxg2K5snN7fQ9zoC3CcHjHnc30i
 rqE26JWyYw4+9fbjppO4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JrAeleBm9ng=;lwLr2GBZDtlzaRvptRmxpsPUING
 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
 lzkkLGQhzyNe+vSKNYFVyn4/GGJ06PH7Pcw0=
X-Rspamd-Queue-Id: 4695450849B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245096-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[efault@gmx.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 2026-05-10 at 22:57 +0200, Lukas Beckmann wrote:
> Hi,

Greetings!

> I am reporting a regression which was introduced by d66792919d4f on 6.12.=
y.
> Since this commit, cyclictest reports latencies up to 50 milliseconds,=
=20
> on kernels with CONFIG_PREEMPT_RT=3Dy.
>=20
> Steps to reproduce:
> 1. run a load (e.g. stress-ng --cpu 4 --io 2 --vm 2 --vm-bytes 128M)
> 2. run cyclictest (e.g. cyclictest -a -t -m -p 80 -i 250 -d 0)

...


> I found this, because Debian updated its rt kernel from 6.12.74 to 6.12.8=
5.
> The issue was also present with upstream 6.12.85 and HEAD, but not with=
=20
> 6.12.74, so I started bisecting and eventually found d66792919d4f.
>=20
> Is it possible to revert the commit?
>=20
> I can provide traces or help wth testing if needed.

FWIW, my box says this *may* be due to a fix (+follow-ups) that didn't
wander back to stable.

cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
   Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")

Follow-ups:
4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")

Local 6.12-rt tree containing the above (et al) failed to reproduce in
the hour I let it try to, whereas a build excluding only all locally
added fix backports reproduced in fairly short order.

Suspects NOT confirmed in total isolation...

	-Mike

