Return-Path: <stable+bounces-93042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4409C9104
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EAE7B2BE53
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CD3183CC7;
	Thu, 14 Nov 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ICOnwwwi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qprPlpDR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA0262A3
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605461; cv=fail; b=GRsiBPAG57BKTbeidk5gbOylffAKKf8/F+x8AZPHWlttPfPaRG1dSBS9l6P7qUQnIGL9RNqYYq1f8QbMH+SySLlYMNJ5fEoBWYbTJt4sSHEQv99mBJqBLsrVBzvDilWqz/biDjnDxHH9cgtze/T0bVLdbJZo4kBx44p7l9f2OOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605461; c=relaxed/simple;
	bh=012NYYlb0TkUrAHPmvBjGFZZXWpbtpwxR7fDWjfCxBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+qVVnWpwhlG1h+BqiM8vqDwdWRFnBPJp9f5P2oCPNYaRVidJrGtY3aZwfL3B60LnYTYrU0Mh++M9f2D3FGZv6IiICUGpn7zX9BfSVg2n6GOota5Zr+2SSJynahF7D4h7i7UuglkK3r3lu8dBFu7RxeXAZui/iM1qtBsYsSbIG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ICOnwwwi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qprPlpDR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED3u6I008329;
	Thu, 14 Nov 2024 17:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Y3L1akylUeIcwynmqCMb5AdK4dSqk6cZjrzx6bVRPhA=; b=
	ICOnwwwiGm/CBpdt9xdCII4t6j5wppGl08aduc4eXCQ2GNDQnkQgVlNDq23oq65i
	h6H5HLtqpRmYlboJCYoUDo35q0czEVPU7+XiEobzRnkBGatKLfGj+7OKtjE/tyWf
	5gmNPHwO72gqHdLFsqnyPdMDoXUmRMIdXif7VSG1O212ey3nZfJDaM8yoJNLjo11
	osSIJCRJadq4gdwEB30r7YVBtxQHrhGsZ/oJ4FEQdKlcZP2dCXO62Acrs8EPLUs7
	JLaEoN6fZxD5VgiHYVXyFOdSz55WHTKjSWXbUA0lvjDLfKBA9LYs+C48vmeZE1D3
	GHxi949+9/kCTSBFYpuJrA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51shm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGrJi7036059;
	Thu, 14 Nov 2024 17:30:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b46ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abBfP73gL0zbavE89PTp91NENkj4EyUbCYDp41D45BDkNOBUJpuc+FRtGDel1yk5w7DnXbEek6TzsgZguELRJXw7j2wJArtS4wB41EtCDbzo0P0R4znbffY83yCtSgtLxkHigz5pTpi1qvVO+ylAdeQe1xNdpJVBFyjP+YY1TxN6DgZiRpvWMSE3UYCfsR1VO64DpkuuZGjO5rOx9N1zRiCV0qrLiR1mlmUirKMs4yyhp7gBCzkl6F/SHbkAJaidLjdKqCXHxSp3wcwaygzRIm212IhAxRn/wUPfCNEtm0D4mFu0xqSL0bdGu+GEp052Qa2z6TvBEBoL17z6iRoknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3L1akylUeIcwynmqCMb5AdK4dSqk6cZjrzx6bVRPhA=;
 b=RNquV8pqtZBwSDpuZ7Zzkd75Tvj4Ifdz5buoF0QWICvYvh+f62GoRUIJZdQH+qJZDDSaX2B8Vr7sLLf3y7P+GDbyi2v9pGypyQTryHC9I4WwEUVpQ6Ko9ZVSq+QGBcAlf1St6iGbP8SdzffROO9SSR/MdsguREO9trt1X2RXtFjsl51sS3nMDwtzpAlNMX4l6lTlXtvFKIzQHA3S8G6+OsZEy4A1BQgwBmZsuPLN3nx77t+ZRj4Jthy/gbPpNBPC5BGYBNj7MBpR85eNq/prg+6zsCTo2Bx8Bf49AH7NPhMQ+Xm0uTlbHyZXUZdKlYkku0ktmVwlVwpBJq4Dj7BD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3L1akylUeIcwynmqCMb5AdK4dSqk6cZjrzx6bVRPhA=;
 b=qprPlpDR0nwIMR0WZt8ZEJKeL2GcsebjzwDgHJk0UTpWBvKMqPoxYW/0je91b4vIoYyKFiEa4FY4itt2m46gbbp+0RCS7ymGOKaPF01C1WT/qNoF2/ZqybxwfhThICdOyey02OwkZ1CqS3kopX1KPjqc4PPHSNZOJvSqrFGNUj4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:30:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:30:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: resolve faulty mmap_region() error path behaviour
Date: Thu, 14 Nov 2024 17:30:32 +0000
Message-ID: <20241114173032.731265-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111151-threaten-calamari-7920@gregkh>
References: <2024111151-threaten-calamari-7920@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: da57651b-435d-4b8a-2827-08dd04d20c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SAiWOW+/UQckVNgRvJPlpQK+ruDu40nA5iHKt8kGqKhyekIFHg6pGYyEzc76?=
 =?us-ascii?Q?86ewTrbp1+A+IJEfTRc3akAcBh4twtzFE2lO21lm8jLNu+y+AwJyBdHl/568?=
 =?us-ascii?Q?2pswvZkLALvJlEyM3grQ9Kr+Qoiz6WgE9XZ7N+NzljfoUqYcfFYOyjWTQjJM?=
 =?us-ascii?Q?igsBlHjYi8WtFeUFo8S1qRz03wdqKMtVU6CYcz/PJjMHYNCxccaPkfTijc8m?=
 =?us-ascii?Q?WKMksEMtWN2/dJdeK2VxGg5IBh6xG+VCBDIYnkP6367392Nex45fjGXMUFg/?=
 =?us-ascii?Q?NDH2NnYvGvRnA2GVyB/GasafWkz2EiXw4ydnGhVI4pvuBFjnCvFrosBARH7n?=
 =?us-ascii?Q?/XyjZGrvCG1u62JfgshhPUSbAnR+NfD9bXOcB3lHJZlpHXDuU0/1lzn2C8C1?=
 =?us-ascii?Q?/dhDGj4XDnACcZu+7bQ1mZ1XmpiKR/sEy1EIfS7noFW+9bd+vZobPqn+vzKh?=
 =?us-ascii?Q?qn+CNorVhl80MFgSrnlxmV8+OhNZb7BrUHhNCpbxAxjp45g6kbsgKS7dXXPC?=
 =?us-ascii?Q?nMCGFF/36C0QZN82Wc1XMDOdHMgZfYjvxBWPgr9Vr1dtMtnVoV9OXin+mz79?=
 =?us-ascii?Q?4I+m2wQesfIqYJfBnN8//QDYzUJOCq0hE1H3ePpEGU/OmRRZaE+dHIQ6EqXY?=
 =?us-ascii?Q?mBNkAohpAnZh/da9zYjQann4z4okj8rV/S6FJGjHLTxAGQ6uzz9X1I0f9Vrd?=
 =?us-ascii?Q?wjhY3tZuGybqpSsPqVd9CvrndS78Pk9I5GniI7jkrhAe/CeWn+tAdpIkpG22?=
 =?us-ascii?Q?6mJJtWAnnmO3UImDl9on5odnyQD5angmHe48VIcJA8D4GjVWCMPzndOOrFKy?=
 =?us-ascii?Q?8nZDJ7GnMkTXWLCl0bkwx4M73QMrb8zsXoxloeFJbTNsIqhWKxzZMCUPweIi?=
 =?us-ascii?Q?GMB1mebLQ4kLsIu/X8T/H92KB3bS76Mb5eh0jfeS6pjWD33C2i6divTvenJH?=
 =?us-ascii?Q?rgCUMZGoeD5cUKpAlbYJygAaupNklk41VMtmghuthGGa8BwxRKd5ZzrfYYdq?=
 =?us-ascii?Q?HN/tZ1GshU8dgW5UNGB8PKNgzWCBpbcutplsVPhuDZmqdiPdWE6Bla26lb93?=
 =?us-ascii?Q?B6OVTvtgSUX5g2rzNdAj8Q3ks8yWzr8SESvqsKfujGUYTg3Dm7puPhkoPwcw?=
 =?us-ascii?Q?LMMZ5IrVZBTSFOqnPDEOguXkQJf6MwnyiUymJBrfpLFq374kbSDcPqu8Ujhg?=
 =?us-ascii?Q?8AZzgv6hHg3yhcroqAv7PzEXpo68s5970HbC5SBVp4a47REpqMAMw4TEdMir?=
 =?us-ascii?Q?X3j7E1rq5GsTyLNYtLz7P9WyJkTNqG44nEz6GxU5cMWNMDU1LXbAKcA6y0ja?=
 =?us-ascii?Q?7DGNnxAHb6JX8fT/wgxRPba5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y8VABAVd6BRcRp9h4wKcCNoO6USr/2boqsLmG632phnRZTLwqqtQTyYbp7Jy?=
 =?us-ascii?Q?zeFtTnJaExt9/DCtEL1D2v0xqLQaPHYEbEkD2EfXShPSP/Wvr/UROxMDSFCz?=
 =?us-ascii?Q?sbCComiZWACuAGjDUSNQRwioTHcDirzs12wz3/xhN7LtT6TDgwPcsUQY8UBR?=
 =?us-ascii?Q?MQiVli9Kk1WjQnxyrzIG+BIgx24k8u2V3NxDxbvmNXnvsqyL2PVeGyr+z1xv?=
 =?us-ascii?Q?NCAi65UTVJin1Uz3xao+0NQv57zAuqZ1ZYhsc9Co5Bcqj+URpYxxf3ZGk+iS?=
 =?us-ascii?Q?bhQP9dsTgAUNZkqdjqD7F0ibEXzmizeSQXDjSWhnjWzo4C/eH/bct6/Nghue?=
 =?us-ascii?Q?XBmDp79yAE4Z2lgxycp63MdkSkq1B5bvkr1qYZYOxbUBmL9W1JF00ifYr/2c?=
 =?us-ascii?Q?iP5Ognzn1XT07zc4EfDQJWD2owsIPJAqthlVQ1dFgMyyIdboJawUGi8xTB/B?=
 =?us-ascii?Q?iJHV1d7xXM1iNwgGoR0xYcRsY7US/IocJI6HUXPdFizjrh8lwmHKfDYMhaOF?=
 =?us-ascii?Q?sWH3G68qswg1PfJ3tYYX9k74o/ZQgO5CZ1MAzkkK8Dw4NSs+SNi9ps2oKg0U?=
 =?us-ascii?Q?o+q/Bz6fSzH/jqAlV0IEqrj1rsS/DS1I1qOobv/P8cntrGN3T4btLXdnb982?=
 =?us-ascii?Q?4OsCozm1XTtjAysq3QTzaQKAKV30XZffNMCmQQ6VhplHFMZU9bHOEwrRK+3/?=
 =?us-ascii?Q?AQdACOrUmPecOPBK4P8wiCycf8X+oYP4jH8nu/Gw3jC/CaH7kuQR1sZubX8j?=
 =?us-ascii?Q?qNz0iLDF//M3ihL9vgE9GHtjvz3tLAr7hkAkv0JtbG7G64N3NPM0Ui/feNrN?=
 =?us-ascii?Q?xhqK+Cpx30pOI25gIRlvp/RFQnb1m4j2mTQY2dFtizmQmQgekxaqmKtYVRq3?=
 =?us-ascii?Q?narFy5w+rU2s9pqHdNl50R0ACAhW0B3NnuZrojMHmeA4bK9waRjMS0qyCNof?=
 =?us-ascii?Q?FGNwJLSavrAV1HQk2rCOIB3R7vG88zuNSaQcItmZ8zoKadd0fvow+9fvLAtB?=
 =?us-ascii?Q?Tv37jSTS3D2BBxEK208dOPN0Qc+hb/UMSTedIcR4u9pEv6higmRbedo9AycQ?=
 =?us-ascii?Q?86ChAQYkYumqjRkX+g9xp1L9+KYp2e98gb6ALA1aDyeoYiMe791v9SyIn4xG?=
 =?us-ascii?Q?oGe8bPpBaezyoc3WBIMlL0HObE4I+CbIkINMlPN4kvZsgI+LLI5s4lDXBFvI?=
 =?us-ascii?Q?n8a6WTXFmzOVaEQFtmU+RFnpafSdxH0MZHzc1tnAqFImLzD/nNE6qLHd6C/7?=
 =?us-ascii?Q?FcTM5trDcNAAVkjGtdPTf0RWHLdC1MhP4flDD0ATbXNoxkYNRcQ5U3ze2n3G?=
 =?us-ascii?Q?d7xRN0CnZ+tO4X/RQUYd+vSbDzj6DurDQsAKSyaJmgnCafDOYQInEwOmiftH?=
 =?us-ascii?Q?N7UnzA/wCdEnKi1jeQSpriYbVo2zPGpw34/c074qImwsakLJYLY1nBQg2vsX?=
 =?us-ascii?Q?LjjZhiB0Ub/8tkN5FZCNa6rYNg3ONen+IgFR3pULf8ZSqIzwLPhEUPpd0BVo?=
 =?us-ascii?Q?juQ0DeS79vFtK8/sduBGNEhDUiT2CapnX1u2DYS0QAdXUxxDGT+JWPRnr1Kh?=
 =?us-ascii?Q?HiIEA7kRou+4poqU9ariKq/bToHKjCnKKRT/eM1wZ3itRsYrcAycQEYzL//x?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	68OXFogoGvajYrhiItwFMmfT8039fKHFqH7K2wwo76XGJKfwm9eQD/X0lEQQDKNkABjJMNfgi7kjZ2HGUrtXGhH/4isbaqLRnFAGKKVI9Seo68GK/3iW19+ehO4Hxm46UzSt31rpMxBI8NV4k8RzDXZ1WArZKDDAEIR39ue+/9wyqz+Ar5HKdRLvx8Da9E0HPB3kqi6EgzfD1+fZNyygeHbgjJW9cqhSV+y2eOrwlBufuG1jIroSFkdY5xIrftOr/hgyezZBWyGXMZN1rK0MeE1h287kb15ntbgfY/hGWKpuZbD80aN5uGTUZ/G/h2Yll1JK0roaFRWLldD1uB1mJvnDstCA7DcAc4bhC2C4RSGZPjKaDz2kUb+0DMn2heimwV2tSVsfxXrS25SIhSnZI/i5LBzk3EbzFLbGLu9xnVW/ZtKm6P8fIQF3vjlJ16BNuiQbRNtvgiF10bPTODzK1mp41o3PMT09YTWXcF3M2H51Kxiv7cdjTNHuZv+zn0bybT8z1V0nMAKdz4zDYra9ADjySYzBpBZlIbVE8Eby7LHcdSoXYvbCaPzKLKATykaFGa8niqwrhWJbEEWvp9fVIcN5/+zcw3XzXR1q88zI0fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da57651b-435d-4b8a-2827-08dd04d20c64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:30:35.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7ZfZWodwjF2P3io9RaITPAKizZHodwCr4p3tcodKXIRyKRjIY3BmKDzGpYWBsTuSSeYcQjudGYQVzes2hqwMqtoiLS5i4rRfuuFVtZZMUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140137
X-Proofpoint-ORIG-GUID: kgkcjWvq6caB7ZDjTEiU-MNG8wKw1T2a
X-Proofpoint-GUID: kgkcjWvq6caB7ZDjTEiU-MNG8wKw1T2a

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5de195060b2e251a835f622759550e6202167641)
---
 mm/mmap.c | 73 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a766b1c1af32..f8a2f15fc5a2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1716,7 +1716,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
@@ -1780,16 +1780,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
 
 		/* Can addr have changed??
 		 *
@@ -1800,6 +1794,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
 
+		/*
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
+		 */
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
 		addr = vma->vm_start;
 
 		/* If vm_flags changed after mmap_file(), we should try merge vma again
@@ -1818,7 +1820,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 		}
 
@@ -1831,20 +1833,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else
-			goto free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 out:
 	perf_event_mmap(vma);
@@ -1875,16 +1870,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-unmap_and_free_vma:
+unmap_and_free_file_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
@@ -2907,6 +2898,36 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
 
+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && (vm_flags & VM_SHARED)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
-- 
2.47.0


