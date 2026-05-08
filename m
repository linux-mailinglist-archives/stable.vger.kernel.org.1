Return-Path: <stable+bounces-244822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN5dCmJE/mlFogAAu9opvQ
	(envelope-from <stable+bounces-244822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 22:15:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B64FB64C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70F83044A41
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D6402B8B;
	Fri,  8 May 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0HPuCH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B583FB7F1
	for <stable@vger.kernel.org>; Fri,  8 May 2026 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271262; cv=none; b=j5IDhIMLwohUOVOT2SXuZSfHhRopsLIUuSnIGDo9sqUACWAaIN1FE7zHUOV8X31VnhlH9PITgSCI9JppAt83IvrlKP8GIi5CWcFoREkS02vm0+jRqpFa1XmSzRdQgaTpvHfb2V9ZXVLzNMMKR/Iuoru7MrqrrbuckJZR5QO3yac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271262; c=relaxed/simple;
	bh=vJz4MyRRqHz69E66/O5kDd7yLuLDgBnoNU4QmBDbKH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5ypWJG+JJ2eDWOV5McuRs8XD4yLIT7XXxvbwkANmDaRC63vuuI651F2QQ/PNQJFsdA1BZbwJW9UqedhOw315/61LZIRed8gU7QWtc+RtFXBHn4/6fVF0eN1+flvSQV5qvDvyNQaXYgLOuLJyN4QxNPFiPf7Bkk1htEWPLAnOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0HPuCH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E562BC2BCB0;
	Fri,  8 May 2026 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778271262;
	bh=vJz4MyRRqHz69E66/O5kDd7yLuLDgBnoNU4QmBDbKH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0HPuCH3VKSVAgYNq1BiEMopDgkpml7Z3vYl/cl6W3NQI8Dz1qCUJBil/Xn67GTB2
	 D3/AsCHQR0pflmpQiuZCoM9M3WZCe8pL990tH4+zAtLjdRNi7wO4w41MDZEObfQo6H
	 +rpG6aRDjlatM7fDFcnDcdtWhi7E618AHM8ubUG1faVgbGsFUM5/+zKEthpOvXYG8y
	 U8QcO93G8dTTph3UNeretPLCP71m14CKowSEgk4fsqu4UcmdrXn8zGezKRgA44bxH9
	 Qmv+q9FERQUzEsAevbr0GoFpkX5Ht8yT85GhfNW4/9hgAAE6FSCIdlFMdsB+mJJUBu
	 BZLnNNbNb+L2w==
Date: Fri, 8 May 2026 22:14:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: gregkh@linuxfoundation.org
Cc: viorel.suman@oss.nxp.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] pwm: imx-tpm: Count the number of enabled
 channels in probe" failed to apply to 6.1-stable tree
Message-ID: <af5CI1ZrJIAoUnf5@monoceros>
References: <2026050332-washer-legislate-ef0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g7bl57fqxct5su22"
Content-Disposition: inline
In-Reply-To: <2026050332-washer-legislate-ef0e@gregkh>
X-Rspamd-Queue-Id: 986B64FB64C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244822-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,gregkh:email]
X-Rspamd-Action: no action


--g7bl57fqxct5su22
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: FAILED: patch "[PATCH] pwm: imx-tpm: Count the number of enabled
 channels in probe" failed to apply to 6.1-stable tree
MIME-Version: 1.0

Hello Greg,

On Sun, May 03, 2026 at 01:46:32PM +0200, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3962c24f2d14e8a7f8a23f56b7ce320523947342
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050332-=
washer-legislate-ef0e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>=20

You wrote already on 2026-05-03 about this patch that failed to apply to
6.6, 6.1, 5.15 and 5.10. I replied to the 6.6 one with the exact patch
that Sasha now recreated in reply to this new 6.1 failure. I would have
expected that the 6.6 backport is tried to be applied to 6.1 and the
other older versions given the mainline original doesn't apply cleanly.

:-( that this resulted in duplicate work being done

Uwe

--g7bl57fqxct5su22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn+RBgACgkQj4D7WH0S
/k5ZTgf8CXXgMtIvbo5N0m2GVWxyhTqaJCmLFB+vEFwfEvuq6MfyuiZcOYjema+4
UgYmL9scgOZwx+WiTnYhQu+QFNRJDInzjz5ZK+KfvKGOOq5XnT7WH57JsWv4pS1C
s7+A8F6wngopTMTpIUE6iPZDo7ccXhg9duHm6QZy1GbypJuq4xnWJIqZ6eER33gb
YQ2/yGgu1GPUa+WB+uTkEfiWfwz/uqZ7y6OujDxJANTSJRN1QA/ywLuTbhx4xAjY
bwFROBivx/kRLoYuodO8WFjo27WtAes+tR2EfWybMpvImWegRipvqYyuew5qHxYW
f2tkyeCFW9qfXoD1gBosptWSm7Dgbg==
=ke9W
-----END PGP SIGNATURE-----

--g7bl57fqxct5su22--

