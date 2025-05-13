Return-Path: <stable+bounces-144197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9248AB5A83
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332F0163624
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8270838;
	Tue, 13 May 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yck13dAr"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5146B8
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154869; cv=fail; b=QvBwMagZkWOz0i3HjVhYWIqE7DMcX306UVenkAgcH8y3nb9jEDh76NroCXEA2ejDlkC79Lk/dhzv+slbwgaZoQA4TJ9VcbBahx3FlGC07v5nItbuTFzH0JdcgCXkp5Mz/yrLPh/GO8DxnjdS9O75eNV2J2AMYIEik6GYxbCJpvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154869; c=relaxed/simple;
	bh=FkzB+v+1T9US8m3343Tn2VjtuQhp0BMc7r7v3iaSLho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LeOZMCmTmVby6jQUtasv5ujAarVFUQNz7GiZNnHuxueCgt8S4xd0NisFuRXqpL9FOpuxMgkIiEjmBeSC3l4geR85D+c2FNLVrlg9ei1qzTdMQKZ3V9M/7pfjE7JxBCsd+UbjUDkUw8H8tKYJ8dY8Ahsl/I/mdzykdTvC8TvBwIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yck13dAr; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viIPt75Mf77tqj4RwHU98a5dBMjl+V2LaeW+O0PT4uhTI6+w/ZSe+6eVV2fRArvQeHnadhbCEM9ComGNk07NI6XKFI33ePd50bp1iVfYCxOhh8OBm2vPTp18tk49s3Qcs6YPZ9O9PIdEeWn4te2Y3hkCsJn/9qwnVK5M9beUq3Acd84QlRYgylBTzq1FWfS8sUfmhX7wAiMCSAGCCL5ssWL3CyoLa5y0rDRGsdpYk60mDdJDaHaYON7Q8q7w6SVgy/qT335B/YuD81xBbKEd7htHCFDHPUv8cAqDMpjW2q5yIXLrTJsyAIkbJqNiuQ5nS7HNUo0K3NrlRJpeXOcQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEzpNwFrHVEwZOpTOtPNIH0RWodOpkV7wnBxFPq0Bf0=;
 b=AD8DUki/eoZvOI8HHtUP0zMp30DKS9WI5BeQwt4zfepHQ7VO4s7Pt3trsAfnOXmWD1FVp61YUSUpbLz0djvWKNAicnxBZisG4PvWrTeHNdz09lQK8BFDGT1AeNGZES93zBAFlBfQ9PlKI4dyeEpB86HxoflZ+qebiOLznJ0DItO68P7uYo0WgnG/+N9qdH6qDsDT5d0zdH1vI/MwQdsARGaiahrU4aWrioav5QG5r8XBPsfAtIftT+G8Ce6bqrrl1mBvETtLik2Ui9hES7NTpI3AbBrueXc6zn2zBBssSVkrPOsYNEQ5fRRcK9/U06BGJ+jnkonqd6JJtOp/lTRO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEzpNwFrHVEwZOpTOtPNIH0RWodOpkV7wnBxFPq0Bf0=;
 b=Yck13dArdtkEIN31EZPNnbAWbTMMkMSt8pw5stEJ4KJaZ+HGbDrS+HN8kRjLeFwjJP5CGzwpFLl97Ed8KU2PPj8NHZumS2qvMN2EbR+/z9aFCr8TSzyrWh1FGQwYxB4bPRUu+OrFqvMyUj4G2dRDVbwnaxXBO7FxCHyqOFw75xU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 16:47:44 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Tue, 13 May 2025
 16:47:44 +0000
Message-ID: <23d465ec-a15c-43ae-ba1e-052cf342ba43@amd.com>
Date: Tue, 13 May 2025 12:47:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
To: Alex Deucher <alexdeucher@gmail.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com, stable@vger.kernel.org
References: <20250513162912.634716-1-David.Wu3@amd.com>
 <CADnq5_P5QrYhLEzkwPUMvgYSmk8NkTOusa1dmBFD=veNfshBAA@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_P5QrYhLEzkwPUMvgYSmk8NkTOusa1dmBFD=veNfshBAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0079.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::9) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 674c7dbb-4cd0-4216-68db-08dd923de1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUtYb1hJN2RPbmc4N3lxRDdsZjRNZms0QUdnQXJBRGRIUHlKcnAzS2J5cE93?=
 =?utf-8?B?ZVBMZldkQnU0Vk1RaG1ZRjZzaE84VmlUSXRYS1VxOExIcmNEZ3BVR0piTmhj?=
 =?utf-8?B?MlFHN0t2WlFxVU10ZEF4eWRHcmpCR2tBVmRxNmtFbnZkd1ZJakVUTUdoS0Q0?=
 =?utf-8?B?L3hPek1ZK3hVbmwxcTRndGwwbXQ0ckVSK3NqM0dITzgzenlMMXRtd0Rxb2VL?=
 =?utf-8?B?bXZtenNJNXhHWGFmS2wyUGJSNS9xcE1KUGZ4UXVaOUROWDFmUEszVVpkWkhz?=
 =?utf-8?B?VndsQW9taW5SMkthZTdmMnFHNDdlRXN3ZXZ2L1BBc2VJSnZ5dk9nU2Vzd2ow?=
 =?utf-8?B?Z3JCSFRyUjhVYnJGQzU1bzlFMkhiYlJiakk1a3B5enQzM2lRejFNOURCLzN0?=
 =?utf-8?B?cVlMTGJpcmExSVhYa0thUEpIR3UxdlByQnJ1eGdHV1pwRVRPZjMrN09YclMr?=
 =?utf-8?B?SENqdkpkK2RMVExubDJsZ2dqeTcxa0puRVpBZk5ocnBQbXJrWnVGczRJZHgy?=
 =?utf-8?B?TWttWjlhbU01emw3aHlaZFY0emlDTXRhZHB6UE1sMEo4QUw0eG5JaUF1eHla?=
 =?utf-8?B?czBtc2Q3NGVpMXEvcnJaZzNkNTllNE15bHAvL1RCeHNFVlZRbjFabEtBWkZQ?=
 =?utf-8?B?QkpHNTg0emMvZ0szZFdlUGFqcG9YMkVtaWM1MjZmdFE3eWkvNnhuVk5ocVdB?=
 =?utf-8?B?Q2V5NWN5eDlreDdrekZBZ1NGWDJMeXBiZGlkbFpuSzNrRm42RThmazRIVjd5?=
 =?utf-8?B?cUNkQjhDSDlrOTJRRksyS2JIZlBnUlpMSnFMWWx5dVJpNkltTFRLcFQzanVn?=
 =?utf-8?B?TktSdTVyOEh6TmwwREdsaTk4a3Q4Sm5SQm9ZSDJmQlpXak5zcnlHMS94b1R5?=
 =?utf-8?B?UnBBSlUvazNlQ3RRV09XUWhORlFUNEc0UWJmQnVnQ2Y2aGR6dG9tcVpFZkly?=
 =?utf-8?B?V1poYXJpVzBsVVovelc4bDRNL2NDUE9zL2p4S0lwQytIOXloci9mNFM4RnZ0?=
 =?utf-8?B?UkRIenFXR3NsazdGellRQU51NmJsbDlubHVOeU0yMVhhME5sdEUwMGlnc0hB?=
 =?utf-8?B?d1JxSXBaWWE3SEhhSmZ4bTJpbEJqWXBqZkdUN2V2WmlTZlBwMFRkd3NaRllo?=
 =?utf-8?B?bERnOXUzTjIzemFrMlczdmQxZTY0YVUvM3JnNC9TY2JraUFPWlEyNVRIR1k0?=
 =?utf-8?B?UERxb084R3FmU3BTVEFLUDB0Z25vbGR2R0g2cTNPNFllMnNvdlRVWWNzQXVL?=
 =?utf-8?B?ZzdycldQR0laZmk5cm4va2pEUVFpMThRM2FzN3VUZkNFSFFqcWFhWDU1L1pu?=
 =?utf-8?B?dm1VYkhZTmU2YVJoNkZMeUlmNThJd2ZQbFVvSndtRXdxQm5tMjZYd0t4NmVl?=
 =?utf-8?B?bkxtMHVGeFNVMzUrQzJCNzJVcVZ5aU84b3ZmVW02Q0NOUTZNMUk4MmNoOW1W?=
 =?utf-8?B?UHU2aTg2eGNkd0JFMHNvcXp1am5CUFMvekt2bzdZR29IMHBDVjlMdmVKSExE?=
 =?utf-8?B?SmRjckFDQm5uQUxtdjdMVStZcFlKUkF4U2I0RUxDV2p3VW4vN3doWFE3V1BX?=
 =?utf-8?B?T1dLbWovdkpnQmhkdHYzYWNHVSswWUgrVFVTL0cxTm8weTVma1FYRmFXZlUx?=
 =?utf-8?B?aXBMU0QxTTc4dDBzclhXYTI2NTFWRXZSNFI2eWRENFBQRmtPN0JZTklPbC9n?=
 =?utf-8?B?Sktva1JiOTN6RTExWGtFTWVNRk5CRnRIZVZoYmtsMi8wMFhZM0VjR1ZGK21w?=
 =?utf-8?B?QVJBWnVRYjZRRlNEeDdvblBTd24va0JFYVNHZzV2ZVhNUi9BQzRYMisxbVN6?=
 =?utf-8?Q?SFDPkU/R6lxH7N8ZYjI//aaCcD2/HkMFHRRto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7210.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVpROEthbWkwWkRVWEYzU05pZGkvOTRzWXpINlljbm0rNy81VmhseGdjOTBr?=
 =?utf-8?B?dkFReVpnV2pRQkNnN2hpYjBCbVV2OU9RTGtLby9zazNld2lKY1Irc1lCUmFT?=
 =?utf-8?B?YzZrYnQ1K201SVo1dXJKRjFzeDBoVExDV3lvSTBYTmNlaVhkbWxiM0EvNWpM?=
 =?utf-8?B?Z0M0SlFmL0FRWHhqYVZESnZCZ3oxMkZWY29hdXI0WTg0T1RvTFNoWWxkZlU0?=
 =?utf-8?B?NnhCbll0V3JQU3lHRE5lTTZvcEhOZXRzTGpJaEZSaFBGR0lPZ3RSNTJhdkZY?=
 =?utf-8?B?Wm1GSENuSitQb3gyT2g3OWdUVTRyR014QzROTXVuNy95d0tkcmJoM3B3OVJX?=
 =?utf-8?B?cmo5aWptTStxN0w0N3FncFhBTkg0NG9rK1ZrRmE3Z3djVC9ldTlOVUYvSndP?=
 =?utf-8?B?MGtROWlUb1NqUDcrU3dhUDlQM2lBblRlWDBiNnB1SUtxMmYrSDFMdnhNUGZw?=
 =?utf-8?B?eTY2dzVDS1dvNjNMVzZ6UDBDdUFIUzdhN2RybzNUc0pQZjdyb09RTFRkeU9H?=
 =?utf-8?B?eVl3Mk5MdzRZNmJwUDJ4blBNR3l6cmdrWEhaOWJ5QVpScERMK2t3SUxVQi9p?=
 =?utf-8?B?YnNac1ZXaFROeXprMGdNb2xCK3NkaWh6UkpsNk52ZWRUd0haTEFwb1ZmY2Fv?=
 =?utf-8?B?dUFRSzFSVEYrdm5OMGkvVHExWVYvZW93cktsSGNPaVkzR1B4ZTBuVjdmZzI5?=
 =?utf-8?B?M0dkZ2JkQng2MEVqS2dNcWpsWG5OSUlzWHdzRDNMZGQzSytSTlcrRmg4eENy?=
 =?utf-8?B?ekxLeHU4T3VkTkx5YVkzekFlVHB2V1FqdEJoYUxETFVFenJVOWh5TFJ4VVc1?=
 =?utf-8?B?NExMMWpnYjRRTWpGYWlURG5UeWxYeXdsUndKbllEd2ZSbWVuOGtWcWROUHBW?=
 =?utf-8?B?U1hpVHp6R3F2REpvZUFTSjhLbVRCWkgwYW8rS3Z3d1I3cHI2RmNqdmppaVZx?=
 =?utf-8?B?aDdubFVmMkdPV0QyazcvRk1OL0RBdnBqNm15d3FUc1o3bnpHYzJaVTZYeFJB?=
 =?utf-8?B?WkhqbDZWaHlsSThuM0RTeFFvZFY2eHZvYkErNkx2RWtwRmRDM1hHZ3hLSi9m?=
 =?utf-8?B?ZmZOSkg5emhwNHErNlRhUmdDdnFCWEcxaGxWdkFRZlFmVWV1NHZQZ0lwSmI0?=
 =?utf-8?B?YWVVWlRHOEZmYlZ0cUltY2IvZG4zT2VXeWlOaTNXSSsxdHBVZmsxeExwZ3ZO?=
 =?utf-8?B?UG85L1dzcXlabk1FdlR4WWswOFpsT2tSKzZKUzNUSlB5SURqNEVxQytwTkhO?=
 =?utf-8?B?UzZrdDlCYXoybGxCcmhLTFI3Z3ByZjBLWTF4bWluL3RRcnBLaUFHQ2UybzJ6?=
 =?utf-8?B?T2FxNi9YOHlEamNVV3BmamNNSGtwN0ZPYU56ZjJ6MGhqKzFlaTRURE82Unh1?=
 =?utf-8?B?cEZuNm5WSDdld01zWGVZMW9YT094NFJrUm14ZG1zb1N1RGxvemdXQjZhU2pn?=
 =?utf-8?B?QnpWcFVWVGxXU0NDZ1lxd2ltSGVTMHFGMGg2TEg2dm1HOVg0R2F6eGtibStk?=
 =?utf-8?B?OW5SdEtpL0RPb29ZSFROSDlrZEEyTXRnWkZBdEgrbERYUWhUNFpqbXBQR3p5?=
 =?utf-8?B?cmRMdWlMK3FUY3FsOEl5ZmxWWGowb2N5cVZya3pEY2VNUXplQmtBSmFQN2Rm?=
 =?utf-8?B?TjVSNmhERjNUdzVYMHRWMkpoTzlGSENEYUVmNjg2cUFIVnZJODBuNndIcmdX?=
 =?utf-8?B?S3kxRldpUlJOSGtXc2lsd2s2TXAxSWw3ZEo0NklEck1xOHpzK2d2SjlGS1pJ?=
 =?utf-8?B?S25BcU4wWTVETzJyTWVoWDY3UnBWRW81c1Y0NmVKQVdsV2tMaG9ITURSTzlQ?=
 =?utf-8?B?Q1hnNWtUYWw3dkFuK2tZVFZIWUM1QmE5djdudjczNklkaWQxY1lUQ0grNDZW?=
 =?utf-8?B?eVJ2aEZRZUNvWFZ4dkpMWjVFc1VycjBhMTZEbUZIZERKRlozSHNUUXc5ejBt?=
 =?utf-8?B?WndIK1BIcFJnZk8rOERaREcvdUxoQ0todGlDbDFhRjdONHJLY1doZFlCMlNy?=
 =?utf-8?B?NWJkRXhOL01ka0o4VlBCcDM4WHkrc2dlQ0VmV0NyNDlZekJ2OXZtZ1dCSGk2?=
 =?utf-8?B?YUFWSS9jUDJveHlKNHdCS3ZZT3hlOC9TV25EL2ZueFVrYjBlMU9XRlNHSFRs?=
 =?utf-8?Q?qDjxjWmdmk/5bRVF7MTXMzt67?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674c7dbb-4cd0-4216-68db-08dd923de1f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:47:43.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcPOjklJYLq+zDB1gOiGpUDn+keXsq1Rt/RoXzyOHSpDZil8Pash61HvEPEBfunIVVWNUAFFwqizxEK4PfpOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482

sounds great! will adjust accordingly.

David

On 2025-05-13 12:44, Alex Deucher wrote:
> On Tue, May 13, 2025 at 12:38 PM David (Ming Qiang) Wu
> <David.Wu3@amd.com> wrote:
>> On VCN v4.0.5 there is a race condition where the WPTR is not
>> updated after starting from idle when doorbell is used. The read-back
>> of regVCN_RB1_DB_CTRL register after written is to ensure the
>> doorbell_index is updated before it can work properly.
>>
>> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> index ed00d35039c1..d6be8b05d7a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> @@ -1033,6 +1033,8 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>          WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>>                          ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>                          VCN_RB1_DB_CTRL__EN_MASK);
>> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
>> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>>
>>          return 0;
>>   }
>> @@ -1195,6 +1197,8 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
>>          WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>>                       ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>                       VCN_RB1_DB_CTRL__EN_MASK);
>> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
>> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
> You might want to move this one down to the end of the function to
> post the other subsequent writes.  Arguably all of the VCNs should do
> something similar.  If you want to make sure a PCIe write goes
> through, you need to issue a subsequent read.  Doing this at the end
> of each function should post all previous writes.
>
> Alex
>
>>          WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>>          WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>> --
>> 2.49.0
>>

