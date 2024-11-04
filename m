Return-Path: <stable+bounces-89597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311209BAC06
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 06:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99761F21ACF
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 05:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21FD16EC0E;
	Mon,  4 Nov 2024 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CgTl5hfJ"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D210F1;
	Mon,  4 Nov 2024 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730697554; cv=fail; b=CQstR8qLSMu7WSVOUkrY9zg0w7DESpRzxxoG0C0vx1Mz7Cnhbbm1JRpdk/XtuZttUH4USS2Sw6yAC8+3FJqR8abdQqY0HNkvKtqU1MBech9zBIEY+kQaW5pyMO2QWPnass1wVHG7sTTKZQ9M4/rhA8Fd9FqhZRu37c/2Is7vhp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730697554; c=relaxed/simple;
	bh=Gb1vWO0ViFYAzkHiEA4T4+ny6s4IlLt9dxYzuH6lWME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mzMnIueKcyY09a3TcPc4BferkIFssFjx0VkgoJo5oPN735NsLuFkSwguov31ijTVgLMe9D3n05WywbvwZjgwpTzY2euUoXhEf3TLetQ8p9bj9NEx218ehGjhAME57ytQcXOlOg+kAZonk0Yf1s3oJuhrTL17cFqXHCwI3oPPnbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CgTl5hfJ; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s26NoqTRzipiwbNJc/QavfcEFmxK1sGW2HBFJ04MBz8dRgyMnd+PJ9D39AWQT5ijzoaHkRPR/ILhknpLJv3FMbLnPe61YG2rU7tSZ/3gUKDLRnBPZRIdN8Mhieo1K+9VI9UOcajDGSSoGnATndzkF/Pr5jjaYKj6tmuF21pfYFakDc4b9Uow7E/ox33lUqIjYy/zBeP7aIzys9nrj91Ca9n3x209OxEfhInNpA0REMG1lSX/0Z71mEOoU8Oh8tsc2Bj9ALio4iOAjGt8UzWXzycXJK3EzWFyLRkSbdWuxNmiiXlrMRbv/BkRna7txMRd5BL3WPhFg+tG7lhN8W0QjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb1vWO0ViFYAzkHiEA4T4+ny6s4IlLt9dxYzuH6lWME=;
 b=jevVu30MkTPoia0f6JSJYxXPPfZUYLMHGnukkaB/PIBzOCmkoZhm9V/DdJnplZP4I11qP6RL/n6I6qMSCXi3sWH7dxBjTZB3fTGrZAiUa5giW58At9TO/zIYRFfE7ZR7KaOcaDejJZS4RJZlKyIePt8DvIvTYAEtJ7rJ+W9nNsTixOXrobFBue+1QGBVKnvW6IxTJ3ysAUY7GrgTw8PiEB0OMQgnQUzcYgqtDUzU2yXNzjZmY3gfFnoCkgDV5r6fVbe6l9khR3Ht68jVLgHEv9205MNr5H4lPBaGNIO7CwNfB02xN/iCTY7LJzeog/IHeHuen4uF9BJdkGt2vSAhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb1vWO0ViFYAzkHiEA4T4+ny6s4IlLt9dxYzuH6lWME=;
 b=CgTl5hfJo5Lrnhz2B8qs/ryHykwaWoK0E1DMna+Py81EerQDzMopsR0z5FsMoKuW1L6+ecL764tg6hTEATUATDtLoS9LOAZ+LqHUzTaiewKQuLeIS3Y6hlJzQQIaFp6nH24h5Vzf1kIcI9GSXqZ660yb0YKzmzkTMuqUx2Ne/yh17c4aIGgw6O49O6UgeGJca3pthrrndllWvkpaXQ4CcEqCtQ/9DGeotHSEg5olEvazi9VRS13Okb1rxN/fFd4k3A/7SEp0gvPohInDbWrcRJX1CQAKXklSOHxHjFcoYzC3/Lh/7cRx5KhMjhaXhDgqNHcekbnt0fH3i3SNjKwvmQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:19:08 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:19:07 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Adam Ford <aford173@gmail.com>
CC: Frank Li <frank.li@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, Marcel Ziswiler
	<marcel.ziswiler@toradex.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just before
 PHY PLL lock check
Thread-Topic: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just
 before PHY PLL lock check
Thread-Index: AQHbI9FMGl88WWAvnEe0gqFlzhKJarKSIYmAgBDGCoCAA5pOMA==
Date: Mon, 4 Nov 2024 05:19:07 +0000
Message-ID:
 <AS8PR04MB8676D33E00DE6B0B961B5EB58C512@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241021155241.943665-1-Frank.Li@nxp.com>
 <DU2PR04MB86770FFB0CAEEBE95B91F5FC8C4C2@DU2PR04MB8677.eurprd04.prod.outlook.com>
 <CAHCN7xJya+XjAP+kn5MePdrqNxaLnkYag23UaNatoh09ize+AA@mail.gmail.com>
In-Reply-To:
 <CAHCN7xJya+XjAP+kn5MePdrqNxaLnkYag23UaNatoh09ize+AA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB8171:EE_
x-ms-office365-filtering-correlation-id: c5e2201a-9971-4884-3a0a-08dcfc903547
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3paYzY3SEF5ajZCWS9KYk03Qld5RkZ0VW52a1pXRzFYSDhlc1hwdkpEbVo2?=
 =?utf-8?B?eW9wLzZuM3p1QVYwZ3lSb2JnQUlRT2M0M3N4ZlB0UGJzM0s0Z0JueG4yVHY0?=
 =?utf-8?B?MGlldm92ZUdMd1Y3Qm9ZSUgzTXhxcWtmb09CNmZmNHYweUpqbzBZSWM5SE00?=
 =?utf-8?B?K3UzUzdYaXJuNzIwcDlJdXRqSFV2TXBxNHNqUGRVcTVOdE5pSGg3T2plQ1JW?=
 =?utf-8?B?b3V0aHUvQWVZUjVWOG96YnJ2cEREa1p0R21pZlZrRk8reHUwT0dEckhFWjc2?=
 =?utf-8?B?UTNGM2x3Nkl4NTlNQXU2ZHNwSU9qOG1SdEFlclhLN1dBdE9KYmZ1L3NRdi9u?=
 =?utf-8?B?TG44WkNtcy9Mck9ZaEFWKyt2em1EdC9ZRUg3K01kdUJBbjBjTnUzY3I2eEQ3?=
 =?utf-8?B?OEJyU2Ivb0MzM1crZ1FLdkhLU2JrUTZmanZnNUFncG5sdnVVenRDc2xyYVlr?=
 =?utf-8?B?Yzd3Vk5qbW9ud2prV20rNlN4REVjMmZYNzY5WGxyYmVyUEVRdW5JRnVsZkV1?=
 =?utf-8?B?VzdsaFJzRzR6Rk1PVGRYU2ZIWXpwdVN5UjhaY01ERzNaUGg4d2dYNFRPdWZv?=
 =?utf-8?B?MXVEc3pMRXQvcEFnREpSRGFMdmZMQnhqY296ajhQRFlwUzBuWmhNcXMySDFw?=
 =?utf-8?B?Nmd4djd6d1hPRHl6R3VHNVBsVmEwTmlKR0gvWW00K0dBRCtrVkovOEpnZG5U?=
 =?utf-8?B?Ulc1T3ZtLzBEVkRRbFhZbHlOalNPQlJoanRndC95YURwQ2pna0dhSzUvV25o?=
 =?utf-8?B?U0YxWVRaaTE1Tzhiempldjd1eWxNRktOdlNVRmZnME1xNWE2bk1PbEJSU0tY?=
 =?utf-8?B?eGk4Sm5FbDhPN3dPUXZZNlFITy9KZ29uSmRYbEtXT3lCVUZZL2dZTklhKzVO?=
 =?utf-8?B?aTFyMXNPQldvTVF6NjVFZXhSN3lUak0zQWVmekhHRXNXVnVwRUF5dERENm40?=
 =?utf-8?B?N01VamVENC83SkdHbU02dXFjOVdzTVpMaXhMYWk5NDNJL1NLTmVLdFdidE52?=
 =?utf-8?B?RnZSdXYwRzhicGlLeGVSODVPRjY4eWN2NEd5WEtBdmx3QVArY25NaFNId0hk?=
 =?utf-8?B?WW9sWEtZc1ZjVmFzK2lqV0VBR2hnN3ducWRMRmlDMmhJd3JkdkIxQlVkV0NR?=
 =?utf-8?B?S1BUQUhYODVHUTVuMVhFTHZ6cE9acVB3Vk9TbEdDeloyU0pvVmxjVXg2bGRz?=
 =?utf-8?B?bHVieisvdTBLelVodWFOeW0zWTFiaUpsRDNQOVNLdFl4d016UDM2Rlo2K0E0?=
 =?utf-8?B?NHBKM3l3RlhqY2JrUWNDV1p5MmRpK1NjeTVZcjBiTnJiajJSWUdVMVBHWTBw?=
 =?utf-8?B?YjY4aE5qd3BDb0VwOVFrcHFkbjV1ZXhZVyswbHpZWExxWWlxL0xSSjN0Ymhr?=
 =?utf-8?B?eTRsTmJOdStVSlh2S0doM0VsQTZ5S045aDJwcmx6c3k5Zm43cjd1a3dZWkFr?=
 =?utf-8?B?c2Z6K2Q0Z1B0eHlPTjdZSnM0RUw0L1F0VEMvQjVldHBPc0NhTUMxcUpVZ0Ru?=
 =?utf-8?B?SklkQzZKRldqeEFyTkl6L3ZBb2tFTVVzRk9OU0V3NzBIcEkrNDhjU1VPQWZ6?=
 =?utf-8?B?TFpuZ0RsRVM4N2E1NVFOVkFhbzNPaHZtMlRScE00bk1PVWErNzBVNGNpQ3pF?=
 =?utf-8?B?djhEYUNLQjlXc3FWY3BPQkQ1bjV0cStmY0VkNnhTaTNZdGErVW9ic2RtMllh?=
 =?utf-8?B?aHowY2dNS3l1ajFFZEdPMFRsVlh0dkN3bUtPWTl5K3RGNXlCNitWZFB0SkV5?=
 =?utf-8?B?YU9GR25TRDlJVnlhV0tCbDNjanBraFhDRWlzSjZHQVRuZHNycEpWd1NaMzdU?=
 =?utf-8?Q?GJUM5qsiHgL1A8caepIVD4A4t9jNoJPfUK3Ho=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0pxL1JHWDdZa2d4Zi8zZzNyNTFhYStnR0dLaHNpYWRpVXVkZG5sWnJNQ0tT?=
 =?utf-8?B?Tm5vRllUUmhCZ0k5WjU5elVXTHNSemZTY2E4ZVE0bHR6eXc0QnJadkp3SEdI?=
 =?utf-8?B?Wmx1OFN1a3RHb3dnZDFIVXN5cVRoTGNyRm5tQ0V3VFU1TEhQL3BrQXlBTkIz?=
 =?utf-8?B?eXZBVTdhMjRQOGVuZUJXWFNKNGh0T0ZHZlUxNmQwZmtQUXN4UUtPOUtNY3Rz?=
 =?utf-8?B?MnI1a2NWSlpDeklRQ0VPV3RoanU1VXVKWXJ1NTFxMG5EQ002dXUyd1UzUVA0?=
 =?utf-8?B?MnMvT1JUbWtSUDN6alg2NVpQQ0JjcUlKaE1ZODFzVTk3V1Nwd2xuMEp3dnY5?=
 =?utf-8?B?YlVYUGx4eGcxUkd1ZENWRHduNFFIMWNaS2NvWWxrUU5uaFlobVVZN1dOdXNw?=
 =?utf-8?B?WHptSEg5MXhLUFd3ZXk1bzhyWEwrQmdGK3JqZVpuakxvZ3hCcmQwQXd6M3Y5?=
 =?utf-8?B?dWc2NUJaN0MwTnIzYk5pWVRpRDU2K0N3YzN0UlF2ZlRsYyt5K0l1Yi9SeTB6?=
 =?utf-8?B?N1hBZkpHOC9QblNtQjhocnozakFNNHR6TmxSaFdnU3B4bkFsQjRsVTZ0UTk5?=
 =?utf-8?B?SjJTd3lsUXltTWFnbGdtamlxT2hBZVE0Y3YwT3FXbE56cUEyUFk1K0hTYlJD?=
 =?utf-8?B?ditvQW1Ebi9EYjJKT0JBSGpHSHdNTDYxa21qMTVYckp2RUxSU0RvQkNZdUF0?=
 =?utf-8?B?cURwd0JraHJ3aWFqUm50NDRYTFhIMkwvZ0lralYrdzdjM0YvTlF6VG9aV21q?=
 =?utf-8?B?TDVkbjlvMTNJSCtCK2REbUNUNko4bzJKNGtlMmZ6YXdNVWxtUDJ3a05MNG1V?=
 =?utf-8?B?Y29zL24vZlRkYkczSkdwR2F3VlAwUjJ6N3IwOWNMcWpDRnk3a1VPVlozcC9t?=
 =?utf-8?B?R0dBRENTOEo0dmxMYmhwTFducXdtNHU5dmJrZHdRRzZWMGtWVGtZTkdrK0Ny?=
 =?utf-8?B?WlJTd0Mrck1nT05ENmxScTRJc0licTBYVkx3NzRPSStIbzI2UGczU29yS2Mx?=
 =?utf-8?B?dmNWaUNBaFk4dG5XSjJKRExTbnRKZkhYM1FGWEhTV0VwdmswNGltZWpwRjRO?=
 =?utf-8?B?cVRpUEhBYy9YUUQ5M3dNb3hUY2RYOFhvRXhmeFZoN1dOWVlFMmN0ZW56cUEr?=
 =?utf-8?B?enlZTjR5T0ZCcURwaENGWG14b3dJYTBZVHJwcVNpT1p0aEVqcUk3MW0rWmFI?=
 =?utf-8?B?TzM2bElKWXBYMVhXZFlEWk1iNjgxTndseERUeU1ac1FRZTN0bWYrTlFtTFl5?=
 =?utf-8?B?UkhyekhCTTVWNzUwUi9BYTVseWMxVUllLzJkbGdKK0E2RmcvRCs4M1g3Y2RZ?=
 =?utf-8?B?Q0FXYjFKeWpXU0JHWkU1bUNPS0E3Y3p3dkZoRjFZYTdBOVVhYXorN2xUQTJX?=
 =?utf-8?B?WWRhUjZ1THFBUlRGZVR3YXRNYWZCbW5qYjd5cWNKdURhc1FReGZ3VmZoTHFL?=
 =?utf-8?B?VEMwbUl0OGJoOGY4R1RxcnpNWDFMeVI5RGo3OFBFMzE3ckZhWkwvV09ZS1R6?=
 =?utf-8?B?TEdMMGx6TzBON0hpYTNZVnltQlJ3NklxTm9kazBBNU9EZHVXdFN3djVRRkwr?=
 =?utf-8?B?Mm03V0NmaFVucFFuT0dHcXpxRUhEZ2xUdHpaWW5tdW1tR2ZBc0lYREhNc2pp?=
 =?utf-8?B?SllFSFZ1aUY4UjB1Mi9aT2lpUTlDTHhXbW4rM2RTOElEN0ovRTZ2Ujl1aFRh?=
 =?utf-8?B?QUg3bTQ4NnNxSlZsazNjNHhwOE9aVis3SG5ROXFhaStzajk4c2d3YjZVZmtB?=
 =?utf-8?B?SzRZaG9GSW1uUGZLSEsrSVl6bHdtcHQrTHJ5eEw1K0NUcDFJbUFNeU4rbUdj?=
 =?utf-8?B?d2JycjhXN0tkL3JtWWRGWjh1Q3loREQrdU9aS0JnQ0x3YmVhbXE2Y2VTWlRy?=
 =?utf-8?B?VHJDNDMxZjJVYXRGV2dhS3o2MHJ2QVFmWWQxZ1cvbGhJWXI1NWpCem1wUlBS?=
 =?utf-8?B?T0k3ZXB0UTk2K3RqaDhSNTB6OUJVUXViQWxyL2phRnZyVkt5UVhyelo1K0pN?=
 =?utf-8?B?NUwxNCtyRm9weWFRSTFGSGhRTUtPMzRtZnFlYnJQVEZ2eTJXdkdPS1lqTyti?=
 =?utf-8?B?WW56UlVQOXRMMTRjckNoVG5NQjhvbUdHTlBLTXc1MFlFaklhTVd0QkhoamVI?=
 =?utf-8?Q?4ap/VBhgLH1hkszSdzvak1T2K?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e2201a-9971-4884-3a0a-08dcfc903547
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:19:07.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7J9J4gqA5PniaMs3yPzPWjzeHHxjnNlE/C19NNNTivPtL64z+iHad12GSU451WWNYgJ+bg8NYLGL2jtjIiKoZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZGFtIEZvcmQgPGFmb3JkMTcz
QGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNOW5tDEx5pyIMuaXpSAzOjUzDQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54
cC5jb20+OyB2a291bEBrZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGlteEBsaXN0
cy5saW51eC5kZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsga2lzaG9uQGtlcm5lbC5vcmc7DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IE1hcmNlbCBaaXN3
aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPjsNCj4gcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDEvMV0gcGh5OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IERvIENN
Tl9SU1QganVzdCBiZWZvcmUNCj4gUEhZIFBMTCBsb2NrIGNoZWNrDQo+IA0KPiBPbiBNb24sIE9j
dCAyMSwgMjAyNCBhdCAxMTowNuKAr1BNIEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+ID4gPiBTZW50OiAyMDI05bm0
MTDmnIgyMeaXpSAyMzo1Mw0KPiA+ID4gVG86IHZrb3VsQGtlcm5lbC5vcmcNCj4gPiA+IENjOiBG
cmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbTsgSG9uZ3hpbmcg
Wmh1DQo+ID4gPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBpbXhAbGlzdHMubGludXguZGV2OyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBraXNob25Aa2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IE1hcmNlbA0KPiA+ID4gWmlz
d2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+ID4gPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8xXSBwaHk6IGZyZWVzY2FsZTogaW14OG0tcGNpZTog
RG8gQ01OX1JTVCBqdXN0DQo+ID4gPiBiZWZvcmUgUEhZIFBMTCBsb2NrIGNoZWNrDQo+ID4gPg0K
PiA+ID4gRnJvbTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4NCj4g
PiA+IFdoZW4gZW5hYmxlIGluaXRjYWxsX2RlYnVnIHRvZ2V0aGVyIHdpdGggaGlnaGVyIGRlYnVn
IGxldmVsIGJlbG93Lg0KPiA+ID4gQ09ORklHX0NPTlNPTEVfTE9HTEVWRUxfREVGQVVMVD05DQo+
ID4gPiBDT05GSUdfQ09OU09MRV9MT0dMRVZFTF9RVUlFVD05DQo+ID4gPiBDT05GSUdfTUVTU0FH
RV9MT0dMRVZFTF9ERUZBVUxUPTcNCj4gPiA+DQo+ID4gPiBUaGUgaW5pdGlhbGl6YXRpb24gb2Yg
aS5NWDhNUCBQQ0llIFBIWSBtaWdodCBiZSB0aW1lb3V0IGZhaWxlZCByYW5kb21seS4NCj4gPiA+
IFRvIGZpeCB0aGlzIGlzc3VlLCBhZGp1c3QgdGhlIHNlcXVlbmNlIG9mIHRoZSByZXNldHMgcmVm
ZXIgdG8gdGhlDQo+ID4gPiBwb3dlciB1cCBzZXF1ZW5jZSBsaXN0ZWQgYmVsb3cuDQo+ID4gPg0K
PiA+ID4gaS5NWDhNUCBQQ0llIFBIWSBwb3dlciB1cCBzZXF1ZW5jZToNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ID4gMS44diBzdXBwbHkgICAgIC0tLS0tLS0tLS8NCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgLy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ID4gMC44diBzdXBwbHkgICAgIC0tLS8NCj4gPiA+DQo+ID4gPiAgICAgICAg
ICAgICAgICAgLS0tXCAvLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgWCAgICAgICAgUkVGQ0xLIFZhbGlk
DQo+ID4gPiBSZWZlcmVuY2UgQ2xvY2sgLS0tLyBcLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gPiBpX2luaXRfcmVzdG4gICAgLS0tLS0t
LS0tLS0tLS0NCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KPiA+ID4gaV9jbW5fcnN0biAgICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgb19wbGxfbG9ja19kb25lDQo+ID4gPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4NCj4gPiA+IExvZ3M6DQo+ID4gPiBpbXg2cS1wY2llIDMz
ODAwMDAwLnBjaWU6IGhvc3QgYnJpZGdlIC9zb2NAMC9wY2llQDMzODAwMDAwIHJhbmdlczoNCj4g
PiA+IGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogICAgICAgSU8gMHgwMDFmZjgwMDAwLi4weDAw
MWZmOGZmZmYgLT4NCj4gPiA+IDB4MDAwMDAwMDAwMA0KPiA+ID4gaW14NnEtcGNpZSAzMzgwMDAw
MC5wY2llOiAgICAgIE1FTSAweDAwMTgwMDAwMDAuLjB4MDAxZmVmZmZmZiAtPg0KPiA+ID4gMHgw
MDE4MDAwMDAwDQo+ID4gPiBwcm9iZSBvZiBjbGtfaW14OG1wX2F1ZGlvbWl4LnJlc2V0LjAgcmV0
dXJuZWQgMCBhZnRlciAxMDUyIHVzZWNzDQo+ID4gPiBwcm9iZSBvZiAzMGUyMDAwMC5jbG9jay1j
b250cm9sbGVyIHJldHVybmVkIDAgYWZ0ZXIgMzI5NzEgdXNlY3MgcGh5DQo+ID4gPiBwaHktMzJm
MDAwMDAucGNpZS1waHkuNDogcGh5IHBvd2Vyb24gZmFpbGVkIC0tPiAtMTEwIHByb2JlIG9mDQo+
ID4gPiAzMGUxMDAwMC5kbWEtY29udHJvbGxlciByZXR1cm5lZCAwIGFmdGVyIDEwMjM1IHVzZWNz
IGlteDZxLXBjaWUNCj4gPiA+IDMzODAwMDAwLnBjaWU6IHdhaXRpbmcgZm9yIFBIWSByZWFkeSB0
aW1lb3V0IQ0KPiA+ID4gZHdoZG1pLWlteCAzMmZkODAwMC5oZG1pOiBEZXRlY3RlZCBIRE1JIFRY
IGNvbnRyb2xsZXIgdjIuMTNhIHdpdGgNCj4gPiA+IEhEQ1ANCj4gPiA+IChzYW1zdW5nX2R3X2hk
bWlfcGh5MikgaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBwcm9iZSB3aXRoIGRyaXZlcg0KPiA+
ID4gaW14NnEtcGNpZSBmYWlsZWQgd2l0aCBlcnJvciAtMTEwDQo+ID4gPg0KPiA+ID4gRml4ZXM6
IGRjZTllZGZmMTZlZSAoInBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBBZGQgaS5NWDhNUCBQ
Q0llDQo+ID4gPiBQSFkNCj4gPiA+IHN1cHBvcnQiKQ0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29t
Pg0KPiA+ID4NCj4gPiA+IHYyIGNoYW5nZXM6DQo+ID4gPiAtIFJlYmFzZSB0byBsYXRlc3QgZml4
ZXMgYnJhbmNoIG9mIGxpbnV4LXBoeSBnaXQgcmVwby4NCj4gPiA+IC0gUmljaGFyZCdzIGVudmly
b25tZW50IGhhdmUgcHJvYmxlbSBhbmQgY2FuJ3Qgc2VudCBvdXQgcGF0Y2guIFNvIEkNCj4gPiA+
IGhlbHAgcG9zdCB0aGlzIGZpeCBwYXRjaC4NCj4gDQo+IEV2ZW4gd2l0aCB0aGlzIHBhdGNoLCBJ
IGFtIHN0aWxsIHNlZWluZyBhbiBvY2Nhc2lvbmFsIHRpbWVvdXQgb24gOE1QLg0KPiBJIGxvb2tl
ZCBhdCBzb21lIGxvZ3Mgb24gYSBzaW1pbGFybHkgZnVuY3Rpb25pbmcgOE1NIGFuZCBJIGNhbid0
IGdldCB0aGlzIGVycm9yIHRvDQo+IGFwcGVhciBvbiBNaW5pIHRoYXQgSSBzZWUgb24gUGx1cy4N
Cj4gDQo+IFRoZSBUUk0gZG9lc24ndCBkb2N1bWVudCB0aGUgdGltaW5nIG9mIHRoZSBzdGFydHVw
IHNlcXVlbmNlLCBsaWtlIHRoaXMgZS1tYWlsDQo+IHBhdGNoIGRpZCBub3IgZG9lcyBpdCBzdGF0
ZSBob3cgbG9uZyBhIHJlYXNvbmFibGUgdGltZW91dCBzaG91bGQgdGFrZS4gU28sIEkNCj4gc3Rh
cnRlZCBsb29raW5nIHRocm91Z2ggdGhlIGNvZGUgYW5kIEkgbm90aWNlZCB0aGF0IHRoZSBNaW5p
IGFzc2VydHMgdGhlIHJlc2V0IGF0DQo+IHRoZSBiZWdpbm5pbmcsIHRoZW4gbWFrZXMgYWxsIHRo
ZSBjaGFuZ2VzLCBhbmQgZGUtYXNzZXJ0cyB0aGUgcmVzZXRzIHRvd2FyZCB0aGUNCj4gZW5kLiAg
SXMgdGhlcmUgYW55IHJlYXNvbiB3ZSBzaG91bGQgbm90IGFzc2VydCBvbmUgb3IgYm90aCBvZiB0
aGUgcmVzZXRzIG9uDQo+IDhNUCBiZWZvcmUgc2V0dGluZyB1cCB0aGUgcmVzZXQgb2YgdGhlIHJl
Z2lzdGVycyBsaWtlIHRoZSB3YXkgTWluaSBkb2VzIGl0Pw0KWWVzLCBJIGhhZCB0aGUgc2ltaWxh
ciBjb25mdXNpb25zIHdoZW4gSSB0cnkgdG8gYnJpbmcgdXAgaS5NWDhNUCBQQ0llLg0KaS5NWDhN
UCBQQ0llIHJlc2V0cyBoYXZlIHRoZSBkaWZmZXJlbnQgZGVzaWducyBidXQgSSBkb24ndCBrbm93
IHRoZSByZWFzb24gYW5kDQp0aGUgZGV0YWlscy4gVGhlc2UgcmVzZXRzIHNob3VsZG4ndCBiZSBh
c3NlcnRlZC9kZS1hc3NlcnRlZCBhcyBNaW5pIGRvZXMgZHVyaW5nDQogdGhlIGluaXRpYWxpemF0
aW9uLg0KDQpPbiBpLk1YOE1QLCB0aGVzZSByZXNldHMgc2hvdWxkIGJlIGNvbmZpZ3VyZWQgb25l
LXNob3QuIEkgdXNlZCB0byB0b2dnbGUgdGhlbQ0KaW4gbXkgb3duIGV4cGVyaW1lbnRzLiBVbmZv
cnR1bmF0ZWx5LCB0aGUgUENJZSBQSFkgd291bGRuJ3QgYmUgZnVuY3Rpb25hbC4NCg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gYWRhbQ0KPiANCj4gPiA+IC0tLQ0KPiA+IEhpIEZy
YW5rOg0KPiA+IFRoYW5rcyBhIGxvdCBmb3IgeW91ciBraW5kbHkgaGVscC4NCj4gPiBTaW5jZSBt
eSBzZXJ2ZXIgaXMgZG93biwgSSBjYW4ndCBzZW5kIG91dCB0aGlzIHYyIGluIHRoZSBwYXN0IGRh
eXMuDQo+ID4NCj4gPiBIaSBWaW5vZDoNCj4gPiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHksIGFu
ZCBicmluZyB5b3UgaW5jb252ZW5pZW5jZS4NCj4gPg0KPiA+IEJlc3QgUmVnYXJkcw0KPiA+IFJp
Y2hhcmQgWmh1DQo+ID4NCj4gPiA+ICBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4
bS1wY2llLmMgfCAxMCArKysrKy0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+ID4gPiBiL2RyaXZlcnMvcGh5
L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+ID4gaW5kZXggMTFmY2IxODY3MTE4
Yy4uZTk4MzYxZGNkZWFkZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGh5L2ZyZWVzY2Fs
ZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9waHkvZnJlZXNjYWxl
L3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+ID4gPiBAQCAtMTQxLDExICsxNDEsNiBAQCBzdGF0aWMg
aW50IGlteDhfcGNpZV9waHlfcG93ZXJfb24oc3RydWN0IHBoeQ0KPiA+ID4gKnBoeSkNCj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19QTEwpOw0K
PiA+ID4gICAgICAgdXNsZWVwX3JhbmdlKDEwMCwgMjAwKTsNCj4gPiA+DQo+ID4gPiAtICAgICAv
KiBEbyB0aGUgUEhZIGNvbW1vbiBibG9jayByZXNldCAqLw0KPiA+ID4gLSAgICAgcmVnbWFwX3Vw
ZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgSU1YOE1NX0dQUl9QQ0lFX0NNTl9SU1QsDQo+ID4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgSU1YOE1NX0dQUl9QQ0lFX0NNTl9SU1QpOw0KPiA+ID4gLQ0K
PiA+ID4gICAgICAgc3dpdGNoIChpbXg4X3BoeS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ID4g
ICAgICAgY2FzZSBJTVg4TVA6DQo+ID4gPiAgICAgICAgICAgICAgIHJlc2V0X2NvbnRyb2xfZGVh
c3NlcnQoaW14OF9waHktPnBlcnN0KTsNCj4gPiA+IEBAIC0xNTYsNiArMTUxLDExIEBAIHN0YXRp
YyBpbnQgaW14OF9wY2llX3BoeV9wb3dlcl9vbihzdHJ1Y3QgcGh5DQo+ID4gPiAqcGh5KQ0KPiA+
ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiArICAg
ICAvKiBEbyB0aGUgUEhZIGNvbW1vbiBibG9jayByZXNldCAqLw0KPiA+ID4gKyAgICAgcmVnbWFw
X3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgSU1YOE1NX0dQUl9QQ0lFX0NNTl9SU1QsDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgSU1YOE1NX0dQUl9QQ0lFX0NNTl9SU1QpOw0KPiA+ID4g
Kw0KPiA+ID4gICAgICAgLyogUG9sbGluZyB0byBjaGVjayB0aGUgcGh5IGlzIHJlYWR5IG9yIG5v
dC4gKi8NCj4gPiA+ICAgICAgIHJldCA9IHJlYWRsX3BvbGxfdGltZW91dChpbXg4X3BoeS0+YmFz
ZSArDQo+ID4gPiBJTVg4TU1fUENJRV9QSFlfQ01OX1JFRzA3NSwNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2YWwsIHZhbCA9PSBBTkFfUExMX0RPTkUsIDEwLA0KPiAyMDAw
MCk7DQo+ID4gPiAtLQ0KPiA+ID4gMi4zNC4xDQo+ID4NCj4gPiAtLQ0KPiA+IGxpbnV4LXBoeSBt
YWlsaW5nIGxpc3QNCj4gPiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHBz
Oi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3QNCj4gPg0KPiBzLmluZnJhZGVhZC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZs
aW51eC1waHkmZGF0YT0wNSU3QzAyJTdDaG9uZ3hpDQo+ID4NCj4gbmcuemh1JTQwbnhwLmNvbSU3
QzY2NmM4OTY4YjMwOTQxNDdlZDQ0MDhkY2ZhYWVjNjMxJTdDNjg2ZWExZDNiYw0KPiAyYjRjNmYN
Cj4gPg0KPiBhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg2NjA4NzU3NzE1NDU2ODclN0NV
bmtub3duJTdDVFdGDQo+IHBiR1pzYjNkOA0KPiA+DQo+IGV5SldJam9pTUM0d0xqQXdNREFpTENK
UUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCUNCj4gN0MwDQo+ID4g
JTdDJTdDJTdDJnNkYXRhPTNNZzRTcWNhQSUyRmxiU2N2ZXJpR0JCTU9xMVlPVHQzb2t5ZGdIbWpt
ZExwcw0KPiAlM0QmcmVzZXINCj4gPiB2ZWQ9MA0K

