Return-Path: <stable+bounces-233488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJZRIbV61GmxuQcAu9opvQ
	(envelope-from <stable+bounces-233488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 05:32:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07843A96C0
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 05:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2EF03019124
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9048372EFF;
	Tue,  7 Apr 2026 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HJxA30wW"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4A358D00;
	Tue,  7 Apr 2026 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532722; cv=fail; b=PO/CIKbQIlRTxPrycbwKzpwypfgU7jNpgm6T/S5gY/eJQ4SFfID1CgY+G1qigpoo0l1FZ0rU7NTHt7t2sOeO5aPrKKZXKGzJeh8pSmWmwEMb5wjBSdXJZpzauT2Vz/F+EcVl/+yHW0QRfW8K1Cr+EoCC98zPXFgrXey3Bsdh1HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532722; c=relaxed/simple;
	bh=1j97q0tL8tzZOP3U7HFfLh0fu5B8WiJzPOezXqHxe9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSeq2uLCtJVCNLnW0ZuH8VPFcwTI0nvZPfDbKIhHOChpXgVibf9JOKBERCwcgypugOHkJPftcsM9rzf0Z8g7BgRE0Wd5E0muwq+l4U/u1VzicGbQlcW6Pz9Godba5pZrsZlLRQ6w5qf/zG3sOe3DBPJIwSUqvo/+5y116BbkOe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HJxA30wW; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N74SX4AKMdWSdZQ09n1s/oGKYqQd4LELoVWW0yzk2Ymw3ZOSSVBDGlktXVB1vot80lWfwLuYSQ84Ps9IiwusCuV71qonCYxrDV1UaoRQIr6JjU1oU4vyyLWo14mSVprurud22plzevCHPmF5hQOcoU2nhVGmVP910eAhRKqiOgyiIopddlIzZRAXgw6P2XQ47+drF7AVdRnT2XrWi/Z/05ieOMpv3foLiOjqiYxUMX7EgJLdTm2Tz8aLF+Hai9Pi3O47e64VrIZ/Ac1GGmCngwsv7/C4ae6N/1uG8Dt42uWdnx0tBVjIKdDlHzWR53UnuKBRTXUf587YtMUHz0971Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j97q0tL8tzZOP3U7HFfLh0fu5B8WiJzPOezXqHxe9c=;
 b=W8yfOYTden0cFZ8n2DpwiogrzTk7IFYJKw9DD2FbPbUsWRSgGd4GdX66pGsHj2NTY/dlWIa9vhi6iT4W76ZOkEHU8rQvJhP43shm3Zb/yAwQEpkAJSutuwn/hNQdn3ylJo14Dk4X3TwpiI6VIYBYtjMIx8axv4fa98G6ztEh+/aDpOUf2TU5c1NYSk0ahSe4SMwmz9wozGXE6e5gXCYcGz1cnrONEH9Hy0ZJ0J8dWKd91N/aNv3TkG/blQ1h1HyXEqBiLq9i2Dwc8z/xgJrDLXgu5qiwkEOv4z75SheEqymncEveUiqI5vt4Jnm3BtJkmzSlUrgTF6FkeM1/9ya3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j97q0tL8tzZOP3U7HFfLh0fu5B8WiJzPOezXqHxe9c=;
 b=HJxA30wW5Hven3/glYuu+IrMuAr4rJt6fEWwySWkKUYu1RwVdFTIB2xT+DhXapsbE+oLOoRCzabz62eYgZkgPEHhimDa9BcUhsmTcMwDbt+umiIirkTIYX4mQogdSTVimOW7kD0a/piFzGTvWkYKk3SllD9+1pvMzpd9cRIbUBafhj2de3pOPhVN411Nze7RCM51SSUsknLFI6zGO2hEC2cm+uTKS5dRkrMW3VLrRFPmwKgwAyXoqjH0QcS1FARKkbSKssU0HPoiqOvBh2ECzys/wrI9IA2Gklgp9NFC9Cvyq0qm72DNX3oIpjHdUbUwBMR32d/ftV4wqNYT0FZffA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU0PR04MB9633.eurprd04.prod.outlook.com (2603:10a6:10:311::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 03:31:57 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 03:31:57 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "mani@kernel.org" <mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>,
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
 AQHctdXR4rMaQwHMbk+Nxv/9or4V47Wy+e2AgACXyCCACSXqAIAAPoUAgBC1qACABVGiIA==
Date: Tue, 7 Apr 2026 03:31:57 +0000
Message-ID:
 <AS8PR04MB8833C20B6FF92F96EE7641E38C5AA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8833061F34B9BEFC9D19764A8C4EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20260323220858.GA1084506@bhelgaas>
 <AS8PR04MB8833137860C682F9E1E743E08C48A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <y76fzvju42srykr3khio2bx5lmzusy6iasodvs45imis7fw3b5@wjv3gsocj534>
In-Reply-To: <y76fzvju42srykr3khio2bx5lmzusy6iasodvs45imis7fw3b5@wjv3gsocj534>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU0PR04MB9633:EE_
x-ms-office365-filtering-correlation-id: a0600db0-8bac-49cc-af79-08de945638f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 MC4J1fcs4kH9JWoqDyFHWArJCMwQM0GPnBtb3XeBb/TSUe9GEfnmLXkKUjEyHwrPRzxmc/szWg6Pur5PAVvgCHITSwP91Vk9J6c0EzaGA4euPApPy98yNcbu+UYoTTyAzv/5UIXJP0Jyv3xevf4gHfnS/h43sNFtFS96+72tuXMyTHh4uXZ0tQRFTSx6CYtImKtf1gsvRLZ7tGMbgFXK5mZTnGvh60iTCvseHNbAvCwGz9el9aq6Oy2sOM3LYYFxEooF+xd05aD/Ljl07D3L40Z1huE5FmfdBj6UY+cx5sxG9rda4iD7sA2ajg393JQzXJ8A3o68KSWENyZzlDVN9ph7NuSVpiTsOY0OQvokwzZ9Wi1bBR1WCMSNYfpeEJEcYz5MH92ufFKcRgXvzNzmwiYVh3YZTnou5BJ61YZtIDYk0j3oW+UNe6gy0otkhgafkONrMq/arUz1YbjMtzbNbmqOUJNrROagy3U14cMrMD6E4IfVpNTfcXJkP9ldHLJp9qBDGyIv2roM4CpLS3hqgtqLVG6poOlDRbwu4X0xpBJdSC52x1FIR8w5hn4ZSq+q97XtrbAlrv0J6wMQZ+f63TVjhyxR0DimkcTDlAN0ASvYp9Ovr0aaLSv3svMxMFbmWokNCAAFM9TfpzqKH0H3QAKQS9vPfYXjwK+no/DdgfyK9gSz/MEWrcVkPgqqSQAcULBKzvfdFYcN29f+ORES3RCUdqw1sd6RTIDWNtGYh9ojTbjbKI582tu/WRUsyxmi9aoqNYebRuf/8sha4cc2IKMeNTTlo0ts0GiWPEX/khY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWoxTnl6VUc2bVZEMFhaU0FvNXZsYkFDTEk1MkprQVJJSGlGUXkvV1VGRHhp?=
 =?utf-8?B?MTh0R1hxQXZvZU1pYjJLVEplVzhnSm9hWTJVWnYwdUhCZU13N3Bpbm15ZFRz?=
 =?utf-8?B?SDdFMkowOUNpNkh0djFvdlNsbXV1TjFGR2loZ25MVHdBNjFKVHJaR0V6aEpR?=
 =?utf-8?B?cTdKd1lBOFJpb3MwaUhCYWRFOVQ0TTZHdGxIUWNFQStXSi9yUDFuSFJJKzQ0?=
 =?utf-8?B?MVg0cVZ4YkllWC93dExkUWRWSWZ1Sy91ZWF3T1hhSFNWazRwSDVSMlU2ZzZx?=
 =?utf-8?B?S2xLN0FrdVFPdGhwcTdsWmZZbnZrd1pxZWF2RG5XUis3MEtjbElRSGdtQ3Bw?=
 =?utf-8?B?OXFqckRqYWRwdXBUb3RWeXgzNmVNSGw3WjFkVUttbDAydkwxcE9aTi9vODRL?=
 =?utf-8?B?Z1ppVk8vbFJpZFhBcHM1NkQ0S0E1NFRDVFU0UWhmTTE4ZEIwdEk0cmcyK05N?=
 =?utf-8?B?ZGt0YVRzc21pemVzSHl1UTlROVZ2eTZKYW5NeEVxTk5lcFl3QlVOMmQ5blZZ?=
 =?utf-8?B?Sk1ETDZCY0JscTJyVG40YnJKZUZOZmsxdDFwM3h1WWE0dXdrQlJhTE1MM2JO?=
 =?utf-8?B?RHlPdGZjOEVWb1Y3REx6QkdwRzNLMHBiajV4TDQvREJENWk1KytHd3dXVXZi?=
 =?utf-8?B?VzF4NWRxaGNwdUhFVW41OVpZNXl4RlV0WXFoZ0YzU2tzdUx3NWR1TUZBSTVF?=
 =?utf-8?B?N0x1YW1LUkYyZWp5WDRGYXNNdWpqNFZNc2ZlT1NBOE1ObXd0M1NGR0J3b00y?=
 =?utf-8?B?aWJ4c1NySDJWSGJYL2xqRzhiWkFtYmcvRHdKcEZLbVRSVW5IckNSeHZVeGVw?=
 =?utf-8?B?RFNiZnpQazc5c1pnR1VKTmRhMFpuRFhQOWVGWi9tYXdiUHVhZ2R3Y3hObGx4?=
 =?utf-8?B?WlorUnlmZ0xhOU1KN2dwa29scUFkWE13aXc0WHlwUWFyUE9jTjNDT1RRVlJU?=
 =?utf-8?B?Tk9aYTRVUHlLUHRzaXEwQXNNMnB1ZE8yczRZYlQrYnJiUTUvdWtBVmpJL2R6?=
 =?utf-8?B?S0R5cjd5NTdNb2o4Sk5QTDhJSVRpcGVRZ3VrejNsdmtRbld2KzJlbU41aDFD?=
 =?utf-8?B?NTJ4dUhJMHpVNVRYOU1WaDZtb09aNGswMXR2ajk5cUk4RjZ5S2xwY2FBZmlp?=
 =?utf-8?B?YWV1UkRoSWpBMDRLNXVsZXFSU01LT1pkcDBSU3pTZ0dqd3hMbDEwYlhqcHl3?=
 =?utf-8?B?aXkva2t6K2lFQXR5VmFSL1NDbjFYdXlMZm8zRkIvNmRkYzdWckNjb3lVRUFN?=
 =?utf-8?B?TGFGcVUyaURtVWxJdi9JUW90em52VFVYU09xdGppOUNWc0dZRkpLTDhXMnQ3?=
 =?utf-8?B?cWd0UWt2VitnQWErcllLUEtXOWdqNEVRbXJ1d1Z0TkI3NmpJSVRaNU1JZTR5?=
 =?utf-8?B?MHQzWnFvVlVsYUFQVDhwVUVDRWFxZFRpVFZXVkh4VjRFT25SZVlRWlJNaWdL?=
 =?utf-8?B?ZU9BdzZRY0lOcnI4TjVSVVg2SnVDY3E1YmUzRkZXSEQ1cDBkbFl3aU82Q0la?=
 =?utf-8?B?MXNpYnBBV0RFWS96NG5paEtqNWttZi9STU5pangwdDhBeU42T2dMTTFhek1S?=
 =?utf-8?B?d2p3azJPd3Vzb1ArYkd4c1ptNE1KTFAwTWJ2Ykp4eUxyRUlvYkM0ZGE1R2k1?=
 =?utf-8?B?aFhlS0dsRmE1VWMrbS9wWEZIc0ZYZS9hMldrU0U4eC9BamQ2TEpWZGJWNmN2?=
 =?utf-8?B?TXYvaitPSlZjVlNmQThMYXBMMHhFaE9RQ0JzVVQ5ZEhSTjg2MGFPMHIrdmYz?=
 =?utf-8?B?c0RlSjM0c0pGNktyNGpSOWkxMlhybHBycHFxNXJUZUN5WnRJT0JiaTVlYjh2?=
 =?utf-8?B?bkY5UVMwYUt4MDI3UGxsSnNIUjRtK2NJaUxKeWwzZk5EbW1HNDY4V1JuMytQ?=
 =?utf-8?B?VytkYVhmZmIzZ2dMcTZ4UzRMZGhKTDBHd0hzMXNEdkVqM1B5VEsxS2MzcmlJ?=
 =?utf-8?B?M3VvWlFMd1o3c2h6emZFeG5lRnZhUndoSjdiQzEzdWVHUE1qVTRpbEduWk9Q?=
 =?utf-8?B?Wldzb2JDZzUrRmZ4elZhUnZzR0tTWElkdjBRS0F6YkNKWE5HbHZPYXdXZlVv?=
 =?utf-8?B?T1VZZ05zbFhmUWh1SEhHZzlmdXgzRC9GWTdKd1kySE1NOHBVakx6VWM4TXFn?=
 =?utf-8?B?d2d3RXUwYUZPVXdKcjFhaHV2SW03RGZUMHl0enM5ckEvcm9mU1VWTWZOTW90?=
 =?utf-8?B?SS93WFJNUEtYeFlDd0JtM0lqdS9FNURsMzZQc1p3TXdVQStqRXBhQ3RWNWlU?=
 =?utf-8?B?N096Y2Z5NDNMeUxpVWVFTEZKS01sakl5YXFIQ3RWR05aWXZSZzNXenBtK0JV?=
 =?utf-8?Q?H+MLXwNiqbzdTlApCv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0600db0-8bac-49cc-af79-08de945638f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 03:31:57.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtefR96Bltz9KFvkDnaoDmMvmZcnnWHT/pZdQfADA99qGP9Py41boqUjYWPTKmVlTbBByOsLAhKN5Jg+SQk6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9633
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233488-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,AS8PR04MB8833.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: F07843A96C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBtYW5pQGtlcm5lbC5vcmcgPG1h
bmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNuW5tDTmnIg05pelIDE6MDMNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+IGppbmdvb2hh
bjFAZ21haWwuY29tOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5v
cmc7DQo+IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRl
djsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBQQ0k6IGlteDY6IEFkZCBmb3JjZV9zdXNwZW5kIGZs
YWcgdG8gb3ZlcnJpZGUgTDFTUw0KPiBzdXNwZW5kIHNraXANCj4gDQo+IE9uIFR1ZSwgTWFyIDI0
LCAyMDI2IGF0IDAyOjAxOjU4QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAyMDI25bm0M+aciDI05pelIDY6MDkNCj4gPiA+
IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gQ2M6IEZyYW5r
IExpIDxmcmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+ID4gPiBsLnN0
YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+ID4gPiBrd2lsY3p5
bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gPiA+
IGJoZWxnYWFzQGdvb2dsZS5jb207IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsNCj4gPiA+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
PiA+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4gPiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYx
XSBQQ0k6IGlteDY6IEFkZCBmb3JjZV9zdXNwZW5kIGZsYWcgdG8NCj4gPiA+IG92ZXJyaWRlIEwx
U1Mgc3VzcGVuZCBza2lwDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBNYXIgMTgsIDIwMjYgYXQgMDI6
NTU6NDVBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0Br
ZXJuZWwub3JnPg0KPiA+ID4gPiAuLi4gW21lc3NlZCB1cCBxdW90aW5nXQ0KPiA+ID4NCj4gPiA+
ID4gPiBPbiBUdWUsIE1hciAxNywgMjAyNiBhdCAwMjoxMjo1NlBNICswODAwLCBSaWNoYXJkIFpo
dSB3cm90ZToNCj4gPiA+ID4gPiA+IEFkZCBhIGZvcmNlX3N1c3BlbmQgZmxhZyB0byBhbGxvdyBw
bGF0Zm9ybSBkcml2ZXJzIHRvIGZvcmNlDQo+ID4gPiA+ID4gPiB0aGUgUENJZSBsaW5rIGludG8g
TDIgc3RhdGUgZHVyaW5nIHN1c3BlbmQsIGV2ZW4gd2hlbiBMMVNTDQo+ID4gPiA+ID4gPiAoQVNQ
TSBMMQ0KPiA+ID4gPiA+ID4gU3ViLVN0YXRlcykgaXMgZW5hYmxlZC4NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBCeSBkZWZhdWx0LCB0aGUgRGVzaWduV2FyZSBQQ0llIGhvc3QgY29udHJvbGxl
ciBza2lwcyBMMg0KPiA+ID4gPiA+ID4gc3VzcGVuZCB3aGVuIEwxU1MgaXMgc3VwcG9ydGVkIHRv
IG1lZXQgbG93IHJlc3VtZSBsYXRlbmN5DQo+ID4gPiA+ID4gPiByZXF1aXJlbWVudHMgZm9yIGRl
dmljZXMgbGlrZSBOVk1lLiBIb3dldmVyLCBzb21lIHBsYXRmb3Jtcw0KPiA+ID4gPiA+ID4gbGlr
ZSBpLk1YIFBDSWUgbmVlZCB0byBlbnRlciBMMiBzdGF0ZSBmb3IgcHJvcGVyIHBvd2VyDQo+ID4g
PiA+ID4gPiBtYW5hZ2VtZW50IHJlZ2FyZGxlc3Mgb2YgTDFTUw0KPiA+ID4gc3VwcG9ydC4NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBFbmFibGUgZm9yY2Vfc3VzcGVuZCBmb3IgaS5NWCBQQ0ll
IHRvIGVuc3VyZSB0aGUgbGluayBlbnRlcnMNCj4gPiA+ID4gPiA+IEwyIGR1cmluZyBzeXN0ZW0g
c3VzcGVuZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEknbSBhIGxpdHRsZSBiaXQgc2tlcHRpY2Fs
IGFib3V0IHRoaXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaGF0IGV4YWN0bHkgZG9lcyBhICJs
b3cgcmVzdW1lIGxhdGVuY3kgcmVxdWlyZW1lbnQiIG1lYW4/ICBJcw0KPiA+ID4gPiA+IHRoaXMg
YW4gYWN0dWFsIGZ1bmN0aW9uYWwgcmVxdWlyZW1lbnQgdGhhdCdzIHNwZWNpYWwgdG8gTlZNZSwg
b3INCj4gPiA+ID4gPiBpcyBpdCBqdXN0IHRoZSBkZXNpcmUgZm9yIGxvdyByZXN1bWUgbGF0ZW5j
eSB0aGF0IGV2ZXJ5Ym9keSBoYXMNCj4gPiA+ID4gPiBmb3IgYWxsIGRldmljZXM/DQo+ID4gPiA+
DQo+ID4gPiA+IEZyb20gbXkgdW5kZXJzdGFuZGluZywgTDFTUyBtb2RlIGlzIGNoYXJhY3Rlcml6
ZWQgYnkgbG93ZXIgbGF0ZW5jeQ0KPiA+ID4gPiB3aGVuIGNvbXBhcmVkIHRvIEwyIG9yIEwzIG1v
ZGVzLg0KPiA+ID4gPg0KPiA+ID4gPiBJdCBjYW4gYmUgdXNlZCBvbiBhbGwgZGV2aWNlcywgYXZv
aWRpbmcgZnJlcXVlbnQgcG93ZXIgb24vb2ZmIGN5Y2xlcy4NCj4gPiA+ID4gTlZNZSBjYW4gYWxz
byBleHRlbmQgdGhlIHNlcnZpY2UgbGlmZSBvZiB0aGUgZXF1aXBtZW50Lg0KPiA+ID4NCj4gPiA+
IEFsbCB0aGUgYWJvdmUgYXBwbGllcyB0byBhbGwgcGxhdGZvcm1zLCBzbyBpdCdzIG5vdCBhbiBh
cmd1bWVudCBmb3INCj4gPiA+IGkuTVgtc3BlY2lmaWMgY29kZSBoZXJlLg0KPiA+ID4NCj4gPiBI
aSBCam9ybjoNCj4gPiBUaGFua3MgZm9yIHlvdXIga2luZGx5IHJldmlldy4NCj4gPiBZZXMsIGl0
IGlzLg0KPiA+ID4gPiA+IElzIHRoZXJlIHNvbWV0aGluZyBzcGVjaWFsIGFib3V0IGkuTVggaGVy
ZT8gIFdoeSBkbyB3ZSB3YW50IGkuTVgNCj4gPiA+ID4gPiB0byBiZSBkaWZmZXJlbnQgZnJvbSBv
dGhlciBob3N0IGNvbnRyb2xsZXJzPw0KPiA+ID4gPg0KPiA+ID4gPiBpLk1YIFBDSWUgbG9zZXMg
cG93ZXIgc3VwcGx5IGR1cmluZyBEZWVwIFNsZWVwIE1vZGUgKERTTSksDQo+ID4gPiA+IHJlcXVp
cmluZyBmdWxsIHJlaW5pdGlhbGl6YXRpb24gYWZ0ZXIgc3lzdGVtIHdha2UtdXAuDQo+ID4gPg0K
PiA+ID4gSSBkb24ndCBrbm93IHdoYXQgRFNNIG1lYW5zIGluIFBDSWUgb3IgaG93IGl0IHdvdWxk
IGhlbHAganVzdGlmeQ0KPiA+ID4gdGhpcyBjaGFuZ2UuDQo+ID4gPg0KPiA+IGkuTVggUENJZSBw
b3dlciBpcyBnYXRlZCBvZmYgZHVyaW5nIHN1c3BlbmQsIHJlcXVpcmluZyBmdWxsDQo+ID4gcmVp
bml0aWFsaXphdGlvbiBvbiByZXN1bWUNCj4gPg0KPiANCj4gSXMgdGhpcyBhbiB1bmNvbmRpdGlv
bmFsIGJlaGF2aW9yPyBXaGF0IGlmIHRoZSBQQ0llIGRldmljZSBpcyBjb25maWd1cmVkIGFzIGEN
Cj4gd2FrZXVwIHNvdXJjZSBsaWtlIFdPTCwgV09XPyBBbmQgaWYgeW91IGNvbm5lY3QgTlZNZSwg
dGhpcyBiZWhhdmlvciB3aWxsDQo+IHJlc3VsdCBpbiByZXN1bWUgZmFpbHVyZSBhcyBOVk1lIGRy
aXZlciBleHBlY3RzIHRoZSBwb3dlciB0byBiZSByZXRhaW5lZCBpZg0KPiBBU1BNIGlzIHN1cHBv
cnRlZC4NCg0KWWVzLCB0aGlzIGlzIHVuY29uZGl0aW9uYWwgYmVoYXZpb3IuIFRoZSBpLk1YIFBD
SWUgY29udHJvbGxlciBleGNsdXNpdmVseQ0Kc3VwcG9ydHMgc2lkZWJhbmQgd2FrZXVwIG1lY2hh
bmlzbXMsIHdoaWNoIG9wZXJhdGUgaW5kZXBlbmRlbnRseSBvZiB0aGUNClBDSWUgbGluayBzdGF0
ZSBhbmQgZGV2aWNlIHBvd2VyIGNvbmZpZ3VyYXRpb24uDQoNCkZvciBkZXZpY2VzIGNvbmZpZ3Vy
ZWQgYXMgd2FrZXVwIHNvdXJjZXMgKFdPTCwgV09XLCBldGMuKTogVGhlIHNpZGViYW5kDQp3YWtl
dXAgcGF0aCBieXBhc3NlcyB0aGUgc3RhbmRhcmQgUENJZSBwb3dlciBtYW5hZ2VtZW50LCBzbyB0
aGVzZQ0KY29uZmlndXJhdGlvbnMgZG8gbm90IGltcGFjdCB0aGUgaS5NWCBQQ0llIFJDIGNvbnRy
b2xsZXIncyBzdXNwZW5kL3Jlc3VtZQ0KYmVoYXZpb3IuDQoNCkZvciBOVk1lIGRldmljZXMgd2l0
aCBBU1BNOiBXaGlsZSBOVk1lIGRyaXZlcnMgdHlwaWNhbGx5IGV4cGVjdCBwb3dlcg0KcmV0ZW50
aW9uIHdoZW4gQVNQTSBpcyBlbmFibGVkLCB0aGUgaS5NWCBpbXBsZW1lbnRhdGlvbidzIHNpZGVi
YW5kIHdha2V1cA0KbWVjaGFuaXNtIG9wZXJhdGVzIHRocm91Z2ggYSBzZXBhcmF0ZSBzaWduYWxp
bmcgcGF0aC4gVGhlIHdha2V1cCBmdW5jdGlvbmFsaXR5DQpkb2VzIG5vdCBkZXBlbmQgb24gbWFp
bnRhaW5pbmcgUENJZSBsaW5rIHBvd2VyLCB0aHVzIGF2b2lkaW5nIGNvbmZsaWN0cyB3aXRoDQpO
Vk1lIHBvd2VyIHN0YXRlIGV4cGVjdGF0aW9ucy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KPiANCj4gLSBNYW5pDQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g
4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

