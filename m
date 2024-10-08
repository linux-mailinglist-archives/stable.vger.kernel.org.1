Return-Path: <stable+bounces-83095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3A995811
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7503F1F216EC
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BC3212643;
	Tue,  8 Oct 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Qcb4CfVL"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B412B17C;
	Tue,  8 Oct 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417758; cv=fail; b=HAiYNhMcu1bC+IasOTQc4jKbbZYv+Y6nx0w/J40taFRZUUKhyvNUdkYe1qwKSFHZPwuyajX5tsavYm64UJ8KBfBMwB9G8BIROyT47ZHIRZFDv/Cii07LbEq3XemX3+aZsid4FoVBQryUzF7ZHl+Xa/1ibLuRi8YEk9ogKB609PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417758; c=relaxed/simple;
	bh=oWwdgxRh3PgMhyfxXmuTOzNv7jbRnAY4BxC/MB72HWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pSrKSLNw/Kxg+UPAzsoRqf/vOuCKFnfjjVFhJ4mviLlYMqq5K6fIEET0vzBU0vddhZ1zX3qxTuyqaCLsPRd7hqHW5xcyuHmddtliq7+Pcu7l70svWxNFKhikjT2Y+xlQBUf9MbP8ZL1iloKwW6nMJbcyu0kMsOyLR55wY++czzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Qcb4CfVL; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBD2ygesGKbAwGgbxBfszn438y7Qvrq5++Loq9CDk0TcLMhn8/rGNZ5FW0UlNoSFBloLQYGU7N/YgiwZ3MU9p/o9SW/kJZ/MzDVXnY9kWJDoEV+JMXu2J1agdcSeCCCpdp9t+50lr1gMAnf5hw2JZfdmD4nV/z5Q7wt6EFOcAbArZALTIg2zgVBhw+JtsBSVixN/RRt08mGkAgnM6UsyLWbQLIVDf8SC0CxU716NMr7UxvP3cxJtdPY6tIjJaT0DYFm7fijys9dkSwClZ4oShobzp6H5bgz1FrrUlwOPwusUB9o3nc68gQPdh4Qu+mCKL55T8yWZW7D8tGqDPNDuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzdWotbnb0kglrqvBB63QGfSYLt0JHlsQ5C5ZifPh0k=;
 b=qO/9pW/k9myJ3Sa/e/HBx3+eLcNPT6RaCFAimv41qReuVS/vjfoZNEhGP0gilIDmAcuXhnireXIYLm9ujHAzqbJoA6LctsA5pAx7hI+0a+bmCGocXZ65DjusOGBLckTa0YGwA4qNuep+bPcIyUo4kDGkyoJiXvlRDxn2M9nlqV+ddN1v/H9f7cnbNpqgXDnEwbWF4VXubyimwm6XWUriMLQ3yIZheGD7GcVqSjOI3YVn4kaDLZiFm9LUC6ILj/0sPUfRAPmnn4TSz4PGyxSn0I3XcM/s+PwZSfuJldL4sFKOqa77mHJuYPuE2De1dHPAyrHhd761UuGBHEmeoSvVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzdWotbnb0kglrqvBB63QGfSYLt0JHlsQ5C5ZifPh0k=;
 b=Qcb4CfVLBSnu8tdOYcs42sM62UnkABAOBcxR8/drmJT/UPa667GiECEKhAq7pw4Vy/n3z+6mH32tXPh5Q5QC+V+Tr24YHz+vdtz1qGMcT1V3XJkDKpiMZsDMv+l37JQaiNVnNh5ieUt4hrEXq0hAWlvo9RM/awyjH53pN820uOT/H1RgjEpM/9A8W8LWEFeZoit7PeUeBiYYE9bA5Ql/Lnz57GLnDrm8Ebd96JWRAr/JlEjTYXKYtulQOV/a+GdTa2xNjtpXEnCXYguyPoCGEPD2s5SCOhe/wt0jXCgk/g5YkbhbaiomwhJhT5oUnOLXUMUrANChu0ieu0uPaDvUFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8707.eurprd07.prod.outlook.com (2603:10a6:20b:4f1::7)
 by VI1PR07MB9500.eurprd07.prod.outlook.com (2603:10a6:800:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 20:02:30 +0000
Received: from AS4PR07MB8707.eurprd07.prod.outlook.com
 ([fe80::887:2f82:171e:f1ca]) by AS4PR07MB8707.eurprd07.prod.outlook.com
 ([fe80::887:2f82:171e:f1ca%4]) with mapi id 15.20.8026.017; Tue, 8 Oct 2024
 20:02:29 +0000
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
Subject: [PATCH v2] coresight: etm4x: Fix PID tracing when perf is run in an init PID namespace
Date: Tue,  8 Oct 2024 22:02:25 +0200
Message-Id: <20241008200226.12229-1-julien.meunier@nokia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925131357.9468-1-julien.meunier@nokia.com>
References: <20240925131357.9468-1-julien.meunier@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00003676.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38d) To AS4PR07MB8707.eurprd07.prod.outlook.com
 (2603:10a6:20b:4f1::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR07MB8707:EE_|VI1PR07MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a64217-d418-4caf-cc20-08dce7d4237f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+aocHE11pqjdiojvRn+ze0uJYSFlGRJX3NV5Kdfnu9kSrOOlcCNoXo71wZO?=
 =?us-ascii?Q?wbdU2B1pvN0IkEBqr3/z9ZcnaDYCyTCmqzeP6TmnVtzs6ItA0uzxzoWDXFVq?=
 =?us-ascii?Q?S1nYhBFEMsTG8bfO/qap9wP9P+3ETMNVl4ij8fucGK+06gXPEsvWUGXQRqq0?=
 =?us-ascii?Q?VVv7KnhFdE5fKy+HGfepX9T3xNHCBVDyZTp/SXq/R0+pEoRPmMvkifXE4RZ/?=
 =?us-ascii?Q?xiB2LowkVN4hmvtCvlyABBpYA5QsqYMJymD7aGlfNvh2S6jIHqOLx5fW0fHc?=
 =?us-ascii?Q?abSj9MPG1oaFA6PCKOELvugchbpB4P6vpIjMkksAOXSJ0cOnVBBewnUN/Wuo?=
 =?us-ascii?Q?l4SV7CV3WDK6biWU1qQJmX+bf4xxQsNJyu7YnWqlskhkosWujOFl33frH4+/?=
 =?us-ascii?Q?swybfDNGxQadX8vV1AJEYhcR+mFX1PN6xDeTM/6t5Xr2qIi80uYBav3Y6yJ8?=
 =?us-ascii?Q?VN1n0zyeKk3rsGhIWm6OsAKtjLtHHCw1rbcD7HVpYC8s1b0wxpDCy+cl53WQ?=
 =?us-ascii?Q?XjtNrEqyQNtgh2V48t2G0YucdDfUjqb95ZSXj5Gwt+HFAR1DYxTVNV1/Fdoo?=
 =?us-ascii?Q?H4Nyv/sTR5KLRtoFG9kwDm1+rHbxnKPA8/C7Mcp+2IAKD48UbrWZ/gzPyZxa?=
 =?us-ascii?Q?usp8pvQutunG52/zFD38WfH78sCxlvynEibQTXdC1B3avC8DmF/BWgZlPHYQ?=
 =?us-ascii?Q?4hJl9bQ9oflZHUDvTD/v+LWn4Q6sDNl1EIghV9weCNkuc+h95LBl7c8m8QAl?=
 =?us-ascii?Q?1sQukUa5Q1/KFndZu0XKHu13DsuhFB/fSu+iw0V/nFdz1FEPVLztF0axNqA8?=
 =?us-ascii?Q?ewZE4Wuf57iAR/OnKQjUEcMUgq02HrPMUzvbJeQzeXQoNwM2arK1kpx7f1om?=
 =?us-ascii?Q?lN8zc/I3sH1s/F1EfRE5Qh0aG7GgALx5Wizw7hZ5tWLcV3rF7M0vXtxircKl?=
 =?us-ascii?Q?KBIe25u8CXl9SFT4IoeopzrOpxP8ceYRA6WiZITVHNZj2L490jLo9Ds7G4C1?=
 =?us-ascii?Q?+J9GbiSFXW/4ae+UlSEpsiH63Unp3p8a5kQlXkmbnxobu2kE+N9zNwwFL8Dl?=
 =?us-ascii?Q?JaR+o53ZsSchjq5HKa+oHneYKvFYkjg4GWzvczfugTpz+3Zvuifp8uYqkskX?=
 =?us-ascii?Q?bEr94oVDG1OefdUUOkO+zlwKAgAJXw0BDqr4D7E/ioidsaefULKpRIpdH8x9?=
 =?us-ascii?Q?S0Ywa8Bn3XUi+mv25nek1aaXQQSo8KqMbKwXk7kYXQKrs45KNbv96+iF2pa8?=
 =?us-ascii?Q?M7n8dvbLfCJYh9SlYjq7u6WqpYEU4iuOnGvCUsCeng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8707.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bfbSS6XoVVYcXpI2zCDytJ3QOBAlItO0r8vrsMd9JaZsAjYZpnBSlh6FtIHi?=
 =?us-ascii?Q?O02iIeRKr11qr8f9KwrWVbPxj4WNmRGwhsftkCRbKSAZxrJ1xuC/Ew5MaVJy?=
 =?us-ascii?Q?ltEbKcreVunMK2mAC2/p2mCBMGUzRaNI+yrjnH1zcSZgnRKb4FG5NQfkqKBK?=
 =?us-ascii?Q?tx7WQut4NC2nkfITATNSIUT6I5xl7YnCCyr+ZOwlnV+st+ZHLvqekfxl34oL?=
 =?us-ascii?Q?aOaOxRaBE8kpnksIT/znodi58Ac2pf/Q4PNDiI/c+QCEHAgNvIhyUOdkSYeP?=
 =?us-ascii?Q?RoTiUaiGqL1/BwQAOUk41AaPCn9vCGXfQJrPCEE8sp706KQQrAMA9NEbOCgu?=
 =?us-ascii?Q?mprf326dwAqf97s8zvhUIrQoNdwej5dB67+5VOzj3F1+xarlL+C9aFbgH88K?=
 =?us-ascii?Q?0bGoaVvqu5Qy6V8mB2lb7WFVzgu9bzAEJ1+UAXKMI9icXY6VgaLcl+xcnTDO?=
 =?us-ascii?Q?jyO5A+hD12l1JyZoLJQulIYTKxU/RTnTJGaBAKUjpYsSbnIZzjj7iA/fLu2o?=
 =?us-ascii?Q?G9u54ZIfNk3J8tzI8g4LWhQFgFyEXMCWvapECU+viakB23EhMwOoYvGgc4u8?=
 =?us-ascii?Q?ykA9VgsqXyP2nP5IzDzl3k1eik0j1cSkabHzoiIRKcr88FPRDQD6sWP0/C7Q?=
 =?us-ascii?Q?qev1zjryMP02VYszJHM1gAi5Uek0UT05RTo//mAJ/cBlbRBgwMyQSfEy3LHg?=
 =?us-ascii?Q?6VOuB5tRXUVP4dYfy7S1yxcGdkHhctu2ePE0QQGXfyylX9psNFabYwxxChU3?=
 =?us-ascii?Q?tK4vinECLSyZT7Fjgz4f1V+iXDlx+hxxgFSy0Rv9BC2inIUm0Bb1UgxnrguU?=
 =?us-ascii?Q?YKEQmGYo1fCzI0i9Nmq4YyCa0G2dT2/yKBOQhN1Yi3y97oUhvlMPu1m7ILsK?=
 =?us-ascii?Q?BySN8OBVRPQ4K/esDdfCaWOdMKH0md2F+o6Sefz1jzOjDJBAk8BIdpUPgCRK?=
 =?us-ascii?Q?CNPv3lb4WldQQ4TR6a37yqYsgFA4QD6kR1CN1HXPzBq+s3yDdRwz+sjsWb+B?=
 =?us-ascii?Q?FuDM+99iFmPwGBxlX8zTaPPYVzOYrX72LvgW0tH0rfxTPyAifKR7wZEsyLjs?=
 =?us-ascii?Q?MIEa1iVAGq+RfFDPw66cRg1m1BOyjTvHCd4HZzMRLgVrF5cv99DSPOtT6hyf?=
 =?us-ascii?Q?78VkzXkqdVoueGHyz9CX0aYem+M94oac+px75bF7jNWF6SVNazitujgv4fA2?=
 =?us-ascii?Q?nozz6Pj8uGh9k5B1E3NxZBVffT3rSBsL13wN+n4bfGUtcXsCnCMESe84dcnf?=
 =?us-ascii?Q?HX6giRL8+QtTL5NTt0DP4mgtLnF2hqC0yiddeSZD1QIdzayoOUjqdST6qEYR?=
 =?us-ascii?Q?ptqgxnlCAUmffWuekEkr5swzqWgsT6MM2XcWOLnt6+e5Hc2uuc32sKTTmAxE?=
 =?us-ascii?Q?8+rAyS8QKTaBS6dLo4AhSP3854s/Y3vF9iHNg1MBusLtUFqIoOYbtGlIsCie?=
 =?us-ascii?Q?I0/SZ7zr4wVkZZMS6vOvErEfCr617sWitRZd0rFRNxZW4BPSlZW3bubCNZns?=
 =?us-ascii?Q?w5CalFdNdAca+2AeRjhPnyriQOCDFDNPn5zbqwo+QvvlccOgEQfQMcf4KUm5?=
 =?us-ascii?Q?BaRmfSNwtZce+MPxObZJgeMQznNs6DgrHwv3alNmc6KoZebsQOQZubETogIZ?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a64217-d418-4caf-cc20-08dce7d4237f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8707.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 20:02:29.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4eNaXNLAhQVs/jApUTi5ltpokDD0LVUba0tQDw9I42lLrWDduuKn4g4bHx2CPRmq0Ls/9uJ2dfYBkQ8rv0pS/CY3YF6E0vuHWT2dXSLWWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9500

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
Changes in v2:
* Update comments
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0..cf41c42399e1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -693,9 +693,9 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		config->cfg |= TRCCONFIGR_TS;
 	}
 
-	/* Only trace contextID when runs in root PID namespace */
+	/* Only trace contextID when the event owner is in root PID namespace */
 	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
-	    task_is_in_init_pid_ns(current))
+	    task_is_in_init_pid_ns(event->owner))
 		/* bit[6], Context ID tracing bit */
 		config->cfg |= TRCCONFIGR_CID;
 
@@ -709,8 +709,8 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			ret = -EINVAL;
 			goto out;
 		}
-		/* Only trace virtual contextID when runs in root PID namespace */
-		if (task_is_in_init_pid_ns(current))
+		/* Only trace virtual contextID when the event owner is in root PID namespace */
+		if (task_is_in_init_pid_ns(event->owner))
 			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
 	}
 
-- 
2.34.1


