Return-Path: <stable+bounces-212893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOIlGOPYfGlbOwIAu9opvQ
	(envelope-from <stable+bounces-212893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:14:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADABC700
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C5EA30125CB
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993C34CFB3;
	Fri, 30 Jan 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cX9OTmL5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034C349AE7
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789661; cv=none; b=Zb+/kDA4GYJIA9ce6yjo6E6HTnv6nWYB7WfSj+kPxyJZ7N5rNsGxbIq1v5shFXayDzB/StCQw6dh6yhpfpfR5W5kZnQtvuRKKJfcPfYuhau9Pm4AKwN6wZ39+uKSuH7aJ/aFTrWyoVErmUc3nu0TlwkgPHwf5ka47VcMHx8szqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789661; c=relaxed/simple;
	bh=DDT0bJbVWVtyD5zM2EzRN1dNjE9w8AQkHO+bYmweHYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur8hB0S7lXrHTdf96c6UD2RRXZkIJgSvf4l3XL2+5POU14RHGL/bC+84a3Y8H3epFFmnQ6BmkR04wJyj2b7jZWf5UDBUKjZLCJXC701wXZGU9RcReWlmunvaR5GIt/biHvlL425L/ujcY7FIJSbvTZGL6fH3ANc3n0u9QStM4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cX9OTmL5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2239864f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 08:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769789658; x=1770394458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDT0bJbVWVtyD5zM2EzRN1dNjE9w8AQkHO+bYmweHYE=;
        b=cX9OTmL5WZ+PLEgp+aHoXu1oFDrmQkPT8zChJz8oMtchZ6fs6o+6/9nyHPpYjgp796
         /yvhO/0/LfE1DOKz+NBFPCSD6dSuxDAiBSM9J2FecUEmnCcu09JqFxmWL61ciFzdQbxU
         +sk4W8iXXWS0CNeFlcsnmEctw1WISzExjXgvHR1wdfxHNHq/mXOe9mjm6mqsXbyedt5Q
         Cdkk+C3DYZFRHM3bV85dRuOwd2AHymYjBBIAZ7P1jLm/S9PIS/2L3o+N97Ud4LrEGCNk
         SqXXUi728PagbgwMKefX70Shl6xu1S6gwiwvwbjwtChFeu6ZHfqTwiQ4VmHfOvDb+Ub6
         lSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769789658; x=1770394458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDT0bJbVWVtyD5zM2EzRN1dNjE9w8AQkHO+bYmweHYE=;
        b=VR6zTGevae3SO9jS1E7svuXsyhI0Y+0AYyvHUzC0TIGqXTYJv4NNt/4HWjF5FvDILR
         JkFsP2OmkXFkSkdLCb2v1Vu2ugIx5YvrFRqW6HMNXAJWHeSpicyDmh5ia06Ko1E10DC5
         RRzeG+zjatFQBHdmJgDwiUVoYPqY5etiQqrM0445QKdokjpY3GGc9PLxSD1a0U80VY9c
         O+LLg7uRGXyQWWgI95gVqMeiBsfLvxZ4sP9xRB7NMpX+8FefCtjpR4P2VlhV9hyRQ9nl
         HZjP+B1Hs3FQjNRJJRBB96SehcqqbIfl37E++tFqG1rLBzAJO+Y9Zezzh8ov8OudM/uh
         ou8g==
X-Gm-Message-State: AOJu0Yzqq9LHIYq6887ZidNNoBbU2T3gLnya5nP28BSWSeOR+PCt1xLD
	r5iR0uOLF02N4Vb3Zs9S4ht8TbVPQugLhzdsskTIHQNeOVb7XWEmS5BtE9+4DpYuQsw=
X-Gm-Gg: AZuq6aKg82U8xXstMQDpUsfGZ2PXCW8AyKbOUuHGeSaSxeRfEe2jLFYd2J6Ll66DFQ+
	aswDu/UHVlcEX1iN/NfJAihPLKXIqdRQ2FVGlWpAPsQELcaIVyl6hyU+YGwBopjWpssNTRcpWDe
	8m07k4yG7OkKm+W4ur0ylYrr1SMrVnsgsFasMNeWL9/jMPdlg16hoxZE6wTRCAa4nGQv1G4cu1S
	DIY4uVoeQSqohr8NN/+tFYnFfZB02RH4TJSTjhMI8OUiiGuYTzI20EalKD24wiI3+ua6zPEyMnD
	DaeUMzLBn8BlZAli5klh51YG8HSFQaR4pK1YBfNJDfdwaXx5pgL2kemdVajy7tEzMIuHUS2PeXK
	n4Zc+ggM8SKcG82p4y0enWy0KzcSIERExgxi63+ez4fGJdSh1LBE+8GKyLbtEuOJVC+KJf0PDZz
	wNH7RoAZw+d8nJYjJskEgwkPO87EN5i6tSs6T4bmXP3g==
X-Received: by 2002:a05:6000:24c1:b0:42b:38b1:e32e with SMTP id ffacd0b85a97d-435f3aac886mr5782699f8f.46.1769789657831;
        Fri, 30 Jan 2026 08:14:17 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm25452401f8f.13.2026.01.30.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:14:17 -0800 (PST)
Date: Fri, 30 Jan 2026 17:14:15 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: stable@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, hawk@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] cgroup: Fix kernfs_node UAF in css_free_rwork_fn
Message-ID: <xlebwk6u4a2uwxzexxwnhwldjtgcd5gl3srtciujayegoucweq@gx5ny36x3pu4>
References: <20260129191034.3181412-1-tjmercier@google.com>
 <CABdmKX3rhV-Kn7fMg689Yo2M3f88xS5BxK+5R6G0-rEx9thBOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lexnkbxkojdohjkh"
Content-Disposition: inline
In-Reply-To: <CABdmKX3rhV-Kn7fMg689Yo2M3f88xS5BxK+5R6G0-rEx9thBOA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212893-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08ADABC700
X-Rspamd-Action: no action


--lexnkbxkojdohjkh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.12.y] cgroup: Fix kernfs_node UAF in css_free_rwork_fn
MIME-Version: 1.0

On Thu, Jan 29, 2026 at 11:11:48AM -0800, "T.J. Mercier" <tjmercier@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 11:10=E2=80=AFAM T.J. Mercier <tjmercier@google.c=
om> wrote:
> >
> > This fix patch is not upstream, and is applicable only to kernels 6.10
> > (where the cgroup_rstat_lock tracepoint was added) through 6.15 after
> > which commit 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> > subsystem") reordered cgroup_rstat_flush as part of a new feature
> > addition and inadvertently fixed this UAF.
>=20
> I am proposing we apply this one-off patch to stable rather than
> backporting 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> subsystem") and its fixes to 6.12.y.

That's a performance optimization rework, IMO too big for stable.

For the conservative stable-specific fixup:

Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Thanks!

--lexnkbxkojdohjkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXzY0xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah+vQD/cH3j1FB2MFNGkCW9bJcX
lIbreEhIUjPYK0nxLUm/RsUBAMhDHGfYmED9UTCGEmAB8W0UW+3f6+45abeEAU6L
g6IL
=BvqL
-----END PGP SIGNATURE-----

--lexnkbxkojdohjkh--

