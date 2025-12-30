Return-Path: <stable+bounces-204194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 560EECE91FC
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 10:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF9FA30386B3
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCA2652B0;
	Tue, 30 Dec 2025 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Vburl/o7"
X-Original-To: stable@vger.kernel.org
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C321EFF93
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085273; cv=none; b=tqZKkGvtE+su36zRlgKqiKsNZPy50wgq4XbUqX86VQlu0xxVYaoTFqbsW5QhR7zHlDCSHUJvh1RRc8N+Mff1i/ve29+4v6qjxdEK1qke8JXuCSaSnvp4vAMWDs0HsyMEmYIlxEWazHhWpAcA/NG/gFp8sbONwpceRQize+6wAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085273; c=relaxed/simple;
	bh=9Ik39mu2v9hvn1lf/nr6ebiYCdN4FoREP04GtHxzg9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4CHz9jrjz9/Psej81nEoTFMxkoqf94tva8PVAcDmOTf4wgHqB9A55zw515F2AGSUVEK3j7NWJDCZlf8sP6ub7HSE4hAuyAFFpi8KZLzvkM739PgaGfdIPWNEf8ccHbfDR/1S6Eq3OLsXFnQ6P5VcxlBs8avzQJXwB3RRE1ua18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Vburl/o7; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1767085264;
	bh=+yloqipr5XRM3SgJts4WQG1jvkHWBhjWaiZ8/dial8I=;
	h=Message-ID:Date:Subject:From;
	b=Vburl/o7LLv85OtPBEOF0FmRhzIPWQcx8EPXoimrlaQ9r/8RtzLSMJV99u98IzloX
	 6wMqYWeSghEwVWhLJdKvgMjscU5W401xuZZdWhkMNjHbuOtY7ioMa/32H19CJE5F/i
	 bopJF+i9uZuuIPsPI6E7M36vWiHl7sImd4rtqlos=
X-SMAIL-HELO: [192.168.2.143]
Received: from unknown (HELO [192.168.2.143])([223.160.228.242])
	by sina.com (10.54.253.32) with ESMTP
	id 695394A4000065AD; Tue, 30 Dec 2025 17:00:24 +0800 (CST)
X-Sender: atzlinux@sina.com
X-Auth-ID: atzlinux@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=atzlinux@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=atzlinux@sina.com
X-SMAIL-MID: 3547804456886
X-SMAIL-UIID: 9A38D75C3FC94F998757FF6621AA3EB3-20251230-170024-1
Message-ID: <511cc15a-1f1a-4dc8-bd63-157c59a179f7@sina.com>
Date: Tue, 30 Dec 2025 17:00:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 debian-loongarch <debian-loongarch@lists.debian.org>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
Content-Language: en-US
From: =?UTF-8?B?eGlhbyBzaGVuZyB3ZW4o6IKW55ub5paHKQ==?= <atzlinux@sina.com>
Autocrypt: addr=atzlinux@sina.com; keydata=
 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
 oSclJ9Jocazn/UjtfqI16BsNwzAtg7LgIOWm
Organization: https://www.atzlinux.com
In-Reply-To: <2025123049-cadillac-straggler-d2fb@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------40EW5O0W09VneiXUoyt0wRGa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------40EW5O0W09VneiXUoyt0wRGa
Content-Type: multipart/mixed; boundary="------------0qvKTpUMyr8U9R8exa12WoYn";
 protected-headers="v1"
From: =?UTF-8?B?eGlhbyBzaGVuZyB3ZW4o6IKW55ub5paHKQ==?= <atzlinux@sina.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 debian-loongarch <debian-loongarch@lists.debian.org>
Message-ID: <511cc15a-1f1a-4dc8-bd63-157c59a179f7@sina.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
In-Reply-To: <2025123049-cadillac-straggler-d2fb@gregkh>

--------------0qvKTpUMyr8U9R8exa12WoYn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/12/30 16:15, Greg Kroah-Hartman =E5=86=99=E9=81=93:
> On Tue, Dec 30, 2025 at 04:00:14PM +0800, Huacai Chen wrote:
>> Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
>> loaded first") said that ehci-hcd should be loaded before ohci-hcd and=

>> uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft=

>> dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci=
-
>> pci, which is not enough and we may still see the warnings in boot log=
=2E
>> So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Shengwen Xiao <atzlinux@sina.com>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>  drivers/usb/host/ohci-hcd.c | 1 +
>>  drivers/usb/host/uhci-hcd.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c=

>> index 9c7f3008646e..549c965b7fbe 100644
>> --- a/drivers/usb/host/ohci-hcd.c
>> +++ b/drivers/usb/host/ohci-hcd.c
>> @@ -1355,4 +1355,5 @@ static void __exit ohci_hcd_mod_exit(void)
>>  	clear_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
>>  }
>>  module_exit(ohci_hcd_mod_exit);
>> +MODULE_SOFTDEP("pre: ehci_hcd");
>=20
> Ick, no, this way lies madness.  I hate the "softdep" stuff, it's
> usually a sign that something is wrong elsewhere.
>=20
> And don't add this _just_ to fix a warning message in a boot log, if yo=
u
> don't like that message, then build the module into your kernel, right?=

In Debian kernel config, the USB driver module is config as module.

I meet this warning info in my Loongarch machine 3A6000 on Debian:

[    1.119467] Warning! ehci_hcd should always be loaded before uhci_hcd =
and ohci_hcd, not after

I hope this warning can fix in my Loongarch machine.

>=20
> And I really should just go revert 05c92da0c524 ("usb: ohci/uhci - add
> soft dependencies on ehci_pci") as well, that feels wrong too.
>=20
> thanks,
>=20
> greg k-h

Is there more better way to fix this Warning info?


BTW: I'm not a kernel developer, just a Loongarch linux user.

thanks,
--=20
=E8=82=96=E7=9B=9B=E6=96=87 xiao sheng wen -- Debian Developer(atzlinux)
Debian QA page: https://qa.debian.org/developer.php?login=3Datzlinux%40de=
bian.org
GnuPG Public Key: 0x00186602339240CB


--------------0qvKTpUMyr8U9R8exa12WoYn--

--------------40EW5O0W09VneiXUoyt0wRGa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEvGv7H5NUQYeSuhtTJ2Egg8PSprAFAmlTlKQFAwAAAAAACgkQJ2Egg8PSprAO
yw//cBvsQ/SkvCv1+bm9Ve6yNsUwNF+xvL2efKbs+3Pin/aiDpHUNeTjGZS7C/UWapiBHKMXfzTi
6xeIJ4O/RcqFZFdHH1DpgwP87nTw8QF9wbBo+YsM2+/W1o07NT6nU+hYRLkgjrFIvU+SEQtm2fyS
F6GQhZapfh503E9z7b1XR/oe+WT0yAQxCafGrl4Wbtudleu/c5U1bk4f3pLTRP7V00qwjvvv010f
QhsgT5c0Orf+4U6is1eLKRDxf3I7ftqTBCurpiTSI5E9saR12No3tuADeRA8KsZuByQRdHSC0V9r
BaOHy+wPCF7ja+JNA5ZxbYidmP32NVqSVlnRtbOLKC/znn0iuAE/VHihyuQ1jyZo9zBS7nFnUNCG
bNf7utN4s6Hrh5tcfo4vE7XykByRbcQ11Ls8E2OkblFcUXNIEeXpMTziptHjUYOCQHW4t33QB3u2
A6T/Rg7F+hsSgWasGZI0M/M5YrHHA31qduSsICEmsw0qTHeTQaMMJVUe8OqcAfSBF0CUb4ZcIw/i
YR3R6TMZVzwXhPHMZTgQ2g5gTYKAYe7i8bCVi19tQfdvohJqYChWOeVLy5wFlpCTcv4xqvpkcU05
QO85wYQiYZEEFG7AsMrDLKIzcxbFPkzvEcMcmZ8pIUbiOPrZXk3vAywIn3aE23DNE3fPdX9envoE
AgI=
=Ic5n
-----END PGP SIGNATURE-----

--------------40EW5O0W09VneiXUoyt0wRGa--

