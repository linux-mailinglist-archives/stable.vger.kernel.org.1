Return-Path: <stable+bounces-83237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5E996ED4
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4732842FB
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9D19DF41;
	Wed,  9 Oct 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljW5bHIt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FiYyVYmE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E531558B7;
	Wed,  9 Oct 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485684; cv=fail; b=jqfYv8evEAs4QrFQImWa5MQfmcCxysVrMi5ZQqPbnYtdaUTDXma5GActo3Ky9ocGZQAIuSp7RU3ziCD7uQ6Fc5hULOP2hoW2nc4JGjrTG8VMRYTefmaFw9zGlaHxD/oeaJtCim3eaz7jei2LqTIH++vsI2uvinMZV53sNLD9l5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485684; c=relaxed/simple;
	bh=pcEwmBAbYeY3xjjTxJue5QBPUEoiRKKAxdx4c1UsiKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dhIaNrhsyMAzdQghqAVFeZx49vOYUppVp/raB4LCYHgBKJIuj35idnAFmFc6la15BxFLHG+2RdSj7Sb/Ff2MhmEGl01urvlbIT23ZiRXGTK1UJrgotzDnO+82MWqK7EFpixpaT5bVTTQUw3smYRiEAO9MbS9bAA4qbdKYrbXLA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljW5bHIt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FiYyVYmE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Dfe83004690;
	Wed, 9 Oct 2024 14:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FZlduOiwCOO3J/H7vA
	GzuT4tOJ3oiYKThZldI1YJuVg=; b=ljW5bHItT7V+Gy2w9/Pr8Kj0o+3qLSJ5WD
	PuMdcFMMoU+ab2zml9evj6vjvQQ2FUMjUkprti19kw9DxkDZJv+1n310kDMXY+YA
	34D/YPtRmbBPmOd/bqQZM4TqEFUdFl79t0uhoYfhqe4JdpMy5jE5+fKKLPrxtCfC
	/UcfVNRmP5isQC+KXpbt4YC+L4HrZfy/B350nPgxHeC3LGN3xKTG1Iqq7RPuVfjp
	X5xlrxzCgr9AqVpTeKmwz664FVclTcPMn/7ZC+hqPjUNr8Haz0b1v4tLd4INM18G
	i4kqpI9W37raeqM6QcU/McRgKvCpHt6UT6LtuEUpaqG/QiPRHJjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034rrt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:54:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E2GYJ019140;
	Wed, 9 Oct 2024 14:54:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwf0j4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1kj8i8p/XqwWhxyytxJGQ1tlGDi3WOBiSKRYg5wxrQmRqWWUCGYrVriC4uosNxbsBe3Mowkl9JNMFgvIkDb1PTBIcj6T1SkI21/1ZorSmcHwi8CBVFF98fSQlyXuDgjbYXhmrIJCPQgnc9Bddrp8JDhPAupyVg2pMnAI9uv8Z+5tgwnt4RhsyVhTB2Xe8f16I0Goe3qtOjZ8DeM4kWf7Ace3Awre311Hm1KEiLB8rmUJbDiPSsZFP2ENXpTBuj5wZt0e44y26sI/4lXGIsaK57jkPOCe0i/WrYaExPWXFWN6qNmEq8bLJZ+Jh5S5iMLruEWZxKsupgfo11Id2/jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZlduOiwCOO3J/H7vAGzuT4tOJ3oiYKThZldI1YJuVg=;
 b=B0MQhTxR7tSFXlZkDHvwrn9/+aXppF/eHSarX7Mbx55/k5yht5HP2Q+AR250rHCCc4r7MALvyrhu1pMxHOrlqla7IzjzRFPJ/QG5RFEbvIQ0eu3NjoQxS+HPNZlZY8DTLujtwFvqckdsmsQh7VdlyQUQ7cxGShD0Y89doTU9QZHDbztACdVRgIoDgHj9MSZqjtsUepFfaFNiyReSdlK9Ja+m+qN6CGd6q+o9Z4jkF4izqoKWNzEG7PcuE3ZM7o/piyyGk4ZLdyYrOXqIMlcE3IdC+HgUILS9UhyR5BHbRIcKJBvZBN00E4yXoZtZasrVS79JUv7FbDdfyRm1j8j2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZlduOiwCOO3J/H7vAGzuT4tOJ3oiYKThZldI1YJuVg=;
 b=FiYyVYmE2IWgYWYW61USYgeV5MRCnXoBekMTcZkISTHWm4W5iWBBwZpg+AVkUVjGJ5SrRqd7j05+Sx3OVZccdzC15o6SfnzIr+fpEqC05VAjrLNp8UHntVI3/iIrzHfnPIB/TxaQHrEngnBEnOAl8A+fGsWB6J6yBQgJ1DF1xKQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7471.namprd10.prod.outlook.com (2603:10b6:208:455::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:53:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:53:53 +0000
Date: Wed, 9 Oct 2024 15:53:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Vlastimil Babka <vbabka@suse.cz>, Ben Hutchings <bwh@kernel.org>,
        Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against
 inaccessible VMAs
Message-ID: <f065ca1a-473b-41da-998a-cd51ae1d201d@lucifer.local>
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
 <202410090632.brLG8w0b-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410090632.brLG8w0b-lkp@intel.com>
X-ClientProxiedBy: LO4P123CA0329.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bfdca1-ea34-4938-8f1a-08dce8723188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dSqzEspLr6iDfcoWq+t//fHJ1OM+yFfzpkDoGXng1M8hy6s+WpKBSRbLvd+?=
 =?us-ascii?Q?dfpYiUQeD7A3RrimroerQJr7NvHxF1Wnfp8u8VgKs9y52Lgkgfrtct04hIIy?=
 =?us-ascii?Q?2ixGUjuciBfHbz2EodeRDKxaDF/T4XlggiVj1ElWslkc5RfnvTcYaP2U81BF?=
 =?us-ascii?Q?fPj3uTchQscLAx5OLIdrxRUWM6tLtauRQk58S3Zirzo5ieJEtYG822kIsPfi?=
 =?us-ascii?Q?w5WO5e3+jFJR323ReDTLvsOKN/3r2PTD9go13BdupZqmCxPZ9dazKPh7Xm/7?=
 =?us-ascii?Q?gxhvCpx9RycpDcYHx6nBj1mVhRYSxEbgHx9tdOXRjntNLJJsMyzh9Udb9dz0?=
 =?us-ascii?Q?4vV8tP6/TiTYy1atfdH1iPpmWdDchb5DcfZrODRAeKdoxYNf+9uRaWo6jdgY?=
 =?us-ascii?Q?0tQp0G0aJU3jZLaAd11lxSf9GJvmYQckzGkh8vURtmTLXGfrPIN4AA8gML8v?=
 =?us-ascii?Q?kHH+6vVLvCIdWRScK/e6EdRKrJhuFjfUq8en7bS5oVNbbfkLCD10tqGFC+47?=
 =?us-ascii?Q?vJSY6dXNFH+F8ASVx/RYSll4Zm7+YK2BZYedBoaAXi9p7ps5B14DJMJVM5Cr?=
 =?us-ascii?Q?ZfxtBrsnTxeUkpbLzos48rJbTkZAOZ74347jM2SLTX+I7F+rf1Ofog8ebcRV?=
 =?us-ascii?Q?max6TJ344LMiO5gs9Y9gYD+6eiZvFiRu1rVs5o6EByovOciO9e/73k8mhnO9?=
 =?us-ascii?Q?bzpdQzbIDFyl4VKr+0Z6sG6bxe+cCkjMtzBhBQZIoNV05oa5WGKin3SwDRo6?=
 =?us-ascii?Q?DyRaHR7CL65005Cy+h4anvI3oSS6c8wVcnkgzVlWcQZa7h1kGDE/oeHQb0dD?=
 =?us-ascii?Q?hfp3YSqq4M7ApMYVqah08Azg/ZYtQCZ04nU7quS1snOfRuND3BzaPeh4c/46?=
 =?us-ascii?Q?LGNRlVLdo6C21EYgkj9Gzwti2Bb6E5s9Z5beNgc+iSYfYVpnV5IdNYTNHv22?=
 =?us-ascii?Q?I+e+aT5Cm9jY7deJ3LqCkeWalYMBuAkXMZne449cjPa6BVXvqaUlUcMO3Cwd?=
 =?us-ascii?Q?i/GpeSRQTW895SBvu4PP/OCMhwaCRRIs4f8dPLzl3K+6gupUskgo7vpku284?=
 =?us-ascii?Q?vovTShCPFNnn+qJOyIU1JyC/hNly6xhTiwd4A938P+QxenqSqIGAlqTgEkov?=
 =?us-ascii?Q?uko3JU+O1Ryz/FxAEgF6safdyqy5cJRZcisV56BwEacjXBh4Vv3HtrpxLGeg?=
 =?us-ascii?Q?7THMMMfXNYEPfLJc4rGCXlMW2hiB+Do5GdIvitwl+NjUAqEoGT1JNtMmm1s?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MmQwWgwjOhlhoc173eGC/yBkjWXAtpaKvtGVSkbkBjR6kt3elgv4hSroPy9B?=
 =?us-ascii?Q?nwQhdIE/QCZIaYRLAoYVvNTtrDEOs2VK+NVGNNtNQ/JRJj+nWQ7HWvC/KU4P?=
 =?us-ascii?Q?Cg8g9kqbWVOKbICAUPaJbOYmI6hNi/RgY+FoCne/Cq/EWoUgx/LKFrTpkP60?=
 =?us-ascii?Q?ubIaxBMJK5NcXGjwsBTePJ6uzCWCFQNsG5uf6ouiBYmCRQHyacmhlw5Ta3xL?=
 =?us-ascii?Q?2bHu5clR53TblS3qxzXXWe8IVnYFl36Go5UkHfNjpVip0Fe8wjbZ6FVc8yFC?=
 =?us-ascii?Q?cWwVBA5dULYa2RbLfKgSTekuEmo4AScnMcOsH4Ro/cU1rRDawLik9dUrwpCI?=
 =?us-ascii?Q?wu0rVxMvx0MsPjrPK3DomaN40VR6cvFWWRkNqWlnMsGgUwTvTsxmVc5VX8ht?=
 =?us-ascii?Q?ldL5RnIUl2joLfAoKd3vbiurLioz33d0W5tRzwz+mvTsJNLFQcwn66uib6Rr?=
 =?us-ascii?Q?i3nSmoiexcFIZK/uBwhud4NOJI1redp9Y9082gvC9CcqKEoumtTiaOQzfqcg?=
 =?us-ascii?Q?VzOMp24cOGu3g0DgISRA9IfhzgzPoGV0nPG5OkRK614DhKLziLM6SYwQFDSd?=
 =?us-ascii?Q?z/FIaViGRbCEHD4wPkS7n8se6CsLdZ2B/iILDU5gHjmqIXsFKUVFmjiUcEpn?=
 =?us-ascii?Q?lRT+3Znot5Trs/FgaHK2x8xfqASBfUEdxiKRnu8toxAcPkYAc+p7CAv+t4gQ?=
 =?us-ascii?Q?LG2GItszCWmHBLFSLWQorbHcH+he7U4VvJgDXPaTpFVWmLwL9+qfg16BSKui?=
 =?us-ascii?Q?I1974X57XAutf+iIpdfVRKGBq6If1yz4kvpZXoyq53vERc4+pG7NGHOIPXjl?=
 =?us-ascii?Q?5UowegaCbE1UPq98pxg4GA9B4ENP3XhB/aKR1p6wihdAsEPg8C6QaIdZaVV0?=
 =?us-ascii?Q?XrYyWCGKk1wYrocyhhpE6RwqGrflwXqMPvEoiAqU4sbM7UpW814dtsXyMV7z?=
 =?us-ascii?Q?MZxblcReszjtMY0GmK6d+s1BYsECvpW+vrn+429S/UjGfo/7iRWg/4pAfgI3?=
 =?us-ascii?Q?ZptmTBAa6WCWHLpBXY/xOOiEiapTpTtspcmwU1qilSh+QIknHMuswviz/5jK?=
 =?us-ascii?Q?BH6Zaxq5odelWzpil5/dX5xlrINLEcWuegU6Dju309uoSnxj7wzuFOoACRGV?=
 =?us-ascii?Q?zuJRw/IH6Ub6ckguOc9CMCt5iNAJIcYO6HU3zH5CJ+XDhIFNEBWV+6EmX2eZ?=
 =?us-ascii?Q?gT9nTaXFYlI7PsDDCEnYSOpqO40mUUt/fnBv4u1q6FRkB91MoTnYbCb8X73g?=
 =?us-ascii?Q?VM55BR8mZrwbG6/5i24pxmwjDFaAIn9OPgmRTrH6qkckdQuVufDj5h8KGZ9U?=
 =?us-ascii?Q?NkMzTSYqOjEL881brcA7JFQENO+3pA7eKWbH2IPDxUcOBN2jBjDjh3RU4W0s?=
 =?us-ascii?Q?3D1oUCwUbpP9C14L9F4UufC4J2BmuiFtmkWgDODD/ebwruilBZLiQlPcKZcB?=
 =?us-ascii?Q?tVoflmWbVhUulseGK85n7L2Fx/EYi/MQth60UjXf+WgNRzV1hV3/oQF2o5D7?=
 =?us-ascii?Q?ZRvfOgM+NoB4QiR2tdSoePcATEUdkt+PCDDMOUQmvH/Y5zLfk+Wr2e5WT9vr?=
 =?us-ascii?Q?Bx7z7tO0XPUdI5eSXQtMpiUwj1qV3O1dpl+FuvpQWoNBfiefsClZy6ZCaePk?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CxCEAXMS70E+XSw0UGUMQIP8ovlV5okbvBQpRZKVKNgYq3WdKk+6jQEziFgm1XUUOIKGTDPFUcZlY0F0nLPfCY20SVfH8s/o+DXxqmgF8tqiGJt0LS7M2ctEcnBOhleNe+4ljTlzRf2h2uqR07Ctd6JU68RkxxLAvfOLQ95RNzQEugFVtPltz47a1ewM35ECjxed5j4LbEoRQv6/A4XmYXPKKv6rgISPq2dRn1ITrML9tZ0awyN2HkTzhN9y/OieBs+iLAQZCKmH8i/k2c5pGnYM59HCi26/XdASlm4g8U87ZbRU7wucUlXPeA0T1CpZfuAkMsVtPEivZG+94fH+swyFpg0mE5FAxVGRxWRR4rnPetgrnyy+GsGmlZpUuYFmpB78Tai06pJba/++M3EdtRvng1nSSN8pelHHsBxx/SFo7V/LdzG/QfToEiTYTJ7Eeuuki4VtHhrmqRB64oDmY1ueWd29aT196UrxP3i4zush4VoJ3myF7/W3eQA8lme9rSulNwSo52CR5sr10JI5MmAcTHQr8J9qEnVXrGtF8alu3D7vKbuZ8Rs4qy6RINVUN3XHrNvvaHeitJ1zzNSrrqyMdIajL0jz6zfom3pW97A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bfdca1-ea34-4938-8f1a-08dce8723188
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:53:53.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoTOx63nIHfvBoUB0V99QnIsJncUOKicp+xfjI0ELQ8sfPjH7LGn4HbPKEairr7zyouExKcL89JD2wOFjvwsEIYQCJRxZ8g+MF8VoHEZcmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090092
X-Proofpoint-GUID: 7fjeo44QNbqNfkeGiLcWXpVjN5J54u3Q
X-Proofpoint-ORIG-GUID: 7fjeo44QNbqNfkeGiLcWXpVjN5J54u3Q

On Wed, Oct 09, 2024 at 06:45:08AM +0800, kernel test robot wrote:
> Hi Jann,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/mm-Enforce-a-minimal-stack-gap-even-against-inaccessible-VMAs/20241008-065733
> base:   8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> patch link:    https://lore.kernel.org/r/20241008-stack-gap-inaccessible-v1-1-848d4d891f21%40google.com
> patch subject: [PATCH] mm: Enforce a minimal stack gap even against inaccessible VMAs
> config: parisc-randconfig-r072-20241009 (https://download.01.org/0day-ci/archive/20241009/202410090632.brLG8w0b-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410090632.brLG8w0b-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410090632.brLG8w0b-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    mm/mmap.c: In function 'expand_upwards':
> >> mm/mmap.c:1069:39: error: 'prev' undeclared (first use in this function)
>     1069 |                 if (vma_is_accessible(prev))

Suspect this is just a simple typo and should be next rather than prev :>)

>          |                                       ^~~~
>    mm/mmap.c:1069:39: note: each undeclared identifier is reported only once for each function it appears in
>
>
> vim +/prev +1069 mm/mmap.c
>
>   1036
>   1037	#if defined(CONFIG_STACK_GROWSUP)
>   1038	/*
>   1039	 * PA-RISC uses this for its stack.
>   1040	 * vma is the last one with address > vma->vm_end.  Have to extend vma.
>   1041	 */
>   1042	static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>   1043	{
>   1044		struct mm_struct *mm = vma->vm_mm;
>   1045		struct vm_area_struct *next;
>   1046		unsigned long gap_addr;
>   1047		int error = 0;
>   1048		VMA_ITERATOR(vmi, mm, vma->vm_start);
>   1049
>   1050		if (!(vma->vm_flags & VM_GROWSUP))
>   1051			return -EFAULT;
>   1052
>   1053		/* Guard against exceeding limits of the address space. */
>   1054		address &= PAGE_MASK;
>   1055		if (address >= (TASK_SIZE & PAGE_MASK))
>   1056			return -ENOMEM;
>   1057		address += PAGE_SIZE;
>   1058
>   1059		/* Enforce stack_guard_gap */
>   1060		gap_addr = address + stack_guard_gap;
>   1061
>   1062		/* Guard against overflow */
>   1063		if (gap_addr < address || gap_addr > TASK_SIZE)
>   1064			gap_addr = TASK_SIZE;
>   1065
>   1066		next = find_vma_intersection(mm, vma->vm_end, gap_addr);
>   1067		if (next && !(next->vm_flags & VM_GROWSUP)) {
>   1068			/* see comments in expand_downwards() */
> > 1069			if (vma_is_accessible(prev))
>   1070				return -ENOMEM;
>   1071			if (address == next->vm_start)
>   1072				return -ENOMEM;
>   1073		}
>   1074
>   1075		if (next)
>   1076			vma_iter_prev_range_limit(&vmi, address);
>   1077
>   1078		vma_iter_config(&vmi, vma->vm_start, address);
>   1079		if (vma_iter_prealloc(&vmi, vma))
>   1080			return -ENOMEM;
>   1081
>   1082		/* We must make sure the anon_vma is allocated. */
>   1083		if (unlikely(anon_vma_prepare(vma))) {
>   1084			vma_iter_free(&vmi);
>   1085			return -ENOMEM;
>   1086		}
>   1087
>   1088		/* Lock the VMA before expanding to prevent concurrent page faults */
>   1089		vma_start_write(vma);
>   1090		/*
>   1091		 * vma->vm_start/vm_end cannot change under us because the caller
>   1092		 * is required to hold the mmap_lock in read mode.  We need the
>   1093		 * anon_vma lock to serialize against concurrent expand_stacks.
>   1094		 */
>   1095		anon_vma_lock_write(vma->anon_vma);
>   1096
>   1097		/* Somebody else might have raced and expanded it already */
>   1098		if (address > vma->vm_end) {
>   1099			unsigned long size, grow;
>   1100
>   1101			size = address - vma->vm_start;
>   1102			grow = (address - vma->vm_end) >> PAGE_SHIFT;
>   1103
>   1104			error = -ENOMEM;
>   1105			if (vma->vm_pgoff + (size >> PAGE_SHIFT) >= vma->vm_pgoff) {
>   1106				error = acct_stack_growth(vma, size, grow);
>   1107				if (!error) {
>   1108					/*
>   1109					 * We only hold a shared mmap_lock lock here, so
>   1110					 * we need to protect against concurrent vma
>   1111					 * expansions.  anon_vma_lock_write() doesn't
>   1112					 * help here, as we don't guarantee that all
>   1113					 * growable vmas in a mm share the same root
>   1114					 * anon vma.  So, we reuse mm->page_table_lock
>   1115					 * to guard against concurrent vma expansions.
>   1116					 */
>   1117					spin_lock(&mm->page_table_lock);
>   1118					if (vma->vm_flags & VM_LOCKED)
>   1119						mm->locked_vm += grow;
>   1120					vm_stat_account(mm, vma->vm_flags, grow);
>   1121					anon_vma_interval_tree_pre_update_vma(vma);
>   1122					vma->vm_end = address;
>   1123					/* Overwrite old entry in mtree. */
>   1124					vma_iter_store(&vmi, vma);
>   1125					anon_vma_interval_tree_post_update_vma(vma);
>   1126					spin_unlock(&mm->page_table_lock);
>   1127
>   1128					perf_event_mmap(vma);
>   1129				}
>   1130			}
>   1131		}
>   1132		anon_vma_unlock_write(vma->anon_vma);
>   1133		vma_iter_free(&vmi);
>   1134		validate_mm(mm);
>   1135		return error;
>   1136	}
>   1137	#endif /* CONFIG_STACK_GROWSUP */
>   1138
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

