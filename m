Return-Path: <stable+bounces-93024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC99C8EA6
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE7282698
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E5015666D;
	Thu, 14 Nov 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HT6H2XAm"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BF1714CF
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598752; cv=fail; b=t8QgfKdpSZcUDOn7sNoNr5IpfPqA9BcglvXPwzGYVlZJK2p7xbeDU2F4hQumKQqnQfVuANaN5gdYb2C0kDLJq/Cq0+9pGwSiQPErdd31knYii//AghbYOEn5ydZsQKeVEkjqa3IPbWgpguzgyN9+ynIkGc4sVqh/0VOAbxP6Nqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598752; c=relaxed/simple;
	bh=2Era2NQ0dBWMptUzGoY9E2D4X23T7wdsZGYt1pcj7bE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HV+nuAlAAY2gRSaQWqIIBVV9kdZSFtheUooMSkBTfyVGXpLCM8uVgNCS9aan8OPv/5lPLq3Pmeaa2fSUyOKun2ncsBIYEQ27JI9Cwt5aKVOeKJ+LqCySYCzktexzmhdUZpiTns3ywZD2dSLnenosHgE3PY4zv0b1ZNZA5aUlt3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HT6H2XAm; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxGxPMHGODwcLiEwleH/e+Yh1mnJh7ATiGy2jFPj4vKOpLdGx4CLlsf/OrjdFW+vKkbPAaDhtKJm1oU+3qkMeQy4fVlX3ITx/1R/nqkJKZz8ZADDIiUS6Jp6YewuD6QPmwJBoXSNSZZYv3XD8p0dLmpCQnRlw3sXlj3t5BbBT58rsqnxE1ASGu/Uf3HVJAi0CNwcaWoYdmk6LfsqfloTp5Zaq5djOpepy8uiGnofBIxIqVe8f7b32+TroBcJzb0wiIkMGjxozt/1kR9ictgNwcI790ZMVcUsqmfdgQfsat8mTPAcy0TabLJ55s0CghGcUN5yt+8NRJZH6AX9FGhIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzo1WveRpPKoYc6AkCdSU9383iAAbJwr9p4f0woMrSU=;
 b=heFu/fquL54tba1mI6cvlLQExNHLHCjTwsv1Pj962FR8vk81Y42gXy3rKZspdCYfBXzovGXRtLHKVxX4oCBColpssYPWCvrDsOES/auf+nP8c5SBYBgvF/gYzA4aW4xDjsTzNPrrBXEwyLjTf3k6icEjQZQ7pW/tu02e19Obc+S3VYn33BuwVexPBPFX/qedASueFblqOxtweqiSJlk83D5eTZEId3vLuqKAvn1ApIt77ryBvw0dQuqzLsQx9ORvaVNQ4//zDrnDO7Xa9LuDOYryIg+PKTyp9lDL76wAYZG5UEtUzGe/jiq19xVjb9ongcM12c960DsemUmkfYIqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzo1WveRpPKoYc6AkCdSU9383iAAbJwr9p4f0woMrSU=;
 b=HT6H2XAme/fEDhwtxAF9pXqDVAq6IU84gikQgHDC6w5VCmPDCjLenGyf6DkXw0xpwrpoyb2h+7Sax8mPqlHIE0ldquE4M7p5iP2LiXNt6VNHaIatfL75/XpT5t+zLfAc2V3dNQgDWPbs30N3c5XZisezjYC8UV2t5wyv8ePd9gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 15:39:04 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 15:39:04 +0000
Message-ID: <26165549-bb0c-4d6c-89b7-273648ff4512@amd.com>
Date: Thu, 14 Nov 2024 21:08:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix UVD contiguous CS mapping problem
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, stable@vger.kernel.org
References: <20241111080524.353192-1-Arunpravin.PaneerSelvam@amd.com>
 <81849d7f-f1e9-4ace-af5a-7f36ab5f5c22@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <81849d7f-f1e9-4ace-af5a-7f36ab5f5c22@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067E9.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::25) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: cf452bc0-1ddc-43e4-7a54-08dd04c2782c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXNVOTJod3ZTckJDZG83MHFQbWtuRDR5UGo3RTFNYmJVUlF4MnpHd3R1Z1F5?=
 =?utf-8?B?K0xRMXlnTzFlbHE4ck1BaEdjVjdHemEvQUdhV2RNNU11WE1hMUV3VXhaemc3?=
 =?utf-8?B?NzNUS3BKOW1aL3JqalJXeURJY1BBR3VBcURsTXN1Q0EvM3NaL2xqdHpGMk9r?=
 =?utf-8?B?SGV5ZEM5UTBGY3haeVhoZzkxNG1OYktJbTBTd3VmTHB6eEZuU3pSUGlHeERZ?=
 =?utf-8?B?QWErZmgvckxXY2YvUTJLOUovSWd3REFROWJybUdrQTl4UFFQelhRY1cydWo1?=
 =?utf-8?B?T2xjNldGZHVpRUYzcUorbis2RW5oUzlEemdvcWtTWWplcTRXbzZtQSszaFVm?=
 =?utf-8?B?Q0NHcjY0ditaZ1Y2Rk1NL2x3WjIwV2ZPdllTSExGeHFOeCtJNStvR2NiTXlq?=
 =?utf-8?B?VEozZmpXYVA5RDhkMUhsY2s0bGhiMVRoS1ZXTThHMDhRTlhUdUhSVGc2SE40?=
 =?utf-8?B?Nm02alhCQzhSTHZMNHdsOVd6VUdsdHFLOXBleVd5TmdFOCtSSjM0Qi9WMThP?=
 =?utf-8?B?V21kVHVlNENKSkRRVTA0a1BzTGc0czlXWHZQTzRoRVpqTjJEVVRRNVFNTzRN?=
 =?utf-8?B?ZnpiWmMwS2kvV0VOYWZkZXZBVTExNDkxYU9sVmhvZVdWWXd2UWZTbGNWZTRu?=
 =?utf-8?B?bWY3UndrWDZ1a2Z6MWJPWCtyVlg0Qm9RbzBxeVNzbDBLaDdtWlZVS3VaWGh1?=
 =?utf-8?B?NHBFNndZRTZ5UEMrNjB5d05WK2d2TUtuUTJZYnlLcjZjNFU2Umg1ZjVWb1Q0?=
 =?utf-8?B?S25iWW5Dc3JCQjNrems3QWQraE5zcGhvYVVUUHpPZHJRL2dBNkl4ZUN3OE0y?=
 =?utf-8?B?eWE1N21oSzFMeWJxNXBIZVlCbHpXOTkrcnlvZFI0K3ZscmNVWDVsbUFDYXBV?=
 =?utf-8?B?V21NMzdIQ3BKdUVpeDdtdDdsWitJczJaOWVwdlBjeVFqdG9lYUVmNHV0UTNy?=
 =?utf-8?B?SjFwbXdGOUVUMWlZbHVTQSt0SmczRENDVHcwVXFnbk5kM0VhbTRwY3BKcXVk?=
 =?utf-8?B?dVZsb2ZLdG1sY3FlQndxcFhzelh6SEg2SmxZZW9rSzlJNmtHRWtLblNkZDFN?=
 =?utf-8?B?YkZoOXBuQmhPakcwdFhlMEFaam90OWhnODVmdUJzUnJrY1BwcDY0NnZRbUtw?=
 =?utf-8?B?RTN5QXMvaEhNN00vbmlXeDExMWMwMjBzK0Q4dU1KSVZwN2xpdldrTjhsUG9D?=
 =?utf-8?B?S0kyMlVNRGx5TDM0MDQwZ2xheWlJRit4QWxCTURPNncwdDBxWC8yUXh1djVD?=
 =?utf-8?B?Q2c0T1I1N2xUS2Z0eWxsQWNZMlRtYTdHM1djbTVlUnM0aDk1WmxHeXdUNnhi?=
 =?utf-8?B?NjlBSVFVWnpNZEZnR0J2WE9LYmhhVzFra2VYbXJVK1E5d3FJVld5MVpOK0g4?=
 =?utf-8?B?UnNLQ1g5bUMvL0laYjRpZ0toTXRLZGcyWkp4azVub3lHWEc3TEdjSnFXZG5n?=
 =?utf-8?B?ZnVrTUh6R0RzU1JEWkJocmdVSXdwWm1ZdjR4aVMzL3I5aE5MNWNBWTN1Nllq?=
 =?utf-8?B?S2hlRnkxUCtyelg5VHZwOFIxRXEzWldLbmVxNFoxOVVXdlFVdEFMZlJDOUdz?=
 =?utf-8?B?aVJ3Q2FrVUpDZ3A5RGJHS2QvSEUzTjVYVDVHOVNQQmpCTXAwUjlPMTBuK2VP?=
 =?utf-8?B?Z21wbkpsQkhjQUU0cjh0QjRRQXF0R0lmY0FyeTM0aExpc2xtSFEyUjVqeUpX?=
 =?utf-8?B?OC8yK0l0c2swTXFIT3lBWG5zNndDeTVLWnY1ZWtPOVNqOC8xYTBMZFdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXFBUjRGdmlqUWR5bm9CZWRlbGdNL0l3ZW1qNWw1cjBJZ2JCdDR5T0xoeXda?=
 =?utf-8?B?d0ZPZEhEaWg1cGUvUzhncW1TV3lrNGZsc2hJK0lBZzkyNklYMlRZOTE4N2ZV?=
 =?utf-8?B?TlVCSmpXWW1PUmFFUnhabXRUbGNlaEJFcE5oYUlvbFUyWHdXYXNwMVFuVFdP?=
 =?utf-8?B?ZC95OWIvU0lVRFFxTS9RY25TR0FOakx2eWNNaHc5MGNDY1NTUHBubzhsWENx?=
 =?utf-8?B?dDZGc044eXRhRnZ0dXkyNlh0SlB0bWhlUk1YeExWQ2FHMlFVdmNtYmJoVzBP?=
 =?utf-8?B?SVpIcWVKbGx2Tjc3emZ0aXM4bU1PQ0o0YXFCUVZJOTVXclhGRHMzK2x5Rkdr?=
 =?utf-8?B?cG5XMXphdUduN3ZlQm4ybVlydmdZWko5T3grSlpxd3VDMXEyRnpCTDdYV0Zm?=
 =?utf-8?B?b1RaK3g2Ym9oQUMxdEE4cTdGeFlZTDhlNnVXN2VsUDEvbHZaVkdTN3RYN2tO?=
 =?utf-8?B?TmpZMVdwM1NaYSszT2J3VFRxb2VrQklMQkM2WG56eUVYelJPd1JpU0VHY1dJ?=
 =?utf-8?B?azVGaTltVTI5WndJN2pwdTE3VitsamZTMVE3bkRac0lsakFqbXdzRS9lUDVh?=
 =?utf-8?B?WU1Ra1U4Yy9zam9GbXVpNjRFUXliRDJaNVZyaTFNYmhtK1pHc29xT1JFUnNE?=
 =?utf-8?B?MzN3ek1veGo1dFZIQmRQRFM3ZVNKYlViMkVYd0hFWU9wR3Qyd3JXQTg5bHBH?=
 =?utf-8?B?elFrdEQ4TVQxWjJQNlhFMmNUbzZYeTJ5YVgvd1Jvc0VDZnNhdW80aGw2ZHdl?=
 =?utf-8?B?OHF1cE5CbVUvYUdiQ1oyN2pTbWUzNlJyL2FUMVdOdnZoZ3ZuMVR5WnpCL2hD?=
 =?utf-8?B?UGE5RmN4WXhSME5LUE1uc3NCQ3NDWEJYa09VNnM1TDZzT2VsdS9CRkhnZFE4?=
 =?utf-8?B?UXVDSS9MM25jVE9JUm1xbUhGTnZVY0JjZmdDWGhtSVkxZ1labnhWNDZHZWNX?=
 =?utf-8?B?RDFacWZJTTRURFFkZXMrZ0MyeXpzcitYQ3Q5K0hTcmhKVmtzeEJENmtlN0RV?=
 =?utf-8?B?V3p2QVJzTm9WZVZyU01LWHh6YnQzYzVtN0VtWUNYUFFtZ213enNNN3pTV1RB?=
 =?utf-8?B?WmdsMlE1RG1VNmErMGhFL1lWWllsb3E3VHB0UmtxaytUbW0zNThEeVlGRU4x?=
 =?utf-8?B?cDhNc3ViUXBVTElkaFRJU2pTaDBlRmE1ckV3b3pjYllxUXZiNmpWcGVRVlpK?=
 =?utf-8?B?S1FDNmZMQmxxeko3QUwzcnUrNkh1UWZnSC9iaVZPVjlkSTI2eGdxUHdqa1Bo?=
 =?utf-8?B?ZzlpNVpaM0l5anNkWmFmRG9NOFprbGVCOWE5cGlhME1PNW0xY2pvUzA1OW55?=
 =?utf-8?B?WVhadng2K0RybGVoZVFoSkZsRi9kajJhMDhSdFQvaFFIZ2pDMExMbnJPMS9v?=
 =?utf-8?B?VDY4TVRqai92Wng3Q0RQWjBsbW8wTEZiaVhiN1R5Umx3dkl6eUZqajZVNUk3?=
 =?utf-8?B?V2lXN0tFZVNSTmp6ZU14eDVKcHVIbXBIb2k4R2JSS0U2YWhkUlErWG5vaHRU?=
 =?utf-8?B?MTZKeG84MW9sTjM5ZUQ2a2cyY3RUZkNHaUU3cjliSTBzT0dOVlR6N0hhYUsr?=
 =?utf-8?B?VzB3NmNwL1ROeDBwQ0UxVTRVY1cybzJIS09OUk1wRU5FYWRtQUtoN3NyVWdJ?=
 =?utf-8?B?bi9Xamd4cnorZ1BKNkVucEdVZDRzWWplYXlLbWNhWWxTNlg4OWMzWVJuZzdF?=
 =?utf-8?B?Mmk2VjFwOW9zeFpja3pSRlYvTlRhUWU4L2NnK04rWGcvK1hRN2IrNWViZ1Zo?=
 =?utf-8?B?K3pRVGVib1Juek93VFVtWmxGQjBJRTlpRm9vR0l2QTI5WmJYQ3FWdE0xTmNO?=
 =?utf-8?B?eWpLc3FoZDBIVGV1d1k2UVVvSDU5U042cWNNWm42S0VJWVJRL0NFanN6QllO?=
 =?utf-8?B?L29BUDRITE9ZV2Y4VEx1L2dNOEY5YmRseTdFT1d5Qno3R0RJb2xkaSs3SnE0?=
 =?utf-8?B?Y29SWW03WUVMdEExVEpBcTBzeDY2R1A1NjJ1d2tPVzQxTDVVQnN6dTRnWktk?=
 =?utf-8?B?b0x3bDFrL0dzZFE3alkwcFhuK3hESTBaUnM0SU9BR1Q1WHN0T2NybHRtb1l2?=
 =?utf-8?B?VEdIWmFpU3NibEovT3R2eU1EL2lQQWxPdDZlei9aa2lmT2o0Y0FJWklCUUVZ?=
 =?utf-8?Q?J9ihMIU9PrfkCx5+OVqA5TkiF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf452bc0-1ddc-43e4-7a54-08dd04c2782c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 15:39:04.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4fVcxQSeIR5QvBwNejtaUUXWWSlUBMSyP7jQYKXyG6fjO/RfGtrRVft5RQcnToE8MoOhvTMhj/3QIRE9yvnYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043


Hi Christian,

On 11/11/2024 3:33 PM, Christian König wrote:
> Am 11.11.24 um 09:05 schrieb Arunpravin Paneer Selvam:
>> When starting the mpv player, Radeon R9 users are observing
>> the below error in dmesg.
>>
>> [drm:amdgpu_uvd_cs_pass2 [amdgpu]]
>> *ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!
>>
>> The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
>> flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.
>>
>> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
>> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index d891ab779ca7..9f73f821054b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1801,13 +1801,17 @@ int amdgpu_cs_find_mapping(struct 
>> amdgpu_cs_parser *parser,
>>       if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != 
>> &parser->exec.ticket)
>>           return -EINVAL;
>>   -    (*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>> -    amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
>> -    for (i = 0; i < (*bo)->placement.num_placement; i++)
>> -        (*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>> -    r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
>> -    if (r)
>> -        return r;
>> +    if ((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>> +        (*bo)->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
>
> That is a pretty clearly broken approach. (*bo)->placements[0].flags 
> is just used temporary between the call to 
> amdgpu_bo_placement_from_domain() and ttm_bo_validate().
>
> So setting the TTM_PL_FLAG_CONTIGUOUS here is certainly not correct. 
> Why is that necessary?
gitlab users reported that the buffers are out of 256MB segment, looks 
like buffers are not contiguous, after making the
contiguous allocation mandatory using the TTM_PL_FLAG_CONTIGUOUS flag, 
they are not seeing this issue.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>> +    } else {
>> +        (*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>> +        amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
>> +        for (i = 0; i < (*bo)->placement.num_placement; i++)
>> +            (*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>> +        r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
>> +        if (r)
>> +            return r;
>> +    }
>>         return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>>   }
>


