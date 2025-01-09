Return-Path: <stable+bounces-108136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5D8A07DDA
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0157A34B3
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB92222566;
	Thu,  9 Jan 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LsV02XlB"
X-Original-To: stable@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19010014.outbound.protection.outlook.com [52.103.64.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C522257A
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440864; cv=fail; b=ExbB4umWkss7g8iKiX6Gl3K8odiToXXygU8fcnffM52QFx77QP24P0BeFD+LriXCAWFFpFosI+BFUgi5qwyIb2F0BQKL+PaLWDtkJ9kkJYJyqhqinYKQuWrFwBvodE9tVltpLAcgcENh8GNgnqnhXjvg/u4vHHtDEUYo8Jt2wK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440864; c=relaxed/simple;
	bh=wL46oJtlbN+86tyz6gZOTWNH5AxbN9YYHllu2FBgVVg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vCGLkv38tEJXOIkFrDfMhI5pVQmncVJjRQLxZnZ3cPXcH+9wHzoZOuD/VzHx84RhrcZVwMi8uqUQmkqkXYevtNh/yKG9FHXVTA+PctbKJU8f+CqmITmEYKyVn0ea2ZWCvVA4QRSyuzl3v++2BHSzNjeQOSHfWYmA/m0uZNld+EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LsV02XlB; arc=fail smtp.client-ip=52.103.64.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBDhUNrEZO2/jX7Ly6dgElhPxAQ713+vJJWLiML/hRXqQVb7kInfd1Fr3TfRLbi7QJ0PSYvG75D7iTaoSOJZS6Y3xA0NZ91xWKfiKl8P0FmfMZd4jM7ysE8F1UScRomSxuKLZE6LEfRo0hAM7VDTPRK3jf/1E+T/tjBHGn1e7F1G0pcL3Obz8RodXIncReYElKouANecnDk0PPndbrWscNXgaZo50My0VoUegp4A8dijxrddp6b4x/EemKYSN7TXangy+QaKyftaKdDBDLavwt5u1naMCYs/yMJlihCE/xPTMESdba6bvRgG6yQUHOIAnpDrQV9jEQB1V2E/uc2DHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd8DYB+WIB1TNGerK4M1oOHg6uDyPT8b8k8KED3RH/k=;
 b=JqdpjncEHGFHgkmb5sDrjUlxz9nIv9GGtMEqHVYdiHgMjHBETUvgSbIuOqrlvDTwzmYVrVjnANOCyx3b8bZB5TVBpMRNVb7AIY7nBT6V3lrwCjwS8z5SNFm3wFkcTr+q7l/+PwBF6F1WKNXP14ybxzEpFBh73RXbkDHqRG6FpqOiFAGF3ardNKLxRxAspVVAKZf6DWsUkViF0MLmJ4UPpCbYZIYnBG4/LM7jFUBmWkRE/7dNR5cOfNg1hEjCCL30TYs4glPdfpeALgR9adlbNYVOhKFbhFDJ+tJepShrrh/h3jD4VD54JVvH5VVkDptxfFXu2j8LG1fQs31Eobdp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd8DYB+WIB1TNGerK4M1oOHg6uDyPT8b8k8KED3RH/k=;
 b=LsV02XlBVaIpvKCjukjTmKTaLUrvsooJXB2TuqPYOKQmzXXMtkkAObLfRgeztaGpGZ4UG5vyCb8FrHqxxLO2DLqlRn+VhC7f/pJaDU3ZFkz6ZYAnQg+Q2CLLEji7zaIDO5v4DpCS+bzuYQVvaoMNngWljAyxKG+lC+rfqmWl7GZzTWSsHYHQRsVNCC/poe3utsz3Nx1WDNB/HMuDAtMHZbZaxMjyRa83hKHBSXhNCRicZkQIMK5xyQX9dKt0pCgfgx0jQd3wEtcq8WTiHNiWMaOiXch6WPjMtwkKpGB3IeQQJkcXwEY8qRFEB5lzaRx3S8rPGgOwLKL7NUgGdj8Gkg==
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c6::12) by TY2PPFCE5E5844B.apcprd01.prod.exchangelabs.com
 (2603:1096:408::3d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:41:00 +0000
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2]) by TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2%3]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 16:40:59 +0000
From: Rachel Taylor <rachel.apolloleads@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: Taking a look at the NRF Retail Show 2025
Thread-Topic: Taking a look at the NRF Retail Show 2025
Thread-Index: Ads6qYQQ9Arym7QnRMG+gsn7vUgHNQEvzwAQCNMf83A=
Disposition-Notification-To: Rachel Taylor <rachel.apolloleads@outlook.com>
Date: Thu, 9 Jan 2025 16:40:59 +0000
Message-ID:
 <TYZPR01MB4209FEDA3034A9D6F87DAD1D8D132@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
References:
 <TYZPR01MB4209A522147B2AFADA21AE7F8D202@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB4209C949A62D7D308F226DC88D2E2@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <TYZPR01MB4209C949A62D7D308F226DC88D2E2@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB4209:EE_|TY2PPFCE5E5844B:EE_
x-ms-office365-filtering-correlation-id: daa182c8-17bb-4401-2c63-08dd30cc65fa
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|7042599007|8060799006|19110799003|461199028|15080799006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c1nbULR8CQtuTvvdTxYqpuEybfRniNH8vSx6XCXZTCIoP0l9U9/uYBkMMsOY?=
 =?us-ascii?Q?f8Ov0CxRbaDd4DviKl3TD4T57LSMzfsa5EvBFGk4wg0GVXuguQxqGR8NeLhz?=
 =?us-ascii?Q?qSXTu+6wnAA3YIfGosMhZ7rmHBYXB+I2qN6nTKEPpNsu2fYkamK//NQhU8Ii?=
 =?us-ascii?Q?bQPpPFjAjvPVvgKin+OmDDWyv5dQrhQ9YOme7fadyPqWOE8+T2qsYqYnAIOi?=
 =?us-ascii?Q?w6kl3FRFldmNwSW9upVdPtERyf1D2KOrWxcEmlEEhbrJrr7P8Lqo6ik7qS4B?=
 =?us-ascii?Q?afYaOwz95HsYq0YQDREzJ7nKX/FaU7bYzF680b6pVuOTQEyWuF2PwbjIoWFX?=
 =?us-ascii?Q?Jx4qj8Kz7aXBIG8PAE7FnfKndYv993Na7666ly5y0S8FavwC+OW28K5kvJHY?=
 =?us-ascii?Q?lxgBG9RJiEPZO6kk+rEHkXQrmt9x3Vb6+echdehuWY/rD/p2PmzDAwN+b/xZ?=
 =?us-ascii?Q?pKOPmHFanc4Wm7VQBm9phpf3uZqtKZ9mqNZ/Lzm47ZcRwl+eMIJiwxUzgHLH?=
 =?us-ascii?Q?W37TwDgxwYSuIMoeEhbfwAG5jk0+V6ExbtCB2imhJKGGmbpt5xRso6jWfAUS?=
 =?us-ascii?Q?OeUz8Fu7M8lRUQwHFnShilXRcJoBfuEOHVctHnfhQ28/UQrgd0Juis/3oQ/a?=
 =?us-ascii?Q?8tohho3iH4i2lBRdviHKw4K8/oscXCU8WkjoHOs1ibVHhZzmgng4GVjABkfu?=
 =?us-ascii?Q?vR9WkAaV88gYB2QyDGU2QpXWlJo6oRbgQKXVjczM1fNmCj4LRjcTaokO73sb?=
 =?us-ascii?Q?Vh32ii1JZIy7pu7yxLa8Kok4uo5LAE2s0Ai4bLC/fHI8xX0BAPkBgnmqg9LS?=
 =?us-ascii?Q?maUizSqdtcm+wHDDtNAF4EgBSUvtY8BM7G/lDFS8D89i42U/6f+5HiRXqaOW?=
 =?us-ascii?Q?46+mORPZyQOsOidqcXTvlY4j67WraSEU7EXBngUJx/9L+9jRgm0FoZJ3y1ju?=
 =?us-ascii?Q?pjvaBv2KDc7sDYzC34w+r7R7llmrjvGFaQxaeljoCOt0HMgTXB+hjumG3phL?=
 =?us-ascii?Q?rmSJTifh6YZw98QrESFUR5l/n5A/+wGJBeL+xPsXZcVewYzLEWJjqvOioQPA?=
 =?us-ascii?Q?LKbRlnNTjthNR3VOJJ3D+8Fn9E3nrg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nVx2QodLTvBlW0F6prqACbIf3Xo1/i/2xfQC5LciTQ8qzgtOpv4HQMIpmCVK?=
 =?us-ascii?Q?6jtXACHhVZ+JA4myPnjawr6F9GzSuJiM2cMg05lDvZzRoLNgJaQtCSNuV5dT?=
 =?us-ascii?Q?lBGLxd22Z4a+TV0aZ+5n96oSfhvhFjWCP1C9kH6ICg8tn6O9B8IXpowX+nYY?=
 =?us-ascii?Q?R7COC6vRQFytBhjKW/qHgjnEdx984kfhepHej/hKmOMjNrLj9f25zt65ZwI7?=
 =?us-ascii?Q?ak8t2p/132+lTRhbj+Q1KTTwVKMM1ZETzTlPPQF5TR4BjcOzEk/4vmn7uHB/?=
 =?us-ascii?Q?BErfDjwQlU8VuRVqOSA8RGcKcztEzh3SsYI/bZU53V7Mc5LxXlBpVzFh9gc5?=
 =?us-ascii?Q?LvmH2V3pne+rpCzxtWeEtanl+45ySqnk90unNdSj7hktZVycLdjat/VorzSN?=
 =?us-ascii?Q?3GOSiMdL4GQe9BRkJhne17IesHFcorl1AilbJ8OwhHOsxnDWoMfPY38PsAgY?=
 =?us-ascii?Q?M5bb4o81JfhFTdrHvVdwKV2h8WbIu0ayq/8AZqwvDVMXuP8mueZm55fk5AiM?=
 =?us-ascii?Q?vp7Mk4YNyDWXTlT6IukP+c8fSBEnntIo2/B8OMBQv8m3zjFCjghijkJ37CDK?=
 =?us-ascii?Q?MufW1dqF5y6tXojtZk59UQ+R6c3WkWYSH8hUIJriU+WW/nHKYV0hXvwB+5KE?=
 =?us-ascii?Q?+q/ddPEbcW8MR/4I4/mz8ca0fKCN4arg6hUZnZQb1o/82By/gEOHQj5RlUYk?=
 =?us-ascii?Q?bcHQtyvvczA22nzCkbKIvcGEF0tIQkwyNr2xtFoo2Xl8+pBBFqcEw0H2DqA6?=
 =?us-ascii?Q?E/1H5gVjyUIFUmHp9LxiJi8IZODKSh2zUxIfoYmH2lJi0WBWsflTCZaVOUjH?=
 =?us-ascii?Q?4QdvO7X6HebFE70935DRndhRByPI78lIJnImcpMRXQjttGyWmx9LUYEwXbau?=
 =?us-ascii?Q?2snyFeNEW72r0Rn+Atxcr80CKVqrUFT/yJRnQQE3TEkfYUzkTrkvT1ItaP1Y?=
 =?us-ascii?Q?2blvNKNA8JZ4dleGRIDmK5hsst9cvJKQCaYo9aICfm4hfMEa1Mp+r9BRTzQL?=
 =?us-ascii?Q?rH+07FcYhWB1fT/+HN5ajSnWK7+zVwnzUddej8dgmOHoYvUiVvZDxb0W90+i?=
 =?us-ascii?Q?xKCZ1sRqhJXb47zPq/yzzQWR5LOgz5rljFjDu5epOfjK68xI32FW8Kh5dJrm?=
 =?us-ascii?Q?RyU/ASShJf21rsViEIfeoEqh1RBuOlBugw3WGv7BSUYbuOLqgVM5xVTyaFgI?=
 =?us-ascii?Q?ZX0iN/celiaYNC+piu69XjKtipuOUB9pbUNPfioogd4dRduAbpSLqXWDYpjY?=
 =?us-ascii?Q?dPVtOL0cGZDCBgh3SmK3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4209.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: daa182c8-17bb-4401-2c63-08dd30cc65fa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 16:40:59.8620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFCE5E5844B

Hi,

I trust you have read my previous email, Are you interested in purchasing t=
he list?

If you need any alternative information kindly  let me know.

I'm waiting for your response.

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails

-----Original Message-----
From: Rachel Taylor <rachel.apolloleads@outlook.com>=20
Sent: Monday, November 25, 2024 10:35 AM
To: stable@vger.kernel.org
Subject: RE: Taking a look at the NRF Retail Show 2025

Hi ,

Just wanted to make sure you received my previous email. Can you let me kno=
w if you have any questions or concerns?

If yes please let me know your thoughts, I will be glad to share more infor=
mation for your reference

I'm waiting for your response.

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails

-----Original Message-----
From: Rachel Taylor <rachel.apolloleads@outlook.com>=20
Sent: Tuesday, November 19, 2024 10:55 AM
To: stable@vger.kernel.org
Subject: Taking a look at the NRF Retail Show 2025

Hi ,

Hope this email finds you well

I am reaching out to let you know that we have a list of attendees in NRF 2=
025 Retail's Big Show=20

Attendees count: 20,000 Leads

Contact Information: Company Name, Web URL, Contact Name, Title, Direct Ema=
il, Phone Number, FAX Number, Mailing Address, Industry, Employee Size, Ann=
ual Sales.

Please let me know if you are interested in acquiring this list, I can shar=
e pricing information for you review

I would like to thank you for never keeping me waiting for your reply

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails


