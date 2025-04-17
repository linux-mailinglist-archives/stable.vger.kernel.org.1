Return-Path: <stable+bounces-132900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AFDA91451
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CF95A29B5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093F21518B;
	Thu, 17 Apr 2025 06:52:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F89215178
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872755; cv=fail; b=OiCGQmuwqArQPrT17w25LnHEIi9sn31jfvX7gHSFOg1z2npR36ZgT8Re93NZ3BWSR3J7Y5lIDx86R4Exhes6zdkR5ScwHCe8aF8L6dFERhiF36j2LIUDsqy9hUNt0dVXVRgTqRm94JFzzD7TUWQaqXaQTjhyR2/ZgSHDAasLkjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872755; c=relaxed/simple;
	bh=NM0R/59/XgwLpPXe9GbMj+cQCTyOGvBXbXeFup+gYkE=;
	h=Message-ID:Date:Subject:From:To:References:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=NVmveBj3Y8D0LxsRKLWoYKu6VJi/fCPV36x5w+Y7F+JJVhIHnZuOIDNC7mTAM9XFRlkkShwgviXiSsbVtq/R99Ng/Ib6Q8E47CfJ7AGZBvTHLMPk/0DhDFOIseaZAeJnE6Jio7stWvEZyxwWMk3dzpNGc8iLl0OuUwfYLOgWcPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5Raec003805;
	Wed, 16 Apr 2025 23:51:14 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ykf3nsc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 23:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbReyZSAheUBuw56AECrUMkzyp9Z8Fi5LejceL/HPsG2wYp4pLhAuJYI8V4+enAk5aYpI0hAWp+fJERZU+o4zMrq0HEPTBdGbwS4ZKnQu2+lAdvRb/7Q86LJ1l5tcp5rS4okh+UxqlJ7cIts7HfHFQuOLXpgIkMsVlxoeaKnAN+Q9xQUcR0ZLiGRyHgOIQB5LEsn09QJq41c42HvBKFCB5lKnb9ww0lnq/03W0ylwoJtBr/O+3NM9RywpVzB/792dkHKanIzD34r09XSSpc3le4vLM3eHKtZgvlGzGxOGcrzrrSdCB7c9eZotmTZc5ot5Plcj6FjmNewYaejcVOUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp3nMtsxRr31kgue64JrUcOHPKAUctYz+u+OKhFNRmM=;
 b=WLE20otMJFAUaNyRoqJesb2rasVHG5uiGBDNEnKq7gy2B/2EqXfA4HXVT+lxrfxhguZaaMBYHVGb6Qaa+TTIFep75EnkZoZn9YnMr63JvcJSReHxcJTzCwoSMv2yqTFk4Za+4OM83HPSvBCBjXF3vKlhngDctnItZek+tcqBriqcGBkP8kcfqOao+NepRuXLL6L3Ed/c/NOzjHSinhzPfznil5XnP0Rq9lE3K35qYib4p32r1bi+ZxY/7tJfAJYzVEW/h9ROcesvuJH1L2zl3yNT973UY0akF/ku1orhuWx4zwt9EimByF64wjmf4R04RdaT3uyLLBfQkbmkXGpUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by DS4PPF2F49754B6.namprd11.prod.outlook.com (2603:10b6:f:fc02::1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 06:51:12 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 06:51:12 +0000
Message-ID: <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
Date: Thu, 17 Apr 2025 14:51:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Question about back-porting '8be091338971 crypto:
 hisilicon/debugfs - Fix debugfs uninit process issue'
From: Cliff Liu <donghua.liu@windriver.com>
To: huangchenghai2@huawei.com
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
Content-Language: en-US
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, stable@vger.kernel.org
In-Reply-To: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|DS4PPF2F49754B6:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4db5af-bf70-49ab-cd1c-08dd7d7c3db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDFsODJRSWMyMFV6RWVFeDQ5ZXpQNmxqaGVYeVFQWkxDTVk0cXdTNTF6K0RN?=
 =?utf-8?B?UlJvVTlBWFJpUm1wbXYxNG9mSllYZXArMTNET3dZR3NDSHdmM1B1QUwwcVRn?=
 =?utf-8?B?SXRwQXlLKy93bWJMSmpncUpvdmRibEFRUHpTNUZQUE5WNG0rVysxOEtWSDRx?=
 =?utf-8?B?QTNEVk1zNUpTeU9aRGNFRXo1WGdyWmkxdFBhd0plVnJYZ2dmZmNVaVpuYzgz?=
 =?utf-8?B?ak5xa2E5eXJraGN3Zzl3b044SzdDQ1FnSlV6Mmxpd0FiQmkzRDdqZGRxS1M3?=
 =?utf-8?B?UVo1SUo0UGtnMk5SNDRjUllCUWZ1ckV5cXlFSUs5Y3VVNkk3WnU4VkpJZ3Rt?=
 =?utf-8?B?Um9ZNlJzT3VtNml2akxyTEtsNVNVYk42cFhERDRESEUrVWVLUEdUQnY5cTN0?=
 =?utf-8?B?S1hlV2o0dTVxaWRMY2Nsclo0SXRoVDBZQmZSUUxXanVnb1hUNzArR2NpZTYw?=
 =?utf-8?B?SCswWm9VK1p6UzE2dytucm5temQ5SW5DVFBjRktvK1dZL3NjTFhrcVJ3MUJo?=
 =?utf-8?B?cE1STkN2VmZGUzViZTFnWjFPckhBRHBBb05XYW9SbUFiWmxXcmlCdjZvdDlX?=
 =?utf-8?B?UGJOWnArOHR1RjZNaEdocUdjQlp2enN1YjF3MGxFV2p3NjdXUVBiazhMb3RI?=
 =?utf-8?B?dmJwM09jN0dNTmt0VWVvRzcxOGM2SXE2YkpweWs2YTZMclNINGs3TW4yaDhM?=
 =?utf-8?B?M2o0NXprMm9lUENRZ2RSNEZTYVd6S1ordUdzUHhJWVZhSE05NDEzUGJSQlBK?=
 =?utf-8?B?WEZSYm1yUjIrZ2FTbEE0V1NZeUUzM0JoclB2TW1JS0x1RTNzQ3NTb0FmU1FT?=
 =?utf-8?B?Sk9sdmJkRGlydFZuOW5GZEYzbnVyUHp6T2gzNER1a0EyenpIMkNtbHpqVXNh?=
 =?utf-8?B?QVp3dG5KL2t4R1MvaUlTSHhKaG9abDJGeDlUWnFiSCtkK1NFcVNtWGVHZndx?=
 =?utf-8?B?ZVJXN3BtUXg0dVR0SEloWlZzWjNhaGNxd3crYTBhMWdYT1lTSzNhS2VCTVhx?=
 =?utf-8?B?cG1xelA0WVU0YU1ndS9pem9Na1FXUGVHN0dhanFEY1VuU1FlWmhqcU5MRXZY?=
 =?utf-8?B?OFgxR3pHSnptM2RaZG9GaEU5ZnNWMm1kcU1ydXVCRFg3R2JTSTJRR2VGQ3Z6?=
 =?utf-8?B?TXZmQnRUSEFGNnhsQkIvMmVpOElOakxwTXdrYkhXSzIvNHczTWppWTA3V0V6?=
 =?utf-8?B?MFJOcXhxUi9kdW5vWll2OWdLeVpNak9ra210K2tNY2U2QzhJai8vVFM0SWdo?=
 =?utf-8?B?SG5jYnBvY2ZyYm5KZEUvRFFuTmtMVVJLREZLVlBhVzRmYkQ3QUV6WDJkMVp4?=
 =?utf-8?B?NCtSU3ZVaDNVbEVkRXRtT2tKTVltTWtUeGIweWxBQTVUZ2ZGOVlHem13ZDlR?=
 =?utf-8?B?SkNBMEhhU1R3VTVMaDVGbXF1d3VwUzN6T0h6YUdWQUxUV2JTMVVaSW1QUlBq?=
 =?utf-8?B?cnZyK2YzWTBuK1oxQzBWY0xSdzY0U2tMNnNKbnBiNno3c2FZL1VvY1ZXQ3FN?=
 =?utf-8?B?VFZnY1p5dmcyQmhVQmlYaHlONmtUMmQvVm9DWlZ5dEl4RGU1WXQ4L2V1SVkr?=
 =?utf-8?B?MHZJbkFHVEh5RVBvdWFjbHd6N0d0UEczd0c0NzVLZkQwS3NlVlA1YXcyMWpj?=
 =?utf-8?B?aVozRDlzODB6bEVOUkdXYlNHUmNjdVE0bHIvYm9zQ2MwaUtTRTVDbjE2V3d2?=
 =?utf-8?B?U3pwZDhBSlVTS1I1aFhHMGN5SHZHOUFpS05iRUtLVGUzRkVUalRTMTZ0NU9S?=
 =?utf-8?B?RHBzUVp0MU1UNDZzeFJKemlSQ1Rpcm55OEZUVVdkNnpITVJpeVVxWkQvZ0Ju?=
 =?utf-8?B?bGNYL29VRDR3MlB1VGVxT2lIVjFuZTJ1M3NTaDBXbmIyMGl6U2dHbGE2Vk02?=
 =?utf-8?B?R0tDamhqa1Y4MTJDamVUaHI0aVROV05zMU93Z2lYOEowQ1lXd2pWaWNpUGZZ?=
 =?utf-8?B?YXkxdjg5VWtvbjdWTUErcG1RTjU2dXRWV3JobUw1ci80U3Y3ZGRBck90VE5I?=
 =?utf-8?B?ZXRBS0g3NENnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUhRd2Jtc2ZMTFdmVXRTd05LRCs5WWhMTmV2RTlwQlRFUCs0N29ueXBMRjUx?=
 =?utf-8?B?RW1MNWF1UnBab2oxVUlzb09lSEp1OFJsWUZlbmRNNFp0VFhzN0wxRUlsdjlY?=
 =?utf-8?B?UmFDNldnL2hXUTJGKzBNSWxpV0dHRmg4a1gxcDIxUkNlaTdIakc3eTlWK2xR?=
 =?utf-8?B?SzNjbGxiM1hqdGdub0dVY3AzTCtPVGVlU3JlNWZkVnJRVXBHL3BXY2M3dTJW?=
 =?utf-8?B?TDZUa3FUUUNNNWxqYllrenFITDYya1pRQkd0QzRTa1htTlc4ME1LektrY3RB?=
 =?utf-8?B?azJ6L1BZblFkT2dEbDlDenBzZUt1VFd1Tkp2U2RkTi8rb25DZVh3alVTSUVv?=
 =?utf-8?B?T0lLOHF1eDh0YlVlMitrWGtzMnRFSm85NldyeW9KRUpFV3dPbUo4cXlYS1JL?=
 =?utf-8?B?QXU4bzhFd1JkdnFuZFdtYlNlb0tuNGtEK2tLNXI4M1E4UWNtYW1UQ3B5V0hI?=
 =?utf-8?B?eG53akFGVlltK0NNRllkVjFzTGRBSHF3S0R5WHJmbHViTzdOdHVPUVo2NU5H?=
 =?utf-8?B?K1lRY1ZOSkN1UWZ5cTFMV05ieXFTWHN1RnBhVUZvVnJDRTIxT05zK1U0Zlk4?=
 =?utf-8?B?WnRxNW5ZdkM2TVRVenFMUjNCZnozOXpjT0hZTDY0RmhTdnYxajVKWkpmR3pm?=
 =?utf-8?B?blEzRXk4dDZHODZiUk5oOXFIODJ1bUJycDFnUE0wMVcyTXZFcU5YSC82ZExX?=
 =?utf-8?B?NEhkNCtTSSs4YmhmMTlVdEJodDBlSHpHR1VvOEJWbE9qb2RDVWRxSkVMOVlD?=
 =?utf-8?B?enJJVnVsVFRiMXVRRWFKdUZxYmVmd0dSZnZ0dzVVczlZd01ZRXNwNEdUbU5Y?=
 =?utf-8?B?dVlualFRZ01VVnhSS1VSN1RTbFNJRnhNWVZJWFlOcm9JalhhV3dhNVdaQStj?=
 =?utf-8?B?djlyTUdqc09VL1BqY3J5ZDZRMkJ5NUkzNGg2eXpJcmtpYnlsQmtCV0xlQVV5?=
 =?utf-8?B?VTh3WVQxYmorSlA0RG0wQnlSVmtrZWk0eWdURHp5OVFDVDdMSU5GNnFwaitj?=
 =?utf-8?B?eGFVRExoeG52bjVnTlJ4bHphWU1jQWZ3eHZ3cWRhSjZzTnhteVRGQlZFKzdo?=
 =?utf-8?B?VGRRVWhoSUcrWGFwVmkwUG44b0RVU0tmVjdsOFMwVEYveE5PajFhRzdMdmhi?=
 =?utf-8?B?MitaUlBOeTVKRHJuWWhIZ0VVeW92c0hHcW1ERTRoRytsWEFQaFk5OG5mSklo?=
 =?utf-8?B?ZHI1YTdUL2Nmc0I1d0Nwa01OY2N0cXNyWW5ubDk2V2ZNdTZSdFJvc1RYcFhL?=
 =?utf-8?B?MW40cW5FTDROREgzbXdsTU9rS2g3ZHAvTnV1VFlQMnhlM2t4QU5NK1ZkQ1A4?=
 =?utf-8?B?QU5lYjJtR013dkhaTzNrL09HMzFhb0ZBanM3MVZZM09MRXlEUjVwbG9kdTlk?=
 =?utf-8?B?NDREdi9nU0g5OStwS0tWN21yakhlS2IrMFVsUVh1VHYwY21DMm9pc0d6SGpP?=
 =?utf-8?B?RmpETmZta1NtdXNMdk94UlBrYjZBS3JlS0ZGYTQwTndDd25IQzhyMEMyeGln?=
 =?utf-8?B?SW1uckk4U0hQUmhRZjJBaDVSenFKQmdvejBISWxsZXJCcVBaejVsbDVnOFVt?=
 =?utf-8?B?V2VleWZvdkNOZ2crS1ZNTk1DQXZOajdSejR3OGtFaGtmUlJwd21BdERBa0dp?=
 =?utf-8?B?U1Y4ODZQbnZXRzdPaFQ2QW1HNFkzSlVlb09uVkt5Q1VFZ1ZDYWJnZXB4UlhE?=
 =?utf-8?B?eGxMbUFoQ2xTSSt5TFlRRHEvRjFCKzczd3p2Y2xsSm9ZNTVLeDcxbHBlMDVJ?=
 =?utf-8?B?WEFlMmVDMG0yV1dlOXVJdHJsNFFYYWExd2trbkEvNldPVmxXSXhZNC9QMmth?=
 =?utf-8?B?SmQvaGU1YXBTa0Rwb2ZOeno2WWFwOGV2aStsTDN1ZXdCa2FXQndzQ2w3NnZu?=
 =?utf-8?B?SHN6dzRPY2RKRHh6cGkrN0FRbENRSmQ3WFQ4SVVtdWFKd2lUdmFCQnFvbnMw?=
 =?utf-8?B?WlVzZ3JpYmdrcFdqUDVMY0hvNnBIRTJ0dXgrSHJvNks5aXB4SHhLTm15SlpB?=
 =?utf-8?B?ZHJwYVJaYVMvNURNTWkxVDJLV1FiTXkwRVFVeldmSFNaR1ZZZWVJYjVDWmxt?=
 =?utf-8?B?c1A5NUpRRzVsM2lrYjRCb2lTQVhmdTVsR0FEQmFzUDJidzYyWFJNYmFFUWxt?=
 =?utf-8?B?WkNMZW1aZnNJZmZvaXVBalNaWlU3SUpCRHc3NjVHbzFlYkJTalp6eWZQQUYx?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4db5af-bf70-49ab-cd1c-08dd7d7c3db2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 06:51:12.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zf/OzlA2/1yTXejcPDSeV8S23Ya2puW/GLzwjeNWeKLIX6BJXNZlqTou9JJyYRuyw/P2+OuPWERUKTGd77hrcawJuVRafsdkge8CeeVM1rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2F49754B6
X-Proofpoint-ORIG-GUID: 3Tn-QEmYAyKa8wHEqJnQWqbgr7Y4pnUR
X-Authority-Analysis: v=2.4 cv=Wd0Ma1hX c=1 sm=1 tr=0 ts=6800a4e2 cx=c_pps a=9T78G36u1E64A7MtQSounQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kv77K52gG795DiB-QMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3Tn-QEmYAyKa8wHEqJnQWqbgr7Y4pnUR
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=982 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170052

Hi,

I think this patch is not applicable for 5.15 and 5.10.
Could you give me any opinions?

Any helps from maintainers are very appreciated.

Thanks,

   Cliff

On 2025/4/8 15:45, Cliff Liu wrote:
> Hi Chenghai,
>
> I am trying to back-port commit  8be091338971 ("crypto: 
> hisilicon/debugfs - Fix debugfs uninit process issue") to 5.15.y and 
> 5.10.y.  After reviewed the patch and code context, I found there is 
> no "drivers/crypto/hisilicon/debugfs.c" on both 5.15 and 5.10. So I 
> think the fix is not suitable for 5.15 and 5.10.
>
> What do you think? Your opinion is very important to me.
>
> Thanks,
>
>  Cliff
>

