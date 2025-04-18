Return-Path: <stable+bounces-134531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D99A93239
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF7A3AFEDD
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43024EA8F;
	Fri, 18 Apr 2025 06:46:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51EC19F40A
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744958812; cv=fail; b=a3atpLLJXUyn+zXagRol+1XO8f/XdyX1qnKQx8aOc2Ay0aZh/4Pg9etNRN4OR2VVvyoOLPGIOMy3aoFZsdLSuKwxxQ+TxjXX1DcR3a6TnEBJSdfZt0wxyHe0zsAaG82b47o2P7bZBLbgIs130Ut6g0JxlGAh43Wa85zSkg2e5R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744958812; c=relaxed/simple;
	bh=PsaAEUOxHGMfjWJBDV2CjuqmxZPQ3Zixjwii+JAPSjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1PCTwsJTLLMA8lnxVzjzsQE094c1LHHG5xS5UobKMW1MC0oNZO8Oxo6xpgoE1u9Wj76GomjRBp82SH1eTLGvNBPCYfgS/9pZV37rWnMFY9SmHrnC46pdJri+voaDwqOYD1ikyvzH05PkcHrMtbtjGn+VZ+lbCEtRouR42YxO9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I6PTOj006626;
	Thu, 17 Apr 2025 23:46:36 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpkq57r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 23:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYPAkiB/imiFNIUPuU5u5BMMZQ0Xyq2wILT7Cicu5U8P8ABVRx1zjQ32p2pHPDnS+nHuMyxdviFQX5LuHvyf3BmEIHRK436kSn3sid3RaD79fpG/38m67czUw4w+4lZ0NcZtddmbNDV1J5Afy3pQT07Rif3FIcqN1swwjSOjNAgmPRK4lLX2dELYj/IRJBSXBsFpRBMs091KMZZKu0Oi3W9Dzg1U2PRjxCHBR2mx5Xz26p0JOcrqqVK6EkA1+PIWlWJX+jWh2ryhGsolH8uOzRYAzCI/dOYzmnArPZnMV+3jdYRh6WJp/Qd+m0OqU+Ut6uoFbb/UdRTRfa8ByvkQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynUG+l8zuwT+FXyXJ4RT7NvKM63z3LgCTgsq3m6ZKcE=;
 b=h6yO8vGfMTlVyV2UUG2Fssl96MG1n0bWmVgie8BQUi6IcODt6ve/8iiH7YoQ65ZLtdF2WlYrd5USE63uxi+hK5qjTtt+JfPcQHEICYKQve4ShEaWSxD+g/AGK2M38fCMJYtjnciN8p2kvLVLGkRdGLtRVAVVIRr1u/iZ+S/5lLJbuQioO6KX6/QhCGh15hiSLgiU/feEL43Qhg7ddIUWNQSO41/Fc2HmFNppGmyOg7m9T956ZFrszmu99FN9u1LklF5GuCSvtHL1Tpn4gagwD21ZxVhBEEK4/5HTR6SxMRWRdu7+DpCfbzCQROFOPmRDx3Q5QDWoWSmppKlV8xGk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Fri, 18 Apr
 2025 06:46:33 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 06:46:33 +0000
Message-ID: <5e274450-5024-4201-918e-71b8986d9f36@windriver.com>
Date: Fri, 18 Apr 2025 14:46:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Question about back-porting '8be091338971 crypto:
 hisilicon/debugfs - Fix debugfs uninit process issue'
To: huangchenghai <huangchenghai2@huawei.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, stable@vger.kernel.org,
        qianweili@huawei.com, "fanghao (A)" <fanghao11@huawei.com>,
        "He, Zhe" <Zhe.He@eng.windriver.com>,
        "Bi, Peng (CN)" <peng.bi.cn@windriver.com>
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
 <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
 <bbb04362-c67e-438e-b15c-85da61563b0f@huawei.com>
Content-Language: en-US
From: Cliff Liu <donghua.liu@windriver.com>
In-Reply-To: <bbb04362-c67e-438e-b15c-85da61563b0f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|IA1PR11MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc4d25a-0274-4e7f-e32b-08dd7e44c1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0ZGV2xTZWlxWVlEY0hUWTJtTjhYc0Z3VmRkZzVOeWtqWlZpWHVGRGpibitI?=
 =?utf-8?B?VkhOR0FJazl4d21hV3lJbElIOWhUM25qRUpnaTZqQlRsTTlBRkQrZkhFQm9m?=
 =?utf-8?B?TW4zUUNZSjRUTjdHdzdDYjhaWmdZSWQ2emxrRldRUFhybHl3WXBlVXdJNjdB?=
 =?utf-8?B?RFdPK0wwMnU1Rjhwam01QzU1SkE5cFlHZUswa1dTdUNCWXBpc2NEcWF3NXg0?=
 =?utf-8?B?UmYrcFliRkR4ODIveExxM1Q5d1VOM0EzRjRIVVlYMTRHSmdmV24xQWxWYnNV?=
 =?utf-8?B?UTRnRmNVM2xDVW4wOG9UK0NIbHNZR1plR3N0OThiZEw5Sm9uNXpEL1BnZ2w1?=
 =?utf-8?B?ZlB5dE42bVVOUWtVcDRPY1ZEaENHZXIyalRnVWpqOGdyeW5DV1ltVW9CMXZP?=
 =?utf-8?B?Ty9aTTZEL0NzTGlkd0ZnSGNXSVUwM0ptSGJkZFB2YU5xamZ6Ynh1clduZTcx?=
 =?utf-8?B?VEN4Ym1KMzhFTzFJRFNrTWZBSmNQYStMdEQzM3NqVDdEK0sxQitEVnkwcUt3?=
 =?utf-8?B?SjNVOGE4NWk5ZnMxU0ZFS1pLVTNTL3FrK284UTBWWVF6K2NMT1pGTVdMN2dE?=
 =?utf-8?B?eEQxcWNkcFJKaGVWSE0yNXhCS0RhYytFTmFkZ1ByWERSaHZrdnBvdXJDcW5X?=
 =?utf-8?B?cWJ2YjJjUlAyT092ZjlyOVZZa0d6VXZtenRlTVcyVU1YT2xZb0FLWG1mdHQr?=
 =?utf-8?B?TWw3TVpPcUxkZ3VFWDVTaDY1KzIvQjYwVU9LS2FtYUFyZTB6WFJ2WEU0anky?=
 =?utf-8?B?d0FWTVpkQVpYdFFiVm9EWHFhdXZMWjdtNDFWN3dwSWEvRG15RGJKLzVyWmYw?=
 =?utf-8?B?bHUzamg1akFtc1JlQ3N0QTdUK3N2WkVQUkkwNnlHMW81U2hEaHJITHBzL3g4?=
 =?utf-8?B?bnFJeHZVbU53WFJIWS9FRkdiWVdQbEcxaFZSQVpHY0w1MXN1V1ZKand0UnVE?=
 =?utf-8?B?cEM5RUUrbjNja0Zzdms2aW85MmtsZm5waytONXBidnQ4T2YvSTh3MmRDMHZR?=
 =?utf-8?B?cVNqUVZPQS9BdHhlR0xSTjk1Sk5VQVIwdThsSjNrNTAzMzR6UlNHbG5YbUN5?=
 =?utf-8?B?Y2dwNDFCRXJoZVZhVnpVMnplRGwrZDBMaTdLYWxnZkFqdS9xYStMdE1ZejRz?=
 =?utf-8?B?cXNhMWYyaVZ4MU15NDM1Y1YrY0NaUDVYNUYzZXBHKzhVT0RvNUlNOHpUQlhK?=
 =?utf-8?B?a1pVSTRmR1hXQWg3M1Z0WElpUElXVDcwK01OdkRYTG1pRE5haGpTNzRsSWw0?=
 =?utf-8?B?VEN4UDdTVU45WWdyRVZZWDBPK1VVdktPQXRsaDlOZGFDODgrZDlzMkttK0ZC?=
 =?utf-8?B?aTBzOU9HdStlTWdnRG95d25PQi9Sc295aDNSZExmTEdwYWZOOEFpaFpObmxl?=
 =?utf-8?B?a1VHT2ZIaklrVDIxUmFrOHJCRHlQbWFvZDZkL09rSTNzbHJPOFRHOE9iY2J0?=
 =?utf-8?B?K0xWVlROY1lNSEZTd05vMDViR3pBU1oyUkZDNlY0am53STQ3MDhyLzZnTzIv?=
 =?utf-8?B?dmtMS2FUU09LOG9OaEM1NlhtdVdIRmUwZEtFOHlmZ0ROUHg3T3JNMkVVdTUz?=
 =?utf-8?B?bVFacnByNW1BdjdvTEYyV01rSmdxZ0l5ZjBpZjVGSXBBcWxKNEwrSGdkWUc5?=
 =?utf-8?B?LzZQYlo4NDdJdGsrdHcyYXQybG5uNVlnZWRKZUQ5N2NaM3VMa21rQ3hrNjI1?=
 =?utf-8?B?YnJrZGxzWlZOTjhlT0psQ2poWXB1L1dWZG9Vd2kwMjlFV01lalpPT0FXNjFN?=
 =?utf-8?B?VFhUOUh1NW1zZnNIVEVUbGhlbVJWbWxZZFNneDVUY1E0YjZ1ZTcxT1FQU2sz?=
 =?utf-8?B?UXM1NU1tWHMweDUzeDJ3dU5uMWsxMDhXcGpvYi96TUEwNExMdFl5dXpHQ1BZ?=
 =?utf-8?B?Ni8vcDBPVW1CbkNNWjlWWHliYm5xL0ltNXBjejFGTTJOOFpUcFFHdXpsVTlE?=
 =?utf-8?B?YTRyTWhDNGJ6anpFc096TktLSHlCYjdiTHNuWHNVZGdNSjJYMExuV09JSmVQ?=
 =?utf-8?B?OGtxWVlxQXJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXlYSzJNSVFTOXV1QXpucUFnTTRQL3hXT0hwbjN6UVBHZGEyVmNPRjB6UmRr?=
 =?utf-8?B?a0E2SjJ6bGVzMmMxUGtHOXhicWJxVUMyWDBLd21zYUZGTS90d2w5WE80ckt0?=
 =?utf-8?B?YU5kczkwNkZtRW1CZFlZR1RsdHhVOFNsaDdGRDJLbzA5QnpsRmorY09oWUtL?=
 =?utf-8?B?SjlzdVdwOHBIYWRrVjhTZEF4dW9UaTZzMVZjcjgzbUlscFNyWnduZTVSL2tJ?=
 =?utf-8?B?ak83cFFoV0ljWFZtOVRxNVVnZkJNUW5ubTFucmozMCt4L09EcjlXVEVjK2dG?=
 =?utf-8?B?aXliUTJDY1NZckV5NCs3cmd5eUxzc0FuMHFZalpwaGszdldCZEpNNStPajlV?=
 =?utf-8?B?UWJscjRoaGlMZUIwZ1haWW5MWTMxZy9vQkIzZGRHZUtxMTd5Q2RzaEE3ZTRP?=
 =?utf-8?B?SVVzT29ldUJmT09BVkg5UGR6WnY4VWV5LzY5NEh1b3IydE5mRkZMT1pzVUtF?=
 =?utf-8?B?ZFNWMUxsa2dKTEZMODBIbmZLMnM3ZFNLclkvd1RSUFpHTVVqYm8vbFZmclJs?=
 =?utf-8?B?MVg1M1JieTlmeVZJVGFwRmJ2cHB0QkZvVHBMQ0poN0pKUUZ0eUxYQ202Skw0?=
 =?utf-8?B?VlhZQTVzVzAydlFGRkdwQUE2TmgrcGN6VGdGaE92bHFUSUk4Uml4SkRBUk5z?=
 =?utf-8?B?eEdDdGRHZEovS2hGNG04eEttVk9RZkVScUFWdlBTTllxaTkwT0JSK0VFSi9j?=
 =?utf-8?B?NzNIc1lRUG14SmN3Zkh4dDcxTTkyNURSMFkyTmNXT2w4VmhsZU1SallqRENC?=
 =?utf-8?B?QXFVc3g4Mkc2Tyt1Mzg4LzRBWFVpQ2xaRFp5Tkg1UEVQL1Fsbzd0VE1aTFNy?=
 =?utf-8?B?TjJsK2lpYkZ1dkh1NDQycnYyOWN1ZFFWdlhlSUJyMmNWNHJ2N2hac3N5RlIv?=
 =?utf-8?B?OThjTzIrOVl6dHFMR3R6ZEFVMzBRbnBSN2VKaWJRWUZvN1V4amFqZDJNb0hD?=
 =?utf-8?B?UFMrMUpZRW9PWEM2azJDUXV6b3k4Q2R1YXNhMzAxQUFYeGtVSXpxeWtabWxs?=
 =?utf-8?B?VCtEVWtSVmpqVEFNV0hGdm1nNjRSZ0lGWkJ6dnZzdG9iazRwVWRMYUZubzdo?=
 =?utf-8?B?bUlvUTlzYkh3c3ZEMGhsMGZ2aFpqaEVzTXBDMHhMQ3JqaHNOaSt2a3R4YzNQ?=
 =?utf-8?B?MnRjNzRpQThwVlBPc2lOaHhGVVg5REhKcVlsTFdPN0FHSzUyYVUza0dzVFRS?=
 =?utf-8?B?c25Pc3dXU2hqZnArZ3J5VXFZa2tBN1hXQnM2TXBRaWdSQ3RaYkRtSE9Mditl?=
 =?utf-8?B?MXBSc0Q2SHFNZ2NFejc4K1JMemJUbzNOU2ZGRThoS01xY213RXFjR2tSRDZu?=
 =?utf-8?B?L0IvT3lEODV4UnJBSGM3SmJGZ0dteTB4cEs4bVhTODlJZ3BOOUJuU0tkK2V4?=
 =?utf-8?B?TWFHaFlPM291MlUrTWJjR0VqQzdPYmdOV2JZcnBOMVpreTN0NUk2aTlTbG5S?=
 =?utf-8?B?Yk8wem9laDZLMS9WbmRJSDVEY2dFUEo5S3NnbUxKalp5R1Z0NFdnSi91TTU3?=
 =?utf-8?B?V0hGU3UvYm9Vdm1hVVRwdnJkUkJiSHB6b0ttdzRzc2lWVGt0TmI5Z1ZrZVlK?=
 =?utf-8?B?MTRhNlZ6enBROG9oNHF4VlcvLzhuekZUNytqamlxYlJEMzZkc2VGMXg1cG5k?=
 =?utf-8?B?Q0VsdFNibnNQOW1jeTJWOUZEQ21udHBGczdkZjlGN3J5L2oxZnI0YXV4bVZQ?=
 =?utf-8?B?dGtWWFhpbGJhdkQrdWxuWGNHSkdCRVpYdUxNUTEvUzVzQ2Vac0tKOFFPb25n?=
 =?utf-8?B?Y2wwT3l6NjBNajFWcUNYbytGNm0vZkUzb0E3TjQ1ZFp3WjdONm9EN3hGbWZT?=
 =?utf-8?B?SkxlSFRJSm9peGJWMXJGWFpmcTZaUExzb2RwNW44ZFNSUnpUUFpWYnF3cFlv?=
 =?utf-8?B?cW5pTENaU3E2aHJKZEFpaDdDYlRUaG90aWUwb1ZvcFRsVW5rQnJ6b0o2Qlpz?=
 =?utf-8?B?TzRiUjhrNk9yU0VCU3lrWE14S2pUNGExYktZMm8weWYrSSs5NWQ3NjVqb0p2?=
 =?utf-8?B?RWxjYlJ5Q0J6bHVwSERGODJmcjRHQmNUMkgvQlZHM2tGbHN1cEk4czY3Rnl2?=
 =?utf-8?B?RCtvclc0VWpPbUxMZXBBZ2w2QmFCdWJIUnJ6Qkk5cXpwMStMeFpxNHg4L3ds?=
 =?utf-8?B?Y3dZbG9TckQzWWZpZ290eThuRzNRZjRxeEFkS0JYK01ISGJhdXcyTlViQjB3?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc4d25a-0274-4e7f-e32b-08dd7e44c1a2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 06:46:33.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQnSFpx5VuYYaovpx2uBJnXZllHYmCLMM8c1pEBKNUQIfvx9XWdyGSa8ROYq7itNQUk5i3A6rrG+LuAaRkeBwt7in0F0G1Nenu3wJfOVbSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
X-Proofpoint-ORIG-GUID: dk_Ku6ax7t4v6fzGj3xDKjbtz9n5FnYu
X-Proofpoint-GUID: dk_Ku6ax7t4v6fzGj3xDKjbtz9n5FnYu
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=6801f54c cx=c_pps a=9T78G36u1E64A7MtQSounQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=q1bzhA5_rk0hHByROAsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504180048

That's great.

And thank you so much for your opinion and effort!

   Cliff

On 2025/4/18 14:35, huangchenghai wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> Hello,
>
>
> Sorry to reply late, I checked, 5.10 and 5.15 do not have the diff regs
> function.
>
> So there's no need to fix this in 5.10 and 5.15.
>
> Thank you for your attention.
>
>
> Thanks,
>
> ChengHai
>
>
> 在 2025/4/17 14:51, Cliff Liu 写道:
>> Hi,
>>
>> I think this patch is not applicable for 5.15 and 5.10.
>> Could you give me any opinions?
>>
>> Any helps from maintainers are very appreciated.
>>
>> Thanks,
>>
>>   Cliff
>>
>> On 2025/4/8 15:45, Cliff Liu wrote:
>>> Hi Chenghai,
>>>
>>> I am trying to back-port commit  8be091338971 ("crypto:
>>> hisilicon/debugfs - Fix debugfs uninit process issue") to 5.15.y and
>>> 5.10.y.  After reviewed the patch and code context, I found there is
>>> no "drivers/crypto/hisilicon/debugfs.c" on both 5.15 and 5.10. So I
>>> think the fix is not suitable for 5.15 and 5.10.
>>>
>>> What do you think? Your opinion is very important to me.
>>>
>>> Thanks,
>>>
>>>  Cliff
>>>

