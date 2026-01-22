Return-Path: <stable+bounces-211314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHkdGVaJcmkPmAAAu9opvQ
	(envelope-from <stable+bounces-211314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 21:32:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 092AF6D6F9
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 21:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70C27300B1B0
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4D35DCF5;
	Thu, 22 Jan 2026 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7d87vGW"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C767331A63;
	Thu, 22 Jan 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113935; cv=fail; b=TUBhZuZN3xkq1/rqb8NJO8sWParR+TbC+RFzxATTHKV8ve0SjjXu/cBm3cmAr0MGXk/02hE20ehyKw/uJ+15RhgOLsSkrDVdcufKBXDyCADP+uXkvtvzgkq5672rLTHycfIT12ACt9p/cKDkxp+Iai0bdKXGxyPGqGc8QJ5IQgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113935; c=relaxed/simple;
	bh=CywtYz1XMfe9WfYs8zFY85I3jEUhw/ZDBgJKIsnz/2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rp9Ut3vTzidhgaiRXXxR0e5kwxOz3PWlf6Ww4/TEFIVRdaLIHb2LD4F1LP8JyNbdsKM95L0lvcYUXXPjidy6abeMvURs/34iSEatnEyyj9s76sl9I6L5RRlKaiZvXfc/E5vMHWOSiu9y7WjJWVKl3YLNQq/AHs5btYXTJ279WXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I7d87vGW; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh+gd9Tt1Tt/gBeeNovp72M50HER+80dhh1IAOZUwN382n3Hv3GKCBCNOLrc3yUuKILBtZGrujdKkgBIIn8LhMZNinRkScL0QLxo0CU5+X+frrB11c3nwgWBacUlxotYqmExchtFbRPoGdXsE5oK0Se4/AZO1bQJK6h4U52OHXyfEERVNVvQAYIXGYgwtL6zNxrri6sEakeuG94R6hIGblaLq1whka/jYqABj0D4ZGLmxTQV0F9X5ST7XX6Xm3wVYemrbTYO9rtGtRuEKe9414iTTCk/0RbPnB0ij8QuqFhqtlMvD9sTBY0hzujw0zuytwqskNpPPfj6dlsavCAFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqtQ/kwkyU8LsP2WPR1gkScatj2VjOhCzIH0yyzWWms=;
 b=u/WEkzFaGjABnScqGA+zACjOiiXnAkG6Sf6UtQvFe2FxpB/iEuR079qk8lApTQO3lTy81/O1XROGMa1ceXydfUg/9cqYcXPMCCXQNQM4nYatsp0+/e1umaj/jB5LQRBFIH+OZJYajPdSB3u4qQ/2yo6+8KgI/LOE5tT5PeAzz6bayVoLxaUuMpkeDeEJsfVoEA4bCCsU7PzRiK7b1jsG2DAbPFWJBdpsxiZwQuCNRROtTZzOeSFxAgS7v1n6kOQieG6INyCMiN0LssafE33U7sKKj2N9zc3AV5isdLrZ704Ic3JhhBP+nLf0VmXMpRYVtEDe7BU7xemq1l2dj8altg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqtQ/kwkyU8LsP2WPR1gkScatj2VjOhCzIH0yyzWWms=;
 b=I7d87vGWEGPT9inzkWB6cCAQ6D+fgj3t8JnsO+ZgIkR0uyXEPyBF1z/uYWtxiifUxbh1peiv/WtEVCtgcIHAqcyST73GyAaZSHqvs8ITenD0yKnU4LsGmRTT5zo7rw4Wn/Z9+lJQoUk3vuYduHlGCfmPiRV8WAejECiT53r1ZbvS9iiOSNQBPIkpbOXASeBO54UAu8DeEoJhl0ZnYnN3xhLVrr21mZApinpwNnlm1qlPhrmh6KsJCdd5Wds6mShbVXp60J8JsKKrdTfJR545BdetT50aRupbIEYKo/K0JoK64qc90YGwB50l/wG2EIul5YLaDaJS4dVmnsnnQ/pP2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 20:32:04 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 20:32:04 +0000
Date: Thu, 22 Jan 2026 15:31:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	stable@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: Fix msg_atu_index assignment
Message-ID: <aXKIl85lu+tmU8tQ@lizhi-Precision-Tower-5810>
References: <20260122145411.453291-4-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122145411.453291-4-cassel@kernel.org>
X-ClientProxiedBy: PH8P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::24) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 20744516-b4a7-46c0-e1b4-08de59f54e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|19092799006|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S6ENfn4UzAXLOEpjeGp86AzG4PT22OfaiFM3JF2x5/r/iJndQc4DkyHxzism?=
 =?us-ascii?Q?y7aqwAaYtLkVZdeph2ZWVw3fsij8I+noQxR/gkDQNWBSB7IJ/9RTXBkIR998?=
 =?us-ascii?Q?yf9NicD18EY6Axdy3Vp1N5yNNSvG0cIp4B3Ri2GG3YMnv1cvh66xBoANUy6/?=
 =?us-ascii?Q?gl8MDsc1v0j/xPTDL86jIFBz9vkxN5U/NNylzT0pUtB0vp/Hxc6MyjiMth8A?=
 =?us-ascii?Q?XGZvBoM81AvpApQ0YW2nWstvocasy6hx2TwnFQfdybMfz69SnAztPrNWGXJo?=
 =?us-ascii?Q?hvs9PczIYYsj8qWFC/99sdYxnRt2/tcGWRGcIzSltKZx7ezZYd3xOegGbawc?=
 =?us-ascii?Q?WaD6WCTcen9kF8UaWWLucFtYfSLFp8n4ePxehziVgKuG5DntoNc/XFwPoW2o?=
 =?us-ascii?Q?1kaxHntpesoZM9ckSWTHR5GH5Qo/Dfa/c2uaRbWr4Rg5L222kkFZIOk9KiVj?=
 =?us-ascii?Q?9CAgs+e/HjPdCp3/dAPaLNVm2RgpnL8FBQc1J81LQxpwENxVfbefJ72HmvOI?=
 =?us-ascii?Q?ndzjiMjvvNdMC1jYiaUmmw8IW9B/jKV2mPM4HuxztWgCyz3kUMObSw7O9MKb?=
 =?us-ascii?Q?/a9ZGYkO24BTpPcAQ97AAoXCAqM8doZzEW1hLwEmQDrIcSQ9QDxXlTTiWiux?=
 =?us-ascii?Q?5rdSkxQcIpKWJ0RUAETGzBFtENq8SWJJ88UcYcdzRIHtuLefQNr3r47Iro66?=
 =?us-ascii?Q?mzmCFICZTTFGB3LetR8ASYoXcyHVtOTWYy3YyGeukwRPFJqpJdbfRN37InAe?=
 =?us-ascii?Q?yXaQ0YWp/6cyqfuLx5W74VUdwQvtvJMzDhwSkOQXd2px1dlvR14MHv2y13ia?=
 =?us-ascii?Q?ra/h+bIsN4eZywO8+vscGTuZGiVI2r2onWq33tuaDbq2YRVPq8KVnszD2hrN?=
 =?us-ascii?Q?AyglV91MfFXyemxfPIDJgpCRMPzY3lq6biOY0oaRztqS/zE5s5YTReGFak2H?=
 =?us-ascii?Q?rnp1PLusVqbZSxWVrRWPAAGKmsYZoa3x9C6cBs9ky2lsuVK7kZukirGI8d/8?=
 =?us-ascii?Q?VLv6vgVcpx+rLuTvjSuvgH7n9mniyB2qQnnkTrPuW9aiaPTpT9/z+Fw9SaLz?=
 =?us-ascii?Q?NWTolvaONMsARDfUj5EmxCyWT29ax/gYG0WueWidB9yYB/eSBfj1eVox9RUW?=
 =?us-ascii?Q?pt4UtYCe79EpmFdaUE3uKA9cfBYBD3gglNLaRBzZdoFZfyfm5ZT5vCH1JG8B?=
 =?us-ascii?Q?V7tCihhilR4FcPpzjMEhjP2jUQIhH3HQyN8P4DNrWSbDpQGkA9jGIRXCTQDL?=
 =?us-ascii?Q?C9VemlnhSVHN8iEEr96GA1VziojXljpr+OcKGLCK+igMPY4WR4XcEnni9ABY?=
 =?us-ascii?Q?VeinTP5xjvGtZOVSW3TyMHAHGYellvEqaR88ZiPhG3EgN9ZH4cK22nHnsvEC?=
 =?us-ascii?Q?X4dWhdBMFzsHlUTzWDMNSWchVjq4dRUjIP86dir5wQwNafopP0jOl+70UwLz?=
 =?us-ascii?Q?HCk+IDwh3CAm6Nbp/GEipK/vJL6ljfi+lmj3hAdIl1aS0CQxOMNrdngdV8R2?=
 =?us-ascii?Q?0Gjf9dhoez4EGLe4MhRbDEOxYNjPhvxfLMMbGRwEeS7HVk82bTbLV6Pim+Np?=
 =?us-ascii?Q?7lKZOp16BVwohSw2QZA/BoubCHfTPuX8FCnM6NzlZ5Qv3KUe3ZN+eavmzT4E?=
 =?us-ascii?Q?/3j7EhjzIb3trTGlWXArSmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(19092799006)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nvA2ufYvqkP7ll9XXbnwhRS9k92iKQgF06j0+9r3dUEOGQIiSN7P8tqhq0q0?=
 =?us-ascii?Q?YQypPmX/bSI058UqLrVG7p8Mr5L81HY+jtqc5KJmaDOgLC5SgKjB7xOF/Cbo?=
 =?us-ascii?Q?NTv66em6qU0sLODkdTQeLr1+Pf/Z1UX4s3LHUNITrVAVn17Q7JQ67NgC18mn?=
 =?us-ascii?Q?A1mvqoEx1L13zGJxrIzuJPBmbJ0qAEZGwcXSq7iMxLTpyYuj4S/acGl0Tjl6?=
 =?us-ascii?Q?6PYXqryipi7kOHi0Xdyb6RG4gxkrdKekVGPuGtYYMccY+mJT6f8AaOSqD36b?=
 =?us-ascii?Q?Ryz1oH/SO30pgnDka0gJ4+cg5x0yAbmg9hWX2X7oJQ6F93HCBJqLqhXREaje?=
 =?us-ascii?Q?Hki0NcKalbgXmPtupRzWlG6muAhAdXz647UAKp/zOK4Rq6tk7WlTi7Lkypas?=
 =?us-ascii?Q?RseZuyoBlkbeyP9OF8GoOYpcFr1HIqNujuVIImHNI6rYd084AICDhkDZl4Na?=
 =?us-ascii?Q?b9VxCWFlvraYlk4RYMGAM15wGo4Kpx8SeT/BmFl367KaPyj8YGQvUyCCFoL2?=
 =?us-ascii?Q?KkG9R0Cq0iGb9MaLw/kBH7eiqjRbqXb7LonM+1yUeZUhNHZ+QCoKQqLPcOOJ?=
 =?us-ascii?Q?Jw+OqGxJZ7hfVuPnOaIKYi1inVzTOKlpzDcaJB2Eqjkts5pSI5Byyw6sByt5?=
 =?us-ascii?Q?/OV/UD8q531QQ6sdcbb6fEGZxCu5FwCLSaIF4a+bk03rsNHmb62Koogd+j6q?=
 =?us-ascii?Q?yM3Q6NLTIY86qJfCBYt1SqVvddF6CkzV17gKfMKarNH+YCTixsFBNh/0SLJc?=
 =?us-ascii?Q?EpKnNmdcqWBTH57Z3nXeFB2nQuhICLI93bt19x2xG9/JmhcvWodhuBrYdVQl?=
 =?us-ascii?Q?GNTB/GRzQFW3e6+uKmnSdwdfIRu4NrKRsSJdRJI5GoEbBwR7ZnEeeuvQxsFP?=
 =?us-ascii?Q?0L6E+S9RK+oD5F987SNa+ihSGMRdgRdhGyMVrSANoFelfN2GetfvbS2YDOGF?=
 =?us-ascii?Q?pCoTrjHXDgtRnYJDNYA331ywzRp4gcK+5dgKEb4kf3Snw99nLPC5rOmYY9He?=
 =?us-ascii?Q?G8t04vbt8rI2HnzYJKPT9pQH+ncq/Gp6t9DbhLoP3nKFxhMocTs686mpLxNt?=
 =?us-ascii?Q?+DfTG3BJRNhhDIwbv2W9YrazNa0Hp0N6FVMvipB6JGrXaRP3lamZ2TpYtVb3?=
 =?us-ascii?Q?oO+e0vvcmfu/XeqEJ3lIUoZvtDv27qyu8H2tYmxEPcweBiL/j/M7nmNSOX5g?=
 =?us-ascii?Q?tFCO4+fceqg3kgSRUMMkhIkaPnrzClPEqFKJs0DA+jm9D/hGC3qEveOJgG+9?=
 =?us-ascii?Q?+/SJPkYKq4esLEW22HPmWFmDI+DlP/2n9t1Rk9jP9dlkKCj9uH6aqN8FC+zV?=
 =?us-ascii?Q?0Jno4WeuT9RzVdhzDsEJ+I7Oqdp0ahmtP73qW/wNSpuvYeat3VgF4UsIOFW0?=
 =?us-ascii?Q?us4gvD0Fuh3Y5GwK9MmJWkYfJNiusBF39c1yUzieV3YMZqNFWqa58dIIu6l2?=
 =?us-ascii?Q?Jw93ZkHIUVZyZAYcAa3RYoVVbSgsd83bp+BVcocpd2nqLlzEINYoM8YiMSnC?=
 =?us-ascii?Q?x2u1UzsZqJfgGXJWinRB7cH3XjK+8pirlsLP4GYnjJ+NeC7ecQPj0x+yFF7M?=
 =?us-ascii?Q?rwosEAHgJ8ZabLw/gjktsLRVdXUGyiMduyV3r9SlyZkTULJYWWh9zMd+Oy44?=
 =?us-ascii?Q?GPxkVSfagXPaQnW3ImgNWM+afTCYvYQQkSwJnLtJTsBYYDQ7TbwbmYj3KrU9?=
 =?us-ascii?Q?wcrv83xhSon8c9V+W3sXcJuVOpNEy8gPrE56IaSoI2pyymUl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20744516-b4a7-46c0-e1b4-08de59f54e0c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:32:04.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fmg+scfffW8GZ5a8+rBQ1J5bRd6j/EcXmxyb1gP+3gHRRWGxose30vUIe8zZr0hatJVkRaANBSGR79uEWqnbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211314-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,andestech.com,sifive.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.965];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 092AF6D6F9
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:54:12PM +0100, Niklas Cassel wrote:
> When dw_pcie_iatu_setup() configures outbound address translation
> for both type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iatu index
> to use is incremented before calling dw_pcie_prog_outbound_atu().
>
> However, for msg_atu_index the index is not incremented before use,
> causing the iATU index to be the same as the last configured iatu
> index, which means that it will incorrectly use the same iatu index
> that is already in use, breaking outbound address translation.
>
> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ab17549af518..cca5fc886409 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>
> -	pp->msg_atu_index = i;
> +	pp->msg_atu_index = ++i;
>
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>
> base-commit: e9a5415adb209f86a05e55b850127ada82e070f1
> --
> 2.52.0
>

