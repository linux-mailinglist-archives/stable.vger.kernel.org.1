Return-Path: <stable+bounces-248882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGFfGBhfB2pa0QIAu9opvQ
	(envelope-from <stable+bounces-248882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:59:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB2555C3E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF84D3179C7B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78921380FEC;
	Fri, 15 May 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq8Ogtvk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A4380FEB
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864653; cv=none; b=b2iSk3g+xBBChdbIpSZrg8O3iyRx+XJM0/DCJcE4iVZPbUs+bgIH0BGWMp+2ItFGe4KajhHIfM20BlXwZx6nfKB9To7y/N8WYOxX6Wth+S0/6pT6ScuYTdFa6rAUvBo2tr8shnKNcTbV9+IfARVnrJWSU20Lv/oiPIMWfGVj4qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864653; c=relaxed/simple;
	bh=kP1pLlTGFv2kBOue9eJ0aaym40jrfAql6Ubqw5H5mjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci1iEQuFl+Bjs4fk8g0FKldBBLDQ0YTIohbAKkrHHiybxycFnQDbw53+l5HH4sttAfxcFBI6kStrVzip+lp0+5a0XOUjNHnPuYDtnSlJnT0YJQ/PI5SJQ17onFGimNEmM8VnQ98jD8EIveV4terV7Ylf8UH7PdKYmeF3g5Td87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq8Ogtvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86048C2BCB0;
	Fri, 15 May 2026 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778864652;
	bh=kP1pLlTGFv2kBOue9eJ0aaym40jrfAql6Ubqw5H5mjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qq8OgtvknQPBEQVaPfTKdX4/T7+P7ugeV7VHMWeJxQDYaFZBuucxely9MHxrDjAF2
	 OLttVugDKSEtKEhYGcHRix4bmihL1as+vcVibavBFRYaxYkBBtPeqzGhmjmf417xus
	 k2U41BWeNL1FROlcnoVes74uAaD7Z1gXI54CUOt2I7Ak1W64PNGks6l76vckJI31f4
	 p/+HVgMxsJIdLkyOI0wcqleitWcU5wKRk9hXWahUPbsecH0jYi/l0DHryHGSsMnBb+
	 C7ONdK0sFRUYHBnl1xCGn+XCI3j76Aqjgk6Uu13atthXJ+T/3I9epSg5RllpxG4yV4
	 VHusHfD4VLb5A==
Date: Fri, 15 May 2026 19:04:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: viorel.suman@oss.nxp.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] pwm: imx-tpm: Count the number of enabled
 channels in probe" failed to apply to 6.1-stable tree
Message-ID: <agdRLH7KJ6Mr725C@monoceros>
References: <2026050332-washer-legislate-ef0e@gregkh>
 <af5CI1ZrJIAoUnf5@monoceros>
 <2026051535-dynasty-boxing-69a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jz6stehalauksngp"
Content-Disposition: inline
In-Reply-To: <2026051535-dynasty-boxing-69a0@gregkh>
X-Rspamd-Queue-Id: D6FB2555C3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248882-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,gregkh:email]
X-Rspamd-Action: no action


--jz6stehalauksngp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: FAILED: patch "[PATCH] pwm: imx-tpm: Count the number of enabled
 channels in probe" failed to apply to 6.1-stable tree
MIME-Version: 1.0

On Fri, May 15, 2026 at 05:02:05PM +0200, Greg KH wrote:
> On Fri, May 08, 2026 at 10:14:19PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Greg,
> >=20
> > On Sun, May 03, 2026 at 01:46:32PM +0200, gregkh@linuxfoundation.org wr=
ote:
> > >=20
> > > The patch below does not apply to the 6.1-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > >=20
> > > To reproduce the conflict and resubmit, you may use the following com=
mands:
> > >=20
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-6.1.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 3962c24f2d14e8a7f8a23f56b7ce320523947342
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050=
332-washer-legislate-ef0e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > >=20
> >=20
> > You wrote already on 2026-05-03 about this patch that failed to apply to
> > 6.6, 6.1, 5.15 and 5.10. I replied to the 6.6 one with the exact patch
> > that Sasha now recreated in reply to this new 6.1 failure. I would have
> > expected that the 6.6 backport is tried to be applied to 6.1 and the
> > other older versions given the mainline original doesn't apply cleanly.
> >=20
> > :-( that this resulted in duplicate work being done
>=20
> I've now taken your backport for both, but we have no idea that a commit
> you send for 6.6.y and says "backport for 6.6.y" should be applied to
> 6.1.y :)

Isn't that obvious at least after the fact that if backporting a
mainline commit to 6.1 and 6.6 fails, and there appears a backport for
6.6, that trying to apply that 6.6 backport to 6.1 is a good idea?

(But I also learned my part and mentioned in today's backports that they
also apply to the older versions (though only in the body, not the
subject).)

Have a nice week-end (=F0=9F=A4=9E this really happens for you with all the
mess you're into),
Uwe

--jz6stehalauksngp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoHUgcACgkQj4D7WH0S
/k6cPQf/ZCd9eyVcB15Y+LUp3wW5RZ0NiVF5OrIWcMUFOkxy/LFFofp5WnDuFhjr
b2mP168ylz1TWIWqCtMYW6dlmko+UCSh2/s1ejDOxMgYsDsILdsgAG8j9bkoJIh9
DB6AL/L8hk0q03hFOzYkQDEzTG/Xbfioh73qxtY4E9YbEu8lAluuV/9ydC5uhfWJ
xnQc6gFikvpw+MF7L9udrHldGgLMEVPOP3dqkIGKxD3dMDk1AZEPKF470x37ygEu
JysmSB1den6+Y+mofHA70xwhPSwT6R9iUPNja3YdKYve53Dm1ZJCUGPBot2yh3F/
YP4frZ9pZ7WeaRm9xf7WIbIi7BMgrA==
=WtJp
-----END PGP SIGNATURE-----

--jz6stehalauksngp--

