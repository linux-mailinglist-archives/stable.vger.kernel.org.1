Return-Path: <stable+bounces-245060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PyP4NrfAAGppMQEAu9opvQ
	(envelope-from <stable+bounces-245060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:30:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A2505690
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E61A4300888E
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BC1EB19B;
	Sun, 10 May 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="WYXmb1qC"
X-Original-To: stable@vger.kernel.org
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7C533D6
	for <stable@vger.kernel.org>; Sun, 10 May 2026 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434226; cv=none; b=Z4TqMU3aw3eemkuhOqC+wO+uGGRdvJXdssUy2w4RajXaezTf6/q30cs6iWPLR3XkFswTuQ0mkFMpZnu1VVWZbTxUqNRDriBvVzlL1IHqACL1gJ3Z+c/+cgtuwpBsPz4rQ+I67Jgg+IFPGTDaCHsPJB4GnbNmdPpVl9CKN9uGJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434226; c=relaxed/simple;
	bh=Hrmx7mhqWIU6CTis7PaQRRXAFaSAb6al8q4MPkRBvNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCJpWfS/cdUUqLpmVHT6oX44Ymhjj/Nzf4IdSj6x7FRQwz7ZQSNIY1i0CGMnCztvzt0LHAr5MLlmd4JdysDyRWnJVijRH1IL33nKmueC4WMOWHNBPePXhpmKBUUoh8HGxNH+iBpncWJc3m2HrYc2MdnGjN/1GMWLaU7C1+p158I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=WYXmb1qC; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TJ58bbmrh+pyeR1MRXgtBNPGCye/bC7K9b1jnY3KMLk=; b=WYXmb1qCPjPTtZM1Q/ywAGdcx5
	p/7/ajKQNAjoaf+Sy40DyWLpxQwen6YuyortBavxEosoHFMCbUXNEZFM8zTiom99HyDHvYIKus1KI
	H4Cm0cPBZP4zTx0QSt6Y6RBOOPdjPPFJu7Jvoj5sHXjl/D8Xi3eurMAJ9Lw1oyG+lUMQ=;
Received: from mnencia by spark.kcore.it with local (Exim 4.96)
	(envelope-from <mnencia@kcore.it>)
	id 1wM7yj-000BFA-2l;
	Sun, 10 May 2026 19:30:09 +0200
Date: Sun, 10 May 2026 19:30:09 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Mika Kahola <mika.kahola@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/i915/cx0: fix PLL enable failure handling on
 Meteor Lake
Message-ID: <agDAocAQF_wpZYs5@spark.kcore.it>
References: <20260509162407.510539-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+WTlR/4MbHBIrr6"
Content-Disposition: inline
In-Reply-To: <20260509162407.510539-1-aaron1esau@gmail.com>
X-Rspamd-Queue-Id: 3C3A2505690
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	R_DKIM_REJECT(1.00)[kcore.it:s=spark];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kcore.it];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kcore.it:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mnencia@kcore.it,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kcore.it:email]
X-Rspamd-Action: no action


--H+WTlR/4MbHBIrr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

Short version: same regression reproduces on Arrow Lake-P with a
different NVIDIA SKU, and NVreg_EnableS0ixPowerManagement=3D1 is already
set on this machine. The S0ix knob alone is not sufficient to suppress
the race here, so the i915 side of the fix matters even on systems
where the NVIDIA workaround is in place.

Hardware:
  Dell Pro Max 16 Premium (MA16250)
  Intel Arrow Lake-P, Arc Pro 140T iGPU [8086:7d51]
  NVIDIA RTX PRO 1000 Blackwell [10de:2db8]
  NVIDIA driver 595.71.05 (open kernel modules)

Kernel: 7.0.4+deb13-amd64 (Debian 7.0.4-1~bpo13+1).

NVIDIA module options:
  NVreg_EnableS0ixPowerManagement=3D1
  NVreg_PreserveVideoMemoryAllocations=3D1
  NVreg_DynamicPowerManagement=3D0x00

Representative trace from a recent boot, ~45 minutes in, on the
internal eDP panel. The trigger was a VT switch out of the graphical
session via systemd-logind (vt_ioctl, fbcon_switch,
intel_fbdev_pan_display), not a direct s2idle resume; a suspend/resume
cycle had occurred earlier in the same boot:

  i915 0000:00:02.0: [drm] *ERROR* Failed to bring PHY A to idle.
  i915 0000:00:02.0: [drm] *ERROR* PHY A Read 0c70 failed after 3 retries.
  i915 0000:00:02.0: [drm] *ERROR* PHY A Write 0c70 failed after 3 retries.
  i915 0000:00:02.0: [drm] *ERROR* Timeout waiting for DDI BUF A to get act=
ive
  i915 0000:00:02.0: [drm] *ERROR* Timed out waiting for DP idle patterns
  i915 0000:00:02.0: [drm] *ERROR* [CRTC:149:pipe A] flip_done timed out
  i915 0000:00:02.0: [drm] *ERROR* [CRTC:149:pipe A] mismatch in port_clock
                                   (expected 540000, found 61440)
  WARNING ... intel_modeset_verify_crtc+0x325/0x550 [i915]
  WARNING ... verify_single_dpll_state+0x1a2/0x560 [i915]

After this point, every suspend/resume cycle in the same boot is
followed by [CONNECTOR:506:eDP-1] commit wait timed out, which is the
symptom your series is meant to make the driver fail cleanly on.

Happy to test the series on this hardware. Let me know whether you
prefer it tested against the current posting on drm-tip, or if a v2 is
in flight.

One small note: the cover-letter title says Meteor Lake, but the
cx0/C10 PHY path is shared with Arrow Lake-P (and Lunar Lake), so the
scope of the fix is wider than the title suggests. Worth widening in
v2 if you respin.

Thanks,
Marco

--=20
Marco Nenciarini - mnencia@kcore.it
7C23 B804 3E65 D298 0A21  B6E2 589F 03F0 1BA5 5038

--H+WTlR/4MbHBIrr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEfCO4BD5l0pgKIbbiWJ8D8BulUDgFAmoAwKAACgkQWJ8D8Bul
UDgNlBAAjBBS1Ph+31LDOsuy/1ezA8j6S6cHo0pJWtgSNqNoQUBsfj5CrfiAHB4P
HnK65pEuyUhAPSK3SijI2lGNs5qlHiMvdcs+vY4sU6OiT7DW4oQ1cUv8v6V981zY
yZKfA0eeJbp/kxGgEKddCwD7qaZSxv3HFSUk/Xb4niR8Ma1alxwyrcQGpuL1aQ1E
vgEy21nRy+tqIiowbKKmEqyvDnNEEUxWw60XZR/sr/3JzzVhzqrYeOjqSpKT7EYZ
eix6asWQnLsEuQ5DimWBR4G8DFDDD+2RtwXHoo9pp/jhLLDEk/9hZptQRfdz6Cug
gJQpx1TalvftNOUI9kp80cqRBNI/UfMdOuMv97p8ptKmUodnjFe/b282DvEB5eH8
nKxdumfg/3OdRSOmM9OrFhCIMrYza8yn9ZNFWGPybZi0RG0GJSI3n+aIOoAWzmQo
89JFFmU1aGrPLA5kJbyLaX5GDDaBeXQ1vfSgqB9Vuk5QXRETh9fwWdS2/WobTR+7
IlVXg8r1v8lkiUeiqFLs6yQfzhZnzFZZPDt4EClYp7IiHathwmhmQaHhbwM2hyp/
p1lDuyagjOYykvWHMmD0402/EpReSzeQ0Qt+gOUVAX9yuzwS7efq9hwEAXlHitSp
uMVtVusODO2rX68NXXKduB6QTZspNXx9vzyS6Ac/uKwELP+vHH8=
=Dt7q
-----END PGP SIGNATURE-----

--H+WTlR/4MbHBIrr6--

