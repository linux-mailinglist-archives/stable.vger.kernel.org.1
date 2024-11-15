Return-Path: <stable+bounces-93536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E604D9CDE7C
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763F41F21196
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAE1B6CF1;
	Fri, 15 Nov 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CsBQWA3M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CYAJPZlE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E671BCA11;
	Fri, 15 Nov 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674554; cv=fail; b=axrlaMwom4YiMGYiXddaIIDLuxYKlvBQrhMI1g2YYSp7HmFk8V2EuIacxH/gAdei1ebi59f0A88zJpLNCHaq7va1FTnnCbNuouOYYAG44AKNj2pbbCkut0lf2OwzvRYQbreJ8MD8Tb8jPGDH/ogYWs9Sj0vK4p5LrEtn9tRgjG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674554; c=relaxed/simple;
	bh=1OkhP7Ux47jb+hySixOUM9xE0HSsT87vSJwugCA4j6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSGEGZqhOrAcFCJbVhzUgXsmyKuE/I31bQqcJNcCtrSpDwno4WhjyJ4wff0p5I6kds/Uhn/Ub7oPwnrrOkRXTQYw1iabRMAu5B2VLpDItVQBd127eZzgFnU/anJLYqgSA1u6KCONbBtwCX3IUnnMhBgdH2p9KDEdiKcVEdl1Dzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CsBQWA3M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CYAJPZlE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAGwPc010628;
	Fri, 15 Nov 2024 12:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1nyxFrUZ0YkzFxmLhfWFRII65PTLdN3cwHIqE3lAYMg=; b=
	CsBQWA3Ma7UarW6iwsP5Jv/ZBQZN2ZxlxJCsMixNhM/mjz3bpikeRlYkcSLAjtok
	HOlMBCxFwvqYnih0ePBOXfdKaWjz2LXzpISCuwYfJWXXPvCAxNl7lIHT8jzW2GZQ
	rjpoy5+RQNWWbWuOfdNw3lC7uO1oWQlJ+lnXgrpweN/ler5wxOcy1RYFAS1pErBA
	01j+i37CXLY7YpJ8fmcOA+H0/SBvF01sRdBlHm1a3tztVK1QfKyRmET7+M5hPxhk
	7hTQFdkhM2mmSDr9sVFNIos5bBLJq+En5W6w7ITgC+F19j4bQEQ0z0tofcIHxobO
	r5JdN9/kcGmJe0C+uT9wjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwubhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCYhtt001151;
	Fri, 15 Nov 2024 12:42:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ch7gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4vqstwCrrW15bIiuIb4vZbiIdInkknm5MV3R6P2wruUqB+N/7c1X+Und9EAphNlmKXPNoRL55xvN25w4rKhuvmpwvIRTpgUA546wnfe44OIEcHuL9Rkhnf9kmh5vgA60817tlPOL9XeUSqjOXsEjxAE9KQ9gzAE+u93o7zvaiQy1x0GICyk52cDkn9Xm6YiwK+UZ+AbF7AF0qC9oyzf6Vv4sdjp32zLz62D6VSZFTWfxJiSRrb4c+A3SadgfLyk8cqsK1YLcQrrkpzzgQeZ0Jpl2MD62wDlmERgtf2qx3hIDBV9pi/aiAAgKh0Bsuk/wa0ArY9CYIpyTz7fJOTiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nyxFrUZ0YkzFxmLhfWFRII65PTLdN3cwHIqE3lAYMg=;
 b=StsOVzgmJix9XaUtGHmsaW6Nv9TWDr4W3s9u4lzh2fQEYvucDViKTIwhENWlOVU9pYEGt+gkQwehg1P4dDLeXHVD6grumIpcduU8ROAvKoeds/sdTpmpX4A7fJERUPQRLEHaksiUf7Wq0Pcq+l8o9BapzZCjfq/CF05LESpp+BWkUtQJAFvr4nElVMLHNAWtRkBY2Fg9zwyJygKzeQCy21Ml4WOewZpJvngs6rk3hwUMNt77nwoX7UeYP4Lt8JblbBgsxYsz/TdyurCa4hvWK/iIY5KMYaJLMzBraW4gqW+6x+UiqfgDpDbe9jNJeA7mHM2oQnQ/KvA/sKntRgq4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nyxFrUZ0YkzFxmLhfWFRII65PTLdN3cwHIqE3lAYMg=;
 b=CYAJPZlEAltJSdpajx9CZsX9f0PIY0ff6pv3paQu2YQ7yq0e1gJT19fMr+gMzGC+x2mJNpRN7j5yNBerRPjwkWYUW7V3/CclTKK2cBTnpVidMDbYuMS4Ya89880wEfJwgJHfjulETFzuzyHPPtAX2zlh818UCUNGAdVHg55Jl/0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:42:09 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:42:09 +0000
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
Subject: [PATCH 6.6.y 2/5] mm: unconditionally close VMAs on error
Date: Fri, 15 Nov 2024 12:41:55 +0000
Message-ID: <cbd9c0b17ccd9898d18f8d6147e0dc6441c63217.1731672733.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 22084be9-5b69-4cef-8443-08dd0572eb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lRrUcOodxZv+PzWNz8gFJZ4SM+sv+P1fws34dOBC1Hq5EiRIvp90p+lmPr3g?=
 =?us-ascii?Q?q5oPMJSL3N6eoxEsYNN2sG2TUTWbIsGgKDrm2Tr1xvBEw/QlLHswuY0kVaMk?=
 =?us-ascii?Q?esFX2QHT83X4G+xkP9MWTtXPfMYG9bN0Tshubt/iV5kJUfECNZloojt6Duui?=
 =?us-ascii?Q?DnG/rToduMcx9FV563xo/OrjiLIOIOaXvykkd6j+9YlvW+Tur5LqzxbxBWQp?=
 =?us-ascii?Q?BeIB9cEGHd80yeqvKse0ssAdctzAU+FyyAhG5DLQ0aaGEUr2NQojF5c1g4VR?=
 =?us-ascii?Q?GT6Sssk0e7jTrHGA4e1mDJeMsKoOxVHMiwhiR3AvwHpeI2nq3JmfyvbdyPbV?=
 =?us-ascii?Q?2y3GrSTZTfM46Ig7dF06Ja5XdrMYdefxkDR9WdBEhliRlMmFEk4/fXLWWdl+?=
 =?us-ascii?Q?DhYLOSaXeJ5MesputgsX0JUVwMiFHzEEGaegZKYVa3hHhtUUiQEFf4c/U9Pj?=
 =?us-ascii?Q?vurDCmTLcANruOD0o57AbotdU24AIJeFNBr5NK6aGJbkggCz8t4gMs12CJh1?=
 =?us-ascii?Q?z+MUZFieyqYqYCyy4Zer1V+CdaKwNHtaiXp0fF/z3+rX//vaRb4gMNxfN63E?=
 =?us-ascii?Q?GsLey3KP7LdYUefxTew80CGX5Mj5JdBEHbCAa+qbyemkL2PC9R9EUf2Z4H49?=
 =?us-ascii?Q?3XxRjsMF6rLxVAuDVLEJ2PSlsa47CGFiACVbTD5ZqP7M++885rCM8vDQkEQR?=
 =?us-ascii?Q?LgW00bxrK9AYud46Kp7Aagkpw4kaWyDQK3wBaa/Wzlc7lhbCIdW20edGdhqj?=
 =?us-ascii?Q?hjtLgqcuDkE5INZxIoKIq699RrbbVPul5q9hOgk7Zyjx/hzoTGTw7BFAshNW?=
 =?us-ascii?Q?qhcl2iMv8Cgmq6E/H/vFCsuo0hyweW3tyUNtXkcS//UighlONS31I7GL8jUW?=
 =?us-ascii?Q?M5Is92lZMhmDLa6zoPSVHTyJlOpZse55DwKBhF6SSMxCiJYkHBJHDvIdhg6H?=
 =?us-ascii?Q?0P/0Mwdi7IWPigdnWowAdKJ5Kw498thK17IWgx/bgEMB4HyTAqXIymLs6Yak?=
 =?us-ascii?Q?6DfzH7tc3ZmRjFSQHFkPUfYdA0I8PTGsN2QY6kWJ2NuR/HL5flgcW8KXjSOp?=
 =?us-ascii?Q?u7HGBHHnKbR1ITN/us5PnymKeOrEyFVoPisGDDFI18FbhmJ1dFJfUk9Mzl/X?=
 =?us-ascii?Q?W5DEGmHiBV6QTZd7sSgV0hfufL5gS3NYzRKFc5+z99VFQ+O4DthwO4sY4W6k?=
 =?us-ascii?Q?+KDnrORAnGTsn4tqVJ2V3BeAdw8czX62Vaja+A4PWNoOXN9AM91bvKCGx4K9?=
 =?us-ascii?Q?WwBUJn203udwgzpw2vRspHQTyoLF6C+Vmh4SuuhfXiRxl4X4Lb2mnRxZHXRS?=
 =?us-ascii?Q?HpsIkDPhR3N/cJuvtgdcusZN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YaEfKXswjD2RGEk3gCnNcDzt4vOKXMY3k1BsbdmJklY1neAW3qQnydfmx4iY?=
 =?us-ascii?Q?OkfF16ZJbtJ8/4mnQriRl28WnHCfrvWiAMDUgcXzUFIwNGbeFIPqM+vywqYi?=
 =?us-ascii?Q?mhYhNIPsk/fmGYbsLnSaQBTMIa48mC2BOgbxCESW/++4lLu4iGk4fyEfyoN2?=
 =?us-ascii?Q?YjPucfE8WrD7E6O9DyBUJSW3L1hBBzG1MsLsCSlqxdvD2eqX2q4n98Bwltfn?=
 =?us-ascii?Q?Z/q+dDLE+mm8SHsgCFLfRgwR3TW6wnjHAIRIXdz9ZjQL17bVHOYHwdTQsKOT?=
 =?us-ascii?Q?f8ZpmeCMhnO+YEM3CNw7gB2wF7jyFRLfvZKQyHSHOnsMeR4AuC6akr4er1qs?=
 =?us-ascii?Q?uqLxEy8H0pNeuu3wkS6PD4+dE5jOf52DYLB9gZwiAQVj4o5Rc26r4l9ek03f?=
 =?us-ascii?Q?O3VNFGz+rwjpw1wTPweV55L0Q+1NjlrgRYQX2u54R+B9QssCmHokDq0BF3Sv?=
 =?us-ascii?Q?zN3sfSe9yqlcDw33NSAvl8SEkD/s1aGZ22yhcDs1LHaBafv3bHDKS4x7pb4M?=
 =?us-ascii?Q?LSYI65Jg512pjGUgIyInmccu3tIlwly0CJxOzDDCb/W/LYzItfrdOVJqE7hr?=
 =?us-ascii?Q?M3tdx8mLc4ROVOHX8pp7ZWWN8DT52rKjMYr+jypSyKmR4u6LDAM8/zTXUrm5?=
 =?us-ascii?Q?98J/H6pevcPeoRW8aTaOiVVOJmTB1d+nUWbEzDOeuQCF5XmpnDcCz9MpLvjb?=
 =?us-ascii?Q?6ByrLH2P/LPXseQE1CnAfzBFnLN8Ym9gjoc9dd7z65NEm7t8FydT4MLBScLL?=
 =?us-ascii?Q?sdnRoeML5XV0WRiTPGYnaZKJ18vdaPSq+Tushhcy9BM3+JcGftsyKofq/4PG?=
 =?us-ascii?Q?3tkMRj7P6SS9MkPW4jmhUjGg1IJ2AfNz6PI6ZF3NCwt5CVNEKIE62eh1sxEa?=
 =?us-ascii?Q?+SSk4hE80eJLJs42r8/7hEo04TIYuF2NjGouhb/spyac/zdxlLGQqVF5OrxV?=
 =?us-ascii?Q?g1XI5jm90hLKWKY4BKWAQQVf/cAX1NmrRKfOotcpwp5AdYl0L33aYt1ksuu9?=
 =?us-ascii?Q?XUl9B3Oi6exeyhGnYt3MIcvgyqvjaevo+CslN8z0ELqDpUnRyXRG6aHU1iVN?=
 =?us-ascii?Q?5zYCHgKSe4SqngMzTtROVSimYzEXtviOq8sHKRccV1mCgDwP51RTTIgXbnSn?=
 =?us-ascii?Q?HAHEmX0A0XpR433XFLyTlJQGEuGNC9SqWlFeNT9YnlZ17jY/7a1nu0XO7qMh?=
 =?us-ascii?Q?NVTdrWl7gax38aAODNqSGlF9wvgjZemwpqxqo24Er9IgEDnsuHZN+7j0yfro?=
 =?us-ascii?Q?R1dxQC079Oe24MkIedK3V+QEv4sl+Iv9Fo8TY4KWP7SipML8SeVxeUqTEZgk?=
 =?us-ascii?Q?SjYRAWkpKH6EmdTnPvHxFo08SQZT1RRavnRqPyqNG/Gic9k77D7+AYsinKki?=
 =?us-ascii?Q?/AWylN4pDa5k8aDFIDmiYL5OX8UmT7g+R9Y8q4Znvi/ftCBiFcmYiyoewZhR?=
 =?us-ascii?Q?JMZTY/+0pe2H+EjV3D5H6ag6GyDE2hF+e3Tx78Fz0O5Jzz/gXmMnbbhnZPZY?=
 =?us-ascii?Q?nT8ykgAnbik4/HwKw9+tmB2L7ZIG2cR+L2RebSekLc0gs6BEH98EcMzp2bEf?=
 =?us-ascii?Q?OiDcIbZmkL1MJd8AQyhVIYLdzOCk/5jDOP58Dnx8IyqCrL9uXeFTTol4OivH?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T7+3a6cmWOKNH57/k0HH+UQtJYCjwtLmuxPPdCJHAS4eznAkFJIoVQ9tNbpjmLWA6VfSjBrFxpEHlGJPJrnPaUC8y7oDRtLexHhlvlM3Kcj4lAgOyoW+3jXKWv8od9/DfjImdTLfd5uoNj8zkA1IkilfUTALD8F/o/gis8QC60WQx05jAZLelHsXuf0umQeuAy13JQQjyVE8HycMQABybHtsuSnpdUTNvQquMEPlL+dgcrMOLiICgfpRPu9z2pLwMLlqXwbYM2XSCNXUJgUOTQC6dbzIt2C5+65rnauQXaXrjTJW+IqOa95NujcQ9/APZxaitn6kqm/R0JHkNWxy/mR+FdrkP14chy96w+4CmiBEWxcyd2hUiTpEl6FRDI8kd4DZLwZAWO8GEdgi0BYEKwfb39NIOdODiyyl4lnFY5afXWXvuSOwCIAhLwJ2VGdeTBHdWLHP/RtJddqS5as9DPn1JBhZOIQNBeXX67Ksk/QP3VdVoRgIuydVWte7Nsl2S+J8gDHGNeR+SGv6Uc64fFIWyHD72oC5muAVSYSkGN/x7ciRpn2kNUlgGQmvAIQPYVIc8X7rgHUBWBpwIOty9rheX22aJywSoRxJ+Ix6j5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22084be9-5b69-4cef-8443-08dd0572eb80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:42:09.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mLh82sip7T2QZQa6mVW7UtcokBSdJJnLgmpygxQSEAO7kZN3qE2AZ54S4s8zO6PnCn6bMRKwviYzzJCuID6OElagN6T2DKovlyTLRQ1qaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150108
X-Proofpoint-GUID: W4wR622cEeIvVS-WNAbRnXMvdlzSsIeD
X-Proofpoint-ORIG-GUID: W4wR622cEeIvVS-WNAbRnXMvdlzSsIeD

[ Upstream commit 4080ef1579b2413435413988d14ac8c68e4d42c8 ]

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 mm/mmap.c     |  9 +++------
 mm/nommu.c    |  3 +--
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index d52d6b57dafb..36c6693f4ebf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -110,6 +110,24 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+static inline void vma_close(struct vm_area_struct *vma)
+{
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &vma_dummy_vm_ops;
+	}
+}
+
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 						int nr_throttled);
 static inline void acct_reclaim_writeback(struct folio *folio)
diff --git a/mm/mmap.c b/mm/mmap.c
index 8a055bae6bdb..9fefd13640d1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -137,8 +137,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
 static void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -2899,8 +2898,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (file && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 
 	if (file || vma->vm_file) {
 unmap_and_free_vma:
@@ -3392,8 +3390,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);
 
 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/nommu.c b/mm/nommu.c
index e976c62264c9..8bc339050e6d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -600,8 +600,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
-- 
2.47.0


