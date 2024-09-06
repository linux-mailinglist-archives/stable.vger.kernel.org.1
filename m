Return-Path: <stable+bounces-73702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFC96EAF6
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB11C228F3
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 06:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EB13D537;
	Fri,  6 Sep 2024 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VvuTpJIm";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BbadjgjV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CEF3EA71;
	Fri,  6 Sep 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605342; cv=fail; b=fSuD9XkuRR6uK/AjsZKaeQVHbfZsYaqOgV/E4LuEmITEe7tPRUxygiWJgpNdlpo98t5EA8/YGI9igScmCKuq/YQfHx5bP60nnVB3EUT2aDpN4zCuBnzyo67H7+Xpn6mMowS6nxlwaoAyXcJhx0khBT3PuD7LdiAl1O3ae9nvvuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605342; c=relaxed/simple;
	bh=PDQK5aTRBdKtKAAcuJeTJr3vAI6/uOmtmMl062CqMJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKykPFlFdKug4LfxY79KM0AIAOfymMtjjjZDokxI/IaeZoETRVfSIKC5AIvsnVYbwfLSX+eALDemok+50d02uVA5nA4h2QBypHh2nKLpPpKuSiIuQ4s3EPh795hkHcfNceBYXJQyOEi2h3wIDF7zXferwPsEdgq+be+EXcSK/HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=VvuTpJIm; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=BbadjgjV; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4865viKb026067;
	Thu, 5 Sep 2024 23:48:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=xUSEcN1vQ32dgKEKzSAw+Zx5KFGPYOf8FX75iUsvEe4=; b=VvuTpJImQ+8Q
	PhkKkUXkNErqk35PTHVG6Ur2G/WttxRdlgRwDi3CaYrvQflcp8sVAhaDalp+kSJi
	yahDof9/r61tM+84alyctKGAwaUdJymcXcArmu3bjcJrpgRoZlyodEixuJyV7eJe
	qngX6hIlgcKyzFdQdnwhtpvM02JuLaxtu36nTpgcOkrQycm4fFSvXS8MhVQqrY4O
	1imbfI+xeaPBkbbjv+mggdMa7C1Oz8lkyT71mPpx9UYlsY5HRP0F4I25HEkrWLYa
	0xA0wPFfE/1ERBI/MAb75r6YaMYxiLImrgZ7SFcEIor/yDoN/ApVQP9Rm8xiTbPV
	hESLMTps1g==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 41fhx5t38c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 23:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqEOYlEcgLbROhqHPvakgEfTM4yiJ/JaLnLRRsZAjAM2LiF7ANCHpL9+2tXCp09Tjq9vEWZW8zzL9dd3QoIVCTj8Fw4HKbdj9Yu5PVlmMM8BsGYujyJ3E2D3ECxNcxHBXLP7iGyiBVG9mCl/kpuz8ixvwXgquef2KdU2oELr3gR4ZTLATeMurq5lcjO4j2UVSNSCACPhBqSaAMoYNRjWOFGQIjzJiRXmFLNt3XP4gC28rElvACnLCUBFPWOqiNm2G5ShN82hsphuio+fyeeaYQzO5VUBxm60m9Wyc6/AmjKcyakJ4EbrAU3PBhwXJ8L6xOq0sWxA4/MTef6B5Hat4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUSEcN1vQ32dgKEKzSAw+Zx5KFGPYOf8FX75iUsvEe4=;
 b=Jnx1fAmVGoqmR2WH+j4TcGfjLCtHQGVdsejiN7+1xoyXPkEOB6mPVaG7h/e0i8jxRFpKmYE94YERtQGG5aKZkMX5O0B65GD/3J03Pk6KEUtLDkDne8/u6gUv667ZKfQgSthDq/qz0S4PTwivxk1u4zofctQijeqeiCDzgqJojUNnfdiz4z6k7ojY4W3hoeBDH9B25XTB3xXtJ2e7ThfYf5LYknNlYGPMcO/fcXiwH3UBSEnEz2fVWntjQNGMimVRS5ZRyxzQdSo3MOJpK5pP4RKoYIYLsCBVUMVCui2ZA8W7q7fUDiYkz6m4dThdgwQTi5OP5tbD6wMOq0UG8ywXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUSEcN1vQ32dgKEKzSAw+Zx5KFGPYOf8FX75iUsvEe4=;
 b=BbadjgjVLNyM8ZAMe91b4VOrDAbulWsOvDjHhc2f/s29ckGqMQ1RAc9+ggNtS39+zA8lwupMamJK+trN9LjV1Bq30oaxV9QkcDxHJdeqyNlvWgtG5Mtj7T+H6wCumrOaRDzcW/ZyQ3EQODMJaS0hCb0ZYZruWCGnhkXLOKMZQ1E=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CO1PR07MB9052.namprd07.prod.outlook.com (2603:10b6:303:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 06:48:55 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:48:54 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] usb: cdnsp: Fix incorrect usb_request status
Thread-Topic: [PATCH v2] usb: cdnsp: Fix incorrect usb_request status
Thread-Index: AQHbACh/YWJ76qtKVEGX/ynC8VwZfLJKUNRg
Date: Fri, 6 Sep 2024 06:48:54 +0000
Message-ID:
 <PH7PR07MB9538E8CA7A2096AAF6A3718FDD9E2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240906064547.265943-1-pawell@cadence.com>
In-Reply-To: <20240906064547.265943-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTEzODJlMTJhLTZjMWMtMTFlZi1hOGI1LTYwYTVlMjViOTZhM1xhbWUtdGVzdFwxMzgyZTEyYy02YzFjLTExZWYtYThiNS02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjQyNjYiIHQ9IjEzMzcwMDc4OTMyNDA4MzI5MyIgaD0idnBBVmJ2ZzBzSHFlMWUvZDBSZUVDVmlQMGkwPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CO1PR07MB9052:EE_
x-ms-office365-filtering-correlation-id: 99966141-cdcc-4ce4-f78e-08dcce3ff9b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?57Lr6hoKtb1IlFhTuSC5TQh6Xyo3ij7xqRbVyzAQ0PpDscJMbD1MT1uFjN84?=
 =?us-ascii?Q?33YabM07uTX0XCzCR/1x4gJUV7XWVHaJlhLPdlahg9E8Ez2o9VIc6AS/bLNo?=
 =?us-ascii?Q?vSXsj1xP0Q+YBvvRIBl69F65m/pB1l41qCqqX59TZX4xFPwigOBMyqENr3hP?=
 =?us-ascii?Q?FSqFJeQCH8QAdokCDGnzHh0EKOn5rVvmZei6JLBNLN1rqxdLuEt/Q6Z7pyVH?=
 =?us-ascii?Q?++8Tvb57AaUPsX7e499hWpU4FaqZgtYNCKleLtmaFex3ogkADsPo9lwGluG4?=
 =?us-ascii?Q?DgDapil6sG59h+VLx6r3YGoQ6v3ZQ5SAgKfIO9QoBHuS3vzW5AMJKMuiuR8t?=
 =?us-ascii?Q?D2GgS2wNiLfvvr/askWCECJ7aSLxCxwmS4s8TZ/ShlhyVKxlJ2ISUpfNngib?=
 =?us-ascii?Q?HeRlxIcMJq8XBK5Jv5veWYEho9SGMWjN8h2ZeYhNkYCP69lj2uDm9czEg1xU?=
 =?us-ascii?Q?p6NOkq1IcXTceihvJ45m11ZUlTZ95Csn1yg8R8inil89SOinwuSr92LIFIUL?=
 =?us-ascii?Q?D2U7VLGAh8sBr14TK/67HxY0gMJ4EKLXAzSVVDQOcmYcXHfSVGjpXygBEHds?=
 =?us-ascii?Q?QnQrGGWBd/CID7Oy0caL+pk86NLiV1eSfZku5WWa/PFkPoHgNAtn8z4vh4E1?=
 =?us-ascii?Q?ILdJYNWLz/q+30jCFIxLIZ+WMUZ2hcnaGDNGEAHr+qpK24J/iTk/TGV9Ie0v?=
 =?us-ascii?Q?kHit037//fho7OA9GWcFDy8i5I+webCPg5O7FcHaImj4F9gm1zT4jsiGlXT7?=
 =?us-ascii?Q?ng1T7vQozSek5m0omhyjJ93bkNtAHcpXAAhH1HxEBogG/AAiKBorCKjRrvgb?=
 =?us-ascii?Q?0PfqZt07Ywvu5DhA1B6UGmo5htz6w5KbPliywoD7s+NBZuatH2a6byU6SnfU?=
 =?us-ascii?Q?0NIWFtDRIILYMxkdHkzJi60GuOhA8g8oJhZzU3V+PMqi0/WjSwHT6hSb3koJ?=
 =?us-ascii?Q?NJG4uCzEMvpyGy57ed/Kd/nXDltKR5+aLP2FSh9gVnb5+CYkXpmgt5BTuC9R?=
 =?us-ascii?Q?E1u5yl3HVwy2SAFsT7L7i3shgiyuCjXev4A1Zqiph1g4QOSfrl0hDyJlsSZQ?=
 =?us-ascii?Q?o8qEHyW/lF5dT7Zo+JklFzPGwc8E78Zr24FpIIUrxuHV3wuUapNNOasavYwH?=
 =?us-ascii?Q?pgfzLZUx8CQWH9Np/e4ZsGyG72SazFxvE/fivbU2QHDo+/F+4ua4GqDuD9Uk?=
 =?us-ascii?Q?iOsft2X+sN3oFtPHNpNvKzrbI1kNiAwVPZ8T1+BXfs6zOk4Ia6Ya/Q9rdNh9?=
 =?us-ascii?Q?apt1wrv9TVePmrqLZ54uywsrAYPqiaDAyoj64Ecz57pBo3j5I7FpejWmn8bu?=
 =?us-ascii?Q?Vhkg+yW7Zu3yTJe2qGuT4mixRifvG3s9X5fHxkTTd6L/IO8rVZpDcenljN8v?=
 =?us-ascii?Q?z7MlYo6j+JBACCiauUiGpLDJEaCv1m2fb368QxAw4mxQxepIzQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x5GWpLOVX17HUFX8WMwmQEGJVQV1ykfLe0Q1hr2F9OHgwCgnf7qWmazIi0kw?=
 =?us-ascii?Q?7S2Yb6V/2TbZSSZaCS+lL/C0rUJCGbP6lz4lYffpnMI4pnaDq/nLTbXrL4NU?=
 =?us-ascii?Q?xBO0MYin1d/8gf9E00vai9Ip1N0FG3mGJVZhyi1UJYw/FuC4Z5nekOud4g3s?=
 =?us-ascii?Q?+Kg4N/vHjwALUxZlrJIOmw4IFeIsi8Y5JC6Edv/GJdM3we/L27ErxLWFd0bB?=
 =?us-ascii?Q?nSb9ktEf2RpQaiGMhWCR1W9lZa3BcudZF7dayeOdLvlDcHFFnlA5bRqEpa6X?=
 =?us-ascii?Q?OPeUV3n3ZX5b9JvknMOTd5BbD/CmoOkI2SnmbKGldxL+ecDsIu3sv9J5lq8l?=
 =?us-ascii?Q?9AYTUJYvFEFw2yTfCj61i/x1En709/9DDi9Md3O8Wm60PoITZYdW7h69nyKb?=
 =?us-ascii?Q?mQJx2IkX7pzGIfV5gW82vcUE0qGgwLgrDNUVwSuwmn2Pq3FhYLNvq+mKwzWy?=
 =?us-ascii?Q?7dmnoHI8ku9oGuF3F9uAj8kY9nIevlmr08jXQqsoA5FvQ0kulmzZelBJf8cR?=
 =?us-ascii?Q?80eDsS498PIAN/YjzG6SZ5v3FLS08uP5iYDgnKSPwUejcnq3sMHku7AoZscR?=
 =?us-ascii?Q?0Tc26Az/Q19orJUqrawF6+GdAzgtPmIl2lWthaqw5J535TqObx6dGCyMh9/B?=
 =?us-ascii?Q?c1HwjcpnPUDnNeX+bT5xHcOqpKGcjBIusQmRI3UUFlUxV0dkWPilgBl6lQXg?=
 =?us-ascii?Q?fNqXbw7tR4QBLCEREsFUwGsDOMQmc91S1drOz0H/0FqsN2Q4nvzerlTa2DQD?=
 =?us-ascii?Q?bk5HDB7aEKVleaItkPDYkohlCU0fFUU/2jsOy4ct/Jup2ctRlF/l3FK80uhU?=
 =?us-ascii?Q?bf4/aYyNz8FXJGwWx/9wCsEQKHNTwp2z2OaLnKxuRW/zuTC3t6etE8yswqYN?=
 =?us-ascii?Q?mxMv/fsCBENv1xfLRGshC22DyIjF8iksr8mz1lm2Gf7IJxkjPLYsSqosF5F7?=
 =?us-ascii?Q?9WcjpSDa0TFjAODWT+rrfL/uTshinz1Ow1v7Red7WjsTn+Zdlpbezz7Lm6/+?=
 =?us-ascii?Q?HMtN3IgSwH8vxeD9/ZvndLajaqq7+7vu/iKPxKyEMhpsckm4PpH68XoOYOs2?=
 =?us-ascii?Q?73wy2OvJvsqM4RchcOJTKqoS8jeyqfLfW8gD3tbQ+J+uVTrWAQ+kzdLc0jl6?=
 =?us-ascii?Q?BZciPFMFbdhMzMfxEOUWYc16OwX/pfR4/LvAAfAYL1nnyOg2sKwpg7/4QXnm?=
 =?us-ascii?Q?Ec0BKg5dCfeDhRapc5Gixo8yXkCV/PxBR1GMirZHwYaA/gPccf6sIGi+iKmZ?=
 =?us-ascii?Q?CgSrgQC09AlAwUbWw622tiEQiqceJAHJI/kH0wzOt4tZY3W4C5ZGq/nXTwj8?=
 =?us-ascii?Q?Tx17OT+OmzsaCKH4flB1xaFSY0FcOHNoFubOzovDpAj4YM9sApZFugeMpjNU?=
 =?us-ascii?Q?ecGUDMccK++bUv6RVBLApaQ2kP5UHGnmqoSp5u3UPbV8ZZgWGjnSJ5YkfneF?=
 =?us-ascii?Q?KvfdH5BLnwffr2K0nCcVtjA9UjWrzO4tz1af+oVAoaPlMrV5ym9usaBeEjTS?=
 =?us-ascii?Q?RJ1oJwP0bBOMwY/Ie80icA0XFXDZD6DTg+3mgBqlWz2a+xLfVeVHCEEOXAHv?=
 =?us-ascii?Q?JLSgi/D+Ikj2SZmjQeJqHJ5j5XH47TssgU9b8jds?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99966141-cdcc-4ce4-f78e-08dcce3ff9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 06:48:54.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luukdh4Odi2tEGOmmEPgH+u1g4WSf6PF/zJ+Gq+TlhNZWqCxCT29hkRxabW5Yu0XauG+f0HEY74pqpPOXuX4bmDMaCMZ6LmYtjcCm7/P5sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR07MB9052
X-Proofpoint-GUID: KEFlIki5fFnTI0TM3p1p7k4IiM2NlShv
X-Proofpoint-ORIG-GUID: KEFlIki5fFnTI0TM3p1p7k4IiM2NlShv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 adultscore=0 mlxlogscore=731 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060048

Fix changes incorrect usb_request->status returned during disabling
endpoints. Before fix the status returned during dequeuing requests
while disabling endpoint was ECONNRESET.
Patch change it to ESHUTDOWN.

Patch fixes issue detected during testing UVC gadget.
During stopping streaming the class starts dequeuing usb requests and
controller driver returns the -ECONNRESET status. After completion
requests the class or application "uvc-gadget" try to queue this
request again. Changing this status to ESHUTDOWN cause that UVC assumes
that endpoint is disabled, or device is disconnected and stops
re-queuing usb requests.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v2:
- added explanation of issue

 drivers/usb/cdns3/cdnsp-ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index 1e011560e3ae..bccc8fc143d0 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -718,7 +718,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 	seg =3D cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
 			      cur_td->last_trb, hw_deq);
=20
-	if (seg && (pep->ep_state & EP_ENABLED))
+	if (seg && (pep->ep_state & EP_ENABLED) &&
+	    !(pep->ep_state & EP_DIS_IN_RROGRESS))
 		cdnsp_find_new_dequeue_state(pdev, pep, preq->request.stream_id,
 					     cur_td, &deq_state);
 	else
@@ -736,7 +737,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 	 * During disconnecting all endpoint will be disabled so we don't
 	 * have to worry about updating dequeue pointer.
 	 */
-	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
+	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING ||
+	    pep->ep_state & EP_DIS_IN_RROGRESS) {
 		status =3D -ESHUTDOWN;
 		ret =3D cdnsp_cmd_set_deq(pdev, pep, &deq_state);
 	}
--=20
2.43.0


