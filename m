Return-Path: <stable+bounces-113973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8689A29BFA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DA1888A4B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E510215074;
	Wed,  5 Feb 2025 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JqPFUy3+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gGdWctBV"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A84215043;
	Wed,  5 Feb 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791650; cv=fail; b=ZNt8ltEt00R0j0cj/nrPiLgDEgFH3IOWS4dVnlO40OWSwuVEElTxDDsrnh/JMPO6R/rnXIXJZj7J4aNLaT0cT4EnadXddfxsalMWzm6aYMHFtdfCVeZZikXC5z7lq8O1SfnA3TwmjTQgjMXvee+sFYg64IqGTMzwFlKCvXcM+Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791650; c=relaxed/simple;
	bh=JFulHl/t/YDD5UXq1A1W9WbdeDaJiCTt3tfJ+XCql+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G40NC+0D0p6Zndwhy0WmV7eC9dwSJfXnOp2sFxv0TkwUS6Mo5NAjH69a8+IbHJWOsL+JaKIzAm+UY04ir5c6fRnkp3D5P2mbqi1VdlxoSxXcKT2mXrqqEpiWqq82rTvd7zIR4SIWvPtcLKSGqr5TfDql+2fiM+4hE8IwNoOWpic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JqPFUy3+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gGdWctBV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiF3016851;
	Wed, 5 Feb 2025 21:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RO3KNQjq5tbknPju5xqQ/FSF/4E9qkL/VwcdgpSwM+0=; b=
	JqPFUy3+L8C/6iJqc76KXGJ18NFQTtnItVVJht72l3cWDUKCWhcNUsbIzKdQKrJ6
	FvSQ7g/uOkvE8MTytMlgkKEpBOspw488GOt7KRz2PIMlzgbyZ+kfZRwceJCgH/DE
	5FeUPs53DNpej+oVEw6I2PLCyrjzMxWt8ehgpSk7ofKOexhj0QYpcLc3WuNNKcvX
	A++XNBhgeuq91+Vup7o056rxFMSgi1DY4EIRP4liRhlX8THvF7EdRvkcInn4qqri
	6MD/qI0g6hZATIiPuadQ2MaVj3ESFxX++o4Gg9V31ZDzvzCJYgwqI+pgb37yPVvS
	hg8Vet/ad0hihC6NnZEDig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxm21e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515K0iIN027114;
	Wed, 5 Feb 2025 21:40:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fp5ab2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l21jVRhhpP87FZ9n993IhCGydrOC8FsQMGoiANuyXeGRHgoJoa4taD7JIb1bNg0UiX/t2L0IAQRVRDvnbeQm26zBSfkbSEcx4/rNmgEScUqLFOX5q/2ZYz6f1yOYgl7S8TGkuq1EF2vNR13BdWvYjCoLlE3lgH1sIpPXYxkvM9LO3Qrz8KbKNmnkyLF/xILf/I1JAudLCmfYbJfgaYMyPu6jysmFOMbKxDVLHISwSV5YijP18Vi8IpF3qKIeqPktwRq93qXYxFvGOQfMcOx0mZ46hSyZMrHAzXh2RWx3AfZQy+SyXK3QI3RxjrAajM8iTy6l5eNWJIg6FxcM8OYcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO3KNQjq5tbknPju5xqQ/FSF/4E9qkL/VwcdgpSwM+0=;
 b=XKIu/rcn8J+bpNT8FYEBlGw5lsXFqwcB/y4aYj3b4GuFBk1lzh0QvIVY6FVTnQzhlZr87gZS+30aDCGeXomzsgd/oYk4BAyHKGaUYEani2g4k24Dk1/JA4RqTefrUjw2/WMBcBTTAt1FecXrTNRWxDX8s7GCXNrYu9QnzsWtpmtz2wyRUoxGjNhWHHHRAU+4CkPwN//XoN0e8SNbDGwrCWlarsFpR/guV7UnRtQcyzQt4coUzFOc/UjgsQHdObUYtuaShctUnay3gpVb2b7BfFWf974R2/eHxuu9tq0QNfZVUHsi1h7J4i2WcxKEmW3dVQM9747KH0Xpb0fUlQV5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO3KNQjq5tbknPju5xqQ/FSF/4E9qkL/VwcdgpSwM+0=;
 b=gGdWctBVmwBvumdJp0NcJFEuZzccu21JcgRDD40FGPelT2fT8F+Fx8DY3w/f5UsfCPcHmLDPdXtxy3p3bc5XC6cfhLOzWkWqSoVJd7BV4ldRUiqdIOFxn5A4lOZJElEwoJFtRpazfXBSUqIksmGqiQoH8Atp7aohH+flyln5KKc=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:40:43 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:43 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 07/24] xfs: merge xfs_attr_leaf_try_add into xfs_attr_leaf_addname
Date: Wed,  5 Feb 2025 13:40:08 -0800
Message-Id: <20250205214025.72516-8-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a21eced-494e-4834-0c98-08dd462dbde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ARo+uQXl6voEkjY+HbHiQl7PnJ6lfnUDNWwEP7/Llq4Mwsl8B1J92iSPJw+2?=
 =?us-ascii?Q?eYgwMyPNyqwy9Xx7ukJuRn7pX7Nha5Zgh8AKAqiiw2H2sEXanZmilnDk3tsQ?=
 =?us-ascii?Q?Zr23P8fBn0AwzJ/jW3Zqg6LI2bM4kA3BvljXFaJgcGQ4dz4+PFjlram58w0L?=
 =?us-ascii?Q?M3rGgzg68F1cvNm9a/1NLY8nviYpFsgN7lIkGg3STf9LpG9GZjre0T7MKOWx?=
 =?us-ascii?Q?ozehQWk1JWQZJf9S2pkFFhzzbqyYPOlWP0rR3l1w7XJNwOhMYGkmA7NiDgsT?=
 =?us-ascii?Q?nGV9Cs4uQwKO2q/FPsxNoR4O0O17aavAeis0V56Ar4huJ0/mnXy4pPGfBjgj?=
 =?us-ascii?Q?7G5GNaeU9dWmB1G8KUE3kCRtFK7rQ4j6XI518DVy96PLXn6N5WZ55Gw48rq1?=
 =?us-ascii?Q?aPYGx4je1NigGk+4yum5z1RalOaeoxWJjtbf6MxpT6l1YF7w+BFZXLTqA/GN?=
 =?us-ascii?Q?8USSy7guuuWFqutnQUCzrJXhY+BS2kQqQq0+1VBltlIOTuTkI3sQGqlljK5I?=
 =?us-ascii?Q?MmFG/yogDM6jpOVHCrMCxK63DolRQ2ZCorGCdyN/Nwtzeq3znnKgQUbKan5y?=
 =?us-ascii?Q?k/Y8L6CiN2FDSJpG4U6bpKT0omWGu6zMnpfAV8sjGfOMVaOg0TLAY6Fr0xxQ?=
 =?us-ascii?Q?jmPA4LC/kpBd3IaYFHkVPs1z7PwKIKO9zAC3WapGWbWjImPXSAhBXT7DhCqY?=
 =?us-ascii?Q?rxaNIs/XBaZ/hXQQxU3wNholdKCawEAUPTkbiLmqtRmmSVs+RVJEUNIFOD/P?=
 =?us-ascii?Q?5PTdtX/IWqiVRetbeTxpoQHtopfSUKp0/zPKx+rWt2s6TZAjHEC2sI2nsLYx?=
 =?us-ascii?Q?QyRbnr7oM9JOJNC5GRW+4GorVvPcy5aCsr14q/G4PqWf9Hz/mgGzdvY2xJ1F?=
 =?us-ascii?Q?+pS46NuyBjjIhyOYz15uY59lObQd6YvHRZRLG+5eNZ91cOBtJJKVH4ixGUWA?=
 =?us-ascii?Q?/D+slgF+pKuFmgzWeZ66VmkrqKSkZ5PJSBh34o9QSbbDK01SZ1P38KQN0m5Y?=
 =?us-ascii?Q?Auu4lYTz57RY3UETBldtjMAnJ10EPzIkZLCSR5gYlssiahmz22hddOO5jo5+?=
 =?us-ascii?Q?rXA/79bgWZwJxD7yfd8dYReT5qARusZ3pMaRhKCaAYrt8wCQswObLMtA6lOT?=
 =?us-ascii?Q?uKlIPL9ob7FL5yZV+TdsIUdewAtG2u/+Qdp0temOz9WgeXDh4MpLpLYLf3U7?=
 =?us-ascii?Q?dcJ70mEJEGMnMh0jj5XMgCV2/DWNstyTKQJull2iqr+uJkRZhiPjYs79qGIW?=
 =?us-ascii?Q?hHh3KWmYxRcVy9852qIlVi+pUewKB+RnozA4grO2K94ZxOEDLKYwFLc1Zxey?=
 =?us-ascii?Q?ieTFSjwUCNdXx+fqAMUievvxnaFTaFCAt/RlccdIngITEv0C7u8ROnJ1bjdj?=
 =?us-ascii?Q?0d3NBXZdyx2R9PH6jOQlUEwvbAgp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDx1MmEDgmZRUbYfPqD7hJs3z/DeZM9DX3ge8JJBaYZqNeJaHj/tr2sM7e3S?=
 =?us-ascii?Q?zj20uJUezTjqIsE0ZWpGoBlnzYkpr8j+9Vg33SKk/l8WaXEwS+Jd7bf41B+d?=
 =?us-ascii?Q?Y8YKQEPXTlHSelu3EOTP6t7KDdQBJhIQmPMLBPyKQ142lq1g0kv69K92rG2F?=
 =?us-ascii?Q?NuM/1B8h4UbG3PJfOFtE3/PFdAhagSG9Arfg+GeQujbgIeEOR07BA5sZAm32?=
 =?us-ascii?Q?9gOBNc4sS34YOd43jjXRk8s0rOoj8Vd68nhYbiKsJizZO+6Km1VKjgyTqwuv?=
 =?us-ascii?Q?UZkRFIkwcA/309RuqOkKCXoDWuMves1l0qDEjPRyiK0gyVSSDV1gTAqjsvy0?=
 =?us-ascii?Q?iPOqWW4En7MM+PA5phD3PHeymUGbfZtlP9SxYU16BbBu6yGgLHhtyvWCfmy2?=
 =?us-ascii?Q?jETQZstx8Pfc+zd2Ub0/7bLRJEG24LHnWCeS5zhbU666NPv6CcSc5ZsGgS0n?=
 =?us-ascii?Q?JRWqlFkkpUDaq0+GkcqlHuMlDaBHkOQEJElmhDsdoC4cTcmDzKVp9RsNSJgL?=
 =?us-ascii?Q?4JTLwqbIz/bnyRYQWUyJ8Xs8QfgTmQcwK1eGdUPrZfIhLqrcZLTSaCVnUd2H?=
 =?us-ascii?Q?D9UxYyHQQhyXhVHNTy7losyQSdOOeKoflelkZoYUmUqDomOA2fQrSwyAZXMs?=
 =?us-ascii?Q?i8XsKk8I9+5oCtnhUx9uOkNodxfm3AErNkwHbLUeFHirOYaBDMXMack445R0?=
 =?us-ascii?Q?WuZv9t2MZeTCrA+ZJ1Wt3vikEP3aUoZkVmprEiduP8e+EFihq0qu8Ps9aJ7Y?=
 =?us-ascii?Q?NKe0Sb4z3ATHzm+7z9UpH4PVVR82Vd9VOlnW6itAf3WQzRFrssbur0JpGo42?=
 =?us-ascii?Q?kQvE2eGtnCV+jtvIgzoUfISFTq7Oc6/00q6/WtqMciTHBtF2Ezhw3NDsFJBM?=
 =?us-ascii?Q?k3vU/H/wsUhFUgq6UUS+nh3E/Z8HdJc0/ZsWCpAa3Jwct0o45k0sfYjYPUtq?=
 =?us-ascii?Q?cur8vTkDVDM2S7snlIqMebaPBv5odMZNTvWIjspMakgyNqEBOPDod2ZOyJsQ?=
 =?us-ascii?Q?QTksKUcTaCKQBWO/LGJ8ynH40KiYw4fldfsJ4RanMB541vmlxdsbWdz8hk/T?=
 =?us-ascii?Q?KEd4LVoZHBYjJ1S+3bU+vV30cPE+BNJWWXm9fwD/yaraffMg2q9mqX8Eqs8o?=
 =?us-ascii?Q?ft10B9a9amQEaeki0Asv2pdrU41sQDZGY5b2MNNynRMIdeji4xHgad6g9+Kk?=
 =?us-ascii?Q?tAPbeGCmMrO5EvbLm8AhMqL81KHWN6kFVXUFHr/HalBeHEpdl+D4uO5BoZ2l?=
 =?us-ascii?Q?hDBURRl2sW+p+aDTD+w2Csd3gehHHidJDxIQvK3iIQXvAVACTPKYbdIeBbhB?=
 =?us-ascii?Q?m1U0tsOAomSN0gA9LpUmxyPS7pk6ZHBkyZgQ505j0b+CXdeJMhyGH0j+nq4X?=
 =?us-ascii?Q?p2HNK7zV32ODsQVWs99pBzlBs88rB54Ims1uBBxFybjof7NatKxyZPlZBinO?=
 =?us-ascii?Q?s5MDjZdQdGFJeH6YeDK9Cy2hc0w0qnNzbyPeldMgphplplGn81rRYUzc6bXd?=
 =?us-ascii?Q?DKR2HFBB374dLQw98WwaeZtI/g8qUaVTFBDVP2BLiUCmxocqKo3bbzixbiUO?=
 =?us-ascii?Q?tuLBFlTQJKrFleuTAHZ80iCdyPSzLjibjVE1SeSuc0cjmn5ki1vwh3Gs9Pqt?=
 =?us-ascii?Q?487ao8/HqVP/ZBfDgqEH27qtEliOJVEZVudoK4wE/fJdW/ghX6HGnfog0muk?=
 =?us-ascii?Q?0xjuQA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ba+4zgy7/P0cuDgIDwXI9PqoNQxM8Z6r5fA9b1UNmSi0SG/veMP76ANi05WXhBoi2erb7vrw7i4vPVYpnsIKLJnquXB/F6ysF/xWCnBGHyYV0+/u5t2mwS5cJRoMPCohvafi5J55BcDgd/9rBnbSL4ymN8cvHfnu7ZieEbYaaFSnC9IEGeb4Y18ifCx37i+/gwf7G0ihTskuFrVItq3mtIsZWl3g2rJD4w06Um91oHct0xCLTtC/3h8yjoOWSLynh3rcIrqCqIXGpU6lSQHf9WSYeU+qz7oOkZADJ/58/fOBIBmLm2dthlx/PXyd5KJfADmkQyWVhM/MQm0WEZ/75llb0/c9uWXg7Skw+IwKA9JmmQDPdym9hArx4znJUAm/v5CNHmvinzlSDeqiamZcbWQ7W1N2c3k3RqZ0D8+cQhoJJ+jd26EzF9gt/Vj2xZYaaF9dE349CH2QPZXrA+O/5DeO3st/YnEZCWKpO9aHjw6MDeTdXK9+OutnNjNq07QTzgpxkzdfAL+AEuevBVL9A0D9bbfL4f7uXB2As6VubLo7lwkmyOZejDzOGnkepTcqj9+U34E3WxB6duAOxBDRRvKbPKlMoCXbAclwZmpGLnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a21eced-494e-4834-0c98-08dd462dbde7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:43.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pilE9INQpvWyrNnUaAXFtqv/Nk+yWE6rA5Y8Teil15o4dJQfcGCYER8H/dXMWkG3yCc8F69l/Id3gZA16hdGERrav/McQxb+nQlidSAgnOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: -peoZEyS6ES4znpRjlZZxs2BhzW1ut19
X-Proofpoint-ORIG-GUID: -peoZEyS6ES4znpRjlZZxs2BhzW1ut19

From: Christoph Hellwig <hch@lst.de>

commit b1c649da15c2e4c86344c8e5af69c8afa215efec upstream.

[backport: dependency of a5f7334 and b3f4e84]

xfs_attr_leaf_try_add is only called by xfs_attr_leaf_addname, and
merging the two will simplify a following error handling fix.

To facilitate this move the remote block state save/restore helpers up in
the file so that they don't need forward declarations now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c | 176 ++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 102 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 33edf047e0ad..f94c083e5c35 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -50,7 +50,6 @@ STATIC int xfs_attr_shortform_addname(xfs_da_args_t *args);
 STATIC int xfs_attr_leaf_get(xfs_da_args_t *args);
 STATIC int xfs_attr_leaf_removename(xfs_da_args_t *args);
 STATIC int xfs_attr_leaf_hasname(struct xfs_da_args *args, struct xfs_buf **bp);
-STATIC int xfs_attr_leaf_try_add(struct xfs_da_args *args);
 
 /*
  * Internal routines when attribute list is more than one block.
@@ -401,6 +400,33 @@ xfs_attr_sf_addname(
 	return error;
 }
 
+/* Save the current remote block info and clear the current pointers. */
+static void
+xfs_attr_save_rmt_blk(
+	struct xfs_da_args	*args)
+{
+	args->blkno2 = args->blkno;
+	args->index2 = args->index;
+	args->rmtblkno2 = args->rmtblkno;
+	args->rmtblkcnt2 = args->rmtblkcnt;
+	args->rmtvaluelen2 = args->rmtvaluelen;
+	args->rmtblkno = 0;
+	args->rmtblkcnt = 0;
+	args->rmtvaluelen = 0;
+}
+
+/* Set stored info about a remote block */
+static void
+xfs_attr_restore_rmt_blk(
+	struct xfs_da_args	*args)
+{
+	args->blkno = args->blkno2;
+	args->index = args->index2;
+	args->rmtblkno = args->rmtblkno2;
+	args->rmtblkcnt = args->rmtblkcnt2;
+	args->rmtvaluelen = args->rmtvaluelen2;
+}
+
 /*
  * Handle the state change on completion of a multi-state attr operation.
  *
@@ -428,49 +454,77 @@ xfs_attr_complete_op(
 	return XFS_DAS_DONE;
 }
 
+/*
+ * Try to add an attribute to an inode in leaf form.
+ */
 static int
 xfs_attr_leaf_addname(
 	struct xfs_attr_intent	*attr)
 {
 	struct xfs_da_args	*args = attr->xattri_da_args;
+	struct xfs_buf		*bp;
 	int			error;
 
 	ASSERT(xfs_attr_is_leaf(args->dp));
 
+	error = xfs_attr3_leaf_read(args->trans, args->dp, 0, &bp);
+	if (error)
+		return error;
+
 	/*
-	 * Use the leaf buffer we may already hold locked as a result of
-	 * a sf-to-leaf conversion.
+	 * Look up the xattr name to set the insertion point for the new xattr.
 	 */
-	error = xfs_attr_leaf_try_add(args);
-
-	if (error == -ENOSPC) {
-		error = xfs_attr3_leaf_to_node(args);
-		if (error)
-			return error;
+	error = xfs_attr3_leaf_lookup_int(bp, args);
+	switch (error) {
+	case -ENOATTR:
+		if (args->op_flags & XFS_DA_OP_REPLACE)
+			goto out_brelse;
+		break;
+	case -EEXIST:
+		if (!(args->op_flags & XFS_DA_OP_REPLACE))
+			goto out_brelse;
 
+		trace_xfs_attr_leaf_replace(args);
 		/*
-		 * We're not in leaf format anymore, so roll the transaction and
-		 * retry the add to the newly allocated node block.
+		 * Save the existing remote attr state so that the current
+		 * values reflect the state of the new attribute we are about to
+		 * add, not the attribute we just found and will remove later.
 		 */
-		attr->xattri_dela_state = XFS_DAS_NODE_ADD;
-		goto out;
+		xfs_attr_save_rmt_blk(args);
+		break;
+	case 0:
+		break;
+	default:
+		goto out_brelse;
 	}
-	if (error)
-		return error;
 
 	/*
 	 * We need to commit and roll if we need to allocate remote xattr blocks
 	 * or perform more xattr manipulations. Otherwise there is nothing more
 	 * to do and we can return success.
 	 */
-	if (args->rmtblkno)
+	error = xfs_attr3_leaf_add(bp, args);
+	if (error) {
+		if (error != -ENOSPC)
+			return error;
+		error = xfs_attr3_leaf_to_node(args);
+		if (error)
+			return error;
+
+		attr->xattri_dela_state = XFS_DAS_NODE_ADD;
+	} else if (args->rmtblkno) {
 		attr->xattri_dela_state = XFS_DAS_LEAF_SET_RMT;
-	else
-		attr->xattri_dela_state = xfs_attr_complete_op(attr,
-							XFS_DAS_LEAF_REPLACE);
-out:
+	} else {
+		attr->xattri_dela_state =
+			xfs_attr_complete_op(attr, XFS_DAS_LEAF_REPLACE);
+	}
+
 	trace_xfs_attr_leaf_addname_return(attr->xattri_dela_state, args->dp);
 	return error;
+
+out_brelse:
+	xfs_trans_brelse(args->trans, bp);
+	return error;
 }
 
 /*
@@ -1164,88 +1218,6 @@ xfs_attr_shortform_addname(
  * External routines when attribute list is one block
  *========================================================================*/
 
-/* Save the current remote block info and clear the current pointers. */
-static void
-xfs_attr_save_rmt_blk(
-	struct xfs_da_args	*args)
-{
-	args->blkno2 = args->blkno;
-	args->index2 = args->index;
-	args->rmtblkno2 = args->rmtblkno;
-	args->rmtblkcnt2 = args->rmtblkcnt;
-	args->rmtvaluelen2 = args->rmtvaluelen;
-	args->rmtblkno = 0;
-	args->rmtblkcnt = 0;
-	args->rmtvaluelen = 0;
-}
-
-/* Set stored info about a remote block */
-static void
-xfs_attr_restore_rmt_blk(
-	struct xfs_da_args	*args)
-{
-	args->blkno = args->blkno2;
-	args->index = args->index2;
-	args->rmtblkno = args->rmtblkno2;
-	args->rmtblkcnt = args->rmtblkcnt2;
-	args->rmtvaluelen = args->rmtvaluelen2;
-}
-
-/*
- * Tries to add an attribute to an inode in leaf form
- *
- * This function is meant to execute as part of a delayed operation and leaves
- * the transaction handling to the caller.  On success the attribute is added
- * and the inode and transaction are left dirty.  If there is not enough space,
- * the attr data is converted to node format and -ENOSPC is returned. Caller is
- * responsible for handling the dirty inode and transaction or adding the attr
- * in node format.
- */
-STATIC int
-xfs_attr_leaf_try_add(
-	struct xfs_da_args	*args)
-{
-	struct xfs_buf		*bp;
-	int			error;
-
-	error = xfs_attr3_leaf_read(args->trans, args->dp, 0, &bp);
-	if (error)
-		return error;
-
-	/*
-	 * Look up the xattr name to set the insertion point for the new xattr.
-	 */
-	error = xfs_attr3_leaf_lookup_int(bp, args);
-	switch (error) {
-	case -ENOATTR:
-		if (args->op_flags & XFS_DA_OP_REPLACE)
-			goto out_brelse;
-		break;
-	case -EEXIST:
-		if (!(args->op_flags & XFS_DA_OP_REPLACE))
-			goto out_brelse;
-
-		trace_xfs_attr_leaf_replace(args);
-		/*
-		 * Save the existing remote attr state so that the current
-		 * values reflect the state of the new attribute we are about to
-		 * add, not the attribute we just found and will remove later.
-		 */
-		xfs_attr_save_rmt_blk(args);
-		break;
-	case 0:
-		break;
-	default:
-		goto out_brelse;
-	}
-
-	return xfs_attr3_leaf_add(bp, args);
-
-out_brelse:
-	xfs_trans_brelse(args->trans, bp);
-	return error;
-}
-
 /*
  * Return EEXIST if attr is found, or ENOATTR if not
  */
-- 
2.39.3


