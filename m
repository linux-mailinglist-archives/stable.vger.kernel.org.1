Return-Path: <stable+bounces-194683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 469BCC571BD
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6852356E46
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E35334394;
	Thu, 13 Nov 2025 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="irCgD2Z+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GMmkXhvn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED792E2663;
	Thu, 13 Nov 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031974; cv=fail; b=r0U57TpYbYKO8CsWLk7Zu3AFOocP8/PEEdhdTfOihsSCnQJn8KUBAMSIH1jrOLNTsMhA9rvWqdafoY8Av7YuReuIswfJlCUIp84OV9XRtgLorWEoVOC7Y2n1N/uDn6k24s9FWCWKgtfxFx0haPeMeicWra1OAEYgKPE+bdPYqvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031974; c=relaxed/simple;
	bh=PVJGmdg33klX+h6O8/CVkSRddXy8cKmNzPC3LMlvY3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DdkT2E0XzX5WGIcfJDlYCFX5F30FVrAqXFFwJhcvivtR+enzbyVXQNXJe4SrfM+9oOvbNGNGk5yaHXW1JWJ5fbHASxaGiKiB8K5RQNHRzJ3pUgZ+A9r4sOCyCvirw476ELLp0N+cvgaCUhTINUpXJoy57bRSC1pVY0nU1LWkd/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=irCgD2Z+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GMmkXhvn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gHA5020810;
	Thu, 13 Nov 2025 11:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3YksbRrcn+aa3fv+C3
	2v5pkARAuIagi47ZTMQl0uyng=; b=irCgD2Z+kDH6wCmEZkkn4fneWvEJ9oqiYS
	/7EI5UJ3PfnkoyP7PnsRhpPmJYZ9oYEwDqZxxbo7aoHaXEZkbB1CMLQNmyJT7YDT
	TNyX+ZWawKM1bLwFcEaLiVe5zo0T2ol1Ioq60npgw3CgcHZuOZMDcL2gg1bZoaUu
	1IeUK3ru1NokvCkW/no579j6P2JAzCyJ1utRSdL6CO/ZnzbAu7mNqxPoQ0XlL9ZH
	//BAiPbsX2KmTxDLnCe4fRcnuOFgwTNMBb6DhoG2dUqDDw6XzHzHkx29GagbNyKB
	AHNMyZ/Q6MbmiHTiWvSBlKZh4zXAwMarhRrXKvF+u8f+sawczuMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjt9etw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 11:05:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9hr9W003299;
	Thu, 13 Nov 2025 11:05:34 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacgwxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 11:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1Mo8wOW96jrG77xVOvk45ZKRqzybFb6/7NkEXDz0SlLxUOxLE7o2ibVu5skk4U1sAYANoPw+7XY0QyPS2ekxFGSYzIg9YMPETKT+QQiITtgSSaZjTCXhSXZOY4RCJOqrPQRBT14Cc67vORqlmbqpCQ+v8Hg85Yzqwa7Q4jIYI6QL5xZHH+9hZfPyOszPGRvVB74yXNKw1kM6IkuIS1kF8KsnQg6qVgbecQ92nfPMr7JvHaiw7pDcicUMb3BGmU0QsNgzJDuZnwsLBPfCQHXbKkaGpU2TVMc7gwt9WmyinFnW5a9OLEXgLLwBuqkV2L54DbMHLCmCLl8m8tSDRzayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YksbRrcn+aa3fv+C32v5pkARAuIagi47ZTMQl0uyng=;
 b=SS1JPza+1xiA16ibRflt1Q3RlZrLXqUSimcmKj/XPHr3hw9NmIARLaGnNEpxHsKUEm66mK8rl7h9iRKCAFYRyYpn7Sn/MbnyXSJ98K3vupRuJo+wKKc42Wxtb7XZA8KX8ZmIYpd8Z7QZV/TuMQfzYbmuCUsHkXw8zhDbdb8RW0MzCB9kNz3WC2n2bc5yYIWHgCMoZOSdlgeA9PbD1zvqGcLlAfyvIh7FnkrZuTnj/B6WyUzhjNKJByhbaRMaKKKpxMBS7eU0GjHMctrLFUho1oVZuFtg2sRCcox6+/XsbGhVHIUGqZlQmQxn9eOOvYrdekIzvpVYseYdyL5pr9hR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YksbRrcn+aa3fv+C32v5pkARAuIagi47ZTMQl0uyng=;
 b=GMmkXhvn4xXBgPZ7ZWdHET679UK5XStjKdyJpMrSiXyMT9nRk1SEungxA0z1mpqv8CmEToFOXf1qiVeIbZPbzSGOzfxpwvzU96ODtf4eDeW9sXoYE3nDZMFfPwPU+s+acZscbQD+tOFvHNadH238i3k7hjO//lE7k9foL4OzapM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF6A2C0CCA1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 11:05:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:05:30 +0000
Date: Thu, 13 Nov 2025 11:05:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        stable@vger.kernel.org,
        syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <f7abdb4c-b7e2-4fe4-9198-f313d0cacacb@lucifer.local>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <aRUggwAQJsnQV_07@casper.infradead.org>
 <d9e181fe-e3d8-427a-8323-ea979f5a02ad@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e181fe-e3d8-427a-8323-ea979f5a02ad@paulmck-laptop>
X-ClientProxiedBy: LO4P123CA0382.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF6A2C0CCA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c83af6c-552e-4fae-74d2-08de22a48f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nmPBvepWXzOb39e4BVa1IR6/zE1zuoeELnxir3S+onSzGn327ETI4YDnqmRE?=
 =?us-ascii?Q?x1ePl/ooYg7zgg7SLbxCQ2NPCCzbaDSsnIeMtQysJyyQdHRvZMoB2nT2j6tO?=
 =?us-ascii?Q?eewPKbyB/GTtuuiELVQ9CCs5hdX8aplmOLDFoIIx7kPLGMsUH1vksB0pblru?=
 =?us-ascii?Q?w8Qrt1e8KErr54akggwSmRp/kEPq9En5egOSJNuXCCJZxPWn7oOWc+8OvCnc?=
 =?us-ascii?Q?Y09yzKeAGHbg3fOyjsC0kM173cyNc6m0VRyKbCxTxpJOfC0nygHU/rPTCSdy?=
 =?us-ascii?Q?x3IBDXWM508e+qx0GYda0wdhrOFMQT5nw3XYvy8myN9boDJP02Y4NXtNi4V7?=
 =?us-ascii?Q?nmiem+AO1B57fWPx0S3r/tca2qaOiLx7AIvxFwg4Y9atblcGKjf3mcTyg+BX?=
 =?us-ascii?Q?rZPsw70OspTvtJ1SfHZy12Z7MniRqy5iZxln3ywpJJD98Eegtky2GnEg4IIV?=
 =?us-ascii?Q?ghDj9kp9jvhT651LSWUhv2X3LIuMUviQMKYukMVQWpt4KsEUOpWg7Q4esDB+?=
 =?us-ascii?Q?r6/5wRdq/MEMqxiZtGkMmXBqxuQMvSJ2Y+lPbuNPnruScu1XdcOSqL6PP9XN?=
 =?us-ascii?Q?GL+y4bFP1EzmyFC0qvEUZgPJdpVAO5EGv2vZuTEljj3Ik8UPPPkOSjIV8GYD?=
 =?us-ascii?Q?wprYvJjNQoXz26Sjt2yZwXPfQicCxqMOdnJ9JcjKMR0Ltx7GOqm5kHo4Isab?=
 =?us-ascii?Q?PcPrYuBr3CyTDrUpIB8G520wYPIQu1HsTLp8DvVhKtriuajWyVlDY9ycPPkm?=
 =?us-ascii?Q?EzKd4ItE+z2W/5loMrL1TsuawWcWveeJXfMc3wAwo/JxF8q+cKzKBqdE+LPW?=
 =?us-ascii?Q?OfoPDmoBK5bUjqmfKwgzm6mLLWcirVubBeHQ/Bvz0v3kYn84C1QIGbPlzAKz?=
 =?us-ascii?Q?e/ooHqBqzTUbtxA8DbA7JHvXCywch4yuM2EZAAmY5jDNjB977X4QMlSH8y6u?=
 =?us-ascii?Q?1nFf4flmd/TVHQVXpLlsi9wLpCm93Ku3aajtBqsomi2/AxrIa1ccM1q/pjNQ?=
 =?us-ascii?Q?HPlolWf1p7/6oEqSw1P/M2nb8FvWSpusSHfbHFzdiY+yG6tB2pv7RNoqFAGy?=
 =?us-ascii?Q?YU4SBNILKS1X9TNhZPNRNjUUGKedumzxOcEfUr6HJRvSBUjox8/cU5mc/bR8?=
 =?us-ascii?Q?nTCuUYyhgykxXCWbiL6bTJjBkrAOTT+9jyOZpInUPTMIYbgcN6XWnEP/c6qr?=
 =?us-ascii?Q?G8LRIP0kTB/IW2hD2RKyYeyNG3wzpYptVmBVIRVPSFRLlq87BlgyLzt6/Ttl?=
 =?us-ascii?Q?wvIUmumeIAhtYb1Su5cowobCG7qfC5eMpXyvD2dBYIiS5w4wFfxjaCC3gHCF?=
 =?us-ascii?Q?9D44uua7yRbNPzjhD1IH8cVou+AyNoAwWQ2kp3BNTBbXoLDFPwYhsWoCgWpH?=
 =?us-ascii?Q?Z6LiEfZIKLQBpBXOHyhJI1puPZMYeLf3IludWZl4WN2+sbG6F56ZEUZ26V3d?=
 =?us-ascii?Q?HlKoFJysKT0TWpkkUwBaVqRk7vXQZEph?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQJSy7XlB1Q5tZHrCvh3dXSQtG0jok9BREOq2HUh07C9Kq+bRsSjfeYKKbdf?=
 =?us-ascii?Q?Ah8+lZ4gfGgV5rMWBptuXzOP8VIzyza2Sxj++QbMqFD0lw/NylzxL+IZaYor?=
 =?us-ascii?Q?20+iZjeHopLAaI7DCqOCnsngzpH7cs0/Fj6FUCd+mY0aVpw/zoa9IAUa97zl?=
 =?us-ascii?Q?GGYy7q0pr0TN/cOmiL64JzpfgXvGU+rfe0EC+w+NfrjGaVMRXxYaXhrFvWB1?=
 =?us-ascii?Q?r6m4VAG9W7SdxD677JjXX6UFSUzVD31rXQESgPQ49iNZ+pSShJYUYR+LWCCf?=
 =?us-ascii?Q?ClRMKAS1G+fK4vzSSWhBpm3Gdb1k6+/fXDDcSIuRtdpOsjekvZk+pYixfJHg?=
 =?us-ascii?Q?TIbIcwYOo8op+mi3k+VU0OszsjGRVWVFta06WdsQ9++fdcWu0OyGpm1znRly?=
 =?us-ascii?Q?BRY/d9wcYKI24aRA5mB0s4c/Emhja93Ai38DMo1oggxEe5kRA6CXO+lcnAc3?=
 =?us-ascii?Q?fZfxKJwRLsQUAepkE2ByRJeQEtZ5Uzr7klZ4KJKWHzwFl5tpn0DV9/eq96ms?=
 =?us-ascii?Q?fwLP8LeUtIRziIYN6neUOOTuTPtbqsf5s+tph5zQGGjJWOQbqILLfoJ7Bu1D?=
 =?us-ascii?Q?eF1ONqdzWxQoBKcjLJvYyOqpU61PBJ12XLIQJZx5k/u4YZd3z1QjuML3nxQa?=
 =?us-ascii?Q?XnEdi2p3TNFGa7x07uFjOYN9hj9NMhWUnO90rVMI/LvkcuFx7vtY83ljtjy6?=
 =?us-ascii?Q?auo7MVbBlWxxCUjkQj1iqD30DEJrzmXUmbOXdJlhJDMjFknRcepJqpPklqTM?=
 =?us-ascii?Q?mI5TfR/4TzGVDskX4NUhtF5Z0y681hpKpnyX2s7lul62WGac4hwrO3LI2tNL?=
 =?us-ascii?Q?Hbvb2nB6+e34hgx/TQ9IK3OqYXtTK2FCw950LOTqIqd7M66s0+D4EfyeMT/d?=
 =?us-ascii?Q?NbAo3bcxntx1hMtkr7P3GXoLE7OpttOSLqlzOxy+7x5s5bTY+imvytM/2DV5?=
 =?us-ascii?Q?yVjWzftd3xtXBm4WZrSl1IwR3IeYLDZ9pFFnpPWfk9qeERwBkTYc6kumLjzf?=
 =?us-ascii?Q?ptcD9VIu4ConYXLT9q1zDTXvYhLVIdVt9Yk7zkkowp29l2VRyrd1Ey8GpmuK?=
 =?us-ascii?Q?beymVJBRc5KsXkZfWVuEt7YzAu7vDZ56kzKmaZ9PB1CNOjn1QdQLZX+FpcxH?=
 =?us-ascii?Q?6hxu21yjLE57l138xhxFEjcpPN+oKpz9YOKCSFM6CAVHycNGNDKQg6bZ8iuq?=
 =?us-ascii?Q?u5Cdk7ChpVHOwbBP4iTyFqA/eJIySg9KPbPyFJwyVd4wnwd/1JATH/SKYdRR?=
 =?us-ascii?Q?IhcUp8SR4dwBWWlfxSTmZH0OVmCNtufmVnLIPuS1ycmQ+nfvf4b2FHG673Ip?=
 =?us-ascii?Q?wP29cZUEC/oyIOPGJQkjyqt+aGbDSt7SBYTiGXaUI3xDesJBijYCEChax/ht?=
 =?us-ascii?Q?6uliqt+N4rZksxoqGQrdEmUik4AWOBFhthlvy1xN/4KhP6yXqzOSqmovRtCv?=
 =?us-ascii?Q?6fcnvDOAuLQ0g8HWJUg5mNNYirD9IksA7Q46gu8ceSObYIjVE+RVIr+/l3Tm?=
 =?us-ascii?Q?hkel94B/CvI6S9Y/EP75rcY+wOlqMRfNQquO+OkoZZoMN9Ob6zM+QxRFPLYj?=
 =?us-ascii?Q?IwBSQ1BC6wVEhdNtPLwKoJkNkEoBy6NbJ1kMGSWS3IdQe2O9CV/Df1dxvVNE?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IF/wYiTKV66Rus3W8eWcpZpbT47WDuN3IDy4rZq3UcWKy/LkYwIPRbuGfGnbSnWk1kCYUkk8ryHpn0l2gQnp67QHh4O/pfCnpiIh5dOEWpR9xPlxFoyyAlv7HWZxIwHEbR2neLZwNuktL+1wfhj0I/ClRFdiNbu+X4ifZNiUBom+kQPD7lGsoBujqrg6HqwZoSlSvIith03lHOgEkz7ojC32+wIFIgluTfN4JxeITmFlExRkxAbZGSEj6YX2YN7vB9T5yLYf+q1NnNo4Yc9JLvubKr/40yeKE3IH/kwKnGnjRFO7xU0d4/pfjFp0r0C7IIOHFCNCzJ54Ao4wsOu5boCq2so8ytGSGny9WMB9ZIpdfjXMkJTyfvIKigov/BScr9yLtdlhfavrADYzcf5ifIEvtNdwjvFjjBxuBXiLMo9UfeoYWDjgzyaJmogGn9VAGhRFIiro8QJeU4+PVRuQketn79cwonmNVd1+LBnAmCP3aExQ9ilYvkJUJJ2tdJF4/oJjUVq5u3ZfG0PiPWRwH3PeaKPCG7OzpHjYY5g67V7xAAqRztUqK7paoqCtwrTpLnp5zxhLNqXvM9tbrcjdZhDbMunF3pV/XHgACuK8KoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c83af6c-552e-4fae-74d2-08de22a48f2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:05:30.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNOFWkebex352Zh2ZzPW2nX0HRsV2mNGw9heCaEaS08J+fyS3qKYmqVVrgnhyYjZ6CIjp4iFMYbpwcXpJ3ZY9nXnGAkda5M3XgPNa4m3AYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6A2C0CCA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=932 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX0MHBBetI/ZGT
 rmHGryKMdEyC4Wpq7ztN6wSFmmmEv22lugdRDyjgusIFAqtY8hn/00tgFwMxPjlYqdHufo1S82W
 rjy58KZTR+2FxcxTF+tsSsOGoT6HE8eIRKLYN40LQ6bmH5O781lFG89t2NUzAEbAEybxE64KADQ
 W8d+9ssN0Q5jZMZDltqiazxu5Zsle8DsTwLwXz/J6KGta5Jjq9HGeS9K+acEi6LKOhbFPzM/Oh5
 4VdqF0Mqscv84mKyhcr2kvd1QPQ24SYYwQR47hYSIoEF/cfJZ6csZGKrt4IZoiYe35GYL0ntbEc
 OYMvNfBy6Y80lVtD/IkGfFwATo9AiNxh30M6T9JeB9eMiM56F04wg4auZwW79yE25uUAbbuTFth
 jfGGSZYpO10nKNmR+73zvI/R9tW6Pw==
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=6915bb7f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFKF31hz3x8rsBJF9LwA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: zZ8MuLIKKP44a2l3MNxh35ne_1P8GN2F
X-Proofpoint-GUID: zZ8MuLIKKP44a2l3MNxh35ne_1P8GN2F

On Wed, Nov 12, 2025 at 05:27:22PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 13, 2025 at 12:04:19AM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 12, 2025 at 03:06:38PM +0000, Lorenzo Stoakes wrote:
> > > > Any time the rcu read lock is dropped, the maple state must be
> > > > invalidated.  Resetting the address and state to MA_START is the safest
> > > > course of action, which will result in the next operation starting from
> > > > the top of the tree.
> > >
> > > Since we all missed it I do wonder if we need some super clear comment
> > > saying 'hey if you drop + re-acquire RCU lock you MUST revalidate mas state
> > > by doing 'blah'.
> >
> > I mean, this really isn't an RCU thing.  This is also bad:
> >
> > 	spin_lock(a);
> > 	p = *q;
> > 	spin_unlock(a);
> > 	spin_lock(a);
> > 	b = *p;
> >
> > p could have been freed while you didn't hold lock a.  Detecting this
> > kind of thing needs compiler assistence (ie Rust) to let you know that
> > you don't have the right to do that any more.
>
> While in no way denigrating Rust's compile-time detection of this sort
> of thing, use of KASAN combined with CONFIG_RCU_STRICT_GRACE_PERIOD=y
> (which restricts you to four CPUs) can sometimes help.
>
> > > I think one source of confusion for me with maple tree operations is - what
> > > to do if we are in a position where some kind of reset is needed?
> > >
> > > So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
> > > to me that we ought to set to the address.
> >
> > I think that's a separate problem.
> >
> > > > +++ b/mm/mmap_lock.c
> > > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > >  		if (PTR_ERR(vma) == -EAGAIN) {
> > > >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > >  			/* The area was replaced with another one */
> > > > +			mas_set(&mas, address);
> > >
> > > I wonder if we could detect that the RCU lock was released (+ reacquired) in
> > > mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?
> >
> > Dropping and reacquiring the RCU read lock should have been a big red
> > flag.  I didn't have time to review the patches, but if I had, I would
> > have suggested passing the mas down to the routine that drops the rcu
> > read lock so it can be invalidated before dropping the readlock.
>
> There has been some academic efforts to check for RCU-protected pointers
> leaking from one RCU read-side critical section to another, but nothing
> useful has come from this.  :-/

Ugh a pity. I was hoping we could do (in debug mode only obv) something
absolutely roughly like:

On init:

mas->rcu_critical_section = rcu_get_critical_section_blah();

...

On walk:

	VM_WARN_ON(rcu_critical_section_blah() != mas->rcu_critical_section);

But sounds like that isn't feasible.

I always like the idea of us having debug stuff that helps highlight dumb
mistakes very quickly, no matter how silly they might be :)

>
> But rcu_pointer_handoff() and unrcu_pointer() are intended not only for
> documentation, but also to suppress the inevitable false positives should
> anyone figure out how to detect leaking of RCU-protected pointers.
>
> 							Thanx, Paul

Cheers, Lorenzo

