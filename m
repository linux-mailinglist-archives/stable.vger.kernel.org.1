Return-Path: <stable+bounces-215791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iINdHhRsjGlmngAAu9opvQ
	(envelope-from <stable+bounces-215791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:46:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D0123F23
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E92783027320
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749FD313277;
	Wed, 11 Feb 2026 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=durel.org header.i=@durel.org header.b="LpTSdIe7"
X-Original-To: stable@vger.kernel.org
Received: from arrakeen.geekwu.org (arrakeen.geekwu.org [109.190.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97D13D638
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.190.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810370; cv=none; b=cHXxSC56SUTdprDC2bfqZ0SYVh6ZIu4Ky9T7TFbVXuuMjjk3wVT2aidYi6Br2dhnXkWAm31wnuf6YRgCBy4HVmlp7dC9A1QlPFFZkWCPn010+laPG0sMt/YEhAnDpGQB86T/SbTBytogXru6UbHkNwAc42oxTK5gZ+OIw+9sS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810370; c=relaxed/simple;
	bh=Tvw92uNRvYOHcD5vw8pDB+Qt9B7MDCwoMbPJd+UKhdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OeqMbrnfjQZNC3J8/2Hl+qOmrmPe5/S23SkWzaAaF7rcAuzHrMDwcpronLhJanfyjjiavpotVzcNWWdmRg9zOGIBWeFWY3ZMrQDALcyCLwshvQ7hq7lAdNOEF0WeVc3m4TJSJgyF0JZLlqfmvUFsAlYd7N4Fsaby+fEmHXEk7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=durel.org; spf=pass smtp.mailfrom=durel.org; dkim=pass (2048-bit key) header.d=durel.org header.i=@durel.org header.b=LpTSdIe7; arc=none smtp.client-ip=109.190.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=durel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=durel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=durel.org; s=halleck;
	t=1770809705; bh=Tvw92uNRvYOHcD5vw8pDB+Qt9B7MDCwoMbPJd+UKhdw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LpTSdIe7jLxl3FfojyS7LAESedXl2PN0ImkAzzHU843t3QTefjhvuAw8YUavLUr6n
	 9f3+ydZTzIEu6V2VmZQFp6cgbVwHjaGljqnaOxeGBMn6kZ8FDzLqmm5v3IQfuEqEWA
	 DU/upAVu4rGUS8Ari03DnHoOG9S/TKwp8araQElqMJpuxjHgwu01b7kwham4PRSN30
	 oSv8VY+btsYQn6dw1+nJdsZzwW+tt+RdO1k3gmYrq+l32qyHtO/7wLbocri9AN2/Br
	 +lbD9SfEMdsQvrLhAO69mCKJSc16MnM0noOhdU7ceIwIw7gQmwHiKIwR9j2AOU67SV
	 Z0Sv71W5tvgzg==
Received: from . (unknown [176.178.84.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bastien)
	by arrakeen.geekwu.org (Postfix) with ESMTPSA id 8F7B67E0A6;
	Wed, 11 Feb 2026 12:35:04 +0100 (CET)
Message-ID: <2f916548d1671131bbba7f209b95c83830fd46de.camel@durel.org>
Subject: Re: Bug#1127597: Regression: v6.12.67 ip6_tunnel: ip6gre
 decapsulation fails
From: Bastien Durel <bastien@durel.org>
To: Salvatore Bonaccorso <carnil@debian.org>, 1127597@bugs.debian.org, 
 Tobias Fiebig <tobias@fiebig.nl>, Manu =?ISO-8859-1?Q?Beno=EEt?=
 <tseeker@nocternity.net>
Cc: Tj <tj.iam.tj@proton.me>, Eric Dumazet <edumazet@google.com>, 
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 11 Feb 2026 12:35:03 +0100
In-Reply-To: <aYwyKiycDDI05Bkd@eldamar.lan>
References: <177076023892.578113.8206759777477389796.reportbug@sunny>
	 <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org>
	 <4157ffbe-3974-46f8-a39f-01671d86e224@proton.me>
	 <177071383551.15684.7212803445896238445.reportbug@arrakeen.geekwu.org>
	 <2026021138-gleaming-overarch-7e6f@gregkh> <aYwyKiycDDI05Bkd@eldamar.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[durel.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[durel.org:s=halleck];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215791-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[durel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien@durel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC3D0123F23
X-Rspamd-Action: no action

Le mercredi 11 f=C3=A9vrier 2026 =C3=A0 08:39 +0100, Salvatore Bonaccorso a
=C3=A9crit=C2=A0:
> Hi Bastien, Tobias, Manuel,
>=20
> On Wed, Feb 11, 2026 at 06:29:56AM +0100, Greg KH wrote:
> > On Wed, Feb 11, 2026 at 05:04:04AM +0000, Tj wrote:
> > > ip6gre tunnels fail to be decapsulated in v6.12.67 so never
> > > appears on=20
> > > the GRE interface.
> > >=20
> > > Reverting the following commit fixes it:
> > >=20
> > > commit df5ffde9669314500809bc498ae73d6d3d9519ac
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:=C2=A0 =C2=A0Wed Jan 7 16:31:09 2026 +0000
> > >=20
> > > =C2=A0=C2=A0 =C2=A0 ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_=
tnl_rcv()
> > >=20
> > > =C2=A0=C2=A0 =C2=A0 [ Upstream commit 81c734dae203757fb3c9eee6f989638=
6940776bd ]
> > >=20
> > > v6.19 works but I've not been able to identify a subsequent
> > > commit that=20
> > > should also be backported to the stable tree.
> >=20
> > Please see this thread:
> > =09
> > https://lore.kernel.org/r/CANn89iL5ksZZCJr7SK9=3D4Sw6EejdOzr5_m6pBMM
> > 8RVtbLy_ACA@mail.gmail.com
> >=20
> > I think that should fix this, right?
>=20
> Can you test building v6.12.69 (or the Debian kernel, see
> instructions
> below) with the attached patch which would be the above mentioned
> fix,
> and report back here?
>=20
> Manuel, you mentioned you see the problem as well on 6.1.162 (where
> ineed the patches were backported as well), can you double-check as
> well that the patch fixes your seen regression?
>=20
> To build the Debian kernel with a single-patch on top applied follow
> https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html=
#id-1.6.6.4


Hello.

I built a new kernel following these instructions, and it fixes the
problem:

root@gre-test:~# uname -a
Linux gre-test 6.12+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.69-=
1a~test (2026-02-11) x86_64 GNU/Linux
root@gre-test:~# ping fd3c:aa96:f408:700::1
PING fd3c:aa96:f408:700::1 (fd3c:aa96:f408:700::1) 56 data bytes
64 bytes from fd3c:aa96:f408:700::1: icmp_seq=3D1 ttl=3D64 time=3D2.55 ms
64 bytes from fd3c:aa96:f408:700::1: icmp_seq=3D2 ttl=3D64 time=3D2.42 ms
64 bytes from fd3c:aa96:f408:700::1: icmp_seq=3D3 ttl=3D64 time=3D2.36 ms
^C
--- fd3c:aa96:f408:700::1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev =3D 2.362/2.444/2.551/0.079 ms

Best regards,

--=20
Bastien

