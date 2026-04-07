Return-Path: <stable+bounces-233722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDqLI3p21WlC6gcAu9opvQ
	(envelope-from <stable+bounces-233722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 23:26:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3284D3B5047
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 23:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8CA3014C3B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC9737C11E;
	Tue,  7 Apr 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ln6yJ9p+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C72DF717;
	Tue,  7 Apr 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596931; cv=fail; b=L9Zca1N14f/822USj8JVdznql1sJSsn2kSO2smjG1ZSG6YYXFVSRlnaIEeeb4pS0D8zNCK5GQ1fSymQZuPRos9RUCYwl3LPCUKUIPYyovsE6aWnpcI/9sgRyug+/ND2P1QOUdeGyInkwcPZVvJWPQVcGLy4TaP2XHcTxbcFrQ5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596931; c=relaxed/simple;
	bh=B63UOtP2D8pwIyAigHX1gslTmTU+2AMzDzdOJvrDthE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kp8n8IsnCnS4ZXocBDzh/rSyVwtjyQFOnCFyxUyrv5W9LYSTHHoZr47d9keveVklx4Yupzpj4Yxl5+WAtUxNK/ChM31vcMXS2qp+ygNmK/UewerAdpoIdmAnbXNJu/WS+mcNhCl2N/75Rwc20tiWDOpnPxKOa6oL8hiL72M9ZAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ln6yJ9p+; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637K2Kl03027831;
	Tue, 7 Apr 2026 21:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=J8
	Bcr2Vo2HNlv+woWS3M8G1yOfFDEfde1aPstO+Zplk=; b=ln6yJ9p+T7pPT6VK1a
	qQH4vQEvVv6XRQyV8yxRx10HxY+okq/uX9ItIaGs3B9wd+fbCS6klXocDHI9v/X4
	K6UwB7mXEL9cFF0Q31WoSaibFgd1vzETKVoB2G6+uZUJwHXiPv06iy7xA5KcXY3s
	Cfwjmd/BkOdPdggXlohLl+64q95ig7SKa/14TcUv/8FLOoMsI10ByyFxvvbiW0p2
	pTX8A/NxQ4lG6ZWDUbKtVTzDg28px8XfvjANAWW6+RQqsR7jiqFMjwwwhGDWo839
	EBarezCqL+IRfCeSYBOm8t1PhYIbEZK+RCTK6sPmFhA2CQgHphoPx5SWu+q7WZaq
	1Rvg==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dd58t3ku1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 21:21:47 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5FFAB80173D;
	Tue,  7 Apr 2026 21:21:46 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 09:21:34 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 7 Apr 2026 09:21:34 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 21:21:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnKAFU9nDQzbJQ+5E0LO3dGzy4OpphJfgwQ9wAD752fIdb4+TBUcVZdoq2HQhI8FsHviH9571EeXP7po3E+6BCxmfeFzyYk4B7vHIeeBmGaQoI3Sayy7GiUITuSz5zzHP9lIrz+FGw9fthujAniB9ZIAo7HK6jUNIB+pyfZylJOtRUrT4Gv82yCxyVwjA9B+QZY5uoqKV1aNHDrM6XvcnjJNNMWbtrXuz9Kuu61n9wMbkNOH/y8McIDwFUvxoZixoOcOHEHonxl4vobkR3UQ7uSByixgjlzawGEgeqUWxsMZyUw6su6P06ggSNXDL8KmrGUwwj3YJ6wY5AQeJGlidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Bcr2Vo2HNlv+woWS3M8G1yOfFDEfde1aPstO+Zplk=;
 b=DyMP3nc43fB6kbT+TTi3ogDVfFjZQHIfYtEQQlj6SSmom17jUmJYsiDeoMHR6XJmfyFndJY5v9v4JBYEr6VmNhGx93hhAix7mrWC4xte3ODROQM2XMdsMZPQ9o6yhLY7Gvyc5UxURidLTJfUknO4WZWXGR9qiHIai/660+bX1FNGRNm/z19Hk36TuzNngWZzVYKfSxNoCpwwNLNlLnVb9iNUi16RTgEcn2OtKou2mktZrwpyZQFS+Hx3GfL6iiKHSKYNHaalkPF+KqlGnI8kPZ8F8RTAb0EdlWE1arQ78YkRtx5uh/g92mL3jlK9TD8US2zxX+5iSHFA6rWJTEhySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV8PR84MB3787.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 21:21:32 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 21:21:32 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: Re: [PATCH v2 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Topic: [PATCH v2 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Index: AQHcxrVHoCgEpn0KpUWpNGAfFRFIf7XT+iEAgAAhawA=
Date: Tue, 7 Apr 2026 21:21:31 +0000
Message-ID: <20260407212122.278824-1-sanman.pradhan@hpe.com>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
 <20260407173624.247803-3-sanman.pradhan@hpe.com>
 <20260407202146.59b1476f@pumpkin>
In-Reply-To: <20260407202146.59b1476f@pumpkin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV8PR84MB3787:EE_
x-ms-office365-filtering-correlation-id: 42f59a31-1f9e-4384-b94d-08de94eba3d2
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: T2DJsDvlqJch6k1ZAK2R8OX+4q81dqGUGPzm76At08s8iBY9CObjb0Tn/PDigQAyw/hh9XoPcFAfok00+tdFr3CGeUBbZfbrc2TkOVJOWIuieBdtsBNGjKxzdgvZW6rE/diL/eMqV3KRhjSGK+UVLoy2VlzNR3atWQykHnwmaZHP6TB5A3qkY1bqSpS8Qj4fIJi4BlCiUHkFQyP/Iy7nWWPjLi4rfEduSKycSrXtW1mSDv32McSS6HrLa9B8NflSogOUpFTibDt0DM8XRCJExYrpEMHppfSTrSLi6n2n3DKkAX9tiKfgEp8YExMpF4ccw4Wpd7UPTTpI6cyFBR551aPzxjpGDB28zyuhd46YE+uOcb0BiWq5ofrH37uytHbXyvgJ9Qyp7x8WQGwQN3o3aoc0Z+fiAFtSp4PIFZYpyOQO+z6LF0TpoLtviyI12xTXCGHv0eK0f3v1MeUGzrwHYNYaGeyWpzHAO2Gd3CbFHYq7WAeA33Tol3YQeWPgjiLieGZQgf4SJqf9ULxL2CZHtz4TT9c4f7h8e3C4wt5FaQ0jjz8KVBItEqtN/+pHSifpeW7C201FyDxOkeaF8AskGSon9BpC5pgImfVHqSQWhOKrpaSZofSSoqtbyT+ScYum/fsQNatiQZCGmeG8rKAZkIKK/iOftDRO4sQRKY3PElF4Vzq/6bi5zzhrH3cohvC6Dj5GKEc2hb8HVaRmuYBiNplCJG3jioK05FkjkkxNvRwtJ+1cz4roFBnfRAJWogZFkpkRakka6JX1IieHZ70c+kSEwAJP/5WWq0/K+mJVSxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5nNmFH1QPkFJzgbi0aOsSFqI8cDnMnnJEbrW528CdIQ4x7zyZH6I85eU81?=
 =?iso-8859-1?Q?maPjG7gErf+sMILYGIphAzuMNmUAza5MMLsYWR3zYPvRA4SBytcEmXJG69?=
 =?iso-8859-1?Q?GVUC98BkJ/p3VL4lolCIQ58iNcDITDEXF5xP3lM2Eui8JU7vev/aqVZahS?=
 =?iso-8859-1?Q?pwvUctRdtQq2iFMmN02sY7kj8lomuzNc79zYMR0kDZyaDH189qzBiYPXWr?=
 =?iso-8859-1?Q?HRlPqf4n/0ofJMhMdS0T8zb36H5GpuqWHbuxcL54UY/8om+blopzI/rrvz?=
 =?iso-8859-1?Q?I6/gGhL3ML4AH7UslYpTPjn1IYPZJeTaaLpqYrP6qHoEjzCxIBr4461UOf?=
 =?iso-8859-1?Q?H/y8hAZ4pZAWR595foANiDm8LVdf1GIrPVfW/W90GS4kbLVsM40kAXgdHl?=
 =?iso-8859-1?Q?Sq9TAhRnh55J2u4tnpyIiHT/fqBE6+eJaEBKjSgial95ikkbJA+bAeYRfX?=
 =?iso-8859-1?Q?IP4CtGYD0Kb7G8HvzjbP3jadTLgUO5Iw1WCyyINa+iQfTqR/31Qk4jTGWC?=
 =?iso-8859-1?Q?xNo4sRwt97N7mnVl6QEvM4xgcPlDk1srEW/LF6G7cVt9AZIpApf+3N40sZ?=
 =?iso-8859-1?Q?NCKfdm4D08DWorEA4+Owbxg8td/y9UAdFXi77Woczqk299BD3HOnAnIBdg?=
 =?iso-8859-1?Q?v230Jbo7bT7V1Zlm7M6AM/u/B96TbzJodtR3gKinOHx1HBloSnL8hMbCfv?=
 =?iso-8859-1?Q?iC7eUDxdjT6d319ReLQdYXAqxcRSCar/n0s4O+LYjz6942okZN7/Q/ROdb?=
 =?iso-8859-1?Q?N8bfktFD6NQmhnoqh6NbSD3i9ie/W4cSjQQcKMM2V79Bq1qCRFz1g46sfh?=
 =?iso-8859-1?Q?2j+G0XbtKWJy9Rlz1I3TTBLnlaF4+SjzC2t4whEZ7Hp9FcotRU9I6gUH7Y?=
 =?iso-8859-1?Q?NPxYYRdW+TmH4TRLHxXDXkSwugnq2zJQ9AB6vT4NW3qnUH4zlsSyhKOjyr?=
 =?iso-8859-1?Q?4KwKm52Bnt9e4o3gzJ7k9tfcUiuy1P5mJ5YGiAZMFBlCbalpdM4121yLNE?=
 =?iso-8859-1?Q?f7WK8q6H5GIeiHt3lYMbGeXY8ahp4UKNu2r8pqVh8Myi54MeVZBmMy795U?=
 =?iso-8859-1?Q?MLaiLEESdwtBpBB3dOueJEWohBvmAxTAuNJ2chvkygzPAUVfb1g9OTLmX8?=
 =?iso-8859-1?Q?8vcaLFRX20F1HVse0zvR3AHIFYNq7oPh+XTqbpobN+CzTk8d2Xb/TtWZwS?=
 =?iso-8859-1?Q?VxSsD2WkwJg25JexNSkonyzhoE/8Y+mlmUbdAfJIm9mE17NyI6mAAbfeeN?=
 =?iso-8859-1?Q?78L0+Kl8q/ebVvNk6wHxWhNVYoO/qN4w2lMKCyZ46C0ZwVENo/19FW/115?=
 =?iso-8859-1?Q?6c0W/R7r/ulfWjohM+koLtDJsqDWi4VA1+bb9NENRptCZPwph8dioUIfLx?=
 =?iso-8859-1?Q?z5Plpbwz1t4oGuvyk6xVPa8ji+MqW2SuXUJG4yo493cG6h5A2adr3da80r?=
 =?iso-8859-1?Q?1JlQUDhClF5KWaONcKe7GgOZc3YNwLxc2khYpeWbibBi9LsZlhKP3h69wS?=
 =?iso-8859-1?Q?ws3FPQ7wMNkJ7pWPrTOmtLOurXICUBdvARL0mH2x7mlvYXfV/Yobt21iQd?=
 =?iso-8859-1?Q?v5xvCSHw4/NtPe+XLZBf3EbgXlNw1cyWg3fulWPHOiyFvwSxDrBL2ae2eC?=
 =?iso-8859-1?Q?yfV2JohkyTIGLG8kGygjQakk4N2GHZkP1UE2eT1kiCbDgbGSvY2pd6DlXk?=
 =?iso-8859-1?Q?k7hccYa6LKcgIxeKvaLsVx9958UnqHiY3a7UFhnpy8AqAz+2d22T2B60eT?=
 =?iso-8859-1?Q?ZbwfFVO42fPfMh4fjkuzH730ATEnDq/PJDRjtdL0yP2LQG4jik03TmKaDf?=
 =?iso-8859-1?Q?/57kNFusYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ty5Z7Eytut+RFGxT6cYhL45mY5gE3ChV8iaoCP7LGUpv6DQAgl587CrtQe0OvaRNSRN8icUcNyqvHC2SNJcSHk4Wgii6Gofm1MYK4GoWcL78d7Htdvxmg9WpCD/hkvFvgXT3sAOCw1GRkU4G3CMwLbSG7MGNfJyDa5V5iF9p1rNZbGqsZDVNeMc3QOTwCGrScgVPqYBmZP1I9xaqzgGgfXY5vJMB7/jtU5xnNVyb9PuRQiwex5s3h6ck4LHAVXxnrZvKbnJzd/pBbVcK7iQSdLworeBUrOMmqbYN5jfNTiLXW7u3t5pAM+zSoYQHYY+ydL+rJWnhwBxXMsXzyc8vqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f59a31-1f9e-4384-b94d-08de94eba3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 21:21:31.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+Xd5x+Zg2N2lCXOGCMlscrWp+tycxeaR0giIeVhkZYGw/19fvWFpEswDzGdgaP10ikRoU9n3YG/PF7IyUa4eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3787
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE5NCBTYWx0ZWRfX/sDrSRYm4WYk
 Xbj1hxUdoXqQ6D49bUiO0xc/vmEvUSUBzof2xd9bAS7niIQ5s6gyNlWItAoYhWMpQIcaSmRyN9m
 HNG5R6NXSkyiBZYbLCmRTcoCwP5d4rQjaMXzL3s7oVShgGgTM1bSI8TKyFuESckm6j1FCu2bHZz
 zd+hPjYkuA7tE/gP5ZEi+ZShfb8/rv9Pd7XufVTp4lfQpyeSWIgmyoliUplg4zr9+LM5r740xIF
 /x0IWscH8DZATaF0lkOt78trw+k6tfJtasqDLqRuMo6+GB6bLHh7pT1dsBxhNwNRNkOkfpy9XYh
 EVvGY/izIZ8z/3tTzbOt61iFgNrczs5szb6E+EByO99Unluqiz8IqjHyfMQVMHkRlotdoVLHOX3
 AfTOC9Zx2YAo/hDHHuSPmfTzpZSKEpuyLjl3FkUJcvXMCEVOq+HvXWBzbPQUeCK52GPgei9rdMM
 Rft92hTYz4WMcu3eXqg==
X-Authority-Analysis: v=2.4 cv=dbWwG3Xe c=1 sm=1 tr=0 ts=69d5756b cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=anyJxH9OBPgo7lGdIicA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: bTV_SNCN8TUr5Jc66Vuos_E0piEboNKY
X-Proofpoint-GUID: bTV_SNCN8TUr5Jc66Vuos_E0piEboNKY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070194
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233722-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3284D3B5047
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Thanks for the review.=0A=
=0A=
Yes, I checked this.=0A=
=0A=
In this driver, gain is limited to {1, 2, 4, 8} by=0A=
isl28022_read_properties(), and regval is a 16-bit register value=0A=
(max 65535). The worst-case numerator is:=0A=
=0A=
  51200000 * 8 * 65535 =3D 26843136000000=0A=
=0A=
which is well below U64_MAX, so the multiply cannot overflow.=0A=
=0A=
I'll switch to min_t(u64, ...) here to make the type handling explicit=0A=
for the u64 result of div_u64(), if that's ok, and send a v3.=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Sanman Pradhan=0A=

