Return-Path: <stable+bounces-239971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LhNC5Jk5mkKvwEAu9opvQ
	(envelope-from <stable+bounces-239971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:38:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E74431A4E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D0BA300825B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021193A5E80;
	Mon, 20 Apr 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSnWewiJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50C37996B;
	Mon, 20 Apr 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706701; cv=none; b=CC/VOMZYRQ3KD6s7rULwAZdU5LXKapR3HZYJNuoWvR0pHkpXI9we7k24JC4q33sU8p4rwBmIl+4uskxHevXhfHx8oNiFevT5erYHy/r2CbD/uEf4W5xgFDj4BmGGuSUS1aBhWUJnP+OXNf+VpIEG5shToaxoVwtiMQ6gRlHaxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706701; c=relaxed/simple;
	bh=09BXK9BgUP9PffdgEOtf6De3RxnjbCIb7IEjCYaf6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQin8He38u/otWwlMjmrnFDusY4rQqHKzL7kgDE4iwzgOwyPUHHMIBbnOSYIR2jV2qY7tTBNaOI0yp/lGE7X8SJO3ccPZiMNOA6wTsRWbfcQlkkqsW4fBB0MECdPK02/5FgS8EvMQj6HCRZwaoDvmnQJQ9+RMSpHU4gtFvuPz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSnWewiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1174AC19425;
	Mon, 20 Apr 2026 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776706701;
	bh=09BXK9BgUP9PffdgEOtf6De3RxnjbCIb7IEjCYaf6Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSnWewiJN7gAnDsHA3vvnqXl09hfNfLDtGpRPwdPZlcoUGB+iSnf7cR0E5DCYhnJQ
	 xMbQMH7ebP35Fn5Q99II/AEoiZsDCrTZpHvFn2oTU6M3j7pkyymJ6XWFKV3QMThMaS
	 puAmlPsPXInRItnqwWQSEN33zmEZH9loubRgojZtvmWblNtZVwon6QyVmo59nwbFaK
	 drqz5DihRjHFyD54IRstsUxAC0Zw1EROm6CACcEtNqtU84WN1aupUCr2qENp6t9ztp
	 juHKKENPFgGWul79hyVnY0B9PbPsGWOlbE0R2BgvsMVEEI4yAvvrxPu4oH75H1f+t6
	 gPtd0s7gh27Qw==
Date: Mon, 20 Apr 2026 18:38:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] regulator: wm8400: fix reference leak on failed device
 registration
Message-ID: <c22d8c63-e13b-4346-9607-3967d7b89de1@sirena.org.uk>
References: <20260415181228.3691185-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jb0dIrANOO63SQU2"
Content-Disposition: inline
In-Reply-To: <20260415181228.3691185-1-lgs201920130244@gmail.com>
X-Cookie: Sales tax applies.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239971-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,opensource.cirrus.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: C2E74431A4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jb0dIrANOO63SQU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2026 at 02:12:28AM +0800, Guangshuo Li wrote:
> When platform_device_register() fails in wm8400_register_regulator(),
> the embedded struct device in wm8400->regulators[reg] has already been
> initialized by device_initialize(), but the failure path returns the
> error without dropping the device reference for the current platform
> device:

> -	return platform_device_register(&wm8400->regulators[reg]);
> +	ret = platform_device_register(&wm8400->regulators[reg]);
> +	if (ret)
> +		platform_device_put(&wm8400->regulators[reg]);

Note that the device is embedded in wm8400 so we don't want to free it,
and we don't have a release() callback anyway.  The whole lifecycle is
messed up here, the subdevices should probably be dynamically allocated.

--jb0dIrANOO63SQU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnmZIgACgkQJNaLcl1U
h9DA9wgAg57kzIumLufOFLxOnEmOgBpsmP8QMomiWVt1L3DWoxyvzPRlHCq7rLaa
0IAc+jnO341FOr4OBlfxyZd3torUSwTbFjI0qWc7wl/4e6svIlQpa5Ti/GanqOv+
ejWNl+VhueADaxINv3gKWfqH793rceFuVg8xTORle2v9AHAW0FIWPuwsbCloNbVB
QTr4N4rvHAcwEb60hdXIACS9vrYxhtphec4I5QPbHwpVBx/bq8gWH8Hopm9eHTm0
gdhFSdRwLpOpLoAJf8YCbdoobsEs0x12UeNtRvno9pZQWGU717namBKZGhX6Tmfx
+EC3hcuBg8whc07ov+wdl/6jSkIhXw==
=xtum
-----END PGP SIGNATURE-----

--jb0dIrANOO63SQU2--

