Return-Path: <stable+bounces-49950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA58FFDD3
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D449F28AE6C
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45A15AD9B;
	Fri,  7 Jun 2024 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ShVi+VJh"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866E1C2AF
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747837; cv=fail; b=jWLmNIt9Qx5nN6kKQJsr8O6ZZ16liH9lM/HxFTxsL0LqpCB+lkzw5ot3QVlE3tJgkFJmhp3hm6VKpV+5tJligQpd3OmhrLNan1+jvX6Ccbm8hBcPi1akpybxwHL1pj6byKWHDlgv5XQDe1khsPAurD2965pConqfHQh+IobnuOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747837; c=relaxed/simple;
	bh=83O+eWg5+EwqS+n5x3aZoVkbhZFUfq3EylaDlRuixME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGuqQVckEzWbpPylLfnVvxW1XT0qYpLbbafIPrpE8315quePc9DstYUWRvoIrerH3KHaa2P5tOZPAsn5XoiC7Aa3Lq6sOHVc9a/ZRWo3FfPt/zDEyXCLUtpWAd4NgEXzrTV/lJ8Mg8/ZgjlSAaO+YMPVDOkRj8zWtrRXeXgOzrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ShVi+VJh; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGmI66x2Al0sAsitrNB/xJXSJnJYMM3ih6ImKWZiDchIkNBRnRZKAXangpRkUiXx1uyHDS25BBWFWK66o+9FEAlEBqqNds2u5HMMcLvPzulK6rqhD7GLDNUZg09lueAlsz0VG1rEeDkVG9Z23CnoWnaILd/Y4ig3HCuubrbS3rjY1DxX6vXP1YgF7gKTcKvxIlEIYOKOtQK4TWA16R5d/ELXKEZThnXW6w2fJJ+7207gY9Szh9RE17fDw1djhDiLdVH+hfQN+us95GS9qF/hlx40AdI2QUbn+BF5OegOloJxzEkNaoNZMpo23QkQCX/AiUFGjjxfavmTWK8wwzYycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQddRWt26tD032imnbVdTOdhVTJpbp2Rjd9t5QLRXzs=;
 b=LYrlSnNK9EMhhWDPYSajvER9aiIiGb6Uo/lgdR9/hlFQB4eEHq/wzZ0FjgWOG0KqU3PLUzYkJgO1U5p3rZv1u+Yj6h2+npiTXGIlfPR/wdmtR4Iwz17d7YCuAgkVSOmUuRgWbgmWT3mEqNgaOpo5lNYH32SrGKd3QQ2V/w68iL7cnRD53H78OJU5SkcYXV8YrZVluUI287FSO6a4Ayjgq8pqntp6bqZog/aXS2tXRarW5JugyxtLF9486qQ1RmiAAWZdX3k7+ube0lubJp8ZbJwuhaQvbNATyO5SkfNGvi9qddryT8JlEuZN5Q5iR4ax0sORj4k8Wc3Fzf+gmPurbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQddRWt26tD032imnbVdTOdhVTJpbp2Rjd9t5QLRXzs=;
 b=ShVi+VJhtxN4bYoIRXrMTiVNQ041zPVQPt1n7xE0D7phsx72OQpOfaRMO+vCrJwDQzJ3qSK/4APgDg6r7aPHXATO+3NrgDj7PNHNvEPjdwfIcoPJhl5YZT+K/cYPKvimRF8WvF6+UxzOI+5+u+wLcMJ+oQb15njln3fSO1lH7zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Fri, 7 Jun 2024 08:10:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 08:10:31 +0000
Message-ID: <c0c030a2-e9ae-4d1f-8181-337e54631677@amd.com>
Date: Fri, 7 Jun 2024 10:10:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the BO release clear memory warning
To: Mario Limonciello <mario.limonciello@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, tvrtko.ursulin@igalia.com,
 stable@vger.kernel.org
References: <20240606200425.2895-1-Arunpravin.PaneerSelvam@amd.com>
 <a1c9e7f7-fd1d-4e48-abbe-0afea6c4c10b@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a1c9e7f7-fd1d-4e48-abbe-0afea6c4c10b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 146d4654-b16f-4102-cf2e-08dc86c94c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXpTMzM0T0J2VWJjTGh6M2VhRWl5WmtFc1lCMHVQUi8vbmpPSU9oOWJ6aWV0?=
 =?utf-8?B?YVVvaFg0cmZubHdUV3dHOEw2dWNuaythdi9nL0NSYndDWUJDYkdYT21kcC9E?=
 =?utf-8?B?UHI3ODRsOU5xRld3bndXaC9Ka0dJSHpPWGZqdW1sNXIxKzlDd1dMNlBUQnl6?=
 =?utf-8?B?dVI2NkdYWTg2UVN3RGVORWExODFsSGtOb1RaQXgwZldONXVjUXMxQ3hZYnIv?=
 =?utf-8?B?T1lCbkFPQ3Q4UkpUd2draFVJV0d1dFdVMnBodlhLZXVPcnF1dWVnd0Exa3FT?=
 =?utf-8?B?eDFRT0padHpvbzhZY2oyNUQ0Vlc4UDdqOWYwajJhNnQzSWhtT3dzTDdVdVNE?=
 =?utf-8?B?M3pJUERyUm1aNjFiNk14RjAvLzJuRk0vVmVCLzdQaThpS1RhWXNlRk92SUJu?=
 =?utf-8?B?SHZONnVJSzBzZ0JYWDhoaUcyMmszNitTQkVXYk84K3J2OEd3T2w2VFZaM3p6?=
 =?utf-8?B?ZksyRHFHOEc4T0F5T0tWaUcxQ1NmZXBic1UvcmI2eTEzT0xXSlgrRFoyNG42?=
 =?utf-8?B?dW5jSWg4SUhIekpPcDdMMmp4UThwWUZBbWUrQVNDcDIwZ0FiZTZmMU1mMlFR?=
 =?utf-8?B?RndESVNqOHNKUGhhZkt2YlNuZ3BHTkp4WGhTVlZ4M0FjSC9vM1hMSTNoMXRW?=
 =?utf-8?B?U25ydm1abHZQenRTR0pVTDRhWFBvVElBRFNyYkFhNy9XNW5JRFdZM0pEOWwy?=
 =?utf-8?B?aFRFV2JVSUN3bGlCeWFpK2RXUExyOWdIRURCK3JxSHRqaHZzLzRTRCtza0F0?=
 =?utf-8?B?bVUyTUl5ejRzM3o5TUt3ekg0S1M5blUrMm1DdXVtZDBwUGxtWkduZFhUK096?=
 =?utf-8?B?eEZQZUFzbFp4YjMwcHU3YjdZOFVVdTBTT1hJQ1FjOHlFRU9EQTdRWVl5b0NW?=
 =?utf-8?B?UkRkZi96cXRvZElEYnIxM0Z1SFR2NmMvbyt5K3VTaTQrQXhXanZnditBSnVP?=
 =?utf-8?B?SVdJUHdMbHRzcTd0ZlpnWnFWUkVKTlNxeHRPajgzN3hCdGtqWFB2dGxhWWw3?=
 =?utf-8?B?VlpRanppRkV1MmN5UWlrR2g1ek5lWGVRS1oxSFBud1RxaERJS1M1UGlTcElK?=
 =?utf-8?B?clpPSDlyMlAxOElFd0UzKy9aZ3ZwN2svTEpIdFp4RjhSb1dMY1FxZitJdUJQ?=
 =?utf-8?B?TmVIaTdQbUcvTUg1dis4TWdCMHAwRk9JdENpOXB0cXVkWXptRGZFbG5FSk93?=
 =?utf-8?B?TXVVcXNNbzN2MU5oVGdoOWJGVm9ZekVIQU9QdXRnMzFyY1AzRWMxbjhCcFNh?=
 =?utf-8?B?R2hEMCsxZHV5YXJ3RVlabDdZM05oc1FzdmkzMVQ5K0V4WGtDK2hJTTdVdXV1?=
 =?utf-8?B?N0RyM1Z5bWkwNkg1UVNSdGJ0ajRac1FUS0ZnREs1QkZ1RVFBZlh3NkdRSkhv?=
 =?utf-8?B?anNuRUhKMGUxSUZlR0hIZGVQMFBUQ3RHT1hVbmRjVUp4cHV2ME5zdk5lY3pr?=
 =?utf-8?B?blpuZnh5QWNKekJJY2prdkh3N0RNT3dCd1FsV2NJaVRCK2oxb3ZZVnJQTUFm?=
 =?utf-8?B?TFA5Unl1QzQ2ZGl4Tmxyc0E3b3QyT2tXS2FJWXFPNkpHN3RTZUhBTlZXZzhV?=
 =?utf-8?B?MHpWdDFkckhWc0hlcWRPMGE0bnlOVWdCWjRUWnYwdjBZTGpQN0d2Y1JLVnJK?=
 =?utf-8?B?ZFNjS2Nab2N1aXBQMHBWM2YxNHQyckN0aDRpRTh6UzRZdUw0NUhOSmtjZjJu?=
 =?utf-8?B?emQ4M1ZJSVh4QmNoSmxXMGczck5jWVQvbm9UeG9hamhqV3FROGEyNGFvT2Jv?=
 =?utf-8?Q?dlBN0inxXgc07901NJep4ng+h23cx4qt497URJs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmJvaEN6SXNCemlIR1l2ME9DOFI1TEN2dG50ZjFGRnFnM3pQWnlGbHJRU1cx?=
 =?utf-8?B?bk5lZ1NuUG5sSTBxb2U5d2dlWExycyt2MTdnV09HZnc2R04vNlBNQXZ6ZUZQ?=
 =?utf-8?B?bVc3bFZjWFZtRFRRTSttWVo4ODA5cTYwN24wN0d1Z3pNSzdQa1BhRUNBS3g5?=
 =?utf-8?B?Wk1IalRsSjlscit3UmpEeXljY1dZTUV4bm9tdkF0SnV5WUpiRG1zcDJZSks1?=
 =?utf-8?B?NmdCbXlnbTM1TTVRc25qNFd1bXJ0clZDMnNGd2xVVVEvTTJCNjdFU2hEYTRy?=
 =?utf-8?B?ajIvUDN4cVJnMmhjNE1DbWtCRVZZajR4REdTY1oyMWhxQVVqdWJOOGFObFBB?=
 =?utf-8?B?YjMvK0VQNFY5QTk5UUJWSTdwbUNKbG9GRnpjc0J6ei9rOWllWlZCY25WUWgr?=
 =?utf-8?B?L1FkelhxaDRjZkVhUzVXR1dvSmlPTW81clV0dXM0cWdHQWhOSjJJKzNzdXlK?=
 =?utf-8?B?Qm41ZzZaNGxHV25abElqL3Vtc0ovbm10YVRYYW5idjdWSXZQZ1lWVkdIT2xx?=
 =?utf-8?B?RzFGdjFtdDZTQ0VEVENMWHBiYVI5Z2I1WEhEUHRUcVhobDdJT0dFdVZIUWh6?=
 =?utf-8?B?eTBxSlowS3JKQVl2dUo4dGRQVm9LVmlxQ2toQnFZR3F6dldWZEtHRDJTUmxL?=
 =?utf-8?B?Q2ZKdGx2ZlczNlN0S3o1dnpMS3d5ZHFBNktBYlkwUE1mTnUzbHhmZjlrS09V?=
 =?utf-8?B?aXozbWFHU0ltUlJiWWhCL1FpQk5XeWVkNFhrdmNFOSsxdE5RUDdEWjgyQjJD?=
 =?utf-8?B?aTgxUUpMeGY4Y1ErUnQrdE44TFJMSzFvNGNLUkZGcDRWYVRQSjhweTkyamFs?=
 =?utf-8?B?SnRQbTNwSDZxNWgwVkx4S1krN3hhL3lVcjdOZlAvRE0xMmpvM2VDVVZoeEg4?=
 =?utf-8?B?SEU0anpYV0lMMEg4a0pPUjFvekNIaXBFUkhsMXliQUJraEYrMDkrK2VSdG85?=
 =?utf-8?B?RG0yTTllcTVIL1M3M25VZGxEOHdoUFR5eFRieGt3SGRlbldSZEF5eHFyOFNm?=
 =?utf-8?B?TUlwcmtRc0FxQXVtSzJVemRSWGlGaW5BSjVQdzdBU2szL0ZpWnZQUHU5TlF3?=
 =?utf-8?B?YVZoV2hRaWRYL2RyYnFzY1V6Z2xzQVNqWCsxT01yZ05ZTyt6Y3cycitRKzcv?=
 =?utf-8?B?QTRNQU9IWlQzbHE0V2VxbE9BSmVoaWpkZ09VTitkMjZLUVk1aVIrNzZPUFF2?=
 =?utf-8?B?dkVzVE1pRy9hNFZWQnB2ZVU1OWV3dWd5RkxQUHV1S1RmZnY5OTJHRU1aMmNv?=
 =?utf-8?B?MHRHQTZnRHZHRW1NSk4vTXA2bXRMUmR0d0htTW1jempqeHpPZWswcVZSSE5R?=
 =?utf-8?B?aDlsY2FFVXJvZUtpeHRXa1pZeFV1aTFYSk9ydFhhT1RuK1J4ejR4SjBhR25H?=
 =?utf-8?B?aC8rdzRkczlUU0NBSjFaeTNUTzI5L1NEWFRBZmxGRjFaY2YxRFMzbER5UHVN?=
 =?utf-8?B?cVlMNXd0WGZzMlZEUnZRdy92dFZvWDF5Tk9NVlpvQitMVFdlQi9KU3NES0FY?=
 =?utf-8?B?N2RhRERDR3MwSXo3QVVvL0o4ZG9UWmFkTkI2eHVVTmtuWmpxNnlGaXNIUW9h?=
 =?utf-8?B?ZHBsZXlzNE0vZ2phTFd2VFhuY2QwWGtsMzRMRmNoaUprcHFVQVAzdm1jZGxU?=
 =?utf-8?B?UlU2Zmc1THFtdkJhY3FHb01pQ2gvdXJ0bDlwNi9aMlJZaysxREluVFRqaElQ?=
 =?utf-8?B?SytJZ3dWeGdrWnhLYldPenR2SnpZVUp2Mjl5VVJ4Qkg1NCtNYmVXQThCQW9i?=
 =?utf-8?B?YjlabFlqcGFrTWZiSDJBTmY4amkvRFFpWnpyVmt0VjZHS1luZjRTRzhTZmdw?=
 =?utf-8?B?M1FLdW9DeGpQblRUVUhGWXREV3FnMWdUVlVXQlpSWWZ6T1dRbm1XQlpkNi8v?=
 =?utf-8?B?QXN1M3Q4WkdCQ0N5eUVxNW5VS3doQmpieXptOXgrUzBoek5oVWg0U0ZqTkVD?=
 =?utf-8?B?SEFyVjFOVE5sV2UrR29YTUNaZzdBZnJrRS9yQXo2MXRhZUpwYWlNalFObUxs?=
 =?utf-8?B?MXBBY3J6TFlFNFhhWXVRT0cyNnVIUXJGQUEvUGdmZnd2amV6MGdTN3JaY2cz?=
 =?utf-8?B?cFlzcnUxU0dhOHgyRHlWaXg3TzdMNlNWLytEMTYzbTZwRzRXdHQ0WTVlR1VR?=
 =?utf-8?Q?FqQ8Ff2FaFpR7wB5EjxEOcTlz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146d4654-b16f-4102-cf2e-08dc86c94c66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 08:10:31.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/V2KBVcBv0BrWQjMfaWut5hclSFzJbCbR+mnEtfEghz+yKoY7PefGZqbemPgo5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

Am 06.06.24 um 22:19 schrieb Mario Limonciello:
> On 6/6/2024 15:04, Arunpravin Paneer Selvam wrote:
>> This happens when the amdgpu_bo_release_notify running
>> before amdgpu_ttm_set_buffer_funcs_status set the buffer
>> funcs to enabled.
>>
>> check the buffer funcs enablement before calling the fill
>> buffer memory.
>>
>> v2:(Christian)
>>    - Apply it only for GEM buffers and since GEM buffers are only
>>      allocated/freed while the driver is loaded we never run into
>>      the issue to clear with buffer funcs disabled.
>>
>> Log snip:
>> [    6.036477] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to 
>> clear memory with ring turned off.
>> [    6.036667] ------------[ cut here ]------------
>> [    6.036668] WARNING: CPU: 3 PID: 370 at 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1355 
>> amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.036767] Modules linked in: hid_generic amdgpu(+) amdxcp 
>> drm_exec gpu_sched drm_buddy i2c_algo_bit usbhid drm_suballoc_helper 
>> drm_display_helper hid sd_mod cec rc_core drm_ttm_helper ahci ttm 
>> nvme libahci drm_kms_helper nvme_core r8169 xhci_pci libata t10_pi 
>> xhci_hcd realtek crc32_pclmul crc64_rocksoft mdio_devres crc64 drm 
>> crc32c_intel scsi_mod usbcore thunderbolt crc_t10dif i2c_piix4 libphy 
>> crct10dif_generic crct10dif_pclmul crct10dif_common scsi_common 
>> usb_common video wmi gpio_amdpt gpio_generic button
>> [    6.036793] CPU: 3 PID: 370 Comm: (udev-worker) Not tainted 
>> 6.8.7-dirty #1
>> [    6.036795] Hardware name: ASRock X670E Taichi/X670E Taichi, BIOS 
>> 2.10 03/26/2024
>> [    6.036796] RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.036891] Code: 0b e9 af fe ff ff 48 ba ff ff ff ff ff ff ff 7f 
>> 31 f6 4c 89 e7 e8 7f 2f 7a d8 eb 98 e8 18 28 7a d8 eb b2 0f 0b e9 58 
>> fe ff ff <0f> 0b eb a7 be 03 00 00 00 e8 e1 89 4e d8 eb 9b e8 aa 4d 
>> ad d8 66
>> [    6.036892] RSP: 0018:ffffbbe140d1f638 EFLAGS: 00010282
>> [    6.036894] RAX: 00000000ffffffea RBX: ffff90cba9e4e858 RCX: 
>> ffff90dabde38c28
>> [    6.036895] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 
>> 0000000000000001
>> [    6.036896] RBP: ffff90cba980ef40 R08: 0000000000000000 R09: 
>> ffffbbe140d1f3c0
>> [    6.036896] R10: ffffbbe140d1f3b8 R11: 0000000000000003 R12: 
>> ffff90cba9e4e800
>> [    6.036897] R13: ffff90cba9e4e958 R14: ffff90cba980ef40 R15: 
>> 0000000000000258
>> [    6.036898] FS:  00007f2bd1679d00(0000) GS:ffff90da7e2c0000(0000) 
>> knlGS:0000000000000000
>> [    6.036899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    6.036900] CR2: 000055a9b0f7299d CR3: 000000011bb6e000 CR4: 
>> 0000000000750ef0
>> [    6.036901] PKRU: 55555554
>> [    6.036901] Call Trace:
>> [    6.036903]  <TASK>
>> [    6.036904]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.036998]  ? __warn+0x81/0x130
>> [    6.037002]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.037095]  ? report_bug+0x171/0x1a0
>> [    6.037099]  ? handle_bug+0x3c/0x80
>> [    6.037101]  ? exc_invalid_op+0x17/0x70
>> [    6.037103]  ? asm_exc_invalid_op+0x1a/0x20
>> [    6.037107]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>> [    6.037199]  ? amdgpu_bo_release_notify+0x14a/0x220 [amdgpu]
>> [    6.037292]  ttm_bo_release+0xff/0x2e0 [ttm]
>> [    6.037297]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.037299]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.037301]  ? ttm_resource_move_to_lru_tail+0x140/0x1e0 [ttm]
>> [    6.037306]  amdgpu_bo_free_kernel+0xcb/0x120 [amdgpu]
>> [    6.037399]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu]
>> [    6.037544]  dcn315_clk_mgr_construct+0x198/0x7e0 [amdgpu]
>> [    6.037692]  dc_clk_mgr_create+0x16e/0x5f0 [amdgpu]
>> [    6.037826]  dc_create+0x28a/0x650 [amdgpu]
>> [    6.037958]  amdgpu_dm_init.isra.0+0x2d5/0x1ec0 [amdgpu]
>> [    6.038085]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038087]  ? prb_read_valid+0x1b/0x30
>> [    6.038089]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038090]  ? console_unlock+0x78/0x120
>> [    6.038092]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038094]  ? vprintk_emit+0x175/0x2c0
>> [    6.038095]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038097]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038098]  ? dev_printk_emit+0xa5/0xd0
>> [    6.038104]  dm_hw_init+0x12/0x30 [amdgpu]
>> [    6.038209]  amdgpu_device_init+0x1e50/0x2500 [amdgpu]
>> [    6.038308]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038310]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038313]  amdgpu_driver_load_kms+0x19/0x190 [amdgpu]
>> [    6.038409]  amdgpu_pci_probe+0x18b/0x510 [amdgpu]
>> [    6.038505]  local_pci_probe+0x42/0xa0
>> [    6.038508]  pci_device_probe+0xc7/0x240
>> [    6.038510]  really_probe+0x19b/0x3e0
>> [    6.038513]  ? __pfx___driver_attach+0x10/0x10
>> [    6.038514]  __driver_probe_device+0x78/0x160
>> [    6.038516]  driver_probe_device+0x1f/0x90
>> [    6.038517]  __driver_attach+0xd2/0x1c0
>> [    6.038519]  bus_for_each_dev+0x85/0xd0
>> [    6.038521]  bus_add_driver+0x116/0x220
>> [    6.038523]  driver_register+0x59/0x100
>> [    6.038525]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
>> [    6.038618]  do_one_initcall+0x58/0x320
>> [    6.038621]  do_init_module+0x60/0x230
>> [    6.038624]  init_module_from_file+0x89/0xe0
>> [    6.038628]  idempotent_init_module+0x120/0x2b0
>> [    6.038630]  __x64_sys_finit_module+0x5e/0xb0
>> [    6.038632]  do_syscall_64+0x84/0x1a0
>> [    6.038634]  ? do_syscall_64+0x90/0x1a0
>> [    6.038635]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038637]  ? do_syscall_64+0x90/0x1a0
>> [    6.038638]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038639]  ? do_syscall_64+0x90/0x1a0
>> [    6.038640]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038642]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    6.038644]  entry_SYSCALL_64_after_hwframe+0x78/0x80
>> [    6.038645] RIP: 0033:0x7f2bd1e9d059
>> [    6.038647] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 
>> 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 
>> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 
>> 89 01 48
>> [    6.038648] RSP: 002b:00007fffaf804878 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000139
>> [    6.038650] RAX: ffffffffffffffda RBX: 000055a9b2328d60 RCX: 
>> 00007f2bd1e9d059
>> [    6.038650] RDX: 0000000000000000 RSI: 00007f2bd1fd0509 RDI: 
>> 0000000000000024
>> [    6.038651] RBP: 0000000000000000 R08: 0000000000000040 R09: 
>> 000055a9b23000a0
>> [    6.038652] R10: 0000000000000038 R11: 0000000000000246 R12: 
>> 00007f2bd1fd0509
>> [    6.038652] R13: 0000000000020000 R14: 000055a9b2326f90 R15: 
>> 0000000000000000
>> [    6.038655]  </TASK>
>> [    6.038656] ---[ end trace 0000000000000000 ]---
>>
>> Cc: <stable@vger.kernel.org> # 6.10+
>
> I think the stable tag really won't be needed and could be dropped 
> when this is committed.  This will presumably go into a -fixes PR for 
> 6.10.

Yeah agree. Just make sure that you push this into drm-misc-fixes to be 
sure the patch makes it into 6.10.

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

>
>> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 --
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 67c234bcf89f..3adaa4670103 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -108,6 +108,7 @@ int amdgpu_gem_object_create(struct amdgpu_device 
>> *adev, unsigned long size,
>>         memset(&bp, 0, sizeof(bp));
>>       *obj = NULL;
>> +    flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>>         bp.size = size;
>>       bp.byte_align = alignment;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8d8c39be6129..c556c8b653fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -604,8 +604,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>       if (!amdgpu_bo_support_uswc(bo->flags))
>>           bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>   -    bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>> -
>>       bo->tbo.bdev = &adev->mman.bdev;
>>       if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
>>                 AMDGPU_GEM_DOMAIN_GDS))
>


