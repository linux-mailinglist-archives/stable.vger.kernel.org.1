Return-Path: <stable+bounces-144172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8CAB5631
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DD87A607A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4028F935;
	Tue, 13 May 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XxVvd/cV"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF218027
	for <stable@vger.kernel.org>; Tue, 13 May 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143323; cv=fail; b=ljgh6AWYoFguPPBfbkqLLqxabbFQ0a745/kimy9WmgRQrWD4uiGi1uHBuyzvzjVzHApq3bgoFAofozgbi8/UB6zV9ZTGxWadGBlHxQg8Rr0tnwJuLg3wMmYD59+MO4+/zLyp24ZnG8xcyumivkXgYQnfGrmfFFfdVy6NoI0ifIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143323; c=relaxed/simple;
	bh=lSTm42XZlGXmKWI+7wW+3FOCSvxH1qqsGvNygdn2s/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d3Tf8x6U06FXnS1f7wc5AgQdvseRK3S4/x5U70BsAryiVbJARt/EbqmaNUYYl1MBckcbcua430elb1g7vI7f4Pure7OZTW4YOJKp9noz+614aM/SIPEhY+DKCLI1D8MeXV7kRnALf1cb7lP/DPjJJvoRTEcseHSva6R8jHVqJ3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XxVvd/cV; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9HrvlA40foMF3YyaGCZ37gyZfvSQJ51xjD5gMvkN8Nbjui6hJoqORcAuDBLVRM2vXbtsMDVB8Bg5+IH8L8LIRTi91gShN0wrcnhjakLiMh+rbyz8vP5/XfoxclW3c39v8C6hWDsPvlQXjjqSCATAnyTmreu7DuE2lQjf9HtKyp0963QJb4pZeJDIOA2gTzn3VLeILS7sTrjDFRza/yFUpaHynkCkWvOuTES9WWoVLmu8TAhgixMRsPOxBcB9y79yAEONkETewVhmQeryXRIOjG44FBiDWre6iLfrlMbriyqFN375egEPtuQZaJZqSOOBbc5a6wXGdtzlEnYJSq6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBDi2stsnGEr8Hj+2480Ka/ybmuU64Gqsao14K0sYbs=;
 b=jrsYQHZ1YDOAWePM497zV9KKuBVd9fkOxINxRcLWbz9Lv5eXN0CMDotVaubJIWy1IWh98CeEyXLVC8tUqpiBt3E04rmX/ZJ4T0ZXClZuZ/e4zPSeRg+pZntVfXqUQvWKoHhmyJ1Pv3Wcln+d0bGY9OgxljwobIHnsGx27jGrH9cKUFlM4tTi6RHDnXBX923NJ65myY2cxI99EEpCKphFOk4z/+FS6Ws9t0f5U/Nk0sP8EVLntwrD0XuktPNaimgFpekap9ugXMPYSIWAx8Dc8XMHOtyvgCpCJwS6s9MCWS3NrNL3iiPDiQi/b9XncBeI1BUcySswb6Ev2alY0gB5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBDi2stsnGEr8Hj+2480Ka/ybmuU64Gqsao14K0sYbs=;
 b=XxVvd/cVYj0j221GnUN6uGp1uaF5JBR7MYNSVJASKbriUv4dOp4ucGu2KDUiXiWKgSTE9co8279BmJ/5PHQAzvXe2sUNFRYVpVX7RHbwKN1yvZTty+1nBCSr9Wz5qxyWOmlHC3dQWlaLvUvlB7w34WUj5Y8u7e47iCNyHkJKr0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 13:35:19 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 13:35:19 +0000
Message-ID: <4a3d9653-cc3f-4b24-b6a9-a2d676e8af03@amd.com>
Date: Tue, 13 May 2025 09:35:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20250513032026.838036-1-Wayne.Lin@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250513032026.838036-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 535b0f3b-8abe-46cb-41fb-08dd922300ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9vckdEQzBrT25zRGdFdTdwWCtKTG56SytrK1pqVUx5RlRnYW11eXZhaGR0?=
 =?utf-8?B?SCsrbmh3bFdOanRNR3RINCs4dFVvTzB3RVM1WXljTTZXa2pWVlZFMWlNbGdE?=
 =?utf-8?B?Wnp4NkdZc3FqdU1pV3FERVpYZlRMSVRJUFVNMjF4T3hEN21rR0RxQlBVRHdh?=
 =?utf-8?B?Z21xbTFYNEF5M2VMdG9pYkd5VVcyT1Vhank5TDhWN1k4NjlFV2k3QWFzRjA1?=
 =?utf-8?B?VHlJTG1ZSEl1Nm1sYVVwbkw0Zy9kS0cxTDJuVzRFNEZvTGwxV2pSUUo1NmMw?=
 =?utf-8?B?QmwwcXYzTE05Y0MxVUM5T28yMjZSS2xkTTFMSlp3UmdUWjlZbmpZVk12OXQ3?=
 =?utf-8?B?VWgvRHdOU2RpSGxWdUlZU2YwSUFNYkYxeGo2ei9seFpLQUZveFdaWVMrSmxC?=
 =?utf-8?B?SWRwOTdMbVF4eSswT1ExUkk4a2EvWllGSzI2azQyNmRrd1RINS95TWVsN0JG?=
 =?utf-8?B?ckxrWDJvQTZtMkhmenlmTmxSZjVLMmtrQ0Z1d3NjeUUvMGdqUUFCQjQ4MXh0?=
 =?utf-8?B?NjhlVTdXRnZhVXU2SHVuWVUwUUV6LzFxMDJQc0M2Zitaclo3YTgxRlVzRFVC?=
 =?utf-8?B?VGlRdXNySTNJR3paU0xsc1QxU1Bvd2twa1NOWEFmaDdSV0xsTFozazhsdGY1?=
 =?utf-8?B?bk5CclAvdU9hUVdoSVNIR29tOHZzMnkxS1dMTFVUV28zbCs3UytkR2VhSFhG?=
 =?utf-8?B?VFFRblA2RnVoRXdaejkzbmhucFZ4UnFBVW14QWdyQU41VUdueXdGMWV4eEti?=
 =?utf-8?B?c3kreXFZMWloZitNVjFidWdocUwxOWhZNGFOU2dOZkU1RnRGTkppN04vVVly?=
 =?utf-8?B?dS9uVEtaRE9NVDJ3ejRXRDZVNCsvOSt0cGVqcDUyZVdBSHlwVWhXTUd1dmxH?=
 =?utf-8?B?UXJwWDZOVXBZR3ZZcVQzYUplSytIVzVXbDNkWmMzK21WNCtIR1dNRnc3MWFO?=
 =?utf-8?B?b1l0dWVkOUpPOGNZdUxuVUlPTGpIMFNRSTZiSUo0aTRMT2N0NjA2c1IyR1Zu?=
 =?utf-8?B?dHdCSzUwSm5acldJZkxXZjB2MkZoTzU4akcvNTlqRk5tZGsrT1p5OEFocWFh?=
 =?utf-8?B?R0dnWlBxNDk2WW15RUlqZnRSdWdlbFBXRHVBd2JSaml4d1dsVjFuVy9WMGZi?=
 =?utf-8?B?N0hnUW1QcGlJZEtYTmFUb3lnbEdjWUxjNkNPMUxuZSsvT1FNSTF5ZGEzd0pl?=
 =?utf-8?B?aTVKcUNRWEpvSyswd0hFbVhCZEhVMVluZzEyQVVhaVNScHlrUTJFQUdtWEZ6?=
 =?utf-8?B?TXNFc0VOd2ZuTFJ1V1lLMUVnTCtIK3ZEQVQ4MnJNdWYxSWpjS2txNjdqSGc1?=
 =?utf-8?B?T243WnFkUjdDZllHZG9ieDN4T2pSNGJjaDJtVTJjU0xlckF1aHR4YVpNVVBJ?=
 =?utf-8?B?cFJDNzF5QXpwNDNUTUI4cDdsdFJxTW5XUXRSYStPOS8zMXI4NjZtelE1SVJR?=
 =?utf-8?B?ZUFHV2tpVXhrcXZCYjc4YlhLYkxMbWJ6ZnViWmU2ZjU4eWVlZnFPaURERWps?=
 =?utf-8?B?RkVXMjRPVHJBQ1BwNysxZFFMbG9WMEpsVjFGZldybjNGa1RQMlFpZUJXUW5n?=
 =?utf-8?B?VC9BaWhsR2YzNnM5ZmdVWFB2MFhwN2VEMzh6emNJc3ZhMFVMSlhEcXJZV2Zi?=
 =?utf-8?B?MkowcUxSL3NrOUZpcXk5VUlvaUFMUjlJNlY4L3NrUDlYd0p3ZjlwNDhURkRH?=
 =?utf-8?B?V0F2dkRDa3dvWWpqU2ZxaEE3SHJaOU1ObUpDVWdiWXpSc3gwdUZIRVF4WERY?=
 =?utf-8?B?N3dwV240U0picmR4bk1TQVMrU0lJMG5nZzRvLzVSdWhNdmxnbm5aditGdTZY?=
 =?utf-8?B?c3EwcXJnTEY1MWU0dkZhTDdmYU9ibGRyRE1ZTGhsbTFHNm9GdzY3ZHFoZmhI?=
 =?utf-8?B?MlRJdkUyaTBYc2t2eWxMaFdYSDZKTTRtM0VNQWNQb2ZJM3VFSU42TWQ3RUpK?=
 =?utf-8?Q?WQjzoBaRE7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1J1VDNVOGhjdVJJWEwxNXRpemRTM3ZVcWt2TU9zTFUzOUhsa0t6bzJLMGdz?=
 =?utf-8?B?a1VGT1VFa3kxQ3JISktXbnE0UHcvWk5RS2diM0hoUU12dGVRS0IxTHFuNHBn?=
 =?utf-8?B?NEQ2aHJ1dGczMDRZVWtza3htaHkvaFU1dXNSSTBuN3hFL01yN2VpTFhvR2JV?=
 =?utf-8?B?cVFDYWZveGFFUUxZR2J3UFg0MDNZaTh0RSs3d21aTldBSUg0dDBmQWdkcTZU?=
 =?utf-8?B?a09xUW9GWHdCR2c0cEVOcDI3bXpXaDNQSU4yTG1Zc0FjaUtDTUEwS1h5MWoz?=
 =?utf-8?B?Ty9OSHYweXBDY1hoa0ZBRUl5WmtGcnRSWXFUQ3dLQzdOM29pOVZYMmxMTTZs?=
 =?utf-8?B?VmRZeDJDdkU5VWxLVmk1Unprby9kY2I3ME1IOTdVOVJsTWJPOGM1YWtDR0pw?=
 =?utf-8?B?Nk1KcUVPRjdINUFCMnptZGZZWFA1WXQ2am5YckoyM21EVGJDQ2RsK3hwbU1o?=
 =?utf-8?B?ZzdkR0tDS0UyWi9IYkdWQzEzWUsra2pKaEpYZmtFTDJLQXlkczljMmRlU3Zx?=
 =?utf-8?B?cUh4aG11aXd6NjlpZkl1eTk0OW4rTG9vYnJ2Nk16N1FoV0pzdTVxVklRbk9C?=
 =?utf-8?B?bHJPbTJEQ2tTNjFEdUovbzJjUEZKamc2bytYSTFFNFVNalFEeDJ5Vjh5VXJ6?=
 =?utf-8?B?ZlhNNkY0SWdzc1JsL1VrY2xTcDdKV0I5RHJXb3dQMWtEQVVGNkhWOXlZYzN5?=
 =?utf-8?B?OXFlM2JzS1pJaW1WRjI3UWFMMUFQSTZkd25SdjlxTTlERElTQm4vOExweEN4?=
 =?utf-8?B?d25lMU1ES3p3RFdheEthdTJOR0hUNUxSamQ5TUpheTREbFlGVkFDdnpyQktW?=
 =?utf-8?B?dlZFejJkdDFkVHNiU2VOSlNCd3ozRmZIOHhIcGN6WldYNW43MzBvQnNtSE1V?=
 =?utf-8?B?OVVrdEJIbHgraWFWZUJqY2Zmc3UxdmFRZXNFN2JuM0V6WWpacllxOEZ5U1U4?=
 =?utf-8?B?RDJxcHAycUNsMjNqNUhUKzNzRVd1Q0orZmhTbWJiK1gyNXFOSm9DOUNDcmpI?=
 =?utf-8?B?TWxHRDRsTVF5WmtJd1BaMWp0VzJ5NTVMNHIwN3pwMU5ZWm4vNWNPN0xTODhj?=
 =?utf-8?B?cDkwVkdjV0V0eU1wZXNtN1A4d0ZFRXVtYy9KdmVySVhpdkRlTzlvM0hVNzVa?=
 =?utf-8?B?UUpuVkhHVzBiUWtsTUJGRWgyWTNrcXB0c1FyT0JWdGd2Sk15R25QM1dxZTJ4?=
 =?utf-8?B?eGNEaHZTN2YrYnhWd1Vtb3VabVRFbEdsVTdkRktGck4zOUNzM205WmRlNmFG?=
 =?utf-8?B?SUQ1L1paK1JLeGtqdys5ZU1kRUtRZmpHQm1OQitDN1BjVnF1WWZqaGdENHpa?=
 =?utf-8?B?elRLSjNnUlJ0Z3QrbXJZamtsWlAvWGw2WG9HNE5oQVljYjVET0NHYkhneXBY?=
 =?utf-8?B?bTlqVk9LVUJZVE04clovVWJtdFhHVG82c3FhblVzNnNxRWl5YlEzRXdiZCtz?=
 =?utf-8?B?M2tldDNtWWtBWjZ3Y1Q5dXM2OHg0b3BlZWwvMi9yZGxqdVpDRmJYZGZHZGZQ?=
 =?utf-8?B?MCtyeUpWN0pVakVPUGJOSmthRGM4bURJZEZGZTJtZlNBcXk2M1RGQ2cxd2RF?=
 =?utf-8?B?Z1VQUEYyemttRTFBSUJvZ1M3TitZQmJqK2ZNRTVsUTc3MVJjT2NmcWZRVE8v?=
 =?utf-8?B?VGNCNGp4VU9zQ0l1YU4xRXdlS0VzeWZyaGsrTGRGcjI0RXMrRWcwME1td2gr?=
 =?utf-8?B?RVBrUHArS3M4MXZMeS8vWWY0ZEp1bjdXeEhTbEluVlJhRzQ5dTV5TlpVb1JB?=
 =?utf-8?B?d3VlR3lwUVhrdFdTd2huZFNMMFkrUWczK2pUQ2ZMQjBzdFAyYVhQWG0xeTgw?=
 =?utf-8?B?YUswWUlmUzdKOS83ZTdJa2pPR1I1RlRFOG5xbC9hWVM0Wld1SEtMS0VHUFRI?=
 =?utf-8?B?VU5IMit0cXlsbzJraVdJV2ZnSkZ0KytEeUhLSDRYZkJ6WGtua3RLalZuU0gv?=
 =?utf-8?B?bmNyNEh1QVRxQXJvZkJZVlllUHFYVHBmT01mMC9WMDVOMDdnUzM0K1ZMbHI0?=
 =?utf-8?B?d3F5YnRzTkFsZjBZQnRxckkySGNObTl3YkFwcktBQnVGaWIzcnpjK0xub1px?=
 =?utf-8?B?UTRaSWdDK1JCWlBUaUw5dWxROFRwb2htWW9rT1dqN09YaUM1WnJmUjhVMHlF?=
 =?utf-8?Q?pFIolmQzXMaQRuhkxof12uUbZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535b0f3b-8abe-46cb-41fb-08dd922300ed
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:35:19.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxFkqf18Ujcqpa4U0/g30CmipHRJn1FirY3oj+CEJI4VvoiWScscITHla07k00vG8ZInYvadx1B5nZcQJOhRqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290



On 2025-05-12 23:20, Wayne Lin wrote:
> It's expected that we'll encounter temporary exceptions
> during aux transactions. Adjust logging from drm_info to
> drm_dbg_dp to prevent flooding with unnecessary log messages.
> 
> Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER case")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 0d7b72c75802..25e8befbcc47 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
>  	if (payload.write && result >= 0) {
>  		if (result) {
>  			/*one byte indicating partially written bytes*/
> -			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
> +			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
>  			result = payload.data[0];
>  		} else if (!payload.reply[0])
>  			/*I2C_ACK|AUX_ACK*/
> @@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
>  			break;
>  		}
>  
> -		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
> +		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
>  	}
>  
>  	if (payload.reply[0])
> -		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
> +		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
>  			payload.reply[0]);
>  
>  	return result;


