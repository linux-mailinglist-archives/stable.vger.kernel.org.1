Return-Path: <stable+bounces-196853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AEDC835A1
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 078BA4E205F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B972618;
	Tue, 25 Nov 2025 04:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fuejlozw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wTkDt492"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D3125A9
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046071; cv=fail; b=L0BFF2NiVC25DCQq5HTY37TbAXu17B6EVw3bDcgorM70nsrm/XNeuxUSmPghOBAw9mewCNge79vJzZHwspui/RJozh6M2U17ylYnHXLg4ANj9wDykTiYuJpaxRguQjLVShBPKxN3wksmIZbbv5gKJ0q6Olgh9kyvDNCmFo93Ggk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046071; c=relaxed/simple;
	bh=2ERu41T7ql4aANQWBimmFZOqLAD5doltVWAlr9S2J/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UmZI1tjApSb9J0B1ruAjc5PvmDrEGo2vNkatBZ0EY5ADXJl7x94QctGFizm2ID+aKTdD2wShxsvvRn3ry2ZG0sj+J6dOWw0aXs+fi7zRBQv9sZYBiYQmZZi+1nbmJd22BgCuMwroAew7vhGOmfVppwvFw6TivD35guR3Klwf1bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fuejlozw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wTkDt492; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1Duu42342705;
	Tue, 25 Nov 2025 04:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d/5ByJgVGwQEZ2gE8K6fozpVWlrDXFj9kvylf7SzJBk=; b=
	FuejlozwuYipte4I3sED961tBiwJdtbudcdAUfu1M5C9rokbsM2fO/09e92WZOHG
	G0cgBqTWqSzkhAzo4GfZHwpGrSywr4wAUMcPyVamow2/oMIfv1+F/dtywyad8LuP
	OpFyWXhQxhHSPrhxeHPXTmV9tvc3JI6MifQq9mnWJ3tBfT+T9yqSSTWGaCE1lMZq
	xZO9XiV1wmNL4wjbvZhE++iyRgcNFdfcR6V/Hlj3my8cCVYfWTmNhW1NrMC21MyF
	L/e2HvcDQadoH09JWu9uLoIqaLi3d1y1n7s9Wh2aP738rH1Cx1OKIaHB0Izak3aD
	P/98Y26uEQGyK/7K+6BrjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fk3d0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:47:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP4LxoQ022628;
	Tue, 25 Nov 2025 04:47:12 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mjyujq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU87xD1GCMp96c1/yGgU0lN0m/riMCRqyA8G+DetGSYsaHHJFZnIu6P0wJJgamKsRbDZ507uD299WEyZgedPJZPmAEnaphq163kFhC2hRqvN0gkEa9Z4rWXkX0XN/hODQXCbxNQnS3F4k25+nf9fj+naGv9eri62cQu5dSrwps7I2isDiMBYfV8gtj1KRGNMSweGZAw8VXiR8InyhI98dWuIbnb8ss2wGfAQ6rQxUcuQ0CirctFyZfr5wvMQv02KO6Jrit65AjjlEbW1aWRgGYo3Zl14/6GmA4CyDLn4vR/y/FqJ0YtaYvUbutSTtOZDPXoGtvkCl/yU2eSrS2k6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/5ByJgVGwQEZ2gE8K6fozpVWlrDXFj9kvylf7SzJBk=;
 b=gz9KIHxmREw/MWhoshxzWymMng8tUVpRgRxLiy/VCBVjPDwc0mZOVYbw86mmCeqDl8xKqeLRIH2U47GJCX6qww/hTc5fyYlVm5yJcb6A2Jy9NXfCR3TjRFr45G58ghil5UsaIM96/m6lbK9EDGvycwJ287JjEgAN9gszbnrKGKLlSsjpF8/eAGCJGQJQeKtSr6Bn5TUO9xdIF4hkOr2zPI1FyYFw6QRxxcnVOJJA3yo/zLCqM3+sP3QphGRkdSvS9Gyn+8JrhriQfdzbYqbi9Zwges7ENIricVPd57gRy67QRTJxyEPUNBuMndphTPC24hQTSGcczxAD0mtTX6/hTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/5ByJgVGwQEZ2gE8K6fozpVWlrDXFj9kvylf7SzJBk=;
 b=wTkDt492PE673RYXwzXD15zuzwUPWzguZNuhUs6CK2BDe7nsnTeIKCgMX5hNxtz7Qf2wsHcSJ22UydvWyHfrqRQ7YUf9D/aMakkbFChO7Pk2yHSM7RHgJdwK75egwb1Y7gcYjgfuh6DMeRxCsFGHZdpMBF0xpPYuoLgUA6H/Oak=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 04:47:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 04:47:08 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Peter Xu <peterx@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 5.15.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Tue, 25 Nov 2025 13:46:45 +0900
Message-ID: <20251125044646.1074524-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125044646.1074524-1-harry.yoo@oracle.com>
References: <20251125044646.1074524-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0075.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ec91a9-85cc-4943-f058-08de2bddb049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBMTRsZfoQL+tgaq/ra0aFn1kUzyjEipQE34Vuemy9uh9Jm8fzEoCEinCT0c?=
 =?us-ascii?Q?OQ222K1wVJfTX25T8dREiBKwzv8cLbyvX5tzZ/QVr9+6l6d4oGIrPnS2xqz0?=
 =?us-ascii?Q?qKNflxCP1dbbMLXEk8Ff/NduVAboIf7NtVqVf58i1r9O86XusLYBYDGmpL7A?=
 =?us-ascii?Q?SoPiB+oavNOWSjpoCy8qP3Efm9Q90w8YJ7ceYHPMS3EjtzyPHcJ4660vsIQW?=
 =?us-ascii?Q?3vRA77jvarX5htRdticpMkUP2BwprzK7nvAk9aZziFBbzwz1znyIp4N3ZgPk?=
 =?us-ascii?Q?03cn6ClAXiklkvXgMIohPd0vL5KQiU3CjW5XMm2yNyZNuXdpMDbseoZI4lZU?=
 =?us-ascii?Q?J8hcPe4aSSHgzk35KPFZLOxefik1yM4C+59EnxvJzktNJAiAEMoEdpjYElTi?=
 =?us-ascii?Q?J3ByHYgFPsijjr1Ku9IXtwkdsFDJ1tM5Z2w2PKjKw+4lKzTPvYvJ4DtEPk7B?=
 =?us-ascii?Q?L7XWK2BOl5HAJYLx4rGrYXCP4D9QGrPLqpg0MR6spBUYRFZJpXAtyhRUWblf?=
 =?us-ascii?Q?k6dQkbfbdW7T52QfRdSH20uVsm4tXDVihnFU7UyJdGsHDQx8wc9hupgaOXge?=
 =?us-ascii?Q?ajf8q+ysEiRC6D6HyPCfV/5Qc3qjnQaaUjM7eXs6lhZON8CC+ZrIJMe6PdpI?=
 =?us-ascii?Q?raB4iXW8ivZ4pkLWHAcXskJ/DYt0/d9V/0SHt2JpFssKiwiRlzuhsxh6+vH2?=
 =?us-ascii?Q?OlOLzI3d8VKaNpI+ZkKCG79S0cQ4Vy3gpmBx8qNt34TahSQiNiikINRJS7k0?=
 =?us-ascii?Q?feVaMEXH+dSkVMcY8FrJXA66tsfscNGEly2zdCFu7Ll1gFWnw2cDfu35Jpvc?=
 =?us-ascii?Q?DAaW9youYy/JfgWxbH+oWU39FJnE7kHhCQVRL9390BAb05WpGLd89Qbp4Iz/?=
 =?us-ascii?Q?BZ9TWX6daNfqjbrLyQsNM3FwIIxlMo++A8U0ddKkTNXD2KxlX9zhz4goQ0oJ?=
 =?us-ascii?Q?2m/d0rSiHBNMX0M3n61Gyg7Ga/IJZbrBwl/fiNqxKaBcSUIOpTaNmfU+1ALk?=
 =?us-ascii?Q?uFfXMTsGJ/doXoqgwF9MQRZC3zy6wMVdWP+kAdZoiqWDtmeQhjTS8arV7/BH?=
 =?us-ascii?Q?Xjdmgg/zJy2lVC68UMBksoKc/klD4hOmEJRNJ6m3vCfXvbmlzuLV99hSIzPg?=
 =?us-ascii?Q?IHULpVMNkronuys5RWjif0zjPlm8rz0RA+jikM0CobXIBKwiPuUb+zf9mo32?=
 =?us-ascii?Q?MimafsWx49phKF2jIqnyfsG1bxO/VmGfXhl0wKKW/dIeXz2JFqNmqG3k0GCw?=
 =?us-ascii?Q?NjNNe0DPLFPjKl6ThUr0NyiaAqLa7oxo9Y4iMqFhQFga+S3IoE/ZfxUMDYpq?=
 =?us-ascii?Q?lsDWSAbJJd6d5zO5nTIlWbOpSoYx9oQN6xRToK2PhwyoKD0tHkPtfviOcVtV?=
 =?us-ascii?Q?pyCe0QNUG4qb4qBlARGuRv6hv5UzKT2MA8Bzmf3vf5iJ3PKgazTnkT4fpeI2?=
 =?us-ascii?Q?YPcAgkpR4UgWFqJ8QQpLhaKewkIdmRWX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?quAjNzKPhFmsdS3JHuG7ifaT15CIzWCLxbEs0vrvvj5Gai8g0nn0TrWJeXmC?=
 =?us-ascii?Q?0YhPai8M/VGmVg17NS+LM+neybLJepSZFwE+6h/2JSEvt2o1Ddgakn2TpbKr?=
 =?us-ascii?Q?jUdgryGn4saHi74k8mvSm9HbCv8vr0oEhP/AzqdAt2ekgzk+S75MdgZqQJrx?=
 =?us-ascii?Q?SQsRIsCDauh/aEhh7mCZatiCbPAkpbi6bLWvocVsy39q1Ik3qlKs0iAVxvZg?=
 =?us-ascii?Q?qhegM3Xf6vs9nUha3LOe6QUVEjT0a7+w6MlwlSpZ+GrRjGhoI7jl0a2XtHNp?=
 =?us-ascii?Q?a+3VkjRPYCCTtzDQ5Sa2HhCKhL/IkdcK4yJJ3wHAndBFcsIJM8mWBmQFx+w2?=
 =?us-ascii?Q?0T/UL5gt18aatDMb0WkDMY8gdFR7DJHcPAFhUCnHYEMs4MbO7VdvTh8QFjp/?=
 =?us-ascii?Q?LXhUp7oqMhSPsGDgze81ez9Q1fkexYqVcAaivAW7SbZFdWLkrtb4F0/TTnjR?=
 =?us-ascii?Q?AXdWsVGL2iVF5Zp3cnQJAgjkUkhojPS/OGQtwjYldUV0Hi68XeHlkXwNiSEr?=
 =?us-ascii?Q?6vjJD839DyXfZPS3RTuHY0sN9+OfBwXTzkt30oV3BJ03NDz8WxARDYXWEvip?=
 =?us-ascii?Q?UgTU7DrumP8U/+EyQSgm+JE8xPdMYaAd7LGmvVCE+47TaueARBG76kEN6+Ed?=
 =?us-ascii?Q?jtYtGFH4wtk5PT1YPzV/sIR3q80xER6wQJiBjbe8E7oZPfmk+IeY+5YIstUp?=
 =?us-ascii?Q?rdWUIrwamR0dntVwHpDoYiVGSPNVZ9qThBmWzvnXoIZmkue9hsWhVvOgvMFQ?=
 =?us-ascii?Q?er40mzG6H0KQSOi1gfFOZroROTT4lx3NDlAPiAAEA8i4DTl5n1fzun0B/d7P?=
 =?us-ascii?Q?IMf/nnoyC5CE/vWrCejvZNZ23RQ2FSxAcSImZ2NmzMxs0x1t4iK8cUyd2TBc?=
 =?us-ascii?Q?mV/MCCHV6Wo3e/iYUr5CqYpx2B4buLOuO3fMnGvIYXyPpgf0yhiw8xq9icD3?=
 =?us-ascii?Q?CgVWu5bKQ5YT6E7Ms4uZEimEQS6L+rbdsiytp8fePG+EuetFXaxVyGbAV9xS?=
 =?us-ascii?Q?oztbERTMjVti7MTSkdMOAiMYLQNH5hww20blyl27gOB/qk05TOTT9w1oo0sy?=
 =?us-ascii?Q?V/oHIxNcmrmu4TG8nLC20P4jfPjXvIMG6dRMw7YJ8x4YAUqxc2jyLoK9HStJ?=
 =?us-ascii?Q?ws/IWWJ3WmmIcdzT3lkcBg+RwyLHUo9aJSA2dcrfP6/2LGpzkc+kSxk+OP7O?=
 =?us-ascii?Q?8Q3T6A5DE9AKhoL/G6Xu1S97F57T4dfYxbnSlALhmAnl+BE2+xdOhJeyFVeT?=
 =?us-ascii?Q?restVgORYVhWpqodpZWeLmtM2qYgTE2OTrOawzJmNxsnt5gHQckXYb2lKq6g?=
 =?us-ascii?Q?+lUzxVGsq/9WDLE3uX8rr9bY8EEx3xbwV+Cb87XFzEAbJeih72e/ULcj4GOP?=
 =?us-ascii?Q?Kj7kXaZGyzXTgUCTNoU2ZLhS/NwZoo6U/SxztqHrlAsbdGERw7B2p2O+f4Dl?=
 =?us-ascii?Q?j5CplT90QWyoSjXKzcSPtFIhlNJhOEjBG8thpqfc8zUPpf/sgZt10LUzmlpf?=
 =?us-ascii?Q?Xsa33A0thWcGx9u/CwBNh/t1yICkzP1X3OYwugEPrV5kMqB2tURIb34z0qYY?=
 =?us-ascii?Q?slyrTr45ZHhFTehFwk6R1ed9m6QtZ61+CF7hWyHP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d/g2UgwEpLqw4ug+WfB+G4sQ3dQ66ARsbhi7nJYo9Kh77OWUNwBVco4uQbjkM2+BssoYAmDVlQTy09KnrV6N/skJuWYxkxIdISGk1pMxhwdwMqWlnfHUfR6J9oFiYYDIHBqcZU7WgX7IuXULZbk7eTLls2pTQR+Na32W9b1LDMPM7wiMQjuYOKz08cdDczvJQ6LDeKxKV89mz4nQKs0oxidYUBJRtcfc4bQf3Pqpu6GgeOhWgMxSGSCL3BGxPHr8dWkzB785VsGzB3doYh6bUo+0PykAn5Gv1Cn8ivM/FdsFeZH4L2WFAH5/kIG4qhCGx0kPGBKoUrEmmCFZRQZTBoN7UEYyS5Js2UaTtMGwnrLb9HtCd6gP96CNpQnyGPfeX40xzSt4JVJWYfyAUy6Im5/hwzNXt6PYvYIfIVvLfEXhh3wIS9Y599Os1xdvDi9ed7w4YhCXbLsdpB8VYYyAKY8a6XZPFQuk01CHq1L9RJLsm9yljqxBg2OdFAXZIVVqJFU3F5vgQpDJlOrQEOd41DKCB12Gd0SB2/aY0ubZpl9a9caJ/bUhOix5iKIRZWynIVG5Erb4jWCRQgJSeygWRQ7x1UIrrppbm2coXy8ArgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ec91a9-85cc-4943-f058-08de2bddb049
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 04:47:08.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqAjLRD9RTqkrxV4fSgMdIejli4ZCbZLQQHlCHFJiPQ5DDWUcVb/TcdJZgpawlM9IiLsPY6JNxqj5MyzWaBMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250036
X-Proofpoint-GUID: kg-tsqDYjXJ-t7HLj2_kNMYwSE3MbNu4
X-Proofpoint-ORIG-GUID: kg-tsqDYjXJ-t7HLj2_kNMYwSE3MbNu4
X-Authority-Analysis: v=2.4 cv=L+8QguT8 c=1 sm=1 tr=0 ts=692534d0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=bsZYzbwDObJwb2A-_GYA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAzNyBTYWx0ZWRfX+S34GHeqfjOm
 V71hczuyde4zPAgekXwYfU/Emc2QelOR1EO3y2PugnovDrA4cXIVH07zDReFtfqOZ8TRu9snDaO
 VgSTrYT82A3MAFv9borJHFpG1m9q0EUesY1W+DKRa1SOO/PHl91lrm4tZ9q+whX/XM1hQ24TXh6
 icrrshlEIAUZAyy5a3lQWrGSNqVUqztOWchxfHxyvgym0dxAMwFVjFipmhuFbRS2s/9hfkFf4Dm
 OzT/JrK+c+U+RlFZyZDKmwOdMb0mieCNqYIrRXYVgPAB8tp5A7pRg8umJqtPofpNgHFFCuqr52G
 Y/Yi+SKBbiF/TBO3hj/SQKrFSBziBvLtkgVtPa2SykwtuOYKI8E2hOlk8ILBoNrEdPJPEZ2HjEN
 ONAvwIZwduHaUmCgwELTuNpg+z+z7ktDpmuUk68ZC2HzBWJbIt8=

From: Peter Xu <peterx@redhat.com>

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
index 60572d423586e..ca26849a8e359 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -208,7 +208,7 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
@@ -379,7 +379,7 @@ static inline void move_hugetlb_state(struct page *oldpage,
 {
 }
 
-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3598925561b13..8df1027982532 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1910,7 +1910,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70ceac102a8db..d583f9394be5f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5644,7 +5644,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -5652,7 +5652,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f089de8564cad..3d984d070e3fe 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -634,7 +634,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
-	int nr_updated;
+	long nr_updated;
 
 	nr_updated = change_protection(vma, addr, end, PAGE_NONE, MM_CP_PROT_NUMA);
 	if (nr_updated)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ed18dc49533f6..58822900c6d65 100644
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


