Return-Path: <stable+bounces-237700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEBjMBWe3WmZggkAu9opvQ
	(envelope-from <stable+bounces-237700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:53:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481153F4D99
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B379D3028F5B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60F26738D;
	Tue, 14 Apr 2026 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TO4aX9KL"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BD247DE1;
	Tue, 14 Apr 2026 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131600; cv=fail; b=Sn5sv6BGR8ufLiQgkJXA5OtThsaLFtecz+QvptYrKqX7fDsPgOAXPiqnsZLKBMqaDjDuWlLdNlduUdlg24F2BHzzmOx/5nFDkJahC8fpk9ddR40UmHeBnBIuLBEl2aPVVZHJrqgl+ryPHKXvlTc6sqtpAylHURbfryuer4TvDsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131600; c=relaxed/simple;
	bh=Re2MmOLk6AzShp5sKpQpF062Q148rE4MoCWBi+1IHPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSdVgsyliZv/EVAIFcYsv9aWtkMTJw1uHbcvMtKQA6qYZAwhqE/SIaW+nEBJe+Z8CGDgH3tiJLE7WlWEVrPharjqj79z9ot1WFJ1RhTALiTfISd40ScPmuFpy/g36FsQMarmqgFRZsWS2tM905OMI+MLuvc0PNTRKgthApnqb60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TO4aX9KL; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+K3zFV1NHl1a4YLUYkurV1RNy0R88FjPZYnp6RW/cKc6Dr5e1roFq2wryetF58FT5gbEaDGCwrel51mKpSz4xNKH3/2Ga9FGsVHChW+Kl6t6NDbgYQ4E6G10ns8rokHjnJ9UWARzvY2IADHFtTvzeWlZ22gZjsyNbaQ4PBTiKviSB99YCMjLcDoQFbJzh7AzpQoxZ2zhHgSbg5NSwHU5Kl8+xni1R6PUNPn7rgOTHqIDj0zjDJguTLd8YWIGebHFViZK5YQvT8jVLaCPvHKVA36pCQl0bg4rlP5tR/Q69qaprdM8sBQmokvRGqW1oR+RMIoYg8i5o0CUDw2pEp0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re2MmOLk6AzShp5sKpQpF062Q148rE4MoCWBi+1IHPw=;
 b=N1cslxPyUG48mAjWvUPDX57DOISv7pPGCObLN4Axe+EZ8F/kao0nZooaRNnD6g94prJPdUZ1W5BtqbcEN4MCgAwBLBhbiT5ig4wCESd04XmTXMwB+Paw+Wm3aXT1MJAaSP6z63KGcXIGfDdmtTKB4Dci1QIkjo/RAhSYCIfFFd0lWPk75IbORG0hpKlHXH3lMOltxBK1JLulb6aqEXfKBmID4hgoLNih1OMrWv6cxuuo/fNMTjffSm/WOo4tJaXzixwkbStocVyVi2uAjH0UoY5WBytOY5ieKwavxH+4Rcq7KYxLixO9WS7t9ql2jEavViPOBatCLnGTnSXpGstWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re2MmOLk6AzShp5sKpQpF062Q148rE4MoCWBi+1IHPw=;
 b=TO4aX9KLZHF0BwlYVKe580GrpjEBvtC0n50rqHChcE1TYUNjpfSlC01vOCag5jQt6eZ4IZNDvPncXkIcLhoUJwhLpmvXEA5kU2gOLdbnjrj+JSW4IOMVywa2C1EQWlCBLFyjw3DZsxSHe7BrnCPGmbvsqC767glxgMOqs9b48Nw5FvGdRRzSjekuWH/4I1T1a/YtXX5yVajWt5Z+NXm48d3xuTK1Bb35C42razL+iP4ZdgXsekJl+znK/8mf+vPkqXEUWo66f1KZTY7QwZXtWGW2bFq5NYNtWEauFHMPwhZ1Um+hvyN5HR19rZb+IZ1Yab7B7orJWTnDa8JH1+hiNA==
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 01:53:15 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 01:53:14 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "mani@kernel.org" <mani@kernel.org>, Frank Li <frank.li@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "l.stach@pengutronix.de"
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
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Topic: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Index:
 AQHctdXR4rMaQwHMbk+Nxv/9or4V47Wy+e2AgACXyCCACSXqAIAAPoUAgBC1qACABVGiIIAAVfmAgAExgtCABIkrgIAE5WHw
Date: Tue, 14 Apr 2026 01:53:14 +0000
Message-ID:
 <AM0PR04MB5220457405E99187829BFEA58C252@AM0PR04MB5220.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB883374CBFD3C97CE54DFB4C48C5BA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20260410225341.GA598942@bhelgaas>
In-Reply-To: <20260410225341.GA598942@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5220:EE_|PAXPR04MB8288:EE_
x-ms-office365-filtering-correlation-id: 195b8eff-2367-4b17-44b0-08de99c8978f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 T20rQ27rvOQsrjO28P88Sk/NxCXAetCo9wLwZZwej8W3yZ1EdnxfZNbsvcwVhl/bpMDecsiZiNPurIPmrHkmsk6m859ib8meoZBclhLmCPp/kAgV85yKRJOfij/FMzBSoT9+soKPfLToehc9JId0E9x4wrPwuoU+cUTmPtHZJeb4NnQIRWnX1Qo7dD3G8ercDyPwJLvflvQHvydaoszEiORSwZW7Slv4SWIiPQcR/AJOSbZ4OR1wkBQJI+kuOYNjF8P31pzmahiV9/pDmELKA+79siSxiqRO32wb2pZeG6clEwlKj7b2orwI/3TkYCfJysRWw01Anck4ZJh9UWlASfZdR5c1Y2yvZOtCvm8TCDfie0QETiDOLIDxhiNm4P1X94NEOzOo/Cy8SzbtyYR1rYcakm0N3toj1a4v1pwO5nSTTApCRNydOJT7wqozdZf61YzsObB1b8DNUhA7k/QVVeJ8wDAeiguAVcBxFkJAUcmHpwthulCxXy8qtGo/oFbs7Y8NiNHNbfGN2bLEFHSzK07wfqlfcEFkeGhEvcVwIfZvECMPyJpDgjHoLciR4NddQvVwA6X/MfDSUGG1fPwegurx1Ca7zV4fP6lM3hkIhmld8GIi95GXi7yfNR4CTMiUIZIS1OTkmqFipzH0QB5KhpvRMw2ehKEmvwwhY2Dy98wJGX2yJeEyFu3HY42/nSoCs8g/hOAQZlkh+52RLSo+dCtKv/rTFao3Z5fcfVgu17N5a2pFyiBmsxQxBUVb90wie1UBInT0tzAnMSYnJYkdIBRrkUQn4vYBfVT6cYTnPsQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OGNUbCs3NHg5RzNHaWlFRlNKb2RVMlpNUy9CS1RIVDRiWFN1QzJTRnN1Tk1G?=
 =?gb2312?B?SUJjTjdKYkFQV09xajI2ZGZqMU9Ld3YydDlJNUxOTHJ0M2dPZDJ4UGY0MWg5?=
 =?gb2312?B?SWJRblA1UjY3RElqODNtOS8rUlUvOFBaa3QzVXFEM0EvZ2tkdkx5Z2QzSFln?=
 =?gb2312?B?a0RaSHhjYlpSaUpXdU9wZlVpWkxLZUJ2WnFQTnRqdm1JbENHT1NEY2w5Sncw?=
 =?gb2312?B?emFlQ1BCRi8ydnlNOFhRaHZoZXp1YTRBZVJ6SXdRNC9nOVBDa0ZHakRTRExa?=
 =?gb2312?B?WE80Szc2Wks0Szg3anhoZjR1SThrY2FEbUh3UUkwMUdNeVBHWENOZFo2QVlB?=
 =?gb2312?B?TWNINWl1enRWTDdBY3MxSWJTcVNzM0pjZzJYOVFOZ2ZoRmxHQWF0eUptdjJ1?=
 =?gb2312?B?aDAwSlNBWXZLTklGcHM2bjFZSHUwbnU5NWJzUW1yZW1QQzVKaGs1TENNWnZw?=
 =?gb2312?B?b3RPN3JEcUYxQU5RNjhRRk5CKzdxL05sZ2pZRUl5SWpLV1YycmFteUR3K0hy?=
 =?gb2312?B?UGN5NHBRUEVrYkhUenRMZWUwM2lET2xHOFRxSzQxQXJuNTJtM1pDbDE0cVAr?=
 =?gb2312?B?SENVVkNodUt0dmYvRkd2QVVlYXgyUnBtWVJJZk1MOWRrWWZ5YzUyZjNueUdM?=
 =?gb2312?B?cC9NQjlPRTFRWUZJNmVmZm8rYzdCa0NicFB2K1crNkt3L1lYSDFydndSdjJu?=
 =?gb2312?B?ak5xSEE0aFY5SlhwbDZYS0ZUR0JvME42S3l1ZmhLRDdGcUhpc1JVVEtxUXJL?=
 =?gb2312?B?RlhvNFBvUVdYRFBTZHlERWptTVp6Smt2V095UXdqOENFYkNSMjZXRDd0RVpk?=
 =?gb2312?B?Zy8zdzFseVBkQXhQSEtNeXJOZTV3S05NSW5NT1hNbzZmQ0MyKzFZOWh1U1A4?=
 =?gb2312?B?MnAyR0NibTl3aTNqKzhoS3JSYnM4SUpZNGFpSi9XZVVmenRkbHdrU2xOUkw2?=
 =?gb2312?B?TG1tNUdGaEQ2TnJnTE1tOC94MHRNR2xBOUhUbVczV2lteGhhNzJZTEJsOFkx?=
 =?gb2312?B?dHUvWWJvSzFSYkRXUnd0ZWd0bTk0bElVSDZ0eTFiT000WXNVdWh1SlFvcE9L?=
 =?gb2312?B?WHYyOS9JZ3NLOTlsT1BsSWpNeTZzUHc4U0RJWERpV0s3Q294OXU0aW9WZTdj?=
 =?gb2312?B?b0w2UjZzVzFwQnFTVkwzK0JBYXVvNnRDMDc5bzdsbXpUMXZYTFF1b3hLYjgy?=
 =?gb2312?B?Mm9wN3dXVTZmcGVUM25SMjZacGdoQXh2bm9yMG5JTlBoRlBlek9yZWdoeXhC?=
 =?gb2312?B?SVZ5bElmVDRsZXhnek9jdis1c29vMmRUYjJXcDBIbHpCeXpVUks5QjVISzdv?=
 =?gb2312?B?UUtCZEF5MjRSVHYzUTQ5Rm8xQXlsY2dENy9pSjYxcmtBazJseWxGTEw2aTFa?=
 =?gb2312?B?ZG9pZFFXNlpSWVNrbGpDMkFYMk9NQm10YURiYURLMzdFNTRrb2t4WFhXQVl6?=
 =?gb2312?B?UFJDaGJ4L2FnZk1wUUt1MjN6b0NRVGVvQnE0SW9FU3JiVElwYzFLczBwUDUv?=
 =?gb2312?B?MXZ1UUVyMmpGZnpHTGROclVEbFE0d2kwSk5JUTBtdm9HVHdBdTg4REluNXlZ?=
 =?gb2312?B?aFo3VGhBQlhYYnI2QmJmcWQ4NUxMOExmK3RTWWFLbjJZUDJxdVp0ZnNXM3ds?=
 =?gb2312?B?ZFNrQ0pORzB4UG9xbmFyZ3hzbldZZXBtaTgrcHF5MTVaT0pDKzRQOUU2L0lp?=
 =?gb2312?B?cWFhckUzTzV0WFhwNG9oeTQxY3Fic1BTZ3lZbzV3WmJsbzUwY3A2YkR4MUVY?=
 =?gb2312?B?aE1aR0paempmZ3dtcWVSYnYyL01ud1FqOS9GMGdtbTRUYXM4bm5HVDNDSnlr?=
 =?gb2312?B?NUl0Q1ZPS0JDNFRaSERZbWFvcWNSTVkxNWpPVEVlTi9tQlhKYytlcjdSS0w0?=
 =?gb2312?B?V3BMQ1hnZmpMU1lwY1RRTFBHZHpzenpRdU5pZitkVTZYWkhFS3IzZVRudEY5?=
 =?gb2312?B?MWdsUWQ2dUhPQUhQVG1oMXRqRGRmUHMvTGZxVG5ad25FMHJvTklxMlRuTnVr?=
 =?gb2312?B?TVFJOURiclFhNzM2cjM3WHpnK2RxVGU3R29aVHRYUTZTQml2aU1oZktZbWxD?=
 =?gb2312?B?NW1GdWxVdjRuSDBXWEYvb1VGeUFSTGs5UzIvVUtaanlJTzhERUJqejQvU0hF?=
 =?gb2312?B?ZzJqZ2dxYWUwL1JTc05MSGp6WDhBQWdlMFpiY1ZXOFBDMUxEL0R0dzZJVW51?=
 =?gb2312?B?ZW10NEdvaERlSjk1Q2NSSVJsTmlpV1A2ckxhRVVzTnR6K05EelJ4N0FRTEdS?=
 =?gb2312?B?OGM4TC9pbm9uMm1uUmY4dTFxcGhwSmhrNVB0VUdIZFJSK0xsRUdFdDQ5b0NW?=
 =?gb2312?Q?G/YagFN3PV2PjQgCux?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195b8eff-2367-4b17-44b0-08de99c8978f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 01:53:14.8031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DehFoIC54M6Ioy4PGkO2ZFDZJQjlvTJDF9aUOsYWRTB0FAf3ggKlVVLxE6hdMfT926Xe+giNVNkHKgmMljiJaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237700-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,pengutronix.de,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 481153F4D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjbE6jTUwjExyNUgNjo1NA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IG1hbmlAa2VybmVsLm9yZzsgRnJh
bmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBqaW5nb29oYW4xQGdtYWlsLmNvbTsNCj4gbC5zdGFj
aEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd2lsY3p5bnNraUBrZXJu
ZWwub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwu
Y29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MV0gUENJOiBpbXg2OiBBZGQgZm9yY2Vfc3VzcGVuZCBmbGFnIHRvIG92ZXJyaWRlIEwxU1MN
Cj4gc3VzcGVuZCBza2lwDQo+IA0KPiBPbiBXZWQsIEFwciAwOCwgMjAyNiBhdCAwMjozODozNUFN
ICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gLi4uDQo+IA0KPiA+IE9uZSBhZGRpdGlv
bmFsIG5vdGUgcmVnYXJkaW5nIE5WTWU6IEFTUE0gKEFjdGl2ZSBTdGF0ZSBQb3dlcg0KPiA+IE1h
bmFnZW1lbnQpIGlzIGRpc2FibGVkIGxvY2FsbHkgb24gaS5NWCBwbGF0Zm9ybXMgZm9yIE5WTWUg
ZGV2aWNlcy4NCj4gPiBUaGlzIGRlY2lzaW9uIHdhcyBtYWRlIGFmdGVyIGVuY291bnRlcmluZyBh
IHN5c3RlbSBoYW5nIGlzc3VlIHNpbWlsYXINCj4gPiB0byB0aGUgb25lIHJlcG9ydGVkIGJ5IEhh
bnMgYSBmZXcgbW9udGhzIGFnbyBpbiBoaXMgcGF0Y2ggbGlzdGVkIGJlbG93Lg0KPiA+IGh0dHBz
Oi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRmxpbnV4LW52bWUlMkYyMDI1MDUwMjAzMjA1MS45
MjA5OTAtMS1oYW5zLnpoYW5nJTQwY2l4DQo+IHRlYw0KPiA+DQo+IGguY29tJTJGJmRhdGE9MDUl
N0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0NiY2RlYzFmZmE1MTQ0Yw0KPiBkYzcwZWMw
DQo+ID4NCj4gOGRlOTc1NDA1MDklN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM5MTE0DQo+IDU4NDI4NjYNCj4gPg0KPiAxNzI0NyU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJdw0KPiBMakF1TURBdw0KPiA+
DQo+IE1DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0Ql
N0MwJTdDJTdDJTdDDQo+ICZzZGF0DQo+ID4NCj4gYT1McGFmcCUyRm8zbiUyRnpDQyUyRjlpd3h2
aVJkRlp6VDhhelFDJTJGelNqVGJBckRWOEUlM0QmcmVzZXJ2ZQ0KPiBkPTANCj4gDQo+IFdoZXJl
IGlzIEFTUE0gZGlzYWJsZWQgZm9yIGkuTVg/ICBJIGRvbid0IHNlZSBhbnl0aGluZyBpbiBwY2kt
aW14Ni5jLg0KSGkgQmpvcm46DQpUaGFua3MgZm9yIHlvdXIgY29uY2VybnMuDQpZb3UncmUgY29y
cmVjdCAtIHRoZSBBU1BNIEwxU1MgZGlzYWJsaW5nIGZvciBOVk1lIGlzIGN1cnJlbnRseSBpbXBs
ZW1lbnRlZCBhcw0KIGEgbG9jYWwgcXVpcmsgcGF0Y2gsIG5vdCBpbiBwY2ktaW14Ni5jLg0KPiAN
Cj4gSXQgZG9lc24ndCBzb3VuZCBhcmNoaXRlY3R1cmFsbHkgY2xlYW4gdG8gbWUgdG8gZGlzYWJs
ZSBBU1BNIGJhc2VkIG9uDQo+IHdoZXRoZXIgYW4gTlZNZSBkZXZpY2UgaXMgaW52b2x2ZWQuDQoN
CkkgYWdyZWUgdGhpcyBhcHByb2FjaCBpc24ndCBpZGVhbC4gVGhlIHF1aXJrLWJhc2VkIHNvbHV0
aW9uIHdhcyBhIHRlbXBvcmFyeQ0KIHdvcmthcm91bmQuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZCBaaHUNCg0K

