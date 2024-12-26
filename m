Return-Path: <stable+bounces-106120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D09FC776
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9821188280A
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7722914;
	Thu, 26 Dec 2024 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qJZ0cbFB"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A6360
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735177741; cv=none; b=fLF/h0LFPfLiekLfjRPz/fqorV2toOce76DIhZ6uU0Gzam66r9OJaUYuvROxj+1PL0WBKrPrQxhKY5KnO4NGD9NgDKWewyPX8IgpyWkKk5AaL3KzfD194MqVIXx5KOHbbOKsKKXcdoIJcAyX+EyEutJMMb8VsThdvP2JMiMYRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735177741; c=relaxed/simple;
	bh=bWwSYKadA07KmwbzeaPMaTYKaSAUwYxV/ll+Zi6vSnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OM+ggPwOECWEc0dKeUWmi8mjE1O3LZZGk6ZjcZxy23rhcEEXihlgfioDzdtT2lsYUlk8OQd2w/ydZXSL/z7jxg44/6nxAem069feIf79wGtHmXV7UfJwUPQRyXQR7Xh9nLsuwEhPh82xeJ8QQpa1p48wPXx+zhphtDT1GaZJY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qJZ0cbFB; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735177722;
	bh=bWwSYKadA07KmwbzeaPMaTYKaSAUwYxV/ll+Zi6vSnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qJZ0cbFBHBQZfmcFmz6fiIbZzs2tYnLpTbpIVjNa1sQbRUczW3T8oL/K9t/u+cr9O
	 hbNYIVJk+Q6Z1GzfT3h0Rc8lMN9aPhn3HPWqKVV4qDbh8wEI5H6EZB0sDXapLCZ1k4
	 kAXbQnLjSPse8kA8V9z+IN9f0V1BtWDXkD+Fvw8c=
X-QQ-mid: bizesmtpip4t1735177719tzuqou5
X-QQ-Originating-IP: hfBpJA0T8Tpugu4UgfzQlLUckOs4f+UqdaBvM7LjBiM=
Received: from [IPV6:240e:668:120a::253:10f] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Dec 2024 09:48:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18014970393753908179
Message-ID: <75C5E32C0CD59E4A+9f9b7696-8383-4bbf-9d85-b1aecd5b1e21@uniontech.com>
Date: Thu, 26 Dec 2024 09:48:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4~6.6] MIPS: Probe toolchain support of -msym32
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20241225181141-941d612a552d1f6d@stable.kernel.org>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <20241225181141-941d612a552d1f6d@stable.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TUVtc5Xc07N8sOxGkzCzDeaE"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MrLc0h1D6pNrTZK6zp5WZwr3fWLf51iakIa1kCajqXx1OlCXxwgQRwdf
	xnzZk/nwS2UfzgXtQmYFcSpjAqLFXOVNVpVhV+3Zwl3k0om2IGq+6S45JmE9H3OpRfqgCJx
	Cv12siaKct/k3qOT8o/kOBQtsYJKi7R97fYcV4Nf8yBD+3wrLSFQZiSfm/PrMuym5hh0K48
	wh6CFWDZXMQuN8I/NQogFzxJhcXhlA6kLu+8CLM01h1+hjvLaAJDWBfoKqCngpTAeSe7tx/
	7/HOKaruQvznYKVRJ9bGGhQoyroC2waeUfeZ+pt1CuHgbmHro9y5bbpMISPw+L6nGgRmRpU
	jNwuoWXGuMx+7zBYzGfuwTDvaM6dFvXN1qghp9bfjWKlTgOcYT2aR4X5pbWuakuG627iWtk
	5BTbu1n2GuTBVzC5LZHLesNN8jlzXAWtoBPmxXnC6Q/F+ExSebsQDkDNU4pvVFtMTOxYDbN
	DF2zYK4N1lbhO9qx08GjQ/p0Hed6jQC74Ido/EkNMqTI/i//Lb71e7FQbJIiLH+mZLlpfLC
	fXm436qoXhEOEKlk+6Q3yw9WZ+WoBxQpfuGtc9BXhUMKEu/MKKpPwBqBVs+9eFmbfczMvGS
	uJTLk4zeoq8dus5WdZrwwf9yIpSzuDc3H1Z9V+5N0xW1qQrkDxnszbpW/3oeKnAsr32q22J
	3DBVO3KwTiReB0Xs9ca6JJxa4DSUH2gagHFx0DPIrssSMny2LoiFPKH/daSc79pKOHH4wIb
	N+UV+htAgSleMPrm4bUrOTC+I2YZClp4N8a8Uav5+AXqud7ggDC9NaAABkaoXCPbZyKuwFv
	arXGVbsBKlxK0JZ1c6j9b3iQPaRhK1qQrRpqv/mb9wJPK5r3pFYUawW/ZARD+XZIcOGYy/5
	eHrUge9hs/1TfbU80VUUERcwTKleBheBU21fDXJQH6vEnu17tqUvXLJowifALk3qPxT4uiu
	MzlxzMYH9yRetz+uCMXxObp65mxptgnrEebwQ0y6Gm5lzsWMTAhNDskv2XnTqzU4CEVXwWd
	Cw2NtWH97o3MgMK2kg
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TUVtc5Xc07N8sOxGkzCzDeaE
Content-Type: multipart/mixed; boundary="------------gyc0YZWVrh6rIgo31FSPNTCg";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Message-ID: <9f9b7696-8383-4bbf-9d85-b1aecd5b1e21@uniontech.com>
Subject: Re: [PATCH 5.4~6.6] MIPS: Probe toolchain support of -msym32
References: <20241225181141-941d612a552d1f6d@stable.kernel.org>
In-Reply-To: <20241225181141-941d612a552d1f6d@stable.kernel.org>

--------------gyc0YZWVrh6rIgo31FSPNTCg
Content-Type: multipart/mixed; boundary="------------NGJY0lRLZzLrv2r5m0IONkUU"

--------------NGJY0lRLZzLrv2r5m0IONkUU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2FzaGEgTGV2aW4sDQoNCkknbSB3b25kZXJpbmcgaWYgdGhlcmUgbWlnaHQgYmUgYSBi
b3Qgb3V0cHV0IGlzc3VlLg0KDQpJbiBmYWN0LCB0aGlzIHBhdGNoIHNob3VsZCBiZSBiYWNr
cG9ydGVkIHRvIGV2ZXJ5IExUUyB2ZXJzaW9uIGZyb20gNS40IA0KdG8gNi42LCBpbmNsdWRp
bmcgNS4xMCwgNS4xNSBhbmQgNi4xLg0KDQpUaGFua3MsDQoNCg0KT24gMjAyNC8xMi8yNiAw
OToyMSwgU2FzaGEgTGV2aW4gd3JvdGU6DQo+IFsgU2FzaGEncyBiYWNrcG9ydCBoZWxwZXIg
Ym90IF0NCj4NCj4gSGksDQo+DQo+IFRoZSB1cHN0cmVhbSBjb21taXQgU0hBMSBwcm92aWRl
ZCBpcyBjb3JyZWN0OiAxOGNhNjNhMmUyM2M1ZTE3MGQyZDc1NTJiNjRiMWY1YWQwMTljZDli
DQo+DQo+IFdBUk5JTkc6IEF1dGhvciBtaXNtYXRjaCBiZXR3ZWVuIHBhdGNoIGFuZCB1cHN0
cmVhbSBjb21taXQ6DQo+IEJhY2twb3J0IGF1dGhvcjogV2FuZ1l1bGkgPHdhbmd5dWxpQHVu
aW9udGVjaC5jb20+DQo+IENvbW1pdCBhdXRob3I6IEppYXh1biBZYW5nIDxqaWF4dW4ueWFu
Z0BmbHlnb2F0LmNvbT4NCj4NCj4NCj4gU3RhdHVzIGluIG5ld2VyIGtlcm5lbCB0cmVlczoN
Cj4gNi4xMi55IHwgUHJlc2VudCAoZXhhY3QgU0hBMSkNCj4gNi42LnkgfCBOb3QgZm91bmQN
Cj4NCj4gTm90ZTogVGhlIHBhdGNoIGRpZmZlcnMgZnJvbSB0aGUgdXBzdHJlYW0gY29tbWl0
Og0KPiAtLS0NCj4gMTogIDE4Y2E2M2EyZTIzYyAhIDE6ICA4ZTg0ZjM4NThmY2YgTUlQUzog
UHJvYmUgdG9vbGNoYWluIHN1cHBvcnQgb2YgLW1zeW0zMg0KPiAgICAgIEBAIE1ldGFkYXRh
DQo+ICAgICAgICAjIyBDb21taXQgbWVzc2FnZSAjIw0KPiAgICAgICAgICAgTUlQUzogUHJv
YmUgdG9vbGNoYWluIHN1cHBvcnQgb2YgLW1zeW0zMg0KPiAgICAgICANCj4gICAgICArICAg
IFsgVXBzdHJlYW0gY29tbWl0IDE4Y2E2M2EyZTIzYzVlMTcwZDJkNzU1MmI2NGIxZjVhZDAx
OWNkOWIgXQ0KPiAgICAgICsNCj4gICAgICAgICAgIG1zeW0zMiBpcyBub3Qgc3VwcG9ydGVk
IGJ5IExMVk0gdG9vbGNoYWluLg0KPiAgICAgICAgICAgV29ya2Fyb3VuZCBieSBwcm9iZSB0
b29sY2hhaW4gc3VwcG9ydCBvZiBtc3ltMzIgZm9yIEtCVUlMRF9TWU0zMg0KPiAgICAgICAg
ICAgZmVhdHVyZS4NCj4gICAgICBAQCBDb21taXQgbWVzc2FnZQ0KPiAgICAgICAgICAgTGlu
azogaHR0cHM6Ly9naXRodWIuY29tL0NsYW5nQnVpbHRMaW51eC9saW51eC9pc3N1ZXMvMTU0
NA0KPiAgICAgICAgICAgU2lnbmVkLW9mZi1ieTogSmlheHVuIFlhbmcgPGppYXh1bi55YW5n
QGZseWdvYXQuY29tPg0KPiAgICAgICAgICAgU2lnbmVkLW9mZi1ieTogVGhvbWFzIEJvZ2Vu
ZG9lcmZlciA8dHNib2dlbmRAYWxwaGEuZnJhbmtlbi5kZT4NCj4gICAgICArICAgIFNpZ25l
ZC1vZmYtYnk6IFdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPg0KPiAgICAgICAN
Cj4gICAgICAgICMjIGFyY2gvbWlwcy9NYWtlZmlsZSAjIw0KPiAgICAgICBAQCBhcmNoL21p
cHMvTWFrZWZpbGU6IGRyaXZlcnMtJChDT05GSUdfUENJKQkJKz0gYXJjaC9taXBzL3BjaS8N
Cj4gLS0tDQo+DQo+IFJlc3VsdHMgb2YgdGVzdGluZyBvbiB2YXJpb3VzIGJyYW5jaGVzOg0K
Pg0KPiB8IEJyYW5jaCAgICAgICAgICAgICAgICAgICAgfCBQYXRjaCBBcHBseSB8IEJ1aWxk
IFRlc3QgfA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS18
LS0tLS0tLS0tLS0tfA0KPiB8IHN0YWJsZS9saW51eC02LjYueSAgICAgICAgfCAgU3VjY2Vz
cyAgICB8ICBTdWNjZXNzICAgfA0KPiB8IHN0YWJsZS9saW51eC01LjQueSAgICAgICAgfCAg
U3VjY2VzcyAgICB8ICBTdWNjZXNzICAgfA0KPg0KVGhhbmtzLA0KLS0gDQpXYW5nWXVsaQ0K

--------------NGJY0lRLZzLrv2r5m0IONkUU
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------NGJY0lRLZzLrv2r5m0IONkUU--

--------------gyc0YZWVrh6rIgo31FSPNTCg--

--------------TUVtc5Xc07N8sOxGkzCzDeaE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ2y19gUDAAAAAAAKCRDF2h8wRvQL7k5h
AQD9/+FEnG7Q29pQchDxyq1zFSVTKFLk6G4tgowd8p240wD8D7BMOpXMTgeouVlMZQGUnT072gnT
zArb9fDL5P30awk=
=qqJn
-----END PGP SIGNATURE-----

--------------TUVtc5Xc07N8sOxGkzCzDeaE--

