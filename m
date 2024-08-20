Return-Path: <stable+bounces-69692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21F9581DA
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A781C2469C
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4218C01D;
	Tue, 20 Aug 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XFvjqiw/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QTUoUyxd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C418C011;
	Tue, 20 Aug 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145326; cv=fail; b=L9uyOZ9WC8T6oAdIAA4ywfe0fLXbrhXBA9uhN7iaEWsLj/uaIzPwOR0wGEjql1Ep8Yy3Qgxa6G67Px6H2M2RyYcK2X9uoCDeUkphYXuAcibCyXoJfMMqUhJJXLzCineVc08dF2k8S0xy80KcjqqjtcJXGPhfJh03jplfQqfJb10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145326; c=relaxed/simple;
	bh=2+DT/1/XKkoPscLnymadxmjGncwqK41D5hOYQ9AsrgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PSrbmeFmevd4waU3QaPveapFajXnoNxmo/C6eaP+aY60ZW879OsauUKp36IIJXuB0rGkOuxPA5uEjFJDbv71qEHKKoGPxL6cEViOamW+x+DCqDaefC9x+UqbtdRfO/ztKbganDt+7UqT5/kShzWFfOgY94v5u+ycYLrYyjlgBJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=XFvjqiw/; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=QTUoUyxd; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5Jq3b023427;
	Tue, 20 Aug 2024 01:21:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=X6sU3oour/vNlHbaX3j4sqo7Car0tbpOTzUViAmwpLQ=; b=XFvjqiw/XSOC
	Mo2qWMM3CStIt4DZjOdZGBXTHhfdRoB+vpjHbmW4MDTymy9MYKpn5L0rGvoOJn/B
	eiop2DrdfV6j8+gs5Kn81E68ftIYKT+w+ID4KB5bM3VAhIIDurJbYlvYCqupS54r
	9H8KefUYbXxspeVI6QQYtoUL5pOWhzQUzSbf1N2QYz+skzqOv3FntgmCfJOWCaDi
	Mso//fWA5wwx8VXGThojzj6oLJlMgWeWqqcQR5ZzOKzqJaPQxBe0x5Vd6TxosyLX
	j8xpk1hdszgXLnYn2EOKSmsYWLTVm4W5Kmr9uBqkTTsKMcL5193xLXJ3Iyx5++Sz
	ijMJYEjegA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4147uau94b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 01:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rb8MFnsnpFnsE+M46Cio1VRUZ5gr5sakuwjLFTaKV0B5LB/5aVksR8EatNEsHKidme6uZF/uk9useHkfcoglRlffwDdoBpvrDU+bcME1orNoa1eaKv0DbfYdMbkdzc79n+hD7v/xW1AhjEYgFdpj2FazAA5zp/isXtdMTRG2O9w4PH98ENYK65c1CJRphwb+qSikXf1QIOJIGUDYns1LGJyjUNZ74dRMtz+NTMcWU+eBVckT+j7iEISeTthdsyl64wMNIKbAIRVRtS6LbAWvcN3qUbngyx/RDqj0Xc04uHnK2lyxBIHYFK8yTFrWvv7us1kdVaTP9XfGlxVvG3C6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6sU3oour/vNlHbaX3j4sqo7Car0tbpOTzUViAmwpLQ=;
 b=CQuUcmxjJbL7jTFXXcKfmERjpLItRWZ9N52tEHG2+6r1mPLFxJBTwKMAlIKEumAsN6jNAefnIF67jvsbYYKQLgeQcB6ftDqY2+Vf00hwqxTg/vAAGVsvxiBHABLrAz8qXxIfgYTHHs1v5GLORkUK/oVu3lz2qRuX7VG6ozzCkHTgoBnY+aHJa4sCvDZXrpb2zaySR/EUthshzTeSIwdZrXDApTILzcyoBiSeYj5pqtRB8APnJjtRfkHb/1fAaQ8chDQH40ZfH1CpVB0Je+mVtzx9/Ypt40idmhF2eBRltoRGMkDchlBzcAWHO/7aWoYpq4br/SGiHgr19JDqVF/AQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6sU3oour/vNlHbaX3j4sqo7Car0tbpOTzUViAmwpLQ=;
 b=QTUoUyxdwbJTOaEcbXxfct3n6QxL6sO8tGdu5kCIBMsEwxdHg5qYOT6sqptTKSOsICEzdmj7GZCK/K6d1l0VopegIim41RtJP8Yhgr4+DFX3jLh3Kb1N/5B6705uv0DlNAYtqjHQd/ocZMU7OrXlIOiKDsfjHm53lIyJvuSw/fU=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CH2PPFDF47B6187.namprd07.prod.outlook.com (2603:10b6:61f:fc00::267) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 08:21:20 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 08:21:19 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq function
Thread-Topic: [PATCH] usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq
 function
Thread-Index: AQHa8tcSaZ9otU6Q7kaVOUP5gNQzArIvzcHA
Date: Tue, 20 Aug 2024 08:21:19 +0000
Message-ID:
 <PH7PR07MB95381F2182688811D5C711CEDD8D2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240820075951.191176-1-pawell@cadence.com>
In-Reply-To: <20240820075951.191176-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTJiOWUyYWQ3LTVlY2QtMTFlZi1hOGIzLTYwYTVlMjViOTZhM1xhbWUtdGVzdFwyYjllMmFkOS01ZWNkLTExZWYtYThiMy02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjE5ODQiIHQ9IjEzMzY4NjE1Njc3NDg2NzI4NyIgaD0iMm04REIxZ00vVTBZbXJydHJtbkpmczBXZ3hBPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CH2PPFDF47B6187:EE_
x-ms-office365-filtering-correlation-id: 1c9184a3-d509-4892-ebea-08dcc0f111bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H0PxaFUZALzIE6Urq53s+c6gg+M5CPFSdBaWHw1FIem9GLa0OVEUD8UxKsJB?=
 =?us-ascii?Q?fl4kBTWckY6cUwOrTogtl2yxlu4MDVgkmCPsI4zw5Q+n8A6l+8LzCmsESfdL?=
 =?us-ascii?Q?lbi6LeXQ5H1ZDvEe4IYCGdPpBXxxA7vcIewFcDKQ9an4Isfxfg3m0VCUGGGY?=
 =?us-ascii?Q?g/9qUg58HktPe3ohcGlbwK/UnoZxI85ZJVI3Vosvd7s1oY/wFRMBDyq7faLR?=
 =?us-ascii?Q?oSYJJpKZ6ZQIW5VkmmlR72lrzC2IUhXyzAuBmZ3V03Jba2JA35ybD2YTi4S3?=
 =?us-ascii?Q?tcxF+Zg3xWPw13qkr3T9NRsNn2cnjvHHX1PsAudkhNFb19BXmxwrIo1w5Uhj?=
 =?us-ascii?Q?+a7jGzDTefn+wVGmv4AmDG2AKZgRVeuSQqBIEMfN1TG+7x4E39fd2cNtPH54?=
 =?us-ascii?Q?xdEnPULXbuSqo9LvP+EkrYhpyJ1EbWAe6JDWbAsqp/vUgkT1XJ+W1/TDpEka?=
 =?us-ascii?Q?gbUZ8+RlIIIOuDWaPvmGY5wut540zR5mpGbC+jeb9f5haNpZi6igyd0TTrTe?=
 =?us-ascii?Q?IwSoKzNKrLu33SPA9XHdUtdb1VHjMtmcC3bjpt+W0JkAuEJZfqfbtXOkngx4?=
 =?us-ascii?Q?VwVucSfKqhlNG4CPr6U8EP4Tf09RDidXpPVpju+O8zk4vAyOBA7MRfFvX2S0?=
 =?us-ascii?Q?CF0aUux3kxktxyxcdD7xWckL1A9Nzc2EXlYzeM+valvBMDqzxD4oEwiAnERE?=
 =?us-ascii?Q?R3yNv+cXuU4bd154ya08cVpAmVpuVsPUI6eSCEe96ASM9ccLBqVFMMFoIDMN?=
 =?us-ascii?Q?wgdhv+08Pz+/h28NB8dS4woN06LMi3hJodPNvyRFINS3CzLJQzxBYylxBDpf?=
 =?us-ascii?Q?e6OWeBE3GNnsd1aUitpT9K0yzAJz8xHf7ph+dQqUGNUsJsGf4PxIjktMg0Kf?=
 =?us-ascii?Q?nc54Y7tE5ZYK5yN8lat1od9RoT81TFTKX7Ze/eSQV0NRgxUkpz/R1x9dC35S?=
 =?us-ascii?Q?i8vGjO2pbG4GulWJXhWWov7s+8tjuUNrVDTfPpNx9qxpiBbQ8+ITC8r+ZLKg?=
 =?us-ascii?Q?ZZPnoTuiKwzlDKRDPKo5yponmPZk69NvXGWlXcHRwf4KNSHHVzXIqT0UgkBU?=
 =?us-ascii?Q?TQp0WJX06nW0yMh/BxLtd5MbvAmyoj3S8Okj2rrSDQMv03cEi62JpuUlQryX?=
 =?us-ascii?Q?WTZ9SBn6gHDIQGxqA4mdsgQMKW0X9y9gz6vMX9e8/9vR2bsfy/UvUpu1gAmD?=
 =?us-ascii?Q?RNln1HYuqq7+iCN875xGk9Fw69IO780gjReGrt9Z2w4Be9HCrhe0t1knmslY?=
 =?us-ascii?Q?WOvl+WZ2OLkHedZKUV0kApCcqvDczzSss3mKghCq3Q5xpTAiYGB6NGT6loRu?=
 =?us-ascii?Q?ewTDOxT1y0GBxS++xRHMi5wGZurCnbY7AWhnD85fr8vyWG9HoTe1P6p+U5GP?=
 =?us-ascii?Q?DPhsxL4esvZq/xJNUe+jQAgQaUWWumrbqdt6j3D9rBoBzvyO2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iaM3q0aTwDdKRWUG4xPYIPqUrXzSMHeurQc7/4vBliGgYU0Efv8GWqhZpui/?=
 =?us-ascii?Q?T7SyvuCbqpQIyTfDJSK04Ju8edPsLAf+7w9ennswGVIo3sKEfQz4bEYkQgvl?=
 =?us-ascii?Q?DzLhCnAGfm08XyJ6M3hqCIeEJHoZps41k8Krb/aLl5DFX0tYHBgqmPsggXTA?=
 =?us-ascii?Q?Y82Q124Furv/cu0MpbtpcsDB72AoWmD2hYWxs4oQwdw407gEpEt1Xj5B0usi?=
 =?us-ascii?Q?ClIBk/L4oOFTTycR0QyNDq2GJlRWnzPZSEwq+Oc5nXAS/rj81tlM6zkx0n15?=
 =?us-ascii?Q?r2+NaVuFPFwwx0hjAeakssokaZBYsRxD43+rxpBQn9O56wsX8CaCIdiUgPsv?=
 =?us-ascii?Q?jNZxfRWMgGZeD0vfVeTZkwNdI376iSOBJuhgwnN64bXxyoebuqC32XN5VO6E?=
 =?us-ascii?Q?2C5noumi07HDD0lKCxruZH8yqBFQfp98BTTkfvHZzk0nL934KxpeaI/YM+07?=
 =?us-ascii?Q?x9TISu0wdWnHz5znpYE5EN+zeRKwatdqdY0LLm9w6XSsalz5UoslRR2AQRK8?=
 =?us-ascii?Q?wwJIAfurCHaD4fD+MBoTztLgx/G6Ew/8oJdPe8yU2IvHaO1LXQcRM2MFAh83?=
 =?us-ascii?Q?vdVo9WhKW1cjCmb05uKtPLG9/1lEPJPvCHydXAmeaplGNLL1xlYTsLhpEP3/?=
 =?us-ascii?Q?2TyFL5pvYm64zABnkqHXk9R1Hu3CPNcs4CvLrBtDQDuZDffP35LZLKeMwu7e?=
 =?us-ascii?Q?GzNLW2gU8fFP/5xlSJ83EzlVscKaJHDEq3Ip8a52jPc3AHY72lisrAyS0VgP?=
 =?us-ascii?Q?fghWBt/yU0TrJIeKBL4B2nbjl+tCdMMSEJTaDzP4TsblOb2eyr0TivjKjDDS?=
 =?us-ascii?Q?kh88bLkSYPt9WbnInIsI7vDbb39NnRbHsw9BITDbQhpGAjbbm7XFfUg93OXl?=
 =?us-ascii?Q?8oZaUFadqlb/HNHrR0YOh0NvZ1jdMlKigZspusu61zz+FkdJsqsaNen7UJFE?=
 =?us-ascii?Q?OucMwleYplRa/GME77SYNsXThn1PiDpcb0HMAPP+5efHwW8lXH71M+RZDrAY?=
 =?us-ascii?Q?Q6eYzC1QolwZPF2srs192syeroWSdnMACymk+TL9z4KljcTnKWFdEXnrhd74?=
 =?us-ascii?Q?LemgUSEJtR1cwFX6TbS5HweL6mGqgXz24WsmgE5LL8TFS/Yh4Tw50CLiC8ye?=
 =?us-ascii?Q?ZnbBbLaavxbUbu5bZ0s81FO9SHkK35ZI9hSCHNZcHZTaEXKXyqbzKyTb6l9M?=
 =?us-ascii?Q?dtWq45LrmFEbCPmaQVRt+k5HEKoQJ5oQUAWT8DlIh4MUbZOoAT1BB7VtxG5j?=
 =?us-ascii?Q?qjZibFMAQiZQrw81lAO2JJXPD2pS00WPkeDB013YkrBeSfDpmb183xmye0Ys?=
 =?us-ascii?Q?9wlBoKlKAy5QSiOwuLoAC03KcYRIevE75j9oC1gFlJu8+pUPKXuUkuzFa6yo?=
 =?us-ascii?Q?gBsu0FHSLUpfFsJ6IxY/vAo7vFNJsxn+JQmPwzyw/bJSJuw0j7HfpeB0I9Wq?=
 =?us-ascii?Q?ptTxCvFf/R8BxA+X3K3WzjgtyYynnQ8S7UEP7jVirbveIZoMDKfZvY80nQ3g?=
 =?us-ascii?Q?ZPRsrDLuejL4dS1rV5uO2zQFbUM9mxbWgfsHpGSGd9WJU7VVprqrwkRMABA0?=
 =?us-ascii?Q?12X9dFeBvNGh2T88lwo3Z6ooEsSRe8FNJrt/stKI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9184a3-d509-4892-ebea-08dcc0f111bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 08:21:19.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rM+E1GHlPHiHsOOybzzbA5Pu6JmntMchqYbj1AL8/EHwArfmI9VhrhAXiTUJJ8rQ6FvKdutyCjKCFsNTKLPoSbnX9cmi+P+gxhXBxSclY+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PPFDF47B6187
X-Proofpoint-ORIG-GUID: ovsQhnDz3WynrfYWbayjxfRUr3R5pW6s
X-Proofpoint-GUID: ovsQhnDz3WynrfYWbayjxfRUr3R5pW6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=622
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200061

Patch fixes the incorrect "stream_id" table index instead of
"ep_index" used in cdnsp_get_hw_deq function.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index 75724e60653c..e0e97a138666 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -402,7 +402,7 @@ static u64 cdnsp_get_hw_deq(struct cdnsp_device *pdev,
 	struct cdnsp_stream_ctx *st_ctx;
 	struct cdnsp_ep *pep;
=20
-	pep =3D &pdev->eps[stream_id];
+	pep =3D &pdev->eps[ep_index];
=20
 	if (pep->ep_state & EP_HAS_STREAMS) {
 		st_ctx =3D &pep->stream_info.stream_ctx_array[stream_id];
--=20
2.43.0


