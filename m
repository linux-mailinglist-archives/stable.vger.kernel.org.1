Return-Path: <stable+bounces-231314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOBUEJFBy2k9FAYAu9opvQ
	(envelope-from <stable+bounces-231314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:37:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2113363B9B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59461302F706
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 03:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD728CF4A;
	Tue, 31 Mar 2026 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nvkOUeUI"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A929B793;
	Tue, 31 Mar 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928260; cv=fail; b=PdxVEi3l6riosvwqAOLT1e1sPcTlWV9WXwg1atgP1ICYZUeHY6TFQpyUxQhS8LqZ+GTShVszrWZ9c9wnbO3buc+OsO1XDt44clK6F9mhPtGwvsd5lDO9WEymeW0g3HBhsV0SUHgHTCuNOqSRCKqdn66vZAZoGxRERO0bZ722VTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928260; c=relaxed/simple;
	bh=vXHzdrd6X5UOOPsruuoZ9wlIElnZ1tZFjvahWnI+ESg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FbmmV2u/VG+uXkTVqmpulN7UBngpcdHoVh5/mBWKSRNhxWG0KbAmXVh0ZUbTtX9fUKXjFWFc9Nn27cT3ioyBp0JT+rgi1QgyDE1o8+v5jROT9a7KbLmP/Hcgfe5wbRBguhQYRQf6AjJdIYm3yDtyKNyWeEqBd+I0vCrCkav0ICI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nvkOUeUI; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhGSNiavV6NySUpDNugGQx+b1fQF0DeBf/ix0qFNV995s4dbzR1EGCMuvX1JsSEFCpxAd6pEJ+8Vuuj+Ycn0YZZin/JkkPdy5eUWss8EihjVk7YvDKmv2tYo4WcurQEWjk+HZ95vDQWeZTOqXt7uJsh1pgt9lq/OTfxBcO430rvMOJOv9dIqcdqhL4x5Z/cxB35YunvXb7LXli4xW1cQGoSRV263HcnkT3WcmvaO3qVWfrzL+aDH3iwetKOeFRG2kGG1LlERe1OI8a1XWgeOXeQs1dJeWHRI/P3Y7tW4VE7ILxUg2QXizHny3sjEi7DR2F+vrCalPe9Af/OiIajtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXHzdrd6X5UOOPsruuoZ9wlIElnZ1tZFjvahWnI+ESg=;
 b=G+LYj1zp3nmtTh7oosuMwVYl2jL+t/tPHsYBc37Dq0L0x1MAy8e07FXpwMT0fEsTF8KMocqYfV1X5NzmRwEGO/P2WJn5pGXkspi9610F/qyQNWM73pAR8vU7DjUclD9gYgrNjXxn2Bli/egFeBlMGQuhWCOothI9KlsQ7H3xiHLMtRTKui2X40VSfb3XPOOrLKOGMUICJQ02JPsiopJdGPsNsWgzhsKkWi2H0ThJPSON0yt9ea8ztAk/rWof4QV8g6lHz/grathTxD7q+wH94NQ1dNouY66ZcVW/uC5Bk0Ot6YmD9aIVIMya+mQBJ2PaQRv0ZhT6eoF+pK8nkgMbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXHzdrd6X5UOOPsruuoZ9wlIElnZ1tZFjvahWnI+ESg=;
 b=nvkOUeUI2LciWcopeTHkl6gcNtG6BxCvPZPQvtNQ0boJ0MyxlyITWLt0/GqCfN8qQw2MTWrj6lFuLTWAATGx+/3gch5vJDlspdB1ow10qD3Pexgby5vNJDWF9bsLkcoLsnGvZbSF2+j7/1DYLpeWZNF8JHDNlQbrFH8Ifq3lxvi0HL0CFTpX04yAtl/cV4D9+oO7CW28JnMUl0BOAH7iJRZ3+wBOuATvs56jsLeiAV2LmH7VXUssJDQeL7AUCGu/Fh96foyBZryH/d3yt/GIEskv7aBcZb397zbvgstvmknv58c926XiT7bMQVXZGpOCNNCvHubWFXghP4xGNuDBjQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 03:37:34 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 03:37:34 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: RE: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Thread-Topic: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Thread-Index: AQHct4Eimn8S6FzOSEeZOEeRWCABYLXGvO6AgAAZemCAABfLgIABGbbA
Date: Tue, 31 Mar 2026 03:37:34 +0000
Message-ID:
 <AS8PR04MB88335E9C4A83E6AF10B293A98C53A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
 <kqv3x4qocp7rkas5oedlpzd43h3ez7dg26hqnfgubbjdhhxlwe@rfnsicbv7qba>
 <AS8PR04MB8833AE3B8D106CE446EF89E58C52A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <5nom7wnhrr57jvb6komumg3fjkbavsq5ecz2pd43rc5tsmnqev@ag6ld453s2lu>
In-Reply-To: <5nom7wnhrr57jvb6komumg3fjkbavsq5ecz2pd43rc5tsmnqev@ag6ld453s2lu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU0PR04MB9444:EE_
x-ms-office365-filtering-correlation-id: a3316aac-68d3-4022-6f00-08de8ed6d8ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 bmcTYtuJ7fAh56nhQEcf/xJjXBgolf2/nlcmU076SZK12Fqu3RNTvVtq653liSuqT/+iRYv3QYenCWDhJVN7dyVs0n8qmM2CXrFpYuqA7YlG80faPm7JRXty/TM213veI2k78F7v8yPNU2qs/oBfixIKS6kurq+drgHQnbk5ZM12c+JjSeTdP+IeB9gIMIwqDUzeR5UhMs/RfE5/8BAphTQCPiIn92Ub3h3PLuMaxdpFy0kuc03FyjA6jB8PUW26H9sNk+zTyNyHaWvxlDdKk8JZNvYZ8PHLRp/MrOkS4C3L+L6Uu5YnW1dEPjjG2pnPAgE0q34Ua5C7R60MGSNXmsrOEvdtoEswntj59eVucLVZUk3Q0EOMgfLeejtOtKFJ7eXmmXZYhLE8ug4DqcE3cg70zbHCgM/7VmewnyGXOjqd18dpAo1zEJg8hnHP+iXQIt9RdsaN+oHTtpihToxT6IbYjLlBSRBR9flMKVDPODIccXCB1Kzes4UtgiZm226/oH5Ws1SjDKjhMYvO/p7ivQqA8jPKavMfFpTc9Pkstz0xogFC1K0WcrezBAi7rx0uJidJF4r8o/gwneLEg3pe4TCruE3NMPxmdNi4sAoD6qgVgE2nwlZVM4EyZzxfMQH9CjHH/Pi9jxv+Po5IOK7+utEq1kQsJtapC1EtmiS427Yt8ScVs6MiIPezQBDuQXmACesOn79jW/xhfHPqLxwTOni/ksKwhk0Ei2cC/kiz9RbGJYjYo5fZ0U8NvfBI09SiPO0GFAlWVrjihjs5lvDEejHKeA9bBLX6eOWhDfoVoTU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTVDZ0E5NGRZSld1amdOZVJ2bzJTd0FEbWIvWnlNME9TYkM2bXlQb3lZc3pD?=
 =?utf-8?B?WUFRa3orNTV1MmdsU1lva3dCMTB5WnZBMUpKYzN4TEgxUW1NTFB4Mmt3bWVH?=
 =?utf-8?B?d0RadFhNR0ZJVGdMLzlPY1NBMHFuekhmVHJpSm1hZEMyMUZwMXRnd25lV1hn?=
 =?utf-8?B?Tm9wV2xzK1ZjNTNYWlYxWThDMG5xdmhDR3o4ZW5LUmkxak8va3lyRHRxeENW?=
 =?utf-8?B?eHZoWSt0a0xMR3U3M0xTUC9zZHJCeHVRL3p4QlBHNlJOQ3pBL3U5ay9QVEJw?=
 =?utf-8?B?ajJVS0FsSE42bml4M2tGeHIwaWs4ellVZ0lDVG5Ea0x4dVJ5aDBkbmxzUEpU?=
 =?utf-8?B?NXNxSm5maUxiWkNKQXhSejVrb0lYc2lWcGVmTEdDbGZGMStXQi90ZXFLNy85?=
 =?utf-8?B?UDZJQzhzUjZ5RzE5dmZiRVFob0V3Q2M0ZlFKdGZjOFIzRW9Ub0IvZG16OS9B?=
 =?utf-8?B?K1Q0eklrZXZBaCtILzJzWkFQbmtTZlkzRzlzelpoUE5wdUNPd1Buald4eXU5?=
 =?utf-8?B?MHB5VjBxTkFjU2FyT0dSQmhuWTV5ZzFYa2pZbEZzN2ljak8za2J1VVNaT0lI?=
 =?utf-8?B?dTY3S2tibTFTMVJlbTlBdmw2dFgxM3BkZ2pXMWtsbWpxVmJESUFIeTdKRit6?=
 =?utf-8?B?WTVTRUVlVS8rN0xSVGl0azVEbmgrdmkzaVJBdDVWQ0d6ZDBBeVJ0WFkzemc4?=
 =?utf-8?B?S1lILy9xNnozZC9nbzU0b2J3VFlzbVRaK2ZyRzk0bmJ2eGE1MzJJN3ZnQSs0?=
 =?utf-8?B?U2J3VkZaZ1ZKRVUvelVvL00wcGVnZnVUeVhjbTlTN2dSODhYSDZFQXNHRTZw?=
 =?utf-8?B?emU5TFdBaUpXenBtTzNzK0g0WWF1eE9WNzZ4R0t2dnM0d0IyOE8xa1BJZFFY?=
 =?utf-8?B?ejNkUXdRaFZSRU5YRlFlbHB5MTZKMWVta2Q3aWwrUWh4aWErSURtODZIaWpI?=
 =?utf-8?B?bmpYNW5CakVnNXJ2UEN2SHNrd2toSU5hOEtFK1dkRFU3YUNESGk3MXBEM2Iw?=
 =?utf-8?B?NmJWazQzaG1IU0lZOG82OUIrSEdvbytmWW9yNEhGa09uUE1OTndPUm14dnR0?=
 =?utf-8?B?ampXY2RWbUNCTXFXK3c5VmVRU0VmOVJFbTZyUS9VVFgzY3IwTktjeG0rMXRs?=
 =?utf-8?B?eDg2Ukd4bGhsSkFVL3RkSHhJSkhsc3o2bmFtaVJTRXhzMDNsa3ZVZFhEK2VS?=
 =?utf-8?B?RnlTNGt2RnJZU2cyYXpsaEFIcFdISzZuMTJvR2tnWllZaDdWQ0w3Ym5KcFNJ?=
 =?utf-8?B?SXo4YVlPZ3lETklJMWYxVHFOeVRrRjZiS0tlcDhyWlRoTWM3NEluVmV3cTdx?=
 =?utf-8?B?L2E3dkdDeXVuRURUcnZWM2M3NFpyT0RxTzRFNk5WT0JVZXZjYTFkV2VPQlJ6?=
 =?utf-8?B?MnU5eWRaU3MwY0Zsd1V0blp3bEh5T20wUG9RUW44N1daZkFhSU9adVc5cDhS?=
 =?utf-8?B?bVlDNDN4OUpXdG0wVUYrN0RVcWVPOXY3bFdTTGROMldZbm5OdWdEWkxZcmQ2?=
 =?utf-8?B?ZDlHczZIMjlvdmdTUXYxZkZ6WVVpaTZ5TkZrd2tMZWpnaXRUZEFnNWdFVS80?=
 =?utf-8?B?RGtleGRHS2xyazFBa3ZuSDNHd3pIMDZ4cVlnbnlnYzFndHZhUWQrMXRXUnFj?=
 =?utf-8?B?UGlzSkF0VHpLK3NKNVVYK3N5Z3NvSXhuWGFocTRvWTd5UkJHRlh1c1N0SXVD?=
 =?utf-8?B?cEpaZFBIeXFRZllSQjNoRWxvSHV5YXpOMjR5SHArNTJkb0RNbkFwK2loUEhG?=
 =?utf-8?B?K3A0T3JUSGJKaWhCb1ArRXJUZ2h6bU45WVFuaUJ1UkpncU1mYVNmR290MXBr?=
 =?utf-8?B?YVgwcTRobWpuWmliUWhsQTNVdCtrQVNjZlFPOE5pQVM3UUN2UTkzakp4eFNS?=
 =?utf-8?B?aW9VTTVpUitOeXBISSs0N3pldkE4L1dJNnlJT1JURDYyRFRTTDFuUUhyMFlq?=
 =?utf-8?B?czRhNGd4M2I2SFU5bmd4RElyUHYxMk9HMjE5VS8reEoyb0NHZlpDdGRCbm9u?=
 =?utf-8?B?OTU2UTBmcUlOeDd6Nk9wRlZCL3pTNm92dWtCOXJFS0JndnE5ek95QjFCM1hn?=
 =?utf-8?B?RUdsOW93VzIrRUFhOTk2SzNxV2Jibkl2cjFJV3BWOGVVQ1ZLVG8yTGpwK0tB?=
 =?utf-8?B?R1JUMklyOUxkMkRYRVJBdDlZaFIzWXBJMEhvbU1yRjZMTlNqQzFhT2YxMDlt?=
 =?utf-8?B?VW8yalpjWTZyREdjWitYODMwR2ViRnhyUGk1dW1qMWd3bU9yNmNDRGpqRktR?=
 =?utf-8?B?Y1Q1aDRlTlMzZ21ZbUl0S05mMVUwWVQ2L3k3aE5NTDM2SEFncGk3OHNBeGUx?=
 =?utf-8?Q?SdDze+76swdjI8YkDz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3316aac-68d3-4022-6f00-08de8ed6d8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 03:37:34.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyQC1DWV/lPfv8/FCrjYmpJEtedvHQQdx33yTdO7RGwYiG5UpiDQcmhK3lyQk8li27HhpuOKSiYgoq+JZC/R3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231314-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,oss.qualcomm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AS8PR04MB8833.eurprd04.prod.outlook.com:mid,infradead.org:email,pengutronix.de:email,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2113363B9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hbml2YW5uYW4gU2FkaGFz
aXZhbSA8bWFuaUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI25bm0M+aciDMw5pelIDE4OjE5DQo+
IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkg
PGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBscGllcmFsaXNp
QGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4g
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1
dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxp
bnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZzsgUWlhbmcgWXUNCj4gPHFpYW5nLnl1QG9zcy5xdWFsY29tbS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogaW14NjogRG9uJ3QgcmVtb3ZlIE1TSSBjYXBhYmlsaXR5
IEZvcg0KPiBpLk1YN0QvaS5NWDhNDQo+IA0KPiBPbiBNb24sIE1hciAzMCwgMjAyNiBhdCAwOTow
Mjo1N0FNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5l
bC5vcmc+DQo+ID4gPiBTZW50OiAyMDI25bm0M+aciDMw5pelIDE1OjIzDQo+ID4gPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IENjOiBGcmFuayBMaSA8ZnJh
bmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBscGllcmFsaXNp
QGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4g
PiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsNCj4gPiA+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+ID4gPiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBRaWFuZyBZdSA8cWlhbmcueXVAb3Nz
LnF1YWxjb21tLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogaW14Njog
RG9uJ3QgcmVtb3ZlIE1TSSBjYXBhYmlsaXR5IEZvcg0KPiA+ID4gaS5NWDdEL2kuTVg4TQ0KPiA+
ID4NCj4gPiA+ICsgUWlhbmcNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIE1hciAxOSwgMjAyNiBhdCAw
NToxODoyM1BNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+ID4gVGhlIE1TSSB0cmln
Z2VyIG1lY2hhbmlzbSBmb3IgZW5kcG9pbnQgZGV2aWNlcyBjb25uZWN0ZWQgdG8NCj4gPiA+ID4g
aS5NWDdELCBpLk1YOE1NLCBhbmQgaS5NWDhNUSBQQ0llIHJvb3QgY29tcGxleCBwb3J0cyBkZXBl
bmRzIG9uDQo+ID4gPiA+IHRoZSBNU0kgY2FwYWJpbGl0eSByZWdpc3RlciBzZXR0aW5ncyBpbiB0
aGUgcm9vdCBjb21wbGV4LiBSZW1vdmluZw0KPiA+ID4gPiB0aGUgTVNJIGNhcGFiaWxpdHkgYnJl
YWtzIE1TSSBmdW5jdGlvbmFsaXR5IGZvciB0aGVzZSBlbmRwb2ludHMuDQo+ID4gPiA+DQo+ID4g
Pg0KPiA+ID4gV2hhdCBpcyB0aGUgcmVsYXRpb24gYmV0d2VlbiBSb290IFBvcnQgTVNJIGFuZCBl
bmRwb2ludCBNU0k/DQo+ID4gPiBFbmRwb2ludCBNU0lzIHNob3VsZCBiZSByb3V0ZWQgdG8gdGhl
IHBsYXRmb3JtIE1TSSBjb250cm9sbGVyIChEV0MNCj4gPiA+IGkuTVNJLVJYIG9yIEV4dGVybmFs
IGxpa2UNCj4gPiA+IEdJQy1JVFMpIGluZGVwZW5kZW50IG9mIHRoZSBSb290IFBvcnQgTVNJIHN0
YXRlLg0KPiA+IEhpIE1hbmk6DQo+ID4gVGhhbmsgZm9yIHlvdXIga2luZGx5IGNvbmNlcm4uDQo+
ID4gVGhlIE1TSSBjb250cm9sbGVyIChEV0MgaS5NU0ktUlgpIG9uIGkuTVg3RCwgaS5NWDhNTSwg
YW5kIGkuTVg4TVENCj4gPiBwbGF0Zm9ybXMgcmVxdWlyZXMgdGhlIFJDJ3MgTVNJIGNhcGFiaWxp
dHkgdG8gcmVtYWluIGVuYWJsZWQuIFJlbW92aW5nDQo+ID4gaXQgYnJlYWtzIE1TSSByb3V0aW5n
IGZyb20gZW5kcG9pbnRzIHRvIHRoZSBwbGF0Zm9ybSBNU0kgY29udHJvbGxlci4NCj4gPg0KPiAN
Cj4gSSB1bmRlcnN0YW5kIHRoYXQgTVNJIGlzIGJyb2tlbiBvbiB5b3VyIGhhcmR3YXJlLCBidXQg
SSB3YXMgdHJ5aW5nIHRvDQo+IHVuZGVyc3RhbmQgJ3doeScgc3BlY2lmaWNhbGx5LiBCZWNhdXNl
LCBSb290IFBvcnQgTVNJIGNhcGFiaWxpdHkgZG9lc24ndCBoYXZlDQo+IGFueXRoaW5nIHRvIGRv
IHdpdGggdGhlIGVuZHBvaW50IE1TSXMuIEFuZCBzaW5jZSB5b3UgbWVudGlvbmVkIHRoYXQgdGhp
cw0KPiBpc3N1ZSBoYXBwZW5zIG9ubHkgb24gb25lIHBsYXRmb3JtLCBjb3VsZCBiZSB0aGF0IHRo
ZSBoYXJkd2FyZSBkZXNpZ25lcnMNCj4gaGF2ZSBtaXN0YWtlbmx5IHdpcmVkIHRoZSBSb290IFBv
cnQncyAnTVNJIEVuYWJsZScgdG8gaU1TSS1SWCdzIGVuYWJsZSBzaWduYWwNCj4gb3Igc29tZXRo
aW5nIHNpbWlsYXI/DQpZZXMsIHRoYXQgbWFrZXMgc2Vuc2UuIEJhc2VkIG9uIHRoZSBiZWhhdmlv
ciB3ZSdyZSBzZWVpbmcsIGl0IGRvZXMgYXBwZWFyIHRvDQpiZSBhIGhhcmR3YXJlIHdpcmluZyBp
c3N1ZSBzcGVjaWZpYyB0byB0aGVzZSBwbGF0Zm9ybXMsIHBvc3NpYmx5IHdpdGggdGhlIFJvb3QN
ClBvcnQncyBNU0kgRW5hYmxlIGluY29ycmVjdGx5IGNvbm5lY3RlZCB0byB0aGUgaU1TSS1SWCBl
bmFibGUgc2lnbmFsLg0KPiANCj4gSWYgc28sIHdlIGNhbiBpbnRyb2R1Y2UgYSBmbGFnICdkd19w
Y2llX3JwOjprZWVwX3JwX21zaV9lbicgb3Igc29tZXRoaW5nDQo+IHNpbWlsYXIsIHNldCBpdCBm
b3IgYWZmZWN0ZWQgU29DcyBhbmQgc2tpcCB0aGUgY2FwYWJpbGl0eSByZW1vdmFsIGluDQo+IHBj
aWUtZGVzaWdud2FyZS1ob3N0LmMNCkdvb2QgaWRlYSEgSSdsbCBpbXBsZW1lbnQgdGhpcyBhcHBy
b2FjaCB3aXRoIHRoZSAnZHdfcGNpZV9ycDo6a2VlcF9ycF9tc2lfZW4nIA0KZmxhZyBhbmQgc2tp
cCB0aGUgY2FwYWJpbGl0eSByZW1vdmFsIGZvciBhZmZlY3RlZCBTb0NzIGluIHBjaWUtZGVzaWdu
d2FyZS1ob3N0LmMuIA0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiENCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KPiANCj4gLSBNYW5pDQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPg
r43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

