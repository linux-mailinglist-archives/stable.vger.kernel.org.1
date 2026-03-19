Return-Path: <stable+bounces-227313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBxyGkEKvGkArgIAu9opvQ
	(envelope-from <stable+bounces-227313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:37:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C6E2CCF91
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75C59300DD6A
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D13CCFDC;
	Thu, 19 Mar 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JCbdqHdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yyJkujny"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B335DA67;
	Thu, 19 Mar 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930645; cv=none; b=bLekP9pZy3cUKP0Oq71qX+lKoKgRzfBwc+fDOkADQpOaY6vBj7uGtyCVBazE4ElD76dwzwurUR0DvMvpwG8Z+GfljKl5e45+8VDB2f9m6vUXgBq1+nqU4hbRC7fq5k6klWo0tkLs1U7oitOM+Y97dLd5pf/ujoaCkN4sfHMRGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930645; c=relaxed/simple;
	bh=Tc1rDkH3+UiS6QBT1k2JXzUFq1OvHy6pwiSd1/PUFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koPa0vzgitRGfjBXNAfNO5c+D9eS0G2oZJYEkXQ95zIk5gF+hasnn0U+9Wc/kANdP/ri0iB/N/PyEqVENXh68ueF+mjMduoJxWoBFgGlDxZOeB2MS69RW0aR5M9WgJGB/2tgtmIfKbK9ZEmMJdHwXXcqwLDTNB23STqJKF1fd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JCbdqHdE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yyJkujny; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A8151400204;
	Thu, 19 Mar 2026 10:30:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 10:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773930641;
	 x=1774017041; bh=d8H4MdzzItKEf3ZYCkEG3VbvnFnz+wY00IZL+Df1u5Q=; b=
	JCbdqHdEm5582iLKjH4zLt7GL3O6rxvYSTEUXBLo6xbMLHF5NJitkG/UiaedfD4k
	9xOWSf9twNxfNFrLy6tMKizYfnGiJLHbtiadarQifbEZPMPU7uMtbTkd2HsJHwOS
	m0l/WqEuWaa6DaMMVz5kJnfZVELz1JEucjUbvtatTXBX8YN3xHl4XBhSPJ8SX1w0
	7DyAoeHqTCmmgDq4Kymw4A+BCqQbRe7pljJORShbLcVyKm5ImEe4igIL+MqD0izS
	6ZPFxZM3UUUWuohOb2EcuxyYbKuZCLuVzhllrdzHva9QnnpQ06U0RhftF2Q7eKyF
	x51STR3QyfDSpy9fI4ZCLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773930641; x=
	1774017041; bh=d8H4MdzzItKEf3ZYCkEG3VbvnFnz+wY00IZL+Df1u5Q=; b=y
	yJkujnyo+GYnZY5NyPW0k/KebDotyHYON4PnY7dsIs+8F2enWMC1cWh/bcnvdcBf
	K3iv3qraxQXUr0E6BvSpznWE/hVxHe+KlgCyeqWC+GExpdwaDcQrMrhdZSrjQ3MG
	sQzKpHuwDPB/q4np5JNH9KxZNeyVTUqsKc1jmGYsR+fUY1VkNDl+FHzr6coJSemJ
	pU3oe0uAB62wX0EsLFGe86SAvu0m1RFGLiqrsgPHOOKuowplOK2vCG2ZB2y0XIqo
	mNntX0vLdgibLoqzx6DjRTT4GX9uQU4N+I7A/OO2j+tApeKFZOX7kZXNyxJudbkw
	svUsQA0zKYX6Gbr3Q2IBQ==
X-ME-Sender: <xms:kAi8aWxCzB4oj9qvhU3esZdMp8zqtenTVFmX8Pf2bpg1pcvi6l4mXQ>
    <xme:kAi8acWvgtYDs6MM_33Y6CgoMuRXbYEkG3lEL7YoJVnyduLQQ5JWXsF9nRjSe5A1R
    -hf9TAINyzcqcSW6LUfs_ZiShP-Io5Mw7gwPbcsRMEoqBpFtWe9ug>
X-ME-Received: <xmr:kAi8aYMwBhMQEu6bteUrMu-cgLEZcTunq9wvDh6fo9Uz4Z_YW084Clq5Zuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqheftdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeihfduieffvefhffehffejjeetveetgeeugeevtddvieehveduteetfeei
    tefgffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhgsohhonhgvsegrkhgrmhgrihdrtghomhdprhgtphhtthhopeguvghvnhhulhhl
    odhmsghoohhnvgdrrghkrghmrghirdgtohhmsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigs
    ohhtrdhorhhg
X-ME-Proxy: <xmx:kQi8aeBUZYqrs6MiJOjRP04GfrpfTANFxnlA2ivHcsjTr_K-aP1tIw>
    <xmx:kQi8aVchcwnBxEToddbJQO9QXxO5AngaID_YWOc-PgKs-lEfgi6-tg>
    <xmx:kQi8adN5FhmIxz--rfi7TEvn_030ExP8wiZDuPjU5e2Fu7d89Fb8Zg>
    <xmx:kQi8aVL_x1A5JY2IyMGGSm_fXwAj4ErOix2ZJE-xcf-jVEJ2NemoAg>
    <xmx:kQi8aZPNSyDMAgjsh1Srr_zbittOJigSTya-OEhDIT8-Htd7nHECpRvc>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:30:40 -0400 (EDT)
Date: Thu, 19 Mar 2026 08:30:39 -0600
From: Alex Williamson <alex@shazbot.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Boone, Max" <mboone@akamai.com>, Max Boone via B4 Relay
 <devnull+mboone.akamai.com@kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio/type1: Retry follow_pfnmap_start() when PFNMAP is
 zapped
Message-ID: <20260319083039.03865989@shazbot.org>
In-Reply-To: <45e50068-751c-4e8c-a6b0-62cf8d1e58e6@kernel.org>
References: <20260317-retry-pin-on-reclaimed-pud-v1-1-1f0d0a23f78d@akamai.com>
	<20260318152249.43eb81f6@shazbot.org>
	<3C8F924E-CA2D-4368-83DF-3CCCD4BA49FF@akamai.com>
	<45e50068-751c-4e8c-a6b0-62cf8d1e58e6@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227313-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,mboone.akamai.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,shazbot.org:dkim,shazbot.org:email,shazbot.org:mid]
X-Rspamd-Queue-Id: 02C6E2CCF91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 14:18:49 +0100
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 3/19/26 09:36, Boone, Max wrote:
> >=20
> >  =20
> >> On Mar 18, 2026, at 10:22=E2=80=AFPM, Alex Williamson <alex@shazbot.or=
g> wrote:
> >>
> >> [=E2=80=A6]
> >> =20
> >>> + /*
> >>> + * follow_pfnmap_start() returns -EINVAL for
> >>> + * invalid parameters and non-present entries.
> >>> + * If that happens here after a successful
> >>> + * fixup_user_fault(), it is likely that the
> >>> + * pfnmap has been zapped. Retry instead of
> >>> + * failing.
> >>> + */ =20
> >>
> >> It's a little stronger than that, right?  We're betting that the only
> >> remaining non-zero return is due to a race and we can introduce what
> >> appears to be potential for an infinite loop here because -EAGAIN will
> >> get kicked out to redo the vma_lookup() and fixup_user_fault() should
> >> return a genuine error if we're completely in the weeds.  Should we
> >> make this a little stronger and more specific?  Thanks, =20
> >=20
> > I=E2=80=99d say that the best case would be to have follow_pfnmap_start=
() return
> > -EINVAL or -ENOENT w.r.t. which of the two return values it is. But then
> > again, we could theoretically run into an infinite loop I guess - as th=
e zap
> > and faulting could run in lockstep (the race window is extremely small
> > though). =20
>=20
> Well, in theory :) To hit that race repeatedly, you'd really have to be
> quite lucky I guess.
>=20
> But the real question is: if user space triggered the pinning, and user
> space keeps hurting itself to make progress, is that a real problem?

I'd say no, that's not a problem.  It's really just that masking all
non-zero returns as -EAGAIN makes some assumptions about the other
error conditions that could change over time, so minimally those
dependencies should be clearly stated.  Even better would be if we
didn't need to make those assumptions.  Thanks,

Alex

> I guess the crucial part would be to
>=20
> a) Have some cond_resched(() in there?
> b) Checking for fatal signals somewhere?
> c) Possibly drop locks (mmap lock?) every now and then?
>=20
> For GUP, a) and b) are in place in __get_user_pages().
>=20
> c) might be done, but I think it's less deterministic.
>=20
> >=20
> > We could make the retry above bounded, and bubble up a -EBUSY such
> > that users of the ioctl can decide to retry instead of fail? =20
>=20
> Would that be a possible ABI break? You'd really have to only do that in
> a case where user space does stupid things, I guess.
>=20
> >=20
> > David, you mentioned that gup already has retry logic that we don=E2=80=
=99t have
> > with follow_fault_pfn() -> follow_pfnmap_start(). Would we potentially =
run
> > into an infinite loop with this change? =20
>=20
> GUP triggers page faults through faultin_page(). If handle_mm_fault()
> returns
>=20
> * VM_FAULT_COMPLETED we return -EAGAIN
> * VM_FAULT_ERROR we return the error
> * VM_FAULT_RETRY we return -EBUSY
> * Otherwise 0
>=20
> In the caller __get_user_pages(), we
> * Retry immediately with ret =3D=3D 0
> * Return to the GUP caller (letting it retry) with -EBUSY/-EAGAIN
>=20
> Having at least a) and b) sounds reasonable. Not sure about having c),
> might be tricky if we are not allowed to drop the lock.
>=20


