Return-Path: <stable+bounces-192209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A05EC2C444
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC803188C489
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E9267F57;
	Mon,  3 Nov 2025 13:54:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020095.outbound.protection.outlook.com [52.101.171.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79949148850
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178064; cv=fail; b=Idim9vf1+de2zWYi7dg+L8zIdKR3VOliLkoogcK4pyKeQYcb2dtOmRih+MYSHS+wnd8PPTDUyDRBlv6ZmeVpscZwItJnqnAEMk77ekhSVlY56yzX6Ildg/eFF8Ro6cXYIlXh3Q7IWE4Np1Ty0P/YicCOAbMhUHy/6teoqusu6DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178064; c=relaxed/simple;
	bh=HcL0172/CLNxcMH1MPGILyIHNNHL81D1+cXrA6n8D1k=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TJE5sWfp/qmCPOcXQ6mqLy2ShG9eA2fOSJglA2b+GbsHWXo6eyxJK4kKlyxbgzXAPLaczPgztn5Ub6vsF4dn9oAUT13kpCvNEuqIKPVlRs+1y/bCoSbJfZswbEgz7odxz0EYz/t9L/kDnyvH28IjPXsppzj05rVB8SD5Cq+AI5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jumptec.com; spf=fail smtp.mailfrom=jumptec.com; arc=fail smtp.client-ip=52.101.171.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jumptec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jumptec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk2ay/00xn3NebOV78oTV7Bd3/AgpuT41PH8NfSdwr9FdXDyBc4jt364oJ1iJKxOcqJ4qaKXwjWSuPd+Chf6HhplChb++mnXhoixpxS1p2Ued/T9JYRSSq0trTTkHoF9jL3gstqUsNMWbb6Jxb94Ko71Q/SoOhF4plApLhL0TxQiRwREd+ru/34hYUKp+UUIRVR+IoND8egAzmHTlUPD7FzVa+r8UDirjFjuXYvSO3+VSD9O4YmozSQusxrWsNa4EAHhyAE3gmoG+Z9n6qBt+GJwRXVXR2jY9ypDwWjQO+2uvYl5youkRILcnO32s/JuQ2Ve5Ci1/Xqd75ZgTy9ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcL0172/CLNxcMH1MPGILyIHNNHL81D1+cXrA6n8D1k=;
 b=ScVmp6VXe5vobcCn9ubgqan1CbVDDjLH9pHeoecvGRIrrE0Go5cbyktCWB8EIw6BMRwG4cu3990pFW6EyzILgvswVGUqoXKjj4gGt3ggOMW2Bi0YegFJ/XBE0FYFAqvprauZy81xw/D9z81qoppBi0LzmdLMYROxhH4p3CwqDFNVRCLwChyyKRzWE6fQaOkVartOWY055RM8JBVzWiZXbiSTKUC3SASXPFmoXgaiFsShNUufTH8Mkfgh9bUeVUoxAN+ihj62J524aGqSevy9JcMGvlBE7C1ZlgYjGUCJLuCx3n2tDueZTdMn1UfLnaBCvJp2FqzXihB/uSESIKt4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jumptec.com; dmarc=pass action=none header.from=jumptec.com;
 dkim=pass header.d=jumptec.com; arc=none
Received: from BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3e::10)
 by BEUP281MB3687.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:54:18 +0000
Received: from BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3455:bc1e:5194:cc17]) by BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3455:bc1e:5194:cc17%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:54:17 +0000
From: Michael Brunner <Michael.Brunner@jumptec.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: For stable: [PATCH v2] mfd: kempld: Switch back to earlier ->init()
 behavior
Thread-Topic: For stable: [PATCH v2] mfd: kempld: Switch back to earlier
 ->init() behavior
Thread-Index: AQHcTMlYH82OjRmPnUWfeyxk5WVxMQ==
Date: Mon, 3 Nov 2025 13:54:17 +0000
Message-ID: <d63de3930e7df2726de5ef482b6f46b5c69f0154.camel@jumptec.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jumptec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2787:EE_|BEUP281MB3687:EE_
x-ms-office365-filtering-correlation-id: f1c06dfb-3dfb-4975-4c2c-08de1ae07b62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-15?Q?X/5E5lDcBjJ3gnMS2Cz6q+FzM6jfXwVNF+nSK3oFyYCm6bgNn2hFwHtm6?=
 =?iso-8859-15?Q?Kab2F8gl6ora0GWVYxLPgTbXNp7Nj3F/jvexen45FT4p0I3cGKQMS5HB6?=
 =?iso-8859-15?Q?6Kos2Xif/cGghjilv1hxjsri9tI10bemSPictCaBRQ8t/Y8GRbiHn66ad?=
 =?iso-8859-15?Q?vgP/MZbjxvg6s9KN0U60wrbZh7CVFhrLKNYQUKdRMaWU3QuS2yizBx0dd?=
 =?iso-8859-15?Q?2bkzZXQYKhd5JvoZwZ6Q8heCp0ilkbrixuf6q2jWqTeeZxzDhd29nRFWE?=
 =?iso-8859-15?Q?g6eP6SyQn+IH6UD5435Miqbm8ktOlvjaXxeEQNqwHgcWkd0vyuw0vPtAh?=
 =?iso-8859-15?Q?G6SE4V7pwX+EqeeBHaGi+GNw0OrM3ITEV3qQ3XadKcGfrH/BuTdIwGSoh?=
 =?iso-8859-15?Q?NNI7lSJyhSa6bNDtYGbBsuB7OvgOAPEpnK/z+aEynTwWajTQqOUYaHRy2?=
 =?iso-8859-15?Q?NZGQ6BFX8CKxaasmaJmcsG3OAag3TMPJE2QuKVByl6qBlG6m+3OUfcYSg?=
 =?iso-8859-15?Q?F4s+5btHwzwbPvn5IwtZyroNd1yvzfINDagIazt3ZYlmsfRrigjFnWMSj?=
 =?iso-8859-15?Q?TKcLJKCKad31QDU8r5o6NzPxaLyjWeusSlsgh+/tHm/QpulhqGON+h8hh?=
 =?iso-8859-15?Q?4F2Luyb+EAgx2/51fMbANggBXyVZykZ9EAYNY8hfm6gUvRgQRES7Xx6oE?=
 =?iso-8859-15?Q?Pt0WWd6iJ3rtH2GA3iC+AISf/bo3qb+p8vmBSudYUaUAMf4d18/bGJwBl?=
 =?iso-8859-15?Q?jUNebjB9xy++AEd0u3eQFsfB60JMvQfw235BA697a3kxGK8QQrQTPIob6?=
 =?iso-8859-15?Q?wKCHyGMEcMBLyaFPQfPKu1OgswGgl1XM/RE/RbQYOT1CkJIaSGAK7QMi2?=
 =?iso-8859-15?Q?1i/ih4Q/D/l7SYGmTu4shp5YUJSq+cjuuqzhnlpebvUzSoI1uM3l3EJrq?=
 =?iso-8859-15?Q?Lj9zuwlcDp8ULvzOUM0lap1ByqtKMHpJWN4GOK833LRs1taDA3iFLF8xx?=
 =?iso-8859-15?Q?1ifB2dhPExRgzHsRRDlNyGv1cHNGCOcRPniwl5ZqAg0Z/1UXkyoJ/IU3X?=
 =?iso-8859-15?Q?SJEUB1dOOPXiMnTmosx/hNYslidC2LlrsP5GbGlnhdxbLSfJpr+TRyMMr?=
 =?iso-8859-15?Q?trZGcUnRXBUVcJrKbuuc0O9NWavRzrbPwXOBMSElXH+ba9sIHAtqL2YHd?=
 =?iso-8859-15?Q?tLdjsfe2Ot2NMdo7vmpfajJNri+c4pV0d/R6Q1BEmXjD1nv2Z5L4I4W23?=
 =?iso-8859-15?Q?fy1SdYyoOPJWN9i98rKFM6G6uP8rmCwY9ZIz33cnbsDgVDVPvgPSRg8sp?=
 =?iso-8859-15?Q?QjXM4Uo0MhA+bCP610IyBCfcLIVixoBuLns1wn9xm+lY/NlPhwaDtnf2O?=
 =?iso-8859-15?Q?xujHky1vLEIwy/W9G+7McM11YOtjKAZiSes0a5Ooq4GtkPv0IxNC6uG2k?=
 =?iso-8859-15?Q?VvOLq3tWOoNKFIkf1KeioST8Lzsz0KowxHsbT+iWIWcmbyPecB1DR9nPQ?=
 =?iso-8859-15?Q?srgldBz6nEE8Sb/ZzBUkKDgSff9g0W+XMeUTEccitXIug9+c86eMEL3sS?=
 =?iso-8859-15?Q?X/3LDzmEAPuGeVhMm5YHSxfYlVeTXa2YbtTYCL6eh4PXwhTDeTKs5s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-15?Q?M//j7TZ2NC6cu8yZhrjTHjfrimQo8b6bdYaoW0PXxVAvtMbm9S8pj/iXz?=
 =?iso-8859-15?Q?FUTLCy0/OFlP5WJovv6ObhtSPLn/LxNsXV2aR6nv08ikkyZfg43B95pCg?=
 =?iso-8859-15?Q?u8jTmXFyxR5WcanQoWATva7SUYKeS8paNG1GbSBkkQVimdw2OwV7uZfaL?=
 =?iso-8859-15?Q?q5nY5QH1xsi9n9sWY3/IbkEMRYep+zhilPt3antINcWBXmI8nfu5sVPf/?=
 =?iso-8859-15?Q?1LbOtwhbyFWFXyQA7ttNffO9vXpBJemU9SUPgB+nPhL8C+niV0C3BqGIY?=
 =?iso-8859-15?Q?leC3J46LO+EovL18JST6TN5A6ImrFtG+CBYl8yO5yUaUp9oVnf7Ff4bNh?=
 =?iso-8859-15?Q?hPRnCoxzb/VfmgO88EDPYew+mPKRi8MEjzRW9dGX0Nx6t0IZR6uUDnnLj?=
 =?iso-8859-15?Q?6bjksN6DMRpNoVBSkmhd+Rjw7MWNE8U22eADrKKy1cHx9MA/3zp6sXMLh?=
 =?iso-8859-15?Q?Wg21eFtGnRVRHWQ4kn79+GgxtlOSj28VS2iY62UUEKCx5qLmUco6rIpns?=
 =?iso-8859-15?Q?PstZOhHFvw1+XCRfLNqEsuCb0GyWWd7fYK/LyIEDJ7N156f8PhpqbZdml?=
 =?iso-8859-15?Q?H+dGyX+4WL/I2uGj3Z20HRYmZ6kpafySQ6mnv5WUNG0fsJYbs5ZBtQAqj?=
 =?iso-8859-15?Q?Ii3MsAzTACyxTvb3jpFwurdSTLBvLGSKgm4czFi/pZOBbkehOHpCd3z73?=
 =?iso-8859-15?Q?MVhHehIRSK7g3Pjl0tgwWg7bzJzXJg9UQaPsQVUF0Xp0Q4xyM+pn/pkz4?=
 =?iso-8859-15?Q?yk0/KQzh5r+dPSQ2/j5FtDp706sOl0MVKQLeb1ULmlGngE1ssIZt/ZtXL?=
 =?iso-8859-15?Q?ZPnzlazLyQIN5N16o+0MkUd9dBWwz31ZX30i9jojIXo+hI4S3iepAuH6Q?=
 =?iso-8859-15?Q?lPAiOWiQvL+WLcktDQeS8A8DjpNyA5iBxAJbUfbetOyV21yGvD2VZZF/M?=
 =?iso-8859-15?Q?1ceKmASLJp51AkPcYA7eSnH8nzpxJhTnYNH6BndFLaZDzqlKFU2DAcIYD?=
 =?iso-8859-15?Q?7KQW4chANZvmgtHqFIBI2Ng6rBywhkEHgS4fmuZ8qMvpgXqUbDjVU7dW/?=
 =?iso-8859-15?Q?amZbrZFMa3mHPWYVl/HbnI2O+c4Z5radjJw3GgaCfdNaUc6bzEGfl3JPb?=
 =?iso-8859-15?Q?4fZqOAqUeG0r5h1VZupzhr4JtWMBhNn1eptU1Qf8uQLYL7/pv7TmyrfCT?=
 =?iso-8859-15?Q?KpSpxV+ELznvHXCNSG5XZMSh0ly28Lz6fj4SDqHQFfszRfYTsmxE+vLsj?=
 =?iso-8859-15?Q?FK9KZMvt65PcWd/0OOAf9kVuHQ0TIima743NCn46L14EpPxCVycBkLKRv?=
 =?iso-8859-15?Q?b5Lt0Q76vr1eAsCF4kSAz2FjB3K4L1HOrAPOXHITAJO/2CRaON2fuQ0GO?=
 =?iso-8859-15?Q?ItLqiEgWFcrjDJOTwIa4Mk0rspUyR4ijthFEfg046byzwxycbbJ9gsL7Y?=
 =?iso-8859-15?Q?KyLyM/lt9pX3FfN1OBqpvSrsrBmnDUAnu3/z3KUYKz/SMEs9rqH0CeyZ/?=
 =?iso-8859-15?Q?7OlPi8xUoz0fvFecDA0reL0alT+YjZLPmQxcrDH58mB+NK2YHwvs8vogA?=
 =?iso-8859-15?Q?o6Ek2fblZwrm/4iMvlKd6Ml6q15Pn/I+C81jEQxcWsw0bwMovT/jm1PyZ?=
 =?iso-8859-15?Q?TG7+LQ1d+PDqMB7ZweMx0hHonCbFC1Ez649qDip2eZhjnfqduVvlsgZCK?=
 =?iso-8859-15?Q?chYyTplPT1cHSo0bctPPuFcG3g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <23508AA640B71743B077B99DCA05ABDD@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jumptec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c06dfb-3dfb-4975-4c2c-08de1ae07b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:54:17.8177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db368334-1f76-4002-a68f-6dc6e8b50cd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ctg3YfQLwMrUy7pbWvjSyv4rHT8MGtnrPQp4Pu37iGQVDHwNh0ZRO690dTRkuP8hjrLMBkJPFrIffOEqpJxHK0KkJMEuc6ZcyLpvCUkoZqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3687

Mainline patch information (included in 6.18-rc): =20
mfd: kempld: Switch back to earlier ->init() behavior =20
Commit 309e65d151ab9be1e7b01d822880cd8c4e611dff

Please consider this patch for all supported stable and longterm
versions that include the faulty commit 9e36775c22c7 mentioned in the
patch description. This includes all Kernel versions starting with
v6.10.

Newer Kontron/JUMPtec products are not listed in the kempld drivers DMI
table, as they are supposed to be identified using ACPI. Without this
patch there is no way to get the driver working with those boards on
the affected kernel versions.

Thanks in advance,
Michael Brunner


