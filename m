Return-Path: <stable+bounces-160459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08052AFC558
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 10:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924063BA154
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881622BCF51;
	Tue,  8 Jul 2025 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aBf9AO8n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YQScRiPk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B929826D;
	Tue,  8 Jul 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962900; cv=fail; b=BudMpIVQ7JIc18dpiZsMLkhYb73JESiv+J1yssJ6nZlwmU08lH/avgfGHU/KRemqiDG0cEZbvazrMwFumUuwggP4K9zXbzR1u/Dy9xGbMo82KhO+qm2VClCRmlMJNn2HotsPicz8r9AGrMH3JJ+uKIAFeBT+nfEuKbYTe+1031s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962900; c=relaxed/simple;
	bh=HKHwLgleluy4QeohZBir2dPpR6jvr2TxMSeeqps+Ipg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FPzrULwi/SEZALoqQzH/fslnRcwJLpZZxN0WcoUKYZSeMGHbWDZgpiF2IyXKlji6kPeJtxLI9wroaGtA5i0CF681gBhXzNCSphvoTkFfVWCfwhG+n51S59UsNcRuervVKyHSbNFBD+GxxEN0PiUievGO1hzGquIvmY6fd62MYQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aBf9AO8n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YQScRiPk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5688GwWe012895;
	Tue, 8 Jul 2025 08:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rWCE3BsHMewx+EBtk7LqHyQkX+7dL/+MC/46L8uh4P0=; b=
	aBf9AO8nU2Rnsi+Y5fmJGa5ioaOkLN5FeC6GxWspFQuWYy+pagJwfFwmu5i/Xzyg
	B933EGXpXteQVs4RkkK5yrRzNt+u+w8ZmfC/AVUjkx/iiP9CZL4Uv68zifzwClG5
	524yzDNwzfKqyrizqB/CX3zhu9Hea3jxRN8N12a9CIUdu/e9VNipyWtP26HUl3Nd
	z02wLAR4xK37if4X7BBsRuZTXyyPozsil6IrAofCJEfEeY8LoIKtl9tb7Z5cdrJh
	ZXs8OMJ8gYwo7X5/HNUNdvL+Q56G8cMQhBTGS6dYM4yeTffTZQRoL069ac/TtG5n
	7H6ECVSIzXKF4925o2mAaA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ryp5r05k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 08:20:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56870FKd014057;
	Tue, 8 Jul 2025 08:20:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9abab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 08:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSWqZlMMwdSFSOhoPr6RsnOOeWD7ohXZVOlE+gt6wc0CaBfyqmzCBk+IkQSMcDrPZ2H70iWASG0sFTZXphlQDglDs3C6Fk4VVdvDg9aOzjEyEAu8JlINsp9gfmHvRs2ZXFdKxXWr1K6evuff7XGeHAfJdzdeTObRrhYqj9AQ5vmAgmuzj3AhAmIiIGwODTZhA8ORZ/JhWiGbYtAW+wYbPvU9yA3gDHENsLZ9KaCntHV2RJxTJQ7J6IZTv/8jSzQ6FrS1shtfXoa0WdwXAmmsF+x/uVdWK+EElXrwWBkhrC4ke+B9m+5kb0k0iAFyvvju9RUSL2cYK3wQjQvLdjTcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWCE3BsHMewx+EBtk7LqHyQkX+7dL/+MC/46L8uh4P0=;
 b=yLoCvwK2p/nhJ0MAAPysuTVTEGOoTqtSFllEJU/ahlkCEe6GghUJ6jtvI/idVMtF9hB9dyTRQ+C79s2c51gAKSH+cR+AS9Z9EKPYNCLWB0ub0wcCN0fCoBq4JjeCm1oq1gDxN82xaxRlUkc+95GofA8DegCNolsZt7BeNz+Mk5AjWryZMkU85Ph8mM3rTSS4mZMQnNTB72jznZGiJv+EviBjjkM9EvQTvYx5wGKGHzx5vA3MKFSSxEX9nZVsu296o0qt3qcHWduIpQEAONDL2SUs9tUSGA+JRx68sxilq5k7lOQGghLKbScS9jJ6ZDD7K7dMx2seqnBF9HrGPUvJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWCE3BsHMewx+EBtk7LqHyQkX+7dL/+MC/46L8uh4P0=;
 b=YQScRiPkeLc2YgQdcr3b6R9UblQOip22oUC4vp1jwz/DAWNVjylU0UpIyBU7yi4G5q5gArFwTui7IHswKMrpFEyJQ9vtRSnVfmjANAEvTQV8Zo1cDe9sLzUMdyvM3RIJdTTF3DQ6mYOe2IzhC/fB+qTm02JlRloXRp+YMHutDzM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 08:20:02 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 08:20:02 +0000
Date: Tue, 8 Jul 2025 17:19:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
        kasong@tencent.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
        ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org,
        huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, mingzhe.yang@ly.com,
        stable@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v4 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
Message-ID: <aGzUpJsAmUDi6Neq@hyeyoo>
References: <20250701143100.6970-1-lance.yang@linux.dev>
 <aGtdwn0bLlO2FzZ6@harry>
 <CAGsJ_4yk5FPfieyRyzLwrgHu2CYADOtZRZKa0ORo=y4nYd-KrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yk5FPfieyRyzLwrgHu2CYADOtZRZKa0ORo=y4nYd-KrQ@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0180.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f966c0-c49b-4ddb-0232-08ddbdf83ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHg0WW1KK25sVzV0V0RDczdwZTNpVnRoQXN3WEdKVHEyOHJuL09BYzR0cWpn?=
 =?utf-8?B?OXBCOC9uMG05TDJ1Qi8yaEFaMVRldWkvL2dtRk9zSnc0WTFxUXdaOUM4Q2RF?=
 =?utf-8?B?anp0a2lkeVp4U3hkUEZ0SXdoMXFWLzNKVHg1TllnNVRuRFFsdTNjbzJuKzJn?=
 =?utf-8?B?SFlUS2xBVzkvRGFDUGJKNURudk1UVUFuS3Evc1krL1Z0U2FUS1BBakNrOVVT?=
 =?utf-8?B?d1h5VlAxUG9qWDN5bytoREg1TTFXcEJGMG00aHB4RklZMHB4ei96amNmSEhS?=
 =?utf-8?B?bWVjZ1FyUWZOd0k2ZS9QMWtadCttNUtxbjFlSkhJaGFTa0VSQ0s2L2M1UkZ2?=
 =?utf-8?B?NmJqRVV5VnRzdi9tL1dEWXlmNFMwS1JwOGM3ZDdQMUhzZEVRRHVLZlpKTU1a?=
 =?utf-8?B?TVdacndEYXpLS1UyL1NqMVgzaTlaMWZySVBQNW1WMW91WXBQTFBsZkhkUzh4?=
 =?utf-8?B?eG9XWldxWWhCZWZvUkIyc0poVm9qcjRCWERkQzJsWHBiM1dDbUUxSWZOY3ZP?=
 =?utf-8?B?VTdaZTI0Q2lHQVVma3NQN0xlUlJpRk9nZDdiaUl4b3phVkQzS3kvbDZKanVJ?=
 =?utf-8?B?NGhwMXBkRmcxaDNiRTR4WS9WNEZQMmg1MStNZWpWU0NSNVgwNzBuTmQ3emRj?=
 =?utf-8?B?Nm9uSVFkc1pGcDgrNHl3alhGK0JFcEpqVnV4blBLaURoLzNQUXo2SzJqVXVm?=
 =?utf-8?B?aTczQ1FYMUhHaGtlMHh0K1U2WHB6cEVJTVZibmpWaHF4eGhUWjdQeWp6aWYx?=
 =?utf-8?B?UU8yN25RUE1TcXlESmZrYkRScEdJa2QrT0ZPNUV0eTJUKzBsWjZlblFVZ2U3?=
 =?utf-8?B?ZU1mMHhPQ0EyRUZxOTd4Z3hDbnZKZ25RMFJXd1JleVNmS2VkMDJaWVdpTkha?=
 =?utf-8?B?K1V3aDh5Vk1NN1lzQWVGbHhLaW8rdGxrWUorek9LVUtpSktwSnBHaU9FWmFU?=
 =?utf-8?B?VGRQZ0M1dmpCdjVLdUd6L3JCczQzK092b3RDb1dxR0s0WVVtVC9sZVlhTlpV?=
 =?utf-8?B?NkNZbkZ1UTFCUjJ6Rm5hZFN2T1NoNjZLelJ0MXIvZFpxZEhxZ09SaEptcDJr?=
 =?utf-8?B?cWF4L3R2d25wWjJJQXZKWGl1VURscUtmQzVhNHE5REYwZU43RjFqTGhYZUxT?=
 =?utf-8?B?T0srdWJoWDBhUk9kdGIzNTluNHNaeFRzNkhvRzcveGg4MWVER3hCVFEzRnM1?=
 =?utf-8?B?S3dCRmlyUFhJaGYzMlcvTjMyTVRmR1RWZXFvOHhBM1NiblJqbVBtZ3F4THhs?=
 =?utf-8?B?S2VCd291Q1kzNlRZMHk4VmhxQ1lPZFJkN3UyK0U5TE40Z3AzcHl6UG5seVNK?=
 =?utf-8?B?S1ZCVFNjRDV1dXB0ajNlTm9JNVNmaWZ3T0t6NHhMcTRISzRLY3ZMVklwYnR4?=
 =?utf-8?B?akdway9pbXJKNHRXNCtWK1JGbDVBUUZYbVE1WGlVbXUreVIwbFQyK2hHSnpH?=
 =?utf-8?B?aGtvVlgzL2U5TFRGYkxheU5kY2ZrWFk5TTYrV0dJMkFGa29WT2dqSlVEczRS?=
 =?utf-8?B?SnlnQldGeWEzRUp1bXNCNG1JSDd1QXY2QU1OQS9VNHlPbW5CVVIzQ1d5ditH?=
 =?utf-8?B?WGxGOFd5aDB5OHRJeXN2aW9idk5vdUhrMTBaWWJuWG5FWWR4UWZadjZEUCs4?=
 =?utf-8?B?T09uVGlNTTRpNmtENm80WTQ5ZFBnV1hsb1hRUk1sSXRSczdOMUcxVnRHZjc1?=
 =?utf-8?B?SjNQeStPT3NZa0lMdkZDTkpnRVNhMXVHVUtJOWk0RmJuTGlpSU00d1NTcExI?=
 =?utf-8?B?M3NIN1pCMm0rVUpLaG1qLzNzbE5yTmx5SVpiUnl6aDVvQ0tqcUlqVlBlK0Nq?=
 =?utf-8?B?MlFHd3JIbFUvV2VBOE44ZDRoekVmUm5kVlJzWmNmYWFtNmZjY3dxZzNReUNk?=
 =?utf-8?B?NUlKd01vSDZEZWZtWHhwcjkvR0dnUXFMNU4xRWpKSUdKREJPblU5eXZkZVNW?=
 =?utf-8?Q?L0YRpnBTdoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHI1S0JBUnBtSUFVZkpsWU9SZGZzUmlpNmRsclc5UGQyNUF3QlJ4c0ZYTys1?=
 =?utf-8?B?Tm4zVDBSYzZvMmE0K3drSDZvT1RTVFVRb0lQODBxamwwVS83eUlJVUlFNmdl?=
 =?utf-8?B?Rk14dnNHblFrV2dTUGdhUzQ0RVo5UVJCNDhuY0NTTStrZVhTWEhXVmxNUnh3?=
 =?utf-8?B?Vk1HQzIzZk40T2RoTGJtYUk0aFRyNVVwSnZVdi9uMmRzeUpqOFBiOUJTQ01T?=
 =?utf-8?B?eFN0WmhRdjRkVUFVYWRObnlXRVhNOWVLNGg4VU9OY29hT3BVUjZOK3pVc0Iv?=
 =?utf-8?B?NkQ2NEpmdysyUTNnM1BvU3JwbG5QcHFSUHlPTTZ4TzZ5UnhJRmhpNHhteWV3?=
 =?utf-8?B?VFBQUjRqV1l1Ry9Yd3RxTm5KN2JNaTRtVC9SRGNlT29pUFIyTThwVndGVUlJ?=
 =?utf-8?B?TlhySll2emZZUjdqQVFQL2J1WGM3dXBBdVNWbVlxenlMNWRBNExmNlhLT3Jl?=
 =?utf-8?B?eXBoSXZTZnV1ZFoycUo3bzVnbkR0VXVuKzIyOUVKS2JWckppNDMrUFRNS2tO?=
 =?utf-8?B?MVpHVGR0MkJEcmIyRWl0WVowTnlHc3gxeUk4ODdIVjBNNHVHWStHYUR0Tjcx?=
 =?utf-8?B?NG5QR0JoVWJKOGtPcEpzTUhwdk5iL2FLS1pNclZrYS9vQm9YTnlpWnQwRGxG?=
 =?utf-8?B?OTQxK2NmZUlucGNTWkZ6YVVvaXRCT3B1aWhwVmtRUFdHWTh3bEl3dVpoV3c1?=
 =?utf-8?B?S24zSUx4ZmZzNEFGV2x0TEV1WmZrMlQxM1FQSS9JbjRzbm51YzA1MmpVNXZH?=
 =?utf-8?B?REdLMXpYbHc2V0d6VnNkZlBlR0g0cmptWEgrc3RhMVlJVldJZXQ3empZM25X?=
 =?utf-8?B?UWlEYkpveUk5dmNCaFlpNTdlVTBjS3BvSlFQTUlyajdHK0ZzRHhKR2hEUmZ1?=
 =?utf-8?B?bE9KdFpjeTVvYWFjaHRHSm1PMUUyeW0ycG5ObVFtekMzN1E0cnJsSEdSU0lN?=
 =?utf-8?B?RW53aVphaTRiQXZCVWluWFMzT0tTbHZTSmYwdFhXL2plNk9KZVJFdGdaQ0l0?=
 =?utf-8?B?R0l4cnNkdTNCOU1IU1JxREJraHIxMDl6SVhnSXdVZkgzdDNsUUpyOHB0ZTIv?=
 =?utf-8?B?cWNvQzhoQ2lxSlN0Nm5SOGVtWlZuYTdxS0pObmFGdVBicUdOVkRBVnIyUmRj?=
 =?utf-8?B?V3FMb3A3LzVvckVwNzNINjVWczNkVXdVdjhkTnRqdWh4RDBDNlNLczhVVDZS?=
 =?utf-8?B?QWNMUjlHTnZCN3cwM2J4QVBaUCtvV3pHeXdRaHVScUl1Q0IvcTR4OXBoN0tK?=
 =?utf-8?B?RFRqVGVWZTA0Y3hxTHdzMWEwSGFiNjVnSjREQVZ6U3Jpc0MvSUc5V3JrVmNm?=
 =?utf-8?B?bWxPN01yemlYZjBTSEI4R3p2cGs4N1NheC96Yit3QXpHaHNpYkUyQWhwTldB?=
 =?utf-8?B?SDN1RHFVQmxrV3ZlWG5ONzg3MEg0UEJROHl1dXhSQVBZSEozRGRsSGxCQVVt?=
 =?utf-8?B?dkVacGdBSVhEVGlWdTdXQjJyS0QrRkhJOTNzTVNLeWl2aHJLdzE3WWpuVnho?=
 =?utf-8?B?Y2pwWUdGWU5HYmlZMjQwL0pEOFo3R0Z3cWswZWFZUnRSUVRMbXpORVI0aG5h?=
 =?utf-8?B?WnB1V0U1amk2V2M0UWRuUVVkRm9jRFFLUFA2Rm5VVHgzQWZmMjJ2cTdJa2FN?=
 =?utf-8?B?NFZZbUYyT2lCZnl3V25Rdk4xdFdSdGhrbnNEdW96c2xmeFh6UnJCT3lWeGZ4?=
 =?utf-8?B?Z0JiK3Zya1dTQTRSU2N3aXN6MXBlUlJtSmVvSTJ1QkUwZnN6MER4TE42TXQr?=
 =?utf-8?B?dHYwbHl1ZlJ1WjY1OHJ0dHpCbWJ1MlRvVVFETkRUYVBPNmIxczNQVjdvWjBT?=
 =?utf-8?B?MWVjcHRiU1lCZlROSTdaOFBNTlI1KzdmTjI3eVMySWNCZ2t4eXAxTlZKdVJD?=
 =?utf-8?B?bGZ1ZTRZZGIzSkR6RHMyZGhsN0x1NXNkL3lSRGhNbklFdHg5anZ1U2ZrV3M1?=
 =?utf-8?B?akczUWNHTDRnMHc2cEhtR1Z0K3JEYnJQUnpkamtmeTRya3loT3JCVk5PbU1Y?=
 =?utf-8?B?QXFkLzhoQ0lkRkQ5UW80WjN4My84MElKUS9KaHoyQ0JhN1RuNGN3c2hFeGc0?=
 =?utf-8?B?ZE55VWNaejh3aVZkZHUzazVlWjRHTXAvblZ4Y0NXU1c3N0RaSWpuai9IQWJY?=
 =?utf-8?Q?k6jY6ExtxojlS7AELcZvKcWuP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R45sv7Jn5G3N+3wyfLfiYuVHFFzLwFBIECfkd3I8SeMOPH/WpFbCOseaQhNGZvsSi7xt5LXYR2ovLpKJGfVRdoKZt6f4MGpzF2kchaxlSzHBtJ2459zUqSplm71nUKH/aXWfDdcATCFL0Y/f8t1DfVkCV9Xa/n0krmaCSqNrff+ElmMibw9sqWIIdP2VCUuR2MfR5DgbB36NPP5d1YxuTAjJvbwn/JRlKlCtH+lNJIoVBqPQuwbtVKPBUGt+W+bUoqn+bhtuUJ/EtBLeD19Utw9FHBst4zpvHeqGsHQuahVOP1ykfx9rwqxJ2mdBNRWfN6qYrrvBQIgjPrICG+yxiZ8E6zFKF7nqwvV+O3nAagNfLUeoWJC2TcJuCVgohW8A/Jicw6psNodT9fDtY0OGJEu2H3j0H0Nycz2q5EJeTk4qZnQ5QsdXGjLO57sPUf9liexnddMt6gzuxopQqoLbVa9AiJP/BLkQo6aOKQSgwD7Yls/mb467guYlhKqS2o0S767gSJZizBlyFsV9tilw4FGW9LdUPXlsh9klecsSk78wCKm05LuFG6XZC5/kEeRBYjp6aG6zIty42A2f6uBtitywLAm5HgC+zv6S7YC1kSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f966c0-c49b-4ddb-0232-08ddbdf83ca4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:20:02.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6HBbraGYpR5wK6x7NNm95TLVGjuosZV2dRAGOtHPCExDKquMpb62sCraax7WC/4WFHgwtmIpM48doZeHsJLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080067
X-Proofpoint-ORIG-GUID: _jXjmOEI3b0sOih1yqCSAbJooBlWdHAU
X-Proofpoint-GUID: _jXjmOEI3b0sOih1yqCSAbJooBlWdHAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA2NiBTYWx0ZWRfX0xXZDKqUDW2h 3dOuc7Vpy9oSBsM3CsqC1oJQqUkr09oisETg8Ae4nRBgFNGDGLjGjglJQZRpvEij2AD1F9V357d 0iQ8GyyC44SPbyrhNzQBBa3u6v9F+FGdPIiTYJMTL9GawzmGTuD9yhr1+/MvGkZqE5J+Qsv3kTv
 HgCkwM77KanHS8LMjHRtXbGI4ZK5V4ZRmsQ5lgLkgov2dHD8ow0yl25GDNkUqXaHMbrNknzdipa IQfrcCO/oKFsPostd+Q9VrCG/iGG99q+lkXUryFywAt8b+e9ZbUdEjO2oRtgc+AGx07FPZ+NK9M BbwCG41KXRRtUop+nRrhR9YtM2Kk1VC86Dh4JW98GCw9sUopgPieD2IpzngPRraOjPH5argjKkJ
 uGTatD1K7304qoMhAQI+RL+Ji14iYjzyl3kdVt1F+QTE3VPqjDaAnLcCWbj9tjnJt7JbBwoy
X-Authority-Analysis: v=2.4 cv=EtPSrTcA c=1 sm=1 tr=0 ts=686cd4b8 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=gKLJ0jc5FbzXRXBV4SgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12058

On Mon, Jul 07, 2025 at 11:40:55PM +0800, Barry Song wrote:
> On Mon, Jul 7, 2025 at 1:40 PM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Tue, Jul 01, 2025 at 10:31:00PM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > >
> > > As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> > > may read past the end of a PTE table when a large folio's PTE mappings
> > > are not fully contained within a single page table.
> > >
> > > While this scenario might be rare, an issue triggerable from userspace must
> > > be fixed regardless of its likelihood. This patch fixes the out-of-bounds
> > > access by refactoring the logic into a new helper, folio_unmap_pte_batch().
> > >
> > > The new helper correctly calculates the safe batch size by capping the scan
> > > at both the VMA and PMD boundaries. To simplify the code, it also supports
> > > partial batching (i.e., any number of pages from 1 up to the calculated
> > > safe maximum), as there is no strong reason to special-case for fully
> > > mapped folios.
> > >
> > > [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: David Hildenbrand <david@redhat.com>
> > > Closes: https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
> > > Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
> > > Suggested-by: Barry Song <baohua@kernel.org>
> > > Acked-by: Barry Song <baohua@kernel.org>
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Lance Yang <lance.yang@linux.dev>
> > > ---
> >
> > LGTM,
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> >
> > With a minor comment below.
> >
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index fb63d9256f09..1320b88fab74 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -2206,13 +2213,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> > >                       hugetlb_remove_rmap(folio);
> > >               } else {
> > >                       folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
> > > -                     folio_ref_sub(folio, nr_pages - 1);
> > >               }
> > >               if (vma->vm_flags & VM_LOCKED)
> > >                       mlock_drain_local();
> > > -             folio_put(folio);
> > > -             /* We have already batched the entire folio */
> > > -             if (nr_pages > 1)
> > > +             folio_put_refs(folio, nr_pages);
> > > +
> > > +             /*
> > > +              * If we are sure that we batched the entire folio and cleared
> > > +              * all PTEs, we can just optimize and stop right here.
> > > +              */
> > > +             if (nr_pages == folio_nr_pages(folio))
> > >                       goto walk_done;
> >
> > Just a minor comment.
> >
> > We should probably teachhttps://lore.kernel.org/linux-mm/5db6fb4c-079d-4237-80b3-637565457f39@redhat.com/() to skip nr_pages pages,
> > or just rely on next_pte: do { ... } while (pte_none(ptep_get(pvmw->pte)))
> > loop in page_vma_mapped_walk() to skip those ptes?
> >
> > Taking different paths depending on (nr_pages == folio_nr_pages(folio))
> > doesn't seem sensible.
> 
> Hi Harry,

Hi Lance and Barry.
 
> I believe we've already had this discussion here:
> https://lore.kernel.org/linux-mm/5db6fb4c-079d-4237-80b3-637565457f39@redhat.com/
>
> My main point is that nr_pages = folio_nr_pages(folio) is the
> typical/common case.
> Also, modifying page_vma_mapped_walk() feels like a layering violation.

Agreed. Perhaps it's not worth the trouble, nevermind :)

The patch looks good to me as-is.

-- 
Cheers,
Harry / Hyeonggon

