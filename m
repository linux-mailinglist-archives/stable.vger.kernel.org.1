Return-Path: <stable+bounces-158866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE2AED479
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 08:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268CC3B0F68
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F619CC28;
	Mon, 30 Jun 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AepaKXQx"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE8125D6
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264720; cv=fail; b=jlhXwwsJ+z6RK0RShw5MF1JXlBkgUYbAcRtGXew5B7pSvrg6V7DrPjB+m41GLoUNdTBLfdeB+2KGJ5KrxxgyyzAVAJmBekc3BATnsmDr7wGOTHOKQ/Ep8i8IkfuYiD7lqNxRtmlHKzo4FjouI1pP/J4kQoj6zT+eVoZp8ehmnu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264720; c=relaxed/simple;
	bh=kJFTMf6YKBbY+RE8Ws6CeQ+phBcAEOjp2OZHxWAJxpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ov5r3LMA+EUPaVfKX/ZHnb6jNz81fzj7hHrgqS3IR0R3ksabsh7LIgPlkAulwM9PnB5BgCPEprkFet3ZXU6EUSZzvS3u+RZqGIWw0RwU7rKeYOwslIFYbVLe8k+W9cYvn9IGSIYyeR+2VpCNbCreAqZZVPun0Qdf/XBcSHK0H1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AepaKXQx; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXCHNahDABQNvWQ6z1YxJ6f4pJ/veBXrzzvg2Wfhm0do6vMOZyaTp8T5vQexLXf4xcHF+8zly2ZA5Zwsk8tsnU3QLwLXkDY/01nK6aUwpbC7g93QyP7pNJ9oHzpj3IW91vnNdrC+tKNkOluF8brSUZc5QQzAOZp5ZiZct3IpvAeOxfFIMClqeDZ2uDNLYY2JXg3qQGLns8yCKM5JjROBISAjGzDACFKPX9ivvNDSVggQmdMyyiOSTIHHtBb0H8Nfgk8soQ8lQQzq00CchxBMJ7To92DgJfvG2l6EiN1sCa0HkRNgYFJ6yE21iekhbpf0MwpRtO703c/64I47E1aCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyxs2VHEOkTflu56Q3b8teWV4j3MNbyJzNwv8YbF5nU=;
 b=orDToc8/qcJpIztv57KC0eceyvIJQOcR7hmav8F7iHDHCoxeJLG6BWVUpP0DqIz8iORwXr7vaIx+M4jt592iNl1k7FEXYiZEqJ3zL6Sp1Y0VbcC8fXREGpMPuy3/4OgU+x/shMWFzv8a0TjaDrgKBeVUD9nq9yNBy5mJdoJQOoJ7WYYMiZoSmzs5+vefC6Zkh7SSVQCbMGcnDyRamxrajvd3xrYwcBWY/bDn1uMCGWgDjBSNqulHBiR6Iiqv2Mllu67Qvk6bQwchIrpFBXGngTnJG83gtGZguGusN7WD6xYDFAJ+EtxNUJYQ+4zUNlxe68C+ID3utDZ1CNJWOS47ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyxs2VHEOkTflu56Q3b8teWV4j3MNbyJzNwv8YbF5nU=;
 b=AepaKXQxPDahSaOL3nwqAowScizYbNzTIzo9P3w3zBNQLpMIGk93J1n72iZXi19V0jgI64uEHbWLHK53oMGdpoRgyNd66VCGIypA1HCL97LeDyknuRScoACou5ivOwlqil0cZr6Mw+3QCrEcKTkgPydHyPTYpEvbSNm7bn9liaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.38; Mon, 30 Jun
 2025 06:25:14 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8857.026; Mon, 30 Jun 2025
 06:25:14 +0000
Message-ID: <491a68b9-a2ca-4ca8-8d36-5775762088cd@amd.com>
Date: Mon, 30 Jun 2025 11:55:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
 surenb@google.com, kent.overstreet@linux.dev
Cc: oliver.sang@intel.com, 00107082@163.com, cachen@purestorage.com,
 linux-mm@kvack.org, oe-lkp@lists.linux.dev, stable@vger.kernel.org
References: <20250624072513.84219-1-harry.yoo@oracle.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250624072513.84219-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fe4971-a2b2-4f68-e7d5-08ddb79edf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGZaV3NKc0ZYRjhZa1BjOThIVUk0WmwxWjQvNmpXeVZUMGlKa2R0U29jSGlo?=
 =?utf-8?B?NkRXUHlIK0VKb25CeDFiUW15SHVwcGVJWGI0NFhpWEJIcDc3K0lWU2tYSkhZ?=
 =?utf-8?B?Z2htN01jdEQyRGRYWjY5SW5BN0kvdGgwWEZTU3hFNkRhZTdMSUNRVGg0b2w3?=
 =?utf-8?B?UG1wcWp2NkxOQldMWWFYN25tbVJHcENwODcweWtEOHlaVWdMMTF6OU1jRm5H?=
 =?utf-8?B?TlpIVXh4NWhEVXZoek5JT3ZVam1YdUFMb0MrUnJ6VUwrZGdqMUFYSHFqMzdp?=
 =?utf-8?B?NmtZSDYrQm05dWxxeC9mSDY1OGVIb0ErczdNbkZCNjBMNXpmN0M1cS9Lem1k?=
 =?utf-8?B?emZ6RWg2NjBrU0RIMUFTek9YREt2dWx4ZUc4R1MvRkZ1SllxeXJzNjFWaUFC?=
 =?utf-8?B?MnZKYzM3ZlZ2cEg0QlJOSVRURzRrRjBrUnNjc1JKZUdhNmlPL2ErdThsODBr?=
 =?utf-8?B?OVZqYWVZMHZTaHZYTUpXZ3JpYmpuL2JHZGJnNE5WWU8reEp4UlhoUkNIT2di?=
 =?utf-8?B?N3IvRzI0WUtoMThrVHpZUkJEOWovU2R5dkErNXpFbkJYZ295L2I2a3J2MUZp?=
 =?utf-8?B?bW90WXRBcU5rZEN6WEVBcDA5OVFoT0Qxai82WlFUbzBaZ1lsWWJ1RHFJdGlB?=
 =?utf-8?B?WUIyRGpWd1JiQ05BQ3docE1XUE9tOUF6L3NKc3lrb0Q5WVZuMlpVb0ZqN2VC?=
 =?utf-8?B?b01OUVdKc3VIcHZvVUZ4TEFWdXIrRVdocklFQnhvb0RFcVU3aUZNN0tvTFFv?=
 =?utf-8?B?TEo5Z2JXQ0NISkd3VFhlN2UvTUkydUhyWkY4ejB0NDRJdVhJV1RRV2lhbHpK?=
 =?utf-8?B?YlRldm93SGhCenM3UWt0UVZTajJTVEdnQVdJSGZ5OC9mSXZCZVcvd1Erc00z?=
 =?utf-8?B?TExmT1F4eHFyT0xkbmg4MXR6UGVwWEF6QlE2TkNHQmxkWnZ5blNRaC9GWk1H?=
 =?utf-8?B?cFBESjh4cFNpTHR1elVCZzQ3OEJZZFRVNGlRRHdLcnJyQU9QRXJBQm1GT202?=
 =?utf-8?B?bm5nNHlaaEJ2NnQrQ3RGeTlSYWVUR2ZhNXpzeTNlZU9nL3hDYTN1OWxURjVs?=
 =?utf-8?B?anVvaWwvQlVLdzhlVENPNFQ2Sk1qQS9XQk5PV09vS0hPY1NjYzN3cjl6Wlh4?=
 =?utf-8?B?b0xMYVpQaDFmcDBWcW1kNHgvT3BMYSs3MzhiYkYxVHNaZjZ0eElKRTNid0ZF?=
 =?utf-8?B?T1lmb2QyOWFSMnZOMldSd1F2QkwzRXVNQ0p3ajJReFRlR1YrNFl4NVBqSk1B?=
 =?utf-8?B?NHYwc1c0azNGUXViUDBKbjhYWFFGZU8rTzdMdnQ0Ny9OU2pIWkhFckYyZFVE?=
 =?utf-8?B?OEVGSGpRQ09UeGdjQUVmSWNldjZHdTRsMGZ6b0VwMkNjaGErdVpEb2VTRTkv?=
 =?utf-8?B?OGoxSTZmME5TQlJzL0V0cmtvM0MrVUJqejVJS1BWZkpOUGlldTZvZjEvb2ZT?=
 =?utf-8?B?Y2NvRFhtb2NYbTgwdG9qUHZqOE00OGZ5K2tFWWpGRGxXaTUyWndPaGYrcVov?=
 =?utf-8?B?aFJmRWhWTlp5WktHT0YrTWFrdFlaVTVFM0ZyZC8zamw3dTBxWC9wM3hjQzIv?=
 =?utf-8?B?bUVOMGFlSkdyb2JkQnN0czdZK0ZnRFkxUmpDWlFVRzNMOFVUeW02OEdMRHMz?=
 =?utf-8?B?MmtubXE1MnZHeXFKQjZQcmtOVzRmSUorU0ZUdnU1cEJ0dUxvR1ZnM3JoM1Y2?=
 =?utf-8?B?a1IyVDBsWkVMVEVwaXIyazdGeDBZTzF2SlVrNWNxalFDRnZhTktBUVlqZG5N?=
 =?utf-8?B?cDROTkZtYnVjcXNzRXcvMWVjOWxzUmVFSGVxMml5WSsvL3JZOEx3VlAwNld3?=
 =?utf-8?B?RHNrMGxJSDgxRkg0UWc0a3JUS2tjR3p6ajJ5VXhvVHIreXJxeWU5SXl3Qnkz?=
 =?utf-8?B?WFdiMzByZWhQVlkxUi9wNnB3dDFTZ0tUQTlkd1l6QUw4cXRYUmtOaVZ4cWJN?=
 =?utf-8?Q?Nz30Pw0slko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2pZQjVRVUZGYzdMZ3paRjFMZnRGTkpRRzJRaUxJTFRxZklobnc0STNieEd4?=
 =?utf-8?B?Q1U1cFR6OThPYmxXRG1vZzFoNTZwajNKOTQxOGJTSEZrVk1YZStSNEVMaXNa?=
 =?utf-8?B?cjgrZERKREt5bFRCdi91NVNCOFZUMlZGTk12d0Q5TnlDeFBteS9WOUlqYXB0?=
 =?utf-8?B?YkJPTkJORHZKMlRtOG90YmRZamttMXd5bWNzT2w3OGZHZGJqam90eTN3aHVI?=
 =?utf-8?B?Z0N2SzJaTEcxdW9GQ25mZ1RYYTdYWGFEMUFzYkN4MXhvRVpndFZBS2lIamJ0?=
 =?utf-8?B?LzFPQ1JlZ1prWEhWSHgvTWttTWlja3JRQUl0QkhmVkFIamNLKzZldDVLY1NR?=
 =?utf-8?B?dHVRT2RFUndmQnl0SDFXZ3FhU05BbXJnYTV2Rm55SFVXNFM5a1BuandaeE1a?=
 =?utf-8?B?MU1aUFptOExiZC9GamNMSHhGVk5wYnhSc0xoa2dBMVNoNFowdExObnZlMFAy?=
 =?utf-8?B?QkdNbFR1QzNxaFF0eEVmYTN2YUpnMHYzeExWckV5Mi9iRGZBeGhoRzI2bnE5?=
 =?utf-8?B?S1c1NG1jVjJjdFp5QmFSbWx2bzhqVWoxVHFreGUrM05yMHhrNlhudHVaRkI1?=
 =?utf-8?B?WlllaGlvOS9uV0N2MVk5Y3d2dFZiSjQ4eGdNOVhoOUV2d3BsaXVCTDkwNG9v?=
 =?utf-8?B?NlJyaUQzODdObmh3YmZxUWJJcFN1TjlockZrb1g5Vit4MVI1OXE4OENna2xv?=
 =?utf-8?B?a3F3UUVqaVpFSTVKZ09LK1hnL1A5VUtseW9RK09jdnRXWEIwa0pJYUZVQk51?=
 =?utf-8?B?N1JkaG5mdXRsMWsrWFNlZ2d4SWEvL2xZaytxUnlqcXFJcnhsNlNRcnowTVNu?=
 =?utf-8?B?b0hDcEVtMEpTc044azJlbXZacjlsY0cyV3hScWc2aDdjSlRpaFdxcnpCaTlJ?=
 =?utf-8?B?SDZOQmluYnR6enpGNUQwcGZXYlRDNy8yVm1sWDl6MlBtSC90eithK2UwKzNR?=
 =?utf-8?B?ai9GUnBtYWVtMit3QnMxZXBnYWdnSFUvSnFMTHR5OEp0YmNtak9hdGM0RTNW?=
 =?utf-8?B?STdBSXF6a1YvR3A3ZHpLZUp1ZWhZU2s0dlZBTTcrTlhZc2JObFdDMmJNQ1U4?=
 =?utf-8?B?cHFPdnBSazFlWU9wVzdtekxweVlGZG5xNko2dHlTTzdYcnMveDRSMWtZTXN3?=
 =?utf-8?B?a0krNThvYUovUncreVBjSUlwZkxjOFNIWUxBNTdxMkdFRDVmUzM5SGQ1eVpm?=
 =?utf-8?B?U1hUN1J3a1kxZkpWZGMzSUJ2S05iTjVQYkMvSUJkRmc0QVhGN2d4WC9CUExh?=
 =?utf-8?B?VzRnOWgyREo0L0cvM1E1NVIxaDdQYko2MkpvcGNFTkhsUDFHZUtVVmVBYTZJ?=
 =?utf-8?B?elJUQy9hMHpOczRYbU84VkhVTmp4RXV4SkkxZVVwdm5uUUZkSEdNMmZyd3pI?=
 =?utf-8?B?bXBNenp5KytxeUpZZlV1MWtjb2ZJWWp2dUw2VkszaE82Z21ub3Y5Nm9mck1J?=
 =?utf-8?B?SnprK0VoVytBVVgvVmRLQ3pJL25uV3k5TEVGK3ErdmIzdW54Vy9oRnQ1c09S?=
 =?utf-8?B?MG9wWG5jY3c2eTBhekNzeHVHVzVuclVpWHZ4QkhQSzlEYW05MzJ4clZqZ0c4?=
 =?utf-8?B?dXQvVjBvaS9YSXlTVjdQdDE1OW56R1l2b1pkdll3Slk0MWFWOGhNbXNUSXRu?=
 =?utf-8?B?MHJnb1Bod0dZS2M4UkR1MEsvYnpmQlFIbUZJRmt3bHM0ZmllWWgyYXVRb1ZK?=
 =?utf-8?B?T3ZGTlQ3a25xbGM2aWkvNXdwekVWak15ckZaZ3hzc0JwcWk3Wm5xVzE3bFRH?=
 =?utf-8?B?RVVGeFh0SjZweTUxaGFRYUJxcjZEZE80eEZXbVRFTHQza3JrTzRKbkFyVlY0?=
 =?utf-8?B?VnBvazRLRUVYSjg5UTFPTjVmenptNE5zRUprYjVMc2ZUSnpkVXJpcGN3eEtI?=
 =?utf-8?B?ZzI4ZjZ0c3YvK0ROUWNPalBBNDhGK1FhV25Cdi9BcWFpQ0xxZXlWN001MWdQ?=
 =?utf-8?B?MG1qSERFMHNiRHErdEJ6OFFWdFIrenlKRUpQcUVvUDdrRXBMalBOY2J4NUtY?=
 =?utf-8?B?YVlTNzFyTm1YaWdacTZsMyt0Z2dQcUhYbVp6dkxzTUNnOGdPVm5xQnlXSXVu?=
 =?utf-8?B?SmYyb1BGSVBsNTV1ZVlLeVVTZFpzUkRVU2xCaUxhdDdxS1dqcEV3L1JVV0F5?=
 =?utf-8?Q?BGYvJGHSFedVOZu1dQSfY7Mdm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fe4971-a2b2-4f68-e7d5-08ddb79edf4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:25:13.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rly0osfz8VFmSWosWwSgUNyEfqu2/A2/rWZECOZq/pjw9UFHtcLsdPoSLj8FS5ixMsRlvFe0Bei0mFok6DfdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

On 6/24/2025 12:55 PM, Harry Yoo wrote:
> alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> even when the alloc_tag_cttype is not allocated because:
> 
>    1) alloc tagging is disabled because mem profiling is disabled
>       (!alloc_tag_cttype)
>    2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
>    3) alloc tagging is enabled, but failed initialization
>       (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> 
> In all cases, alloc_tag_cttype is not allocated, and therefore
> alloc_tag_top_users() should not attempt to acquire the semaphore.
> 
> This leads to a crash on memory allocation failure by attempting to
> acquire a non-existent semaphore:
> 
>    Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
>    CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
>    Tainted: [D]=DIE
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>    RIP: 0010:down_read_trylock+0xaa/0x3b0
>    Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
>    RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
>    RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
>    RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
>    RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
>    R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
>    R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
>    FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
>    Call Trace:
>     <TASK>
>     codetag_trylock_module_list+0xd/0x20
>     alloc_tag_top_users+0x369/0x4b0
>     __show_mem+0x1cd/0x6e0
>     warn_alloc+0x2b1/0x390
>     __alloc_frozen_pages_noprof+0x12b9/0x21a0
>     alloc_pages_mpol+0x135/0x3e0
>     alloc_slab_page+0x82/0xe0
>     new_slab+0x212/0x240
>     ___slab_alloc+0x82a/0xe00
>     </TASK>
> 
> As David Wang points out, this issue became easier to trigger after commit
> 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> 
> Before the commit, the issue occurred only when it failed to allocate
> and initialize alloc_tag_cttype or if a memory allocation fails before
> alloc_tag_init() is called. After the commit, it can be easily triggered
> when memory profiling is compiled but disabled at boot.
> 
> To properly determine whether alloc_tag_init() has been called and
> its data structures initialized, verify that alloc_tag_cttype is a valid
> pointer before acquiring the semaphore. If the variable is NULL or an error
> value, it has not been properly initialized. In such a case, just skip
> and do not attempt to acquire the semaphore.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com
> Closes: https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com
> Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
> 
> @Suren: I did not add another pr_warn() because every error path in
> alloc_tag_init() already has pr_err().
> 
> v2 -> v3:
> - Added another Closes: tag (David)
> - Moved the condition into a standalone if block for better readability
>    (Suren)
> - Typo fix (Suren)
> 
>   lib/alloc_tag.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 41ccfb035b7b..e9b33848700a 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
>   	struct codetag_bytes n;
>   	unsigned int i, nr = 0;
>   
> +	if (IS_ERR_OR_NULL(alloc_tag_cttype))
> +		return 0;
> +
>   	if (can_sleep)
>   		codetag_lock_module_list(alloc_tag_cttype, true);
>   	else if (!codetag_trylock_module_list(alloc_tag_cttype))

Hello,
I have hit this while digging one of the TEST_VMALLOC test.
(specifically align_shift_alloc_test which is expected to fail and
give similar splat)

I can confirm that with
CONFIG_MEM_ALLOC_PROFILING=y
CONFIG_TEST_VMALLOC=y

system does not boot (for v6.16+).

with this patch system boots fine.

and thus seems to be a mandatory fix. (for the above CONFIG combination)

Fell free to add:

Tested-by: Raghavendra K T <raghavendra.kt@amd.com>

Thanks and Regards
- Raghu






