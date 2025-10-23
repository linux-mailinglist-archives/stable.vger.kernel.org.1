Return-Path: <stable+bounces-189074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A6BFFB73
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9DB189E832
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A52DC323;
	Thu, 23 Oct 2025 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="G6kg2VRn"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023124.outbound.protection.outlook.com [40.107.162.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3B2C0F76
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205908; cv=fail; b=NCDV+kl8TdqFWy/A51zRSbbXLT+r8o7xsfNnbbCJ/GTOFHEajqzLBZbxDCCV1rJV6n7UW1bzM404a+lG7wVFz5EKRBa2fXYyRv8IEy0Ettb4ihH+0aMDu41ufiFqbvC08vQTA0PsGA8mwtdcBG8VYWOVlrJV6dg6qGoNr8LcrB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205908; c=relaxed/simple;
	bh=BwfWAMK5zLPU3+yzZx0Vv1ybuQ6w+rhsqaH0OWtc6A0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u9gg5d5b3ynl1jwQARGdx4nCmV6z6VIs5hhSuFkN8tC6DTdzSswqeNdpO68g8cBS/NndVY53SG+KZvJLO52GtVrmm/Y68K5Tcz9F9XuyogN+FOS/GgEcf1QpniHrbjRWa9TRoh8cVNAZHMYK6r83ty9LLNZQ6SzCbfw99Hl1Jos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=G6kg2VRn; arc=fail smtp.client-ip=40.107.162.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3rX6WAQHaQzd00u12H709QYI1KudT2vXG/73DxyTr5PE2AEYmsqAIEIKzZZZR92gn1+CtVGIsI0Mq96+5RjwRJUkkfUHajRZw91+YTsrxft0blkC/oiKIKCbvUi3WAEnvIBLQMiof48hn3jSXDzA+aU7sJ0V/vYIGuCNnhkKi0bSMFS0GgfX1bki5Lk+qmKdD+KQ36Rfyolm1B1yyLcKU0E2wxPyh3UhdvHy0kS1qjVie/mmaR08FMra2/wypO5zEyTXhRg7wVSJJ0BfCDH7h9B3pZopDxPl1ndh5qOkij4HWFpN8yMNyoNx2NVJPoRmNwDXZgx3teS1RyAdU9lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aABT8n/bbjmqF0SehLb54IvMBnWPRLrt7OaVErR34dI=;
 b=jGwkfwGO5UuuukFxlVyHPsMrCPEbAt0tpltJNIx6b/LmaeHs2o6pi9U/UUQD4DntMS7gU8Rq1BUiQPjn8tvOTNkGJqo16Ez3xStVRFOgEe3DkgCgjIGo5T8gRNioVQudTCVP1ZoZodZ+UHgHJ4jFSCffK9IdCmCgmRB01xvygqnk7TfYrOFlBUwXxurlP8UYcO9poJXpXlGQeKWGrw3datd+HKhV1r2DQMUegA61TLLCShNVbbW0tHiRNL3VkafO2N1QBi2PMvUDTz9FpEM5PVQXkKXQtdf/YiZs5WPCIp1TlmiTfmgjK0zQT/2BY/Dl6DJ6LzJPJfuYQZtfxpXZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aABT8n/bbjmqF0SehLb54IvMBnWPRLrt7OaVErR34dI=;
 b=G6kg2VRnYet9osD+f8M1oKK/zNHqbGwVYCKN2z2VmCzTAovziy4gZrMOJ9k6abWDnQx0rkE4ubsHlA4/CI/QUw6UfdBBAHdC3SQkOvvwakyOrSIbM+dmPXCc50iLzn7B8kHmX13vkDQR023rkC5llehxHXQ4wz20FTf+Yx4dXT+byyLfSYyzvpVxUmKbYhjZHmBKeLiB4FfTNiia9S/h0rLCJOxG3ur5/RVRcg9jbIqkeZis40gCDlh/ira34Xtx4qfBAFVRFl/ZOsmlEEL74hXUH71KxBUEgXAfiCc3cZTIAYnXyyN0JHzAPbRR2V5x3noFzbuWBq3jO5MGjl3c9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by DB9PR06MB8255.eurprd06.prod.outlook.com (2603:10a6:10:2c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:51:37 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:51:36 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	sashal@kernel.org,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH 5.15.y] Revert "perf test: Don't leak workload gopipe in PERF_RECORD_*"
Date: Thu, 23 Oct 2025 10:51:01 +0300
Message-Id: <20251023075101.25106-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0043.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::10) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|DB9PR06MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f9c7c7-d612-437f-ca10-08de1208fe31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjpK/nLYbGP0NUFXKZ4ZFxGur+8bRJbb/49JK+OqeJTIaiY5M5XVAv+nqFMS?=
 =?us-ascii?Q?vGe8Om06NYLgytKbDQ2vz2zPgQ7KFCUHfO87RJ7ka9O8E5FWb0EqAgazuYFc?=
 =?us-ascii?Q?UrCPeUv4+ttqjn/2TarGEC4I1nXuEYygbAqeosgRKcUPe0H0zMTXvxhuowo3?=
 =?us-ascii?Q?xvuJXWm+tNOyqNBeWmBPNVY74Ks/9PGD+skt+d+QIIzugQ2FWgLRt/EI5RPq?=
 =?us-ascii?Q?tKdB14AgdgZs53wq0PDlsVaMiRivm2V0DlVLZKVgZq7uh2+wlQJR91x4Y7Ov?=
 =?us-ascii?Q?4vtM9wNYEmq7TQ5jFuuQMJwFrSYrg72464GbDSbxjnfHeteM+1Htoe1fH4Jt?=
 =?us-ascii?Q?+2Wldrv6qbrkORtcBcf93chg8gnSPjTVerF++EyZvTYnX5VSS/ZMz4YhiUiU?=
 =?us-ascii?Q?k76Od7HJGAHdq7XrPFqjb4NEwJD8udesTqrQP3il+2w71bTz6rpVuqET66UC?=
 =?us-ascii?Q?pD3kpTmJhdFnu4Sam0GE5ekqeOWKmOTIa0dFiyYzGMtU7Rshr55IlLIhhLah?=
 =?us-ascii?Q?wFuximCXGHvcJ8QKsYbSs8phE/zI0KIdX8nzKUStQTVjXywpKDY0LQHohNUW?=
 =?us-ascii?Q?WNlxDbeWRPrczRw7pD1QtPATSopbYF2+9g4i31IKDZh/sESbulmHozsYIu0V?=
 =?us-ascii?Q?Aweqnb0vxDSFNEYpNScaQMEN1GzYB568wxMI+Bdi8P4SGlJQxa6W67wI4e9c?=
 =?us-ascii?Q?oU9mZ/2CxtZNOOgVMeTrNvpTAiCB3AYKIqULQarAXV8UhkWbQ9CUfHeeKDdW?=
 =?us-ascii?Q?y2B5sGMLxwQ6Sq/oGb9ZgIVJDonSTvjJPlAxfp7gJePKh/BImT2aNVG1grQ/?=
 =?us-ascii?Q?5e3lz2raTt+6ON1l+cvrj+I/YXQy97vYiDl0yPoWxAB0+MIxeIlnI82+6lHT?=
 =?us-ascii?Q?IoCAFtFT1mfeNIQFjCdn/fx1+gqoHJ/BJWKlor8773A/b+qRHYVTVcmx+BWW?=
 =?us-ascii?Q?vhLOVf7INPOYBnIuNhMuiOPrdrOaIkqaFbRV7o2eDG6snJ9DsGIUlPESK8xL?=
 =?us-ascii?Q?bn+WjTYu6TuYreuFTRari54ZsBmZi+nXXaC7CMnWZmvFFDUIl3gYKp4g+Ece?=
 =?us-ascii?Q?AN2lIy+OTdL3ywCX4Tpmdi6vrcWfzKJWMeYxFoW8k+o0qk9r5jfm/kKmGy5E?=
 =?us-ascii?Q?+av0z2ZEcpxS7Pi9vV6Rf3cV1m+NqYqbe2ANjfVQk30lPwscd4Pc5XWyu5Qy?=
 =?us-ascii?Q?KSxom7V+2fXsl8fGTJloHqITZPWaWzUHLefol2bofZ2Jl0/WLcMXEPCq5lot?=
 =?us-ascii?Q?nlzVK04nDBrBk9KYu/hVWTHtZW4dQRxPjL4LaDrkv0ks5NCff0y+bEy9SRck?=
 =?us-ascii?Q?js0trMAc2KUpsXj7DSWJOudVSrPvKkifxQJGIYIPYQl5VYhHMGiDrdDVAg/j?=
 =?us-ascii?Q?unvK6VGVW61ai4HgszlSfmWAhnZB3DcvxaAxP40MEtjByb43K7bFpN9NdT+7?=
 =?us-ascii?Q?FRKqyqHfggsLZjqKbJg+5lWGAn0qwNfq1D8AV4iJpVfvVLljJt59F/6wu8+5?=
 =?us-ascii?Q?Ia1jd4agcnGujxNA8V+iqCokFAASlVqB7E5g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6q7XlAJ01Y5Xw1S02mlRBkotRf+3L6uqVs7eGWbWoeTdOkAlG8MABBtjzy5?=
 =?us-ascii?Q?QiRcG+s3AywoIwkxw259EW+8YlQvrLCQlokbPKMsod5E0ZYLalTZXZ2sBes2?=
 =?us-ascii?Q?JvvSHkZVmCMODYatkImCL/1UM8UX53DP8iY+vsEw/TmwPsaeDjZwwA52evmd?=
 =?us-ascii?Q?cldsJDz8WuCd023vV2OsgkmwSj7/Y5dCZm9/dX901j2RLLZMnbPrbNmOeFBq?=
 =?us-ascii?Q?FmBMEPhKhDpPY69JkarOxAUw4aZM1S5X/t/J3QCbRN7pZmROtBeqHr0EBBAV?=
 =?us-ascii?Q?mBEfWsDDhMeVIGUQCTAMD6vpnSF7RTk2K7ulS8H4knCeAf0lKA1eh0SJinja?=
 =?us-ascii?Q?41ushmulRpHtcXNeWPn1RRWaCjDLOGzNVKQBNsNuNEN2O4LyV9b8fvX2Zmwm?=
 =?us-ascii?Q?dTY69z50bfGlJa5PK8dRh9ozzgaEt2FiPC48RnF8kc5pDSxWoA4emrSWLsra?=
 =?us-ascii?Q?+sVuf0jGIJddZbRBNBSUFyzuk93iM5qBWUV5/MXR4bbyxBB8mx3wfmuH4PpP?=
 =?us-ascii?Q?q32S/CBio33yL7iDpqIpe/TftAsjQa9/mAQmMGeJzbWjUN17LwalNaiDyU6i?=
 =?us-ascii?Q?4/eIYQla+MSTvLR8XdjvWqZR99PIaVUF8V0MCbqbKPG8/lnrFSlSNJxbKktv?=
 =?us-ascii?Q?+NaUP1MTTuQyggxSSwgXFMUTkDdfG25zc28bGoumSwvp/vyszg6uJRQNYhFr?=
 =?us-ascii?Q?OKue/gIyq9F7+vQkOJll258PliY9TUfCKxXknyUIc8SYzaD1Q5dKGDxWAdhw?=
 =?us-ascii?Q?DtnSjFAJY7h1m8pbU+11ifFCwRGARSUSjmQjKMwUqJEemUIJhbHNK/U4BLI2?=
 =?us-ascii?Q?wqrj8jMjzJ0qTrWSh+vFg9SWfXKKw2ddeciXyLfF4JAnQeeXJQTWzcMke5Rf?=
 =?us-ascii?Q?BlTbcw6i1woiW4Aqh7g9IxR09+p+a6LTH4sZE/pyRqkqWXUGwWEUkMFc3iY2?=
 =?us-ascii?Q?WUgsMA0kXIe17QKLq7+ZhJ37ZCv0vjVf2N+ciQT9fIpu2ySORUHSmBQlogLQ?=
 =?us-ascii?Q?zO0scVW0bboOVKpmx/ubGcSDE72lzp0clBIFWBEjaGevyoqOVgRLZyvpAsaL?=
 =?us-ascii?Q?AUnAxJHa9B8VQGaOIXYrwSwzWv2Qd/ExzteaVWdoyB/d7FJ90wxwr6ngz8Bo?=
 =?us-ascii?Q?1rKk5+EnlvXOlxb690HieAacMldbQPMRqHbnbS5H5KCCncf4+YXxxst6KGcC?=
 =?us-ascii?Q?FBAitZ0zV6ZnOwsNK5zB1EbEVMQJTXQRgHQzx6X3corqkIUetikno5tlGErX?=
 =?us-ascii?Q?wXne5/+YJWWPfWvOd+4rAfTsI9pgphd+0AhhwxnE+fRxkfA/pLBKdoFFsA7k?=
 =?us-ascii?Q?2Yb5dYNgcG/xdOb7c8j7MQlwtPdFQlMQlgOIqQrmuxy+xZiNQW6UFWR+yBYb?=
 =?us-ascii?Q?rLVHdGaS9o0nHGbITZ3vRochYPVAub3LuL266UiDjnnfU/VYiZ2KxAFUMMPD?=
 =?us-ascii?Q?zBnC2VxMuSrOzhUQXjlxhXUhwfE6XjXYT1GA5YoLPgRHMst4bADkwZ8JiJu4?=
 =?us-ascii?Q?WpV2sn64ST6n4ZgADF7t6ikq7pLX6PPb2kGZEH6bU6WHnbadIs/yvjIEOMMY?=
 =?us-ascii?Q?ACj4jIJK8lgLL0g+tpRyqbciL4hUK7WRCDOFqkZsyoQtHKRlKl4WxokmCyWi?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f9c7c7-d612-437f-ca10-08de1208fe31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:51:36.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3HF8OYtVwdBH219EWet3npLf/STPIpEsQxkDwSgMa4pmXAxmBDqnlhd5P7CLvIZfFdphJTwYossR8KoLs/snA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8255

From: Niko Mauno <niko.mauno@vaisala.com>

This reverts commit b7e5c59f3b0971f56ebbceb9d42cc45e9ac1cd94.

Commit in question broke building perf followingly with v5.15.195:

  | ld: perf-in.o: in function `test__PERF_RECORD':
  | tools/perf/tests/perf-record.c:142: undefined reference to `evlist__cancel_workload'

The 'evlist__cancel_workload' seems to be introduced in
commit e880a70f8046 ("perf stat: Close cork_fd when create_perf_stat_counter() failed")
which is currently not included in the 5.15 stable series.

Fixes: b7e5c59f3b09 ("perf test: Don't leak workload gopipe in PERF_RECORD_*")
Cc: stable@vger.kernel.org # 5.15
Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 tools/perf/tests/perf-record.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index b215e89b65f7..0df471bf1590 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -115,7 +115,6 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (err < 0) {
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -127,7 +126,6 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -139,7 +137,6 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -152,7 +149,6 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (err < 0) {
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
-- 
2.39.5


