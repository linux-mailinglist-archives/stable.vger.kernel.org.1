Return-Path: <stable+bounces-164716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98982B11747
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 06:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E32D3AD93B
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 04:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A41A5B84;
	Fri, 25 Jul 2025 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nb9WFKaw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="abQRZkRM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96304A08;
	Fri, 25 Jul 2025 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416129; cv=fail; b=RYtmoprS+wO0R0QHJr9V8U05guHecC/6OEc0E6P54ehpmNVxpjgzRHUo9kmkEd8/P8vYjkGIAfeBdK4bTFnXZZiu9bdVkzlvS+XE79tDTodJ+EzeWsDTR4hdnbsb4J9f1tzgIslpZJ3+n5X5i+PGVqeK47hBFFQXBtqy6GUfk1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416129; c=relaxed/simple;
	bh=Yzz9hi29vZD0U3G+p+bPzR6HiRahhGdED41T+o1qlUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLPibRI3RYAVwSAtM4WkGIZ0CC97IBy++jRg46H7IWaQJ2IYVhmFtmPYUi5RRX+DNTHYvf4TSRtwQKDIKtuU+3j/coE0cOUTPMoJ/aWxkyE7mlYsGQWTV8s2fy70MxvQw1khnL8HZzXuQy6iAvd9JnS1+mA/xOGAzJfqkbrtdXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nb9WFKaw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=abQRZkRM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLjswL011804;
	Fri, 25 Jul 2025 04:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GRBpz4ozCEBjEwQDAR
	gpSFpIEnxSQ0KK/bxounIfl9w=; b=nb9WFKawTwOOPdWSxyBL9cMvBkOD54upyU
	v55E+LoLqv8dTI5gCEkQJjyAD9rb9E7XAgSHCbd3kGfk363Utw17I8Ww1w8v8vD2
	C20QYMkG+R1TLKq/wNNQDWt202M7aDVFTBNpAAQmhTjXwsIg8mTf3R2tfHAMn3wx
	Gzxyou5zrPfbUWIJinnKZhZ0t4WYGhFihYvYwz61+hi6LIk5a/LHXJ2QQ7obj5Eb
	CfqSYGzSZDl2t/lY696tRvbIfMFyJoX3Xc+Jdl0O73tw73dBNkIg1avPb2DBsWNT
	qyZa/Fw0Vg2fBNeMded0fqc3WYiODyx7jtJ6+VzWNQwYYNsRmpNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k89qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 04:01:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P339PY014612;
	Fri, 25 Jul 2025 04:01:51 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjxjn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 04:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qgf6ziPOglckwQP59FMO9Hnl2um6dudifrCYZ78Vqk4ONZMdCKCcLvvWMGVBuyP4jX9wRCX2gR9idW6WqYBU/Q84yZU3DwTAPjgr0aenG2hR4ES4iX9kkKVrW0Sx/HZI9v7tXhlrMqMN/4+A5l7CZOY5FPQoDtzswnpyCP/RxFrCuPNQ5X0AVKNKjm5YImm5aYGNTCnBHx4mfKrFaNwDrmfWKD6CelMEXUFv0zuL4l2V/IsLPnpxCEME6WU2adfJgc8EoEC41oJlTzn5la9iK+GouoOCjg9DN9jSWKJOOiNQGQkp/Q1VqFdTf5yb00qf9C4ytTenq5MPc9taaF8G5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRBpz4ozCEBjEwQDARgpSFpIEnxSQ0KK/bxounIfl9w=;
 b=yGOk8KWgzX7gzMGGQszvY/DLI7x/lqT/J4DjMYFPGEcsau0huEgzYAhciSzhzHBsn6R0wawXgnpPZVZZgglb/e3ZJgTXvvg3KwO3Fn5TpV/FNxQuGqRGBzSqHMTagZQA7dMs/FLuItYvBMhpYRUZw0x205AxmKOz3iPZVoA1glN1PLpMIbVUFD8tcC7abWzWM55FoIlKDY8lfdDhRiviHOeHs2O4PIHL82+4O0wNbiSafabmfS68Tl1kaoYK9897CWrm5Ql5gD9Ald9S0nFpDY2WlhZ8HspRy7cBXbE3VmsH7ffnjqAEWMQ0wBL3Tnn+OUPqUuCRL8MmqIyg+AXBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRBpz4ozCEBjEwQDARgpSFpIEnxSQ0KK/bxounIfl9w=;
 b=abQRZkRMSLusdvCvnjLlDi/7ZJcKNgsg5XY9yXHfFX4MNRbRJXpWdr+YHweKWgVS5TXVFPDJoZ/8r7EzipMZheF61Z/yFS+I+B6GJiS9PW/CSNfWdZboNAQ6f+Ol9qPBln2OHGbMYzG9zHcTKMuDvmZGYTtGdX0QFqdpqFW/8mA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF125C3CCAC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Fri, 25 Jul
 2025 04:01:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 04:01:49 +0000
Date: Fri, 25 Jul 2025 13:01:42 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Li Qiong <liqiong@nfschina.com>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: slub: fix dereference invalid pointer in
 alloc_consistency_checks
Message-ID: <aIMBppTQ-ON7RM8y@harry>
References: <20250725024854.1201926-1-liqiong@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725024854.1201926-1-liqiong@nfschina.com>
X-ClientProxiedBy: SEWP216CA0057.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF125C3CCAC:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9ff8ee-b864-4945-cfb5-08ddcb2ffaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zGTx338ynwMfQctl4fVerYHLYLcCCbYFUpalHHgM6klvRLpvznfrz3UDhb7t?=
 =?us-ascii?Q?pdR0XsLfT90AVIxwXjWHN+Q+YjEn26HH/RW5LI9oytfx+/MNUae4e83BjYoO?=
 =?us-ascii?Q?Tu8Tq5CjEG4QNj9S0rGvrde8AAllnXWFcrhC/3b/gM0SAtJEd1xppPthi/5P?=
 =?us-ascii?Q?GThsg/fqzxQAw2CJWOb593p/VdUIm/vuzQfOwuGC/afrO88i6z5n4n9S7Tjp?=
 =?us-ascii?Q?lli2mJY9CX1fP2eZMgadZo2GIJf9GPDJ9lax76InSb83KffOJMwtiewYUXCA?=
 =?us-ascii?Q?V2qR9zMH8SJHTdwWQMMZbDXkw9tsv4WDuopyFEVd5Biqos8Amsuf03lgWUVA?=
 =?us-ascii?Q?ugjiZFfZkoihyxY1V8LYbt0nNYc8R24JtL8RnAOulGq0KLQk9Fd6553L4vcr?=
 =?us-ascii?Q?bFkuyM6UIT98rbefxN6l0h5BQBZ4Winz6+e9maTdjjBe8sjpOnoHZZUgyHZY?=
 =?us-ascii?Q?mlE9q5H/Nzm7dfhHA4imkSCAckQ/gGV7nDrZ8MTe+7CbiybGOP+4bfFTwBcy?=
 =?us-ascii?Q?dKIvxih25w77M0r2f6IAcBTIK+7fhtDdf+xDxeHoqTQPsO5X4WHYT4tXN+Gv?=
 =?us-ascii?Q?75IEw1NwwkgiOp3OKJIQ7rpht8q5VGeM+rThgiHwr6wbNRTn5Oy3tO/L6ZWe?=
 =?us-ascii?Q?Owk7DWZE3DHqZbm3toMIYlxkreox9gsNK2KRjk0uRq6k81zTtaiLFm4i7ZHu?=
 =?us-ascii?Q?T+wjZ7jg+XtmDemJSznvgEdlzN59FepW5Hb3My22NkxO5WUSccqUauOhPmaN?=
 =?us-ascii?Q?3BhPDtBdMOQq4hVFGAzSGM1bFK4c5EmRBvr6hFEfAIESr2Nnyq03AU0FoMhB?=
 =?us-ascii?Q?HcNW97vsX3DWDRrAJXvLOHV0wI/jxqKsrAJ8TMknaWF9DvZMlK7KnciVwcTT?=
 =?us-ascii?Q?ugSPA3uG1I2CfURxX6nIqe1kUkmwI52bGzC9/SzEAomhvQzl2F0006Q0dBZ8?=
 =?us-ascii?Q?3EQX2EEz/CBVkHKBYRe9mDR3WLdVg++dagF4ndkCdRkN3UaE6BEF1a+yu0QE?=
 =?us-ascii?Q?5T9UV6jRDkwHDu0Cp//Tj7Koj3t8IqigJPnbERuF2WvfcG3HtGc1/wRos2r+?=
 =?us-ascii?Q?UKkyCxL09+8ahvq4F0+vdEN/PwtVRgBnHtA8koPGUacovs/Id4A1IX9qiyxm?=
 =?us-ascii?Q?nys2kHF7c4cgrTpQhxWIXrAROwU3+hXGlupUCgL9bWUjqCCjZwmU15oPPu6z?=
 =?us-ascii?Q?tv0BKWdf4khNxjDKZeDcgwEzGyh4x1W6vcnJLGjK0g778G8YMEMvAU2h0JRV?=
 =?us-ascii?Q?sMjoi/I/TPUVphWqBz2XBLKyPrkSZDvpfiZofig4WuFGa4gzdKzbsz6yjm3E?=
 =?us-ascii?Q?GTMYI2R4xLrdc3XSB082tlC08dziuXnacZ5qE99MPP1Laexu75daGI5XwWGm?=
 =?us-ascii?Q?D1LID8qMlSpBEVVRKqMWTtmPnNmlOMsxgBbq/Owv9zUJjRZ8WEhoyHe2ZgRt?=
 =?us-ascii?Q?kp4lknfG71s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ka802gEIHF37qf2n4ZZBr+JzYh1NXaE0zdYKf3hrXmEz+OkPbYeFd5YM2dU7?=
 =?us-ascii?Q?8g+66KxIgfJdCxGb2lvm8+VecEbtQJV1YZXQtLW53jE/5ZmtdniRtBx4dmQ9?=
 =?us-ascii?Q?gnrN+WHRssJzzICY4WTi3K4i3McZYDiEa5Qgi4x4+54305sLQ1f5LeUtz9pC?=
 =?us-ascii?Q?YqnzRAK6BMnqeQ8QdcM2UwHu1nymQuH8I96E1TaOBT4cBiRePSkbS8mZpo6W?=
 =?us-ascii?Q?cNwllKA74nNvSD40uyK5YRBVvW2X0oZdCZSjofrrMnaxdkmItIonHeAE9GeP?=
 =?us-ascii?Q?gxZaMVNZh2bJ9v52bGxpmQxGGQ5SiBWsl/Vae5qsgXD9gajK5l5R5/JDaNk0?=
 =?us-ascii?Q?f/ypks2SXgyN7ZiEIdUIE0nMybC9KhEQ/YO/l5PSeQ5av2LQcpHaV/OMnFDh?=
 =?us-ascii?Q?YA9etCSri6KZDnV/9W7WEG6kAbtsPhmMmt9tD3JG7q31ym+HXrk6RJDzrYqp?=
 =?us-ascii?Q?Nu5S2ExsiiySkUDjzEkpifhTDT+iCDcEOOY1cXXnna9TP+kfNflLwGDMwgP9?=
 =?us-ascii?Q?/ftXvD2oybFZANSMsQfA4/jrfybWVcnZkxGCQK/MeBeqZScX8w9YnvVCsmj0?=
 =?us-ascii?Q?yR6pH3IU8ZsPHFcSFkv0abfUIm0qcSrcGWsxS0wJ0x0gpz66J4X8DB/s23UU?=
 =?us-ascii?Q?2ITc+dJl++R1bCcARqb48njtbERQ7RgBR/hQ03Dz46tudVOBFFtb5b3B04k0?=
 =?us-ascii?Q?cLp9m0E7vtrTASZoOq5Dmum8dmtZ3m1b7tHaf0Lz/dK+SlnoK3FfhdljV08k?=
 =?us-ascii?Q?RwdXb3cqrL0wM+w/u5SYl10TQRirSlN+8FNJ6ZmZNktAberKhgUSmheVIVIw?=
 =?us-ascii?Q?HSr3p60fyIG+BsWHQAbF371COU4J3dEaQ87y5pLObXtdN8og4Mc+IznnoUFd?=
 =?us-ascii?Q?03IJZQbHs9Xa0g41s4+K2QRBrY/6hUph8fkSiDsUjHNZxz190t9+o58eV65e?=
 =?us-ascii?Q?RIxemRCstjGSqCwv6Z5gtp9TmEbfDLcvFyr1Jzly1fAF3v5t0q1QexoNMGmq?=
 =?us-ascii?Q?LA91ltB7/LXtdPpw7aCAPokk7c8OuyLP5UyhGS+iDvheYqPr6+w2lRXLUnF7?=
 =?us-ascii?Q?BZXzXS7Hj9p45jNI3Qh4LV9PB8e8VDcaGCuc/ysjqZiSryeNjKXWuljLb3LS?=
 =?us-ascii?Q?MEeft0vjfgM6bOpI9FFc8albOsVQIVlVnUb3FrNpONuHOSKaL4qBxSHVYfHP?=
 =?us-ascii?Q?CdSiAE4DE7MtEo04KvZXKwvqNsHOivzH/+gqDdjU4qYV5Ex8sCO1nyv7NQPy?=
 =?us-ascii?Q?li6ujusoum/3mz02+ogZV4gxdA05OheVEA2y4tBDXu58Jnv7Gvx/0JX6aw2o?=
 =?us-ascii?Q?l6CU2H3OFiZ+iYZsUsQvwXwBfg0Ug9aAUwzpXnVMQIXCGyuUJyZZRSH3qa7y?=
 =?us-ascii?Q?eJwvKBCOC3kKSZGZUXVlVJdNYsxLfQ/ePLJnur9Qb6Q0whIBuyVro4IyM4GQ?=
 =?us-ascii?Q?Fb3PAiFVu0+MfXsXxzlVHqCV/QgR3kwNbqAW4TBNgLmS+DmnP25Txx8Stnby?=
 =?us-ascii?Q?KMrzK0RRM0ybbKh0Nj0Vmgck0ReB9fyiVHduadHEypF2o+r/s8zmAwEeV3vj?=
 =?us-ascii?Q?M94kCJzclnRBlWi7mp/b+/+hGPIoTlOo/rcZUot4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VSdcNPREUVYZd3d5n8qiuNFE2ndtY44WRv+Stz6JlPY9Cb4gegNYMuCv7inVQP8K/kOmsmhZKKrj6wXQBlYl1B1nRa/GqdotC5O3ljnGWEylNld2EMKeKuz+i+W2PXO67ZbyENBbBP2mdQ3g1Awn0cVK890cYKVDgYVbWKFBOu7jlJLKx/BbG279ceYfP/9YpfpB0pwRM4qIvIz77kmWfehldniHm+LqE2JOIs3fRcMpBD3qcPGBD5+ufKqWnn2SabVE6QZ1vxfG5Eoxy+oURrjVsCVudeTqC9csTU0qBJM//BUwln/Ii7A4OuOb4HvTFdT1+cdlYPgnQ8L5/rxiKZmNeO9hco2yU3nJ4aDTNri7zFwMFmSOwoWx/wu9JMvwsT2TKCohfT5SyALXHdkbnbMXHiiQI78i/G3HNSeI81b2oGVMKbGgXTEl+2SkaBOV1Tf1NxFQt0o6zp+WD1Vf1mysPZeJsA5N/Zoq/1XWSOUHVRbxLNKFuGmnCjgx/vObbpJeOv6pYZ1Fd/j2EtZThP7Bv1Uif5LxPMaS0R7t90jRXqbDoaA+bGVfuiuoV6O/6bf0P50aJxP1fqrQO4G2iG+IwuFWNPIPWEwR+qG6yNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9ff8ee-b864-4945-cfb5-08ddcb2ffaca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 04:01:49.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfMPVcMco9uiMIdfJeleEk/7XfKYkntSMwyMR8C5AxMpYlVmbwFU0V8XSer7W2bdgW/EJezuriYsEXOmHyoJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF125C3CCAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250029
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAyOSBTYWx0ZWRfX9KWz8nlrrJLQ
 Ouk1tjH2bNdVHZwuaKlzaRdwSnAmuNljx1junf1GTwd1pOoIdUV75rUwrMpyZqLozcJL3ER4MAY
 KSHtMDqCeAmAvBnOMIAgD2L7f8/ISx808kjo8+6pnM7W55ycDnTAcnkZfA50TjG6Dyumzgz9MXP
 Srl+H9m5BVlOdE+bG4Fo3tGTPAtr7zmY/VcpDxGWTQ3sRIDWi8Fc2g1kyvkzTedp+mqt52fychj
 4FW/2b/VbGkK6m6ZgTbHkZbrtywGrtXXFddSGY+wDY8mMITPwIAoW4/HY4vR9qX4AahwUTFBI/w
 kUYRcBFz24PBRWXK/CVpFcD632fuaupbM2zTS541mQguYo/CH3i+mLlHuoJNJz+mQH6nAGk56/v
 Kj5n1qnz890bSToyWZ0kFZzWpiItcyx4WW0HsPPU/v4Ft/YMZ2HHxA8pjuYUloZhZbV3gw7u
X-Proofpoint-ORIG-GUID: I5ZQmETYYMZuxCRfvQLfOOnNyOY-IhJm
X-Proofpoint-GUID: I5ZQmETYYMZuxCRfvQLfOOnNyOY-IhJm
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=688301b0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=SlVAvriTAAAA:8 a=VwQbUJbxAAAA:8 a=-JOcM8_zE7f15fQG8r4A:9 a=CjuIK1q_8ugA:10
 a=qesGs21RGGeVIEdTuB6w:22 cc=ntf awl=host:12061

On Fri, Jul 25, 2025 at 10:48:54AM +0800, Li Qiong wrote:
> In object_err(), need dereference the 'object' pointer, it may cause
> a invalid pointer fault. Use slab_err() instead.

Hi Li Qiong, this patch makes sense to me.
But I'd suggest to rephrase it a little bit, like:

mm/slab: avoid deref of free pointer in sanity checks if object is invalid

For debugging purposes, object_err() prints free pointer of the object.
However, if check_valid_pointer() returns false for object,
`object + s->offset` is also invalid and dereferncing it can lead to a
crash. Therefore, avoid dereferencing it and only print the object's
address in such cases.

> Signed-off-by: Li Qiong <liqiong@nfschina.com>

Which commit introduced this problem?
A Fixes: tag is needed to determine which -stable versions it should be
backported to.

And to backport MM patches to -stable, you need to explicitly add
'Cc: stable@vger.kernel.org' to the patch.

> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 31e11ef256f9..3a2e57e2e2d7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1587,7 +1587,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>  		return 0;
>  
>  	if (!check_valid_pointer(s, slab, object)) {
> -		object_err(s, slab, object, "Freelist Pointer check fails");
> +		slab_err(s, slab, "Freelist Pointer (0x%p) check fails", object);

Can this be
slab_err(s, slab, "Invalid object pointer 0x%p", object);
to align with free_consistency_checks()?

>  		return 0;
>  	}
>  

It might be worth adding a comment in object_err() stating that it should
only be called when check_valid_pointer() returns true for object, and
a WARN_ON_ONCE(!check_valid_pointer(s, slab, object)) to catch incorrect
usages?

-- 
Cheers,
Harry / Hyeonggon

