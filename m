Return-Path: <stable+bounces-206262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF40CD047DE
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E205C34D513A
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A703612F4;
	Thu,  8 Jan 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AL2ODp4G"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7763612D7;
	Thu,  8 Jan 2026 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858122; cv=fail; b=QRBVqVI9IpT1Imgkqc+SVp2gT9FEC8l7+ptofNuFTd/UkMc+C1ruFQFOdod1tBZ2cZ8DvlgkFY0BAyrLJUfLsXYOKu+ljTB1KqJgsz3vHb65u25zyUxXt/OV9Gksw6Gs9Y3Gyk+IF5oA4mvlqBrCA//l0+FwI6zVLoLLNJilepI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858122; c=relaxed/simple;
	bh=kSxWxNwefu30y5LyFID3cwkPHufdFKpIrRj/ct0J8LY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G5URv5uSb8Qf28Z52KcjPkY9glZ9QIMftOW5NqNpd2lk7ZyOYEDF94QvKxdKt0gUzpuTd/0kKHYPKU6mfdyu5QH7p57+gI3JoJiYsKWs7ftdOhqK8pYzYwjSB6k0JdjvjastalDWxRKGPP/WMs3nt4PNs6/2vBFCzIyQRd8ypvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AL2ODp4G; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8b3CvehsXwvW3fLqUEp00f1Z4P1CTmnu9KyQWlN96ixfrAWbxE6tdNMMJSlxt5dDN7QxcXGsUPLl19T7xDOzz95AlnoZeRUmxhXEeCfWVmKcy/emyThWuM6DGz4brTFQta/E9EYyWHtsAKXhwT5ShVnBlBW4OrMnPm7W4hVl6EObVSelFZrYK1yt/kApr1r0fT6H2SBK1LzEA3angr0qiViiuoW08HWHj81v0s234XFKMjUWVyW+oqwKQ6dxGS2ns9UxnG7HIrzL1Jko7HmRaKM7YiK8zVEIRY7buUktgR55s4rMATyNozEEOWOqnvP4766Hx6wAUnpN+ny4WruBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWAnZ5tqWQqGjjtv0kE1AQHMMCPU92uOi3JBUxe4ysM=;
 b=xSA+QFkjEzyG3w3E9f//gns5CvGOyFJA3FzEMcy6nVqU/SyD77uf/k+rWBjfvnwelBxLKbJe1U7aV60asTalKwjPxpn5Bmzd5MWKP3x9OWWPu/kGRHSPzx50FswLC0CW5PuQFlenaaM4FHRvt+Qhxbu6kg8owK55E3hmJtR+F0VDo1hEm0LokY8Jel3fv9sxa7LLjUw/G+fXLEbFFMvHf+JLy0o7+4sQsJ11NOdQXWR8sjy6htJUal3ytwlph1HjZKAHkII4zpPe0rGTriq8is06rC3IZJPAaEVEYHWNGTQj9F9zfvLH+IuMQ+68vIrJjSJffz78i/vqW/iA/L9fQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWAnZ5tqWQqGjjtv0kE1AQHMMCPU92uOi3JBUxe4ysM=;
 b=AL2ODp4G+YNvrnhVi71FnsGe6qV17suTbNGxChfhleZ5YU7baSSCCKbnIquhJSDTd9IJO1TnJ5uTNvF2okeZ6FFT9SmFhsnW1ELOE/pm5LLKkHDCsyrtMPEESIQcP1etaoLdrCD82H+mPNKGVjotBnYaJMupG31PPVIGXJzSQPZlUBVXWv5wsh8XSnG2SrRCLlEjeQAK1qbjYwl1CcqFai9zGTnHyycfKJ2fPEVj3R/61oXH5QDVRX9jxcD7YF3AP3f7vGusKtHGUTrilJn/hMczDuGOtNqGfv/OOWYz9bDSCOMH/FioOC1oYMDK51ImIt+aO3eGY69G7kpM5OVWcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 07:41:51 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 07:41:51 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 08 Jan 2026 15:43:03 +0800
Subject: [PATCH 2/4] usb: gadget: uvc: fix interval_duration calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-uvc-gadget-fix-patch-v1-2-8b571e5033cc@nxp.com>
References: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
In-Reply-To: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: jun.li@nxp.com, imx@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767858202; l=2328;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=kSxWxNwefu30y5LyFID3cwkPHufdFKpIrRj/ct0J8LY=;
 b=H0PSJ38MI7B36sTSEoI9RtiTI0usHCTS9n0xl6x2XcA0x43bdICUuY2hFOVmARVoH3OgL/HXW
 Yp1qK0adoghBKOLzDWwSmS1E8KZMNHwZ8CvcQwzvMwToRrF1CuLIxno
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 20662d62-d651-43ed-907a-08de4e896321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGhRNFBuekdJeHptM2xDdEg1N1NPcWhNWVluUGloU0VrdXBJcGdMZUdGbWhJ?=
 =?utf-8?B?cjVsTXh4QjJWWWZkaUlGVnVBdlB1WmZsZllhYkh3cUY4UWlOaFlFSGVkaEtl?=
 =?utf-8?B?eDN5Qm9nNFNKTmNlM3NnYWJIYlFDLzJoQ3ZGamdydVJTcjdTVmF5RS9iVTcr?=
 =?utf-8?B?dUdtWUpwVkc0RVl1UG9rNS9naTF5dEV1Nk55dEtBTVFVOEFVS2ZSOGN5WnYw?=
 =?utf-8?B?UkJScHNVajlYNDJTelJENFVhdU8vR2E1U3VDajBaWXllQmV2V0J1OHJLd1RG?=
 =?utf-8?B?ZlJndWxaTHJUV284eEc4K2ZmS09sdnVuODJkTzFGK0tlbDlnVHBpU0greTBo?=
 =?utf-8?B?ZFhGUDVpMFY3UXFvNVZETmFsNmF3TTNDck5VNjFNWmdoMzNNRnVWQ0N2Tytr?=
 =?utf-8?B?VEFESkNKYUlXK3lTL3RLTFhMVnlhQkFvanNCSDJIWXQ1U2ozWkJHZnpqNElv?=
 =?utf-8?B?N0RwdDY2ZGFVQzNDT2xic3lIRHozVFZlTzFmb3B2aEV6VFcyZGhWVklRSVVF?=
 =?utf-8?B?MWVQTXdJTkF1Y0lubTBHMnkxdkRoQ29mOUkwUkwzMDZvV245THM1bGt4djFa?=
 =?utf-8?B?WWtHVjg5enA0M0hsd1Z1UjMxbUUzN2NSQUphOUJzVyt3WXlVZ01sUTdsWVZK?=
 =?utf-8?B?NjdybW5TREVReERXaG1SelVCcU43cTZEUFV6YncveVhVSDJFNXZvQnFSVkVm?=
 =?utf-8?B?VmVBdlRXNEErMUwzeGVzdmZWWUlqVlFXS2xxOStnOFgrNUlJQkJXbmJlcXdV?=
 =?utf-8?B?RHUvUkNYMUlpWXdDdnA2K2RScXVSMzdKVE8rbTE0UmdiaEo1YXA3MFA3RzF3?=
 =?utf-8?B?ZWV2NGZJSDNLeXlrazNwS1V2TW4rK1ZnZnFzak5mQitVSURLOThvY1ZQRXMz?=
 =?utf-8?B?ZXdPM2ZnVWJxTGgwbFZwZWp6TnE4Vi9LT0hiQS8zeW5LN3BUVDRyT1hkUVhm?=
 =?utf-8?B?cEQ4a3piejJENGt1ZU1UWE93YXp2L1dnZTNEM2FzRVZjSGVDY1ZPL2ZFakgv?=
 =?utf-8?B?VmNGdm1DdUw0empEek9KUFFBYldyWnpTNGtwYUNNT0lSSjBCSFpuR2lIVjBN?=
 =?utf-8?B?Z3hvT3VCRGNpOEgxR0p6cHlnM0tGNDA3aUxFcTRYUW5hWDlQK0ZUL2NzeVFY?=
 =?utf-8?B?NENkWGxzL281eWZNTTh3Umh5Y1pRRHd3MzBKWU9FMmxPcHY4RDE5ellYVG1I?=
 =?utf-8?B?am14MTEvc0xFWEpIazVtaWlrUVp1WWFCa3ZYd0t4bk1SazkvTU1JUlJ5ZWFm?=
 =?utf-8?B?SW12dldnczFuK3Z4TmJxU0JDRFJXRUpHODRsNEdZcklmTjJURWJNSXRLbDlS?=
 =?utf-8?B?U0ZGTm9GK2x1UHUwSEdLZVZsMjNtNE91MnV2UXQ0Vi9qaGtQSHZhdGdLcXhY?=
 =?utf-8?B?c2NIcUM1dkovWlFzSHhNSzY2TXNIYTVaZVRqQTM1Z0hHZjdHNjk5ZnRVVDF3?=
 =?utf-8?B?OEFoZk5rUWsxOVc1S1ZnWS9Qc0xMZjRUMWZ2UkFqcThHRkZ5SE1SNE9QREl5?=
 =?utf-8?B?dnAwZmM0MnRiM3J4eU1UM0JJWUFoRE1iMkNqOFRYSk15QjQycjZqYVBjY0tl?=
 =?utf-8?B?Wlg2dlpWVFFOY0tXb2E0dGVodnlTRy9aNThRRUxMa1ZsMWFLRHg2UkpXS05j?=
 =?utf-8?B?Y3ZrQmxoYTE0U0pJcU1oa2Z4T3JiQTA5enVmays1MnZoem9RUndoYXdxcjNa?=
 =?utf-8?B?ZldKeURlV0NoeEQ4bitvSmdPSUUvbTRNNmRsK3NWSDAvMElzckdnRlFIZXVC?=
 =?utf-8?B?UWFMNFNqaGdCV0tLVDM3T2cyeGdNYkZxMVJTWXVIaDdFcWk5UGN2clFkemQ3?=
 =?utf-8?B?bUxTYmhUTnZ6SXMvOGZuV1BZS1VLQU9KY2ljalo2Z3RjOWd2dDFVNVh4eFR5?=
 =?utf-8?B?R0EwQTlyNG8yZGFxek1JZzZtS3Zwd292eGVpSys1MlplNXNPRHpnMkZNN2dm?=
 =?utf-8?B?TDZkM3ZSU1gxQkM3ZE5BcitqdHhGb2MxSi9Va0Q5WGMxTVY3bG5SZC92T3Rn?=
 =?utf-8?B?WUxvWW5TTldYMmNsUHhPdlV1Q05hRm9iQlg4VjZuUEZSTG13TStYR1Z2bi83?=
 =?utf-8?Q?WL/le6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJhYTFVOXVRU241VE4rdU0rdzZPMTE3eGpCcnB2ZjB6TlJLU3QxY1krRHhU?=
 =?utf-8?B?Y3piVy85V1hhWmx5QjZHTjlneW5LRThoU0E5VkZ4QTk1V01aNEZVT2NWS3Vm?=
 =?utf-8?B?WEV2MXozMjFnSFRRenRzaDBhTUNPTjZJanR3OVcrV2pEYUlWNWFKWmV0dDU0?=
 =?utf-8?B?dVRtMkFLLzlkSWVYZE1tMlRqVjJOOUFEV0JUN2ZoeWljeml6OE0yU3JqT3lw?=
 =?utf-8?B?cHY4ODhjaWpXT1IxeHNQSHlUWlJHdUZlTVQwdlVIU0I4cnVFMW1SbE0raHpE?=
 =?utf-8?B?Ykg0THVPazZlVjd1TmVnWm5uSkQrVndQanpOSmpiTkk4UjlDeTVya3hubnlI?=
 =?utf-8?B?bW5DaXNhTU1CZWtSRFZNbW11blc3U2ZiK3IzaDJYZDI2N3JVUlhPQXRycnhJ?=
 =?utf-8?B?SUs2ZXFpRG9neXYxaGJkZVNPL29EdnBnRWFaKzRrTjc1dHN0U0I1NDZ3QTMr?=
 =?utf-8?B?VW9zeFo5Q1BDZzhVcy9KV2V6Y040V3h1KzlISmJpYTMyRFBycHZDUDhHYXpK?=
 =?utf-8?B?b3lNZnEwM3BEVUdGSWJoR3JtWE8yRlpmKzBZSUo4bDhWK3QwWDFkc2dWUHVl?=
 =?utf-8?B?QWMvN0R3VVJJVU9YdWM0T0RwcGtUSjFFenpxQUR1cG5XclNjeDladFNjYzdV?=
 =?utf-8?B?RzBjNG5zOUdCZW5zdnRVSkNWTCt1cDBRYk5ZeENtdmFBYVhBeVRTQ2ovUFh1?=
 =?utf-8?B?Ti8yNGR4b2J3OW1Ec1N4dkRkRFNsYVljNEU4TmhOYVRtRzVvekVPVzN5aU52?=
 =?utf-8?B?dmxpMUdNbnVLRnVYMngybFdpaks4d1JDdFMxRCs4T3lyUm1oc1lreUtYR3Mx?=
 =?utf-8?B?NFJNU2xZcmxBUmlEV1R3dXN2WGlHYW1DMGl4R3ZzcWkrQ0tqK2l1THQrNzRq?=
 =?utf-8?B?N2w0dUxjSGt3TjQxc0FsSG1iWHVRbFJob2hNUzk4b3FNa1doN21VOG5sdnpl?=
 =?utf-8?B?T2VlNXIxTmFJZlZGQUtXMnlxbER3Q1dzK2ZRai9heUxLWllpS3VHNHY4aFZp?=
 =?utf-8?B?R3BXYlA2UWFkdHVVWUk5T3hpbWlROTN0YlFkQkwxYVBRTjUwRCt2QUM5ZmRn?=
 =?utf-8?B?cmRNdWd3NU5EVjg4Sm8rQ2RGYU01ZlNYN1BpOWZadWdiUVdvYVk2V0k1MTdy?=
 =?utf-8?B?eVhYdURYaW9MZ2dvYUJ4dEUrclNNaWY3TXZNa3c5VC9BWU1vdXRwZm5YL1g1?=
 =?utf-8?B?amlDb3FFb1NDT1dUZFF1QytzZW5uclc2UjFRd0lCSW8vcUdwT1NDSDhOYVVt?=
 =?utf-8?B?TUthV3VPKy9ZNHBMeUMzL1kxSktYS3VPOUdaM1N0QzFEeFR4cHVxNHNqWUho?=
 =?utf-8?B?VEJaM3dYOHU4T0ZlNEJNYWZEcUQrb3NOM2RNOGZZVXNSaXVyU0FIQ0Z6RHYx?=
 =?utf-8?B?ZUdoelZvdkdPM1FBR2J5MXZ0NzdBVUxadjkxRWJraEVVT2tqNERHTFNqZGxO?=
 =?utf-8?B?OEpNZzZZMC9LRGloVlJ5aDlyL1NXMjJwbHVseDVsNkFNYnF0R21FRmd0azND?=
 =?utf-8?B?RXVZRVR3QjBTdGdVQUtRcXNjcUFaK1ZMOEFGdStEdWJQK3pyZGFrSEZqN1Vs?=
 =?utf-8?B?RVFFWHU5d0JjUVc5RFlKKzcwSmxQSUYwbnU2RXpRTmxGd2dyOCtac01FbGgx?=
 =?utf-8?B?dTNITytzSGJGV2UrV1JJVVlVUncxV0lCc0pVcXR3dDNsY1h5Z3dRNmhRUWo1?=
 =?utf-8?B?dUt6MFQ2ZUVkbnNuVmEvTE8xMHRtdWJFOTE2d2lLTlpZUXRmYk5nWjZ3YlF4?=
 =?utf-8?B?UEtnOHR3M3ZPQUJnYkFZbEdaNWxoajRDRzA5RytqUENsanBpY09oQUpYbjBD?=
 =?utf-8?B?a0pwN2ZZN0dOaHVkL3E4YWpsUHowS2VMd3lNN01nOEdjU3hyaUk4ZU5VZENq?=
 =?utf-8?B?ZnZucmRZcHZXanFGY0dPR09oMDd0QWxMZDBUWkpCNjdhajU1N1FST2hzYXlu?=
 =?utf-8?B?dW1RL0pCVk9nTkFjV2d1c0ZPeGJXSFlKcTBpK0JEZlcrYzBrdVZMb3hnZDdU?=
 =?utf-8?B?akRhTksrRTViSWE5SldOUzJiRy93cUsrR1J1Z3JyZkdLSVpUZW1CZUxGcklx?=
 =?utf-8?B?bm41akRDVk5OemVRenhtQndMMi8zcXQrd0FBajFOUkJUYXBtRVpuWm1MV0Ew?=
 =?utf-8?B?bzdVYW96WlJtWWxwM1JjdlhRQS9hNlJaVnl2TWxTUU5WR09JelNhTVBYZEZh?=
 =?utf-8?B?MjdMVS9pd3IzbkZTZkdIRFNiTFRuOTNRdzlFOEtLQkdDWTRUR1Z5TC84bW5j?=
 =?utf-8?B?bERqTVorSmt2RTFRK0lNZkVkNlFGZ0xyTmY5MmFYTTNSVFF5V25XT3EwOFBW?=
 =?utf-8?B?dks4aFI3YWdoNk1BL3A5QW9zUUV6T2dESkthNjhiRS8xRkZ0YTc0dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20662d62-d651-43ed-907a-08de4e896321
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:41:51.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l3WGe1Tqi8P2/2z+tVWnWGtrehUVZWquIINLnXRyqKnI+Sh9g1XSNBe1gb0PbFkxkes6Z9F6Qf1Lj1R2XAC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

According to USB specification:

  For full-/high-speed isochronous endpoints, the bInterval value is
  used as the exponent for a 2^(bInterval-1) value.

To correctly convert bInterval as interval_duration:
  interval_duration = 2^(bInterval-1) * frame_interval

Because the unit of video->interval is 100ns, add a comment info to
make it clear.

Fixes: 48dbe731171e ("usb: gadget: uvc: set req_size and n_requests based on the frame interval")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/gadget/function/uvc.h       | 2 +-
 drivers/usb/gadget/function/uvc_video.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index b3f88670bff801a43d084646974602e5995bb192..676419a049762f9eb59e1ac68b19fa34f153b793 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -107,7 +107,7 @@ struct uvc_video {
 	unsigned int width;
 	unsigned int height;
 	unsigned int imagesize;
-	unsigned int interval;
+	unsigned int interval;	/* in 100ns units */
 	struct mutex mutex;	/* protects frame parameters */
 
 	unsigned int uvc_num_requests;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 1c0672f707e4e5f29c937a1868f0400aad62e5cb..b1c5c1d3e9390c82cc84e736a7f288626ee69d51 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -499,7 +499,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 {
 	struct uvc_device *uvc = container_of(video, struct uvc_device, video);
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;
-	unsigned int interval_duration = video->ep->desc->bInterval * 1250;
+	unsigned int interval_duration;
 	unsigned int max_req_size, req_size, header_size;
 	unsigned int nreq;
 
@@ -513,8 +513,11 @@ uvc_video_prep_requests(struct uvc_video *video)
 		return;
 	}
 
+	interval_duration = int_pow(2, video->ep->desc->bInterval - 1);
 	if (cdev->gadget->speed < USB_SPEED_HIGH)
-		interval_duration = video->ep->desc->bInterval * 10000;
+		interval_duration *= 10000;
+	else
+		interval_duration *= 1250;
 
 	nreq = DIV_ROUND_UP(video->interval, interval_duration);
 

-- 
2.34.1


