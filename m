Return-Path: <stable+bounces-244292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LGGGvKd+mk8QQMAu9opvQ
	(envelope-from <stable+bounces-244292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:48:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491604D56BA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 328793022633
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C5626ED3C;
	Wed,  6 May 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rRGzpZAY"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C7257845
	for <stable@vger.kernel.org>; Wed,  6 May 2026 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032080; cv=none; b=jbS+r14Jtz4IxnpKmRt+3TGo+ebPsFhvgOKGU5mum0pq6SqRoFRax0nXIELMCFGNxdcigKm0KI1PSGPXv8XgqdRdJfYqkdJzOgOOE6VDsrarbla6VcLyisXVAUlaql8fMa5JprVjMi99Evgz5pBaQzciVEE+piq//aiu6KE3aZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032080; c=relaxed/simple;
	bh=kvdHMyUd6HY5+NQcA5vYvtKaKFSt4PICTJ5L/NBuFJ0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XRoAXRgj2W7iv/dca630E6lWNmhNPGT/GIVO8Qdchm3z+eYlXaS7mUTKRK/mY8EOcKeDLCBbkmYzFARklWvDwkG9ceOeW/kLJRfyznFH1k5JHvOIfL+lZYLEBOl0LN6Jw5+7KuoICIOaGCotK0zl5TSRWjmTkc6mifZ9X5ubg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rRGzpZAY; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778032066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNoa+/5rxK6oL7CPWgtRiawwuEPcZV3Ro2C5ThlSBKc=;
	b=rRGzpZAY17+MRtxkHu2mTdfJOa8QVdR/mblVV8XxsniSrCqgaGxdjWf3uF4zd04ZxZesRv
	z71mlxAlsQWuus65rVydG2bjHIzBrn6GBSw2soraNqbHwMjbYBNkNSyq4dVsyb9OF+agny
	qXN43FewaiDFGwkV+Tym4xETGrrgM4w=
Date: Wed, 06 May 2026 01:47:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <3c8a7577bcdd2cfb50d7a90c4779c8023a6144fb@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 6.18 214/275] mptcp: sync the msk->sndbuf at accept()
 time
To: "Matthieu Baerts" <matttbe@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Gang Yan" <yangang@kylinos.cn>
Cc: patches@lists.linux.dev, "Paolo Abeni" <pabeni@redhat.com>,
 stable@vger.kernel.org, "MPTCP Linux" <mptcp@lists.linux.dev>
In-Reply-To: <68c8f2a7-6149-4b65-bb1b-0ab4cd4067cf@kernel.org>
References: <20260504135142.929052779@linuxfoundation.org>
 <20260504135151.022829547@linuxfoundation.org>
 <1bbeee9b-b69b-4be9-84ee-ddadda4793ef@kernel.org>
 <68c8f2a7-6149-4b65-bb1b-0ab4cd4067cf@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 491604D56BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244292-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gang.yan@linux.dev,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

May 6, 2026 at 1:50 AM, "Matthieu Baerts" <matttbe@kernel.org mailto:matt=
tbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E =
> wrote:


>=20
>=20On 05/05/2026 19:16, Matthieu Baerts wrote:
>=20
>=20>=20
>=20> Hi Greg, Gang,
> >=20=20
>=20>  On 04/05/2026 15:52, Greg Kroah-Hartman wrote:
> >=20
>=20> >=20
>=20> > 6.18-stable review patch. If anyone has any objections, please le=
t me know.
> > >=20
>=20>=20=20
>=20>  Please drop this patch, it looks like it is introducing regression=
s on
> >  v6.18:
> >=20
>=20(...)
>=20
>=20>=20
>=20> @Gang: could you eventually have a look, please?
> >=20
>=20FYI, I quickly checked, and I noticed that 'subflow' is different on
> v6.18 due to the "mptcp_for_each_subflow(msk, subflow)" removed in
> 68c7c3867145 ("mptcp: fix memcg accounting for passive sockets").
>=20
>=20Moving __mptcp_propagate_sndbuf() a couple of lines above, before the
> for-loop, should fix the issue. I can eventually look at sending a patc=
h
> with the fix.
>=20
Hi=20Matt,

Thanks for the quick check and fix! Much appreciated.

Cherrs,
Gang
> Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>

