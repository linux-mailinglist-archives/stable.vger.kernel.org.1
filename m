Return-Path: <stable+bounces-269761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ovp9Efh5QmqG8AkAu9opvQ
	(envelope-from <stable+bounces-269761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:58:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A36DBA19
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:58:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wot+pkiM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269761-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269761-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F12653027415
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF9202F70;
	Mon, 29 Jun 2026 13:34:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0B1AA780;
	Mon, 29 Jun 2026 13:34:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740063; cv=none; b=uRaMey3o/24Havt4By1t6kqxdqaz0B2NhOuuWtyoC9Yqm3iH4dx0veian6/2/a3O6Gk2IS6Lo+gTdfdjLndcJcSZN7T8U/AOBJEuvLYoBdI6PwzcuWffz8UiG8zsJPrWd33/F+iaZOTDM82uMQu+XvDQPPyd+BscTl6gd5rwKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740063; c=relaxed/simple;
	bh=RDXd2DV9o9Ew1Cn/dxVriEPiH3znnGUUkp4sf0LuKYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmN6xTO6mCPQhPTPMyC1+RV81/zNK0zxiNibVv+JRcxTeMEVAWCqMn8Tx6rIe/ckTBkWCIEzTF9sEkoMjyv3Y5XS6GMqkpguJnET1Xmqon7SGXSB3EGfwcSWGPqITii2QEqO7iY8tBjFanud8YW7CDGqht7wPNbp9Rxr2sv3DHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wot+pkiM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBED1F000E9;
	Mon, 29 Jun 2026 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782740062;
	bh=RDXd2DV9o9Ew1Cn/dxVriEPiH3znnGUUkp4sf0LuKYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wot+pkiM/+XeZThAnRU6/qSAEhaI8GSkJ3+b/o9Wx1VjTPJpaaTimN1MTiUQDqETl
	 B2Qk8Qio0wSXu3mlO2TVmjdV9J/mx4Pts+Lnl636Q01ARHlAiEKf+GMGUwpCFx2+S6
	 VNqm7zvP4Yjq1jguU+2DKiZBmF2GB1U5NGfnCxapG8ICgf2D587shtS3cp9nin+I/I
	 eUrzIV6befcxxVAUL7Gi0xcWnh5MARwnBKjSazxtXdj+Pp66Txp1Ludtlg7b/gUrbj
	 FcC8gBK1sO1vP6Wa4otT5TpZ2nM8H4WPnjlX5Eh4ss/BUcY2eG59UUNpADtNzjWcQj
	 Nz3Qr6Q1SKaJA==
Date: Mon, 29 Jun 2026 14:34:19 +0100
From: Mark Brown <broonie@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fix: regulator: as3722_get_regulator_dt_data: fix
 premature of_node_put   leaving dangling of_node pointer
Message-ID: <cea3b329-6c77-4289-8c0a-3fa717258f42@sirena.org.uk>
References: <20260626160150.54291-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PQ0TtsOcivnon6BL"
Content-Disposition: inline
In-Reply-To: <20260626160150.54291-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269761-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:lgirdwood@gmail.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 294A36DBA19


--PQ0TtsOcivnon6BL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2026 at 12:01:50AM +0800, WenTao Liang wrote:
> In as3722_get_regulator_dt_data(), of_get_child_by_name() acquires a
> reference on np, which is then assigned to pdev->dev.of_node. The
> function immediately calls of_node_put(np), releasing the reference and
> leaving pdev->dev.of_node as a dangling pointer.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--PQ0TtsOcivnon6BL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpCdFoACgkQJNaLcl1U
h9BxeQf/Y+aXiDhM2jO4bBtKpiGpSY1bSxFvAWJuuoN+8nr711br1jUobsfwPs13
C764kjE6BOO5zcWMxYLlsk6h4zyLqciQcdnCN0WKyK7Y+5Y29LQg3QUN47Bscal3
U8AX/qZKuHexydRhq2QXOJuSDa0VpLT9AuJ5xKgV+JY6cob+6rZlir/RlAWTFrz8
1u+A+X92bUPggi205MR/ZpsJU9c06sMI8Whmlqr8O66dIvyrjkkMUeqarc87sM1O
vWZfIUQsiJq2xvJN06xX2+NfnPh6Ov9VOQR9JnIZ38mio0xeMVMbGuv7FMd7WgHe
ttjhSDGLRWz8bPg21KktCls2+JMGSA==
=Z1yk
-----END PGP SIGNATURE-----

--PQ0TtsOcivnon6BL--

