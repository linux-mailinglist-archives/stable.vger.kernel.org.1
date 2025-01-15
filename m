Return-Path: <stable+bounces-108921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8625A120EE
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC44616A5DB
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A8248BB2;
	Wed, 15 Jan 2025 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="T9QID6xz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC43248BA1
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938252; cv=fail; b=GUu6psu3yHGbOTS3+yUcbGzl1EO81W7NWtfnxTHXkZoenU5q6H8perNIh6E9CRA0MuPr3CqQ1rdoPTUR4lwbs8I6tkIYkhvYZk0lpLatfX4r8dnpFK9pQXqHGieHddh0DesW5KCRPD4aFU+BXkuQnAtoB4SqraDdyeLMIJm41cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938252; c=relaxed/simple;
	bh=8Fx6VPYwNLjLNVPIqFNdADSopNI0P/qWFRtAh3VC8sw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kcwrov+hvrR0bbhfTPUGoi2pA3TS7M/4Bvhr/vvRmGy+1Do2L+6OWRx93EXaPrHxLhkkxXMSD8A0JmRp+qkcQRkBE/LYdx0aGS9WHfs1rSkPWxJd9OYd+dXEML5eKmdDzI79MD4J0NE/ZboYJbx1j76LvHtIx8O9KVkVLeuby38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=T9QID6xz; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F6vL0D014415;
	Wed, 15 Jan 2025 10:50:36 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012048.outbound.protection.outlook.com [40.93.78.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 44686t87a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:50:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI8s+sQiDTNZrh4Z2aEYFYEWtiWXEYcVkA4Dp3G1JbpGnqrLvUIdtPDoYJx0m7FGSDGcelIiqQo3hdmIo35UUbVTKmDhDh1wDhLStDRNIvC+vDck/KPgYDU0N4QBMQ6iiPvw2wRksGwEgKui5n506f+zIzt6zFwykivOUK8fn0edM3sBupjcwWTK1ombQnHoTtwNSPyQGy/KemQx3hQqieMX4jzvPXSxc4eTpjMBXER60yPG0jjyhUXedarstg2baKpbupoZI8B+YBikJHCt1enSOjai8kY71p9WOazD3rOo7E8VV9LvjvFO8/KyQ5HKCYjVwEoZ3N/7yemz6JJIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by4xEUfCjEOd0sLcOip23uVq8CeZPH4Hb9uPojTr7NA=;
 b=UdLJforWqTla0SQM8AlMGgp4gn77RcTuY81Ot5yKVQSrrJHNZGUhUf0J0ydmupFv3B3DHYUVCtjiBj7NHSBn3NzSNFLDkeLpS8faPPP6Zi+xPXdWkuAR4npqr02gTW1FdjRQjVHkb7f+meZI00aN0q3TrgnCEQlm9hn/lRJi5YYnzV9vXzJxZ0MATbiSVLb4QrPl2zbkvywJ5T0k4f/04uS6urxEx/Kh3wJc/R3AJgjCaUA1Wc3Du2ShryNrnCCT38liX8ViLWQDtcmIY1LXSzcq41T+6OU/5IGBreg0OwcTayz4h/7HqbSFS1eKok4SzaJsYWBgLNF/vQbXYpPZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by4xEUfCjEOd0sLcOip23uVq8CeZPH4Hb9uPojTr7NA=;
 b=T9QID6xz1fhe6hI7E6lY3xvr72ekHgzeJY8TSXztsYxjld8/+OoNoFBIoPFwXUaFAUew3GcYN9Vb/rbXZs8WQ81dIrMS23pL1m1VYaxIzVOlJhNkQAlYBwJaLzsKPB8wP6AG666zOHJ2gTUXBdN2slL8TXKbUj0eyDZdZmlk8eL+pR1QIaW8jsz/71U8AOXDhCLgtn43o0e9b8ARNlhlUs0mJEVyxN0jltmF//I1yjlOF7v4HaGzTwbDTFZnYef0PJymH5R9HdCKzrmDToehwIDPkus0IZyrnxejhTwjcvyyVsBLjeCbZ0O6xtsOUYwMHYIwJOshgtHxDOScKzo5RA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB2501.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:50:31 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 10:50:31 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Thread-Topic: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Thread-Index: AQHbZbk9tfyA0hL+QECyqHZRISJBD7MXpgGAgAABIoA=
Date: Wed, 15 Jan 2025 10:50:31 +0000
Message-ID:
 <FR3P281MB175777574467C382B07AAAF3CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <2025011346-empty-yoyo-e301@gregkh>
 <20250113124638.252974-1-inv.git-commit@tdk.com>
 <2025011500-unmixable-duplex-9261@gregkh>
In-Reply-To: <2025011500-unmixable-duplex-9261@gregkh>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB2501:EE_
x-ms-office365-filtering-correlation-id: ea3dfe85-3204-4f82-3ee8-08dd35526ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8EVzOxlUnzq1DMpycfHsFgBOKNpqN2dYGhtVuSuE3NU77RIeTJPIH/IS3B?=
 =?iso-8859-1?Q?o9LWb4X+TKx8QcEGS6GXmiugvevNKeM6OVBrVwPWHdAxs8oj7HSKPWh2Ce?=
 =?iso-8859-1?Q?G3pE+dVf+KDVR+0bgw8EIlOJPNiaEbLYqzOSyBOZOxFHgri35sb/i6rj2K?=
 =?iso-8859-1?Q?cg8AQ2xFD4azHWWb6jIgHmrcaiurURCm7nqkXhG63usAwkCDcSrTRz3ygU?=
 =?iso-8859-1?Q?z6Hg+xgIOkAorRrqIXps5fFdwRN3di284o1mI+mInwZ9u4myurvyRfJTYu?=
 =?iso-8859-1?Q?84oiUL18E9ezVqLj74q9jhWwAI1lYwixc83Ky4Zrs/NRtY1mB9hfVKOYtC?=
 =?iso-8859-1?Q?rVfcVM/lzAvVbiULFa61Gz/aSUnzOez2hReT60TQ9xJ8SSUTfPiVjLIWEN?=
 =?iso-8859-1?Q?m/oIjqrzRdo4u0waXWn3jeZvtWAAZraa6Q11cW2pUclYbiR35/ptFQ2uRO?=
 =?iso-8859-1?Q?QLBhdJTheDyeN7n3hhYcKdRcZDadzzrNclphpgcaWTfUiOYsrCoF8lHFA2?=
 =?iso-8859-1?Q?qBhNhkHE7iGzgrt/3NRBdHUSGSgLkHuSt/EI5DhRgPeXSXQoppkYgX64WC?=
 =?iso-8859-1?Q?zzpBbfbNyzqAA4kf+B7sJo8DNYZ05zwjqx5xFkF8xucyO4T4JxQBmsQht0?=
 =?iso-8859-1?Q?8yRaz3NdTGCuLA7ZR9IOpFcU5C18OHR8w9h+lfPp6kMnDvHqr9Fpvdvq0C?=
 =?iso-8859-1?Q?V30lpgVh+1B1QU8VfRjS6w8BseIxAzuaQrHFQ8D3gZ6HDlPj0kzV04Csqn?=
 =?iso-8859-1?Q?eZU+AJrBgKl3bYlA1BXSSDgPjyJw3gVUuAnhg59o/WXx2Plzir3XbMNOn+?=
 =?iso-8859-1?Q?GLVoBpZgOx5bJCnC4g6usrndgYOR7rr3kl9qHBAw1iGoCElJdsc//4bZao?=
 =?iso-8859-1?Q?cWZeCh9oGSFSykH7qLIsj/uGk59hKvcOe+um+s8x+C6wZelHmSNldL4nSq?=
 =?iso-8859-1?Q?3n8sLT5scHZcIliskhimCWsIpKgeVzaVGYkUvKQqy5YcDepW/vyIlO2tIH?=
 =?iso-8859-1?Q?s4ZeOYHicqXuAsN13uTno8mTAS2FfE/9/UiJb++xBjAZnH0XSTe5E/Criw?=
 =?iso-8859-1?Q?luZcLzu/ABEhVAHqM0eRPN2UtX6fvBM1ffw03liVh0t8ET2Vc+zfy5Hetd?=
 =?iso-8859-1?Q?TA0E9ejxJkxozbnJlw60dz8wcRtfKXzxk3g7b1jTqwgYmP/7ZcPIsxzuCR?=
 =?iso-8859-1?Q?f7XlQZ/NBVFY5vmLZMegZeMfUXevkB7j/3s9QHkXNR6aVjspS9a6d8v/s+?=
 =?iso-8859-1?Q?IFhd9oVP2+qkNfte/IU1plJ7eFx3KZfMFiFeRhahnMPZRoQcaM5PZ+MIx8?=
 =?iso-8859-1?Q?ZRIu7zsIAzeS4eMWk7ACSVlvw6WGdgU8vtgSnkU58Xr/LcOvWT8iQddnxE?=
 =?iso-8859-1?Q?5NMBbiRbXKwbCiE6lfRNs+6275Z1MuUxqb5qrzJ3c4caXyYjh4a9avKnWW?=
 =?iso-8859-1?Q?gjDaPwqLx2Q/V5L0PBYmwFLNObevkNi1gXzrGja7JfXdmj5pmzbG8mZRBb?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7spgMUsCV6nO8XIvyLKidA8Fud/pwnhyzv0YXxcSWq+9Ah2O6P8wZnyR7r?=
 =?iso-8859-1?Q?u6xpuqsv7TRf1qEpQYL/JmoO/Al1MycdT4+kHItI3IX7RgYZJ1Z5w6m4TG?=
 =?iso-8859-1?Q?E5uPz61eDOIbROrCXFf51oen/noBGeLoBxxPXmsaJQFEAjkuSBtQTKKusG?=
 =?iso-8859-1?Q?gjjsyeE1LxTXgWAPhWXB9V+XvZ+dHuiWvuzxP6QN0BvH5mgQCHQQvIUD/5?=
 =?iso-8859-1?Q?fPjYtVRoMHpIxJ0J3Aqh04eqyRq+lzYXP+tg5lzQOGtu6KyBxrB4jzrZcb?=
 =?iso-8859-1?Q?6z4B0WJw/7tzc2DSh+sc67FZUmdamboVUJ92kZGbv5PwMW3w/9BPmX1HTa?=
 =?iso-8859-1?Q?/bRdxAUe84l7dG2YEyBzSgQRYiubaHlKxKqPdfFgLb/6fhMgriTWcIoEVM?=
 =?iso-8859-1?Q?RM2KeiGVS14qXMa+0CBgN8EKnTrG1fFyrxhlyGz5m3SeqLxvEf3HbE1kQk?=
 =?iso-8859-1?Q?0JqxM22WQqgV4Gi6yc3ziyPpCkG0izefNbdPIo8WtZCohhY7EEXaRHpnHC?=
 =?iso-8859-1?Q?8B+eaia8Pf2fppT6j78JbCBfCW6AZKK6YKIzlWKwrraB0V9n0ZI5Q6577j?=
 =?iso-8859-1?Q?3I4e4zgdW2whQLyPlZTGrYQ/luaHtVoVGJt06DYtCR6YkC2r2snKzw1Z9r?=
 =?iso-8859-1?Q?hpRMXGnN4iFdYYj9/FOhWpk8Sd44vGeRWm7GPF71xXgnEyoRJAM78MT2K5?=
 =?iso-8859-1?Q?7SN2bjWepL8iaSw/Tan90FK9QflMn5Ac4SO4RmrvQCEpg+zP3aqaX3Y16X?=
 =?iso-8859-1?Q?lKJLhAX+d56CKweIt3lwvSC8R08RsBm2xq5ib32JL+JnYE/JEtVNaVXwX3?=
 =?iso-8859-1?Q?VlGTV4KzVzv67xtXYjpi+ezfH5WQs3SFaeBpIp2LsHqHGPiIUOtRjkhr46?=
 =?iso-8859-1?Q?HrvlHR57lfPBNdAKmoGAJA6QKozDE+FpivMTSnGqc5nLrVdIZZRQcTIxyY?=
 =?iso-8859-1?Q?pGG3xmlkN87dSx7d4VVCZYNqAhntTCjUUtz2v+s4j+CUysuz22OQh0oEpb?=
 =?iso-8859-1?Q?sJ2RqaV4w5qQcP7ib0onb4mKsPb4MczqGYESEv+D3t9BN/ieKCo9QdCRL5?=
 =?iso-8859-1?Q?kl9Jec+LMNvk5Q5aESKJ7kgm6tiByUqoXXwvd8T7qlKMc4rlzR3UDgMg88?=
 =?iso-8859-1?Q?oli+7INsY/9dtXfg2YMrjN9JbKElF/kzuiv6t9kBw80GMitXFIc+F7oeSX?=
 =?iso-8859-1?Q?hoC3H5k6RXeiosamF4IbGT1GvNy4qLVwflGUFOWlDn+IPTpQk1CXvRUn0K?=
 =?iso-8859-1?Q?QB1f/lJTRSq31b64qLOyxogOPVmoyWJglMewdfa4Z3+i57YTUdpVdriFF1?=
 =?iso-8859-1?Q?ckanfIwYiRLBFcvWWcngnBpOXY9/3m+hyZpXKNSbNbwVue+RFYRCQQ3kRQ?=
 =?iso-8859-1?Q?JftjM/HX2u0HYa1XX+PDZnpc+rEF4kvLgXLp+T1gun9EsSQJTEE2bYdgdC?=
 =?iso-8859-1?Q?Wya2KZUOhLfzr6hHNWJAi2Zohi7U/gmfNzzWMdfRbEVSGCeSPY0eznids4?=
 =?iso-8859-1?Q?N7xSixww2eiNTn+8ZQueJ4Y5Y3C8tLFsGqZZAYbofmyic9pe4UNW9VnZ7I?=
 =?iso-8859-1?Q?QcA3h18wZTQZEJt6CZyjbP2bMlYQbSh590g9qA/tlG0Num/dYA6Oszk/gE?=
 =?iso-8859-1?Q?6Mc6SxwNTwO/53V72flb/kuI6g8nnT0g8vU7Kv0FBjn2EYpIko7mcOSpiZ?=
 =?iso-8859-1?Q?hLdXHbYaXfeb/8beV46lVjiaBIOLNYXhdAJrqEVtFVyi9vn05lmoDx9rn0?=
 =?iso-8859-1?Q?H2tA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3dfe85-3204-4f82-3ee8-08dd35526ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 10:50:31.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuO7/4NxEaaikLjjsw3SWInRhH3uoR2ql4tN/Afp8wvBrViP016fy5JntURHneYT5ddhKAbTMXkqSRJGTMIg6DYw4IT7nI25DiX/bBo6DTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2501
X-Proofpoint-ORIG-GUID: z1Jq2gEPVYP5XyltA0c5_Pt52ZtcuW4w
X-Proofpoint-GUID: z1Jq2gEPVYP5XyltA0c5_Pt52ZtcuW4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150082

Hello Greg,=0A=
=0A=
beware that I messed up for the 1st versions of this backport, and then I s=
ent v2 patches that are working correctly.=0A=
You need to be careful to use only the v2 patch if there is one.=0A=
=0A=
I'm really sorry about that.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Greg KH <gregkh@linuxfoundation.org>=0A=
Sent:=A0Wednesday, January 15, 2025 11:32=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0stable@vger.kernel.org <stable@vger.kernel.org>; Jean-Baptiste Maneyr=
ol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan Cameron <Jonathan.Cameron@hua=
wei.com>=0A=
Subject:=A0Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write no=
t supported=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Mon, Jan 13, 2025 at 12:46:38PM +0000, inv.git-commit@tdk.com wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Burst write with SPI is not working for all icm42600 chips. It was=0A=
> only used for setting user offsets with regmap_bulk_write.=0A=
> =0A=
> Add specific SPI regmap config for using only single write with SPI.=0A=
> =0A=
> Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm4=
2600 driver")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> Link: https://urldefense.com/v3/__https://patch.msgid.link/20241112-inv-i=
cm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com__;!!Ftr=
htPsWDhZ6tw!BHuM_mFkFLufuYUdfRKsfVtoNwcGIdpfwb67zA7zHn0aaejUaf1E059wV6BjFCM=
4sykCxOWPj1PnNMwDW2WyQuXjY8KnYJ8a$[patch[.]msgid[.]link]=0A=
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
> (cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)=0A=
> ---=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 15 +++++++++++++++=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-=0A=
>  3 files changed, 18 insertions(+), 1 deletion(-)=0A=
=0A=
Did you test build this?=0A=

