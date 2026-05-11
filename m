Return-Path: <stable+bounces-245253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLbdCQH3AWoFmwEAu9opvQ
	(envelope-from <stable+bounces-245253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:34:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84B51140E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC4F3042946
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEA402B80;
	Mon, 11 May 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Wx2okLjC"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E81401A10;
	Mon, 11 May 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513447; cv=none; b=fYFdp+PUIWW9iDqKgyupZR3dDo9VU4uqFG3/gw3mYNamBXe/k+b97P5mb5vgEl8aPLsZ92OlrCS7MfYLKfKvR/7ya7yQXsWwjzrtFwicyQq2AzMh4dOeqoPeJZk9FXAf5ICR+D4V3W8H0+Ar/406xLPv9O6LHs1VU0JnzP7cnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513447; c=relaxed/simple;
	bh=FnGbrgcWchxKK43+wWIzf4HDhK/0euHgwPjamcdl1x4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZTmf0/sU9HqvGmM5jVf7r/Kda4ZJIxMlbaaZ5GxUoe5KRGU4gNpxtLHbrwgTkDKoVulujYRAaQrQWE3RfseeVN0FbTD+KWq5IE8k41gJalFRrjccbSk6tMIODujWDe4TmuWbLoapseQ9fRgkns4Wgm7CqVJTlg43jvvc4VF3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Wx2okLjC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778513402; x=1779118202; i=efault@gmx.de;
	bh=NCWQn2ZDOOzbcZTex4isIZKHZcd1mSINNk94wvwkSGs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wx2okLjCQWoXBo+Qwu2N9PwgHxDWgvnOxH9M4rar9eXLYb6VsL36baLZcpZ25cJU
	 QnfopnSbvKQF9/0A2ewYGXFg2i5jNlU5qxH1dV95Q92jLIIQIMGUUX1qPfspGFYNK
	 ldUR7g+grhR7s24YjiUx6/mMJ0SpyCYEWIR1C35YuBpD+Avbfwsy4NuWn8O2rapsf
	 uLhdY/W71cuAltYmjg87rW2nyccLbZ2Ovj820+1T1qS2DS0DYQ5gippFzwx7c4EhY
	 E1ZgxSu0KE+GLRM7J8cqJaHqJwe9dUk3vxhhgtYuRCIPu1mzY+6iaV9mK6zpMmymY
	 HAbDh+pn21hexnQxng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1wogfD1tlp-00OBDf; Mon, 11
 May 2026 17:30:02 +0200
Message-ID: <72333205daf4663b6bd133efa9766c7cee7b22ef.camel@gmx.de>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised
 wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
From: Mike Galbraith <efault@gmx.de>
To: Sasha Levin <sashal@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, Lukas Beckmann <lbckmnn@mailbox.org>
Date: Mon, 11 May 2026 17:30:01 +0200
In-Reply-To: <20260511141441.stable-reply-0001@kernel.org>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
	 <20260511141441.stable-reply-0001@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Dbvbhv0H6J1TilgRn0sneQjMh2C6vcPhUH1VmKWRqByOX3Pp9Pa
 3ScMlm3zV8g9VxeQVJSFezhoVMuwhh6JhvX19/eJBxZqB9hJdEyd8ps9wImTWjwxNZDSgMp
 6YKSDQKo4Q2qh/foY88trvj+ipIcuf5T6wpatC/36gzu/gSZbu9grzVnjK4L/vFy9xvjHTn
 2hhuqtv2N6g9bu0zuyunA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:foBmjayto0E=;vZvKxesVJJU/R0973hArEWqdhZ/
 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
X-Rspamd-Queue-Id: BF84B51140E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245253-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 10:21 -0400, Sasha Levin wrote:
>=20
> Mike's reply notes that his local 6.12-rt tree carrying the following
> three commits in cannot reproduce, while the same tree without them
> reproduces quickly:
>=20
> =C2=A0 cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
> =C2=A0 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> =C2=A0 a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")
>=20
> d66792919d4f's upstream commit message explicitly says it relies on the
> state established by a3a70caf7906, and none of the three are in 6.12.y.
>=20
> Could you give those three commits a spin on top of 6.12.y (keeping
> d66792919d4f in place) and see whether the latency goes away?

I've meanwhile tried those three alone, and the size XXL hits my box
readily reproduces in virgin source do indeed go away.

'course there may be another shoe, so...

	-Mike

