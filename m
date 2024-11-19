Return-Path: <stable+bounces-94042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEB69D29C3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352C6B3514B
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFB1CF5E9;
	Tue, 19 Nov 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MwFflXAg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n76FoUHD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85D1CCB35;
	Tue, 19 Nov 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029430; cv=fail; b=lM2c2Pf7W7d1wHxnKUkPrLqCoU7pO0siCUPjy2X1kARYpI3LqMfNYC0JrG73Z4pre3MZgwpoOsJdCva8TPvUwlZwY1sNgsst5q/agDe+ifx4Pb6Lxym/hOxslI5sfOS7OVOlvzGpoTxDvNP4jTj/8tzXHpO4DFSYYnrCE4sjPkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029430; c=relaxed/simple;
	bh=5UdbwczSRrZvvsLoWGA+mQY8Nn1iX+fTMAe4HkjDD6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+ZM4LrQITEQitjK3R89gJO2scr/fZizt5P5bcxkn+F03GLMipVNFIa2FxHPiCzdU+B1XxlCJarHjbYZg+Fxivz/BIfZrCc4DctWs0meD0X36eC//+wCkvABCHkU5i05IKbvaH03Fa1iGahdm4FKBMJyZJu8Szyky4D1zlVIPHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MwFflXAg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n76FoUHD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDhNA2001615;
	Tue, 19 Nov 2024 15:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ybAhFSXWvNWd0cKlxE
	iDnAmOoW8uMeolLQXhf2xsjLs=; b=MwFflXAgsELKsfDde/LclNQBBNqz+WQ4il
	/+3UbHM4ZHQK+Y5JWc51tSOm9BvoNCfWBJb8sGL1BErYE/qrYS+sSyv13tIykCyZ
	yInWcO+fuJUdwAnn0J84UCrzS57nKakYhBFMPj+kVwSjVqKScY/H8zQ/+qO2K6eL
	0XUTiU5O0RPcsBIn5M7mdp67VBrcUvX//9lRRkyEYb6NtAtu1cDDHxdp7fjDe1kL
	KFr9oycMFHq5vKHUvHt6atNwahlmHUp95725wEHN5QSJRL3r5s/7I87cOC8ELFZr
	1cNlFxRtuVarugvpOTRilGywmZEQM0qd64vSUojy36CINWy+1D6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa579j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:16:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJEB6En009019;
	Tue, 19 Nov 2024 15:16:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8vdpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceuR+kpetw14tYfW+5ePw0fSIwtKrzBsDXkd7/jE9O+/yQb3VxRgZbvgU+uw74wH7pZhBcHkad1eux//vhsiCcgkQnjtGlt78wKzcNtYXWxp4Jhho2Kjn3wq18AAA2GLOdosO22QtPkjDXg6B44lJKXRlbpw27FjCMMJ3TigMCSuQv23LhJJyJ/SACDJ/xEOFB+KmLT4HBixCzP/D4AhvJljUQ++jlROHwDRc3ksfRsCh+LTbVVRDXrIhlaRHK3G2+Y7nYa2tIIe+VdX8vNtdVE7cGgWBGpkZeQp9IGfoNTlIyN3gPwcCk5blUOlHazlfPyPIOtSANARNC1Em3JNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybAhFSXWvNWd0cKlxEiDnAmOoW8uMeolLQXhf2xsjLs=;
 b=pVMsUlXezB2qwOHef/uwiLjAK2usRDenoQ1VtlnerYekPk6Hn3UMc+SbVRn7O3dBeBh4vTJFovj14jO7sVZJzXH/nMTm+AfFRiVlgmnR1KUM63ZUSOH244myXBtYJa4I8Z2gUkpUeYAzvpzKYB0tKmZBE4mSPm644KNyEQUzj6zmdAa9u8sPgTT72wSyh3TPD+MDN1lZJIrGWsghm9eZt0mt8tfVwfYIRLA6tralcYmZuCX988+rr8FLoVj1K2N7PFoeEVNa8ZyKpcDHldwVNJbHkTtbGpWqMJGaUpzUuIPx8YImoEyaecAGvhr1JmhZeLb6ztJ2HSmfyENSgzA1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybAhFSXWvNWd0cKlxEiDnAmOoW8uMeolLQXhf2xsjLs=;
 b=n76FoUHDjWus9czskuSKgAe9mUA6nUTZbH2rIdYNeXhBFVH0XnPWrZ9eE2iyCfS5vQcrfpHxPA5Xv7Y0817a4ogdbQeeb8Llom7Wpw1pz84TVEf8LgE+6S7ciQt1Cur4mD+pOaVOvq8R8ZW5NKgUmnbP0opQ5tDQlB9EAS3LEg4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BLAPR10MB4948.namprd10.prod.outlook.com (2603:10b6:208:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 15:16:51 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 15:16:51 +0000
Date: Tue, 19 Nov 2024 10:16:48 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Message-ID: <ch2lsauvt5zflpbsfpop5wnoxqfbx5p6yvf3wervzdkbrtmj7b@p35knagkslw5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com, Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
References: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
 <989cddf0-a3af-4f84-8b68-876e811a8795@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <989cddf0-a3af-4f84-8b68-876e811a8795@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BLAPR10MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: c096a3b2-2b97-4ff2-77a9-08dd08ad31de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yVCIl+WuD0+3hPCcDtOcnDIp4+K/0TZPduG4LlPENw37uiSDq83bo4mqR2Ci?=
 =?us-ascii?Q?3FLU7Vdjto/wmAFX9+JeWwelYxPGPpRlSGL9ikTpf8JU+wXLZhr+oQqGqb2+?=
 =?us-ascii?Q?aArhwNydYbN80H2kcn5S7cRHW783HHSmQnHoJ9xKMAqJLNuCq+mSAb9LIIYJ?=
 =?us-ascii?Q?GCpr9ykA98k9hkBHukPRnaVfymmA7D32H8tyeJwU4DTNptEx8a9kA4/RBImV?=
 =?us-ascii?Q?aXKakryUtmMbFC9q5fa4K2klOH95OAcuz1aNOiCSzhNKBHKO7r2m9bcArjxx?=
 =?us-ascii?Q?k8cMM84TWS3VxC5s/wRS6jPqnv+YhDbtzj2GbrXZr33rWdY5nxUoZ4KtgjQL?=
 =?us-ascii?Q?E3NwCpoOUoiH9WBjCZO0Bz9Jl1jCiFCSLWqaGdVdBEnm954kVPVSWU+r2BPg?=
 =?us-ascii?Q?wChTvdN+m+ft7jl5RaQQu4HlrgzaumlDnBp/xljcUZvexADpZsqRk98/VrgM?=
 =?us-ascii?Q?SXK4qmq7dz3lsQI63eKnuF0a98JFOvyk2gV5We4aM0k0f7Y17vPQCUBfZUK+?=
 =?us-ascii?Q?HE3pLKMwZhuEFaqNPmRXtrf9dzVLF/f1VEZpypV8fzSg193ALxquFja2VsnZ?=
 =?us-ascii?Q?HKhdf+dyXbJRygT5D4p9U/VIr0ZvFAbZMmt6IVMHWo74YW6oUKvsZaBCNiY+?=
 =?us-ascii?Q?FvpK5B7S8NrAsnyoEgyPXSqBmODMWEmTjI8KViz/87PGcHbjAuQvactqhgkc?=
 =?us-ascii?Q?HVTCJvHMYd2wLKSPFaITH1NbanuOrHOJD2KMEQalO/baGAz7MAKre94h2EI3?=
 =?us-ascii?Q?ktn/hb1DVRxaTFcI2nVfRRA5fLU7uyfTI970gYn3HI0W/oYoFR/LbBI1NkJO?=
 =?us-ascii?Q?Sy1TDJU8j5pHYpjMsCUH+hvynbUMc79baGO+BZYjrvs9ZbNKnRAj1P5wEnfB?=
 =?us-ascii?Q?qhLbgz6XtUxGuFzgJjFEHZGVt2m5pKYUhzfLigXbX3FkL5Zlgv2C6uKA+HVC?=
 =?us-ascii?Q?9f1M5LL9bCVLcv3dsIAklXu+2jsPFD+5AbBs+nY169hBvqjYxTCIkiu0Lf61?=
 =?us-ascii?Q?i+YSKxzWdJE/lE7ijIvkVg8IrV+HUHzXPGPPKbvYy4X1zZM4thQbJ1jYcsSJ?=
 =?us-ascii?Q?UROZ9IyR37isGlppCtaoTRb+jPhrwLip0lB9XPeuuInVuWDgh+Yl96s+y15O?=
 =?us-ascii?Q?J6l9K9f1St86RcxGBKbTFY8xWIaYeiBGP+ge5pxV0D6wg2YLGYfPyW7YDtAc?=
 =?us-ascii?Q?Kf5WAkCoXkauppq6LxqCSa1u+Py69jjuQFQtskmktpd84qVmQTqHM+c18cH6?=
 =?us-ascii?Q?U/GElsg27PxiTbj4TuDR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKYmKVkAKviq8t2mOzEgHUuEqHq/oi6F8+kG2bMsw4vANKYW4SuOdSmh0/+A?=
 =?us-ascii?Q?pV2iz+4A5+IQr0iQ09fkfW8hZ6gBouum6OuQKwP0kDLWzV44Ztb8yRK3ApTZ?=
 =?us-ascii?Q?hzGsIHHPyBYfcmXUq5EqYS7SKLZp3y+1NiPLr2ytOIoLarMSsRLpOVF+BzvO?=
 =?us-ascii?Q?g2z2hFy5VqgQWc3KwUX7KRfqMlBBq/b9h+TM09R5UJTgU5IzUaXeqNY8Lcmk?=
 =?us-ascii?Q?3XOPaqaEx7a5smld4SunR4ebItyjQZUdKV9+mzhb6Mn+6rhA/lLKt1YhvxEL?=
 =?us-ascii?Q?ULE7l4PczDIdjHx0ti6N2dToSi9dXYzRFOR+ZfpgmXBwmL5OBVYpFoJKnbLj?=
 =?us-ascii?Q?tgl9a4F2Ak/H+zoI8scxnI5t1OCHx0mPqVbmL50kBN+f5qecBQ7072SlJpA+?=
 =?us-ascii?Q?Kjce8pO+SUPc86sV2+lC175xxz9ubmzGjc5nK8OR9tVuw9AxNrnRIYXliXkD?=
 =?us-ascii?Q?3qBNK4+NcP6EjOUmAldayuNQXsvV6dALo2mYcO7kSRJFwTIZRqi1FcQGIBLj?=
 =?us-ascii?Q?1t8U99ucpyZVNA+9jdtjZR4bnaqYC9venMXJPrBKgEL0B51PQN8Jda0InBl6?=
 =?us-ascii?Q?v2qESi2EgVm1PkLQlhcSoq/YPmeM6YMOygx8qIe1xyj9yTU5uyBUcX3q6lqV?=
 =?us-ascii?Q?3pNbnYPerohZKzn/ib15P3ZlpNMjyteXQaz4pZgdZTClJVQ7Vqb24rpmF4U7?=
 =?us-ascii?Q?q/sqNu+KgKdl0JsWXj6VnXJVP3Qt25LqpBMhVTgus7WEHF8RTIq37xqJ3AiM?=
 =?us-ascii?Q?LJ5eW5v3BmxIXJ5deuG5VtnuCw1HTOCOaOE6cCIwcIOeXlbwLsUWmO1h0PAS?=
 =?us-ascii?Q?xeeGKlDd6l3WleNp2iI6sg6peq6suaYaJxI9ZbcHdKIWOG8SwM9DZpwhMc5o?=
 =?us-ascii?Q?yWbY/d8GLKoZK/ZNTjX0yxJVfCOTFaTNvMsHqLwCcLOR65kBvpvjv8lCHZzR?=
 =?us-ascii?Q?pRmL7JI4KLFmpDick1vr4ViBNXRNL/0cCelmIp9UvKXod0wL9+4dumuWSejk?=
 =?us-ascii?Q?6h71dxyG3u9yK1DH5bCOjJPNUPrutA9cUxrqccnLoedI5agPi/en4OsCX8oy?=
 =?us-ascii?Q?BnO8Tnkfntugws4u8g7WIUNAMVClRTm3EfIDAP2SWWPDVm0hWer5vGhZyNh6?=
 =?us-ascii?Q?jZi/eQwRczmy0Ask/GQU2f3UZSbTEI29WY32II15Z1q0s1dk9+h81vBmyzBQ?=
 =?us-ascii?Q?anTUZAi82VrVUCgDTKgozHiBHQxh/lYTpZNCI0HgQmbwD+4QSkmddKa8WFw2?=
 =?us-ascii?Q?SkGNOV1yl+l8jUH+bFP7XEE9NddkBXRAnIll+V+RYj9OmAI7m1arW++5syo4?=
 =?us-ascii?Q?pqRTnmknTKdaV9UMx+YEcE+WfLKoJmYgHPek4j1+srErClU3cJRBWUdikbh0?=
 =?us-ascii?Q?BL9yLLIwIqJQNVcGvPrEkONymkfLIRViyMu0c+UKLv735CHPrNeiGR6YRtbv?=
 =?us-ascii?Q?iat8zY3gZrXgGDEMT1Y0cWR4dciyTtuKt5yO9GB4jKdwE9fY8zovaGSP/T6z?=
 =?us-ascii?Q?z/86piEMddfvLZgCA2op2pdJ2zj1dyeF5bf6kDCbZbfnnlaMHd3RNg01iNKQ?=
 =?us-ascii?Q?+Lvk5qQB3Ys/Y6aNgN0j3bu9e8Rk1HuNulpw7GckltTOY8Fxir6+urf1RN3M?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QBd0MXMo4NbbIud99LbjtDDwKZqE8n8cHEEg6CDN9+mUSMM4FkPt0rQz3UoZHKbfsKNdF0Ny0yzCe9hXE5OiQFbuQFVndyK2fE/4l52s20teFgwzm8WVkV26cGYHlqkYWuymbuDCcyE7MreeUpJ3j5eQiRZgbqUAlB2ZuvzvE+btyRLYmZPmS9mElth8cW3D4YiERmfovONLNl5wCPCPCh3vtwZH9yxr5h5ty+HNT8GlKGwqCv6KH9tYOG63O+4vLkSBB+qOhBjSI11gvQYy2cUby/iJUAUFicPYORi/6+8tksfTSnsBLqUHuWbglosaxWOQTbIV+bPr4DcxWkFgtUbbb8EIuZuqyuvPzUDjPFs2ziWHXhXbvbG7OKAB06RGH4Kkxp9bkLt7/L9d/edx0I3Gotjlz6V/vu3ilnEJu17DK1v7Wlhw4kQv1udRBoeJXZgRtqkNJR2OGbu+zAZn1NWqdwBmMm4pR8M7nMiz4vVJdR0IqjHclfAQtww31HNDbgeBP639JMcQryVl9sjSeCgdk3B1E5RZ9s27s2Sf5+wiesS0nIsQkp1cAdLzu48VHPWHwqtixf9WHf5eyGMJb3dhKDKSYjNyo/rICnhxS9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c096a3b2-2b97-4ff2-77a9-08dd08ad31de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:16:51.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4I9scyb87oJKRlVJqRugJA45f0ilGB655JaLQdJ15cOvRPV1DlsbRdu0u076pmgBEvv/veNtcBg6r9CI9r3XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_06,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190112
X-Proofpoint-ORIG-GUID: j5g5ntA76QT5ubaQthzpdVjYBQQ8ijs7
X-Proofpoint-GUID: j5g5ntA76QT5ubaQthzpdVjYBQQ8ijs7

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241119 09:59]:
> On Mon, Nov 18, 2024 at 02:40:48PM -0500, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > The mmap_region() function tries to install a new vma, which requires a
> > pre-allocation for the maple tree write due to the complex locking
> > scenarios involved.
> >
> > Recent efforts to simplify the error recovery required the relocation of
> > the preallocation of the maple tree nodes (via vma_iter_prealloc()
> > calling mas_preallocate()) higher in the function.
> >
> > The relocation of the preallocation meant that, if there was a file
> > associated with the vma and the driver call (mmap_file()) modified the
> > vma flags, then a new merge of the new vma with existing vmas is
> > attempted.
> >
> > During the attempt to merge the existing vma with the new vma, the vma
> > iterator is used - the same iterator that would be used for the next
> > write attempt to the tree.  In the event of needing a further allocation
> > and if the new allocations fails, the vma iterator (and contained maple
> > state) will cleaned up, including freeing all previous allocations and
> > will be reset internally.
> >
> > Upon returning to the __mmap_region() function, the error reason is lost
> > and the function sets the vma iterator limits, and then tries to
> > continue to store the new vma using vma_iter_store() - which expects
> > preallocated nodes.
> >
> > A preallocation should be performed in case the allocations were lost
> > during the failure scenario - there is no risk of over allocating.  The
> > range is already set in the vma_iter_store() call below, so it is not
> > necessary.
> >
> > Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> > Fixes: 5de195060b2e2 ("mm: resolve faulty mmap_region() error path behaviour")
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/mmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 79d541f1502b2..5cef9a1981f1b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1491,7 +1491,10 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  				vm_flags = vma->vm_flags;
> >  				goto file_expanded;
> >  			}
> > -			vma_iter_config(&vmi, addr, end);
> > +			if (vma_iter_prealloc(&vmi, vma)) {
> > +				error = -ENOMEM;
> > +				goto unmap_and_free_file_vma;
> > +			}
> 
> This breaks the whole thing of these changes which is to avoid having to
> abort after invoking mmap_file(), so we can't do it this way.
> 
> As discussed via IRC, it's probably best to do this with __GFP_NOFAIL or
> similar to avoid the abort altogether.
> 
> But reaching this point is very common, since drivers will often change the
> flags, and failing to merge is also very common so we need to be sure this
> is a no-op if no pre-allocation is required in the _very rare_ (if even
> possible in reality) case of a merge failure due to OOM.

The tree will do nothing if there is enough or more than needed
preallocated for the operation.  If this is common though, we should try
to avoid the call into the tree with the vmg_nomem() test.

> 
> We store in the vmg state whether a merge failed due to oom, which you can
> test for explicitly via vmg_nomem().

Okay, I will respin.

Thanks,
Liam

