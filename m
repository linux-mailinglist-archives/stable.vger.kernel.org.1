Return-Path: <stable+bounces-224659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OS5ND0xsWm0rwIAu9opvQ
	(envelope-from <stable+bounces-224659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:09:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2226005A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72A5A3014913
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EE3C3C12;
	Wed, 11 Mar 2026 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDkzIbLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247B3C456C;
	Wed, 11 Mar 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220139; cv=none; b=AiVDSUkVKGPM0+CPqXyc5Hdg//GIDTo4wDiisRswB72becX/Ad3Ebe/5dmV6JQY4vz1lJfSSGDp8br1YPox3q5Hyo9xgf3PJKqmdhuNrLFSTHZgEZDZnKS/q6bggYH55+TWc3rKndJuLA2rgQKb2YHaM1QhiG9ev6Axh7nzITwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220139; c=relaxed/simple;
	bh=QmMRcyr8cPQR0MBzpuW18tVPDlR+PLdqMUtnqfdQuWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRgZ8BZ/r/qr41yN1J++6ywFfStoVCI8UcKbB/slmBK+HHogUlxnbbLUe/9nRiVPxlz/vokDh1OBVCbeqb0foOkYfo1Wwsry+ctoQfTqnX1fvfSnBAGN5sU/gTTKFD1ymTgFrgOog74P56vVtz0fIFjchfFiTCE07tJ+8SgpTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDkzIbLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AA2C4CEF7;
	Wed, 11 Mar 2026 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773220139;
	bh=QmMRcyr8cPQR0MBzpuW18tVPDlR+PLdqMUtnqfdQuWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDkzIbLOOxTU/2T/UBRhLPy0pXrulO+dRfcILugrDDsVQTtavO5w9ullnZKuRSJ+4
	 nJU1zZbiT0I4v2DLOyGIRsYWvd7Pb2ugJTywVjdA6yX2DsBosmonXQKENfgJjuG1wF
	 0ROfCG8XQZ2N+YSvkBazdKezBWqrBlqcqR5bRD16O0bbshLEvalC2MKBblcQT+hw4s
	 Usw/hO/sI3/Pc1f12XqYVEDlAaFFb2JQeKzTT84zs2ko4a9RqblE0dmLIZK+89/2HG
	 T8Er3SV6AwI6ALySu5maZAL2YI2NeMj6tPPhID6S1ZCJMrW5KAZbd3MiDV8f5RUuER
	 pErCINqf+m+Cg==
Date: Wed, 11 Mar 2026 10:08:56 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/tidss: Fix missing drm_bridge_attach() call
Message-ID: <20260311-spirited-mighty-grouse-e0b1cb@houat>
References: <20260311-tidss-minor-fixes-v1-0-ee5e6e14a566@ideasonboard.com>
 <20260311-tidss-minor-fixes-v1-2-ee5e6e14a566@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ozhc3zbwh5ezmexs"
Content-Disposition: inline
In-Reply-To: <20260311-tidss-minor-fixes-v1-2-ee5e6e14a566@ideasonboard.com>
X-Rspamd-Queue-Id: E5C2226005A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224659-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iki.fi,linux.intel.com,suse.de,gmail.com,ffwll.ch,ravnborg.org,redhat.com,ti.com,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--ozhc3zbwh5ezmexs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/tidss: Fix missing drm_bridge_attach() call
MIME-Version: 1.0

On Wed, Mar 11, 2026 at 10:16:29AM +0200, Tomi Valkeinen wrote:
> tidss encoder-bridge is not added with drm_bridge_add() call, which
> leads to:
>=20
> [drm] Missing drm_bridge_add() before attach
>=20
> Add the missing call, using devm_drm_bridge_add() variant to get the
> drm_bridge_remove() handled automatically.

The patch itself is fine, but the commit title mentions a missing
drm_bridge_attach() call when it should be drm_bridge_add()

With that fixed
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ozhc3zbwh5ezmexs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCabExIwAKCRAnX84Zoj2+
diJkAX9wcYxbDxiUoCf43yOD93OT3iBlQlTM5ZG8WHo/dzCTlLJe7MA+asG9K12l
8Yi8/YgBgNY+UgM30pgZlDPZlgir/jIhxG2Du0rF/lLb0FS/IHpRB+wGVVVJhdiL
dTTFPo6XfA==
=KVb4
-----END PGP SIGNATURE-----

--ozhc3zbwh5ezmexs--

