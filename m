Return-Path: <stable+bounces-94053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8049D2D76
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 19:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4093D1F2660C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872B1D1519;
	Tue, 19 Nov 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rok72SAh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wAudpcPR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DDB13B780;
	Tue, 19 Nov 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039218; cv=fail; b=Wlq6NNb/8K2AvkWJm9LySaT4JsOpAvpY651fK7I+//czFBZg85d59nwraOmi/djlSC2ZJvVjRc/0OsAC5yOkpjACPjc3XvXP8MraMN63NsV3gdyZx9ytE+fN2reEE85lkOK0+VSWCt9pcfAIC02HO0aJdDpfl1WN+BYsgOz3DsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039218; c=relaxed/simple;
	bh=N0knngdYSsEGzsIIVL2BljdHE/U1wn5DB9xKJd2qBho=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NwqjGXQ62ADoG51iL6NYw1hvTdyXSo9pEsgjPDM/eJ0AXqWAiB+Z4tWDkO5AmATww+13JXXxH0D10G0Q0CGBcntYcmfIrM2F5Tpggz8q31pMcx430yQVDed33L33+NKKrVjgk6NFmvCTTkoPP3NHkgwyih40xW29RXx6s40LtW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rok72SAh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wAudpcPR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHBfHN027726;
	Tue, 19 Nov 2024 18:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=ROJXPTWSiIFMiy0X
	wSEjXYpSu70jeFVcRyMN58r3aMo=; b=Rok72SAh/YfnjQCLQxt5WCXAbLNgztlt
	UE4w7CuHBgznYTCJoz2pMG4KHQu6q3flhJLRwUtS9s6QfLnO5Txxwz6P0FrRte3q
	ih0qKY2kO1zqQlyKnXX64j8Ml2BhzrJ6nQoq0C7SR0AXJZAElhhOrttT6OiKQHsh
	nsegm8pr15CkeyYWAw00OCDvDbR6Mj17uuIRPNCaAOh3X2Cg68kyMZb/aQyhgoS/
	M6oVUYJzV0Z7WF6xdim+HHurorDEaBfH4VesWne9MwvHqgjpf6mpb+G+K/X9Km8i
	X7NpE6LiJ8wjv3YNqpQOMPw9RR1ZCx8utoEsJNY42u4o2t/tgdd1eA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa5mn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 18:00:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHFxAs023209;
	Tue, 19 Nov 2024 18:00:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9a2ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 18:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYT+ly9evLmKoWTw+bLtGQJGmTiuO+Rrm3wlpX2wXUYEmD5iVFSU2xEJiIOOr3bzfM8avae9wEAhcTYnZGl1kWttlC2EPZVTw3ZvVSwU3wPf0qoJzyGH2+RJepy9wYulAC8bJAwQpHQZV4IQlx9mghAteUuXljoIZn8Rhbpx4mK9/jAwKdwkhjF209MoUZJHyktWSK+qRkkQglqrWOlcC8edjXVndjJPq3MyrfPlo5DkklCL3DA9zqTDOXclAxEU5aAoSR2fvWiYcD50Y1idiYNqw8TmTI/yhcY2FTepgk9/eG7z+H0fb/WmDD9SxiV4SX2YFbjAFlJK5CRvr7apOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROJXPTWSiIFMiy0XwSEjXYpSu70jeFVcRyMN58r3aMo=;
 b=SZqKgHd0dS1lN9n8O9tr78q2dAv9UI51hJm2FtTYKOhw11irDdimruKGr2P8ppGNogwNtu5zOWfQfC4wwaYGb7ok4ymPJ7cjvq0gQd03+Lv7lrjYEjUtfms5glyGCELnazqptNMYPJYX5/QJgU5K6VcylqhpJGVgYbjQeqRv0K2p7U7qeDmmNWEA54REZL634dafPdjHXm1ewNIikPb1yZl8rFTIqty3ybJ3hqhzYkAT5WjBnh+xTn2eQAT2GIm5NP2ruDDkoa46ZYhuoPVGqpdDHBDWfPSU3W/h9uiMn3zdpibDoCdKm+S7qylpqTI/0Hbzf8goM/FLZJppos/B0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROJXPTWSiIFMiy0XwSEjXYpSu70jeFVcRyMN58r3aMo=;
 b=wAudpcPR/liQr4qf5S0DL/8vAlHtQyrj7tiiwtkmmutehAqpVfsn7vmhGw8+B6bWFw7N/jQCU1qV1KZrn7QPo5OWzS8kHDWf19nq6K4xiSSeCdKwbFPsoa1S3sp4dI6ED1hG6aF7NnJw2pfBfv1ubWJOIG4WWbTW1Fw1z/PqSH4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Tue, 19 Nov
 2024 17:59:59 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 17:59:58 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.12.y v2] mm/mmap: fix __mmap_region() error handling in rare merge failure case
Date: Tue, 19 Nov 2024 12:59:45 -0500
Message-ID: <20241119175945.2600945-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BLAPR10MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e66310-b3f0-4943-ec3b-08dd08c3fb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Glm31QuyWbC41Eiut/ZEu5lfJ+QnGuTvmuAKYXbKSPsDfnzgfcNH5aZ0hVPB?=
 =?us-ascii?Q?KGv9rfzUKD9Mrr0S79oXP/6evhnE/Zga3enJgOi6onz0XN+LLgtgHKtDn/4D?=
 =?us-ascii?Q?ceU17o8NvQBtz6zd2m7EVnk0RVmzmoOMi7O/4L7wt2pegUSpj3LpSpbxfjkn?=
 =?us-ascii?Q?28wKmAl55lQd8nmHFcHGT0ysVkFzxQvIaASqWskzP+HDLod27ALE4oYRxFy9?=
 =?us-ascii?Q?l1JPJBLmrrY+W8yjFLpDqjj7uvflTKqaYJtL8oENQYtk7gPUXLEfmtmyw8Rb?=
 =?us-ascii?Q?ja8i2zUcuCNTQsNkEXp6DFwz3cdv+tRZIvlEgkdtO5YYnyi2xXWDnvaIGNP0?=
 =?us-ascii?Q?VjiF+/BeO8yZPdHlfwx2QntdZmFuNGCz2chxoKgep0nRs+0B/mg+Io8rw7Rc?=
 =?us-ascii?Q?abkKsJZYEr17YiM42B4HNuUHDlUZXFQqtQOg+6PyaQzb9iBNsmfZxoiBZ6QP?=
 =?us-ascii?Q?a2iT83harRryn8l391swt8Ll6Ym6tNkqywZJgvI39qhlVgx7nHM5ra1cJMGk?=
 =?us-ascii?Q?Zqm8RYjbFI1JY20OEUXA7l7aoxcHOGOEb3IRCW4kPtCEQy7VfhQPnMfjJPQp?=
 =?us-ascii?Q?EDkav4ii0zIPBywLJefEYpfoPr2xartvQcKDChL/HSi8WE0j8UxcQsZXNpe2?=
 =?us-ascii?Q?EEXhMUMAE2nlUDwzkdt2NOXbl3juH4r1tVkyHTQJluqodOuLqhGwTMcZChYT?=
 =?us-ascii?Q?mpn7KE2pMfZQU49riiZhtIuGz/3n2PqMT/m/JUtKNkfLrL9sKIpyFs2ovzJA?=
 =?us-ascii?Q?4TDM6Wupk07PjgNRMcQYW22Cixr3nWHoVelS6b/oSacsWJ7yA5wvXwh1YAjx?=
 =?us-ascii?Q?bIKt7nIuxjgMBtKwppG557/9DcJSL/JK6i1De+UvwCmkpqvMWH5mOTYRdz5f?=
 =?us-ascii?Q?ePQ9DECACJXwqwX4al7VhWOd4V20Lu6UircJ9em4VSWNdIRtr41h1t4JyHMG?=
 =?us-ascii?Q?KDoLgCn21TE7t90W7Y3oW6IodgkjOAH8isH0K3UxJqz8rUiIQHJRjjtIKDmw?=
 =?us-ascii?Q?9kOzhg9LSh3qjuLCR8DIaV88pcxo8752TxdqziwBu6nFbUHRIz/Vg+QaaT8S?=
 =?us-ascii?Q?M6TVQI8yfqFa3y+Nz4AwoeluBVTkUzWPxN+QT29OcoIgnFHC6UNFHYziiV+c?=
 =?us-ascii?Q?SEkWCXpGrzb7ZW6y8QeIh6foIG9n0meqqFsJDGEZhudOkZnQNWso2/VlrGPX?=
 =?us-ascii?Q?1egt+A0lC7MKzhvnbXs3Lgcb5CuHPB6tbcIgn/QqaPiMD2Rw87Lsccz30esh?=
 =?us-ascii?Q?99PiGEdf5Mhx6mZhf2v8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXrI3EYniu1IrjvF47npxEF+hS1DPLoV4tTnOO2TsMF3xpRA2ipZKxxEsyBr?=
 =?us-ascii?Q?5mSQjmJICKdkZroVk9ocP12H2ms0WYIEUh+swb3yEJTtsuZk5mqylK1yhiuB?=
 =?us-ascii?Q?XcWQg5fiP8X29l5ZrKVzoFePk7goKV3GE1wqxNiH/cIcbeoG3qgEeYhb8mpo?=
 =?us-ascii?Q?1NUvG6kgndfeUa1C8BsPEC/ztxFfMeTPID1EUsXoJxVdBEQic24a1E3m42Mj?=
 =?us-ascii?Q?vLRtY8JarkCz3NuKNE4dB3AQOocjFBzzQW/mClYrAE1tScNoFDlKg3NStfsj?=
 =?us-ascii?Q?hXCwt8KO+eNOTfX3itz/kgI10IHkpfCmTMQzN5Ouz3a805/nakkG/UbnaBr1?=
 =?us-ascii?Q?LfCFtnYjFZStNJXRsQK7rcArsXxu6vEYh3JpplFktC6rNHtVksKz1P37Tz1D?=
 =?us-ascii?Q?YZT9Wit9MEBenj+fCS0r6pOmsMGh31Jt356a9D7ZA4kSMK8pPI5PQOvp8mYW?=
 =?us-ascii?Q?/eH9oLA/eKZ2m1UcZnBIv2B2l9XLNBQWPmXaqA0m60lEiZZ04jK9bkRFq7Cf?=
 =?us-ascii?Q?HPgl3zaloKFqwHQExIIypeLpuuFKnh0/O21SakF7sPiz6ox95ERUsI5w1/q5?=
 =?us-ascii?Q?iXCceIgUoXJBobAv1D5JD72qqAXMqM9LaaTfRLEKHn3aKlEYXPt+iErlpIn8?=
 =?us-ascii?Q?hlzKYbgndiUO9DwfjuHDoYmOHl+ZfyLvW483tNoadmhRSiP2atFV2W7kOts9?=
 =?us-ascii?Q?PHzOkf4MQdTno284/O6shrGPkyjmLx3ZMmjbzhV3/jxGfCmCqc9GN25W4/Ug?=
 =?us-ascii?Q?KwT+0lf+MJLPjMqhn8fcgZaYRTkKso8+hdFKOXIialBHMhOXy+2zaT1yN50W?=
 =?us-ascii?Q?/XxQJZaEd1Iv6UQxeJecx8Jrb4S41gWhTcU7rAJgCzmhkmgVmVZWrRams0HX?=
 =?us-ascii?Q?fH7A7cJpCBuTA9xkbhYuD5SfiOPjwBCfzm05Dres6G7lxW9QqKLhYHYkvMO4?=
 =?us-ascii?Q?tpAdMy4O37sn0yHoafaHVacmXFFvbGUcMwGuUHhUF6eTLyfUcUQSZsdv6dd8?=
 =?us-ascii?Q?/KrI9jmSrFJFIM5BhFwjjVo+63VdWEnLLtyJuCZLs4tWVnhe8wq7sEx3ijRx?=
 =?us-ascii?Q?yX7BIMBzM3vcfSgRuDn4khA7HK4COwUrR2Fkgle4MJ8cJRHYiwZd+TCskSey?=
 =?us-ascii?Q?XszP/P5ZeUFYycZwYCbb8n2cZi/+j1y6BDUuya43k77xTPXrglCEkWOeghfQ?=
 =?us-ascii?Q?UflmEDQ7FaaHNDh8YqQIbh+FYChbH2gYR/Qy7i3Gg03C0Wo+lhSsV0+Ts7FE?=
 =?us-ascii?Q?tk7ezaAf60FLdO+lwJ0fA++sR0z3fN/96GxJGxUNopFYK/5Hi8NeVrmY7kW6?=
 =?us-ascii?Q?mw2PdYQPmlzUIH4w7E4ihYneZfWa3QkQvkYtUvzMrvztb5hG/+wjcLDCCAAh?=
 =?us-ascii?Q?djnNVD7T7rzA3GMCcUh6Abp8hcA+nXiATCUPlTDqAgk9m4AOGBh5tKPFyui/?=
 =?us-ascii?Q?v4iuJHsaLxhl14Ch+9ObLBc6Lu7joPiginCqk2bM3VDLQwLG0G4sZRAeaOOh?=
 =?us-ascii?Q?Bb5f76eFe+gFyjaTLLx9fKIF1YE5M7q2aPDCJHT5EcuLK5nd2iZusgcvezZQ?=
 =?us-ascii?Q?9Tt9htNnFG2gTO3/ufOuhTrW41LZ/z6vspjByvHCEco9VdlmXw7+nLi3pt/+?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HVgT5DZ/wNvQe+OhUzkAWCq9v/dg2DcWZR8Y5Xm6l1mPpshX8MeLTXN2etcK/K2aznBxYwicjIXBdh+LpnZnmbatJqwCzaocOWxp1TlFhPQ5tFwI3zlty2U7n9ARGzMfw9bwfqPyS7YM88e/6Ngwz8qI9vw9B8GEBJs69MOIylr/3XCUg5pmGVBnSquogJkkHC6r+foUE4G0jWA7MkvPLWXNqKKd1E7LyBgj8tCDHK6QFKeKrX5JAUXWXv0IeLGDSNBS5Y/F3GuGWa0OEs8deLmju0cKutqqS2v8EcEjClc/GVKvYQDG+N7M/Es06s69apG2cGHJ6/rsVaetruFntCh9z2pdzP7Z9syPjbnCzo+fDrCB331Q3b5f8wkrcRaZ/HVm3xuS8AyYYZUpezcjkpM6OhsD+ehYEkAePQJVmiuZ6xG518VrCnpS9CXqc+FQyVudHCDtEIOUoIU9bQtVTkFsBRDURORCp1lIkPtolkg1yshnrS7tjyFdFrnj2gBcKPxWlZizjLivN/FBtKo1BF5lQL2U+VZsTTMLlyYrlX75hV3qcSjR9HaTIQD+K0eq9MPgXM5s/STXVY7g8OLN3Tox55buWABZTYaByNmouc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e66310-b3f0-4943-ec3b-08dd08c3fb3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:59:58.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1Z5l08Evt/wKljcpZBxIFD9n9wEaFe5bEB+AeRMYBElGOWV067n8/GOWPvXTSxy230I1CMJKvBgeBQXH9eR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_09,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190134
X-Proofpoint-ORIG-GUID: -roBxQ22CImUDGci4YRBptcdOrMokqjS
X-Proofpoint-GUID: -roBxQ22CImUDGci4YRBptcdOrMokqjS

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The mmap_region() function tries to install a new vma, which requires a
pre-allocation for the maple tree write due to the complex locking
scenarios involved.

Recent efforts to simplify the error recovery required the relocation of
the preallocation of the maple tree nodes (via vma_iter_prealloc()
calling mas_preallocate()) higher in the function.

The relocation of the preallocation meant that, if there was a file
associated with the vma and the driver call (mmap_file()) modified the
vma flags, then a new merge of the new vma with existing vmas is
attempted.

During the attempt to merge the existing vma with the new vma, the vma
iterator is used - the same iterator that would be used for the next
write attempt to the tree.  In the event of needing a further allocation
and if the new allocations fails, the vma iterator (and contained maple
state) will cleaned up, including freeing all previous allocations and
will be reset internally.

Upon returning to the __mmap_region() function, the error is available
in the vma_merge_struct and can be used to detect the -ENOMEM status.

Hitting an -ENOMEM scenario after the driver callback leaves the system
in a state that undoing the mapping is worse than continuing by dipping
into the reserve.

A preallocation should be performed in the case of an -ENOMEM and the
allocations were lost during the failure scenario.  The __GFP_NOFAIL
flag is used in the allocation to ensure the allocation succeeds after
implicitly telling the driver that the mapping was happening.

The range is already set in the vma_iter_store() call below, so it is
not necessary and is dropped.

Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
Fixes: 5de195060b2e2 ("mm: resolve faulty mmap_region() error path behaviour")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/mmap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Changes since v1:
 - Don't bail out and force the allocation when the merge failure is
   -ENOMEM - Thanks Lorenzo

diff --git a/mm/mmap.c b/mm/mmap.c
index 79d541f1502b2..4f6e566d52faa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1491,7 +1491,18 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 				vm_flags = vma->vm_flags;
 				goto file_expanded;
 			}
-			vma_iter_config(&vmi, addr, end);
+
+			/*
+			 * In the unlikely even that more memory was needed, but
+			 * not available for the vma merge, the vma iterator
+			 * will have no memory reserved for the write we told
+			 * the driver was happening.  To keep up the ruse,
+			 * ensure the allocation for the store succeeds.
+			 */
+			if (vmg_nomem(&vmg)) {
+				mas_preallocate(&vmi.mas, vma,
+						GFP_KERNEL|__GFP_NOFAIL);
+			}
 		}
 
 		vm_flags = vma->vm_flags;
-- 
2.43.0


