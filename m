Return-Path: <stable+bounces-231018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEu4IaAjymmu5QUAu9opvQ
	(envelope-from <stable+bounces-231018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:17:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC254356538
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 648E230071E7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B066399011;
	Mon, 30 Mar 2026 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N+/vmpNR"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7224E4B4;
	Mon, 30 Mar 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854677; cv=fail; b=mbudOo8DYNF3Ja3VSC1EQaiuauzF+K/thGvoaEZvL4hRePMdWAawZ3e1AehKpgXuxwgeA7hF53+b3oC51Tjy/Iiid8NN7hWaNn5JSFzQ+fXIf30pe8ADwTvVPhkttgXhMl1dTs0Aka2MB/B+N4wzFysP43qSIbGWHJc/31k895Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854677; c=relaxed/simple;
	bh=m3gxNNt/V7FqVqSNTuJH6iLiMABhBX2D5Ic0ZG9gguw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pa6MC12bU+3JeV9fJmYybSbWkhB7gW88rbDn9Nxuw+2BQEbSX5tEQ1wngkAfSgtKNvF+9/1bNSF0gYvXAOybGuvmty3nsmposp66fC+GW3t/0iUj908tPicvH/yyfRbfqtrViSV/BWBW8QtBVJ8TGzw8P+YmT1TGXTBZ3WKDg+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N+/vmpNR; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+aw1K9bk9UzRD2fk5FNfV85iaoVZMrq4WZc8h+MmZcxDfJCm0NIuKj1yNVtd1EycmZ1GFddD/viGoAcuzUltY05DzJI8P/P9nPmSwsBLLUdk+6JAxEDxhlJOkMeOQV2rwTgRyEqCltl0ywDlQC9dcbOH3W5YWKaQqHnJSLfKtLtlxr0dHQp08pTVTzoQFrX/GG/RH2L82o7xg4IURJwmyIZ0C1DyRbN3Z9IcftPoulbB+Vc6kUk7pFDGguF+4oS+lf5/E0efnNrKIGGT8yZRFa2BUM/aQ3ojXR+3KO8sdqVZ/tvQICp1O4mBKmplrj2kw2MwF7svPxFaMql8znJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3gxNNt/V7FqVqSNTuJH6iLiMABhBX2D5Ic0ZG9gguw=;
 b=GM3TnoeOZ3TVtzTtLKawWErUtMYRvxl+RioDLi0Givx3a8CgE9rJnXDh2yEc1kdyR9pQXZwf5kovKvIAJGFQjUqpPPBdOlfDe4v7g4FZCTErg6qQ4v7WBpHGQfXuWqWqL1UpYsMGzxfsXlOkSkOqL8/6GFeBOjnnE1f4rcJq3AcfAhO2V3dDvaGOla/xY68N/tLLmLLHqFehPazNPFeUlJPvr55arjLTveLZl2FxYKOIbe/0/GP8pn9UBpZyxv41Kh9GvJ4Q4nOE2Cgi73CCyAb/8b7tUogWXh/wmPXxL32VqTxgIjFfAM3bT6D5JHSO4uFYDP0xYOFIz623LrwcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3gxNNt/V7FqVqSNTuJH6iLiMABhBX2D5Ic0ZG9gguw=;
 b=N+/vmpNR91P0GbGXok7j74LyQi24dXQh29Eo6/81v+Pv+M7cTL8algJOBVBXV81q73bBmU8lU64KrlifZfLSXN72I+BEZi0RXum24y4RcPeYrnNEWsgfJkjwPHQFs2Mfq3sjjXFvKENuoQBgfW929qFO73+IgqmlHBWn4beVXaoei/QQbBLzDJXwGgI/7gyw5EzFpygP54Aaq8/j2/e1jEYFC5kMk3ghou8ffncvlBncg7a+Q7GuRoj6bIoVIVHCwdStLOORJsmPfjLOoXvmxI+Ze7DTP+WxA5yUlwx4yQABvHvzlYQtF/U3vGFznixFqgNye4xGvNv+VVtWZmeQZQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7552.eurprd04.prod.outlook.com (2603:10a6:102:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 07:11:12 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 07:11:12 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Thread-Topic: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Thread-Index: AQHct4Eimn8S6FzOSEeZOEeRWCABYLW15xAAgAwsvvCAAIkPAIAEFJUg
Date: Mon, 30 Mar 2026 07:11:12 +0000
Message-ID:
 <AS8PR04MB8833E299F4939CFA26280BAD8C52A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
 <abwFVpxrriV7Bt2L@lizhi-Precision-Tower-5810>
 <AS8PR04MB883306406390FCB4106C3A978C57A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <acau0qZNUqEQmGKS@lizhi-Precision-Tower-5810>
In-Reply-To: <acau0qZNUqEQmGKS@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PA4PR04MB7552:EE_
x-ms-office365-filtering-correlation-id: 006a7071-aacc-483a-c53a-08de8e2b8660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 BjeoSqFaiythD5SZpXl9Ep+TlWYiEHzFH6ont4JM/SD6sWHrPpwoR39zX47H7JxBFhIzhWpjjItFDDy/LxD8d7uWerFjRZNB4yoCmAT5/DhraTcA4zgjl7JdwLUZrb7DxZoP/8zoPiYPlCAGNC5e7GF0VLn86FHLUBIXoTsZEwmeScLVEMkm7sdxI1GH2i98348mPx3GByqM1sAp8YypT6BlCCScwfak9asyfFWif+7XY9CGkKlY5u/AqnmCTcj4xAGPFqdKyxpHFHs/gpGdirtdDLhdB0Y3Yhfn8gLqoag1zY+6q6Ez9zOI6VJsKjlaReuGVujs3IlpYKT9LapB9WbKBXbdS8fD+nxgY2Zaesj+s1HbvwkYVpUGj/+AP7mlPtPE+5oFaUmEyu2fTWljlQf38LYfcix+mODoCqotMGnf66hnq4MIWvzXL1EHoPM9KXa71y+IFy0ZmB/vPlt9cs7IsQCE5/ET6nuDk/nK9+xgw5xAHm9DuOxihEm3Esh0woinmP9JDHwl0bKU00G/vFZnmG/uw7Xvf6Be2G/RiQR7AEHrg0X4qtrtANk/NC1WYuzdmTe8Z6znl+EsZJWHL/agCHCNUnmNyLIgV+SA0SVTazj3yZJWxpVxOEdPDh3k44/Vx/tbqEAkuE2zbBhxJpjVgTvUYNlL7chbIXeXSNwoUh0dKYBrmHWGFzKy3BBOUZTgMpxMdTUzK2dkIuhOjt4tvIoGRDN3Zntybgr7JYkc4Gm5BQDWEPDpf2fSBgLFhiYFDm9/xmMcyrmJk8bcdl0hNqlOd8EwS1halw+mLaQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eU5PTWg3RDZVOG9ZaUFSUGhwbVZ1bkEzK1lacDN0SnVoaUJlS1NJOUgvS1ly?=
 =?utf-8?B?Wi91aDR2cmIrZlNyblFwbjlhVEdKN2lONG5kK0EzT1M3ZXpjL1lVaytvUnNE?=
 =?utf-8?B?TEhydHh2clQ3eS9hTjdiMmcxalJyYWkyYStPU0c3WjZNVHlMRmxTZG9tUEZI?=
 =?utf-8?B?VHA0TS84RFhzK05wQUg5YjUwTVlDcTJQb1g2Y1JuS2pHa3Q3Q0lzb1RUZ1Rq?=
 =?utf-8?B?b1k3dEF5MFVrTDh3K2lXbXRJTExLdUVuZWxQVk0wSmhPeVZCbGlzUDRuYytW?=
 =?utf-8?B?Vi9BRDYwVVZTeHpic0RHeHB6TCtmNTRlK1hmWEd2QThWTUxndjk1VWZFNDIv?=
 =?utf-8?B?SnhVNjdDYzJlZkJGdHVOZkZ5d05MY3hWQWVlbDFYYkYyOVo5bFdnSGEyVVRU?=
 =?utf-8?B?NXBWSkJzUk0reHdJOGRSbXRocVY4UW9hb0pzN1grSXRBa2RuTGlqdGhVTTVh?=
 =?utf-8?B?My9KYytFWW1pY1NHVUxMS1ZtZnVXY1R1MFNYc0ExV2JDRVNJN1lpejkyaS9N?=
 =?utf-8?B?UndWVDBOdE5hRGJ5RFBQSFJGbTBYMzNtM2hCZWtwbVB2UDI1Y2pVeFFPVGsz?=
 =?utf-8?B?OGVldE11U016Nk5qUXdwM3hMZm1rREkvcE1xVHBDUWZDNkVSQlNHVm9LMGx6?=
 =?utf-8?B?QkpkTkZVem9uS1NZczF6UGhuU09ROTRhYmlRZTRYNEpJK3RXTytNcXhuZWh3?=
 =?utf-8?B?dmF4OUZnRzhxdWxaQXVNcXUrRTJ3MU5wRHlCWU4yU0JqVnpTbmZDY0c5dmU1?=
 =?utf-8?B?b1lJK0oveFFUeHllVGhDSFlHUHlkSEZvQ2JCU1ArVVM1Q2wraVplVXlWaS9u?=
 =?utf-8?B?Mlg0cDg4a0tEajd5WEJ4UStkMG9HZjloT2d5VWVWS25FZVUvdGh4Sm5zUTdi?=
 =?utf-8?B?VEdJYklFQ2c3OFM1RE9KdGNXbDdCNjkxVUVWaloxdjc3Smp2VGpMQWUvZzBV?=
 =?utf-8?B?VWE0TG5oS2hvVHpCdldBQnhoS1lzMFlpTHJGSlVMS1dJOEJqNGcvSzdEQy9K?=
 =?utf-8?B?d3pmck1tclhVOGcrWGQ3ZlFIMUlhbENSMTNoWUw1Q1NMQ3NNWThQUWRLMFZj?=
 =?utf-8?B?cFdoTVlLdFlJT2RrMHF5YUowMUtnamcxVHJMTFV6czJzZEE4ODFKL2VJTS9P?=
 =?utf-8?B?Q3FVTVgrVm91bVdUa2FpaXFTRXowRG9zWGx5T0xmd1ZjVEpLZEV5Q1RJQWdn?=
 =?utf-8?B?aGZDd3ZKQTIxVXRCMTY4UTRDOEtuSHNkZ2FEZWxtVDNpT3dYM0taQmhoaGNx?=
 =?utf-8?B?dVp5T2VLQm40SHBjemNPMnJLRFVUY2EwSVRlNW5nZnRJYVJ3VjV3L1Z5SnRN?=
 =?utf-8?B?NDVEamFMYmpiYU5IeS9ncHl2V3lTUWpNRU16YnZCWDBGamU4Q1FSZmRHZGRs?=
 =?utf-8?B?bTNaTWt1bU0wWHJJYjV1cytjNnlScS9LUUhzQmZvVlg5SSt5RUc5Zm9RbHJB?=
 =?utf-8?B?dmZDVXFEV0xSaTZkMllnVHhyWllURkl4VWpXc3BPZS9HdEUyQnVYS1dzR0J1?=
 =?utf-8?B?MFRYaHVoMkRHaWpEM3JJd3k3bXZPUVNqbWlEN2ZGY2VmSGl2YWxyL1lxOEQx?=
 =?utf-8?B?OFJIbjJXdGtjRjRjb1Z6c0MrdmdwOTJlNHJ6TXhaa1dGSmdUZjRKK3JVem1L?=
 =?utf-8?B?QlFDU0xROWFjbmNUbGE2TU1yVXIvQU1jay9mb25BRE9EdnhhTDZULzhLdUJC?=
 =?utf-8?B?UHZ5WlNyK2d6OWpWVE91VFdTdk9sQkVZdWhoWGszNVVnTG1od1Zrek5nUUxl?=
 =?utf-8?B?bUdSbHdRRTZwVFBTd1NCejFsd1V1WHRKZlZ5d1I2U2tITlhLczVTRWk1U0Nn?=
 =?utf-8?B?RmJDQmtIMFQwWUh1NWMyYnhGQWYrMVdtZHRmUmF1K05DRFBsRWU4dEVJWUly?=
 =?utf-8?B?d214OFJCNWpXcjNLN2pVUDQrYWQwd2Zld1BOZ1d4VFVud1dvZDkrSk9XWDZO?=
 =?utf-8?B?YVZxRVZ0NSt1VVRmVVlMZU1SMy9UVmFlOHI2dFNXZnZOMjhUWjh3RmYzbUZw?=
 =?utf-8?B?a201ekt6K0Nna0xrVmk2QWs3SXVXVjdFYUhCVEpsOHFITlZlU3dUMjlkcXg3?=
 =?utf-8?B?eGl5MVdIU2wreE5jbnpDR1ZwK1BnSjJPRDhKRVQ5ZjNTQU5ZQjYzYmZiczl4?=
 =?utf-8?B?cjdKQkFZRFF6Ri9vUVNLY21TM0xRSC9XQUZHcFpCOUNaUHZLMGlaTlQwc0Iv?=
 =?utf-8?B?cHI4UGU4K0Q1d2s5STRTR1prSXlUTkZQZGlXT2drVlhQSWJ4eGtRMDQrSm5s?=
 =?utf-8?B?RlE0bkpJVWppTjNFWWZjd1Jma2trQ1lGQVZ5L29JSVYxNngxL3lOT3FmQUFm?=
 =?utf-8?B?ajllckYrK3lsOG1RSnpyTE1sWTYvckcxd3R5UFlnZ2tWL2I1U3EwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006a7071-aacc-483a-c53a-08de8e2b8660
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 07:11:12.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx3WH8PMn7hvUEok5Y0V1hkRsmQEwutLr86v5Og8xACW1JcgMl47wkx1j1aXnur5LI3yUSa0XhC9/7Nq9XKjzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7552
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231018-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,AS8PR04MB8833.eurprd04.prod.outlook.com:mid,linux.dev:email,pengutronix.de:email,infradead.org:email,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: DC254356538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNuW5tDPmnIgyOOaXpSAwOjIzDQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsg
bHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOw0KPiBtYW5pQGtl
cm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyXSBQQ0k6IGlteDY6IERvbid0IHJlbW92ZSBNU0kgY2FwYWJpbGl0eSBGb3INCj4gaS5NWDdE
L2kuTVg4TQ0KPiANCj4gT24gRnJpLCBNYXIgMjcsIDIwMjYgYXQgMDg6MTI6MjlBTSArMDAwMCwg
SG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+IEZyb206IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiA+ID4gU2VudDogMjAyNuW5
tDPmnIgxOeaXpSAyMjoxNw0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+DQo+ID4gPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJu
ZWwub3JnOw0KPiA+ID4ga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOyBy
b2JoQGtlcm5lbC5vcmc7DQo+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzLmhhdWVyQHBlbmd1
dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBmZXN0ZXZhbUBnbWFp
bC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gUENJOiBpbXg2OiBEb24ndCByZW1vdmUgTVNJIGNh
cGFiaWxpdHkgRm9yDQo+ID4gPiBpLk1YN0QvaS5NWDhNDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBN
YXIgMTksIDIwMjYgYXQgMDU6MTg6MjNQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4g
PiA+IFRoZSBNU0kgdHJpZ2dlciBtZWNoYW5pc20gZm9yIGVuZHBvaW50IGRldmljZXMgY29ubmVj
dGVkIHRvDQo+ID4gPiA+IGkuTVg3RCwgaS5NWDhNTSwgYW5kIGkuTVg4TVEgUENJZSByb290IGNv
bXBsZXggcG9ydHMgZGVwZW5kcyBvbg0KPiA+ID4gPiB0aGUgTVNJIGNhcGFiaWxpdHkgcmVnaXN0
ZXIgc2V0dGluZ3MgaW4gdGhlIHJvb3QgY29tcGxleC4gUmVtb3ZpbmcNCj4gPiA+ID4gdGhlIE1T
SSBjYXBhYmlsaXR5IGJyZWFrcyBNU0kgZnVuY3Rpb25hbGl0eSBmb3IgdGhlc2UgZW5kcG9pbnRz
Lg0KPiA+ID4gPg0KPiA+ID4gPiBQcmVzZXJ2ZSB0aGUgTVNJIGNhcGFiaWxpdHkgZm9yIGkuTVg3
RC9pLk1YOE0gUENJZSByb290IGNvbXBsZXggdG8NCj4gPiA+ID4gbWFpbnRhaW4gTVNJIGZ1bmN0
aW9uYWxpdHkuDQo+ID4gPiA+DQo+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
ID4gPiA+IEZpeGVzOiBmNWNkOGE5MjljODI1ICgiUENJOiBkd2M6IFJlbW92ZSBNU0kvTVNJWCBj
YXBhYmlsaXR5IGZvcg0KPiA+ID4gPiBSb290IFBvcnQgaWYgaU1TSS1SWCBpcyB1c2VkIGFzIE1T
SSBjb250cm9sbGVyIikNCj4gPiA+DQo+ID4gPiBJIHRoaW5rIGl0J2QgYmV0dGVyIGFkZCBhbm90
aGVyIHZhcmlibGUgdG8gY2hlY2sgaW4gZjVjZDhhOTI5YzgyNSBpZg0KPiA+ID4gKHBwLT5oYXNf
bXNpX2N0cmwgJiYgIXBwLT54eHhfYnJva2VuKSBvciBkaXJlY3QgdXNlIElQIHZlcnNpb24sDQo+
ID4gPiB3aGljaCBhbHJlYWR5IGF1dG8gZGV0ZWN0ZWQuDQo+ID4gPg0KPiA+ID4gUHJldmlvdXMg
cGF0Y2ggaGF2ZSBub3QgY29uc2lkZXIgdGhpcyBvbGQgdmVyc2lvbiBjb250cm9sbGVyLg0KPiA+
IEhpIEZyYW5rOg0KPiA+IEZyb20gd2hhdCBJJ3ZlIG9ic2VydmVkLCB0aGlzIGJlaGF2aW9yIHNl
ZW1zIHRpZWQgdG8gdGhlIHNwZWNpZmljDQo+ID4gY29udHJvbGxlciBkZXNpZ24uIEZvciBleGFt
cGxlLCBuZWl0aGVyIHRoZSBpLk1YNlEgbm9yIHRoZSBpLk1YNlNYIGV4aGliaXQNCj4gdGhpcyBp
c3N1ZS4NCj4gDQo+IFllcywgc2hvdWxkIHJlbmFtZSBoYXNfbXNpX2N0cmwgLT4gZGlzYWJsZV9t
c2lfY3RybC4gU2V0IGl0IGFjY29yZGluZyB0bw0KPiBkaWZmZXJlbmNlIGNvbmRpdGlvbiwgc3Vj
aCBhcyBoYXNfbXNpX2N0cmwgb3Igc2tpcCBpdCBmb3IgcHJvYmxlbSBwbGF0Zm9ybQ0KPiBzdWNo
IGFzIGkuTVg4TU0gYW5kIGkuTVg4TVEuDQo+IA0KPiBEaXNhYmxlIGl0IGFuZCBvdmVyd3JpdGUg
bGF0ZXIgd2lsbCBjYXVzZSBjb25mdXNlLg0KPg0KSG93IGFib3V0IGFkZGluZyBhIGJvb2xlYW4g
ZmllbGQgdG8gZHdfcGNpZV9ycCBzdHJ1Y3QgdG8gaW5kaWNhdGUgcGxhdGZvcm1zDQp0aGF0IHNo
b3VsZCBwcmVzZXJ2ZSB0aGUgTVNJIGNhcGFiaWxpdHkgZHVyaW5nIGluaXRpYWxpemF0aW9uLg0K
DQpzdHJ1Y3QgZHdfcGNpZV9ycCB7DQogICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIHVz
ZV9pbXNpX3J4OjE7DQorICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIHByZXNlcnZlX21z
aV9jYXA7ICAvKiBEb24ndCByZW1vdmUgTVNJIGNhcGFiaWxpdHkgaWYgdHJ1ZSAqLw0KICAgICAg
ICBib29sICAgICAgICAgICAgICAgICAgICBjZmcwX2lvX3NoYXJlZDoxOw0KICAgICAgICB1NjQg
ICAgICAgICAgICAgICAgICAgICBjZmcwX2Jhc2U7DQogICAgICAgIHZvaWQgX19pb21lbSAgICAg
ICAgICAgICp2YV9jZmcwX2Jhc2U7DQo+ID4NCj4gPiBUaGUgaW50ZW50aW9uIG9mIGNvbW1pdCBm
NWNkOGE5MjljODI1IGlzIHRvIHJlbW92ZSB0aGUgTVNJIGNhcGFiaWxpdHkNCj4gPiBmcm9tIHRo
ZSBSb290IENvbXBsZXggKFJDKS4gRnJvbSB0aGUgYXV0aG9yJ3MgcGVyc3BlY3RpdmUsIHRoaXMg
Y2hhbmdlDQo+ID4gc2hvdWxkIG5vdCBhZmZlY3QgdGhlICBFbmRwb2ludCdzIChFUCkgTVNJIGZ1
bmN0aW9uYWxpdHkuDQo+IA0KPiBZZXMsIHlvdXIgcGF0Y2ggZml4ICBSQyAgbW9kZT8NCk15IHBh
dGNoIGZpeGVzIHRoZSBFUCBNU0kgYnJva2VuIGlzc3VlIGFmdGVyIHJlbW92aW5nIFJDJ3MgTVNJ
IGNhcGFiaWxpdHkuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IEZyYW5rDQo+
ID4NCj4gPiBJJ20gbm90IHN1cmUgZG8gdGhpcyBjaGVjayAocHAtPmhhc19tc2lfY3RybCAmJiAh
cHAtPm1zaV9icm9rZW4pIGlzDQo+IHByb3BlciBvciBub3QuDQo+ID4gQmVzdCBSZWdhcmRzDQo+
ID4gUmljaGFyZCBaaHUNCj4gPiA+ID4NCg==

