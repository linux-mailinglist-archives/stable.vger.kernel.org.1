Return-Path: <stable+bounces-124568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85256A63B70
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 03:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765BA188E302
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4853E23;
	Mon, 17 Mar 2025 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JqETgbTi";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="v9rVccna"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5C28E8;
	Mon, 17 Mar 2025 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742178244; cv=fail; b=QPAOY2OYzCBhHM95KdO5y4lQTsbg4tXYIeW+5imdTFAb05MLifd3n8n+RX14mUSyyDZmzKsjQfcg6lJMMHV9RFcgUifchDNpPZXF6OoI4Yl5c10BJOD/bSa70x2UA2HNNqrkPDtAWc7I6bzvIv36nPDQAgL92ckKfdEHm5RPrLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742178244; c=relaxed/simple;
	bh=AeVE8B+sHamK+yWM+DJnX3qUuvM4bWQmh5ujlNwnpvw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uq/zkXuFIV2Pe6VjDo16+JhZjVc/XF18RhK0CXLn+ZOqYC62jidNF/1QcC7qi1QPVZeNBtcuYJ/2rVm9ClWpweaFS0MSf/JKCt+WvnmfqHvAkQAzDDITRFrX3pT9hxzb6viS/J3NXjLPEbGY1kglPHWSdgmU3Z19HgB7gbZ2CZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JqETgbTi; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=v9rVccna; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GI02rt015726;
	Sun, 16 Mar 2025 19:23:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=RMJJarPc7YK9h
	YivhyHrm/lGAr6vqfMZSXNzubzA1qU=; b=JqETgbTicZd6ChmCYJ8oh+vjSQLUk
	nqQJuMzSqCiRdzi2zhbRCp7o7Eut1AwRBlbkpRLuQO/MbR9RLNLK7aVGCUaK7mis
	NxY7ur+nqbUXAbil6uvUjptpjSdMpAmOdVKedtCtkoAFDOTRlgDpqTZmOMGKoDkh
	QF8VqXdGg40WcFdx2xM4Vca5vZaQegwtBzw9q98+Gq9w1qzxWsRlgiwFcVDrMbSI
	hExmCmJ9SNFOvglh7Bt821EBoQBDWmdv1+D9faKY9x0SKCcoWIurvHsOzCkMbypH
	LrLmYWk7N9i80eDqMXC3WWFI9g10Rlz1O/ia1DDe50geBmJSX9pIAOz8Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45d8vat04f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Mar 2025 19:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOGgtGn9Y5Ei1pBAPma+JANCCb3UO5ry49YzKqhzvMBidr9/1Xq8aJYPH789XAr4r+bvlHuO62nqjO7hySa1Pdkc+XVFIQfOooIpkK84HTZGBBQQnqNH/yfGaWGso5TgERDnw9urqOYB4aJJ/4gb3bIGV4XhRn5XOReji2Ka94zxGJn6tRR5AskWRrExUKN53DNkuGotypfm+DEiC0CmLqhtKGeOL4tC4RIE+UPHwonwsoEJ9iYpfHZGWYHWEXWKT2u+VoR5+5x+HxUHYcVqBVVoqtBvrEto39TJVOPlP0mczDJnjA6KbRDh/fVveXnd17EWFZITz5yTUtU5AdTvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMJJarPc7YK9hYivhyHrm/lGAr6vqfMZSXNzubzA1qU=;
 b=T88G+K74OTpQtj7f248oey/fikghKZQEjyIUXDNYBhg70qUCY5fGeG/lBL1xhD3WoK5Kw30D7vNGQUep/mbWFcDf1lZdHyzY9dMncMJciFJGyID4ngWq+3TqtHSX41Elt2e0iuyyAzLyIy5Qouh+sNeE+MOkpWQcuk7gFAHAuJMFreybFcthMfwjjx9QWWLtHEYIJryH9c+3fMpFG/vA+lstDJG6g9ETvOl28hzkHGfOl+qg3FXmJivF/8owMrAAilbGUmFeoZhvY4u1/6F4fNpGsUENOL4sZbLzXXuv0+xT4+/LkcaJUh6IHyX+AwIXQlryGEXNxSYXo62gyROecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMJJarPc7YK9hYivhyHrm/lGAr6vqfMZSXNzubzA1qU=;
 b=v9rVccnamwC/pPpGLYGvUF4eGAyvcE4XypFtmigg/mUFLihY+4P+C+0cs3ASWK/gKrWXd6KNUtc/FSQNmXH/5cLIIrGEWT8a8oDWKkSdpA/pH2M/axGBHES3DroLiGgoBbaqIzaJZvj9CAu2l9CrKFZDPwzT5kDBq/vuPuf/exj1H4fsZA72gYTd/IQ4DXsh3lVgRPI1nEc3Ks4oqt9AN3GF5b29Q9wcRquGKMCWpXBJnHkqUTL9qabXBrcwWQYlq+XUbElLksU9rO72koKkxuA+P8rjTo6Fl99Fi7mXAmPnlRKj8rao+AuG8joEad2acrP2+AEeXyKAI9XeKoFVaQ==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SJ0PR02MB8466.namprd02.prod.outlook.com (2603:10b6:a03:3f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 02:23:37 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:23:37 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Harshit Agarwal <harshit@nutanix.com>, stable@vger.kernel.org
Subject: [PATCH v2] sched/deadline: Fix race in push_dl_task
Date: Mon, 17 Mar 2025 02:23:24 +0000
Message-Id: <20250317022325.52791-1-harshit@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::15) To SJ0PR02MB8861.namprd02.prod.outlook.com
 (2603:10b6:a03:3f4::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8861:EE_|SJ0PR02MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f16201d-e869-4c02-806c-08dd64fab94b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOr/x5dwiojExFBe+uoYE+j4GzCCCO6yCzvhNTHLGhJFjxJxSML5oDi6UdRJ?=
 =?us-ascii?Q?nh2r0vIDTY/FoQZktBwIhZF16oFFPfnEbDhDA+YnOUiR7kto6q3xcxiBjGNX?=
 =?us-ascii?Q?Xm4KkWZK4reVuu3XWXeJzHAeSU/lI4Wn76jGIe9ZdDC0EO/9Tu8EosarJqbm?=
 =?us-ascii?Q?ilO3kd8AoYl9NJAHlYH55Kyb2gg40uzpIF7hU/GbZvBJHGtaCrI8TQZLaiom?=
 =?us-ascii?Q?NKDhHbLwWOpl0FrhMSSAR34LO/Plc8v+OYXt0b9DS/QPKNQfGuH42aIGnxPP?=
 =?us-ascii?Q?SH/6Oo57ZZBLhSsD3F3Kqu5+r2rd+iR3demjSVs8gd4xHIpKJ9LXWpKCY8rd?=
 =?us-ascii?Q?9IOxcOdnZ3KaEqDi/t8xPnejDfP1ZCOoO0pan6RqGrJq9ompjEfOBhoQzTlO?=
 =?us-ascii?Q?yCqEj5tU3MsOzW6RXM5SedsXQHOcN4mqbWwEJPmkzX6IsFyEPO7JXp3lYguG?=
 =?us-ascii?Q?OeSTz8qvMEQ8NC2IwTqLM1/kBlsQIWeZ4Yzh+N6/RSy02TIZAoxpB/emsdl4?=
 =?us-ascii?Q?46cUoifALov9H686n4G/zQkvCo/QuRT1q3fktEY1iLcMpd+G28ZdwLmiFQ2X?=
 =?us-ascii?Q?3fa6DTarXOn7lu22/to1korSmptbVBDrcU+fxROhNAmnJIjnFi6ioKHnW+lI?=
 =?us-ascii?Q?vCLE2T7AOuQ5Nfli6BvQiBqs7p0uRltbkNH+ZNDl94N9umq54nhQ71Csw122?=
 =?us-ascii?Q?LihtOmOjUXusj1IGpol4eLthRqN7Jl1OPkvSLNY+WTY75iigQBSlmLbXS+iC?=
 =?us-ascii?Q?NS+GYdZtCMCD/2dSpqHjuVLOHbev9DkhgA7C3cNZ/+dbM/lqqCKO/UejseqA?=
 =?us-ascii?Q?gStSTI73jSu9FsrLJupLySKoxHEykZmuKxTmHR45xV3buIeyXxkvTElqqg1L?=
 =?us-ascii?Q?oVNAesty26ZilW2KFwff+W/QEEppfhHwUSw7t9pR4D26iMH1duVz5J1MluM7?=
 =?us-ascii?Q?RIZFaKzGms/GjnycbfJnF2qu0ih/XSlHxmHP08ED2bprJYjevVcY/fv38sWd?=
 =?us-ascii?Q?QdkLQ5jiCI4si1mGvASHuxAgd4MULVWT/FCo5vCmzAAmTNb9umyrQjNojSfk?=
 =?us-ascii?Q?pMKJorHgc+fAbwZIJTUWIOCtOZKU6I++j2IWyK5it5HKdTZVOrXVC93OxgW0?=
 =?us-ascii?Q?vo8HWbPWBVnqoaSDP2njcLeeRSu3BbFe8Wmz+AG7d403mf/ZbTnF5zXXQG7e?=
 =?us-ascii?Q?TXLyqKkRfBcl7rJxrJlBYug2G1NZTMuXK7wldEZMxtnFusi6BdyYGpOCducy?=
 =?us-ascii?Q?ufVwxmUpWeRLyUnKxXqPj+8oJ3i1AlCjPwb+6r1ORXfperXCsHyTeQQTg8vd?=
 =?us-ascii?Q?SAGbG8oA7L+PXBX6tRl+aHb265FTR9A9pS6CZ0zEE6vCRFIU6nwuoLJkO4t3?=
 =?us-ascii?Q?b4f9aeYaufENbHyfTMivfBYU4gP1HtqoYEnn0SxkUu0ngQgpceGYNLT2wniI?=
 =?us-ascii?Q?iKFH6GmEAavXmvNXwzexu6ZLkbkeZ5jsWhbtEbfAP+jeZjz5QQwu3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4UMDxceE9XcOP45Ke4YeZ+a8OyK1WpKH8b8rxPJpcXbAfaKZcq0AY/Cm19r?=
 =?us-ascii?Q?uqDKia8KI/FEtQoUaa0epfvFlpnoyYkxN0nFPIHHAQSfVpwJCMNL/xYKgkuS?=
 =?us-ascii?Q?sGZRZWuiJvTpjWgPN0KEIyzvMFVN+ROTR7ZnK2Biud/JN/tAiCfapWpBqGlQ?=
 =?us-ascii?Q?aaspIfoCCkjDDnbDdUwdWusXr4uUJwyLejRKcJ88VNVo3ulvAE8n8mklKI1a?=
 =?us-ascii?Q?DLc/1eJ9WCQapPb96pmK/50Ms3BpasA5Ccgczvr9lJQZ7p9MlZqQ+VS7OVy/?=
 =?us-ascii?Q?49KYIbPcEVBHhfC/juJZAGqZEn3QxVcDImcp466E/1qMBH/iN1f6BnAE1KlH?=
 =?us-ascii?Q?qpEe4fU669MBXb5/VhsISPGqfQslDwsTzsk1jNXxTGaQhf1/JFBopVa1cGDC?=
 =?us-ascii?Q?3OLVjMrq/D1Y96L9cn/y9mGBo7wrFS88GJJUwlm412o4A042gOWgpo1rhzU4?=
 =?us-ascii?Q?ELmshgpAI3/rEC2T53GTiFnNEieTCmfGuEXIe+FFp3GfZZ6t0/jQKUcKufHz?=
 =?us-ascii?Q?xwYczVivvfJFdoe1LqykG4A+7DpeBmdBcIC/mBawmB1csFYo7MZNpDtWTBL+?=
 =?us-ascii?Q?lNoe30PppbvmISpAx9+Ar39dGl/xJRzXzYeTXRnGm5VtWbmPndTdV4ARqmFH?=
 =?us-ascii?Q?9fTfqsnVl7Hqgtgjgt5PpRnvhWqiKK4oflQnlqKw/S7FB3AZw9/q3TnFE1Gd?=
 =?us-ascii?Q?YWBU/NDRBeR6UmmRAsWIy6/PD2gTaPbo+HEVdQg3IX4B5xh5RqZ0ZGq9kh5k?=
 =?us-ascii?Q?E+X2SoQStGohRBtW3M8vfIcooo7KzmYJR+TMsSYeg94XxQePr18FEmyUiqba?=
 =?us-ascii?Q?jnT38D+qy0XBjblyawCy0rHF1XK2r/AN8fMKiXLeAQsTE0Gmm1R8OQ5Nox4c?=
 =?us-ascii?Q?Z/m51Vr9rkypjdrI5nkcROOe0Xmx+HrDQXngFv/nzBGEJM8UrLXziS/hkA1X?=
 =?us-ascii?Q?LGeoZmZdvxPjBi5H6khWDuYwaWj4+n2k7tBgopPdTgEsj1Mge1GA4fobBeFU?=
 =?us-ascii?Q?9uFdN0TQNdBm3iiD1AVRq2/rOGL4+Ioe4NiHqG+kdZcPv4FmIZgziDPwRdIM?=
 =?us-ascii?Q?ir/E20KobTy/vtiioBnzwX24dg8PANt3bz5V1Ayend3D03lOifvC2rOG61n2?=
 =?us-ascii?Q?cAPsxXDTgnz0vjdKbeZbk91nOkm/U8deaFrJwmGTBSzjzBooUeWMYI9FIBpf?=
 =?us-ascii?Q?4QuyABMgetMJd2YGOef9wm/oB8cuJEh/xhYpy0UJcwWOT/00bWVOJxw5R4aB?=
 =?us-ascii?Q?w88EHi2CNZ6LC6MoITQA723OaEVZKVcdRvcIlk2pgqY6Q/bj3bjRSfdqZ0gW?=
 =?us-ascii?Q?LJTXmxI4WEt0lmDzbdytD4wnNDAGhfuB3sCDOmjhahQWk1RFDkYbhybOgDNH?=
 =?us-ascii?Q?3jrhC2nGjMI+KZhxPBO3h75dbk57m/8FPWl4Z9zNLA7KUKr0D/rVdcYnf1H/?=
 =?us-ascii?Q?ZgpUHmvxeeCjcTWdbfbA2GVGg3GFJ30s6HyjHrWRKVuIfFQL312E7eEX/NcF?=
 =?us-ascii?Q?f6TuE8EK9PdQ6N0K4mWK+3UJISBFPWlXcRENt1I9ejdr5pe+XemLtTYEkn3T?=
 =?us-ascii?Q?PI32Caia7phrLg7CziDS8YVimG75XEK5YTXT4SJh6UIAOtWsyn0S69SuwU1Z?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f16201d-e869-4c02-806c-08dd64fab94b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 02:23:37.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DBYYxVgbVvu/ARHCvyniNgNA+Qz+C4V9e4B5JrLhqntQoP/XTHoB8Zin3+efxLa6csuKJ23shcaq9WtjmYPvJOpKAEXcw7d4b1f5S9CgeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8466
X-Authority-Analysis: v=2.4 cv=GNEIEvNK c=1 sm=1 tr=0 ts=67d787ad cx=c_pps a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=Yaxl--OJOmRtuZ9H6O0A:9
X-Proofpoint-GUID: jBYoB6a9OWsbrHpPQt0YgOxCbdL7PECC
X-Proofpoint-ORIG-GUID: jBYoB6a9OWsbrHpPQt0YgOxCbdL7PECC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

This fix is the deadline version of the change made to the rt scheduler
titled: "sched/rt: Fix race in push_rt_task".
Here is the summary of the issue:
When a CPU chooses to call push_dl_task and picks a task to push to
another CPU's runqueue then it will call find_lock_later_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.
Please go through the original change for more details on the issue.

In this fix, after the lock is obtained inside the find_lock_later_rq we
ensure that the task is still at the head of pushable tasks list. Also
removed some checks that are no longer needed with the addition this new
check.
However, the check of pushable tasks list only applies when
find_lock_later_rq is called by push_dl_task. For the other caller i.e.
dl_task_offline_migration, we use the existing checks.

Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- As per Juri's suggestion, moved the check inside find_lock_later_rq
  similar to rt change. Here we distinguish among the push_dl_task
  caller vs dl_task_offline_migration by checking if the task is
  throttled or not.
- Fixed the commit message to refer to the rt change by title.
- Link to v1:
  https://lore.kernel.org/lkml/20250307204255.60640-1-harshit@nutanix.com/
---
 kernel/sched/deadline.c | 66 ++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..2366801b4557 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2621,6 +2621,25 @@ static int find_later_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+	WARN_ON_ONCE(!dl_task(p));
+
+	return p;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
@@ -2648,12 +2667,30 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
+			/*
+			 * We had to unlock the run queue. In the meantime,
+			 * task could have migrated already or had its affinity
+			 * changed.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, so we must
+			 * check the task migration disable flag here too.
+			 * For throttled task (dl_task_offline_migration), we
+			 * check if the task is migrated to a different rq or
+			 * is not a dl task anymore.
+			 * For the non-throttled task (push_dl_task), the check
+			 * to ensure that this task is still at the head of the
+			 * pushable tasks list is enough.
+			 */
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     (task->dl.dl_throttled &&
+				      (task_rq(task) != rq ||
+				       task_on_cpu(rq, task) ||
+				       !dl_task(task) ||
+				       !task_on_rq_queued(task))) ||
+				     (!task->dl.dl_throttled &&
+				      task != pick_next_pushable_dl_task(rq)))) {
+
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
@@ -2676,25 +2713,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 	return later_rq;
 }
 
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-	WARN_ON_ONCE(rq->cpu != task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
-
-	WARN_ON_ONCE(!task_on_rq_queued(p));
-	WARN_ON_ONCE(!dl_task(p));
-
-	return p;
-}
-
 /*
  * See if the non running -deadline tasks on this rq
  * can be sent to some other CPU where they can preempt
-- 
2.39.3


