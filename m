Return-Path: <stable+bounces-130948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA2CA806FA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C719817B2DB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823EE26B975;
	Tue,  8 Apr 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="EiaQFLXK"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558ED26A0C5;
	Tue,  8 Apr 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115084; cv=none; b=GKURAmXS0OYz0Q7+ibvOC1fWqYrgI2ikbFJfpY5XDp8ytBzsibgaw54Z/Wk8IbszO2KK6bokGJkoQHfnxUPTY7JVnxD+fwHpVD/791qZ+xSUfAsjYzjf3aBoQW22tN61N/xR/5QEv3ksu+oZRbpURh+ZlbXO4dqbEDO6rSSP9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115084; c=relaxed/simple;
	bh=A6GH0730N9005FvryT+2f/BKLA9sdTWfH/OfPZwZa2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/fUY4CNh23INcoH40id9OnTDxY75088xsb4SHe05DWjntLab04aEWD54R/2aKC0qgPZwBJXDcpxhbNzAIdFkC3ahQf3W5hoMwcmQU8EDoYsI8eura3MFVBArrzsvaUDh2BT5rZOeaInxnVxm5d9OJxMGDwuEdxC5kGvzfyyWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=EiaQFLXK; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1744115033; x=1744719833; i=christian@heusel.eu;
	bh=u+/mqDgKSZDwMA/1OefEMZrRqMdUu66MZ8QDf1kcPGk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EiaQFLXKwN3AoNdw06wg/JJFHG8G1LGb1GKK5OCkCEUHW77XLQd8QZSYDqLrg3Lf
	 f+j4Nl343OuVCiiVOoOy5COSsvoGIysiOvgBklAummE9pz7aU4FsrorGtMh38W8+u
	 7hgR6VJKzrup/Nqsnc2P3yZWE0sAs5Rce8+c+BNApwkJVa3okTA4WWfpeON1xyFvn
	 61IpuMi0X52SgLK4acTx1E1a4NlKlZqfuhfDtJHPNcCEDzgGunnkqDoPY9f7T6v2p
	 zgcmcMvSr+/uMCuzqesyqLjC0QMw7lDg/hIwxfK8HT2NcCFnWomRk0RqTHl51La7Y
	 SAH3iiGzZffK6d8pGQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.49]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mlf8e-1tKr632Xbu-00g04s; Tue, 08 Apr 2025 14:23:53 +0200
Date: Tue, 8 Apr 2025 14:23:51 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/731] 6.14.2-rc1 review
Message-ID: <fc727793-7b2d-4cd8-aca4-78824cdf477d@heusel.eu>
References: <20250408104914.247897328@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lygmlimbjvuadv2e"
Content-Disposition: inline
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
X-Provags-ID: V03:K1:xJLObfOIsGYs3G9tzv2KxMMPmxROXgzsfdd5jG9ok1TZhiuAdR8
 9BsmlSVv0FfEC93stkg8tdEDL1NEmeE4kLG1HoH6tG1f4FRRTvBxr4lQovuGOoGi/uTXWaN
 vkjbFl2dbS6czVvPg97OqYyP42+vA3HzfNIzpqTX3qh90h+gzBfU0YKxHFEEM7i0qGBAN+4
 96Ccy6FG110v68Lr2cDqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KO4HuXsZ7Ec=;6p898VuMUIGSeMx5ydeOIVsRBqy
 bZ54qd/pC69KH0pih4EJ1hoMjj5ZA3Z32lizRvoW2pVE5JF666QSXkPi+FuZvWgSsTBHckg2R
 IES5vZe02SfeLnY7h2Be4mRns6ONPTMi/0nL3vDIrGI3Z6Htkar4LS0lfHfbG/MIvcXEW4kSg
 3PqvmT938ubnPXPFN5CUzPO/oJKnCcTkc511TGA6f6uV767QfCic/4NdpIrxg1E29c1Q/+bf3
 7R4lGQ4wLhPn1s8ecvBSdqopLLtqtXX5qMBQL92KltfZV475ROwJ2574ybBMk3sO194fLMkBa
 i+tc9yVra957l2vcNTpEp0gGxOGYQONsETFvAI8vU/XDq4wzW51Qw8CZUcfhdDFkN+tW5k1ny
 /cfZWoOPbHvXD7tcQ1qF5DXFLU3B8vWIZltwZ9T2uwGrX/9z3hJQIL03JXemKg8hHn7MhN1Sb
 nkclm0/1NkUNRTjkUFwEmZ8kKAawLyd+wwpAZrQguOgG8pVkoKJZ20Vf3X3FOjBn6jvmDG/LH
 dR8kuYX8DU4RWB3uJFkdoSjLS3oP+nIxT/d+03D7L4ByMuhp43HIBCNhmInAutwXFNHHAM7gt
 8TS9LfvNVNc0knIhKKq/CEovFgssl0Oua0RaYtko8PPfT/UE4IbYMjBswvZjOjNd1oIxR3w2V
 8RaYuNoObAADXi4h455Cl9iDAU9Q6qI44tm/K+pw87oLAYHCOVEpd9eYXsWwjg7xMsVzPlQTq
 DMBSAetr/DYKYd5jSp/LEbTQ+tgIUhoHk7wcTgaZOtnNRbalO/7L99dP7wr3c9jXhc2QhJaZ3
 YBXtE620A9AGrtC44gdChcpdQElp1iYE/DEiPTqQjsV+SDKz2LXhmZTrODOkEPb/NIJhimFv+
 RF097XHZcE7k2xZiDlzjx5qyIOowwoMTmB5r56DIyFJvBAKlNU3+Qie5FwBcav03rAbJdA//s
 mBW+92OkTQYT46s1deEsSA2iwruP/HkmrGvw4g1n0Sz8K/Xi6QFtExC5JMbQCzgwtv3F6L0kX
 jn4n9DKtQgUL7ywNYdJLcg1zmlqygq1/k7ynNIw/EY2qYKRx4IpE0ABNLVXMM9UrbBsS+tLvd
 NkH++PT+av4ucL1RDwXHwVvoR2ppG+mqflsG8tr0Sf3ZHXxc0hXNtLrpvkmyxHNBswzDSGGwL
 AbmQzWA51wD2FfzuNsd3tsnHytaPki/NDWWOkw3pd1P+pBvxkvNA05T01PUKz9QmjF86ph6QO
 RBa05Wxv/oH6kAA1orQjrjk1Xu5aAIRfJ8Dc95n3mX7pTgZ7iQ9jfGJJJQWfZPVAD3EB7/o7W
 kSKHh3JwaKiRboM2Qz7S5yN7Zzb1gjXlef32/RiGQjCpV58JmtOyBzEVIDzgk8HCu8JdXcLjM
 lFWi541h+iFC3qt2KsV2DVE3DrkHoztNO7lUE=


--lygmlimbjvuadv2e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 6.14 000/731] 6.14.2-rc1 review
MIME-Version: 1.0

On 25/04/08 12:38PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 731 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--lygmlimbjvuadv2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmf1FVcACgkQwEfU8yi1
JYVj0Q/+JQVAUATBuO7W53RKR8zORwFzOoxqEgviNSJtEnpew2jG+G4ZmVZvO+fW
9tF2nc/WpxAXUZzZ1wLAi0jZzvoVWM5ays5d9a5Jj3D6n4kPDNMPfwowt81xOo9P
drgrB/Vl0jGc1kkCE04YOtYB+fCuZIpP1K+WS/uBvaqh4J6+CaOyZOXjEUYzfE2T
HsoucAsHxkuPN/NRJjKQJysUdNTDYY7NDOBKDDdIGhXjDj3Myhr8dYLHGBND2Fmg
EqH7sRiEvEjAH6pK3JJ9xV0K4yASct7vBK/I0KnnrCvnNltKRjC5XYqkeuSi78Nc
3RYstQu2mCaWCVuT/X5XwLCkGt+x/V7v/QJ6SOIlKiIX5RlDaBqxXfuSF6pVvcL3
w04fJKP/XKY01clO5tjFwJGFgKKPjNmHyrpL4r2rtTuMeQ/qjnW1in4VHVqEVPEq
1S6elZ2U+JM1QiC7mTJa/+LzD4C/9KxvurmhhdODyQDo6ElY8KdDX2cGd0VUs/Kn
RE+Eqrimctxh1wgQopppsuc797ApdhlB4q6oP6SdhIBhx3n5gfqtboYnggNr0bqE
agtXY8qN7rJ8Di9TLPkqjaxPHsaERs7+lkUg6YrDrh8W2o5HVVN8nZX6uLoPCFJO
Vml/77goY40D7GXJ3iinV20KKLABQGLkmQjnXrlt8C0P8BEY9pw=
=EA18
-----END PGP SIGNATURE-----

--lygmlimbjvuadv2e--

