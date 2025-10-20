Return-Path: <stable+bounces-188118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B66CBF187C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80D554F503F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57733314B8B;
	Mon, 20 Oct 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLEeFswl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gu0JbS2y"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764CD3128AD
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966792; cv=fail; b=M8+Df+F04Ppm7SbF/Wyf7mFnrO/DqHNF0N8fsUikpn/85XpF2btPU2+7eFB3gwh7K+SWmKbYrVIzezmIgGOvMMoXQMqgaTU8AJIb4Zq+HpY4lOY0LqHct0/aiGvWkBh9+zOHNa+4C1BuFwcqyEHrJ1Lc9gyGb2broq+v0pkwIVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966792; c=relaxed/simple;
	bh=qndE0dk8/orWIxWIEkLcJdkd52uKmgMdbI7wXsrpAWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAx4jkw8vRMGEREqbUvBkhflQz4NVPQfvmvGyMeCFssfq8OJOs71d3ZKOtiKJfeEClJ6JHiuVguhaUBLUh3Reo6jH58I83RMeVOCrBwqZHgLB1Df9tDeeHGvDxV0CL2RuiJiUWpTVFMpnIvYOrpgDrH161nniSmtn/zmVG3BSJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLEeFswl; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gu0JbS2y reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SHuV008934;
	Mon, 20 Oct 2025 13:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Q6SevFhyLllkEgyKf4epKp/fyRn0M4gZkMknvfJ9ksw=; b=
	hLEeFswlR+k9ic7Dqi6QFLo+4p81BxLR6bZLrfJpgtj/hXA+TpT7NXa+521a5523
	9KJ0tDxpgW/cJ69P9XeklI6pD2+idPD16xrfV4x/r2QyWyay7XJLA1bmb30vPYr3
	HOZ74fMfcbU47XEUJMkkJkdkJ/qyOYcKw4/JaGTVddptYebtplGNZzTQERI1Ydto
	dQQekcjiumS+Ack14E6Bv4vtdC3IU7iZCI/jbOygDttNXCmAb8bEAoPTvnIDJd5U
	Yvlj8klrt9GdxnlmXJfkzHwtoII/p/O625APVwqbYibXY2qus1VcZqOVmc6CeWh6
	uFbX4eNIfBSClkOrfkwWcA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d296g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:25:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KDOfpR025396;
	Mon, 20 Oct 2025 13:25:44 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bapn68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG5pCBixyoe5CnNGZ5Jhox656aFOG4MRzbEu/wWP1QVcTuGmIa8n2/HBtvfXd+JDz4Z97OhM0sGqIhiLidWlgAoCJzIId2SJq084VTjatDdy98arUu33ZcJPAQOA/sk/2st2GcVWgOl3m7YKh79BAppNbU7Kuta+Uj1ep3uEjG9Cogh8Ldzan4+gnt1X83UE/8tU5yOjV3AgiCZ5k1ZBMhwpluvolEvpG/YQpyZz2/TSEOETes1tqeN7/oKRUXxnBR3QpNXwWmu/kE5EZX/Ouen6JU3Ox/CeC46Nka3vyCqimO3RUyMHRGcEXMa4XYV/UXZsSf5fbBBgLeV4gajnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53Zn+DO3gLgWeD2wyoh7mREQXdJrUpjZT7XbPX5Kr8s=;
 b=mMIP894XjL8nwWylLdBPWfvkkL2UOPnwYCb4GDHbHRSXxALagjv0ZvTZohtRpltxgkHr9w6U6MTZTfFRF4lqjeW8D8Veeju1wRs2f6UsdQdmvSQuDU75lDxd67QZQaS8dLmqAiVBNo5sVuSK6O2g+eMdP7z4y5qqiMsM/3YNzP9P2veyllrp10btXWzoL+/1HFRgQRRhC6Q3N5If54lRH1R1XZKDf0I1E2VRCOpZc2VoPc2Uitvlljibz2Ee3fscZFGmTDdGNIeIy+JYQ1UJCgZ0mg1uYE9H0NhOVLmBUEveFS/ied1QQBpt3KJTtL3GF3h+F++DTmnxq1D/pvFNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53Zn+DO3gLgWeD2wyoh7mREQXdJrUpjZT7XbPX5Kr8s=;
 b=Gu0JbS2yfqgCcZzFoaTQ69TWTRFW40sW02GLAGkiD1dCvb/kose4Y2S1xkMSmTSyAWxCbXaPtZ42ZEB+oBy/eLfjbAoCGMel1gRkxf2a6ngtbQzp4VW5XdNevltdfqtYW1odHN0nwYzFPfUC1vMSLZo8yMi/Hq9CF3ojFvZ4qpM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7264.namprd10.prod.outlook.com (2603:10b6:208:3fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:25:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 13:25:40 +0000
Date: Mon, 20 Oct 2025 22:25:29 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [DISCUSSION] Fixing bad pmd due to a race condition between
 change_prot_numa() and THP migration in pre-6.5 kernels.
Message-ID: <aPY4STwIIRxvk3oH@hyeyoo>
References: <20250921232709.1608699-1-harry.yoo@oracle.com>
 <b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com>
 <aNKIVVPLlxdX2Slj@hyeyoo>
 <6e4f6a37-2449-4089-8b3d-234ba86878e2@redhat.com>
 <aNPb3qVCZTf2xMkN@hyeyoo>
 <9b05b974-7478-4c99-9c4f-6593e0fd4f93@redhat.com>
 <aN6HMzXM4cL6Yf4A@hyeyoo>
 <9f3e4031-9e13-4f8b-a7fb-8db4166c47f0@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f3e4031-9e13-4f8b-a7fb-8db4166c47f0@redhat.com>
X-ClientProxiedBy: SL2P216CA0120.KORP216.PROD.OUTLOOK.COM (2603:1096:101::17)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: e008d4f2-de17-47d1-a8e3-08de0fdc29d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?/otGTrhSh/exnbEHIhol8CKL5/jPfrs+NIfhJb1YAp6wBRSIjCkjZKYdXw?=
 =?iso-8859-1?Q?c8eg8S7ShO2xFqkasupm3lRKl8votp3PTPv1NRhr0piKBNGM3C8MxbLOy8?=
 =?iso-8859-1?Q?ur+CnmUnAJs7ElIPJywH1lsBFirKIizeCUV/0+YqjQESQ0+O2BLwR2pjbN?=
 =?iso-8859-1?Q?IhDz/pT65q441/m4R/xnRx0+MzgNon8ieUaf+VcLrp/3rB4ajycuqQyf3Y?=
 =?iso-8859-1?Q?0L5E6Bkcs+YW8UyqKwEt6kBAXPv46b1gOXKx7U2fLEZOv7gG/+SOkTwGSX?=
 =?iso-8859-1?Q?CBrLN7zmUsM6ERncJfdHbjlXFTd6va52GliV1KnTpvBzyNiC5abMbBUwO8?=
 =?iso-8859-1?Q?hPIyhcz6ZVSW7tgbbwtzMCfPPX809IUdgt5oYkSL1pQMJqiPVzwSaJAEA7?=
 =?iso-8859-1?Q?+tDaNPKxc5gLCkLzD8oxZMC41ovATtGI50XstsklmOnpH9/Ku1eCrX6KLR?=
 =?iso-8859-1?Q?bk9MMrizACcaAG7OY9f19dNHvNgrTxUSp1EWyxl53hCgsLz9c20VziH4h9?=
 =?iso-8859-1?Q?fmPuXGLf0MPj0RyjFiDcvZ5wV/qZJgnYFTtDryCY3wNIthO4fZ7p6oHFCm?=
 =?iso-8859-1?Q?BgstqGA/Vh091jjkmPvgm6aLWe487CFdXM/3JtqTMP59h9CMJFLgnWkRsL?=
 =?iso-8859-1?Q?gOYQS14ngL98YxAd9DxdqLX3i3I9J58PtJAxPIS4By/Rz9h5zogdRxWrqW?=
 =?iso-8859-1?Q?wKAatNGiqbugGOT3NakQBsy4/BCnY49+IxnuXavXzBmh79j4jZkK4KQVoK?=
 =?iso-8859-1?Q?FSAkIVG0yRqa93xbLRq0d6q052tsEizqIU2eg01/PHmMfquh6k4+2h4l9D?=
 =?iso-8859-1?Q?K7lbDlukXlgT9I2JRUpv9mBhdq6s9fZtBwUCiOWd96/+is2wzMa21GSKuu?=
 =?iso-8859-1?Q?2g0MI7AkglHW3VZQfBBIy8OPHm+0mm6h8EsXEdxDOXIvSyzrkgeVpIZZf8?=
 =?iso-8859-1?Q?g1Wo7KbvZFzh7YBx9J3ns4fC7LGPNNyQ7AM/gJsi6HcFFuGCuqIFGMaD/s?=
 =?iso-8859-1?Q?c01PGK932tr1Xi+We0qCcSTL1tkIA9feoJnEvmpui6O2eU1Hrs536MdhWa?=
 =?iso-8859-1?Q?EqfYVnZ+GRgjDcvfm+R0dnqwu9tGop0C0x5j1ZA2CaHTJ58HzGIS/AOcog?=
 =?iso-8859-1?Q?EhO8ggGz1uMJviAhPU8tdAFIz+uM6/HehCoFV2pMkdr5xb717X0YCihU/D?=
 =?iso-8859-1?Q?8YMt4y/6uTX+k/2ZTeJggHjabJCOIIwZQFp2UZzSLx2m2fcD39ou+qPlAH?=
 =?iso-8859-1?Q?Zx4WtC8a3G1XoD5tHDBgGkNTuqeV2LR6HQa776PmWJIhctQARZcYBslHsn?=
 =?iso-8859-1?Q?C7zP7TfLWkiFss70ldnwG98FYIpPedBtKE88+3yJO6CdqhrZtyiccbObXV?=
 =?iso-8859-1?Q?QWzRp1ngNX4YtX5V3UU38twIh6DnZF/Oe7cQJjkra7SgGjT7OU/WpCphXt?=
 =?iso-8859-1?Q?Y59gU3Uon2e0rh6h1UpHOv/PzUNxnHucZp20sWdqCO1Y745fo573VyHzNS?=
 =?iso-8859-1?Q?HtsBEjZwq2fVF2K0Rx3qRN63xVzEJNtUV5izHmlm/D0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CFT5EZg+7WS+uGPjKASVuINkmsTkzuUAQK+Mw+otQQt3cEKE7rY5XKalup?=
 =?iso-8859-1?Q?qZrmrBgyLx40hGdkmAlA9BR1Jzfi7F+//bSXEP4713Twd2MeGxcX6PX3Gm?=
 =?iso-8859-1?Q?rIvMrTztfs2ltb+tyc6JPimJSYKLVB9BMvcDdBTTmpr3cBlDdk1q15sKik?=
 =?iso-8859-1?Q?jhojEYpyjZ3Hs0t+zcjH7IkOj0jqXQfowTblJ617KpOd7/8SwAuZvWZroz?=
 =?iso-8859-1?Q?Ossddtw1MlCOssqoy6ZDaPuTnGcmYECDH1Z4QgQhuoVhl8BXJtWQGAXzHB?=
 =?iso-8859-1?Q?2lObggjGjj38TpZpVhu0ehDBo6c+mL8U7JgblJyWFQHcA4xJie/PFjIhV8?=
 =?iso-8859-1?Q?jO++ijXWPWnA6F7ULmk1IWOuMUdUTac6KfrQ6fdkaiOo1xicVjfMEl2cfP?=
 =?iso-8859-1?Q?4nATQA0/ADychFC4jjvwZU2dABQc4+cIUsIJBTbLDQXVswaNEjrPo3ZcI+?=
 =?iso-8859-1?Q?dqqcC5a7RPBD5MLeX3z6qatBt4pCwnSiNDWJHWI7d8hLmYe18wxJHqSN/j?=
 =?iso-8859-1?Q?oNwpt6GAEP13H7VY02GpOFHl+AsE4P9E8uybm0LNa5AHgexvP1Nf5kX+FX?=
 =?iso-8859-1?Q?F5p7Cx2cVUAe504hpRMmmdM+pIYw184jFDjUPz37VYcLaO5WkEZTqTuViU?=
 =?iso-8859-1?Q?wrQD16D24HpHc9hCYkLhR5VluTWmGARPwI4b5VRxEF8WnMLnqO50J82Gxe?=
 =?iso-8859-1?Q?EknFx2ekT4pdiemMw8rGP21THbrZtAFe11ci7KXQIeEXDlfUf6yucEIofq?=
 =?iso-8859-1?Q?Csmhjlflwsnf7nraTWKVRrNVd5cfm3CfWcGuBfmxH37yygIGvEQOmq+k+r?=
 =?iso-8859-1?Q?DY1lt+ek/BfXAfNoAWZDdEp/ZlDr0YIHD551NU0SS/lhuni9RDu8eyxQ+P?=
 =?iso-8859-1?Q?LW+ns+Y/uwycbvL2bLfMEIyRUY7zq2yg7LdXvO7QCrvxtz9FqjL+YPK5OU?=
 =?iso-8859-1?Q?7xH6F8zDmz5NLzsmICp2i0Vff0871p1PIrCXs0IjmV0L/S967z5gLlBnpZ?=
 =?iso-8859-1?Q?mJSngh36p33bUGu55bym74L4l/W31bl0w1sLGDqdrdDWxT1s6PojxFvaYp?=
 =?iso-8859-1?Q?SJw/h46z85tmpOBmzbgVsS0KgQg/zzB3z/PT1IVt18D96RTKAMIYTDBaWm?=
 =?iso-8859-1?Q?ZR2TBesVOtPKFl6VnG7VUxskC6hHFHPBJoedcHNtb/c4MjIBIPLVOe7u8X?=
 =?iso-8859-1?Q?nn1f46txZ4GckmYRCdNsxtsyXMWNShQ5d40EdXeViJXuYuRwVyLfSbrPnY?=
 =?iso-8859-1?Q?fkZX/cvUE5+3eTLyZp4TDjf9TCJoEWSVsKDrQE2XkDoP8mzviealnt4i7J?=
 =?iso-8859-1?Q?i4l/037aEcDgPQJK5FQdp4jfmBFiD6/jSqji/KqvVsByoRj4QHe3Bi6GIe?=
 =?iso-8859-1?Q?IWAukQbjQjrchHlZ9SOe8IyDaAt1O1r87wkjAg1FbvXrp0C0U/wc6U8cJx?=
 =?iso-8859-1?Q?mszM/h52iwX2yt1fny1AYOO3gqLQTQKwb3QfZYGpDyilpOKthP4xGcgdDf?=
 =?iso-8859-1?Q?9AR4wKNK8I78p/C3GrXOYPCL3Be+MLh2tBj6FGWWGcCiMUbsAbA7e2HMlt?=
 =?iso-8859-1?Q?l1Cu2id2pCxeYx+LtMzKh7yUcxcVa8+ck8KXlzT5Mj5D/Qgws4/sdK8C5b?=
 =?iso-8859-1?Q?n3eS8TK4pDxRJUAoRwjvmLnecOACzInwX/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/9QGBsT4CL7rUc4qE+5QGe3vIj4iwS4o5u7TDq5WVcZZa6ZnV+ro7f7rLDg8bMh6QaWNCcNQZHLoJ9eC0+Iqfuhcw7r5yPuNBFGaWx94PRA2GXxE3kF+ch0tVuQ2SWJGTYkob/kIgNn1peA3/yb7PtDrBMya74Z854XSHfVXtFkPqGcfcxk1l4oG2EG/RblBG4FIsobbEw3PyZPJe++f2F8JkIpeZ4C30oAsIab+yZku0Doe2LQvQ9gUwRW3njhFQHlk92RNJU99JWIcGmPOQ7q62h6CxwHV7zlvMiCGtowCPKy2r6+z+6mbMqbStDXc2pIe+Tdr6+uoJrmR6l57XTl8u0/zVarzUEIG3Vfp/ifTqB2yQoja12wU8gfvvB+9vXDZa0HPtb+N0i7zZKPx6+bENoaKKq4xybSYv1XXNt1IiheG9u3ZdIzvSQQEnkLmMKN1Nsx4R4U6NvmQYoBE87j1znxPx+Ci4ZxntvpAtXNAebZ+IZvgZfcvzDizpCME3jyd/EbBHS7wKBfdZ+/qLnw05x/RgVwB96WwbKx13mgrYMxBvCO1YcCc4EMeQ15wP291E4+A8z7zKZBKnUimpoOpxu2rYZO61JkpBkNHEPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e008d4f2-de17-47d1-a8e3-08de0fdc29d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:25:40.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw2LG5YlwxU1ss3AY+uBVNJkkUD/GuAErIK2h8Y9a1Lzq+NvZIiviyEYOilGCegA/Sz6s36MhJmSHNiHndADXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8oi0P7U9ZcfK
 KYvF/kL0IlYRU7himz3gZGBfmrNxfM7fqUija3TE/sl7AMbVEJSXdsZtLEuUI4TurkJxWTV3Sfq
 d+I/Wj6sXml3lSo+Wcf7lYVtTiWQOAqzsVt6Vulf9o068wz53f/71bKgH4Ph37pvPqRyMNPQFnq
 YlYvYMlDn/+497IiTnTgWhZlnUewK+nln4dtWxXWiKJIbKe9TRCKb2e1xktkuaKCSxcpx7YJan3
 FEmW5mxr5MsodN0UBl9HH4+7aon1fzWv9fc2LFqy681J7Hplspj0F4qRSjQswiEu3zMLRhfLrgg
 EZ54AAP3Vzauw1PeP5IerYc19Wm4KmhbCzE7UmS5vUge6qEw2bOl1tk+O+pSaMTX4xHduiW1bLd
 +KP722pLMo6AlJXN9MqXFOtFFiw1SA==
X-Proofpoint-GUID: 8hF9NE1cE04xp3RFpy4A1Ob-tqQ_MG2c
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f63859 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=Ikd4Dj_1AAAA:8
 a=7CQSdrXTAAAA:8 a=1UX6Do5GAAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8
 a=9jRdOu3wAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8 a=nrACCIEEAAAA:8
 a=7ipKWUHlAAAA:8 a=eh1Yez-EAAAA:8 a=eJv049XAPIeucDiclAAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=Et2XPkok5AAZYJIKzHr1:22 a=1CNFftbPRP8L7MoqJWF3:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=L2g4Dz8VuBQ37YGmWQah:22 a=gpc5p9EgBqZVLdJeV_V1:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 8hF9NE1cE04xp3RFpy4A1Ob-tqQ_MG2c

On Mon, Oct 06, 2025 at 10:18:30AM +0200, David Hildenbrand wrote:
> On 02.10.25 16:07, Harry Yoo wrote:
> > On Wed, Sep 24, 2025 at 05:52:14PM +0200, David Hildenbrand wrote:
> > > On 24.09.25 13:54, Harry Yoo wrote:
> > > > On Tue, Sep 23, 2025 at 04:09:06PM +0200, David Hildenbrand wrote:
> > > > > On 23.09.25 13:46, Harry Yoo wrote:
> > > > > > On Tue, Sep 23, 2025 at 11:00:57AM +0200, David Hildenbrand wrote:
> > > > > > > On 22.09.25 01:27, Harry Yoo wrote:
> > > > In case is_swap_pmd() or pmd_trans_huge() returned true, but another
> > > > kernel thread splits THP after we checked it, __split_huge_pmd() or
> > > > change_huge_pmd() will just return without actually splitting or changing
> > > > pmd entry, if it turns out that evaluating
> > > > (is_swap_pmd() || pmd_trans_huge() || pmd_devmap()) as true
> > > > was false positive due to race condition, because they both double check
> > > > after acquiring pmd lock:
> > > > 
> > > > 1) __split_huge_pmd() checks if it's either pmd_trans_huge(), pmd_devmap()
> > > > or is_pmd_migration_entry() under pmd lock.
> > > > 
> > > > 2) change_huge_pmd() checks if it's either is_swap_pmd(),
> > > > pmd_trans_huge(), or pmd_devmap() under pmd lock.
> > > > 
> > > > And if either function simply returns because it was not a THP,
> > > > pmd migration entry, or pmd devmap, khugepaged cannot colleapse
> > > > huge page because we're holding mmap_lock in read mode.
> > > > 
> > > > And then we call change_pte_range() and that's safe.
> > > > 
> > > > > After that, I'm not sure ... maybe we'll just retry
> > > > 
> > > > Or as you mentioned, if we are misled into thinking it is not a THP,
> > > > PMD devmap, or swap PMD due to race condition, we'd end up going into
> > > > change_pte_range().
> > > > 
> > > > > or we'll accidentally try treating it as a PTE table.
> > > > 
> > > > But then pmd_trans_unstable() check should prevent us from treating
> > > > it as PTE table (and we're still holding mmap_lock here).
> > > > In such case we don't retry but skip it instead.
> > > > 
> > > > > Looks like
> > > > > pmd_trans_unstable()->pud_none_or_trans_huge_or_dev_or_clear_bad() would
> > > > 
> > > > I think you mean
> > > > pmd_trans_unstable()->pmd_none_or_trans_huge_or_clear_bad()?
> > > 
> > > Yes!
> > > 
> > > > 
> > > > > return "0"
> > > > > in case we hit migration entry? :/
> > > > 
> > > > pmd_none_or_trans_huge_or_clear_bad() open-coded is_swap_pmd(), as it
> > > > eventually checks !pmd_none() && !pmd_present() case.
> > 
> > Apologies for the late reply.
> > 
> > > Ah, right, I missed the pmd_present() while skimming over this extremely
> > > horrible function.
> > > 
> > > So pmd_trans_unstable()->pmd_none_or_trans_huge_or_clear_bad() would return
> > > "1" and make us retry.
> > 
> > We don't retry in pre-6.5 kernels because retrying is a new behavior
> > after commit 670ddd8cdcbd1.
> 
> :/
> 
> > > > > > It'd be more robust to do something like:
> > > > > 
> > > > > That's also what I had in mind. But all this lockless stuff makes me a bit
> > > > > nervous :)
> > > > 
> > > > Yeah the code is not very straightforward... :/
> > > > 
> > > > But technically the diff that I pasted here should be enough to fix
> > > > this... or do you have any alternative approach in mind?
> > > 
> > > Hopefully, I'm not convinced this code is not buggy, but at least regarding
> > > concurrent migration it should be fine with that.
> > 
> > I've been thinking about this...
> > 
> > Actually, it'll make more sense to open-code what pte_map_offset_lock()
> > does in the mainline:
> > 
> > 1. do not remove the "bad pte" checks, because pte_offset_map() in pre-6.5
> >     kernels doesn't do the check for us unlike the mainline.
> > 2. check is_swap_pmd(), pmd_trans_huge(), pmd_devmap() without ptl, but
> >     atomically.
> > 3. after acquiring ptl in change_pte_range(), check if pmd has changed
> >     since step 1 and 2. if yes, retry (like mainline). if no, we're all good.
> > 
> > What do you think?

Apologies for late reply...

> Only for -stable, right?

Right!

> Does not sound too wrong for me, but I would have
> to take a closer look at the end result!

FYI I'll test these two patches and see if they survive for a week,
and then submit them to -stable. Thanks.

The first patch is also going to be backported since change_pte_range()
cannot return negative values without it.

It's based on v5.15, but I'll have to backport it from v6.1 to, uh,
**checks note**, v5.4 since the race was introduced after commit 84c3fc4e9c56
("mm: thp: check pmd migration entry in common path").

------8<------
From 3cad29977e81cebbb0c9e9f4a7ac58d9353af619 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 4 Jan 2023 17:52:06 -0500
Subject: [PATCH 1/2] mm/mprotect: use long for page accountings and retval

commit a79390f5d6a78647fd70856bd42b22d994de0ba2 upstream.

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be
half comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on
any system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow
too during the int-size convertion.

Link: https://lkml.kernel.org/r/20230104225207.1066932-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: James Houghton <jthoughton@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 26 +++++++++++++-------------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7733abdaf039..772ce73fc5ed 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -213,7 +213,7 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,

 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);

 bool is_hugetlb_entry_migration(pte_t pte);
@@ -398,7 +398,7 @@ static inline void move_hugetlb_state(struct page *oldpage,
 {
 }

-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3a076a98733d..537575ea46e2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1905,7 +1905,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)

-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 116636bddc46..3f4615af577c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6339,7 +6339,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }

-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -6347,7 +6347,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d5224a8ec9c0..5b73c56b37ed 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -630,7 +630,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
-	int nr_updated;
+	long nr_updated;

 	nr_updated = change_protection(vma, addr, end, PAGE_NONE, MM_CP_PROT_NUMA);
 	if (nr_updated)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 29c246c37636..22024da41597 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,13 +35,13 @@

 #include "internal.h"

-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
@@ -219,13 +219,13 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }

-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
+static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;

@@ -233,7 +233,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,

 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;

 		next = pmd_addr_end(addr, end);

@@ -291,13 +291,13 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }

-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
+static inline long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;

 	pud = pud_offset(p4d, addr);
 	do {
@@ -311,13 +311,13 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	return pages;
 }

-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
+static inline long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;

 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -331,7 +331,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	return pages;
 }

-static unsigned long change_protection_range(struct vm_area_struct *vma,
+static long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
@@ -339,7 +339,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long start = addr;
-	unsigned long pages = 0;
+	long pages = 0;

 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -361,11 +361,11 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	return pages;
 }

-unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       unsigned long cp_flags)
 {
-	unsigned long pages;
+	long pages;

 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);

--
2.43.0

------8<------
From 0db554652a1fe67841e4660ae8e87759d0404db4 Mon Sep 17 00:00:00 2001
From: Hugh Dickins <hughd@google.com>
Date: Thu, 8 Jun 2023 18:30:48 -0700
Subject: [PATCH 2/2] mm/mprotect: delete
 pmd_none_or_clear_bad_unless_trans_huge()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 670ddd8cdcbd1d07a4571266ae3517f821728c3a upstream.

change_pmd_range() had special pmd_none_or_clear_bad_unless_trans_huge(),
required to avoid "bad" choices when setting automatic NUMA hinting under
mmap_read_lock(); but most of that is already covered in pte_offset_map()
now.  change_pmd_range() just wants a pmd_none() check before wasting time
on MMU notifiers, then checks on the read-once _pmd value to work out
what's needed for huge cases.  If change_pte_range() returns -EAGAIN to
retry if pte_offset_map_lock() fails, nothing more special is needed.

Link: https://lkml.kernel.org/r/725a42a9-91e9-c868-925-e3a5fd40bb4f@google.com
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zack Rusin <zackr@vmware.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Background:

    It was reported that a bad pmd is seen when automatic NUMA balancing
    is marking page table entries as prot_numa:

      [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
      [2437548.235022] Call Trace:
      [2437548.238234]  <TASK>
      [2437548.241060]  dump_stack_lvl+0x46/0x61
      [2437548.245689]  panic+0x106/0x2e5
      [2437548.249497]  pmd_clear_bad+0x3c/0x3c
      [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
      [2437548.259537]  change_p4d_range+0x156/0x20e
      [2437548.264392]  change_protection_range+0x116/0x1a9
      [2437548.269976]  change_prot_numa+0x15/0x37
      [2437548.274774]  task_numa_work+0x1b8/0x302
      [2437548.279512]  task_work_run+0x62/0x95
      [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
      [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
      [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
      [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
      [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b

    This is due to a race condition between change_prot_numa() and
    THP migration because the kernel doesn't check is_swap_pmd() and
    pmd_trans_huge() atomically:

    change_prot_numa()                      THP migration
    ======================================================================
    - change_pmd_range()
    -> is_swap_pmd() returns false,
    meaning it's not a PMD migration
    entry.
                                      - do_huge_pmd_numa_page()
                                      -> migrate_misplaced_page() sets
                                         migration entries for the THP.
    - change_pmd_range()
    -> pmd_none_or_clear_bad_unless_trans_huge()
    -> pmd_none() and pmd_trans_huge() returns false
    - pmd_none_or_clear_bad_unless_trans_huge()
    -> pmd_bad() returns true for the migration entry!

  The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
  pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
  by checking is_swap_pmd() and pmd_trans_huge() atomically.

  Backporting note:
    Unlike mainline, pte_offset_map_lock() does not check if the pmd
    entry is a migration entry or a hugepage; acquires PTL unconditionally
    instead of returning failure. Therefore, it is necessary to keep the
    !is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() check before
    acquiring the PTL.

    After acquiring it, open-code the mainline semantics of
    pte_offset_map_lock() so that change_pte_range() fails if the pmd value
    has changed (under the PTL). This requires adding one more parameter
    (for passing pmd value that is read before calling the function) to
    change_pte_range(). ]
---
 mm/mprotect.c | 97 ++++++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 56 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 22024da41597..5367d03a071d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -36,10 +36,11 @@
 #include "internal.h"

 static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+		pmd_t pmd_old, unsigned long addr, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
+	pmd_t pmd_val;
 	spinlock_t *ptl;
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
@@ -48,21 +49,16 @@ static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;

-	/*
-	 * Can be called with only the mmap_lock for reading by
-	 * prot_numa so we must check the pmd isn't constantly
-	 * changing from under us from pmd_none to pmd_trans_huge
-	 * and/or the other way around.
-	 */
-	if (pmd_trans_unstable(pmd))
-		return 0;

-	/*
-	 * The pmd points to a regular pte so the pmd can't change
-	 * from under us even if the mmap_lock is only hold for
-	 * reading.
-	 */
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	/* Make sure pmd didn't change after acquiring ptl */
+	pmd_val = pmd_read_atomic(pmd);
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+	barrier();
+	if (!pmd_same(pmd_old, pmd_val)) {
+		pte_unmap_unlock(pte, ptl);
+		return -EAGAIN;
+	}

 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
@@ -194,31 +190,6 @@ static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	return pages;
 }

-/*
- * Used when setting automatic NUMA hinting protection where it is
- * critical that a numa hinting PMD is not confused with a bad PMD.
- */
-static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
-{
-	pmd_t pmdval = pmd_read_atomic(pmd);
-
-	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	barrier();
-#endif
-
-	if (pmd_none(pmdval))
-		return 1;
-	if (pmd_trans_huge(pmdval))
-		return 0;
-	if (unlikely(pmd_bad(pmdval))) {
-		pmd_clear_bad(pmd);
-		return 1;
-	}
-
-	return 0;
-}
-
 static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
@@ -233,21 +204,33 @@ static inline long change_pmd_range(struct vm_area_struct *vma,

 	pmd = pmd_offset(pud, addr);
 	do {
-		long this_pages;
-
+		long ret;
+		pmd_t _pmd;
+again:
 		next = pmd_addr_end(addr, end);
+	        _pmd = pmd_read_atomic(pmd);
+		/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		barrier();
+#endif

 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
-		 * between pmd_trans_huge() and a pmd_none_or_clear_bad()
-		 * check leading to a false positive and clearing.
-		 * Hence, it's necessary to atomically read the PMD value
-		 * for all the checks.
+		 * between pmd_trans_huge(), is_swap_pmd(), and
+		 * a pmd_none_or_clear_bad() check leading to a false positive
+		 * and clearing. Hence, it's necessary to atomically read
+		 * the PMD value for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
-		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
-			goto next;
+		if (!is_swap_pmd(_pmd) && !pmd_devmap(_pmd) && !pmd_trans_huge(_pmd)) {
+			if (pmd_none(_pmd))
+				goto next;
+
+			if (pmd_bad(_pmd)) {
+				pmd_clear_bad(pmd);
+				goto next;
+			}
+		}

 		/* invoke the mmu notifier if the pmd is populated */
 		if (!range.start) {
@@ -257,15 +240,15 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}

-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
-				int nr_ptes = change_huge_pmd(vma, pmd, addr,
+				ret = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);

-				if (nr_ptes) {
-					if (nr_ptes == HPAGE_PMD_NR) {
+				if (ret) {
+					if (ret == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -276,9 +259,11 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-					      cp_flags);
-		pages += this_pages;
+		ret = change_pte_range(vma, pmd, _pmd, addr, next,
+					      newprot, cp_flags);
+		if (ret < 0)
+			goto again;
+		pages += ret;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
--
2.43.0


