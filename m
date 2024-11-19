Return-Path: <stable+bounces-94063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D79D2E67
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 19:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597412846BD
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9CA1D0F68;
	Tue, 19 Nov 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q+c2NptI"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2056.outbound.protection.outlook.com [40.92.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D040BE0
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042517; cv=fail; b=klHQUhV7/mY/1bYusWa53MwQEnp8j5NjjEUu0CkaCShn3ILk2JBhnBScxkWuEjdLvld57EQ8uTmqzyxLPjNM6tn30poAs3dLsFHwBtZ+ePBksGgEuLiO7yTpUmZrtl76m+9S8DsVlwfS91WONUBYlYIuaBrV0mFjYWHo5clwnko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042517; c=relaxed/simple;
	bh=uiRmDjGFAqW9hsbNOsj6PpMf/+GEKIFkng3LidgTNZI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q+Ip95obIJSh+ts7nS5TqgTtki/uigxsxr9jfkoupzkSiiqOqdwjgqscHPHc5uBajR8kFPhy5czwAhDCCOnOo49Abv+5KhYaai8wmkSzum6UNTqTd7tuxsIoYyRkwu0fvSHRPA6ZXqQb9etH2HyHO57MTBvUXAWzv34X7ZxvJF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q+c2NptI; arc=fail smtp.client-ip=40.92.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eatr4mV94495OBmSdiVObx+FsMfqq+HSFzxQdkbkakvc+E0fF9UJXOC6lNHIwY80w9eu3zSLZgiQ19qCbhX6n8CsJ0T6/R9DDlObdhSWgQB8jYHIbSH45FFNIbgXicbRuZ0Zmo4WCYzrxbCfOX4t0EWvfpOt8BFWAaOtoY4RLQwmXi6EjNva8qotYdf9iCU0DIqm6N5AlKFMIVrUJxj1RRuBX9/nZJtb4zJnATVynVlJVeEBhnFoayGL66ABq75eOq9zqoEHZtl7FxZ72f6XGMp9lAFpWU/e/hJAhsxbPYOcARBitbPf3KHui0G8iRa0Pqv3rsoJvcxZ9qONSNdumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiRmDjGFAqW9hsbNOsj6PpMf/+GEKIFkng3LidgTNZI=;
 b=H69YIQWwjvNIlq0esfiZAblcNmojdYQ71WCqmK/NWoIQwxWMD24TNrfwOLkpZFfHraDRkj4HfK+LiWmR3Iog4a12R3y59cTF64e0crP4KRKFOuS3KzUTnd8c5kqTnS41bS1ExKFFQcPSOBFKEHLIXDJ5wroR8Vh3G4O54wl+iqXSyOjre8eOW9IrWhNY/UYEEF6vAPy3BFSADny+JU2kh5+OLe3HntoKhK83jNfqb2M0lGTwJUsrmLvKBqzvXzQ8Pz0lzzv9X4m5n5T2vqauE6WHIlhFgxwol7aegTtzzLxqFH3VYmIztw25rkunuOLiNIxMpCK+4nF/unWZMroP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiRmDjGFAqW9hsbNOsj6PpMf/+GEKIFkng3LidgTNZI=;
 b=Q+c2NptIcQv2QiAQ4aPtf0JSsSsBESlnG6vSfOWKnzYzmRqHLw85E3RJm9NxxDtRTEIPVHd9OhVMPf/31D4lB7mdgSsMKzlIwIVKnWvB34lbdM9lF6WtSxA7qvgCT4uw890//pIsfdR5YE7B3EQRagBIBYCareQ9ajW6jgsqGZZW9MGuEXpJZ4Xf5f6XM6bYaAFtJkHx3CnbvqP1vpuJgTzfgnEDhYRcsbQHCaJHnXXibFotjibeCVe9I4PiZDfo9lmFGnKIwBOQTEntS2Y20F4EiQVqJpooGbeKaIvxUdU/7WDado52k+ULNdyXrJYdXEdwKKVX0ZwGczAzAa9UDQ==
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c6::12) by JH0PR01MB5846.apcprd01.prod.exchangelabs.com
 (2603:1096:990:4d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 18:55:13 +0000
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2]) by TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 18:55:13 +0000
From: Rachel Taylor <rachel.apolloleads@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Taking a look at the NRF Retail Show 2025
Thread-Topic: Taking a look at the NRF Retail Show 2025
Thread-Index: Ads6qYQQ9Arym7QnRMG+gsn7vUgHNQ==
Disposition-Notification-To: Rachel Taylor <rachel.apolloleads@outlook.com>
Date: Tue, 19 Nov 2024 18:55:13 +0000
Message-ID:
 <TYZPR01MB4209A522147B2AFADA21AE7F8D202@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB4209:EE_|JH0PR01MB5846:EE_
x-ms-office365-filtering-correlation-id: e5a98ee7-d3ad-41c6-1470-08dd08cbb30e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|7042599007|461199028|15080799006|8062599003|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qgz1tmlDfAPz3yb3jOXsP02MNw8NvVWHw1fdCGDgm2cwJKUPMqKoOUxHxK2A?=
 =?us-ascii?Q?4Etpn8HhAhuz3VroHTAqVZM1ExSBUm4X+9VQXMROVtFmhsDzTbAQh0+IpLlr?=
 =?us-ascii?Q?K+if0MRhjjkaw/lpZIyXfJcNvgSFNIxgfK9HSew6Jp+JmWyUbgQIfqSpBPx8?=
 =?us-ascii?Q?WPDpWtXhXEls7T7K25BIudxmfFl46ovaW7uIeDxJYbQKNKKU8hNaE4C+oEc6?=
 =?us-ascii?Q?kKTGHTjM/ZJfBkwMuOp5S9s1Jtm0oCq8dSVSKs4gpU7RS+Feu9pnPHBD3eWr?=
 =?us-ascii?Q?nLNxLgmWVsX2DZrGrbysYy/nbFu0N3ifc5N5BAMv1Fb90Zy3QegP5Wgo/CJz?=
 =?us-ascii?Q?Y/zavX4We77mIfBeESwuvEvTmIaEgbYsAGiBxRMM0Y4RoS+WYuiiP4f6Qe6X?=
 =?us-ascii?Q?JbB13LxJBNLsKSzuLS8meZRLA0/Sh+jRSNOgwxRVhiV2y3T+cxQSeuL/9S1t?=
 =?us-ascii?Q?HM4P9XbigJjN1F8S+aB3giqmZtqbSoi18pDkd+kj9SVdPjvUATWqd06QWFyR?=
 =?us-ascii?Q?x/50gjnCwkDdbqeqp+K2wdwnEej10ZXRNGOzzkzuRTnAfQsW1iO0v5zVkza0?=
 =?us-ascii?Q?k9/2pSA3hokkcNIoaMM4lz8eSafhmZW6JIL6rlDaI5Ga8AYV2+a2IKCseRKG?=
 =?us-ascii?Q?ik4vnfy5yoML6U5zF6jdbj6Vzzljkfr8SRE/es5hZJhaARs69aSXnQ6E/KWE?=
 =?us-ascii?Q?2PE75m4wzsxccI/n3J481SgBJHlSMyzRdIxFsXKBkZZ+RWvXWreoBc6sMypE?=
 =?us-ascii?Q?nir6k7FIGUbnGm3uAJd8WblxRfzcTIADnhOkogGzMk+bOQWzEUO83wCTLfwz?=
 =?us-ascii?Q?WTSLl9F1AOqeXAmbCVMU5sBGFdKklAN+WiW6PyUNBPyn5JWcISEhPP9CmnD2?=
 =?us-ascii?Q?n6t2xKc5Ycmy3GdNF3k/rR9N+UEjZdNFX77W4Ob4l4k9eu80z2cHHnzF5VoI?=
 =?us-ascii?Q?es3648Heh/hpRl9FupBYg4XLqjq1SVeT21d+DFxST9VFIK/Q1IEomQqY27oA?=
 =?us-ascii?Q?7KUYS7JQ+mSgBdaPpVJYOXACDy+CthCsQtFkbj3XpVzDlTA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ScFrL7zIz2ujXoGmPdBnt0dxLD6xaguAdG1OhX8xIokj6TWo4r/TPp1c7BHC?=
 =?us-ascii?Q?JkWoMb3cyRb5J4vnuP2dBlL9YYhSz8/gd5Gt/SMCxAZ8clbJuf5I8Arln3qz?=
 =?us-ascii?Q?vIkJGw+hbfelFSKEMhrxiN+gXHtTLmDYUV7pr56k28YBkCEtfydb1DLbHzl7?=
 =?us-ascii?Q?wBT70fQUhawWIeXQzPVw9dG2mji5CC+YTGs6/X/KeX2mjF0veclCKhadyYI3?=
 =?us-ascii?Q?r0175W1dlHQ/rsAkLAvdl9fIlcf5daMjquI8Yfr67OszXBXOqqS5VjhnLWa+?=
 =?us-ascii?Q?XDebF2PKsfDwRTC+P3P0YuWVY9V35hsoVe+opjdshNPkZp5tx9in718N9q2p?=
 =?us-ascii?Q?wPfbD853ehyHRIybqJABYj/OKRGZ9M17lzTvnY3i08+ZpslnXamG2MW1tQei?=
 =?us-ascii?Q?JAOFSHb42kzigf5OxdyizV4qVAl8OYOeJuuER2N1AX7vEv1wmDWw8DgVsj8O?=
 =?us-ascii?Q?TJzl6ZHYAZxEtURRoaW3MATtc9dwTLGSRq42CblpMldxqw3PPjyod1+6BhXT?=
 =?us-ascii?Q?EnfmnTtKgk2RtgwbA8jy6691oqsckOWzZ9y6chkIzfrGhVgzHASJir5HF7GY?=
 =?us-ascii?Q?Wei8sinE5h+WeKA8BzTNEID8ikeZSUu7fR5MdvxyPkGJ3hEVQwbHu25z85RA?=
 =?us-ascii?Q?t95zmm66JJSZhiv37Usz7Vi2KCd6kRs8hGJgP9gQrS5LfN4dFD0pNfZAbDQx?=
 =?us-ascii?Q?l47+2F+RobIVNrbrEI5IGU1lOAKTVhaFgMBunYgcxVdQGGzejHAHZaZO0Hfb?=
 =?us-ascii?Q?PecmXv+9NJru2144QXZ6IMgfwarnIA4J41Hcn0d4nP9kSYhk5JCzqmiabghd?=
 =?us-ascii?Q?chW/JdXJ+WT5yEJ1KtY6pJJhaP1xnEL/eH0WvLk/1pBQGoQLSIFrxRShzbyf?=
 =?us-ascii?Q?dfd3kfyi6uHDYtS3i7lExNgbKtfaG1bDPlnrcZGLG0oFq1o2Dvjic2YTb8n5?=
 =?us-ascii?Q?Klx3yS5jv8sGCfKWKaK1+oSSPBqYcXZUH7ePX9zn7QH+zUnPnGLkGCYNmo9u?=
 =?us-ascii?Q?O5anArM0H3Zb2qXNd5Zr27kSzHZdIqNH4T/SxZgN3msVBdKHY2JPJyqNPIoA?=
 =?us-ascii?Q?6XomJ/DWtKR8W4T8xR0VgjWnllRqqYztNyqH8DEfMSNnyQ9d3krlYDrtoKh9?=
 =?us-ascii?Q?feZfivvkCLJ/xb+pt/quG7+Xent3cJIqm5bOW4LBz2Hvj+XrtStlthjcpGTh?=
 =?us-ascii?Q?WSsn3Gv5vYPgbzSgqc8GUQXlLUWp3h47A/orBySpy180h3+8sR6XqBTJ8/2n?=
 =?us-ascii?Q?lUvFUDd0IfXbQUIrO3A5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a98ee7-d3ad-41c6-1470-08dd08cbb30e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 18:55:13.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5846

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


