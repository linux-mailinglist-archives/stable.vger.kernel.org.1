Return-Path: <stable+bounces-219600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPR0K6fvnmk/XwQAu9opvQ
	(envelope-from <stable+bounces-219600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:48:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5981A197956
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04D23040479
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3F395260;
	Wed, 25 Feb 2026 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aCKNiz/p"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A60225390;
	Wed, 25 Feb 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023647; cv=fail; b=M46U+DvxDuU42MmqTkGVrqcRXsMR7VrmABuqB6j2N5IIVwc30El0N/R4SalKvEuImkKbSK8VmscSW0/hXCGJMA3daN2w82k6g9Re6dH3OtKApryJ30Xq+mE8PU81NMqMLPEwy1p0VZiojKelSwlvpMDvlr6USG2iwXSfICOFO4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023647; c=relaxed/simple;
	bh=Ub9UN7a3q0kd5B8dgKKtoakIo7mvZX2Z3fxuWLOZlyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPTZvbEDuYQgMveTWnV8CPnygEDVPIWsmQ7ojIE8JO9i0V5OoIzTgGLl0LbV6jyDx+Dlji1W1/je5J9Ln5MB4nO4hZxArrrusLVfY8yakDwJ3h5hsVQsk6UBslK2HLjCl7BTD3WAENxoxEQ12zNRoYgJw7ha3OKf/N2qETJLiV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aCKNiz/p; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P6lK9U3631151;
	Wed, 25 Feb 2026 04:47:06 -0800
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022119.outbound.protection.outlook.com [40.93.195.119])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chf1mtm6y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 04:47:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdVbJB4ZJFN25uo0aKn1aNEfVN8EgBOlsY31L5BWwbSmmXOLHah/XlfF7t7mIxZfOec8Mj6L2CSbv+D0PnAQZuZ1acKBSqdoNuax/guQKO12Nm5agGzcDs7RQL5k11r4XpKJnZaI7hdvi/r/Qc2qGhOVxZ3ctM/LzxTlwOQ1/d98iKlljWtYxGhATWXD1//h+5xieTmau4RTMQ/g/8aPlIu8qokbQoF0cLRezgLC04m+gkp1u1AMYqe6i4XfGwcWplgv06skcZwWPfYKy/cNOTWfL+BYQeWsZsVeumgbNUXEIqqnwK0aNRHbMbopHmSbBEVnHlefCf0RwNZAi18c1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub9UN7a3q0kd5B8dgKKtoakIo7mvZX2Z3fxuWLOZlyk=;
 b=K1L8HDXQkLOFLVO6RM8PTY49vIqALmq5DUrNBIPVsr6M3ivaIbvOEUZRuDtZXL4GEsuxnR7spEHqMMsBGTkuyol2X/9CTMWPrqGc6dJwewGhLIA+I/UwDOszwZkRc6l1iIR4vIE5JJK+6+ndp4/TDGMILKVUpMbwolxUr96Emi8nAfhVkkFXMXeylEBJdvPur+zhJUVwSkwcR04Gip4DtaoZgLfJCD3ZA4yuo/jW53VKBf12Fk3xisRGQXtAzOVPT73z37JQrwJxltEewRsf/zcqzPy+1adz/6b0QCdcTJtpxE9FO1DY8Xzt2Y4W2CB/HJEcDbh2a3F/j61Q1s49+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub9UN7a3q0kd5B8dgKKtoakIo7mvZX2Z3fxuWLOZlyk=;
 b=aCKNiz/pUXZrr5tFdz8AykAYVqZz0vgtPrOqWBD0y6Dj/0+PCRvRS3QPx3N6QXY3wr/IJfiD0DNLnM82uDvEM7KjYknu0+9gvR8jRJ0n1tSx8NbubjBjxdiAJzhFJ7QsPRGZq8VmATFgkoP9cD1IzHEVrB0qdtWVvhgmOIetsiQ=
Received: from BY1PR18MB6374.namprd18.prod.outlook.com (2603:10b6:a03:5aa::19)
 by SA0PR18MB3693.namprd18.prod.outlook.com (2603:10b6:806:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 12:47:03 +0000
Received: from BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374]) by BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 12:47:02 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index:
 AQHcpVsOKxOBWB2/y0CrIf5i5ji46rWTMV0AgAAk+ICAAAJzgIAAAelwgAABfwCAAAGJIA==
Date: Wed, 25 Feb 2026 12:47:02 +0000
Message-ID:
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225073537-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6374:EE_|SA0PR18MB3693:EE_
x-ms-office365-filtering-correlation-id: 51549941-8130-44a3-ab00-08de746bf970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 U8FbFPSqS0DT7UhyNO63DbEKMWSxXnaA887DvNBgfITVlthhaUF42Zfj3QAGmbocYa+bidLNkGVnNQGSxrXg0o3970nNV96isQQTzts77r32UQxHu8AvKD2SFI5SGjHN3e5lAcJhx+WRiWsRtTlOhUz6DmvZNXjAuKMW/+kLOBTyf43Xgh2BJyOp3R1PaVqKyyuclVT76A5tF9HngRzlceXOc3WHIVgmedRShxKJa8JcCTv3aByVXIZVXJvAY/DiHgrCO1dpSxsdXcsGozjCJQSN5DFVvHIn4f3tMQdHXORrUfHaI5dFlWW0N5K4kH0x00aU7H/mJRRaCya+IX7c/fIGC745xTsBnrpFt5wGlFHgvxJ2GdYtTS9ln9KNHswY8q4U1+v//5i2PfwsGzbjyTcKgnLodqAwNe+KOyLFlIyl99Hl7XZJLWGS/5omont1kheHP/QfvOzZE4MuN50AwLNBzEbuvd2Ix1hgUtvNkgodwRKTkSvLQ9NibITAjKY2dWpmgfG+aG0XSKagKJReX57vFvzhB1BuknfmnZJ0ANE3OEvFsbHSsPaOExZ7AoNhtAVoKkeO6IuuwcB4NFX8ikNGWXfchzTgN5+A/fvBfzUuVx91Kc5RrBn182viHqy30uvz7LSU1RuVczK0ej3IV2kSjkitlruoPaR3komqSFNZxX7eSICf4YKGPXntzaiOuOnN9t9RnjwSQbLNf7OPDVVJRYRmibnEOtuAhFgjA+8+M/Py8oLNAIX1lGsf+Te8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR18MB6374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTdVeFFuaFhaS3JZSXdJZjhncTNsMnBIK3NsTTVOOTRoZDd3QlBEbUtzc0Fo?=
 =?utf-8?B?QXBRNk55aTQyMHMycWNIWGlRZjJYQkFUUWM4L2Zza01KUTJlVlUvYS9jLzVm?=
 =?utf-8?B?QklrNCs4bFlTY0VUaE5LU0hUVnVQa1pVRWRrY2JBM3M3VTlkSVBkdy9TczF5?=
 =?utf-8?B?dkJ6ZHh4VWZnNFlOV2lvL294aStXeWRqQ2lHV2RtWm5jT3QxZkZwZjFUMHJZ?=
 =?utf-8?B?UkMxL1pyLzhLVFEvQ1lqMG1NMFl0VkJpL1BnWkZFTFNBSy9LbG56czlIbWRJ?=
 =?utf-8?B?U01mZUdLK1JwOHlvR0MvMlllNFI0SC96dUMyUjNoMVJoU1ZsdnRoYUZ1Um1E?=
 =?utf-8?B?a0t2UStSRG1PTS9TWFpqQkxKYktTcXB1TmtpVGpxNlJpVGl1VkcrSHR5Sktr?=
 =?utf-8?B?REdPSGJtZnlyWWJHTmY1UzA1cFh2QW02SVRyQUJvRzBJTUhDWjRiYmszTWRC?=
 =?utf-8?B?bWdFM3JBRjNRZ1BpUUhKWHZybVhtN00vUnZNdURlQytxcUkrNmRZbFBjNyt0?=
 =?utf-8?B?UjF0NktVK1hlaXpKNnVRbytyYzAyVnV2dWc3K1VnUlprUGlaRUNkMlBDalVx?=
 =?utf-8?B?Y1B0N0lieElVb1dVdC9xcXlkbXBFd0Fzdzk1YnBDRWFQK1l2K1VHRVN4NWY2?=
 =?utf-8?B?Qkl5RGxXQTg1WW5IcC9DdzdNdVp3STc5OGVpOE1OOW1mRHlFRGQ5Rk04Rnpy?=
 =?utf-8?B?Y081ZUZjZUpoc1BTbGt0Zmo1R2xOTkE0Q0NuZkJVdUdaQ25WNE5tVDJjcUln?=
 =?utf-8?B?MitZaGw4cXY4UThjVjZYTEt0aTNoSHZTUXhNN05uTFF5a1owMUVjeFNVUHZT?=
 =?utf-8?B?bEsyT3o4dTl0SngrMGlZaUxXQlEzeGxKeFFrMUhyYTVKdkR3MTRSdSt1Wmts?=
 =?utf-8?B?NVVES1R2YjA3N3hRNXFaVGpkL1dESHhMOHhKd2U5YXpRRDlNM3IwYVEzWTlm?=
 =?utf-8?B?M0d1eEdyV0wwZC8reEtZY2NnaGhvU00yemcxUCtlUDhkMStYR28raFpaaEwr?=
 =?utf-8?B?T2ZZRG5YeGdpNDdZM0pZT1B4czYzbUdMSmtRSWVjZVh0WDhUZnZpTURSTSta?=
 =?utf-8?B?aEpuV1UvS3pMOWUxRW8yTWFwS3AwV3VSWGxmMkoySWZWdTQxbVRrOGgvbjZR?=
 =?utf-8?B?aVh3Z1V1VkFTUVVYVnBheUFFR3JBajNucys4TzNWbXlVc3o2YXdEM0hLc2dD?=
 =?utf-8?B?dXlrSDIrM3E3UTgrcWNjenN2bXVLYy9SckdQRWUrL1UvR3M3dXhLb3M4enM4?=
 =?utf-8?B?ejN5RzJIZ0ZTVC9LT1JWVUl4TzZBMGVmZUhzbWluT3FHbWcvVXJtVFd5RGlC?=
 =?utf-8?B?cHBtQVpqblFBcGlqWU1JU2VJM3dwSUZhM25qQ01vSE1OZU9PWFJQallxelI2?=
 =?utf-8?B?VXdTeXdIWGVJMkVuZDJRdUJIQlNxMDlPWHNhTGh0S3FIMUlZYzI4clhBZE1V?=
 =?utf-8?B?bUdpQnpUQmRuWm5wZzV3bjlVVjRvS0JCQVhta3BINzhhMlBHQmMvRGNrWFlu?=
 =?utf-8?B?Sk1xb2VGaSsvTERUSkExcWlLaHZkcmpQanFjL1NKOWVMejE2MGh4ZTNzYXJt?=
 =?utf-8?B?L25uTWNNelZFS1R6V3F4ZmduakNqSjBqa0kxSERlWFdMby9sQ3BrbVg1aHF1?=
 =?utf-8?B?U0tyNlhoTlN2a2dvdHA0SEwyZ1ltWVBWVC9BT0x4c0kzaVhOL0ppWTFDN0t1?=
 =?utf-8?B?UHJVbnZZSXN0WUxHc3JzVHpkV1hvdFFIUXd2R0FISHlPbDg0QUN0S2tGS203?=
 =?utf-8?B?ZWdBQjBmZlc0c3ZWcEdmYUcrL25wR1ZHTENnRGUxU3N3bExiWFR6ZTl2TVBU?=
 =?utf-8?B?VWdScjRWL1RQYU9RRFNLeUtDOVJvdUhiU0JsNElKc0k3Yllqd2RaTFJvUVVu?=
 =?utf-8?B?dlNsd0V4Q0lEb0Y4eHBRekNtaEJiUlFuK3RqdmNsUVRWQ05rSDgweGpPK3Nz?=
 =?utf-8?B?b0ZRaG13ZlprOElYSDRwakE2VllJYzdLSUg4NXZxcHYvdkRPT3E4R2Iwdzds?=
 =?utf-8?B?Z2lxaWtEdG5PVnhFRCsrYytnb0dzNU4yQWdmdmI0cmdRblV5ekN3b1NsRkVY?=
 =?utf-8?B?RCtqUGtqS2QzSVFRYXBQQndMcnVHLzAyRjRpSjc5N3h2VU5pdHFKalJ6NDBk?=
 =?utf-8?B?S0ZSdGhWY3BpWmF2MWhsN21WSER0b3lVaXM2RWZ6WVhQa0RUb3RsRDRRclZU?=
 =?utf-8?B?eEM1V1BwMm1Bc003ak5HbnkzazYrOHA4VmFlalI0bVdNZFI4NUpVWlJnVlh3?=
 =?utf-8?B?cUlkeWlhL3g3RGoyRmxNVkhOdXJGcFAvMDJqdUVUY1RJU2RvT0ZhejNnQnZn?=
 =?utf-8?Q?aOEj6Ogp4U0qA4+0an?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51549941-8130-44a3-ab00-08de746bf970
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 12:47:02.8238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uk6dPc+8NvSwZ0A9K97ltX2y2NBWqA3AZ82+ZXU6Q0M/dK3tMqTJAY+R3pnXgnUmRkBLLzEXAEWpudoIZnz10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3693
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX1EhodeY8wSr1
 2Lota2SmujVYUzAHIoEvFwH31hMmwuRPL9t7jm2/SaLxV9zDxhhvNZtyNohOTkSWTy+KVEoUrzO
 SAtCXbsGN7I46bvA0RvjgBfEW0io6f3GJxf1AlYh+oGO9ODPfUN4lgev4BDuALCzdIQerjz1Fql
 P03gWtm2/kHkYcTjvUAFvg+bC2+XmZeX7OKXNCYlspHbGMDIw6m/tFoHJHkDArxETepyIiSKjcV
 krQaY4FVLylp7HoLjsn86ECG6LxgLPvVRh+USXXsHLxKqTmZuNOgn6YTRY057+i5FDq+FKg26Xd
 Vm9qffVEPdykn9eOCU58FLqKDKR3Eb5tUwuSKZKW4bOtCa6gdAmyKT7gt98kv/33+57yMvt00zx
 1rcG/axj28LoOKeCzXBNxbbIctc7EH2T6bNzX1SlT77mo3oNmGJNMuKvA6oHSdLdGUXdL8LEZXk
 WGiC+ChdzTLylXW0+Vg==
X-Authority-Analysis: v=2.4 cv=a+c9NESF c=1 sm=1 tr=0 ts=699eef4a cx=c_pps
 a=c7K7qtXczKOKsP5Tyt1v3A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=20KFwNOVAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=RpNjiQI2AAAA:8 a=pTLvAiT6JwhTXrhI4RYA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: uAFgiUoRRvLuS3J5nJxFv37RPPH9AXSJ
X-Proofpoint-ORIG-GUID: uAFgiUoRRvLuS3J5nJxFv37RPPH9AXSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219600-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,BY1PR18MB6374.namprd18.prod.outlook.com:mid,marvell.com:email,marvell.com:dkim,proofpoint.com:url,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5981A197956
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNSwgMjAy
NiA2OjA3IFBNDQo+IFRvOiBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4g
Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRl
djsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207IHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tOw0KPiBlcGVyZXptYUByZWRoYXQuY29tOyBkYXZlbUBkYXZlbWxvZnQu
bmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7IE5pdGhpbiBLdW1h
ciBEYWJpbHB1cmFtIDxuZGFiaWxwdXJhbUBtYXJ2ZWxsLmNvbT47DQo+IFNoaXZhIFNoYW5rYXIg
S29tbXVsYSA8a3NoYW5rYXJAbWFydmVsbC5jb20+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0LHY0LDEvMl0gdmlydGlvX25l
dDogSW1wcm92ZSBSU1Mga2V5DQo+IHNpemUgdmFsaWRhdGlvbiBhbmQgdXNlIE5FVERFVl9SU1Nf
S0VZX0xFTg0KPiANCj4gT24gV2VkLCBGZWIgMjUsIDIwMjYgYXQgMTI64oCKMzQ64oCKMjhQTSAr
MDAwMCwgU3J1amFuYSBDaGFsbGEgd3JvdGU6ID4gPiA+ID4NCj4gT24gVHVlLCBGZWIgMjQsIDIw
MjYgYXQgMTI64oCKMjg64oCKNDlQTSArMDUzMCwgU3J1amFuYSBDaGFsbGEgd3JvdGU6ID4gPiA+
ID4gPg0KPiBSZXBsYWNlIGhhcmRjb2RlZCBSU1MgbWF4IGtleSBzaXplIGxpbWl0IHdpdGggTkVU
REVWX1JTU19LRVlfTEVOID4NCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0IFByaW9yaXRpemUg
c2VjdXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczoNCj4gQ29uZmlybSBzZW5kZXIgYW5kIGNvbnRl
bnQgc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nDQo+IGF0dGFjaG1lbnRz
IDxodHRwczovL3VzLXBoaXNoYWxhcm0tDQo+IGV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JW
bVhrcVchdGMzWjFmOFVZbldhdEstDQo+IDhXYjM2RHByOUZKWFpNQndFdWdIajF4Q0d3UmwtDQo+
IGROWE1fSThZazdoYmJqd0NIZTlXaGdRd21HeDJNczg1ZklrU21LTTJkQlFlSDlEa3phayQ+DQo+
IFJlcG9ydCBTdXNwaWNpb3VzDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+IE9uIFdl
ZCwgRmViIDI1LCAyMDI2IGF0IDEyOjM0OjI4UE0gKzAwMDAsIFNydWphbmEgQ2hhbGxhIHdyb3Rl
Og0KPiA+ID4gPiA+IE9uIFR1ZSwgRmViIDI0LCAyMDI2IGF0IDEyOjI4OjQ5UE0gKzA1MzAsIFNy
dWphbmEgQ2hhbGxhIHdyb3RlOg0KPiA+ID4gPiA+ID4gUmVwbGFjZSBoYXJkY29kZWQgUlNTIG1h
eCBrZXkgc2l6ZSBsaW1pdCB3aXRoDQo+ID4gPiA+ID4gPiBORVRERVZfUlNTX0tFWV9MRU4gdG8g
YWxpZ24gd2l0aCBrZXJuZWwncyBzdGFuZGFyZCBSU1Mga2V5DQo+ID4gPiA+ID4gPiBsZW5ndGgu
IEFkZCB2YWxpZGF0aW9uIGZvciBSU1Mga2V5IHNpemUgYWdhaW5zdCBzcGVjIG1pbmltdW0gKDQw
DQo+IGJ5dGVzKSBhbmQgZHJpdmVyIG1heGltdW0uDQo+ID4gPiA+ID4gPiBXaGVuIHZhbGlkYXRp
b24gZmFpbHMsIGdyYWNlZnVsbHkgZGlzYWJsZSBSU1MgZmVhdHVyZXMgYW5kDQo+ID4gPiA+ID4g
PiBjb250aW51ZSBpbml0aWFsaXphdGlvbiByYXRoZXIgdGhhbiBmYWlsaW5nIGNvbXBsZXRlbHku
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
PiA+ID4gPiA+IEZpeGVzOiAzZjdkOWMxOTY0ZmMgKCJ2aXJ0aW9fbmV0OiBBZGQgaGFzaF9rZXlf
bGVuZ3RoIGNoZWNrIikNCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNydWphbmEgQ2hhbGxh
IDxzY2hhbGxhQG1hcnZlbGwuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLS0tIHNob3VsZCBj
b21lIGhlcmUgYmVmb3JlIGNoYW5nZWxvZy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gdjM6DQo+
ID4gPiA+ID4gPiAtIE1vdmVkIFJTUyBrZXkgdmFsaWRhdGlvbiBjaGVja3MgdG8gdmlydG5ldF92
YWxpZGF0ZS4NCj4gPiA+ID4gPiA+IC0gQWRkIGZpeGVzOiB0YWcgYW5kIENDIC1zdGFibGUNCj4g
PiA+ID4gPiA+IHY0Og0KPiA+ID4gPiA+ID4gLSBVc2UgTkVUREVWX1JTU19LRVlfTEVOIGluc3Rl
YWQgb2YgdHlwZV9tYXggZm9yIHRoZSBtYXhpbXVtDQo+ID4gPiA+ID4gPiByc3Mga2V5DQo+ID4g
PiA+ID4gc2l6ZS4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDM0DQo+ID4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEw
IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jIGluZGV4DQo+ID4gPiA+ID4gPiBkYjg4ZGNhZWZiMjAuLmVlZWZlOGFiYzEyMiAxMDA2NDQN
Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0KPiA+ID4gPiA+ID4g
KysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gPiA+ID4gPiBAQCAtMzgxLDggKzM4
MSw2IEBAIHN0cnVjdCByZWNlaXZlX3F1ZXVlIHsNCj4gPiA+ID4gPiA+ICAJc3RydWN0IHhkcF9i
dWZmICoqeHNrX2J1ZmZzOyAgfTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtI2RlZmluZSBW
SVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkUgICAgIDQwDQo+ID4gPiA+ID4gPiAtDQo+ID4gPiA+
ID4gPiAgLyogQ29udHJvbCBWUSBidWZmZXJzOiBwcm90ZWN0ZWQgYnkgdGhlIHJ0bmwgbG9jayAq
LyAgc3RydWN0DQo+ID4gPiA+ID4gPiBjb250cm9sX2J1ZiB7DQo+ID4gPiA+ID4gPiAgCXN0cnVj
dCB2aXJ0aW9fbmV0X2N0cmxfaGRyIGhkcjsgQEAgLTQ4Niw3ICs0ODQsNyBAQCBzdHJ1Y3QNCj4g
PiA+ID4gPiA+IHZpcnRuZXRfaW5mbyB7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIAkvKiBN
dXN0IGJlIGxhc3QgYXMgaXQgZW5kcyBpbiBhIGZsZXhpYmxlLWFycmF5IG1lbWJlci4gKi8NCj4g
PiA+ID4gPiA+ICAJVFJBSUxJTkdfT1ZFUkxBUChzdHJ1Y3QgdmlydGlvX25ldF9yc3NfY29uZmln
X3RyYWlsZXIsDQo+ID4gPiA+ID4gPiByc3NfdHJhaWxlciwNCj4gPiA+ID4gPiBoYXNoX2tleV9k
YXRhLA0KPiA+ID4gPiA+ID4gLQkJdTgNCj4gcnNzX2hhc2hfa2V5X2RhdGFbVklSVElPX05FVF9S
U1NfTUFYX0tFWV9TSVpFXTsNCj4gPiA+ID4gPiA+ICsJCXU4IHJzc19oYXNoX2tleV9kYXRhW05F
VERFVl9SU1NfS0VZX0xFTl07DQo+ID4gPiA+ID4gPiAgCSk7DQo+ID4gPiA+ID4gPiAgfTsNCj4g
PiA+ID4gPiA+ICBzdGF0aWNfYXNzZXJ0KG9mZnNldG9mKHN0cnVjdCB2aXJ0bmV0X2luZm8sDQo+
ID4gPiA+ID4gPiByc3NfdHJhaWxlci5oYXNoX2tleV9kYXRhKSA9PSBAQCAtNjYyNyw2ICs2NjI1
LDI5IEBAIHN0YXRpYw0KPiA+ID4gPiA+ID4gaW50DQo+ID4gPiA+ID4gdmlydG5ldF92YWxpZGF0
ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4gPiA+ID4gPiA+ICAJCV9fdmlydGlvX2Ns
ZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfU1RBTkRCWSk7DQo+ID4gPiA+ID4gPiAgCX0NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX05FVF9GX1JTUykgfHwNCj4gPiA+ID4gPiA+ICsJICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2
ZGV2LCBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQpKSB7DQo+ID4gPiA+ID4gPiArCQl1OCBrZXlf
c3ogPSB2aXJ0aW9fY3JlYWQ4KHZkZXYsDQo+ID4gPiA+ID4gPiArCQkJCQkgIG9mZnNldG9mKHN0
cnVjdA0KPiB2aXJ0aW9fbmV0X2NvbmZpZywNCj4gPiA+ID4gPiA+ICsJCQkJCQkgICByc3NfbWF4
X2tleV9zaXplKSk7DQo+ID4gPiA+ID4gPiArCQkvKiBTcGVjIHJlcXVpcmVzIGF0IGxlYXN0IDQw
IGJ5dGVzICovICNkZWZpbmUNCj4gPiA+ID4gPiA+ICtWSVJUSU9fTkVUX1JTU19NSU5fS0VZX1NJ
WkUgNDANCj4gPiA+ID4gPiA+ICsJCWlmIChrZXlfc3ogPCBWSVJUSU9fTkVUX1JTU19NSU5fS0VZ
X1NJWkUpIHsNCj4gPiA+ID4gPiA+ICsJCQlkZXZfd2FybigmdmRldi0+ZGV2LA0KPiA+ID4gPiA+
ID4gKwkJCQkgInJzc19tYXhfa2V5X3NpemU9JXUgaXMgbGVzcyB0aGFuDQo+IHNwZWMNCj4gPiA+
ID4gPiBtaW5pbXVtICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+ID4gPiA+ID4gKwkJCQkga2V5
X3N6LA0KPiBWSVJUSU9fTkVUX1JTU19NSU5fS0VZX1NJWkUpOw0KPiA+ID4gPiA+ID4gKwkJCV9f
dmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfUlNTKTsNCj4gPiA+ID4gPiA+ICsJ
CQlfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwNCj4gPiA+ID4gPiBWSVJUSU9fTkVUX0ZfSEFTSF9S
RVBPUlQpOw0KPiA+ID4gPiA+ID4gKwkJfQ0KPiA+ID4gPiA+ID4gKwkJaWYgKGtleV9zeiA+IE5F
VERFVl9SU1NfS0VZX0xFTikgew0KPiA+ID4gPiA+ID4gKwkJCWRldl93YXJuKCZ2ZGV2LT5kZXYs
DQo+ID4gPiA+ID4gPiArCQkJCSAicnNzX21heF9rZXlfc2l6ZT0ldSBleGNlZWRzIGRyaXZlcg0K
PiBsaW1pdA0KPiA+ID4gPiA+ICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+ID4gPiA+ID4gKwkJ
CQkga2V5X3N6LCBORVRERVZfUlNTX0tFWV9MRU4pOw0KPiA+ID4gPiA+ID4gKwkJCV9fdmlydGlv
X2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfUlNTKTsNCj4gPiA+ID4gPiA+ICsJCQlfX3Zp
cnRpb19jbGVhcl9iaXQodmRldiwNCj4gPiA+ID4gPiBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQp
Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4geW91IGZsaXBwZWQgdGhlIGxvZ2ljIGhlcmUgYW5kIGl0
IG1ha2VzIG5vIHNlbnNlIG5vdy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERpZCB5b3UgdGVzdCB0
aGlzIHBhdGg/DQo+ID4gPiA+IFllcywgdGVzdGVkIHdpdGggTWFydmVsbCdzIE9jdGVvbiBkZXZp
Y2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIGlmIGRldmljZSBpcyBwb3dl
cmZ1bCBhbmQgc3VwcG9ydHMgYSB2ZXJ5IGJpZyBrZXkgc2l6ZSB0aGVuLi4uDQo+ID4gPiA+ID4g
d2UgZGlzYWJsZSB0aGUgZmVhdHVyZT8gaG93IGRvZXMgdGhpcyBtYWtlIHNlbnNlPw0KPiA+ID4g
PiBUaGUgaW50ZW50IGlzbuKAmXQgdG8gZGlzYWJsZSB0aGUgZmVhdHVyZSBvbiBjYXBhYmxlIGRl
dmljZXMsIGJ1dCB0bw0KPiA+ID4gPiBlbnN1cmUgdGhlIGRyaXZlciBuZXZlciBhZHZlcnRpc2Vz
IHN1cHBvcnQgZm9yIFJTUyBrZXkgc2l6ZXMNCj4gPiA+ID4gbGFyZ2VyIHRoYW4gd2hhdCB0aGUg
bmV0IGRldmljZSBjYW4gYWN0dWFsbHkgaGFuZGxlLiBFdmVuIGlmIGENCj4gPiA+ID4gZGV2aWNl
IHJlcG9ydHMgYSB2ZXJ5DQo+ID4gPiBsYXJnZSBrZXkgc2l6ZSwgdGhlIGRyaXZlciBpcyBjb25z
dHJhaW5lZCBieSBORVRERVZfUlNTX0tFWV9MRU4sDQo+ID4gPiBzaW5jZQ0KPiA+ID4gbmV0ZGV2
X3Jzc19rZXlfZmlsbCgpIGVuZm9yY2VzOg0KPiA+ID4gPiBCVUdfT04obGVuID4gc2l6ZW9mKG5l
dGRldl9yc3Nfa2V5KSk7DQo+ID4gPg0KPiA+ID4gc28gY2FwIGl0IHRvIE5FVERFVl9SU1NfS0VZ
X0xFTi4gV2h5IGlzIHRoYXQgYSByZWFzb24gdG8gY2xlYXIgdGhlDQo+IGZlYXR1cmU/DQo+ID4g
T3VyIGRldmljZSBtYW5kYXRlcyB0aGF0IGhhc2hfa2V5X2xlbmd0aCBtdXN0IGJlIGlkZW50aWNh
bCB0bw0KPiA+IHJzc19tYXhfa2V5X3NpemUgdG8gZ3VhcmFudGVlIHN5bW1ldHJpYyBiaWRpcmVj
dGlvbmFsIGZsb3cgaGFzaGluZy4gSWYNCj4gPiByc3NfbWF4X2tleV9zaXplIGlzIGxhcmdlciB0
aGFuIFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSwgY2xhbXBpbmcNCj4gdGhlIHZhbHVlIGlz
IG5vdCBmZWFzaWJsZS4NCj4gDQo+IEkgZG9uJ3Qga25vdyB3aGF0IHRvIHRlbGwgeW91LiByc3Nf
bWF4X2tleV9zaXplIGlzIGp1c3QgdGhlIG1heCBkZXZpY2UNCj4gc3VwcG9ydHMuIGRyaXZlciBz
aG91bGQgYmUgZnJlZSB0byB1c2UgYSBzbWFsbGVyIHNpemUuDQpNeSB1bmRlcnN0YW5kaW5nIGlz
IHRoYXQgdGhpcyBwYXRjaCBwcmV2ZW50cyB0aGUgcHJvYmUgZnJvbSBmYWlsaW5nIGJ5IGRpc2Fi
bGluZyB0aGUgZmVhdHVyZSBpbnN0ZWFkLg0KR2l2ZW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24sIHRoZSBkcml2ZXIgYmVjb21lcyB1bnVzYWJsZSB3aGVuIHRoaXMgY29uZGl0aW9uIGlzIGhp
dC4NCj4gDQo+IA0KPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArCQl9
DQo+ID4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAJcmV0dXJuIDA7
DQo+ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEBAIC02ODM5LDEzICs2
ODYwLDYgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdA0KPiA+ID4gPiA+ID4gdmly
dGlvX2RldmljZQ0KPiA+ID4gPiA+ICp2ZGV2KQ0KPiA+ID4gPiA+ID4gIAlpZiAodmktPmhhc19y
c3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpIHsNCj4gPiA+ID4gPiA+ICAJCXZpLT5yc3Nf
a2V5X3NpemUgPQ0KPiA+ID4gPiA+ID4gIAkJCXZpcnRpb19jcmVhZDgodmRldiwgb2Zmc2V0b2Yo
c3RydWN0DQo+IHZpcnRpb19uZXRfY29uZmlnLA0KPiA+ID4gPiA+IHJzc19tYXhfa2V5X3NpemUp
KTsNCj4gPiA+ID4gPiA+IC0JCWlmICh2aS0+cnNzX2tleV9zaXplID4NCj4gVklSVElPX05FVF9S
U1NfTUFYX0tFWV9TSVpFKSB7DQo+ID4gPiA+ID4gPiAtCQkJZGV2X2VycigmdmRldi0+ZGV2LCAi
cnNzX21heF9rZXlfc2l6ZT0ldQ0KPiBleGNlZWRzDQo+ID4gPiA+ID4gdGhlIGxpbWl0ICV1Llxu
IiwNCj4gPiA+ID4gPiA+IC0JCQkJdmktPnJzc19rZXlfc2l6ZSwNCj4gPiA+ID4gPiBWSVJUSU9f
TkVUX1JTU19NQVhfS0VZX1NJWkUpOw0KPiA+ID4gPiA+ID4gLQkJCWVyciA9IC1FSU5WQUw7DQo+
ID4gPiA+ID4gPiAtCQkJZ290byBmcmVlOw0KPiA+ID4gPiA+ID4gLQkJfQ0KPiA+ID4gPiA+ID4g
LQ0KPiA+ID4gPiA+ID4gIAkJdmktPnJzc19oYXNoX3R5cGVzX3N1cHBvcnRlZCA9DQo+ID4gPiA+
ID4gPiAgCQkgICAgdmlydGlvX2NyZWFkMzIodmRldiwgb2Zmc2V0b2Yoc3RydWN0DQo+IHZpcnRp
b19uZXRfY29uZmlnLA0KPiA+ID4gPiA+IHN1cHBvcnRlZF9oYXNoX3R5cGVzKSk7DQo+ID4gPiA+
ID4gPiAgCQl2aS0+cnNzX2hhc2hfdHlwZXNfc3VwcG9ydGVkICY9DQo+ID4gPiA+ID4gPiAtLQ0K
PiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+DQo+ID4NCg0K

