Return-Path: <stable+bounces-146187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC12AC2091
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EA94E35DC
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AEE223DD0;
	Fri, 23 May 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+RBsG23";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HO3B6C26"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB47EC5;
	Fri, 23 May 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994716; cv=fail; b=JS2AjEsVCPnqqQYFgRJrrMemZXhDZre/NEAyWEll5hHWwyJA6zRpoBn0PQQSESdLfwu2iPXmGv0j+whdbd7BVrv0KstN9mrZEUY01ZNo0twaxB5ra97aZLthD0yQ0gr1CaiW2RFPlLZEuNdzZ7WrcSAsQ9cSG4AmgcXbKKdgeZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994716; c=relaxed/simple;
	bh=ZvuFAMizci93Crf7aQpAhbh0GMrZlaxcIYWYcEAG/lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/wKikq1iC8CI/OyJbqMwkFRyuPAGu95/t8WGzL/clGUZCPpq9p4bk5FV7GApzpR1DKEZ1EfA8jt4rgja7KOSAjqmupXHxXHYanuAK+aLcBI0Dd401dpKwNxq5ZXrWG5zuF2m+UsTe2jmBLB5YaAjjvIRgHkK4i4LWHf/ZFFF8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k+RBsG23; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HO3B6C26; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9x8uK026694;
	Fri, 23 May 2025 10:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HjQ9RQ04MHEvgAPKU7
	Yjuiyh4261G9FPeyD6O6WWLlA=; b=k+RBsG23Dwb+QVLob/JA78J4t0L8IzBrUa
	0SBnVz71z2jlKU1BwlWk8OFp5LLGZ76hbKLcRkHts0IakrELoME/sUW3C/1bK+3+
	9QlhwMcc4ZKcG7S9Y3SiMRJ+wMGJAZz6B3YU0cfOYX1o/qwnukddC/WX8tDs735h
	M7//B4YGLchcnFvHykA35NOs2+ntP3dzRaF4GCnM+S18ViiOVaGKyKM4r8WToS34
	u1dOrK8J0HewAWB13jTiA6YV/CAdTrswdpGVJvHtrHcQbBeWTTB8ACXkDzpkSXx/
	cW2ECMAW74FO8IalERND75yH5zhhIVwR3cBtw84MBokPSdiYqQ2w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tpuyr09t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 10:04:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54N8jKkD011351;
	Fri, 23 May 2025 10:04:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweqh7p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 10:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM5PUXeYncQD6PkwxIKxFGGYi5NgcZfEpT5tu1xSTHmEAxsz/eiO+eI+SpprtY58Dp+bAYrkYSfrPwm4+w7sqSBVKMX5Jn9e61nrpV1llh4jHu7bek8b5wOenF/jRyZlrm7zGxt0td/MVOanJ6qOKDHanIMDC+nhb2DsUWmWbMPFNj/Aak88z0+4zTw34OcnV8bEx4lJmuliS5SsrrnYFmkhgtuv7Tx9jHB2WFoYsanhCrD19mjN+2fJToffZLbZ1tirMxIltoBYeCeP7fIXfoYelh72s1phJgjYzA6GO2s5Nq8l6/GcsJbQ8UNkXOLC0chaU7bFJZueY9VtKqKqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjQ9RQ04MHEvgAPKU7Yjuiyh4261G9FPeyD6O6WWLlA=;
 b=SpJBQzUyU/ljGJ2SeIEd9rkKzhuLLpwZ24xcqaxVGF2XYY9c9/obAw9ADEo9cqAWun5OVt04UH3cAVfn79BF3cOqIr3tMosFxlXS7b+T+S+VJWYHpvM4ZKldaKfANobu24xizktVMSD4p25WCIV8Ia9lRFU6dbhLE53oq7898A+3FBmGYDxfp5fuRkvv16g0seA5HgOkjB8KFnBGbWFtgLQIu3/j5BDAHwKgBJDni8975SI9m6p9BXfltU2uOKeYU/yq73Bj19EmQwkOz5IKxRaVt80xTI1C5Tm9cODO5wFatnj86JeGDF+8DTwnnsL9a+OMKA0sgu5gvG/0uzqgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjQ9RQ04MHEvgAPKU7Yjuiyh4261G9FPeyD6O6WWLlA=;
 b=HO3B6C26wAE3uZnxF5ArlczrGnJGhoTRPVxyL4OZCPSfBWSSdWq+2wJvQf/okU8BLYsgqRUjP8cc7VDnN4v7KHNCtfMVHN1LzMurO63cv2Sl2q4Dzww0J2R4mGvh8i5yXgcmIMIAJwhfXPGxAJdMQEcpEws+Eyb0ak93km9mYJQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8681.namprd10.prod.outlook.com (2603:10b6:208:577::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 10:04:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 10:04:46 +0000
Date: Fri, 23 May 2025 11:04:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, revest@google.com,
        kernel-dev@igalia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
Message-ID: <edd2b2d1-fdd7-4e11-9024-03098da78dd1@lucifer.local>
References: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
 <afba02be-21d0-49f2-9ca1-36ee6f7fe27f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afba02be-21d0-49f2-9ca1-36ee6f7fe27f@lucifer.local>
X-ClientProxiedBy: LO4P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bf23be-3639-4c8c-ae5c-08dd99e13f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGUJeXRKQNFeXobVjPaILzBGeHSTAPLLfkr6EOcld5pMd1I5gX6yVUr2mwQ0?=
 =?us-ascii?Q?/NAehAmvykqhGFVnjJ78utCyZPBIOqGXZ3phN/Fw5FzQ22JBN0hRETlPy0E/?=
 =?us-ascii?Q?AiKnh2c7KyR5KmKbzJof4XY1A64qSU4PsVD7/5GQPqKvuDzSE3Z4eUrOXt3n?=
 =?us-ascii?Q?4qg9EdNMHDKK/Ae8kxON/CsowwuanVNge4K/kpGbCNXbwEE4AZEZaFrENllw?=
 =?us-ascii?Q?3+mBSKiP+dJtYbzXa8tJSi5PIUyQAqfyVh5nFrR7q8OLw5v3aOYw0OqK+Z2e?=
 =?us-ascii?Q?b0NzTrHYXUbS9Aq8NIsdgTdQSkhbLGIcNlWvSDjaLqlSRf9z/Qmwz0D0e7vU?=
 =?us-ascii?Q?kt8PI5jM48nNe3SMT26ikAYjwE/G20DWObWgQTl+t2nypDsq2I0iKGsLBvrc?=
 =?us-ascii?Q?f9EMXbmBezEEJe2grzRUSk4siSvIgHHNB5EfbV+C/zzePI7P7vSGtKIPKYn6?=
 =?us-ascii?Q?3AUiX0SnCIklhm+956QtAYOSMo8Jb+yUri5dAVcR0huL90uc+SC46zZibk+/?=
 =?us-ascii?Q?/Mx7btkNdpzEXMoNslu/Btzmr+qe8iioIyn8fl4dvd6gJ0NIuWzpvJBTXmWY?=
 =?us-ascii?Q?erGEg6sodcyds/dg1Oeyg+EUjvzvCnI1hA5as7yJMccOJR9vG5z3nKPFJIkS?=
 =?us-ascii?Q?nguPPjunFu2j7pe7cdKV8f29XLxPV8AAU4l7Cr7hpUGrm8MNF+hCAv7q/EE+?=
 =?us-ascii?Q?Unl/pxpsoVcFpYcRQPtkUPFz7gi4Pbj8ooMKvg6sDi3QSjHjEQsJhP6BtzWk?=
 =?us-ascii?Q?wHSdpYZlMlDqtvmCZlfoIfUEcic2LeBtMvR4kYFmc5kjcd/jPNkbVXj/xQuq?=
 =?us-ascii?Q?rA0CaarsKeLas73m44KwL5VHPRAB1l2QhpDICFSd4u54px9jDjkSzexH1lHA?=
 =?us-ascii?Q?WJHHYHi+WPCiBhdy/gD9av5vMRKzifGjMOv9ndRu8YR3LRjDc0xnckaYfCm1?=
 =?us-ascii?Q?2Qu+Z5iuTWHtL0TY53Dk1F1Zrz9+l0s+N3tdd/O5czJrE0ontsroBM8MyySF?=
 =?us-ascii?Q?+qKR2PWMTH160s6SizzScm3eUE3seW5TEfOTEZ0I8ZcYIyDc6jajEzBSRqxy?=
 =?us-ascii?Q?mpE3BQQD8o2DdU3HfTvNjH4MxFTirc3Q8rJJbZuf1t5HTohMbza3yPow3Pt9?=
 =?us-ascii?Q?OXTrzxGw7UZPxJ9md7Z1Lv3UFENOz6eVQ06qIEJA+nkiySn+m0DgDD0vlkqv?=
 =?us-ascii?Q?xk5TnwQ/hP0kjj3bjIEzd1hPTDIQF9Uj5lHLq0RCe87MsFYenXzv3R9vHZgr?=
 =?us-ascii?Q?DorxyMCBap2SV2L91QoQ5mlJxQTKBJ3LXHPocUCqFwBTblBhIeYlYGvsUvQj?=
 =?us-ascii?Q?mrrHBAWRBRDSMYyMa6QXBHgBSCyzAkG1Zn/n1/BSc0LOB98fDO1bJnI1ugxE?=
 =?us-ascii?Q?At+zvYv8aLMN9oGDDLiEmWQv1SOf2ElcEv+CgB1WFNosPJcQK3mcTiNqYQd+?=
 =?us-ascii?Q?/uVn3SnpR0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43nROJVa9F54CWcRZ77CM2ZFwxeMmu0jid6iQBH8z0c3iY7p56Jo7LTGHg+O?=
 =?us-ascii?Q?2EOPGeHMnL/RCOgowTxzi/50wQE6J/xh8yf8Bldu9z1wPJSZcW385CDPjYfQ?=
 =?us-ascii?Q?hgwZ8mclbc6CuvkAJA72BXDwGAnHUxzALQEOCKERvNSvX2dHz9VsLICmYegq?=
 =?us-ascii?Q?mLPaOI28URAl4VNkYmTP2ZpAJ+LFX5KFzkTlutkt2EoH1Ir8RCd7v0gb6iHO?=
 =?us-ascii?Q?pf4XXnQPlyCH3WVHjK1PNQo/hK/1HRL0VL2eIMeHuPkNUvXojxTkx+1rt7xG?=
 =?us-ascii?Q?0aw1qvLNh5MwLMI4EuJZikJkW6jzojpYeOJeiaE9uxXtH83yufhQrPNuMnVC?=
 =?us-ascii?Q?kpd/FsJ+5+9zd1vuYaXpI9XxDgeuz3+oSH9uVajoxlI93qMmDHWI0mSXsNVZ?=
 =?us-ascii?Q?QYeP7KN3q9kjlAwRR2/5DyK54gjIkaMcw9qIKfktfmjzWT4koATT7uFjNmiL?=
 =?us-ascii?Q?mHeI2zjpyBfv2+zoIl0nuZyVPlyTAqCOjvA/XklYTnKJ1y8e1aa2WJ3vrqQr?=
 =?us-ascii?Q?0PprMyGjcWt3N98fchfAaU/RUdM+ZGG8lDSpSi7U7jJ/2V6hhk3OadFEAuhJ?=
 =?us-ascii?Q?7n/L2Rgg2fya+/D8TdMvL1c9Poxfp/cUn+qwd2ooa54RqkWQZlZ523Ru9NFy?=
 =?us-ascii?Q?BYfBhPB3WFW3vrek7d0J8ti+00CzlUKkIhsMzd5sh8s97aSc/z1ZkmrQsS82?=
 =?us-ascii?Q?AVwxAvfu3z7QoXAvFmxYa502vV5oxq3Qv0UXMAuZbczL84KB+haTJRRgAUhA?=
 =?us-ascii?Q?GdK3YYg/K5ZgjfaAqw5sMXVhTNxo16k+SS466ZOmVrt+lahLEbZyxTteG6n9?=
 =?us-ascii?Q?b8XB5YsDmaqhyw+ZdkxpB0HPB7pq7lkUpCDSC1GYVgm/48cVbv4dwi/vkePy?=
 =?us-ascii?Q?0r2BPt51sjB8jRqtQW2gM/SjdbJgtWX4dokOtWNDrkPMpQiTkbI/dpwuEvP0?=
 =?us-ascii?Q?pdVmu4irmZR4LW96uoHbdHQPnQ5heK1XMYq+tB86m0v2u2XiHkH1faUG2aG8?=
 =?us-ascii?Q?PayNcRPCv/bZj4Ri1J2nkS7tPO1q1HUvG/mX7GwwZF9SMkMrebVz/L3+Yz9D?=
 =?us-ascii?Q?x9+cuijzZYTwvka0TiXEFquiLkIK5S4Jp+JBSEeSt8YFmhY19PaX8sbrwJ2o?=
 =?us-ascii?Q?FoOS5Mqx+CpK9hQIRpvyukzTF4GiF7hw9mjda/R26xY2JQCpiKRhMNqHQlaj?=
 =?us-ascii?Q?UasrXuJV6i7VxJ5CKwCB1aLBbHzaFephUmkuCNbv8fptlqb8K4yssIjrbUPY?=
 =?us-ascii?Q?jrXiwmzfyIJMRSERhzhjsXqp6ajQtphNqlEk1vpiXn4YpuuMG5T+GTug9smI?=
 =?us-ascii?Q?kIBzIg5pXrWeRkHwBDJ7BFzWyMUdAk2KGkAq0xPukvjU1DnaME1RWQBlJdNB?=
 =?us-ascii?Q?rXqGp3UCnOaLDAs5vvgdmQutpehYWqzEB6OIOEZdp2qrFSFeAHR24tD/7f9J?=
 =?us-ascii?Q?TVVhPgelSKgx2xbcfpIMlsa6Gs/eNOgHpJmuUGF362kmLd0QvFNGQ9Z/da4h?=
 =?us-ascii?Q?OBDFAUNIRStywpLXHSDCBmEmQO+wGZy99XtnGgnKNl+gcdrsPI0ioFkkNnD9?=
 =?us-ascii?Q?wQnLWA/o1ji99fcReSDZlxdYWXiAym6wIvP7I1wZt5QvJK2zIB/WUxsmhzB1?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kqsvsBhOL7YUuWjYrqz1diDtLNbsPUfneeA88hJL8Y/LkvPgJlJUrusuQvLBNg19DYVJhkqkCDm34h5VsQ7j0kFENZh/VTnm8IsYEOYg88StiV1YAph6nfkFv3CcGjUbI5k9frF0Y3tgQLAO+vg4QZHjif+1pj31Emn8HlzgeYozggK2xItRf8oIJNlEWR67bI9hYWrPGXObC+B5krJZzD0X6ab7KSCWqCTaiN0ZdbAzyEXwHZ/7bD28N3zI5VqPcpwoI7DcNSgMED5f4qlzcjRtFcfRxfsfvIjmfq5wVx2MDMtmhiNlp7IQteG7eaYqKUFH8ZP7TNjL0a+gBMD/LnS2OqWSkgFUMlus7K6Rrtl3GJPWhs1xI4+baI4o53xjjpln+FhVCjnAkf8lInLDNs4Iv1zkGVYRGNNGSmbNpS3uMrvYZbuLaGQGiIq4MK/+b260hgwgM3Ty+SCMp1X8L8LI4xmHPQV1fGxlG9k2nNz6B0/XSu6+hHZ+C4hV5H9NmMxY/wITBcgjPN8/OHWVXCUrRCpAHf4oKWT9RQcCtd9x6+iHjs70RmtVf69K6iLnCYOKCx350VkNDl6q003UfYLvFv2xV9KQmzGocqxT9Ws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf23be-3639-4c8c-ae5c-08dd99e13f10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 10:04:46.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr8R7h31tWd1Va5k8G/fsP/R841jd1CryyJGc3ub0AxthNE51MbrK5n0UAM7wBBjK5pUpe10TWKlbtcvkm350UOfrkfv+MytNDTB9fLSFPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA4OSBTYWx0ZWRfX4sJy3EB8Ao/X iVNtG82CDuwkH/yEBKFOIdwPpEmzmKOd+kiCR9UAFGI/qnlyjY6C1q7QnFaKvJT6rDAL3vjQuX4 y3HfO09tdcPV7PdAMBdJE13k8+erzreO9TIx3OFgr8xIJeSkfKJtsZRQ85gjg8W7uoC3qyW3Jg7
 Zfq4XelUtFdigW9gstc74KHnLixvE+9Cu1AonkPtcAUsktR0ELKeWAum4p6kVAat4U5MD9of8qD ZqQ2K13/PXOOywEAMYD7V6k0ZTPKTU9YCvX48pKduBcn94W7MHhKxa7xMsrJmQsGOr4FVEGYyub sW2vXQpiSN+5izneeceHXU9jrpq7w8oXFXMYllo1lJOJlbuCGMFrXK/PXwt4S452lqYJP8MTQIz
 9YYdcuFgj12m4/caEeNLlaotewvOnUiI7Cv3tBPC7Kht86uldkw4001XQ+t5kD7YL+HOHGkJ
X-Proofpoint-ORIG-GUID: kosPw6bmTSLLQw-nuc4Oo7xY9CgpG9CA
X-Authority-Analysis: v=2.4 cv=PuiTbxM3 c=1 sm=1 tr=0 ts=68304842 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=lN10_9w6cNUPTFwFABEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: kosPw6bmTSLLQw-nuc4Oo7xY9CgpG9CA

On Fri, May 23, 2025 at 11:00:40AM +0100, Lorenzo Stoakes wrote:
[snip]
> > ---
> >  mm/vma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 839d12f02c885d3338d8d233583eb302d82bb80b..9d9f699ace977c9c869e5da5f88f12be183adcfb 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1834,6 +1834,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  	return new_vma;
> >
> >  out_vma_link:
> > +	if (is_vm_hugetlb_page(new_vma))
> > +		clear_vma_resv_huge_pages(new_vma);
>
> So,
>
> Could you implement this slightly differently please? We're duplicating
> this code now, so I think this should be in its own function with a copious
> comment.
>
> Something like:
>
> static void fixup_hugetlb_reservations(struct vm_area_struct *vma)
> {
> 	if (is_vm_hugetlb_page(new_vma))
> 		clear_vma_resv_huge_pages(new_vma);
> }
>
> And call this from here and also in copy_vma_and_data().

Sorry, I wasn't clear, Can you please ensure that you put a chonking big comment
on this function too please? Something that explains the situation, e.g.:

/*
 * For hugetlb, mremap() is an odd edge case - while the VMA copying is
 * performed, we permit both the old and new VMAs to reference the same
 * reservation.
 *
 * We fix this up after the operation succeeds, or if a newly allocated VMA
 * is closed as a result of a failure to allocate memory.
 */

[snip]

Thanks!

