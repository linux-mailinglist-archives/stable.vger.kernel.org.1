Return-Path: <stable+bounces-43454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3E8BFBE9
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312111F2228A
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E37381ADA;
	Wed,  8 May 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="p8mDGO4w"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739C81AD0;
	Wed,  8 May 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167435; cv=none; b=S38BoQfYtqbpEl2cdh5ioTDg+yJcxIJfGw2iPNflhjapOBkHHlmDQFbN+QW9rA/asnn38YJRpP+QgyukqjNysc5zK4eQs0TwNrcCX2pHK9Slw35at7T3CKcTNu0XUWrVc4JAjOR2n9eHhzfL1u7UTx3FRFi54Y2vcOKbKgd8xtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167435; c=relaxed/simple;
	bh=mis4f4hQic+cmqVrHqnE/d64q8AUSunS9QlVMBWGcNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgzXj237QyNNnVR8eC/sPGo3zDE7IkMNwLsiaZfFOcScXu5MeDhZisaWgmE+l1YceCZ3D39bb9i4E8uCks3z2kukFVzC0+UXKJ0FrbPcChzeCXnHlXatBgn/MnVNJ0niSdhoWSEEq24NtokumdHX7wgu7/GpbSfC7lz4a5JyPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=p8mDGO4w; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1715167420; x=1715772220; i=christian@heusel.eu;
	bh=mis4f4hQic+cmqVrHqnE/d64q8AUSunS9QlVMBWGcNM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p8mDGO4wbjD+yc2z9PdI2m3RqAjEiBE6I9JVAYYB7YA9TEJbQhuvxDN+nm2b9VLz
	 hnBmiiBViXG8H0M4AN4gTdfFLIVAlqw4C2lDHqu+wVmSz6DtK0AvS+QncwbzuW/K5
	 vIla6XcY6SQctYORlBu/9o1trZNB+fr+OLyQhVQjGelhsbSyRRWSKEc4spc9SGbSd
	 BgDkiyGMhM889tyXI4gEhSXpL4IvFqocPsgp5DPt0Jog5knkjYrdrdYS1FDQxKhbN
	 St4ENxDWewY/HRGgGpNmi20xAj5xeoIiY4usNYHQ6S/3jiNCEybdoEoWTH2lQ6TIm
	 df5kv7zCo3nN4yDK/A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MYvHa-1s8yr605QG-00W1LB; Wed, 08
 May 2024 13:23:40 +0200
Date: Wed, 8 May 2024 13:23:39 +0200
From: Christian Heusel <christian@heusel.eu>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: regressions@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>, 
	stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	heftig@archlinux.org
Subject: Re: [bisected]: Games crash with 6.9rc-5+/6.8.9+/6.6.30+
Message-ID: <7w5mh4rfmif6wbufadpgklghsj4f5filwq4mo2hpmujjurjcxk@v4xco6ar3ouk>
References: <gifkxwcrswqevdig33inrsieahso2lcxbhcawu6d2qprnujoij@eqg53vwjamts>
 <8e7ed389-c894-418f-a8ec-1ccfb13e2126@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lq5oio6xbbfaa2c6"
Content-Disposition: inline
In-Reply-To: <8e7ed389-c894-418f-a8ec-1ccfb13e2126@amd.com>
X-Provags-ID: V03:K1:KHMWz/7RVoUc2CakhYSOASk3q50+WnFC+cPYcahCRHCaY8pzccG
 jWOB6STLl9DwNgPuPumVSH5QYOQVg0H7XIA88bEG+zmRqhjJWny7G8BqnxOJYc8DPWeUYyF
 72nY/zaS02TaEwKAJz3Pr4O8UK930xTdIs8E02HNF86ToCEjyQe9SqIlRgQjZiCBbkr1ypM
 9ZlonZ4xKb/T2+ieh2+UQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bd3DiT4rqUY=;kx2SZTLlCu6XNCOKaGjUFMCeKSz
 nau8QNZS0kdrl1+Z2WItr6VROMgCAHr8jA14KiS1vxvQrjn+DordR9Be+YlAcr/0rjttkyqX+
 Vf//eaqMuPE2rOGhAwjCyUdlityUC33Gy6Ie00FGCBmWNNgKQCLRywzC8o+Wq2K1spVtNzM+N
 TJdsZuc66lMAiX7Q7Nzu5U2+kpXzxKyAIOKOA3MKrknCnCrglXDfS+BBSLvnMzu5h3SwtnxYc
 WknKbQc3v9NlDtKT40OZi0Gwbr7X57aSJYSeY2cXaFFAxbzmXBl3RpPsQR9c86IyNytmbOxYI
 k+bB7a67++BZrY5/s4xHpXC6eU35NkAp+/wbOE5SF6Cg5Ce1EbBgwvi8O3asNHXEjepb9R2mI
 4ONdsRpojMJDv7c1lFT54Lu8boNccEHYiMEnULN3SUEaN7Va6t/5F36fHcp2XxVhmVmFoS1Su
 eJcvLf+iVY3iAzMEKLUeEncQTsF0+3wE8Yga+XqsagA9nAsIhIZedgV1obr0lHoCP5cZpdIoU
 XL4dQinN22bc8prFTG47+5leEL9FUFyq5ZNTuPG8hmBbpzDDT3NhHulCxbXNHIyvHDGE/N7Xh
 1QynWJrLRV6sijTxQEAePTKfk4ezG9qlvIKyADVctM4zJTgdPWM4bOezvde7XrZd2ejm+FYul
 DvrlBgDqwz4UWubMsrppfBA8jbOHStuCbOJ+OZOlTON0IxXDUxI6nI3J1BZClFdvrGcJhtFfy
 5W/XRh+XMRRld4I1gf5L25b2im8Ncyfv99soVQ/CpF2nAIu9jC9NVY=


--lq5oio6xbbfaa2c6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/08 01:01PM, Christian K=F6nig wrote:
> Hi Christian,

Hey Christian,

> most likely Michel just pointed out the right solution.
>=20
> There is an off by one in the bug fix, which might cause the issue.

Awesome, I think I was just missing out the relevant mail on another
list!

The underlying issue being fixed is of course the easiest solution to
this situation, to me it was looking like it was unclear on how to
proceed.

> We are still testing, but so far it looks good.
>=20
> Regards,
> Christian.

Regards,
Christian

--lq5oio6xbbfaa2c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmY7YLoACgkQwEfU8yi1
JYXFmA//TWCENR2652H/lvxOpY6/o5cb3wmzQCIF8eTlFuNyOBdhyhPZ4Hgj/Dig
+pkz7/IVj6gxC9NOJ3EXmu/lJfAwp5lfOjgGesEsO4JupPNHDlwxRVVDhebaNDJy
/cKZc2pJTtv4KiLUp0nW3omIwa/SG4AIeGeu5mJZKJWDzn8uxjhiieB0m+DOCXJB
GsvGnwvatbraFv+7RsWv+q8ZofmnsQwiUbgmAGUT+MReYEFNhif1PPvtZzsv55l6
wlfdOxQEX5GbtyWpGWSAKyJZBS8PK1HqcmGxLJVGQibQMc6Oi7mAQmzjT8/CGFYL
8QT/qCKVhKygF2SsEgYB4W5NyVWT6O0UUp2aufp+CSYxXUZzKue6Ii2g5VrybaBG
XNc5tvwxUJ2+Y4OjYlcBfT/fp3O6XxpD7di/A4ki7YcCT8Pm8dI354MBwDGrSbZK
YMWPC6UOPiVHi+IQFg0VOf/H0wGg14/9OpLs4021cu+CPvso8rFh1Y8JItoOI43A
wEuJ0WYsssXrF8n4nl2mQb4Q1yyj0pueG1TuQxgOQwG/jv0K/ljVOi8Ie8S0r0JK
3XW3GZrGTMyVw4uX/3eJMB6pPnOxUFtPWhqtcGPPAFTolGXjf6+Sh/K44QZKfs5Y
U//ZHVIgUEa+57v1CQwFLOu5AGesYXUCWbwxeJa90BkrWjbTkLs=
=ZNBn
-----END PGP SIGNATURE-----

--lq5oio6xbbfaa2c6--

