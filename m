Return-Path: <stable+bounces-158424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16450AE6B37
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C613D1C41FE6
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6472D542A;
	Tue, 24 Jun 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixII9B/z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fdXI5sPc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B52D3219
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778085; cv=fail; b=VJHN21BKFSm1cexDkBKSyFCpuaA3kvdb+IUR0UUOoTle6jis5HTafX16YxXliGYAEHzhKKA/S/Xz7uc8QVD99/hkijp1CvdHA+Z6QTnxPb73KMDBwX+kgybiXRfD4yUxHft5cklCkbcZGDFskp4WKb1FIZql93ZjlWEIMFHp8lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778085; c=relaxed/simple;
	bh=7xUcKgUI80npf2P/tB+ExtZcLN0KkMpjZX1/V2ca0tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ceZqXfNU4D4acgyHOdWyqYBjzF9Ry+SLoeg4yvWa8iuytnLuGIEQUqfLCYkvPZcMcOYewXPW4s11zW9mPzfAhZHwXf2wtAlRdLQGLFAJGdkrhp/Gr2oFT+DNSCDIMJ0WrsLpQown+oxUbBe2sU8lemYH5+d7lSsLnGO0i3FlrLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ixII9B/z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fdXI5sPc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCiGb6025836;
	Tue, 24 Jun 2025 15:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kBeHeNT8QkYpfUELwrPBC4I8YYoWReBijfa1JToZxuI=; b=
	ixII9B/zrdhWPFyqy5Ddi3d4vaUC2M/7C3+66hq9otB3/vzrLz9pmMMhr76pi03/
	6OKpVibRHD9mt5bT2NKCa8lFTzJ9wNOibE0eCMQsY/MVVUO4FdtexVE0/FocJKP+
	UlIMkCluSWZQ/ZP7qu9TBsek7dgeO8QDagEgBWF9CDumEdJccB3Uuzl/q4qUa2a8
	v3xtmVnPtapY363JTF8RxB4l+cjCxQJkxTrzrjPgBKpU1zqfDDk8mdWgxB5uPL4z
	WH+Q9UaRPcrYH1odkIpAD9VZ5lhRHq4YZRAXg7jwi/HRUTyXXZaZ84UuxwD3BEPz
	IHO8Xt0DEzqZi8U+ZY6T/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uwdwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 15:14:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OEJEFh002108;
	Tue, 24 Jun 2025 15:14:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpd8x7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 15:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTitlX2tY5qKSD4JoFGJqqPYe4MZhbc51u0jC9Oo3e2SIaHU3fvPpGrdVpLR9wxKt7KbmhsDm7HnG2/LaS+kVWKPuzUujHv7yvGaDZOGJxeq8dpuzWlK571+oh54a8QcJupNKsdFgjzqVtICLz7+vq5oRFrTFzAcBXTj0NEwaylBXB3DXnbSDU5hMtaqCDnpRHLDzAexr32xnLM0jI0rDUOLErRhYPUGuJyr58ailLL1ozUwi+gnhKhYSgQ+EvVhBpsPXmX0cRQyhGJ6s4E/OKKFVcbDMadRjyu5Gud37fYIT4kK6QjFffNlCzGpZQA+QlLadCEQRKgXxPR7jWPOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBeHeNT8QkYpfUELwrPBC4I8YYoWReBijfa1JToZxuI=;
 b=DOyfoUL9JTl1hkZsVL2aCQ2GVObVFc8fVH+wt17Rg5cfLjawtKAd2pE8tDQYqkOmvmffKmzRUyKK0PssmlQ+saVqRNXkbLcCft1kbvgwfG/Rsmd5LMZ0YRA1Q0wH3+DJ1UpisGN4EPw7bjTyxtynutIybRRU54iNasbld9X/r+T6NdQVNTvEizvR/VtnuUN9yqbyZPfrxP15MRD+S7GEgnF+yt6oSnP0cCt9+fgTYSGXOEP+uf6vnz3FQSvaXMjiYk3XUh1CmehbdCcGRJ1MT7VlNiLYVsSb7vP3JRQV4aoRgcK7o7pwnzGDO98mL/sGqQ5Y6kvN+4+khqeaek9CPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBeHeNT8QkYpfUELwrPBC4I8YYoWReBijfa1JToZxuI=;
 b=fdXI5sPc6+NRobJNHtrTDURbfXD58py0y9AlaZf5IlKuxDz0g5wAQCnOe1F3neVgppyOt4HPIozA2SE59gW3BavwHUAcKdvlIVlXSqR0JwCNvlMq7HfPA3TfLhlaGWrNkirQwRqX9evY43KfxRlpG9b1OjMPxT1YRWwU3koqUuY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF311374B40.namprd10.prod.outlook.com (2603:10b6:f:fc00::c17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 15:14:20 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 15:14:20 +0000
Date: Wed, 25 Jun 2025 00:14:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Wang <00107082@163.com>, akpm@linux-foundation.org,
        kent.overstreet@linux.dev, oliver.sang@intel.com,
        cachen@purestorage.com, linux-mm@kvack.org, oe-lkp@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()
Message-ID: <aFrAwJEkjYFAuVOa@hyeyoo>
References: <20250624072513.84219-1-harry.yoo@oracle.com>
 <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
 <aFqtCoz1t359Kjp1@hyeyoo>
 <2dba37c6.b15a.197a23dcce2.Coremail.00107082@163.com>
 <aFqynd6CyJiq8NNF@hyeyoo>
 <3942323b.b31d.197a2572832.Coremail.00107082@163.com>
 <CAJuCfpGd+jHoCdyuEbk5h-dbQ7_wqgX=S4azyb6Aou8spzv0=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGd+jHoCdyuEbk5h-dbQ7_wqgX=S4azyb6Aou8spzv0=w@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0160.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF311374B40:EE_
X-MS-Office365-Filtering-Correlation-Id: df63d99b-b6fb-41d4-3ff5-08ddb331cb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHpNc0prVWZ5VUhtdHNKcERZcGRSQ1J4cVAxcVVlN0hjM1p2MEIveUVUUGRv?=
 =?utf-8?B?cnlTeGFzVG1lVmZsalJzdnFUVkN5SDAxdmxjWHp3ZjlUOEIvcmxqZHVMbDZV?=
 =?utf-8?B?cVZhOStaS3EvZiticStyL0ZxK3BqczFSSHl6UEpxMlBSbGYzQUUzbjFDc0Y1?=
 =?utf-8?B?K3ZpTllmSU9GZHNzdHRlZ1VTdC9FYjdXSjFlOGh2djZ2bXJ3ZktJdzExUWZZ?=
 =?utf-8?B?L21iTWp6M2F4bXJBTXEvN3QwSlRyaFI5YVlUTjFXVmRBWTRaZmRhOG5FRGRB?=
 =?utf-8?B?YzZQKzZXQ0xHU0dITnpZMEZDZ0x5Q1YrQmRDT3dnOFlicDVROXdMMW5YZmx4?=
 =?utf-8?B?cXg5bGRjS2doYWlkQ0RtL1hNRXREdHExU2ZUd0g5dkhJU0NTNUY5TFRoUTM3?=
 =?utf-8?B?Z3kzODh3bHBuSjIrVm1id25OYUZadkg4amtsc0xnOUdyS1dVK2o5dlpzbXdE?=
 =?utf-8?B?Sjhaa2ZKWWtMbmhwWC95QklXazhQYzFsQTdiNHRtcVhZMUExc1k1Q1Q2Uzkx?=
 =?utf-8?B?c2R4eDh1bSt2VExORE54WmVMalFuZ1hMTDNmWisxVmQvK21IUzJXV052NkVD?=
 =?utf-8?B?d01WK044YmgyKzlzTVcyM1ZUckhiNlZqdElGNWxjQWlKbVBBWitBbUJvSFdW?=
 =?utf-8?B?MklHNHdqVHFDQkpJek05d2poZzc4dDdWNW5pK2d3UDhJNUh0MDhtQXplbktE?=
 =?utf-8?B?RUlIeTBvdS9wUXI0WkZHa2dMRUhTb0pMd3k5QnlIcDA5VWtBb3RkRi9LZkFM?=
 =?utf-8?B?K3ZXM1JPTDc4M0o1cGJib3FiR0xuTEpDT2NHd2ZpT0k5VldWZjIwRnFXc3Z3?=
 =?utf-8?B?cmZNeVhqNlRDN1U3UVZ1d1RHVHE1VlQ3bVlrMTNyRXZhaFFFY21KRTE1MFcv?=
 =?utf-8?B?RkxHUXFYaGRZY2swK2ZycmRWY3RBbU92OEZjazRTekVwR1RQRzBSUlkreTd1?=
 =?utf-8?B?YklHdXQ2UXg5ZGZTYjFTS1M5bjFWbEtuaDRlZnJRdGM2WlBIYlRLUnZPb1V2?=
 =?utf-8?B?a21ydGtVaGU2NFRMM0VaOERZTktrVVd5SC8zeDluUHVaclNGTU5ITjNCNm9U?=
 =?utf-8?B?V0VWVkEyS2czU3g3VnJTUks5cUpmbytZNmZqVVhDTm13U3VoeTBibWdKSDRh?=
 =?utf-8?B?UTRBaUQ4SmVqamp5SUhUbjhVZ0xFbHNCay9QSzNzZWRzRlJyVjlhaFpRR3BG?=
 =?utf-8?B?djlwK2llRm11TnMySXJZNUVCclFJd3pCbU1QSTVxZndxZXVreENuSnErS2xP?=
 =?utf-8?B?RmMybXpYNFJpVjYwNTk5ckJGTy9OU0lzbG1PZ3BsMHJDcFozSXJIazl3N1lG?=
 =?utf-8?B?VjhBQWdlc3lDTGhEeEh2MEdGSDd5aHJ0UnlPSUVZeDRxdEVETGlGUldBVGlS?=
 =?utf-8?B?VUgvclAyUDV4cjczQjZ2QnhIQVpvWExndWZzdkhSVXh5eHhxL3crbnVHbmk0?=
 =?utf-8?B?a0xGMDU0VG02MHpBd0NoOUZncktrZ1ZsOVo4R2pHWEVTMmtEdmJZMWozTTJa?=
 =?utf-8?B?Ykw1MHZCTHh6eDFUa2U5OXJyZEVDQmNKeTd3WnY0aitBOWo2MXduMmNpanJL?=
 =?utf-8?B?a0dlTktrYTBGaFJaVlZFU001M285K21MVjNBSHVVejhOaHd4emNFRm5TSTd0?=
 =?utf-8?B?elljV2ROK0FnZDZvSENnR2pHVXNNdXNqaDY4ZU9sYzNtOFl4TVh1bFYrWnhT?=
 =?utf-8?B?SGpWMFczcENYMFpWWXFqTDBZZmNCTkpxZVlERmhzKy9UUzNac0V1WHVtUC9s?=
 =?utf-8?B?R3JNb2dXbGl0Rm80TVFqWm5VdVY4MDk0MDlRR1I1Um5wSzN2MThsQSs4S3h4?=
 =?utf-8?B?dlR5Rm9DOGpFUHU4Nlh0VWl5Z1oxWklTc1ZlWldHaS9FSi9KVVVOWlRGRFVh?=
 =?utf-8?Q?y6NBE25qwk4aY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9HSXdYTEk5bnpNTzNpbFNSL0VHMU9DcCtQeWZWemJFYzVPTmtMQTNRT1NO?=
 =?utf-8?B?QU03MnRBRUZ0SU4zbzZCOUpYbGY5MW9SMG8xdzhJVkJYWHRwektYdEN5bEE4?=
 =?utf-8?B?STRDMzU0YXQ4UVBGYVZnS1hBeENJaXNmeis5S2txNi9VQlVWQ2RzSTlsek1p?=
 =?utf-8?B?SlBQWTU1OVc0M3ByUGZqUFNJMHJBNkZUZFpjMGhsc3MxaVhaZXFzME05Tmpm?=
 =?utf-8?B?VFJ6TEJHNEpqV2R3b1Zra2hRaDhCZFk2c1ZieVRWTXhPRSs2UFo4ZDNZRVp2?=
 =?utf-8?B?MHpqM1AxZFludjhVdHJjMm1wYStTR1o3MlRDNnpETGV2cFBGWTNOZ0p2RCt3?=
 =?utf-8?B?MjNCbTFVQktkYUFvQjA1dDd0MHdrVEloYUk0aE1PLzFBcW5oQ05CTHIvWXZB?=
 =?utf-8?B?OXFQWmlBTnM4cmUvN2lIVFV3allURHlxSGM1TmNlbHg3ckZ2V3pJUUMzUVpZ?=
 =?utf-8?B?UU1NamdpRXVKUllaQ0s5QW9mSk1zNUx4VnRJZ3ZDeEo0KzNJbG52YWd3NTVL?=
 =?utf-8?B?Ry9HbVhYdmJSRWxScXZnZFdmTHQ3Q0VMZDViRU5LNUpWNk5XWGlsTW5hOUgx?=
 =?utf-8?B?ZVA2MTcySlFqL09xTUxVVXJOOSsvYk5Fc29CNWxsLzRqTjFmNEFDUndTRWRB?=
 =?utf-8?B?SVhjVUYzRnNxVVdXMEhTOEUzaDR2dkFvK0hpemVXMDRqbzA2L0JzdC9WdEsy?=
 =?utf-8?B?R1JpL0xZN2JqQlNtUEdRYk5tU1FQSnZoZ3RTUnVYVTkzZXJManRVeFdlYUVZ?=
 =?utf-8?B?cndCeVJrdlFCemRiRzRXaUV2MmhOV290bVpWQ3hvNGdTQ1BLUkFiT1ErTWF3?=
 =?utf-8?B?ODdNb0lBVXU2clhNUlN0dG0xa3g2NG1lQW1mVGprVU1FWi9lWktEL3lnY0FV?=
 =?utf-8?B?d3pSSWlIdWpFNFhPWWJHd1VpL2tJUUtWTVl4ampzZjVDRk1GSEJLMk1qWmk3?=
 =?utf-8?B?Sy96R0kzQjdNbkZIUHN2ZDFwZmxYcGtId3dJRHRxekw4Q3kzeXh5cGdaSEFN?=
 =?utf-8?B?VTV0NmQxeFFScWE5YjFPbGZnVGs2SU90VnFDZzBNRzVSTjhsTkRVQVd4bDhC?=
 =?utf-8?B?bFUwNVEzZDBxNjcyM0NLU25OV2RMblovZUQvczdQSzJ5N2VGNHdjNEVaanh3?=
 =?utf-8?B?UlFETUJDamZqZ1RPZW9wek1maDI5TFBtbEExbC93aTdTUFlDQ3hnQ1lmNXZM?=
 =?utf-8?B?MHJGb3dlSmxoNVlKUExWMGloN1RVRGdRZEMrU1pJRUdqVHpEN01GVWRicWVp?=
 =?utf-8?B?aG1aUzRYb0hNTUpqOXdnandiMlJKb1oraTdPaE5ZV3puYTY3MWtPekpjR0hh?=
 =?utf-8?B?UXkrTzZ2VVB6M2VBbmNVYm1sRG16cUw5Vy9vcmZJZkxqQWF0YWVEdFlBdFBs?=
 =?utf-8?B?eWQ3dGlhRnlQOTJSazVSaTU0SStheTBuSTYzWXVwaVNwSHkwcHAvQnRFVUY0?=
 =?utf-8?B?SlZTQkM3aFF6UEwwa09iM1N3djZpUmlsck51REF6SmZmYy9QbXAwVy8vUlI4?=
 =?utf-8?B?TEJrQzVrdit3V3RHZU9zUlpCTG1aM2E4SGd1emR3cWdIRWZvQTlHTnRNVmN5?=
 =?utf-8?B?anl6MHVucDBrK2R3ZmpnMDBoSG8wekl5SFhiOUtsOENKUTIwNXh5UTlUeDlx?=
 =?utf-8?B?K2ZkeFFTUmIvcUZ3MEVURG5UMU1iN05yWGdQN29hR1c0c2tXdHhCU05VbCsr?=
 =?utf-8?B?WGp5TXF3VXdEVUZHSjhsdWh4OW9Vdm5pU08vUzRFRVVRdEI0blowVDcyQ1RP?=
 =?utf-8?B?Z3g0ZFZvOHVpT05pOEVtN2o1RWF1dnAvei9veEZzeWVHVGdlWnA1N3RFMDVG?=
 =?utf-8?B?cTBYOEhUS29UakRkVUF6SzErYjVRVk9BeVZ5a2QrOEY2MytGR2FtVXNLMVBU?=
 =?utf-8?B?YXkveExRUFRza0ZneFhIRUtpTVBCc21XSDA5dHdkTWNvcFV5ZEcvOE1ITTNo?=
 =?utf-8?B?K3Z4MFlIOU4vS29KWm5xenErTXZZZEI5RS9oOGo4MXhHOHY5T0ExbGQ2M2lK?=
 =?utf-8?B?eC9RQ2NjOXphazJ6S3lreHVZV3dRN3ZqeXNSZjV4TkJaYVJLcDhFSkFsUmxP?=
 =?utf-8?B?MXN6UGJMbU9BcGNGWHRXWHE0L29vcnEwUjNMMGd4elE4ZXdiYWlsd1RxMFQ4?=
 =?utf-8?Q?PJx5dRyp/tSTJVdOU6XiuI8AF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VgrvTSrR3iJoe204pkghZ4MwoHwAmHMIwlLBjGHoS87R1siWSj3zvUBMfi1It3+DqQ91MnO+dpycyrr2qZdVgeWsCFgthfObTfgk5rtT7XKUsChsXzuk7h8Bw0XYhGu38IGARdtQVy36zurn2qjmqRfLCK8u72+dvl2rMx667TsKEQLc02ZlvuCdRmvx6BF69OfHewKy6Qa1KWFZrzdrG4SZOdMjgPATYtqw7wcxgY2gC5QKGnbAH6bc1aR8ls8p+jqqQXcLD8ucAJdyrZF4QRLGL6MtO+UmRHHR5xLc2w6VStCEti/J46CdoBKZneoOQixmBspw2xmAB94zGsCN3C/Yqpi+bwTBrHWoYOx4DJzMZr3X59i7l+vJdbXROzTWZfOlT5RP36z3uqRLhDFKijJwYNsO9H7VFtfc3SHkxSlrjpviSQJp1wZvOJfqlgeocqh/klsnhyMkDzPcq3h6oMZFr13QoHsGqKSPjrDUqAoesg8YhGGX8gQc0m8tXd6BGvxfvHcPvUrBEj4qigMlbFHvGlzcxYCAzSWskwLNpDXMYg/gAA0tTjB77Ly2H8zezS/0oplE+TVBJn9EAN2ksz9ZcKKNHMxWhh4QFDXv9Po=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df63d99b-b6fb-41d4-3ff5-08ddb331cb5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:14:20.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V7yaou5qH+qoBEK5Dt4W1npE2cjP2hsCNuQtASMtoZqAb/HWwdboHT6udjaVS1GnkDuE88AV0WPnjrYvCjbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF311374B40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240128
X-Proofpoint-GUID: meLrYGLP894hQA84hPA0IzwU5PuOhJED
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685ac0cf b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=Byx-y9mGAAAA:8 a=yPCof4ZbAAAA:8 a=F7qQQ1vQbfOrkkY-c0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: meLrYGLP894hQA84hPA0IzwU5PuOhJED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyNyBTYWx0ZWRfX/5ue/jD96fGg feu7y8QOIYk1zSSmD9bZOtgi9PzrTFSspbU3d/taSEvTfr5HZYVP1YV/tSj7+WRDDJWNJELfgkn t/sXMvVF3VBts5h3KZSidIHgYaDOYQ/LLGRRdg7V1eLErkZuk2l9QQV2lssLFEc3ezl7wMn9xDm
 bxZXVIzPlLgPgki7u1JuTjBk6uTEWqZDBxdtSl+1axx/GqLCO//dbWiowjVZTXTEu7u7gwV/9vD ZlSRoXz7NJ40uKpcOgYkLUbyYb70DlLdq4Vd834ETAax2oGnn7FD3ErvNxFGXedR6qolnMyfD2u Nve50QIkV4S4MQfeJGw+O2PdGefhaWEODQKFJbS1HItg7LeAteIko9TDsuxPqeZM5dNXbh3xbxp
 Y0vUPKwGw6KlUawaUe988NBiFrJl7XhMlmJqqXnr2ugECK8VGV39Uj/JEzaUZXpa7Oh43sfZ

On Tue, Jun 24, 2025 at 07:57:40AM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 24, 2025 at 7:28 AM David Wang <00107082@163.com> wrote:
> >
> >
> > At 2025-06-24 22:13:49, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > >On Tue, Jun 24, 2025 at 10:00:48PM +0800, David Wang wrote:
> > >>
> > >> At 2025-06-24 21:50:02, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > >> >On Tue, Jun 24, 2025 at 09:25:58PM +0800, David Wang wrote:
> > >> >>
> > >> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > >> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> > >> >> >even when the alloc_tag_cttype is not allocated because:
> > >> >> >
> > >> >> >  1) alloc tagging is disabled because mem profiling is disabled
> > >> >> >     (!alloc_tag_cttype)
> > >> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> > >> >> >  3) alloc tagging is enabled, but failed initialization
> > >> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> > >> >> >
> > >> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> > >> >> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> > >> >> >
> > >> >> >This leads to a crash on memory allocation failure by attempting to
> > >> >> >acquire a non-existent semaphore:
> > >> >> >
> > >> >> >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> > >> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> > >> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> > >> >> >  Tainted: [D]=DIE
> > >> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > >> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> > >> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> > >> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> > >> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> > >> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> > >> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> > >> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> > >> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> > >> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> > >> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> > >> >> >  Call Trace:
> > >> >> >   <TASK>
> > >> >> >   codetag_trylock_module_list+0xd/0x20
> > >> >> >   alloc_tag_top_users+0x369/0x4b0
> > >> >> >   __show_mem+0x1cd/0x6e0
> > >> >> >   warn_alloc+0x2b1/0x390
> > >> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> > >> >> >   alloc_pages_mpol+0x135/0x3e0
> > >> >> >   alloc_slab_page+0x82/0xe0
> > >> >> >   new_slab+0x212/0x240
> > >> >> >   ___slab_alloc+0x82a/0xe00
> > >> >> >   </TASK>
> > >> >> >
> > >> >> >As David Wang points out, this issue became easier to trigger after commit
> > >> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> > >> >> >
> > >> >> >Before the commit, the issue occurred only when it failed to allocate
> > >> >> >and initialize alloc_tag_cttype or if a memory allocation fails before
> > >> >> >alloc_tag_init() is called. After the commit, it can be easily triggered
> > >> >> >when memory profiling is compiled but disabled at boot.
> > >> >> >
> > >> >> >To properly determine whether alloc_tag_init() has been called and
> > >> >> >its data structures initialized, verify that alloc_tag_cttype is a valid
> > >> >> >pointer before acquiring the semaphore. If the variable is NULL or an error
> > >> >> >value, it has not been properly initialized. In such a case, just skip
> > >> >> >and do not attempt to acquire the semaphore.
> > >> >> >
> > >> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi1MlgtiSA$
> > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi0o2OoynA$
> > >> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> > >> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> > >> >> >Cc: stable@vger.kernel.org
> > >> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > >> >> >---
> > >> >> >
> > >> >> >@Suren: I did not add another pr_warn() because every error path in
> > >> >> >alloc_tag_init() already has pr_err().
> > >> >> >
> > >> >> >v2 -> v3:
> > >> >> >- Added another Closes: tag (David)
> > >> >> >- Moved the condition into a standalone if block for better readability
> > >> >> >  (Suren)
> > >> >> >- Typo fix (Suren)
> > >> >> >
> > >> >> > lib/alloc_tag.c | 3 +++
> > >> >> > 1 file changed, 3 insertions(+)
> > >> >> >
> > >> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > >> >> >index 41ccfb035b7b..e9b33848700a 100644
> > >> >> >--- a/lib/alloc_tag.c
> > >> >> >+++ b/lib/alloc_tag.c
> > >> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> > >> >> >         struct codetag_bytes n;
> > >> >> >         unsigned int i, nr = 0;
> > >> >> >
> > >> >> >+        if (IS_ERR_OR_NULL(alloc_tag_cttype))
> > >> >> >+                return 0;
> > >> >>
> > >> >> What about mem_profiling_support set to 0 after alloc_tag_init, in this case:
> > >> >> alloc_tag_cttype != NULL && mem_profiling_support==0
> > >> >>
> > >> >> I kind of think alloc_tag_top_users should return 0 in this case....and  both mem_profiling_support and alloc_tag_cttype should be checked....
> > >> >
> > >> >After commit 780138b12381, alloc_tag_cttype is not allocated if
> > >> >!mem_profiling_support. (And that's  why this bug showed up)
> > >>
> > >> There is a sysctl(/proc/sys/vm/mem_profiling) which can override mem_profiling_support and set it to 0, after alloc_tag_init with mem_profiling_support=1
> 
> Wait, /proc/sys/vm/mem_profiling is changing mem_alloc_profiling_key,
> not mem_profiling_support. Am I missing something?

Feels like it should call shutdown_mem_profiling() instead of
proc_do_static_key() (and also remove /proc/allocinfo)?

> > >
> > >Ok. Maybe it shouldn't report memory allocation information that is
> > >collected before mem profiling was disabled. (I'm not sure why it disabling
> > >at runtime is allowed, though)
> > >
> > >That's a good thing to have, but I think that's a behavioral change in
> > >mem profiling, irrelevant to this bug and not a -stable thing.
> > >
> > >Maybe as a follow-up patch?
> >
> > Only a little more changes needed, I was suggesting:
> >
> > @@ -134,6 +122,14 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> >         struct codetag_bytes n;
> >         unsigned int i, nr = 0;
> >
> > +       if (!mem_profiling_support)
> > +               return 0;
> 
> David is right that with /proc/sys/vm/mem_profiling memory profiling
> can be turned off at runtime but the above condition should be:
> if (!mem_alloc_profiling_enabled())
>         return 0;

I agree that this change is a useful addition, but adding it to the patch
doesn't look right. It's doing two different things.

> > +
> > +       if (IS_ERR_OR_NULL(alloc_tag_cttype)) {
> > +               pr_warn("alloctag module is not ready yet.\n");
> 
> I don't think spitting out this warning on every show_mem() is useful.
> If alloc_tag_cttype is invalid because codetag_register_type() failed
> then we already print an error here:
> https://elixir.bootlin.com/linux/v6.16-rc3/source/lib/alloc_tag.c#L829,
> so user has the logs to track this down.
> If show_mem() is called so early that alloc_tag_init() hasn't been
> called yet then missing allocation tag information would not be
> surprising I think, considering it's early boot. I don't think it's
> worth detecting and reporting such a state.
> 
> > +               return 0;
> > +       }
> > +

-- 
Cheers,
Harry / Hyeonggon

