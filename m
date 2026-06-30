Return-Path: <stable+bounces-269964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yOfaB9C4Q2oifwoAu9opvQ
	(envelope-from <stable+bounces-269964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 14:38:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D546E4403
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 14:38:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Yt/5L7H/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269964-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269964-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684EF300B8D4
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6740BCCC;
	Tue, 30 Jun 2026 12:37:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23540B6F9;
	Tue, 30 Jun 2026 12:37:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823077; cv=none; b=Abs/OZC6gev9qchWZvfMxV3o2ud7maQyotbHB5TxQJHOavzl9bLiEj87LJ94eFBM2tzQhgd4BTGK+46k08rVOsro/si1tqrUgfip/yljNW2V3NpsdZI+E6DU96DAjA1/ahgcBvr4LXkIWpiILu0I8Empg4k//TC3gFe6neUcegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823077; c=relaxed/simple;
	bh=gFrSgFmeb/xqCopXlwbbqo/0obZElfXwNWbu9ZgZAes=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=VBdn7t/T8K2AMuYg+Fo+iajERZQ3oHrngY2fhM8j1V4YSoJkjBlCbzRvXV5Rm0b0+TWbPb+0PbtlCrlQFbYdbl/v1G9s9HS4gVdfoF/1Hsh6qDrUhutdIvzTSAeQwE+Fb+W/0gC3SCsTtLkcf8/SyjxxQXWWvxY8FZbGEaXqh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt/5L7H/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3541F000E9;
	Tue, 30 Jun 2026 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823075;
	bh=gFrSgFmeb/xqCopXlwbbqo/0obZElfXwNWbu9ZgZAes=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Yt/5L7H/IkbJ9HNCJOdZa23vVb/ZtSnHchmYg+O3goLpkPlSXZpYXob7ZCcB/3dIL
	 TUl9LNgwWQNx527FTikZLkkz3u9bW5U5/VcwQnkW64KB/061DouY40i3ITsBDfpWG5
	 cF2oCQnEkUZ648ANOj0HejnPcVkywnjSwNY4UmSWADyjLg2GwaF4ZNvjq3uPquvVIL
	 XKp8LdwYFmIUAoCALE7z3PMSPeUZtbpToOlz6y3Cn5qtQsuooA8EeBSWhrRoGmh5sv
	 3Q/Pct2EoLle52uw8PfTNHu2qVs+i7VTfFh6qP1EarbnGLq/wrLfVw8392mSHz9t1p
	 FrPmsXWXe4PEA==
Message-ID: <b10ed22795de18c499f444e3ce8f3756@kernel.org>
Date: Tue, 30 Jun 2026 12:37:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Romain Gantois" <romain.gantois@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/logicvc: Avoid use-after-free with
 devm_kzalloc()
In-Reply-To: <20260630-logicvc-uaf-v2-1-99e881833860@bootlin.com>
References: <20260630-logicvc-uaf-v2-1-99e881833860@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Jason Xiang" <jx@jasonxiang.net>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Paul
 Kocialkowski" <paul.kocialkowski@bootlin.com>, "Paul Kocialkowski" <paulk@sys-base.io>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269964-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:romain.gantois@bootlin.com,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:airlied@gmail.com,m:jx@jasonxiang.net,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:paul.kocialkowski@bootlin.com,m:paulk@sys-base.io,m:simona@ffwll.ch,m:thomas.petazzoni@bootlin.com,m:tzimmermann@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mripard@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com,jasonxiang.net,linux.intel.com,kernel.org,bootlin.com,sys-base.io,ffwll.ch,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14D546E4403

On Tue, 30 Jun 2026 11:10:10 +0200, Romain Gantois wrote:
> The logicvc driver calls drm_universal_plane_init(),
> drm_crtc_init_with_planes(), and drm_encoder_alloc(). These functions
> should not be called with structs allocated with devm_kzalloc(), as this
> can lead to use-after-free bugs. In fact, a use-after-free caused by this
> has been observed on a v6.6 kernel.
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

