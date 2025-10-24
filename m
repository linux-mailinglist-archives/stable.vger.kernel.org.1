Return-Path: <stable+bounces-189234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23751C0672D
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40AF1C00E2B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99185313539;
	Fri, 24 Oct 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N56GN+H3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RwBNaUYp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826B2D7818;
	Fri, 24 Oct 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311958; cv=fail; b=k6acDXer4WvneEtW17HXWkVMmKBjn/WJnAFwIluj0LUhuNpwcnmuedz6JGzwQvsZyhzu9ozEIrTjAI9YNvfVyUtuDHkDo9Gy7PS4N1NMT3QpHvjKZf1QaDjL87s/gW1AXEKRdUV9f9IO9bcXs8wBccigvfDddBMb56tIRUp3O/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311958; c=relaxed/simple;
	bh=oXaTvwpwfXhb4HklnHUT9mO+eTDUxphmSdvZYYdIyQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kQ46qgHI6rBwYFp5ot+3opv8tZifhfEGP45pGOj9rb0hH/XeeEKXqZ/OFsicqEbQA5TOSAqt83GdDyjPIDqrjiGplgXs99wEqAmkYJr7gyNXtMEEjE7qbDvno8Bd+8zbo4mI2RocSkFg+9e/8UjdfpFWZwISPYlfz34Gu5oXkWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N56GN+H3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RwBNaUYp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3Nq8Q014067;
	Fri, 24 Oct 2025 13:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BfSMN5Jn2trEATZ9Wn
	ZlPpK1/zYZOsN6VTUKdxD/uaE=; b=N56GN+H3rr0xMFviiU8wm03N64LKMLywxf
	pGcvWAsnqDWM/OVeSABMCmOohMq8Apn9GfzvZX7hTARTnAL14PbrXCa9UMCUPPmQ
	DtNClPOIX68SY3LXrlY8e7WmPkxOg9+Rp9mrkQ7P/nN+hxdSME3h/KFE/fy+MkqP
	jGhXLMmL2QNyKc79cRkrBZPuPPTjGDKQK6XPkZxLtCAi/ro6/D8uvipYkIXg/Tk5
	NuMWSZ4g+YQ4ivYljdRElVzWOZfAlnfwGPQwslMB9v7iXQ+W/bvpwCqcTTgLq0ip
	NaCNDKJJTKbjS7XIgJv90dqyOX84UO1DoI2jb+FF+bW6FdvxfsTA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xstymy23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 13:18:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OC8ECP006307;
	Fri, 24 Oct 2025 13:18:37 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwkacypn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 13:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyuQKCd6W73zASJ0qypZYlrgyiS5obgHZyK/iWZjb9292vqdSOmA6r/S1m7vqgYPeChZZpHkJvIUToOOeC/UFZibeS2lLntmDQXYkgsjc113JQ33ALgvJ3stg/pans+jkshrtwPr4QIMnaYTLqoPRMYA7YxHjwsEesd0B77ZnY4+ov4wF9g/gug313UqAJQyoD/35smPipHZMw5GbtsjvlpSaoc+PaCUpWit5Q+y9Fq67st2Rq/Ozpf7ZJtN9iNKVIG58dkdDApqnE64r1Ta+kotBi/439CtK2wIPLdUB7dYHWVbjO+bscmTVZoX4a1fNBcdzEIxop9JXoUK37esWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfSMN5Jn2trEATZ9WnZlPpK1/zYZOsN6VTUKdxD/uaE=;
 b=IwsvDHLmKD87GqDPupXKbBbV4FQzx0lgM3a2XhnbEK1jj8XkNZERS34PgUfQ9sfOQlyhFKob6qcl5buxi3pGFFH+lZIlWlaUVtuRN9lGMZX3ZVXYWxOKWPoaHdCNH2DGF7pxDG9AkAoUNTApkO41IEz9S2vQQ9qPeVoj5t5vpiwnQKYhguSPFfa8Ct2+KqYzK5oSaBfaaTSXZ/j65y4Zb2Zibc/z1CIQ0HS1GyeWpIWHEtBlKb6nYyldOHm5Vr8Yoa0AYu4yr4Rj7stFy05tBVk6zYonDzBAdyOEq5TS2rw8UhriUees38wval17rETM3BIuLEYUxfg7hXotwXoFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfSMN5Jn2trEATZ9WnZlPpK1/zYZOsN6VTUKdxD/uaE=;
 b=RwBNaUYpA+m8xVt37mJx1ENulom1m9MYynDEp3jFwnDWYIjKKpU5KjUzpJRhm+MFfMaGrrbfgs+Za/GKXyMFvQ9TyPDFG50HE2vZQj4HMcZmREW1riOyMG+Uq0Ysj2vM6YQBJXcfVLE7GWGcsatXP/bFkRiLGMM3mW2cKCznK4w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB7498.namprd10.prod.outlook.com (2603:10b6:610:18e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:18:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:18:30 +0000
Date: Fri, 24 Oct 2025 14:18:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
        Chris Li <chrisl@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        YoungJun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm, swap: misc cleanup and bugfix
Message-ID: <178e2579-0208-4d40-8ab2-31392aa3f920@lucifer.local>
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
X-ClientProxiedBy: LO4P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fe730e-47b0-4924-aa50-08de12ffd308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQ6W/iEnXV5nZfG7tj3LDEHHcEA8lZbJKURMyqSrQ9Efctb+eI+xoUTPSgjA?=
 =?us-ascii?Q?k1pf2hbsXjPUcOtiVc35ucSzujEWN1tPE6Qt0zyADt2QRl1G9UUhuS3HwdeC?=
 =?us-ascii?Q?EOwBwBgqhPTnsH67TyDa4Q45f0GAvjUg8WN4CPKNSkdBBZq/LZUpicXsrGVS?=
 =?us-ascii?Q?s/JGeNr048U2LFjuxfQpZyUqr/FE238J949NkQ/uHdKfrGo/esXFSEf2FlPY?=
 =?us-ascii?Q?3t00P+3UaIPKIwa3v3eR/X9Caq/RB1JRXYk7cTivzjvsqT4nzpyzXJb4Y3Aj?=
 =?us-ascii?Q?b1a2x4qggWFpHjIYufE3rmetvgmh0K2AZ2UD4fT+63fMGBHf/ErGEFG9IeAc?=
 =?us-ascii?Q?yb/ss1o08ijB+qem6aSj0NR+FFf3wnaBABoWZFd7NfDGbak4SRE5FHmqIIRY?=
 =?us-ascii?Q?+mJpUtHTM9XaOJuL0L/GBbl39WQs/PldHuZQcPYqRPzj5qsIdqDFSXrtUuw3?=
 =?us-ascii?Q?ZO78xHYp236MJ/A5eYxGEENyHhXW7LHhc++JKnhzloO4yOHiNl9o9Xj7KSe1?=
 =?us-ascii?Q?xFtKMjzfr/NNWWOuXw1ejCxFHSL6PXWDm348skF9mbNIYffbQmIHkLPOiLKI?=
 =?us-ascii?Q?wTy8aBZWd6FWuNSGE0o40l8S76uSOaZ0jUdXIq839VY7T9+MDZNqOB27jiEJ?=
 =?us-ascii?Q?z50+ylA1XWmgXv4xvxhbk9fxjfPFS/jsr4FWITAPzBCs9lSyfGl+qDaMloV2?=
 =?us-ascii?Q?pDVF+EejEz0ffiR+1j2kNzzCL7q47H6XLGh+er3+ykEMX+Fzc9gOO49EKjYb?=
 =?us-ascii?Q?XEq2aYDMf4TInZldgLavZlMfZyOO8wyUEMqv3IlKKLdmlIMoFi6/2BYbX94Z?=
 =?us-ascii?Q?u7RwD7bjO3gydKRqVcwjORDEGvgnez61YrqbS1O9HF57FdnqqUW2EasBsx+E?=
 =?us-ascii?Q?3wuk1bVt5uc6TAvokhq3jb0dj+wOHS/4upf0FV8F3XpQs2BjflYtbd0KboGv?=
 =?us-ascii?Q?I2suj3CeG8oBccIs7IqkdF5Y2BF8+hrrdNaXN7Ua1s2jsnhe3jYreJzQhF89?=
 =?us-ascii?Q?32qWixChjmHQSapFoBt0x5IMMF6QX04y/N/NzdepdpWt6wm4gAm9rOV4GJRU?=
 =?us-ascii?Q?5e+Qbkh2KZ1Lhh1mlFnHhBqXYP/obrKOWzFFw77MVMUpoB/VArs6c5nShNZo?=
 =?us-ascii?Q?p+PK2hOXEwryLgaSHZTaiF6YBtESa4Wijpm9Rn3n6oB+HRvgNZ7k+0ERD00S?=
 =?us-ascii?Q?us1166gcH5tyLN/Ne/WLT4jSAfHeH93/p/FT+8M287XBehPG63X8ujOkUI0n?=
 =?us-ascii?Q?ZnGJZ71NOF3mmd3JO0zb7xAqvfmb0yfC1KcZ+Ebg30uoatUZGEqJFTip4Z1Q?=
 =?us-ascii?Q?7x8r7qwrqSsZVpvqfDZQoH3qXzMCGty2rK2IXsJCfrqJxTS3osLbN2RxDolV?=
 =?us-ascii?Q?hbJtRae8JkDrHC6Ge0u1Fxva89ZQXJIgTFjBCfoMmK7taNZDZkGElbTNzcO+?=
 =?us-ascii?Q?EqdhLq6UpRS74t2vfNk2HI6v2s2Shi/1i3uuztChKA/3WVjO0rWqpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21+XJgbTUE/5oWwOo1SSNoGwmbPhprSdG1CFeIfDxuq6bc3Cj5ptaCCFvtBi?=
 =?us-ascii?Q?S5FpEOP1TtrZeYb9iqP8zPVS3JnY+6tgFiK5sCixU//e8h//N9/8D2P2xZF/?=
 =?us-ascii?Q?YT+U1ab0nZ8vOQjD9s5XfH1oBB9IuPzChqGSiKJN3lnddmqbUe8bi4l3a1VK?=
 =?us-ascii?Q?QmK+NoM2uBlIv3ndta1Bvao2nm+gmvnip/aZAQgNyL8rTJF/gCqCq2GYa648?=
 =?us-ascii?Q?GrvW+zv9x4bZcorj5zPg7m7tax4GU7L1u9M1FF2f23qD9BAWPT7KiMYXlQdg?=
 =?us-ascii?Q?WHaWTWtZMlFu0juutSrl2KFrvgx677131LE8H1p27n6gF0O9oL+BiSlEyps5?=
 =?us-ascii?Q?wy13g86MIn2/3zModO49bTVgqlamcY0ajOB3IvtQENSokvHGjWj2F7WL3qxn?=
 =?us-ascii?Q?YBLLM39kpHZa78eo4NpyETeNOn36sB0Ooz6IA0OqFeRS8FAn35wDJuqEszyE?=
 =?us-ascii?Q?fSWqpy3cK28+RBuVOr4uiMdPGupEjseaSDBCZehaadB7CBn4G3EIVgk9gFl5?=
 =?us-ascii?Q?5Ga6SVJfs6pz4ojnhQrY5FDRSq3kPAhZ5RkzGMqBuTgXT7wC2enWs/u+T+Sg?=
 =?us-ascii?Q?PNhulwwn6lLZR2BnIRvvib45Qomi/0Nv/oCx/YsEIOELcefarUZGovPabTyd?=
 =?us-ascii?Q?C/2Ky4joFauC9LFD/YuCeIlCJ2vAQ2KHZl0XLvC+KYc5zjqOj683oerwiP9a?=
 =?us-ascii?Q?UFz6BRS8HouvtR7HoOuRNfqCPkyXAoo43pRwQxR+aN0KPr2PRQ1vK5IqwA2I?=
 =?us-ascii?Q?7+QkzfFw6oLczaKG6AQknyfUcVM4cxKep0mMtkwBMqHuKpiZr8lTeS1+PGeJ?=
 =?us-ascii?Q?1oDlTKCm8jchTacAvIqvCsXnOJJcZ+1kxsx0aD/ciCpWzUKndEqXDRKEIfSj?=
 =?us-ascii?Q?PhENXyTfU9Va+WDw6svJTtolFrBlXNdZEPUvMY8lrUgi7270GegWuvjqspdv?=
 =?us-ascii?Q?sab9fjcXjTc6aUpG3bRcxevRBWmKAOZPwtEjW90l+NmJuUsQWNk+3K28X2+m?=
 =?us-ascii?Q?mBwGhP/4Mg2g13QGDib/Wd8UPKOFwyOO583aSROJtJhAm+e4UUBNEdtDYHE1?=
 =?us-ascii?Q?44YOtWjKnl/ZtZcvDDzzHR3A4gKGyMcygwPw4CgJ2+wnFvJe6Hj8f4apYZxY?=
 =?us-ascii?Q?32D7agj2A+J9rLwVnEKs6r8YThOQe+SPZIiUTonWUeeEVCqMnWeLYpJF9gmS?=
 =?us-ascii?Q?JoLUDD+ri9o535Aam4uaCIVEkY15a6kiRO5R3H1jbeY8m5xikcALxwfNrrKs?=
 =?us-ascii?Q?HHdQgYeEwByeEnnusDLnm3sGPNxSvq3JSXpGiDivJ3/oomTgpNh6H0LsimBL?=
 =?us-ascii?Q?f/UVfYdXvsoJqfjlOG3+YZvd2pgvBK0i85AvfEfkXBtQxVGyQiKExa5UsLpu?=
 =?us-ascii?Q?93COM9Qg5NXenoSWe0SVcjFaqPuiLy7pXrqFwDpM01vLsLNpsCFlVe5T/Yi0?=
 =?us-ascii?Q?AFn7N+1aDSRUwIDW63f1GKB44A4ZL1wGM4t5x1GYBVDpzB3GTbVaJpTgI7Bz?=
 =?us-ascii?Q?O18TirR1tVjp5X7Op6QI6YY7oKNNWoZP+egnH2yFg3i3FFI9cn4p3Ava1Pep?=
 =?us-ascii?Q?7GHEu7z0fq+mocrCwGA7hE8ZL7Amp3UW22KN9s/4Lksu70+vFieyIffuFTlr?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nZHNQCxxzZN6d/sX1GAG1s8ZBbYQ2jp/uU9Jjsww5tTbjn6fbHsl3nC3g+hWXIoFSlJEOKaAYkg/YPOhBLFXACRpx2mrQrwC72uGqpwgXsD87r9wNb4F9Cp86YsuEqJEIXuS2QtKpe5dSYMN6Qzfkia68BW4V6dWu4yyaQTIEpn9xMflS78d7ATiCHOBR2RcmfmG1Px4BZ8D/bOIpKAEdzDU8+bPGIQk7JNsCIbF6tykdBARQSuOj+f/MxuIVsTJEyBBie4+Gr8pyiP53Wx0SpJQzEiNZuRXIXsqH+fl3hT6KEmz1fGYsxH5IVs8TEIyzL+LrsZTSvTMQwkvtin1VCKf4GEyalCYZsCRd941lxe/ue24B+wZCPPWzh62Mr6Hznw4ufxa7oTO1oyQPz10fyPDHPftXqSfQm/Rkcu1hINhemhLGhzhBJ+1z1EYJnsLTJ8WMoewvAjIm3Lvclb5HXcNbMnYgh8Qoof3ty6pMZVn6idA8/7R+ng3oB/aDHYb7g//IpZcnz3naCdy+aVt0fhZQ1yGQC1sAFsbrXL6OmfLCMot8RnPLGs9r2W1IdgM2XKP+t8alz/k3OAi9VTo+33wffMuJn4rr7Y3hT+YPuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fe730e-47b0-4924-aa50-08de12ffd308
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:18:30.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjt/Irs1WU7yzfFgo/svmfHOAh6WYYvkVfMn9iCQXwriRyGm2RAa1pBjQ0kMd90/6xGXxMTb9PAZ90S/xezjQ3CUWCcEAmtyniN5kNVkxZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=932
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240119
X-Proofpoint-GUID: wq16sEh8cW-EijyGKATtNCLI9HUPZRZg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA1MCBTYWx0ZWRfX5lxLCEemXXov
 xjRnNIiKS+dPt/h7GJ1ZYDwkrTKCMkcNML3GmwcZ0ClSmF+27GufxXCP7+qphWvPanHIwsGSc+J
 /46nWVQ/3tmAMZZmSbEqXLkrWHV7UZ2FTkHUQjW29fYL27TnqkiIbSDvMRdkoPK6NkXW2LqqglA
 l5M32tB8XzhoVCiA4r53g3HlFAxBQSq3e4GGLeltXuwZRP6nMqSXchoyiff8jYXE6663wpaHyiQ
 F6DX3CfIEOgHiWnAt82YAy9CIr8QO+VcOO73MMmJCTrwRTRl1HPV7szDWeYHalf2aItqBjzJqbl
 kcDpuqjx7Dv0ooc5Q5sL1u/m+JL8irbvPdDrAOIWq+awGT8Bhy7d369NeC266WuqGd5wrp0Zh82
 g236QAUO3DkeMyjwE/SsBpKObKpPkVNQozQr1VsjZOSf6sek6nI=
X-Authority-Analysis: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=68fb7cae b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=GvQkQWPkAAAA:8 a=ZhAWi9QkK8A50k4rI84A:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: wq16sEh8cW-EijyGKATtNCLI9HUPZRZg

On Fri, Oct 24, 2025 at 02:00:38AM +0800, Kairui Song wrote:
> A few cleanups and a bugfix that are either suitable after the swap
> table phase I or found during code review.
>
> Patch 1 is a bugfix and needs to be included in the stable branch,
> the rest have no behavior change.
>
> ---
> Changes in v2:
> - Update commit message for patch 1, it's a sub-optimal fix and a better
>   fix can be done later. [ Chris Li ]
> - Fix a lock balance issue in patch 1. [ YoungJun Park ]
> - Add a trivial cleanup patch to remove an unused argument,
>   no behavior change.
> - Update kernel doc.
> - Fix minor issue with commit message [ Nhat Pham ]
> - Link to v1: https://lore.kernel.org/r/20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com
>
> ---
> Kairui Song (5):
>       mm, swap: do not perform synchronous discard during allocation

FYI For some reason this commit is not present on lore, see [0]

[0]: https://lore.kernel.org/all/20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com/

>       mm, swap: rename helper for setup bad slots
>       mm, swap: cleanup swap entry allocation parameter
>       mm/migrate, swap: drop usage of folio_index
>       mm, swap: remove redundant argument for isolating a cluster
>
>  include/linux/swap.h |  4 +--
>  mm/migrate.c         |  4 +--
>  mm/shmem.c           |  2 +-
>  mm/swap.h            | 21 ----------------
>  mm/swapfile.c        | 71 +++++++++++++++++++++++++++++++++++-----------------
>  mm/vmscan.c          |  4 +--
>  6 files changed, 55 insertions(+), 51 deletions(-)
> ---
> base-commit: 5b5c3e53c939318f6a0698c895c7ec40758bff6a
> change-id: 20251007-swap-clean-after-swap-table-p1-b9a7635ee3fa
>
> Best regards,
> --
> Kairui Song <kasong@tencent.com>
>

