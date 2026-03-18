Return-Path: <stable+bounces-227141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN/UNGT7umlwdwIAu9opvQ
	(envelope-from <stable+bounces-227141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:22:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB52C1F5C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8CB2301F3B5
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC1D3EDAC2;
	Wed, 18 Mar 2026 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="O27UYy56"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA733C3435;
	Wed, 18 Mar 2026 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861726; cv=none; b=XO5ZbS4oUW3e3FdQgndphcTH2bkGEUwudbZkA4P1YrlAO3co/BJ0/0nF+K3yjFBE6BLzhzxI2nKWzkPtbsV57JEZhWHQYR6sjflBTFTyqHIgbDtbLeGDN3AV+rb2GqmJ7C+Fk6y3i9eOBh3yCstKf3fIK3lWMgyrxQJW3WpWsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861726; c=relaxed/simple;
	bh=w0L88E4JONxcknqxNeYj/mU96kVaZt44YfM3bCuyj1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8EWJe/FcPPaCcyGJA3dv2yWMb2ijrT8JWu5LispVMOOca5BXM0dsiL6+doKpv9ig+5GxnmK9ln8DquMFikf6+N0eqypet2Ws22jt6VNmJ8zse1xBnYoH25pUbNTQyqLRfDcGd8SVZhwi+TMpdse+LSOb7oAaNrPnH1rFXlgijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=O27UYy56; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9709610E8FA;
	Wed, 18 Mar 2026 20:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773861715;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Oy3QBhS4EWryri83ZPBqhGram0OqPJmtGvZJCIL6wVY=;
	b=O27UYy56BY+5Qv80IzGKlgoKNlCx8zj4Reh84DXxmEmO/fl54YBx9wrtQiOaj8naOc+dC6
	My8Jx1GDAljZ5utpIxKkkoyF5Nc4XAeAqpPd87GswU4vSXKANMk86iEjd4Hy3GQ9DegQ9t
	vtZ4K1WwIz9U6rFHLAbEYJTOuQbZNcDoqPZycYgoAD8j/52CkUhOkYaTG0TcUGS7V0CPil
	/q2h7xUJo5S7Bpcn4fyfmFZBlbI5Cwtrb16TwsB63JvazXI11LEq/75xvk0o0OtkWODEXz
	9AzNHlaDlCOdQFNwDL7TnQe6TWSrOiB4SNvcR1s/7GGwEwJ6GHqP0XrECxGkCA==
Date: Wed, 18 Mar 2026 20:21:51 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/335] 6.18.19-rc2 review
Message-ID: <abr7T+v9PDUSo9WD@duo.ucw.cz>
References: <20260318122621.714862892@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1G/feHWU7Fzh5M8s"
Content-Disposition: inline
In-Reply-To: <20260318122621.714862892@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227141-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.com:url,duo.ucw.cz:mid]
X-Rspamd-Queue-Id: 3DFB52C1F5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--1G/feHWU7Fzh5M8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.19 release.
> There are 335 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--1G/feHWU7Fzh5M8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabr7TwAKCRAw5/Bqldv6
8sq8AJ9hg+DKITs+FFN3HtcFDOLoJRhcIgCgvSeHmgWRp1i3Vtu4Jcr7A6Ax52I=
=8bj/
-----END PGP SIGNATURE-----

--1G/feHWU7Fzh5M8s--

