Return-Path: <stable+bounces-164775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C2B12706
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8852D5837B1
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBC24BD1A;
	Fri, 25 Jul 2025 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYBn6XwI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ttWqP7tP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E231D555;
	Fri, 25 Jul 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484454; cv=fail; b=AhFVChMCHdVzSvBIhbM9bm13+q5r6S78Mw0PGe7Fy3bUAeWsKpuXuU1z0a65XivCIXs4S6mA2kACQS1OTKPoMzMke7tOon5uSIGu8+r/n/e588KEPD3twdQ71WJRiAwU6ybu7hwWLQWBBC8ikgiekmoLdYmZjUMv8nNOcWknvug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484454; c=relaxed/simple;
	bh=FawjFnDWaY1DDXljgx4r8EEl8Z5PlQi/Ekk33UL+U8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SlB2YxDG+a8kyZYhuoVT4DxGybPBBlClOR6mSIABScxQIF59bc6wCQoLs1F5GgSDG1bhOQ4dvuSlkIRZmw0Xu079DT9NqdrvyTZxvBKPwz5+gXmmWfrGkvnaAWs/agLZij7xlRg2I26NvCBK1SPfLuygLyxUKO9KhsaWBaf7PFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYBn6XwI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ttWqP7tP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PKgfDJ021600;
	Fri, 25 Jul 2025 23:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SFh6ERCLfOz4oH9Efi
	VAnE5QJB3djnXErOnyWQNrkYY=; b=nYBn6XwImzxPjASvZAWlIUFwYyBDE6tObk
	StOgdMgi0b3QR8YtOkVFbm5jsZQlbjKQJjtmcn4OW8nlMPwEIM5VvIaJuYw+UYaK
	gx29fc3KACoiSTuSLrXG2MwDB8Y366I9nG2UwsxotlAHojmLNW3KdSnQxFNxSfmC
	zMdwxbylzlAC4dmN9P0cIFTVJfMRKOV69AHwKxj2eZlAGSNynpMJgjSa5ck9PYkk
	/nhEZbaYH1m69Gd9oZ7+1nEtUqSnnvxf4ucK7/mPQ3rKgcHHfKnm/X6HXHzCFqLO
	BAhRlCw54F4DGt9r6QL5kv9FCYWKvcgXqahvejSvQ9vWtkhO/tTw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1n20sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 23:00:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PLh8xO038352;
	Fri, 25 Jul 2025 23:00:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdp6u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 23:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+SXIx951OxF5H5nVVpv6kr4RiiCsU/c7NJAqEMZdrdSR9qg/WKQlV9DepwKpUoLV9uKHm9d4Tn6A7GpxiUlntzRHFYAV6mHFa3bjobU/ccbg75qTSJCgj9P7Qzf0DQT3zeTwqFGK4OOXZykI/HuI1Gs1ywxJBuQX8YRCV3RDM28ns6wl74KvdCiGerk7lsInUpZbP/OBd+pblFLbHw3Wl0lCF9zdG3RkiN8pp0KTqtU0UVs4af8NfgExxCQVVs580CgUH0S14cQlmT4XmWQLSepkZNiWp9M78LH6ZbsFRLShHGJarzHzfWbwurv2cCDzlkUVKMnH/LlGx9Sv6YGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFh6ERCLfOz4oH9EfiVAnE5QJB3djnXErOnyWQNrkYY=;
 b=dw4UKxWfNBnkGmwwAMgWTlFttcnZcgHNaK1Q/ul/uQbdJhqFVS/DRqomJt1BYw6LtMeWXeFTBGiUFJLVmBsMTPoptZZTCNenx0CG9CGazNauLbcdptiEtFQKgJTmgm14HIBbMtTgAa3dmqkDdXZMRiFtFTUFKY4lxyrR1uLYYM2IzbixAf20acldIoDH/3/eVHfLlDph2ZkE8GX6dlay4/RlLgy32w4WNXuVtf1HdOAJdU5bBD7GSpgka0ZGFmdUqusmZZNY1GSOzVKHR7zqNdjsf24FMW8jIQL8AfM5+Fk0rBBVjV4N2Xm7+mNoPMBMhXvNEz7dmPQeqTNLxzQM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFh6ERCLfOz4oH9EfiVAnE5QJB3djnXErOnyWQNrkYY=;
 b=ttWqP7tPx7NM2Q9oZLqcxzL0XyGbyjKlsBGYJiCjsukL08xGyQJSk/+CkG0cL5sSz67KJZIRqG8xqrGkebsIs2gpz3wG+GnhDr5ikOgWLXeh5O8rFqUxIAmbjNZyZV7gcXVLNfeprKrT+sEuUyZOTTSyNpUxervKpJCoIm57ZNk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 23:00:31 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 23:00:31 +0000
Date: Sat, 26 Jul 2025 08:00:21 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Li Qiong <liqiong@nfschina.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: slub: avoid deref of free pointer in sanity
 checks if object is invalid
Message-ID: <aIQMhSlOMREOTLyl@hyeyoo>
References: <20250725064919.1785537-1-liqiong@nfschina.com>
 <996a7622-219f-4e05-96ce-96bbc70068b0@suse.cz>
 <aIO6m2C8K4SrJ6mp@casper.infradead.org>
 <aIPhGvYgF0oC8kDa@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIPhGvYgF0oC8kDa@hyeyoo>
X-ClientProxiedBy: SE2P216CA0129.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7f8bfb-ca6b-4d72-5157-08ddcbcf0e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+GMBnZ5Sh5co11e4UWOLWxuUF4gyEBObbXbLrtn/ZDBAO+diSxNcE6inhi/?=
 =?us-ascii?Q?uGcgkdMuYxQgrEFxQeK3LPlgZ90ZBqJPMSoy1x8RB8p3ltufJqckYU/TMnTP?=
 =?us-ascii?Q?kOUtVJy+gjWNjSOB5u/gdn9vV0q0w+0QQZcKM1GN95dXZ3h1jPSTWR7WTIGg?=
 =?us-ascii?Q?KKFYKuAJgMoJVclSy6Er1Vnl+y33xwyCk0W1NqpuPqg3GYCw86cPW6i8bJLx?=
 =?us-ascii?Q?TKj1uX2wz0HdjSB1qMJN0JWnwJvcmx4gA1QXUtTCK8ID6ZEiZ45fMmfcRAzg?=
 =?us-ascii?Q?ghtTnfYDkupaAq5ZGfj9CWuYA0Ry/FrxeAG9fr0VSEnusiQbPOkm0mIEPzkq?=
 =?us-ascii?Q?ay2/ktulqcLMEluWuxDLtyMQwzSF7rKabw8f9XvY5YBdy8TN3WbqIwP6F1SW?=
 =?us-ascii?Q?RoZ9LhQJLUYHX3mcwYh7woIaFFMwQFBRi0K8F2LQXSOEvCEQAtOsDQP8+471?=
 =?us-ascii?Q?3LzD37ufPHX/Atoj3/so6RuE9jZHXEQTxahoBLgmccge8/DRxnNTDt27STbc?=
 =?us-ascii?Q?t64b/lpIntZiA+dq+VYkd2od8oin7YQtXJS7DSCq3MSyV4m0BnHaXTCbz/I4?=
 =?us-ascii?Q?vBHNgHTd9shQ+XJwoOWwrlGmHJu29VtkbXkchMgD0w+JbeVsrKtGAhwK+hk2?=
 =?us-ascii?Q?/NOr+dkPTkhGdjZliga0BmuHvF61UOcynlSvaSTq5Onpd+0g5/52A3P9n/I6?=
 =?us-ascii?Q?tgiR43E8vllqnzVRB3EhnXfjbrRXjhLrJa3iicN314vWc/C/Yd63W2ym9KIX?=
 =?us-ascii?Q?8Rp+IfQ735vdvA+sVD7oOahu5tvcdsacKxrCCn68iShuIWR96Ho8cGRMhmiX?=
 =?us-ascii?Q?d4Dqbq/kyonLA3ckvtghr3l/aG0n6vzb2Ha/UxvFOiimLtQPZapf8mbbf0h3?=
 =?us-ascii?Q?8JE/Y2EZHeOfTtgkBFAQsCcVwx2NToAnKlWA8eHrYCzlom5dzF/c4DUQcamB?=
 =?us-ascii?Q?BfPRXmSFeZjRTl88EM0oTUf6MkLkusBwYgFJExJOTnjFzIPAKMwYAgTty/uI?=
 =?us-ascii?Q?45XUmc4wJYhRSkJR04iPklWGjLu84Dv7KT9uypbXQ4ucXpVzQ5UKZ0tIusXe?=
 =?us-ascii?Q?jM1bt6KIu7EcldY2ZnHfjAIVMDJHS046zI5X3y4Y3qno8adlzm0L24hBJPJR?=
 =?us-ascii?Q?39uZNFY0kH7T/qM7sma8MXNmAy1nmxIbnr0c4SbNrhnZhlVNlkGBiI4EOXjx?=
 =?us-ascii?Q?Xnb21rNpbKl4wJyCGAoL3l+lhtfIFhGTbkW5rG5AgTPf3HoLn7HMC9lQ5f03?=
 =?us-ascii?Q?aXSDTK16cmIDl5KlErk3I/pCxuUhD5cosK3c7mBZ419DT29Kc8imkFE9o7xa?=
 =?us-ascii?Q?mOlWxeqUuVIa/Qz0iDxpraCA7JNK95PZS9ZpXYENk8zTRKop2HxRBlgBTnWy?=
 =?us-ascii?Q?TGsbhTtLaNTQs9XAli0EZAd0MAUuNq30gttxJnT5AGQ/uJVzq+fGffshUXs0?=
 =?us-ascii?Q?nA6MyfLXni8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPTKjbfXXdsF7oCv4dlv4mGQPkr/rrZD+RNW/mqtjs4CnEfKPylJIdYr2a+h?=
 =?us-ascii?Q?dZxmCbB8wCm+UuvHAi2omst4JFplhybGUGKFNVZ3zI1MbbbcpHSbC+bHb7Uf?=
 =?us-ascii?Q?iSiscOvk1zLWDJbnF34eEqrsZBiTx9qHPuUGdwx+zVCDn5C1JmU+StafnMNd?=
 =?us-ascii?Q?j9VTm0vwX6nkGvqdIAH+3qItze1EEm5De9UJIY8Ym8Zh1GfcJjVLI+Ubi4LK?=
 =?us-ascii?Q?TkxSz8i4d4bX0s4MSXzHstI2aMRkqEEQpRj9JBqGDizrSFwPbMdxf6Zj+w0M?=
 =?us-ascii?Q?8OJ7bVHVxJIWrKx4Sb0+Ye1JT3pp5Z5dwCV8jUXB9NGjKHm1MYRvpaVtlVhK?=
 =?us-ascii?Q?ImWeHfeYHll6cXcua9l5JycBfzMZNU24jtLUbINeFDqV+RLC+8ZPwf9jn7xS?=
 =?us-ascii?Q?iaucVDlW93/Kqe/bbCIKZ2Ogi7dsuqEygy7MWn7y567L0/sm4SrY6vLHH9+1?=
 =?us-ascii?Q?IvqGwV9gU08ipx+H4x8lZ0VA1lb8SvaGWcAKc/gHKWwndIq89pqBU27Loygm?=
 =?us-ascii?Q?X6elRY/LyET0wTRsHXe0w7FbcNtTy8Utohbo/tEi2d6WH46lgMtEYpAnzyoV?=
 =?us-ascii?Q?bgToRxezxNsxZKE8Z4AhaIk0nAHN4xP9Ln7Xzkphm0UKLhWI00/McbQ+XjnU?=
 =?us-ascii?Q?5k63gCBB43yFhpHgVTST7HPJlVHQqmRXS0lGAqMc260rBDNF/MNbNO//rlGB?=
 =?us-ascii?Q?h5RJFF4Ofyi7bAVfN266iCJ/J+3WslUAPYYPkHInYvAcpvIPFwOud1nU4XpL?=
 =?us-ascii?Q?ejjGATeCtPEYlEE2lo2SQR/EYz+gTkEvJp5inAO7nEBVERgxk11gtfj7jlEw?=
 =?us-ascii?Q?er9IZrkxjej4Xn4Vfor8OVEksNZMH+54+ztUGY+285yO7abC02IbMRa4x83p?=
 =?us-ascii?Q?knd52+U6R5etNIJHt753/yWq85aoUC63AOLfbKEI30eWHfvL5/6jumsvSxbk?=
 =?us-ascii?Q?tl9xM/iQ4VSbPZSwCi+ahbqULLrkM45BLylFC5EJo3Ggf8Ha0Agg8VE1buui?=
 =?us-ascii?Q?wJryR9QtkPlM5k9imDeTdiT82A+PmX64AmBQmNwE9iWbl/zNnwoY5dShcI+M?=
 =?us-ascii?Q?IaYw1QZLuYeTKWWoHf3uaJZL7ZJeEfSM/B6Hgjvw6OlnD8kyqToG1+8j41/1?=
 =?us-ascii?Q?9Qj7PCsZuo+G4daS+6LLY42cLRDh8cSgyI5fy2z+3RyW5M6V7Mk46ZRLQ0Bi?=
 =?us-ascii?Q?jrBgXwniddeC9bBmvJCfp2PddCkB1j4PJJ5EBVPmUvl8ChVrBYAOjm9Yu3pw?=
 =?us-ascii?Q?ViHTQJwy/BsMaGb5doTh+YzuSF7kAvBT6tsUgOjnVPaTBYgF7GfIUsQkA3uI?=
 =?us-ascii?Q?aY22OryenTlgD6waDdzG7JdjAh1ZU+5R2mb06tvFmVZfXE4TQCMF6tbd1M9h?=
 =?us-ascii?Q?ODEqTkxqLrIYXf/5oMnH18ArjFAldEG43XxcbF5RppQsPtaO6moBzzTQEyMf?=
 =?us-ascii?Q?fCvOIrYC6YSACSUXXv7Gwd14dGlp3U19cZrhi0u2AW162ZrvEukFGbZE6PRc?=
 =?us-ascii?Q?hKG45Z9aBePIiDj2aYxol0MyGxtfmVO1NDmkC7/y+ot+WIdk4Kh0MDMW8XFh?=
 =?us-ascii?Q?cShEUxH8ZTloe4vnsknLJi6u57KhCoQ8HmV7dN2T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t15DROPpVr9QqZE7ktJUVpgkavKxKJY2nHuWJOGG+jJc2i0I6GMAG3WOfAApDC3LRh/LLTeV4W7HQa+nUyF7COwHNRIJ6+96BLFa5vZmMDpockZL57ZMhl+qlzgps9FbKos1crLiJnN6Ff8jZMLJ0W6IN/bCvruc4XiMqT6OXfirARJFgz9aV2Ee5UCgBFNdMyZbtd3hvOr7vexIiRH8eyK6ias9Q6D07Ug3FBC9QIMMz3BtclTgkN6bAA8u/svk5Lu4itNZj80tWDjcTFnOIVmsNUEVTwCs9mxE+SzSrklcmG3BxeckpGcz6hiFp0viPZQaKTpPrXaWIcBFsYETWxWMc2lQOYIldHCJQAqfL7ESsZuSsOORM2UtYW1gSs/x4Qczlp9AySekZN/Ho6cBVDAMTmiv58M+8QZmxJGxMvlhRWctg2HkuA1J66xj806DUn2/IGFEusmxKFmJioARovJDMkDo+pf5qDdGbRRP6ZX4zbX3OQyZR7yMKh6rJkzXjZteqOhLrUlmL/hsNpBUO72EdVFoX9Yc5a7QEiL74mfC+6+790L99Nn5zAd5FeMzeFEkgzBFTR/OILmJeGlFNsF3xh03VHwG/6XvTqg3ACQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7f8bfb-ca6b-4d72-5157-08ddcbcf0e05
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 23:00:31.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2WSvk0sZLdMTuVBgPqgz7P4Oom/kdyMtyNFVq5JkfpW9yPfY+l+UcIBV/IsCaQJqY9FDcrjccrNNi/QzyMUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250199
X-Authority-Analysis: v=2.4 cv=ObmYDgTY c=1 sm=1 tr=0 ts=68840c94 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=UDYOwdoAtdH84hfzlSwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: _1Q0TGd7lczfeFn4PANcdhOt4IMCOTus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwMCBTYWx0ZWRfX+rHYHizd1vEU
 cloyn7Tfo6IgXMXOP6dX8piW+el6/53fOgdhFxFEHTzAI3lMi8iVh9mD/0ewJLj51WmTL/KRysQ
 WPwTfRw39DmKyipzpMuPBAlbFG+eqb37fH9JrBtUhTVoLZtZKfple7lq0at0wGmYkSj2ZoT+72w
 Z7VcBW6lpNonjaXg8N460IcYZ9SAsY9sAzSF+fKIGmousALUuEOvklG4xbe/6+ZckNo1HfqOU5t
 +FgeNGgw7xImRDxZgn8GDvzF1VMKar5VYB2E0gOuJpeZDe+sShY26e1Wj+CtR2Tu0tsaoHewKgV
 6w3/Q33TMukI+GeGl9geYHnNYN0KtQm2K4HYeK59v2GUtagI+MJPRlnWpFcub/eeWXBfSdJhfmP
 jeqtBVJjEURGSoSl2oqiQVdJgTE4MPShn28ncnWswo8B6mCrjGFcEWi+Mj8pDSQ/caxButVy
X-Proofpoint-ORIG-GUID: _1Q0TGd7lczfeFn4PANcdhOt4IMCOTus

On Sat, Jul 26, 2025 at 04:55:06AM +0900, Harry Yoo wrote:
> On Fri, Jul 25, 2025 at 06:10:51PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 25, 2025 at 06:47:01PM +0200, Vlastimil Babka wrote:
> > > On 7/25/25 08:49, Li Qiong wrote:
> > > > For debugging, object_err() prints free pointer of the object.
> > > > However, if check_valid_pointer() returns false for a object,
> > > > dereferncing `object + s->offset` can lead to a crash. Therefore,
> > > > print the object's address in such cases.
> > 
> > > >  	if (!check_valid_pointer(s, slab, object)) {
> > > > -		object_err(s, slab, object, "Freelist Pointer check fails");
> > > > +		slab_err(s, slab, "Invalid object pointer 0x%p", object);
> > > >  		return 0;
> > 
> > No, the error message is now wrong.  It's not an object, it's the
> > freelist pointer.
> 
> Because it's the object is about to be allocated, it will look like
> this:
> 
>   object pointer -> obj: [ garbage ][   freelist pointer   ][ garbage ]
> 
> SLUB uses check_valid_pointer() to check either 1) freelist pointer of
> an object is valid (e.g. in check_object()), or 2) an object pointer
> points to a valid address (e.g. in free_debug_processing()).
> 
> In this case it's an object pointer, not a freelist pointer.
> Or am I misunderstanding something?

Actually, in alloc_debug_processing() the pointer came from slab->freelist,
so I think saying either "invalid freelist pointer" or
"invalid object pointer" make sense...

-- 
Cheers,
Harry / Hyeonggon

