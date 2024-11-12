Return-Path: <stable+bounces-92225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D772A9C5242
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F4FB29BF5
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16220E30F;
	Tue, 12 Nov 2024 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cRs//R0J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mzCQe1rl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEF1ABEC2;
	Tue, 12 Nov 2024 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404269; cv=fail; b=RgOjAngsc/Lz70GG9P74SqhLKG/iLKsIxdmeL0b9OvxEDoSqneTDUaZNIZSrFVzopCXJye/JHEcQWFRT/qVHwF/ne3dFr7kdwZFJELow3DBJDlL6uB9KtXZEC5NWL3Bz3FeKamXJajKMSBiI5NdamysSkN4x9vvPBLvmQp2U1uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404269; c=relaxed/simple;
	bh=gYtUHECqT6+JPwEnL673A4L0lphn+aEs3SCa5Jncf3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFJ6iDJWvXJEANan8DvKXBiOmJ2NLL08WTlnQW3IeVbf24iV9Dvm/+FdFyiMf6+NiAthCJgcdEnACJjqD8fBehZJ+lGfRL1OUoRMBDEvCp4yP/lSTWVy64EzIwZ0F3Mgdlt5jDplXzjEU+ftI671ntxSuuUuY1A9RNJSl9VUcfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cRs//R0J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mzCQe1rl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC8fWBf008781;
	Tue, 12 Nov 2024 09:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OMCFS7BQn1m1W4fbZn
	x9MHqOHFjhVdBspZ84P7bc3V0=; b=cRs//R0Jtz3rr9fhYTalYjWQny5OUpfVty
	6+z+/DZKJ3pnr/mB/WhGUwfrqV9efhR+D+37S42x15G5h7TD0vAXpwmKJdYU1gjb
	EoAHC6mvwpKH2X/fYv7F5KWS1Yxwr9X1811lDEKVPuU+3WboEm0xDQN667LnMj6+
	s+gSDyyP21jJwYTejGPeFB2Fa1rGRAqZYvArXX4Jz6c7E2eEKXQUQ34G2rDLDhDc
	7wHscJEMTA0Knao+fluJvOHeHvgN/fS4t6da6KPLJpW4u2qzfICXTx1pmeRA3C5X
	AwGbGNQ847r27TnriP71usSnmHX0NcYYltO/ukYFDh6t0bCiJcMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hekx0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 09:37:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC9bXXi022298;
	Tue, 12 Nov 2024 09:37:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx67x47f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 09:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC1FGw0br06G4ZhVs4TE17pLnBLNKprfL+LBI66+nWtPZvqUvMmM1jRXGzxM6KMb+FSfYDKb1u3KkW+lbgXPcfjWY1G0Fz0IMSfeV8XT+Nu9oeVKQ9iACPCWJtxveBbWdhC6012K8MorMtjHRNsTtW6p7B3Y/8tJjVZx/7eCGBVrFE2eXpD0qITQBw3dV5CB3HhQNJD1EPgFWWlk5bBLe7KMp1fl6kPi67mPmHdkviXT/lbnIU5pgu0edCBATrK4X/ICM0Q2NuFu4aUnc7ysjG+8Va7NgemXPNUjlrFKfuyN9M0YkSsOP3Jm7qdFrytEIruC26CY1TMFaM8EJpLLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMCFS7BQn1m1W4fbZnx9MHqOHFjhVdBspZ84P7bc3V0=;
 b=G8qhqehA3+tJl+/83TgLimR3fThE8dhU30Zk1J2ZRHvipwBkicUqaB8daNwTS3HcF3IovgWM+FGgOsK49rbY5rZaveTBSmK+ihSglKR9YnkZEfnuInK2L1biiTfML6IWwKBQt4U6uAnoR+L+GSLMR7dwEBh32tCvc6pMZuuklRWTvaqJ6w/i1FKdiTorxDbfHImxj8qI4KCcKOek4MspSJ3DDASzM4Jom5o0fWU4el4ribbX3iVC+a4MTBzQdMOGRygH1aTfEQecvq9cc/1AAHTyNoAVxWHEVQnbnaA1qJfX8jLnEIeRsrY1siHhu7u5zVTvdimZ7fPIPz1qIq970g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMCFS7BQn1m1W4fbZnx9MHqOHFjhVdBspZ84P7bc3V0=;
 b=mzCQe1rlvDTiNM0DNKzwb1DXUmdO9ry5ViyDv8Z6q+ONtrGteBsa9gJtGmIN4OZkyej2fc0A5VQzeBJPvSqozrvor1xySQbTIzfB2762TFHPWuIZH+2RKo3LI0XJFeCosAOyUbhjjYnFE5YFOb0cP/ZNVS/kZufXkeOg6tuJZuk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5745.namprd10.prod.outlook.com (2603:10b6:510:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:37:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:37:07 +0000
Date: Tue, 12 Nov 2024 09:36:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: Fix address wraparound in move_page_tables()
Message-ID: <413eb1e6-6904-499e-aedb-8979e4373b0d@lucifer.local>
References: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
X-ClientProxiedBy: LO2P265CA0506.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 690797df-b5f6-4969-a625-08dd02fd92b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRK9zwpNo2i+TKyHDp2LlAGO6DGTUkvhDQJV/qTqoQ+F1U4GsMUwRAVufUMd?=
 =?us-ascii?Q?n2XL8ABgQHkXbzgFIFbhHOgKfGAVWjcIuncxVvacM/1Qlnd+Av2K35Zbpkas?=
 =?us-ascii?Q?AoVtz+nNcteDpE9EHKEzlQD/UfgRPYwoHERItUIPDpXRbLSCJKBHynzsEi2A?=
 =?us-ascii?Q?uDDUblGaBj0cX29Nw1QLAF7SdwxvFK93ouM3KDFoEXTEhni7B1t0U/8cJAbe?=
 =?us-ascii?Q?VKMMCskc/BV9RTVhVbeij7UTbDLnnHe2X2TezOqYj5hLNfsaO3QGHDpgle5N?=
 =?us-ascii?Q?nOyQ4YmO8VhwWF0+RqzDf+sK2vQ79Xn16WXIQRCHZoDaPk3TuQsuFzvrXoBc?=
 =?us-ascii?Q?hIUW0u+FckNZDX/ksmAYJ84U/pztfLQhuvviq29XVRe9cQ+r2TEesgJPYoJM?=
 =?us-ascii?Q?wRAB4eESYwi33zA1g8ClBYpwuzakrjgInjjoukW4GmfAFxkzfWZa949zmHoO?=
 =?us-ascii?Q?INyKRueiL0bsuAwsGIsYKgQeKYUgvu8y2v3D8A0wQv9xde94xzgzuPrzjj2i?=
 =?us-ascii?Q?Alygkrkir2SqYIieQEDVFCpfa0ezPPQoON3crR7Jh3HIkNjXNsdmO8SzCt3/?=
 =?us-ascii?Q?SBZuNXT4xCl4NztcYJb7P5bDdF7kVyky1jKH8okINZ9YyAal32tRWfM/0zZT?=
 =?us-ascii?Q?C9tjHgrjO2aXKvCS2ms7R7mvNOzUWQ8MMW6HNsuoCdn4UCBM5JSTF0LxR9Nu?=
 =?us-ascii?Q?61OooqSOxq+IJrFDjLfmQd3venfuRQRELsbcTzB70b0d71A9eJ36yFt4nkpP?=
 =?us-ascii?Q?5GpWDX45LtDJXJUx7lpCN88mTVBH+yuoYfcXH4hhv4FVxgQ0NbeWuJPUigFO?=
 =?us-ascii?Q?6MNIDhkW/S91fAPcrknOVT1TPmYFj2lORChq1DInsJbf4CpdXAebc8l5YwQz?=
 =?us-ascii?Q?DGGlRXiz/3W/KZHYnk4ObvNiEesdsbssEhUGvdtRyW2kgwuqsxR0PvHQIvW5?=
 =?us-ascii?Q?CCHqExOCVKz40sMHXTZ1wVUKEQz0dqUz/q+GR8JBDoxssPJnv11PLOp8+uLY?=
 =?us-ascii?Q?2jnLDwoXwZA0IHY//UERHsq3gD657fs+UUiLRhSZX/HIm4DiK2180oY5LWuJ?=
 =?us-ascii?Q?yzn/bY2K/oou8Fc8+FBnsX1BXLEKpK85aNMI36oT+Y4YbPaxmt2Gxy6enl73?=
 =?us-ascii?Q?Td2DxjjIH2i0nx6mV55sxcBEFa9C0aVoLDZrXOZ/zUPF0C7vuoqVp+e9mqlY?=
 =?us-ascii?Q?AJFX9NNHkn9ZRfA2y+C/h/dKCeUMoSiLRlIbBaw6Z/0n1Lo2XdSaDvYj3Xrw?=
 =?us-ascii?Q?64Og37NScC5PKY4vcTas7wTnoRGQSao/BmyKlEW7r/ZsTl1UDFlgggBz1QYC?=
 =?us-ascii?Q?772uFrZdAj/0AU3UixMs4fN5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ne2OM0/phv3dmqOoSrEEoErEm0b8/hjQ9dvXOBcnScwAO6lvOYqWuccSXJr/?=
 =?us-ascii?Q?NCEhN+F3fIZ5QM+58F/42glZexcUYjuq/phnKenmR/HA1tG6AOdJU//aVdtU?=
 =?us-ascii?Q?1r4xf5f4dwa2KGkCD/ezQGkyhKYwBRxA0WDskXjq/fSqXO5fWpb8HgAPmBr9?=
 =?us-ascii?Q?x3DeZweMvomrGEluPm8xW5oL7heI+PEKyVpoQ53rFy1fIG5C7u/lDpNyM1ym?=
 =?us-ascii?Q?OoFVUMzXsQfWbEi8unqC62GI8SRsThFefK0vOwP5qqGS/Ik5eWXVZD9ck/t+?=
 =?us-ascii?Q?Hu3pYGrphXcOzOv+Lh89l3acHz3fjU08Ey3HPzDjuVIn839PmbOCSAe8Orzn?=
 =?us-ascii?Q?aoxHPonLZj4iC0HepLx+9XTo4qF+THHNLBLQLAWfbPymElnlUQ5g2bl07ri+?=
 =?us-ascii?Q?YARcGmYabi+JSAAO8L05hmatmpYn/8tv7DgX12TrIAFPGe/pLQPJvKsnMO/f?=
 =?us-ascii?Q?R/82yTIG6fmA6jBZO/30kD1OfKQqXwO2bxGeQEMP0gsUmxy9UNFV1u+v4vDa?=
 =?us-ascii?Q?+xio523/3PA3EHZZ9cpWjKJHCTDy7eF9CBa6mcfPszUL2pdMpyUG3e+/bfQi?=
 =?us-ascii?Q?Zkot/PjSh1Xt74y32G+IN0dIXIcnaSgYTJbyKPRbVN0rToQMxb3ZucK5j7hV?=
 =?us-ascii?Q?3lz/b2FRt6Rr5OKmWwCjz1uTV0P8aW7USfXNXuUjvtNOEv8Rg4Qa9tFx6AHX?=
 =?us-ascii?Q?FnRTZgSt+CdqcrhqxTTB4Oa1riigc0ULYCb7omHvsZ88pSuKOf4rl3Jp5+bh?=
 =?us-ascii?Q?bpDGVN9nkYhlblkUg55w8zoqKMfRcDnxQK9vuYWPn9LDWs/zTHIUoUAdISVW?=
 =?us-ascii?Q?8PfI7r76fvhUG2/M/bpnepinPNjtU1vRe9vUeU3dzK2zyOrZcdN7aWFwky02?=
 =?us-ascii?Q?TDUTpYzTfAoD1X67Rs9qCivq6/McY16C9L8QbIyRcSbZN/jwsBBZt39OLR/S?=
 =?us-ascii?Q?0ICHl5t97JFVUwXQFubslMqL7xuESOPFtNbfSCqJUPfX4+eUUg43nUjHLxlq?=
 =?us-ascii?Q?GInoTJFIUxADxWECCQ3Ppqbzs4WoREdutR7QMK8d+ZVKhuNjEcvl00izLSX4?=
 =?us-ascii?Q?5BAMmlA4glK2roXR5uEwX0tDXw1Bf2RRMVZFOqLhi4cdQqR99slXFTWhBS/t?=
 =?us-ascii?Q?vGRjRsWVCoaXkKVLRXLiD0bkRp+gtXk9PL4b3pEToKS8/iiaIevYhnMDE+f4?=
 =?us-ascii?Q?MFB1WFd7MzCuuHr1aoLerjtklDK1JfVGW8PKtb1K4+0MOy4OfZQUDxgHX864?=
 =?us-ascii?Q?6eIwoO7kCwl3kaOtJR/dENygo2KN8IUzAubHaUuXp+iwOvjlA8SplCbLyw9Z?=
 =?us-ascii?Q?kCJ4uKDQGjC43SvDiXD2A2rXSv4PXJynQX0KKv8acNMPeI+fJV92Bgjrmf86?=
 =?us-ascii?Q?cOGENDZaNVgA+sQnseb1z2TlRJ1FK1wkNV+cHYE3arNx/CYxQLy/GYMkjaD9?=
 =?us-ascii?Q?igvtgyRrwbjxk3eRRhBnsJDpxooBppVNKyPd6MtyMWsKYYiUzGIhjjFsLuoG?=
 =?us-ascii?Q?gVSHh84nAs17lpdRD+cMU9GVNzC4d4SVzG0yDnPkdM9oBSKcshqfr0utE77P?=
 =?us-ascii?Q?4CLOj/plji8FCGnl2mfpYA3/qqm8tZZjPLlZ7JTpF2EYHlukT4lNuD+M1tDu?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7c9szez2gZ4x3CNJulVshxtVPEcbDnJtuaZoLDwtACAsKcMqOEQVVsUXZ45c3R6Y36Bdf0vMpmuTr1MbOrOACvW7ZJLn8QY1IofY/dfFyLrkz0twDSr492VKjs9Ptt7YCSWsq2Eqiq9V+t8G8/eK4r33ByP6LxdklbPQEaIylJpSc7a0oRfEKlg53QTFzx+qcpD0U5PK+Z80R4A7OcdLj+NKHP+9WWtge0H2mw1OTW16yY6RhtiOLESkjmkMZyEYzCLAYsOkIVpFP9jLZhG8khfariGOVWvRKmSAWnL4Uj6OVJyOMkYchFvvrneZaTpu7hr9hbaK8B0iRB/V04lXQyqnxc+JW5u2Ht0ZDM6o5+AMmHCgzWGCa9V4O8wXke2K5iqYj2ZOC1jw3wrrseRQreaG8aPHsJQCGvpGV4ZEY47bj7n/ovci6WbUagDoSgRgYojcv/5KkuZmFAZ2Jo1PBGGLm0Mc1brTRxrCdDVHEjLO6PrIG+tAe594RCYKsRerFWz3aAb7udoQpLq4zF6Db8iYtTHkOzr2ctpmPTKCZyHbeGyKUbD6VwMx1FkwyCdwF+mY/FvfOymIpvUAyvkJE4kYy6SAs5NqAeCLibRDRHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690797df-b5f6-4969-a625-08dd02fd92b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:37:07.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKynivKn0VFcttsht7OuPe6fuw1go2fwBRQHAI4IMcSEf1Wdzr18Ck4isXT0xo5QpYasbpJyGOF7fxwPvCpj1c9JYGg9HQW6nunigoLPedw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120078
X-Proofpoint-ORIG-GUID: 4JjhZdPVWrD1h_9jHVTV_g4QLv_WvYjg
X-Proofpoint-GUID: 4JjhZdPVWrD1h_9jHVTV_g4QLv_WvYjg

On Mon, Nov 11, 2024 at 08:34:30PM +0100, Jann Horn wrote:
> On 32-bit platforms, it is possible for the expression
> `len + old_addr < old_end` to be false-positive if `len + old_addr` wraps
> around. `old_addr` is the cursor in the old range up to which page table
> entries have been moved; so if the operation succeeded, `old_addr` is the
> *end* of the old region, and adding `len` to it can wrap.
>
> The overflow causes mremap() to mistakenly believe that PTEs have been
> copied; the consequence is that mremap() bails out, but doesn't move the
> PTEs back before the new VMA is unmapped, causing anonymous pages in the
> region to be lost. So basically if userspace tries to mremap() a
> private-anon region and hits this bug, mremap() will return an error and
> the private-anon region's contents appear to have been zeroed.
>
> The idea of this check is that `old_end - len` is the original start
> address, and writing the check that way also makes it easier to read; so
> fix the check by rearranging the comparison accordingly.
>
> (An alternate fix would be to refactor this function by introducing an
> "orig_old_start" variable or such.)
>
> Cc: stable@vger.kernel.org
> Fixes: af8ca1c14906 ("mm/mremap: optimize the start addresses in move_page_tables()")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I would prefer the orig_old_start approach (maybe a different name :P) but
for the purpose of backporting and getting this fixed this is fine.

I also thought about using linux/overflow.h which has some nice helpers for
this kind of thing, but decided it didn't make sense since we have no
reason to risk overflow here.

I kind of hate this whole thing... but that can be part of a bigger mremap
refactoring when we bring the implementation into mm/vma.c... ;)

Thanks!

> ---
> Tested in a VM with a 32-bit X86 kernel; without the patch:
>
> ```
> user@horn:~/big_mremap$ cat test.c
> #define _GNU_SOURCE
> #include <stdlib.h>
> #include <stdio.h>
> #include <err.h>
> #include <sys/mman.h>
>
> #define ADDR1 ((void*)0x60000000)
> #define ADDR2 ((void*)0x10000000)
> #define SIZE          0x50000000uL
>
> int main(void) {
>   unsigned char *p1 = mmap(ADDR1, SIZE, PROT_READ|PROT_WRITE,
>       MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
>   if (p1 == MAP_FAILED)
>     err(1, "mmap 1");
>   unsigned char *p2 = mmap(ADDR2, SIZE, PROT_NONE,
>       MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
>   if (p2 == MAP_FAILED)
>     err(1, "mmap 2");
>   *p1 = 0x41;
>   printf("first char is 0x%02hhx\n", *p1);
>   unsigned char *p3 = mremap(p1, SIZE, SIZE,
>       MREMAP_MAYMOVE|MREMAP_FIXED, p2);
>   if (p3 == MAP_FAILED) {
>     printf("mremap() failed; first char is 0x%02hhx\n", *p1);
>   } else {
>     printf("mremap() succeeded; first char is 0x%02hhx\n", *p3);
>   }
> }
> user@horn:~/big_mremap$ gcc -static -o test test.c
> user@horn:~/big_mremap$ setarch -R ./test
> first char is 0x41
> mremap() failed; first char is 0x00
> ```
>
> With the patch:
>
> ```
> user@horn:~/big_mremap$ setarch -R ./test
> first char is 0x41
> mremap() succeeded; first char is 0x41
> ```
> ---
>  mm/mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index dda09e957a5d4c2546934b796e862e5e0213b311..dee98ff2bbd64439200dddac16c4bd054537c2ed 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -648,7 +648,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	 * Prevent negative return values when {old,new}_addr was realigned
>  	 * but we broke out of the above loop for the first PMD itself.
>  	 */
> -	if (len + old_addr < old_end)
> +	if (old_addr < old_end - len)
>  		return 0;
>
>  	return len + old_addr - old_end;	/* how much done */
>
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241111-fix-mremap-32bit-wrap-747105730f20
>
> --
> Jann Horn <jannh@google.com>
>

