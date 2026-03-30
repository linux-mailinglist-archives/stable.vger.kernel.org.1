Return-Path: <stable+bounces-231055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA2pHOo8ymnD6gUAu9opvQ
	(envelope-from <stable+bounces-231055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:05:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF40357C21
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4C4B30236B6
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EAC396B8E;
	Mon, 30 Mar 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I58u61wr"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052373AA4F0;
	Mon, 30 Mar 2026 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861387; cv=fail; b=pH9EEMBTbVgoWM3UcruD3n71moMS+ypThff09F9lBKEd9K2yZK09ruBi+wzDn2Ih1KVjiLArTdY3XLSs3mLXn6YF0tlKRiOt5yoJPJnDCicK549pvdFui8EcigWuOO9neF9ELfASpxoG5tsfDVkUXnSpT0R6KciW1ovuaA2dvL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861387; c=relaxed/simple;
	bh=7x51OBE8nr3QT9BojSXfrp0/kv2vp6fcxwsrpUp9HI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8k703Ml5Z09DvYpEyduvYjqcOp0kjTlshv0rVCIZQ1RrrgltC/xXN0zMp/xioxhEWtD7ZcHhu5BLp5S+Obs6caJNqeNOPeE8CNgM01M2t0Jh2wPTPoXmVOXv0sAcw7XBoml5CtI/XvfXXQLlTcAM0yLqHR4zNw6MUPp3W33T10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I58u61wr; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fbca7smuzViMpXafiPFucokt+rtTTxjQ47wzJd8n+NMo91TI/reCvFgmSqwldsis6LBeF+wYupnUwBDxYzM8SGEgo1TYLCz3Nq8Bk5b8x0fZMU8cf7TK/3dSgEKW64iW9CGLd4OzVyIG/mAFv4u+XKLROCL6rO6vEBOrr3EocnHsCot6C6x1+rlJRH/ebuTFdBTVVmKbQs3feuhnmz7IslDnubi241TvnGm4fxCfHO3fUxQtt8F5DG1qp9/d5xDcj6bZPvqGEAebt6zQtRltzsddnU9kdI9MDVKul4dbRDWMkz83nJezZzi2zLyLx93xDZjHImqUCNp9hjfSVCUhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x51OBE8nr3QT9BojSXfrp0/kv2vp6fcxwsrpUp9HI8=;
 b=C828RywbatSG9eiqHt5u5pc2KzoYcUcqQWdynBOYx2qfO9ehnPQWEqXbxznMuYk2rfbwfMmIHginf0x9VOZGWyk/kYmKHCkyKxX4tOkQRIt2+uKtn/XomTWmKvTsBwGQld4yEmFCKeY2PWmuyn7VnAgsyT2Jk6glhbh1SwiJ2IGp87vx8LLyLJSV6w3IoFWCWbnwXq+DD18CaQ8EntgpqGOw7Hezk2+jjI1+o/S3JIp38YT/+/lAMuYqPwu99RrWG857SXBHkL7DFddG5KbHest6wn3vpajDF/chLuz9sKDBEngL6N1G3cIXKRNHXp9cB1UMNisrR6C0YFFIHG7TMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x51OBE8nr3QT9BojSXfrp0/kv2vp6fcxwsrpUp9HI8=;
 b=I58u61wrliDPjvaqpG0f0/+GsfpHKEbqFsWPR2LwRZi+tnjP6wAcUr1SU4t06tH0rVuBQES/+WP/1enb5CM3bGq9s2Idku1HrFrFnrTn1mcO0zqSUNZseT0RCJXseZaCU8IKMOyWfJiD9uBjsU5Z6vSIG0ysXD7kUk0wBDg9Kyc2Vkwk85eIK6qG48U52t9+lS0EXgi2xxk0lGRSAzVhgN8HE5jBFT4h6WvY13fI3R5LJ1J2Tq9TJgIODWyBcR1ThbNTl29MJvtyZcKYbvqsSIhV8jF+L6AhKc3Sd8AAXPcvw88XLyN3Qsrd89q6HF5yxJIIBr4gMjy7+cDkwJ6b8g==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GVXPR04MB10683.eurprd04.prod.outlook.com (2603:10a6:150:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 09:02:58 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 09:02:58 +0000
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
Thread-Index: AQHct4Eimn8S6FzOSEeZOEeRWCABYLXGvO6AgAAZemA=
Date: Mon, 30 Mar 2026 09:02:57 +0000
Message-ID:
 <AS8PR04MB8833AE3B8D106CE446EF89E58C52A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
 <kqv3x4qocp7rkas5oedlpzd43h3ez7dg26hqnfgubbjdhhxlwe@rfnsicbv7qba>
In-Reply-To: <kqv3x4qocp7rkas5oedlpzd43h3ez7dg26hqnfgubbjdhhxlwe@rfnsicbv7qba>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|GVXPR04MB10683:EE_
x-ms-office365-filtering-correlation-id: d10026d6-3c48-40b4-4bb2-08de8e3b234d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 TUqqQp6M64XwLYiT4TB/bi1bHzBpG2/4CvhQcy4Ty8aWeeXf1XeKIW4rVryceYC9eUQprKlC7sy6lFbK0NpqJnUzEnktEFSAeOetflgGX0t3PtVN50FSJzsekHVR3GKbQUH9/QuOYmxN5FsPogWfIzN39T89A21Qcht9a95KJSZXWYmt+Mp3npkjz5t4yK20mIcgMmoq3fnY6azgvS+7FdQmpExSoIvxVXgNCkBT3wiSzK1PfC+oXzRVtXuO4Sa8RX5YyWCEir6T2EJ9zhuha45cvnNDR/3qOW93BAB/0aW2h2jUQ1LRNWEMytaM+YlygaNBnXqTc4vD5gjGpp4PAXg8emPOdevttaEgLc4H9NHdspifEXUqY8u2fWg5g+MeFKN4cth5enQoXcRCaGpO0wl0sLrEt4qO2Vflc1yZKg2j/mWoPRmJ9YaPmem+vxxiFBDJ1mvnVH3uiMRkEZdDhQdFKWL8SrELAmDopeSCXyyPjzbx2Df3t8+l6d5gK32n4Bs81NISbHr0b4m76+IOgwiLqoSBM6mtTbwVSNOxpqOeb+oEhCQeSx0Z3Wk5lHNjBXyJsT6eQT3lTxUuIG6tSE6W3Kcf9uaMcQQF6cmWucttiknlyDZLPF55rOFFO6rVQBk/9iRX6HtHRIkwWd2uNsfwDPAH5cTdYqnJsCe8pHx7N3tsUjZcFVhqWROeKFxgQzFJuDJ8p1ZYh7FshKiVdYmb7d2Q5/HBDmw1/pUz7at7OzKJ6XyC7tboCRA3lqSbMZ6AD2unODQYrVMPS3cyUN9ya2BHgX2JSnb4MPhH1WM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDZkZXFZNGdNbW50dzIyWmIzK0NtWHgxZUgzMGovZ01rMTI0YUtIMlplTm1y?=
 =?utf-8?B?dit4RE5ZRDliZlArbmlpMmtqL3NsUHQwVzA2N1JQSFdMTDZBUHExOU5hS3FZ?=
 =?utf-8?B?VG9aNW5UV2R0c2hGdzJvenY1bEZFaEo2ZEgzd0JYellJaHNEeTZ4RFExYWtv?=
 =?utf-8?B?SDV5SWRqcDk4Y25tcmZleG1FeHhxeVhuWkdWUnRLdmVmeDJzelJKYWR2ZzUx?=
 =?utf-8?B?VkRkbW1GQXFNalFHblZtNWlpMTdJS1Z0alhabCt5QWQ4L1BXSzdhTC9jQ05o?=
 =?utf-8?B?VENDU2hCcHkraDczc0RkUlY5Tkk0YnpPMVBGem5IQmhJTHdHNkt5Vmg2Y1Zq?=
 =?utf-8?B?dWlWallsNGdmY3R2UGtYMi83aWl0VndUazlSY2JidWZ5c2UyVkZtdzNLL0RP?=
 =?utf-8?B?dVhPMjNFeHg5QXl0N29KZFowMWFhV0gvMk13SHNVYWFaTGQ1bDNmTUY4RWV4?=
 =?utf-8?B?SXZDT3VDOUJ3ZkxVcWNRT3NIRUorRlZPbkFtRFNDVFBMVHU3bnBhSW5VQjJZ?=
 =?utf-8?B?ZkNPRkVxa1c0YWtkbmFUelh5bktOWWZsU1BZL1FSNDFFYjZUdkkxVmJxbmFM?=
 =?utf-8?B?OGZYZmcxa2hIOW4yWFJIRkpFSnM3ODRPWG9iK1R3NlhlcXFWSGFXMndIVlp0?=
 =?utf-8?B?Um5lekxWN3FLQWdReXZ5Y3ZkQTVuVC8zK1lkeklNcTNENSs3eVBtMDRlT0RZ?=
 =?utf-8?B?L1ZhRmhjR2gzUUtOeDZSQU1mbWx4TUw3MnFmWTJkQjRGU1NmZ1Z1cEF6YVlM?=
 =?utf-8?B?Nk00eHk0RGhhd3RrMVdON1pJU3VtYmk0WXRLbnVyb04ybVJaVjZVamdHNGFK?=
 =?utf-8?B?STkvTE1HblNVVGRPOHpnMEpTQ29RaHhDam81QU44eHJtSHJwU1JvK3kvSFhY?=
 =?utf-8?B?ZEt5bDRCOFc1b2NtSlM4OTJmSDgxNzZ2T1ZqQmpXYUlhVGoyZmFZM1J0SjlO?=
 =?utf-8?B?STBlSFNjRmRydEtZUFBDWWEzV3pPTzhVK0gyaXJ6bXI2MThRY1RqZ0wvZGE2?=
 =?utf-8?B?TktuWXIwQ25Sb0VRcU9pZEgyeDBZUE1vSWd2bFFJNlFDb3NMaVVPa3FtME9R?=
 =?utf-8?B?Wm0yNVJ4K09MblRuSGMvb1BrcW0vVnlJdHBIUisydzZtTDBzM1hDWDdNZW1J?=
 =?utf-8?B?YjNIa2U3ODIzNFpjL0NRbzFIaGJSRmhhZFRJaHBYVTRXbGNPczZHZGJxUUtv?=
 =?utf-8?B?SzZEQU9EUXd4OHRWcG0rOW5KanNUVnB1c2N5R2lRTlQ2dURkTDhSWlE3UDRa?=
 =?utf-8?B?bUdueXdNSFlZQjVuTktSRUFJbHZBNW1rOVRqelh2YzZjOEZxa1NVMWRKTEdy?=
 =?utf-8?B?MGpOa2RGUWZjckhyTTVEVzNzUHIycXZqVXhveXgydXVtOGRPMmFWZG9HcHhO?=
 =?utf-8?B?KytmSi9qaDZsUzE4UDRLRnNWZDFHaDBxV1JUZVFsYlA1WlF2TVJvblZoSTFV?=
 =?utf-8?B?dXZPblRndlVOanI0azZwYTN3Rm45bWJVMmZNWFNTMVQzZE1tMWNTaE5mZUVo?=
 =?utf-8?B?ajVFQ1QySUhYVENRQ21PenlISmtiSVFETzJNcWhFeGxEY1VOS1FFdUViQms4?=
 =?utf-8?B?a3lGTUZRS1FVNVBDR2VkYjZTUGNmZjZlOERocXhRWHdVWXN1SHo4b2ZYTW85?=
 =?utf-8?B?RmdsQ1dOajNZckpYOWlESkw4KzZaUG82aTQxaE5TcUYvR0NibGZyT1Y1MGJ2?=
 =?utf-8?B?NDh3RWkrSmEvcWlwa0NPUmxwV1N4cXJSV2JqS2hBd2djUG5jalVkamdOSG5B?=
 =?utf-8?B?QVMzcXptSk1oRFQwU3Q3REFnL1BGaTU3TEwwem5vYTRyNjlTcmNYY2pBNlhM?=
 =?utf-8?B?cEJ1WU9ZWU9adGZyZzQ5d1Y1dDZxNlhudHhiYUFzbnJIUDdkbnF2c211WDJl?=
 =?utf-8?B?Q1dqS3BKUXhwSnJ5MngzeWZzZ2EzTHVKcWZqbm1XTDJ5Y21Kc3Z1Y2dTQTZ6?=
 =?utf-8?B?Sk1IOWNURUg1OUh4WWVVNm5Odzdjc1ZPbHhUeGRFbGRHSllXaVBOOVpjU2Rt?=
 =?utf-8?B?c0dtR2JwVDV0eTF4U2c4ZDZQWkVuQkZHRmkyajVqTFJ3bWhUU0NDalAyczhP?=
 =?utf-8?B?bHFReDhzeHZDRllWUk9ub1Z0c01FUmVaMzVpNU9Wb0ZXVHkxbkFXdzI5YnNz?=
 =?utf-8?B?aFFqcHdhcXVFNUtnN3R3eUNHdnNYRTFvb24wUThFRStCQ2Y3cnRhU2RtcEhu?=
 =?utf-8?B?ZEF2UDlqMnJYMVZuRWV3QXdybndLT2F1by9WR3ZXQWNNM2tQWU5CMTh4UXRQ?=
 =?utf-8?B?cDNTSi85Y1U3L2tUZGUrdDlRMXZZQVhiM1Bzb1NjTnUwS2d1KzFPbTJsZkU1?=
 =?utf-8?B?VjhQczBVUVhYRDVnM1pUS004Qit0MlI2eDZzZWZ1bG53Tzd3VXJ4Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d10026d6-3c48-40b4-4bb2-08de8e3b234d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 09:02:57.9651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxpET96/HJyZiYkVGPGu6u4W7S7SVOaL6GKPJjkkBfBhdPNz7nx6uaKcF+Ki5VXSp9pBLp7L0GjiYGmPEJEK6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10683
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231055-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,nxp.com:dkim,nxp.com:email,pengutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,AS8PR04MB8833.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 5AF40357C21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNuW5tDPmnIgzMOaXpSAxNToyMw0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJu
ZWwub3JnOw0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxn
YWFzQGdvb2dsZS5jb207DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51
eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IFFpYW5nIFl1IDxxaWFuZy55dUBvc3MucXVhbGNvbW0uY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyXSBQQ0k6IGlteDY6IERvbid0IHJlbW92ZSBNU0kgY2FwYWJpbGl0eSBGb3IN
Cj4gaS5NWDdEL2kuTVg4TQ0KPiANCj4gKyBRaWFuZw0KPiANCj4gT24gVGh1LCBNYXIgMTksIDIw
MjYgYXQgMDU6MTg6MjNQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gVGhlIE1TSSB0
cmlnZ2VyIG1lY2hhbmlzbSBmb3IgZW5kcG9pbnQgZGV2aWNlcyBjb25uZWN0ZWQgdG8gaS5NWDdE
LA0KPiA+IGkuTVg4TU0sIGFuZCBpLk1YOE1RIFBDSWUgcm9vdCBjb21wbGV4IHBvcnRzIGRlcGVu
ZHMgb24gdGhlIE1TSQ0KPiA+IGNhcGFiaWxpdHkgcmVnaXN0ZXIgc2V0dGluZ3MgaW4gdGhlIHJv
b3QgY29tcGxleC4gUmVtb3ZpbmcgdGhlIE1TSQ0KPiA+IGNhcGFiaWxpdHkgYnJlYWtzIE1TSSBm
dW5jdGlvbmFsaXR5IGZvciB0aGVzZSBlbmRwb2ludHMuDQo+ID4NCj4gDQo+IFdoYXQgaXMgdGhl
IHJlbGF0aW9uIGJldHdlZW4gUm9vdCBQb3J0IE1TSSBhbmQgZW5kcG9pbnQgTVNJPyBFbmRwb2lu
dCBNU0lzDQo+IHNob3VsZCBiZSByb3V0ZWQgdG8gdGhlIHBsYXRmb3JtIE1TSSBjb250cm9sbGVy
IChEV0MgaS5NU0ktUlggb3IgRXh0ZXJuYWwgbGlrZQ0KPiBHSUMtSVRTKSBpbmRlcGVuZGVudCBv
ZiB0aGUgUm9vdCBQb3J0IE1TSSBzdGF0ZS4NCkhpIE1hbmk6DQpUaGFuayBmb3IgeW91ciBraW5k
bHkgY29uY2Vybi4NClRoZSBNU0kgY29udHJvbGxlciAoRFdDIGkuTVNJLVJYKSBvbiBpLk1YN0Qs
IGkuTVg4TU0sIGFuZCBpLk1YOE1RIHBsYXRmb3Jtcw0KcmVxdWlyZXMgdGhlIFJDJ3MgTVNJIGNh
cGFiaWxpdHkgdG8gcmVtYWluIGVuYWJsZWQuIFJlbW92aW5nIGl0IGJyZWFrcyBNU0kNCnJvdXRp
bmcgZnJvbSBlbmRwb2ludHMgdG8gdGhlIHBsYXRmb3JtIE1TSSBjb250cm9sbGVyLg0KDQpCZXN0
IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBJJ20ganVzdCB0cnlpbmcgdG8gdW5kZXJzdGFu
ZCB0aGUgaXNzdWUgaGVyZS4NCj4gDQo+IC0gTWFuaQ0KPiANCj4gPiBQcmVzZXJ2ZSB0aGUgTVNJ
IGNhcGFiaWxpdHkgZm9yIGkuTVg3RC9pLk1YOE0gUENJZSByb290IGNvbXBsZXggdG8NCj4gPiBt
YWludGFpbiBNU0kgZnVuY3Rpb25hbGl0eS4NCj4gPg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+ID4gRml4ZXM6IGY1Y2Q4YTkyOWM4MjUgKCJQQ0k6IGR3YzogUmVtb3ZlIE1TSS9N
U0lYIGNhcGFiaWxpdHkgZm9yIFJvb3QNCj4gPiBQb3J0IGlmIGlNU0ktUlggaXMgdXNlZCBhcyBN
U0kgY29udHJvbGxlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IHYyIGNoYW5nZXM6DQo+ID4gQ0Mgc3RhYmxlIHRy
ZWUuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMg
fCAxNSArKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gaW5kZXggMjBkYWZkMjcxMGEzLi4wYjBkNmEyMTA0MDYgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNDEsNiArNDEs
NyBAQA0KPiA+ICAjZGVmaW5lIElNWDhNUV9HUFJfUENJRV9DTEtfUkVRX09WRVJSSURFCUJJVCgx
MSkNCj4gPiAgI2RlZmluZSBJTVg4TVFfR1BSX1BDSUVfVlJFR19CWVBBU1MJCUJJVCgxMikNCj4g
PiAgI2RlZmluZSBJTVg4TVFfR1BSMTJfUENJRTJfQ1RSTF9ERVZJQ0VfVFlQRQlHRU5NQVNLKDEx
LCA4KQ0KPiA+ICsjZGVmaW5lIElNWDhNTV9QQ0lFX01TSV9DQVBfT0ZGU0VUCQkweDUwDQo+ID4N
Cj4gPiAgI2RlZmluZSBJTVg5NV9QQ0lFX1BIWV9HRU5fQ1RSTAkJCTB4MA0KPiA+ICAjZGVmaW5l
IElNWDk1X1BDSUVfUkVGX1VTRV9QQUQJCQlCSVQoMTcpDQo+ID4gQEAgLTExNyw2ICsxMTgsNyBA
QCBlbnVtIGlteF9wY2llX3ZhcmlhbnRzIHsNCj4gPiAgI2RlZmluZSBJTVhfUENJRV9GTEFHX0hB
U19MVVQJCQlCSVQoMTApDQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR184R1RfRUNOX0VSUjA1
MTU4NgkJQklUKDExKQ0KPiA+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfU0tJUF9MMjNfUkVBRFkJ
CUJJVCgxMikNCj4gPiArI2RlZmluZSBJTVhfUENJRV9GTEFHX0tFRVBfTVNJX0NBUAkJQklUKDEz
KQ0KPiA+DQo+ID4gICNkZWZpbmUgaW14X2NoZWNrX2ZsYWcocGNpLCB2YWwpCShwY2ktPmRydmRh
dGEtPmZsYWdzICYgdmFsKQ0KPiA+DQo+ID4gQEAgLTk3NiwxMCArOTc4LDE3IEBAIHN0YXRpYyBp
bnQgaW14X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZQ0KPiA+ICpwY2kpICB7DQo+ID4g
IAlzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llID0gdG9faW14X3BjaWUocGNpKTsNCj4gPiAgCXN0
cnVjdCBkZXZpY2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiA+IC0JdTggb2Zmc2V0ID0gZHdfcGNpZV9m
aW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX0VYUCk7DQo+ID4gKwl1OCBvZmZzZXQ7DQo+
ID4gIAl1MzIgdG1wOw0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+ICsJaWYgKGlteF9wY2llLT5k
cnZkYXRhLT5mbGFncyAmIElNWF9QQ0lFX0ZMQUdfS0VFUF9NU0lfQ0FQKSB7DQo+ID4gKwkJb2Zm
c2V0ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX1BNKTsNCj4gPiAr
CQlkd19wY2llX2RiaV9yb193cl9lbihwY2kpOw0KPiA+ICsJCWR3X3BjaWVfd3JpdGViX2RiaShw
Y2ksIG9mZnNldCArIDEsDQo+IElNWDhNTV9QQ0lFX01TSV9DQVBfT0ZGU0VUKTsNCj4gPiArCQlk
d19wY2llX2RiaV9yb193cl9kaXMocGNpKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gIAlpZiAoIShp
bXhfcGNpZS0+ZHJ2ZGF0YS0+ZmxhZ3MgJg0KPiA+ICAJICAgIElNWF9QQ0lFX0ZMQUdfU1BFRURf
Q0hBTkdFX1dPUktBUk9VTkQpKSB7DQo+ID4gIAkJaW14X3BjaWVfbHRzc21fZW5hYmxlKGRldik7
DQo+ID4gQEAgLTk5MSw2ICsxMDAwLDcgQEAgc3RhdGljIGludCBpbXhfcGNpZV9zdGFydF9saW5r
KHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAkgKiBzdGFydGVkIGluIEdlbjIgbW9kZSwgdGhl
cmUgaXMgYSBwb3NzaWJpbGl0eSB0aGUgZGV2aWNlcyBvbiB0aGUNCj4gPiAgCSAqIGJ1cyB3aWxs
IG5vdCBiZSBkZXRlY3RlZCBhdCBhbGwuICBUaGlzIGhhcHBlbnMgd2l0aCBQQ0llIHN3aXRjaGVz
Lg0KPiA+ICAJICovDQo+ID4gKwlvZmZzZXQgPSBkd19wY2llX2ZpbmRfY2FwYWJpbGl0eShwY2ks
IFBDSV9DQVBfSURfRVhQKTsNCj4gPiAgCWR3X3BjaWVfZGJpX3JvX3dyX2VuKHBjaSk7DQo+ID4g
IAl0bXAgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQKTsN
Cj4gPiAgCXRtcCAmPSB+UENJX0VYUF9MTktDQVBfU0xTOw0KPiA+IEBAIC0xODk3LDYgKzE5MDcs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0gew0K
PiA+ICAJW0lNWDdEXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDdELA0KPiA+ICAJCS5mbGFn
cyA9IElNWF9QQ0lFX0ZMQUdfU1VQUE9SVFNfU1VTUEVORCB8DQo+ID4gKwkJCSBJTVhfUENJRV9G
TEFHX0tFRVBfTVNJX0NBUCB8DQo+ID4gIAkJCSBJTVhfUENJRV9GTEFHX0hBU19BUFBfUkVTRVQg
fA0KPiA+ICAJCQkgSU1YX1BDSUVfRkxBR19TS0lQX0wyM19SRUFEWSB8DQo+ID4gIAkJCSBJTVhf
UENJRV9GTEFHX0hBU19QSFlfUkVTRVQsDQo+ID4gQEAgLTE5MDksNiArMTkyMCw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhW10gPSB7DQo+ID4gIAlbSU1Y
OE1RXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDhNUSwNCj4gPiAgCQkuZmxhZ3MgPSBJTVhf
UENJRV9GTEFHX0hBU19BUFBfUkVTRVQgfA0KPiA+ICsJCQkgSU1YX1BDSUVfRkxBR19LRUVQX01T
SV9DQVAgfA0KPiA+ICAJCQkgSU1YX1BDSUVfRkxBR19IQVNfUEhZX1JFU0VUIHwNCj4gPiAgCQkJ
IElNWF9QQ0lFX0ZMQUdfU1VQUE9SVFNfU1VTUEVORCwNCj4gPiAgCQkuZ3ByID0gImZzbCxpbXg4
bXEtaW9tdXhjLWdwciIsDQo+ID4gQEAgLTE5MjMsNiArMTkzNSw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhW10gPSB7DQo+ID4gIAlbSU1YOE1NXSA9IHsN
Cj4gPiAgCQkudmFyaWFudCA9IElNWDhNTSwNCj4gPiAgCQkuZmxhZ3MgPSBJTVhfUENJRV9GTEFH
X1NVUFBPUlRTX1NVU1BFTkQgfA0KPiA+ICsJCQkgSU1YX1BDSUVfRkxBR19LRUVQX01TSV9DQVAg
fA0KPiA+ICAJCQkgSU1YX1BDSUVfRkxBR19IQVNfUEhZRFJWIHwNCj4gPiAgCQkJIElNWF9QQ0lF
X0ZMQUdfSEFTX0FQUF9SRVNFVCwNCj4gPiAgCQkuZ3ByID0gImZzbCxpbXg4bW0taW9tdXhjLWdw
ciIsDQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j
4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

