Return-Path: <stable+bounces-88135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6169AFCDD
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 10:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F33828386C
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331D1D2B02;
	Fri, 25 Oct 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3/wU5Ano"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F701D223A;
	Fri, 25 Oct 2024 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845810; cv=fail; b=PT0/Ylm2CFNmlB2li75DOLZRNmSW5ldPI5RhXB3IopKLh8LgqHUIkW7RCkbpDh3Onj6vivkoqRu5q8x0VkheYALjwFs2X2+cT/TwG2iJNc8FfjLpgmJnVz3ndHxPo+liBm5igOjoAGA363tOq7+ZEaiYBpp2KGQEM4Yl2f6Hr8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845810; c=relaxed/simple;
	bh=ymdbaG1ZTYnR2ByX/DI0xn/ROFYCg1bDrTbDsvKCAXA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nGbm2htJEdNAXGU6j+sMCOrHpY+WJlQ1j+EIuBOH+9Dp/bVgSeR9tt/AJSqPQ1iVp63/ES0JedW/FvCIf4LhucBXQ6FAon94ZK5G2YpT/FdjtLQ5CO8cXaknQshuxcQTUIoErpB4Jy4ioYdMeJWQnyeswKmhZCKZdv4hOLetGEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3/wU5Ano; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdeRcUFvnX/x9EpxqavqoNDC0VE1vffXbzSkHfRYCUvUBDZfiCp5DQRPSzYAA3qWsuEYHpnjSPUXBdrbXj+hEjra3tgX/ODxRb8cszys5muuP6Gw6bd3eveiKisZdzkoA+GuzE6z308/hGZS0/uS2P/1V40PKEbjCGXPE0rHNIzy4BBAXQa4lOraZUZxDbwPavmH6zoQ60F1I49kbITugsL4s4Q5V9j1ur0mq9RR9bDZ/EQuyWkZPnOpjv7tavugtVN+Fx56cwEEjdQ9DoVPx1KEUbumadbDdiWGgy0tg9gc1VOsIIleH1mL9Zh+ukQo/Vff0dqDEZ11cCdasCuMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymdbaG1ZTYnR2ByX/DI0xn/ROFYCg1bDrTbDsvKCAXA=;
 b=wUdhm2zzQGCYacidbcgzwfUV9FbTCVmDYyCWBInzOSULJ3WZxl3sZ9Ch8hr5nGje8CjyAJEcHC69s2oee0yfYZatgpeZ5kZrGGFmBE2KGICkJ7y7oH1QhfYu6Uv9ds5dMbMDmbUjlF7AdD9QYfteq3UvRWyxl3Bqx3yPWMzoPUHowyGhPm69rnWi09tuwVfyacAm0JO6iWuX3mVflxkX2gfcBOC5/SA5gSpcCP08lkxoWEBCRl9k9ripas6hu6xs27uIAnZBMpku+1p5CFl35E3k9P28x3vIRNfdJOiJBNYYArpQ609JlDK3RrjX1wYuKoHGgiiXqiLN9vC6kJZBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymdbaG1ZTYnR2ByX/DI0xn/ROFYCg1bDrTbDsvKCAXA=;
 b=3/wU5Anokvuv0AqXMZamu7/C/BSUCXmgBqWNOve0250ey4nqIaUlbbza+ufa3eFEXpqgnBKsXAgyUckS4uuw/huyLX+KWSM0zJtzr9VrrAKggENko6J6i0oOF/6W6mmANqVQs2H7FbAOoBlY0jY6oKiUGn93/8OiBoMtzAcOUUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 08:43:25 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 08:43:24 +0000
Message-ID: <825d7456-0c84-27fd-c89a-891545290931@amd.com>
Date: Fri, 25 Oct 2024 09:43:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com
Cc: Gregory Price <gourry@gourry.net>, stable@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
 <00e03abe-1781-b2e3-62f5-97897093eb5b@amd.com>
 <671a769c8adcf_10e59294c5@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <671a769c8adcf_10e59294c5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fd8d36-bd17-466e-b442-08dcf4d1168e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NCtnQ3VDY0hVd0ZNNVJwUkd0MVhwcFgwT0tuci8wN1YvWEs4R2crWkVGdzM1?=
 =?utf-8?B?RjB4SlpyeGZyNEViT3Z3QkR1UkpTMy9GN25lcExkekxZQk53SjRIb3l3MG1i?=
 =?utf-8?B?eVBzQVIxc0xiWlFGRGRwbkxzdjgrM1lINnlCaTVXQ2tKbG9sQ3VqQXpHVENM?=
 =?utf-8?B?bXZ2UDQxR1FNK2duMGV0TWYySEk5OXc2dE5YZTBoMTRsc0Z0MG9Hajd4OVFQ?=
 =?utf-8?B?MmpZbllNMUVwclMwTUU4YmxwdVo2c2xNanNXVWFhTThDc2ZxMVY2MUhaVGd4?=
 =?utf-8?B?TVJRMjNReGk0aldoQ24xejc4Y0ZWb0NQTTIzWmxOOHhnN0NUMHFGMnVRb29E?=
 =?utf-8?B?Ni85OGp5NTNJQmJEY1VMZnRmZDZXczB3MFpuUXhwMnhmQ3dxNHQyRFk5cndI?=
 =?utf-8?B?M211M213NGNzY05lcXJMcTA4U3FMUTE4NnpMVEVCakN3WHBrbWxad3VKbTJS?=
 =?utf-8?B?T3huNGhKcVBqUjc0b004d3FIck4xWGd2RjFBSG5kOHYrL09RZjVta1ZqZ3Jp?=
 =?utf-8?B?cUNhbllwbGI3QnRPbkNweG1kOVlOc0k4QzdQdFluNjNNcWtnZXFUcWsrajF4?=
 =?utf-8?B?Nzl3YmNJTUlvRVFIQmovUGVXWWpzeFl5dU5UVlNYYWZxRlJjZlo1T3BtdEV5?=
 =?utf-8?B?RG9XYUgxcFBBM3FUTTZyT1UvQWozWXNrZVhJc2ZiTTFuYjczUnRydEdPTlBt?=
 =?utf-8?B?VGNPdER6a2VRQ2RuZ1E0WUlzeFhJdXNzQU5LdUZNODEzY3orL1B2Vno0Y244?=
 =?utf-8?B?bGFZd1ZvejBDa01SeDdNRUREalh1S3Q4bExaOFliVkw0VitiZ0RFb2NObWhH?=
 =?utf-8?B?K0psTitwcUdrOWhxZWxBelZJSWxwWFNOcENDd3lLSGVYd2d3R0FOV2tCSlVS?=
 =?utf-8?B?SHlkV2dTZ2ppdU5BZ3puR01KcUw2cmgrSCtXRUR0TVVJRUtLOUEwbWJqeEdV?=
 =?utf-8?B?SUxZVDNycXFxbWJGc216Z1k3eFAvQm1rWXRTNGo4TE5NdzNhVmJ5bUdLOWdh?=
 =?utf-8?B?UXRTVENaSmpBbjUxN1pQOUVLY0kyTll3dERYYys4M3AyM2lPWkxpcnNPYml5?=
 =?utf-8?B?ZWl2eGlDb0htOCsrY0lpWmZFZi8xajJIYTFWTVlZV2RTeXphZklZQW9rODFD?=
 =?utf-8?B?aE5tUGxMRExPYUhVTXFQekdXN2VtZlMvWWRIMXpDaXI4VmxpaUc1ekd6dHYw?=
 =?utf-8?B?djR1Vy9hK1hoQkp1eUNFa3NURXhVdkJRdk8yVXRnL0tLYkZxRDJWYmRPN0Y4?=
 =?utf-8?B?WG8xUXdCZUxEWFJuREpKQUJjcUd0ZjRBSUY5eXh1VlBveEhwZ2wveUVPNXla?=
 =?utf-8?B?U3dkSjBJYkQ0TUNiZ2djK1ZZZXdMYThPQ04wSUNGdjRuY2g2RnFMRVVHdVpv?=
 =?utf-8?B?NEZrTSsrdE1URk55WkplNnV6ck5YYmlYZEtseGJNcXZ3dlE3U21LVjd0Tk92?=
 =?utf-8?B?VHVUQ0pJdGxxTDZOdkJIb0ljQk1aa3F5bm81Zkx5ZXFiZ1FZMnBySzdnS04r?=
 =?utf-8?B?eXZ2UG5sZkcvZjFzOGpXMWNUOWZVa2ZTdW1TY2RsNjdONW1yclNoRnJXcGEw?=
 =?utf-8?B?ckhiejRpZHdSTEJwYUtsNmpGTGlRZjh3L2hwYzVXMWplckg5bzdYSU8xNU0w?=
 =?utf-8?B?SVJvczF5VTZGWXEvTDZzTkszM0pha1ZhK1ZpL2I0Y2VZcGgwcjdmZk1RaUhH?=
 =?utf-8?B?amVIL0VqQmtqYmtUTVVURXp1K1hEMHNzL0krVkJKZ2Ezak9jMlNkLzhlbitT?=
 =?utf-8?Q?L1SanJJ2+u6oj8ng4ZNMgoTgmz+iVaUY5Acuys5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0huei9CS3VQaGp5ZUlWd2IxL21kLzNVRFl0SkwvcURYTjBaUmh3QlMxMXRW?=
 =?utf-8?B?UnFkSjBlLy80THhYS0NxaXVwUTFLeUUxMjh2dU85V0NmcXNmK3huc1o5NktU?=
 =?utf-8?B?U3R1MlZUdVUrYnI4MGpUVVl5Smh2SHVrM1IxK3NUQ3ZLa2F2czgxV2R0VytM?=
 =?utf-8?B?LzVUcDNubjVXNERJZFdVbHIrdTZFWHZEb3hqcXNLWkhKc2JMYUZ2RmNFWjdx?=
 =?utf-8?B?b2RXQ3NVN3hQRm41dlU3dElxV091aEt0NGxMT3grY01ReUtoK2JQR216VFRF?=
 =?utf-8?B?QmppTW5NZ3J3a1VXbi9lNkVHckxvL2VHSWZ4cWxDSzNSVlM0Zmo4bFdxaHh0?=
 =?utf-8?B?QVhvRGZjSWd0OWlKYkxUaHd2dTJ4QzlBWGdWYW9LeW9VZHd0OHFFVll3UmIx?=
 =?utf-8?B?TlprUlk4RGwxNEp6V1RqYVVYMkNxL0VPc0xlT3lCYW1aSUZwK3Y3N3ZtS2g4?=
 =?utf-8?B?LzFhOUp1OE4vVDZiVHlMK1NFQmEvRUF2WWV1NzB5RlVNK05ETHNiNHg3WjI4?=
 =?utf-8?B?eThWeTJ4TWdxU3AzL2RLQ3RTbTloaTBVb1pXSmFUcER0a0NvR0dzRTEyeXBL?=
 =?utf-8?B?RzVMZmxtUnN5TjNBR1RLYW9vY1NIbUREaTNCMU1ZdmxKN1g5eWc1NmlPL2Ra?=
 =?utf-8?B?RFJXY2loWTN2ZTZyb2s4ZklQNlBWZHVnRURiWnlKWUd6ZkI3WEZOTlVxOHdL?=
 =?utf-8?B?cWZoTEM2Nm0wY0FSbWovRi9Ld2VJZWFCSEFnY251RlVUWERmdTkvU1drYWQr?=
 =?utf-8?B?dERKenJpanRWWTF6cHQ5L3hqMzQzb3Bxc2hCK05ONGx6d3BZUnJIVWZaOU8y?=
 =?utf-8?B?bHUydHU5Vm9JanU0Q2N4ajdjb0xua29Mc3lwaTJQem5CQk1QTnpkd0RwdDds?=
 =?utf-8?B?M0RtZ2RmOXRLVGdOM0Y3SWthNmE1VC9SMWI4VzhSV2owYjdmY0pkRzB2eEl1?=
 =?utf-8?B?aXBhY1lQOGFVZ1lNQjZ3THVrRExXc1BwRmNleWJUa0k2dDVqK0M0UGRTczhB?=
 =?utf-8?B?N3crdS9tWVZJc2RLMHdIS1FzZ0NsZkxUMHYrSUtXYUp2U0J5WGw2aUJOOVdI?=
 =?utf-8?B?VTBWNEpIU05icVAvQ0pvMXFZa3psdS9OcWtGaDNGeW0yYUxibDdqQjh4SW1p?=
 =?utf-8?B?SHl5dWE2TzJxUFR5aVR1RXREQ3p3bEtYUlJqV01NQ3d4M1ExUmplVkp3bXJw?=
 =?utf-8?B?d3BCSHpiR3dmSXNEQ1MzNDZTeVMyRWtQYTN1TllUai9PVUc2YUF1VUlmcEhJ?=
 =?utf-8?B?UllQQ1JKRVQzQmgwYkE4aUJiUGlaQnVQSjdKc0NRSE1yd1EzSTBGeStFMUUz?=
 =?utf-8?B?MjR0YVgyK1kySE9mU2ZJc3BkcUZJREkrWW1NRkNJeGpRdld6Y250QW1qMkpy?=
 =?utf-8?B?aFB5em1XQXFtVGZpdGFlc0JLRXBoc0d0MDVTSlozaFRWTzArTzNIcFVsTlhI?=
 =?utf-8?B?ZVlZS2JITmFEc0NmeGRGd2hsZWZ6dHp6T2VmcmdEc2ZpUHYrS0F5bnFoQzJH?=
 =?utf-8?B?bUxja1Y0RDZkS1BpdmtQd0RUOHdWOUg0OEI3RVp3VnAvYS9EaXJ5ZlhwQm1m?=
 =?utf-8?B?R0FNdTgxem83REhlR3VUS3E2K3dMY3BydS85WmxXMTdrMUNaVlpUMzdPOHFo?=
 =?utf-8?B?U1dKN1pCRWtkYmhJZ2NpTXZPTlV3dXVQVHYvZERnQWxDczNGK3FESHBUTmVs?=
 =?utf-8?B?K2V1YVpmdDIycnhvcTRPOUpxZDhHRnpUbnRZQ2tHVHRXTTNsUHMwa1didStp?=
 =?utf-8?B?ZS9xbHNxanliTTJZUGp0eFkzSHpabWNOcG1BR3ZiRzdyaG9SVG9LTjJDQm1D?=
 =?utf-8?B?ajc3dDI3amtoSzBsemN6YXI0bUNtUDh5N21YN0VTWFlFSEZna1ZSSTVWK014?=
 =?utf-8?B?SGVTRWV2UUJ5OU11MCtUaTJDWWVpY2RXcUlVQU10d09WazhSalR3cUFiV2xR?=
 =?utf-8?B?dGpielZvUHVRUlRNcW5ubnM1d1VlWFlFN2FicExKaVFXQ001VkxtM1VySm05?=
 =?utf-8?B?TmZLWUtkRDF5R3ptVGdja0dYOWZBbTlJQ0RheitXUDNDU3FyNWVtYzMxd1hI?=
 =?utf-8?B?OXRpTzA5UTBEMWpUMnkrQ1o1OGZTOElkZEs2QmR6QU5FOVNHM25NRmNHYWxp?=
 =?utf-8?Q?DfRaya+5WqzRO+YBsj7xcUCby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fd8d36-bd17-466e-b442-08dcf4d1168e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:43:24.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiPThkQOzwPNrIT3fqK0h1xBBFoT250+RLWAhs+DGD3w396RjeFt7Irr46Fuz0TRQ7syEXioX9UPZKqwP94wYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531


On 10/24/24 17:32, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 10/23/24 02:43, Dan Williams wrote:
>>> When the CXL subsystem is built-in the module init order is determined
>>> by Makefile order. That order violates expectations. The expectation is
>>> that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
>>> the race cxl_mem will find the enabled CXL root ports it needs and if
>>> cxl_acpi loses the race it will retrigger cxl_mem to attach via
>>> cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
>>> enabled immediately upon cxl_acpi_probe() return. That in turn can only
>>> happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
>>> before the cxl_acpi object in the Makefile.
>>
>> I'm having problems with understanding this. The acpi module is
>> initialised following the initcall levels, as defined by the code with
>> the subsys_initcall(cxl_acpi_init), and the cxl_mem module is not, so
>> AFAIK, there should not be any race there with the acpi module always
>> being initialised first. It I'm right, the problem should be another one
>> we do not know yet ...
> This is a valid point, and I do think that cxl_port should also move to
> subsys_initcall() for completeness.
>
> However, the reason this Makefile change works, even though cxl_acpi
> finishes init before cxl_port when both are built-in, is due to device
> discovery order.
>
> With the old Makefile order it is possible for cxl_mem to race
> cxl_acpi_probe() in a way that defeats the cxl_bus_rescan() that is
> there to resolve device discovery races.


OK. Then rephrasing the commit would help.


Apart from that:


Tested-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Alejandro Lucero <alucerop@amd.com>


>>> Fix up the order to prevent initialization failures, and make sure that
>>> cxl_port is built-in if cxl_acpi is also built-in.
>> ... or forcing cxl_port to be built-in is enough. I wonder how, without
>> it, the cxl root ports can be there for cxl_mem ...
> It does not need to be there for cxl_mem. It is ok for cxl_mem to load
> and complete enumeration well before cxl_acpi ever arrives. As long as
> cxl_bus_rescan() enables those devices after the fact then everything is
> ok.
>
> The problematic case being fixed is the opposite, i.e. that
> cxl_bus_rescan() completes and never triggers again after cxl_mem has
> failed to find the root ports.

