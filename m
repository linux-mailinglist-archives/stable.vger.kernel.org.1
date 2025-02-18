Return-Path: <stable+bounces-116801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21318A3A124
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788C816D0F0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AD626B959;
	Tue, 18 Feb 2025 15:26:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313C26B09B
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892391; cv=fail; b=IVRgYjE4BplxvW0iz8cH9fNZAJLJvuiA7UTyVjhYNHQ5YbXSzXjS1LTilvXfrlStErsHNcCwuEUQvUbD8WYWooGpgZEidjrFLSVZeua6kNqoE34nyntEJKd8ricM5gxETvRgzBIFTANKSOkvkg4VVuP4OEHPTS6anPKjCLXeN6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892391; c=relaxed/simple;
	bh=5pbt+SPJpBrsXw5832sCJKLSOR+e4SBPDo9k4CxcWQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aHfz/nClzNQcjZf5aAFloaHgZdq4eCMEgeRbhCqW/hF6jo/zTh52DVPWYFmyNF8sBAufiRMEu51Nk0/ZsAHiNhRLAfxH3m8b0NXSy6l218Ip6Hwe9gDASuN1/caT/LGfYMKwn9MPyBNK9G2VeA4hn4AaJiIdmFTO571AB9kIoQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IAsKZE001430;
	Tue, 18 Feb 2025 15:26:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44thw93637-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:26:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxDoEU1HMq94hS7D7pRo1OXpaUu6AWmjjh1HUI3XvhJhB5MfLRkXoDHcA+ONtedYQWTwS3+KwkJL3c/9ZMnanLBU410Qih60LJYKk7beHxyfWb0eAl5BYtIk3QP5ftdiaBgClBl76kVJOQJruMRzz9gsB+tmEgj613JPrKqohpgWK18jJsJUGzyo8CSHFcudoo5FH9K1ZyeDjZTGUmxaOzLyMO/QMOVu7TXLN05fLuo8XbHZRubdcSlKMZf6dtvyOWuUHGYS9e5u0SWgfRW7JW+N4+Bfs1FIJiSJY5EG/8DbpO0uNjf4UH9PIQPDbYKk4mXUF47YLjWK43mYou2/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pbt+SPJpBrsXw5832sCJKLSOR+e4SBPDo9k4CxcWQg=;
 b=gdPg/kXQfWPFL9Drue5dKaNjy6ie9CNiKMFU9QJbGdFyQMC5nZccN1gAEBbS1iKdfFq5iQmYhXEO8VU9HKi/9Anu8jt2JkYORroUZ9LlQRBQdRXBZSxW1/mSxSnZf1GleCPsUTx/ZO576UISLUPSFe9ZjtamOTNY+xVCvOqQ9IMbwE1JAIJ9Re4vH9wOxgKjtDCHDVMrLQroNPoaEZdboM4lAQ4ul359Epz+a63ySBjUc+mN55+5aOaYQC1049kcxpbZClmfwnV6Pu0YWqNe9LYjAcxFMTJBbEbJJ0j0hb23DavlxawppTeHxE1OHZLSIgArN1tm2DU2sOGBqwiFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 15:26:23 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 15:26:22 +0000
Message-ID: <aa07a60e-cd70-4296-a3f3-e0b35bc5eb62@windriver.com>
Date: Tue, 18 Feb 2025 23:24:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] drm/amd/display: Add null check for head_pipe in
 dcn201_acquire_free_pipe_for_layer
To: Greg KH <gregkh@linuxfoundation.org>,
        Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: chiahsuan.chung@amd.com, Rodrigo.Siqueira@amd.com, alex.hung@amd.com,
        roman.li@amd.com, aurabindo.pillai@amd.com, harry.wentland@amd.com,
        hamza.mahfooz@amd.com, srinivasan.shanmugam@amd.com,
        alexander.deucher@amd.com, stable@vger.kernel.org
References: <20250218061818.3002289-1-xiangyu.chen@eng.windriver.com>
 <2025021846-blubber-trophy-b77b@gregkh>
From: He Zhe <zhe.he@windriver.com>
Content-Language: en-US
In-Reply-To: <2025021846-blubber-trophy-b77b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e60f93-6c40-4bbb-eff3-08dd503099d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlY4R2o5c0o0dy8weHRTVWo5QUVjZFR3Uklma2ZvNHlIdVhBVG9jcUNYRUpz?=
 =?utf-8?B?QmJjUEV3NFlDWXkxaWVUclRCR3FDVXU1a1hMT1FkRG9DdzZZUGw1eVNPZnd2?=
 =?utf-8?B?Sk1rQllRZU1QR29UazhGbS8yNDgvaGlrNENKQmVtVVB0VnlPUklFWm0wNWhi?=
 =?utf-8?B?cUdaZ0Z4TTdTVG1yeUhVd1IycHhWaWh1YUVocTVWZ2g3dEFiTjFvUTNaeFU1?=
 =?utf-8?B?dlFGTytjcGFpaUZCeWdHU1p4djAwckhRYmlxNmtzUjNja2ZZYkJ3Q0VtR2JV?=
 =?utf-8?B?K2VYTzZkRXhUOGNyTVZlZ1pwbktIcXlxV3lSSnpWMmwwSnpjYk5iKzdxcmhC?=
 =?utf-8?B?REY1TmN3UzlGOHZHS1JPaDlTV3lGNmtTT29iaFRGSlpHTUdscjZwWklwcFJF?=
 =?utf-8?B?Vzg3QVVKQjN4NWFWR09FN0l3YzNkVmFqQ3hpL2RWMEV0NnJieFJOaEl3enZK?=
 =?utf-8?B?MEZCTDFkeTlzTXl2U3RzZmJlamI1WUlYNEZ5eno4b1lpMkpXbmd1MEhYQlNx?=
 =?utf-8?B?eUVJMVVlVk01WFlqYkN4TVJTL0kyNkVyYm80bDdJL2xUY1VQTm1mVmhZYjAx?=
 =?utf-8?B?dWRQVU9WRDBtV1JzNWdxNHl3MHA5RVRYMDIrVTFFdFF3QnZ5UGwzNElMa3VT?=
 =?utf-8?B?Zk0yM2FMMWtpSTg3YThEUTFINklpVDNGZHNDWnQzVVBDL25mZWY3WUdVSzVN?=
 =?utf-8?B?RXJ2anZDNzlVd0czRFMrWEQ4ZTltcnl1citDa3RZWnJEK1hJSGJvOFRTSU1R?=
 =?utf-8?B?aU9NWVp2b1gxZ0JKS1hlOW4xQTd3VEtDbjM4VUM2NmFDWitBMk4vblc0NTFU?=
 =?utf-8?B?dEl3VGswWFJ2ZHJPTXVrSUFlL3FqdFI2cnRJMnErUlZtak9zN0JObVJoZWIw?=
 =?utf-8?B?bjIzdEhYaUZKcENVZFFjeVhCS0x3azF4L3RVYmxuTUhwVDhvTlhGTDRYQkx0?=
 =?utf-8?B?dlM2cTRIZVFKcFlkUzEvTS9NbElyM3REWFNQRXhTdXZLdXNSRjJDVzZKVm5W?=
 =?utf-8?B?S2xMTnJxVld0cGlndTlpNzVJMkFVVldaZVgwWDhLakdtUkFMalZBVTV6RHF3?=
 =?utf-8?B?cXc5cjhrKzlNVU5WWTd3MHFwTW1JTm5yc2JoZVpqbEcwanZ5dVY0OHdsWlVi?=
 =?utf-8?B?SlN3MzRnUWRpVHIzK21SMDlrdjhmdDU2QzRnanNBVkRxbkE5QTJ0K0RjRXdF?=
 =?utf-8?B?TjRKT0NIcW90cXJNM2dRblFpZzJ4SVJCSjRtaWJubnp3QW4zRzRvQi9OMlRS?=
 =?utf-8?B?dUl3cUtPeEJ0OUhRaE9pekZWTXFWM0QzOWRRQnRWZWFvRm94VThCRHM0Wnoz?=
 =?utf-8?B?SFQxYkZ3cHZMU0pxaEdzTmZHcGg4QXZodlZ5d1J3clhwZGJYWG9xVDRqWlZr?=
 =?utf-8?B?aU9scC96djZvZW92MjZBMzY5VW42V3g2ZTRldFlZenVqNUFoNk8xQUdsYkFI?=
 =?utf-8?B?QlhlV010dnY2eDlwL3BQbjVNN2hsOG1KS0JuM29kMDR6YmpSQ0Y0S045T3Ez?=
 =?utf-8?B?eTdxL3VROE9BYWd3NnROaTFyRlRJUHh0WnBLZU9BV2xOc0dmYkU0Unk4K0xo?=
 =?utf-8?B?UXBYckRjemFuQ2tLTUVzRk85SGh5OEk2Um54dnEvQk11TjRnTDQ0SHo1bmJ0?=
 =?utf-8?B?RXV5aFdZRlVKdXFtaTl4N3p6RVE5Q2Jxb24zNTNmOWxKdnkrSkVwV1B5L0F2?=
 =?utf-8?B?a0R1TC8xa0hmY25UUkhTSWpWUG9qUkJwSGpiSDkrZ0VYaU5pNkpUU3lKWjEz?=
 =?utf-8?B?dXhkYlJvV29Bb25VOWxCWCtidHhHTDRBMFVTSWFEVVcwZ0hjNzhHaXhlYzRN?=
 =?utf-8?B?UlJvazlxUjVuY0FVSnpBKzF3TGtlMm5ENXJOeUF2cU8rZ3RwYWtPZXRqRkpx?=
 =?utf-8?Q?6UPGnkat/ehb5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zys2Wm5KQm41UU84QmVTOVgzVDY2dmxVY1A1UHYwc0ZoZDRiLzk0QXZMNEVx?=
 =?utf-8?B?NWVwcmxlakJ4NndOV0FHRjkxeFExanZFZGVUM1poYWYrOWVxUGlsK0FJUEtI?=
 =?utf-8?B?Y3hpNlVpYjR1cDhRZEVzVXFhaHc3MlNsVDJJOFJSWnNkc3g0U0xSSnRmTnpH?=
 =?utf-8?B?aW9XQUl0Ym82SzZiWWdBblNER0loSHROWGdSSnlOUjNMcmk5dTM4dUlSV2lp?=
 =?utf-8?B?WXMrY2pJL0o3THZ1eWFBTmNSTHdtS3dHR0hxSnhwNDM3WHFacVJSRFJkbFJK?=
 =?utf-8?B?bmFvN3FldXdwckNBdnVvbkU4RHcybENEYmxVVGQvbkJSd2l1dmt0a0xscGN4?=
 =?utf-8?B?bmd2VG45OUlpTGRTVm42SzBtc2lmWndGcDlHOXVSUS85NkxpWTNjZDg4WEd3?=
 =?utf-8?B?SmhWZUhWWUdtWi94MVZ0WXlEN0U0NnYrU0MzbXVrdFdmZmZhTmJHYWJjR3Jh?=
 =?utf-8?B?YnBZSGY3MnJocC8wUm5jK2ZGWjNvcnMrZU5EVUttYU9Bb2pobUtlLzY1blVF?=
 =?utf-8?B?dG9ObUtDUUFkLzE1L05sWVdySDkrQWtGdHpPQjIwQ3ZDS2RDdDNPVWVrdC9P?=
 =?utf-8?B?Q3RuanIyY0NGME55bDBSalRwUTNwalRWeWMrL1J3RkRRQ1cwSlBYMUM2d3ZY?=
 =?utf-8?B?RExxREFFeHg4RVByZlZGRUVPekVoVjV2RE9Jdks4SzdJc3RndjNwbzdlZ1B4?=
 =?utf-8?B?eVpzNEFNRzEzWVBkaTdLbUNHRGNUWnd5MTdSSGJSa21ENVVOVG85dzc5V1g3?=
 =?utf-8?B?Qm5LK0QvZnhia2pYZVRDbEEwUm5kNWdySUZ3dHZ2SmxLM3VpMjNieVdLZjFY?=
 =?utf-8?B?UFRvYXRENWNlUEZ4RlpzK1djeTRJZGgxNnZYSWRNeWNTUTYrOGI1amFMaVlo?=
 =?utf-8?B?OGJ6VzdzcVEzbUJnOWJ3ekEzN1g0ZVVaKzR5N2hSTWxpYTJNVk91WEJRWnBx?=
 =?utf-8?B?TmdzNW1QU0xiazhDSEkzVmFiMHQ2Ym8xcmZ2WGZHeHFHWHpyNnVXemhkNFAx?=
 =?utf-8?B?Vm5FbnJXclBycnlIaGlBUFZ4OUg0SDREZTBkN2F1djdwckR5eVQyMlVXS3NZ?=
 =?utf-8?B?dXhxMDFrU1c1UUIrWk9WbWRJMkxZUk1WZG9ISW13TGthU3RIWEpkNEl0ekQ5?=
 =?utf-8?B?bXNUcFNVWXNSVTNybmlkNVVtRnpMbnlleGdzWEhaUTNKOFQ5VDRGNFpBRjhu?=
 =?utf-8?B?M2kzWVhzVWJoSmdJM0s1L0dzSFhiWlZKeWtaUDI5b0xOYjNablhzU2hzMnA3?=
 =?utf-8?B?aHFNdDhPZHFXWkpvTVByNFRZaG16THBtL1dPbW5RL1JWTE5FMFBpRzU0VEZM?=
 =?utf-8?B?WW1ubWFKRzJIcHVVQzRhSTZlTUsyZ1ZwbFpYTGQ5TTEyTnI4RkNCNy9tM2kw?=
 =?utf-8?B?RDlKUDh0K2tHVnU1VDZDcGRXUVNXbGROWURpOGhzVlE1YzNHL2hYdmQwOFNP?=
 =?utf-8?B?RkZCcTgxLzM1NFBPMTRXYnZTLy9ITnRsWEJiSmRDcmhzMzA3ZzA5OWZHSGlh?=
 =?utf-8?B?eFFGNTcvT1VNd01NR1o0VVdOQ3pRNWpTbys3dDhiVnF5b0RYelBmb1dpUW9F?=
 =?utf-8?B?VWFEYmlyKzJnSE5MQ0pGeEkrV25EallsTHMzS2dtSm1HWjRzeDc3V095Mmlm?=
 =?utf-8?B?TE1nYWY4c01QYmZHZHZBQlRTUFZCbnl3OERnQllldEFSSlBUV21vZXN2cWJH?=
 =?utf-8?B?cjBZOHZuQVNyMXJ4WS9TeUNiQWo5RDlTQ1pyRVRPdDFTU3MxQkJTWlFFSjAx?=
 =?utf-8?B?LytlcVU3eFRnNzdaNnczQ3NZWmNHcU45Um5VRkJINjJZaklPRXlKNnQwY2F2?=
 =?utf-8?B?MHdGMytIWkJ0UXBxOWhFTlBzWkhLSDJ3RjFUVjJlZWZOZjBObktTcHI2RXRw?=
 =?utf-8?B?ZzRjNmtiekRKZys4WnNhRlJuK2RQdmpvd0JtdGRwbGtBMmN0TnlpVHcyN2VU?=
 =?utf-8?B?VzRiNlNwczFWcmZzUXNzN1hsSURKdmZ4cGd6SUQ5NWloVUZSRGg3amJJQkVr?=
 =?utf-8?B?bDVnS0FkTlRXOW8xa3FtOHUvUG80cCtiZEo2OWttNG93VEYwWnpwb2dIaEVQ?=
 =?utf-8?B?aEFIQUFHQ0FiZHVmelgreVJKblJLbHZ4Y2Q3dVc2SUhvSVJvMGJ2TWNMUmcy?=
 =?utf-8?Q?BJfPAmlRw9N1cA83wFfeMqa/1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e60f93-6c40-4bbb-eff3-08dd503099d9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:26:22.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP99dk3HFAYSGSCkns3mtRWTyU7T9iK7viMe5FDOB4ai9Dy+4eNBCXwgXMYhIhA8KZO3N5m6C/CDQpLa4XSg0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-Authority-Analysis: v=2.4 cv=CZzy5Krl c=1 sm=1 tr=0 ts=67b4a6a1 cx=c_pps a=19K1aDEwnJ0RahI1emVHDw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=bRTqI5nwn0kA:10
 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=H2C-XesUw9nqmVa7ZsAA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: YpOuVSSzCygDgqLVqcDOUmZ0jutE3yCO
X-Proofpoint-ORIG-GUID: YpOuVSSzCygDgqLVqcDOUmZ0jutE3yCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=757
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502180113



On 2025/2/18 22:59, Greg KH wrote:
> On Tue, Feb 18, 2025 at 02:18:18PM +0800, Xiangyu Chen wrote:
>> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>
>> [ Upstream commit f22f4754aaa47d8c59f166ba3042182859e5dff7 ]
>>
>> This commit addresses a potential null pointer dereference issue in the
>> `dcn201_acquire_free_pipe_for_layer` function. The issue could occur
>> when `head_pipe` is null.
>>
>> The fix adds a check to ensure `head_pipe` is not null before asserting
>> it. If `head_pipe` is null, the function returns NULL to prevent a
>> potential null pointer dereference.
>>
>> Reported by smatch:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn201/dcn201_resource.c:1016 dcn201_acquire_free_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1010)
>>
>> Cc: Tom Chung <chiahsuan.chung@amd.com>
>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Cc: Roman Li <roman.li@amd.com>
>> Cc: Alex Hung <alex.hung@amd.com>
>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> [dcn201 was moved from drivers/gpu/drm/amd/display/dc to
>> drivers/gpu/drm/amd/display/dc/resource since
>> 8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
>> The path is changed accordingly to apply the patch on 6.6.y.]
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>> Verified the build test only due to we don't have DCN201 device.
> If you don't have this, why do you need or want it backported to
> different stable kernels?

We provide a kernel for various customers to enable their own hardwares and
develop their own software with. Some of the hardwares are from certain boards
that we will test the kernel on. For those we don't have, we have no idea if
there's some customers who will use them anyway. So, we just try our best to fix
as many CVEs as possible.

Regards,
Zhe

>
> confused,
>
> greg k-h


