Return-Path: <stable+bounces-211528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH8+KkImd2kUcwEAu9opvQ
	(envelope-from <stable+bounces-211528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:30:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAB385795
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FE4B3001588
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422629DB9A;
	Mon, 26 Jan 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i0laz7DW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UKcvSe+z"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90682313538
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416249; cv=fail; b=Tri9koCeuUWS/z+jPFXQqt95ItNXeOW60EmivqfYkYwCVHAMJNn92iwlEPLC5/evnH6XzJYOtXqwLdYH/fFIMQzYbp1N8VTVvu7rqPm5Ms/0Kzemt66P4gItnBtjtl9qs14aGhkIYfSqMDgUTd23QziObQ4huFfNiOjvTN0wUqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416249; c=relaxed/simple;
	bh=RDsdQRIQo4iUCW9ie8EZPSYJeNzDi3vCDlQYbgyUlng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uAla2ZwSlDi6aencx5p3Gi6AtTwqWz6cmPyfiYFA2Jao1z/GHZMhn20tLltVDYjTHb4v1+fVOOAw7hr80Snz5zEpoTKJrPGFImp170MdB7J6A6/JKhTMUGnrpPjkDd+nG1ASv0f25KAhF+lNwDncUQLjFnhl6NzeVuTWqbROA5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i0laz7DW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UKcvSe+z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q5HtxM340417;
	Mon, 26 Jan 2026 08:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=g9g1H39ewTTrIaFa1i
	lYxbGmkUIQhGuslevaoh/jFj4=; b=i0laz7DW3UnwKpjU5dTMCObz06qns9lRF0
	2HiMhuEzXZNNIg/XQqsWGUodIyGuvPqG2ttnD+dBL3o9hy/phKDKWntGTYDQAcNQ
	NRFeakE44CHLiVCtsbXK4vFZ1MKrMh+kscUj17KV+NBdwOhSNuUC+Yyxj8bTdIyV
	WJ33KREYmo1wYD7ESZIPQNIdTm4lxBBDryAkqzB7KFdFu1euIIHrz1UEfwTBpN2L
	LSJZiLfbIALcSLWjNdx2QoU6P5xBn5pZdTM3SHUAMJuAFgxp+m1jT9XIbtbQXGG7
	WYnCdHBspdH9pvrLC1tyOnmeef9PEtXpV2e/WvfqmETnLJDdDrBg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny1j44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 08:30:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60Q72dJp010559;
	Mon, 26 Jan 2026 08:30:27 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7qqe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 08:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thThO0UY7xyXxjEdfd9lw+IHJOu28zwx9Ls5Gy/MRHBY/d5X8453soDq4e860SPJ5yxPKuFk7EpUi/JwaLm+UtYwKIlFNYCgoGSu/wDY70Pymk1PmSG5+M6fHJZ/VIGk5uxx82TUvvPUeaH9Eg5O8d9oeVbTIqYLFaCOsjnfRGyWxbjwpbaN9Sp+86vGXQxmqXHAzMA0Tsv9OFioaKEmRoo4kCs/jfQ50SPtH3cPlftxxv3o2vrR7b5JHzOiKzgzOAw6aDLCFZkiTc88PgQm01qDqo2Jz0ySvQPAtpzVqxl7Vb4nijco3kOi8oXzphzqm9CyxlEeDiINSTGOJ++mNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9g1H39ewTTrIaFa1ilYxbGmkUIQhGuslevaoh/jFj4=;
 b=ARa/oFwgZZEfc+jS6m5CWtbAtT03SVt3bp67ujW8TjI3kgIznnLu/OLvYSnk15j3wk7QVwLOqpVNAbSTKX+H/Gkeg2MX6tqP747qqw/t7pk9jpsHl2wh+XRoxRjCbFN4G6uJYesByW8eS6A4nUkQaV4SbSzmvJ8pUDa0XJglHWQ9ebbBRCXeDIqkA42mkPe732P0fufgO4rVnm9hUcPteNaZwsNSP2L2UnJ+2hnZhOHjI/pHbSpn/pyOa3Px/ZAWQKcNC1dDAAloPppYwKZew3yk1j/tNLizqXGp9MelEmqhREo5kI3HE+8OA0C/3K7l3c3blFGg0ZGzyAQviMkn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9g1H39ewTTrIaFa1ilYxbGmkUIQhGuslevaoh/jFj4=;
 b=UKcvSe+zHRuuA7keWvr+fpX5fYexkOIgsn+n+tFQi0tjwWhXsIQaROGwAJQlYpw7BMVyl58o0oTUG3yHb5PaW//HEZ1X2wxgbYOdvdS/sQxvfyOkDrMYxptIHXoPx6x4SOw8DBTqqkhJJSu7dYVr7Jc4tv8Bds6zc/8hQIen7Wo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB997767.namprd10.prod.outlook.com (2603:10b6:510:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 08:30:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 08:30:22 +0000
Date: Mon, 26 Jan 2026 17:30:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cl@gentwo.org,
        rientjes@google.com, surenb@google.com, hao.li@linux.dev,
        kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own
 slab
Message-ID: <aXcmGMlH3sWO03rv@hyeyoo>
References: <20260124104614.9739-1-harry.yoo@oracle.com>
 <2b116198-b27a-4b20-90b2-951343f9fff1@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b116198-b27a-4b20-90b2-951343f9fff1@suse.cz>
X-ClientProxiedBy: SE2P216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB997767:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7ea8f3-d5b5-48e6-e317-08de5cb52513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3qEgpohtmLa4eaNhJyLpwAn3h9kC9qzXsaY55D23C5+TzUw9cjJp8WQqN1HX?=
 =?us-ascii?Q?Mv1o3RZNp/aonYch8zephdu8Bhd2y1dwyeT0dqtcOcr49zvzwCl4fuqB6ngc?=
 =?us-ascii?Q?CMCxogOvtAaHobE5n6h9wAzy2Y5HKDLN45kzdmXNLBXGUaNqRhFJ9QbqTg/+?=
 =?us-ascii?Q?Sinsko6/Up87XlhiHULUGl/rMn4q2TZuOu0I2dHhMKmyX2AvJ29q8lpaaiWa?=
 =?us-ascii?Q?spgiRJzVf1eiJ5nB9F9B/INYX8WCBEtANulYr2SBaLHncRqNVIoUc+pZZtGb?=
 =?us-ascii?Q?yBz32afZnS7uSBBGFpw/U7kuaref9QOPwmRsk+Ym931qQ8O+8oSOgqvIp5At?=
 =?us-ascii?Q?XeQ3boCOndcgj1qCIraGhltJc8mDQM2PtAFrE98VZZ0vCdrDbS2R377DN2Fc?=
 =?us-ascii?Q?LFy++bKizvsLKds48Thg1GYAUNtagSJafVfMwOypIrqWUh/mhOKFw7niqEt1?=
 =?us-ascii?Q?wpKzjZ2XD6GN032z/nMfKaTnvpnvZfYXffHkM2rVUqn9Zgd6qalr+z3/DCAh?=
 =?us-ascii?Q?9Q3u+2ab7ilz9ZeH4jUgrgG2M1RObkuFpU0QIVpkJo+2gEwsmhsREChISoDU?=
 =?us-ascii?Q?Jw9jQ/RSy5DRpM7wbo4Samg/1YROl6fEcHAY0M55ssdMJ4YQQWfL15Mtnwma?=
 =?us-ascii?Q?Ndk6usbrH7bDIaHOSLgmUXCmrghQiOfDJZfjQ4qOehwJJ01ApmaceEkJq9z2?=
 =?us-ascii?Q?8QCGGaiFOszIG0wYWXiPFs4HvKJkBnKsg/fnspAn2zEi9rdk2l2G19TuILOP?=
 =?us-ascii?Q?3XYG2oZzHp+zsAu3HM469SF0+vz+Hr7Xy+wG9wFMo3Q/8xi+DNE0efwk3ej/?=
 =?us-ascii?Q?ywX+rLq214GkMhndZDpmTcUgWOqAWm0ZhfV7OhE/8zylVBR7JlulCT0JOzHd?=
 =?us-ascii?Q?0aw1C+Xd7w4l52/+oxh1PEMtwmWQPN0QXeuH8lAeUpcH6qhaWCfyywq3UkGr?=
 =?us-ascii?Q?Tvh4Xg381g9QQeiK8iihzAcsreNJm2Z0UySbidFww866FoJ59Qc72iEPuul/?=
 =?us-ascii?Q?2grG3uUcUSPkWnmSYJ494fLm7/kioMLlY8XJS9PASqbsOTQvjVXW6fqkf+rk?=
 =?us-ascii?Q?DYBn/V6R6TQKilSdj514XftKpCGS53G5y7HCzSwDxO2BnpAUrx6Q9NtoZysl?=
 =?us-ascii?Q?tujso5riEzPmfvEo0W0TImGU0UK0qXrtc00GqJLSelykoB/7Lxv5wqom40Rp?=
 =?us-ascii?Q?sU/JERQGVPD17PXANsr576VK5muOJmYPW6rgMn7yAcy0FU03fucEfbtJkGS3?=
 =?us-ascii?Q?nWAryuNMbd9C+c8juurGFZ2j5skHnF8VdNwM99fuFj5PLA0wj1rv2+jEAv8s?=
 =?us-ascii?Q?e6odsVYjTjAMiJIb/yd+bZer6qrVbmSt8B4GCpAkto2LK5IuKLPR+khDBAlK?=
 =?us-ascii?Q?sm65d3fdC38y0IlVqhK25zsIo1dBvc/DKmb0NmnqOe3wb/S1OzqZL5+0kWcA?=
 =?us-ascii?Q?DAJEpc5wG8B0xpdiZMYky65YbwvkwRXahDz+T1kKt7S17AReReY16FzmsywJ?=
 =?us-ascii?Q?O63vjnzpy3KPDKdZAa0rM9pBlxS/Fua0t2E+dtxtQ/0gQ/BzNpsmliY/rfPz?=
 =?us-ascii?Q?KXp7DmBlgzcBj/sC6uZgW+WPa3JPaKZYfGfCtz3k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9RN85m0u0kP+aFgXjE2xBuJPN9/c+YdsYPqUEX0Mq3TYvKxFrxM+zRkdEJ/1?=
 =?us-ascii?Q?tx9NB6KByX1Ksv2xcbl9Kn53H+aFBMC8+SNMgzvLV/wYKmeDsXyCRh43fbIX?=
 =?us-ascii?Q?YFhZfbG5qg2mJPoriSdcE3E0gbz6KYAfOdwTWRbp1LIwXtRHGztr9yOlEll3?=
 =?us-ascii?Q?PIJYenmCOp+qsP9dork3/eDog6iZRJ/pnpR6s2EciLY1LMloTjlswyZBlW35?=
 =?us-ascii?Q?9l1PEkLVwAszP3e2PPoxDNrgScX098iDKG8J9aUq7bw0sop7bMxgqxRZ1Yfz?=
 =?us-ascii?Q?4pF0pza2CAfEJXLGFXXoceD+yt1WA0OJ/sMfF+/akEfbdhHTkwdRd4j5miBy?=
 =?us-ascii?Q?sg7CZbgfkxvZS2csO2JFlSJqnwmIK+WtRc6wzLAYM0FAEgpf7mgv322Gbb3E?=
 =?us-ascii?Q?9c3WHjGpg4n8RymLXnQMj6BTUSNVWRW53z0bYjF2iCJBMWwp8KTSg7cI/SDt?=
 =?us-ascii?Q?fjXAe0UvimM0gtQRuRkJA5Te07ChyMqZGF/1OOLiPBrQB0ClhA/RDg3dWGLc?=
 =?us-ascii?Q?UkWXobSbB1emjuoy0nhcUHevbHIIKY7EhJnYqSp7GukbEC5PIhnF4XZJIjAr?=
 =?us-ascii?Q?e+CAkwMm6SdzvUz4ijr7vusVNJ4TTozCrPE7xBzIhO9Ih0gHYwJgURG7M/2u?=
 =?us-ascii?Q?LPfVzzPAA6uJpwIIQFrAHx7FbT+/4G03ReLnPTZn6g2sQlSy0MuUgI2QAd4x?=
 =?us-ascii?Q?im9XzBqyEWjHqAk9Jm0PtT2Ye7lFEiD74yRDmNUk4pR8ibXYFNBvv5i2IPSg?=
 =?us-ascii?Q?DPL79XnUGeijbU/vwFfEyHMeK8SPtJFR4AjqXH8+WYwIf9uJX5kIw34Oeopx?=
 =?us-ascii?Q?HJW8xKpGTo6eZRnFjBFjkppV1ahWOaQzCfE7N+Nac7j+7T5BRpJPfCWPA/az?=
 =?us-ascii?Q?IjSFS/T1jpi6DCfSiR6m/un5cf/J9Wt3dbAuaVGWGbroVgmkpfKEnpQLGyKt?=
 =?us-ascii?Q?kCDu3cM/gLfjwQMXsPDFByVEUJFDONChe6oAIe99QBuK360gQ3swVpyxr7lv?=
 =?us-ascii?Q?vi4kn82hna+3/3YJbEGnC40XJkalWX1iITbBa49Vok33c96VSPtanwZDW2uZ?=
 =?us-ascii?Q?rmWiPG6fmKd6useTwUKEGTgh3MAeZ8ytvvxMmPVYZSAcPQAqtZoT7eCG7akp?=
 =?us-ascii?Q?5Fa7PTEufpP+2z3xRy2X4SJ1u845wP8Kv6PetiWIHVPt/ARsMfg6fG2bf9Jj?=
 =?us-ascii?Q?sbzKLhvsblQuhK/t5kQLC8Qa1oF6CJj5uXaUt7rN3epUsR8Zc3W76MYQgcic?=
 =?us-ascii?Q?r+LFv51Ojlfb5wfMwr3ekxG0yFh2KqJFpqUxdXrOj0oZQeJQ9yy4qRqjxF2/?=
 =?us-ascii?Q?OH2EOjtWIIKlQ31ipQqL3CT4heZObh6q4D2IwQaIjRUWXZjc/ascvK5eC99b?=
 =?us-ascii?Q?We9fvjGWeerk6i5LQBqs9keiIlaHPQsXwoROHIEnuws+h7+KMk6vE2f0Q+Xh?=
 =?us-ascii?Q?jpB/9YDKtIIfwNfFyjA6icBx43d0rAyTN3idPVNHa85DTopUP+4PMBMeJ3lf?=
 =?us-ascii?Q?LkJCDlkUzw4FHxPT68pk86BdXECT014QIVqRFcuJ05XgH9lO7MvZ+5X03Spu?=
 =?us-ascii?Q?Ecz72KOjkycm7t41JcGDi0EJNxAUeKMxXlHEWCt5SPwlXIS81799VXKba+dh?=
 =?us-ascii?Q?1Ren0fsUThhPOVoeEL8enSkIzKBIaqSrNDwskDGLQINd95/4bu+NJRlSetxL?=
 =?us-ascii?Q?RjEbOhAl0GDm8ZFhaMP4gUzJiSUUU+etN1Uhu4cAyc17Y/F+n/1Fm4zIvbtV?=
 =?us-ascii?Q?uFUAKdcOWg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m8SAJ1qDALiw6saiqi4ottY/YzICYkybqim9YJotBRfu9H0YGqLoVIEUGU/Yy711CzC37ZRPkIb1TRkLEAItrFmPV5e3S8AjNN6bYWCz0BbrR5UTUsUwEhOP4D+9AMvrJxKsPtiL2ZgdFGLw3VTBvbmZeBiGwoxDnMP6McVP4/sda5n9LTu4WriiJBKDjCgQ0ghZz+viaXwuxMXjOLmGchBnLijKheY92iDr+17o0E6JsKTbjsa99rnMgLaqFgWvpS0j62lcBPXgksahnHYwlv88aVHFB/uFzezt8TebjBynKhWzjtPkx+OXe/b7PK/gt/n8AlYI6YC6ldAVi9D0+ocCOed9DGGr/Lsh2KMCUEHgonM3DEsXg7xdQYHvWRZlKPjoBPwCgAgZ/Z8Xcwgtj718MW0ytdd3BcFO7bcVxv0oRrDbAKFJO+idLu0Jt+cpJz+eENt/+ESgaInPO7aG0ye46acd/bQfP3DZK6oX7+utl7ajzPLcFQ0ThEkpBZH4fzi53eDm3yj7eH4l188Ik5V6q9nGNZu7jdVl7nsCBEgBDCXvYHPYJDbt3kNZgkascIwcVHG58eUO9BhkmzkJrU/x7i94vcE5MP2MNUqIpoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7ea8f3-d5b5-48e6-e317-08de5cb52513
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 08:30:21.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55yTJMYG+pgR2qVLUK5/3VGy2hbHeHHv/tnrGghuFVpGtJXHahYLxwapTqCQdcHu6GY1hwrrGSgamvz1bYEI4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260072
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA3MiBTYWx0ZWRfX+aTUGps8GW8c
 YtF/QYgjwbyeBs+bjfUNPVTNtmPpOyxPvw/xxpp5z+JyneAyxoJiho2BY+QD8xX6hKwc7ybbnr1
 Hr0lQ1UuuNA3JT2mZ4SfjQtTyiprzjkJdqdRvwt49j76eOQc6GdGS8pCDjEBCzxacG22NCF1TTQ
 vmQ3RR68B3D8RSi96a/nwNuApYIerw1THBiacGC1afZwqYXshE7lvdeSF0ktlOPzAZWDf7Mh/xv
 wFEevymNa2BN+MO6izLSQpfj94zKKxXtLBS+2yR+Inch1vbOQsWm2KiV2pYP5By3BIUzQAFw1Ht
 S/GSn3Kix6ZEacHosK4HG1XDwn2Ck5txo+z7h/tojuGRIKnfWN/r1jIil3IH7kGAmgcO8iWZOMV
 sQubAsXizl/hQWlMSGCUAnrhSWEuOtBmk+I7hTumQby3maO7rkbGz16Wy4key8cXNgiqvZB+av3
 eZMj1xuCn7z28/M9IeA==
X-Proofpoint-GUID: EoB6XIUNRZjg6qF5w4lQSg9PAXE0XrVK
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=69772624 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=YhTC-NAF-ItqzgAtKjYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: EoB6XIUNRZjg6qF5w4lQSg9PAXE0XrVK
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211528-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BAAB385795
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 08:36:16AM +0100, Vlastimil Babka wrote:
> On 1/24/26 11:46, Harry Yoo wrote:
> > When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
> > can be allocated from the same slab we're allocating the array for.
> > This led to obj_exts_in_slab() incorrectly returning true [1],
> > although the array is not allocated from wasted space of the slab.
> > 
> > Vlastimil Babka observed that this problem should be fixed even when
> > ignoring its incompatibility with obj_exts_in_slab(), because it creates
> > slabs that are never freed as there is always at least one allocated
> > object.
> > 
> > To avoid this, use the next kmalloc size or large kmalloc when
> > kmalloc_slab() returns the same cache we're allocating the array for.
> > 
> > In case of random kmalloc caches, there are multiple kmalloc caches for
> > the same size and the cache is selected based on the caller address.
> > Because it is fragile to ensure the same caller address is passed to
> > kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), fall back
> > to (s->object_size + 1) when the sizes are equal.
> > 
> > Note that this doesn't happen when memory allocation profiling is
> > disabled, as when the allocation of the array is triggered by memory
> > cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com
> > Cc: stable@vger.kernel.org
> > Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Thanks! Just wondering if we could simplify a bit.
> 
> > ---
> >  mm/slub.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 55 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 3ff1c475b0f1..43ddb96c4081 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2104,6 +2104,52 @@ static inline void init_slab_obj_exts(struct slab *slab)
> >  	slab->obj_exts = 0;
> >  }
> >  
> > +/*
> > + * Calculate the allocation size for slabobj_ext array.
> > + *
> > + * When memory allocation profiling is enabled, the obj_exts array
> > + * could be allocated from the same slab cache it's being allocated for.
> > + * This would prevent the slab from ever being freed because it would
> > + * always contain at least one allocated object (its own obj_exts array).
> > + *
> > + * To avoid this, increase the allocation size when we detect the array
> > + * would come from the same cache, forcing it to use a different cache.
> > + */
> > +static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
> > +					 struct slab *slab, gfp_t gfp)
> > +{
> > +	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
> > +	struct kmem_cache *obj_exts_cache;
> > +
> > +	/*
> > +	 * slabobj_ext array for KMALLOC_CGROUP allocations
> > +	 * are served from KMALLOC_NORMAL caches.
> > +	 */
> > +	if (!mem_alloc_profiling_enabled())
> > +		return sz;
> > +
> > +	if (sz > KMALLOC_MAX_CACHE_SIZE)
> > +		return sz;
> 
> Could we bail out here immediately if !is_kmalloc_normal(s)?

Yes.

> > +
> > +	obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
> 
> Then do this.

Yes.

> > +	if (s == obj_exts_cache)
> > +		return obj_exts_cache->object_size + 1;
> 
> But not this.

Yes.

> > +	/*
> > +	 * Random kmalloc caches have multiple caches per size, and the cache
> > +	 * is selected by the caller address. Since caller address may differ
> > +	 * between kmalloc_slab() and actual allocation, bump size when both
> > +	 * are normal kmalloc caches of same size.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RANDOM_KMALLOC_CACHES) &&
> 
> Instead just compare object_size unconditionally.

Yes. Will do.
But perhaps the comment is still worth it?

> > +			is_kmalloc_normal(s) &&
> 
> This we already checked.
> 
> > +			is_kmalloc_normal(obj_exts_cache) &&
> 
> I think this is guaranteed thanks to "gfp &= ~OBJCGS_CLEAR_MASK;" below so
> we don't need it.

Right.

Will respin soon after testing. Thanks!

The end result will be:

/*
 * Calculate the allocation size for slabobj_ext array.
 *
 * When memory allocation profiling is enabled, the obj_exts array
 * could be allocated from the same slab it's being allocated for.
 * This would prevent the slab from ever being freed because it would
 * always contain at least one allocated object (its own obj_exts array).
 *
 * To avoid this, increase the allocation size when we detect the array
 * would come from the same cache, forcing it to use a different cache.
 */
static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
                                         struct slab *slab, gfp_t gfp)
{
        size_t sz = sizeof(struct slabobj_ext) * slab->objects;
        struct kmem_cache *obj_exts_cache;

        /*
         * slabobj_ext array for KMALLOC_CGROUP allocations
         * are served from KMALLOC_NORMAL caches.
         */
        if (!mem_alloc_profiling_enabled())
                return sz;

        if (sz > KMALLOC_MAX_CACHE_SIZE)
                return sz;

        if (!is_kmalloc_normal(s))
                return sz;

        obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
        /*
         * Random kmalloc caches have multiple caches per size, and the cache
         * is selected by the caller address. Since caller address may differ
         * between kmalloc_slab() and actual allocation, bump size when both
         * are normal kmalloc caches of same size.
         */
        if (s->size == obj_exts_cache->size)
                return s->object_size + 1;

        return sz;
}

-- 
Cheers,
Harry / Hyeonggon

