Return-Path: <stable+bounces-219964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAChLM2goWnEvAQAu9opvQ
	(envelope-from <stable+bounces-219964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:49:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2461B7E03
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF225303FA9C
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8143F0779;
	Fri, 27 Feb 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBGtOx+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611342032D;
	Fri, 27 Feb 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200078; cv=none; b=FLlJDm/53AQTc4lYnuNetAT+LxnUTr0uWKlLHsXHWUaxwSej3bQdQHG4DEqO+2xefw7IVxeAAz0Qige3YgdSFd/uUUMXkd84zUJt+mSVrg4I0bKdknkNoT34az1Je/cSNc2Biz1UAk6XIo37hkwNhOqTeMAulwCkfukR1esLkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200078; c=relaxed/simple;
	bh=MLYtcfYu30A79SvPiG/y1eWPluHhReqVhz9kxWyFv/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L69rxaBGBRDJW3AHYk7cG3irEknRQ3O87XSo15WOz1IFnscBPaHRpE7kTBVWZZ6z8LSBG0rcjIIcSrqQq+kq3PZd3LAXYCnngTFFktvTqDGVscqdSkb896TqgiScJg3LQy9Z3aqQiaCSWX66zAeZUEFrmklR6wv1Gxr7t1wKFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBGtOx+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B45EC19425;
	Fri, 27 Feb 2026 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772200078;
	bh=MLYtcfYu30A79SvPiG/y1eWPluHhReqVhz9kxWyFv/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBGtOx+AbijjxToDBlEJUkOvlHJiJ2fDXhtvMvqETX8rA8UYdmT3BeKVfSlKK8gJs
	 xXaD4tgokcoevWSJBe3g+b/R4WomgsNTelIIfVyJoSuUTdztoYmUKMC+zOLAKZVncY
	 TMWsVWMj2jwIMi80CCWXEDECOccplUUGe2xwHo82cNYsFaqCQJdKQz6pSiNPGeSSpp
	 yYnaqqMWXeZB8OEQmODVxl1pQAXwIbENEu4ihAHGP8zvaNk43uA0Z7Qknzobn/EaFg
	 FWMUWD5ZslevzII39Vpu2+eEv8B4gSlp4UdqYCNjMyRgNiAo21tucTZquHIqDEwx7D
	 cJix3+L18FAiQ==
Date: Fri, 27 Feb 2026 13:47:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc2 review
Message-ID: <0cc404f7-f2be-4e31-bf6a-1c46e9d07b54@sirena.org.uk>
References: <20260225151847.709818960@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aFVFkaQu+H9CsBBB"
Content-Disposition: inline
In-Reply-To: <20260225151847.709818960@linuxfoundation.org>
X-Cookie: Only fools are quoted.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219964-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 0C2461B7E03
X-Rspamd-Action: no action


--aFVFkaQu+H9CsBBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 07:51:50AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.14 release.
> There are 641 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

(I mentioned what looked like a regression on IRC the other day, it
looks bogus from my investigations - just bad timing causing a flaky
test to flake consistently everywhere I think.)

--aFVFkaQu+H9CsBBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmhoIYACgkQJNaLcl1U
h9DnOwf+Pf2wJncW6rWjor9HCwsOvt8czl3NdVfj60kmvy23/00GyGKujDrrpIvO
Y7nounHl6SnoFsGp5ueIt1Lb/VzYE0IKkq3Fx+VJZ34jpes3XQELZPN0ZLAnwPyd
CZ9AO9t2s0bIBc1ckyBFrEnBpemzuttElXe4VVlaEy0GXgzfokbC/pWe3LC/Cpop
eQZXQ7/sgzJwPMWWSAKGChZzui+URMeJT0r/3Fxb6b4TG6a5yJc0ll4UjKrafO/s
ARkOxcTc8YXfg24NYFlZf4F45MJGcLFw6fC1LRCZJ3k8h/mdpHf0jRVxMD+nCxW1
BPwGZ8djrrt8XQuUogvFNTUn8DILxg==
=flqs
-----END PGP SIGNATURE-----

--aFVFkaQu+H9CsBBB--

