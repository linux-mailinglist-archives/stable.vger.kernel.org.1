Return-Path: <stable+bounces-211818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFpCI+PBeGmltAEAu9opvQ
	(envelope-from <stable+bounces-211818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:47:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CAE95152
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF9CB301178F
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CA35A92F;
	Tue, 27 Jan 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHBK3LQX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NvfGonDt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13930DD19;
	Tue, 27 Jan 2026 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521632; cv=fail; b=FBwcAkQDjezvBzSLzMZ5PrFygBVaJWr8lbzREvB7guYZF/vcVkobdXOe59I5Z1F4RYYnGE3LYQKNJBR70pUg9N9LXCoIaiNeSsndxULn8X2DFLInI34kiaOA0NHcJiSu+urbnWvQUCvxUP5kG4pFSR2wtc3YOJtWdRCiPafb7mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521632; c=relaxed/simple;
	bh=mq6Fi4l32vB06wSt7hPWZLte+rIFLO3ozrEG1dbHj7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AmjO97GRMcMSq0N+vFkLpsdUS+qxP1PCksEIFp4x+LQE7vyJ6ijw2xO+hWFhQEpFka95Zo5ERU+GwBW/wmnUh5cNE5z8Vk7G96YZIFfbIGqKzAo8Pu5tT66hlVb7OqrzRN4uwUwT8MMmZjIeQylc7SXXQjKIDQP2W9yqduw4grU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHBK3LQX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NvfGonDt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBETBq3328617;
	Tue, 27 Jan 2026 13:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=stN/0LM6U6Ax77CCiZ
	kAHwoEUB2yqUYgFCSn9iIDPLw=; b=RHBK3LQXDAq5VJUpYsNoTh2Gwe2qvqWP8t
	+uVd7BCBiLB14wS86nFKyoN099St+xnCqDemXJRvmXgWiVcemxAjNy+O/KKYrF32
	wzpxMEcYUxTouD+Jrkw1SVj03Uve+tyHJ+QnEfjgtz7kMwCoIrKCladWg6rh/QUW
	STdeMFS54ir4w0H7ri9L+ml/9FqkTLomkLIrw1GYiz4dVnOzSfkXpVsBuU5PZdB6
	F1YhaMGGggPvzqombKs+M38eP+ZB+ceVb/Tbcsb7jqzsr3jAVBK6xwp+mfd7Nxrw
	z5cGGsH01M8mpk1ObZaBB7u2XOWI1PCG3WwxyzIg5ASf0nv1ez8A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny41tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 13:41:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDP1Ia033462;
	Tue, 27 Jan 2026 13:41:40 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9dpv1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 13:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9VvNwYIA6mLqLCqqtinGaYFx4TnRfDE+A8x3stdodySbwkKh4Zg9slrwjcHBwTEa3x8xFHA9Bep0WUrwJ/kbV1lK9TuFNLT3LVuTPpOgsf1KTqzRGsH3efERLZ+yO/myBD2J8DyEuNdOX+ju1U4hyRJDJivZXH4bHuyAyMeP8f4Ns5io+DbXuWh1PTrzqvumXzpEgt4RlTEaL+Mes6h2MadXP8/vBm8ZKRDhSkV4K5TQFWEFtk9q+TfduYtPB8UdvZrIGRKphggX1u/ExInTiLGPubWCnMYtHG4ltN4tFGDSJ8uoSnX3KXRwA8ihapyPcApmsSMB1e8dAlpKqJghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stN/0LM6U6Ax77CCiZkAHwoEUB2yqUYgFCSn9iIDPLw=;
 b=xXXVGYu008GL522VMf+46TMvy05QUMipC24DkmvnOtTigcGbuYnRn4WKejwSRN1eCqTyHUporsaOU1OC0zidFk0H0cnEKNUSoBX6JwDCDYi5e7qe63c/thPUMRoTpGt4TTKLGIAXdjW+NMnEH9eu2XXe8M/xifDET7msQj+6bnLt6pkxdfq/qeTsyd5vEJ2Q3UWlnuPb4dO6YQ4HLRIFGYIhFDawR8hrbHrjCYQbLHPGPn7toxGllet2Fo/c8vs92FW77x6vRiq+l9gh1/j0VFH4a1iYWCRIv/Mif0mNPwPWk9mhsdb2YbipUpirHd4Ob9i1pyI0baQyhL5l7TrDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stN/0LM6U6Ax77CCiZkAHwoEUB2yqUYgFCSn9iIDPLw=;
 b=NvfGonDtB5IVLiow4XeGicZt3WCbrHxfKA6d2xzJrw6LlNb/p52SAEbvJBCR0TnUt2bSauOoD6SvxXLbJqwCzVtlYTpKI4RBRS/0T1ryhSGuclPA15I0d8y8xiSGBmf8xWVLzwAaJeZCdcLZoWb4xGVWYZwVGcv4lNaYNeGiI24=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8469.namprd10.prod.outlook.com (2603:10b6:208:561::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 13:41:34 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 13:41:34 +0000
Date: Tue, 27 Jan 2026 22:41:26 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jane Chu <jane.chu@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
        muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
        linmiaohe@huawei.com, jiaqiyan@google.com, william.roche@oracle.com,
        rientjes@google.com, akpm@linux-foundation.org,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, willy@infradead.org, clm@meta.com
Subject: Re: [PATCH v7 2/2] mm/memory-failure: teach kill_accessing_process
 to accept hugetlb tail page pfn
Message-ID: <aXjAhpkzifB51MV2@hyeyoo>
References: <20260120232234.3462258-1-jane.chu@oracle.com>
 <20260120232234.3462258-2-jane.chu@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120232234.3462258-2-jane.chu@oracle.com>
X-ClientProxiedBy: SEWP216CA0034.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc9e98a-0ac5-4906-54a2-08de5da9c92a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ZDObwW4V/VYDxbGhz8AQU9Rggnzu/+rUxSDb4B+QnnYefrfdIspVMpCrzWzA?=
 =?us-ascii?Q?SbbsJGNky+gLFpveI1QeTRa6zdx2AkbXXedFdKsCo+j7kmGJeMUnYgXY1os9?=
 =?us-ascii?Q?nThp5LWSTLunRRqRfZLPMvmww6fV3jGCmWNoaIywdYk8RtPY0F5+e8s7S7sR?=
 =?us-ascii?Q?I3BEdZRO6TE3SIfNjtjiYY5ybpqRIajjhtOJef1WIt/D6k9bSxBj1nhQWJQB?=
 =?us-ascii?Q?XlNnOpb/JVtWHV8PI8/cR3tpwcuvk1pW4jnTszw+D/EEOMMVX1o47nis+Kqi?=
 =?us-ascii?Q?Qdq6wNSuBdACZADyfblJmFUZOtyiya6pzBPolN/s1IDehRVLlbKfXoz/xyQc?=
 =?us-ascii?Q?u19p0/F+lfwjCUzyUZOaCiMLqZDIZtW3spKnTBAmc27Oe4ygHQ9C/tR76N/n?=
 =?us-ascii?Q?0UdcjDA+6utuybVE1mXh5GJw6etYHOt/5PqY2uKbEIAZWEKH2KD9vD0XX4C3?=
 =?us-ascii?Q?zXKggav/rnYHOYNAgb7NMlMa5/nhKxvI5v8gxv6gFXfaEGEx9JJi+v5Kl0BR?=
 =?us-ascii?Q?s5MjnNWYwTmMQQruK9ho2lT5Akb12+GFn86ge2OcYVQGvfM3adFSdB8dtQKo?=
 =?us-ascii?Q?Xi3QFTIL1fYy2M8Y4ENT7TyCIM8mWW7ss6V9eiH+RBGKpSLJxnJQcywvIueD?=
 =?us-ascii?Q?lOI2wQ6i3Djdyfn2tkYQ0YfkNdt0Ky+M1tPOs9HduC7msoxH+7lYG3d3Qxa0?=
 =?us-ascii?Q?vroCkEGD/nvl4QbW8Q8uMHYKZ2PA3pKPXKek4r0mmAJLQOJfmTyJshRrP2Nr?=
 =?us-ascii?Q?rt/Ig2lOZY1YoITysgdhwID0alU1MClb6bIzfGl0emBQeTjaKcQjQwhx9ow1?=
 =?us-ascii?Q?dQastLrD6nbyzR/6hh6Hj9JGbsj5tUSABYX0zgYl+4nCNhqKKv2OqSaZ3u9G?=
 =?us-ascii?Q?kOQ6xg7JYq5IQQGDp2Vc+C3ELpGAklULtk9gx83pUZQ3yPYZ2NeJSgXS4BGl?=
 =?us-ascii?Q?WTdAv12UqNcHhpwf0ILI3oP6DdiL0jmq4iq+bcrWk1hx/ic9JgZIfBE3gm5m?=
 =?us-ascii?Q?xGhARVTRuHM1cI/EHoaeZG3NXnOlCJS/CCnoLv83XmRPtZBEJt7Y+Gyn/3SO?=
 =?us-ascii?Q?PU/pg+NkMJ0EOvgVrLA0clTXJdQG7A3e7dF+baZZMv2ld8W6rwseLkjYJFeb?=
 =?us-ascii?Q?a8w516OVpLy5jjCf9bxTBFQOglZZqD9GEKLUSxt9x6eEXAugPfKsKzxpp2hn?=
 =?us-ascii?Q?MuVoFF+FQ5c13ksa8X8G1L+TVu4VaNYA1HaMudq6wIpY5ldXsUKnhRy/iqj7?=
 =?us-ascii?Q?8UzEE6j0ZRe0z2PYZT7cs4DuDSSHsFFnLH8JIggv+TB+DKAim8B1rCSoAZvC?=
 =?us-ascii?Q?rzWc3Kr0tb88mtRftFQ7FtV4HqDxTTlpuVndUo37vlD8jjZn01vG+gDmGJjs?=
 =?us-ascii?Q?Rg37o5XfKZL1vfXpLcU8AnjqAr4K6F2H3WV2wDRPgn+Ql8Sn8xCNgJ9Q3OgP?=
 =?us-ascii?Q?/syjqX+1p8oIoXChqpLMe7uHXcwfAWlyl3+J2S2b3Ylp4tducb1U0eiTDiBT?=
 =?us-ascii?Q?k5zwIH+V6/VIrxYg/8JuEnPemPQeh+Dam3G8HpX6rbSrZH2MvFoU2xH8i4VR?=
 =?us-ascii?Q?g6YZS+D9YXOc8JaMkwf9GpP47veexyr2xCHf6BYa?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?CcZiscuGipV/uvT3VjNnOQdEB/jsJEL2USLJh11IqdAxqIMn50eegcdQOYGj?=
 =?us-ascii?Q?CkR+Jdp3SkSXFGKXLxKqtBMRLZ7JYgX/eerc7toIJTs5MFKyWwx1I2NbMKxY?=
 =?us-ascii?Q?pB3lvgPEXB7lIyxDojMR/4PFAWcZVF2phgxQ8702pspy/PPwIq/79XOSVTvV?=
 =?us-ascii?Q?C408Ky861FlPsO8vf7sdCocr5Kd0mY8cZyItkYUUUeBsar2xwIah3+IgokOB?=
 =?us-ascii?Q?qqY6DGXpkedVcXWH2ob4jtSMM8MkM1todIxa9uLgYplyL8EX9B4Jh6Z7tZfo?=
 =?us-ascii?Q?3adQHQPI7ivcH/6yjYS5JB67m2TOLPIReS5GFoC8YutI5yN7ko8eMdin5rzo?=
 =?us-ascii?Q?FowBQJI+XYkdNMynHfS/B6uKw7pnwrmpq3twiE0vpWXp2vZy8COOTMLEF287?=
 =?us-ascii?Q?5UJKVatYBSsK3DJLAAUbZS91/FqSGF3YgW4hTehbngj49x8xRH+LDLhRev7x?=
 =?us-ascii?Q?u8dPXTJlITsQPbLq8BPIzkBU5RmFK4MmH/2lWVJ9MfD+pNRctKU8xJAxL14M?=
 =?us-ascii?Q?xBVfIXO8NxYmIhZJSHMwyxaXDLFUEo1Ylj1/N6lIDuqTXh6iM1YIv1TGf4Sy?=
 =?us-ascii?Q?Guoy41McqwJ6uD2qXpmOaoha/uoQ6XrILzXCgTaEs6fJh01WVi74f8Rwtbff?=
 =?us-ascii?Q?XnQZW5aye3/PqqLqjzGkciMaU/mOLKB69hOYKNmD4i3YP6dA5Bhy+0PHmy0r?=
 =?us-ascii?Q?K50jZwAEbcr+znW3Bd6UivY7gdxU92lK1NokHgcIZ8Np9hq3w1xvFvPdFvRr?=
 =?us-ascii?Q?/eCpLAykcBa4MRhrgYd+NEfiFEG6tF5i0IDpwWBHmmOAbH4rBurvy0E0LgOU?=
 =?us-ascii?Q?ssq5Wo/2KYP8GPW8caAALE/JBj3VymyLw2MwjlxDLL/SowsJipV+QsnMWyhe?=
 =?us-ascii?Q?oibqKh73LmItGIP0vH4eOWq8sz4rK28o/vph4Uztyzo0E62EyKgB8DwnY+O6?=
 =?us-ascii?Q?0CL1PMcm6N+aEbSGN49Lt38NvoOSzyKFFR6h+t5pq67gxPbGzsOjLZCu8Jda?=
 =?us-ascii?Q?w2TcaHlghh1BgrQsjlhQIQ+1c4DczLezWHUN5ZzkTtkIW7beppqpRs6UhEhM?=
 =?us-ascii?Q?BAKDLiUzKH61XvjcoAGGjDcLOVXjDqGOBG/4UpnpQrNCIcibbd/IVPLGNEUL?=
 =?us-ascii?Q?qBLLzPZ+G8vKfNBDElY2tTAPicAgpyzCMqZLhBAOar+jsskndLiDz56NVOV8?=
 =?us-ascii?Q?R5Wxq7FVhd05aE7TZOnl+BJMLQyNZ6xzdUpKoh9/eseLvHFnlnfzRorXYkOt?=
 =?us-ascii?Q?BK+2IcA5oF5zATVk04tDHHx9sKeboua8rDQUonEmgpWDAev/e0tSp2t6x0SM?=
 =?us-ascii?Q?gZ06/1MLEwxuOFNX3ffF2oxXV28GGxuTXfiBRVv12SnviqQNBE0gXrT/5C2Z?=
 =?us-ascii?Q?eFnNTdyrfG1fVlD7k0vnJaID/Y5UX4gUPXVyHdSXbqwmV9ynBhX+BWlk6cQK?=
 =?us-ascii?Q?8j5RWXk4UiGNp82Ud3An2CmQw2RA/TT4k5+AUjgTnT06EzS9gb521TsyaWUP?=
 =?us-ascii?Q?RZlDAmzZXwWTBuMbjwcTlhMLj/3/p/f09lu/atgeQtn3dBDThHKhr8RP7Rdz?=
 =?us-ascii?Q?IfwLM195RYJfl+8PnXt+TKkG2Gq1ISGdKy55ZbuDzIwG92hgXA+2Y6k/+gvG?=
 =?us-ascii?Q?RoO/rgMvUTQsh8Cuxoqyx3rSrKfo8Q23LZqPsh0pwJ7l+b9KuntDijgI5OmB?=
 =?us-ascii?Q?P1icIW5aK3LPNHgVpfpnUBhOSR/4xnJFU6+GcLKAuYCBkOqkAlV6GG7K93Vo?=
 =?us-ascii?Q?dc/scS0k9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DfHZLlc9b1aJJqQAD4R0q6f4CvsGZccORRhwSCSgx0EOMDWZtk4JoDbiX640ISUQG45Zh7CpXiexKkZt3n8X6idHtOIbD0pPspp81lVoRZj9QWrJt52yRlP8PB0IM+nij5f1HTm7SN6fehRIvvadMKGtGUSOArKI+VL6UQOfMBgtE1aJ7SdH814UsQDW/bMMJjsNHXPZwORF1xZLi6DAA1fIn6cgO5156X5KblKsb+HQcOKNfP9GycoL7Tt5gsxLaFA4cpB6OSRDQx4LzNkHcrwhJzx8pnV+vdrOv/zeYK07oGkeaEYq0Te8ZgMp2dAlnT1WkfMgqVr8WoJCyOJbUx0+EP0V/6bOjJiuZ89WlE4IhwTXdUfusT5GfdzxggWuoN3uZuPymp1kEVKsCDPQ/npgp630oCbzPAFmVj4ARIPIHAusjO3sw7GTnFxCjOopbuxWtykea69tKEOyh6JIgy9Bi/3VC6RgdLN0zYNKilsXG+I2GYjbUtNtpApEuQwZk7iJJjTg54XhbGRIfbR3vq2ocbIvg86N2gKI5FytwPOyjPbG/EY/1tun6sp2Iu4kqeH6ZLFNYi076jwUDVFxgAuFFH0/TIDM952UxSmKkDY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc9e98a-0ac5-4906-54a2-08de5da9c92a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 13:41:34.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3or5pfaOpI5tR+nfcvnPS52DkXPh5ENCWQF/msQAcTBvfYk53e+9rs6vvIpU0lFA04kMT1KJK6f0Jur5jgojXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExMiBTYWx0ZWRfX+8kCxOTDRoHK
 ivFu3IuYBm3KPvbHw3AAvJtCVUCpf/Pp4lIs45Z0XPM2qNnWGkB+Lbcc9exDaGIG0Wr9wORTlck
 EJ7wxVZ+ExUFtdG0yMr7dNe62IZ3u+bLZD9iByb3KmKs6/K4EbimPpX4QW7KLhzClp8E/2TV+mh
 Nkd1kV6wy9NJJa6H672kyAr+3BjLK/ewqPVG9uWUGLEndfWB0IamuNoZEQoFHR6CRNwq6l/MhdI
 le/2SzjCkDQYXFcmF0pcJTFcMGDug6o0auSvucAwu7DfXCRx4pRgWZauDYLjrQH/eX2sZwjbvIt
 PA+hjYrpl/STc2PKM6eg7WwJn8ZNhuWAgReVnwoDJ0YK7C/pmgMNf8w2djMjCxePTzcsW/wJHIt
 5lyipKM7OhYdokcnkupE26mGy3c/p0NYWXThM8wGIQ8A17oFFrNtwy34wts7Fq1bRE5mmNUNhqJ
 tsylF/fNU1SYndVr/lQ==
X-Proofpoint-GUID: L1-EB3yGsOvZmOO6Sgjx-COJCW9vShFH
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=6978c095 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=i0EeH86SAAAA:8 a=YLQEXtXBj_6quF9Ign8A:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: L1-EB3yGsOvZmOO6Sgjx-COJCW9vShFH
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211818-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,oracle.com:email,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 04CAE95152
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 04:22:34PM -0700, Jane Chu wrote:
> When a hugetlb folio is being poisoned again, try_memory_failure_hugetlb()
> passed head pfn to kill_accessing_process(), that is not right.
> The precise pfn of the poisoned page should be used in order to
> determine the precise vaddr as the SIGBUS payload.
> 
> This issue has already been taken care of in the normal path, that is,
> hwpoison_user_mappings(), see [1][2].  Further more, for [3] to work
> correctly in the hugetlb repoisoning case, it's essential to inform
> VM the precise poisoned page, not the head page.
> 
> [1] https://lkml.kernel.org/r/20231218135837.3310403-1-willy@infradead.org
> [2] https://lkml.kernel.org/r/20250224211445.2663312-1-jane.chu@oracle.com
> [3] https://lore.kernel.org/lkml/20251116013223.1557158-1-jiaqiyan@google.com/
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

FWIW, looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

