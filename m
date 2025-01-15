Return-Path: <stable+bounces-109137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBB5A12589
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 15:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42DD3A51BF
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403EFC0A;
	Wed, 15 Jan 2025 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="h7DzfKie"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B8208A7
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736949782; cv=fail; b=dlaR79lufPeuQwkjT+ImszHjA8kXDkrQ3GtDigEmiedl8biBYR66mbbTdNd2dqumbv1taZ3CQO55IWwMBUzVWS44mZvnZSBMy049rUNhe/eC/HwgxWs/aFNHR2PZgg4b7/9yF+JtEkMoeKTfIizfhsR+lOsyPw8EYzv8ZMtIPyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736949782; c=relaxed/simple;
	bh=FK8ITfLVl8O7Hywkeg1HN55l/WoR5UnTQZYNEmD5EWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BR2pzWQBajzzc6Drm/LEianxXhbBOdl5GOQtvcrE5fdp7I6Cl/vzE/GoJLuXKm5Pcot/ErwoDn50bVv+ML6HkvRKNG81wiU7cUQxj43XUq9pSeDYEXTQPn8JVVkdYsIf53HkO0MoZqBQDdvVLLE2zpFl/Bfjo1LJoRzJTvIfQjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=h7DzfKie; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F6uo8W012817;
	Wed, 15 Jan 2025 14:02:49 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazlp17010005.outbound.protection.outlook.com [40.93.78.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 44686t8avf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 14:02:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcEZAPwD3ywTBbwyl3Vv4dfgsT0U59IZK/kKPUNL83qZlOIjJk1r6f/93pr5ulJgMLgJ7fD0sns8rQMp3yeNORWXf/h1eJ0O/eiooIb3noX9pEelbpwCI+VLxutJovKnUBrWhUChW0BLQ9O1MFBG4r1e7j2JT48pYSc4JD37JepAVep1U2gcOAerx7V/bu4TFToWJ2ihsOvFXC2jevHQAsNP54u0OfqzE7Y0L0f7J7Vb32MWyW+7xjLBFroApmBDLzFfYkaRh6OVySbywoUteWhriOwLFZWIdDZfk13JKq+OJppowG1+GGtWVDeNTEvxjASZruP2CHsl3fM2wbHRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK8ITfLVl8O7Hywkeg1HN55l/WoR5UnTQZYNEmD5EWU=;
 b=aujtsYpKNXLAO5kSc01Ipma0FyVmnyPbnJUDstkzpLX6BkPBrMA2wRyPXZ7r2yMANRAJFovFQXYp+IGrQ5rhBTwSO8QI2UhQifGVkweCvaUmsXGPGzikj96vGSmQVm84ff8NpYcLOpfx+IRmtdQm4taa0BNjINQP1hVBq0wr3bYQrvy07Zc3FDco/G83wWMsNeLP7IhTFC5J2Df/B2C2DBLNB8hhJAbZZSnT5n5iaBCoe2E3NrSdpMV1X/MxcsBaPgffsCQrpYhd4dFVglL9bd3V4epB39jQypBTpSUU3YF50nuZsRO+tAVTh0C3Co6vWrW9/tckkmenA5zjqipgkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK8ITfLVl8O7Hywkeg1HN55l/WoR5UnTQZYNEmD5EWU=;
 b=h7DzfKie41KMGRPCRAGGJWvvFNQeRFQlUeA+MOAKCBrkdt1iXzON969boDSSRDijfPwVM/5xEU2mAeizKL4BsQM7eYf7oKimJRmgfXfbOfWVUkWh81i/WA7skkA9cvuGF9+amgcgh+d4XgPC5C9JFaCBgq50ymJBFqsC7+jlXAGFQTs2oDpYcr8OsObBCFn7MLeIbjNW4VKldfvmyln1xuwIsKL5S3ONPyvfAMEHT0xkQEyiVc6gRBhph1HRq1mXqwArwI7Sjp5IlnVfqtAHh9Ls55/ovHApXkeE1IcQh9MFIxaRXsau6kdOBkOKHmJtlwLsi/1FiM6wlrEp5zprVA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR1PPF38CE4C16D.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18::f33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:02:46 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 14:02:45 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: INV Git Commit <INV.git-commit@tdk.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Thread-Topic: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Thread-Index: AQHbZbk9tfyA0hL+QECyqHZRISJBD7MXpgGAgAABIoCAAAZ8gIAAMUly
Date: Wed, 15 Jan 2025 14:02:45 +0000
Message-ID:
 <FR3P281MB175713D9EC9CD1A135227620CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <2025011346-empty-yoyo-e301@gregkh>
 <20250113124638.252974-1-inv.git-commit@tdk.com>
 <2025011500-unmixable-duplex-9261@gregkh>
 <FR3P281MB175777574467C382B07AAAF3CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <2025011515-perfume-bless-e2bb@gregkh>
In-Reply-To: <2025011515-perfume-bless-e2bb@gregkh>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR1PPF38CE4C16D:EE_
x-ms-office365-filtering-correlation-id: 92b4314e-c466-433a-f7e7-08dd356d4994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mKYT1bH+y8gtRuzyypHVzyxCQRgjFTuFNqDa+wN+u0D5e9P+LYc4L5K6GC?=
 =?iso-8859-1?Q?fgNJDqomptrwEn7V1jegW4S+gXlQTplhVKJ+okDDC8wKiYsW391viG+RIl?=
 =?iso-8859-1?Q?ZvNktBJJb74mWNYqOwl4ZNqO9xemwqS/wq94Lqdp9M5adCxtKwt795egjx?=
 =?iso-8859-1?Q?ptqfcQlDNakGJmCaH5X9g5BXj1re6rB+E8Ca0AhJnHnKdKUkxKKlS7zJCO?=
 =?iso-8859-1?Q?9mxq5IfDvzVrHqZBeqve4aucHBVbjGMaDrsZcrS/28kRusT41qysfsCzjn?=
 =?iso-8859-1?Q?1XFDbYHBaKIa8ZsOEX6UpzYGn1iqNt6Qu2nF/3UXRaiWFatZXjU0GCKsUf?=
 =?iso-8859-1?Q?wHDGL+EJUY3BGzyj/sg0tVMOIYfSyGmfINm0y/TmwqxgnOATFwKF/NtdLh?=
 =?iso-8859-1?Q?hIU8qVl77KOTTBFu6t7Ulbv2v3DdFdf0skv0rkSNJRaORyUEu7uBs6Zj9+?=
 =?iso-8859-1?Q?t0ZuqmKrEeUcV5dsrlpRtCUIqJA8j1obPolx8Dn6QT7xF2/m2FxHsmvL/s?=
 =?iso-8859-1?Q?MkJERWMM9EmDATSPF+Nn2nqXzusCxMNJwj69rpVNhVcOezf02raPsFqvlT?=
 =?iso-8859-1?Q?/826lrg6BKFn9oHtqGZHFz0noi5wuLtGDT9C12feaJJj0eS7cHIR8a8Mgt?=
 =?iso-8859-1?Q?/a8vf71mMuyP6Id3qS/vNXwehc7gB87Hrlwz6Vb35mAkQq8iWuYmAEOp7d?=
 =?iso-8859-1?Q?TUK9D6IOHwUVpjHzRf6nTJPoy5sKQkpwF2/V9LHC00jzAFEfF9TIDaBOuV?=
 =?iso-8859-1?Q?ztrHKHd7CL/iFZWYTFLJ7AxM/dWDJaVnxBIf4af3f3NptGjDK0vt48vdqU?=
 =?iso-8859-1?Q?Z79Zq33Ib92xL+OsY9+XCEt29q55cB4fNGae/F/G5xz1krEfGN+O3Dh4Nw?=
 =?iso-8859-1?Q?fGc3CtlDpgzY/SOAM97+SEYK9eNPtvN6YWILpDMU4Yq3V5CGiDAbZHlM6I?=
 =?iso-8859-1?Q?Fd96jN8N2uMogtdxCCVwQ0U8xPPbR5+ZWgGaLqOy5pkBklVSpKiFBgaPfb?=
 =?iso-8859-1?Q?HuOFWt6VsIB8+cDpmsrPknnWQMZmPfl00IGBWwr7OlPAm+X+4RSLphFHud?=
 =?iso-8859-1?Q?lYacOZDksNzdUEVodavEMyE54oy4tXALgMpS31F36/GJApNgU8CYnYl0fM?=
 =?iso-8859-1?Q?gPEoG1iFP6ON2hr6lnhqoWnFLgoC+Y1yfRqpBKmIpxPoZsHreKrAF8XVg5?=
 =?iso-8859-1?Q?uTzPzDSDRBoNeCj/NGDJmc/h9Jgtj2HFF90ZPNqjKiHiHazM/V3mS6Fxnh?=
 =?iso-8859-1?Q?IEYOcSUQwpuCZd0zFe3uTY25F8S3XsSPsT9dXwJh4PJQtkHJMRrdK3NfuO?=
 =?iso-8859-1?Q?lDUGvCzav+GmcWHLpsLxZGVc3lUM5TXgd9Ih3+Z7rcg/wXifRwlt55/mp9?=
 =?iso-8859-1?Q?gN4QzzRxP49A7MLxYrfnWv/dGnMaLiL+cGjGP06Ux8bhxGbbhodTwzJ8H8?=
 =?iso-8859-1?Q?CdMu9MgqBBHQDQcaXKAKAUH66MZ1oXGPulLJ544ilHJCXbpPh72/HxMRhB?=
 =?iso-8859-1?Q?Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Fxmq8xg+wqoF19gWOvTwKEU6jsSOKUM623fkFM2DBrE8osyPS3QlsDCKyL?=
 =?iso-8859-1?Q?74IU6NiWFEpIBOpKs0mwxeg/UKg/hknc9e4W3Q84O5Tsjr/9ASz2Mo3tCi?=
 =?iso-8859-1?Q?pbxs4ON1LPkcpEyXrxaKzsY7uPZftECNcgJttSjpIjGzm1obmOOw5vfKKN?=
 =?iso-8859-1?Q?vNcbEldLt+4/CGZ6rM3PKJdMjltdRu6fQvfIV+JO3yVjLZnYet5EhHsVtH?=
 =?iso-8859-1?Q?ATZBdjZpg7XkD0zjamCMixFcojRevnMQ+6FsMNiWQU7tGjHbNnR22k1zVV?=
 =?iso-8859-1?Q?jdTHr2iHMcMmiIOU7K47EqzLW+rBoo4i9Vw/VB+RAj0iIsRtQ72NciClZ1?=
 =?iso-8859-1?Q?5pJaIlFojG6KuN5b/HGPWiHNj/cKHrWDbeF4xaUlOD0mqQ6jscvsnl6cxQ?=
 =?iso-8859-1?Q?sVR1YCyKQH7plsuc8Zre//rPo5zBE9Y0JLhogS+wUlUR3e7Qj+Mn+m5xOI?=
 =?iso-8859-1?Q?9JUGyRn75zcN6Je7OdqXwbRiKtPL2FullYt2xDywAaAT0pSMUlk5kiMTZn?=
 =?iso-8859-1?Q?RLuK9/lChpeJytKIIje/IfZSz4i8UDYM6UtdY3BZOUpmYbTllP2KGHv5bj?=
 =?iso-8859-1?Q?nvd1mebvVt1M1U/xZFj43LDb61i69HEz1I1S17nbOB83VsseE+mTSUQ4ZZ?=
 =?iso-8859-1?Q?ascFdd00BI069ZSrAUloCEzJ41dQ/zPBoncCJpaWVfZLzBRJVLCMbLle+S?=
 =?iso-8859-1?Q?dV/PBm6JX+gRoTEW8nnmd0Tq7DHN1+30amdr0j/kUIpqFwucRj7JxJt7oO?=
 =?iso-8859-1?Q?prUFwUqW9IjTgYN08UyqE81Yulp4RTXqXswid4dKvzf2KZGjXXJQBYf22Q?=
 =?iso-8859-1?Q?vKAkkqH/2OTuAtFumH4nbCmr4UEzxYriUPDczzk7ZA2BSE5GEC2FKDUXFG?=
 =?iso-8859-1?Q?K7QB7sJ72W4ZOBlSYI/IsXHm02isNTjiGpiztlR1U3g3gSfvh5/sdr7Xvd?=
 =?iso-8859-1?Q?PWskO2rXZEnJDoduzKwcf+LnKoiVKQlO0qrFB4ATsTGGnMCyR/Fa/9+Xom?=
 =?iso-8859-1?Q?oULMHZnHf9kA2TiV4d2I+BHunV7UN/ccdAQy+YFmeZzl8cvWdIFn1cEGXE?=
 =?iso-8859-1?Q?rsP+v4QDfi2G8dLYrVRWKx50FYTBmrUgihgDIJJr9ESPYSRIsXln4/BuES?=
 =?iso-8859-1?Q?k/15QMoie92gXWQhQcrHlUr1mY3sy1Vp13JgctFcqchU2CzZz3N7LceWg5?=
 =?iso-8859-1?Q?hEd2s/m8gd4QQl+2ceOZi0m/Ixq9XgCueionWgYXHvWFrXphnFtkWYkbi5?=
 =?iso-8859-1?Q?8NztU9bVnx3JGkF9+oAyhrFAJ3GtsYhk7lFeEcwpAqVTY4gLIu0n9QI+VV?=
 =?iso-8859-1?Q?YzlOxYxQLTljA3n+iwwSQx3VfF7PS2jIdCjBMfaHu4tXlyYw0cTIP0r28O?=
 =?iso-8859-1?Q?pXraQD3nAUtRWvEjlLdW+wOdJ1NVAWGHhqy8oPsU4Sdr9eRkUsA+p/QpqE?=
 =?iso-8859-1?Q?oCp/leaB/OcU78njIaLe9USlN/PuAtNtBLjejveiHPy9jhIQw6VDEFh+6k?=
 =?iso-8859-1?Q?SfQdFnM+j4f5XCgAS/OsICZSslPyhqa5JDDS6BZfDXbR+SsWsgH+d+UJrU?=
 =?iso-8859-1?Q?kEVu7mWz5Qw1akvef9AlbT6S6AXnRNo1kKzBEx1DbVKa6SAJwo/IDzTACI?=
 =?iso-8859-1?Q?zObh3wIhmpEqUZTcQHMcmSoxiXXZ+bPZaBcBlCg3gCVgD/Dl94AaxuUbDe?=
 =?iso-8859-1?Q?6qzvudJ0FP5av34huq/qz0IvpnHe4sMZfi4P83teiqCZZkiQZBEmPJSqJB?=
 =?iso-8859-1?Q?NSeg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b4314e-c466-433a-f7e7-08dd356d4994
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 14:02:45.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCsug5hpehV9pd5ndmsPb7yhcch14dsg4w/4AMPo5GDdiFf9RpcCeRFflybNgoaGhu8l71Y2ox3kAN0VW8j/iKvNfYu/YIBk3jm8sV3avYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR1PPF38CE4C16D
X-Proofpoint-ORIG-GUID: v5h9dDr90mgzT_JpLi8vdb_XH2kW0uI3
X-Proofpoint-GUID: v5h9dDr90mgzT_JpLi8vdb_XH2kW0uI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 mlxlogscore=935 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150106

Hello,=0A=
=0A=
strange, I've sent it.=0A=
=0A=
Here is a link to the mail in the mailing list archives:=0A=
https://lore.kernel.org/stable/20250113135307.442870-1-inv.git-commit@tdk.c=
om/T/#u=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Greg KH <gregkh@linuxfoundation.org>=0A=
Sent:=A0Wednesday, January 15, 2025 11:59=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0INV Git Commit <INV.git-commit@tdk.com>; stable@vger.kernel.org <stab=
le@vger.kernel.org>; Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Subject:=A0Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write no=
t supported=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Wed, Jan 15, 2025 at 10:50:31AM +0000, Jean-Baptiste Maneyrol wrote:=0A=
> Hello Greg,=0A=
> =0A=
> beware that I messed up for the 1st versions of this backport, and then I=
 sent v2 patches that are working correctly.=0A=
> You need to be careful to use only the v2 patch if there is one.=0A=
=0A=
I don't see a v2 for this one :(=0A=
=0A=

