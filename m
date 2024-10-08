Return-Path: <stable+bounces-81584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A45A994767
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85743B23FD1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756C18DF65;
	Tue,  8 Oct 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bR0MQeft";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sp5sAs0w"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA13A1CD;
	Tue,  8 Oct 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387647; cv=fail; b=ZcUHkXoI5s74194dYsUk/i5vLgpYg8TAEwykzKE7IER5IP+PJ3/s1rbFQCmDukTmJF8/aBX3sGeIggPEv+RoW5cHfAaszQP97+iQni3XSAZykPUxMm2X0rWlDSJVSDk0INxf/m/RRXfBJM5zzpWj/tzZtltyTAQyrlxjo6+Bbng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387647; c=relaxed/simple;
	bh=TDkRyqJbmvzZ/8hXKKJbi+TynmD/Dg/S+fVaa53r5Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mYXZNASMpO7uw25w9zM8vQyGTwj9FcB25reXltjLDhC6AHLKTi2JLjoCa+tdRfSNlc4avMzedY3gfnZiqkW+YfB+XaIxPEAQC2tawOcrjk95xlrT6OMqfPN1NfYX8gmU9VNv899G0wvqe3zvc2eyfBM3UVrzgTDmmdMK68RvyZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bR0MQeft; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sp5sAs0w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498AtDjZ009602;
	Tue, 8 Oct 2024 11:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IPp1Atfbkwlk2sWuFB
	BU6fW9SXgedMRhHf4dcvIRgfY=; b=bR0MQeftfIS0mhdckzGoDn9YMuYNU0IXC/
	jZL+R0KhAeGUfPPG5VSS+tBRg548G6HxvYNRoJPPqBSk0mjuaMjjsCnUvJ8nFlj4
	bxCx2TvsyRxOaPoKKiGRRVaBrJfUr0RTZ9PnY31YWo62lQpuYEEqU2Ewb+1IVU8c
	Pb9wxPCx2nqeeOk63JQ+R+SNX7V1f5RuwVumBoy7yEHu2gV0sFUdWuvP0zm7Kwp+
	vphjHKh49Td6jBzOyDS3btf1tCdZ1yQtsZgc03Ov0f0+tSatWP+nm1/2zBCBp+K1
	lhMGuIOfJW6Tr1p/PqXcPn+qHfMMEh9whEmX1Q6ZU3MKAMUYjCPw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv5kfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 11:40:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4989UBwq012403;
	Tue, 8 Oct 2024 11:40:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw71f33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 11:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMsABJ+ZTtCbk1Mq4kh7RKT+Why7t8xH/dJeLNS2LMt0hCV4EqznAenayLYsdoc/E+ByVNFQqtAMG4J3HMifuOKWOBMpJIt3wElYDxiD2o5n64sCH+hn7cb3Cdp87dGha7LsuOOxWWq+rYq8kSeX4bGPcMGlbf3U9owr/t+NilWkcSB4uEiukmDDDTIOBKdTNbHIl63r9SDVRrRj5YetWc4y47IqqlupDi8VkU1uV3bXquCSH47Mdt/hUBqUTMQljyYC6ME/lYP3MMAZ07sVpNwwqnSBEjc3upxGkGAldJzPFKgKojg7IyYhLH1QyEJmSS9UMxTDii/YnYfAnRepZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPp1Atfbkwlk2sWuFBBU6fW9SXgedMRhHf4dcvIRgfY=;
 b=RErscjW4q+2l9UKr9NyNIDAIwwrOLI1IXDxW95GD7LPOj3lcM5HIa2H02drRN11Hg21OmXFJ87PsSZqEJGQJ8aDwYPL7KkOhn/IrBWzAzjPY3knVvmV4WqUZ80NUkdKVCCT55HtSkBOyDXdsKTX2gfbri6TLaMGL4sKwFiGzI9hZbH0QCFV5Z7vA9Zk8V422GeIhOPMMD4tvTOU5bHGQQmSZCeUTsHnS3PwpJZgm8lYep9TYnCNveKBV77/xvEMaRHxj0qEC68k0PshSZ28MqUbiGnM+7me+MUbyqqJuAhG8zneWo5QFboKs+pkLRfzdbB8bndJipxf80bCK6zawPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPp1Atfbkwlk2sWuFBBU6fW9SXgedMRhHf4dcvIRgfY=;
 b=sp5sAs0wh19YLnGfXXe/+xYZDC+e2dW6HmxKXonUak8+rhjoDjlde0rRA77LwCdqvgMArWUGJPaQDwG6265zsINS3GtOhbAMEi4pwqZJ3n34b/uP3+NfW5NlzfvyjKn5lux2ThX/aAl/Ko61C8BeP79UdXpoXvo1ZlCIyS9cODI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6868.namprd10.prod.outlook.com (2603:10b6:208:432::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 11:40:02 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 11:40:02 +0000
Date: Tue, 8 Oct 2024 12:39:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Helge Deller <deller@gmx.de>, Vlastimil Babka <vbabka@suse.cz>,
        Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>,
        Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against
 inaccessible VMAs
Message-ID: <1eda6e90-b8d1-4053-9757-8f59c3a6e7ee@lucifer.local>
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: b014bc7f-772a-4f6a-ea9d-08dce78df211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cHxcAA7sIyRLwhHgbM1uzwfpbGXvsNSg4OS5Bj+ZB08RzTSPh4xOf7W3LE7S?=
 =?us-ascii?Q?lpuuTRS0fbgM24zGse7eBJ9nTKlO4K6WNn0+22ZkfQHC20XNosVe3GG5SObU?=
 =?us-ascii?Q?uc16Ujk6hn5IQvUcH7YGOD7bS6hki9PJGcW/aeUglV87L6/pBI/pDAET6CCn?=
 =?us-ascii?Q?EiZmfPZAbiu6vxPpQwbYdTioxnbTG/R+7qmCiLLnoaY3sU1oA+P5EVa4EDdj?=
 =?us-ascii?Q?Z6jALXtnRV9+up5+HjDdLupndWDADLjVcU0qMcXM/jBHm4YZsKS3UBXh+aup?=
 =?us-ascii?Q?xSaZcNTDrRcFDMhe2PjyeSa7eNnZ4+yoAfwkxLkAK4jCA7c5xjYP8ARuRxbK?=
 =?us-ascii?Q?axiVav8AwQqcqs/GEAExa04/JOAJjBzrJJoz4gBjIY1ofJpmnGSoTVA+5k8u?=
 =?us-ascii?Q?9oi8wzkZgQJniGjzrq9jQZ6j8hVHwAhuv/68wS/8bcxYpPsJLZEtJTpHY2/T?=
 =?us-ascii?Q?IerKSQnuJf+Z+1sJ1wlsycb065vc96kIKuvBvNrSw5c2DnV2AOKmY3DSQJQW?=
 =?us-ascii?Q?BnwUeIPkfNrawld3NlsYtwzzcjc/kubRwI7tu/DO0RY8mnJsHmSDxXVFqDFj?=
 =?us-ascii?Q?cWWOsimZTD8CGork4swzWL/bKqvlsgoMbTaSuXwmr0CQEXwk7bfNsiN6y68r?=
 =?us-ascii?Q?u9XZK3ui+Q0CmmPLE4dXmDcR1ZH0AZK862EaOndvwBPAcCXC3Kxyqhzc2dt3?=
 =?us-ascii?Q?cnRmJOzbnaIHdBB12Lrt1BWVwGqSPQfNwzMsVGHKKZnUn59ALhC5/Du5rU7E?=
 =?us-ascii?Q?jb7q2ufnVoLDBkj7yu/1WTnO9nvV8xLBaitae25RWow//A0mW1DbxxUM56Tw?=
 =?us-ascii?Q?7JMsdiWWgAr0SyxPW3QUbbqcJ787gEcBk/W7LjyLLzxAcJ505vx6A2TgN7ji?=
 =?us-ascii?Q?VAY89be+75U/87PF64hQRPvAaHMdb8PjPdMO8tdeIZ0rIgBVEvqA0O460pBZ?=
 =?us-ascii?Q?VlZz6cyd1OTTCSCT2fIwixbybPJa+mTbjny5IF53VvFMndrO2tZLGI9oONy6?=
 =?us-ascii?Q?IlN4TlmF/dMoVYksT5pSqPzxP3465SKrycdB0lVsugQmx1PXXB6iDHFxdHdE?=
 =?us-ascii?Q?qES2Jn1lbM27zC9O56LGN8HzWd/5xMuJIx5GSWrFFMUU/brDjRD6LSi4f5l9?=
 =?us-ascii?Q?VTmNvDq0TQ0p+fSZW8cssIOd5rH9qIbXOYq+hqsH+VlKj9BTizYGuL/2kI5m?=
 =?us-ascii?Q?9/100wt2Ffc7gLcOBo5GmWa1rKhlnMxD+F4VmkWFIFvzTXK4otEv5icAg0yf?=
 =?us-ascii?Q?OC7IN9PrMqnLH1XfbCyFVZKxbWFNaEQ8R3rP6U4IFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imFD1215lJOwHr82Pt97KQO/aECBQRB+kb6Bx5aFz7DVmGItfpC36Yo7pxi0?=
 =?us-ascii?Q?GsFQgPlIAp4Ikud5F/YQySKlu4IcdcsFGqEulkzY8F24FzSlUR4nWiLFgF6R?=
 =?us-ascii?Q?czfVgnpxA4is2h1sFIwD982ChZjmmVC7Ps5VtPh81DrIAp00PQuHkPrT2WOt?=
 =?us-ascii?Q?7JKX1Y7RYQLcqfXnLzVEPpHNoPcb3PKizxcEFyjJEe4qufhn+9C4LJg3z+zA?=
 =?us-ascii?Q?EGXV+zO/GJTtP+pGdkS7d10ozMhNJea/gPl2QHFY0dVE3QQMX1IXmL9EpqPE?=
 =?us-ascii?Q?53v1fC4/M8lND2ncWP2hSqiXpGEFGusDjQQckW7D2SERjttESLU8KIKyofhu?=
 =?us-ascii?Q?dwljiawS/iyPAnX1V4ouDjULBc33y064Nn0Dvi2eKQk9YIqOPkgrjoVYHD2n?=
 =?us-ascii?Q?34h1nL6MyDvU3fMcEGgrAZw357NiM/Sv1lYDDYnzc1haG5TfX8x/635jGzqU?=
 =?us-ascii?Q?8z5WJ79fyBAG0zgktsfikRnxIYz+K4vpGuOYsEJUk1zKfmZ3Yidovo39Y1pI?=
 =?us-ascii?Q?zzchXIbkniNqCSeYXAzCJ1w0pI5Gxm1bBIaaqra61sKJFU4g9ry4eN6Vjd5w?=
 =?us-ascii?Q?n3IHR/ss3Abx1V7NEWUtZ+H1MVNUy108FscbMavRR3t3RXUlZL/qle4f/uKG?=
 =?us-ascii?Q?nocJx414QE1NRSnuTh7JMY0qK4BtSHvTzu9y13ELYixVjfdCTYi2HQBdFlEu?=
 =?us-ascii?Q?HAxZH1HnWMy1MnrichrpI0dlpVvil7repyvnwK+IBbtSOLONA0I3rFTzmMPJ?=
 =?us-ascii?Q?y6jxwCvql2jmnUbbtpk3kEQYln9wAV+/ig98X/xM0UFW6nh8G1poEycgMrGY?=
 =?us-ascii?Q?kiE0XF/M5dsk1dxDiEEKy45+pYjK5Mw5UNhpjH7Pnw33/CymVCWrUFshWe6n?=
 =?us-ascii?Q?YPWsKiRdDI7g6VRwyXk2ocwuIjWG/COA8JHmL/wnE5bdzNILZpy9Eme7m0xr?=
 =?us-ascii?Q?WTFUiIqSnrdG1vqJPlmKZh3TOmVYmi3+uFI5XPJCbO7GaBb+1CNwPnf/DJH3?=
 =?us-ascii?Q?EKEYpfxyuxuoRBDIn6ZQcK+P8JA0QTD2SMGomm6Eajz0yqTy2kJISiDG3J3C?=
 =?us-ascii?Q?sWRlZYDIzvvfkwd4nXCrhD2g3rsYQtjc1WvGeyFxdXKHcSgIQtcYNJEx5j2T?=
 =?us-ascii?Q?kU7ZsLudYunenPyqyVzk4Z9RObvjPQq58pH4NkUR0za8zRTb5P4lVZQ71D7s?=
 =?us-ascii?Q?NTD96dhJkB5Qp9Bqp4cuimhFKlmF8SGXpiap2OJsr9Zw0SsAf5atiQf5uGig?=
 =?us-ascii?Q?294nEaQVhrRlPQqzSXT7voJPsv6NPXukZ+K3eRCqgcupdtw4I8reES/x1+EW?=
 =?us-ascii?Q?3eDqTRlokzbsIVaeidOD7v0C1aJwZsTrTh1NaJ1ynuDGCnIalcAAqpDinCOj?=
 =?us-ascii?Q?0doJWuqDEPETF8aODTkVlMhv/uG+3ZwXlk0tTH1QohNTZBynholMCynsP8CJ?=
 =?us-ascii?Q?S0MjS2U4bKUmPOzV2LjLSp8KK8Tt31lnhejlxg9OrUx94JNnXLqwtxe4XiLH?=
 =?us-ascii?Q?TWwZHxhABkrqTFDHXiYcTvNUtriR1JmqY1ffjdHIjrb22Y2Iw4hRzbd42eqr?=
 =?us-ascii?Q?LFLD1JB1+JBylnwFc7z5XPQznEjj9tjRa+uVELqvvdiVAO9m2/INurNxreDt?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8D8RtRCNlWb2TY3oAOAOSDygU3kkkW0mwNMk+1WGUUAdzSgUc0DAZuBOe7KC0fBp31daX7smj2nV/KfIWUFE0IVVUyaR8zD149fHxZ17VJGUEgeCk+Wyam3TV9b64RsB1VMc3vDTmDsjNLvhuE58UDmIC48YiqO5EmvsSvCcMJdoUyEhft6ZPmSYnyEUlKHMI53R0u/iMg0UAcKTIIJ7CQY8xwkbaapPx6HO4MZNpNJrkKRy1/oap/veEwD3B+5h3YLlmS00kpZCAV9Y2Edf4+FcRtDALnBVEl7OzSIonmZhuI6O1+NoinA/kilngTOu4iSJ0mbydyBXU5jhsrifErrjQQ32ZJCS0Y+u+xHJC1F7EDknIDHZi166cie2+qEf+sR7dUqS5dqM03KnoOxPivNSGNIbiDQxPrjbcNQdI2hvk3hqUzgD0PwIkJLkJKPi3lQK+TM16+05PuOGTYsM+DimjcaZDy4j0jgbW1SkkzOtjxWBixjGoXTGWuYqGYTPRz7/2YBvC101Uep2LK4bgmyGYkMFD9OrcyPdOplqP5bfVgf9S4J7PDnx6VIXGXwUmafHbqmKWr9+kbAkGmVoV35xxKFJhNeYG1WnPm8pgAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b014bc7f-772a-4f6a-ea9d-08dce78df211
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 11:40:02.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPNDL6Y5LT27355ybFxvkunR/XpwSIhq2TVE2Odntsic+ntbRod8DOT14QkcONooSOAptWWxBBejm8gMonEHbi7gY+p7mFUTX8dopFZ+KvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_10,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080073
X-Proofpoint-GUID: -iHjz3A-yVToOvOR2dNAQPEkYoC8_8jV
X-Proofpoint-ORIG-GUID: -iHjz3A-yVToOvOR2dNAQPEkYoC8_8jV

This is touching mm/mmap.c, please ensure to cc- the reviewers (me and
Liam, I have cc'd Liam here) as listed in MAINTAINERS when submitting
patches for this file.

Also this seems like a really speculative 'please discuss' change so should
be an RFC imo.

On Tue, Oct 08, 2024 at 12:55:39AM +0200, Jann Horn wrote:
> As explained in the comment block this change adds, we can't tell what
> userspace's intent is when the stack grows towards an inaccessible VMA.
>
> I have a (highly contrived) C testcase for 32-bit x86 userspace with glibc
> that mixes malloc(), pthread creation, and recursion in just the right way
> such that the main stack overflows into malloc() arena memory.
> (Let me know if you want me to share that.)

You are claiming a fixes from 2017 and cc'ing stable on a non-RFC so
yeah... we're going to need more than your word for it :) we will want to
be really sure this is a thing before we backport to basically every
stable kernel.

Surely this isn't that hard to demonstrate though? You mmap something
PROT_NONE just stack gap below the stack, then intentionally extend stack
to it, before mprotect()'ing the PROT_NONE region?

>
> I don't know of any specific scenario where this is actually exploitable,
> but it seems like it could be a security problem for sufficiently unlucky
> userspace.
>
> I believe we should ensure that, as long as code is compiled with something
> like -fstack-check, a stack overflow in it can never cause the main stack
> to overflow into adjacent heap memory.
>
> My fix effectively reverts the behavior for !vma_is_accessible() VMAs to
> the behavior before commit 1be7107fbe18 ("mm: larger stack guard gap,
> between vmas"), so I think it should be a fairly safe change even in
> case A.
>
> Fixes: 561b5e0709e4 ("mm/mmap.c: do not blow on PROT_NONE MAP_FIXED holes in the stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I have tested that Libreoffice still launches after this change, though
> I don't know if that means anything.
>
> Note that I haven't tested the growsup code.
> ---
>  mm/mmap.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..971bfd6c1cea 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1064,10 +1064,12 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  		gap_addr = TASK_SIZE;
>
>  	next = find_vma_intersection(mm, vma->vm_end, gap_addr);
> -	if (next && vma_is_accessible(next)) {
> -		if (!(next->vm_flags & VM_GROWSUP))
> +	if (next && !(next->vm_flags & VM_GROWSUP)) {
> +		/* see comments in expand_downwards() */
> +		if (vma_is_accessible(prev))
> +			return -ENOMEM;
> +		if (address == next->vm_start)
>  			return -ENOMEM;
> -		/* Check that both stack segments have the same anon_vma? */

I hate that we even maintain this for one single arch I believe at this point?

>  	}
>
>  	if (next)
> @@ -1155,10 +1157,47 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  	/* Enforce stack_guard_gap */
>  	prev = vma_prev(&vmi);
>  	/* Check that both stack segments have the same anon_vma? */
> -	if (prev) {
> -		if (!(prev->vm_flags & VM_GROWSDOWN) &&
> -		    vma_is_accessible(prev) &&
> -		    (address - prev->vm_end < stack_guard_gap))
> +	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
> +	    (address - prev->vm_end < stack_guard_gap)) {
> +		/*
> +		 * If the previous VMA is accessible, this is the normal case
> +		 * where the main stack is growing down towards some unrelated
> +		 * VMA. Enforce the full stack guard gap.
> +		 */
> +		if (vma_is_accessible(prev))
> +			return -ENOMEM;
> +
> +		/*
> +		 * If the previous VMA is not accessible, we have a problem:
> +		 * We can't tell what userspace's intent is.
> +		 *
> +		 * Case A:
> +		 * Maybe userspace wants to use the previous VMA as a
> +		 * "guard region" at the bottom of the main stack, in which case
> +		 * userspace wants us to grow the stack until it is adjacent to
> +		 * the guard region. Apparently some Java runtime environments
> +		 * and Rust do that?
> +		 * That is kind of ugly, and in that case userspace really ought
> +		 * to ensure that the stack is fully expanded immediately, but
> +		 * we have to handle this case.

Yeah we can't break userspace on this, no doubt somebody is relying on this
_somewhere_.

That said, I wish we disallowed this altogether regardless of accessibility.

> +		 *
> +		 * Case B:
> +		 * But maybe the previous VMA is entirely unrelated to the stack
> +		 * and is only *temporarily* PROT_NONE. For example, glibc
> +		 * malloc arenas create a big PROT_NONE region and then
> +		 * progressively mark parts of it as writable.
> +		 * In that case, we must not let the stack become adjacent to
> +		 * the previous VMA. Otherwise, after the region later becomes
> +		 * writable, a stack overflow will cause the stack to grow into
> +		 * the previous VMA, and we won't have any stack gap to protect
> +		 * against this.

Should be careful with terminology here, an mprotect() will not allow a
merge so by 'grow into' you mean that a stack VMA could become immediately
adjacent to a non-stack VMA prior to it which was later made writable.

Perhaps I am being pedantic...

> +		 *
> +		 * As an ugly tradeoff, enforce a single-page gap.
> +		 * A single page will hopefully be small enough to not be
> +		 * noticed in case A, while providing the same level of
> +		 * protection in case B that normal userspace threads get.
> +		 */
> +		if (address == prev->vm_end)
>  			return -ENOMEM;

Ugh, yuck. Not a fan of this at all. Feels like a dreadful hack.

You do raise an important point here, but it strikes me that we should be
doing this check in the mprotect()/mmap() MAP_FIXED scenarios where it
shouldn't be too costly to check against the next VMA (which we will be
obtaining anyway for merge checks)?

That way we don't need a hack like this, and can just disallow the
operation. That'd probably be as liable to break the program as an -ENOMEM
on a stack expansion would...

>  	}
>
>
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241008-stack-gap-inaccessible-c7319f7d4b1b
> --
> Jann Horn <jannh@google.com>
>

