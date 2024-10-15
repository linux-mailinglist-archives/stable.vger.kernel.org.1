Return-Path: <stable+bounces-86197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2B99EC67
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B96D283939
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011C227B86;
	Tue, 15 Oct 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gyva3R4C"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2A1DD0FC
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998097; cv=fail; b=OSX5aRYN2J13tu790yPHbOwErAhE52dXPa00xPBO7hKaXpCsSjAWYqgaNzO+3NyzrlQjCdlHx6yG0z+CRtXG+4GIpT4Gem8qgEe9+ltPtARHP+ZZzY6JsPTlXsLTnETWcXBk6HVEW4izVNtQFmLRgkhxQN0uFu858loFZDYG5qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998097; c=relaxed/simple;
	bh=prKPJ3It++8P2Z9WEMVTXNuiI25DKRKe3OHmc9gzQss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WH9th1tggffIIoOhme/185AcuIB+/FMVj/nJVz4gTe1BCp5pHVJibXpT14KAsM8GKfj8ZSAY/mWsfpqTJkmf6zF/qNGWjo7lVdKAsmJVFa4q8Vr0kt6z0CdM+SaoH0lTFrwAOBMqQ+tcvWN/gO4u0RCEcLB/A3u9PFa7trLPJvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gyva3R4C; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJnpOmXvxN9KBL0lM7JXzmZXB7JqA0zvM3YNMCucGtYHJA8UeSONuLZ5rDmK+VRIsGJoXafEaJX3cg4iQ457jGWIE57FxVo2GYE0yzpovayVkpBlkIJ4zviB7PXX34q9xAedZ+nzKq+CB+Gc7Yq84Rf4Rq9dP5ev8DUB15hNr+nxq7GQXw+l2NXTQ4RxKLU08zfQ0qFT8fTnVXMAaEbrFV9h5bWCMYva9GIap0F2Xo5z6kZGxkCMXLRJzIpSHG3wCAu+9ealMlYKHIJG0nR10xoAHDCBd/eMNyq9JrF7fkZvjQT2OLbfuCrA8gPmdLwEcdOrGJYkOLQpON9kDgtxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lYOnmj2a04rflfxwy2hOZmax+GcNGLyoevOHhv6EnA=;
 b=idiNq2egVkRgbMvhKNspU3uXoEo9VB6JXw5qUPqgHBT7dUr6MBhfdg4Yey9nnLA87jLV6ihCxP7VKOMV6Tv6swt5N9DF99v4bBLqjYDTpSEmJ4pyRPioQRSE8WsRlxzosm5rm41LPFMEFkWukTFGoMdmMxXqafAAlrpjCsCkHZiuhAXFAkURGAMsK3DQNl5LEr8EMB2bPM0B6F4IjPoRmjdRw5RPvXOWpPnYHw8oOEsATw3s+JvoLn/Ab03BEeQi44hUOUoBhTk/jA46fuEldOa+hxglB+yUhrAEY2DriERK6IWmkD8q5vjZW1yEQZaIitmqu8fjm/W+v6aS8XGnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lYOnmj2a04rflfxwy2hOZmax+GcNGLyoevOHhv6EnA=;
 b=Gyva3R4CDkWAcSXoDCxh/pTXMCgGrhJaOQKd17cMttB7ez26RfTQX5SdCV/J5AyAYcqcvmLhx+CDns6TBxi3r7KyWh4tNWUi8yFZ76Msfxf9K8ChmNIgkLKTCWhgLbQ790ABcCbSswnlCPnDDrmFBDgmsTD2YguXYjr74ynuhFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:14:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:14:52 +0000
Message-ID: <1284976c-8fc9-4eab-b01e-a8a12790541d@amd.com>
Date: Tue, 15 Oct 2024 08:14:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to enter idle
 optimizations
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
 <20241015081713.3042665-2-Wayne.Lin@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241015081713.3042665-2-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:806:121::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b36eae-0669-4b8a-36bb-08dced1b5ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzdJdktwajIzazRuU2lIcjB5SFNJRkphY1ZvOHpjc2VuUC9ET2p4SG5SRCsz?=
 =?utf-8?B?eXZZVXdFSkRqWVBmUUFJbkNLcTBnQnI1dk50R29UNDBkcDJqL1VsejhYdWJk?=
 =?utf-8?B?eGN3Zk1jcnlURjVCNE5OeWhWU3lZVStaV3Nja2dEUEFMTldjSm5TZHFrN0tQ?=
 =?utf-8?B?dVdVTFdCNndORnpzRU8vMEhJWGdKa0VvWHV3bmxRYUtWYkwvL2NJRkhqdTI5?=
 =?utf-8?B?bkZYNVdLRTRjRGRnd2x2TkN1RlN3L1dYajJTcWdPOXNiLzA3YzVjaVRPcjNC?=
 =?utf-8?B?d1V6TCtWZW8wRURwWjN2RUdJSUhPZGkxSHpLeTFPcW1ZZXlTRzI5MTdnallo?=
 =?utf-8?B?RnJmakpOd0VFeUNnV2s1V284S3A4TFdwSkNDUERBTmdKYUlackN4L1lmSDNs?=
 =?utf-8?B?RXMzTEJ2SjZOZ0loKzlRWDZFSkNDMFRNN3lPSHN6TzBvRnh6anE4bGdXOXdT?=
 =?utf-8?B?ZHIwQzhvTjdOSUh5L3NrNHNoZTBZZWV2Z1F4Y09hSmNXLzUrV0JVRlZ4SVhn?=
 =?utf-8?B?QkM5TWZmOWFodXVkUmtPeUhZeEhWZFZWY2EvRTZWTWZpWkY1NjZZbXlYdmd3?=
 =?utf-8?B?MmNaRm4zaTd6ZHhSMVpOQWdQcDlwV283T0lFTHRVaHp5b1g4Sm40aUNtVnBT?=
 =?utf-8?B?YmcydHhhT05GMDNhdCtKWnBuMnh6SnF2ckxFWnJMSGtrK1hOZkRRSTFlK3kv?=
 =?utf-8?B?dzZSemEwYVV6VG5seVFKS1lja2ltUzd4UXl0Q0lDVW5WekREL2dDRUJNc2RZ?=
 =?utf-8?B?N3Rwb29xejBsa3ZHVktLRkNhd3JORFN0YThKYkp0ZE5iL2tPeFJVNUtINXhq?=
 =?utf-8?B?by9JWjVHU2Zab0JGcXl1MUdjMmhBV1RLY055dm9HQXc1TWc1UHJaV0ZlbGZX?=
 =?utf-8?B?QmhoVTZJeXVXTlI2SUdQY1c2ZWZ3ZGZBekhNc2lyRU5TTzluKzV5VmJxWjJl?=
 =?utf-8?B?eUNyZ1Y3N0RtVjFTckxWUGY1UHNRR1pSSHc5allEZC9vRnJHcDAxd1dycmc2?=
 =?utf-8?B?Z1FEK2R3dnkxZWhTcGg5eGRsY1dPUEE2djE0MGZQUHFLeWFDUmk0dkFDU1pq?=
 =?utf-8?B?VjZlRmlPOE9pelVUc2hFOXdEOFplYnVmQUFUTDBCbWJXbUxCbmJxVUhZUVUy?=
 =?utf-8?B?TEJYTXZBb0FnQVZNV09SUHRPYTFCd2xIc1VkUCszZHNiaFBic3MvZzkrU0cv?=
 =?utf-8?B?UE5vQ1hxVGVpemN1YzRzUEJzbmlXcklRYzhRSlpnU0E5TDNSV1k3Y0RSNmR6?=
 =?utf-8?B?Mzl6K1JkM3JwV1MvM2s1RkkvTXVqYWhscXhzcTRLSUM5eUNJcU9aQU02NFVM?=
 =?utf-8?B?U3JHOVdWdVNFaGVxSWZWRCtVMUxCV3NZbzB6aFZkNDA3dDlNbjBsQkFhNHFr?=
 =?utf-8?B?S2hZVjlmUlJoZ3F5MFEyUEE4VXhUVWtVZDNjaXlsVkZ5VTBXeWQxYzc1ZzRL?=
 =?utf-8?B?bjVLM2RITGtuQ1RtSlhwRDB5ZXRIMHVzdGlVa3pKdjZzNWd5dHJPdDdCS2JJ?=
 =?utf-8?B?M2Z4NXc1cVFMcnBqOGxOTWlRQ1EyQkNVd2dFbkxmREVmMU1kNW1hQ0JHMXBa?=
 =?utf-8?B?aitJbXROaCtIQ2FnWWJSUHdnS0NJNUZqbmVOaDVod3YrTU5lUkk2NVVTNmZx?=
 =?utf-8?B?dXE0eFJWNlZ1MUo0UDlkTlVyMnBHZXprdlpqSEs4eGtuVjlLcHltVU5VQ3Zz?=
 =?utf-8?B?YlJOUHBvUHRSSGZobnVpVER3aUgxMENCSlJpWE1TNXlaaVdaUlUrK3lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnNhODFub1M4QitsNysrWkpGTll1VmxPc1N6OHMwY2VQSmh5dXMzMm9WOEo2?=
 =?utf-8?B?TlFSaXBDMjBzblhKYlhPV2ZwRlJiUXFIdmdmVFhTUng0eFl3N3RVVFYzeEZW?=
 =?utf-8?B?ZUprc2syNDNKa25KSy9tS1Z4SDNsdDlUVzJIcHE1eW1oK2pLU2NsTmtZOW9Z?=
 =?utf-8?B?K2dWZlpuTHNSaU1WL3dzV1NEVVBuWVMxdXN2WDVyNG00TXhOMzRBb21KZVBl?=
 =?utf-8?B?OEVWeUo5U1RFTyt5MjBIU3VPQ2dMUXg0Z2VqbDc1dFY1ZnB0cGltVHRXdjNx?=
 =?utf-8?B?M0hLcThNWWw0Q1gyWXVwaW5XQXZkRFE4ZVZFOFh4bHZzOVhqWWo0dG1tNFhh?=
 =?utf-8?B?SmlyY0NDZTljMGM4UmlBbS83ejZVR3NWTnFDVm5DRmJhMU1lY3RmbUNaQmFn?=
 =?utf-8?B?bFpWdnFXVXJQZHRsSVA4UGVsam5nTmhkc01ZK1c5WUJFQ3M2ckRkR2JTR09m?=
 =?utf-8?B?WjZkMzlXZmphYkNHay9hT3oxa3lVUldTT2tOOUpPOEFWQllVZTNFSjl2ejV4?=
 =?utf-8?B?ZnNrR1JlR1R5c3d2K3hXQXNVQ204akFOVlVtTDNwNmZ5NTFHVmFUdDQ2UWEv?=
 =?utf-8?B?d0wraUF4K2ZCYUd5eDBOaC9Vd2x5VEVMdkhMK2xhejdqcnlhb1d0a1B0dzUy?=
 =?utf-8?B?K0Q5QW1CcEU5RXdFSCttbWZ3ZUR1VFRJbG54aGVNR1lpSHpiUExEbFBCQ2ZK?=
 =?utf-8?B?R2NRVlZubEtWYTBzL1l3d1JENVg5Zmk2MHAxL240SDlLQzRvYzRScUxLd0Ny?=
 =?utf-8?B?QlN3d3ExaDRSek0zYVQxRS84bDI1SFF1M2orYjJUN2dPbW03ZzJJRGlsR2t5?=
 =?utf-8?B?VDd6MGI0TmY5NG82K1hYamZ1YVNrOEVsSmJBdjFTNXFzZ3N5L2xmeEVUaldp?=
 =?utf-8?B?K3pZcnJpOHhlWDZwWXl1WVBSZXRNZGtnMWhsSEN5YnlBcEZDWFFLQVdDbnlo?=
 =?utf-8?B?UGo0Tk94KzcxUlJzeVpRZXFuZWxYMmJMRnEvTXA2RzByclpoaERUdTdhQlpB?=
 =?utf-8?B?VlZndVJsZVNhMHBlaWxYUDVITUhQaGpXVG04Tk1KZFhCQWZDb3ZDUmVLUjFG?=
 =?utf-8?B?Ni9rN2dNcW1RRk5oMWhLczl1cHA1N3ZVM3ZYQTdsTTZML2NvL1RCeUlwVmRE?=
 =?utf-8?B?TnFWSndFL1puQ2ZBNk1VVUpSbS9JK3V4L2F5RTRpUnRMYUNwY3p4czZkeFdn?=
 =?utf-8?B?ejl6aWtFbktTdVhZTHR5cVIwVTgvblNia1BCdGh1TndhOXRJU0ZBb0ptQnYz?=
 =?utf-8?B?bkNrRmROSjRNemlMOVZ0aWtaQThTSVFGeUpDN1JhZUhkQ1RIZ0pvR3FoRkVu?=
 =?utf-8?B?MDBqM1grUXJQdW9hUDlhckxsMnhubGEvMThjaWZjUUViQ251Vm8yL25waWVp?=
 =?utf-8?B?VWRISEtGcDdJUTkwbnBFUUJsVDMvZks3cFN4ZzZVcTg3b1hHSEZUNFVGSTZP?=
 =?utf-8?B?ZVJ6cW5NUVc5WEg4U0tkTWIrQ1ZSMzhsdzdxWU55cjF6bDBqek5PQXdoM1N3?=
 =?utf-8?B?QTh2YnNSRlBBUDRBbSsvNmJIbHJHRElmNTkvM2VhRi90YTNqSGxMVXNCNEtU?=
 =?utf-8?B?UnI3aWNKem4vQTRhZkc5SEVHcWRxckFYRkJQOHZrUlg0TktSd1MvQnpOYXVH?=
 =?utf-8?B?dzR0SldqbnNQU01HdXIybXF3T0hxMVplZkcvaTZHeFQxVTJnSmppTDhiSi9D?=
 =?utf-8?B?U3oza3QxZndGMGU3YURWS2hydGl4Tk1vREFDSkd3N0lITXFHSzRMdGJkUXVR?=
 =?utf-8?B?YTkvaytKQ21NSnZyamFHbjcrMktpa0hEb0MxcXNsam1NRERQcUo2d05XeDVW?=
 =?utf-8?B?VGtWZ29OcC9FR2xXcWdML2VXT0h0alUyeHJRUXJkRXhrYldJMDh5V0hNNjJq?=
 =?utf-8?B?RC9PUHNNeUZWVUtzbFVraTI1aHd1T0NndXRRUVZHS3VpS3VLbTBOek1TMCs4?=
 =?utf-8?B?eWt0SXJ3ZWVHb2w3bi9yOVVzVXdVUjRWOWt3azJweUpEdnAvb0VEQTRBeS91?=
 =?utf-8?B?czBsNGdab1JvaXZvY2s2cUFCaWFSSUxyU0Y4TXN1SVhyczIwMGh3Q3lzK1BD?=
 =?utf-8?B?Qzl6TUNFeFpscDI1cjJjbjlzRENrSGJlY2RoMjI4ck1tRnlDdDAvY0F4c2tX?=
 =?utf-8?Q?b5EW24KDKWQ69qBWrJDoLbjhs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b36eae-0669-4b8a-36bb-08dced1b5ac8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:52.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+MbVDp89umwWnpqr/7g4P7JCDGqkq23XQZjbkAcqU8wb4r/NaoHkJs7BKLi4JkynsPtidZvo1aN+vh4r8vzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825

On 10/15/2024 03:17, Wayne Lin wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> [Why&How]
> vblank immediate disable currently does not work for all asics. On
> DCN401, the vblank interrupts never stop coming, and hence we never
> get a chance to trigger idle optimizations.
> 
> Add a workaround to enable immediate disable only on APUs for now. This
> adds a 2-frame delay for triggering idle optimization, which is a
> negligible overhead.
> 
> Fixes: db11e20a1144 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
> Fixes: 6dfb3a42a914 ("drm/amd/display: use a more lax vblank enable policy for DCN35+")
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a4882b16ace2..6ea54eb5d68d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8379,7 +8379,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>   		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>   		    IP_VERSION(3, 5, 0) ||
>   		    acrtc_state->stream->link->psr_settings.psr_version <
> -		    DC_PSR_VERSION_UNSUPPORTED) {
> +		    DC_PSR_VERSION_UNSUPPORTED ||
> +		    !(adev->flags & AMD_IS_APU)) {
>   			timing = &acrtc_state->stream->timing;
>   
>   			/* at least 2 frames */

Considering the regression raised [1] is on an APU too I wonder if this 
is really the best workaround to approach to this issue.

https://lore.kernel.org/amd-gfx/9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me/

