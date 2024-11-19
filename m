Return-Path: <stable+bounces-94062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB89C9D2E90
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 20:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70042B37468
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9D14A098;
	Tue, 19 Nov 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwRD9eOK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JVSLU3al"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC041509B4;
	Tue, 19 Nov 2024 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041955; cv=fail; b=UXnLmp7Yh6X/Jsfv4DOpXRBh6D4gxSwz/Abya722/Hm5Y8m1UQzVVShF4ZmfHqn5nSsnoCnUhD75nKDCDrbSlwGxCpitk98HF+W/HhtJdZCEc0GEE/GSWFKxdXslY/KzjJck1O/zRQ5SIpiQvu+lySpDcwP/NBc4duAuB9rh4jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041955; c=relaxed/simple;
	bh=bi5nfdnKbfDNgALSmuGVSjidhEjOJKj7fBmD2QQh+yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bazqpRta8BT2nvtSpGrPZO5SkG124hY7PjmVP97J1Tle0yJCb38O86Tr58cLUZzYFVzXAYfe2EzZW45c+3VN+3qTSnHnotNv58ZwRv4v1vV7IZ7MgsQkjVk3fEFC0YDwChOfpGO8dkdP6SHypbzsopRVO332oh/rbC6bqpctRXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwRD9eOK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JVSLU3al; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMZvc018888;
	Tue, 19 Nov 2024 18:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9n5FnyRcfrIU1v2d2D
	YUHKTtanGwm1UpspWlYBYVIjw=; b=WwRD9eOKlHKitL+CVVSGdOtNdItEWZiug6
	eXxTlwOxaFs0rGJbxZ7B1uu87mO0YBznh0JUXC37/LC8jp2QqnSIRYUkwYP9pE+1
	E7bzTDuNvLPeUG37rN8ehmAOkzBVdxBpWQYvt4aH8fw8egHR64t2rWTeoZ4n1fvs
	JZTn3zMefDLQkO9HDjzJo0Y2Jlr9uxYkBE83WRSeW0HGF+FpuoiZYRRwnMe/dtBd
	5D1qIEA7bKGE1/c3rAUKO3bDSnnUJJzmWzxgUn921UsrMQkA2lst405X+UWpiCJD
	aEtdS5RcyzxMjmpkujcFntliVYfD4En63y545Shfxh79jtU+R31g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc5quu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 18:45:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIX8f7023230;
	Tue, 19 Nov 2024 18:45:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9cd2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 18:45:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxJ2TD8aqSLlRp1eHDKoU/D9uU+07Z0QYlk3XyNCIrhoxx8ZL3ZkMax3o6xJoJgwLrirxBF3yx5jwEl8f5h5egK19zIcR9ZtQk1/Tm/8HWF3VqwO4iRkBg+kLGaAQEIwGbo3p8PSJZaql6foPP86w6Ad+/iKAXfeqg0BrR+cW+OxekMCG/ka6Q28moMbLH4ijumjHTmq8SRS3Guye74PEZZxzfIH//rMZFBdagKjfsF/wLF+ajszIsJiwRRChk/yiy9l76sThEVVzJIup2GUyWufrFqwx5o8dXSY99tQq84L8zRmeNhgrbrVmCAet3/V78q2ecEC2VauhQ4RfV77WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n5FnyRcfrIU1v2d2DYUHKTtanGwm1UpspWlYBYVIjw=;
 b=yq2caJ6NwhT3bWtW06kf9bwgOrvpKIEDRNQk0j6rAa30SvJYGNiDCefYE0Vt2RW4CoWRO+/K/nfMLOO98csENv9Y9BiuDT3xG4Ex7RtOkvB7vHRjZIEjWM6PnR2ul8/CFsWjYwUUC9mLoGZmvE+CKQpJ3dYdmKdVTM0ZoC0a26A6X39KTmu7uViTOR/q0XEgc0oO8MKCNSw4BiJHVvUhwQWx/tCwe0xxCLZMczGU1qRsjIBZLgqnJ84rwiausjPUl3KJ9SyZbRRdo3bUBHUhR8AefGVua5GiWvGY2KDDJ8duiVPWmhVtqLkZ64FzbrWr/439dYEnpcyTFoCw6GmBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n5FnyRcfrIU1v2d2DYUHKTtanGwm1UpspWlYBYVIjw=;
 b=JVSLU3alYhzsikDUFQmosyJy//Z7mbVw/qJDEV+oYrHRdTM47CTJq8SCsMLkLNzquf+H7/t9QXcHCwRJKgWPv22ucRUqdJ8OuTvETF4db4pXBlHNba+sXeMWtL5XLcmhlZq4nRcmS56ONL+aO64O4eknXMkUIk6btHHhJ3EoMzE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4327.namprd10.prod.outlook.com (2603:10b6:610:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 18:45:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 18:45:40 +0000
Date: Tue, 19 Nov 2024 18:45:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.12.y v2] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Message-ID: <4a661500-91a2-4d4c-a454-586898dfd6d1@lucifer.local>
References: <20241119175945.2600945-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119175945.2600945-1-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LNXP265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::33) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: c96649f0-ef59-407a-26ce-08dd08ca5d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nh07LLCBI+wpZs2ATipsBsC17FLCL1ivjWcdEqmoTVT/PVyr3YcUYbCmKBOd?=
 =?us-ascii?Q?791B4Xs8s1l3wgntYK9oys1MFNclSMp2KljKDnFRVPNBhMhB9I7InoHJn/jb?=
 =?us-ascii?Q?zRW+zgTwQfMggWgKaqgqOubkG/IyWO/8C5avR2xnbti+XFGBVPVBYk75ndg7?=
 =?us-ascii?Q?9435qp+ytqMYm4aYrkzN+TscJvIgLBDA1ioacgqDLT5TxsETJ/iLti7LaUBu?=
 =?us-ascii?Q?gPBCLmHXdFSks+obxZRmZx/jKGeQH/QQG5EIkaesBPOLySaA8rmEWENQN8l/?=
 =?us-ascii?Q?Te1pFDoCkNzYBWsRl/EBxHA0AQwJlk1Ub4Qbl+jTctwMbVsY2aTlG+N6Zc9n?=
 =?us-ascii?Q?l+pdapmNcLXKGbih6qPUZqJbGKtATCjpVG5fuTJzHaAvcBDTGUEYfYyqyPFd?=
 =?us-ascii?Q?9/zpyyrYon2cZnT113HKyNubft+gzyzZceLgMOjQZifDnMpo6S0KHT1bI6cN?=
 =?us-ascii?Q?N+BnaPNt1VCggfcX+frKo8nvyS8Hg2ru2kBewyLHaHaXQuO7I8/pKHSX2iSc?=
 =?us-ascii?Q?T3dir4cHmiWyIkigKcEjdzKMTBvPrzZThqflx9elx0gAhiW8Z/SQpqiTF8nx?=
 =?us-ascii?Q?ClpuA3K9PK7jd+6Nmu9z+1rA0cDrRet7f3JvLQ+3c1PbOaS6UcAJz58aAd60?=
 =?us-ascii?Q?0V33w9v0oKkVmdLlxLNYg7uVp31WZBbpLpEkoc7RJ/NqRSvxGibG61764fbZ?=
 =?us-ascii?Q?9HPOd9uo7sQpOPZDRx/AaSXwx12e9P5hZqS7UR5MiEN7VP1TMwPOdfeNX0bz?=
 =?us-ascii?Q?SbRN9CAu6gSgf0jTiCDSTMS5HJcD14lVcJGV8fjuj5IIp/Uc98nImb+LS39o?=
 =?us-ascii?Q?v4FgmkeTdW5iSKQOniCRmNyiev6gjE1cgEwbvacOC3SJy/Gb1nyttgDHDd5K?=
 =?us-ascii?Q?Sd3QA76xoMt0M56M7eQ1MyCpQWoCJJ4zngqDlILcyWS/GqN5yC+ZIRUMCc0p?=
 =?us-ascii?Q?UO85lDAJi49CurZOCXobyWK9VU7gGDkapTa+6eXDEgrcCVa47TGn9mVEAN2p?=
 =?us-ascii?Q?g/K2d2lfPZldNPau60cCSxO7uTGJxXpgOWSgcD2K9MF7bbPP0wRO4zmDfApn?=
 =?us-ascii?Q?lU2kEfZz87fXNi1hGnsMhhN464pfEZ1Yw8j2p+9Hg9BQPnFjuqIzdt6JvMu8?=
 =?us-ascii?Q?iMzLhTH9hBJufQarfH8MMidiULod8oYgL/rsyUYTV8gf1TVR3TGnro0GImgW?=
 =?us-ascii?Q?9QKjmGVn5Kif6J3gADyPrwZVPYLYKKFrxq6sFFkEdejtptfX8ZViLAO2z16Y?=
 =?us-ascii?Q?RDwXOGNiQBfQBn0hXDjA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4Wez3ft/isH9eW1D30xR+S7C0UG0dU1zpF7vMrxZjq7tV7RHKpvL1rEPDnh?=
 =?us-ascii?Q?uQef5YQoI3X96XxPdeHntH2xjH3FvZAM65QGhiHKrv36mWwYs4YAc/nj5LIs?=
 =?us-ascii?Q?YjlEg4M4RV9zYloH/BteUy95KLp/XlK2H7XR6QvyZrBvoxeNaHN0Sw5dwDH7?=
 =?us-ascii?Q?sHr6hF90wOn784IF3/7YYqoDRyVACNmg1XMNssu97/Fc8WUAg7++m2x34RSF?=
 =?us-ascii?Q?TJ9w509xWn/bkMuA1sKmCxTFfO2aFqGP8TjvLc9nHsETdLsqTQ4ZMuk48SZA?=
 =?us-ascii?Q?BgjoTQwgbO4QfF5yXgha05UvsUjhWWHVUiNx8PKu0ZO87kWVER3dPfBAB3tm?=
 =?us-ascii?Q?0gBuHLHqhMZUeTC+M4UXM6crtNTXzqlC3xgmVwnZriMAauH48imvgXgUUOFk?=
 =?us-ascii?Q?scstZDVW+dtlbo9JAze7//EOLS8CmQzo9wKJnnxJv2MEHALScDrZLrLfSqgS?=
 =?us-ascii?Q?V41WC35Su5CXpOBpgDR1yBC7fh73PqaeVZkd07KcmKsDK0U30lQMelUu+lLi?=
 =?us-ascii?Q?LLsBnIP8Bn62Kieb3/hThf3BsC5vadnUW4OOrViwE5KLLD381Dhy6/zn8Ceo?=
 =?us-ascii?Q?rBajHH01gvBzzJd5MbwTSVdh0gsLzadTsJsP8kvU3rYGTKr4s78vUBXbPRWb?=
 =?us-ascii?Q?NEjCLcuLQ0mGf+S2F8P+KO0ixywlC8kfnws523oflbRO3GMctqaMeqJqm0jW?=
 =?us-ascii?Q?hD7k7dgb9U6MAM8XGScELTOFNSEQpxavgxlLHP+/FC90rD+ptbk6pypTFnTE?=
 =?us-ascii?Q?8GsXyshDgdDHH+74WjOxeoyzhqUT4dNILiO75F175IKzxD0bSAuRB8DjeXW5?=
 =?us-ascii?Q?SOt1LTIg5+xLcLLub0oIWNlu9TJCrbTDx1KkCSTZmLaV1gO6KRtIftJ7PX/8?=
 =?us-ascii?Q?txkSL/c/6Ba0c3XW4jzy4Z4LB1IGg6IzRraDg4Jpeg+UB0Kytuvb3iwaFhEB?=
 =?us-ascii?Q?pPepgnazdBWEx+Y7I2eu5nMd8HVWz5wyUmlIXoHeiMYMCAL6e6B3+2kSuq7a?=
 =?us-ascii?Q?A2QtudLy4Mdesk7LGi8ylzwuoCQpS0/Dq+JwLuVcUEYRt7sbL+0IXx7Ksh7U?=
 =?us-ascii?Q?hrlTLhfiE1fBG9c0dFCETsBJZN9Y+6TaUOQITx53+4PwyCtpX3BPxQVUCX78?=
 =?us-ascii?Q?nJCddY6g9GjIP5fm13b2STO3f7jUnSNLek+OqCb8lV1Wjlqs/CuHK6MPwKje?=
 =?us-ascii?Q?fXhuerAJHFCF8M9c/4SsSMvPybHSxgud19qkZ65r1bbq5l2FFy/JrEMj1FYE?=
 =?us-ascii?Q?lOkoBX4SAEl4xesEFRyncObuyPP66hY5jFdgCMwduSZMWbYx3Hd2D6lNEHTd?=
 =?us-ascii?Q?UTMigTPB+/W5FTZsEYqNxHE+s0RcQKhMrrkomwjAnP6UQv7CiB+hrnj9iNPj?=
 =?us-ascii?Q?I/zfrk9hn261DFYUNXCmy5ClY+0qcMoBfCIiZvYSPxzFTRbRU0xaUu4Ndq2k?=
 =?us-ascii?Q?F4tuuosddKsZonLWv1NIZCss19gNcJR7CZufq1+S9DU5/2wgaSSgqVo4gu5T?=
 =?us-ascii?Q?mdaw05edI3r2Okb1QSbNi7OF+SBJICDrHZqPnZSsmqjp07iE3Ts0MRccj6Sa?=
 =?us-ascii?Q?A4P8AlCwKWmV8pK5MnH1ZIEMIC/mJ76h3F9WrHRHYTP+htAPe0BLuxla5Jn3?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vc68phN3fgwR8IHKNJSUTVrj6xF+2x1lJNenRpB6BVT32EVef14tWLB+BMTIpcYuRkXBt5BDpw9gSLqouqbvcm7xlqmnt+uBwjVv+G1PW/IxzQdC4q38htQmiOboEaUF4k0l4I3SKpgb8Jxiqpl6RZ6S4gw7r2Y0RkItoTYmRtNp0+IGt+F2sSTekfWvSE8DMiWXRQbKtn+Hm934HChHh+50QX1E5PW/BB3L1UJIp6hGWk4wQIipDg386IPvNnYKR+3L8wsW2CiYnxA34Q8eP1e95Pq5jrDpz8m7QMsCtY7ULYzv97MvBwYbzU0bJGDK63C8KEwQEXD1zyl0stEiqiDDf83UX22TD54zh/7Xlqr1191U5tbgZZAkVBB4sr2UAhTwTWheUGzGFRFxSXz07XeWyG9K92Y0Irhzl0HgXmI81lPLyI9iABJTVnihCbA//oq9U+ndGKVJJ4OOYwD1dQAlxgueLvEwBMostU/P/panrgyr8m7r4qo5VQy4/D0M63raMRx158Tgmekp+x61Yl/bvzQwN6hikJVTC8TEJz/te1aJHcH4bueCNpZheySUpeIOukS4ZlwJb7Ukp+wPBNxJsPxvkUDDQ/qSEFd2zAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96649f0-ef59-407a-26ce-08dd08ca5d5a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 18:45:40.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqhye73T6dA+xLbNlymEWkhL0P5Bu+uWlrNMCAb00G/22nG53xxoC1G+IyaDXraYlike0uPQuYCPNJq+QSCoWSug9IACC+RLum4OqVJuW0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_10,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190139
X-Proofpoint-GUID: 3cHy15_oR42n322w-VvxT-8B68piBdAz
X-Proofpoint-ORIG-GUID: 3cHy15_oR42n322w-VvxT-8B68piBdAz

On Tue, Nov 19, 2024 at 12:59:45PM -0500, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The mmap_region() function tries to install a new vma, which requires a
> pre-allocation for the maple tree write due to the complex locking
> scenarios involved.
>
> Recent efforts to simplify the error recovery required the relocation of
> the preallocation of the maple tree nodes (via vma_iter_prealloc()
> calling mas_preallocate()) higher in the function.
>
> The relocation of the preallocation meant that, if there was a file
> associated with the vma and the driver call (mmap_file()) modified the
> vma flags, then a new merge of the new vma with existing vmas is
> attempted.
>
> During the attempt to merge the existing vma with the new vma, the vma
> iterator is used - the same iterator that would be used for the next
> write attempt to the tree.  In the event of needing a further allocation
> and if the new allocations fails, the vma iterator (and contained maple
> state) will cleaned up, including freeing all previous allocations and
> will be reset internally.
>
> Upon returning to the __mmap_region() function, the error is available
> in the vma_merge_struct and can be used to detect the -ENOMEM status.
>
> Hitting an -ENOMEM scenario after the driver callback leaves the system
> in a state that undoing the mapping is worse than continuing by dipping
> into the reserve.
>
> A preallocation should be performed in the case of an -ENOMEM and the
> allocations were lost during the failure scenario.  The __GFP_NOFAIL
> flag is used in the allocation to ensure the allocation succeeds after
> implicitly telling the driver that the mapping was happening.
>
> The range is already set in the vma_iter_store() call below, so it is
> not necessary and is dropped.
>
> Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> Fixes: 5de195060b2e2 ("mm: resolve faulty mmap_region() error path behaviour")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>

Looks good to me:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I mean ideally we'd not have to handle this scenario, but 6.13 resolves
this in a different way, and since this will never nearly happen (perhaps
actually never in reality), I think having an operation that will nearly
always be a no-op beats out alternative solutions.

> ---
>  mm/mmap.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> Changes since v1:
>  - Don't bail out and force the allocation when the merge failure is
>    -ENOMEM - Thanks Lorenzo
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79d541f1502b2..4f6e566d52faa 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1491,7 +1491,18 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  				vm_flags = vma->vm_flags;
>  				goto file_expanded;
>  			}
> -			vma_iter_config(&vmi, addr, end);
> +
> +			/*
> +			 * In the unlikely even that more memory was needed, but
> +			 * not available for the vma merge, the vma iterator
> +			 * will have no memory reserved for the write we told
> +			 * the driver was happening.  To keep up the ruse,
> +			 * ensure the allocation for the store succeeds.
> +			 */
> +			if (vmg_nomem(&vmg)) {
> +				mas_preallocate(&vmi.mas, vma,
> +						GFP_KERNEL|__GFP_NOFAIL);
> +			}
>  		}
>
>  		vm_flags = vma->vm_flags;
> --
> 2.43.0
>

