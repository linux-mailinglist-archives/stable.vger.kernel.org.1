Return-Path: <stable+bounces-126652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D05A70E54
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DAC179E8D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B231B808;
	Wed, 26 Mar 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LUDhZOyz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hauQCUZ5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036A1F94A
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 01:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742950964; cv=fail; b=bcWD1G8blIS0xQ6OZ1EHcxePliojAg0YXs86in7n/qEUYm6wIIQ6ETS8H2XMP2IaTl0shnh6AtDa6D0eVZ7wviLlmJr0cKCRI8nTOP1SnNWOEMNbFvQZ+grpTP/1Pf+oK3uX63AQzk6L3rq00fuvxC/HWejpib6G+2riBmYay4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742950964; c=relaxed/simple;
	bh=jHUyW3BcrZFenbvHd0trP+h4RhPlsjZn3j1IUQ9T7t4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oJKRXIdxy5tCNeKsROLyxJG3aZxuA9Rb9s00m9Yu9hLbN7wz5NsPzhAX3FXCgKSWkAi9qVG1jwUuTuRlrBayJv0AP7g/1+UOE1UD6F7OBkVuwGv+nlMdcpMQk32bgQ81f9Xx5s8BS5ekqk0PYQEioG9khZLIZBlOiKMnpIhzubk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LUDhZOyz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hauQCUZ5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtvJg025366;
	Wed, 26 Mar 2025 01:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nAB33fnwEL010BQMN03nTdwOgEUCSjiUkQZ0PoqHcL4=; b=
	LUDhZOyz13nHDPyGmpTwdwKb2csthbz+mIK46GHCLpFkQl9dk/oFqvB3K+CYFVDM
	hU1zY0fDl8CLthO3z96XYy0PoeJA3sooS+jtAdI2PXzakCL9J46NxTXTZDBgVn0j
	BuQKaOrPLPmUOla2S1/DB43HjKNVSy0qMuLxBMfSU67Jey1gfi/6yC8+3V8ByRIf
	wtT4ClCkE3OQY913b8hFR50q3xxX7iWxKQX920jiU12+97cj4N5i3d8rUuAfoe8O
	ZyInoy6IQ9KpF09rFx1jYLex24ltV3c/lEhNCxvIEgErsjCUk3wnRs7F4DpkXCL9
	X/8XyB7o7CIQaEXKCMaKag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn870at7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:02:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PNjQDa008232;
	Wed, 26 Mar 2025 01:02:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6uwakx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjdwaqCHc9NTC5Qb7OC84GS3I0lwukeSqCekyoAeCdAE8DXCvbhG1bbO6OBJfpcyjJqhpPi9eCvkxSgV23nkRtUtECsDf8YXrjWMs6Y2Wg5t5WjjUIiEtAEbPyFZ0MnCvLhSSZvehsK6D8SXBCdgBrmH4gxob2EI+APapCSzR0wDaaCR5vnpL8dSEaPq8S6zdJ+VfsXIMqS51avxVOi0Z1UNVuAjvQ5oF0RwtBRF6lhofm64aN/fhV/BBSwnp+yf5VJO1uYSC1b4+6AcSuN+Ry3a6BHVipP05OHiCTlgabP8DyqQaH5tmgEFJgWgqrWPCgTQXff32t1SfcnarQIIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAB33fnwEL010BQMN03nTdwOgEUCSjiUkQZ0PoqHcL4=;
 b=NtsoipQwck/ozzpEosJYQsb/x7kDfv4CfmovZNA9nKUcsF5NcIIHDZc1U5u2QQhzlGOvETb3Ia9ndaetdnqXjniV+Bi8t9/F3MPrEpo2eM72UT1w9wSOhlrnm3LjH4uC0LGBcBfPl1lsmj6GfwXD1Qwk30+vsjoeTpKirseN40wlZKJRfx0Ccxx19n9jNdp1hYuAdzEbJ6nwtP4zl5uku0PNSe6xsMk3O89SxhYo62+dHSlMIxnIMCF37ZBH/B/TR5SolKjE6nWq09BUJ/ADHFAeyzSO0EiBwS7HcG2wyn+MyVo3Wb7339HZj1vonQh9tHboZgZiZREFW3LydXMGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAB33fnwEL010BQMN03nTdwOgEUCSjiUkQZ0PoqHcL4=;
 b=hauQCUZ5VLCM2CJG9nSbKtpZMitoFGVU5emXv3zFj5TyQqL6rk5bgJ67f5cQlrwNrf0+TgxNI8TjbKW8TpYZlV61mNKJ6Zh5JYp72qYNQct5aAIoaiHjdKJZfb9S4TeYPyO+81dneE0T1mSZXH8zoYuNoB4vwRX7b5yEy4tAiJA=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by CY8PR10MB6732.namprd10.prod.outlook.com (2603:10b6:930:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 01:02:25 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%7]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:02:25 +0000
Message-ID: <628164ec-d5cf-40c3-b91a-fe557b521321@oracle.com>
Date: Wed, 26 Mar 2025 06:32:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] virtio-net: Add validation for used length
To: Larry Bassel <larry.bassel@oracle.com>, stable@vger.kernel.org
Cc: xieyongji@bytedance.com, jasowang@redhat.com, kuba@kernel.org
References: <20250325234402.2735260-1-larry.bassel@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250325234402.2735260-1-larry.bassel@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|CY8PR10MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 234c5663-a04e-42f5-ff74-08dd6c01df36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDVtTVBCQWwyMW16NTI3MG0zbDhqVGRmT285VjJJaVgxZVRWZjV3VllGc3JR?=
 =?utf-8?B?cStiRVkrT1VmTTdKRWF3ek96TzdHZk9YVnB6Qm4zeWZ1cXlFckIvdSt4S1Ft?=
 =?utf-8?B?WUhyYVNlUGl3MGN0QXFNQXJrMlFBWks4TmpYTkFycjVsOGVJL3prZjYyOU84?=
 =?utf-8?B?cXY0ZnYzMER0bHhZSmQ1allmcGhsUFhKWXJ3T2o5WkhLRU1tcHhiNzZIVG5l?=
 =?utf-8?B?RWUxQVFadjlBZVRUOVlkb3J1RUVPMTFGUjE1SXFqR2dsbWVOc0RIMUVEbkRC?=
 =?utf-8?B?aFNpMS8zV09iazRTc3BsUWltMS9wUnhLUUNSR3Y2b0xSOTBRZG9QNGZLMlFN?=
 =?utf-8?B?Y2p5dGhvaFZ0ZUh4SlJpdXdZSmZwQ0xOSTBuZW8wOEJ4YlNHaG1JSm9TZEdM?=
 =?utf-8?B?M0RhMXcvVHRPWjhxdjl3RDZVazhlZHNOQlBjY1k4ZGdSNnoxZGNQQVlzTStI?=
 =?utf-8?B?cVpZb1ZrMVBFdnQyTWhQZENqL0FMc2U0WFM0ZXU2UEVOdUVNVXlkR2piOWZx?=
 =?utf-8?B?c1NQK3BHWXBJQkFGR3BsN09rakhXNTI3VldnNE85V2lzNXVUK282dUpVcXov?=
 =?utf-8?B?MFVlakdGQUxjc3BXMEtCNU5zOS80RzRZbjVELzRsamJhMjlaRk9EVEYycUlp?=
 =?utf-8?B?ZStCc082M0xPcys4dXd0MEhMT3Y2ai9DbjJ2M0hYZ0RjWUlWRzJ1VUJtUW0w?=
 =?utf-8?B?RllpWFpXUGdteFdGNUVidGVYT2wrQmpEVGxEcTFJUmkxbjNGOUNjcE5TYjFU?=
 =?utf-8?B?VDlaN0VxeEZya0FsY2JyVjZwV3AvNXNlci8zRWNzQUtuNVJYdUVwbVBCdDE3?=
 =?utf-8?B?bzJVbkpObmVycGlUS2FsODdlS3RBRWozWjVRTjg3ZEJlWmE0cEFYNzBsaWVJ?=
 =?utf-8?B?MjkyOFhpRU1Uci9GaFlsdzRhNHNnbmRjaXpqK21RYWN6aGJsZDBFK1BRYTMv?=
 =?utf-8?B?bWdhNUdhK3dJVm8vaVh4ZDYvZ2E2aUZXRTM4eU9YRFB0SEpQMVduVzREZUR4?=
 =?utf-8?B?bFRYVEI1aEcra1pVWnh6T0QranUxL2d2TGhyVDUyRzlEMll2MlZITTBrYm1o?=
 =?utf-8?B?T25BRUo3aFZvN0szRkZsSTgzSEQ1ejBWQ0JZMEZ6ZnA3eHFpY2pDN2t2cFFm?=
 =?utf-8?B?VExWVFV3VTdBN21yODNvMmFWRjV6L3p3UjV4OW04UTkzOTBXdnBBRnZRQk9I?=
 =?utf-8?B?R0M2c0dCbC95WVpiSnBKdC9PYzNxd1JHbmVRd0lISHM4MW1UUlZXRGQ0Qk95?=
 =?utf-8?B?N1A1b1liYVpmckI1d0tweFZBSjBCVjYvWWpFL2FjS1pEcTg1NVRmK1M2RHh5?=
 =?utf-8?B?aElBbzVuMGU5TDVxalc2dHEyUUZOOEt2enZVcEsyRHhjL1NPeURUcmx3UnBV?=
 =?utf-8?B?YlU5amVpL3JyZ0xoMTAyRE12b3gzT3QycXZ1S0luYjZkWVE4T0p5VCtUVHVm?=
 =?utf-8?B?UlJaei94VnlleW5yNlAraUFCRDRNVzJaSDFSbVBOWHpiakFiOUpQTjNxajB5?=
 =?utf-8?B?dkhkaG1paHdKOG1GMEl0d0pWUXNBZFBWM0s4ZUJlQVFTOXVMWENWcWpvbmtW?=
 =?utf-8?B?YnBTTmVmRGt6OU01LzFReE9zR28wWnVveVJxa1NtRUZxcTlsZ1Zjd0g1Q2NI?=
 =?utf-8?B?NmhzT3BjVk5jOWw1aXRrZCtuMzAzUThjZjJTYXB0U2JRbExxamd3U0EvYjRL?=
 =?utf-8?B?L3dyRDhCbTZLUHdJT0hXeERpWDQrWEVJWVBpbmtVMy9nSHlKTTV2cjZHejdC?=
 =?utf-8?B?eEJzRGd6VGIwMnE4a0RQdERkdHpxeUIraGl1NFVRa1dBR3JrYmxoSGNWTmdT?=
 =?utf-8?B?dGV5ZytaenE1VDdtOFdaYm1pc0hHYXZsMmZ0NXU1TDU3bk5KWVoyWnltNmdB?=
 =?utf-8?Q?zeLoAsVljefAH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhtUENRWkdRRW40cTJJTHdNcEhTNmZNWStEWHRzMkIvZWJEb1JraExvZkor?=
 =?utf-8?B?a25YRmZDQWVKcUxJMDZWMTQwVzFlTXdxbHh6VFA3Yi9neU1zMjhLWlphaFBy?=
 =?utf-8?B?WDBQejRLa1JCUE5KU01PY2lYYkd1emYrT1NpQlMyZlQwYk1MbHk4ajlEb25t?=
 =?utf-8?B?U0oxTXlJVUVOWi84S2g1WEhDWkF1WFNsZ3dqVUtuWmxmNW4xTTFqSEc5U01y?=
 =?utf-8?B?L0FIVHFZa01aNzhrNkFRYTZFSlBNVHpYVDhDais3azIwRThoN0RJMlBqTVUr?=
 =?utf-8?B?NWxlcU1NK0tlOWxza2dkTHd4K1VwaUowdzVCeFBXeTNJeFhId3o2VXVLcG51?=
 =?utf-8?B?SGxxQTMwSjBTcmdvZ20zck9Ya2taWmdveE5SeE8yOUU3Tm5zQU5pblcwWVJt?=
 =?utf-8?B?TFllM2ovVTl5L1pCdzQ0U0V5OFA1U0dlWXVHNkp6TVhzQlJ6RER5a3ZHT1Vt?=
 =?utf-8?B?YVNaL09kKzJlTks4dk5VMDR5bHJKaHNwT2JDMnd6Ty85K0plOXZPeThvSjlv?=
 =?utf-8?B?Mld5UWJMM2kwaDdHYVk4NXNLdWxaNHkxYytSMStvWjljTkpzZmNIbExVOXFn?=
 =?utf-8?B?dStVcU5pakJyVXBtcnMyS1RiL3AxRmFyVXQwNFdCV2ZCT09pTTNaUy8rTXZB?=
 =?utf-8?B?elBFTkVQNmswU2pGeENiUlorL01QQ3AwNm43QklQNG5OMWZRam96Ylo1YWdO?=
 =?utf-8?B?VmpGYUhzRjg4ZlBOeUVNR0RCK3FibHYxbU1tazV3VXA5WU5OUTExTnREcHNU?=
 =?utf-8?B?U0pNU3N1bnd5RjFzeUJLL3RNZzYydjlmWVB6eDR5QXUwbjIrbXYxS2pMeGpX?=
 =?utf-8?B?QUNZTlB2L0tYUU4zaVNabHkxcTMwS2hJVU1nSHdIaE5nQnh0MjU4Rzk4S2Rv?=
 =?utf-8?B?Y0pTeEVnVzAzbzR2ZEtScGgyajBsQWhKL0FwdG1NNjVVQVZKTGlJNU1xY25D?=
 =?utf-8?B?MEgwbUVxaklCQUJnTnZJTEcyb1Rwa0NFR0lTMzhGaXphWktjaHI3NXd6UXp5?=
 =?utf-8?B?TytFOGJ2QTNjYUp6WDRXT25nMmF4eWQyS05hM0ZkT2R5MkxWN0V4eVErNDdW?=
 =?utf-8?B?OFJKTkx2QmRkMUtmeUFhR294d0JPVzR6cldXeG9STWM2MGlNelRRVVVvTlM3?=
 =?utf-8?B?SlgzblpVWGE5SlBYMW8vNysyRkZnS2JYckoxaXdFNWpDajAvV2RHaHIvOEpi?=
 =?utf-8?B?bnowaXRyQUw0WFI1ajkvMjJadytGN01wRWpyRnVYbUlXMElsUTdwS3MwYWUv?=
 =?utf-8?B?UUFGTXY4VHBCcWtLR0NoWGY5Qm00TmhzNEZ0OS96bnh5QTJQOWFsYytQZ0ph?=
 =?utf-8?B?Q2NQcW1mU3RSTGZNYkIzd0cvdlZpb3pVd3JVbHhCamtwVGZvUytMRVhzUmJ1?=
 =?utf-8?B?bHZnZ2NKWTBCZ3Z2WEJJVi95Zi9sVGRubm5FSFNPOWcvMjFER0xDQzVzREd4?=
 =?utf-8?B?Qy9Pa1hSMWU2V0k0T2pDSUZBMGUvZlRmYzc5NkpZZkx2UFJPU2VCSDBLTGd3?=
 =?utf-8?B?UmhTS0xyOVR0YXEwQmhVamw5amtLRnFqNm55VTV4d2tUTSthR0wyUXQrTDdM?=
 =?utf-8?B?SnFWRVpLWFZsUWU2ZGtPTWlZWnZTcVNZTElURU14WUVZT1h3YkROTlI1R0Yv?=
 =?utf-8?B?MTJneERnRFpZUUs0Y0FsdVg3c3FLVC8xNk5HaFRONDBTa0E2VXphTUFNbGlR?=
 =?utf-8?B?eXlJS2w0NHFlSGJjTm5XNzRJWXduRXVpV2dpZVZ6cEUxc09FcE44eUlGRDd3?=
 =?utf-8?B?VGZSWFpPbllrVDUwelpMZEtXOG1ERkdrTnJCUXBOdllSZHJjZCtaQThkdzZC?=
 =?utf-8?B?Z0JxK1UyRGpWWG9Vejl0Wi8rNGk1ZE9YNHRnNStieEVOOGRRa3dGM1FQUXJ6?=
 =?utf-8?B?NG1vYWFTSVpKUmdELytSWWgwaFFzWGFwb0dGaUJWeitpcmRxQ203OVJKMlNv?=
 =?utf-8?B?MXJadG9TNy8yakdEdEx0WFZzRHhSb0Jpbmh6anZOVWNkVSsxTFdGSjdJem9Y?=
 =?utf-8?B?Lzgwa3JvQ1B0cDROMHo2ZWJpZUVLdmlnNGFwVGN4dVNoaTFiUzU3ck15QWxH?=
 =?utf-8?B?dUxaTXlnMGc0R3lqdU02UklrWFE5ejlCaitVdWdsTkJ5dGdsUmFBSm55NmQx?=
 =?utf-8?B?VkM1OXVEMkwzWTk5dVYxdlhiQ1lNNXMxOE5tNmI3c2VjbDRIUmlZV3FaVXRH?=
 =?utf-8?Q?Tl6HynEbgtYSItZWxs4Ubg0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vgf7F5G1+kLIQmbygRUkC1MoFukWMxfS+7SEX3zpZT6h0BxsZ12qe/AjE7IzL6Z8yndjKVZMqxHFIchD1yLHYnzzoSfoopjSreAVjJwkHvTX/RRHc5sfeyisSBCoAN96X7hn+mnhCgJKeb87D0r62Met+ie2u9BQDhipn2gZu3ZlTqe7VUpUC+6xDw2fs+ZzCwskB3S8AjtVN0O0grItPP/me2yNDfhFK4gO9Sm2AV167wK2xnVy7HGg+FQRvBPdRliaZtOHRmO1+egCEe195Jf4N4AdZ9rdJD3qyYxypoKBqemx3DR+PlZqphz9FDTJBaTGM0idEx/oylO8/fOzeAJUuXK2IuMz7s+5DjaiHi60Y5Eik/ebZTVj5sImnEvwaYGzy0BH8+sRcSJv9/7MNLx8otWSmZju/FXH+POqhpdjaR8fYKFPmuoNY50/bIFlFxEhLbgpxsh4b2e0ynkz5Z1hIvre/Wkqrk/OKZiy0mM4QgOWVDF9NuLFX4IpMVbnT1MHsywiaXUfP6AK8VNnyg838vPgUF3T8XQY/YnzZAE8L7MXGLmRAZo+iwGVOGLFEPguKbnNHA9XwMJuXgTbUzNKFo+dA5rJtmmip69SW7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234c5663-a04e-42f5-ff74-08dd6c01df36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:02:25.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffHtcsN77nXImxvFCVzNiGJOq6XIm9UZnn08Ta/uvbVNveCIDzMh/XStzglQnZeTqFesxjlfvoQEVMsZLii6KFXRIJacN5APGjGICoJpx2tIwnw6PefgRG29B4LPo8ft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260004
X-Proofpoint-GUID: H9RM4xnV0you0iRAfCmzHkcK3CPDXOKy
X-Proofpoint-ORIG-GUID: H9RM4xnV0you0iRAfCmzHkcK3CPDXOKy

Hi Larry,


On 26/03/25 05:14, Larry Bassel wrote:
> From: Xie Yongji <xieyongji@bytedance.com>
> 
> commit ad993a95c508 ("virtio-net: Add validation for used length")
> 

I understand checkpatch.pl warned you, but for stable patches this 
should still be [ Upstream commit ad993a95c508417acdeb15244109e009e50d8758 ]

Stable maintainers, do you think it is good idea to tweak checkpatch.pl 
to detect these are backports(with help of Upstream commit, commit .. 
upstream, or cherrypicked from lines ?) and it shouldn't warn about long 
SHA ?

Thanks,
Harshit



> This adds validation for used length (might come
> from an untrusted device) to avoid data corruption
> or loss.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Link: https://lore.kernel.org/r/20210531135852.113-1-xieyongji@bytedance.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit ad993a95c508417acdeb15244109e009e50d8758)
> [Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 9ce6146ec7b50
> virtio_net: Add XDP frame size in two code paths]
> Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
> ---
>   drivers/net/virtio_net.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 182b67270044..215c546bf50a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -717,6 +717,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   	len -= vi->hdr_len;
>   	stats->bytes += len;
>   
> +	if (unlikely(len > GOOD_PACKET_LEN)) {
> +		pr_debug("%s: rx error: len %u exceeds max size %d\n",
> +			 dev->name, len, GOOD_PACKET_LEN);
> +		dev->stats.rx_length_errors++;
> +		goto err_len;
> +	}
>   	rcu_read_lock();
>   	xdp_prog = rcu_dereference(rq->xdp_prog);
>   	if (xdp_prog) {
> @@ -819,6 +825,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   err_xdp:
>   	rcu_read_unlock();
>   	stats->xdp_drops++;
> +err_len:
>   	stats->drops++;
>   	put_page(page);
>   xdp_xmit:
> @@ -871,6 +878,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   	head_skb = NULL;
>   	stats->bytes += len - vi->hdr_len;
>   
> +	truesize = mergeable_ctx_to_truesize(ctx);
> +	if (unlikely(len > truesize)) {
> +		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> +			 dev->name, len, (unsigned long)ctx);
> +		dev->stats.rx_length_errors++;
> +		goto err_skb;
> +	}
>   	rcu_read_lock();
>   	xdp_prog = rcu_dereference(rq->xdp_prog);
>   	if (xdp_prog) {
> @@ -990,14 +1004,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   	}
>   	rcu_read_unlock();
>   
> -	truesize = mergeable_ctx_to_truesize(ctx);
> -	if (unlikely(len > truesize)) {
> -		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> -			 dev->name, len, (unsigned long)ctx);
> -		dev->stats.rx_length_errors++;
> -		goto err_skb;
> -	}
> -
>   	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
>   			       metasize);
>   	curr_skb = head_skb;


