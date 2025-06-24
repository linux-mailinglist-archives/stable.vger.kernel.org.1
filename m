Return-Path: <stable+bounces-158445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC6AE6E0B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6541BC76BC
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0552E62AD;
	Tue, 24 Jun 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ksq8eAoY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RCYUufTL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36A2E6107
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788104; cv=fail; b=h3M9gq1qqWgFB6ONzQuRQTQIR/VcPp67jKW/dSpY8n6WH2hCJeKP1vw8cr3pzEl5b1nGWDo1Sk/zgz/SNRdfYcPAfBaIKHuhY22EbNoMNjmhl9i6om5dGAJ4mQAfJwhBjnmX3LCJ6Cw8LFotztTRg71jnGfmAQBMzwN+xXBvqCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788104; c=relaxed/simple;
	bh=0YtpSOcufkSV4W+ajlUrWHGmNnrLfYZn3KbT82bYfmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pocfF1BTB8qPynASIIxbSjr+8V9epIiasMerFUI1VVHBqrq+2xQLXOlLpS+NACClKjxdsR3bRvayG6a7Kw0WKKmHQcZ9n+Cf+3FuGUVoNOKXoIEVZl7c1/d8yyWoPKs2rJDLiqK9wnBLxwm58d2o37/aPile/fCLX045VmGL76o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ksq8eAoY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RCYUufTL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHBegp019213;
	Tue, 24 Jun 2025 18:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mhinW3Oq4cgkJOoLbiZ3Ysbw2fVPS4cmv67kINTXSlc=; b=
	Ksq8eAoYLgi6PPMl/YLt38i1czG8rk0RBqxBg2JXZzcmHyffU8KtQ30uj+1xuQE8
	jNgBSaK7uBou2XZR8VU7oWbPvuIHYHUzxPnHC+S5AkG0oLLXY9LfyjJI6E/LdvoZ
	7bH4XgpEDTfcgP047wfAcXcP63e1dYAVS7XnWVaLW6NV9nY5cBxCFgN7nk/avtdc
	Y/+bx8dNWLdMQ8wZ8KNWxxEuAwWuVleBib2tCzcTrguB8D1XTeL7qfkDNnVAB4xa
	1lIycwjKTo0mj0p14Piy90zfzrn5yAZi3pko3ecF3MHEIH54mHN1Ur2jN8f/XyGZ
	sldxVNJnTE8HL2u5AXie1A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uwt1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 18:01:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHbutK008158;
	Tue, 24 Jun 2025 18:01:11 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq3ysm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 18:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJMeUqRK8CEjicCd+diFkC/q1Q7hX6nZGqRerwpmkTSonhDvFxMQGrKEwND8aBPrZ0CRSIi+2e11/ZSeRzGOp47wPNrvLOZFNoYL56Q2c8AGIUDw0zMEosTnHSm640q3+67GPLf+RtcpEOx2bjW1/avwO1jYtyE2apwt7P1hSq/mh/88Ofj6jU04sOcq2KrDwpVU/6yXiRFeClZueeke29r8r75qbT2I1l5t33aVq+82roXTM4ruI6eQUEmXLravsucY6FYCG+JFDN94efG9lN6h6hNlTxGgx+s+wV+TqfIh8wF4IQiWD3S2n4W33LsQbHl5OCxHf+9A/o8Rb/VFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhinW3Oq4cgkJOoLbiZ3Ysbw2fVPS4cmv67kINTXSlc=;
 b=AJSc71HptGQKsSGJanvAyGUex+mGZmbMKuoLwKATnrk1i03UWvSQx/cSEVYz0ibckkMeFX9BTDGBZmdsiL3pg2+n+UOQXTj4BB481JeUMgMtSGq4zz3A2qxP426LOb48hhLX7MHe5UZkalXjvzw8K1xIGh7zGXxXRADIZQItR1aO3X6TeAkDGuQnrB34OtEvg3ho5Qg5dIUAf6SKfGZM3n/zhhl8qXiHL3Cs6awdMGqaYiTVztAAttI3uUoGxS2c32uWJCrQFMi/CHYMInvRHbpePKK5yxIWxAHj1KTgxmTHeU1Yrxl45NUDkhPG2I3p1NH1ZmQ6H33od8LmwgLEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhinW3Oq4cgkJOoLbiZ3Ysbw2fVPS4cmv67kINTXSlc=;
 b=RCYUufTLtfMXS0gH3MTSqMFoc2OH423h/wIMSlK1QDLR6A0p5UEniq3rdOWeakh1KZTvZn1S+Q5uvOTZROCuZmFRoOJ5M1Gc3eBFcYu6CkepyMqgCXWZg6lG6I0Ce74ECLpjuY3dmWvh9bmLDiXrULoTtpQZ7ZQXiiSkcGdmUrE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6347.namprd10.prod.outlook.com (2603:10b6:303:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 18:01:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 18:01:07 +0000
Date: Wed, 25 Jun 2025 03:00:54 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Wang <00107082@163.com>, akpm@linux-foundation.org,
        kent.overstreet@linux.dev, oliver.sang@intel.com,
        cachen@purestorage.com, linux-mm@kvack.org, oe-lkp@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()
Message-ID: <aFrn1pZJ09N7xNOb@hyeyoo>
References: <20250624072513.84219-1-harry.yoo@oracle.com>
 <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
 <aFqtCoz1t359Kjp1@hyeyoo>
 <2dba37c6.b15a.197a23dcce2.Coremail.00107082@163.com>
 <aFqynd6CyJiq8NNF@hyeyoo>
 <3942323b.b31d.197a2572832.Coremail.00107082@163.com>
 <CAJuCfpGd+jHoCdyuEbk5h-dbQ7_wqgX=S4azyb6Aou8spzv0=w@mail.gmail.com>
 <aFrAwJEkjYFAuVOa@hyeyoo>
 <CAJuCfpEXAX5BJiA94pYYAqe22uo-Ngfw-+ZFZkt57SnHPMsY5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEXAX5BJiA94pYYAqe22uo-Ngfw-+ZFZkt57SnHPMsY5w@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0096.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: c5af233c-cc13-49d8-d88d-08ddb3491772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGEzTEh5TlVFVE1zemZ4aHZ2enBkMkVnODUvaTNzR1lFc3p0cUZLZFhkTkhr?=
 =?utf-8?B?Z1Uybk9PaXBBUHFvMFR4RlZBbk5FcFJOMC9Mc3hmdlJjbklBMHdQdEs4dWVs?=
 =?utf-8?B?MkxSQU0vdmFKeFpiajJDZVNoeUVocDA1YUJCWDAyZ2JHckovNW9MS0hGUTU2?=
 =?utf-8?B?VXdmQnRCdTgyWG9ibGJiQjRMN1ZxZDVzZm1xWWVlMG44dHlPWnhWQmZUOWIv?=
 =?utf-8?B?YXRna3U0amlQcTk3Q0hXQVNRM0ZaT2NOM0l3dm1CdnkwMCtMWFl6TkdKQWRW?=
 =?utf-8?B?bUZGUDZFT1pPblJnaFFCSmJuSlhKaCthMVFUTTZpaFg1S3RCcUQvSGRGRlJ4?=
 =?utf-8?B?K1dYVTNVM29ZMlpWSzZyUWVUUHJ6blgreURxT0lkYUdrL3A0TmtBcEUwTDJr?=
 =?utf-8?B?bG5qZXc1TXdGblFZanZMemlGYi9vTVN1ZkF5NUUybjZRVlprQ2l6TlhDZmJQ?=
 =?utf-8?B?RFVLd0x2eTFmTEFOUHhqOE1UWU1GZ0xnTmRWNjl2TnlJT0xuUTVPNDVwVjNK?=
 =?utf-8?B?b1A3VjNEQmdSWEtwUTkzZG9JK2EreHFKQitnWm1KZDBYYkRvdURsUG1rTmUz?=
 =?utf-8?B?ODZ2ak9yUlNFc1Vpc3pzckhKL3diWHR4cnA0NXlYRVJzSEd6K3lFWDVaWGw2?=
 =?utf-8?B?c1JLUVNFUTNpdk5DZk9KTXlOcU9vMDFCN3U2WkJmVUYyc0VycFNVSmZUSGlK?=
 =?utf-8?B?djNrdldpa1FCNGt4YzRZNXAwZGNSb3hTWStCNkp4M0hLK3owZC9rdUdVYXdh?=
 =?utf-8?B?aC93SGV2Q28ycHBpclRla25LN0xMb3JGSHpmdDhFTTJVc0VXSzhXTFFTaGNy?=
 =?utf-8?B?WmpBS0UxaWlaeWFwMDNKNmN6Tm5DSEtRUUNodVRxaXR1bm9LWWNwMFZza21V?=
 =?utf-8?B?L0JhblZNeWlYZ3cvZWdMUlp5ZEtDaDA2dzliMk9hdlY0YmZZMFQxdWVPcy9V?=
 =?utf-8?B?d3NNa0F2Y2twa3E5ajg5UzAydGJpbW5kOU8vVFRpZ1hpWTFIZDFHYjZhMlk5?=
 =?utf-8?B?Q3pLQlJIUWpic3VncVFJQ2xwQnZ2VFk2M1p6a1hGaFJHWDBxYUFyem02UWZr?=
 =?utf-8?B?V3JLUzJXNWZDRWdVRXlaNVBsWlVxRmNFL1BXVW1zckpxUW1YYnpnUGlKakpw?=
 =?utf-8?B?UFdRZUhvUkJVbnJ0djUzV3N0Rzd3Q1ZXcno5SFFhWW81VGk2YUt4K3VISGxa?=
 =?utf-8?B?UW0rSEdjSUxGWVFvSHpnRmcyWkk3eFJmRHhBZWlQS3J6UUxqT1BBUytybkRK?=
 =?utf-8?B?cVAvUTBrNXhMZTFRWDJWYW1NVEkwWXR0U2xUU2pVQXpmMEZzcHU0cmJSeVND?=
 =?utf-8?B?Tlh2MU1sK0ZrbGxramU5V1RWNzVuMmlmZlJjd0JYOHh4aFN6N3NIYklDMWtD?=
 =?utf-8?B?dWtSWStSRDVISXR6S3htdEZRQTF4clNoQnNJdy9hYjNkS3F5M0J1bVp6d0Rk?=
 =?utf-8?B?QlkxaVYvWEl6TkVMUlEwYWhvTk5yUzNmZzRpMkV1YlRGbW5MK3hCYmY2c1U1?=
 =?utf-8?B?ZzcrTHBuaVhQM3pIVFhkS2dsaXZKdUx6bzBzc0xOYzE5ZHBNamZKZUZsQmVh?=
 =?utf-8?B?eWRIbVhrZWgxVnFrd3JSZXI0aUI3N3hMdWFRZDJBckNkWUNFVmpVeXBVY2h4?=
 =?utf-8?B?YjkzTUFyY0RsSUtlbW95TDg2bFhtSEJMWHZPbHRPZ0dNNnBLVHhhWXlublRZ?=
 =?utf-8?B?U3lGeituaTJmL0lBSW0yd1UvKzMzcWx0c29BeFlPc3p2aVJTODVobkdPa09a?=
 =?utf-8?B?SitORlB6SVBwOWdiZ281QXBEVDd0cEpMWEcvenZkb3dKdi8zSVl6OFpadGJ2?=
 =?utf-8?B?KzlFTkVieFhpVzJKbmh4TlRmZ0FwQTliQTNFcWN0bkdKRmd5Z3BQRnhOOGIy?=
 =?utf-8?Q?/e09DrHtzslrv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE85eEFDTlBud2lzbS9pYVNZa2Q5aTZsaEc0WTMzTVllYy9kSjdGSWg1bjJS?=
 =?utf-8?B?NHdJVGJmUFBGQUI4a0xhanRUTkF4S3I2UDVpaGUxR3N4TDh2K3kzN0tPWWxq?=
 =?utf-8?B?OU8xWmthRHVzQTBITHZ5SGN0Z0g5RExvUkpZTWpxT1dOSWQzdlhybzVJYkx3?=
 =?utf-8?B?ODJaallVWWZ5NEhheEs4c3J3V2I0T3JkMERhWjlpV1BIdjVYSUdVRmVGMnBI?=
 =?utf-8?B?RlhHbkpaUjI2dEg2bHJvbUxDM21XalZtbHNmYVhsSnVwbHdTT2l0aGpKdnB3?=
 =?utf-8?B?ZjQ2RVFPRHZwdlBzNU1kRGo0UURXcjZoTzY1MXpkUnhBb0ROSEpWeThrb2Nn?=
 =?utf-8?B?QTlyRFpnTExVTWM3OEZKdkFmemxZY2FJaGZSa012bHoycUZTa1VybE93SHhx?=
 =?utf-8?B?U3VmT2d6dE5paERzRGNCUXRCbWdFT09nUlJmYkVtT2dkblpYSmkrcFdLUnhH?=
 =?utf-8?B?bHNGa2xkS2d6SVVqMWhRMHJaanZOcGI0UjNzcEpGMFl3QUpCM1ZqdlV5QWNs?=
 =?utf-8?B?OFhhWmtnRWppMUlDSWg4Rk5NakNxa0pDclVDVGZHdTdSdGluU1Vidlpic3Bm?=
 =?utf-8?B?S1lOS2N5SFd5RFl1M1lnZ1lBcklCVko3ODhzOHoxMnlWbGZySEJGKzQ5WnRr?=
 =?utf-8?B?SkwrMjdJOFhFbDY4WkRCL0pYM0RpdmJiM0hpYnhQdzZJc1IrbHVDUXVqemQw?=
 =?utf-8?B?OWw0cWVRSHdCRk1VOE1HbDUxRHB5YkRPalpPK2NvYkNuWkFkUDZ3cVpyZXBK?=
 =?utf-8?B?bGxqKzFRb3BxRGx3U1Q5VUFUWjlKZjVVNnpsSnNaVXJmZ0l0NzhhOXF4dG9G?=
 =?utf-8?B?Q0YxN2grZTJiUDJDK2Q1N1E2aDgxbTB6NGdES2htdmt5azI5ZTVmWmxkT3Yr?=
 =?utf-8?B?RjBtSXRwcnFkVzh2ZllEQUtFYUVBN2hwbXJiWkhrenZMYWpjTjcrT3pPUW9E?=
 =?utf-8?B?RnNTaGtVYnMxK3l5R25ORjUwZk11WW5VMHJaVHhDTTlzMnpReHdvOHA4MHE1?=
 =?utf-8?B?L1lUaStrRHFyQUU0clFnak0vVktGeU55di9jUWxFN0NEWjJ1SWpNWEFIaFUz?=
 =?utf-8?B?T0J4ODRaUjZlVC9ZdCtFYmUvT3k5cW4zNkV2NFVpVTFkQjR2ZmhzLzdBNXUz?=
 =?utf-8?B?YUFsbGZ4dms2NnJhTUNsbnNqSkVrOTBHbVVQVVIwenpBZEpYUEhLM1RDT04r?=
 =?utf-8?B?c0hvZDZORmVKNDBBaWg4enBmSzFYSFhTSmgwcXdRbVVYQmlXZ05Ld0lNZks2?=
 =?utf-8?B?M2MyazJ6LzVmSGlBbkpYeWNFTndmUFZGeEhMTFpLY09KTm1pNFNiTjl0b0Ez?=
 =?utf-8?B?bXFKYXlhVndQMWdJSWFvSXJ6QXpqd2ltV3d5SThLdHBVUExpNTAyL2kvMHVy?=
 =?utf-8?B?bDhvdEVyeGs4c0IzZXpjSU5EWnJKcERWSmtYd25yUXBGcyt1V2pCL2ZjQ1lZ?=
 =?utf-8?B?eDFteTUxWll5bU9mUG5Yemh2QzBnZVVySTVSbjVqc0ZZSDVTaVVveXpmUUFM?=
 =?utf-8?B?UXA5QmhMTURzdkl2ZlhBcXMxYkxKL0Z1UlpIVlNKL01xUk9GTHJGaU80MHJF?=
 =?utf-8?B?RkwrK01EZEY2eHlKVmtySnlaMGpSR09NS3FJc0YyYkVKRU10dEs1aEQxNjJs?=
 =?utf-8?B?YUFNWEVaMXJaUXB0YTQ0ek9TclQ3ZHhsZGFVQytja3hMUUs4TXk5NE85VXNZ?=
 =?utf-8?B?QndSNlF6Ni95c1hJV2lrTWE2T1d6SDF3d1R1N2pOTnQzMVRnaEJwZ1Roa1BH?=
 =?utf-8?B?RUNlUXcreEEwRG5EaURkeDliVkRYbWN0Zmlwc2tRajFwVGVlb0d3RWs4VmhH?=
 =?utf-8?B?eU9iRHFxMDRhNC9Jdll4QXByWnZsRjNocUsxUFRxVG1SWHJuMEdSTHlPR2cr?=
 =?utf-8?B?UHVsQWJTakt0aTc5WkN2VmJrOXdjZjVqMlBXRkIvUkRWcFVtTUQ0b0szZXdU?=
 =?utf-8?B?ajNMcFVkUGUrTnpzekZXT0hKWDFZODJhMk81VGYwVm55M2t2Lzl5UjBEalBv?=
 =?utf-8?B?am5MNjNhWnJnd3lvT05FMTNhd1hnNkZMeC9JVE9ZSEJBWHdyRE1Fa0J0YnZG?=
 =?utf-8?B?VTZPUEVseEJIa05KOWJpdGs3NkhTMTQ0LzQwRmhCMnJ6dWwyUmhMbXBaT0Ix?=
 =?utf-8?Q?g0nnDeuPU+bDkhfIdSC02Gr5N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I9FHyEv9HG+CXSG9xmTtI3YRs2oAvcvs8MmeFGS+hp/VITt70mrmCcIWh6ywwgud9t46bIqYZpOX9wS0F40yqenSjDwQxdC90jk+pJSYACpY+cW0oId5HqslBYdumgwPOLHFcQ2w70YsidtqzHaawbvVuqMBPMh2tQpQsKoI4HK4QAMk2P48ff1GGNuHHLijfbAcmdEpLINArK/jPOa4vtVlAShES6itK8rACEyZ6/tpMbuIfsOA7hIKtjg2eHopqpKMTMHz2uDcahXXq9cDJA7GMeWE8J7Oksnz/9QLF6U4RE3AsMI2zw/SwdQnE+CmFeYLEMTOf0kg2EH4BfoxBF35/sKJ1b/lMKWvzkvQxLU7wy8VXjs9FUFCoBLex274Fz/LmMX8r4hv0RnsOwy49jEoPztNlk4ggxy5sEqgC/fXPCoA40m5HDAfa/bFiN7SnR0kpaLcGE4kicRmricoeRnAatAtNv/sRNHVOKdLGuU3XEILGZ8454rXN3aRHt+2BKSFNVKOUyBYxsrFbpXIDBi1okkk2bLkW76h51iJ5XcKX/lyDrRrbRO5V526Zb4IokLJjBbtaCxyjOscfemQEO5u5BjwQHVQG9SgszU5pkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5af233c-cc13-49d8-d88d-08ddb3491772
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:01:06.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C1K2XbKc0/+Ddwc+ObBDJooB9Z7QGXJ/AtH7RE3cyJFzSabbO9iRqtFlQdDMSKgE3GY7lJ3yzYGD5MvcCSRzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240147
X-Proofpoint-GUID: d5PLBGfQ7Hn_9AkSTtlNdx5uxasN6ewS
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685ae7ed cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=yPCof4ZbAAAA:8 a=Byx-y9mGAAAA:8 a=bXeY4mTF55Qrn8Gr1zIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: d5PLBGfQ7Hn_9AkSTtlNdx5uxasN6ewS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE0OCBTYWx0ZWRfX0YPeSuZtZJMm La6VVuuzCycK/ugfjM+koFUZWvRD91KApsLtzGyAKz3bIMjAlwcTWg9k+waJq9VMYnjZnv6qCve QTxnKrrdWqBfWDibka7el8lx+bGHOjrvqpfxrM2t/PDAm8zftgqLLKbYx4H0xKi/EPqtYiRZuPQ
 j8V6sLqG3lsklYwN7O5BYbu5c8FUSV+1R2KnCQmIfRspSSHPKNvYAp7NL9EgiM6ktGCb+IBv/yy gOCQlsk/ar1n+hIEpqeMGk/a2PC/nPLQygZYNSFXhYvHRH79Qz4lC69ksxH2EYRCxISn/ygKsf2 UTspYdJdbkSHsGyvI29Ek70N2CDj2M568wTQ8qMKBU1oQg7yDJpc49Nkq1xdzD5DvbqWjXnFjPZ
 CAmPqxERLPSHPm3VUTA0VNDaBCm09rFqmA3uclKn1g2ZLckfDUr0pheiFvehcTfb2ggRinIR

On Tue, Jun 24, 2025 at 08:38:05AM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 24, 2025 at 8:14 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Tue, Jun 24, 2025 at 07:57:40AM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Jun 24, 2025 at 7:28 AM David Wang <00107082@163.com> wrote:
> > > >
> > > >
> > > > At 2025-06-24 22:13:49, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > > > >On Tue, Jun 24, 2025 at 10:00:48PM +0800, David Wang wrote:
> > > > >>
> > > > >> At 2025-06-24 21:50:02, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > > > >> >On Tue, Jun 24, 2025 at 09:25:58PM +0800, David Wang wrote:
> > > > >> >>
> > > > >> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > > > >> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> > > > >> >> >even when the alloc_tag_cttype is not allocated because:
> > > > >> >> >
> > > > >> >> >  1) alloc tagging is disabled because mem profiling is disabled
> > > > >> >> >     (!alloc_tag_cttype)
> > > > >> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> > > > >> >> >  3) alloc tagging is enabled, but failed initialization
> > > > >> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> > > > >> >> >
> > > > >> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> > > > >> >> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> > > > >> >> >
> > > > >> >> >This leads to a crash on memory allocation failure by attempting to
> > > > >> >> >acquire a non-existent semaphore:
> > > > >> >> >
> > > > >> >> >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> > > > >> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> > > > >> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> > > > >> >> >  Tainted: [D]=DIE
> > > > >> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > >> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> > > > >> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> > > > >> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> > > > >> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> > > > >> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> > > > >> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> > > > >> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> > > > >> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> > > > >> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> > > > >> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > >> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> > > > >> >> >  Call Trace:
> > > > >> >> >   <TASK>
> > > > >> >> >   codetag_trylock_module_list+0xd/0x20
> > > > >> >> >   alloc_tag_top_users+0x369/0x4b0
> > > > >> >> >   __show_mem+0x1cd/0x6e0
> > > > >> >> >   warn_alloc+0x2b1/0x390
> > > > >> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> > > > >> >> >   alloc_pages_mpol+0x135/0x3e0
> > > > >> >> >   alloc_slab_page+0x82/0xe0
> > > > >> >> >   new_slab+0x212/0x240
> > > > >> >> >   ___slab_alloc+0x82a/0xe00
> > > > >> >> >   </TASK>
> > > > >> >> >
> > > > >> >> >As David Wang points out, this issue became easier to trigger after commit
> > > > >> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> > > > >> >> >
> > > > >> >> >Before the commit, the issue occurred only when it failed to allocate
> > > > >> >> >and initialize alloc_tag_cttype or if a memory allocation fails before
> > > > >> >> >alloc_tag_init() is called. After the commit, it can be easily triggered
> > > > >> >> >when memory profiling is compiled but disabled at boot.
> > > > >> >> >
> > > > >> >> >To properly determine whether alloc_tag_init() has been called and
> > > > >> >> >its data structures initialized, verify that alloc_tag_cttype is a valid
> > > > >> >> >pointer before acquiring the semaphore. If the variable is NULL or an error
> > > > >> >> >value, it has not been properly initialized. In such a case, just skip
> > > > >> >> >and do not attempt to acquire the semaphore.
> > > > >> >> >
> > > > >> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi1MlgtiSA$
> > > > >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi0o2OoynA$
> > > > >> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> > > > >> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> > > > >> >> >Cc: stable@vger.kernel.org
> > > > >> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > > >> >> >---
> > > > >> >> >
> > > > >> >> >@Suren: I did not add another pr_warn() because every error path in
> > > > >> >> >alloc_tag_init() already has pr_err().
> > > > >> >> >
> > > > >> >> >v2 -> v3:
> > > > >> >> >- Added another Closes: tag (David)
> > > > >> >> >- Moved the condition into a standalone if block for better readability
> > > > >> >> >  (Suren)
> > > > >> >> >- Typo fix (Suren)
> > > > >> >> >
> > > > >> >> > lib/alloc_tag.c | 3 +++
> > > > >> >> > 1 file changed, 3 insertions(+)
> > > > >> >> >
> > > > >> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > > >> >> >index 41ccfb035b7b..e9b33848700a 100644
> > > > >> >> >--- a/lib/alloc_tag.c
> > > > >> >> >+++ b/lib/alloc_tag.c
> > > > >> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> > > > >> >> >         struct codetag_bytes n;
> > > > >> >> >         unsigned int i, nr = 0;
> > > > >> >> >
> > > > >> >> >+        if (IS_ERR_OR_NULL(alloc_tag_cttype))
> > > > >> >> >+                return 0;
> > > > >> >>
> > > > >> >> What about mem_profiling_support set to 0 after alloc_tag_init, in this case:
> > > > >> >> alloc_tag_cttype != NULL && mem_profiling_support==0
> > > > >> >>
> > > > >> >> I kind of think alloc_tag_top_users should return 0 in this case....and  both mem_profiling_support and alloc_tag_cttype should be checked....
> > > > >> >
> > > > >> >After commit 780138b12381, alloc_tag_cttype is not allocated if
> > > > >> >!mem_profiling_support. (And that's  why this bug showed up)
> > > > >>
> > > > >> There is a sysctl(/proc/sys/vm/mem_profiling) which can override mem_profiling_support and set it to 0, after alloc_tag_init with mem_profiling_support=1
> > >
> > > Wait, /proc/sys/vm/mem_profiling is changing mem_alloc_profiling_key,
> > > not mem_profiling_support. Am I missing something?
> >
> > Feels like it should call shutdown_mem_profiling() instead of
> > proc_do_static_key() (and also remove /proc/allocinfo)?
> 
> No, we should be able to re-enable it later on.

A few questions that came up while reading this,
please feel free to ignore :)

- What is the expected output of /proc/allocinfo when it's disabled?
  Should it print old data or nothing? I think it should be consistent
  with the behavior of alloc_tag_top_users().

- When it's disabled and re-enabled again, can we see inconsistent
  data if some memory has been freed in the meantime?

> You can't do that if you call shutdown_mem_profiling().

Because setting mem_profiling_support = false mean it's not supported.
And you can't re-enable if it's not supported. Gotcha!

> mem_profiling_support is very different from mem_alloc_profiling_key.
> mem_profiling_support means memory profiling is not supported while
> mem_alloc_profiling_key means it's enabled or disabled and can be
> changed later.

Okay. Now I see why I was confused. Perhaps I should have guessed that
from the name, but I was not 100% sure about the meaning.

> > > > >
> > > > >Ok. Maybe it shouldn't report memory allocation information that is
> > > > >collected before mem profiling was disabled. (I'm not sure why it disabling
> > > > >at runtime is allowed, though)
> > > > >
> > > > >That's a good thing to have, but I think that's a behavioral change in
> > > > >mem profiling, irrelevant to this bug and not a -stable thing.
> > > > >
> > > > >Maybe as a follow-up patch?
> > > >
> > > > Only a little more changes needed, I was suggesting:
> > > >
> > > > @@ -134,6 +122,14 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> > > >         struct codetag_bytes n;
> > > >         unsigned int i, nr = 0;
> > > >
> > > > +       if (!mem_profiling_support)
> > > > +               return 0;
> > >
> > > David is right that with /proc/sys/vm/mem_profiling memory profiling
> > > can be turned off at runtime but the above condition should be:
> > > if (!mem_alloc_profiling_enabled())
> > >         return 0;
> >
> > I agree that this change is a useful addition, but adding it to the patch
> > doesn't look right. It's doing two different things.
> 
> You might be right, calling alloc_tag_top_users() while
> !mem_alloc_profiling_enabled() will print older data but it won't lead
> to UAF.

Yes and I think it'll be great if David could post it after the fix lands
maineline.

Aside from that, any feedback on the v3 of the patch?

If yes, I'll adjust it.
If not, please consider an ack ;)

> > > > +
> > > > +       if (IS_ERR_OR_NULL(alloc_tag_cttype)) {
> > > > +               pr_warn("alloctag module is not ready yet.\n");
> > >
> > > I don't think spitting out this warning on every show_mem() is useful.
> > > If alloc_tag_cttype is invalid because codetag_register_type() failed
> > > then we already print an error here:
> > > https://elixir.bootlin.com/linux/v6.16-rc3/source/lib/alloc_tag.c#L829,
> > > so user has the logs to track this down.
> > > If show_mem() is called so early that alloc_tag_init() hasn't been
> > > called yet then missing allocation tag information would not be
> > > surprising I think, considering it's early boot. I don't think it's
> > > worth detecting and reporting such a state.
> > >
> > > > +               return 0;
> > > > +       }
> > > > +
> >
> > --
> > Cheers,
> > Harry / Hyeonggon
> 

-- 
Cheers,
Harry / Hyeonggon

