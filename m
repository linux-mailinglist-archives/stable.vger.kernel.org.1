Return-Path: <stable+bounces-93533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F39CDE77
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B94281818
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39041BE854;
	Fri, 15 Nov 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bw1MasTN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kQ7TgRNF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32F1BF80C;
	Fri, 15 Nov 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674453; cv=fail; b=Dd6bHQAW41m0Nrp+4zHXoUW+Yl1M/uw9x1yr9Q2dlf7wUgyteut3kXx4bMEij9brVeNF2HsM0XwTxuBv1v13PIADHkGNykwzLUr9NebkIpic+LqLh7I7Z6/iDyf2mk/wi05chG2qQbuKH7TBpblI2EeO40nwkkN5DMxIpavDeCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674453; c=relaxed/simple;
	bh=r1k3WtlUVa4rTK/Sle/cCczN6drEv5UqM8ZsPadNuTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhQLLqev/mFYHnGmeNGwc6ZdHLMHXxnaz822Z8QzqPyPA4nd2XJezq6ZQpUONs+7mlY+ddWsjhWqrL6BQyOSIUDdjrLK0lCX3sYxDuPaWssYerWbcnJ8AsAUHy5a2E/gCQTPt0keqttkSEO7QTvF8b03yFSLeSw7+3qr1tH3YJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bw1MasTN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kQ7TgRNF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH07R021277;
	Fri, 15 Nov 2024 12:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Rp4/S+tmW8/2EUOVCLf3AsFg3DSHJEhOXEcoD1rcL1I=; b=
	bw1MasTNWkFuZVbR3o6XxN66ieQ/YX3QDBIvvWsNaza+Ox3Ryru+De68e9uWYeb6
	leAD4twaKOx+SWjdDDpE90+8BBffILVackfYgh25eElRfbdET9CPSdszQYd4IBcl
	CyG+KrsLaHXlqXvT4MtsSRSaSwCzGy/Ei/vJuhoLw+RdLFsfHzsIsv/K3w6cbUKr
	MFYzTxDCE6ctWvaURJzn48BPFTJxNA0PlANUXoVup2D22xP3SeuOZGemdHMKA98P
	sG9HKEFHEXzfXJzRG/gxb5ztArKZys7/nxtefJsM2HHzva/edQ7JqInpnySGaGBF
	r0EGhS4VJmfLrcawPwjN9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4n13p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBRFUS022725;
	Fri, 15 Nov 2024 12:40:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2mrry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2s/0hOMQUVF8gqu8v4G2siJBAmbt7kxoMnSjeuq3cKGUhmBrlKJcF/K2Hn1zl7bQYQyblcnbshrqm+xn3ukQsxrbwSFHV9pfKKmA30SCKpguOyUGLae2JIPFwP9BdIgPey5xlp4JxOycmN8DPvjgr6ebNC2Qyesy18YlWe2iV9/+Oq1b8KuZzAhHxnJx1Rx22e962LouDww3DI6D1MfNzt6bVNx+FkSqMeP2bkjoGoNWCNg0ig/Le6OxHvw4z5xsnoryvBS4m3EvPfnMF6JK0Wp50T6Ki5yu3cyqk2gViT1u6y22coSsCzAgmCxAxxAnFSBpYiB1k77iuLqQSDttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp4/S+tmW8/2EUOVCLf3AsFg3DSHJEhOXEcoD1rcL1I=;
 b=xotfYH7Sp6dp2dt6AD2NZ6ugWa8ReplCZqQAckkjvqUSB2zLWa1keNLrgFYxNQueh6L1VijiVMF4gQPiuSgDLgjNiVcmU3+3BHp4Gn8ycNR656xh/9BlBrUJzoIW8+CQs6iWPScaXYeW64Ls98/IWO9lp+OPbuOeVLJrmLSSdUZ9mX1X+Ub7Khz+y0e0KOura6Vr+L3vIy41U+73NxKfxY3spwHCf9Y+AffxCnJkEpdFQ3d6xyT/BSVKhzxf+BfsCUICvcTuGG9vYtIGUfwFRR/yIDt8D4+KpDH05qtY7+cU8atRu0S1QUIdwa9nmFuTmno/50uC7k8UpTpYJ5SspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp4/S+tmW8/2EUOVCLf3AsFg3DSHJEhOXEcoD1rcL1I=;
 b=kQ7TgRNFWmh2CGOmBWM/rcgbip9k5ZO4a99J8ATnqQSarefgh3iY+k8A8F5L9szzh0970x4rJZx7Ghe2TmsFRhZrRwchvZ+c/ysQWLlCfRpioE2OHjjv+bNkdRTRitPiwlPPFHLY7UDKR5mqLeOUldxwE4p1clOR7TuGb4jwQuM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:40:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:40:27 +0000
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
Subject: [PATCH 6.1.y 4/4] mm: resolve faulty mmap_region() error path behaviour
Date: Fri, 15 Nov 2024 12:40:10 +0000
Message-ID: <4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: e08f1448-0deb-4c8a-89bf-08dd0572ae9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?68+7svkN7IVwsMmdsMGYPkSTXSEekuHO6bl/h0ycUqLV+lEfdDYdrbAJSlb3?=
 =?us-ascii?Q?48MJbivo6MaTM1LQj821tPoJIVqVgiHs2zELW1u7AXDQFbLDRUWVRSzUVCAq?=
 =?us-ascii?Q?Ol8RZuEQoWhiVDQGe1ECRvLmXCUlSu2hi8iPm3kAkBgeBOwWQi2LFJcaoKmt?=
 =?us-ascii?Q?lkwxXR/5tuhdi9t0Dji2hCwRpWGl9xKo1+YE5h/Unmv2YZS87rRmOlVqbxjV?=
 =?us-ascii?Q?OftJlCp48qy9U+dZZN6nhR6QGzjFKOzinUidjKFO3H9KEVHz3+L7/BjKyK8V?=
 =?us-ascii?Q?fKRnLZijd3qIuGfRqtFwxuoMVe6LrqSlq645NGvNVs2TO46L3YwKMPKVXRtp?=
 =?us-ascii?Q?Rm7oX61hp/QWfcmcyb23pV985F8VJ7RiqlUOWK8JP7f9nZ1sakfGBan5cXuJ?=
 =?us-ascii?Q?rQnq7m36+u25Bz7FwPbX4gnbSGr/2+CuHNNNtoJYOCgV7mXp43AaTTUg9pFc?=
 =?us-ascii?Q?ZVlDHRMH3B2vwZW7vtzQgQj9cPJJUisMtjqPP2Hvu3KCb/sAHm3OoFQCtOrl?=
 =?us-ascii?Q?A8wOvQPtFO/M4Q0iuSCI5+7ehfHVQY2ozRl7FvWWUilM6btVKESnpsPPEeKV?=
 =?us-ascii?Q?hXyD3WeNtbWdnKZvTUrXDHeQKW5AzzG2TRwU4xPRHkKE0izYQv4RVyqDK968?=
 =?us-ascii?Q?jeHbTyNWEt5RisWu3TpkEIgPXSElv20nZL0MtZ5ALqhAABN0jN42nDkBF8zf?=
 =?us-ascii?Q?GGwr9QoC6pOSfWhQaET6V8YKqGoHAUbLvyNyjRVQpZzMHx+s0kXjrBx+0fJc?=
 =?us-ascii?Q?d61CETrRfSrKqzc+TOQMHG9D33+katMUu9b3+Cqg5N0KvANfdKF976c84DIq?=
 =?us-ascii?Q?6nY8aXzdiDNilMnjqRcwshSk9/VyqoaUxSPjdD105fhgv+Rivzr6Pk1PHnXC?=
 =?us-ascii?Q?q5sQAfbZQ9P/PZmRSC1HwSPhafJPWq1P92ffOV8I1Avlef2LFBKah6S+tSTD?=
 =?us-ascii?Q?yBPHFKGSPCRnczeOU1MydH8OZ4XwNUAn6Tj65G2ZMwOC368VRujP0q7RKtgD?=
 =?us-ascii?Q?svL5uur+8wd/1hPqv9MoBGvjR4h6JfGdh5Yrqe1FYdRYdbcahixtcG3qOyav?=
 =?us-ascii?Q?GLdRMCk3Bu8RW/C9H2HnvzoXfi6SpPZ1kxsqIGAu74fYGk1RGC8OM742cShk?=
 =?us-ascii?Q?uI6TbJeH5EGLYnydSlIU8NqZE1dfq3FXffyW/s/N4SepKEXM2x3yL/xb5vXJ?=
 =?us-ascii?Q?QFdA00+RyYhv9DKXoBk9TnVT6nTToHOC1e1tphbRv2r/DaTq0Zb36xeykjps?=
 =?us-ascii?Q?ZMHKxcTjNYpShyz3v6r4vQaVV9BxpukIUdYO+K5t6COiCV/ellWOBzJlKFjf?=
 =?us-ascii?Q?9KXjl1NuxurXtT72bnA4Lnkq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4MrEOe60ySYNRs16IM4VKIIp+3X+p4RneeSSYlgI35Z69ZO8j7bK9UEpDSd?=
 =?us-ascii?Q?mKNf5WoRjqYuwXWJtb9P/umkgB5iILwYz9JjXETM9T/vLo3p3WqYqf0e4UWE?=
 =?us-ascii?Q?cFrfgVKGun/nsWMi9oOD6en9jmpbmUA1/bf+OKhdoHdgYQAj+ERJNPYMBilr?=
 =?us-ascii?Q?y4OpWO4Asg7PvL0j6Zb9EVirjgifvtscc4/BMNs2Bt05T/4GsO+VjsbsOmtX?=
 =?us-ascii?Q?XQIzjnLxv4mEJldB3sL8Mn7t+gE2tRCmjtd98iQUx7zGfMIzbzmPPdABM9AJ?=
 =?us-ascii?Q?mjoc4vRUI1edn4pVB4mNkoxfhHHYEOPPLM+z6IhUeQ4YLQDOhhYVQNy3O8zM?=
 =?us-ascii?Q?7h/lMX+MVJmwJ0zD9OTZgKAXQu9SglOGvKFTV/Xwt34lWAjQ1zvEBDRpmcTf?=
 =?us-ascii?Q?NpTjB0VgMMDuHrg8JQQC7cUUhO+koAIouIB99jQGkYU6c+5MSadNZUGj4gag?=
 =?us-ascii?Q?KC8YFTmonKgUD4lOuHdC5IanIzEFxzKZ9WE6IbTCqDdvjbBLqP5ztCevCzgN?=
 =?us-ascii?Q?gMHTT0kiwlAJTa2OQGzB+pmYyLEJqsMOdPnZhYmZNok9Qo4C+N7UQgzegj6v?=
 =?us-ascii?Q?I6/WB3dDcNJ4u8EF1dVt6z35cgpkhynwtwbTvVNJlag8Mpttod58Ab9T3ge4?=
 =?us-ascii?Q?lWrjUbpMr9xTLkvpqMEzDetodRsMk1IzxZ59mGYCQNOkqPpa/XRYLYX5ah+B?=
 =?us-ascii?Q?PAo8RSy/YgAYdLp+Fqx0K1rJncNvlkGS8L1U06GFzu9IStEhQDi426G6giaA?=
 =?us-ascii?Q?j0Ceds3P4l05aS9P5XaD9rqpYyN/SnWJEQ4uT732mTX1GQbKjI0xS2BtysgJ?=
 =?us-ascii?Q?M72e3AoWAG21Vs7T+9NYAeXxLs+TdhUdUAFnPeNrRTUUsKC77HaXNkazG7lW?=
 =?us-ascii?Q?4IgS0tmokyHlqLyjMtUagQ/u5oy6Li1dPzCUQy69XCVAxZyJYon0Jyl4Hg5e?=
 =?us-ascii?Q?enldi6suFnyvMPlBvoz8GF8hsKiIJpG3E8JSX+CXC7iH8S7+SPWNpqpJlXoC?=
 =?us-ascii?Q?uiQjY6bfguMPVHZHORdpUBhwYKkD4i9WxlaUy3r8MteHmXPWfAw9QygQmWYZ?=
 =?us-ascii?Q?yoKr+dwvF76/viO72z/hTEXHJ9TqTzDlAtGVQBcL/VgxX2b5DsOruhb7DH+F?=
 =?us-ascii?Q?H9RG8mnCCJG4mg6/8FlZ4mKOT8xnbw1IitSLRb04x4gqRZ8GePByVR+YkjFn?=
 =?us-ascii?Q?kNxzloOVFyw1+GL2M/FO12uuqBmNJgBWdUiRmvpXlNnRsGhto7Icl2qE3vEP?=
 =?us-ascii?Q?L9gCQkB291m9qtlPU0NwskxtZkS6pXtjZ3BnVWOju7sLDZNdPJvjLpYxOPG3?=
 =?us-ascii?Q?ZAms0fK+zepcBGBytiK6UR+Q6IFlEtWDd29DfGJtvh6oUENvVDSFgDaZ0FYC?=
 =?us-ascii?Q?tAWssr2iF8lUmHC+qbMH3lGDsGnXcbtmFI8HYbqJTIO/Wa7/2dcpKHmKszo8?=
 =?us-ascii?Q?tkLM2EhBVqUXXABiRZ5N356FRP2sjf39nd8CQX43zM+cHAOgHufThPiwGSFp?=
 =?us-ascii?Q?qqeBQvoDKgLU6rSZJXBhpPTRlwBwSA4Q++BB/YbsyVJ6aglZyqgT0FcalxSz?=
 =?us-ascii?Q?UBiHWt/wychEUQoteUI/6MeZyB2E4jHQ4Smk9J3mJ10Nnsl8rN8ruk6kAJnq?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	54DX0BpqaS3fSkEVnfivT7XgEIeJVfeDYFr6CE0xC5mErLMVSamWSeR3PWf1S+hfcSDP/FSEani2bffB+sG+z5CYhvij0+K4TnRPrh4DZEE2WyUj202BMNBDi4LqzHTKSWnEugLJ2bUzHzOmFmsLaBP39aLApMaokQ/noIegpGE3yb/xI2t+BMkBoNNL9GKf+GUS0EFsPTDjKtsEdLXRNeRi9B8LnDroL1LG09c0RuBDKwLQHa4VJ/AvAvBrtiSjIryQfPnGC5lhdNhg7xNfvAAL/ORJRp6AC8iERP901ODHXAct090oMwRK5UShfUJFa3ewiCc9ZkpmxdUKi0VntBsE8u/qFQJW6AfzVQ0oV8Decu8/2RvabTEYfSkzcIhJaY4jt3nqPD7+/z/Hh+s8aDI14rqHVBmiF0WKYWobdTIVEqxR5F/n4IqRgnVathwIYzBhWQ2fR7m+qZA2ZEF4N1ypPLJjfQ7kLS9CE70eLVVo7jKs0GaJ3TqTeIC9bYMnkWML9LhbkKqj+mwO8sGM39vN1SRx/28UyOBClOIP9dj+pzT1ukUsDUJJTPQ4IluqMD7wauvJBdkjUDnuWOyQvcPFzmw5NoSkvJ/oOx1NeOU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08f1448-0deb-4c8a-89bf-08dd0572ae9a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:40:27.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSrmZdCLWUlCeJt/Q0SxWChwmYJ0w0pcswxmNRDl1KVh+f/z4SX3ahzSCJaFmeqcCluG2+24k+a5j4877plKc2wzsoA27W5HIR1nVf8gnCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: 6c584fQVSkwUqMk5NVXNBP2KtXnSjkYK
X-Proofpoint-GUID: 6c584fQVSkwUqMk5NVXNBP2KtXnSjkYK

[ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]

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
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 103 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 322677f61d30..e457169c5cce 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
@@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
 
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
 
+	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
+
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
-			goto close_and_free_vma;
-		}
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
 		mas_reset(&mas);
 
 		/*
@@ -2792,7 +2794,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 		}
 
@@ -2800,31 +2802,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}
 
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error = -ENOMEM;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
@@ -2847,10 +2833,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);
 
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 expanded:
 	perf_event_mmap(vma);
@@ -2879,28 +2862,54 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
-	validate_mm(mm);
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-unmap_and_free_vma:
+unmap_and_free_file_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
-	if (file && (vm_flags & VM_SHARED))
-		mapping_unmap_writable(file->f_mapping);
+free_iter_vma:
+	mas_destroy(&mas);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
 	return error;
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


