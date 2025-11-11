Return-Path: <stable+bounces-194541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C1C4FEE7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE9C189B85D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371352EBDEB;
	Tue, 11 Nov 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BjIjut9W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Snj1clPY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1D2F12DA;
	Tue, 11 Nov 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898192; cv=fail; b=bRdFqjE3CP6RQR2huoPAsJSY3Qana6OQqhfl/iQo1dgAYwVbQil7yCr7BrVIwPchwA4ykJTRLG/NUaLsmD6hjI6GWhPnA5SMJGIi1nzSIUE7cE6CJGraKPVzriXD8NaZuC64gpw9EniryGlffnXtdH9ddm3+pzScNF5f1oyIMio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898192; c=relaxed/simple;
	bh=zoISXw2ifZK5DrzXA+VKAFpwqZ3oSxLvQezV4kFI2os=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B4xLZn+87s+P/08gfFiSQlUz/7AkfMC/L7/Kx54eykLCViGwSJRu1Qg9O4inzHoWdlYbShR4icB/js9KW6Y9v8f5q6h7T62RQ3tTvre/13il4+hWhYOWmRzHfKmMZCsEosQWPEAx/Qim0svFwxzjbF2j7xkUVaKCx2sXTTDRP4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BjIjut9W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Snj1clPY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABLMDJk029362;
	Tue, 11 Nov 2025 21:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=qXAImXyPD8qxteDI
	VkDy7xc5U8ewsLkqaWU5gOOBYKs=; b=BjIjut9WCh6Khv0Co8QPhMC2sTlAN72R
	Yp3f3l6Tv/52JWNrONq4UFCceo30QU38bDo1+VMqMIzkHdwY8Vtc3bN/2xhWXLDm
	KxoGvVfPfl8g+vBreTR9Ig8yuxMuWschza+tBOkurLBgCWHVRqk06G4+TxRsYIws
	TumVY+HrySuICpWZLnWd3kvIreR1ESmXNAWhbb11taqVfRmR/QEgnnHBsYssAsEa
	mQY3ZYj4amzrQqYMipN0JKnu8g/rC+k4eVqAa+tSKxqeV89OKFsd/k6ZtLHeHuDe
	jupguS9inXpI7OmJBQgNHSwiN0Y996cFbscgmCFzJB8PJcukvykh5g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4accts81w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 21:56:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABJFmWt039926;
	Tue, 11 Nov 2025 21:56:12 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va9yd9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 21:56:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVMiG+bnYpf2heqE1uBwGfFTxHjh3z1EyVlYIOvmpmi3NH9PkXhz83uVvsKv16l78JQsDa3Bv7IN3j9E1unYGJOgOnZPARtPAR3t602lfZ895yzXVewRM1q6O0KB8fyBKweu34T/TYcxIia1YQsCuXvL/jm669mUK0BaeB1WpVAZkEoowSioKkxdPh8WOpSnHi0a3yQfQinPnrx+6FTS6IkOCTOdhmWtu2qBIxt2+FYvu1U+V08gK7QNHfaqzJCWfB5khxggYW8ngI7vUmomR1An/rwGxEgm289umkyg5uB2Kd0T6TsJ0SRlSyRNzIs0vJ1REnlvX69uk3eLMRfjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXAImXyPD8qxteDIVkDy7xc5U8ewsLkqaWU5gOOBYKs=;
 b=NnodywyNWqTxTZVMTxG6vODwuk7qf+XY/1NkoUeN6yNz6ROSSMr6X3XHDUT4GZXCgW2kHoYunczJPGJa+i2XHgnNRxaT0RyUT8UwaFC0VIheWvKvvq1IlI6vVBb8g7GgCqvB+/1R79VK42nxgdnGXuUZr1GRkCs4qNpG+4VOeLXAbm+NegKn8YGEyH0lACvMQnpUQHpTWRUrlOzdsxi7vFk+lGBIW2GaWurHxGnYSVQryaQWn4O6mTzNTA+Km8IbyoAkb3VtHbv+x2hNRPeyKkwPumS/oJyKwZetIiATk/zi0jJZRX3K+kf2JF2eFaOjR+dxX+SfcIKFWSNZaumVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXAImXyPD8qxteDIVkDy7xc5U8ewsLkqaWU5gOOBYKs=;
 b=Snj1clPYiSVxPIt3f5emjrohefUMQWmJ2VhER0r1dGRE6lIY870HchlpoNbmeurUSb498LQEZCZil00arxO/7yusb9UZbsUQTUlY2yftgCfrQDwsi+WSpK6Rj1x/DOc5wjW2DsDTW0PCD8UnjCmzWtkfq8lSdaS4gE27srR/W/M=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 21:56:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 21:56:10 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org,
        syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Subject: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu() retry
Date: Tue, 11 Nov 2025 16:56:05 -0500
Message-ID: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0444.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: cb91ee68-fab7-472a-0aa4-08de216d1f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXJDQaw+JR5mvBUdeyp0ajYsSVyj9OnqhOsYt2EZKr27TprhM+K3o/vGG6ty?=
 =?us-ascii?Q?Mz5g80tfC5VCdIH0/4QawsukjFu5OdILU5hufdhmJD6+gWKxeJlexl7/8mps?=
 =?us-ascii?Q?PHELzX/5Y25xNOy2Xyc7M7A2QiVpH7NgCDAYXSfJwf1m9QRA8MVibbzE3iQ4?=
 =?us-ascii?Q?tRSSMyeTdw+Lw6s2Iozrtx6CVmPJ299fRLOIath+96bKWGQe3bMzOsFtW4nW?=
 =?us-ascii?Q?zFs9XSB2zOiPcy+3Z1YBx/HFEaugy2ZVhsWMCjY6WhdmpF8t1b0tMwOicJmy?=
 =?us-ascii?Q?v1MqQcjcndQlsCCWqrI77U0DULglSTIYAn/211dtG6V3HcmZDG/wGsaNRRZ5?=
 =?us-ascii?Q?FYNpNQbNnSxSuGznnjNcg/OvkA8tifurK8ko6Yl7RLZd9XqR3ElPHu5wvSJi?=
 =?us-ascii?Q?2dsg/NwlE2LzUVUk9ibHQ9x4dPquvjOcVxknxz8aS8kEnurEHUL93qy+gfnw?=
 =?us-ascii?Q?eVXMXDcUWFpiRlQ5hL9px/q14ZWo+8uzm60h7XNGMfGhWQQL2XC2KjQghoMp?=
 =?us-ascii?Q?WqrSZpLfVy/Xkx50ZiWrO2nzjbJ/kG1BTOjmxuQVabvE1zmnohM8Jsm8tnKz?=
 =?us-ascii?Q?ZGVBXrvkUGzG9bbPWMXPJ/oBfHU0BDgNp57vuyliJ9Wy+p4KyZuAe2Ymk72V?=
 =?us-ascii?Q?2ya3yzyjgtrZM0Z6opFIGe4cyQnb8d1+rdTgEtuNnJOs4pEemVhWWC4Wqh23?=
 =?us-ascii?Q?r5BiKnF3kWKFAKE48Vl05mPLF1ugxMMpkIfch859sYyjgFUWCkZG5eomn/qg?=
 =?us-ascii?Q?x/q9vdRwIQL5/AOrK1G2+w3UDVJZUtPpNZg+HQ3NZzSuCZv5cs3i85sp5ckt?=
 =?us-ascii?Q?HdIzUNSxl/rv90wfpOgGcmNTimfXC7XykFjfSCS2BbqElcg2ZSDGdeDxUz9C?=
 =?us-ascii?Q?pglAxAPoSClOwz0C9oeNk3QAZS7dG/4TA8PVlPFfvwbR+7IE3mijDHH3qO0+?=
 =?us-ascii?Q?1Pf6cggXOlzCeQ7lE4xu2+zdOeoxthUPnZ5W5VfFFS/2lCAKgwwvROe+BBIk?=
 =?us-ascii?Q?/JawKd75hL1+OMPJQccRaJwDfchlZi3i/FrFJt4OzzEJ2VBthGam6VZ/lZQj?=
 =?us-ascii?Q?1Gsa39jTkRFbBfCdEnXQQHQK5BE5PXpdjMqJSvABrUA9HrptjH0p9wS2rNqU?=
 =?us-ascii?Q?wzzIW5kkZwvRmbrRxS30uMQExOT+LIy3vNhYp+Wuc6X5EY1p5C0MKsDWJP29?=
 =?us-ascii?Q?IqYymTbjPg9DjSaGdCh6szwGko7GGUoDAFLE/s+kpV0TtY8E/pTPKWfDvOM7?=
 =?us-ascii?Q?kq6u5Kt7Ykr3Xv4ECZTcOuChGuznLW+USo/cI3HFlfb+BWYP128/9iD1mxgP?=
 =?us-ascii?Q?hbJZXbbH9h/ISc5hLeVYPOadST3X+M011KZRWZyCqJVHWDxOxEIS9kEVM4og?=
 =?us-ascii?Q?QeTDmsxWnj5aCn8OIj2DLTi1No6tPBg1GjNuNmgnz0UoZG9+9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sv6N44kum/MnUvjKA+fWN6j3Y0o1g/+CejwAeN+38uGuYG6NWfJgg4OHJUsP?=
 =?us-ascii?Q?ut4HT4LPE7QqB4+AVVWUy/KqHbyvWyTscOT9nY6MW9CzDCOnoMx12YIRWDAc?=
 =?us-ascii?Q?7D0OYVdgMh939uOD2p3wQxJBe0WzN2Sw4S73mNDK+SzqhoQJ/pOOTZENcMjQ?=
 =?us-ascii?Q?wP4WAxkXVOz04KpPSeyTOGJ8Dl90O77L8/hKijfZEiTvkGn7Md2tWWMoItwj?=
 =?us-ascii?Q?fxRwnlD4PbicTqZ0fNiedoLTVk/lSmU1Zv3Uu+H5SNiFFpf0QBs7pPR9inyR?=
 =?us-ascii?Q?sDnDjIgTEN4IsWyntNKGw6vWqyTfUWYjlYOolX5OcibzVgmLlwA07r/URSic?=
 =?us-ascii?Q?kclFN2YQCrMuQBA/NBI6Qc0bbCnmlJV/6BDvIrRTx/pDkdGPyEK+Mj4BFiyr?=
 =?us-ascii?Q?9NgZ1K6xMXa96XqnO787XtI4xrVZkCSl/tFT8NhTfIC+MxzzxlWX1URSA4no?=
 =?us-ascii?Q?orfBn4fsln58Z3dMozk+Z9uvZO6c+HlQgn2HUPGHgrP9Ngt3T3Q5OmMi7++q?=
 =?us-ascii?Q?CGx34oJkkGv+NdPN8oyglqNLvNlxqIh3RSW/8WrrZ1UhF/9IRwZDdhvBMzNi?=
 =?us-ascii?Q?v8Kve8B4FSI0ZXCmGrqKyJbB2KLyOtcasQ/pkuGtWBzrfKrzIS939MFXx40g?=
 =?us-ascii?Q?kY2nlw81mszTYEZRKr1dsxWnVjKb8O/hqDSIfoNNuCaTG6GqbtzIVYeeiZDz?=
 =?us-ascii?Q?D5myHhq8/HYod70FhoeOfIaJSKjybsnncvPms4rgs2WObpkOPq0WyvB7HGLa?=
 =?us-ascii?Q?ob/V4oay+D4Z6moZyrkE3SnNo8RsbHkmsB7rjG/KlzRcEbl0s0TK0211WdVO?=
 =?us-ascii?Q?Bd/N3nP8r5q4ym7K/z8pjSEtXjnwxrO+c/W+IuetZ6st3i0k6uqndjBxLMpT?=
 =?us-ascii?Q?BK+C+bg3416IzItXtB8EGFQYL9+9I2uzskVCwOtTb/CEWNucA7NzsyHkE0vN?=
 =?us-ascii?Q?umVjLzhNdkgZwAmVjx2apLxASzF6p98w+OHT2wtXDIjaceBoab6d6hG+Lfef?=
 =?us-ascii?Q?Bs39TmVQrVWRUETGLGZKxnDRoogJRKDvLoXeLLsj+9z9C6Q+lAkfUKFN5hAP?=
 =?us-ascii?Q?uMPpERfYWCbI6NyiOxnikBY0M+xzYyIUs5pw/28E7dMAR7KDBOSS0/39dwZx?=
 =?us-ascii?Q?Ipd4j3mJw23TseXPJyNHnC9mEFvr3b7xiuxmOjxTRYcfclYA9TYt7urvSZqg?=
 =?us-ascii?Q?SUV7crwCiCkzG+I7+eRYIIu0SOvAmXQle3RmWeUZFfv+kPI1FF2YJsiCJ/7C?=
 =?us-ascii?Q?b90+WfhQp+xlWm6bjrThavfhU/3ZLnKiA1vmgRnQ+/GMRDkYpGrfkbBLtgs9?=
 =?us-ascii?Q?oH+ouAM6IGpex2140yRWkvI4zWV77RlLpkKEW2eyBblB8gufh/X5V17WjuLU?=
 =?us-ascii?Q?et6+X6RlPOhGhc/+QLZKVk5X0b1oDC58470rtgc9tX8mfNNpv9IFbPECCPJb?=
 =?us-ascii?Q?Dps7Vq+P0uzcg48WBAYGokdi2GEgJbkl3Bstl8W4VK9V9GJdJx/H3K29NdP/?=
 =?us-ascii?Q?zk7TAtybzwkkLugXnZjY6h6Q+Q12fUjes1PHgK0Xwbr5pBhBbufIuxqb23QW?=
 =?us-ascii?Q?9nqP9tMlqU6VNn5T0a1PWp7bkGIzR+WuULKSszrl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TI8y++p7nEby3hYZc6pfxDB4jLwhHCT9PekXx/Qq2VapnPYj6R0s1mlIKlWjHHaII8cTvps/l55TD5oOqU9VkTzBAqgjNeiBJ4HM2LTH333IKRLfY1e3G4Xx+DlYAmye9Ok7PUcX5CrqMLH5u0gguaYxt5hKT8sn7G3EjOoDCYREmsUREeeoMbef+SE+0lQoOsj/2p77WUXbObdnGN9tgY/sLYflJs6cocnWZurjqCGJ10tCui/cfA2ebi2OPDYyzxD62s2sXWVnmKQFmprn0YdUeX7lr0AahGvbpdLrlYIxbh5lRg1boSqtkkstTLMjDrX3+4A6jNRv+vOmIq31ApbofYWiHjVsyUNu29ncG16AY94SzWC5eF1/QaMfxaJ0SBXAUc5atjXyhfow30kwvSj5rGd5QJy4LvE45ygCLeTCRHgrVZI/4n5vG9+Fr1lOPYgI7m8ZUmEHZ9Vmzm5qou/9ugbStJI2GhPoKFyQxiSj51WTsTEawtCSXiuhUfj17M2cdq90zMSgG+4J9zTL74rLOY3JJhWltKcU/V2jsz1nCe/hSny12o9lH1qLdVz/sV+SM1buJL6Bkts+yHBfVAliJRWLaAkSHHeSsxP9qrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb91ee68-fab7-472a-0aa4-08de216d1f82
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:56:09.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBKRAGKmHjskCqsM8Fq1oPfUSVQWy+XWu9ZroWtnr5Cr70K385f4OSSJfYdorVV2HIxphoWpclHswN6tVa2+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE3MiBTYWx0ZWRfX42sRdUu3S3RK
 AW88i4Pu/9maJr5S9GYs8JZZ+p8A0Z+cWUrQyDTc/dp5XF0gO06OtqfBINwZrxweUU1WBgLdtq5
 0+eI93QPqt2UWjSIQLqlp7L0lPS07AKyR+NFE7ti74Yh3FQr2i6Ia+nrMx0MI8hJ1ejFp/ZDkGN
 jN/hRci1019IQRQPi/f00vwW4Uc+mK8JiTiCwfDfjJF3PR9L4XTY/8JfdhQcI44ue8DlumMt9SR
 6XzcHBcUJcw/SxGKepwL4CV1y/19iDU0+Mw6XGHqBafWdBEy4wDYeIM8IfBjoDC/XfRDcVLITT6
 ZtTiKEmqrKwDEaKxdx0Y6EwuklCvpDdYcQKJo/dCnspc8EeCrB0sBDd/yC97Ve7vMrgzq4KeU5e
 Ot9KbUGUykvv33uZ+UrF2S5GG79UoA==
X-Proofpoint-GUID: SECi2Wx26eEBHjA9TZ-oFeMpUurxYGCx
X-Proofpoint-ORIG-GUID: SECi2Wx26eEBHjA9TZ-oFeMpUurxYGCx
X-Authority-Analysis: v=2.4 cv=BtiQAIX5 c=1 sm=1 tr=0 ts=6913b0fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=rDUhUsTXIQp9qXccpckA:9
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22

The retry in lock_vma_under_rcu() drops the rcu read lock before
reacquiring the lock and trying again.  This may cause a use-after-free
if the maple node the maple state was using was freed.

The maple state is protected by the rcu read lock.  When the lock is
dropped, the state cannot be reused as it tracks pointers to objects
that may be freed during the time where the lock was not held.

Any time the rcu read lock is dropped, the maple state must be
invalidated.  Resetting the address and state to MA_START is the safest
course of action, which will result in the next operation starting from
the top of the tree.

Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
lock on failure"), the rcu read lock was dropped and NULL was returned,
so the retry would not have happened.  However, now that the read lock
is dropped regardless of the return, we may use a freed maple tree node
cached in the maple state on retry.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Fixes: 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on failure")
Reported-by: syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=131f9eb2b5807573275c
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap_lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 39f341caf32c0..f2532af6208c0 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		if (PTR_ERR(vma) == -EAGAIN) {
 			count_vm_vma_lock_event(VMA_LOCK_MISS);
 			/* The area was replaced with another one */
+			mas_set(&mas, address);
 			goto retry;
 		}
 
-- 
2.47.2


