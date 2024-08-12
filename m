Return-Path: <stable+bounces-66395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C194E48F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 03:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC026281093
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CCF54F95;
	Mon, 12 Aug 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cyh0gI6o"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F7136328;
	Mon, 12 Aug 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426995; cv=fail; b=lKGA5CkJd8jFXh1OBBvUZJ8+4wRrQCrd+M85JJ/6B2YiJ2CazfoFQOfu7vxTWbvFO4U49GRo9GydHUCpVRUeaADMYgTjiomL0GzB79Y24cM9Ex1A8Ss8lv5zkdlCcxrr+Z20C3q5xefiBxiD3cVX/nQXMTiWfOH5oFBDHIWnUrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426995; c=relaxed/simple;
	bh=v3Ic3uJXLhsc2os90c9IfYcveK698cgRBJKXHZhvKV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rVZpiDHZPqdc16p05fGZ2xBESy9fdoRqNULb08woDCz/6VK85ZavvG+ZA7ZgTGPimMijG0GyKgl7NHo9nXyVuK3Z04EPB25KOcjNFI7DS63JsTYQsSsV1WPhuvYdNb2ci/jSwjVPxH16+4M7UbVPxD7TeUyPw+fbxRV2CDYRgOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cyh0gI6o; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWkjmAtHio/t1rt6PweH5R26ub3I0/dZnxMQCbxRQHdzorlbgXSTDvMCwerqlOXjSQDOoznj6q5nVExsZZ48hCswbvpBdHxF2AlLCCeGBJVg2q2o9EwLKGLjKypccbtkzZgr1ew+32Uhd1kX9EfuOVpn0eInDeqJ+4L+dwD2iSjiF4QHUBJ8fJEFbW/69gm0fPaFbfk/RoogKYHmtnx21NfBH7FdyF+6jWrcQ4el/steq3bk4vj74eln+AqUbPUOImTNTkokeHKLBd+K3GIlo/F3DxFFsDeVxCJsUm4tOgOPNeIGCZg/LjFwBnqouVxWnNj1y2Fy/pB5ZouSveCmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3Ic3uJXLhsc2os90c9IfYcveK698cgRBJKXHZhvKV0=;
 b=xybjBbhbdz5FrHJVHVHseaZ8rLoJdHEIqjDWLGtQ4F9Ex5a7ChziY4f0Bw94cuypM38De/twHWuQOd7ecvOal8AHcvBgmk6Y4IRsEExscONZPc7jMVw9PnIrku3WcNwkoYoyzEUOR6qUisku4ghAi4ksCfVed2hmsdN/wc/qDivRd/08DClFeqt+CrKUgtV1Tytj50wgX1lQPDTT5G/bUTMsIcVUJhZZ8gdlga1GF6IsUjf2YL4IrdiPWQ25fbvK8Qh15lYNWpz7pvrhGzEGI4L17yuzDqyrkg2UZAcuP3BzA1TDi11y97nSgXRMWyhu1C/7/QAY3nEvdmDQz9c0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3Ic3uJXLhsc2os90c9IfYcveK698cgRBJKXHZhvKV0=;
 b=cyh0gI6oBfxWCQMQW/jve4qBZVLPQLNGh2VpySdqGhIUhK+sNJzL5g2J3ABKAXBGR0PsD50nH8Umy67X+w+3kwU1b1KH3Qmkpk/FhVCxYvq5QXfmI2x6IKtyqeoH6ri6XAWpbQnuY0JaaNxBU2lh3QGhJHwepDXogYi0S5SDqSE60TBApLOtBST7Jj19tpncFrB9XaGhKVNzwgFUBYecFflb1Ko2T7tIGg33yBXARHq6AjZpt93w5BAAjHPuFhcsWl8VLdaXvpp7EQCf3A5cdDOp+d2y8uCYhp2IJwfLbfjGbFEwtsYTE8j2+Gj5eD+NsjKrYg9E0vuKyUy2ZcxDtQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 01:43:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 01:43:09 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Thread-Topic: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Thread-Index:
 AQHa2aEYMAHnp4ur4EKNGMJk8l3hQbIEgLWAgA7NqZCACTJ0gIABA1qAgAAnWoCAAQ7C8IAAV+gAgAPr9TA=
Date: Mon, 12 Aug 2024 01:43:09 +0000
Message-ID:
 <AS8PR04MB8676BCBCCAF583CF8907D48A8C852@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZrP2lUjTAazBlUVO@x1-carbon.lan>
 <ZrTQJSjxaQglSgmX@lizhi-Precision-Tower-5810>
 <ZrTxJzmWJyH2P0Ba@x1-carbon.lan>
 <AS8PR04MB86765DB41F64B3FBF3DAFCAA8CBA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZrYeBu7XbqmOc0ef@x1-carbon.lan>
In-Reply-To: <ZrYeBu7XbqmOc0ef@x1-carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8008:EE_
x-ms-office365-filtering-correlation-id: a73fe4cf-9dc4-4407-7047-08dcba701f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?eHc5RCtEQVBhM0F1d1V0WFZmNHVROGpHZk1vQmtjdWFJZ2lBbEhGTUlXL2g4?=
 =?gb2312?B?Y1Q5RXY2QmxPNjFvMUxmb2JWV3Z1YWJURDJSSmgrckt1ZUNyUU9ROWE4QzRx?=
 =?gb2312?B?SXFBNzRmL2N3K1NVb1cwRnkvZDJrZnI5WTdoSzZyNHNHU1hmWjM0ajhGM0o3?=
 =?gb2312?B?Z1JFZlVSNkxpRTg5bk1OemVQUXZ2eTU2N1FwbzVaVExLOE82amd3TlF4dzFP?=
 =?gb2312?B?MmErbXhlRkZaV1BGTExhZkdCSTlLZmVHajVCTkJMYzNFQTNsZG5tQklGYWRD?=
 =?gb2312?B?WUwvTE5UQ00yZ1BOU1dFdTVoSDRzblVoQlZtcE4rVDZnWHpzWU5LL0dDdUVR?=
 =?gb2312?B?UzJGcWRBZ3BjVTNBNGs1V0tBSkVMVU55NjN3Y2ZUSWlNRmF3c1MxZ0VxYndm?=
 =?gb2312?B?ellyVVN6TUZLSWxzZlVCbVQyWXlaZ3V0ZDk0ZWJkanpkS2ptQmF5NjlwN2Nu?=
 =?gb2312?B?L0dhalNlaGtBek5UazJtSWVjakxZZ2NjVU8zWXB1cGxGZ21Cc3YwYkRzK0J3?=
 =?gb2312?B?QUxJVllpUXZ4T2xQMzZsQ3d5b0JpK21CMVRURDlnQmJyWE56eXg0aHkzUDgr?=
 =?gb2312?B?UGdqb1lhMFkybUJHMEZzM1JpejlROXFORjYxRHVtUEt1c3ZzbVIzR3RDQUE1?=
 =?gb2312?B?VXhyanBTOGNDc2lpRHRnb2Iray9XZnh0ck5Gcm9ieUw1OER2VnBPa1dNMkVL?=
 =?gb2312?B?SWZ4bjJmclhxV24vNm5VQUNobVYyQ2ZiQUc0aysrZjJrT09ydGVPUThaZTJ3?=
 =?gb2312?B?cC8zQ2I1ZWhBMTg3a2tJWHBXOGVMaGl5QUlyV2J2U3EvQk1CRjVZOWUwdWFj?=
 =?gb2312?B?QTI0UlltbksreDJ3aFN4eHVRVnUzZEdOQUhyc2gyczV4WlRvYTQ4b2ovNU44?=
 =?gb2312?B?cWxWbkp3dXRTY04yYnJtZzRkbmJwUXN5U1UxTjZpZ0pQTkhVeElpcmdOTVV0?=
 =?gb2312?B?VDdJcHBjaEdQTXoybHBGMHNUMmNhQkxTY29pTGs3Wm5ZR0tVcU5xZ3R1by9S?=
 =?gb2312?B?OVFOSlZaTTk4RzBMVDhrei9zNTl0Wm90ZGtXdmI5R1ZldEsweVJuL3pGWklv?=
 =?gb2312?B?L0JseWVRSHRPdkErRndyWTBjZE1HLzMvdTVKa01IWXJ2V05UUkxJTGFVeklk?=
 =?gb2312?B?emtiQ293Vk96bUk1aGtZRlUzYlM3dnVnY0NnSDRSU1JtSzRsa0tEWmMxeDdS?=
 =?gb2312?B?anNGVTdvTVMvaGtWNkJkVmxnZURLNFdUMlo2c25xdjV6UkVYdk5VYVMvQlgz?=
 =?gb2312?B?QXZLUjJLL3BGTk1oTW5mY1dDU3lhV3pFQ0xua1hrVlVTaE1Bd1E1MkdVMG5H?=
 =?gb2312?B?cmQ3eVNBWDZGVkFwTnQ5empLSzhVcUpxbk84MzJGeUYzdURLcnBMQndzVzhj?=
 =?gb2312?B?eG1NZ0NxblNkRXc4TW5rWmxRM2NHOFJxSUVHcUV2cklPdGlOUEtacXV0RGsz?=
 =?gb2312?B?NWpqajQrZTJHSUR3aGlHcXB3Rk1EZmM5WWtwVUJ2ODF2MjNDZkVLQTRoWWc0?=
 =?gb2312?B?R3RoVmU0NDZod21JdWdqWDAyQmQ4NGNVOWRwbHlqNG1pVWhzTmtDWGJjaWhu?=
 =?gb2312?B?cVR2clB5SWY2MUNWcHdYTDhSQUJkcVUvczBUNjNQNnpZZDNCSFV6dE0xKzJY?=
 =?gb2312?B?RVhJMHdsU2trb284T1BFKzJNNzA5T3BrV1U0ZUZzSXVGZXhrYm5Ud3QyM2U3?=
 =?gb2312?B?bjhOM0loR2kwWTlQaWF3bk5qUE9RbXVkSnhYakpyVnZvTTQ1WWZNMEZsODk2?=
 =?gb2312?B?a0NNbGhhZUZiaHU1M0lsRHg4dE50aTQ0Y3NER2c0blBpUnhKQ0UyZTJSL2FQ?=
 =?gb2312?B?L0VJVzZFUkVvZ3hJckprT01kVEh4UG9PejlpWjFreVBNcWhpR0xUNklQTDJq?=
 =?gb2312?B?Z3hjMnNjMnJ0dGZLaHBlcUxtZlZLekQ2K05ENVRDYzVCQ3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cWhlTWp5Tmt4T1Z1Wnp5Uk81OXBiSW5PNjJvclUyQ29TZ003a2hjeTRld1Nx?=
 =?gb2312?B?T2lJM201WVVqc0hTQ0JjZGFvek13YUs2TWViek5kTHJJWkR4WTJhSzMwTE12?=
 =?gb2312?B?THNBdzJsWURqTGU3ckFuMXhoN0FYZE9pV3k5MTZMQ29ud29iTFphc1kwWWpV?=
 =?gb2312?B?dS9kalVSdnUzQ0VRRmdwQWJUVFdXenRZbkRwMTFsenVCeS8wc0l5MEFTRUtW?=
 =?gb2312?B?bHNnRUFRYUNzR2w3WDYwZm5wcTQzQ000MTUxSy9FSG5pOVpUK3ZubUF4SUJF?=
 =?gb2312?B?TEwwVjdBWGZRRFZwUFhrRW5pTDVmZ1dWQjJJaFdXb0JXSzI2VHhUbTQrZ1Zk?=
 =?gb2312?B?RGFuNFlWZWMrOWdUeTJSRC9vUndyTHBmOWIwa2E5cmZ6ZDh6d3JPNVY1UEFO?=
 =?gb2312?B?VWRhSENHMHdCeFJjN2JXNFRzRVJZMG9KNnJLMWJKend6dkxXTTNRWnltbzNk?=
 =?gb2312?B?RWZDbkwvc1Jna0ZxWmxZMnVTWkMxcjdhQlJyVHdFb2ZxRWhWNlVuNEIrVEsr?=
 =?gb2312?B?TnE0elUzTmR1MkFjMkhEcEdkODFxTi82Wk0zaEhiMWhjczNFbk45RUQxM0lp?=
 =?gb2312?B?eUNTaEZnN2lMbWkrTHg2cFQ5S3YwTEpBNktkbldtVmw4VUcrMW44YmIvemxV?=
 =?gb2312?B?Skp4Rkh3Nytxbk4wdE9Db3o0UjgxZVBGb2J3Z0M2SDc5dUxnRE9QZmJEOG5u?=
 =?gb2312?B?YzgxR0hwYVZBUjFvRDJqcW4xdldCZ3YvMm83c3o4RDUxU1RsaGZqajczb1Jo?=
 =?gb2312?B?VTk3aHRJcnFmOEFvb2hla1V6NW11S1hTaW5ZekxKMGRuT09KTWJXbDFaais4?=
 =?gb2312?B?QnF6bGlrQUhMZzEyeGt6NzE3NlM0L0hCU2ZrSTdWVVNTN3RXcDhTOTlTVlVK?=
 =?gb2312?B?c0NTNkg4RmFGRkxQMnFmSjJLd0hudE00dmVXamc1clpKODZVcGkzc1ozdmNv?=
 =?gb2312?B?YkJnRDBCMWhwcE05Y21iYVZleG1lUFQyeG81elhUZXdyVGhLZ3FPbTdXTXc4?=
 =?gb2312?B?bkZVZUFubm9qdEJuam5pTzRqNFphUDB3OVh4RDhHZU0xNFA2bHA5cWt4RTFQ?=
 =?gb2312?B?alNrUDE0a29wT3JpNXlXTmxjTVRRSjI5bFJ3dkt6RCtaZ2I5NlUvWEdiOG5x?=
 =?gb2312?B?SjZLVHpqT3M5dnV2VFBzWlhocERjb1F1eEplcGQwelFXS3hOS3p5anMyNERi?=
 =?gb2312?B?ZHlCWDZYdG9icEl5K0dLU3ExY2hyQVB5NExLNkJuTTJ0SUpCMTJlMkZld2RV?=
 =?gb2312?B?ZmZRN0NLZEFmK1pUZEN6bUdtMU5GNDBCQ1pwK3lnMit4WlhrZjloZm0veUFk?=
 =?gb2312?B?RHVObURWY2VKZDJDR3Aya0Z2K29acXlkOWFqeitPcCtsdDVXTDYrSFhlSEc1?=
 =?gb2312?B?eTllTExIa2pCWDRWcWZIb1hFWnRTVkdJUUVOZFVBRUVpUEppaXdLRkZyY3lp?=
 =?gb2312?B?MGpqUVVrWGZLTVEwQk84VTV1YjkvOGs2NGhpRXJGRlQwdG5xWjBLRWh3YjhY?=
 =?gb2312?B?OXh5N2ZjTnh6Yzdmazg2ZWtuZUc2QlVoNlBWV2lkZWJFdkJyMUVqOHlISFZU?=
 =?gb2312?B?NmtXbFlZUTRrRDVrWnN3WTVOMkRTeldsRUFnUlBMRkxPME1ISDhGazlPK0dC?=
 =?gb2312?B?V3lSYUIvbC9LM3AwZ3h3akw4T3NPYklNL0NWdXNMZUpWZS8yUEk5VnBqL2cr?=
 =?gb2312?B?U0ZrZkFMUTdMUWh1a25vMnVicjVDWlpJQ04zeUFZc2Vrb2tYRnZmbjdyc1Jq?=
 =?gb2312?B?eCsvMERTczZqNDVoZ0ZHZTFBWkxuY1Z0cER6QzlxcEx4LzYxdnN6cGNxaytN?=
 =?gb2312?B?MitwVHNlc2xoZXYyNjhMeUgzTGdNeitLQzRpRDl2VnVIdk1HY2wybUtSaWJS?=
 =?gb2312?B?ZGdYSmxhQlpiS2QrMVRzTnBvZXZLRzVCdjc1TzBYSTFIQitYSTBiT1Bnczg2?=
 =?gb2312?B?VklWbkt1RnBESDdtSWFPcnBvV2ViUGtKK0NpTGVyZTJyRnVRRDljOVhsMmlr?=
 =?gb2312?B?RlFhU0Q0dnFBUXUxWkQrNGNhS0dxNGhwYVFZQ1V4UWxDMjMyN0RVZm1aUU5m?=
 =?gb2312?B?ZXREV1E5QjBDWTVvWXhTWHkvS08ycUZMRGRBeHR5NkNrc2h1dXgycEcvYWhh?=
 =?gb2312?Q?7Gab8E4JSwLZ+fHlDLXrjuibA?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73fe4cf-9dc4-4407-7047-08dcba701f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 01:43:09.8760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5c3RF+lk9R2kXUdco0Cr2lw6bffimFQzpMIn1vdoR13NMjouSUm/xT4r8VYahzUyoJo/yP3ul0SjCz9EjayYWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgQ2Fzc2VsIDxjYXNz
ZWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqONTCOcjVIDIxOjQ4DQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54
cC5jb20+OyB0akBrZXJuZWwub3JnOyBkbGVtb2FsQGtlcm5lbC5vcmc7DQo+IHJvYmhAa2VybmVs
Lm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1
b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51
eC5kZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQv
Nl0gYXRhOiBhaGNpX2lteDogQWRkIDMyYml0cyBETUEgbGltaXQgZm9yIGkuTVg4UU0NCj4gQUhD
SSBTQVRBDQo+IA0KPiBPbiBGcmksIEF1ZyAwOSwgMjAyNCBhdCAwODo0NToxMkFNICswMDAwLCBI
b25neGluZyBaaHUgd3JvdGU6DQo+ID4gSGkgTmlrbGFzOg0KPiA+IFRoYW5rIHlvdSB2ZXJ5IG11
Y2guDQo+ID4gSSBoYWQgYWxyZWFkeSBzZW50IG91dCB0aGUgdjUgc2VyaWVzIHBhdGNoLXNldCBh
IGZldyBkYXlzIGFnby4NCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjDQo+ID4NCj4gaHdvcmsua2VybmVsLm9y
ZyUyRnByb2plY3QlMkZsaW51eC1hcm0ta2VybmVsJTJGY292ZXIlMkYxNzIyNTgxMjEzLTE1DQo+
IDINCj4gPg0KPiAyMS0xLWdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodSU0MG54cC5jb20lMkYm
ZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbg0KPiBnLg0KPiA+DQo+IHpodSU0MG54cC5jb20lN0MwZGJk
ZmUzZDExM2E0Y2YyZjk3MzA4ZGNiODc5ZTI3ZiU3QzY4NmVhMWQzYmMyYg0KPiA0YzZmYTkyDQo+
ID4NCj4gY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4NTg4MDgwODMwMDE4MjI5JTdDVW5rbm93
biU3Q1RXRnANCj4gYkdac2IzZDhleUoNCj4gPg0KPiBXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MNCj4gMCU3Qw0KPiA+ICU3
QyU3QyZzZGF0YT1Ia3Jnc3BqT2s1bGdrJTJGOG8lMkYyaFE0UlY4NkVWWlZLYnVRTTIlMkZlYVpn
Qg0KPiBDbyUzRCZyZXNlDQo+ID4gcnZlZD0wDQo+IA0KPiBXZWxsLCB5b3VyIFY1IHdhcyBub3Qg
c2VudCB0byBsaWJhdGEgKGxpbnV4LWlkZSkgbWFpbGluZyBsaXN0LCBhbmQgbGliYXRhIG1haW50
YWluZXJzDQo+IHdlcmUgbm90IGluICJUbzoiIG9yICJDYzoiLg0KPiANCj4gDQo+ID4gQlRXLCBJ
J20gYSBsaXR0bGUgY29uZnVzZWQgYWJvdXQgIiB3aXRob3V0IHRoZSBwYXRjaCBpbiAkc3ViamVj
dCwiLg0KPiA+IERvIHlvdSBtZWFuIHRvIHJlbW92ZSB0aGUgIlBBVENIIiBmcm9tIFN1YmplY3Qg
b2YgZWFjaCBwYXRjaD8NCj4gPiB2NToNCj4gPiBTdWJqZWN0OiBbUEFUQ0ggdjUgMS81XSBkdC1i
aW5kaW5nczogYXRhOiBBZGQgaS5NWDhRTSBBSENJIGNvbXBhdGlibGUNCj4gPiBzdHJpbmcNCj4g
PiB2NiB3aXRob3V0IHBhdGNoIGluICRzdWJqZWN0Og0KPiA+IFN1YmplY3Q6IFsgdjYgMS81XSBk
dC1iaW5kaW5nczogYXRhOiBBZGQgaS5NWDhRTSBBSENJIGNvbXBhdGlibGUNCj4gPiBzdHJpbmcg
SWYgeWVzLCBJIGNhbiBkbyB0aGF0IGFuZCBhZGQgRnJhbmsncyByZXZpZXdlZC1ieSB0YWcgaW4g
dGhlIHY2IHNlcmllcy4NCj4gDQo+IEkgc2ltcGx5IG1lYW50IGRyb3AgcGF0Y2g6DQo+IFtQQVRD
SCB2NCA0LzZdIGF0YTogYWhjaV9pbXg6IEFkZCAzMmJpdHMgRE1BIGxpbWl0IGZvciBpLk1YOFFN
IEFIQ0kgU0FUQSBhbmQNCj4gc2VuZCB0aGUgc2VyaWVzIGFzIGEgVjUuDQo+IA0KPiBCdXQgY29u
c2lkZXJpbmcgdGhhdCB5b3Ugc2VudCBhIFY1IGFscmVhZHkgKHRvIHRoZSB3cm9uZyBsaXN0KSwg
cGxlYXNlIHNlbmQgYSBWNiB0bw0KPiB0aGUgY29ycmVjdCBsaXN0LCB3aXRoIFJldmlld2VkLWJ5
IHRhZ3MgZnJvbQ0KPiBWNSBwaWNrZWQgdXAuDQpJdCdzIG15IGZhdWx0IHRvIHVzZSBhIHdyb25n
IHNlbmQtZW1haWwgc2NyaXB0IHRvIHNlbmQgb3V0IHY1Lg0KT2theSwgdjYgd291bGQgYmUgc2Vu
dCBvdXQgdG8gdGhlIGNvcnJlY3QgZW1haWwgbGlzdC4NClRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IE5p
a2xhcw0K

