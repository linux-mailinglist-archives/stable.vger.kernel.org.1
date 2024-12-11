Return-Path: <stable+bounces-100630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847389ECF31
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFC3167EE4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936A1A070E;
	Wed, 11 Dec 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="K/MxXuEl"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57A119F116
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929142; cv=fail; b=s/24aWtIqE5+h4lx+DsVaOLkd1xUv3tCjZg7INuZn/Ex6EF7jk53mLoZvNUe/LD6oViyGPaVwTUOWz4vI/UtCEKK+BaQkXiAV8XKpRoK51uXHyPF/XmwQjpFN9B6B1Q1tAghVEunAyx4Am1JKt3ALbY/CqtR9QLUgZD00WYgbfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929142; c=relaxed/simple;
	bh=x6uFACp1ENzqZNTrPJqslhjsZ6vQ2YjxyZDPCfl+AAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZrOKxMJ9zKp6ZcWDI+wwhv2li40jyZgy6vU0MyyLawibFXjoEE8wI16+iDPe1oO6KX07YMzyuyzo2VYVxAZ3uaKfUJZS4Nfr184QQa50dDzyQPYLkUQoykgwmYGYm/ejGBMXpAMfy4mH3c89wYyOdrXfnTfOlESGkwDmbuL4pVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=K/MxXuEl; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44]) by mx-outbound21-149.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 14:58:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhPwBclQsWcxfOr66Mc9Uarp1XUNXLMjAAnu4lMnSSsig6yKBNc1mfEFEWl3tmK2Z5vU6RzugB0qfQfHI5CWR9GFP14SeEzbnizbg6U45VmFQKrFcaaIPjRDUBreWrPuPFCMm7kiSjHcMctnaxHeJGh+uectnvjN63+2QGYgCVcLh/9FXyqjIRNQmegKdo7mnfrjdcvYwBFzvryE9yQmW0PRiKUTAtAPafBlNLJnVpbXzK+ZEdotq5fCtxiTegCQ7PRkuh2R0MhqTuBXlQyQd4iWeRp5nHY/7SrzGrxDTdy771rn/QRIM2AKRTi3C2PYLwoSbiAY67ZieaoJbBhQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S2L8hJYdie6XoAccB3azg5cDXkUUu+4THf/aAULo7U=;
 b=Kpgy7N/+iIVP5FSWL2YrnzrKuHliSqIy86QyEkjqOvuvTRVlDTNjqtaP/bPcrlMVRoYdSPVrOdJU59YFhnPk4VosqtV74lsHsxwIKyLUk0Bu+L9bQjUaiL1njXvjJHHTy0s6pb3zrdIRKAxtrk0qR1ul4H8ZKpYYxU7jmxsJr9qYSGu9iiOUT+fUS+lIMeLvn2uW0CsKN3KpeDXRexF14mU0JqVaZ0a9y7CuOIg5IOgRhsdQHT1yo40k3wsagcFJgaEj0uVj/ee5jVLwEqLPCa4EWeVGRTklwUVIE63p1bY3qg3lfmx9MGsypBYw0x1pRtMpFc+E34d8PA7TE3ym9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S2L8hJYdie6XoAccB3azg5cDXkUUu+4THf/aAULo7U=;
 b=K/MxXuElcNxoRExrTA1OCA974ne0Oychp+P7MVYeVhTXA2ZS8/YCAPtoYZ1he/xdQ093Y+BITwfJbtBfIOLeYIievVeNFt8IL9voa5tfxhpHwqK5TL48CurywZz8i6dds7JbsSj9pLhkP3dKMryALJLvnV9DWTUFe3kbfk0AFNTRBJvT+XkadGdll777f+zK2pacfgv+mUMwufSdrdyfPfb3Ueq8fLIEBTYeafaDsauDhrGdZ64cTXIQdtn9AWch3Hmc7HHRTqHsKl83dWlQ3MfMJkH9yKi0cHyc/hGqCLFVDQkrAEdl8Dh2OxgI4tMmHsh749iNVDnd4+5TVyWmMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by IA0PR10MB6698.namprd10.prod.outlook.com (2603:10b6:208:442::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:43:00 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:43:00 +0000
Message-ID: <31d2a9eb-958f-43b6-84ef-d687e52cea08@digi.com>
Date: Wed, 11 Dec 2024 15:42:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: tag_ocelot_8021q: fix broken reception
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241211124657.1357330-1-robert.hodaszi@digi.com>
 <20241211143734.d3motemj7kwao4td@skbuf>
Content-Language: en-US
From: Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <20241211143734.d3motemj7kwao4td@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|IA0PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e94fe68-4d5a-4ac1-f1b2-08dd19f21bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGU2SlhhQjJhT3QwQm9HOXJJWE40VjdFdDVOd1puTmJVRTdRT0tVQWNBL3FC?=
 =?utf-8?B?WUQvc1FuQkhiazRjRlNBdVVYYW4waklOUHFvZEFIU2wyUmNqbHlxdXRweHZ6?=
 =?utf-8?B?eExZSzhhZDdrV3RQY0gwSEF0Q1BLTUc4ZVExc1BzcjZPSGNpTGcwbFE4TGhq?=
 =?utf-8?B?ZjRaT0cvWVJRczRXam5DeXpGOVJYMUFackdGRGhwRmJPb0Jnd0Z1M09OM1VR?=
 =?utf-8?B?d1JqMUpHcnVkQXRQcEp2MFh6a0xiQ0JSQVhQU0dWYkIrUTR3VTByRlJja2p6?=
 =?utf-8?B?Qzh0TVpncHZyS1JHZ1pUV3p0Zi9UU1VpTTNCMms4Z3JrQk9IUysyMmthcTNw?=
 =?utf-8?B?cmQwWTZ3WnpUbXFTa0pYUnpvOVZSWG5ZMEtiQThWWkRzeS9kaG1ITzdzQjQw?=
 =?utf-8?B?L3pYV1Y2MzRkckhhNCtlQlRvYi9PNG5YcHp0UjFwb2tZTE1TQWdJK2lZMVk4?=
 =?utf-8?B?V2wwbFJGYWNoanhhWkhheG1icnorS3NlTFNnQ2Y1a2JNU3owQkw5eVdPdlFS?=
 =?utf-8?B?clBSb25aaDV2VW5KNmNiNW8weVNRbVNCL1ZvQzlnUE1ZQnNwZlJEak85Z0hG?=
 =?utf-8?B?QitVTW8vT1pkL2pIY2tBUGE1SkY3d1FIVE11RkFHWGpoK1YxRENtOUZ6M2hR?=
 =?utf-8?B?V085R0loTU9ybCtvMCtpYmFXLzlrY2V3Z1lnaUhVUnVZdW9BSFZCelU4ZXh1?=
 =?utf-8?B?WCs4SDV0UDV3RFNZZFdleGlXbFY5bmtKajNXcFV6YjRCTFVWQUdsU01mVmFC?=
 =?utf-8?B?U1NoZzdFcmR2cXYwd1U2VEpvQ2JXNWRSVkFlQXIyUVl4U1h4N3kzaG1Od01u?=
 =?utf-8?B?QmxKcVZyTmlzSjlKR2g3amVoOUxiZUFVVG10L3lsV3hyTzlRaGh0QS9QUGVS?=
 =?utf-8?B?ZEEvaU9QaHh1dUlpelY2cnhLcCtKYmNsZzR0UnA2QXU3aFlrcnRTd1NoWkRm?=
 =?utf-8?B?OU1Lc0Nkb1pBcitBZFNBTHRBLzNuTU1Lb0d5TlJTSjVWYTJyd2ZrWkZ3bGJW?=
 =?utf-8?B?b2QxMlFMVGRRNUZpMGZaaktrZlZlaFdyOWdnNEttS2FiWWRTTTRuSHdWZzJQ?=
 =?utf-8?B?QlFkVTZ1RGUyK1h1UXU0emtJRXcyVFgwL002MDlBamFjcTJkU24vMk4wcGJW?=
 =?utf-8?B?cFk1K3lNK1c4NERjTGI0WWN0VWR6SDBaYjhHV0FPUEtJZXNScUY2Zjl3RWpy?=
 =?utf-8?B?clhJbUNYQzJCcHUzdFI2Q29DRDZLc256bTVYeHRJSkNabzJjdnFyeHRGZlBL?=
 =?utf-8?B?blI1YkUvR1lWWGhmRlI3d3czeXR0dzRMQ3duRzI4RlVzWGR0aFRwUFJXeVdx?=
 =?utf-8?B?NzhWeTc4aUlka0RvU1F4a3lwQVJtRTFtang3OVpYR1hnNElabmJCR1pGTDc2?=
 =?utf-8?B?cThOdklOa2JFbVBlNDRMWnJqWmtOQk1ZMW9FK01CdTRwWENXWm5TRkJsd0xE?=
 =?utf-8?B?eEJqVXN2bFJxWUdDUHJ4cVNQc1VnZm9SMFNHVHZ1Rlg4YXo0cm5jT3hqK0xn?=
 =?utf-8?B?dW5lM1NsakNGR0ZoaElXWUtVcHg2TVBsMW1NU0lGQWVaM04wZlRTZ3JjNjha?=
 =?utf-8?B?STVOa1QrZFh3NlhxSngxTUtJUXZZeU0zVktDQ3BOQzVjNy9NYS81RFdUdEhM?=
 =?utf-8?B?bllEeW0zWEtXQUhxbFlSb3BQZUc1RXdVNld0NXZDMHM3T0dabytNQS84SVNI?=
 =?utf-8?B?c0RXTTRnSFJTWGFXckhEMUF1NndJNmZ4Zk5lb3BWRlJ0c1A2anp5SVU1c01L?=
 =?utf-8?B?bHE5TlZDZ3NVSGlQVThGQ0RnSnFsVm9mWmEwTFdVaWJnUEMvZFBadXpRTklH?=
 =?utf-8?B?dGp6Zy8ySEN2UkY4aUpQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVLV3pGNEJkd2o2M01rTWtXNENsdFVUWkQzUXNic0tpVXVHWE9FN08zSmc4?=
 =?utf-8?B?QmhxbEJFSjc4TStTYUVjK2ZFRGYwem1YVlpFU3Y0MWRhMzlyODQvQzNjYlFq?=
 =?utf-8?B?eCtZbzlkTWRKTjFxOEJhbTRndGM5ckxXckFzcUdRRDd3NG9UaWFUOTQ3bTFt?=
 =?utf-8?B?WURYYUpkSTBiQUhrbXJvbjJPV1kzc1E5aUhveXQ5R1VsSnl0RnRLOXdrT0k1?=
 =?utf-8?B?YWRJSzNXNW5HaEpXZFl1NlBkWTFaL21Uem5pRGQvM1RxRDFnVVFiRE9BY0Rw?=
 =?utf-8?B?d09zLzNYaCt0WGdqdC9Fb2g1bWg1MDREc2s2VWwyR2xGZml3Vk8xck9ZbG9I?=
 =?utf-8?B?RVgxa01vV3NMVVp5VkN4Q0tNVUlLVnJHb3UzK3R5NTMyNCtmYXZWaGlyNUpX?=
 =?utf-8?B?bS9xc2lhVXVXOXlwMHhBUEpLQW9GWlhrV0FwcW90N3ptcE90U2tGeksvOE9i?=
 =?utf-8?B?MmtWSUNBS2FlbU8zdkl4aU4rRlhaOUpnNVRmN0pEZytvRHR5VDViUmtkRXZn?=
 =?utf-8?B?U0JCV3pXK3BUT1RXdFpHNXlSWmx0eDd5Rm1OTFBDem55czJRNi9MeWVhYktN?=
 =?utf-8?B?Nm0wZmk5OXprbnNabWZ6T3kzT2l4OElSb1VneS9MbVVVK0JBUFVrRkc0UU5v?=
 =?utf-8?B?MkRtekNVbVJ4TDl4RENYbDZvUkVCcWVHN1FNY04vVDNlZFJnZFQ5OTBiWllj?=
 =?utf-8?B?UUpSaFZjMjZ6ZUxSMjZSdTVhUHNiTmFMVm9iMG1oTWxjYzdTTlg5RVpsdFlz?=
 =?utf-8?B?S2dsWnF6VnF0U1NWY2NoRitGZnhXRlVObmtJY1NOQjVuWklXY0tWWTV1WFhM?=
 =?utf-8?B?VjUxUDdXYmxDTG9zSHRkMkhjOGNWSDJWN2toclpiaVg2NncrU09wRTZIanI3?=
 =?utf-8?B?QkhYaXNmdDdzVERlVHV0WURHUVlnaTFheTNIbWlnbmMyMjBWWHJtYUh5QkQw?=
 =?utf-8?B?eXB1Z1JoWFJQN2VudDROUXUxWlgwUHNyU0w5ZEVrVHpuSm5FblNmTWJzZ0da?=
 =?utf-8?B?dWEwbHlZZm03RmFUanVBTWdSTUcyNnN6WnFWU3JiM3d0NTM5eTdUVzFET1RY?=
 =?utf-8?B?dzR4eUcvcWNlUU96Z1h1bFhVSThPNkMrZldWQWRaaHRJc1M4Z2srckRTaHlC?=
 =?utf-8?B?aGREZStzRHVROHNiWnVEV1NDQm11a081TEMyTXg1Vk5oU1dGSUJPR3NZRVZX?=
 =?utf-8?B?bWpYQlE3QzNYNlI3bE9UUGFBWHpVdUxjQnM2Q1JNZ3hVTVJETmFUaTg2YjVw?=
 =?utf-8?B?eEQ3U2xJckZSd0FBYlRqeHl3ZTZhbEkvZkRFeHdSUHM1TWlOOWZIVmgybzlD?=
 =?utf-8?B?SWxkZFU4MnU1TzhCNDJWTWdiZ1VnUGJMWU5aaW5KNzBDQ0tOZWU1Sm91UTBX?=
 =?utf-8?B?OXpVcmdoL3EwSjdBQ2dvSXc2akFlSHRZZWFDaFZxbmVDVmJ4QmxnUDhIL2hG?=
 =?utf-8?B?b2U2U241ci9DbVNvWEEzR2lMczh2cjlEVm5nbStpcG5UcDk3dnF4QjBNTVJB?=
 =?utf-8?B?eE8rWWE3V3BLTy9kN2U2Sm8vS0lxWjRWNkY2NHJ0WFRld0lUeENBcVZyemh4?=
 =?utf-8?B?eUVJVkFHa1E0VHFKcC9JSm5VaE0xUjJyQmJEVkM5WDhSUXFhS2R3aktVMm5T?=
 =?utf-8?B?OVVIM1pkQzZlcCtOcyt0QjIyM2dVcFJIWEI1dkFTLzFWNG5vbndDZnVWTkp1?=
 =?utf-8?B?QjVUaWMyaUo4OG1hcWNqZ2Q2SE1WaUQwRnlNdllUSk55Q2QzOWlscDlDR2I2?=
 =?utf-8?B?a3JLVEcvSDN1MHJPK2JlUkpaUDVnb2tmb0o4dnZUK09FejcrbHVkbHA0SnRs?=
 =?utf-8?B?OUVFcFI0Rmx4RjZGSDc5ZlRVMUxZZTVTYkorZGpDaW9mbzJSY1RvSjJUMEFa?=
 =?utf-8?B?RC9LNXFhbkE5TExJdVJaVHl6VzN0Y2JGbDZiUXRaK284VVE1TjBxMzc5MDlx?=
 =?utf-8?B?cmNCUTNQS1Y4UGVienQxMGtjOVd5L0VjT2ZDc2ZXbU1nN3BqL3Z3bUlOVzRO?=
 =?utf-8?B?VDFvb2NoT2I0UDNWRm9POVBSUTlWQ1pnaWs0QXlZTGhaT3c4VStxZzFIN0Vn?=
 =?utf-8?B?eFZiNklhU0NUNzFZTVJKTW5ldHhZVTQzcGxyTVFXdFY2eW40OGkwVFdsbVNk?=
 =?utf-8?Q?9+ucJ00mXUASo2a8tERsTgvPp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e94fe68-4d5a-4ac1-f1b2-08dd19f21bf9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:42:59.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2udom1qt7CiqJr6gjxOOSSZxaajCchi7BUNHqf+hDDY2ImEpw49nr2S1jH54vYfTqudFoP3xZOqrjS7lqqFrfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6698
X-OriginatorOrg: digi.com
X-BESS-ID: 1733929138-105525-25731-8991-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.55.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGhmZAVgZQMC0xLTk1KSU51c
	zU2MA0JdnA0NAsLdHQyNg0ydw42dhIqTYWAN4uVzFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261039 [from 
	cloudscan8-242.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

2024. 12. 11. 15:37 keltezéssel, Vladimir Oltean írta:
> [EXTERNAL E-MAIL] Warning! This email originated outside of the organization! Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
>
> On Wed, Dec 11, 2024 at 01:46:56PM +0100, Robert Hodaszi wrote:
>> Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
>> absorb logic for not overwriting precise info into dsa_8021q_rcv()")
>> added support to let the DSA switch driver set source_port and
>> switch_id. tag_8021q's logic overrides the previously set source_port
>> and switch_id only if they are marked as "invalid" (-1). sja1105 and
>> vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
>> initialize those variables. That causes dsa_8021q_rcv() doesn't set
>> them, and they remain unassigned.
>>
>> Initialize them as invalid to so dsa_8021q_rcv() can return with the
>> proper values.
>>
>> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
>> Cc: stable@vger.kernel.org
>> ---
> Thank you for the patch, and sorry for the breakage. I suggest the
> following alternative commit message:
>
>   The blamed commit changed the dsa_8021q_rcv() calling convention to
>   accept pre-populated source_port and switch_id arguments. If those are
>   not available, as in the case of tag_ocelot_8021q, the arguments must
>   be preinitialized with -1.
>
>   Due to the bug of passing uninitialized arguments, dsa_8021q_rcv()
>   does not detect that it needs to populate the source_port and
>   switch_id, and this makes dsa_conduit_find_user() fail, and leads to
>   packet loss on reception.
>
>   Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
>   Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
>   Cc: stable@vger.kernel.org

Yes, that commit message makes much more sense than mine. Unfortunately, I already sent out the new patch. I rewrite it, and send out a v2 then.

Robert


