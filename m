Return-Path: <stable+bounces-77695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B2F986098
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5703D1C2636A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4018C321;
	Wed, 25 Sep 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="rd6dQQIC"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E63178364;
	Wed, 25 Sep 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270066; cv=fail; b=Mi959vyz1R22To2vkxOGZfwkf55GEoN6ep+m8acQIzV5Oh+v1UJ7+720YHFWLm1v8jGfE9i6TYfsg2zszlzy2ugWGXVbH9Hp9dl9Rj77HgpUyz2a83s5UErfJyjHB7B8KL/Us/fCXU08WZD0PpgHJpoAK3xhbhkpmgShU0gCLhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270066; c=relaxed/simple;
	bh=/teq5fxYjq0YsiDUbBFvhAw3A4O4V3mXT7QqarXYctE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T4U3R2v0MOsSNmukKJ5EhLF7/Dd1ue9QSGB29Qt3UKGWiOiZyW+pDcBq5MwSOJxO93NFvOerd0m2tktRqpTRMoPy/E2inoP6/0J6AhqSlmMiVtuOkd/PufRpSZslHqRrg7Hpys+7RzNiHdXDWmrAEvhEF9kL99z12sZFTiCOkng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=rd6dQQIC; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4CrBuQgZ+uzGuy0R+AoBLNc7eMqN7kAUUYa6LTfe3zVCgHWLXLRAckjpCrlsmp4PazxGcNsMzQ2AuuFNkKlWSk20iF8swqFH3f9W43nVbj3gZROoR5SNAHA6kPbgKRgNF7Dsbg/fYuyWDYIbuhw4HjZK4mEmgi+AohKMHz2g2aFTCcDf76MC/VtVOa85qGAYGopNLl/Vqe6MeE+UKK8d4J0wEqtAqObcjlbG78Icnxqk88PJ13xW0LLLG1MqUNAwvukoq2CFoSHBdZRHqECEwffWumM4HD+jeqTd9GfRI5gaIdKEnzD/DxjZ8cuIgaLdp4ekjM6AWcH2gOHg93c2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r97VjhJSPp0PnTeXqeQx6AJOX2j3YrZLW1M8XQ+Ye7M=;
 b=JK1+CbLzvV5p+0bdzZmJDwW3cnqqOMFHpisQkh/D9keacb7QTdfLppOSAwkXSm5/PBW0oDqzD2EmbTdsWb8SPbzcjVKs5/xQ+TiogDVP7DnQNE+VbAqFYfB1iZa7a0ZNlw94Re3HNU1y+axaF/xCSpKK/OzD7rybveHD7pJg+w1AqF4IrN6GxYOiiEViuijyHNMsMe6XGibSadVpGfj5Faa8aA/b+/P41VuCw9rZJ0FiaQ1EWdhDC585eUEHd8gxywpngfgzG1jDQo85PHWQdFFndECQN7vV/EJcowifmvGxC29hndJwdqT1AoUjhxjyQDncmDicEsqkntucNcYMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r97VjhJSPp0PnTeXqeQx6AJOX2j3YrZLW1M8XQ+Ye7M=;
 b=rd6dQQIC+neJQ6yZJwbZiutqEmXeobYi9QIkugVqbBXFZAWy3C06HspQRV6PQlJG6yLzk+c3kP5J16v8pUNRKRrrakm+yEJrKeCK21oM7Amd2a7ANpw/5c90rawpVJQQiyJYdvwTFklVtNe6QEoXkcTpidUztCrMMxO03AQxh3uddR30KL9niur/NnD1GiuSC22AMFCdYehIRaFYIZa5xPTSIQzefQMuczGW6F9uBSdVZRpd1l9qXTG1U8H7BegLhbzD8fJh/V8Fcf+7WG5VRJ3ZdVvKmSh0W2jq+EpntoNIqa4t01UKggCmyowfY2l+rGZXM/FCQq/3PYHAHj/sdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8707.eurprd07.prod.outlook.com (2603:10a6:20b:4f1::7)
 by DU0PR07MB9265.eurprd07.prod.outlook.com (2603:10a6:10:44f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:14:12 +0000
Received: from AS4PR07MB8707.eurprd07.prod.outlook.com
 ([fe80::887:2f82:171e:f1ca]) by AS4PR07MB8707.eurprd07.prod.outlook.com
 ([fe80::887:2f82:171e:f1ca%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 13:14:12 +0000
From: Julien Meunier <julien.meunier@nokia.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Leo Yan <leo.yan@linux.dev>
Cc: stable@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: etm4x: Fix PID tracing when perf is run in an init PID namespace
Date: Wed, 25 Sep 2024 15:13:56 +0200
Message-Id: <20240925131357.9468-1-julien.meunier@nokia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B65.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:8) To AS4PR07MB8707.eurprd07.prod.outlook.com
 (2603:10a6:20b:4f1::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR07MB8707:EE_|DU0PR07MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 267bbe4e-57df-478b-e3ad-08dcdd63f2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cz3rheaGzPXDfVyQaRKnk7wTodIzfZQeagaiEp7HwrVry1de30jRSbFxKsOo?=
 =?us-ascii?Q?cVTCzc3tTYkSGp/94zm/QoGV55lqoy3Yh54TVFx3P5FHU+YoawqzDzqNLLhr?=
 =?us-ascii?Q?WprzR7/YkxzLkTpHlVOQ7IRPFdUlydJxytd445gFebI4Hf0qvwhRvYVueOUg?=
 =?us-ascii?Q?fQMmCjHO9CuGggXYu0QziYaTEOicDLo38ofgiXiHNvQqC717PG9pyjbTwZp8?=
 =?us-ascii?Q?IzDdIxdzzWHaBYPJIn2xghpnDUaxVWYOyC0h4yGaVJ0yD5tL5lsSANEC8gcU?=
 =?us-ascii?Q?itbBMUQf/KjGhuTGc4YQoRd2NHkbMaHh+ytdo5JUzb8wRdFy+eZw7eIQ2dAO?=
 =?us-ascii?Q?dM5RLoJpYUOUciQqli1vCqJB0YB58RV2f2wnnvNhs1FewjnZIN/fQieLpPKM?=
 =?us-ascii?Q?nQQ8NUoHL8kFwW0KTuEvix251bA7bo0DkO+rtDsYteMMqfEdwwJyfkq5c3R+?=
 =?us-ascii?Q?prix21xnpNZUtz1JZdioXk1ZfeOExTXBX8CD3oufIFMn7cJaAkZ+AJsSNY/r?=
 =?us-ascii?Q?vk8Gu8OTnuHrBnN2qLgWsBH+c1jlgSlAPL+LJrGkexg3oLciNvSIpdPKMiO8?=
 =?us-ascii?Q?Fz6WgYg4U16kv3KIZqqyqP+IXDqFL3Psp59kWOc+zdyJnZqEUel9qKl6iH1O?=
 =?us-ascii?Q?4lWjvAROjoozJ9DYqndu+BcN3RMdWbGOR0s1vFr7Y8Eg/UpyYqD/E1lcNNPx?=
 =?us-ascii?Q?qb4pW2BYQMoGTmWSfJwsCCtkp6XepnN7J7MLZXAlPQAiY3HAyMQm9hW9447g?=
 =?us-ascii?Q?BSNQgUHXMu9msfYqO4A5QP2Ns+ylGUA2TymHp4FS2FB+r1tEfMkj4UEIlntg?=
 =?us-ascii?Q?H+13RxkgF+1NHBUhSF5idsewaNRJYIwI4c8hChwrih4Aux7h/H2SHhHlB6NL?=
 =?us-ascii?Q?qex6RRLnSN+ycS4zqT9zLJ0IYrFXr9MJrx5T8vNKaHuasRg3QMMzV/FPtAuJ?=
 =?us-ascii?Q?aOeG6cd2LfJG/dkVIL1jOeQvMWWkP8WtRkJZjjgWLnBMN92EhkGh4yy7aoPa?=
 =?us-ascii?Q?6+K2MwaLH//R6oKvA6MuIzbPPCR2L0tGdBNmuxqfGCBPLCPi1AXyU4fjluQh?=
 =?us-ascii?Q?MoNC+JWkl+KdR7lZkH84je4N3SJfSchzwCUM2PkUqj9hBoPFVS4gg2bjGMsr?=
 =?us-ascii?Q?S27QCi4AsjAut0j6a7L6U0/m2+dfP314xsi7gjLepXogh1uFvJJ1lPyNKi48?=
 =?us-ascii?Q?EVDM1ByevVrBzucESjQjIGSbQj0JxYDdrJ7EnXa38oYyHRpDmlG4U2qI4w40?=
 =?us-ascii?Q?sDyd/vpxT9mOLjskwSgST/tyTNMwYksSiTviNh/s5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8707.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOOLLjbZ5pC0d2ft/VjwSzyfAGVgZPmvfc9kxXi3+L4OhsFDa375skId2xlz?=
 =?us-ascii?Q?W9tomtPp0OOU5KFehAaCKOBvu6mKDIusvvNMaLS0DYhvLpzrwIEaKTrIIIV3?=
 =?us-ascii?Q?twDj76p51/XZoQlpB0D1kOjb1nUiOm6QHQSNLtHx0nJr9Z5pZyqluOubW69M?=
 =?us-ascii?Q?QRRDNykfxAV5h0h6zGIuPtaE0E8KBxmlMb+rm9e9443ew4yXyaXeSDzMgK1r?=
 =?us-ascii?Q?QlX8HVAl4WxCrr9vObxIFnc5lHzUgKIalEdbuJzNHrTswZOS5A35/YNQnjlx?=
 =?us-ascii?Q?BVXxPto0nANPgE0OyQvg4y2vXtzlxgTbu1hmPTklIW1UDQTBxKiV6NLzdq8y?=
 =?us-ascii?Q?lm5DOpxp0cIhGqv9Etflv23cnlzfzJ2bF+V294PFilIN99ehhLxqklBG/M+6?=
 =?us-ascii?Q?w4q+Mz8KapBo+LBNBBEJgD93j/RMkVnDawdp17aPpGTP9zy1pdEPNmMxOS0b?=
 =?us-ascii?Q?TS48ypefj9NaySBJpfZMDQXX0dEfVvoTz0HLH8pjmp5NLaUc5hV+oYgDjyYG?=
 =?us-ascii?Q?1Pdnw5s+EP7SXBh2ellLh0m1d0acfrnDHxqEe/loRnkJoY5FZIodlaLZwYsF?=
 =?us-ascii?Q?awSqlS+lgw4idDFlAqffVbbQ0Y7HRGYD20zDuHxlnbt5XBaJcdtIVBQDSOUb?=
 =?us-ascii?Q?/BOnmRYO8E1FrhlsgnAkhgSUir04gNZto6OgioAOTY2oUVZIdszmamFGtqr0?=
 =?us-ascii?Q?A12tk1jKrl3SWyF7m+TtuvgciD/NE+tyMogKbVHF+M4rkp26DzF93NxAdrJE?=
 =?us-ascii?Q?dpD+b5VM4ISOOvS4Hc4B4L9Edfxbfr74IFvo8I7tC7Zorem9gs+cypqjqQLi?=
 =?us-ascii?Q?23CU0UsSQl0nreRz6JVNPqC2a/EG9DNwxiWxdUIViZSgAt33Roox7MVqioZ1?=
 =?us-ascii?Q?jfsTfZwjGFTADyZPj/+xnFVMJx4/naz8dFIFCDxOGBndNMQMHf6aBKiVbNhH?=
 =?us-ascii?Q?gOh9Eb8z7XsrkNLb9bhlBEV4sx9RCm5ghFeIZM2iKWtqLMpc2bme2OAQIU6h?=
 =?us-ascii?Q?szOynzY3/6stwaBIaC8SOFvTLAjiB/N72RZFEXxJjhOAJF66wBNffKUi0M1u?=
 =?us-ascii?Q?Poi1TcYATmBiBaYr5Ii3rPPbVn7qNzNZ+Nf1wCvcMgloNMNlUUsG4BH4IZqM?=
 =?us-ascii?Q?4pQ2NuICfQ97EPyewzEHAyjUPJBVaGYU+NgMIjKVlfz39jk6V0H70oqK/aNI?=
 =?us-ascii?Q?+jo3xhWvFiUvME6SQRHbQ3IdQXWGSGMLZkXuXXGlNZD1l957KudscwYYajgM?=
 =?us-ascii?Q?RclyJX/y5J61RDHpcGfbBjgzDZIEuXwKKWaqqYC9zGqidgm9jWlBOVWJeylG?=
 =?us-ascii?Q?hVLI0Vb9ElX6c7S2LwbzuhopD75tmsjUu5klltvwu9RjbFUfoUkXojhaJOYA?=
 =?us-ascii?Q?GsiQ2RXSBmEp+990vwr9OTq1wjN9NWCXRSgGGOUiSSbtK/92IrBYiLPNWQIP?=
 =?us-ascii?Q?gWgcf4rLrSZVOjiy5u7R/mbuWv2Wr8LtocBJMbauUyKotZg3jPDHPmDfExsr?=
 =?us-ascii?Q?inltJJ7HI8xZa1q2hQYqxr8OCYj0zUscT+nhUWhimHq0x4qnNDnLvvQWyWJz?=
 =?us-ascii?Q?lcir6sqfAurmU0UH3O/xJNTf44i3EMc6vYR2tfQP0AiqVnip8fJfUK8nVnog?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267bbe4e-57df-478b-e3ad-08dcdd63f2ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8707.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:14:12.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3MT3RW5OA8Do/8CCn+n+BCMp3cRhLKFD4TpE31V2tB5yfvXNdf2VaNeet1iphO9tQBB9HdsrWKwToy8shDXy/ofq8Sg5JDCS3MQxSuAkKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9265

The previous implementation limited the tracing capabilities when perf
was run in the init PID namespace, making it impossible to trace
applications in non-init PID namespaces.

This update improves the tracing process by verifying the event owner.
This allows us to determine whether the user has the necessary
permissions to trace the application.

Cc: stable@vger.kernel.org
Fixes: aab473867fed ("coresight: etm4x: Don't trace PID for non-root PID namespace")
Signed-off-by: Julien Meunier <julien.meunier@nokia.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bf01f01964cf..8365307b1aec 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -695,7 +695,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 
 	/* Only trace contextID when runs in root PID namespace */
 	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
-	    task_is_in_init_pid_ns(current))
+	    task_is_in_init_pid_ns(event->owner))
 		/* bit[6], Context ID tracing bit */
 		config->cfg |= TRCCONFIGR_CID;
 
@@ -710,7 +710,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			goto out;
 		}
 		/* Only trace virtual contextID when runs in root PID namespace */
-		if (task_is_in_init_pid_ns(current))
+		if (task_is_in_init_pid_ns(event->owner))
 			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
 	}
 
-- 
2.34.1


