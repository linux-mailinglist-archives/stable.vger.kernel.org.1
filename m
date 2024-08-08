Return-Path: <stable+bounces-65997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BEA94B69D
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 08:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73D31F2386D
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1929186E26;
	Thu,  8 Aug 2024 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kp8qYiDL"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04A4A1E;
	Thu,  8 Aug 2024 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098107; cv=fail; b=tBT+c7NiNR75voOTwCge7TNMIbcm0oGR/IaYRv9x+jjMF+HbngbKSqaWGoDOrlFnEqki/1j7j47a9k33Gj7xLDF4fx7wDAJiy8cSPz4Laoqcld24jHIe7sPCBZ7TrXV5WHfhmuc8r9UY9IULZje0TuXZN9oJzht4yCHEAHXakC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098107; c=relaxed/simple;
	bh=4LG7yVWgYSeSdWpLnXJa8jQMJojTSHimGcLYuWI8dqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxqvJ9/xRG2O+TMqsWYN9m8lvrrTn6ZjmxSRySGdsggTYksdFRdlbvARfRn23YSL9bmg7lFkuRM8doJrBUx8i6i/F+F4kOvdZdxYbKDQfsJoagy2aQJAdx/gIjLzhzEhrGQnP4ZrzjF38aaMeycXv8UHJl4+n6LmTLLrYE5PGQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kp8qYiDL; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF5fxHoVl0HQmTecRV/QcYYhjEbUIw8GWki/78rkx+fOjFrRGQm+OEhC+Q7pOw0XaVis4DPl9JPxXfZVtPBGddXxgBP57gpA5d3aQii+DVd92CcvRB0dt6iA33r415qGW7l4zUIBXbpWDli8CCJ73f2Iuh1YWFGd3iaX92c1no5DFn5dZ34WEH6ErYVTksrvC4dHbBLfM/8Som9aDEhAunqST0Bbwd3b5TKkhvGVhtZ32YA5n7Ud2JoMJQjGMysF20oAwQ0s4K8t8FMZNKvTOp1Yco41UAPZfA7QVIVEq7mxltZAV7+LJ5B8xv2uSrm0L/yzcv8b8DRjuERJaf6qyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LG7yVWgYSeSdWpLnXJa8jQMJojTSHimGcLYuWI8dqk=;
 b=QgS2Gggr4no2oZQFR+28JKNJ6JTc+5CCzfCrO9E27o2b6PYSE9POrlKxf6bfiqS5tRTl4wuDZH+pQRekdY0hiZPa/0WkJtBZNry2P+xjqLj8SShkKuUff0/8CGENzIm6Ge5rDPz7hFouF77v/RbTcjy82zn2ewzZMXIYWuVQBQOuNyp0Ksen0Pze6tM63HdnmJ2ZosDarLmcXpcBYvWkKwY2qQQzqASBaIhrrqmNLPEqRtlJpaqlTL7ZRF1eF5QwEW8iWGzfH5T6Y298FTw4M6J4D8KO9ATbfDKUPq0AFXZxnjz52VYVi9WjlmSB3h09tkJ4fP4MktWsioJCW4OwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LG7yVWgYSeSdWpLnXJa8jQMJojTSHimGcLYuWI8dqk=;
 b=kp8qYiDLN72l1e9ZxifkDjt2/ydfXdhqawYUZg7cQdTpXQckU1ndBI38h+pHebLj/yPU3lDlv28zx2wnUHJx1GEpR+j9bu2l9+5NFXuJzkadFrgqT0Vtf+RHwtI8IN1j4l0ziIPbCRlFEzwr+blNf0eO6wWp91dXUPz9QTb/JDITJ4x8ERGixK8IyoySmoA4gMeKVKWr7H/8CVShH+pv6ZCFHwRZLu2WvVDuonP3BaCRV7+v3IPxtyN3R3kvEvyShm2NX+hyIfYu27m9/310vqWrv0lWgc1p5YatD3zHyD86oWQI+uEpptUnh8EJ1tflN8pnzYoLcN7ZH6qK60x/ug==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 06:21:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 06:21:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
CC: "tj@kernel.org" <tj@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-ide@vger.kernel.org"
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
Thread-Index: AQHa2aEYMAHnp4ur4EKNGMJk8l3hQbIEgLWAgA7NqZCACTJ0gIAAfSPg
Date: Thu, 8 Aug 2024 06:21:41 +0000
Message-ID:
 <AS8PR04MB867697E0983A68F51F074FC88CB92@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZrP2lUjTAazBlUVO@x1-carbon.lan>
In-Reply-To: <ZrP2lUjTAazBlUVO@x1-carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI1PR04MB7040:EE_
x-ms-office365-filtering-correlation-id: da62fdaa-a5be-49c4-e488-08dcb7725e1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UHdsaUlhYzhFL2ZHUklRQXdUQWxIVzQvYjQyendhYXpRSTFha09pQzFHYm5p?=
 =?gb2312?B?OUJBMElQOFJtV3REN2hyMnExUWI1dnlmTkcySzAydkNCcE5hUHF6ZHUrUnQ1?=
 =?gb2312?B?cnk5dTdwUlFnRHU2UlQ2UGlpdlZGWjUwSGhNSDhXRWovY1kwb05BRmJSUTVD?=
 =?gb2312?B?RFdhbUl2RFNhUmIzTzNIMkE1TDlaVTZqNzFqbGc1OGhpZklzRVlFc2tKblJT?=
 =?gb2312?B?NTdLejZrY0tmSkNMVHJmTU1EcW1iR0tvUmdrSG9wQ3lsWng0dEprb3Fzckcw?=
 =?gb2312?B?c1l2M25PRzJFMm1ZbWIxK2M3MzRBc05vLzg0d1lUdXMyZSt1SVlIZlpDMjVK?=
 =?gb2312?B?VHcrTFFZbWNReFY0RkpUSjFTMXhTSy81c1hlVmhFcnQwYUlzQ3dMQnhTQTF1?=
 =?gb2312?B?c0dxMzN2QS8rdkxKWERaMisvcTVQTzlBaEJZcXZ1ZmxURVNHb256V0sxazU2?=
 =?gb2312?B?dGtCMFFhSTY5TGliSFZSL3hQYkFiT0tHOFhNQVorUUZ4Tm5JL3dvNERUSGFi?=
 =?gb2312?B?amc3b2o0eWJ3MUVkSGl3K2JYUjRRR2xNTVk0Y3EvNFJ0WG1GVU1Mek5QSUo4?=
 =?gb2312?B?WXQrSzBkK05zZVdXNVlPZWRMcG1ZVnNqeEJqWVFMQmVTUjNVMCttYXdaZ3lQ?=
 =?gb2312?B?YUJDTVBzRlB6RDBjRyt0d2NmblhEQ2EyeHUrUG9lYlloT1BMNWY1bUtqczh2?=
 =?gb2312?B?V1Q1eitodHFkYm1jT3V1d2kyL3NZa0lkdmRoOXRFZGJ3RzN0UThhODRkck50?=
 =?gb2312?B?bXVuVXZSS3Zaa3o3azVtbkxtQk1OUG0wZFFzM1AyZEVJbXh2QkVNS1cyUWNs?=
 =?gb2312?B?U3ZIeG9QdGx6cUNGeHlhZ1d4TWFndXlwb1lldUJ0dTF4eWxvNUk2bDlOK3hD?=
 =?gb2312?B?TnRSR0E4ekhxUWZ1TkV5bUFlSFY1Wks4bi9EY25JcEZMenB6S2RlQTN1ajBJ?=
 =?gb2312?B?L1h2WWZ3Slh4VXFTdWtUM2syRnVvSWNXLy9vQXJucGRYbU9BcWpWQnl3WjlR?=
 =?gb2312?B?RDhyMUFDTGg4UFM3TUlvazllbmsrcWI2dWFSWmRmUm4yV1BIUU53NlR6Sktx?=
 =?gb2312?B?bUk5VEMwb0dVSXNMcFZ5dWlXODAyMGlkZ3hwaW9RSDFoYTNnQW9HeTB3Nm1h?=
 =?gb2312?B?dEhjOUpCd3h0bDR0aWhTV0tBYW9LNnFqWVFydFhVU2VIRi96K2VrYXQ0Z25I?=
 =?gb2312?B?eXFadDlxZGFlcTJvamNPOU54d3d4R0pNZWJGTTl4ZzBLajNFdEkrTEh6VmRk?=
 =?gb2312?B?VWJ6QjR4Q2dRejJjUHU0cWRrdSt1c3hwa2t1Q3R5b2NjKys4OWVpMVRCSXJS?=
 =?gb2312?B?SkNySXFsa29GMXFLUG9zRzQ1Mi9yU1lNZ2VQcHJ3MzIxSVdmUExQbmxYUnp0?=
 =?gb2312?B?MXlCSVVJbEJmYmN4VTBwbW9hNTM3VDNsV2s1V0RhWlBUT3dWVzNVa0tFQi9D?=
 =?gb2312?B?aTdZNTQ5MzYwRVFHbUFXWmIzR3loL1JXTkswaUtXYXNZd0FWQmREQTBKcnhQ?=
 =?gb2312?B?ZWZRUEE2MzFNd0VvRmpNOHRnVUVaNzJVOHIySTNXMFBEZU1TTFd3ODNtWU0x?=
 =?gb2312?B?WDhiaWJBbXI3ZmFzZVBMK3krZUQ2VXhhYkNkT3pha2dTdTRZbVZxNDkyY3M0?=
 =?gb2312?B?QmlmK3pGMi82WUFlSWV6LzBVS3F6ZjZUN1NCeHRDTjJNOXRMSCtsMGwyakZM?=
 =?gb2312?B?WWsyb1VOTVE2dHdOUjVVcjd1aFN1Y3JFTFplOEMyWU9ua2VzNXNITmlVYldl?=
 =?gb2312?B?VC8wdTNibW1lM252R1E4ZWxBZkpJRlYxNHNSVU9hOFIxME5HNEdOWTB4TUZm?=
 =?gb2312?B?TmVlbWtZSzNPMFFHOWxBMHRBSmo1TXNqSCtYL1pEWklGR3c1SzlKZ09tUlhK?=
 =?gb2312?B?V0ZCRUkwa0lVR0tkTkc1bGFleDZlSG1yL1QyeWFFTEVLREE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SnZxbC8reFMyZm42d3BraW41U1d3bERnYzFlSjE4ZUpCV0pNL1BPK0NSdlN3?=
 =?gb2312?B?bGNhUmYvZ0dXcXdyUkI3UVdYUldFSEJOTE1sM3U1MEt6ZGF0bVJTdkxzVmQr?=
 =?gb2312?B?WWIveTRCWXVZdXFURGtXc0RzQVlxUkZrbWkyRHNDUnFKdlF1aEJOcXRKSEZ4?=
 =?gb2312?B?OFRtS28xY2dFQ0xyNUQ5M2phZ0hmNDEwdlZDNFBHdjl2VGhScTZQSVRlYU55?=
 =?gb2312?B?RkRFVEMzRU9rV3ZXVkdRai94M2RZSG14eE13RkRGTGt1QlZSeTFGVkhUQVJn?=
 =?gb2312?B?cVZvWHJJWC9PRS9JMUJvYlFVZ0xuT2YzTWVYRHBUaFROMkhNODFJdkpGUmk3?=
 =?gb2312?B?L0lTK1NNTzlNSEZkaGYwVFM5NTRqN3g1WTZMUElzV3hSZGlKbDZwdlFpRDFY?=
 =?gb2312?B?L1phLzZuMEVSRVlVU0JsTGhWUUNsOWh0WC8zZko2RXNkZnExNXRWckhLYWEx?=
 =?gb2312?B?Wk9OTG1QK0Z3STNjTFZud2ZMQ1FQbW42Q3NVRDk1akk5TWpsdG1La09nRzRm?=
 =?gb2312?B?blhtR2o2V2Q3dVhYTWxOYU44UEgyb1NxOG5pUmRoMGd4U3E4dHhTbUc3T3Rp?=
 =?gb2312?B?Z01YVmxXZjEzLzIyYjBsTlM1QmJ3STNxVWFjdyt6bTJpVmlvWXgxMVlCdlkz?=
 =?gb2312?B?R1NVcERuaTRsREFNQldET2lYcmpaWTB4R1JyclpjV3RUMWVaVnlnTGd2SlBT?=
 =?gb2312?B?ZkdIZUlXZUQ1U0c5TnJha3hkSWRMTU80VUpoTkNYMFBVZFRRK2Y2NHp1Tm5v?=
 =?gb2312?B?QWxoTGgyQ3RLWTYvL0R0ZENVdmNuRTFlcjUydlVzbFpua3gyaC9wM203Tmlx?=
 =?gb2312?B?eW9MbE1XandSMks3ejRzd0xGS1owM0FRSHp4d296VG16UEI1c2FjNmlGN3Za?=
 =?gb2312?B?bDM1d1kyYUh5QTFaVHBpR1lZRzRtK09zdWhPWktHdHpJckt0SG5Yd0RlY05u?=
 =?gb2312?B?anpnSWh0cGZsUHZhQnBNM2Z4bWE4QU5xVi8xSi9NUmRKV1RId3hwbWRuK2Jk?=
 =?gb2312?B?YnlJRnBEREtVWXdrdE5yeW9OV0ZOcjZwQnk5VEs4SUsxUVREeXVzekNlTEQ0?=
 =?gb2312?B?cGpBS1RBM2Rhbys0RWFjbDhqT3VtVEJNL2lQUHFaeWtEY3ZGcnQxa2xwMGlL?=
 =?gb2312?B?MFVrRTRkY2VSQ0xlaU8zLzFQV0EyMzRXTmord21ISmhtZTFCbS9DdE5tZEVB?=
 =?gb2312?B?S2p3dnYwMTBKVlZYSVpRbStBRExRODJnK0JNRFRyQ1poZkNBSTNaZ3lGcW5x?=
 =?gb2312?B?dXlRU1RXdHlwaEM3SWVhMG9kVjhWYVFZSDRZS01nc3VseUVLQXNvZVFWZE1Q?=
 =?gb2312?B?cWVBc21OUGg1Qm5zMEt4RzdyaEViT0p3NFFlRE5uKzBCcEtMYS9pVkRHMENp?=
 =?gb2312?B?Z1A4VkNWbmxGeE5UWG1oVytlblhpWHNobnp6WVBqN2dHTkJ6ZGpLaS9TeVRQ?=
 =?gb2312?B?a3JHWVJuVy9XWnJnUTRXWkpaV005dFJZcWRxSThKNGdlMjM5aEJsdXpHOTdV?=
 =?gb2312?B?VTBNcFRiTUxZZU15VThsbFpQcnBTNHcybk1vaVk1b2wyQzFCekdjWlFPemV6?=
 =?gb2312?B?R1pMNU1vS0VlRGxqaFc2TXI4WHpXUVBXY1IvTkJHV0ZUVGREVzZKSUptcGJL?=
 =?gb2312?B?MDIrbm9OU2RwSGtHeC9GeUJxZDF2VzNVR1gwM3ljaFBRdGp1NUhWTStLcG8x?=
 =?gb2312?B?OGxrendqeTZYc05HRjlOM2NUZG5pRTduZk0xU1N6TW5lSXBoampaaGxyUEE4?=
 =?gb2312?B?bzhaM3BlbXdxU1VJNklnd2dTZXpTN0hQcVpXQXkyZDJocmhuc1hRME44Y3hP?=
 =?gb2312?B?TnBhTUlmYjlvUW42ajF1am9yWnlFRk1uS1k3T2x3WEJQbUJkRTNJN09QZlZU?=
 =?gb2312?B?WEllcmNEUlk1YWoxR3IrTnorQ3dwRERtdVlHRFNXV2xiTCtpdFdLcGYzOUJV?=
 =?gb2312?B?bW9ZTi9mRWE2TFNUT3VqRy9SVTFlTy82ZTI0dWZoN1B3UEtOWFltUDkveWZM?=
 =?gb2312?B?bUJ3bGxDOXJndGZjNGw0RGVjc2VMeHlKdWNYSEMxdkppcXhTNWlKcHhoUXdl?=
 =?gb2312?B?R1FCYU1UZXl4bjV6N0dQWlI0QzhqVG4zWllEZzk1WUU4SmZ1dEVUOFB2a0Jh?=
 =?gb2312?Q?5z4KAHqvAes5cx/ovLN+mWY2u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da62fdaa-a5be-49c4-e488-08dcb7725e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 06:21:41.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXevCEaPHTAGK16ZyRZyDC9ZtWhdKt8f5GxJZ6/jwEz8kXr6OBCorkp2zZ/s5htcdsd0GGVnuUCSsOFr9r/mHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgQ2Fzc2VsIDxjYXNz
ZWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqONTCOMjVIDY6MzUNCj4gVG86IEhvbmd4aW5n
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiB0akBrZXJuZWwub3JnOyBkbGVtb2Fs
QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25v
citkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNl0gYXRhOiBhaGNpX2lteDogQWRkIDMyYml0cyBE
TUEgbGltaXQgZm9yIGkuTVg4UU0NCj4gQUhDSSBTQVRBDQo+IA0KPiBPbiBGcmksIEF1ZyAwMiwg
MjAyNCBhdCAwMjozMDo0NUFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPg0KPiA+
ID4gRG9lcyB0aGlzIHNvbHZlIHlvdXIgcHJvYmxlbToNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2F0YS9saWJhaGNpX3BsYXRmb3JtLmMNCj4gPiA+IGIvZHJpdmVycy9hdGEvbGliYWhjaV9w
bGF0Zm9ybS5jIGluZGV4IDU4MTcwNGU2MWYyOC4uZmM4NmUyYzhjNDJiDQo+ID4gPiAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jDQo+ID4gPiBAQCAtNzQ3LDEyICs3NDcsMTEg
QEAgaW50IGFoY2lfcGxhdGZvcm1faW5pdF9ob3N0KHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2
aWNlICpwZGV2LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYXAtPm9wcyA9ICZhdGFf
ZHVtbXlfcG9ydF9vcHM7DQo+ID4gPiAgICAgICAgIH0NCj4gPiA+DQo+ID4gPiAtICAgICAgIGlm
IChocHJpdi0+Y2FwICYgSE9TVF9DQVBfNjQpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICByYyA9
IGRtYV9jb2VyY2VfbWFza19hbmRfY29oZXJlbnQoZGV2LA0KPiA+ID4gRE1BX0JJVF9NQVNLKDY0
KSk7DQo+ID4gPiAtICAgICAgICAgICAgICAgaWYgKHJjKSB7DQo+ID4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBlbmFibGUgNjQtYml0IERNQS5cbiIp
Ow0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0KPiA+ID4gLSAgICAg
ICAgICAgICAgIH0NCj4gPiA+ICsgICAgICAgcmMgPSBkbWFfY29lcmNlX21hc2tfYW5kX2NvaGVy
ZW50KGRldiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIERNQV9CSVRfTUFTSygoaHBy
aXYtPmNhcCAmIEhPU1RfQ0FQXzY0KSA/DQo+IDY0IDoNCj4gPiA+IDMyKSk7DQo+ID4gPiArICAg
ICAgIGlmIChyYykgew0KPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRE1BIGVu
YWJsZSBmYWlsZWRcbiIpOw0KPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByYzsNCj4gPiA+
ICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICAgICAgICAgcmMgPSBhaGNpX3Jlc2V0X2NvbnRyb2xs
ZXIoaG9zdCk7DQo+ID4gPg0KPiA+IEhpIE5pa2xhczoNCj4gPiBJJ20gc28gc29ycnkgdG8gcmVw
bHkgbGF0ZS4NCj4gPiBBYm91dCB0aGUgMzJiaXQgRE1BIGxpbWl0YXRpb24gb2YgaS5NWDhRTSBB
SENJIFNBVEEuDQo+ID4gSXQncyBzZWVtcyB0aGF0IG9uZSAiZG1hLXJhbmdlcyIgcHJvcGVydHkg
aW4gdGhlIERUIGNhbiBsZXQgaS5NWDhRTQ0KPiA+IFNBVEEgIHdvcmtzIGZpbmUgaW4gbXkgcGFz
dCBkYXlzIHRlc3RzIHdpdGhvdXQgdGhpcyBjb21taXQuDQo+ID4gSG93IGFib3V0IGRyb3AgdGhl
c2UgZHJpdmVyIGNoYW5nZXMsIGFuZCBhZGQgImRtYS1yYW5nZXMiIGZvciBpLk1YOFFNDQo+IFNB
VEE/DQo+ID4gVGhhbmtzIGEgbG90IGZvciB5b3VyIGtpbmRseSBoZWxwLg0KPiANCj4gSGVsbG8g
UmljaGFyZCwNCj4gDQo+IGRpZCB5b3UgdHJ5IG15IHN1Z2dlc3RlZCBwYXRjaCBhYm92ZT8NCj4g
DQo+IA0KPiBJZiB5b3UgbG9vayBhdCBkbWEtcmFuZ2VzOg0KPiBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZkZXZpY2V0cmUN
Cj4gZS1zcGVjaWZpY2F0aW9uLnJlYWR0aGVkb2NzLmlvJTJGZW4lMkZsYXRlc3QlMkZjaGFwdGVy
Mi1kZXZpY2V0cmVlLWJhc2ljcy5odA0KPiBtbCUyM2RtYS1yYW5nZXMmZGF0YT0wNSU3QzAyJTdD
aG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Qzk3Zjg3Zjk5DQo+IDM3ODQ0Zjk3ZGJmNTA4ZGNiNzMx
MzQ1ZSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPiAlN0MwJTdDNjM4
NTg2NjY5MTc1OTgwMDQ0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUMNCj4gNHdM
akF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0Mw
JTdDJTcNCj4gQyU3QyZzZGF0YT1QTzBiUVZVQTdvNDdIQWVjT3AyN1RLd3dOaUcxeWRmUXE0RFR0
Z0V2YSUyRmclM0QmDQo+IHJlc2VydmVkPTANCj4gDQo+ICJkbWEtcmFuZ2VzIiBwcm9wZXJ0eSBz
aG91bGQgYmUgdXNlZCBvbiBhIGJ1cyBkZXZpY2Ugbm9kZSAoc3VjaCBhcyBQQ0kgaG9zdA0KPiBi
cmlkZ2VzKS4NCj4gDQo+IEl0IGRvZXMgbm90IHNlZW0gY29ycmVjdCB0byBhZGQgdGhpcyBwcm9w
ZXJ0eSAoZGVzY3JpYmluZyB0aGUgRE1BIGxpbWl0IG9mIHRoZQ0KPiBBSENJIGNvbnRyb2xsZXIs
IGEgUENJIGVuZHBvaW50KSBvbiB0aGUgUENJIGhvc3QgYnJpZGdlL2NvbnRyb2xsZXIuDQo+IA0K
PiBUaGlzIHByb3BlcnR5IGJlbG9uZ3MgdG8gdGhlIEFIQ0kgY29udHJvbGxlciwgbm90IHRoZSB1
cHN0cmVhbSBQQ0kgaG9zdA0KPiBicmlkZ2UvY29udHJvbGxlci4NCj4gDQo+IEFIQ0kgaGFzIGEg
c3BlY2lmaWMgcmVnaXN0ZXIgdG8gZGVzY3JpYmUgaWYgdGhlIGhhcmR3YXJlIGNhbiBzdXBwb3J0
IDY0LWJpdCBETUENCj4gYWRkcmVzc2VzIG9yIG5vdCwgc28gaWYgbXkgc3VnZ2VzdGVkIHBhdGNo
IHdvcmtzIGZvciB5b3UsIGl0IHNlZW1zIGxpa2UgYSBtb3JlDQo+IGVsZWdhbnQgc29sdXRpb24g
KHdoaWNoIGFsc28gYXZvaWRzIGhhdmluZyB0byBhYnVzZSBkZXZpY2UgdHJlZSBwcm9wZXJ0aWVz
KS4NCj4gDQpIaSBOaWtsYXM6DQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGtpbmRseSBy
ZXBseS4NCkluIGkuTVg4UU0sIGJvdGggQUhDSSBhbmQgUENJZSBhcmUgY29udGFpbmVkIGluIEhT
SU8oSGlnaCBTcGVlZCBJTykgbW9kdWxlLg0KVGhlICJkbWEtcmFuZ2VzIiBwcm9wZXJ0eSBpcyBk
ZWZpbmVkIGluIEhTSU8gZHRzIG5vZGUgYWN0dWFsbHkuDQoNCkJUVywgSSBoYWQgdHJpZWQgdGhl
IG1ldGhvZCB5b3UgbWVudGlvbmVkIGJlZm9yZS4gVW5mb3J0dW5hdGVseSwgaXQgZG9lc24ndA0K
d29yayBmb3IgaS5NWDhRTSBBSENJLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0K
PiBLaW5kIHJlZ2FyZHMsDQo+IE5pa2xhcw0K

