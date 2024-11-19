Return-Path: <stable+bounces-93997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB019D26C8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0554C1F22DF7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3451CCB35;
	Tue, 19 Nov 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aFv12mwQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LnN/E46E"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3111514FB;
	Tue, 19 Nov 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022705; cv=fail; b=B6JXFn05voi0gmomVb0xugHuBswIVztE7yfnikNHGywoc2L7IJsDWVD9EKE4fzWcE1mV+lsT4kjUtYHcbPnLq8jd34pTUviMtMRcqZhFieFy5g9TgCRl+WvguSdUDE5PV5AH1etYqsdsniIwXrYUtbog1S/mBV/ku9+JBZpoEzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022705; c=relaxed/simple;
	bh=tbb1hU7GeJMzNrKKw23/6fcqTjaQXx0spDqTqMI/9sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyM+U9Fat69cYnVKB7w5Vdm9ju3X7yxDySqmJ08T77ncfsk/QDoCI60M5paQFjjlrCgl29YWAerF0tiyS42A4onNMLz3WY0krHd4ByLyQojuFYlzM+D3nLvejDG5Tc81Dy2vWvJDWwW9txzLWzVDjBS1U5O8VcmV6TGbjuFGNfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aFv12mwQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LnN/E46E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJD50HR002186;
	Tue, 19 Nov 2024 13:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tbb1hU7GeJMzNrKKw2
	3/6fcqTjaQXx0spDqTqMI/9sY=; b=aFv12mwQg8FCTbAANNDp51hJbV1HThXy1G
	O+yuEdb3GOG0JYOssm9RJzwNyLAzTlazYge1Gsf26UDWDBgxz+4LOWwhyT/d1X/J
	/TOXl52TPTMcUvwDn+JF5Nz4Ovwc+VEv1lDas7zCBuYqtiP6RMjfqOkI+FIFj0bb
	qB4SZQ+ewRVVUiZbMp/o0vLjL2gA2h9z9NGII4PpHjX6xVu5PbapGlcV4LoYqfnQ
	f4KOaLwNdba7HyQtNv48ZvwTx6FNJ9Ysxq+lCz29sUMok6lO9u1J8nUKgtkYs/Qy
	Oj6vKqodX/Kj/be2t9GDh8SPkVbRjQNsELsgDZPaQDl6mebKEN8Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc4x6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 13:24:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJBYr30037149;
	Tue, 19 Nov 2024 13:24:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8hyn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 13:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cntdAxUAQBaj0Arsevwmqj+41PimCrAOp2ZENP7Xdp2VJcI/sC8nmOSy2yHT6Gi2o1R0M0oWMtiQV2ScPcphXONXcwy/yQtnoKUp9jyexI7IXNC/V/XBRH+lRajdx8JLwQp4DSV3+XL4c3S+tLj6j07E3DDtcqVJh1YJhC7Y00UqYfXjsra+wkIRIRY9oyoIUFsoOv3Ei0YtioZDS+GbTc0L2+tV55lKWccjnQUdzaCyG/0vIxMU9LVqLloKz0g5TCLK3EF+qNpFhswQkNg05APRIViVBjN8Dc6lo5q5eRuQ50J5g/XlzTb9jAteNIXOoSqnoTC4kisyj0nFBXwNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbb1hU7GeJMzNrKKw23/6fcqTjaQXx0spDqTqMI/9sY=;
 b=dCLjUaKlQx/JukHJg6TrLXm1gXlLHdgGSgd+sdOKxhPQJqh89t9AR8aVRFTDg59irSF0Nyh9ep/qxNSVDQXoqNXoIDEN9e6qhkGkU9IuPiUI0x03JcWhiVUOA+7ALWT8/FYOCknc6KIc22fpqwjkECoTqrZhGTdOnrlHCUOtu1DCmcTvAcaaVbCqOpY+hbG/8m+E2RAop70VR/1Z38ZkKlegnr8wXO2B7/aWKmoQdlpi5MsfqrwR8tqgsZ/6Ql9psGzcFQ0rB1SAVAiXuwhIEy9qdSD10xdYI6dCbbUVF7SDve2fhfZJu78v/kDGtMKqprbbPVi1e6XQCwexWZmEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbb1hU7GeJMzNrKKw23/6fcqTjaQXx0spDqTqMI/9sY=;
 b=LnN/E46EtQutb3CUE4DPcD4rSXa/w8IRbeAow79H1JOEXp6ETdLGj2sPCGpnQdGShWXvUmfr3DoqobTNeHCXafdUhERWNQau7AGgeHoCSNEMChOUcF+Pa8AxyyI21Xe4vG3Y/j+Oa2dH45F61mYNgS4oLfwKCuZjFX/DW/JdChQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7360.namprd10.prod.outlook.com (2603:10b6:208:3d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 13:24:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 13:24:36 +0000
Date: Tue, 19 Nov 2024 13:24:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.6.y 0/5] fix error handling in mmap_region() and
 refactor (hotfixes)
Message-ID: <7189585f-d6a8-4335-a78c-547ce468fe0b@lucifer.local>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
 <2024111932-fondue-preorder-0c6f@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111932-fondue-preorder-0c6f@gregkh>
X-ClientProxiedBy: LO2P265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e1a776-f05a-49a7-8399-08dd089d834c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlbFJpGz4hkCjQFHT+sRKtGidj6EkCVaw1cwCOm/an5OJDo6ZPW4YJuaxjTE?=
 =?us-ascii?Q?b6h04rOjr49f7aLOCQBkjghEm3DwY/US8WHB+FeLlcn4ZWKuauWnp1ViH8Yu?=
 =?us-ascii?Q?r3u+wd3fOgqCdId0kuLSXs9arMOEeldH3mZ/56llwC+oYPwaSxKtwgiFFIuq?=
 =?us-ascii?Q?O7+QMtAx6rzB6/o0j5RZGEbDu6mblxGlyVPtVPdFkA9TGRw9Q9PV1/khl2br?=
 =?us-ascii?Q?62Wv38TFCMPc8HOqBF6mAL1eqU8dFY8iWef6+v/XfMLwNmFwdpArBjJE+x+2?=
 =?us-ascii?Q?pK0TeYgnzKju1Sr8Q3POzAoiLCpZZWvEJ7esxzYgOkHEpTnhjHWqrMdYre6O?=
 =?us-ascii?Q?2Zx9Oql2bZpeWvh6/8g+Ke3Dtyep4Mj4uxhsb1XiILv2Ko3xarnFS8ZbXhOP?=
 =?us-ascii?Q?fmnPOw3CVS4RAIaNDRzWop9KE3sVNjJxdkhFk6hUYYoGVA8FgTGCMPGK9F20?=
 =?us-ascii?Q?kCAphjAHeDBEr84eX/rR+Oqa4HJXMlQLhXvNjpRR2q5weOMZEcq4zej6fK14?=
 =?us-ascii?Q?DvTsSV3dj4nLr0rlx2NKazPHyZvIx0oIfLs/B7nwZTEoMTRpsxV9alccx8A3?=
 =?us-ascii?Q?yaXhOM0jXt/D9aRDireMX1qovu4105uAa/lZZ+qm4JvHXUxQT1aXID3T0KEh?=
 =?us-ascii?Q?5KM88mk75YI3x+dbSmTfrwhkyNdiVHBPiO/Iw+MgTx4Tj1skCcqsZ0WKev5Z?=
 =?us-ascii?Q?/kUr6GIRk4GOoB52TwPG9CbKPIEYLamIl3zt6rFsltyKtlMstoNf1xRYBFyp?=
 =?us-ascii?Q?3ZFM6XeD4yQGCM8jp40P6nZQOPeEX3Pv5D+SimCF7k4R+z28QGd6tzzTQtXd?=
 =?us-ascii?Q?uadYMhtSwuHXZw5CywY29/JxHtH51M30OAbY9Cu4P4OWcGSwO+cnSQBCK4BM?=
 =?us-ascii?Q?1HLI0PzL8jCWU2Fd8m/A4FLfHrzShYnaB/VMSFQXfnpxeACgTYCQdooz0bDu?=
 =?us-ascii?Q?PgOfn0sRF15NpxLPsjfJQ7/Ym7Gc4CAA6Yv7+Nzdvv/IcMtSWD4ICWONUz2f?=
 =?us-ascii?Q?v0MJd5S3HMi2AAFDxr/mqrgdC06zO+510EAXBEKJ7ynCy0dgI67jB0x3wfUU?=
 =?us-ascii?Q?2NvdaKSaMfcMLDpSFjhBkYomNzadngHPXfSkRRNuHxoj9fz4uecwGruhUwJF?=
 =?us-ascii?Q?iXrXLiwvNpo78R2S4Pmbdtttzm1Gog8O5N2xHI0atWaIyF0qHj+Ac9SSWt2W?=
 =?us-ascii?Q?ZfyC6NB1xgA9bsqTzlgK7TVRVrcW81AQL9HQ66TyfSHBuDXK1PU0YCprlj5e?=
 =?us-ascii?Q?HeVC6xXF/H31WnstjsmzIR/4ngwUeyHoupQrvrDPU9HE8O4NQoVcGABYMjYk?=
 =?us-ascii?Q?I9gdbf4ERLlH6TfQSUnd3+ku?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?noZpI39UiErrxyEtFt1aFIyAPVOOw38dadJ1hPZaEF0q/ebBPhffM/tJODeW?=
 =?us-ascii?Q?AYejzZAXH0AXD6shqLnonMwtLp6peR/DCE47npJmiEzKMTo/RmbCZ098Ze+K?=
 =?us-ascii?Q?rxNHKvd+eOkSWWOg+YJjB7aQc0k3aKxs28YLLO2SwteJ074IDotwvFSNsN2a?=
 =?us-ascii?Q?5ApzI1M6Q4cfo+RNrs96cd7wqDY361KcVvmj5WfQHTUse66y9W5fa4OLXZpP?=
 =?us-ascii?Q?TcMyoOTOZtJIMPHaTirFkuc/+JxAKaYiZCTr8NV0nteou4gDdL54vVJL59+W?=
 =?us-ascii?Q?GZwF1UngNsf02egtjN1368x1kPMmRDk2k7iBYhEwOQu5WFJ8pbMT8pd/n0vD?=
 =?us-ascii?Q?bxeZApN9fGYX7+6O8dBsxPnPL/4UBWPQh3utJ+UE/9/VWC8T/JS2emSBW56y?=
 =?us-ascii?Q?dTDzn31Q/Adz6vO8XbAPY1xiVnzF1vYkxHCGgSGYyv5Zr0goTYyyWJ/JYC+O?=
 =?us-ascii?Q?mO0qnUWdsP8guMZsLQiGoZoCZNzyPb0kCVq65pGCg0EdWUNFLN7zkcPaeKOn?=
 =?us-ascii?Q?fiYsdPqde8zkYTQtIIJlzxbOInezZFDryhGxIAY70aaL8+WL+sB3ndSP//JM?=
 =?us-ascii?Q?su+5Oh1GpnNqyZfodD2VjMrJkKTm6S9XX9SUMysu7to1uf/BHxyyfrS4GxBv?=
 =?us-ascii?Q?2uj8721vwOfiNtqWNk/G0TsUwyp6sQXHlAPUM0QJcyKw2SqMzDpO+dlHHmDA?=
 =?us-ascii?Q?QBZi6Zr43YPU9iUUcj/kS5NhaOn8zXj5lgu1qfg1zqZdkwDa6Md+j/cvydHA?=
 =?us-ascii?Q?eKa8AkMRDX1pswJjand6+cJGv4QD04+rzRTWmGWAv+kktdKbXCx8DB+wdA+W?=
 =?us-ascii?Q?LgB8f3RzVI+rapYN5si4Ruecf/a0jks7CtKP2qHIuI/2OfiusAJ0y0j69U7q?=
 =?us-ascii?Q?/NJTBDsCpVxAjeQ9p+lho2PAN0MjI9kGicj+xDZwZQa9tLjy4cj6pzl9kaqp?=
 =?us-ascii?Q?pI4d3zYJA1g2QEVNLCzIV8k1At8q3Qr9YWi23RkalMXht1t/Cmlds640VmFh?=
 =?us-ascii?Q?bngkggmPixdR7YZRSCEbUR+ADyJkX5WXqit1NvRLdTYN4J3pXnvDqFK0r5y1?=
 =?us-ascii?Q?eVK+FYnrHepZiPKaVEGaBoBpl8o4h9mKPwF1i6Jily0vzHCYVcJzkLdZv5VN?=
 =?us-ascii?Q?mkMYBi+pXEXpH3m4BL+GM/X1rOsjkp8xRtd2Ii0cdtpsxMeLqOWp9x7gltUn?=
 =?us-ascii?Q?2xRT2UTy9fSTrJ6q2UnMQMOMuNRkITtZEfmFDjNNeiJ8NFAnKeHr+OdqgiZk?=
 =?us-ascii?Q?nZsSjoehqr+euB+HFjKEaR1e31mqXZDd/Rwk7bV+58dCSkUAfgVUC/TfKPO/?=
 =?us-ascii?Q?Wlxdxqd38AzQJD3XNE+5vK9dHLSMQmPUzMoDzxumDx+xluNs5BElfabG4hWY?=
 =?us-ascii?Q?//VirlAHedFoSmcNu53VziERcvZis6kf8Lv3HpynBcceRsGfTeFKUpAFwWp7?=
 =?us-ascii?Q?gjhcFePmLViX+SgZFudTNZngYEBImD1oqe6XejLpf2kTZARhbAmsvgaezTAs?=
 =?us-ascii?Q?NavbkGdyGRzjOCGa6EH2/YhsVZDte/gVclO3J+9oiw0KkfGaztUNnOdfAgKu?=
 =?us-ascii?Q?ZPukq4/e4OiotRVGKQ0dANSD+0kHhQlcQyez5isLbX3BmCzzaQEXVTYPB2UF?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c5RhazEpzyE+ukZKolO/IrJlxmxyOQ5Xj007rmHQhCZ5a4j9Nd/uc+DFB3UWUpFxFTsNsYT+WoOgkCLS8m8dLg6/uHB3e9gmsxUrSTc3Jjho8DreNZA81F+jsTioQ6lAR1Z0D7Y8NWGqoBdwjHjrIE66anYGjQ0OJO0jMfQtCRDLT7G/mtvjKsfplAKA7iMDypM48jD5t98AvVl4H+foSrQMAs3pExoLn35/AQJPwDfgDNhS1KFnjdwcAwpjQiCSNBwEMWbW8i1K5wcYInrzFti4bpApcEGAvd1uq1ghoQ5uuYokOlfdCKQEVHCEWjiz2rKn3qxeW9CcQtXEYmQS8SU2Pp3LckuLmXm9jBu5GxTejk9Ll4mXtEt0VTvvsKJ/UcRZw9qfjP0CPncH1cj6vQWObnwXT0C3kF8N4l3M9K6tJLwi+NdB75v9UFiT8z/pescjU0xdzBZ58NOuAOMYnHDctfOjGxUUGPXEtQFQEkKC71VHnGCZhmC30a/Fnmm/VvAePXWPO4LIc1fQKo8CaFlIy8PWyVbH3c+tU9nNZsdZWfYuYHQWOVNQwzDTFIrceNxT+PS8QcKs3hNXdzACVF6vQYAyXtkhBBEpuOl2+T0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e1a776-f05a-49a7-8399-08dd089d834c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:24:36.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCA+RwrCksyHh1sWuNBnqM2fAqeMT2iL9lZJQL5bweyGmj9FMGdPcbhEs9cZsS9XzFDDhNwhzXzJlLCwk4CFXZmhmAdbINr9MklzKHigVdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_05,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=860
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190098
X-Proofpoint-GUID: m5iEjg2njdwNE76URk0YdI-wUzpDQ8X0
X-Proofpoint-ORIG-GUID: m5iEjg2njdwNE76URk0YdI-wUzpDQ8X0

On Tue, Nov 19, 2024 at 02:16:52PM +0100, Greg KH wrote:
> On Fri, Nov 15, 2024 at 12:41:53PM +0000, Lorenzo Stoakes wrote:
> > Critical fixes for mmap_region(), backported to 6.6.y.
>
> Did I miss the 6.11.y and 6.1.y versions of this series somewhere?
>
> thanks,
>
> greg k-h

5.10.y - https://lore.kernel.org/linux-mm/cover.1731670097.git.lorenzo.stoakes@oracle.com/
5.15.y - https://lore.kernel.org/linux-mm/cover.1731667436.git.lorenzo.stoakes@oracle.com/
 6.1.y - https://lore.kernel.org/linux-mm/cover.1731946386.git.lorenzo.stoakes@oracle.com/
 6.6.y - https://lore.kernel.org/linux-mm/cover.1731672733.git.lorenzo.stoakes@oracle.com/

I didn't backport to 6.11.y as we are about to move to 6.12, but I can if
you need that.

