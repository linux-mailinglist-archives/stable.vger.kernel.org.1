Return-Path: <stable+bounces-93807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CD29D153F
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6181BB24848
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C181B6D16;
	Mon, 18 Nov 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RzfPOIuy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvdRS7ZY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF612EBE7;
	Mon, 18 Nov 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946735; cv=fail; b=uuX+LeP4CbsLE3QkCOubcC7RKEet5sNWqIP8N/rHciIbkC8tLxIl6P0svVReXlSzVDLSqeAQfpqI+7qYXqrpYM2kP8NxGXnnt3DEuHTEMUUKQbjlVF65aoe4aef4Ho/ItSnH1QaUAI447YkgVGta6U/bt6ecmDGzKqIk3Vss5Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946735; c=relaxed/simple;
	bh=t1hCLooJzECRV7SyeLWHpWgUQ8VDctOlwBSfMXk8D1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GWoKXJzapkQ0K1veURK/rmf0nJf8y80UMfdUHhM43cKzD9xWdILrEMXZnDVp7PLKKGU7XP+pBMwqgG2DMXDHQ7OZ05d3O9onL22CLYdSvj+Fqjwz0pRrw3NU5Zp/a8kOTk86r2yRdMmJ690RAxpYmpkKFYf5bOl9jzW1imd6dqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RzfPOIuy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvdRS7ZY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QsVh000486;
	Mon, 18 Nov 2024 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=8RQ8l8yQu4P3XkM+
	74IPFpnk/DQtFKTMrVgmgj2SG9I=; b=RzfPOIuyayypZsIP1kwEMQLtjqkAg/yl
	pkPl7tRsQqw8jhppluxmb0HImDgV+/FBQyNMmEfAAJuqZVt82SOI0LamYpoXQYAF
	+ocXfEuGzVw8vLsWTnstsrXn94lkaWPDhEZldYi/pRWOTayeBc20u68iGTPxzz1C
	zLA3ZTr7l+0YkFwdTltNA7nNrGq6jeSgNqkW3V9uDEwPowwCR3YzcacfXEPz7Z0a
	T1xFmUN0FttW96I8GRDbnyPi+uuppmRR8GAQZpyBh4DA9hyoUM7TtlxvWOu7eYmu
	0RoVIu4HoAlfIJcVqWdMl0QA/u4Ln0D68PckvJNO5F5gShEmUYgUHA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sk2m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIFPi6P039269;
	Mon, 18 Nov 2024 16:18:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu78bdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU/nLhqwKVv4BZNSjhbmW5S/anI31v6A1+N08k206Dw7TrGqYzTC4qQ2l/Kdp6ZLi/SpqMGqd6bwGMwMLQFWQhHqvWe9qPC1IILzQckFico4ViGz17a0mxejYsDQYByO7UKGbkvbWrwo4TXR9AQ7yyYOEoitW+SFFxvQSZBRa7aD/VULHgEsog6GDFxZnXnUiMWxIpFIfDsEwILoiaF7FBjja/mzAcraRfB9naZw3CbmQcNtrsPC++aHea/MBLgeqjVLbw+WRCO85wJUXTo0dotRBR7KO1WKpATp9rV0qxqaFI4KtIGj3pu0NeU+rq2GpBUeWeUuIN7XKcJTUiJ07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RQ8l8yQu4P3XkM+74IPFpnk/DQtFKTMrVgmgj2SG9I=;
 b=QFVvt7Xec0xJwwmPkcI5QSy7JqWbTN7pzwCoJ9+NEsaIWbxFVfky8aJqmRaqeaCXVBkjNz+Oofs7nvw7bHCKqsXkvAqzV53iiYI0PXoYNwx3qthGE561DvU4Hn8AZjRKf8gk3RzIsZBIx3HQ0KbH+q16KSAumItq8BhU2+lTg/xW+OiVOjpj2QWEP1Ed2P567r4XQNXXQpwlsLEmDLfRw7gPKsxzKibvj2Duk/gbfvdBkZe3V3St1BNq5KH0oBYc7ztjFY8NL1z2aoPrZ6z7+wfnzUeLELyAMCwlEiviFuUcgJQrHCOZxHLlydOZT877zO8bDuYNafnqLuPp6MJYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RQ8l8yQu4P3XkM+74IPFpnk/DQtFKTMrVgmgj2SG9I=;
 b=dvdRS7ZYt6CyjpdE+VEk3TdBEdJ48fevsPMymY94vgCMH45HJf/vfDlC7Z1rJvw/reAo4CbluwBrEjFmN0ILBKbajd2UlcaI4f3uHO29qRNaYlXIy801e3U6Y3Y2zzWXCnfjilwLOQ8+kdZKkRuXGfNMlMq6/oPFdbyW1zSGeEc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7619.namprd10.prod.outlook.com (2603:10b6:a03:549::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:18:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 16:18:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1.y v2 0/4] fix error handling in mmap_region() and refactor (hotfixes)
Date: Mon, 18 Nov 2024 16:17:24 +0000
Message-ID: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0423.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d89ae8-6b2a-4b7c-2758-08dd07ec94a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?miMqmjBoDT309wmjbC8k7FCtvJTq8NezKNonZZI+mULHyvnS7WMM0iOUmcaT?=
 =?us-ascii?Q?XKkfMrX+S4XtKFLzQvaItJ9aYG4eI4vgTL7G8HkExdQovgj0yHqol08s4Hv2?=
 =?us-ascii?Q?I7YfJS73m8i1izDnFJhF44OytjuKiZ5XQvVbyxlcCBEyBOgbpdMf/MU1uoH+?=
 =?us-ascii?Q?laAzIwFABj6lwI2GFor/ifv5Cjyt4ujV09meBcxTYSNVrhBfo/J2usUc4HhK?=
 =?us-ascii?Q?Ol6mdK1rz1YlAuc649eiVrJuVbkeBJwHQvii73iwDyuMG+GhU3CudtoEcTcl?=
 =?us-ascii?Q?ts1FjHTSkOwFE0x698LYMWVWCgajZWN3KQrCiPWinT0IOii3hiCRHZCjEUkn?=
 =?us-ascii?Q?pqLLP91TXoi76Kw6ZKtowmXv92ddFtIdcmPsjkhr8kXuOOumLh8WwM+YzveR?=
 =?us-ascii?Q?8DEn4qWXijsNzI4l6QtkUMvzuLlkfR+3T8bVhhxxuNtHBzEwRByHLe1bUbvJ?=
 =?us-ascii?Q?IeemUmM4cH+Uj9K5B76NPG4Lkp0UScHntCQSheZaOY0daxn8e6w9ZqxogHpb?=
 =?us-ascii?Q?etaXlWA3Qqu3yTqtmeuTqFALIr1zGXEaRRoB68cVnCXoXuO1qIGaNavoLo7L?=
 =?us-ascii?Q?1kazlFCD9b1dikrMA2T20kHp77WfVOpcmMlqGIPPCqtL6MOJIo5GsH5tnNFR?=
 =?us-ascii?Q?LOWFVJzV7DHdnMP3rkC0HH+DGdFGbOZBe99WYg+MCZU9Noey0USKV8HtrB0L?=
 =?us-ascii?Q?TJtvVx8wRWwJuag/UDer0QmR4CcZxW53qfP/61H3yduwJXIm7+e+KQ0r9T42?=
 =?us-ascii?Q?uAaEFhBJLggssWok9K0UNtHqSSPtGUq8/5WJcVfVM9LV7IfD2RqG94I26id/?=
 =?us-ascii?Q?gYUjZFKeH+0Wnq6D6y89lNt+thl7q/4tx9tuqhvA4r2PIIJTpxzvWrMrr2i7?=
 =?us-ascii?Q?IUtm9MuBYMh0u8cQi0sGge0Z9aVEn2c8RG+4OJD1uYoEnewzR4ARFIUy7M7M?=
 =?us-ascii?Q?Rg1+cN2/4jXga+nYHWD3ZQ0xtdbNk3ZZfi4NhWW8INBGB6HXZYbazQzzb2Qb?=
 =?us-ascii?Q?+oaRwa1Q2Gphu0rkeWXwsykNW3O4srRgFl5GNgoq8Lpm8LW8JRONPgaRNtsa?=
 =?us-ascii?Q?gtceV/wKbe4aETCMOxldSSL+zndDFDet36N2Gyq0juXyyxgTGKtOrr24aMKJ?=
 =?us-ascii?Q?H+8778MSRMtJxKBjUBBvgzXyD8/W8SeZvcqjCxC+TQIyQhiOoEHcLbbWeN06?=
 =?us-ascii?Q?AQyMJUvTsZNkeJlhfxryfX6DCXeeqqVF/lIJbczXKOt4aOKZGv2uBN/UUnfv?=
 =?us-ascii?Q?vX27IIqic8OOBuStb5PAp05Segwaf1XG2erRgA+XwD151qAOdNuNhMkkyBS1?=
 =?us-ascii?Q?MtshP1qelHuGAeZXtUTpO6Tw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8p71N+Msvqghn9rQwFmc4GYEOhjKBjo0U98yZ089Yoi29YrdHltB3+8AP0L?=
 =?us-ascii?Q?Mx1TdqAoBc+ZEKrjMyviEjV3MleBd0LKNZjv9W8UR+CXhnQmCEjnK9khFl4M?=
 =?us-ascii?Q?GvLlKeoANmif2xQQ2AoIjWyENBgiqVywyWXRqQkuShK0hUsi4tbGSYtU408w?=
 =?us-ascii?Q?39cpfy442LmBmTe20TOvGb1eSAGvgMq+g1Xm5N5SKQOq+DKnrCNRpHFb5wsM?=
 =?us-ascii?Q?jXlYPLRfpt7WIDimUDOT3L2LyIM8gfpLl+5xRx2/gMTdeDRYpi/v/KhEICu5?=
 =?us-ascii?Q?/wU/x8qtReEUSD+jMVR3AahZVI6I3stO/C8LjFC0/JHOer2bRcVQWjd5/8t7?=
 =?us-ascii?Q?jQ7+EThHXyC+QyW1/w0B+YIj2Ba01EvmdypvVsdWqfKG1rAy/oqW9+wa+aTK?=
 =?us-ascii?Q?n4tOloEZVn0yZT2m34Xl0JZ48YEeiNjaXSTd8b/ScayOMYdiVIXe+JQ0EHCM?=
 =?us-ascii?Q?uZH93dmgz0FWXwoyWfdWo4ScTgedXzxwqpEgdcUW5PVKjKz1IMwdvtTbz0Q7?=
 =?us-ascii?Q?VnywMme3RlY95tlLoWgF7Grr4Oo8i1HEMirBvGW9U/i1HVRFzaZjHOi+4iJf?=
 =?us-ascii?Q?5k5wf6LS7zpJsFOUuzuSV2ss1LiZjsXyyEm5luBaAJAJml1x12SFvko18Nkc?=
 =?us-ascii?Q?k9fgnzVuYCsKAl7LoFNBBdSupjMVu70vY7oFtDNfzScrAn6h4k4ezSUhbxBU?=
 =?us-ascii?Q?aPQRht8AI54z6/HE6JudOuWM09uDv91OI48U4tIVBpWww2aO+E6tuXtJc/mP?=
 =?us-ascii?Q?q8+o7tduUZY5G64HlQyzoAUAkHmhq026DgfIMqKHTp3UDvgcnIJfIObdQs6L?=
 =?us-ascii?Q?Zar5/AEIuMpLQXhjHAhqK8q2MMLD148qyPHeIHiqA7qU1VIjF4B3rr2ZT6yz?=
 =?us-ascii?Q?THBRGyJCdbGbQKZfjcg8f3LhNtsvjDuVekDCrQ55FVGd62nPOudkahjnHIse?=
 =?us-ascii?Q?xlLEKUNi91rZZ5ImNvk64uHZZ/IDbqRp40aV65c/adEhtALACool2jsGlS5Q?=
 =?us-ascii?Q?Qkr/xa0UfbqY0b2FG7+t9YhRI3pwhUb5RJ6JkDEICcp24VlP/DYt71FOZZJL?=
 =?us-ascii?Q?HABoC1YsixtjcUSj4p9i25yIhgOjkpAOGRySHIngFXtVkmN55Dn6jeUQ8Pu7?=
 =?us-ascii?Q?FWXyVjHRRR4FmxVtmQBMpuJKWvnG+VPo3HCaUPg01WnkyJvpm+3piE8OY8om?=
 =?us-ascii?Q?6sAdn4pYBU2N9NExEVf1rA9aYJfeUxCBeJBsAnSYz6bwdDxTfd1XJIwC7cCw?=
 =?us-ascii?Q?G7VzfKBVoVWG4JhkRiT1YrE2H8FK0PLT0efxa2KCHYDEZ+IFcXWvtWO0qUyW?=
 =?us-ascii?Q?mftKsBlweAAYCT3T3ElnWRPSmKM4h0BN5ixUdKKqRE5bh3s3Lldh4P1lxXJx?=
 =?us-ascii?Q?UJMF5Xc/SeEoYSf4QexoraV3ClX6o2yI4d9LsQfM7TRcgWZjswW24zpQ/W3q?=
 =?us-ascii?Q?1ctS5qBCq3ZlyG4B0JmstuY6SZGbFunF0Y25whIAZVc3NyDF9UK9XG56SF7K?=
 =?us-ascii?Q?/JebestOPUfOJeBA31FMMGt4W11yr6boz90mb2oeidVAhkEHeNDF5i6EDsxv?=
 =?us-ascii?Q?SblS1B7kljTb+EgiU+m2CuSRlHrJFN+klL0YdgviOfYtfSIIYrY173+3GMbu?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yw2r9p1Rldj8JfF0ss7tmTJar1RStT8MMZ21xki56vvg5JL3tbTTunh8y8ybeUVidlAQICn6hyN3HkXgqISvxh7tHj4VDurI8u2MRG+p5oUrEYCoCqZ9+KP38BO7D7ojBdN7zmN/6xzxSFMlXcxC19M8eOMBU44o5JBlrHb17oIw1DIL/zmeipRoGC51xnh05HMb54/EPJ8J4xtC2r1fPepmnW0rSyn/1YxZoRtCgAe44cH+aVJvgfnCmNgblGmWZRzsxajnmoztfVQha2IJIg767yaP4Bqw9QHlO6wm2VE+TgqpiTfyAs7RWqXFJuJ+saqAWR4hR9Na7XNpR96lYfBJ/Y2SmPt8y0ywefDbBhs6nVxfA0/XjRZ8kuMvl1PYK3hHT4zrg7eziZ4QnQSajb5JV+Xz/lWpWSpW5hYHPKL0V3he3GS/lRhZbe8K0c774Q4yudabkNYAgbsWV2pPXayZGoobR+mUzDqrRMmNuJTXHjtFqrU0kxkJlVENNBEFDT9V+gnaYabMoyunU/IDAlTprJFPabev5PgWIsKzj6FPUMI7Q68MAwMheWrNhZ9lTrgwLlwnhPan3yg/q9iiImOqyc2R8QstVfqlfzMImnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d89ae8-6b2a-4b7c-2758-08dd07ec94a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:18:04.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSIt3wlE3JtYrxLPSD0GwLz9nMTiS91i+anMuNFVjT4VItOmYVs/ScBvFRKzZe1VT/nMARfR6ZLKgDIYoht8fUAmFCUnFWUIa/m0x6D0vYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_12,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=647 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180135
X-Proofpoint-ORIG-GUID: FmtiEMQ3Ochimao3ZKZ8Be9LuH4Wtdcb
X-Proofpoint-GUID: FmtiEMQ3Ochimao3ZKZ8Be9LuH4Wtdcb

Critical fixes for mmap_region(), backported to 6.1.y.

Some notes on differences from upstream:

* We do NOT take commit 0fb4a7ad270b ("mm: refactor
  map_deny_write_exec()"), as this refactors code only introduced in 6.2.

* We make reference in "mm: refactor arch_calc_vm_flag_bits() and arm64 MTE
  handling" to parisc, but the referenced functionality does not exist in
  this kernel.

* In this kernel is_shared_maywrite() does not exist and the code uses
  VM_SHARED to determine whether mapping_map_writable() /
  mapping_unmap_writable() should be invoked. This backport therefore
  follows suit.

* The vma_dummy_vm_ops static global doesn't exist in this kernel, so we
  use a local static variable in mmap_file() and vma_close().

* Each version of these series is confronted by a slightly different
  mmap_region(), so we must adapt the change for each stable version. The
  approach remains the same throughout, however, and we correctly avoid
  closing the VMA part way through any __mmap_region() operation.

* This version of the kernel uses mas_preallocate() rather than the
  vma_iter_prealloc() wrapper and mas_destroy() rather than the
  vma_iter_free() wrapper, however the logic of rearranging the positioning
  of these remains the same, as well as avoiding the iterator leak we
  previously had on some error paths.

v2:
* Fix 6.1-specific memory leak if second attempt at merge succeeds.

v1:
https://lore.kernel.org/all/4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (4):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
  mm: resolve faulty mmap_region() error path behaviour

 arch/arm64/include/asm/mman.h |  10 ++-
 include/linux/mman.h          |   7 +-
 mm/internal.h                 |  19 ++++++
 mm/mmap.c                     | 120 ++++++++++++++++++----------------
 mm/nommu.c                    |   9 ++-
 mm/shmem.c                    |   3 -
 mm/util.c                     |  33 ++++++++++
 7 files changed, 130 insertions(+), 71 deletions(-)

--
2.47.0

