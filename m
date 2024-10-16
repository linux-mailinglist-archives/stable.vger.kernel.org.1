Return-Path: <stable+bounces-86506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F809A0D05
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43981C214DC
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01820C03D;
	Wed, 16 Oct 2024 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o86mQZN8"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437320C012;
	Wed, 16 Oct 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089732; cv=fail; b=Cu3TN7qgpfr+df+JZ9UAwIzkpd5XMo73pfIOOl0ygVTbbfYze5/sPBv/orYrfvl1WwBGtpUCVyvDAMtyL5WrgLyuoRzpOCs+a9Yslgw9eyZ8T1hnN5hYUSVkP8fEBUbHOD2ZxbObECQ3x/BOwcjU1315Dib2r/bsE5Fpxh+6ztk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089732; c=relaxed/simple;
	bh=jpLO3GivTxwnjEOy/87Big/+fx2lC8K54I0zkT6vhps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CDLfv4xTyYicZIzr6UhiLSlKa7ab/AHvte0H404zUeO/qCrePDaspeORHUE4dVBNCOJ5IjAQZsP4ZsJdVRER4DVymEDNA6b8zZ0e9dM/pKa3mCB0MB7FOH0WXO1L6m6gNiQ6VlKJt5YzMa+q6EsK/w8zGqL2GEiAQaOTb3JNH0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o86mQZN8; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYOnvCJfPSvNf73m3SVNWttaS0viR+XWqbo3gEtJKi6JnwJUcHXcSSdaasF7sPGo80EzOHx3+em1m9dJ0feyigZEAp6WfBlovFN31/Qh4hmwNUuuuboUO8uY80aE7jCntBYB5DXAaPVLOlKjQiLe6bV0ifW0zuy5flt2BO9RiRvX74lBjm3x2h3v7kkyZxWXxCe0hTqlQaCAFHwJPp8KTJm+FFYbCHMdVjXPsI47Wdieaqt3lA5/eqVD5GfmZ444Tf/tM+CBhV8Ptcxj9/PUU4zWhvpQ41ZR05DdyP/xEwZH/Jjjvj+fpO26JBGCNWNg0uzaLEb7McXDL63ViTTU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LQlhfjAr9JdpDNXt3FJv+jLTpaNbeM0Hct3RzZMQUo=;
 b=WS6hPgNb0LnWVfZW1ciiZBHR8mg4NmVZHC+R8RBN6RwNYUnNgivFNcwgAgdZ1GNIP6u9joFbWI2eg9AxweXDwUC8w4ynZdyTj1uhxSFayaqfRBoAve+Ud8AqyDA5TyEsTfEAiqcSPpj45Hzo2tvUW2eXrSxydaz7Ee4hdDr8xhEoodSvDZlbCTC0gWAC2YEjmpJQCLM4njDeHsdq2sdA6RlPrbcVSHrUetCLvo1J4XHAMzzxu6ecob82LdXVIUNvOJmBg23Q+OjFjoDUZFihbarevhXXO4LnQi1ftebjAcs6HGOlECVM5Q5w6iFVV8608imqk7Un4C/kRd28XW6LvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LQlhfjAr9JdpDNXt3FJv+jLTpaNbeM0Hct3RzZMQUo=;
 b=o86mQZN8lTCxQw7Gk8i4rkFasLm9kolHmNnUn2giKn6DcsA3zTBepB7UiGpRWXlTGl12FHesyGamhkEqQpPLmhF/nfzI1DIUXVScQ5BLzb8G2p7yDWsxAzfR6O6oJTAIs7FbPQvPuWWSj7je2i4lj/SAmaGEXfh2aGxrVR170nY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 14:42:07 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:42:07 +0000
Message-ID: <c54bb2bd-ab12-1178-f18a-6925bf3d4f8a@amd.com>
Date: Wed, 16 Oct 2024 15:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, stable@vger.kernel.org,
 Zijun Hu <zijun_hu@icloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
 <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
 <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
 <0c945d60-de62-06a5-c636-1cec3b5f516c@amd.com>
 <670d9a13b4869_3ee2294a4@dwillia2-xfh.jf.intel.com.notmuch>
 <9a1827e3-1c55-cfbb-566f-508793b47a4a@amd.com>
 <670e9a2db6f4a_3ee229472@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <670e9a2db6f4a_3ee229472@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0515.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f888924-8ce4-4925-1e62-08dcedf0b5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnRROFc3cVNGeEMrUndseE1ocVVKMzhHYk44MTlVUHc0MmluT2VnQWlyQVpY?=
 =?utf-8?B?SUNaZ1k5STNmaUNER2FHU09wWmY2Z1QrbDgxV3Ftd3FZUTBuYjFnRUx0R29V?=
 =?utf-8?B?QTd0ZmlGN3MrVEdGVXlZU0NBcjNqQkhoUExZYXFBZm9Gd0tYNXFZVEFGbyt1?=
 =?utf-8?B?OUFtNmxkMEtOU1FKeGozdU0vMnZPbm1qbDFoODFkVk0raFMxVEFOK0xXWWRU?=
 =?utf-8?B?bWJodVlmMi8vOVlLaEZUQ0tZREo4c3RuRDQ5VFpBaTJlWVlmZE13TTFJN29u?=
 =?utf-8?B?UENva1daYnY4dHh6YVJQSzZBSkJYc0VJQzJ0elZTeTRYNmtVY3ZHNWtSS1lB?=
 =?utf-8?B?RjVRbTdzdDF1THlaVFFQaDdKckw4L0tFQVFicmVOUldxUWNhYmFVRFZGU1Ju?=
 =?utf-8?B?KzBGMXRzZjZDZEgrUERYUStqV3kwM1ExdVhsSVVQRnNIeWM1R2U4V1VwdHBZ?=
 =?utf-8?B?Y2Q0U3hQY3M1Rmt2S3JHQWg4RHNjTkhJVFBBTnNLMDM3dHpkV0JYV0ZYaW9V?=
 =?utf-8?B?TDBFVEJJUnFESkRWemk5c3A3cGJHWGNqeWVnak12bFBDVmxSNkdOVUNqNXlC?=
 =?utf-8?B?N2hUcE12WGt1T2NsNXFBcllPTmJ3c3NrMXBUU1c3cWtoWWlXa3BxVzBoKzBP?=
 =?utf-8?B?dDR5bzE0RlBBclYrRFNBa2FIaktDalpZc2FMcE41UllVMWN6dmNMdDZVOXov?=
 =?utf-8?B?TGRiR0IyajFEWlpJZDUySHF1L0s1aFg1SnlJaGp6V3h3TnhLT0ZVczQ1OXBV?=
 =?utf-8?B?YmRQcTJ6cEEvaFpPclRiZWU1RnMveitnWFF6dTNLTnhZSmV2OFJRNGN1a2Q1?=
 =?utf-8?B?V1VScExERTNQa3Q0OUlHM3ZONWQ3RlB6NmJsTm1odUxwNVA0aVJKV2s5LzNH?=
 =?utf-8?B?QjdVWXRLOVZzZjhObnFONWo4dDNDUVQ4RVFiNGV5SmNxWHFFNkNDOVBsUjFo?=
 =?utf-8?B?WHN3MHN5R3ZJWFkrVjZ6Yzc1NWdqaHVtSUovVzR2d1BXUUVNbDhZUzM5R3Fs?=
 =?utf-8?B?b0JRa0dEbHppRkhqcGNHOWVJdm5iMUl2NzZGK3JYWEJMU1k5am5hRDRLRHNE?=
 =?utf-8?B?aEZROUNpazl3bnIwcDBrWmZNd3ZEcFJROVJKTE0rVGxRYXFYNUN6NDVOZE5I?=
 =?utf-8?B?TXQ1bm15TitKdWpFTmU1aG5uUFdtZmk2SVB2RmFNRzlCZHEwSGphWkpMSFhx?=
 =?utf-8?B?MXdyZXRrVVdPdFRncnI5UnhMajNtR0lWZFgrRXNBd2JjeDVIL1BqMEE1MndR?=
 =?utf-8?B?ZkhPVUZuS1FuWUZFUis3OEgvREU2dVg5UjBZd1dPUHlRTEZPVG5pSUx6bGJn?=
 =?utf-8?B?YUlNTlRDblBlUS9OQkRLS2hXN2NpanpUNHNWT1luVGRBMHVtbTVmanVlYWVS?=
 =?utf-8?B?Tm5NZFhvam1iZ3EzckZVejJJNElyUzNxN0hLdnFRVWJxaHJjUFlXNmRnYjlp?=
 =?utf-8?B?a09ocllVdTVmTmJuT0E2L0hZTU1Rb3o5bWovaHdxOGVGYnBhOTJhU2VidktM?=
 =?utf-8?B?ZFpSNzBHUnluUytMRTV4UEtFcFBab2toL0NhdnREMzMvbytnbU1VQlhnTUR6?=
 =?utf-8?B?eTRZd0x2aklYWDJOMTNuc0h2azVhWlZmS1BlSVErS1E3bndwaGdtYjV0cmJa?=
 =?utf-8?B?dlBFVlpxVXlmWXdiMU0yalBDZStqNVgrcm81ZjUrQ00wVi9BUDlqeENkQ2tJ?=
 =?utf-8?B?Slk2am1nQVZMZjY4TVRsWC9wb2N2c1NGblZTeWZhL3RKUS9CVDBoL0FRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm5US1o2aURyQ0s3WU90M1RqUWJKZ2RnalFRR1FxclB1Ti96eDJoN1JpOVVw?=
 =?utf-8?B?cTk5TzV3VEFNQXhHTVNrYm8zckpQZmVmMXplZDBhV3hqRHZldlRMREFwOUxM?=
 =?utf-8?B?bDNLQkRQR2JMNjFTaS9uS2ZqNmI5Rit2YWVjTnVnc1hWZXJHMzdpRzNBVHAz?=
 =?utf-8?B?NWZKU2REaXh0SEFrMFgzYVBuNDZJK3Y2SG1XT1lJS0dqbUppMkV0amZ1ZTQz?=
 =?utf-8?B?d3UwazVuUTErdldCNDZZRWw5VDRoZS9nOHdBRnBiU1R5amlSNlRsWjNBQUFR?=
 =?utf-8?B?anBQY0tZZlhjUWtibWJHa3dwcGYvQ0s3QkxsYmdxcmlMMTdiRGZoQStQN2Ir?=
 =?utf-8?B?YjdzMytMT2g5K3h2ZlFjZnd1UXZ6NGtjazBwVGtmMHFRekY1ZDNweitsbC9O?=
 =?utf-8?B?TzY4a09GM0FCZitKWjljeStPM0JpdWRuOVByU3UrTHNWcFovODQybGlGdDhS?=
 =?utf-8?B?TjFJd1V3QVNrSEFoUmlIQlBEWkl1aVVIN1llbTE1U2crVnhlbEdlZCs1UFI2?=
 =?utf-8?B?Q2M1WTdnbDI5dUJRV0NIM2RWMFg5MldnRXVpdmN6SnM2NnVLOFZua2orTDNC?=
 =?utf-8?B?TzJrV2puZXVDMTVQSmJTYi9seTJaUWt6NXBFbDY0dzBvYXJyRU40M1lIZ3VH?=
 =?utf-8?B?L08rS1gvalAyNVJPazVOS0hrSW1pRGtkMEVCSHJ2eHo2S0Y0ekdmVjFvb3ZH?=
 =?utf-8?B?VW9qVGxRN1ltMXA4dGl4M1FLS0RuUFhMWXkwS0FRWFk5TzVycmE4c2hlcUNp?=
 =?utf-8?B?bTBnSVlXVTRGbFB2dHZaQ1IrY0M0RCtmL0ZxZ2o1c1RPVXdCR3BGUjREdFNK?=
 =?utf-8?B?TzQxTEUrdXE4WThMQVk0ZERsUnZSdFFHd3Nycm9ucHY0cTZZRzE5YlpFdHhE?=
 =?utf-8?B?Tk5Va3BLM005K3J1NkRZVFZ3U2tVV3F4N1ZnSWRVUEdHOXIwZWFpM05Dcm5S?=
 =?utf-8?B?VDJydllmVGl6aUQ4ZWE5RGxOSjFNYlljRnUvOWdhaU5nbHhZYXBtSW12R2s1?=
 =?utf-8?B?MitrZEZWemN5TEFpMUtFU0RwVThmRDhtZGYvSnRlUG5FVUV5YTZacVg2RXBm?=
 =?utf-8?B?b2V2WHgyQ3VvTlZ1OFQvTVBvcnR4cUJTUG1oalZnNElKWWVDRCtTQlJHdk13?=
 =?utf-8?B?WGM0RGZKaUhLNUxxSGxIYjhoaGpPTXYvTGVTTlhvQmpUdzV4NXRMWWhhT2Y3?=
 =?utf-8?B?ZVdqYW9zK0xlMWh1V0dJUUk3Q1hBN2NJNnNxUk1FRy9Hd25wcG5UemQwUFpY?=
 =?utf-8?B?cmxUYlJXeE04TkFVZVhGZy9xU3ovRC8veXpYTnRnTUw4aFM3dHV4MjRQeThO?=
 =?utf-8?B?a0FsUmZlSnpXMnJ2WUROdGltcTBlVDNKZ1ZQUmJTOXZ5eGZKaXprVE9McWFR?=
 =?utf-8?B?SmlYd05qeG9WaEZkQUllLzdZUXlvekVERU5Vb0ZSZjNybHZKSVN5UkJDbGIx?=
 =?utf-8?B?VHV0Y2pSMkFaZ3lFZFJQM1pyZFM0NlhRSlFXSXJGbHpUcE5yYTdWbmxhV0tP?=
 =?utf-8?B?YTAwS0Fka1lVa3B6M2dGY3hZcFhRQ2NSNzB4eUdla21lb0JOUmY2NnFwZ0Y2?=
 =?utf-8?B?bGpHeERTU0U3RVBsK1FhOEd0cG1Nb0w3RWlTdDJsQk9xS1dwNk82WU5oMndo?=
 =?utf-8?B?OFR0WUh2a3RKcDZ2SFI4YUpGSjlpcjZkR2padXdMUDRaYXB3c0RQYTBtM0lh?=
 =?utf-8?B?dDVkZndDQ2JtbVZ0NXIra1VuUGErOEZPb1Y4c0x3VEVLZS92c1dvRTVya2sr?=
 =?utf-8?B?ejNOSVd0ZzMyZFd3bWVxK2l3dEQ2bjEvU1A0K0xNRWNxWGREeDI4UkorME5V?=
 =?utf-8?B?aXh6OEVzRjRTK290TW9zWlh6d1ZsUVNZVnpsQ1ZWS2tKYm1ZNnlmelZGTDk5?=
 =?utf-8?B?Y25XbWxudklYbC9OZjBPRFZVZ1FIcVlOTzBPVC9NU3FOa2xjNEpka0lhdThH?=
 =?utf-8?B?Mlp1SWk2NElLcVdSQnE5U3JlUEFpcnorMGZ4dk5KWHBLSElPbENJWEhWbjVZ?=
 =?utf-8?B?LzA2RHRJYzIrSEd0S3Z3ZWhLdCtNUHVta0NZWHZJR2R1KzdBakh0RjhWSUg3?=
 =?utf-8?B?bUtMQTN1a3dkQ2FPR2E2V09nQTdVaVdpMUx3dEVmaHE4TkVpM09IaUJPeXRP?=
 =?utf-8?Q?r3GIdqnQV0KvfKfAjtq9z1b2z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f888924-8ce4-4925-1e62-08dcedf0b5a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:42:07.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBIbCZu5DEE/IeXKwRBs3sxpjJdpdeXDcziyvY9qOj/iD3Yd6NKiYd1QsD12ci+TwKsH4UZ5QnI1xnFzpg+2+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275


On 10/15/24 17:37, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>>> Then it makes sense that change. I'll do it if not already taken. I'll
>>>> send v4 without the PROBE_FORCE_SYNCHRONOUS flag and without the
>>>> previous loop with delays implemented in v3.
>>> So I think EPROBE_DEFER can stay out of the CXL core because it is up to
>>> the accelerator driver to decide whether CXL availability is fatal to
>>> init or not.
>>
>> It needs support from the cxl core though. If the cxl root is not there
>> yet, the driver needs to know, and that is what you did in your original
>> patch and I'm keeping as well.
> So there are two ways, check if a registered @memdev has
> @memdev->dev.driver set, assuming you know that the cxl_mem driver is
> available, or call devm_cxl_enumerate_ports() yourself and skip the
> cxl_mem driver indirection.
>
> Setting @memdev->endpoint to ERR_PTR(-EPROBE_DEFER), as I originally
> had, is an even more indirect way to convey a similar result and is
> starting to feel a bit "mid-layer-y".
>

I was a bit confused with this answer until I read again the patch 
commit from your original work.


The confusion came from my assumption about if the root device is not 
there, it is due to the hardware root initialization requiring more 
time. But I realize now you specifically said "the root driver has not 
attached yet" what turns it into this problem of kernel modules not 
loaded yet.


If so, I think I can solve this within the type2 driver code and 
kconfig. Kconfig will force the driver being compiled as a module if the 
cxl core is a module, and with MODULE_SOFTDEP("pre: cxl_core cxl_port 
cxl_acpi cxl-mem) the type2 driver modprobe will trigger loading of 
dependencies beforehand. This makes unnecessary EPROBE_DEFER.


What do you think?


>>> Additionally, I am less and less convinced that Type-2 drivers should be
>>> forced to depend on the cxl_mem driver to attach vs just arranging for
>>> those Type-2 drivers to call devm_cxl_enumerate_ports() and
>>> devm_cxl_add_endpoint() directly. In other words I am starting to worry
>>> that the generic cxl_mem driver design pattern is a midlayer mistake.
>> You know better than me but in my view, a Type2 should follow what a
>> Type3 does with some small changes for dealing with the differences,
>> mainly the way it is going to be used and those optional capabilities
>> for Type2. This makes more sense to me for Type1.
> If an accelerator driver *wants* to depend on cxl_mem, it can, but all
> the cxl_core functions that cxl_mem uses are also exported for
> accelerator drivers to use directly to avoid needing to guess about when
> / if cxl_mem is going to attach.
>
>>> So, if it makes it easier for sfc, I would be open to exploring a direct
>>> scheme for endpoint attachment, and not requiring the generic cxl_mem
>>> driver as an intermediary.
>> V4 is ready (just having problems when testing with 6.12-rcX) so I would
>> like to keep it and explore this once we have something working and
>> accepted. Type2 and Type1 with CXL cache will bring new challenges and I
>> bet we will need refactoring in the code and potentially new design for
>> generic code (Type3 and Type2, Type2 and Type1).
> Yeah, no need to switch horses mid-race if you already have a cxl_mem
> dependent approach nearly ready, but a potential simplification to
> explore going forward.

