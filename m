Return-Path: <stable+bounces-110933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC8A20488
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 07:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1323A7784
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BA118F2FB;
	Tue, 28 Jan 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T5VZYZp1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vfmI32jC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9618B476
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046288; cv=fail; b=NfrdVZ5TnEtrvK9j0SeQpvotJccjt5quIH+F3MFyOob+NH1/K+r0MWENTZJHXXdf+OOPCsgEE6qnW8QxNxi/KbnfQcAHxFOM4fCKKnm42+pdfnIapV/SgUrBKEarLweinI+Sljv2dvnf786BfegxStM4iwmNYISXS2vzpR4u0/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046288; c=relaxed/simple;
	bh=8qgrYdP7dXPxbun8Z3tpap3Y455Xntvhum5Plie0qkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oh0mg3U1CQKImpZM3OthGGtm+rR1jFC407/tcQSCpBPWI4ePXwLY8GLse8p81K/FWZee2NE6aWbrggJk4o8YeOlvTy6MHLt9HZV4nMkCRUZLVgWbFShVTMhvRDjQDrmAOUxCi72M7WjtMk4bpgvfLkH9MIj/T9TV2Fy4nNMz+uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T5VZYZp1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vfmI32jC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S4r6jJ026619;
	Tue, 28 Jan 2025 06:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=BeLqa3O+1XsreiTC/u
	Nr5g3sznoESl5fn4SsSCYbGx8=; b=T5VZYZp1wjMipQYIoYO60CbqL5acRmHwCv
	IfUll7MMMdYOe0MXVWYY4d/3q0eHQ2Yhwrl3LnZtWL3mGFq2pAXSbzD+tRVfo0ym
	U0OQ0I+y+/hm/AujZl76xAghmRBq1pCGuj8e0hHQ8P0zYLa1UQfrKrsVew0V71Um
	juxEYyGBWTv0FYBDUcwC7tcQS3rkqwOkd4fJa86Rop4EZzgcdioHC29eiKQOSd9E
	+b5ceipaf1XDKfptQyQj6GUmImrEnYDTR0bYrwS6L7fm4p1Ra9gRtTUPu0yXyWjo
	GYwPnOtRR6KJi97bB7dXO0Lf0j2UpZuvAyZEmgqi1JZdFmvNc5ww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44erk483xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 06:37:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50S4dEel034039;
	Tue, 28 Jan 2025 06:32:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd7ybgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 06:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1aU6e+VhgkPey0X+O6BveuM4jIuAv42ZDJ56gAwenJCiQYTGs9R4rS38mOh60FT1DejpuF3SBU9ApvWIxM81jrTQcKgAhm7MC9LgQKU/5DwIGK47giLeFJlkkc6r7tTTcG7Uk0eJJwkAWo7thRNQB/qcZZM5S23bixONZBfUg5S8C7IrJanloMvHraoklc+2XevoizUTyiM4ILxpXugilX+MyU+ZZ2QFGVkG6iMJ3Xq0zlLLVekoNP1+lyLpULgRRnfNMIE1DUkNuELfduVJZWOAJxRkneq54TCml3ncvRRkvtTU2XWhS27byz36kHt9BVTzr9rySqihSEkVVLXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeLqa3O+1XsreiTC/uNr5g3sznoESl5fn4SsSCYbGx8=;
 b=aL5G+wOrdCbUxsbvYJsONXyXD+PVWeSGE8lE77XZ84uiXIgJmO7OaUoCzcoECBKvifjqbRKushroSzM1QP2soEAuRQmBL0erTNy2XLasuY+fmd9SMNoHi3LE5aa/MYwCeULT2I4Lpylx/EQqb8NmbTd1Qk+SSCIHMfjjjP9X0B+hQEXq674mMAq5IO28jDGsELU4gBR6CjvFamD6RWe1qmfgyl9CoN9pVLcm57XQXDbr6GH8sMnPDRbScgwlKhQcLAmnweKrW0GJRV7fTh3O3GLMx3jPz2Omu8lA9dYYBosJ0NV9wYyqF8smjzqcVF5fa83G+jAg/zgEmRplPeLmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeLqa3O+1XsreiTC/uNr5g3sznoESl5fn4SsSCYbGx8=;
 b=vfmI32jCUbNOk31+/BBzVX3BsvCOvQYmaenk3+9lnholF5rco2p8EhjoYBEjGbSI4bOVL+EfpdfYcvshLi1pNFzRsG+aRETEp6Vq6r4kWFPCn5BZckIRt2Qd+gRIPZ4zibAKpl9L/49UycXRcaYi66AyDVwN/tTs6B4wjTDKpOk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7343.namprd10.prod.outlook.com (2603:10b6:8:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 06:32:52 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 06:32:52 +0000
Date: Tue, 28 Jan 2025 06:32:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, linux-mm@kvack.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/vma: fix gap check for unmapped_area with
 VM_GROWSDOWN
Message-ID: <83fb89ac-9c13-4363-ab05-a54b0bb1f803@lucifer.local>
References: <20250127075527.16614-1-richard.weiyang@gmail.com>
 <20250127075527.16614-2-richard.weiyang@gmail.com>
 <ae776b38-1446-439b-9597-a83c4be096ab@lucifer.local>
 <20250128033030.syh64kqq3xoigl7v@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128033030.syh64kqq3xoigl7v@master>
X-ClientProxiedBy: LO2P265CA0465.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a8711a-249a-481e-272d-08dd3f659781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r82jmv6BddA/dP08PXUB44uP1ERZUCrH/AZym+vBd8Bg44sGM13Q7U9eLvc1?=
 =?us-ascii?Q?gWq58fD1fqJfmkb7gSwGSoQtV6zLnO7wdywCwSkdMBLOaBfmxEPo6TywZnm1?=
 =?us-ascii?Q?NnHNw/DQtDenQv6EqoIbQ/ydFds2bsds5oQ4BEG3dDOb85g2oh+j5E+cCJ4S?=
 =?us-ascii?Q?w2FPfEWO/2XFi5y+glduo501UNZotjicxzw1T1ZefUz6emFWOXKvTX4HhMQI?=
 =?us-ascii?Q?ba1PlJfBO3bs/f89m0g75Vuxb3V2YKRrt+FGQM8QH9y8sRBAf6cKhExHJ469?=
 =?us-ascii?Q?ASHx5+WR+9Mxy1B+CntlE9GN4dBIPsNdyz9e/v274EMDzYGafE0Oyp7+2UkT?=
 =?us-ascii?Q?NWaCh6nY/fwnm82MHUAZtlbYK5TI65guPb/VkUuWNauEAx3eqwhq5kxH9gFQ?=
 =?us-ascii?Q?mIgSpSYENXt383KISaBa3trm8MZ4cIGes22Xt48yA0FwbYkH5P69yJ30+xjB?=
 =?us-ascii?Q?VuCDW7cBx9/0+69HHlOijUFZ3do0iqyE80FdbmNtXDPDAuuJLWSJwYeHCBGm?=
 =?us-ascii?Q?xS881Mh0srS5UEo5aekp4TJuLYqdSjy5cFAsDhUlFNOv7UwmAyncJJPsUToA?=
 =?us-ascii?Q?mTO5wDsPGXPlyuR4E5Hsd9kYzalESgVU4GdUfcW2zA1F1H64fd6AlvsrenJZ?=
 =?us-ascii?Q?QP0iarnl2FbABUeY9fhWZphgOdgBp9ZSQ9REiZlstV9LAsvCuLBIvCBcCbO0?=
 =?us-ascii?Q?p/F4RWSQP4TfU7EcdEjiSynqNzWO2RcoRhnCTWP0HATjIVKfraoCY3UANuni?=
 =?us-ascii?Q?gbeS6RQn8RFCCndggghmsiT6hNiuOxn3fCUFOnHTtFrz6+8U2GlX9GXYk82K?=
 =?us-ascii?Q?Z/bUZgUynlRzeyfNPstsR925KO9CKPTVrkh7jd+F5tc6fps0MUtypqZHoldT?=
 =?us-ascii?Q?J52bzt3WAIu5xPgGL/RODT0BBQb2H5uww8X+iv7yjB+aO5E8szN5x3dHsQe4?=
 =?us-ascii?Q?a1J3MFSPiy1jdFUoIXV46xG6Bh5EU/qr9RRPX1paH5wHJGsCg+n3SywJ7uC0?=
 =?us-ascii?Q?q0jz/6u+T3rpDaAJZzm8ApVv+LbxaXMVqzipqKYW/YtYinbqQEiIJUlCbHbf?=
 =?us-ascii?Q?GqbNnuCu6D4Ezd+V5LMf502A7f3CN3Fs2ntBfe6cdxE/hvcpppJI8Uh7xKnD?=
 =?us-ascii?Q?ehICORHG5kYp2doiGF6sN3SzukECkq+H/km6XQVwVrybcqgGTNT3v40fufiR?=
 =?us-ascii?Q?5gwt+Yt0gbWwQdSw+3hF0kW+OCFSIdRyeYqGlk0FWneCON7Qolt0IjfUw3XU?=
 =?us-ascii?Q?oLQgpXBrLFHlXWdUIvQbZ3hVxOSgAxX2av1Kt69qTIF7k2cCTrxb/q8FlZJs?=
 =?us-ascii?Q?qh5iUlAXvW4NAOS7yS9h1pIX10RqlmzT+CuAjITGSDhHwJYIn7skp4g1lMQ8?=
 =?us-ascii?Q?TjsoVR7LcozQm06LTNbo8DN8QOs5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZy4JQZXTulmlwHV8BtGzGclVOTgCfm+HL0Sc4BC14GIppKDjGvIiw2t2Xov?=
 =?us-ascii?Q?BjKbORhCgvcRQDv6NEYMbJcwd1wldcWi/pGK/CJZqMi3/+IITRyMzSvKCU8E?=
 =?us-ascii?Q?jvkey1TbTqeHAqMmVQBHFpUrbMauB8He0rOHFUGA2x9ZPgJmNTOy1u/E3QT0?=
 =?us-ascii?Q?xnYCTRRbcno9lXXxR3MUFMOGrazIBcwJ7dxa7ZKZ9KSvvaD8QZlIERH812lQ?=
 =?us-ascii?Q?WVVCYDcs2B5mH/uAg72hOXAOBMrQeEV/31QtHSWHHW5TXm+WkINi9VhnWN/s?=
 =?us-ascii?Q?gcW3c0EZ4tNunBAUIjN4j88s8UEY7T+zG4b/GXYFVeUdd8WUrVVsq1uqv8Pv?=
 =?us-ascii?Q?u6+nneFZsZsHZY/XHvk/HpfWcpgtoKhZkdTjLYXd5dDsabMbrqqGtnx7wrmv?=
 =?us-ascii?Q?7Nb3gOgHGBJ8Abfpbp0/LUnSkPHIu2660WO8NvAzJAbO8NKomsZCQWT0aZqf?=
 =?us-ascii?Q?fM8bEo79MTKQcuL1zrbAx5Uko0vBU5u/axcxZx8rVgRG4FybGgMv7vG1Ihpo?=
 =?us-ascii?Q?BFgpH9OzilisBVZCzsiEYC3gnP9NVuSSwcNHBqWLE6CoZqEjL+GGYn5673zl?=
 =?us-ascii?Q?Xw8JsB5zVHE3Ii6szM7RtsiBpmBo3GZeNYY21GlP4XGEa5kk+fwTLLasP0WH?=
 =?us-ascii?Q?YsqEJPNh5i9UZRrEse75k814kKWiK9PL5XGXjvop+X0/9nCmuc160D0IAymG?=
 =?us-ascii?Q?8RqK0U594Pa1QCFlqz3L7JcAZyV+i8FwIJv5AVTVcCNJUqIWFt44K4ufBxS4?=
 =?us-ascii?Q?QBftZRz10v2oKRbEpJ0d/iqkkqQF/KmDtHdLjXJN7SeGV6XblqBdVoB705rY?=
 =?us-ascii?Q?UYyjFVxmKG1+yoIP8V+XeLtS9mS6NY+nvOOvmHv1GRdBDJcE8Pjg6yTel92k?=
 =?us-ascii?Q?pTxuB9lmEi7MtjFTd0nuFnicun3ee1zm5d83qQ7ur6wacy499Y7gWQIJ+5UB?=
 =?us-ascii?Q?SvzGJ3MnQv3U1NF1woFd0voBVhy5VrGyTd41YT8Draye20KnYlMvEUsDUO2f?=
 =?us-ascii?Q?f1mbxelRoZdlFINBzzZvq2QKYuoi9uPIhGUrMaBkANjT5sz7X6/pGSnr2bOr?=
 =?us-ascii?Q?FBMGF7A+3DaHcTDYvu1WVKI4kWbD/+uLEC4Yg7iGJSVSHH0DjNsDnXWmO5oQ?=
 =?us-ascii?Q?2zcfYTa0a/Nh+brMsEnTOzyppyy9xQXcrDwNGsYq5xhJ+rGS5lK0XBXPZ429?=
 =?us-ascii?Q?JUMryEka4n83cf0f5fVR0jvTEiumr+sdjlZRlaNvqjxMXun16BNCtT/dsCB+?=
 =?us-ascii?Q?xKe/7U49JcGph9Xr1G39NGKE6ejmauMm/XWWU/bd4pPeUavahJask++6F0hZ?=
 =?us-ascii?Q?DuLPKAF6n6DzxCA7HpE5evFxsD/T/uGxOoDJ43Epw5icbyI4axe7udT0mNn2?=
 =?us-ascii?Q?2WvpH3s6oU62D5GVfd5OFXGJjPAYJ/ADFQdacvLnOWtszkox4ptETglLlkax?=
 =?us-ascii?Q?n9dNeFUZkd5mE/BmgynGWnOScmHZ0XyZQPnmB8YVzrcRmEHnxE5ftPTmy+j2?=
 =?us-ascii?Q?D9UC9KojegH3v/gO20fgAoEBniqmMrJ4IVizIG8UwUQ50b/ignxpZAZgq4td?=
 =?us-ascii?Q?YYNy2JFfAOIjZTxa1pb0IiFqTnbUlhK4od6CeQqFT9Pe4DlqUqishcSleRu6?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SrmaKT1UmGVS/pSscUhOMCjKopXbP70bAubQmGXgrMfAOlXS4+VBfEpiTsdSH8UvdYlVnmNxERGezwVjR8w9T/yXxGoDRjwwQnkDKky4keiflgCuJQvTUgbyTSil7vcpoSWCJtHw6DTi4eG9+GBKcrLPrDM1lK11fblHWO549P2S5K5RiQ+3ui53AX82tnYmRfDKlVEnGqSXM5W7QlXk8mWWsuiUyIxTSt59zTzUOHACCu7RIvC/DppAm0c0K/SU2mWEU66aM+BoITqHLurNw6toYXn2jRaOE+WuFTidoznLsIDFwoT6Ere2vCTnEvPBwZdt5Jp4VUQrv0aS1Rb9aZxfbtT+aHSLOTUUcF71QoCZgnDIYzn6TBjq55MMfS9ABJ3HRzbIBRcb6zId8vzY0jrs3b0NY2SYJgqedLG9ubHncjzp6HTd7JY3/9OfpNWNr6iXmitiRUWZP8oLTvNoZbZIPFei/3CQ63pMZ1qH28DLnDCD9TKJWk5pAqqqFUrsZHJU5lM3n8OTVinvv/f1G9I3OSK1I1856s/9P4p/Ql6DZhkbng7JZ8AsUFk7mj8fJmgdHm2BCZOv/3iu9gBYTBkVZIoJwUlO+MXiy4rnJuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a8711a-249a-481e-272d-08dd3f659781
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 06:32:52.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8gB59mgs6Y4wNULlbmQ8slRTUrrLSX2UMkQAZzaddnhFXhN/qsGIZTAnmQqUujx9/VjrGmpkpHbTrJxlawJv0/SGxgKxryb1ELs5ZpUK/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280048
X-Proofpoint-ORIG-GUID: OVSf72YGfNLhKaqgnoUhF13Fjix6fwKM
X-Proofpoint-GUID: OVSf72YGfNLhKaqgnoUhF13Fjix6fwKM

On Tue, Jan 28, 2025 at 03:30:30AM +0000, Wei Yang wrote:
> On Mon, Jan 27, 2025 at 12:08:04PM +0000, Lorenzo Stoakes wrote:
> >You have a subject line of 'fix gap check for unmapped_area with
> >VM_GROWSDOWN'. I'm not sure this is quite accurate.
> >
> >I don't really have time to do a deep dive (again, this is why it's so
> >important to give a decent commit message - explaining under what _real
> >world_ circumstances this will be used etc.).
> >
> >But anyway, it seems it will only be the case if MMF_TOPDOWN is not set in
> >the mm flags, which usually requires an mmap compatibility mode to achieve
> >unless the arch otherwise forces it.
> >
> >And these arches would be ones where the stack grows UP, right? Or at least
> >ones where this is possible?
> >
> >So already we're into specifics - either arches that grow the stack up, or
> >ones that intentionally use the old mmap compatibility mode are affected.
> >
> >This happens in:
> >
> >[ pretty much all unmapped area callers ]
> >-> vm_unmapped_area()
> >-> unmapped_area() (if !(info->flags & VM_UNMAPPED_AREA_TOPDOWN)
> >
> >Where VM_UNMAPPED_AREA_TOPDOWN is only not set in the circumstances
> >mentioned above.
> >
> >So, for this issue you claim is the case to happen, you have to:
> >
> >1. Either be using a stack grows up arch, or enabling an mmap()
> >compatibility mode.
> >2. Also set MAP_GROWSDOWN on the mmap() call, which is translated to
> >VM_GROWSDOWN.
> >
> >We are already far from 'fix gap check for VM_GROWSDOWN' right? I mean I
> >don't have the time to absolutely dive into the guts of this, but I assume
> >this is correct right?
> >
> >I'm not saying we shouldn't address this, but it's VITAL to clarify what
> >exactly it is you're tackling.
> >
>
> Thanks for taking a look.
>
> If my understanding is correct, your concern here is the case here never
> happen in real world.

No, it's not, re-read what I've said.

I'm saying you have completely failed to be specific in your commit message
about how, what where and why the alleged issue happens, forcing me to spend my
entire morning to figure out what on earth it is you're trying to do.

I also (but you've clipped it) say I think your solution is just wrong and that
there isn't an issue here.

I also (but you've clipped it) say you utterly fail to explain what on earth you
are doing.

I also (but you've clipped it) say you assume the start_gap can be 0x2000 even
though it can only ever be 0 or 0x1000.

I have taken a great deal of time to specifically critique this even though
you've given me little to work on.

I simply do not have time to do this and in future if your commit messages are
this bad I will just reject your series.

>
>   We are searching a gap bottom-up, while the vma wants top-down.
>
> This maybe possible to me. Here is my understanding, (but maybe not correct).
>
> We have two separate flags affecting the search:
>
>   * mm->flags:      MMF_TOPDOWN  or not
>   * vma->vm_flags:  VM_GROWSDOWN or VM_GROWSUP
>
> To me, they are independent.

You are simply reiterating things I've told you but you failed to mention in
your series.

>
> For mm->flags, arch_pick_mmap_layout() could set/clear MMF_TOPDOWN it based on
> the result of mmap_is_legacy(). Even we provide a sysctl file
> /proc/sys/vm/legacy_vm_layout for configuration.

Yes I know.

>
>
> For vma->vm_flags, for general, VM_STACK is set to VM_GROWSDOWN by default.
> And we use the flag in __bprm_mm_init() and setup_arg_pages().

Yes I know.

>
> So to me the case is real and not a very specific one.

It's literally very specific to the point where you have to enable a
compatibility mode. As you've just said.

Sorry, this is unacceptable for _core_ mm work. This is not an area where you
can provide nebulous and vague commit messages.

>
> But maybe I missed some background. Would you mind telling me the miss part,
> if it is not too time wasting?
>
> --
> Wei Yang
> Help you, Help me

You have clipped the part where I point out that I think your 'solution' to the
alleged 'problem' is incorrect.

Honestly, drop this series Wei. The finding unmapped area code is necessarily
conservative and fuzzy as it accounts for -worst case- alignment and providing
appropriate gaps.

It failing to find a gap in very specific and awkward circumstances across the
vastness of the virtual address space isn't a bug.

