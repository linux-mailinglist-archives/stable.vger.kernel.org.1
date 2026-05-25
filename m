Return-Path: <stable+bounces-254086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH13DjDnE2pdHQcAu9opvQ
	(envelope-from <stable+bounces-254086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:07:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A15C6351
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB9F301B165
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F8372681;
	Mon, 25 May 2026 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AzeHPZaD"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC304346FC0;
	Mon, 25 May 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689224; cv=fail; b=VTMwQ0abTqbD2Pk0aybPmT6aho05EViHVfoHxUEVzRV/zlmuncz1R3LYUvAzNQVIBWPS+8OtFJPOeqBnUttuYJuTh1DRzjYY/EEIYd3WG2+J8hztzl7COxxq6ZCJlTG3NEdlsKdSrPOjAt5IwtAEaYh/M8Onh3mDAYhug4pVX7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689224; c=relaxed/simple;
	bh=sYIQCvDml1F5QeZMaD08efhqcRu/hg7MPQibRIK2lMQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f4nkP3PfKuOr7LWTBmQfXW4szlRTau5bz8vdUW7qNZmXrZx9AZPBJrv0GYKoZyqZnDXVBVwbZgroHV0RTV2pLmGkuJGiZgpfKfn1Cbp2CxPHj0hQkAneIpabii/D4+EFASLVfN7H8wusIdWaGGfnIAfkWn2CZG1OxcfBEujmY+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AzeHPZaD; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckkNeKXvg4lR6dLAhIa72SkZQjB29KbyEZYosexDS30/pCggQlIC4gn2kiRmAVp7lK04H7iz7H17dDCYKMqBT8gYMk96t/ChzcuJ+lfGOuvlfJAjM1GKUTtDm7nBrdJTa1uuA8ULCMERH0B8GYiwuI/BpCKpl11MGrZ8LeifxWkvlPO9CD7hT2MvOyALX7M1sySaT3PoyzfVUk1bjryF4H2hNDp2gX/kFA75oSecriv2ECLr2/TgW0v83ggWmlyf+GfsR1QlLFiUinGgTkKoIBq9I4TTLEHqr2trAN8m9Acv56hVJfAsAJrgZFExNs2vmQ1m0sE4E21E2o70f2hT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgjrzaokJB1q/AucMmIwnwYV7T5oi1n8ZZR63ABrv3Y=;
 b=PFSIcfjPIzYs/si3h3C/5vtjSw6zOt+NKsgNQJ+Sy7Yku4ikQx+zusmhMLZcc18aGOxH1y/hTH6Nn65/tXt0lPLmb8FnRtmxxvUBRiigkKWwAOloZBJNYBej3wacjul8KK6bTjHK5UF4jaxHUbX9wtXrqbPbuaaHiNHJPIjXnaPTqwdEfLz8Tvnnlwx/1WG57enAM3ED9UTSqHtr1h4pHLZpz8uqHRvrs3kruMovJsPgoDdgPtWr8FI79DLs/hgOLuTv4ro8viEb8APi75YSa2kB1Mvsic+3RhWbbJ1a2mWqsZiKxUqHJ/PsJ4I24DZEGB3D8McTrPO++HZuxnVX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgjrzaokJB1q/AucMmIwnwYV7T5oi1n8ZZR63ABrv3Y=;
 b=AzeHPZaDfvQXl651SkmDNxFAQV6NJxSZXkqCygPpokoXeZ5fhgvUfnrOiUoWfO/0cr+eoeBXJkhHi1Zia3ryYI0crsKdoOFnJ7TPjREW+nvyCFP4shXwV6NL8K2RwQ4CQ80awmGnYerHo2RGyaxzIH6LRoasSZ2RV1RP+0iCCF6jpJfThuzMUypBN5zpNFRgl62+B0HI8tGUiA5dUC4/puHIUCoYrwdiE6AJdPLfFGDAqnFxYHaCdAFmeKXGIJGNmsN3pS/90Dwt3unGjfqnOR+OR2bVDMEmnt/+piowVG7OTf6/8tXmVblke3pRzF9JljUHHI9+f/r2I6K9vj0XEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10725.eurprd04.prod.outlook.com (2603:10a6:150:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:06:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9891.019; Mon, 25 May 2026
 06:06:57 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 25 May 2026 14:09:20 +0800
Subject: [PATCH 2/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260525-fixes_fwnode_iteration-v1-2-a12903fb2919@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779689386; l=3138;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=sYIQCvDml1F5QeZMaD08efhqcRu/hg7MPQibRIK2lMQ=;
 b=Mq0a8UXRAaBHh03DHHRVPDJ9E7s50TgCBB/YxAI9ALAsjnykxgKKyX961NHTu66ANTiQQiaMX
 vhXw/vgUHcHCa0D88Ol4+Yybtww4Yb+tiI3aV3ts2Xcj7A2dlGSkXlb
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
X-MS-Office365-Filtering-Correlation-Id: cc4d98dd-4d0a-48b4-ceea-08deba23d410
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|18002099003|56012099003|22082099003|38350700014|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
 zO0teIpqmjlMz03L9NYVDmdWiGdpZed1FtgF6K4QbCSWMTJQ2UK1qZ+qr/FwVyIujLjy6scvqPFmHhmmoobnXQt4ow/ibnniiBofJHpJbvhaSRK9G9QJZDJptjF8rDPYTtARYwIrwBbZ54DzaB7t+9WLQrtRTJSAN1s0IwMQ/nCIjdGMeSzcmj9IWiq9aFaCrkIB2acYtnC2LiPdYpyjdpE6EYTobykHLa+kz+/3PqHXbmOfgXKfEYw4OMimkWl1MT8+7hD/R5nBGWkQuv3vmsYmJtd4gHJyvVRtlg3eK9A5Q8VZtVPABbKwJRl5SoTVORcDUcjU0UtOEEYPOwWGuf4howVeIZjosiCleuva7QF64g1xaN2lYiiHklpK57dJ3R1OEfdeGoBXlGRdjSMV0EXBcVSMkqIHTpRPomg4OFc76NkxIFA5YiLRG2GHnaQDSQ7ikIXBctVx/j77/wk166QkxcvycO4pzaNwLjtyAZFm2qG/VjBc0FK4OC8XS3fmW/961FPLhirKvDxru4dMtqPTQC9zZhuVhOjK6Uefzr8UH2L3Vcy9emExFZKEb59Yb30CQJoCRxvswngl4UQQiVgqx+AyWbz//CiYf3XSlYu5z58rAXTyofhlCRIeh10rf/+McFakxWsqnSw2uKfSuSI5wwPaQJz4uNEvWnpqVFPfsmBn1tfNDAHcWFkDz+yaojRP494l/V2jMHD+P/NcbpnIhddSbXY2HHKptwrieyBdS3zHmnCanZ60PEMhoK2w
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SDRIR0FQdkthWXVDRUZ5RWpoTkdCUUVqc1hTbG1WMHo1OUFranRVRnhWNXRi?=
 =?utf-8?B?RUJNRy9sdlB5NktCanNXUHNoTm4rRWZ6cjgrSTNYSVdyRmRoeWtUMWtkUHNK?=
 =?utf-8?B?bS9Yb3VwcE9aeGcwQmVUUG1sdGw4SjBEdm1HYU5zSkJYVXl1VW5EQ2J4RlhZ?=
 =?utf-8?B?MTRmdnVMMmZZQjF1SnFtZjZtcWQxSHcrcjFHQXNYQXd4NEdicVF4ZmhadWMr?=
 =?utf-8?B?V2ZZUERZWGd5aTBkS29zQ2psaGNZbWhoQlVobnZGRnBMVndIWlFEeGhLM0Nv?=
 =?utf-8?B?NzVQQk94WGZ4b2JpQnlZMGpvNis3ZE1yajZzOFp2VGJTSzlTS2ZCSkRrNUFv?=
 =?utf-8?B?cVk0dVdYMlp1Sy93Umd5WkxJVHArYS9xek1KWlpXdU5sVkppS2xmWnU4TVVs?=
 =?utf-8?B?SU9KQ2NCRWI0VkNuL1JyOGdNdEYzaUtVL2xhUWF5bjNXamROVEkvTjkrVlp0?=
 =?utf-8?B?NWQybnRjeG9yS1pJVGg5eGVFQlZBcE5rV3YvcEg2QnpKcjlmN3U0SWNCZkJr?=
 =?utf-8?B?azgzN3l1MmJibWhLWGVvbVFlUDA3c3B4cTU0T2hkOU04YkgyQjBwNjhTbWpS?=
 =?utf-8?B?TWRVd1Bwc2dhRUZjRE0xSlF3S21OUStJNmJ0SWlycmtkWTJZbFdIRE8xRUJ5?=
 =?utf-8?B?eDBEbjVmN0VMMWo3UWdoaW1DVVZNVVRSeTJSeHN0ZEkwNk82VkpjSWNVejRj?=
 =?utf-8?B?L01DNE1GelYzalltb3pSSnE0enZCdHlDbkZLK0VTKzdZbEFSWk5lY0JncjlN?=
 =?utf-8?B?RlAyWi9pbGxTVk96OUNEZHpiZDVsTmovQzJXL3FlZU1NeTd0em41YU5URjJl?=
 =?utf-8?B?Qm1STTFrKy90aDVWTXphRlVtWHZEdloxQzhHYmswRnEwTGlOdDgrbXZZUXlt?=
 =?utf-8?B?UjZUaDRDTUNYQnJzQis5a3kvajdGQzV4bktMRXhlWC8wUXBHb2xkOG1BaVFP?=
 =?utf-8?B?cjV6Z3ppSE5UWnhmeDdtUEpNY2JmN2IrbmMva3pNbTBUY1NrWER2N2x2VktB?=
 =?utf-8?B?cCtiaGQ3UVBXSFNZOVpFdWk4TWVmc2haY1JTYW9xb29VQnpHc2xqejFuT2tO?=
 =?utf-8?B?K1lETm03Q2xyMzJ1ZHpObXhkZ2F4OTM5MDg0NStOajFsZ0Q0STdNOEVCY2xC?=
 =?utf-8?B?OFJlWGVsa2hHTkFkbFdWQlUyTEVPL1BjTVcxbUN6ak9hY0Z2M2NZazZxQnl6?=
 =?utf-8?B?d1dqWmE1VFNTaFNBOUhFTEluNnZtRHhDQWRVRGtFVTRFcmJhb1BwTFloT0JK?=
 =?utf-8?B?Y051VGlYU09LVTJielFITUJRK0c3RmxQbnl4Q1hiMDh3a25VVm1pd0dlanZq?=
 =?utf-8?B?NjBjSDFDZjg0Z1pLNU8yeXZ2dCsvdlA0UWwrTmwvVS9DNzMwcWNmaUlIV3dy?=
 =?utf-8?B?NlVWQitvamhoQ004d3V1SFV1cUVxeklCcCtWWEtmLzVRZk5ITTg2Zm9oNkpl?=
 =?utf-8?B?V2JYdGE1Y3ZhTjRyQlBBUnNEYXVnL0NiSmo4TVV5dWVqSXZvWmFHVDRHSDhU?=
 =?utf-8?B?VERxZXpFR2UzdkkrVzA3YVlWai90YjZkUGNrWE4wNTIyMDVHQlBqTmt6YjNB?=
 =?utf-8?B?ZUVsUmlhcURkTXdObktvejg5T0pYOTBqcmUrNFlGQ3dSNTc5NWxTbklQRStF?=
 =?utf-8?B?VXUzS3RQUWJSSDhHZ0t3M1U1ZVdQV2FHTEYzZTUrY3dXVHRiYmtueWx5YWZV?=
 =?utf-8?B?SHFnVVh2allVK0k1WnpzemkyRUw2d00vMXBKRXoxS0JrazZ0bXFpYlBVRkZK?=
 =?utf-8?B?a0ljOWdKNGZWU3U1ZlBwUWkrR25YRFBXd2JEclIvZTdPazJRTU9rdDJuM1lF?=
 =?utf-8?B?QzdFS3ZxT0RXL0FvNkZqanovak5RMUpabUZtaTRwUDZCVytJbHlQUnJaL09J?=
 =?utf-8?B?QWorM2U5djluNmVCU0tFZUR0bHlhdXYrcEdBNkpycGwvZUcwTTNrTzEwUmZN?=
 =?utf-8?B?RE5ka245SnlaQlVvd1VWM0ZJRlQ1RUhKSVZKY3QrdGtmVWdxdkZLbEwxaXlE?=
 =?utf-8?B?OUc3NXB5cGo2TWFxVHMwMTVINDEvdmJGdkg1cEo2UHF2ZFlZeGoydnhEUUhn?=
 =?utf-8?B?TU45ZWhLYkZ6dkkyb3R2djFZMStQaUpzcXRZS2pNemdtSnB5aDBOem1jVXBI?=
 =?utf-8?B?WE5weTdoaytKWXg0MndLL3BWR1lacFl3SzJ4ZDg1NFBqemtKWVA1VmUvTFdQ?=
 =?utf-8?B?VEg2NGpUcjNrYnRBb1h5YlljL0VZbDFGaUxuWE1LTk8rNU8wdnV4bGFLWE04?=
 =?utf-8?B?Y21JZmYvWmxNQktZQTFlcDlxcGVuRTd3d2xURlhSYzRVWUlKZzZna2FZNElw?=
 =?utf-8?B?RFNHT1J2cGdFT0o0aTRlS2hXMEJaMytyK1BqTm9ZdlllMytCNWxsUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d98dd-4d0a-48b4-ceea-08deba23d410
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:06:57.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8tM3edKmum6KAuAmY8GtbmfYJPyg+SUTSDRfRkQvppf0ZImJhE8S0+EDJStZhUijChd2sWxx03O/8z+sYQUcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10725
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254086-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: C86A15C6351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When iterate over children of a fwnode that has a secondary fwnode,
fwnode_get_next_child_node() can enter an infinite loop if the secondary
fwnode has more than one child.

                       Parent        Child
      (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
    (Secondary fwnode)   FWb:   {FWb1, FWb2}

In this case:

 ┌─> fwnode_get_next_child_node(FWa, FWa1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
 │
 │   ...
 │
 │   fwnode_get_next_child_node(FWa, FWa3)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
 │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
 │
 │   fwnode_get_next_child_node(FWa, FWb1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
 └────┘

This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.

The root cause is that when the current child (FWb1) belongs to the
secondary fwnode, calling get_next_child_node() on the parimary fwnode
incorrectly returns the first child (FWa1) again instead of NULL.

Fix this by dynamically checking the parent fwnode of the current child
before calling get_next_child_node(). This approach follows the pattern
established in commit b5b41ab6b0c1 ("device property: Check
fwnode->secondary in fwnode_graph_get_next_endpoint()").

Fixes: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/base/property.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8e0148a37fff..9dce513f90cc 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -807,18 +807,32 @@ struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
-	struct fwnode_handle *next;
+	struct fwnode_handle *next, *child_parent = NULL;
+	const struct fwnode_handle *parent;
 
 	if (IS_ERR_OR_NULL(fwnode))
 		return NULL;
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an child from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (child) {
+		child_parent = fwnode_get_parent(child);
+		parent = child_parent;
+	} else {
+		parent = fwnode;
+	}
 
-	/* Try to find a child in primary fwnode */
-	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
 	if (next)
-		return next;
+		goto put_child_parent;
+
+	next = fwnode_call_ptr_op(parent->secondary, get_next_child_node, NULL);
 
-	/* When no more children in primary, continue with secondary */
-	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
+put_child_parent:
+	fwnode_handle_put(child_parent);
+	return next;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 

-- 
2.34.1


