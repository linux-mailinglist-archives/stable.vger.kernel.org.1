Return-Path: <stable+bounces-93831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD59D19AC
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 21:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C327C283049
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 20:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A091E5019;
	Mon, 18 Nov 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e0JT8nJ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u1H9O/57"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20B14BF8F;
	Mon, 18 Nov 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961952; cv=fail; b=dDDum5DT9EJoFSRo2xFFQ7mb6ZZw060SA2HdslAD1TfRtZIeA6iDMP1/50NxtzreqC71d7d1GJ4mAe+xjMVBtRfHph5RwP3TFNflpUVZ7+MfSYZNsRL8/A4Z5plDsgz3cqsDAiVSwoJemip1GYyFSWjFBYHe7fHHRlBaEKRTKe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961952; c=relaxed/simple;
	bh=6HrwO+eYTtf/OhPSC60Z/patZmIy4ei5GHHhqYOj5Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WZgEtTgRscBSo+hn6jTHfEDkUz7XrrLvB3Pk+Q+jEPR2/Oa3aKtPpKZ2ozP1/AEfYO8pN9ZyQ8l4RcULE3nNmYXQLfI4UDSgNj4hWgbCjrKdzo0n64G+2w6+e27YqRgYGP5Y3Zc5RJlqFY7ucrDGk6KSFDKbKIjmRV59F3/1vwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e0JT8nJ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u1H9O/57; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGL8Wk006265;
	Mon, 18 Nov 2024 20:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=x7otjzBVeCWzNG9O6W
	IzUirFkAoCgsXeM5/t3o06dXo=; b=e0JT8nJ4k4owlNAMCJGWbfzHYPvCw+GH1p
	wMoj1TBK3HLVkccNpvym5TPaxJF5UNYHguxd1lieCZk8n/69f0MeLe+Eh/ml1SrG
	TdFiqOqxQokfUxQB7x9prVqnIlLT6X16rKP7DdQA73syCu05OBzgqDrH7pKf8PTu
	faJGrQBQZv6zwH9HO5zKT59SkvbXyPY+XdfYJGwKNdAcxaihj9Jgm/FdRyMhZLG2
	lUECAZBX7YGCqexVLZyceSTRfrZ7wTFA24gIkjt/Rm2h+Iqp3nr0Ukch6mvLiCiG
	Hijr+nsuS+iMBuKYuy2D7JXDBAaUf9o465VpPYWkKhZX6WWhG3RQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebumvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 20:32:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIJdVqU009008;
	Mon, 18 Nov 2024 20:32:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7tmag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 20:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3YglPJBdMZP6ZD7gJFI2VE2znBd6TFxlrLBqtdctozkArl0YhfJswqdg8wG1AU6szLZ+7PsODYOYWDE2mUe6xw6k4XM6eAwDJTuGr1uXR9rZIRHin7D3RjuTyh4PZ652A2n3mIi+Ki6KwV4tMLr0lfJcj3j6dHIyXkzzp9B9/quw5vHF+Nd3s6uzf4hmThgIE0VvjXTqzWDgkFh5NnSuGH0Zj5XJUGaKyVHIM8ik1Exk9LK7IQ5Zk+e7pR1oRp3O0CxvACe2UukWwSQWN7f3HUz8IyoTN79OdzSZSeoj4o8KhbRF2Gufpwg0EvyiumgZQlKfxTw9YOF24YZNDtDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7otjzBVeCWzNG9O6WIzUirFkAoCgsXeM5/t3o06dXo=;
 b=u0/aRuo2xA1SttJW2qb1qJVoJvMSZNtT6HZttH1l8SEqvW+uBI7At7XXMknMhb4XrPQiz5dS3AkDh1a+QKuKdHaUo1g4aC62op5YIqUeaDM/XSXtMNVqdpZj5B1z72zlkg3xfd+NkAE99D/yxSGXeUK2azx5XDEPepoDp7mt/PndStbps/fUkOiibeyONe4FH3vTofARohRSeSQoFasmWpC95Qqtzizh4EUACKHfjCgPCxkQGcaDBmd8GKG7ru8TKfnJvzAF06IKiDeybVMDdXNj2g2vcq7+GocYm1dQQ3bMSADaew0hqMtbuDmWet5rt964IXcyOsD/ef4cxMLDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7otjzBVeCWzNG9O6WIzUirFkAoCgsXeM5/t3o06dXo=;
 b=u1H9O/579d8pNcXH6KF1X10FLkbEJ3s+31usNYwZINw6Erugv6Ss9WyhIf3MqCnsaUQtfbWWOw2LZnDPeoDDvNOGg4Ji41JV2KaOSi4TWpQXUdeqoZ2yrgBK7Zwh1lXOHm4ucZroa0eFxV6K86QkO0sLlOgt/0gW32GOmQIQZLk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7604.namprd10.prod.outlook.com (2603:10b6:208:48f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 20:32:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 20:32:17 +0000
Date: Mon, 18 Nov 2024 15:32:14 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>,
        syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Message-ID: <qmmd4lujbzwyhxmjf3wagmfakbirjleufgkh6ozh5wbled3zp7@2z6trp6xlci7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com, Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
References: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf6bfd9-e011-4e38-ed5a-08dd081017cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTj6o8cZaMHwnYIP2DZcgddIxZtkPO0PSXEniru05LsVR6epYBWteUtaOidz?=
 =?us-ascii?Q?PrCq6GiUHWjocNTV93PBypnxaOgyaZxq0h9z+WNiHpr577wso0FNRUjaoEEO?=
 =?us-ascii?Q?jEYW3o50Gz1zIY/Dfgu1pxysXdwkXyXJCCdrf+Px2K75htQQV+qGioqtkOms?=
 =?us-ascii?Q?bx/5OjVdZfthHpqQ7TtOm7of2RtMH2Y1VEXIloU/16pXSTfMAA7NmH1chQfb?=
 =?us-ascii?Q?J6rMAhH2zqCol8v3K9JZsSW+cN4BQ1InE2FCra+/mVc5MRZOcafAa7d7M5Xb?=
 =?us-ascii?Q?EyYNhWs22YOQQTo1RNjD8ZiTF5JSJDx3CKbbW3nYKRy7bhSM2vR/mwK3tkKW?=
 =?us-ascii?Q?51/h/PqbMAbVmSdGsEoBJzA49FfC3Z9r7j5a+h9WmZI3MTvQhr+32l7IldAE?=
 =?us-ascii?Q?VRoTYU62q+rJC9dNOs5G0qdYJnvYkWLtXMUDZjDM3VM4oRVApeKtsa9WGAf4?=
 =?us-ascii?Q?Rw+eHwmtOUxcWX203YyzmhM2vR+Nb6qaFGfIoqDilG+B1AwjGMXNm/aVuFv7?=
 =?us-ascii?Q?yyRapHbT0NJaJqMubnk7aQHpz+tXN/0LUpZO0PZ+RLjj2ytRgsv1FRWv3ge2?=
 =?us-ascii?Q?C5IL1AGLpqqA8dPOqtNvDpDR+bzfa6ib9qw7M2tfTBlHE9Dy91Sv608zmYFI?=
 =?us-ascii?Q?O4zrBi6j2iOsH/9pIAi/IrZi26AcP8CW5u1W+MUqvKj7xGToGhWNsL/L7tvW?=
 =?us-ascii?Q?ENgtqdWimTWlxBtWruhsj7SPvCc2XOgV6SpFbFgnvHGHEi7rOB/Fk2H+ZTiM?=
 =?us-ascii?Q?QaFyd7mGHbeScR5mQXahDy0OsfuOxlMdpkdJyygtdC+ov2hwSNdQtF7Z1Q7Q?=
 =?us-ascii?Q?U3XWH4833AQBoE0dSf4U/+1jyWD+65QdQkcJnS2vxX6r4PtQR3twtRquNypL?=
 =?us-ascii?Q?/DTaFGImYQg9CpXxbKXDSYFwDZ/9IPXyWmPhokfxFLJOHNMGP6uYXwAmVUOH?=
 =?us-ascii?Q?lcPtllSvRkeGX9/y286+qA8JEEYT7iUJ5oEOoZVDkVKHbzUJHRnUuoUPP/69?=
 =?us-ascii?Q?wFIHNvCVsciydIdiP8UUtNmUHlhKCWDlb9AjNUIAowY/HtWCLD7yM14patT4?=
 =?us-ascii?Q?QYmc8HUGQvIUR2ytwILZHoKuQPiVMmVpGAajJMQrXi3gGldJ6ZrurlS9C83h?=
 =?us-ascii?Q?L2hoDUADXF3nIZZB+BYa3Wo3AY9i2lW6S/u3NGI693QaQ7Ry76qVY3ryoO/C?=
 =?us-ascii?Q?5BiYf06cQGsYH1Gpb6t3jQVZKSZeaMmDEIMeKUyQGcRyJd+iD9u4MMN7E20D?=
 =?us-ascii?Q?jW9VkFeWJ/UqTTdiKgJt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c5yksdOW0+tzEpwumDehJcfmoaxU1LyDdIZr+mZKlUNCS5sAueWlvXA74m7R?=
 =?us-ascii?Q?r7faq6L78pkAith1+cTgntiCZgMJoQDBoFVWCB0gyj7GvNmhwolPJXi/6R9e?=
 =?us-ascii?Q?zEh1h1ELPemJUOd2Ha7quOGZNKRj2duTI21IIeuF/oeimneb5F0W1Clk9VgO?=
 =?us-ascii?Q?crtvQ0zw7BxIm1akPbHbJ1Q45fAFrovkrb8GluqM6D1gp7bZJ1i0JDMhd0Cm?=
 =?us-ascii?Q?Q8HF7IBN3Lh9Z4Lm8goTCg5L/bhxTOIAu124TqaPHSqncuTAnpqHdpqKyGNU?=
 =?us-ascii?Q?17jERGTGCpHSpC5sd+IaR+CWIUd0K8WYV3T8+g0XDKmxEbP0iLxVXcic8mTx?=
 =?us-ascii?Q?xo5i/47Oo5/RB/yII9WeXQhDdMfRGgl47udNuqsJPHp8q5yq3B+4N8zjPQIA?=
 =?us-ascii?Q?PkCz79GyWYohrpn8WaNdxoyE4UOgZBsHprEm/lLSkVHa1+wjubDCrZzHtr7J?=
 =?us-ascii?Q?Nhrh6NrhLDd+enkecK1xfwhdD+US7DMtAHG8a7iuHahgjQk/Oqz37PtgnKva?=
 =?us-ascii?Q?YeO7NdytuHBvlp2q0zholR2eaBnhHWzuBp3u6iXAqWND/gaUA+mcaqI2Vd32?=
 =?us-ascii?Q?Y1lpeRvCBL+VAaVGgvKLsTvWWXphf5jrg6NqjncKkXVnah2OPA49+JagizCm?=
 =?us-ascii?Q?emYgGrbt0MCjGZwfgHrp8n4JOyp6R34WcLxq/YPSqbJqDuHnh909fmuwya9u?=
 =?us-ascii?Q?QcSfme1AD3cK8uPQiUxbPJXJnTxh9ASB/NszNJsYv9enMqBUTaiy0lUIpR9+?=
 =?us-ascii?Q?ZjmsUAKlMn5JaHDdZHVHSr+Fo9NAfuMA+o1Q6N4WbBORCwEolqMFQFd5ia2u?=
 =?us-ascii?Q?7G5T0dsq+TZ5CH17r6OYrmV5QGt86bQWdBgKSiw1W71ameJWMgx6V90MKDwf?=
 =?us-ascii?Q?4KNDQz/1JIriEfUS76MEKWn7vmV2urfWKzJvMQZwx3B+A4ns81bnrRdPKLJP?=
 =?us-ascii?Q?dKkz9tct3YZ2nDD9OJp6aNK66SikdAyOecPwqC7Zk16pBW0HenLtbWRSMlve?=
 =?us-ascii?Q?8FOJ/rIVh7NTLtoGyXDKbzcfrducj08+rIXeZCifk5x04Gp1CUb89rc0vj8j?=
 =?us-ascii?Q?fGii0tTEeLQoKUWTWzqBrgMl51pzuEj2WyYDY6ja/At8wFJeudfLx5XpdnZM?=
 =?us-ascii?Q?NGpwEgd2qKbPM/pnw59VCvArd61/SzubUSdYZrUNjDVqB5H5SRrvYVeld9I5?=
 =?us-ascii?Q?w1WtPBYWV/GacW827fRrWR0XpquADuXi4ruzxTAeYGC5GnNaFnzt0CLryI1P?=
 =?us-ascii?Q?VUOTNNNzAktD7GJMmgUtT6IIIF3svNpO5yVa97jvHgNUHNXBHw7sECMQkWwx?=
 =?us-ascii?Q?mUJxy3mca6Uv541QR5fFBwUhSdixvkb6q2Biy0k14WwYeUGgoKhT/8beMgJU?=
 =?us-ascii?Q?/ihRaxeKAaVzzJ65b9pZipM9JNwULjjYND6CSpFuUMISwYqtsJ8EQ1kvAw6z?=
 =?us-ascii?Q?piznEsFAzFlxcfPOvsG8Vdsyfskg3Tf0j10y+bkZqoqq4wjPAWOECxOjFTuJ?=
 =?us-ascii?Q?XvZXK+Zcn6XOFBbYarVA4cJ+UdCu5rHw+E8un5WxuRHmU6KUES4rEC2pQZ2H?=
 =?us-ascii?Q?yuMZWAspXIa/OAoN85WV0YaY0ivRGNIu3LbYiC3u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yR9qGnoIFgrKqxHAQeZ2eeAZrZ0zhroGHQvjyvPNarSVubipn+MFctBIegrGJBfwaXPP/kfZKEUyvQSKcEJtANwd5OzGlRE5PJpw97HYq0HzNuRqvFu3BNPXurb2ZYJLqTrrWxcgD4mMb9t7a4M9v3YciU1HQbcTFq6TjrX0gazLug07rVKrYx7qc9WHzVKrWnoEiXghGAGUt9rkG4cAkV5yFbsDEcHAWpl+EDw3mfSlLUbwV1SLFm/SdbHsnRKEO1RHxi0fvHSglAYrDSYIuVC6GOMdAzo6lApqkXzEnfjspWv0I08CDSbJ6ASD6XL0OQYlPM7Hiurg9IvwBTlcqigSF2ZapfgsatyfGgGjWAPa93M/mZZp9qNrKjLfLeFjTKoZeRXg0/dV0dcirPY5zoR2FOMm1fXbqvbixNdVbxetC9Rv8PSaoNNeEJ9NDStg11UDlKlOHdUTpVyQ6nxewaTnLWo+p5dXYqSXDtO9EC1Om5/JSLeldZv4LNUbNFjXCBhcvfoYBk2+5Xepozm3Y8ZLRoAA7yScOlfng8G2ZGFz/KrjtvP5NcwJx29OmBF7XuiSSs9FBzUdwrcMFtXyESVxrekPArk7vq4YWBQ2M+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf6bfd9-e011-4e38-ed5a-08dd081017cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:32:16.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9bBXJ2OKY+yF93dlngaiPQlq4O+ROYvMofS8rTI+kX4n1vc+oJjWUiEZGT1rG9ISbKNcXuUKQ40OVDdg+4qzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180167
X-Proofpoint-GUID: K1mSOEg53Tp9Rf_420uZqdxj6DAHSREH
X-Proofpoint-ORIG-GUID: K1mSOEg53Tp9Rf_420uZqdxj6DAHSREH

Okay, before I get yelled at...

This commit is only necessary for 6.12.y until Lorenzo's other fixes to
older stables land (and I'll have to figure out what to do in each).

The commit will not work on mm-unstable, because it doesn't exist due to
refactoring.

The commit does not have a tag about "upstream commit" because there
isn't one - the closest thing I could point to does not have a stable
git id.

So here I am with a fix for a kernel that was released a few hours ago
that is not necessary in v6.13, for a bug that's out there on syzkaller.

Also, it's very unlikely to happen unless you inject failures like
syzkaller.  But hey, pretty decent turn-around on finding a fix - so
that's a rosy outlook.


* Liam R. Howlett <Liam.Howlett@oracle.com> [241118 14:41]:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The mmap_region() function tries to install a new vma, which requires a
> pre-allocation for the maple tree write due to the complex locking
> scenarios involved.
> 
> Recent efforts to simplify the error recovery required the relocation of
> the preallocation of the maple tree nodes (via vma_iter_prealloc()
> calling mas_preallocate()) higher in the function.
> 
> The relocation of the preallocation meant that, if there was a file
> associated with the vma and the driver call (mmap_file()) modified the
> vma flags, then a new merge of the new vma with existing vmas is
> attempted.
> 
> During the attempt to merge the existing vma with the new vma, the vma
> iterator is used - the same iterator that would be used for the next
> write attempt to the tree.  In the event of needing a further allocation
> and if the new allocations fails, the vma iterator (and contained maple
> state) will cleaned up, including freeing all previous allocations and
> will be reset internally.
> 
> Upon returning to the __mmap_region() function, the error reason is lost
> and the function sets the vma iterator limits, and then tries to
> continue to store the new vma using vma_iter_store() - which expects
> preallocated nodes.
> 
> A preallocation should be performed in case the allocations were lost
> during the failure scenario - there is no risk of over allocating.  The
> range is already set in the vma_iter_store() call below, so it is not
> necessary.
> 
> Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> Fixes: 5de195060b2e2 ("mm: resolve faulty mmap_region() error path behaviour")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/mmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79d541f1502b2..5cef9a1981f1b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1491,7 +1491,10 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  				vm_flags = vma->vm_flags;
>  				goto file_expanded;
>  			}
> -			vma_iter_config(&vmi, addr, end);
> +			if (vma_iter_prealloc(&vmi, vma)) {
> +				error = -ENOMEM;
> +				goto unmap_and_free_file_vma;
> +			}
>  		}
>  
>  		vm_flags = vma->vm_flags;
> -- 
> 2.43.0
> 

