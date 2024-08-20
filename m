Return-Path: <stable+bounces-69747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CE958E03
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 20:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731DA1C21927
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3B1C3F3C;
	Tue, 20 Aug 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nJYW8ezM"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A311C4609
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178510; cv=fail; b=uN6VbPlCFRYkHglyvHGfS8o37htV7yYjxWXepdTP3trq2Tecn2XoXMnKeDvfO/1LtQ4PrJ0U3JHzTNDKzvMQlzBpC/bjrdZpiOIRY3JQ4PiGLdRbe5z8mF7aPlWCX714nt7V31tnbkZ0SeCZVuQQCD3edxlHuyK8xuCNdIU6HnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178510; c=relaxed/simple;
	bh=zHAZM4NXtooVNQXsYX/2W2tpMdxc2aLlXrbNycTdkQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kJU5t0PBnXQcnC9yfZ/pFsCYP/2eBYeFxvaQHNSpEDkozLnYdp1YVHA5VLDxvjedcaXKxWcJlr5jxKiK45OzGtwNsH3F4jbTcNLjy9WgfxVqfl2S3RdvpisR3O0AXYsQSnmeop8qA3Yijwvut17Wa6QSeSEk9w0iAnwI9If+f2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nJYW8ezM; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNYMa7/o0J2Tmh7VtUyUaARdcuxafBWN6DgWjeXm/32ABVVciVi+CBowHTAGoeOmUdl0hdLjfbEazxM4jHQj1c3eMxXbKhY6gPggr7jE2wr4FsFK+jse8kayyubeXkP7DaGc4eB/c6Mg/3/ne64jYO5dZ1lgQU9H3DUxpnjslh2+plyC9mPjvTePUMJiY/GAXpJpVv4FRPyagchZFqWr0ILx9ncc/gbbVFKwfAoJWO2N/yXi2hBMT8eQMiY9JcshwNHuejiYlTFW5hdEETyWx7hOaheCXz583jjcAYtrrbtmAWVSwa6poezmCD3I+RURZIw5ybXpuNteBXI8sZY4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHAZM4NXtooVNQXsYX/2W2tpMdxc2aLlXrbNycTdkQg=;
 b=k9phPd70ibjnnGroUdWQ0eg6lRyUzAEu7vRhinXNvAim1w/3iVGMxgGXSEMNLojVK9dz3hBiWjGifTR5CV1Ha0kbT/qZyUJU02e5Zo5Q1Dlw5N5eiVyJ9tQ60SHW0XIhPwMPczxWqqSgd8t2qtOL9QHT6EGIc7rppmSmsUXrRqXAa95hujfuXoeY6zPYsvPPDxXvO8Bnwuw/lHAEKN1Hsz8Hrc6KrTWw0AI9kQlb1E0nf833q5WGQVekaMHd4Atg0MPzhjCo9SzQZjeLbzSp31oU35MJ4nFY813NBorn/FIDv6xhiD6waaOUiqtTJRWzBaly12KSa8xsvEDnin3gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHAZM4NXtooVNQXsYX/2W2tpMdxc2aLlXrbNycTdkQg=;
 b=nJYW8ezM38iK1jtZO/2fsCbFPb6pvuo0p0RaKXFlfGnk0NLSKgLW3s2hb83XMK12oxALYruPcx3qI2pMB7b6KZY471/M0IMvlZSEE3AChZY4CPzh+EI4klg+GRzuuymqHKXoGc1zgnnH7XfemTjbpg+OseSa9M6wP3kD8xSRMsA=
Received: from IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 18:28:22 +0000
Received: from IA1PR12MB9063.namprd12.prod.outlook.com
 ([fe80::2eee:d305:3a90:7a86]) by IA1PR12MB9063.namprd12.prod.outlook.com
 ([fe80::2eee:d305:3a90:7a86%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:28:22 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Jiri Slaby <jirislaby@kernel.org>, "Li, Roman" <Roman.Li@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
	<Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne"
	<Wayne.Lin@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
	"Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Mohamed, Zaeem"
	<Zaeem.Mohamed@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Topic: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Index: AQHa8rxP3sui2PAPUE6lTVPfU52mPLIwIt7w
Date: Tue, 20 Aug 2024 18:28:22 +0000
Message-ID:
 <IA1PR12MB906330068545FC761DB98FCCE58D2@IA1PR12MB9063.namprd12.prod.outlook.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
 <20240815224525.3077505-13-Roman.Li@amd.com>
 <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
 <360cabdc-3ba7-47a0-8e4f-f0ed8cea54bc@kernel.org>
 <CY8PR12MB819387431D6D6E754929ECB9898C2@CY8PR12MB8193.namprd12.prod.outlook.com>
 <0d12eb50-c51b-496e-a931-9ce8fb6a1455@kernel.org>
In-Reply-To: <0d12eb50-c51b-496e-a931-9ce8fb6a1455@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ec1384dd-6d64-4714-8c8b-78a07637acd6;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T13:23:39Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9063:EE_|PH0PR12MB7486:EE_
x-ms-office365-filtering-correlation-id: 72ebe575-c099-4278-2969-08dcc145df26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGh1NnZ5TXFCSUx6L0JuMVNvK1pMZ0ZRT252YzJ1S29Mb3dLbXl4Vkd5U2pE?=
 =?utf-8?B?RFIzUHBQTmkzbHRBY05FTXRKdzhQU2RvaDZ6K3VzM1JsQXJDckNLWm9QV2NV?=
 =?utf-8?B?QjlURXZmVzlPb0luUmYzTWZldEdvcmcvNXBwSkFSYjF5bHBqeXdOVUQrSVEw?=
 =?utf-8?B?UWRUT3hWWG5qQUsxWXBvK0FvclFXbjhqZ3Y3ckkxeEk5bVNhZHMrb1ZhUUJO?=
 =?utf-8?B?cFdyRW8ySHVmU3BVSFI1MjNTOGE4TlJ4OUlBNXdqMWc2ZWhYZXhjVFlHQnE3?=
 =?utf-8?B?YXk1dWtZZDJIUDE3Tkswc1J4TU9XTjhCUXQxNkxBWmI4alpJOVVxWHEyUzJ3?=
 =?utf-8?B?NWxFWUhVL0lnd1VzcXBOck41S1hLZjY1emExSElldkdpOVVKWFhWWDhLdnB3?=
 =?utf-8?B?a2RNQ2wxd01VN1dyckJaallLemZramVwcldJU2xKbmRBSmlWeHQreXh2OU9z?=
 =?utf-8?B?SXNseFNhM01ncXk0b2RKV29DT0VERkYvYmJTeTB0c1hKTEFhV3RxcG5aTjR6?=
 =?utf-8?B?eFJudStiSXJpbXpibHFVbGdkbGZEaDAxMEQxSkU4UVN4a3IvQjZVeVJvNmxG?=
 =?utf-8?B?RGlZcXFaQTVDc3d6enVCc2NoM2J3K1F0YTA2YkE2WmZhRlNhcFVQUkNmMDRv?=
 =?utf-8?B?a3d4dWxiVHQyR25qSUIxc3dISnNRQTJhOFpoUEdGZ3Ayd2V3ZG9pelRLd3dw?=
 =?utf-8?B?NVlHb2Q5RDlZUHI5RVh3VHoycTlHYzFGdXRkRmxuVVc4SFFxYm5FZDdXWkNP?=
 =?utf-8?B?eXBJb0NiQ0NMTzZkbjU1MHJyU1BCYTJzN0VpaFBqc2dPcjdUcFZhaHE1cUZF?=
 =?utf-8?B?YW9SL29MMmkvbkQ3TjhMUFZIemNGVFJZMEZJSVFuYnUrUE1QV0FSWDJNcnFt?=
 =?utf-8?B?enVkR0JXTk05bHhCUDJRbHBkR00yQUtUMVVDWU9PcnlUMkR2cElFTStUYmhV?=
 =?utf-8?B?TVUrbEloaVU0RytFc2haSVBtYXZpZkpsbDZFNzVEeUtXK2ZZYlg0aWRuVTRU?=
 =?utf-8?B?cTVhOWw2MWJtb2ZDOWdma1VyTHNXRzVqVlEzWEN3NzFXc3RseGJJTWxGNVI3?=
 =?utf-8?B?dUlMZFlITnpNT1UwK0kyMkJHbklEakVsZkoyRk02bHBZYlhyVjRuMVRlOFpt?=
 =?utf-8?B?VlhnV1ZxS3pmY0ZIc3B5U2pSUTVzMllZY21PYjJyQlNEQXpnMlFUbTkraHBJ?=
 =?utf-8?B?Q0NPU09ROTJPWG5qVHpQa2Iwd3FiTWFoU3ROUktGUnZ5b05TYWtNVzJzQUs0?=
 =?utf-8?B?QnJ4TW5Md2JDOWgyQXY2ZytGU1Nqa1d2M01lSHpxMk9EeHNSVHNISkZ4V3Q0?=
 =?utf-8?B?UXpoVVdzczVVNFh6TFE1cjhKWVpsSHRxY0ZNWEZBcGoxN2VWazY5L2tUR3BT?=
 =?utf-8?B?Y0RkcG4wUXhwZUtOclRZMkg1Nk1mRVUzQ0ViTXJRNXA3eUdlWk00Q0ZtVSs1?=
 =?utf-8?B?UWhlU1cvVzh2S1FKcFcxbFdadVNIUXFscXY3V1ZRMkpWYnY0SjR0c1ZLUFFM?=
 =?utf-8?B?K1VSWUlLRE1pUHliUFVaajBTYWUxYWlEMVN5Rkd3djRFdTlScU9seWlxbHQw?=
 =?utf-8?B?ZjdxSUdCSEJUK1lxRWJlaUNtczRxNDJIYWJDekJUZmtRUWl0azRYWE9QZlZ5?=
 =?utf-8?B?ZmZ5TWlCOE94ZUo4WEVpR2xTWGViaXY4MGM0L3ZncVZ3ekFZK0FjcmdUK2pP?=
 =?utf-8?B?UHF2OVQzSVNqZit2SWg2LzdoWmh2NjNQaDVka0E1S25BSWhERENLbElSc1Qx?=
 =?utf-8?B?NThFMGd6d2xwUzFrWEVDVmFiS21DV3NaV3M3OHZKaWVLQWdEMXp5VXR5N3Vj?=
 =?utf-8?B?RDhpLzVHODFGOUdESUs1MUFXb0hxanBTQmk3bWNPUWVSa1lXemQ3ZXlzTHgz?=
 =?utf-8?B?YlhBL25DakZNaDFJSGpwUG85ZHA2VTA3OTRLeldFano2RXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHMvRlBVQkZ1TUlsdHVxQmFrdGZGZVBlT21tVU94UTZ4QXI4cDdIVDNLNDh0?=
 =?utf-8?B?ZmwrR3NNWVg0THhPZExwR0lEWW1iRUFWUFZSZVlOUTVZY3FJSTl3NzEvNEZL?=
 =?utf-8?B?R0hHaEFtcjV5clQ1YzA0UDFLdFZhSGZHc3ZVVzdjdWtva3hHR3ZMd3hSTzNO?=
 =?utf-8?B?ZFB5L282ZUVoSHpQL2VqMFlpK0s3SkNOeVRNT2NvYWhWbmVRMVQ1WXJuZ2ZH?=
 =?utf-8?B?YlUzSG9PRVlmcm51QVhiNmYyYVRCMlA4aGZaWU5NOFFJNzhMdXVDL3diM2tn?=
 =?utf-8?B?VVd5aDhCaUJMVHIyQTFCTVNhQktJUldWSHZEWlVLK2tLWC8rQU9NSUJMNVUv?=
 =?utf-8?B?cDIveTU5MWJCNnJ0aFJBczFpZUNWdS91RTRkMk5MaHk5MUJJZEZ3SG5FK2NY?=
 =?utf-8?B?QU1FYWRDMFhnL1dRbGNJYm9lcGMyMHZ0M0ZKeWF2SWdRaVI0TUpZRHByeFRw?=
 =?utf-8?B?TExpRjY4SURQQ3F2YWdoOEk2ckppZ2VPVk9TWFdqM2g4WUZHR0REbDFnL3lu?=
 =?utf-8?B?RjZEdVVYdi90N0pGVUc0dXNsTERmTDFBNm9MWFBsQ3Mrd0JRYlp6UURhTmQ0?=
 =?utf-8?B?QXhSbGVyWDgwWTFIanB0RjRiZXVkTTRjc1R2L3dRcVNYTlRMNG1Sd0lGRlRp?=
 =?utf-8?B?Z3h5TWljTlpkbE4za1ZxZUdZelVJdms4UktHYVF2dEV3QXNvRUFGTVEwRE1r?=
 =?utf-8?B?R0NuN2hKSjRqd2drY21Ub2JrZ1o1djJtcU9sZkpQOWh1SGdnZHlpdnJtU3gz?=
 =?utf-8?B?RmVBdFBQVTlaMUNMVUR3MTR2RjQwNy9maWZ5L0ZVL09nZGhRb0ZVclFJbVF6?=
 =?utf-8?B?MVJqLzdUTjgzM3BnN3VwNEgzNklMMk9lWC9LMXBvZmRHZm9MUjB0Mnk3aW5w?=
 =?utf-8?B?QUpDc1FwbmJsUGp5SnM0djN3TElLNVM5R3M3cUg3RnZNTFlyMEI5RldpOFI0?=
 =?utf-8?B?YUJJOEZ4K0dxVTA0VnJrRUt5emsrZ3J3T3BEcyt6dXN0V0ZMS2wzcDZKRFZZ?=
 =?utf-8?B?QnZyaWoycW1NZURDc24yZFJyb2Q4RnBLNlA3bDgrdHJmTUtqMFcvT0YvMzRP?=
 =?utf-8?B?N1JtM2l0b0RzVzArSXJNaXhOSUZnSkZ6ckFMbyttNmpKRUljV1hnaW9EZGFq?=
 =?utf-8?B?aGFFY1VFeWpXWjZ1cVFTVHdpYzdna1ZqVUJDMUI2TkFTRndUZ2tZUTROdzBZ?=
 =?utf-8?B?b2ttd0FlNkNIMG5BN2RYOFY2M0pwVTZIY0dRS2t5aG0rYTJSNlZoVUNLaFQ0?=
 =?utf-8?B?ZWtiT3RCanh5VU9aa0VhTS8zR0lzeXJqdWxNQlFuUDY1bEpLejdBc2tCbmdW?=
 =?utf-8?B?YmlobFpFWnZrdXNJY2E4WnN4Z3RaZ3F6VndZRzNUbDc0K1NxSjBQSkVMN0FP?=
 =?utf-8?B?cHhFNDZJV1l5ZkRITGxicGRHMnBMVTgwWmZLTklBQkpPOTQreENhOHlkaGdI?=
 =?utf-8?B?Ty94c0IzU0FJcmY1RWRmNnRuWEdvT0xHUlRTUGRCeHRQeHduU2lCbkswZHRO?=
 =?utf-8?B?MUIwSTA4cWp6clFTSjk5cVRrZHhtaExiWlF4dCtMcU5jVzJhUEVMVStzcSsy?=
 =?utf-8?B?YmNzQTRIVS9jK0xtWmY0cGNKc1JLTXlOS3ZaT095Y3ZVNUZ6YjRVYi9YQ09D?=
 =?utf-8?B?M0VyU2E3M1IvdW9JRERZQkxyNHFLcEY3eU1FcG04bjZkd1hONFBRMGJ6UHNk?=
 =?utf-8?B?U2dkSG11R3N2ZHRvMzllS1E2eUNzeUlhNHlVNUtEQmtwZFdoWnZEdmVrNlB5?=
 =?utf-8?B?a2tBMHI2QkNEVm5ZSGt4TE5ad20waXFaT0lFVDRUVVlKbm5nSXVSa0xZNDNC?=
 =?utf-8?B?MWQ1WXFPaFk2T1pLUG1DMENoZ2JpSTVkTmRGejZ2cWtlQnAzVWU5eEJhcUMz?=
 =?utf-8?B?ODBJTDUzRVpwOUpkeXZrWGgyc1pmZGtDeG1MR1ZaZ2EwbzRsOTNsbEYvYmRP?=
 =?utf-8?B?Z1JRVTNwMFlxd254RFBIcStJTS9RdHFqYmZPb1R6SXorc3RIOENZejFrQ29M?=
 =?utf-8?B?cVhMb09mV1NiYWFnWm8razBlZEQrMUZxNVFRVWxKMFhRVVJmUmtjcG1yTjRW?=
 =?utf-8?B?ZkUwdy9ubEFTc2RRMDI5dzc4Y0IzUnRuYktyVDB3ZkNUak4xVnNzTlVSYTdR?=
 =?utf-8?Q?FnTY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ebe575-c099-4278-2969-08dcc145df26
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 18:28:22.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TER9mNOeYzRhGn9FtAyin0pM6J4GATaLkB/hK4HZk/FxYG5BWVvicZjUyuOPs0na
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgSmlyaToNCg0KICAgICBQbGVhc2Uga2luZGx5IGxldCBtZSBrbm93IHRoZSBrZXJuZWwg
YnJhbmNoIHlvdSBhcmUgdXNpbmcgdG8gdmFsaWRhdGUgdGhlIGZpeC4gSSdsbCBwcm92aWRlIHdp
dGggdHdvIGFkZGl0aW9uYWwgcGF0Y2hlcyBvbiB0b3Agb2YgKCJkcm0vYW1kL2Rpc3BsYXk6IEZp
eCBNU1QgQlcgY2FsY3VsYXRpb24gUmVncmVzc2lvbiIpDQoNClJlZ2FyZHMsDQpKZXJyeQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEppcmkgU2xhYnkgPGppcmlzbGFi
eUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMjQgMTI6NDkgQU0N
Cj4gVG86IExpLCBSb21hbiA8Um9tYW4uTGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+
OyBMaSwgU3VuIHBlbmcgKExlbykNCj4gPFN1bnBlbmcuTGlAYW1kLmNvbT47IFNpcXVlaXJhLCBS
b2RyaWdvIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+Ow0KPiBQaWxsYWksIEF1cmFiaW5kbyA8
QXVyYWJpbmRvLlBpbGxhaUBhbWQuY29tPjsgTGluLCBXYXluZQ0KPiA8V2F5bmUuTGluQGFtZC5j
b20+OyBHdXRpZXJyZXosIEFndXN0aW4gPEFndXN0aW4uR3V0aWVycmV6QGFtZC5jb20+Ow0KPiBD
aHVuZywgQ2hpYUhzdWFuIChUb20pIDxDaGlhSHN1YW4uQ2h1bmdAYW1kLmNvbT47IFp1bywgSmVy
cnkNCj4gPEplcnJ5Llp1b0BhbWQuY29tPjsgTW9oYW1lZCwgWmFlZW0gPFphZWVtLk1vaGFtZWRA
YW1kLmNvbT47DQo+IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNv
bT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxMi8xM10gZHJtL2Ft
ZC9kaXNwbGF5OiBGaXggYSB0eXBvIGluIHJldmVydCBjb21taXQNCj4NCj4gT24gMTkuIDA4LiAy
NCwgMTY6MjksIExpLCBSb21hbiB3cm90ZToNCj4gPiBUaGFuayB5b3UsIEppcmksIGZvciB5b3Vy
IGZlZWRiYWNrLg0KPiA+IEkndmUgZHJvcHBlZCB0aGlzIHBhdGNoIGZyb20gREMgdi4zLjIuMjk3
Lg0KPiA+IFdlIHdpbGwgIGZvbGxvdy11cCBvbiB0aGlzIHNlcGFyYXRlbHkgYW5kIG1lcmdlIGl0
IGFmdGVyIHlvdSBkbyBjb25maXJtIHRoZQ0KPiBpc3N1ZSB5b3UgcmVwb3J0ZWQgaXMgZml4ZWQu
DQo+DQo+IFRoZSBwYXRjaCBpcyBhbGwgZmluZSBhbmQgdmVyeSB3ZWxjb21lIHRvIGJlIHVwc3Ry
ZWFtIGFzIHNvb24gYXMgcG9zc2libGUuDQo+IFdpdGggdGhpcyBwYXRjaCwgaXQgd29ya3MgYXMg
ZXhwZWN0ZWQuDQo+DQo+IEJ1dCB0aGUgcHJvY2VzcyBpcyBicm9rZW4uIFlvdXIgYW5kIEZhbmd6
aGkgWnVvJ3Mgc2VuZC1lbWFpbCBzZXR1cCB0byB0aGUNCj4gbGVhc3QuDQo+DQo+DQo+IEJUVyB5
b3Ugd3JpdGUgaW4gdGhlIGNvbW1pdCBsb2c6DQo+IEZpeGVzOiA0YjY1NjRjYjEyMGMgKCJkcm0v
YW1kL2Rpc3BsYXk6IEZpeCBNU1QgQlcgY2FsY3VsYXRpb24NCj4gUmVncmVzc2lvbiIpDQo+DQo+
IEJ1dDoNCj4gJCBnaXQgc2hvdyA0YjY1NjRjYjEyMGMNCj4gZmF0YWw6IGFtYmlndW91cyBhcmd1
bWVudCAnNGI2NTY0Y2IxMjBjJzogdW5rbm93biByZXZpc2lvbiBvciBwYXRoIG5vdA0KPiBpbiB0
aGUgd29ya2luZyB0cmVlLg0KPg0KPg0KPiBJbnN0ZWFkLCBpdCBpczoNCj4gY29tbWl0IDMzODU2
N2QxNzYyNzA2NGRiYTYzY2YwNjM0NTk2MDVlNzgyZjcxZDINCj4gQXV0aG9yOiBGYW5nemhpIFp1
byA8SmVycnkuWnVvQGFtZC5jb20+DQo+IERhdGU6ICAgTW9uIEp1bCAyOSAxMDoyMzowMyAyMDI0
IC0wNDAwDQo+DQo+ICAgICAgZHJtL2FtZC9kaXNwbGF5OiBGaXggTVNUIEJXIGNhbGN1bGF0aW9u
IFJlZ3Jlc3Npb24NCj4NCj4NCj4gU28gYXBwYXJlbnRseSwgc29tZW9uZSBpbiB0aGUgcHJvY2Vz
cyByZWJhc2VzIHRoZSB0cmVlIG9yIHNvbWV0aGluZy4NCj4gV2hpY2ggaXMgYW5vdGhlciBicmVh
a2FnZSAobm9uLXJlbGlhYmxlIFNIQXMpLg0KPg0KPiB0aGFua3MsDQo+IC0tDQo+IGpzDQo+IHN1
c2UgbGFicw0KDQo=

