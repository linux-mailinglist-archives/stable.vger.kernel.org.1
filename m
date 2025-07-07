Return-Path: <stable+bounces-160334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A9AFAB1D
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 07:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60F117B3D3
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 05:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAD52741CD;
	Mon,  7 Jul 2025 05:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JWJ8LDpx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SHgaBnjg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA68271442;
	Mon,  7 Jul 2025 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866913; cv=fail; b=JJXCJivbF60xqHEq7Tfy6dpLbdcZnFzEDex5bSh9OQSzw+4lQkdO+Mtw+HYkIcY0J7A0uJnkh0+P7voGUScppnJSRqeBaHIj/fw1TFEA3Uhw6SoMZqZ2DVk3CidzmEYzdjlSjTUuFs35mqzVx8vfWfbR4gkKHBMb3xbF7koCZvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866913; c=relaxed/simple;
	bh=KV/KWTT0tJGSObWd/LgAu0DaTVyU0B6uWN+wzo6Fgl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i8XLgLim8kQZkA3f4kccbbOPJ2+kY4Xf5yG0Zw6Uc2XDPs8eQS5bkHxIOhcuntc0TLruFSIa+bbqnjUtQMQDh9j4SC+D6MzXEiryp+52nULcxY4GU+PkSTFN0oF5EinPfikO1xrcAD/NsZMafqwigzRgQSslfutR73vWY7j/yVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JWJ8LDpx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SHgaBnjg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LZ1OE014659;
	Mon, 7 Jul 2025 05:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=auKPspGELzL5mIoJ6o
	zpGZaLW/woeqGZJ0o4C/aMOlU=; b=JWJ8LDpxkUU9aWCI2huZq97bhd2YVNDqTd
	8v4QNw3P975jXxGVwPX/lP+4sK5Xw83kG4cjPkyMKIMbzQMVkjJP2Usnc8nYhQSg
	F7qM6NxRhZIwAgG3Vwd889gObdlsLTLxL8yUlu60+uWZ4yhQJpz7gxukb6S7J8Xv
	qq3HDrTHtskPZSopWSoIaox/FUC9U2I1XL3DWArVr+htGbicH4GPtNfcF8ZQIDx/
	bvNQRLKR2OUciuN3k5yb4hkOlalPwtYNdWN9c8oCNaYG2B7egHLX+f/M6ZucNfDB
	4JDxzNUrC0GoJPfjLk4vKjI1eZBSLuDbxIdmmCnahX/DeZ7Q2PzQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47pv3g1yy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:40:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5673e1TN014222;
	Mon, 7 Jul 2025 05:40:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8j937-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COFCOaEGuuaKzavb+G3L+TQX3YEhEXCMny/mJmFtX4sxm+yqEwsvF8FS51OkxmH7AFVOZAgex/0cp4GQhi5ABGu7DEPrc0vTHlky9T4qONuAdXB6zlJGhaYYjUSNtSaQxoBNvlu1aeUrRWxR2/oJlPgoDX6ypm3qs6bQ/r6kiYF08fkXX3wSpmQ1eTpKlR/VuuRZBH9mgyTk0LwNTtl2VN0k242bOX7koAMxFD85JbF0GkJTshQb8Co6X7ujro1YBST8+0MZUym2XScKLfzXIj4r057za0DHNmcuygyPLePHimb+Ut0MPO8JYjHPf5kzKIfULnhroTbqbJtXiDWT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auKPspGELzL5mIoJ6ozpGZaLW/woeqGZJ0o4C/aMOlU=;
 b=jPCOvxJBPt0HejT7mdISnSJNSXlfundqSySiDaLAFdLas6OozJzqwS0gWKM7WrnFwGkDwTKOKmkS0sxTzleRVyhqGZ01hDSp3zW6R4hEf+8tupOh4AZBB7lplkTxWkBWhMJQJXQ9D2ic4Q1B2mao2gsB/ISeuU3y8vjxD6axUUHAsdu0EyB9m9lr7bM/r197/s/G2oXYrg+SABimi/h0Kp6pkcLSZQB2cT34UpoJf0BjSKmiHEjr5IJJWZVM8J3fAtVXtTmp3YPj7tCKhbsCgu0MIrcxffms5Ku0kTEQ96uGjCTaLDLyNGjYfbj+V3u/5k2IzQEPy7zeo6P9ENPl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auKPspGELzL5mIoJ6ozpGZaLW/woeqGZJ0o4C/aMOlU=;
 b=SHgaBnjgEI4+CC5wEBk+L0qF5kxurevJ5NHgoHYR3fpcZsDH4KMsV05awdWbSLyEtLkpBeSs55kZeY1aVrDPc71obQrN0EtQd7zgbhPOx6Kag4iepkceRNQjh8BwYZqMs4zfzonocPcDSbFldVqpL9K4AMxLHQtK3CgogypM1ao=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 05:40:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 05:40:29 +0000
Date: Mon, 7 Jul 2025 14:40:18 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com,
        baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        lorenzo.stoakes@oracle.com, ryan.roberts@arm.com,
        v-songbaohua@oppo.com, x86@kernel.org, huang.ying.caritas@gmail.com,
        zhengtangquan@oppo.com, riel@surriel.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, mingzhe.yang@ly.com, stable@vger.kernel.org,
        Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v4 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
Message-ID: <aGtdwn0bLlO2FzZ6@harry>
References: <20250701143100.6970-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701143100.6970-1-lance.yang@linux.dev>
X-ClientProxiedBy: SEWP216CA0125.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d7a22e-8599-4f62-3b80-08ddbd18c852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTlMMzG2CuKkejYwWG7p8xHuL3jDhxYFhtVSVdFzPJhxCPD7NSEEqzGgLlqt?=
 =?us-ascii?Q?v/sW1y2NsOuvNt6JetWDMaOodrl/DCB0SQtV17Ses8is2E2qHo0pzNzuK2VM?=
 =?us-ascii?Q?4e/BIirueT5JakeGs/OQUF5mZuUp985eSpgdTfChwNKYXRaCrsYJvyT5AfKO?=
 =?us-ascii?Q?5uBBnmbNNSGzuHVauFCstPBJ3GLvsLtWhRJbhpIU/jlS7lOxFzkn1mU4bIGM?=
 =?us-ascii?Q?TsI1ajJxVhdKJ7DVArbzzIvynSW84ZQHb0Okt1OTFvFnBuFJLEXfJueOx0Ld?=
 =?us-ascii?Q?/BaeDfX7uufnURZefvpKBoaNq07sOUTdYfCMSQBtdgEXbgVD5ZFauLdbK/7m?=
 =?us-ascii?Q?IHOkig3aanF2rrZClgJYlGKiwOiG4JyWfivX6QOAg8ocSb2x/1IoRCCPngf7?=
 =?us-ascii?Q?xqfLYoo64UA9/7LfZfiQ3l41cesT/NpApv+EtFFbfCSiWwYQIHNDlSy99MMR?=
 =?us-ascii?Q?QeKTx2eZLRWoMNELezztSfYWaLd1ah1b3HGS2y7qX9Sz31ygS/fct6qlhPXk?=
 =?us-ascii?Q?25imvcQbotEFWtnRUXzoKHCCreaYSkBG0qvPbe655NAOGWUsi0Br/T8+Nay2?=
 =?us-ascii?Q?BH1ite4CNGYgG90ghVh1fzH2eNSw3e3QAWNqFJ69VA/ob04+QtuO+WGJ6Bli?=
 =?us-ascii?Q?RP/tN1bVrUWnn9it4Vazog9WPLfOnMJGHlNTUoFPVDhzZZ9f9RL0E+Yab5rz?=
 =?us-ascii?Q?wQVMO2i6zIE4u7njybS/BwTHG4ryk7eGC35tlwrvqDiFfu+zhD6mnoN/WGM7?=
 =?us-ascii?Q?42t8Q3NQDrlYSuak9XK0pR7+mmDxTLTaRms36xYlWy45/LnadhDuQb19YfhS?=
 =?us-ascii?Q?MeURnrynmvD+N3aGlkGFc+FAdstO46ruOkmLZvOOn9l3IkXQ0lWolnXqOy1w?=
 =?us-ascii?Q?BCOwxCfSdlJ7BQywxcNFoVCgD8zSv5gb2tgfdZF4YaVNzNMmifgrY7ZfOh7s?=
 =?us-ascii?Q?zhVs9dmr+cMvqUpZzSEn+mS6BXRrQol84qyA0/ems7einl9SywSswlkWx44i?=
 =?us-ascii?Q?1eLorARYLhWgi26/vVEhRE3uAR5uectqwyCqBhepsUOTp/Lu3LMnmQ7IuD8q?=
 =?us-ascii?Q?gaSOK3Vr6DRNCyw2jkkEFGNky0LYDxCRArP2iNjE7CoSv0EI0lAYVnwGPmc0?=
 =?us-ascii?Q?abimZ+pOebzWiSeYBvsfUkoercGHBiIGGVNTsiRCt+RfG0qNLJfjLorVpH2y?=
 =?us-ascii?Q?kaQOgpXl3XpdRcx6nK/jh6g0Pdsx3ph+Aif2e59+oZa82ne1Huhep1729d2t?=
 =?us-ascii?Q?Cqz8dbK+68bMN8EIHaS5flj/QZOHNrR1c2X5Je+nrUPkHONeIU5h4qhqwviB?=
 =?us-ascii?Q?sHVTEBWcniJalvvR2MA55JNtmU6joeMzgdoABcURDp5DwZvlIR3eqhianaNm?=
 =?us-ascii?Q?SL31g9l4d0XeaWcSfAqnPEX+RJ/rkyl+lwdaEL41hmpS3CmhHwzOg2QvcWh/?=
 =?us-ascii?Q?vSQPwPDFaVY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ktzPHou+F+NT7Q+9iYeS5+kU9KcU5a57fyw4cp6gILYdHXXC+yOu6fI6iafF?=
 =?us-ascii?Q?f1k3I1pKeYURpcwOUlHC6SbaWXOAqdqdFIBG64B8qB7zlTewyJNoubpNtItn?=
 =?us-ascii?Q?4zEIkeVgYKMluPU1tSlzlZKQQYyjsjOOnlZEjR829Qcczdtclb+lXdp+Mmrm?=
 =?us-ascii?Q?vGkklczrGNC4EEOiYAzdbNgjcBcw1jwKGpJTLVPXYNAQG34dMhnQls9l/ZZo?=
 =?us-ascii?Q?jQeomR6dkS9khnd5EKZQu8AliWqX92d1WYPglmwIOjABXlBybWm4N5oZwULj?=
 =?us-ascii?Q?01JfT7k6ByZnJntBJVru14iIbv9WBY3qIk87Qi1v1nibQNUCaxXZ9gPg176O?=
 =?us-ascii?Q?kav94FzEu2awmA/q9EM0BMHdMAHnuGNWXXPLHeRjlFHM9H8tf0yHyko4WpDD?=
 =?us-ascii?Q?n23/OUfysG6PBgR8GOBP549FY56QCfLvfmVIWxg1lIiF4tGl0MDgrVKcWd2e?=
 =?us-ascii?Q?eD/kQIcZ97FO62qN+OqrP1n1ZO7CS1qxn3GPAISTcGM+fFnFu62FU4HAia23?=
 =?us-ascii?Q?BmhJqVZdpZEJdIi2a0syp3geXdXEE7HeFS0fD7zQ886NcXK6qe/ToJ1+6p4q?=
 =?us-ascii?Q?31d0M2KKyYrs3v9UHrvwL4rZs51rm5TQN9DhBFT+UcfS74jY2OD8dlaLJsSl?=
 =?us-ascii?Q?4APaQ4kNlIHt1lDczAi/4/rP6B2ZLleu98PuV1bRArUUuocJFuxKeUmXfpnc?=
 =?us-ascii?Q?CgWCjSd4A4vdXlcfvn+sBSzJLFXRt17q4gSnpoYnQQqctp4+zDeQ4ZyqsQuZ?=
 =?us-ascii?Q?arkFyHuLT0EZ1xOpbuBDn/xOIusNIrl8v7wo9YGAr3SMFw8WgvuC4Rstapum?=
 =?us-ascii?Q?cLAe0oRJHgSwlERa5WYWyBwB7Fe+BGClf4bIqPKkpK+9d/hoep2IFE5ctS+4?=
 =?us-ascii?Q?9zMNAbxYHZIjso36MvLIkTNV/HPrY3/rrrJ+6/oeAMebfabpfZaI9WK520xw?=
 =?us-ascii?Q?ek9lnEDobidaKgSoXiwW9HeIDizyQwJkkA273TGYa3gbFwRxl1jrGTZouy+n?=
 =?us-ascii?Q?W3JzQ2zmko4adEynyoRuioqq/8LSVRu0RzbwPTGBqwNCKwKhDt0IOlFXZ+AY?=
 =?us-ascii?Q?Jqy8ibdkNY4gx4sekWP4PMnedbUk7leGT2ta7JUGUCDQ/Nlv9V23iE14ZlMP?=
 =?us-ascii?Q?O7uvGLGW8J12ifRzFhkWdxZCSpU9PW3FxufqNAK0LTUFauQj43LjL/49OniV?=
 =?us-ascii?Q?BSum3G3l3HREhwqzxnqNZuQXJzXUvuJ8AlC2qWK88v7zOFjmQPBPNfdhhGB3?=
 =?us-ascii?Q?b1WOyrQyuqLQvGSFeLho9nFNFVDjJnaFIJJ4kbuHUpBwwEswjvorvbtuzmCu?=
 =?us-ascii?Q?+FZzlJ0d0JNaQcqXFWgrV9kUJKeU3IqdyezHNnAkOVq/zULVEHJzqcfYvv4m?=
 =?us-ascii?Q?v6p5pqxEMHkt9XaYKJS1h/1aYmNEC9E0g5CXj4MeUtTf402t5NU73lXFZ4BG?=
 =?us-ascii?Q?fIzWg8eDZtcUw6OrOR5PyBHHhJb8A8eAen+CHOa4qpHwQTtQcYqD+a8rPHPI?=
 =?us-ascii?Q?JTwBd717DpVkL4VtIGrM66H+SJPyRUin4/DaDZHxBR46SFWc+kQAqk2TUFva?=
 =?us-ascii?Q?hmUunU0K6870kEe6i2E1c2lGRGCAenWrrP33qnqy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p9q6vnWfqiCs65kQ0L9nqiF2ogSv19EyU8GIElB1EwN/AnGle9F6obwSAqS9FwONoncxxdhfBDVMaDFKUb+OQoFukqQ7ZMjpP36IRW7YSk+3SMhfcOU4RSjEuP15+VgdY4mtqMXX7RpOUdPYW7fQqWGVFK/20GTudZkxtRKeBvR7b0b2fxmPC5+rOGm7O6hvTAZlFNRm/Kin1LE8ETu9NuCm1zK+/CeIZMaxQfosx0utEOIL7ZVo1p+uAgPAH+M0ylJQYB08oaupfIwR3oZflliVzHDbPQdLyU+etsXBrJPW6ZMdI2hfCjz5mTLE6zQdm0T2xD5jXqBqOozklVEVtnFpGWiNlSb6YVkil2dvLvXPXMdl+n4dfU4fmxUBSA8KPkwyuoS4jWc2euYzF3BMEuoG+eXUgFWeLwUexQFcOz8DvgpvWUzBRBmT9wCa/VldIVIXA4uydjuQW4S73cH3IgPMMaNiasFKEHyN/fK/7iSmtGL7TS3oPh3hhlsNLmw0jgmuVO+DCJ7DXUk21ZdWpHMrliyQOr48pBQIgigniBiczXN622su1LDwGR2abhNkovIJY/spuhE1ryLJP2GebVWM45D7x8LBGaHGz9XSvE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d7a22e-8599-4f62-3b80-08ddbd18c852
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:40:29.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyKld1eNdwQQiqPhLZYbqOCJo1tQ0pSz23F7csI+exsBVfVFxzUNXPfYtqMt17prmfa3wciIlmO/NGBUE/IKWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070031
X-Proofpoint-ORIG-GUID: bPXUSnEHMerUcIM4nWqsatN2T7qaxESO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAzMCBTYWx0ZWRfXwDCgdxR7g/CF ZM2WhdXA3FQZyLXObPdL77QJzxwRpSA0L+CRXGpki/j5/3cDZ0B1GfWsIy2v/afcbwCzxFOgiTp x7d08YVXRS7L1JoTqD6I5+Wz1Ghz9DOy4NCSZ0fm3N+3PUCvY7G4qRCu4+SEWP5ZDvj5Dn89mcY
 4gAUHYbdnI2SmcrWfeDz7j/uI0xODV80KUyfh0NAisZ61aZCzyTjdWRwoSzwcqoVOG6j7uP7ySd 5kB5R3KlwRqNTYj6lxi4t1x+dCG1BSpixoF4tPflkuUdR9lx6ztoz2hSZWoFAR+Ks17J5m2ttkE bVlJlK0O8NCc/yVq1NqfJh3rHwlEuqhX0sVWygTvA2f3BI5fiXouVMR20VP0gIWxmr+7F3Kw1GF
 LR92penM0V47IioFjz2yXQ7nDtHwY8mHDFkkuGlCUv5S+woeYkbW4XvJXlWa4/3GDvZnxxd6
X-Authority-Analysis: v=2.4 cv=RuDFLDmK c=1 sm=1 tr=0 ts=686b5dd1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=7iVandTrDhr6HkvTBdMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13565
X-Proofpoint-GUID: bPXUSnEHMerUcIM4nWqsatN2T7qaxESO

On Tue, Jul 01, 2025 at 10:31:00PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio's PTE mappings
> are not fully contained within a single page table.
> 
> While this scenario might be rare, an issue triggerable from userspace must
> be fixed regardless of its likelihood. This patch fixes the out-of-bounds
> access by refactoring the logic into a new helper, folio_unmap_pte_batch().
> 
> The new helper correctly calculates the safe batch size by capping the scan
> at both the VMA and PMD boundaries. To simplify the code, it also supports
> partial batching (i.e., any number of pages from 1 up to the calculated
> safe maximum), as there is no strong reason to special-case for fully
> mapped folios.
> 
> [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: David Hildenbrand <david@redhat.com>
> Closes: https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
> Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
> Suggested-by: Barry Song <baohua@kernel.org>
> Acked-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

LGTM,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

With a minor comment below.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index fb63d9256f09..1320b88fab74 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2206,13 +2213,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			hugetlb_remove_rmap(folio);
>  		} else {
>  			folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
> -			folio_ref_sub(folio, nr_pages - 1);
>  		}
>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
> -		folio_put(folio);
> -		/* We have already batched the entire folio */
> -		if (nr_pages > 1)
> +		folio_put_refs(folio, nr_pages);
> +
> +		/*
> +		 * If we are sure that we batched the entire folio and cleared
> +		 * all PTEs, we can just optimize and stop right here.
> +		 */
> +		if (nr_pages == folio_nr_pages(folio))
>  			goto walk_done;

Just a minor comment.

We should probably teach page_vma_mapped_walk() to skip nr_pages pages,
or just rely on next_pte: do { ... } while (pte_none(ptep_get(pvmw->pte)))
loop in page_vma_mapped_walk() to skip those ptes?

Taking different paths depending on (nr_pages == folio_nr_pages(folio))
doesn't seem sensible.

>  		continue;

-- 
Cheers,
Harry / Hyeonggon

