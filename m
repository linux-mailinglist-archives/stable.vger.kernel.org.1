Return-Path: <stable+bounces-186310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA7BE8447
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E061AA3864
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6594339B5F;
	Fri, 17 Oct 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlIxjIW5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pOlGj8X8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA633CEBC
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699616; cv=fail; b=gDfc24fBc+O+sqipeV95mbx3Ok/OloA0AKCKhQ5nUkIzPUuKvOaNdB5zA8fCUYIN8vup9A2pkGr3jwvhJOf7lemtAMVePIkqnNB1MIxdY+B1Vo8aUUpuv6ATqYOyTYz/zn8zctbOLwgU3lx5z86HxgGrEH8HURPMQnrl+xlKXvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699616; c=relaxed/simple;
	bh=Jul0Sfu1Cdbn57tiq2TOsF8WUBWCOos82v25kPhRYXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QyYeRydyhNT3L69IcrV6DTIQa8C/vag+YoZDYWX3kguSfyCEzI3d5Z5hNpdx0NCfCE3h1b9C66yn1smxgBFufAtHmVCTdyezMEWDZkSmv+GbuOttoeVEYwvqFwNJirg69pAfCaqhvxS2alTHmelPHym1QXm2HEj216USUPdOWT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BlIxjIW5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pOlGj8X8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HAg79J029129;
	Fri, 17 Oct 2025 11:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Jul0Sfu1Cdbn57tiq2
	TOsF8WUBWCOos82v25kPhRYXQ=; b=BlIxjIW5rxOISHGQO/8Opneg/Gap31GLHY
	TYWvsyo64Dw7iHOszygZybynBkXfdMOshXLkAvnjZqJaXapGguc6RK4ln/6Wd8FY
	UwYFAhXHOQz/nyURNKO4OKjnKzt+kJ9MHR+jHIDYzZSN6FKm+mf/Ly+m7zzlV71L
	MJaFmsk1X70F6VSweIQAFIevtJGxT0BDTOQiuo/gXTyiq1IVvywe74z6twn4upg+
	K5JzQ0Z+tJc6j9suJsNWcusK34zFl3UFwEfsh9upcJp9z4DWaDWMnKLWX1Tm6iWl
	XE0eD9ufb/Y7Kmt35pBlFCyiRTn86roKNKihKhJNTW0Ov5v5N5hw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeut2n9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 11:13:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9ZDed013633;
	Fri, 17 Oct 2025 11:12:59 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcpfd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 11:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAbteFXsXSa4jrn/l4jYzeVSI1fYf2znrWf02y7BYJ6sk0N0j9WWT1nwfUFswoWw+2kv9lyTQO0knvHoZVxabkhOg31I3JZRZb271ywQqvUZrCZAcGWrz8n4IBH/LVKlQuPnzKaiGtjVwAb8uWOYVyb0Jd2wBMHS5rZZNYhdcuBul0lxrV/rdD83w3gZbGtUa1yPDVmuI9oxxwmgFKvwS3Chxi/UDwgZeUURNafds8SZgpIHjHv3tgXAo8ciH435Jb/ldPZgJGuy+wR8wSJgnYupKK8aBNG/4+Si28S+YM3XXpIGzS9vFey5TS2+zULpsmJltWZG3n889AUKkXfyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jul0Sfu1Cdbn57tiq2TOsF8WUBWCOos82v25kPhRYXQ=;
 b=v20eKwHQRGlkXPj6EIbNvIjKfWMaP+3NiH+i4lcLL1B7HI2agU1WOo8vubOtdChh67j2zT0qMrLX06Hnd4sqp9PqFcJm7OzIjx0rgqjBCzd3w3w4mEuuaygScFfxtxHSMwea5g8FwxkeoKe+TDBnG6ug7XtNdN4cardYgN3xp/F4SpDHhZEYGizJMF1l7twVlnu8/woo9FLEpDP0OvwAs+E5ce6cg/ceslqAkwAj4HIw9/7HBS4IOJp/vH8rg1n0lug2NrAWGBSJNB4cWseVpuLw7lj9+MmvjzXVfpU05hF211HNQncrEtqaJzJPNN1ZCrq9AeMczsRV8NY1Rqug0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jul0Sfu1Cdbn57tiq2TOsF8WUBWCOos82v25kPhRYXQ=;
 b=pOlGj8X8UoEslWpH4QKi48UpxBJAfgBwJs+bim6/jYW7NW+t0+TS61teh5n46MA7pzB32LYSAZiiCV5e1p9YFXgp/BtG/ggNUDIGGGRFMFam24uMxpIfu5l3Gg+gwxCD6ZZMZVkemKOoPT6bMUM1TkARn6AHuQxe0aK0tVb5S50=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4330.namprd10.prod.outlook.com (2603:10b6:5:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 11:12:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 11:12:56 +0000
Date: Fri, 17 Oct 2025 12:12:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, ioworker0@gmail.com,
        David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
        Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Harry Yoo <harry.yoo@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Barry Song <baohua@kernel.org>, Byungchul Park <byungchul@sk.com>,
        Gregory Price <gourry@gourry.net>,
        "Huang, Ying" <ying.huang@linux.alibaba.com>,
        Jann Horn <jannh@google.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
        Mariano Pache <npache@redhat.com>,
        Mathew Brost <matthew.brost@intel.com>, Peter Xu <peterx@redhat.com>,
        Rakie Kim <rakie.kim@sk.com>, Rik van Riel <riel@surriel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Usama Arif <usamaarif642@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss
 when remapping zero-filled mTHP subpage to shared zeropage
Message-ID: <b3a41a3c-0b05-4541-9daf-3524aa6268ee@lucifer.local>
References: <2025101627-shortage-author-7f5b@gregkh>
 <20251017085106.16330-1-lance.yang@linux.dev>
 <121d5933-16d9-4eb5-b2b5-2edff9b36c16@lucifer.local>
 <3390d129-e540-42f0-aada-0c8b6fe96f26@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3390d129-e540-42f0-aada-0c8b6fe96f26@linux.dev>
X-ClientProxiedBy: LO2P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1034a105-ecba-4b21-0cd9-08de0d6e1fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsWw3RMAxhq/DSDVnMfdQKV6FrPlYugZEqvnMICxSFxDp1aD9RM7zVh1U535?=
 =?us-ascii?Q?zHiRANzqimy1J0ZZs+XjoYIOwxsZUb8zntmW+5GR4d43QkgbfBuuDVI77CPB?=
 =?us-ascii?Q?A883NPWLTOKAWQnnK+CL9BTpjb0qfDd4pd8eXMEsG8Jx5FXeCS685lBXwi6n?=
 =?us-ascii?Q?neqS6/oZS9V7+4AD6l5LWur4nHpy+qAoMEMyyiPUu7yKWOYmGWD9Nww5j2ky?=
 =?us-ascii?Q?CD3Kpf5CBrgYd4q2BKvrFR1JYYoXWcekWfAf0dLVVyAsv5nqG95HkjUDwubn?=
 =?us-ascii?Q?UPIlxt5v3x/awmTIDoMpljtZuz/CFM3N44TRfoBjPKcETkZYPqpCFNRmtAW3?=
 =?us-ascii?Q?OENpeOae35MpQmJF4EoeD9wpWYUxDHCLOXs0a+1dz6iSPyV4yRy9RFxSy2Ar?=
 =?us-ascii?Q?+xSADb4aycOuSN2DB4JVq2wCgSRSfl0pK/GP2ptC3UgsS6nZSVEDSeST17JI?=
 =?us-ascii?Q?hoZHlOxmK77rQ7C6IzTojyarOvrCdlsKxTczIoR0bniS/zjlWvsITqmFwCTY?=
 =?us-ascii?Q?7OEahzO1HIOGUnwR092E0ouBbazU1KpunVGqrSG06loU0bcQus5H45jvtZw6?=
 =?us-ascii?Q?MRr4ZtpEZdUF/laUgXH3YHwzl6jSkpmaVRjo9kUPykz/0VFs6ZBCpkK425k1?=
 =?us-ascii?Q?EqLsA/1Mjh5MGzNutfxS5zHtRCpsfYIlYAfwrihbooZasJM4ZaM25Wu8Uzx0?=
 =?us-ascii?Q?eA3zTv+MoNOxofj9C+9ZDVNi7pXIfrv743pulYpEGmb4SXua/184kp8wqmP+?=
 =?us-ascii?Q?5ba1JBYzE0aWB9BMPNGEU2hpuR2yaNG1ftQNK2GCHgc8Cv+j0NoNcRXW2ief?=
 =?us-ascii?Q?gWGeFfhiCRHs5VYMO6EF9/sifp0XWQCFtO/jKTRLHdLFLYd7+PXgr1Wi1y22?=
 =?us-ascii?Q?IxmoCPEmSV1MP7pA4wYwFCo3wKrN+hZvSx6MctyWoMMrUh3pV4rAAX5z8Ywu?=
 =?us-ascii?Q?OQ0Y8EPeOI/olbHN/y6e67HkXcsicUHrgOxzVy4Hx2TEbB8Dl2R4YIAWHzEq?=
 =?us-ascii?Q?vDf84T4B4STyCxEvxw8lJ3G6GZmSdxh0V8jd8UsvQrspfG55LDEJ31O+kZT+?=
 =?us-ascii?Q?EPr5+Z5PXr/DQ/II32/6h0YK+PxPhHVtIV91N5EOCVX2FV+7ZYMe3QAR5MFJ?=
 =?us-ascii?Q?Fiu2r5V71XP/7kLOKRGOL2RimLEx4/Ic4WPjIyjmuY+MpCyeTgUwITo+JOhF?=
 =?us-ascii?Q?AfhlLE77qTSS9SUmzFSfMCBkRPGLNEL3pksEOd3biws0EvFWBCyjBAR7hIkr?=
 =?us-ascii?Q?QA0ddoeDE4VvnPY2RGvGkKDuEu1JiHzOXSs1WFTWDHD78LonphLwr4fGET+B?=
 =?us-ascii?Q?nBw2dNbCm0qvMceR/RVMUbvc9yL38gwq4UCtU6n4eSKI9TJiNU+zmXQ+dEj6?=
 =?us-ascii?Q?x47BvhzJMHNhtZyEskoJ1HDraHY5S1JPXgJI8uw5soNkiMFluO2gMm2qDpMR?=
 =?us-ascii?Q?8guXmgS4PwgvdLmpxP9kT80QrS3oGP5q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?niQmPHpXN9xhP1kZbf4Ue4uMu8kpje9aCVP69C3tKHjY8t+YnTWrcb7g+ZTX?=
 =?us-ascii?Q?bwp1ETsJdME1YtmNnxEmdN5aTOLtnwpqYFN1dTYXAunR/tlHitcpi7R2l+Tc?=
 =?us-ascii?Q?DfsBIZLaCuxdfrzKQuYduhhcejryEiHNqr8P1MhEtH9gi9Clr+wGAamdr3q8?=
 =?us-ascii?Q?KGvPjwQ72w57wERS6Ewcb9MfuQgB054gT+qqZykjwgqIsVrDnBK/gVtLTH69?=
 =?us-ascii?Q?9rO297f0StZByKuxWF3ieUWYJJJNZx9ht6FnzApLoAwHm0gcIYG74jdmG+IK?=
 =?us-ascii?Q?x3W7SCtnXLRLwWH3QKm3XnQZUFbw5/L+NjPB6mlnnceTjhdD/9uLgeTT2Nwx?=
 =?us-ascii?Q?RvYBIRILgtixr0/rrSJ/b68rkwFDW9J5m+CWwC8EkGigLuF3zIPIe5cUVYJn?=
 =?us-ascii?Q?/mydGBUZIGz3b+r6aVvBdt/HBw8pdZ8d4DRuGPuaS5m4tQuHk7jyRXWS2qcJ?=
 =?us-ascii?Q?YhnRkA6pMXMjnaxwor0BcVM/+RfZq/7cDNlW8WckMFq2YT2AKRsIOpv50/ra?=
 =?us-ascii?Q?1HVwwys0V/ke1ZbjkiUPt26v8qGAJbu8KTNRgJ0bY14/hrnRsFyg4qYNbCbg?=
 =?us-ascii?Q?O8oaTmuEjmSmu5S9oxJBcSXQMBAaHbeGDRZqXPvARhZSLt+pVoOJfukhpRST?=
 =?us-ascii?Q?NKQxIHViPVVCVzzGklfct64G7JgsmjRp6aPRJgvvB9uKfJZpvHdm/bnd7qvf?=
 =?us-ascii?Q?kHY86TyD/cwBqIUFCApWdzKTkw5AekNOCFxM0JJZQ7jgE4LZRs/ci2B89lJT?=
 =?us-ascii?Q?PzwQh+fiv5d4K6DlBc+ZAugnoq2eo4/Gn/IeUcycWm+de8H/e+fm6Xzpcnr9?=
 =?us-ascii?Q?fWyHC6wfTSkqFkc+n3FiP0yAqRf2TFND1ma+/c+6V1otQ/ea9W6M/6trZ+Zv?=
 =?us-ascii?Q?GLA5WXxZf2Gbb5EAI42ybG5I/isyZwnnO4KGajXla2vogfa+1UaDZrc2IfQd?=
 =?us-ascii?Q?AOtFK66vSmtuAi2k1vzyhy8A3DLbtgcMKuY6BLptzAwDu6eY7LK/3dx/FZyI?=
 =?us-ascii?Q?NsBRyFp0WVVrCrNYQiHqihIEevskv70OX5FFnyd7c5yVwzMpenVl4Pn64d5u?=
 =?us-ascii?Q?apVooRYDzaR23iU5Jp4I/Uh2Z7GmZpD6Pzl/3p6pv8atHnD+Da88cvbga0f/?=
 =?us-ascii?Q?vWt7qZkPB3gGS9hc1H1KT5c+tYKaDDEyBfMRFzJdTUp0RfG6Ne52Q4RrgAvN?=
 =?us-ascii?Q?foElLlg3A5uDNkx2WP+6Kb0xO4MknQJE6QnJ4XT5B29QH0CFWsP8iKnSQ7Tn?=
 =?us-ascii?Q?XRaCckPoKkggNdcYtTUhA+x074YwcaZ09W8c7jCs4rBjSJ0DyBS4G3n53MnP?=
 =?us-ascii?Q?sdL1DITa9t0yPIsmr/8m4MIYCKQEcG+4aCRjQlzTKq8IXug2TZLU95KC49ZF?=
 =?us-ascii?Q?ggHSWVGDgJ8O6vztzf5B2sLGdah+hs8l9wEcxd06LKPk0FLcNLHMyz5ImgLI?=
 =?us-ascii?Q?yOedHRjVg6Yh41g/PJsxfGDSRfH3oE7zAaHOczbCsOKGAMxxvnRWAzpb8zEp?=
 =?us-ascii?Q?5RK30T6GVPji6NpP5llZuB1wx4gjpFbUJv5n3dThLrkENu+PF3mI6V4G85u6?=
 =?us-ascii?Q?sISEZZRt+CldkFkYpz01u6elNXHOJL1C2iUpnenFksqIqMaLlmCEqXTefJEw?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bcovw5bceOxZhYXpVwmQNr8vkPT0J3ftEYeMAfbpVwp5DKbPMY7chRrvSupK7t+QbtFezSsJ49odS3adE/mDrUbDmwbihnjeKLT1Z4m069dp6kXf8CkZfdPuaA0kqd1wW9ZDfhgi+obY7o+X70we+xr1DNFytGfXTrSiqLyggSZrZfqM5f2gKu7g75mGYV1Uz6f7DG9+DjbDEaxNlTyz6SzHR+F9CiLQkEURJNfV8ZFxLb/8TD8tNDLnl7+KEvcGuzF2F6QRxspVgszW4AVFmEUqhvGLoV8ecLCWNyrcv1xWvmHMtDrU559447bXf7L05m/cYFdCc+6KQgRtKmGXu8is4poIbz6xqgqxlPrtsdxuNsF/MuGwFpFmkNMXINsvdUVhD1eqRYm3ISr30bsD2m9F5qhMOMD38PuSn6Yj5B8AizHMD8aYpBD9h3CJ3mZBFzz3pKS3F6GzuoVcioNB2jX5n8kz5cMxk55sQjMCQDac3Gk5Q6br/840LkYkuCy0Abwq32s5D3v8/w/LZHMtD4YWb3Z6G+f/VCPF5JN82SjsuzdZ2qpHUj12wsSe6vy+B5r79VkeMeBw9vVV4Zcjf8b08IkzHS42CkFn4LT/cc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1034a105-ecba-4b21-0cd9-08de0d6e1fb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 11:12:56.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1e5WbF9V/RU07z2h0Lmfhs8HjnfnLcohlVqkuRl08OaLINn9Fg1wkmp3kxvMLNbjRAJ72T0WOyBq8BIiWcWQ7nP4YTiny9llzNf8fFWoG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=897 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170082
X-Proofpoint-ORIG-GUID: 1Vb_aU_jyzMr3Va5r_fm1tOwxfE_mtdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX2xudUnHmTjQ0
 rTafz4D/HAlBeY42VHo3FUbsBHXz29kOZv3IUn4vWLNQ5wldzvJQhj03p3tL7z6Mfj3Vhz51zjp
 ZsgZfQ6/EJRnKaHoyWJJSwZQWnILmLulboMRVwFEyeH2xtAdn/EkdCIwgM4BavQAWced6auLMh4
 PEqkiq7NXwRmJSUx6jVzP1oc1qAP/UZRUyTGXLf55mB3JsvlphOR64HNBEqpXkkUr+srdgjtgjN
 1DBGAOtge5Wj3dxJ5syqJoq++kbCmMqzIY3WtjagYG6pUOEgfuhHy15g1hTOiTJLDLZjOBuizSr
 GBAmTOzjXEm3oyiHB/Wl3YwI3RI8ZIncSInLobEzKYc++nKDcUgIEUt4Y5VXz8qMupY7YLkoSWN
 xylBA79Bp9ZrqLtRRO+bgThug8oXWeHKgYnX//8A7MGmCvol9BA=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68f224bc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3iUN7hb3JB3A_ZfKaQYA:9 a=CjuIK1q_8ugA:10 a=QYH75iMubAgA:10 cc=ntf
 awl=host:13624
X-Proofpoint-GUID: 1Vb_aU_jyzMr3Va5r_fm1tOwxfE_mtdn

On Fri, Oct 17, 2025 at 06:25:42PM +0800, Lance Yang wrote:
> > You're missing my R-b...
>
> Sorry, I missed it! I just cherry-picked the commit from
> upstream and didn't notice ...
>
> Hopefully Greg can add your Reviewed-by when applying.

OK disregard, I must have reviewed it after it got merged due to my
vacation.

