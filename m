Return-Path: <stable+bounces-246846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBboAM97BGpoKgIAu9opvQ
	(envelope-from <stable+bounces-246846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:25:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBD53404D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896DE30E160E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FE269CE6;
	Wed, 13 May 2026 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QtIfT/v1"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A52253FC;
	Wed, 13 May 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677287; cv=fail; b=CJVV0s3ViE+diiaH+iVjYiDok2k/dzY3tsfXK0O1GMO07644AtA5tMuieoxNZdzKRqiOUVaMZBGEMqu3X/6kudOuClD57VB74YhZcaut/QKDoyzO5E+bOo6KgMerB5of53wApWIl7r6xHjnOc46CS17D+ZVkCYlGJJOhyWOB/dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677287; c=relaxed/simple;
	bh=7dBogNQF4UnbQyOTfDmPgkVNoUP5HX6nDzIg7s79vjc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UTYUb7x5jxrqcBWMcTVyvI90CZfayaxuGnIE/J09X5lac/4ul4OdgobnS72eHRUg2wuBenP4XKAymieYSxRGQaNonhyt1BzO+6HWPIv4Wc+HhGHqzjuxFYk76XdxTLF8kRqdfTZ7yYbJFEQz4DNYiLcdIjsrM2ZY4JVwlQumtSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtIfT/v1; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gF1jQ/saEcDIQ/T9e5No9b6NeHFIzaH1mIiBhvwRqnh/GyXFcib+biYpa5odlZpWJCAHzxG+b42cVooCwuce/mhmz+L7sC0V8HSe//JE3pbWr7TzdASrGNTAwL/LK3kv5TMk3phCBR3/02uQMOYvRKfF+y932pRDSYNKfC7t/of7YHuZZKrvORWoVE9BrmFTTt0qqT7N/GkaincFz13/Q5KUOZMAhwdN1V0OyroFAAwmW0OMEXBB+sK75qNTmEojCPfqk4r7hmFAqekk0cJTYSrGAYA8lPT5i3w+/Sewg0OXkloWnWIJXTCIp188+ZcH0cLkUv1KyM2KZjR91o8QWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeHwha9Q6tDqloz5xe5BowjGpmeV3KSq7FxyvXWYYs8=;
 b=Hg0WpGTxzHVU6PIeqQJ/uJQkAIK0NVfExXXlDUjPYdvh6oGFieawUmzPxjh8ewyJYCq94CyR0FPlvLlFzGoUGd1MbrnYXibI7esG0gtiYPt7s7qPkuqN6roQC8DqaQdZqF2TZS5XaTUZPyDLlq/8HzG/C/tR1ex2GbmYXyxFFZupjFF2ZHCYKsN9OiiRsMaDBUrC/M0kDnJrIdo3j3+tA+YAQesPaLH+181MV5P8e1IqwrtZ/f35rbnJNzcbOp8nVtk/fn0+1vOCqf5DRpv3ZPbpxeFLybjw5/ZNYByQiQxn6gxmse+VEV8OjRqoma3iemFoEj2BqEJwXxBSZXkdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeHwha9Q6tDqloz5xe5BowjGpmeV3KSq7FxyvXWYYs8=;
 b=QtIfT/v1VDJ5u+hN0wX183860WigaWBqPlpV9vG1AqQcLr0PCevcFMOVCI1WfGjTzVe60paX6DvvjcrdGFktxjDImQKZ2hxN/bRCbgjDS9r3a1uUTfmjCr8boVJYhcxnFmSFxUS+2zaWbmrtwlD0S01SAjqhnwM+jBZWFLmm71M1umVWMgoyl9RqNYGu4WnidgAE2JYbOzb2miuRleL2WKIceUnhnIolGkZZTZsHL+lnuzBVVVqaFPEi7pQQ9X2DHgMy9ZPx/BikFpY6KjljAiqqSZB94DuIbe/57DUfNsWH8E4U/5jXtoaX4ST0DEXaamtN+wVA89ITM4XpaJheKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:01:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 13:01:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Chris Mason <clm@meta.com>,
	Peter Schneider <pschneider1968@googlemail.com>,
	sched-ext@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7.0.y] sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()
Date: Wed, 13 May 2026 15:01:11 +0200
Message-ID: <20260513130111.689740-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0177.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9fd328-5197-4d76-5ba5-08deb0efba2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	oE4EJG2ZO74gIwGHRbpSi27FWCPvOqHH9ZDhqBWuIM08X4Cfa7u4+MpxAv8Mez5qBqQ/vw1V/zySqf8mrJAjVxH+yIMy6iGauoFr9mP0aWxL6mmTXL321zOc+fdQzezI27Uwfo+J5u5adBGqDTccUiCTgqjN+lxbktFsEC/4w4/N5bxAJ/ZCcQHfKzKDqSz8ky/WneL0N6HnGo9Vjfz7RGmsQTsgU2jYgREtF2jzYQ1FOpX8xWi0PAT9d7ue5iWvcqE4ZgiRjtv6Vr3xVJtEFoJpQvpwCo3PCMd7HOl2jBat/mllDSsiVXcFoIFFQX/4qHAZWCCgKsZ+wdKXgUFGhtyfWzhPbrDEcs+VjODYjVdgnOsOhSd6qBKYyc13U3fjVgbWmbiwYqRbSHAZv1EpKu6P5oQJPs+jNo1yPaSugb9zLn+mgBy/dgK6lVk+4xO2t8w6D0U+07yAenYPd5GYCCKmjWUsdY+hl/BabPQX4eB2LnCdjwhE62aTUUGLraFFHRE0eAg5YgSbWNpBzd4tJhmO9NHl/QhSRhbgLET64+c3XLHPH461Gyj6nvlVnnGcP23+6fqOc136X1Ff3Vxi7GrvkLk6xnMZPTtILGKP0NK3XqPC7RVq6wf3XXCKpaCafvKW0TZRLBWQmIyMSi/LxPUynn9x+oCbG4+vjTVUchPfj8xwx58kiyL7yX7Fn9+1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHFB1Go8zp2mbPAPos4tHtXzPOGEtoHxaDfmth2s6sxko+sK2q4Zg7PXM90q?=
 =?us-ascii?Q?mvA8iAjnvyZaEZnAZIi3GAn4DNyh/40STGSfzb/Djg9GjkXeczqDjd9VnzbK?=
 =?us-ascii?Q?0UQQ3PJzvFWKQKb+t5WI6ZtKshTgVGPY06UifnYyIdbvl0X8oKNe8oE/sY4w?=
 =?us-ascii?Q?+EaNdBGfkp2wEzLeSXTk5uVVJagLIR0hqRiX9jlvRbg8JlR9keXzCAQAgo4e?=
 =?us-ascii?Q?nNeLTk/9bTdWJkrlG+0/xuXGVVf7zavSqVdNcWB0768ChZRjkqe8RN9O0VBc?=
 =?us-ascii?Q?IyxfLWoy/DR7s179JNbTFhJdGog1SxmK1ORB11ESNUm+9ks2DyOvquM+0+1i?=
 =?us-ascii?Q?5CbWODC4Yj+atxNLCMZheaCCqgyS3AFsdA3QG6Xj/48LLT3I2UO7cQaOJ/OT?=
 =?us-ascii?Q?pahSYbR5mVJPRBVRf3UumBDgYOu8mh99ytnhVtZButduud6QkwBi9EKBD84U?=
 =?us-ascii?Q?GLLTBXtvwfnYBhhyiHfaNLWxMQgvnaByPpcEX8Ol826NgO/BTKXZ2CHhedsZ?=
 =?us-ascii?Q?33Gl3If4HtWRB/cB5QFfUBw41uZF/OexTkwt4tgwrvG3kZdqv5Yl/E2yGMjp?=
 =?us-ascii?Q?kGITU7R55VbQvO++Uv1kIX1PYJIoDjA7gt+dpSi69ceNEOvhylPD9ocWjh0n?=
 =?us-ascii?Q?aSofWSs4KzD2D/hTs1RF/RsPT85s8U98pP2Sbv0TmUV4+TylMWvVu02twz6Y?=
 =?us-ascii?Q?cFurNjXwHkGmCZZo85T1Ojm3BEn0cI95yUcUgKWcoRvdRyIRsD1zvOnznO7t?=
 =?us-ascii?Q?lccztIhXQNFtYaU9xTyytSNmcD/rN9aCeSge0bj/70mJmMIM7vbVh3BnNDCz?=
 =?us-ascii?Q?E+Nj0jaY/SrIQIC7o3L+x+ReH3eCEn7rjk+9Rl+IXrNCxoUVytYlmPE8Snd3?=
 =?us-ascii?Q?fBwwBH6CcvCvpgP0yJPTnIgmcZoeXxk5mb+UVvpGHchD5dFlZNJk6BddVEmj?=
 =?us-ascii?Q?BJF+h+MwyQyfAhaC8LwQ/jllcm74VBISMhzbSRy/KPvzyeroRgRiWBV1bnho?=
 =?us-ascii?Q?gkhwjldmXrtVj5JXouF+zio9k6kUCtFzBbx0BO4ZAtfa0zyyRiwNN/8Nehvu?=
 =?us-ascii?Q?m9Vg9SXdblwUJebQVrVF/bVhbfouBMpkFDGvZe08HoP5emEuHCBWCQtGp+jX?=
 =?us-ascii?Q?aGZ2ifiNusAirKFWaKyOxs+5FnTZ2SUEdZyamjUz52XbzJhTJUpqHYD5DPfs?=
 =?us-ascii?Q?6+QMdnBu90tZPdSGSJFW5zh0qVCf4J/bEVmy1jwNkf4f/MIk+27Xp2atjXbL?=
 =?us-ascii?Q?k4RkO91GBREu1ElL2xzw+eGIMYM5wTvf2WCDAFcbieEwAy4i5rhLocOz44SN?=
 =?us-ascii?Q?cZRXgA0JxmIaO+wea+rBpCx6LHSzDMpZWy2rMHl6y00Zbo+qjFdJSLNhIK4k?=
 =?us-ascii?Q?VotlIQfMaRw8uvGb4VSHaG8q4PrIQ3Dn/mXRcAlFQAkL2GVMB6bE3kt2U/V3?=
 =?us-ascii?Q?g/FY041hqMB3oDqKVjm61CXgnpyMjcpQ+VPxEYxI3utrLX/s2eWilb51AJKg?=
 =?us-ascii?Q?FnWLHl6nCoJ38WuXKtBg7RoZrOUIWqNTMfgvXMtNteQOtY2xJOfRpu3pHRuR?=
 =?us-ascii?Q?HBdl9Ark2ElqFQYOZ9OWkMEHW1k+U/PdH5mf/DD++RejE1uhd0DtUDZuuSQj?=
 =?us-ascii?Q?xQ/VkJz4Ue1pm1D8Q6rFGbELFvDhhCxDbEF8HJrUjkDaNuIqm8sLapAXp0Dr?=
 =?us-ascii?Q?uO7STRVJyoZwwvUlgIkv9/g/GOqMcOKapPU0oeEROOj1iy0v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9fd328-5197-4d76-5ba5-08deb0efba2b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:01:20.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN1Mm3zW9sy/hrCkVxYlFZuBTvsCZQTLF1YjKOp9wkbA52tmzULZf9E+gTysxCfKIAGy5m4W+/I/LrfLsWd1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
X-Rspamd-Queue-Id: 76CBD53404D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[meta.com,googlemail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-246846-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Action: no action

From: Tejun Heo <tj@kernel.org>

commit da2d81b4118a74e65d2335e221a38d665902a98c upstream.

bypass_lb_cpu() transfers tasks between per-CPU bypass DSQs without
migrating them - task_cpu() only updates when the donee later consumes the
task via move_remote_task_to_local_dsq(). If the LB timer fires again before
consumption and the new DSQ becomes a donor, @p is still on the previous CPU
and task_rq(@p) != donor_rq. @p can't be moved without its own rq locked.

Skip such tasks.

Fixes: 95d1df610cdc ("sched_ext: Implement load balancer for bypass mode")
Cc: stable@vger.kernel.org # v6.19+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ arighi: replace donor_rq with rq, not present in v7.0.y ]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 89814646a9868..ddd7c19daa17c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4008,6 +4008,15 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		if (cpumask_empty(donee_mask))
 			break;
 
+		/*
+		 * If an earlier pass placed @p on @donor_dsq from a different
+		 * CPU and the donee hasn't consumed it yet, @p is still on the
+		 * previous CPU and task_rq(@p) != @rq. @p can't be moved
+		 * without its rq locked. Skip.
+		 */
+		if (task_rq(p) != rq)
+			continue;
+
 		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
 		if (donee >= nr_cpu_ids)
 			continue;
-- 
2.54.0


