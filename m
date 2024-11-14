Return-Path: <stable+bounces-93050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7ED9C91BE
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07524284010
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E45198A0E;
	Thu, 14 Nov 2024 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P/3Z2Fl+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FrEiSfZt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5713D51E
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609389; cv=fail; b=gOiyNDP1ZHxkTfGK8l9aMBs1+BrrSONSqGyCh2nRxkba3fVWBEpIZhC+SJuuNQzQ+G5JnrgBfQbRCZtKPTthIvgigKOg1LB3YYKKviMNVoozMZ+GDQXhEwuV4RCawGJhZnwc0goL8oHrJD50huW4jVMfsbFTASnN00IoPBupBNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609389; c=relaxed/simple;
	bh=86Ya8oR8kYEy115F3xTFN1UUWVUUzFd+YsnvUPZ5A7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dboR8+qhrHYbq663wyRtN9EkC/l8BfxcZ5DZ5Ws5ELPs/DOngfpW/SHH9ZnMbP0KX+hSZhzW7nK2/XE/bwRVeLKHhxNVdbuqe1xGdAuNZyk6Jj2/3pZLVdJRs6cLRH5mxOsFPxA8mSAZ4DjUP2b+s/pQSH/+sUODnNT19A8BXEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P/3Z2Fl+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FrEiSfZt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED9QUK018726;
	Thu, 14 Nov 2024 18:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V5doOH+fBv5gHmsc9QNMW4+5ETo28npA+7o4CKWBtdg=; b=
	P/3Z2Fl+qTVxZ/tgiBkN+IXMqwnH56Go946JfIMMpAkAjxz2kbQTNLkOrEM/zPKm
	ggpTCbVwGyLYjq6jKXq43Z/Vx3jlhJJ8QeEvsjucGS9JLOfy0h4NKEVFqzgqoH9p
	8C2WGpuYtbhlgr681DjzS41U/0oDw/o8LgzuS1XWPNC86z8lxKhKFKYpLji8QkBo
	mGXhyeno2n6I5pI6lvorrZWjRKH4M9D8Bfn8sxSIJwKIN8WCNePVOymrYeRD7SI2
	tOy+5L+uOyAW6fz50p5p6zSlnNAmSYE3Zz4wo1pEeQMj2b376tiso/E/7D2OCXeO
	F4SFelYfjjkn/2JhkNHrDQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc2161-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEIMojn025917;
	Thu, 14 Nov 2024 18:36:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b7m60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMyB8IuAsjddsza/A0zY/5+hbUKnBIRAwXY2wp6FY0er5TCFtkIbkGvTsbpEkq3mmch+EBHOSJqpNib6Sdb6KgaetB4lJ6j2n1wz/AiiZ7oxBA/0ExsGay75067V8IqHhUu+L93wQhVx97VdSrC7rb07R2L3x7Ta2WMRJNxZOkZdj9o7mFrEOUDjjv/PFKLMhgpPgBChFnWkqY99FUCXS4/neVlna2LNEnnpZDkq/7tf3UXXVXq6wjwws65BOCqSrbj7BPyiZ6ALSiFZOaHn5n7prx+GaQAJuzXrV7vNkb3L8jhjsvh/lCDiYHvTk6Dpy69VNEQxdBv9kh261+84yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5doOH+fBv5gHmsc9QNMW4+5ETo28npA+7o4CKWBtdg=;
 b=No10hiztACHFDYIi8KBTH53aVDpdKY2Q3HvCIgW1gU7eKl3WELTBshD8HjVJXJzapx4PuuH1HlZfGvDZqu5CQCU77wbs+3+ZrVBbtbZvALwG1WM2CqK7m00PPRtjuc2Sui4TcTIF/VR23f75MoPoGX82Q2eRcjZkVtm2k9sbKmFJJCgMVmk+a7UUd9URRp4YVJGmPUE8OUzS5286KVyFCoDEgMKDcdPxnhjA0AjlcRB8OdJaeq7UWWKug4rMXknpBgzImd6CSy5BF8+UOqsr6e7RCmxdiRkFfwd+6gm3J0khChdrDtcz4KKatqLhi1fkuDOx/PbiQa6GAHi7ah9emA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5doOH+fBv5gHmsc9QNMW4+5ETo28npA+7o4CKWBtdg=;
 b=FrEiSfZt47X2jusCX35mfhRMthqDvpXUBUdDaoRokNLOn5cidFcV2kwJ4bSg6r7tIfze7Cat+gel8d1AeuIkKOKmrKFSPRzMwS6fZmcD+LuWE29PfAFGfnzdllaVobUSdYRr3g6ophOv1gvnbjDJlTWuC/OZtJzWhIfFxl29jNU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:36:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:36:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.6.y] mm: refactor map_deny_write_exec()
Date: Thu, 14 Nov 2024 18:36:15 +0000
Message-ID: <20241114183615.849150-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111110-dubbed-hydration-c1be@gregkh>
References: <2024111110-dubbed-hydration-c1be@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0342.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0079fa10-a818-498b-d538-08dd04db3ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2rluK2B5w7v95lHbZeyUDZ5PwI+lz6decXWwhdUm9zQwX2pCK7+nQZrgW6su?=
 =?us-ascii?Q?IfxeUae0HfDygbBKry0Xcu80jQZHpwj3iMUMSuCW9MlN5RrIoZpDNd863VJx?=
 =?us-ascii?Q?N3BXsX6oGT7fHRrrC5rWtRJnkcirymFWMdOMJD5K9ChxSLB/3Xyi3p2Kx/4n?=
 =?us-ascii?Q?o4wue3ZK4aJBGiKFWDkLjX86L/nkT2jW9q6XFdnzq4M7UF7H6ClIgxFWeG3c?=
 =?us-ascii?Q?FHZ7VW+c+lKuJFRMjWHQC4KhLUIit8Xa+OjAurzeIsbzkwNgQ9IAVybZ8i9u?=
 =?us-ascii?Q?sifMG2ClbIr6MtpHLiYbvRktgojaUdTMZwXymtVarVJIRvwW53rYGsDKUMuY?=
 =?us-ascii?Q?H4SbUuNp2LaOA0pjZeJQSsPYYnBJSnrzM+c3au6AKL8f6oAvrj1FwO+OgtC/?=
 =?us-ascii?Q?8EGRARsVTPKBMJ5U1mDI3gtf4KPhFYz2HzzLamxZ/Sz0GhBDuaFwVL/AunIb?=
 =?us-ascii?Q?F22/0BMkhWvWByr05Y+ZFMc2LptLSZUevxTqYKiCZ1XFLMbRWOIfKijo0KnV?=
 =?us-ascii?Q?fkjuWBKNgt3r4ZopfZWix6FI5q94Jm032HrCuBbtl/EJvCMWd7YfF0xtbTj4?=
 =?us-ascii?Q?9OLNxGUT/d9Jg/LUlbV2IoKlMWZluZ5AfKZ7DNTtkU3taBBi6HTx7P2ZMncm?=
 =?us-ascii?Q?byGbsU+01WcPU5LBXOLAr+Ld6Fgv1tcmhqM4W+kNLOep4gQ30fO+gk10W8lc?=
 =?us-ascii?Q?Rt+W/tfM+KHOV19350CHMxTUBaXHQBAXKcOMiNxpT+oM30Xxge9pvam1Rk4V?=
 =?us-ascii?Q?3cfApbw55RRuGc6U3xK86nFx+sZQEPfdqVXa2WNAEVKSK+8uTWYUutCusdj+?=
 =?us-ascii?Q?aRCww8TyfUNxM+ZjVPDlqH8pfXKWJdzaAeECCOao8ox9SHnSgY1mCfmvwES1?=
 =?us-ascii?Q?zrWLw4O2g/3WRpvXDExl+dRjrNQ66kMRe1nvjPKzEn3JORC6PqRmTHzKHcEV?=
 =?us-ascii?Q?HQRL0Bsz1mYuU5WcikQlRQyypruoZG7hsp2Fie9Iz3PQFw3hKVPI/5OhpYPp?=
 =?us-ascii?Q?+A5PL8vQiWFlh6XK3HqcMetLpfED5k4n+9Q4Eqb82DO2UuYqtgbVCEo8CcCW?=
 =?us-ascii?Q?AGggpRsLWrZiN2X6vDpp2lUhebcYu5cCztxam7ndifhmk5RQjsueuxTddXut?=
 =?us-ascii?Q?sW9+tbMduzQrkOqpUhzYEDWBAzEUPv2NbLDbvysStbhur48rXwRly/SfGPGv?=
 =?us-ascii?Q?KyIdxVtzV9ZrAGHwW2w0IFz3FL7ugTSQZcwzqIdBBTzCvhB7AkY+W7yDYJwG?=
 =?us-ascii?Q?C13ZAM7mFpCC9bADD5ySD0mjYMVO8hKnRKsaIa4me0ZNeFYsEUsa9D1dzDhp?=
 =?us-ascii?Q?qsYJz6/T3svo8EyR8A5HOJ94?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vldCH54hdrCTHCkb41JhcAlzue/aaX2ULd5Tryw/ITsTTqaoW16SqLUMrWMl?=
 =?us-ascii?Q?cdWWdsWqKLPZn0YtbVSe+dvmbA8UYmeNDTumLl+oguARTazqffujxgW7kHab?=
 =?us-ascii?Q?CKHsKNYP9PIiH+k+/vVRUN/KJKlOLwbl6ke0Rbdk3Vo2Th+xyeVbGwVH9VOa?=
 =?us-ascii?Q?xPBIortrE9J84QhPQFRf5tbNaOfDJvjdCfWoq+6BXrJhrvMDVJQnyXvODfRY?=
 =?us-ascii?Q?9Fe7OFeAnxLUFxW31cSlKGiOunMdONrDPrBmvnV0V9dSfHPFWAbLG+88Mcji?=
 =?us-ascii?Q?3Va+PBoQtKD+JK6N3BfXcwByaxkZtza2Pya76sCPczIGO49tVYiyaxnHrWR8?=
 =?us-ascii?Q?iSRn9FSdFvAArP4SVmApUkFUBTYKCvyc+bNVOaaLgUoiToLQCYBnvli101eh?=
 =?us-ascii?Q?NT3Ew3VhCtLykqYhoJc6kvWbB5jWopi3/9HF4i8xpYesmXhg7HcfHcvpQUtD?=
 =?us-ascii?Q?mIXktGKyCAUtxmEHUcITgYoem9jBA1d/8M3xlu26FpTkmWiba4pQVQUJSbAi?=
 =?us-ascii?Q?H6aPlgIvq9SANm1feHeMKvgfl9fWaKRsKWap4O9IwQqgE8I1pE4XBDOW27fP?=
 =?us-ascii?Q?Tlj9yR4ReQoKpEpOEQXHMNna4gw48KmAuVYqrsfz4eJMcThAHF8dKcrmgi9W?=
 =?us-ascii?Q?i9y6IboQFWjJEusXOQj+HrxfplBCs+OU+q5FKmOOsPAqB8jKqvt6HucyxDS/?=
 =?us-ascii?Q?5nIVHEd0YSvOVSRM7a9G5rJuvn7lSt+fqK2TOqI2BXi1HKW79fBcPSEyOlC5?=
 =?us-ascii?Q?REDpAk3CU6Mov+3MRnd71X6fLgnDrA7SUcy8znl/xgf56Lmh4PpeEGqZtgiw?=
 =?us-ascii?Q?9+9/oigA7nDyIHWCZ6O0F26cG2Jt4WHYDOZAG41xyclj0pEX5l18Rmur4hjJ?=
 =?us-ascii?Q?JnU7V0w/RX7RW1rIRHpqTmcA8WoMRcd6ZzOMtrg/Xw6CSSQegCSlRIQ/gW7h?=
 =?us-ascii?Q?3BkAUc+Lim1A0/FdWw8Xw+XLImvd9lvMKt5kbobnFUIFBLf4V28YK3ipd+cU?=
 =?us-ascii?Q?62eK889k9ZWwW9jXWYDr3b57H8woaa//D8hY4MJnEjrXLD8TLlCIrwZenxOp?=
 =?us-ascii?Q?c/OANg2ErqdHkLdeBTfe89qY/R8X6Tzp59B2DCNphLoDLZfKD+aoLjAyS/Hz?=
 =?us-ascii?Q?JHtpvr6gw2mB5/uNwvnrI2WF+yOm7osR9gSsaRI5bZLI/ouK75PK6KiThjF2?=
 =?us-ascii?Q?a/Bqz+iJDN07ERfX2OsMqrjqAyw9+IIBKii1RiOetVyfhcvnaa0HEkd2IjhP?=
 =?us-ascii?Q?0qmj4/yLFoOVEzpcxlsSBOKkqreMiXEjPCVvWEByJSY32nFjqbtGlLJzMAzq?=
 =?us-ascii?Q?dosS6uIyQBBkEOXofqUutA8YeWu6AjmR5hVVzAlGxXeGEPHiq5UMJ5hA0bL4?=
 =?us-ascii?Q?7bi1fPAv3RqMeCP6uFtUFA1Ok+6XrpDVE0yf/9E/fA1+8zSTTXIUhZt11tBB?=
 =?us-ascii?Q?9OioxeN4cIBrw61tpm5sTxqVtWiosatPh8iQT8UcmCCIAYSe1q0qVSOyUSH0?=
 =?us-ascii?Q?hcRosOCLDAt7YrbWrwX4h78y5PrN8jLYX6dw6YV6NsqMPzaHbQAc27VPurNb?=
 =?us-ascii?Q?yeUKDjZZ+c5FtkiN6+OjD6DXKG0FqRUx95vALWefmwRiY707QUeL95qOgTcm?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TrKoBhTwmqi5h267TUuA6XcgGi1AsYjtgdmSDNN7+RytPHYxI1SfFFvkrpM6s3Cx/hb/eorRUb+ejk6PM5+4qyay8C4GnOUvd8LovojzMtd3EiBdWjy/Q3p4f9znUylajIdbgUPl3ht+/EbOrqPywjf6Q7l16NS0shccXxaPq2W0+r94bUpNYGCd3FIQn6faGEGidvlvNiuRosfunXio5zldz9qiggxRwIip+TuJZtdgWs+3Xsb4XgYbw5TSyZcV522iTSpDA40xZjlnArMj6Ez6Rgi5/iJWHlVn1f/reXlNegw/NBLhraG0D23y1hTesAAfXhhguCX8uoc6qpCtRwe58s6GHhBdV/YVSO1oNJi+bpubAMHWwUtuubZyF7E9n2uQ93AZeSc+qTjmKzKRqo54KP32QGh04e6iNP38IUOwuuRo8gXb3i5VT39JUMIk6Qj5bT15jXADb4mIOS2XPu/bq3NRWPAN4br4NvsJU3a6sLhz0Rk3IKw0o/7/X39WeJEm1mdo7wFiXpsfsQ3aw0IYPfyJc2XVhd0r/VYOwsa+woE/x09NOFwJAAtpL6qBq/ND8YK0TNoCNiM3eQo3Iy6OzjjKqCJTSAXSp3wpoh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0079fa10-a818-498b-d538-08dd04db3ac4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:36:18.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4nyt2TyZiGKj8CeA1zBHfZHJDbH8etcebv0RmLvoaoORWCZgC9sXl+YvWfM6TL/vIVXeGhV24wLSJ8RPQDI0mboi3Oeh0VQ1Jw/3CsbAwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=902 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140146
X-Proofpoint-GUID: 5u7BhdteWs1RSk2MKPwhWYj2ZCIibIZz
X-Proofpoint-ORIG-GUID: 5u7BhdteWs1RSk2MKPwhWYj2ZCIibIZz

Refactor the map_deny_write_exec() to not unnecessarily require a VMA
parameter but rather to accept VMA flags parameters, which allows us to use
this function early in mmap_region() in a subsequent commit.

While we're here, we refactor the function to be more readable and add some
additional documentation.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mman.h | 21 ++++++++++++++++++---
 mm/mmap.c            |  2 +-
 mm/mprotect.c        |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index db4741007bef..651705c2bf47 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -187,16 +187,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
  *
  *	d)	mmap(PROT_READ | PROT_EXEC)
  *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ *
+ * This is only applicable if the user has set the Memory-Deny-Write-Execute
+ * (MDWE) protection mask for the current process.
+ *
+ * @old specifies the VMA flags the VMA originally possessed, and @new the ones
+ * we propose to set.
+ *
+ * Return: false if proposed change is OK, true if not ok and should be denied.
  */
-static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
+	/* If MDWE is disabled, we have nothing to deny. */
 	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
 		return false;
 
-	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we do not accept newly writably executable VMAs... */
+	if (new & VM_WRITE)
 		return true;
 
-	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+	/* ...nor previously non-executable VMAs becoming executable. */
+	if (!(old & VM_EXEC))
 		return true;
 
 	return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index 9fefd13640d1..d71ac65563b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2826,7 +2826,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
-	if (map_deny_write_exec(vma, vma->vm_flags)) {
+	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
 		error = -EACCES;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..7e870a8c9402 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -791,7 +791,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}
 
-		if (map_deny_write_exec(vma, newflags)) {
+		if (map_deny_write_exec(vma->vm_flags, newflags)) {
 			error = -EACCES;
 			break;
 		}
-- 
2.47.0


