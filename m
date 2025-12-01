Return-Path: <stable+bounces-197918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C620C97C46
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 15:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465B93A26FE
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D8317701;
	Mon,  1 Dec 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4tbrFf39"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D92AE70
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597861; cv=fail; b=cxjcF5I51nusTDf9Z9qF81tTm5u1FMCAElI1hjS683dzZ/XTw7beNF6QRtnL6r5bwch6p4cII3kdC6BDu5VVJ3+3xBCiJsefLfWb4woxVl+Vyi0IpLNuC0upuM4/wt1IcFBsPNWS9Nl4rsISE/GLX19nXPlDeU6u8JpACSVfzy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597861; c=relaxed/simple;
	bh=0wi78w7hphiDKdP5D8icN36m+6B3nwaFQSQ40EfnNS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IkR5AaYGjZWio8ccu8STxRmcXGEhoHzP1fgvcydcKEOF3E7H0nKvuF1q690tfMsvT2ydLYatmzJPYzk9nOtCxPjtEdDlOql7IW/V5KBN6AcyxTqmw0HH1mi0O6OA9Z4n67TuI8aSquo4WsSV9T1UOocXn8iUfN7dXRnb8P+yar4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4tbrFf39; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVrjNYMzJvvsTCeOpOUc1UpOKOZKEeVKWeOisG/lICmGOXzw09C7UxM1d45994Uvhr9FrhxvWPEKEnOLChTsK/iA2oVGVNIkXbc8gmCM+Gixf7Kfpvuy7BlcbUD6FshhzKDoX9jMuOxzBpZTw0DCzIkwEAEHj6kYJwqkMnjIZTcQojdxug5dWv4u+31jnELAl1IDkXyUS5RE/1F6/NHJhzqIARKVREm9UiLmPDgPFavLzB1pXvErfj6CJKAeBVRv+k0TlPqi3LYy8Nij8Mk4f/20jqSeuHgfGhcp1hcESKFZ4k6Dc+0FXecBReqeP/0kk1xaT3K250U7znOMBbyVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hksp5sK97de5S8hg52TvI+XUbCLLAivgB/qIRN6r26c=;
 b=Wuu3w8iKKDBskmXGPC5YGcyYGfUUn5Xg4f68cD24hX/j97nnVcrGI8wM648zdtsmYESaxWj3aJ6IByCcbXIttYwBwE/neWvAb8C69TybVpAymu2P7SdMeWNyU+8m53eN42eN9fzRR4b1k9TaZ2XD/uJESpZwYgo+cyjYot1sPj/h4f9BBPOBegMJHbzhIfP3yokZdDz2uzrQeS1V6IWn8nTwwjf9nanqYBgiY7cW1JkG6RRNhQxWcD4/cMCQ32lmMKb2Z6CWeDnuKSmL11Bl42/btWlUvcWF1LIR3ADVMva3JrtJFvE+Mn2cH6G4DVa4+mdDPt5fXXu0sPZMOhHT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hksp5sK97de5S8hg52TvI+XUbCLLAivgB/qIRN6r26c=;
 b=4tbrFf39lddoRSv4PpIU9Aa/YiRxnBWTP4YTUv2UnQsfr/GHN5hrbwNnLg5TPLF8HEQGYLmxXY6yUmMK61u3/29sSVQ7C6JBfvWXNI2+X6k5xCnZ3gSrhUEHFh90MKY0B6svwF5YkHCGqgO7djWudpWmfKxk6YS1xx0pY9p+pnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 14:04:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 14:04:17 +0000
Message-ID: <63389a0e-d6ba-4028-9626-c606cf4b95fb@amd.com>
Date: Mon, 1 Dec 2025 15:04:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Forward VMID reservation errors
To: Natalie Vock <natalie.vock@gmx.de>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20251201140047.12403-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251201140047.12403-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d0f5cb-3e8d-4b14-f54b-08de30e28466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDFyUGs0Sk1sSGpQRFdjMGdoN3dtUXBxVHQ2T3RGb2xQbW1oWUJXQnBvbDNV?=
 =?utf-8?B?Nk5XRUNFaTZmRjR2Q0hxaU5hOVZuUjZvZlNoMWl6VE80R1NTR1V3VTg2RnNJ?=
 =?utf-8?B?dlhUeUFoUjBRTDBIbGcwd2FvdmJSN2hsZm4rQjRSenRTNHdDY0swSytLeHVK?=
 =?utf-8?B?U1hEL2lnSGZyMWI5a3VKNmNPN09hK1JOM1hNaUJoTW1ubzZzZDlCQVFSVk5p?=
 =?utf-8?B?TDNOSkNlMUhYcDE2MU54cUFVdUhSeUFRTFBJUC9zTzJOL0lEaFNrZitQV21H?=
 =?utf-8?B?U1dzRStJVEZ1OVU3ZjZUS05Od0VsNGFmZzl1YjAvWWxhSU1nRWUxR0JiYmk0?=
 =?utf-8?B?S28zOHgxM1NsN2Z5N2tPL2hNWkNjT0U5VFdTOFZGSkF4QnNoYlNmT1NWZmJy?=
 =?utf-8?B?WkhBRWVUNkY2bGN1VmRXZUE5SWxaWmhBMlZMbGpaWEtveVp3TlZoYlg5SHNB?=
 =?utf-8?B?OEVYK1VSSUFocE95Zk1lMnFnUk9ZSEgyc2lpNjlOamgwN0g1N0J6bS9JYVVl?=
 =?utf-8?B?Z1FPaHdhbUx5V2dyWDBiZUFhaUFQekdZemZOcm43U0pld0xzaGh5OWtnOXQ0?=
 =?utf-8?B?SWJTbzB6WHArY2ZOc2RlckExVE9nVjYzRmRMWEUvMGVqREt2L0U3dmJpYXQv?=
 =?utf-8?B?MkR2OHhJQnREVGdtRGhWM1BUN3RZcWJZRGE0QmdtU0Z4K2F4TzlHVnJTWTlq?=
 =?utf-8?B?aVM2UjBFRFFWWVpzbm1iY2xDYXBVdFVHRDlqeFRnVHZpeTAvN3d4SlNiSERy?=
 =?utf-8?B?eTNZTm9YZUUyRVhsRG5tWGVHd0pPaGdDNFBrVHF3MGVnTktrcnFGYWVOdThn?=
 =?utf-8?B?M1oxTHB4MkdWeGJHQXJET0lnVjB2NnJvVnl4WU0vaHRJMUtvMmRSdk5CbWtY?=
 =?utf-8?B?QVRZcjU0YUhTWFdRVks3WjlobnNXQmtxV3JZZkpiMUJSd2s5ejFDcWt5ZkhM?=
 =?utf-8?B?YVhWb3hUcnBMWjRRejZtZGNEQ3E0WTR4aHFSRVFIZXFPemF1TjVtcWR1QW5E?=
 =?utf-8?B?R1BCUWovTFBpVVJaZkxFQTlKQkF6SHc2QUF0MThvdGZEZXhLdzE1YlFTdno1?=
 =?utf-8?B?dTYrT1Jua0Fnb1NMQUVuQjVwMzJMVGpxRXcvelRRQkFmalpwZEZvanFtSUFv?=
 =?utf-8?B?Vjd0MlFwU3JQNEV2RjBJdTVXcDZyUjJxUEJVeDl0cEJoODErL1d4cjlxaC9D?=
 =?utf-8?B?NlFqczRqRnFXTjVtaGR6REVWS0VyakkzcklnSnJxYU1ORjJ2aEJscVZGSmND?=
 =?utf-8?B?aXZ1di83ZUh5QWhTR3JNNVJTM0dtUmpUNlpFY28rbnRRcUtwa01HTDZqdWN4?=
 =?utf-8?B?R1llWVFDNy9VUEdaVmF3YS94ZUtHRStKbjN4ZlViQmwycTdTaDRaVExMcWlZ?=
 =?utf-8?B?UU1mRXliT2pEMDlqelovQ1F5WU1qMHJwdnplSm51Z2xKbE1zSUdVanpuMGl2?=
 =?utf-8?B?YThxK1NXa2lRNzA1ZVZsNFFyYUJhTXphVW9CNGdUZUxORGtLUEFXWWZQNlc5?=
 =?utf-8?B?NDFkMkltdkt2SG9VMXNBOTNCakI1d3puNmJOTTVnekI1aVh4eDNMMlRWTm53?=
 =?utf-8?B?RG0zMnNpdmZVcXR1eWV6OHFaL1ZrYmYzUXYrNnlQYkNoc21XTDhDZ09RaWt0?=
 =?utf-8?B?NS9NeHV0VnRJT29VNHJiSG8vaG00UDBER0pSdC80bGFWdCtYVzdGenkwUUVi?=
 =?utf-8?B?WXdkdzRqOENkQVVxdEp0WWMzMEN0cXVERFJYczNnWkZWRVo1QmJHaGdiZVZF?=
 =?utf-8?B?aE02V2RGR3ZuS245Q3NoQzJ6b3VZcXpQd3pCR2d4aCttQ0h6K29sS3dyK0VQ?=
 =?utf-8?B?d1EwTUlBVXJXUHBlbWhoalRwN3hXc25xeU9FbGloalk0SkQ2NGJMN2dFK2pm?=
 =?utf-8?B?aVR3cmJXcUFsZWdLb1Y5cEJKK0VFL1QvZmpZaGlmSG9wd0VXU1dtOXNMQW83?=
 =?utf-8?Q?en9NrFa3PcbmiJ15n5NyD+5aLtTnptMM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVNXODR1eFVFKzJPMlovTml6QWNVUFBXeGpCYy9sZTFLMng2Y0FydUdjWU1D?=
 =?utf-8?B?M3gvOVk4NDZwSlRoOG9wS0pRNjNvUlVpdC9iNG5hR0lZTVJaa21rR3YyY1Fh?=
 =?utf-8?B?MW91VFBnbzZmSFU5RXhBNDNQNUVoUHArdi9NdDZoUDRRblMvWWJJNHZzWWtX?=
 =?utf-8?B?OWRFM0V3dy9SMzJSZWJ2Y01iellYSUk2Y1VEVW5zT0pwMXJpeG1UUW40NlFK?=
 =?utf-8?B?WmFvUGhvSzlRSGd4d0VZbXRsUDQvSFNWZzFGZmM2eFBuSlk3UTFUUE9LeVVr?=
 =?utf-8?B?MUp4SXRCUlc1Yk5CbzJTbnZJaEVoQ1pCVGNlU0xWSGI3aytENnhSZzdYOW1o?=
 =?utf-8?B?OFRVMVRrVktzblE2L21xbmh4Sk9xZkNmZjZuRG1vSGJUTzhqQzNVMEF6UUlx?=
 =?utf-8?B?cmhiVWtYOWdhS0pBRG4vV3d0YWRCdUdJbEN2L0x0ekxSU1NNbm9uWFVlYzBJ?=
 =?utf-8?B?TnhnUUxOQTdZNDNBU2dzRnJ1STIyWFkzaHo0SGEyT1pCQVo2cFUwczRFMW1h?=
 =?utf-8?B?SWcrN01ONm9pN0xLQi9BMjhpN29Nc1FwMnBONHUwaE1oR000RXlYTHcyRm00?=
 =?utf-8?B?SkhzL3E4TjVDQ21Ic0Nobk5ZNU5namNnS0xBMi9WdU8ya2d0Yi9YL0NTWW5w?=
 =?utf-8?B?UWh2dHVxMzdnTzJEREUxUWl2d3ppbjV4UjRkaVdFMUJEbWxvNFNqQ1lTSkt4?=
 =?utf-8?B?K0sxYXBEdjJJRFFRekk0YmU5ZG12SFN0V1hTRWlIcUhGVEdmQjVmNmQycjkv?=
 =?utf-8?B?dEUvbjh5SmVNaC92RmRDUy9ZYnVUNVkxOXNoekZBR1pIM3hEMDR4Zlk0WnRQ?=
 =?utf-8?B?NGozRkpBUGVLa1dlWGY5ZU1CS0Fud0tBTVBoQmFxZ3MwVWJrdS9xRnpNVStU?=
 =?utf-8?B?RlZsMDJ1ek5IRjBPUUF4Y2xSTHZUeWRQLzRKSXBUdmt3bXl2L2R6VEdqTmk2?=
 =?utf-8?B?U215V0RNK0lxK2xvV1paOFZWR2pzRDBQMHhLVDNJLzkvWFpoblVRTDdnNTE5?=
 =?utf-8?B?czVRa1YvSVdNRHJnOU1SWC9mbS9zd0c2cFVzUzlLdDRKRWl5Y2dGcDdWaVd4?=
 =?utf-8?B?Q2dsYXhpWS9pUHNEbWwwSGp6MFgyVUw3YjdmQkVvenNBaU9lV0ljOUVGZURT?=
 =?utf-8?B?VExkK2l2QzU2bXJjZ3pjanhIK2dQWWdxcnBRTXJ0Z1VQd0hmZ0hvMGtUdTM4?=
 =?utf-8?B?amNDZEVkUDh6L3JXZmJSeGlRdndKeXBBRHcvNUxUMXc2QkFlRklldTFYQWJ2?=
 =?utf-8?B?TXBxRkF6TVE4K2dHeVF1MkQrSURuTThDZlVuWVppQ0FUNHJoUmlVZGtQc3dt?=
 =?utf-8?B?NVpTa21YY3B4Rjk5RG9ZcTZjN0U1RWtHMG1PenB6dGN4QlQ1cDFjQ0MyeS9i?=
 =?utf-8?B?TytmenhSMjhQZ0tFczV5bEJJakJ5RVlVOFdEV20wdXJQM3dJcUZOU29OVW5Y?=
 =?utf-8?B?TklBSm1wWkJQajlidDAwY0VYZ3psZXd3dy9lWnA3aHNoVVpRQ1dvK0tWQnc3?=
 =?utf-8?B?TnlDV1l0S0FyZjJWZVFPRit2QWpLRFBrOTRib2NHOGcyeVN0Umo3eHhyT3Nk?=
 =?utf-8?B?c0lSaDZFSzRTV0llNDFZQlA1aEJSdXpzbkpUVEh1cWJCRDhRYXZRNFBJQlMw?=
 =?utf-8?B?bUVBMFNaQ2oxOXdOS0d4blFweHVsemw0RmRIcVBvdlovb2l2SGNlU05SMkJJ?=
 =?utf-8?B?S2hVYWpOcWdTWjFYV0c1TXkvcnJzQjQxd0NnQnVvWS9vN1NXVXRoM1RHV21V?=
 =?utf-8?B?VG9VdGl2UVo5akpTWFlib0oyb3U0MHovMHBjQUVIb2NudTI0R0VHbDNYZ3Nj?=
 =?utf-8?B?MHNLdlNDMlFyRENBNGtUTEMybVdSRFIzM1RaNllTUmljWU9ybW9GKyt0a0hE?=
 =?utf-8?B?QWRiN0wzY1ZUZ2h2UXY5SUJDa09vYWZGRVF5NDE5azExM284OGhTMVBUYzZs?=
 =?utf-8?B?SGdXL0F0U1JwV2p3T2xGUXVNREVHRTZRVXI2WXRDOEc0dGNkSzNpZHpDSzdX?=
 =?utf-8?B?V0Z0ajBlSTg4VGszMFhNdUVIS0dzUHRtZHpzWmYzWFhoUlNqbkdxMGVqbG80?=
 =?utf-8?B?eTUxaHpJdC9GZlpOdU1wQ0VsN3ZFQzVLb0xDOVhnK2JuQm51SW83VGRXYTZ4?=
 =?utf-8?Q?8tHKDoiSOzoSIFrR3v6ZbtJLQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d0f5cb-3e8d-4b14-f54b-08de30e28466
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:04:17.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmGqlYYg7z73NDLLANO+zXHjPSur3mQX0uHMeYcHPdprfwWsBqtIUsL2SDM4hyb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

On 12/1/25 15:00, Natalie Vock wrote:
> Otherwise userspace may be fooled into believing it has a reserved VMID
> when in reality it doesn't, ultimately leading to GPU hangs when SPM is
> used.
> 
> Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process isolation between graphics and compute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 61820166efbf6..1479742556991 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2921,8 +2921,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	switch (args->in.op) {
>  	case AMDGPU_VM_OP_RESERVE_VMID:
>  		/* We only have requirement to reserve vmid from gfxhub */
> -		amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
> -		break;
> +		return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
>  	case AMDGPU_VM_OP_UNRESERVE_VMID:
>  		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>  		break;


