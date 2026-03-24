Return-Path: <stable+bounces-230043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBF6IbzwwWkdYQQAu9opvQ
	(envelope-from <stable+bounces-230043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 03:02:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3585300E17
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 03:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB83303C805
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87C37CD21;
	Tue, 24 Mar 2026 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l5royXu6"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D062571D7;
	Tue, 24 Mar 2026 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317749; cv=fail; b=HSgdWaV7LX0E5lCmRYwnm6fvXOGkm2pDl9ATSTR5wSCZ11KScEXd9IfmSgcKObS+Kv5bS2rBGsOSlObrDh9mwfXy4z7tSuSlqQo9N8xB1x6nw2lLCOKPZBEJzHrvnHxjCBR2IX+Ri/GFqDHiaeuK1qZb+yx9eloMpKVfIxpBHSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317749; c=relaxed/simple;
	bh=wngK0GxnEWnlr58OKQalRK8s2KoxDNoVhwQZOZC0QFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUMC7nB8Xe2hX7hZQg0FebJj28GyBoGlnyBeavnKoWzb00QOirIzSrkI5XDus21iTNIvgv1qNv/aoVLkti3QKXHM7ji1kJrTdFeSFgJvieTLEELI19Y+RWwDHnREAw5SxkqfV0I4jYJMvVaD/KGaARwKEqXXcDW5IgAKZzjZzFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l5royXu6; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzhIFMiHyZpUaIp1zL+EXp9zoUALLdS3IHf3EauNMuFhXLMJEGku0OPNeB1AAxpdSH5QFcdYdyS+rNB6yIikeLHNbCLt0LV5IdxIcIzTcgHPPneesuKz9nZxXIKQpoDt5i97yzgv/NPC1St9pGg/jjz4CS0zlYa2eMZFx7yVRlUD/kEBzIpjAlURcRvcAjeetXhxSl4zNptcyl+tHIf62LR9M07jySBkCkgAlXSromlJfqABnsEKFsdkpV7SwAqL+GuAcO+GV5RAn0XsWRDDbiCHw3UolNoT3QhQD2soYieJG3f1H7ruIwyjLlQfT4JB4AuGqjnkaPLsfQEN2ePiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wngK0GxnEWnlr58OKQalRK8s2KoxDNoVhwQZOZC0QFo=;
 b=DokUqDb+/IGwfvN3svhDb/U7XpLNOl6aHfRN0UiNtd+5CeCZy9uqhgCFFbbQcv7NE4VCMeJFwhCzgg/KN98vm2HBFl+9e1jWQfN6h4dbSWkwpx6m6ZOGs6wbAesIiKQAlyXkC5pCftuzVsMjmdKhvvg18mB7KzDx2bB21VlU8xB0aux4LzOvVi0KIlGJDj6ZYvqqU5N7LbE4q6BA6jKk9YbrffMEXbN2lhBdF6UCRfqqomZHpOADkOYv5egZLAD93aNLsAN0I8N4DGpxNbRxoNdeutNxRo0Ai1NISdAjZI8v9OaZG9Z9fpvUy0MmJgUtq/xZ4I0SrMKIno9ypV7YPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wngK0GxnEWnlr58OKQalRK8s2KoxDNoVhwQZOZC0QFo=;
 b=l5royXu60dRuMFWXU8P/3VFvjxmkSs382SGiW5Bk/k5p1aUn7073kfoJGDd80yLeOhPtuNxoDBJOf5w2r2ijzUIvw4lWyVw5C81mhWSW+W+WKTsSS9VgvjF3PaFkeaRz9j7UE3vcuuEpND2gz1+7Ser4UaWipREb+75jqbRQjQKGkP+QTn7UD6ZlqS+hKZRezO/KKFl/BHvieFOXruc9v1QCMaTgK1H+H6SOK6nPfG7thVcVXGfvKVz6yVngdOBJRquts2FkBNMftuif6H1LhPUSBQTFXfpaPqr9fFHFNQyb6+P1PxtvGgiWaNmYcrTsuFqEKkDdHurwHjGie1AzFg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI1PR04MB10026.eurprd04.prod.outlook.com (2603:10a6:800:1df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 02:02:22 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:01:58 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Topic: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Index: AQHctdXR4rMaQwHMbk+Nxv/9or4V47Wy+e2AgACXyCCACSXqAIAAPoUA
Date: Tue, 24 Mar 2026 02:01:58 +0000
Message-ID:
 <AS8PR04MB8833137860C682F9E1E743E08C48A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8833061F34B9BEFC9D19764A8C4EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20260323220858.GA1084506@bhelgaas>
In-Reply-To: <20260323220858.GA1084506@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|VI1PR04MB10026:EE_
x-ms-office365-filtering-correlation-id: 71aeadd5-d017-4396-d934-08de894954ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 tF0o5n6jy3RvDyw2eX8TWLMt8y8WXcUQ2CEyWJqRedWfwxGSKia6Eqv4FlRp14/VcyORzSwnC4wQ84ctlxU0sVgElmiWuH/Sh2+wMQG1fiJjaWHvd2TN2YqUJ/djicOipwfPOr6kyP+OFwXWHnw2rHZ79uepTHwzPSpIx5743Wgzp5Tg9J8jjEVVpULrfTRKKDP4Jo3sdP2rS9JzTP9l0zOzX/u6Db9XnYEscnO5ePpE0sfMD0hSEJ53JTG/YHBXU7ulb0piugd21LwynpoqTssL1jhsOUqT9/mQ/bqtJ5dHOuDCHuagoZysrICO8QCS+cr9fB3UmSJEZb/wE+lY5meGQP96nQMVDyytOdBq9GZUKrYgB9KHfsB//slakTfwFaWINvNKhirfh+tgI7GtkVe2wjMKFfCVOhFy/B6lqORW5SrmQTE4xx7ZMJsyRnotdw+CddfvX0DpV6ttGsDxXWvFoBclBJmYJxS859j0/l94xL+RcAGCGVgwX8PX76VkzHhQVuujWHy9pEsTAc6uScionkNjt9wbycmtgVZNkuA+j+gv/rGo85VNu9u0fTpcslODtPYvGAFZa2L58wdnd8n9b4l6zxtDp11TYdqV21OeSaATB+Hk2/aLjS1+zRi9sWQbYCNwnXbZOAullPPtPVX2ydhIMGevTgTMJUiE0DjgEuVRpEr3IhKTDtS0q2Zxe3IF3f61dLyatSacdOe5nhKiF36NMYvuiFOb7lwQHSaQTpRK7pKCTZIwKhMGS0+f3QiX27y1sfJX2+ZA/1uMf3JqfgQ+HpD1YVwaZZ4F9dU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WGRkNmZxWHBnajBwSzY2ckJXQU9uUnBBZ3FnZDVHUUxCbW92RG1WZ0RvYXNz?=
 =?gb2312?B?S3p3S1FiQjl3d1R0ZExSdjlHZ3MxRm5TZWhWeUVoSWl2SEVHeDl5amMxMGZq?=
 =?gb2312?B?K2h1NHZvMzgxVmw5WjBEUUdwMkN3ME5BK3Q5Um5GSXgwWVYzNGR5bnBKeTNL?=
 =?gb2312?B?SFkvWmRsWlVtK2s0Qy94ZVFQWFdKRUpJcGRibVhJeE1VdWFQZjBUSWc5TG44?=
 =?gb2312?B?ME55VUhycmRBTG0yRmN4ZUQxbjhmdXhRQnY5ektyNngrYlVBTlNIQmdZSGlD?=
 =?gb2312?B?NHg3YjFpcGs5ZjNoVUxKZFowSUh4YWhMOFFtYUtlV0tMYjJtdG51QnIzZHpF?=
 =?gb2312?B?ZVowR3YvUURtTjdTQlVEQytTRTBkRThZVmIyRk16NUJydHROeE8wNGV2Z0tp?=
 =?gb2312?B?RGUxYjM4M1dwWlZ5aWMyclV5Wkhyenovb3o4eTVsVzcvTTUxVm5DenhnbG4z?=
 =?gb2312?B?WGhWMEJWL1Q0K2s1SjR0YTJWdzR2WVQ0VW95bTE2eWRtckN0b0xYNVZhYkhL?=
 =?gb2312?B?TGdnZ1ZGWC9aSWl6dG1ITGtGQ1Q2M0VSY0tKNGp4TnZWZU0rbjNuOXBrRHgr?=
 =?gb2312?B?d0E2NDlwdnhvdS9IajVCRXlOdDR2ZGtnR1ROdytjNlpIcmdJZ3ZyVWVDa2Zk?=
 =?gb2312?B?b1JCS28yQzJWa0VkZDFEM0d6VVZhWlg0L3BZekFHYnhxa1VoR0NlMjFrNEVh?=
 =?gb2312?B?MjJsOUJUc0I0d0tqanhvOG1YYWFZZXNpTmR4S0dkREk4YWlmYUhkQWRuUHRX?=
 =?gb2312?B?OXpza0ZldEZNTy9INmJSRi8weElpY3pmcVczNVg2RVJyb1Z1UmFEWVZ3NnJC?=
 =?gb2312?B?OVdwU1FmSm5mQ1lvNW52ZlU1TlBSbGtyUmxuM3RmUGVkRWFpdHdmL3hydmtF?=
 =?gb2312?B?NmhWWnJyNlRZM2plUURVRFEzSzF1SDBpMVJhdzNIbXNXSnB2eTVpdUFxS09K?=
 =?gb2312?B?amQ4TUZua0d5Z0Z6SDhSeVVLR3dVcW1YQzRVMG93SDZsUGlvRVBPei9sMjhV?=
 =?gb2312?B?am1RcmliNDc4RzdMNjdFMmxXUzF5RDR1aDFvK2Jwek9MMXFqMlR6aXJGZkN0?=
 =?gb2312?B?S0tCOERTbWxDOXFybHZUNkdMV1lBMUJoQkVUVWNjamk0RHZTbGx4YjR5U2U4?=
 =?gb2312?B?TTVxN1EzS1pDSHkzUWZCRWppelZGR1ppZFp5c3lzWlhtTFFZSTZteWVBSVhw?=
 =?gb2312?B?ZWpNRUFTVnd4bDZsZ3U1NG5tOEF6NDkvRGFrVmVvZ0xWY2FndURDeHdEdjd1?=
 =?gb2312?B?cFNnVEUrV09oWWIwdi9TUGV6Z1NWV21sdXBNdk1vVmFMTjV4MllpYTVuY3du?=
 =?gb2312?B?R2ZZNHpZOWRHV01aSEY0WFk2aGJ6cy9QOUVVcjZLM3dMYTZVZW5aZ3hEQmRa?=
 =?gb2312?B?UDVvdDNqZ01NSk12ZzhNaWhic2UzQmVlT01iMHo1R0dtc0dzcTdRcjhwL1F2?=
 =?gb2312?B?MXVaYTYyQytxOURCa2JEY01ZSkZMRzZvc2Nwb0c1SURmUDN2dzduWHRUNWpT?=
 =?gb2312?B?RzVzMFB1MHhLcWxmeVJNZGJua0M3UG5RdElJTEpyREZKdlh1aHVyYkZPT0FH?=
 =?gb2312?B?YXdJS0xMNzlXS081SlA0aTNqaHgzdjVsSmZCSFhKVnVwRTQ5WGJDODFPWnk1?=
 =?gb2312?B?Z05KYXFWcEllRVJ5dGpqRi9CZWNvT29remY1VVdjVUY3SHRVMU5GdHBLNEtM?=
 =?gb2312?B?KzJRdnZkYmt5Q2ZOMVdPZUtlWTlSRDU0ZWwvSXhZaUhDUHk5Z28ycGZKcHdm?=
 =?gb2312?B?bmVRWFc0MHR4aGkrR2VBSURJWUJYOWtNaWxvUDBlZk5jZ1Y4M0pDQUFaUlhE?=
 =?gb2312?B?VldXR0ZZc3B5dzJZZWQxMkRZN1BlWnRRQytXRGpBUmwrUkcvZmxKQ1htdDZp?=
 =?gb2312?B?RE4xMmMxbVNjcWxGZW5qN2g2MmJQVjFzL2ZuM2lGN2l4akRMUGpSbmZFV1JG?=
 =?gb2312?B?dksySGdoWkVFZUl1elJkckJiNlNxUGlrVDV0Y3hCMGcxSk8ycndhVGx1eGxE?=
 =?gb2312?B?SFAzMWUxT0VOMkFoTXAyM2lYckFSbXJQbzNmb1VOS3EyTGpHTG4wb1hWMUxD?=
 =?gb2312?B?d3dodk13TVBETTZsQUU3bjByUVBZMVlyWXcwYjY5SjkvcGZnVlhOdHRzdXpl?=
 =?gb2312?B?WU1GbmluRjNXWFp6WnJNbXRDV2ZKM3F2U21ualdBNW5XY2FoUmhhQThFTE5C?=
 =?gb2312?B?bHc1VGp2UFZBdmliL1R1bWhYMzB3Z29uREZhMEZ6K0ZEeUNIUWpCdzZHNVhv?=
 =?gb2312?B?dndYblJLZE5YU3VBRmhia1NTaDdTNUp1anEvNWE2ZUQwSzlCdmVBRFZVbmo2?=
 =?gb2312?Q?XwF4Q5mKc5HkkUD0vi?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aeadd5-d017-4396-d934-08de894954ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 02:01:58.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGoCDuQ2Onyyt3KNeP8pyO8+X96+KeUKmOzgdOo8R5blRN9EqCKnJWf4cW19m4MnZpLcIAUVQaFU7s2eDc5npA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10026
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230043-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,kernel.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
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
	NEURAL_HAM(-0.00)[-0.987];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3585300E17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjbE6jPUwjI0yNUgNjowOQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBr
ZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwu
Y29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MV0gUENJOiBpbXg2OiBBZGQgZm9yY2Vfc3VzcGVuZCBmbGFnIHRvIG92ZXJyaWRlIEwxU1MN
Cj4gc3VzcGVuZCBza2lwDQo+IA0KPiBPbiBXZWQsIE1hciAxOCwgMjAyNiBhdCAwMjo1NTo0NUFN
ICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+
IC4uLiBbbWVzc2VkIHVwIHF1b3RpbmddDQo+IA0KPiA+ID4gT24gVHVlLCBNYXIgMTcsIDIwMjYg
YXQgMDI6MTI6NTZQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiA+IEFkZCBhIGZv
cmNlX3N1c3BlbmQgZmxhZyB0byBhbGxvdyBwbGF0Zm9ybSBkcml2ZXJzIHRvIGZvcmNlIHRoZQ0K
PiA+ID4gPiBQQ0llIGxpbmsgaW50byBMMiBzdGF0ZSBkdXJpbmcgc3VzcGVuZCwgZXZlbiB3aGVu
IEwxU1MgKEFTUE0gTDENCj4gPiA+ID4gU3ViLVN0YXRlcykgaXMgZW5hYmxlZC4NCj4gPiA+ID4N
Cj4gPiA+ID4gQnkgZGVmYXVsdCwgdGhlIERlc2lnbldhcmUgUENJZSBob3N0IGNvbnRyb2xsZXIg
c2tpcHMgTDIgc3VzcGVuZA0KPiA+ID4gPiB3aGVuIEwxU1MgaXMgc3VwcG9ydGVkIHRvIG1lZXQg
bG93IHJlc3VtZSBsYXRlbmN5IHJlcXVpcmVtZW50cyBmb3INCj4gPiA+ID4gZGV2aWNlcyBsaWtl
IE5WTWUuIEhvd2V2ZXIsIHNvbWUgcGxhdGZvcm1zIGxpa2UgaS5NWCBQQ0llIG5lZWQgdG8NCj4g
PiA+ID4gZW50ZXIgTDIgc3RhdGUgZm9yIHByb3BlciBwb3dlciBtYW5hZ2VtZW50IHJlZ2FyZGxl
c3Mgb2YgTDFTUw0KPiBzdXBwb3J0Lg0KPiA+ID4gPg0KPiA+ID4gPiBFbmFibGUgZm9yY2Vfc3Vz
cGVuZCBmb3IgaS5NWCBQQ0llIHRvIGVuc3VyZSB0aGUgbGluayBlbnRlcnMgTDINCj4gPiA+ID4g
ZHVyaW5nIHN5c3RlbSBzdXNwZW5kLg0KPiA+ID4NCj4gPiA+IEknbSBhIGxpdHRsZSBiaXQgc2tl
cHRpY2FsIGFib3V0IHRoaXMuDQo+ID4gPg0KPiA+ID4gV2hhdCBleGFjdGx5IGRvZXMgYSAibG93
IHJlc3VtZSBsYXRlbmN5IHJlcXVpcmVtZW50IiBtZWFuPyAgSXMgdGhpcw0KPiA+ID4gYW4gYWN0
dWFsIGZ1bmN0aW9uYWwgcmVxdWlyZW1lbnQgdGhhdCdzIHNwZWNpYWwgdG8gTlZNZSwgb3IgaXMg
aXQNCj4gPiA+IGp1c3QgdGhlIGRlc2lyZSBmb3IgbG93IHJlc3VtZSBsYXRlbmN5IHRoYXQgZXZl
cnlib2R5IGhhcyBmb3IgYWxsDQo+ID4gPiBkZXZpY2VzPw0KPiA+DQo+ID4gRnJvbSBteSB1bmRl
cnN0YW5kaW5nLCBMMVNTIG1vZGUgaXMgY2hhcmFjdGVyaXplZCBieSBsb3dlciBsYXRlbmN5DQo+
ID4gd2hlbiBjb21wYXJlZCB0byBMMiBvciBMMyBtb2Rlcy4NCj4gPg0KPiA+IEl0IGNhbiBiZSB1
c2VkIG9uIGFsbCBkZXZpY2VzLCBhdm9pZGluZyBmcmVxdWVudCBwb3dlciBvbi9vZmYgY3ljbGVz
Lg0KPiA+IE5WTWUgY2FuIGFsc28gZXh0ZW5kIHRoZSBzZXJ2aWNlIGxpZmUgb2YgdGhlIGVxdWlw
bWVudC4NCj4gDQo+IEFsbCB0aGUgYWJvdmUgYXBwbGllcyB0byBhbGwgcGxhdGZvcm1zLCBzbyBp
dCdzIG5vdCBhbiBhcmd1bWVudCBmb3INCj4gaS5NWC1zcGVjaWZpYyBjb2RlIGhlcmUuDQo+DQpI
aSBCam9ybjoNClRoYW5rcyBmb3IgeW91ciBraW5kbHkgcmV2aWV3LiANClllcywgaXQgaXMuDQo+
ID4gPiBJcyB0aGVyZSBzb21ldGhpbmcgc3BlY2lhbCBhYm91dCBpLk1YIGhlcmU/ICBXaHkgZG8g
d2Ugd2FudCBpLk1YIHRvDQo+ID4gPiBiZSBkaWZmZXJlbnQgZnJvbSBvdGhlciBob3N0IGNvbnRy
b2xsZXJzPw0KPiA+DQo+ID4gaS5NWCBQQ0llIGxvc2VzIHBvd2VyIHN1cHBseSBkdXJpbmcgRGVl
cCBTbGVlcCBNb2RlIChEU00pLCByZXF1aXJpbmcNCj4gPiBmdWxsIHJlaW5pdGlhbGl6YXRpb24g
YWZ0ZXIgc3lzdGVtIHdha2UtdXAuDQo+IA0KPiBJIGRvbid0IGtub3cgd2hhdCBEU00gbWVhbnMg
aW4gUENJZSBvciBob3cgaXQgd291bGQgaGVscCBqdXN0aWZ5IHRoaXMNCj4gY2hhbmdlLg0KPiAN
CmkuTVggUENJZSBwb3dlciBpcyBnYXRlZCBvZmYgZHVyaW5nIHN1c3BlbmQsIHJlcXVpcmluZyBm
dWxsIHJlaW5pdGlhbGl6YXRpb24NCm9uIHJlc3VtZQ0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQo+ID4gUmVtb3ZpbmcgdGhlIEwxU1MgY2hlY2sgYWxsb3dzIHRoZSBzdXNwZW5kIHByb2Nl
c3MgdG8gY29tcGxldGUNCj4gPiBzdWNjZXNzZnVsbHkgYW5kIGVuc3VyZXMgdGhlIHBjaS0+c3Vz
cGVuZGVkIGZsYWcgaXMgc2V0IHRvIHRydWUsIHdoaWNoDQo+ID4gdHJpZ2dlcnMgdGhlIHByb3Bl
ciByZXN1bWUgc2VxdWVuY2UgZHVyaW5nIHN5c3RlbSB3YWtlLXVwIGZvciBpLk1YDQo+ID4gUENJ
ZXMuDQo+IA0KPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiBGaXhl
czogNDc3NGZhZjg1NGY1ICgiUENJOiBkd2M6IEltcGxlbWVudCBnZW5lcmljIHN1c3BlbmQvcmVz
dW1lDQo+ID4gPiA+IGZ1bmN0aW9uYWxpdHkiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyAgICAgICAgICAgICB8IDEgKw0KPiA+
ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8
IDQgKysrLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmggICAgICB8IDEgKw0KPiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IGluZGV4IDgxYTcwOTM0OTRjOC4uNzkwMmQz
OTE4NWE1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMNCj4gPiA+ID4gQEAgLTE4MzEsNiArMTgzMSw3IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVf
cHJvYmUoc3RydWN0DQo+ID4gPiA+IHBsYXRmb3JtX2RldmljZQ0KPiA+ID4gKnBkZXYpDQo+ID4g
PiA+ICAJCWlmIChpbXhfY2hlY2tfZmxhZyhpbXhfcGNpZSwgSU1YX1BDSUVfRkxBR19TS0lQX0wy
M19SRUFEWSkpDQo+ID4gPiA+ICAJCQlwY2ktPnBwLnNraXBfbDIzX3JlYWR5ID0gdHJ1ZTsNCj4g
PiA+ID4gIAkJcGNpLT5wcC51c2VfYXR1X21zZyA9IHRydWU7DQo+ID4gPiA+ICsJCXBjaS0+cHAu
Zm9yY2VfbDJfc3VzcGVuZCA9IHRydWU7DQo+ID4gPiA+ICAJCXJldCA9IGR3X3BjaWVfaG9zdF9p
bml0KCZwY2ktPnBwKTsNCj4gPiA+ID4gIAkJaWYgKHJldCA8IDApDQo+ID4gPiA+ICAJCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gaW5kZXggYTc0MzM5OTgyYzI0Li43
MjAxNTRmZDRmZjAgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gPiBAQCAtMTIyOSw3ICsx
MjI5LDkgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZQ0KPiAqcGNp
KQ0KPiA+ID4gPiAgCSAqIElmIEwxU1MgaXMgc3VwcG9ydGVkLCB0aGVuIGRvIG5vdCBwdXQgdGhl
IGxpbmsgaW50byBMMiBhcyBzb21lDQo+ID4gPiA+ICAJICogZGV2aWNlcyBzdWNoIGFzIE5WTWUg
ZXhwZWN0IGxvdyByZXN1bWUgbGF0ZW5jeS4NCj4gPiA+ID4gIAkgKi8NCj4gPiA+ID4gLQlpZiAo
ZHdfcGNpZV9yZWFkd19kYmkocGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NUTCkgJg0KPiA+ID4g
UENJX0VYUF9MTktDVExfQVNQTV9MMSkNCj4gPiA+ID4gKwlpZiAoIXBjaS0+cHAuZm9yY2VfbDJf
c3VzcGVuZCAmJg0KPiA+ID4gPiArCSAgICAoZHdfcGNpZV9yZWFkd19kYmkocGNpLCBvZmZzZXQg
KyBQQ0lfRVhQX0xOS0NUTCkgJg0KPiA+ID4gPiArCSAgICAgUENJX0VYUF9MTktDVExfQVNQTV9M
MSkpDQo+ID4gPiA+ICAJCXJldHVybiAwOw0KPiA+ID4gPg0KPiA+ID4gPiAgCWlmIChwY2ktPnBw
Lm9wcy0+cG1lX3R1cm5fb2ZmKSB7IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gPiA+IGluZGV4IGFlNjM4OWRkOWNh
YS4uNTI2MTAzNmJiZTZlIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gPiBAQCAtNDQ3LDYgKzQ0Nyw3IEBA
IHN0cnVjdCBkd19wY2llX3JwIHsNCj4gPiA+ID4gIAlib29sCQkJZWNhbV9lbmFibGVkOw0KPiA+
ID4gPiAgCWJvb2wJCQluYXRpdmVfZWNhbTsNCj4gPiA+ID4gIAlib29sICAgICAgICAgICAgICAg
ICAgICBza2lwX2wyM19yZWFkeTsNCj4gPiA+ID4gKwlib29sICAgICAgICAgICAgICAgICAgICBm
b3JjZV9sMl9zdXNwZW5kOw0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gIHN0cnVjdCBk
d19wY2llX2VwX29wcyB7DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMzcuMQ0KPiA+ID4gPg0K

