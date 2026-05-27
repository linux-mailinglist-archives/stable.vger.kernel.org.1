Return-Path: <stable+bounces-254463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPPjLmFOFmqxkgcAu9opvQ
	(envelope-from <stable+bounces-254463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:52:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 402665DE669
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9667F300D166
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A160340A51;
	Wed, 27 May 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+A24DLo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53F1DE8BE;
	Wed, 27 May 2026 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846746; cv=none; b=Y5v38DhATY2I49X70ygXFpDmoQaYBgGQOQ8v9ma+ZA2+JAt8sio04rL5HonH+reBzAsGWWYazZau7mSwfu9fBYWvpnwp5Ac3oZPKyPYmYV/lcfz6uV8XFzav0RwwoPSpdryEWJHX7ri5Ed0YBOkNd6MjuHFkwqOmHVSrz/u4nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846746; c=relaxed/simple;
	bh=UDAcpjL2oOcJxLhXi2al6WtU3AXg283KNysvaLHdkek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQnyik8TdcbzXiBxYqkRVD/m+M0bPcfakKeX+DhTnTuetoh1444JSAkhrniESfdB7FSysNXriCV1vSZWM4chG34dRbXUtU1x85lPZhkggvCmyvFCwiY6j/7cwMxwduV45ZIrCYkefUutdMN59ehkYr7hEhYRj7Wfvh8BU5cs6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+A24DLo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7001F000E9;
	Wed, 27 May 2026 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846745;
	bh=UDAcpjL2oOcJxLhXi2al6WtU3AXg283KNysvaLHdkek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U+A24DLo/tfym1svEC5T3RrNpCRjtXYEnJPpXbohkhrim+floYLLMDWiyHLMnk2kG
	 b6ROEsF9z7oC6EtvtTSIQUT5fMk5aVfIoBkBXn1/t4h0w4PVXR15HbTwgAJ2uGEBm5
	 6/otmkTYZE002qzJ7DIgmNKirSXEThxGgYz8SuHjwYrNxLtAedVqnZlPOMlfaa5FZw
	 Ec9NgAaro2cmYBmVZPsZMKy2sUUWih/6rCzDI1Z23z7G7Ymu/0KIwoqa5lKW9CdG3Z
	 nxN8KDfLAtNzruEEAkWnPK0v+Cve3umN36sZCid6wplCXNomFl7905pZRsdIMhj3Ep
	 LCPKIeuNKbeEA==
Date: Tue, 26 May 2026 18:52:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuhao Jiang <danisjiang@gmail.com>
Cc: Junrui Luo <moonafterrain@outlook.com>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE sharing to
 same PF
Message-ID: <20260526185224.0c65e38a@kernel.org>
In-Reply-To: <CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
References: <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20260526180233.4323832d@kernel.org>
	<CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254463-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[outlook.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 402665DE669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 20:46:46 -0500 Yuhao Jiang wrote:
> Hi Jakub,
>=20
> I worked with Junrui on discovering this bug and preparing the patch.
> I found the bug and reported it to Junrui, and he helped write the
> patch. There may be some overlap with other work.

Please don't top post on the list.

Junrui, please describe your discovery process.

> On Tue, May 26, 2026 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sun, 24 May 2026 15:29:29 +0800 Junrui Luo wrote: =20
> > > Reported-by: Yuhao Jiang <danisjiang@gmail.com> =20
> >
> > Really? I thought I saw this reported in Sashiko..
> >
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260520154157.1439=
319-1-michael.bommarito@gmail.com
> >
> > Either way, Marvell folks - please review. =20


