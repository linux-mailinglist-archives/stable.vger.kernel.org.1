Return-Path: <stable+bounces-203474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EFCE6331
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 09:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF493005FC0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3CA21254B;
	Mon, 29 Dec 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i753R5G0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PONatewh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495663B9;
	Mon, 29 Dec 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766995662; cv=fail; b=dqkoDFjOWDdbKGcUBSodMOl4+AwDD9sLBNxFtGS6k7GhFpvHeLZPK6G8/OK4TKP8grDnKpsJLDholB7d6mdmehA0+LxtRx4MySVAk1yxt+9Jz8Bbap7vqB7izuR1kmwJ7PjjwMv0ZdV0dqZaR9pv0huRpMNRK7EjupvZvjED08M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766995662; c=relaxed/simple;
	bh=sgTpZkXVOHf0ndOMMJtuoj9JbjjHlOP/4SGfsvPIp88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=twuo0ZyrEtiFw/8s8YnBoYQToRJRueuon6UInG4tK/OsQBaZFHRvM9t2oAGHkXMWOTvUnT/m+d2a1L4s0/abQFeXJ+2yy11bReFvkaoJLlJHRyOP35VWcBxX6yKoK2gu1LV1fkypnkxZW6nz5BTcL2jf2EaYC6Awuvc3k6QHUoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i753R5G0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PONatewh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT3lPYG1454660;
	Mon, 29 Dec 2025 08:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gatduEkPZykHwCRlp2H/N9lesqyrKyMjDEa0tRLVp7Q=; b=
	i753R5G0sAtbxs1lovy1gbgSEVLBW3a3NLK0J42QSWA/CKo5r3YC0AO8WYHMf8wF
	UWXIf076CsJT6v8qmpCr8hEu1VHD9lozFTfeDkT10C5IXnJ9L3SOwu4sMsxhpF2H
	P7Rit/MTt2OdV0Y1cx5OGMXSP+yNO4fcyJFDT5MTFS3IkTel3qM350v+b0qSr7FV
	cgdO8ChMLH65DPPdiAgUQnoyJ8LCM5aO8LZy675aHKV5u1Nxs9RZlzAVCeGisGSi
	eMcKSwsBVrxIO04Wyl4ilW4ILsapai+e4KwBZDSiRSmirctFOdsztxOou8+m568W
	e1pAKmJK8zk8eiS+rhQN9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba7ga9ch5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:07:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BT5QPP3038936;
	Mon, 29 Dec 2025 08:07:03 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w6xbuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evkiot+YQSULcI14JVYsgGlrvj4YItjDTzxyOA4OOzQyUXNA54Kf3IxGAWUAqkdopd4b8DPdlrnNm+c00818A/oJEn5V5R6r48RNdXosHZV3g7uQ5ZMWMHQ996jgSLkzIUQO5c1mB1IWYrsY9JxbWj1ykTkeiGWBSzsNyPUEnkB7OKK3vNsui42BleRNnDhjmqrdRb7d5u/skMyNBFQQtWjnFLkLEjU8Bx7cv2ls7g691FPqTdTybE4YvclM5u/D3NJdE1DF2J1ZpH2fDzTZ/ZzzHmUxs3zIy4pBFetTlEykmyVFRvcMWeZdB/Z5ZS3KwLpt7nxtgc+xYyjxMQOgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gatduEkPZykHwCRlp2H/N9lesqyrKyMjDEa0tRLVp7Q=;
 b=zCd6vDT8lxU22m6bvMItYHPqIlxRUUG/m/37R7XTUpNMiT4BEtNm2tHQILrymZxUu5dr0dpx3CsRP9Ak8L9WjX7ykUcIiyoTM9RRUwMNwETatFr0JU5QeLTjwuUYJKat7QpOw71U9iOqO22erUmGb3r9f61vFa2KmuBQQRtVkku6jCS/mRXvSN0XrRAp6ZrqaqDS/TBcAMNgBThlbf/v2yRsaz+spT61Jvh3rvoAILiCpmRvBD+XMcWvV3u8Hw5BEXHFAwzsPraytut9X1RndKcrb9LQQSp/u2nHJkTnkFYRpmIRU9N30oJ9y4wHg2C0PlzFxrcCJ5rRDgq2XNHr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gatduEkPZykHwCRlp2H/N9lesqyrKyMjDEa0tRLVp7Q=;
 b=PONatewhXAYZAilyozP430K/0T4ee3jbJj0WsccccAiPYuO+EJowNrHr+TjodBRXh0X/Vju/kMcHpllvy8eeJWMhNQB4U5wEbngcjizrwRHc1se4uJR9qHHYiv648WgYyeC8/dFewYCQwLTVDsvchzp0Ejgt7m1p08VD0n6s/cs=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SN7PR10MB6545.namprd10.prod.outlook.com (2603:10b6:806:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 08:07:00 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 08:07:00 +0000
Message-ID: <7a7a0106-fdd1-40ea-88b3-f803848e0e73@oracle.com>
Date: Mon, 29 Dec 2025 13:36:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
To: Borislav Petkov <bp@alien8.de>, Andrew Morton
 <akpm@linux-foundation.org>,
        Jonathan McDowell <noodles@fb.com>
Cc: henry.willard@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Jiri Bohac <jbohac@suse.cz>, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Guo Weikang <guoweikang.kernel@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joel Granados <joel.granados@kernel.org>,
        Alexander Graf <graf@amazon.com>, Sohil Mehta <sohil.mehta@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        yifei.l.liu@oracle.com, stable@vger.kernel.org,
        Paul Webb <paul.x.webb@oracle.com>
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
 <20251201092020.88628d787ac7e66dd3c31a15@linux-foundation.org>
 <20251201181909.GCaS3cHcsBjmYblRHG@fat_crate.local>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251201181909.GCaS3cHcsBjmYblRHG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0245.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::17) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SN7PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b741725-c972-4c7f-0506-08de46b13e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE90Ky9sWDBKMW9YM0hFYmx4QnI5ZG1lbDFiRzZCS0NUSHhtTTR3VGdGeWlh?=
 =?utf-8?B?NWI2a2grK0RnaFpCZWtidU1DcW5aS1BYclJqNjh2VFlYSkJlVXd1dlY0NXpk?=
 =?utf-8?B?RVJieE5jL1JEZUtETEdVN3l5MzlQNk9DaUE2OG1ScThzZytXeTNjeWx4NXlq?=
 =?utf-8?B?L2dPT1JXWnUzU2ozMDlobzNFcUFiSmk5OS9PQ25rcFNqbnJJOEgwcllXQ25i?=
 =?utf-8?B?MjZQVjNacmc4ZVAxck9YNkl1UVBEQ0xwUzhKZ2VvRk1KU1Y1OG5GQmNBWmRi?=
 =?utf-8?B?SzZ2NGtaMXQzazZ1amNKMVFiN21ickR1ZzdmKzlQYUJMZDRoNDJ4bzk2TDA2?=
 =?utf-8?B?YXphYzZ1em1nY2wvWFJDYzZ5eDYyR0F5QjcrRzdYcXZNWFlPbFJObTFWVzh0?=
 =?utf-8?B?cXpBSWdkT0Z1YVJIcCsrcFg2YU1mdlAreHdxc1hSdDVTbjZYVExYRHM2UmdL?=
 =?utf-8?B?TWhLSTM2R0RFZ0FrSm9oK3JrVWVhakNucmVPeXBWWkdMN1g3YTVZZnFmU0Jx?=
 =?utf-8?B?UHJkanFtM3hJdzVuUVRRU1gxeVRib3d1ZGZIUVpoM1A5djZORHI0NHZaa0NI?=
 =?utf-8?B?TWx0V3BuS2s0djdHcGUzU0ZkekRqa3pHVjAvQjZEa3pTdnJYT2t1RDIxS2hP?=
 =?utf-8?B?UUxBQTZReDkzTHRoZ20rRFUraDhlOXVsQUJ6WTJvN0NWMG5Qa2VpZFROcndB?=
 =?utf-8?B?SlBKNGJWTFAya1hnd1lCRU92L2dLRnZORFQvRWp0VkRkVHlLM1RjUnhUYm1z?=
 =?utf-8?B?V2Y5TXVPZnNsenJPZFNtdE1uWFNici9nM3ZtQkJFY0ltVVVmVEtnRFpsQy9Q?=
 =?utf-8?B?UkdZRW5QMkhTdFJUWVVURGFDVkV4WG9KWEdwZUQ2ZjZLTlptYTJWdkVEbTVQ?=
 =?utf-8?B?dENqWkh4OGdHVHRyRDA2WmhIQlFEaE13KzJZbzVsZTI1aWNvS2FuNXB0Q2RO?=
 =?utf-8?B?OFhNdFpLT3dZM05oQVNKUFpkMWR3V0wycURCWFVCVktoQmVmTlZRQTdEVWl3?=
 =?utf-8?B?ekNvUForMzVMbERCSHBuWnQ5VEhhSk1vbmJvTTdjaDhpLzJHTWFGVVhaeXNo?=
 =?utf-8?B?UjBMd1MyeUVRWnpwdSthQVdYeE42Rm5xQmtjT0xxaVBmRGxIWXhWcWV2dDVK?=
 =?utf-8?B?U1BLa1JVK0YzMXBRTm9MbWZMQ2ZPcU9NTDA0N0RIT3JRbEFabWViclhZcFlX?=
 =?utf-8?B?N3JSZU5ERkIxZS9QMG00VWRRdGRvN3JEdVJOamxwN1ZhblhNUm9zU1B3ZHFp?=
 =?utf-8?B?dEI4WHdVZW5PZmJDNFZRR3l2TUgzVCtHeStmQmw0T2hLSXVxcE1kaU9KaVl2?=
 =?utf-8?B?Qkh0ZmJuREZVQ2NseVF4Yk0wdDRZL3dYamF3RmxTanJNajNHejBkb3ZDM0xk?=
 =?utf-8?B?WloreUsxTFFMWXFoMlAwUGpNNWlSdlprdGo0dGlBOFRObG90UnhqTGMzek5I?=
 =?utf-8?B?dHdsTy9BR1FQWUErR29oZGEzc1hreHRyNU9sbGZzSXFmcFZ1TGo2UlhNdHpC?=
 =?utf-8?B?d2x4SzFESHRKY3dBSXFQZ0hjQzcwS1ZjYmprWXlTZktSYW45L3VTbDlVRnpE?=
 =?utf-8?B?aUxIT3lMUkJSYWk4NjJzQUNnb0Y3a1l3R0RoRWp4ZkdGdmRVUnJyVWxIYjhV?=
 =?utf-8?B?Qkwyd0ZGZk42cG1SSzRuOE8wWk4veHRtRld6bjFNQzFYbVRUTTNpSU1Rdjkw?=
 =?utf-8?B?cFphUzdGWXlRdXNYTjUrZUVCaC9yQmN0SUVKcWVlVHVmaksrWGNkeUlWZHNH?=
 =?utf-8?B?aUdCVHF0U2g0M3Y0RWljQzVBcDRzNlBKdDA5c041dDUyNHVyNEpOcXBudmIy?=
 =?utf-8?B?NEdQV3RhcFdkVjlzT3Y0Sy9LUzkzL1R4S3dEeG9JVmE5WUdrNnlmcGZDNUl1?=
 =?utf-8?B?YmJaRU40ZHdJKzlVT0tBTXovdVMxRkQ2Y0FaM3pjZHNqejRQaGFMMjZaSU9a?=
 =?utf-8?Q?uhDwGcLYlVn+WfTpvBVHEhAA7cnHPIDA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlZlVFRCMDhmQm5ESXdqb0pweHdFRGpFeW03V2kva2ZOMzVDb0wyRFIxbGZQ?=
 =?utf-8?B?REt0blhoV0w1WUtNT0hrMnp5eEVLK0FZeC9jTjJabDNHblJwWmQ3T2pCaTRB?=
 =?utf-8?B?VWswOUUxbUVvNThubGNMeEd0TzV6VVdkUE1pWDF6blFGOGdhbzNlbDMza1JJ?=
 =?utf-8?B?cDFLVUdXNkdDVlFJVUMvNElETE00M0NORHNWTUZtK3BrWTErc1dvUlRLMUxh?=
 =?utf-8?B?aWIyc1BrRHFuN0t1NzFPZ2FIOEhUWmtQRWNaTWhIbkgxODcxQlpYeGdiUE85?=
 =?utf-8?B?UzZaTnNHUUVncXRpUmZhL0JzMG9YTFU4M0s3N0VtbktBVTEyZzk0N2lZMGtK?=
 =?utf-8?B?bVpJc3ZFSTFXQ0RiQXljTHlqMW9JVXc4MVZVaGxiSFFxdTEyUGNmVFpHbEdi?=
 =?utf-8?B?cEpmOUlWK1hJcEp4QlJid0M2cENTdmkvdWFZWkF0bnc4Nk0wcjRVS0ptN3Fq?=
 =?utf-8?B?aExzRjlJdkkwNjkyMGZPZlNkVkludEtmcEVrdnRXdFJjTDVudmtzeUhkYU1E?=
 =?utf-8?B?blpUQTVoeEJ2VHMzMDg0Rmk0QnlrdW9BNHZQYjE3em5NUytndDlnSmlTUlRW?=
 =?utf-8?B?Z3hTWGplRHpzOFR5dlYxWUJxL0VQbUVkamw2Q2dnNGUxYWpGQ2F1MVUwQ0h2?=
 =?utf-8?B?MGlUMW1wUUEzbm9TMHJqVDkxQk1OUFdHUGZjZlVMYkdvTUZIWExkZG9ySGJP?=
 =?utf-8?B?aldURFJNRlpLb0hmUVVoVFZtSkRxdU16RlprV0tUNDA1bG14SXluaDN1SVUr?=
 =?utf-8?B?VjBhRlJFQXo0cmlsYzlPMGtLR2wwQ0pmeE5uYVJURVJSZHduTFhBR2hadFFO?=
 =?utf-8?B?SklrOHVwbzRoN240Rlc3bGorekplTUZ3cXdmWlc4RXpYV2NpU25zNEd1d1E5?=
 =?utf-8?B?Mk1VZkVYc1ZWbHJyVFl2K1UxOEw4SlZwcU5OcWdQa09DRnVkMWZOSXVib2tH?=
 =?utf-8?B?VzRzR1BCYkh4NE5oTTF6VHEzc1hCVi82cHUzRjZqUGN1eXNDUDIvaXZaLy9u?=
 =?utf-8?B?eGhueEdhM0ZLTVpBUFdtNStTc1VOZ0sraHZqcHMrU05Dc1NFV0REVG8wblIw?=
 =?utf-8?B?cm8xaFNlbTJwUDlLdFFZUHA5em8zZjB3RVhEaGRjUmdwUkxRNm8yVVQrb0c5?=
 =?utf-8?B?MERUcjlnWU55Y04zS0hvaHRqaS9pdEdRN1crVTdFL2EyK2wyblF3T3FzcGpU?=
 =?utf-8?B?L0h1T0hHSndaSUgxbC9MeXQzTFlheXNZOVdhak9LY0tyQTJmK212S2lnamQ1?=
 =?utf-8?B?QUFNdDJ1NUxONURXdjJCdWN2c2M1TlllVFNHVjlUSFhCVDQwOS9tdnpTaGxQ?=
 =?utf-8?B?MjFpYTlXY2hKY3JaK3lxSVBDUXQ0NU9sVWkrNE8yN1UwS1Y4TjYySUFBakMy?=
 =?utf-8?B?SEU4cWhkbW5DMUM4ZllqRjVReW5KZ1lQeFlCS3B5ekt4bGQyb2xKWWhQRmhw?=
 =?utf-8?B?WkF4eldKazZ3UkJHZFNaQlZNd01hbURpdjRYTUE2VHBDdWlCR0pKeE9jUCtJ?=
 =?utf-8?B?TnJXeGxqRVFzNlIrS2V4ckM4RjVWNTdsckh5UjMwMkQzV2Y4N0h5bXIwdnlM?=
 =?utf-8?B?WHIyMU9IVkU4L3dtekhpSGw1VmdZa09LcjdqZS9MRnVNN1RTUG5PZzh2KzVi?=
 =?utf-8?B?TlhMQkppTWRYa2tHUzdwb1RvYXFUd1Zlb1BMemxzSjh5RzNJaDdnalBpK1ZQ?=
 =?utf-8?B?dkpoVUlqanRVd0RURG9BYVlJOWw5VDR3WVNRUkNvMHlORDNSK1RxZGVvUXd6?=
 =?utf-8?B?Qzg4OE9qdGF2SXZ0Z3FoMFBPdG15RmFJNmNGMi9uSzhFL3ljVTREMHBaSzN4?=
 =?utf-8?B?MWNSTll4eGg3UGsvYkxmamdXS3dDY2EwVlpiUkl0YjFOeExMTUpxc05iWkln?=
 =?utf-8?B?YnQwRkRTWG13Y0Y4bEJ6SHJxQzBIVnphOVFaTXhEcGlUdkh6c0REdlRNM083?=
 =?utf-8?B?RFk2NGZpci9VempxTS90YWliKzhIZGFLM1NyWEZwTXFaQTR3MWE1dk9OdGNI?=
 =?utf-8?B?eEhFTGFTMXovRitxS1JrU29BZlJ5bW9Nak50V1pVZjdMbTRYVXJ6SVI2ejQ0?=
 =?utf-8?B?RVByYldNUmV3U3dPUFVLY0tIc25UNU00T2xMRHVhYmpSMmR1MnoxVi81YVNW?=
 =?utf-8?B?ck5mYTlNblZSeU1CODNWdU9KOWR0WW5yc2dycTVvaDdLMzVqYk1mUHNqc3Jw?=
 =?utf-8?B?RXR0bVl2dVBEM20yVHJIU0ZMdEE2TnJLRythOXNteHNnTFNEQWhrcENZdC9t?=
 =?utf-8?B?aUE1bENXSWZHVTE0djNkWjBkYzVIdnhCQXJhQ2VicWowQmd2T2VsVUYxa3VK?=
 =?utf-8?B?YWlOSWw5U0JscHl0YmxNcXg3Ly82V05DTTdQc2twQUxNOExFcTIySlNVVlVB?=
 =?utf-8?Q?v5fnZ8uhgDdbTy8RB4I9rjLu5bjxEXjZKqC1g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	92jQ3cnE77aYVMHoWjr94nQbQeHHPROt3oUZXImOfOVvMRgvzrQgRAY8XyF/G7mBUUiwEPU9iTyilyiat/H78nmfIHk202OCqePKsWUdfcOjPzTcW135XZVYH7ytgWx3mMKlN3c91MdTPGp2GZF2NaFPLS+bkzMOeLvOZoSmgqI5gqGFmahSRL6uRWMdis97xPYBNivP5qJ7hZD37Bjphv5PysqwMEh03vr9byupJeOrX+Fs1R+kZ8z6OZENPQTKvaPNFp6imtvplprIbCoM1Y5sC/jEnUAD0yvQN7olGMbaUpiaXIPqAgLBjmtUFcOTlZsNzfk4yNEL9jQ3auAX4oa7bZw/dWMEDjAialZuXChP5VqjyBnJCq0hkfTtkVTiz/s+LWB5NnBNsZqil25Uom0WXOQ6chFL/Z9YEAt3TLnurV9K3ZowFZxWa2v2ypuwG7kcQs/OBaVBgk2qdo5m0sKJMKZmrMj/xIRbYqn0EfpeJYeDKd5WMmRsa1L0BYSg3kbtIjS2wQgNhdXVXEl9Oy/iHM+bfj9c0pNhsB4lUjl3Z6t5VfV1oSTa6m/CGcuTGt2XF7egdasECEZEHcK6B4nIJMAom57C0apq3IpqcdU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b741725-c972-4c7f-0506-08de46b13e32
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 08:07:00.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkRRa3Up5yCQCAkd2hHF8Wqs6cX/G9m/LJp9l5Pp+26nxiwId8xj6+QrnPfZv8VqLGIOlmZ1vxwZ0DMdcEFB8XJ8OpE9AwlDATpzxwP3Xqee5lszM5ni8ptgQS5196nL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512290073
X-Proofpoint-ORIG-GUID: EMv4D1TfLOpKeESUKb_nGFrCRkB8NT5W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA3NCBTYWx0ZWRfX4UVZjE7PD1cV
 fcjnBuA+i55WnMgDCvNloKBG0DFelStvmloNAisAKSprWtn3aXUqRn4Dbs7AE+TvgVhzblBlrHb
 ZDjOEP8bJ8c4BT1X5XLjg7LqK8iTMWnYdHAtsfm+ErOqkrTgtFRJI32ehGei46Iul0so4jLFSoM
 zkdroNMeWsVmReldMclk9EGOJJM2asyeBUb6tyXjQsa/mB9w02Hlgx9HFIAofPPAHMrsqoVMp/Z
 hi5XW/Gc40UvSZy22kxFNURPjrRZK2wZ0tM3srZT0OktWb8bK0QQxMeSm5ghte+nTslQu/iotai
 UpSLPzl4zSINVqAVrwJ8xpI68EZfGRCGDgA1rhxU4qlc84NzO0icaGdABPZa+BYkt/NfA3B4hJu
 eiUNpBPVU7Pc4VTZTS7ykmS+0/Olih99gTV35aEdkylKomMr+VX6IAHWDLrRU0MCErknnOCNhiZ
 GD9eWmh+q9Xq3WaCzHA==
X-Authority-Analysis: v=2.4 cv=T9eBjvKQ c=1 sm=1 tr=0 ts=695236a8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=VdRftGjpdyDwZ6YfaUcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EMv4D1TfLOpKeESUKb_nGFrCRkB8NT5W

Hi all,

On 01/12/25 23:49, Borislav Petkov wrote:
> On Mon, Dec 01, 2025 at 09:20:20AM -0800, Andrew Morton wrote:
>> On Wed, 12 Nov 2025 11:30:02 -0800 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
>>
>>> When the second-stage kernel is booted via kexec with a limiting command
>>> line such as "mem=<size>", the physical range that contains the carried
>>> over IMA measurement list may fall outside the truncated RAM leading to
>>> a kernel panic.
>>>
>>>      BUG: unable to handle page fault for address: ffff97793ff47000
>>>      RIP: ima_restore_measurement_list+0xdc/0x45a
>>>      #PF: error_code(0x0000) – not-present page
>>>
>>> Other architectures already validate the range with page_is_ram(), as
>>> done in commit: cbf9c4b9617b ("of: check previous kernel's
>>> ima-kexec-buffer against memory bounds") do a similar check on x86.
> 
> Then why isn't there a ima_validate_range() function there which everyone
> calls instead of the same check being replicated everywhere?
> 

Thanks for the reviews.

Sure, have tried this, will send a V2 with a generic helper.

>>> Cc: stable@vger.kernel.org
>>> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
>>
>> That was via the x86 tree so I assume the x86 team (Boris?) will be
>> processing this patch.
> 
> Yeah, it is on my to-deal-with-after-the-merge-window pile.
> 
> But since you've forced my hand... :-P
> 
>> I'll put it into mm.git's mm-hotfixes branch for now, to get a bit of
>> testing and to generally track its progress.
>>
>>> --- a/arch/x86/kernel/setup.c
>>> +++ b/arch/x86/kernel/setup.c
>>> @@ -439,9 +439,23 @@ int __init ima_free_kexec_buffer(void)
>>>   
>>>   int __init ima_get_kexec_buffer(void **addr, size_t *size)
>>>   {
>>> +	unsigned long start_pfn, end_pfn;
>>> +
>>>   	if (!ima_kexec_buffer_size)
>>>   		return -ENOENT;
>>>   
>>> +	/*
>>> +	 * Calculate the PFNs for the buffer and ensure
>>> +	 * they are with in addressable memory.
>>
>> "within" ;)
>>

Thanks for spotting.

>>> +	 */
>>> +	start_pfn = PFN_DOWN(ima_kexec_buffer_phys);
>>> +	end_pfn = PFN_DOWN(ima_kexec_buffer_phys + ima_kexec_buffer_size - 1);
>>> +	if (!pfn_range_is_mapped(start_pfn, end_pfn)) {
>>> +		pr_warn("IMA buffer at 0x%llx, size = 0x%zx beyond memory\n",
> 
> This error message needs to be made a lot more user-friendly.
> 
> And pls do a generic helper as suggested above which ima code calls.
> 

Will do, thanks for the suggestion.

> And by looking at the diff, there are two ima_get_kexec_buffer() functions in
> the tree which could use some unification too ontop.
> 

In drivers/of/kexec.c we have:

int __init ima_get_kexec_buffer(void **addr, size_t *size)
{
         int ret, len;
         unsigned long tmp_addr;
         unsigned long start_pfn, end_pfn;
         size_t tmp_size;
         const void *prop;

         prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
         if (!prop)
                 return -ENOENT;

         ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
         if (ret)
                 return ret;

         /* Do some sanity on the returned size for the ima-kexec buffer */
         if (!tmp_size)
                 return -ENOENT;

         /*
          * Calculate the PFNs for the buffer and ensure
          * they are with in addressable memory.
          */
         start_pfn = PHYS_PFN(tmp_addr);
         end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
         if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
                 pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond 
memory\n",
                         tmp_addr, tmp_size);
                 return -EINVAL;
         }

         *addr = __va(tmp_addr);
         *size = tmp_size;

         return 0;
}

In arch/x86/kernel/setup.c we have something like:

int __init ima_get_kexec_buffer(void **addr, size_t *size)
{
         if (!ima_kexec_buffer_size)
                 return -ENOENT;

         *addr = __va(ima_kexec_buffer_phys);
         *size = ima_kexec_buffer_size;

         return 0;
}

I will try to generalize common parts in another patch.

Will send a V2 adding ima_validate_range() helper.

Thanks,
Harshit.

> Right?
> 
> Thx.
> 


