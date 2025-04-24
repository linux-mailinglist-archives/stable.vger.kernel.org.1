Return-Path: <stable+bounces-136542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61803A9A77C
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 11:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F393B6261
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A785215160;
	Thu, 24 Apr 2025 09:12:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966F214A82
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485938; cv=fail; b=LUi6+M+mD6KoR4aiuDYvEvne3ljpT7iya131uWTzqIuas7F66SOo/bEuB5Mrbl8gOeeLe8yEKnbH4dzaFOuH4XH/1/NrFgPW1KA/QZiI2UueztA/G5+mKf/NvJ4CtmAZkFpeV7nd/3kjVI8KvomLb3g5P4Ax/XKsQpFQGNqkhiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485938; c=relaxed/simple;
	bh=0IkPjZzZrCC2TbpU/pLWNPuyTiPysgPfu0M1pGm7LFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zxnhu6jKzHAK34nfVwxOSwdQ+cGNSBVu+8g/hpdoxxQAqlAj/AkxmR/6XRFpVJEOOAKIk70LzhkOpBLH1HwOaip2RmVdSNwngTK68SYqsT5pVwl2dLMqBb9rEvvN/EMLMmzmygDAbGPGMG5TEVonW/7Ao6crAllMk7HCbMGx4iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O4x9Y2009852;
	Thu, 24 Apr 2025 02:12:11 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhat1b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 02:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6bdkhYEmnu+iXXbT5ADfA2txCiRfDCqESs5Lu1CvTHNKyTRjXQ1TOZ34uQyVOs1q/NwxN1NVCkbsTG7gachFIDCIdT5JRfTP+p/G6txkwW9ynlwmKeYUsZb43Lw7G2yB4SLa51lgrOVBYuihDdkUfIbkl8GVSyf8GryBXqj77wUp23/RQGNcvhIBzIR3xe2NQxgiMoc6PQAb1U5rMK9Yq4pK7OXElKprh5ygb+pEo5EOymmJKmnuvD3LL5kgPAqNDKy2gwWVdnlR7uDlOIrDqGfb3W2HX7Q5gEfskI1qpvguDodne5ViJcLK3zp0hGaIH8Az9au0kYkSFPLAVaDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itDCLZWAqw/ng+hlCwyTO2hcLXy0x+3z4TbEEpDNmfw=;
 b=WzIv9Di23bwMqrqlLD1bb3GCUSC2GbW/RMYY5w2vzoijJHewmOMddhqz9IJ/td8Sqdfy3DFodEM3ZPt9sVs8rueHAJozviOGcmz3Wn5onsn62/gyA0C6eNiBohufmR8QQF7vIARzMC3m3QKffPCLJ3XwHjlZs+pUY6iPUXCCwj3DKfpM8pNen/qmVemwYm7V9Y2dlL5GFwoduWQvRW/6b6kCX2fJamD4WiSX4ARV9JMXq8nuMdqVblGEesCy6xaoOuJLCuN6S/pQCL8yqgOkfWtIj0nXpZytyh+sUhymXYiXPTL5ZlTkjeLHHZwGuCLHiJj7TnvCF1OI/XDLJkTN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 09:12:05 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 09:12:05 +0000
Message-ID: <9f0549c3-fddc-4a12-aaad-b043091c2f71@eng.windriver.com>
Date: Thu, 24 Apr 2025 17:12:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] perf: Fix perf_pending_task() UaF
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: peterz@infradead.org, elver@google.com, stable@vger.kernel.org,
        zhe.he@windriver.com
References: <20250408061044.3786102-1-xiangyu.chen@eng.windriver.com>
 <2025042351-glade-swimmable-97e2@gregkh>
 <741b7850-9d5f-469d-971d-c2548481651f@eng.windriver.com>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <741b7850-9d5f-469d-971d-c2548481651f@eng.windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0205.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::6) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH8PR11MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a27774-c2e3-43d2-9ff6-08dd83101502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0grM3VzblhEeEw4NlBycDg2R3cxbHQwMlQ2KzN0MFBFcXpyMjRodnN5VkJP?=
 =?utf-8?B?TzdRNXhDR0lpNzRIL3VZbFZyRG9hZDVpaXpJdWFTRXYyOHQ3bkNPYmtFRkF0?=
 =?utf-8?B?bkxhQm82dTViTnZiNllTNDB3djk2WmFpUDREU3B6MXdLK1d4SjBLR3V2cGJh?=
 =?utf-8?B?UVdhNVR0Mmx0b0Z5UkJtczEvNWVpYS9HWi9OdHNiQm1WK0llL3I1NWtJTjBE?=
 =?utf-8?B?M2RjbnZrK0FYQXh1WGF0VHEwNHFyOXNsVGpWZTNIL0xqMXVBU1lFdEp6aG9j?=
 =?utf-8?B?WWRpdytVQ3MxUG8rWEE2U2Nvcm1JazhWaXJBNEFlT3NiSzIvNnVzV1k1UDZJ?=
 =?utf-8?B?ZG9QcTRweHRRaDFnK0VpTXFjVkxRUnl2V2F1UkRyL3huU2oxbUhaTnl1VVVG?=
 =?utf-8?B?TDFMOGhybTB2RTJuTy9oWTBzN00rTzIwWkx6ZkREdktDYUlqbmxJMjZrUmgy?=
 =?utf-8?B?UWk4TW40UUR1MjZod2xvVnB5bXpNUzBPd0tSeUk5Y1VuZmZOVGZjT1RGbUpF?=
 =?utf-8?B?V1hFYlZOcy9iRzJ5UWZ0a1ZjRSsxaHFjVlBzSC82Ym9yY0xSZ1hwTTE0OUcy?=
 =?utf-8?B?dlZoRUVoQ2tkLzFUV1p1VlArUm1sRURDcmVKUmwvbE5ZV0hPdlV1M0c0MFlY?=
 =?utf-8?B?OGh0V3B2NjBlYlM0SFlQdk5wTUNmSmEvWEJ3azViSjVZTWZTdjBxMzlxd29y?=
 =?utf-8?B?eGFKMU5lR3l1V21zRnQwS1EwNXpNaHg1NlJCYk5QZ21YSWpGTlh4VUx4MTB5?=
 =?utf-8?B?Qnp6NHdkUUNqVXZ2WEY3ZDNnWjNBbVJ3eUlScTVLQzZSWjhyU1BUaktpWHdk?=
 =?utf-8?B?QlozV1Yxc1JCTTRjeFBaV1NxUDFoeDljMHd2bmZFL3daMlZCK1h4V0xabTZZ?=
 =?utf-8?B?NHJlTk1CV2hmS2ZadUhrQ3JaLzl4QnIxZXczam9ZZDkrc2RKTXllTFRPeHBx?=
 =?utf-8?B?N3lzSWU1bm16eXRjaDdNSCtlS1QzalpwTklsdGdpZGF6OVVLNVJqTkFCS245?=
 =?utf-8?B?ZEh1RkJyV29Ed2cvQ20rNWpXYU9WMndiL203VHVGaDI2clVFakhBSjlqZGFS?=
 =?utf-8?B?bnA2ZWo0b3dLRnRBNFVXSDNYdkNzV0Z5MS9LRG9KKzJ2d1N3R0lud3ZWZVdJ?=
 =?utf-8?B?YTRkRk9WeDhreUNmME5iU3pEbXZXUkFCZER6QVhsdVEvdkpLQjkzSVEwK0po?=
 =?utf-8?B?NGhETW9GT0QzRlltM2E4UnFlemc2VU1vUVFWVkFJRXBTRXdFZU5IZk1FOXA5?=
 =?utf-8?B?S0d6WlBCeXFPejN4QWdJQW84a0ljTlk2VXNlQkJDZjlGWTNwU2FlK1pJdjhK?=
 =?utf-8?B?ZHU1bE82ZGpXb2t6YzFONlNRSnM4SHF5TURVcjgzanhpNGlWcTVxdWcrVFlS?=
 =?utf-8?B?WXdxVEE2NWNrUjh4Z01FZVdzazFLdk81clVzeWtnZE5nWHhON2NWaDdxZnN4?=
 =?utf-8?B?dzdqZDBEWEwvTkZmTU9VN1dkaWN2NFZPRkIvdjBPR2x1Z3pYRGZwQ3JYVEp5?=
 =?utf-8?B?RlQyNHVFVzdKZFNhWk1TM1FOUElYb3p2L29YcnFZQit1RnZCQTh6SkhYVmFr?=
 =?utf-8?B?NjdyS01vcU0zdFl3cDFHdnFzZFBmeGJJQ2xpWm5rS0RBRkNhaEt4Q1NXaW9L?=
 =?utf-8?B?Q1U1S3JCMUs1UzBDalZFR2Iyd0dKSHlEWXpKcCtxRTlzMHdGSTkvcnVpTE1i?=
 =?utf-8?B?SWJFUTFkaDByZGx0Y0EyT1Bic1dJQ0JEWnF3RVhqOUxTbFdJemt3bW5QTlRI?=
 =?utf-8?B?SGtSZG9JbE01WWUwTFlqM0R6SmtiaExjRHBkZkRTVW1DdDcrK01RSFJJNG0x?=
 =?utf-8?B?SGFESlVGWDg0TmVMY1kzTTR3ZDF3NmNrL0pLNDFtKzdoc0xNbmNPOHI4YTJj?=
 =?utf-8?B?Ym91MFhUVnBjcXgzRDF1bkg4a2VuRFNyd2xocWI4WE0vaG1JMzB4L2JDZUxQ?=
 =?utf-8?Q?NNl4oeTr6Gk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUR0RXJMUlhib1JFTVZhYk9OQW1vdm1XUUdqYzV2LzRScUdid1VPblEzSlo2?=
 =?utf-8?B?TUpxYWZyVjlHQTRCR2QxbTBJWVlUc1hQdzJoRi9UWUJsK0VXcmE1d0xnUHBp?=
 =?utf-8?B?VVBCM2l1ZER3a2dmQnh6elQxYXNNdmdOVzZQbDJFVFZNUGZKZXlBVGszMEtt?=
 =?utf-8?B?TC9obGRsbjRPZjBGcWh3b3A4dWtodDVHSHMybmUzMWd6Q2ZMM01nMXNHR0VY?=
 =?utf-8?B?aVZRNmZDTzNkQ3Qxc1pxVGlVejVUbXcrbUtCMzRGSmVyZUQ4M3lBMGFEalU4?=
 =?utf-8?B?YTB6UU4rUlRYUVpuZjUrQkY5bGs2TGtNODJORlpSaGpuWEFUOThIaFllVEJP?=
 =?utf-8?B?YU9hUFozY2RLMm9VNml0d1dvUVNKdHhLUXhSQjdZdHhMV0FWTTNPVUI0S2dI?=
 =?utf-8?B?MHV0WDNRMDNPOUdCM2x3ci9YeVBpNHNERTJPOVBZM2JhTm9sNTk3a2FwZnFJ?=
 =?utf-8?B?OGVKTVl1Nlg1Z2ZDZG9Mcnh1RisxTis5cnUzb1lTcGRCbGZib1R1cHVwckky?=
 =?utf-8?B?SS9MVFBuekJKTTlKa2pneEQ1T3hrMU9uTGxXYjFyMk10RDUzZjh0Z2hnVHJM?=
 =?utf-8?B?cDRGUVQ3ZWpqTGdBdDMzUUtpcXZ1YnRJUDJCc1R0THVnQXNYSnY1Y3I3d0Qw?=
 =?utf-8?B?TDhlYVVjL2k1WUl3YVRuSnpKVlVJN1IyNEdiNlNndGlGU21tWi84V3lDMVBq?=
 =?utf-8?B?V3J6dWo2VzVsMTdBSUkrdG1SdUZpOGUxK1JnMEVuMmJLUzAyV2s5UU56N3o3?=
 =?utf-8?B?Tnp0K3lRSkdocWlOK0NvOGlYNitWdUdRNTNZSVNzcno3UkNxQStuZVYwQXFM?=
 =?utf-8?B?N0xrUzM2NXFwcldYUXNLcUowbGUrMHZWckhtN0lRRExRSUM2bktqejNZUWFM?=
 =?utf-8?B?cFpMbnBQU3F1dG55NXZWVGVJdExFZDBnVDRyYUFYV0pvWWtJdktqd09RT0M1?=
 =?utf-8?B?R2NBaHovU1B6alc4dWpRVHhNQXZsVVdVMVBKSUZPYS9sZG5XU1U5d1BGdXVD?=
 =?utf-8?B?a1dtREdHMzk3anBHcFZlcHhTaW9mcnUwc2VjZ05FeFpjeFA1UC9lc2lrdzJh?=
 =?utf-8?B?YWpFdUF3bG1MMXhZeExlZTlaK1hzRUpUNGtUQzB4K2ZJcGtHZFp4UkhrUGxo?=
 =?utf-8?B?Z2IrZHUzTEsyaWVvZERiSExUdVh5UlBmUm51czhlbFpNZklNMnRPUUFHMXRL?=
 =?utf-8?B?dGtHTW1DejNQbExXVlRqQVI5cjZGbGE1NTEyaDIzZTloMmoyUHhqMkk3QWp5?=
 =?utf-8?B?RitVamZLZTNBZDhtYzgxY3ZidHliR0NqZm5jOXVGM0FrRlI0VTBKbFdocGZ0?=
 =?utf-8?B?Q1JuVWJCcG9tZFNnYnplUUQ5aUFuMk8rdEIxaS9mV0FQbXY4Vkk5Zmk1SXVq?=
 =?utf-8?B?RGFtVFpWMk1YZjdVOW9XellxZStqMHh3dlAwRFI0dTJNK0d0QUY1MVdjekpY?=
 =?utf-8?B?R1B0WlpxUjg0MFRmQnlDanFsOUtXcS9WWU9JUDZHbVJGWnU3eXEvV0F3M2xM?=
 =?utf-8?B?ZTVDMXd4UGRCUHdveHlJMmU4bGphVjMrblRoczlRajlESTR5UTRrTGRSaTVl?=
 =?utf-8?B?Tk90WEFERFd2V0dCUnVPcnpOMDNveU44Zy9QTTZxb0h2S2FOSG5TdDhNWkVR?=
 =?utf-8?B?SzhMSVpHaExpNUV3UFh6cmR2TVZGWXhSRFYrTDdFTFlEYUIzdWN2c3ZlWDBs?=
 =?utf-8?B?bCttSm5DUWljQ0F6MVdyUWRhRnVJeVFsSksvR0NNcVJPNS9JckQwMXVyRCs2?=
 =?utf-8?B?R25JZmtrM3VjMlVwZWgxQmdGRG1oYmJSallrMm1NRnBwRkZKSFBtRFB4K1Zy?=
 =?utf-8?B?c2NuVk5xVHJEdjRvdFh6bVplcFZ5TlV6Y3Nsc0dZVGNkcTF3RjloMTkvQkln?=
 =?utf-8?B?YUIzazhJMVYzckk2UzlrOCsva0lKM3NJRkJxU0pnVTgxNEI0NDB6ZS9mZ3RN?=
 =?utf-8?B?OTRISXJjVkMzck1WU0hOMXRZbkRJbWg1YVdXeVN0NWZwS296dFA0ZWNtdXFJ?=
 =?utf-8?B?WXBWc2RKVjlyVUxoTFR1eDZxTVdKY25XU0JXZzZpdytPN05uTUxFN0pTSnZC?=
 =?utf-8?B?Vzk4c2pSZSs5M0grQzU5UU5hUDF5MWhEZlRLVjZzUFF3bXNncWFiV0FtRGlj?=
 =?utf-8?B?TFZFbjdGb1JQQjNodVlJSGNpSzIwenRNeVNodEQ1UEdyeGhDZ2N5TG1YQ1FW?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a27774-c2e3-43d2-9ff6-08dd83101502
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 09:12:05.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcWjLW4bwKEJsT8jDjs8xpf1V+FK4eZW/Hoe8uwqSv5YdMbCLDxPrl89OQ9/UQaQlwH4jabmqyv1u1SeMvzhlR6/n/6ipoi6ufSyUtHFCUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6879
X-Proofpoint-GUID: qFdWVU5lDKd04XRwZNfy7Giw6vebFUaC
X-Proofpoint-ORIG-GUID: qFdWVU5lDKd04XRwZNfy7Giw6vebFUaC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2MSBTYWx0ZWRfXx0tXwxp+Igjt B/oS/pbvDtVKr7fWePwcYd56WSp5IKyT4O0XZDaB6ZZ1ZFYSLjDctu/gUUa9hphV4b0JzwIXWgl wDmxRyJbqjoAav61EfAdJ/Jl8jogZmswGSYwU9A6jvxr1bzTzDRPv1/ed889T3nlUiz/buynTub
 f4m8c7E6Um7bXkanDWymOoEv5zJsc0aiO9x2urQBSXAbQhZ3qN8jW5KIRH6N+FF+VEG2/0U3y27 X8NjH+yn88rZDOLfXP3e/BqSf3j0EcBoHFOdGHH07/8ej2ZaJ6FqxN4RGy+Bq+Y0HyKz4dh6iQp kulD8Py0L7ZlUOLjYGb73IhdRXDWyc6gFfq+sUlJZ14w/agIUDvgGKOoy04mxt/4bLBoA9K/iu0
 qg2+val2n5KwwtkXHZahtUecFLsvOqPqLgAbqsR61S0ReA0lwXlsn7aHgMYjGpCtNwJRBPMq
X-Authority-Analysis: v=2.4 cv=Sa33duRu c=1 sm=1 tr=0 ts=680a006a cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=JfrnYn6hAAAA:8 a=hSkVLCK3AAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=EgjA6SED1V3569uzDyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504240061

Hi Greg,


After investigating the follow-on patch,  current commit 517e6a301f34 
("perf: Fix perf_pending_task() UaF") needs

to backport the following commits:

Commit 3a5465418f5f ("perf: Fix event leak upon exec and file release") 
-- Fix commit 517e6a301f34

Commit 56799bc03565 ("perf: Fix hang while freeing sigtrap event") -- 
Fix commit 56799bc03565


For the commit 3a5465418f5f ("perf: Fix event leak upon exec and file 
release"), it depends on commit ca6c21327c6a ("perf: Fix missing SIGTRAPs"),

but commit ca6c21327c6a ("perf: Fix missing SIGTRAPs") based on Commit 
97ba62b27867 ("perf: Add support for SIGTRAP on perf events") which is a new

feature intruduced since kernel 5.13-rc1, and the new feature changed 
the perf_event.h in uapi.


Fully backport the current commit and the follow-on patches too risky 
for a stable branch, so please ignore current patch, that

might cause more bugs for 5.10, thanks :)



Br,

Xiangyu


On 4/24/25 14:33, Xiangyu Chen wrote:
> Hi Greg,
>
>
> On 4/23/25 22:15, Greg KH wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the 
>> sender and know the content is safe.
>>
>> On Tue, Apr 08, 2025 at 02:10:44PM +0800, Xiangyu Chen wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>
>>>
>>> [ Upstream commit 517e6a301f34613bff24a8e35b5455884f2d83d8 ]
>>>
>>> Per syzbot it is possible for perf_pending_task() to run after the
>>> event is free()'d. There are two related but distinct cases:
>>>
>>>   - the task_work was already queued before destroying the event;
>>>   - destroying the event itself queues the task_work.
>>>
>>> The first cannot be solved using task_work_cancel() since
>>> perf_release() itself might be called from a task_work (____fput),
>>> which means the current->task_works list is already empty and
>>> task_work_cancel() won't be able to find the perf_pending_task()
>>> entry.
>>>
>>> The simplest alternative is extending the perf_event lifetime to cover
>>> the task_work.
>>>
>>> The second is just silly, queueing a task_work while you know the
>>> event is going away makes no sense and is easily avoided by
>>> re-arranging how the event is marked STATE_DEAD and ensuring it goes
>>> through STATE_OFF on the way down.
>>>
>>> Reported-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Tested-by: Marco Elver <elver@google.com>
>>> [ Discard the changes in event_sched_out() due to 5.10 don't have the
>>> commit: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
>>> and commit: ca6c21327c6a ("perf: Fix missing SIGTRAPs") ]
>>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>>> ---
>>> Verified the build test.
>> You missed all of the fix-up patches for this commit that happened after
>> it, fixing memory leaks and the like.  So if we applied this, we would
>> have more bugs added to the tree than fixed :(
>>
>> ALWAYS check for follow-on fixes.
>>
>> I'll go drop this.
>
> Thanks for your info, I have checked the full log and there is another 
> commit to fix current commit,
>
> Please ignore this patch , I will try to backport the fixes to 5.10 
> and resend the review to list after local testing.
>
> Thanks.
>
>
> Br,
>
> Xiangyu
>
>>
>> greg k-h

