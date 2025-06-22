Return-Path: <stable+bounces-155241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30960AE2EE1
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6638E3B5741
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79891991CB;
	Sun, 22 Jun 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="juMV8EBr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tcl9AyNZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594BA47
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750582246; cv=fail; b=i9G2FLr5yj78hBpKVoAvpryXacEpcVsfGfROLSI53QpfN8lQA0bQeNUlO5HZcqw+CTOZYbVS2hBnc9/twKOk8IyfoFNhjb9lOKE+hVVWEpT+d9M80zevwseCobJMXJ1KYEvM614KGLlV/0MePuC5x31Cw220noMeqxzp6m6q9mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750582246; c=relaxed/simple;
	bh=PTyDTa1nTcMlpDc7ad8rMvKOT/h39aRUt9U6z/rL9NU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1KKQhYbe0J5AhWvRbR81/zIrGtWrtlHdNlyE48zlHTJEX2AN4wsqYIe0e3PyEgNkcxu92RJzSl3mGRwP2XLVoaF4RSlyiiEXqQ3j3yosDueHqfP5zUnBhxO7cPkfQ5usimeOdeWXH2lilktpTYczE+YA3Pk/MjNPudokZj+CXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=juMV8EBr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tcl9AyNZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55M4JJnG031862;
	Sun, 22 Jun 2025 08:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/qhlyp3iS0/dY5DEN+bIyOda8tpj2w1nNWrRo3ljqe0=; b=
	juMV8EBrv3kWsvRo7+XZIYFMFJd59nbKyF/2c6WJKOPReb25FIsqeTTO8tKmfFsi
	GWd/R5aBy8vyVF/S2ThyU60uwgKDgEPX028b7BQVpn0nkqRZY008nkvwOUsvhBrH
	2WseehfF0QA3/KnxfO4E07wXwAjqAG7gJgFmiuGeKjxJ19dXFluXdlymmbeFn7Mx
	qVY7qDjjc6CFMoRTsro5LA1x9+ySMBjOiPXSL4swxLtat8rtc6ROzbTGkYuyfOES
	uBEsv+WQs7WGl8b1AJMCC5B0VIg+ZW4poKJvgdkR7ES8/eGGk4fSac02E5ZvA2/M
	MrEys8zLrP94KGZuSKTiWg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds6p8ygw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Jun 2025 08:50:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55M8AdHn025281;
	Sun, 22 Jun 2025 08:50:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47dk6884dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Jun 2025 08:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQmarSgIapHnzz/VEw3OvDXYeTRkbHhsp+CD+mXes9yyvhFtwsRsz+zwUXpBTTFz8t1A89RrdhUVTZIN4cmwN4qxeiriNGRTGKvTj2aL8t/+Ym5Gx8I5FspEuQu1sQLXIuiUiMTohDQsOnzHEUlBrbPnQz1/3m8L/4wKcT9hUe/en1n8HXPx5asE3zqqgVursAfREJEM5z8l0v4EE9FGtSE9TFjmCPFgha/RD0vT7Cs8FwYofQSMTvvXZvDM4MGCVkAs3OBI3i/SZWYkczNXkYTiKBELqYeJafh4qP47eW1kRH9hkOK/FdZ4HcLMXxaC84OrQRlFI8kmCcguLR4VZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qhlyp3iS0/dY5DEN+bIyOda8tpj2w1nNWrRo3ljqe0=;
 b=Z17HcIz0O95OWvtfVwnuj9aTIJWALBaKSSw9AHRRhEBmv0cWb5pODq9LXlVlVfQgglNYFarX83ELoJ2NBeIffB4AyBSRwmlEA147Am+XpGSJLhvIBqFIUKOkg74allBGz3aQBl5d+K8aD/s/XJLoFMPB1Gg4f3PemI7AcPAdKIebPFfJYOCQ1bitkw9DDlynkdMhgqOfQqysTLpwyO6GZf4HdOyHClYad+wHISsOiJCNgaJ0AsVFMvxPE8eMihWzX+dgTbwlvoRraSk5DK2hEqqwdVkH74esjC9l8ZjMgZtQMVx5PDSOBYsRzK8bkcIVoUYPDEu4Le6ZlalzjSRArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qhlyp3iS0/dY5DEN+bIyOda8tpj2w1nNWrRo3ljqe0=;
 b=tcl9AyNZWfGzcT/ciW4Ssg5Xnli+DJoo86PRhfnunPfeXUaFNlC35UHeoQa7KyuorFR8mfLe6MhKvcX72ye+tvMIwqV/CQWjgWiKOjPO3SyCNEddcu8nOI4/ar0oz/2kQ4EA+SLS2QpHoZ8vLMbRJvaGpg+xCZ9BE4r0bVsY9hg=
Received: from BY5PR10MB3828.namprd10.prod.outlook.com (2603:10b6:a03:1f8::17)
 by DM3PPFF6B8E3753.namprd10.prod.outlook.com (2603:10b6:f:fc00::c59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sun, 22 Jun
 2025 08:50:36 +0000
Received: from BY5PR10MB3828.namprd10.prod.outlook.com
 ([fe80::bf2c:d4e4:17a9:892c]) by BY5PR10MB3828.namprd10.prod.outlook.com
 ([fe80::bf2c:d4e4:17a9:892c%4]) with mapi id 15.20.8857.026; Sun, 22 Jun 2025
 08:50:36 +0000
Message-ID: <7a627a46-0820-4594-9755-88649182a01b@oracle.com>
Date: Sun, 22 Jun 2025 14:20:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 0/5] Backport few sfq fixes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, tavip@google.com,
        edumazet@google.com
References: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
 <9ddde997-df26-41d8-b51d-90572eb2c9dc@oracle.com>
 <2025062204-battered-appeasing-617e@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025062204-battered-appeasing-617e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::28) To BY5PR10MB3828.namprd10.prod.outlook.com
 (2603:10b6:a03:1f8::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3828:EE_|DM3PPFF6B8E3753:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e830be-049a-45d6-cff8-08ddb169daf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZ3RlQ2dU9sTmU5a1VDakt4aGZUMFFPL0dINldGVmpBTGE5Qnh0Z0M0TDhq?=
 =?utf-8?B?a3N2blJJMGZXL255dk81KzBKL1F6M1haQU8yd05xc1hGblhtSzZHYmFOT3Q2?=
 =?utf-8?B?QjBzU3FJS2VOL3lBTVdVSTZRQ1lYdExqZUtUdENXdzYrS1BwVHUvNDR2eEgw?=
 =?utf-8?B?Vk5pdVpDMk5IQzVGL1BVUVJDSmcybS9VMmduM2N6WExxSVpGNzJUR1VpdmVp?=
 =?utf-8?B?ZWR3TndoWUpMVXZzREQ1cDZPSXRtSldldlUybjNQU3lJNU9WREpicjdyY0xJ?=
 =?utf-8?B?RzB4UGtsamRldk5tc2hVK2pSNEZTaVZIZXJ0djhEUVVZSkU1RWx4aUYxZGEy?=
 =?utf-8?B?QmxHbHpqblR6amlSaDBMK2RHR2VKV3F5V1pxQlRBY2V2WmdiczF1MDlYMTNP?=
 =?utf-8?B?VmVlV1ZUd1JQMGY3MGMwd2h4QnJEaUdiVDkwU2p1VVFQa2o1WTNpdHFyWGxS?=
 =?utf-8?B?NTd0TjgyVXN4RU9CVTRwK24rMmVFMUZrS05jOEVFeXp3b3FMTEJ3bzJVUjZB?=
 =?utf-8?B?SUc3aEpEMXJocDErYnBHUm9vV0dWWE9BK28rRXpJSksxTjVZTGhybDZPTitw?=
 =?utf-8?B?SytrZlNkQWg5NnhEOG1Yc1M0cU82WEk2OE9NMkp1bW9ycTIrcUlKUlk5RHN1?=
 =?utf-8?B?d3gyeHYzSW9VK0Q5L0t3YlV2c3ZzUTFmeGpNOXE4MXAyeXMyZkp5cWNJU1VC?=
 =?utf-8?B?UWkwbnFaK3hvY0F1bHVITXZLaFBUWS8zZ3R3aFJvNE1ackhxMXBOK0h2R28w?=
 =?utf-8?B?aVNmMEVteDBHdzl4dUF2Sld5NTh3cW9NMmpraUpOdzdzYnlZNDFqaDUxWElZ?=
 =?utf-8?B?bVBtTVQwRmdYWHE0WUVLbm5wcnZSek1tVVdOLzFFckpJM1AwM2hyNUZLMnRB?=
 =?utf-8?B?WDM0M1Bxd0JhVlBDMmRFSC9IajFqQWdqQTBDUjhTUm5xbkVzeUFDY3ZpdVJU?=
 =?utf-8?B?TWZ4bUtzamhDRGswR3lKazJpbHFPZGJZeWhlMmZ4VU9aNGJUZTduYUlhcUhz?=
 =?utf-8?B?MSs0cGdqdjlyTXhkbFd5LzY4SExSZGJjMHQvczZManRzczNHdEt0MXBJcWhW?=
 =?utf-8?B?amMvQlErNzh6MFRrUDgwQ1AzbGFNbEN0azVnNGVHT0NnWmxiQmtYUkRnNWM5?=
 =?utf-8?B?am80NG5SbitPZkxaaEpPMWhKRDh6VlJYNzlEbVI2UjdkQXNuSEhJZm4vYTl6?=
 =?utf-8?B?ZG1hRjBZS3U5S2ZxMDgxRkRNSEtEV05YeTQ3WFNXU1AvdTRmVVorVUdjaG1E?=
 =?utf-8?B?TnhRcGdsYXFaaEpyOXZ4M0dPZmVXYklkSTVOeEdrYnRUdFZOVDZlRU1SWnRN?=
 =?utf-8?B?T1MwTHBiNHc1ODNtSVZOR0xJSGU5OGFQcUZBTG5iZXFnbWV6ZC9SazQ3a3Fn?=
 =?utf-8?B?R1g4UGxCVG1KanRjRS9oczJ0VXNmNFB6MEZaT2NlWWthM1ZlQ1F4bSttL2dS?=
 =?utf-8?B?UFU0OEpsVGpXeTVmQVhkR3VPaEhVdDhrSjhwVXN4VmlJVjk3NlBiOU1HZlRm?=
 =?utf-8?B?SjJWT0VqQ3lZL1dza3JuRW1XV1l4M1ZuSVNBbTVVZXdxakpuWVQrVjgrVVRJ?=
 =?utf-8?B?SVcxTlJuUzh5K25oU1ZicE0rNFpacGFleWVPd0pNaFlqSXRyajVCVVE1UGJK?=
 =?utf-8?B?emIxSWxrVys1aEVaT0p2NmJJOE9CWURVa3lFenNRaFRjUzBRS0lmdFMvQXJo?=
 =?utf-8?B?aEJvUEg4bEg3TmhLTXpheldoOFFTbFZxQm93aXpXbllCT0xNZXJpZlA5dGhv?=
 =?utf-8?B?bk0zRzhwRTd4c0JqUXZyRVZqcWlsRE9NcmRBS210TXUwam1ISHhjMWYxV2ZC?=
 =?utf-8?B?YlFhS2NSUlVNditKV1ZBdkRuQU1wZFV2QnFrUVl3dXEzOGdYZGYxTWhmTGVZ?=
 =?utf-8?B?c0ZCczlwbm9oczFRZEVWd1IxWXVLMVhacVU2SzEwNFBmOXJVNnB2M29BeWRU?=
 =?utf-8?Q?i/oO/ESWtg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3828.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZ5T0s0WlYrTWJKZWpLbnZzTVBwMFBjUGQ5Yk4vNk9Bd2JhZzM0MFVtbjln?=
 =?utf-8?B?MG1JT2hFcjR5cXJ1cXBUUjVvR3ZQUStKc2Fsc1dEM3FYMmRESGQrTVRGMFFl?=
 =?utf-8?B?Y0h4c2xNNlBWV2VkUGtqLzd5cXc1bkVEU3lvSzhjbjVNcWk5ZWx0cGFzMEFl?=
 =?utf-8?B?WnZqcmVGZjVMaFZGMzZxMEVkTi9GVnJKNWg0cTcwMERLTHlpZ1Y4OVkwYVpU?=
 =?utf-8?B?TEJXdHd6RmtQaWxNamhnaDRoK21RU3dza05McGlJaVJnbWZFK0dVQkhpdkhU?=
 =?utf-8?B?NEFnSG5ubnlDY3hmZDJiR0xLTWNLSjRDQ0toNFZEN1RaUzVwK1plb0gvaDJG?=
 =?utf-8?B?YTZHZHBrNmlDSk9NSjVEVnNCZ29ta082SFhBNUdHM2ViRXhOdjRxcjlkRWo4?=
 =?utf-8?B?TldXS1JGb2Z5UjJWZzJhMHl5Uml0cmRaYTRyaXZaalgySUVvcHYzdk5DUzM1?=
 =?utf-8?B?VDhMcjVHMTVCek1GdU9CQndQbDNFWC9xQ1NEemJBMWFQQU1vNXR1djhtUGFF?=
 =?utf-8?B?UkpmQldSdXRXNkF5NTY5SVhodGxhRG95a3Q0amVHMVVMOGRpSU9ndTUyd2xL?=
 =?utf-8?B?WGpIdHdxYnN6ZlptZjFPL1F2MmRRR0tadG5uS1oxTHdDVVdURHNMaThKcEdL?=
 =?utf-8?B?OW1VeGw1TjN3T2xmd3cyazFlL2hNVDF3RFZuS1NkM0phN1NlOVNmS2txOHA4?=
 =?utf-8?B?c2s2NFdFbUtLQTlHN0hkR3lKNHJEeVZTTmY0b1VOTHVhb3JLSDJPeGYvdkNl?=
 =?utf-8?B?Q0ZXL3J3TFlGSXhIdkk5bUJ0OUpZUVo4L1ppRzFZa2lyYlcxcjdURkdMbklP?=
 =?utf-8?B?V1daRnZKdDA2TDVST1F0Sk5UT2ZiZkE3d2ozMTc5WlZENFdtdkhsdkNDbERw?=
 =?utf-8?B?NXBQWER6Si9WQWV6MkkxT1VvVjA3VVhJME9NQ1dYZVhyWmdjNjdUSlNDYVRj?=
 =?utf-8?B?bm9pQmV2akhGeGNibjNFQnRMM2FIa0RFWktQQU1UdjlCS3BoYkU2WTZoSWpi?=
 =?utf-8?B?MWdQcTZWOXU3cG5zQmNuNlZWTFVBZEtOTFpTS3JVQVdKb2RqbGxVSVZFdE9t?=
 =?utf-8?B?dnhYVTFqQVBXa2o3dndrTVpjczRmd2kvclhremV3bEo5N2JLNVlUTkZDdzJC?=
 =?utf-8?B?T3EySVh5anQrUDZzWFU1Y1JmaEpVUzMwdHo0Y2J0b29IcGV1MG1LMUNZQ0ZN?=
 =?utf-8?B?b0QxK1NLYktQZkxHL3ZiaUhvcUM1bGpNUXBiNU0rdk01UzVyZzVzZUNxUkhS?=
 =?utf-8?B?bTFBbWlxUkJ0Y0cyeEFSSnBKVFpVSk0vUFpjSm9XQmtNWmtZNTZUWkZFNzdz?=
 =?utf-8?B?UVdmc3R5K2hONVNqR3BGRTVyR3JFNHcwSGNnamg5QU1tcmIwUHdDQUEzajVj?=
 =?utf-8?B?ZklRRUJ6Q2xFVzlPelpjdHg2YVpVa0RubVNXK25wQzhzb0pIQ0h3Y3FPZncw?=
 =?utf-8?B?TjRnZnpTQ3A1RkVoWkh0cFVMU1JMeFN5ZWlRZGhwN1o5Z1hKYWJiekE4OWhz?=
 =?utf-8?B?dmtlSWF3VkVOUGRybGNXS2Nmc3RDU1pEd05YZTlnbkh6eGJFUXZBS2pLRW1C?=
 =?utf-8?B?OWl1c1hiajkveGdiTCtkWjVuMHJTZ1hFNWFGNC9yaFVDZUtwVGJsUExHV2NY?=
 =?utf-8?B?YW5lQkJ2UWZGTXdLWHQ2d3NoSjNIYWFXQWZXcWs5ZUNrTUVIR0ROeFNOWCtu?=
 =?utf-8?B?b1plVm4zOGh6RlptYStSUjN1L3FiNTJ4Vys2QmdSYWJreHV0eXA2Z0tObE5m?=
 =?utf-8?B?Q3Y4MWwyWWJyWStsV3hBNW5PQlVTVjJZSzlsVmhZaGdYTlh5RGtMc0gyMzZD?=
 =?utf-8?B?dzNHR2tLNS8rWWFReXVVZUVFZXp3eElVa2ZQTXBFSnprRmJPcURPZklVUFFi?=
 =?utf-8?B?ZThYUW4wbkhlRVF2T2dQQ2l2QjBBZHFGRlR3UlNkZFd2S1pHSEloRVR5R1I1?=
 =?utf-8?B?U25tR1VrUmZxY2FlTW5iUFFWWDhIUnlCb3RGL1hhY1l4ckVVeXg5NzFOcmRW?=
 =?utf-8?B?ekdYb1NMRWlxZXBNWUFKTTAxVjhxa3dYeXdxYlI0WnlqaDVsY0pNMUQ2VmNM?=
 =?utf-8?B?M0g3NFF3dWZIZ3czVWNuazdUN1EyYzQraWUxVnpLOTF2SVF6NGkycE9Jb1M3?=
 =?utf-8?B?WklOZGt0MU12b3NDbERqVlNKczdZOHZWRWNkVEphNzNObXFZcFFUSlVWQ25t?=
 =?utf-8?Q?ia2VjkSmL4DXDSaotXkWyy8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ipxa1PA9UzH82WfaJqug4PyczqOopdV75/92++A+boQk90ucB1XbSt0fetV6Ma/Jr9TdgDQQpYbHpmSnA2igXQ+iKmTvy/CRWAdJk8rB5vNOHUjkbinLXNS9z1LE2ooqdP8tka1Zh52vaNH4QvZmcVXdAR5Ic3wMIzrBEpNdgQWSegVPAADJ2keSlrF7c3Z3V61ifZIoyBN8UWogyX8GxtrT1cjosARha5QYKSFIU5/ot9lhNig+MTTjU5PxPgNTlA+Bbzwade6JNrYSXBR00nyKBiV1SpLRLbXtPWNTlmjjwFeJ9RWxM75o+RzcSjLfFW4+CvImGveDrvc5Lo7MWBWpaKCUJ0CNLjBkbVz4iTwjS/4ZCFj6d/ixPTHClunJpkjypHuoLyG5iTlnLsDP/R1BfMI5JY4X/TUenzTAmAtLgzn8sKkC5bUsyiO1SXP//OrV7rU0dFjWaa0T6Kb8QISD+OdUZfz4eZMtSmS4cvTfIGVnMJNLSMUKLcPgxcIzZ2usJKh8JNV2w2Tf3WJQSmZDw1fAQT34vVRa+28nY8vHnd/MaYzI5AHygB+A9HAvOPRFA08lmVOmgZ0ZFI8pyoSBE+Y2J5/xGJxKE2F7t54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e830be-049a-45d6-cff8-08ddb169daf0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3828.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 08:50:36.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzbjIf1ckUXhAuR0kOKbMh8Sj1wHZm8DrxU/BGtt0UkTUOubp1txXufibj2NXJlW+Ruw+17CYtoboEcFGbC7PvGHcsMCauO4SrLHnmsZH+2SXbP92r/LSm9iGDluWOmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF6B8E3753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-22_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506220052
X-Proofpoint-GUID: 1yCMHdYoZFuPQduUaiqqOng-du_g9k-o
X-Proofpoint-ORIG-GUID: 1yCMHdYoZFuPQduUaiqqOng-du_g9k-o
X-Authority-Analysis: v=2.4 cv=e4EGSbp/ c=1 sm=1 tr=0 ts=6857c3df cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=m-limAM-DY65-DlvHsYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIyMDA1MiBTYWx0ZWRfX6zyWdYxYhNRP hCjzSv3B7K7mHfewKu/nPzQBiTteaxPmDViEkEaozHmXMvhJCUYBpZX5zy5pW+VWU6e+H0i24a3 FMO2/2AZ3G8q/Nas+dJTEwPYiQX51JLH8ZEbAbVnBol2RpUjvv1a4QE1HltPcAnXa9bLcD+k9X3
 YvnK4obgKg44tTG+bNHefS16iX2F+DDsdDCJUxl8nEPFmBJ2HndqyaO2anrVhhuagX6mimHP00H vYGAKRYrurDUWNR4JCqXYIza+qOt7vQQfWhZyIdHDbVnwiHHDYz3xb5bn3J8GAjxSyJJgFc1Otg 0s3lxQh+v9Eo0uUu5EwUQQf/SruzFg7NsjX+xzkE83XIuG3pEc7r3QliUPUwghe0WEc+0TEfa5f
 oKxdK+iByv3IiiF1mXZBq7kgN6y4zkUn/xnx9n0dVdqPbCTvnsWq5s3awfkK+GbbRmEjbMbG

Hi Greg,
>> Ping on this patch series:
>> 5.15.y: https://lore.kernel.org/all/20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com/
>> - [1]
>>
>> 5.10.y: https://lore.kernel.org/all/20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com/
>>
>> But looks like Eric sent these 5 recently as a part of a 7 patch series to
>> 5.15.y here:
>> https://lore.kernel.org/all/20250620154623.331294-1-edumazet@google.com/
>>
>>
>> Just to avoid any confusion adding context here. I feel like Eric's patch
>> series is better as it includes two more new fixes than my series while the
>> first 5 backports are exactly same.
> 
> I'll take Eric's patches.  

Thanks, that sounds good.

> Should we also drop your 5.10 series or go with them for that tree instead?
> 
I didn't see Eric's backports to 5.10.y, so maybe we should go with my 
series to 5.10.y and then apply any additional patches as needed.

Thanks,
Harshit

> thanks,
> 
> greg k-h


