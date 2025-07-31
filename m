Return-Path: <stable+bounces-165670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B81BB17318
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81927583E35
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C513C82E;
	Thu, 31 Jul 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mSCtBGpi"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2042.outbound.protection.outlook.com [40.92.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76648130A54
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971599; cv=fail; b=fJLLZ0KSznoZvlnbxDtF6GheMM1Xg34qGPobuN8dNKUpT8U3obu64jaAMBAzvp0PrtsAUujLJ7oMDgDsz5J5rRhNOseRlWmguVhgnz0akHByaM8YgaPo+X6MxPcEaZyPDsB96eGlEO7B0VK1rcVn0RPiApP6cgqgtO57zQbi9qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971599; c=relaxed/simple;
	bh=wxLBcjMVrzoEntEj5XLBhMBEt34da11Gt/7PqDSnsHQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=skA84UBVHuO/sFtNyEhepMdu4Gk7fvCXHWUqppJvYkCUxNMs3Lm7pU87dbJBFPSfcPB60Iei3K5pBEMaEE+ChpklmrPeraaFukzzHgbGBzL3Mn7rEDJaKuegucGS93kaqkvNl6nGIgqbN8fJUObrZtwu6XoK2TwEPEdFq2dLGpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mSCtBGpi; arc=fail smtp.client-ip=40.92.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ5RDDVYkas7gi4CM88/XfLUjMqu3ZRYi/i8hpa4g3R4M+9zxjRZNhvle39eajNlYr86XHTA88Y81/a5/SlNtawvzVQl/9lFySaK3dxeddi4mcfBHsCXtMoVrw+/2zZBPrQdzZuuIgqa5SBwN6T0zGSFN2w5B0cNGCS5JjNeWd7Dm0SUwnDPztaVaxpYNU0qnFhDEoUQAligIkK6H9Iv8C89lGiyvrcAhzBqPMf3DOBGp4xNqTrz9wBhh0d2spP7nKgJ7/mDpxh8OqVorF7kcwMl62gVc8DfUkGy7t6l3VOdbhOU7k9CSQTaCbU4Lcmdx0am/nOHOKtHr1sPBk31Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxLBcjMVrzoEntEj5XLBhMBEt34da11Gt/7PqDSnsHQ=;
 b=bUf2oi+aho0yBWHuHcUwXCa5BuESX4fAC6oIjHf/Q5rdPUyTuOXQrZ96+eB/MrCcxsWm5vzrtnd303QVvI52fy27ty0f4BVLXJArYlq+c8uWYd6kHja1cm0c4yLk6wVl5OelJctFoVRy58nCjatHGoSS65am+7P2AYbyRVTAAoTcnCQnJwTSOA+wZQEOKrT0T4IHB0ernWQwlB4bXFyaySkhV7XKekvIvJw/HC3PLcGOFnZ5bbfQjDYsEVLvWVxvQCbMJb409UTZ3UWlqzg4mRbyIZErwF7R2RLmRQCZa1q+VrsVPaE3F2i576ne3Zo2aUDElk/ToFCaNA/3JofftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxLBcjMVrzoEntEj5XLBhMBEt34da11Gt/7PqDSnsHQ=;
 b=mSCtBGpiZolcWJhybP0l7I0bRMSgm8T1WOVKxqKRSTSDJT8iKNcVXo0ctDEIp0bmx7vqGxV4D2lGupOCGkDgOhQdC/mD1wquYX7u/ZSQCvGl+a/DCd3rqtVzQsWA00IgDspMVUoclwP3tzby7yuSDgpR5kQ1BBc7Ets18MFm+Veoed+mrcIU7q6y7VUvBnR8hBjlOgh64+nGH9MKSUvhGCUYoWrhlOw2Dj8IDQeX1pL8dKeSI+e53dOvJDUIbSAJWZLq70Td2wnT69n3ec7Rg7pR/ZeFtJUw868+N0kjPTOh2+Ky8VGPIhzD22waob/36WLMa22kQO323trzy6nssw==
Received: from SN6PR17MB2477.namprd17.prod.outlook.com (2603:10b6:805:d5::31)
 by PH0PR17MB5504.namprd17.prod.outlook.com (2603:10b6:510:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 14:19:55 +0000
Received: from SN6PR17MB2477.namprd17.prod.outlook.com
 ([fe80::c94b:9ff:95b4:eb55]) by SN6PR17MB2477.namprd17.prod.outlook.com
 ([fe80::c94b:9ff:95b4:eb55%3]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 14:19:55 +0000
From: Alyssa Campbell <alyssa.b2bconnect@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Need to Know About Details of NRF Retail's Big Show
Thread-Topic: Need to Know About Details of NRF Retail's Big Show
Thread-Index: AdwBpkU4ecjm1N3LRyyvfAySeVuscg==
Disposition-Notification-To: Alyssa Campbell <alyssa.b2bconnect@outlook.com>
Date: Thu, 31 Jul 2025 14:19:54 +0000
Message-ID:
 <SN6PR17MB2477FC99679D9B77EDC731E7AB27A@SN6PR17MB2477.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR17MB2477:EE_|PH0PR17MB5504:EE_
x-ms-office365-filtering-correlation-id: b088432f-7def-4abd-6fa8-08ddd03d525d
x-ms-exchange-slblob-mailprops:
 CLk2x5OX5VaWByBIbrvOWDzHensRyrdtU1/O1gWIJHfPMEE0wqoBXcNpLQ3MtpUqhrEF583xdXeHyxAQRUIMlPmnX9ltmU1a8HidLtzqt9UqCeKuQB/aqYLow979Tvlw/DwhHbLTJ3ESFQ7SkarPNPePlIcSgVI294diCDQc2TUtdsR9cxFkXnkURinavSbH1unw2Wo2Y2EyC42gzr/TDZjdJ11oK7BZZxKyykUdFy5hM64EsoBoJL8t+cYpiIb+SHnmj9dUD1enP2LFBZFMhLJodLmqZi5vCIZ34s0pZXh10Zl8e3NUJvMCoiqG8WSMYQWRBNpjTOroWHyQQVvPZ66T2B0XSqDFletQQ/giYbbz/0smMYiEb4ykl+tyhSDwSCPJQF7afUbb7sbPYZiun/M1EX1BBOENXjE7yqhT7+mEjSHpg+rCqo4bBMbv0lcQyZLBzDz24cLzRYxyBL2gUYwRRUSBlOutNwwtJsBlkUOX3w+HjL5eXeaGpWqGw65ISyw6KG2tA12f1Rfio8ycOQZA6xwv2lRsv2hezqCDnaKlxigEGdlvIKWG2dCxNMEj9nHHgsxZS3MzVIlvV4WQ1XZPpLnQ2tNv7zT9STLLbGJC3tDrMwFgMHfY+hhutxoAo5Qxu72BJoyQfD3UEAN88AH/uA2zfEt2tJbTA3KZszaqnpsP8GtX3ZPzym4l/vUEeUs/Xml29gV6ugQqXptU0A==
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|19110799012|15080799012|461199028|8060799015|39105399003|40105399003|440099028|51005399003|3412199025|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KlE+KoGqRQAKUZSArnZembblYfZneQDT3bZhNJZgyMgeiKJH0UOTWbvIIr?=
 =?iso-8859-1?Q?XGqYCU4c73PoN7LCyWZ548YzXIgts7mocPv1cLtmFSzG1aHin5F8ilNGhY?=
 =?iso-8859-1?Q?ea7NUOn73Hc40s/5AhII6Vwes6d+8cJc76DD0grZJVOJOjn2QRtiULTjvf?=
 =?iso-8859-1?Q?NbWV3/ie5WsQ3al20QCk87aE8bXSS48IWNLbOM1idcuf8zp64MpZiuo6Z/?=
 =?iso-8859-1?Q?/3ihQTbgNWxM0WpFoLfChPP6bCBuC00hHqarybhCxl1BE37PLXOJ8dyNde?=
 =?iso-8859-1?Q?hzQiw8CNY9CiP9EDXGLMQ1qDXqrwdrif1j/4k5xgSvZ3Segg6pKlsY92n9?=
 =?iso-8859-1?Q?PBqgAgLvV8zV6Dz6epRyFjwqJfR947ar4VABC8t33oFyr0X2SXQ/x9uNVR?=
 =?iso-8859-1?Q?TYzRbtqQ3dxhQmV/k6PKcaF5X5wduRZE52nHcquA5R0QXkjZF76Wb6+QHF?=
 =?iso-8859-1?Q?uX6t2O3eZIy0Ud+PJ1wlCh8+AhM1fz2lhGVazsdycThR2OL0cKV3VnHMCv?=
 =?iso-8859-1?Q?gZV7RHnDoEuOltEejiZWM/B7rF8hpqXHm8dVhaMF+Kcq/S4BR9j+38P99n?=
 =?iso-8859-1?Q?6ekp7liUd0i/TEAoPGUuSKvDtD7ei0XgccnUA1xhFt/DRFc1T+k/69xtHw?=
 =?iso-8859-1?Q?8TgW6H9oQ821xlDJbkA48w8EiYsAmOuSCrlTHbnfbbWy/ct/d4FKkJNR3j?=
 =?iso-8859-1?Q?yhdqoUBn0xzindoZk/Od5qF5+OkNzTYSgoeJGNLG/1q9i7iLp3pHChIwnX?=
 =?iso-8859-1?Q?cV5OUmrqy8Zm+rx5vN6BVWYGpuHKXQEtdrNqEKhQofCxgWm5sn0nNuELoB?=
 =?iso-8859-1?Q?H1RAb4zvlo2ybG1/HoxyWLDgNcIryHyVu7ls63NgkGTOFkbcLe8v0ZDqRu?=
 =?iso-8859-1?Q?GIZQ1EW8fep9FfMDYGuGtpQnhioxwA4iDs0/xN4JQlk1wxZAl9WUQynT4s?=
 =?iso-8859-1?Q?6vPvfP0RnQHsuiuJgGk5nNIDxDehspSmDNYyNEcGVuS6H4Hu4CxayyFNwZ?=
 =?iso-8859-1?Q?YhkXxa4OM/22YrjFpWto9zCq2XrDEq/oPr8Kl1wslsTWnl+de5+Gk/xE8V?=
 =?iso-8859-1?Q?ooY5PR9PMNmNkmE9BFdORm2agjLeNH5C9JHQdNsy1CC7XsFEaW4aXj9uCS?=
 =?iso-8859-1?Q?Epi3o6NNQ1fJmeALmVd8YR6yBkzUeUFmIakO779AZWdI5F7lQcycvBBRPm?=
 =?iso-8859-1?Q?xuB29bH0Zpnwuciu+8xOv9rQ2M2Z0kvjOepZqAwBafxni+kd0J52nn9xAx?=
 =?iso-8859-1?Q?FxVek+9YaargqqsMlPwTjbRzolBl15orLF2PFFUQEBgdrtYd124QPa/uuk?=
 =?iso-8859-1?Q?akCk?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LMdYC6f0xwjedHRflInKZpJ6VfPQgKF/M9tMFoOE26IXY2iQdTLTBphBej?=
 =?iso-8859-1?Q?4IFH3EzYl0YGz4UDS8kyHBTQJWZ/26m6+zzB+6/0xg71tqKZysw6M92vmn?=
 =?iso-8859-1?Q?6BB97hrvwMb5xVWQx+uzjqrQJ/8Ob1C5f0xalOoT8bgM3SFCQ9OvmNqZB5?=
 =?iso-8859-1?Q?u8TZVV1q5LpDJQ4sKbI4zC9nkc2mIl8stUNOgQu2RVulQth0kQU/PxjlvQ?=
 =?iso-8859-1?Q?IEBKkVHnBm4SyY+kodKfup/dnqbfKFmmGQIy8sH9nyadkJdJdaQrIfYIud?=
 =?iso-8859-1?Q?D6lfAiSrZpeeE/gaC2V49SNXaiK0+XdwDYBScvJLLPL7qHFYEqsTAO47lr?=
 =?iso-8859-1?Q?i125+NHCz5I4cUgMhx6gC/cNLBYwUEh8Mjwu5UgYnbhay6KTWMg27Z/Mnv?=
 =?iso-8859-1?Q?iBo1tJ/A3vd9nYK376aamop8mJ44iPLdFhZ+owTqOQ2RYjMf6m/n2ayQA0?=
 =?iso-8859-1?Q?O2vzUqb68UbN7AIe+wiYj2BbUXWiTKQvm7sttcKHvucZQVSW1XoI6q/w/p?=
 =?iso-8859-1?Q?tuM9aIUp58zrbiZZYUC3IyVQZymdnaL8De5iOJKlMAKkji59M7cY9DnxVU?=
 =?iso-8859-1?Q?ebSnMm/m5wOY+3h9nwI6Ze3iHbMnAeT7aP3svRbmAVPnMsaShDvGo+pjk8?=
 =?iso-8859-1?Q?hWpQvNdAbFqyGioI1kOTjoCCYvm3o17yFU2rOuhTMkiuyWSLds9EJ4g0ew?=
 =?iso-8859-1?Q?+JfKNHqFYhCZKWDjxcHRfKBQDhu57XlwBBxVwJJq2AVqCUF00BhNux+tnG?=
 =?iso-8859-1?Q?Wm/b44L5tH9K6f51OFvyTd+Z/y8koFWPIifLd3gu1NPUfNIBbVpdhdOvqC?=
 =?iso-8859-1?Q?Ri+4hCRFvbuMjt9BPHptoCwpE1Il1ybYiNv/HlsCL3GZfpRvBJleMEDp2l?=
 =?iso-8859-1?Q?HorkOjdhfo8exp5Zw8HToeBccMuzfOcFPcWnsZJOQOExBafAOezsTn6MCP?=
 =?iso-8859-1?Q?ojAlV9OsvZ8J62L/U749zKLmeia8rY3eWu36BoUE+zoryreHrkfVNvn2N7?=
 =?iso-8859-1?Q?a+ZUpV4gKujvQeHI+lkjpZ+xwkwILp91s32+YE7/sUD1Hb5sOSeLvqOXH8?=
 =?iso-8859-1?Q?31XsLA0S2pnk7u38sw9tzcHGjxJHOE/WYIMFKQz/FgVR0ZFqqR1SiaEDli?=
 =?iso-8859-1?Q?0zpdyGSf/TWh0TdfEcg8lK8d2jolZ5czrakNIIX5um9u+BqxbWe1OFu6p0?=
 =?iso-8859-1?Q?CWNHiiSqmS99liKIqW9m+7ATO3YpYcAy6QQG+q8cmg7QBdmjTi8L/YmXbQ?=
 =?iso-8859-1?Q?c8Bw/6vfHwKN0sqxeOhMpJhgJE7o0xIxXelTQ+vXyZhAtwaHUqKoFajxZY?=
 =?iso-8859-1?Q?Pe6k?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR17MB2477.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b088432f-7def-4abd-6fa8-08ddd03d525d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 14:19:54.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5504

Hi,
=A0
Hope today's treating you well!
=A0
I wanted to know if you would be interested in purchasing the attendees lis=
t of NRF 2025 Retail's Big Show ?
=A0
Attendees count: 25,000 Leads
=A0
Contact Information: Company Name, Web URL, Contact Name, Title, Direct Ema=
il, Phone Number, Mailing Address, Industry, Employee Size, Annual Sales.=20
=A0
If this ignites your interest please let me know, I'd be glad to offer you =
the pricing options, for your assessment.
=A0
I'm grateful for your quick reply. Can't wait to hear from you.
=A0
Best
Alyssa Campbell
Demand Generation Manager
B2B Connect, Inc.
=A0
Please respond with a 'REMOVE' if you don't wish to receive further emails

