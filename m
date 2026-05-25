Return-Path: <stable+bounces-254085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mINKAxnnE2pdHQcAu9opvQ
	(envelope-from <stable+bounces-254085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:07:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7C55C6323
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B760630166D2
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E41355F2B;
	Mon, 25 May 2026 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="edgt9v0B"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7E376469;
	Mon, 25 May 2026 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689217; cv=fail; b=M+nptlDZvss3Fr+jCuyNb6OxcnewkJgPqOAM3D5OwMK2bFB4dumRmbqpn7+ben0egdbUSuYYSHTDZT3RoygKEPeKAtO+9bM6ENWTnwQ36FddjP/agxKkbqWBS1cj0PKe09y0pvNBJ/F7mZz8KACGINrDzcfXIgOB+F0U7WrePPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689217; c=relaxed/simple;
	bh=Lz2TL2lYgNc+cmVMAWjqB39bHn/DRiiB7zDCykiPAas=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i+d/NtoLB4WCl3AUIMAQroe1U4EMKqlqV9OxA70ESxp4ykngJ4iKLJCrKZqQEQ/qH/AD4PQOEoXcqfGZXD8XFiTJvmGy6UV/FRQF+vbPaSZ2I4daV8mdPS43/tiEgpN1geaAT5S1Rxq0ZeQjjIyK5n0m3BinEA/mKlV3KFR6OIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=edgt9v0B; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxIIfCYMc1QRXQsSZCOe/j9lR/XjbD1/fYJ7XjKMHoWh3j2Z/iuE0tVkZTdvb2il85JhRO9qg3BT1LdaxHeu2ZLC57NRLz64tZlH+Q1GpyX95TRU+DYt32hQKGyvmZPjIFczoYwZ/oFfv+Hob+9RkhjpOv2+CPFCSyOAq+/Y9x2cThSnF89bSJuKqA0oH69qVLDFtWvWQAxdy/ZrJZJM2cNxCvJw/9KxaeSVpbYo757WhIHrJ5mnrIuiuTMpeobJh7oMzUxpagVeMtPJpHhc/uRHsouf96LLcGBZy/MbvUdcLHClEMcLESEjp4DUhYVBNjjy+6Y6voq9buaH0rccAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WZbDeF4u00UQPAYurcl4/k/Chqg45PP3oLUoPvVgMU=;
 b=Ve4JmF6AhzM7g6/VQQTCAIaqP90VfHUhct8ulovowJyA4LVRAJ+Qf+x0o2u75pIT6uDy8Pu6B4QaBTPO105wdZD5yW2nD/lKEu3c4Q+Bf8TDZseAm/uJmkn90n8T97uKAAv21ACNe5rxeXn5wp1a4GVjzULnaOFAVnEEdBkvw3WRTnZqwUfjBT7dXz4Mml88xP64ozbe6qC4uAPOSvpIco3WqApATjjfxMtnN4z6BVIG1BSavhMGOO9HSupBvru71hFe15JypKChb/nf2eca2MeVDbxb+jKdRQCqAiJ2s5WzZ6/zUfvfUyVbUVRVcXUekuf/brkoPA6vWay4DC6VZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WZbDeF4u00UQPAYurcl4/k/Chqg45PP3oLUoPvVgMU=;
 b=edgt9v0BEljo3QANep9DIdACJ1VgLkJ+gHzKjDGy80dHUHRXz0pDxHU4QkKtFBf7bkW6BoK6DDiCK5tbc96AOy85vuf3NJ0FbjSv5zFtpiYHez4dFtXjSM4Fwh3/gOMH3QXSPl6hxq/IpQQ2cSQX8gWCUi/KSxG2Yz/doxziptjtUf+ihBpZzO2pYr4My10yzj+rR298ku3AmgkXwykxiLElDbZ3BrZ6+gq/3jwXYhCK6x9enbmTpU+04gtMY6AAFxBFnpS7ERkPyzibP1Po6S6OLenFcPtmdXyT6RmP28F2Kqldoo728VhqN/uPlYYemFlFMkeb7+SjYq+ZOdASQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10725.eurprd04.prod.outlook.com (2603:10a6:150:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:06:52 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9891.019; Mon, 25 May 2026
 06:06:52 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 25 May 2026 14:09:19 +0800
Subject: [PATCH 1/2] software node: fix refcount leak in
 software_node_get_next_child()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fixes_fwnode_iteration-v1-1-a12903fb2919@nxp.com>
References: <20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com>
In-Reply-To: <20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779689386; l=3168;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=Lz2TL2lYgNc+cmVMAWjqB39bHn/DRiiB7zDCykiPAas=;
 b=VUcBxcPK2Ht6gfSLFj2SvkxO4z2HNFJek9ny5emJPKIiAgE+U4uqfG10xxCyz/AUUjhp2sgbP
 eFDv8rhNrKFBVnsGBXroGujVnm5qaQHaScshtC+QqP7hOUVpSOnCw8I
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB10725:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d52220-ab79-4edb-aa44-08deba23d0d7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|18002099003|56012099003|22082099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
 4WL52nATKsuhCwkREdseV/03NNojdj7SlSqp6E2kW1FZq/srCUXknUdhkS4JPm7B5QmGytwZ9yj6xfxcjfrKsl47fD+0050IeHaN7VlfPa8fkm9KDqj613GM8XcBVy6ZWTeZkH0cad0r77+oBUXkeYO4DSVt1ZhjkxuoGnD4GAU53Q2SIqfVAWKK1GHsj6E8vkTq5HzMv1u7uUesHp4XmNfgiAj8zbBrSIneg/eP3cmLsxI5MfS7UP7RxFfnFkBf5V0yw3q7RnlEoziTQetbQVPUgEXEWizZijh/wvIN1rA4J0ne4I9iyYhuctwEIzrgYntaIxTY7wH6w/IVjLb8yhsedZl+4302e6id4gi1WrAGXeuYTWDsIoFBXhCxI2c3JboTK1aoGmMn17TtjTw6ea5ttdFrOSRCsVsM9O/fMNZ/qcCrsFJdfejC7UcIgpZ0aTTxWBLZTA7eNovF8t/rHDyMWDd259S7GzdiM2iJ0uaNtXYdVHViPhQhqY7cq1+6sdHT4Vf5syIa/+iEbs4+ouI1rotunG7UW19Sme+7dxywcXj/uQg7j8aFvco/OQN0oZRIs8xFFxJKBAn/AA7D0ClTjSn9Cw5W8lKqcBAQECOyO2QKxkSMrJTmvWcXDl3cOdF8P+nWppoj7l2F8EbFPLspoKmZ2czs8vQmxuSNIY5ZEnyppF2cc7iYLILz0SxyzyJ0iwpJvAtDXqds0fsSdnNjegD4ZirLmqtEriJfmXzNJIQI91xnzNJ9RfCkD7FO
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SCthTCtVQVdLZU9NRzFsMWV4YzZsY0RRVVhhcnVOMmxVUDdBTlNSbDA0YWo1?=
 =?utf-8?B?T0Y4dmtxeWswQ3puWSt4aGY2ZXZRTlNqTjBsTjZaTFE0NSt1dnZSTEI0bjdT?=
 =?utf-8?B?KzRqM0JIY1ZSZWUvckdtT2JKMklYUnhtcWhBS3o3NDMvSndHaXR1UGNIUFV0?=
 =?utf-8?B?cTlkb2J4aEVGa1VCdG1jYlZJblBaMVNHWnNxbzhmWEZsTjN4cmc5ak0vSUZW?=
 =?utf-8?B?M0x5aUFoU3FDblkyQWpEZWJ4YzZ0aGJNNTR1UVZIbC9IcTI5VFpGcUtGZzdT?=
 =?utf-8?B?Zy90MWV3RlE3anpBWGxtaGtNK2tmb1IzakJienk1a2lyWm41YmFXYTk5V3pq?=
 =?utf-8?B?YzZDRVQrZGJrYXFmWkZMZnl6RlBQRDdUcVJabEpyaE9LcTF5eGpjV3BMaUpl?=
 =?utf-8?B?eDI0M1VuM0hXRkF1STM2TW9RdW9MMGg5RXFlWjdRMC8yZjF1eUpQMjhHdmNM?=
 =?utf-8?B?ampGWG9pZnZoL3E4dmo1YjJITFVQL3Z0WkhiTDhodzRwSXNBZlZSRzlSTmV6?=
 =?utf-8?B?V0UrVnRGZmZiRHhEODBOd0ZQd1V6WURrdGI0ZGRoNjBSSFB3aFBjMnV4KzBS?=
 =?utf-8?B?MWR2THFVZU5SSzlVZFBTSGVoRUF2V3hmNDhleklIblowV1ptZ0o0ckF6RHBQ?=
 =?utf-8?B?ZG9BekEzUitvbU9Sdmk3T2E0SGhxVW9KSWptUXRQN1kweFp3NTVLT2JmZzR2?=
 =?utf-8?B?a3JVRzR0YnlDeXU1Z0FrMU9ZYURycHZxeFJ1eDAzVjZPMnkza1hKdXJPNU9B?=
 =?utf-8?B?TWdlV0w0bHdiQ3UzOXhjRHZUaVJtRDVDQjNob0dxK21ZRm1SWWtOZmVaYkpn?=
 =?utf-8?B?MXF6WGYvc1ZERjdEeTU2bFZWU3VINXk5dllDcmdtaXV2YklxMEZkZUo3TW1Y?=
 =?utf-8?B?VkZRVVkxbUpzdlhqMzVEUVQrRmxZenNlNDBmeWdiaG5PZFBZQ0VNRjR4cUNt?=
 =?utf-8?B?SVJzL3VTbmJEWG92czUzTG1sS2pwdzBHS2VOMXpMTXdKdGh1eW5BVEwwQ3lB?=
 =?utf-8?B?UTMrbU1FM0U0b2s3c25kKy96alhoNC9ZejVpWHRTSmpmeEE1NG1DazAzbEFF?=
 =?utf-8?B?U3hKVzk2NDRXUkJpTExiemg0RXRLUEIrbE9BMkx2NDRTelQ3THFxdGtGWENJ?=
 =?utf-8?B?R05KNmVWWC9aZWROVGovOVI2QW5YQWFpaFB0WDJ3ZnhiZ3ZXMDhGMVRqbmQ5?=
 =?utf-8?B?NDlGSkZQMEduRWVmd0NzOEVUUnlsNjc1NXNIZW1UYklmd0xudDlmVHZrYzZu?=
 =?utf-8?B?SDVxNHViSWRsWW0wam1VSnNwTmc5SUwxd1I0ZS9RWXFTRXEvY28zT2hRQU1t?=
 =?utf-8?B?OER2VXdMQytQbFMrYUxIeEFzZXdNVjJXWnJ1WVBQa2RYZEE3MTdvSUVxNWhE?=
 =?utf-8?B?ZjdGZElQMEZhSUVXb1ZqdlRUNWhkUkVMN2pLWVRMZFl4bjJwVmRFYWdGaTBV?=
 =?utf-8?B?SGQ5NUc3VlhPdlEyL2NkaXBuSFdNZ1VVNmlBUFErbXFjTHRsdUtMdjRpRVNo?=
 =?utf-8?B?Szd3WHZCL1I0T2ZpZmJTK3lHL0crM2l0OHZjdS8xQWJaa09EZGRqNElQcDk0?=
 =?utf-8?B?MithbFRyREhucVZEbVRPdDA3N1UvMmI2RC9QaDNnVk1mSmtBNmVlQ3UxbVR1?=
 =?utf-8?B?NFY2ZGkzYlhZMStMckIwa293b3hzYXJUUlJhU3BBeW5GUVNPUVVoSlZQMURI?=
 =?utf-8?B?b3hvRzlDK2p1ZHY2SzhBU1dTZWU2cW1PNXdpa3ZFSmtQdFRpMGhERURuamgx?=
 =?utf-8?B?MWVGdGVCN2RTYjNPR01rV3RXT3Q2R3lRVHNsNUNKWWg1UmowenYrWFpjelVu?=
 =?utf-8?B?eUZVLzlhR3FuelUwVnVxVHB2RVBtM3dTRFgxYVpEMlNjVC9LUnpybVRUNVBQ?=
 =?utf-8?B?M2Nma1MxeHJtS1BSU1VxN0JES1lqV0RaOUg1YUJab1k0K0NaVURTdnZQYXRW?=
 =?utf-8?B?OCtLRXBKZXUwblJyRnpxa3prenVMVnptenRXVmhwenp2SlZqUDlGMURnZ2ly?=
 =?utf-8?B?WGZONVdhN2dQcjdlY2s0ZmdZbFRpNmhhck1QNzAzRld1bGxOdlVDVFBsRndp?=
 =?utf-8?B?MXVhZXFnQ2psM2ExMEppZlJFWENYU1Iwc1BNVkNjOTJXT05lTUtxOElFMEZl?=
 =?utf-8?B?dTYxRUV4bUNLay9PS3pmY01tN04yS1dSM01pZWI1QU9WZERFNUxZUTJSTVA5?=
 =?utf-8?B?QnlJSVlZMStRcVR5WWZBbUJjNWNNdUpsVksrdTdMNDVlVXBuK0QwbGJ1bW1C?=
 =?utf-8?B?OUx6UDl2c2p3VHQxOW92L1VGckcwOG1kL010QVlZREY0clZITVIrUUxwSWI3?=
 =?utf-8?B?YU8rT29QS3FLclJqMW9VZTkzK08yeDZhNWtGQ1pLYnUzK1YxL25tZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d52220-ab79-4edb-aa44-08deba23d0d7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:06:52.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AV05kmEFjhda3dvEemSZKfMHkWGsGYJhKdVYfC0PfhWhMrPVF5nVdGCOhGVdtkrQkMGjm3Dl5qxxq4uiyi6JjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10725
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254085-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,linuxfoundation.org,kernel.org,ideasonboard.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4c100000:email,nxp.com:email,nxp.com:mid,nxp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,4c010010:email]
X-Rspamd-Queue-Id: 7F7C55C6323
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a swnode acts as a secondary fwnode and is participates in child
iteration, a refcount leak occurs for the last child of the primary
fwnode's children.

                   Parent      Child
  (Primary fwnode)   FW:   {FW1, FW2, FW3}
(Secondary fwnode)   SW:   {}

In this case, FW3's refcount is decremented twice during iteration:

 fwnode_get_next_child_node(FW, FW3)
  1. fwnode_call_ptr_op(FW, get_next_child_node, FW3) returns NULL and
     decrements FW3's refcount
  2. fwnode_call_ptr_op(SW, get_next_child_node, FW3) returns NULL and
     decrements FW3's refcount again

The same double-decrement issue occurs when SW has children.

The kernel dump as below:

[   25.435805] OF: ERROR: of_node_release() detected bad of_node_put() on /soc/usb@4c010010/usb@4c100000
[   25.445072] CPU: 0 UID: 0 PID: 617 Comm: sh Not tainted 7.1.0-rc4-next-20260522-00011-g7376b330abca #210 PREEMPT
[   25.445080] Hardware name: NXP i.MX95 19X19 board (DT)
[   25.445083] Call trace:
[   25.445086]  show_stack+0x18/0x30 (C)
[   25.445101]  dump_stack_lvl+0x60/0x80
[   25.445108]  dump_stack+0x18/0x24
[   25.445113]  of_node_release+0x158/0x194
[   25.445122]  kobject_put+0xa0/0x120
[   25.445129]  of_node_put+0x18/0x28
[   25.445134]  of_fwnode_put+0x38/0x58
[   25.445141]  software_node_get_next_child+0x54/0x15c
[   25.445150]  fwnode_get_next_child_node+0x70/0x94
[   25.445156]  fwnode_get_next_available_child_node+0x34/0x88
[   25.445162]  device_links_driver_bound+0x2f4/0x334
[   25.445168]  driver_bound+0x68/0xb0
                ...
[   25.445258] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'

Fix this by ensuring software_node_get_next_child() does not decrement
the child's refcount when:
- The parent has no children, OR
- The parent has children but the input child is not a swnode

This prevents the refcount from being incorrectly decremented for
fwnodes that don't belong to the software node hierarchy.

Fixes: fb5ec981adf0 ("media: software_node: Fix refcounts in software_node_get_next_child()")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/base/swnode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 869228a65cb3..507de464d387 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -474,18 +474,18 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
 	struct swnode *p = to_swnode(fwnode);
 	struct swnode *c = to_swnode(child);
 
-	if (!p || list_empty(&p->children) ||
-	    (c && list_is_last(&c->entry, &p->children))) {
-		fwnode_handle_put(child);
+	if (!p || list_empty(&p->children))
 		return NULL;
-	}
 
-	if (c)
+	if (c) {
+		fwnode_handle_put(child);
+		if (list_is_last(&c->entry, &p->children))
+			return NULL;
 		c = list_next_entry(c, entry);
-	else
+	} else {
 		c = list_first_entry(&p->children, struct swnode, entry);
+	}
 
-	fwnode_handle_put(child);
 	return fwnode_handle_get(&c->fwnode);
 }
 

-- 
2.34.1


