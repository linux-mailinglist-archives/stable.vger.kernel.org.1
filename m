Return-Path: <stable+bounces-214881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TaG2A1x+iWlO+AQAu9opvQ
	(envelope-from <stable+bounces-214881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 07:27:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334110C061
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 07:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F20E330075E4
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 06:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF4F2EBBB3;
	Mon,  9 Feb 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KeGUzd/C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FfIAKz+u"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F452EB5AF
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618454; cv=fail; b=LaB9onFaVpKXH+EY1KAE7VC75FA9mberLWdzUjnyDJUehgjM9btYCZUGsRtb1vWUD2Td6oEHMlQYH6VF9Q54/EDG5K3pi9QX5Jkf4nC52/X9v+s+voY9ZJ6QTPtNZ4YrXWx/NcpJgkZH6B19qE9NC9Hd+fXB5kbq+FKMqmZ4TpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618454; c=relaxed/simple;
	bh=ALrPBausSWdZOyethqCmKF+DJLKyMPKROq0cvHuRn0I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B3OJrVfTscWeJarQeY4elsZX22Bxw1MsfZt2004MqA2ar+f/dqFqmaUDsyPFsVO2EKdqCdB12/SToz+7TCp3ia5eW9xqTnfAr4xkCAj62dqAzvGYcBHFoKIxdrG3VMDeIDHmkM6KYyLd8d8AeTdkp7Jt/eXkTvTCyBWVdaakAi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KeGUzd/C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FfIAKz+u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6192wl3g522866;
	Mon, 9 Feb 2026 06:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ex2eXsuuNuwBaEaC
	2QcfP6nEqkEHuYfl54uh7pNHKNo=; b=KeGUzd/C4+0NVXyCAGwEzKC4ai43Nl4r
	SOz3UxivKDO+6gtfg0zFLHKqKHOJ/ypRrpmTOHiQjqAzHOewDzM/JZp5AWoWl9qk
	QxkrhMvy6pkA6lDA0m7wdEQTMXePde5kL4PRyMBil0qJy7anPNPUZo/awl41TPly
	WbB3VILXcVY2vhYwLH2yTxBGBAB2WexbM3tQQs9HSiwOXCKBIhmKkXy6fndIonPd
	FxlxrP1SuwUpGMPKCzwRRLgWWT37zx69vEdW7wEqYxrT68eO3Wf/sADrDi9tWG+D
	IlbK9WR69sKsny8hXa5pnn4VFZBgmnL0DSRXmNwFqBe7iYsPeM8Cjw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8sesc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 06:26:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6196LpHJ014996;
	Mon, 9 Feb 2026 06:26:49 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uuk4tq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 06:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euKyXiQ3lyvdWxfNpDhzD1zOf0FdcbYNu9QUegogEBIEcPAdDga6izYKtQvpzPxZgT4WYYbjFUhStrZCdMZCm9ZdePjxZDev0dSrSgYZERkx0LANHeXJ6J565b6vxD1NUhDdA/eIYorREp5isFkKMueusYexIFyUaxpRK64yMivmHweovBJxbbKSmhYzD7ezCnUEemF9ti37LDgOc4fO33x+FJWX3C+3mAAFpc29ZJrAXqCWes4HbyimSw1Sj2OenZWMsovJURXGHU5Y2r/Z8jWVegs5WWgppHBJPAkRtm98C8bkY3KAFS0ylTd3Twrbgho+LTVl0QH+HI1K9IGgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex2eXsuuNuwBaEaC2QcfP6nEqkEHuYfl54uh7pNHKNo=;
 b=cJmlDZR6GApkZfyYR+yun9a3rRkiVHhnsOQGt605TEILs6Orh3SbsFOdWEkhqepGZVbsgPqlTAuhlVZtxSyJ4/vOpLCYdRyzIjpI6F1xBJ70/EB+fqWBZaEjegGBRHbcJrJAqfJmuVHqwc5EnrL/sNNDc1OVaPuxpCVpHvIgz+GLDYbL2izxA8p1LtbA85FH2cBK+HVK/qOkIt7yXd/yg931hTs+WQF/U72/KpUYKKuJcX/iSB7TN8ohNfyUl2yblHWpQpcdLu5tH0Rqufc0KsIqm4vjid/h+LR4+vDPCssoId9pnTQO5yYveZu/E3S6LFZLpUE9hTt5NCPQMKvDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex2eXsuuNuwBaEaC2QcfP6nEqkEHuYfl54uh7pNHKNo=;
 b=FfIAKz+ugsoOIa51t9BDZrTwSXiAYgj4YDFGe4doiQxyXLBrG8c2xmCtu0AbIbalLhmPaBeodw9Hp1fep2LrBdRPVgDV4fXpf55eKnxa/ctojQX7sC8FuDzm9Jcb/7XHn7RwDEdVvSMdBodPjyB/WVKM2DZ77PsLUITfyHE72iM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ1PR10MB6003.namprd10.prod.outlook.com (2603:10b6:a03:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 06:26:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:26:46 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        Harry Yoo <harry.yoo@oracle.com>, stable@vger.kernel.org
Subject: [PATCH V2] mm/page_alloc: skip debug_check_no_{obj,locks}_freed with FPI_TRYLOCK
Date: Mon,  9 Feb 2026 15:26:39 +0900
Message-ID: <20260209062639.16577-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0085.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ1PR10MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0559e2-45dd-4c9d-8c0e-08de67a432da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WaAlL2LRDqGmRUNOTDlmZVA3mGN+d5OoA9ou5i+5pycFZCEx4tb6g73ft0/n?=
 =?us-ascii?Q?+QWNINu9oOCwDvCrUQv2GDl3ETehmA4FYz+J2AOhPLuBsIZ2EC5aXl/O222I?=
 =?us-ascii?Q?NRPDvmqj/pO5+y51deHNVWlnu789AYVss3lGxX+d5yVj2dJIcHkIClJLo8A3?=
 =?us-ascii?Q?jx38Un5XskduYQdYr1SVL8VeQgFKqcXks+7sTpR1K9FzZksm9ATcXgahUqs1?=
 =?us-ascii?Q?4jT32/U2wUFtHkV0IxEY5H/rLnnNd6yUz/wBdSkiHcPQVmEDDV33IRBPzACe?=
 =?us-ascii?Q?p9gWKeo4ouSO+N7IIdXCMZ+f6IohCXRWeDtkC7ZhHDszmmlF195EvU8QsPRh?=
 =?us-ascii?Q?npPXLsO66THGMSAlmZw3QiJodw7RS+6+sL2IaS+HSIsZJTx8xvWh/5Z15tl7?=
 =?us-ascii?Q?hTHvY0JudT2PPoL95KqsboegURXSAfLP8sCppoOka6lwOz84dCMHNUrVzmkR?=
 =?us-ascii?Q?ykTP1Lx9c1CeMeyenq154zP64vCG3mIou9xd7MiwPkbBZfg0bq7MHfRaxdU4?=
 =?us-ascii?Q?VBd9gn/v+ENxxTp4kGnCpGEuo+CYN9cP16RCHdCbBn+3a6U9TEbana7N49/O?=
 =?us-ascii?Q?6zWYr2lW9A8lrZWzkLghc1zE9RyFysNq5cgJF1K1RLzNAQHOAi4PdWM/nZYa?=
 =?us-ascii?Q?1lnG4ab8L/Gr2Q9CCAbuXtm+ArxehgCMIs12bg1MDUAPQ/m2oaqP1f7FLgke?=
 =?us-ascii?Q?WptzBJeFM2tW3cJwMRRQztd7iUR8scDbvcP2CmleXSt6Z3ELgdH0lvNAc3Rd?=
 =?us-ascii?Q?IwcSG4CrYcpJ+XZwErVM6p1sOMWYLsojq/QQpN1xN3z5WYC2AKencPRRiKIg?=
 =?us-ascii?Q?zAByAYE5qXA5RaKYs1dMvZKR6jWsP1FN8IssAwwbDc+WQrBq8cmoAPoVPODV?=
 =?us-ascii?Q?f9p33pyyC0zV/mcoiopSEZX4Y9i+bAU9Ej8jLJablvGixlCl1/2yn0WOMWPG?=
 =?us-ascii?Q?BMruWUjbnq850Vha7aA41BJStG5V0tRgZZ0628Ns9d8t19r0HOj9hQOXxOpS?=
 =?us-ascii?Q?WWGtET2RP72N67+fie07GVPvXuD/+wqc00Yes306IRjDV/0MHFWbt2wj9sQg?=
 =?us-ascii?Q?lNmSEBDrIq3wkr1pwFQDk5mWrfAaCG1zoP/pTKxmK/zxa0TxwqTcpxUDFL1f?=
 =?us-ascii?Q?JyO6JHDHS0C4BM5V3OxuHA3Uh5rO778yUyJZ4ueihNv3edi+EVNhW3BM0Pob?=
 =?us-ascii?Q?21a0vIoI+KnzQ06Q1467+O7SmMMIk7IkOqhpvZqPCAnRmQaBkdgtM5cVmaFG?=
 =?us-ascii?Q?amgWtilials51hqprZZ+S4rAlA4K6NN7WBAYYFGKuMX6VRtntLrbNslmcMBd?=
 =?us-ascii?Q?MdCzkBrzwcGmbVHn3hjujda//lw4L3VsijUHg/JG8Fu4R3do/KLF2ZqazeEH?=
 =?us-ascii?Q?I/T9ATr8WV9XUvIReIC8TQT++y7ojVF31aFNdKjdX+aGR7iMdRyKgzU7bgn/?=
 =?us-ascii?Q?GdP4s8J+9t19I3Tn96ApNBibofYm0Fav1XenY+UCPZEBMx1D/S/HD1/1S1XY?=
 =?us-ascii?Q?Bd5CC00ZYgAC1SKt6YwGyuswiDmkJXWyaOxg1cfoX3Z9ils61VpYJRHKw7t4?=
 =?us-ascii?Q?1zThySecPjubyHdOzf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYlgViJ6b9i2jZMNwFuDq5qlVrw+Qz+9rTon2B4mJtRIQy11a8dEmCtEGDIz?=
 =?us-ascii?Q?zve8XyEuwkcdR3fY09BRJPB2EVTXscAHyllVAXV/y2kyamdrzYU0q5+r/Yl2?=
 =?us-ascii?Q?akMk7pmNPy4kEGcKBVVlsgdxKZV22CUigixzSWzFoxKggPKKfue9jJ87+W0V?=
 =?us-ascii?Q?B0jWo+6jOCSxyAbIoEt0kkSLDH3QqbgxqAnqUNjuN2ozeYqrhO2gowUDbZZo?=
 =?us-ascii?Q?vM1ijnb80TFjBwWBS9XI9qXYGz38kUovhGJ76JVKmNn5iRKZnJmt31aoGN/2?=
 =?us-ascii?Q?dg3r+2IKVK4FVcueYDbaRzr8UnoTnMoLSfan1N9RIgAJRJES7riXdNj3evUh?=
 =?us-ascii?Q?rNYgBpSpIZ2rIOikYFWN8LbTPh4lo8nUny8pFTqcNkx12MjdbBSES3P6WOvr?=
 =?us-ascii?Q?36vz8CI3a17MCYwtBMdSlt3ABV2FK/oT4DNUQK5vFD65kCQCIGph2xx9Rdjm?=
 =?us-ascii?Q?jUh2bUcSiLRE/pfg2Tz3YnQH4pJUjf+clbcB/QajAl0Yez19uMoKxCfyTcmt?=
 =?us-ascii?Q?+WuN9HrDoxxXJMhjeRIGaiYyYEI1l+kdBugUT6a91/m3bDnnRHLWDqcHuRXd?=
 =?us-ascii?Q?fpKORipPPNuOtAIM2DwOj7bdjQUonXNHVq5uhjv4ZdA6+EQojiN0ij9ZgnNY?=
 =?us-ascii?Q?TMu5zywmjxzIu2U8mds7LOkR8qkTQEpbMLDc0TWyR4pi2tR0nd09PgHnjsWh?=
 =?us-ascii?Q?ZB/gpXOyCodHH6XOV3J5N3du85E2U7w9rMzyUYdKCErWJX1ALFx8l0Ctthyl?=
 =?us-ascii?Q?GVCdl8nQGnmQO6NlsFoiqWnSAXIfO0euN5dcxSHLet5iK1x9oz80Pt3efvsb?=
 =?us-ascii?Q?dp+1NfzZRFeZ1AGIIFKB57ssCag20/NUfGJ37imRF7bF7/WSZJ8wyDIqZVDA?=
 =?us-ascii?Q?+a/anybyNylim2c6JH49txuvUVeuJitEPFxlUqm6uDebtjpBbSFjTR2Gs491?=
 =?us-ascii?Q?a7NGghAhkicFKgJrVUBqlzPU0+N3HDkl+9rPmACucT0LUjNvYydkeVpktsMC?=
 =?us-ascii?Q?aAZyN5bgr37szOKHAIJ8Fd7vXKVxHDXwFZ9rBVpS8FbuDqN/PwfEPgk5tbA+?=
 =?us-ascii?Q?b5kTCNPnI9nTKX9dhCZIJ33j6Ieu6CcCFNUzFgTqIsY1rxubcbMGLf/4iY4b?=
 =?us-ascii?Q?A9rRMA6dwaVFmUhrfSUld1jZXlexO5uwtmeSltkX4MEAzLrw96jukrWqxmSH?=
 =?us-ascii?Q?4Qoar/dpVVYpD2mZBSjehWvZhs5auypStkn86J/8SNtAE3BFC5qt/xhi0g2u?=
 =?us-ascii?Q?hC6H3SdG0q4oRll9Ymb6imf8PXIcYcwW2OgtCpXbHVdQ+jlQzY77+jrheSeH?=
 =?us-ascii?Q?tbNyHScyDdw7SShTjH3s1QGrzasAlwosfmzTo82j62/mu96iCyzMHMsnHAy7?=
 =?us-ascii?Q?+/WxGDCjUljsQIVyt9BalEgFVivG/THsDsl471Xw4pRjuyGhNR5793JGBiWm?=
 =?us-ascii?Q?X7f5r+He+wIsehpTjkBxH5WPsHtGm8+5EjK2f/2rg2TxkEOxz0i0/O8kIIV0?=
 =?us-ascii?Q?jSWs9o4NXLuW3evIukh8CXsCLcOToH0edhxa/s3IXQwzqAHRVLMaWWxldL0V?=
 =?us-ascii?Q?mQNJVMzSaI0XUttO0uVOjv5IONfizc27UDoOGnFiXbMtxB9erAgab4mnRL7Q?=
 =?us-ascii?Q?R/Eunf/+mGjbKmteLN11G2G4iMYDk2J4ABr0ukEhKIxYUFP5m7fJTxJqc9Lj?=
 =?us-ascii?Q?dJpLAq5xQK6SzzFcNChWMjs8uy97Cw1olXB/JOe26irPVmOMQIg/5XKGpPbM?=
 =?us-ascii?Q?Dv+NLhivKA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GB6uLmuZgJ6lOsF1iFbSNrwaOKPtul2IbGd5KjMnmPHCZ9iFyCZRn8ur6hOkeBSGFoLfOJ/dtk5MHyQ16QeASXGaQqYz3PyPEKbXY+eEPqZffa7G+NxKHIP41XIZsy42MMN+PMx7ImcctLbQQW+uIhcgUXvo2OeIP+k9IU442fHJLFEpKhiOaHTKlzXsnHiDIu7rHmFMR05CWxObXWGeCcA2IXPcAafBzg2Cvs5yco5Qnm+cgAZ+CblwBfTFLJA8dZY4t5/n/cVRWLtbZAkDYQ11dQJP6DXjTl47CDR0GXTCvGj+9ffZHbHkoOQvKtPwsz85WahrqCaoP8a0M5/SOhHFzkFk9SD/Y2mTUaFuRidMtDnRrwBli6XlMfsKPHVesssR3/pm2Lfgfk1MXhI7Kf1L8Tns/j/ECY1dStaRQQYF28IkzOVljIv1P9S3aSlTavuipIkNxvn2WctqE/FlhNI7uur8ufFXXhxvdp1e/xG7w8BnK6anSqSwSPVy59A26x/PT57GfpJlLOnaFkkGitCIyrKrcevwc1RTqrJxMOdfBqwt7Q9mXC32oJmBuUNRB+iRhn6yW9eD/ERhvTtD+D0IT3JsDQdGfBTj/jN56b0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0559e2-45dd-4c9d-8c0e-08de67a432da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:26:46.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiRJ8roFQxZka/0DoyTwAvjp88/XEQsJfO9DHo4hHCNRJi59wpVWCEM001YZJ3DS81V+Y0srNX7hYjTWwWULlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090051
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=69897e2b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ta1wO2ERTDbzfcfXRbEA:9 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: y-L__QqeCSoDzXv4OegvS6Hz-JV7vJF1
X-Proofpoint-GUID: y-L__QqeCSoDzXv4OegvS6Hz-JV7vJF1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA1MSBTYWx0ZWRfX2JTDPpQc+H17
 52iejG7YrkjmPTdRXnRwyaTM3YeHHi8D5EbN9b0GJX/RPBfMbhLs0nvSuwAN85D6REY3oQpicwh
 Fce1fVBULneCsAF19350r4OEtTt3+zIj/WpEPjhtqRaptOnmlqEfj3CYC44lK/nev7+8+7IAULq
 J4RgBtN6qnu0ei7kWB7sb4jnXDKk642mXNfjdsoCMYl6YPieQm460OWQM1EVxT7Sl/Jnk6qNjWU
 MsDfPn/C2qA9dcbX90Iapva6NAgIibNweZwMBo71Y6/+qYsVW5MeccoTdBoWC9nGmepmmZsesL+
 /lBQEdoZz7Hw+WTryP1GUwYgxEslfYrzE11aKq7SkEkBji7L7g4Noo6t8UvSQMRaEhSMShym1ET
 LOzFnhow0pzEjF9pZxa0IyNSfrW+5aO7kGiEP9l5Y/V5llQwkCu4PXJ2IBs3Dy/leEwAxHqSTc8
 kGnUmWGD0i0nZqGQDRC5opHV4BJNdhVFquSyUYG4=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214881-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2334110C061
X-Rspamd-Action: no action

When CONFIG_DEBUG_OBJECTS_FREE is enabled,
debug_check_no_{obj,locks}_freed() functions are called.

Since both of them spin on a lock, they are not safe to be called
if the FPI_TRYLOCK flag is specified. This leads to a lockdep splat:

  ================================
  WARNING: inconsistent lock state
  6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
  --------------------------------
  inconsistent {INITIAL USE} -> {IN-NMI} usage.
  kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
  ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed+0xe0/0x300
  {INITIAL USE} state was registered at:
    lock_acquire+0xd9/0x2f0
    _raw_spin_lock_irqsave+0x4c/0x80
    __debug_object_init+0x9d/0x1f0
    debug_object_init+0x34/0x50
    __init_work+0x28/0x40
    init_cgroup_housekeeping+0x151/0x210
    init_cgroup_root+0x3d/0x140
    cgroup_init_early+0x30/0x240
    start_kernel+0x3e/0xcd0
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0xf3/0x140
    common_startup_64+0x13e/0x148
  irq event stamp: 2998
  hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
  hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
  softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
  softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&obj_hash[i].lock);
    <Interrupt>
      lock(&obj_hash[i].lock);

   *** DEADLOCK ***

Rename free_pages_prepare() to __free_pages_prepare(), add an fpi_t
parameter, and skip those checks if FPI_TRYLOCK is set. To keep the
fpi_t definition in mm/page_alloc.c, add a wrapper function
free_pages_prepare() that always passes FPI_NONE and use it in
mm/compaction.c.

Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

V1 -> v2:

  Per Vlastimil's suggestion, rename free_pages_prepare() to
  __free_pages_prepare() instead of moving the fpi_t definition to
  mm/internal.h. __free_pages_prepare() takes fpi_t as parameter,
  free_pages_prepare() always passes FPI_NONE to __free_pages_prepare().

 mm/page_alloc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..1513084d7507 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1340,8 +1340,8 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
-__always_inline bool free_pages_prepare(struct page *page,
-			unsigned int order)
+__always_inline bool __free_pages_prepare(struct page *page,
+					  unsigned int order, fpi_t fpi_flags)
 {
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
@@ -1434,7 +1434,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
 
-	if (!PageHighMem(page)) {
+	if (!PageHighMem(page) && !(fpi_flags & FPI_TRYLOCK)) {
 		debug_check_no_locks_freed(page_address(page),
 					   PAGE_SIZE << order);
 		debug_check_no_obj_freed(page_address(page),
@@ -1473,6 +1473,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 	return true;
 }
 
+bool free_pages_prepare(struct page *page, unsigned int order)
+{
+	return __free_pages_prepare(page, order, FPI_NONE);
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone.
@@ -1606,7 +1611,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (free_pages_prepare(page, order))
+	if (__free_pages_prepare(page, order, fpi_flags))
 		free_one_page(zone, page, pfn, order, fpi_flags);
 }
 
@@ -2970,7 +2975,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		return;
 	}
 
-	if (!free_pages_prepare(page, order))
+	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
 	/*
@@ -3027,7 +3032,7 @@ void free_unref_folios(struct folio_batch *folios)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
-		if (!free_pages_prepare(&folio->page, order))
+		if (!__free_pages_prepare(&folio->page, order, FPI_NONE))
 			continue;
 		/*
 		 * Free orders not handled on the PCP directly to the
-- 
2.43.0


