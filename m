Return-Path: <stable+bounces-145947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02E6AC015D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F721BA44F7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF1E545;
	Thu, 22 May 2025 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Tu3H/uK+"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2057.outbound.protection.outlook.com [40.92.19.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934EDF42
	for <stable@vger.kernel.org>; Thu, 22 May 2025 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747873462; cv=fail; b=EKnguW2KncUwet/3JuZlXqw99tS+0LTQd1ggzA5cP/nhR5Q54wOkNQr8nXoaISeT+KmgvCrGkSk+Q/W+IzssUaq42DaJKHUeKYjTrAZfVKqLBd3/J0rc53QONijWNnJ7zK0TBoTHhaYi544Azy5iHQn9x2xAExb5a2WVdP/JXus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747873462; c=relaxed/simple;
	bh=uxFhFPH7Trmk5L9gRgpdeRS+MsgA8C95HQ7F87NuMoQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A0D8O/28S8HE9PoCWEwGJwXqarauPQeuAi1L58ZRtPdneha9hmYyC+UKJtaOJnMlB28q7oJaWYUtLGBzylG+PRlh3U2dseiAztmpnlp2sqtUaVMZv1nAUTPyce8VFz5BxrQi0KIbqTO6dsJBJUOLqCNT8LWe2lSuaC9Wip/BzcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Tu3H/uK+; arc=fail smtp.client-ip=40.92.19.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdxMhtRyA/cZIq/G6OFCfU2kbbWFpZOFydj5Q4b5gIOHzfHmglZ+hx6agh2tjdrDstnlepPoWRL5ceisldt4oJYNPrWBlozp16kpP+1ntCSVN7oHEvb3gEsAD4WLL0hE6+pwjLjQsYLilljm8Y6O1nckQi17y+7qmmL2x6XgxnkbnPo+haMx0gHjC80bqki0YcLvMNrfCSigTsH1EIpJcoLecSv2KukvQNXR4x3AcAE+0i2VukH/EewU4CfabjLQuJg3VzpVcHpgTQVqXaCXHe0dzYBl7gA4UjS7txBBFfMez5B8ABnemT9qhW51eh9iuReBiyGTc7zFtoGl32PDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxFhFPH7Trmk5L9gRgpdeRS+MsgA8C95HQ7F87NuMoQ=;
 b=stdWNBiqZChmr2sxyPufgHmDnImwyeRNrfUDwG1+Jk8rJLl3H28tqQrFIq0aoSo5yYMg3CIUuNbG4fJey4RnMVCsVs8QvMLCeqVZOuKXkx4QTTibCB2BgwyW6k0Ky31D7k3Lfr0Ho0NI/+hQU6r+ddmVBbSUpSzubBKb3pnjfWdcpDZzpjQThPU2Ye/zpzPgbjnP/n6Xz4QAOQoeMu+/xgWaYFwbXZa2RXMt3brsMGekUS06Hjo0E4FUJvbklWce33sQWvfNjZrWhb+9+yx09C8unlosungVH7dK0pdzM/XBMetpCLvvW5zAObiusXeLG28pI0ghFFs80e1Y7ZsVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxFhFPH7Trmk5L9gRgpdeRS+MsgA8C95HQ7F87NuMoQ=;
 b=Tu3H/uK+n1etVAgqdJ3iXGXMg3KphpELYWXbPEC4LzdvPeWwTTsPFkdo2wHYy050DRVhD3OIddq27MLYwAd1HEfhXTwCXTvNwihRB/gujEVI+wVAbmy9mdhlDKH8iZRQL9ZmgWssMeRCIwc1AWufC4qpn3Z2pLhFzget/ujad3tGCzn4v+GXF4yFTezdbmm/3f1GuGVkq6pYAZaenJywwz5nSbwRnGey21m4GKbk6+KLFeTv8ggYWy79aYmvv+C/VLqx87fOoaSqToesIRxD9aG0RlZnZTcknz0xtmc+NCzIy3sIXqrutqlLvjlXymrXJKBCiitrVeTe3rejel1G9A==
Received: from CY4PR03MB3335.namprd03.prod.outlook.com (2603:10b6:910:56::14)
 by BN9PR03MB5995.namprd03.prod.outlook.com (2603:10b6:408:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 00:24:18 +0000
Received: from CY4PR03MB3335.namprd03.prod.outlook.com
 ([fe80::e8c6:bfb:511d:77d8]) by CY4PR03MB3335.namprd03.prod.outlook.com
 ([fe80::e8c6:bfb:511d:77d8%3]) with mapi id 15.20.8746.029; Thu, 22 May 2025
 00:24:18 +0000
From: Jessica Garcia <jessica.campaigndataleads@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: Drive Results for MRO & Air Charter with Targeted Contact
 Solutions
Thread-Topic: RE: Drive Results for MRO & Air Charter with Targeted Contact
 Solutions
Thread-Index: AdvJlsSY4scXCsA8Sb+LnFtHfhogmQ==
Disposition-Notification-To: Jessica Garcia
	<jessica.campaigndataleads@outlook.com>
Date: Thu, 22 May 2025 00:24:18 +0000
Message-ID:
 <CY4PR03MB3335E27D1B689272AB9F3929E799A@CY4PR03MB3335.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3335:EE_|BN9PR03MB5995:EE_
x-ms-office365-filtering-correlation-id: e1ae58ac-005b-4773-595c-08dd98c6fdc0
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CIm2fppK3BHSBFPeUS9e4zjVU8GtJns8dQL3XV1uNF5Wo1hAYuFCM7UhLgeojhc5/k+p4+VlGYSJJTwxy1jXWXcHQVC4I67H/5riX6OOUmE7PvTJ1Aik4rLWKCP9+SOHyM8Y50txQ2FacLiDmU3/0qxcaInAuF2Z9IaPXV659K/VNqDodfVrfVRV567FZK0N34TDxiiDmWFVXKFvqEbBw3i+AGpqyJt4leYmHzgA67ahKd37JyEGL6aDQxPKMx8krXC7lIbeBsAnRZjYI85uoLJOTMy0ERHrPmu18+x+o+DGrVoCScRDC010jxm7CdPY4ynBIBRhBAScNBFXqU/qtQL+LYiZRlaz5nTYZRaUFtCySwxPQ75pM3miZP9R5SogG71xsakcXToVQ7/nPqcdZhJMtsIowFzNKq3ROonfqi6E1ea4tz5PMwnL6zJnhQJu8Ki4cBOq0ZfQdYAw8EaZaLbfQ8PS3ZTvBsh+VtExJZAYRxJYloU0YnJ5hPoGLiQIXQClJwsS+TB5VHAwim7da2jks62czzv8NXC38426tiVHXnGEAfuhg1znE4G9eLN1+UkchHb8j0XiwXsepuLuuptPY2b+xUEwpWmCMmZH07wqznQZ4BPHAvFxYGZ1M0LA1tmW6BZB5RpAk5Mg5LmbyFBnSymcSvgxG6JY1rbv6M9TvBMYQEMggQh7H6x3OVFFMPekQDlAEdhiTf8Afv0EI9/6eAaF/uL0S
x-microsoft-antispam:
 BCL:0;ARA:14566002|13031999003|19110799006|8060799009|8062599006|15080799009|461199028|56899033|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iughi+SBCjDi9R+BKmKjngMeEG1AhIqqS4EGKpU2EUKr/2aLTjzRZejKgq?=
 =?iso-8859-1?Q?NQVu7oIj9aU/TL1C58Nmtx7cnc8utOu8misyT0/vtiioTHsAEJlHnTmGnf?=
 =?iso-8859-1?Q?0NnWxa3Q8Fl1MEDB+xsfMqxznFb2oRrq6Ox/Zdw53H5T9JkTIZOEDgZDR8?=
 =?iso-8859-1?Q?41BPUcKPt5ET7Rl3AcSnuKC88/ehUhyIFeAZhSxd+nuOVzfNA9vzQMHylm?=
 =?iso-8859-1?Q?axdYx72LQtiugeru1puFKKA8we8bWuv93tWwEsawZj1mp0VjaHwuLfGSAx?=
 =?iso-8859-1?Q?g/cHLWlWUzyZLJjjYbUwkhngkEM4QF59M5e0xYs9ase4jcl6NP1xlNwdX3?=
 =?iso-8859-1?Q?z2uGpTMO67u8oKJcQj8avwV11yvXGr7YvGFZGScrxLiZTg8L8oG702o8yv?=
 =?iso-8859-1?Q?tKTvI497dPJBhwJGmqv+h4DIZkMKTCZLZXlENhOwvjfp6c4iuPzh7/+0CL?=
 =?iso-8859-1?Q?v7EZch124BZw2fcos7RvU+YyWU3KrYxrfBp8tbwjPGRYP0/AhPil8EbdxG?=
 =?iso-8859-1?Q?Y4Rem0ISmScxiAvshwo8kNFM3ZPZ+qPNIykdIEk55uD5eAqsWuJY0nHY8y?=
 =?iso-8859-1?Q?tHnYdR2fRNvbF1rKxKCMgvRE2SZxtKXa8jxU8qDTGEmYR+g65Neqxpu69c?=
 =?iso-8859-1?Q?O8GMnuUhCWml82rWXmHJP9zJycBHVljLWVcT+rIraIaaUVcjeRAUzm/2BG?=
 =?iso-8859-1?Q?ib2JKkxhoJN6v6VzM1LHmAg4DKxtzXRxsoHQaItxsJQHdv3ZNhV6ccTIoM?=
 =?iso-8859-1?Q?dr0+1j5QW2lwuqjijrIsc+nh3ODDAp/+EW1RwROvYSqtfQhk5c4kUV16aI?=
 =?iso-8859-1?Q?3W4E7cNJUBHRt0XmQ3eUiy3DW0Dmq/S6aHLU3xTmCfi5dUpXmiWPWnykIM?=
 =?iso-8859-1?Q?FeywLRTd+h/o3xZu2/FyYadIpJpxwD4WQDEPIH8MsB2XI+TqrxYAMeXfdt?=
 =?iso-8859-1?Q?SVsGXQvvli1RRNH81DXbgpc9K0lxqD03gdx/mm1BmyoqaZstwJNdNb/OzT?=
 =?iso-8859-1?Q?gLdpCzHzAc3YXTZ8xORRbpkxonWWNk2Wlz1CpqDi9ERNUjNggb0HTBQLgz?=
 =?iso-8859-1?Q?wZDyuXp9LzwaNG0TIenYbt/aG3u2xszHOmyzRru64cHgAyhCtBkb/q71aK?=
 =?iso-8859-1?Q?vinc2fx9DYNhQBe+4trNpfwm1mlQqg1Fpk0nKO6Ni0xCti+X1OppHXXyMb?=
 =?iso-8859-1?Q?jWjCfKdng+jkBA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?m+sc6g5HgLzZnaXut5tBkPclIMJEpOO2eTGYQ1H8VsTQOgN1fXmOkao4hM?=
 =?iso-8859-1?Q?MoZR6FAq02lcJcGZPzbJF8weWVlVYmGtkdS+xcU+Bpj28IYdvdft/mRipB?=
 =?iso-8859-1?Q?dNG2bPnwKAVVAPROsv305LZyoBCvmowbParKdIa2dgR6ENjZ/DEHj0WzpF?=
 =?iso-8859-1?Q?O9IdL0wZCHytFmgvHMycz6sadk8X89IJ/Z64q/HmfzUd5qRT5jGx0GkBZc?=
 =?iso-8859-1?Q?qss4qpvHrL/AF5fN+hFrZUl6QJZkpNwQ/FDHb4QR0EDpxuyiMAp8u1qU9g?=
 =?iso-8859-1?Q?dROUZQyb0541WyBLDKOdyBhQQHEoAVo47uvHkZlywmszzqmieYzy/5+u1n?=
 =?iso-8859-1?Q?B4VZmkyUkaUXcRbvsRAp7xzpk8lVQ4ZyKxsmXBkiUsKnV50nO/pM8PWd+T?=
 =?iso-8859-1?Q?6iUrghoL+0xHMGoYndR1xNiXaKI0OgqNrOKOy5uss5EUSBmueQjqCnC1Wv?=
 =?iso-8859-1?Q?SPeVRmt3IruYCZFzJi6Ll4tdVP1IUo0v/eJ5mr3AELcc9lcikD4kTh96kS?=
 =?iso-8859-1?Q?h3G2sI/ssiIxkdqjScZC/okjJqy+1AH9fR8u5w6oFIH1r7oMVZYH52UWcj?=
 =?iso-8859-1?Q?1vbI7VfHD9ybDmCo4W23ysmg9gdE4DsRqv0zaG8LKAiSGe8BvdrJYkOye9?=
 =?iso-8859-1?Q?e8ZWd9npte8wJBbx6jpMThlcK5hVz5gjI3YRrHzesqCqXVmbJoMw2Wgtep?=
 =?iso-8859-1?Q?/ABCcLbP4H0qOo52ZNpdpA8CQZWQDIMEPqKiYD0UCaG4B3Ix8NzLBfyu2t?=
 =?iso-8859-1?Q?w5cknMjZEbrHAOv3RZG4pER0JnbMXe2QBU3EbnDHwX0UhxhkXntBE75bI3?=
 =?iso-8859-1?Q?/vQSWR+WLQ8hRhXhf5X+WoM2t852l91OqMmuoVHxdr7PKZizBHtIbUCgN2?=
 =?iso-8859-1?Q?gMzVIX54feUd35sNw6HVMz4Q0DWtoeErxiN70eTSPIJxJoFMo3u/lLgpol?=
 =?iso-8859-1?Q?hzyebguV4WCIPgmNIVCIETvrj0KrRinX2N80JEBnI6XsJPW5siMDz2pqhq?=
 =?iso-8859-1?Q?27+tSS6IPX+za2/KEbFeh3uQvlBqcJTh6i2ITdDLEePJa9uTUuJ8g046TV?=
 =?iso-8859-1?Q?SgkIzsa2+dyUYSo4D2RkdLUcNw/noFB2qdbW3RGqEyfNN9vUAlg2sGWEem?=
 =?iso-8859-1?Q?8prldYv7OaJlBS5ym8Abyxga/rBi52MYXU8IxNBMQWzrYTMOnzk96FTshz?=
 =?iso-8859-1?Q?W9rNejool3ZTv7bUFkxnmH8jCMBdK2l1O/4y9gkZahi7DuGzVjkltHIxKR?=
 =?iso-8859-1?Q?cgw/pEf94BtqFjIZM1mKJEUkKmCcUFrgf/pM8Yu2+YrtYyX+CNaKyrXf6i?=
 =?iso-8859-1?Q?he/HQNqKbkqgaiX7awpiYBGM9rimWDEC+PAfAxh6IQCt+VBSg77oeDPheY?=
 =?iso-8859-1?Q?WcScytAK/KXfiFgX1boA359cVH6KR4KA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3335.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ae58ac-005b-4773-595c-08dd98c6fdc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 00:24:18.4325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB5995

Hi ,
=A0
Circling back to see if you had any questions about my earlier email.
=A0
Feel free to share your target industries and job titles, and I'll provide =
the relevant pricing and volume information.
=A0
Regards,
Jessica
Marketing Manager
Campaign Data Leads.,
=A0
Please respond with an Remove if you don't wish to receive further emails.
=A0
-----Original Message-----
From: Jessica Garcia
Subject: Drive Results for MRO & Air Charter with Targeted Contact Solution=
s
=A0
Hi ,
=A0
I'm offering a resource that connects aviation outreach with data-backed di=
rection.
=A0
We provide a current and verified list of contacts, tailored specifically f=
or your industry.
=A0
(i) High-Net-Worth Individuals (HNWI) seeking seamless luxury travel and pr=
ivate charters=20
(ii) MRO Professionals focused on enhancing maintenance and procurement str=
ategies=20
(iii) Executive Assistants managing the travel needs of high-ranking execut=
ives=20
=A0
For businesses offering aviation products, maintenance services, or charter=
 flights, these contacts are ideal for your campaign.
=A0
Please let me know if you'd like to explore the lead counts and their prici=
ng structure.
=A0
Regards,
Jessica
Marketing Manager
Campaign Data Leads.,
=A0
Please respond with an Remove if you don't wish to receive further emails.

