Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB576BF4E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 23:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHAVcN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 17:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHAVcL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 17:32:11 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013006.outbound.protection.outlook.com [52.101.54.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9225BDF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 14:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPq2+W+JvyytMxrQ2fqkQEfjD1nOYRNukb5kJLOE6p029I7I9l35V5x/DMpvIimP4Qwr88hNtBqWfmPG9gU2ZRaOVXCobxck5lBw2SXS4zfht5zeULAH6XhvkXIu42X7g9xOYaxOtX2B6y/1R9QPwgm4fP5oy1F8CCE1pnq9Ltn6HmVk3jlXn5a9doDCgUhv46IcB0f9Glx+EW7bYCMNA8uIsgSkvPUWlDVNbG/PD1vnPs6k+H/OOQjxnjZ6ERnI7/Ub8jFFpwy0FL29em7Vsly4243nTVi9I+pU/189+SRweF5znskcFSrdm9wgcQFDOMS/uAzSba2T/yDHNhe/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se2XXdmAGnsG1AqGsC8sj9J2xe5VvP4IxEq6taXdiLY=;
 b=cKCmhbtFMkeh7cQXqHbRj5Y/2Yk4sO1MdHVi80wsPjbbMR11j5oWrztrvbJmKFwnOzv1nrCKxgtCgBzTSBq2TDv7qR0Ij2/2p2Wr8AaSYOma7X3g1QoJ33ptlfrrv7iZAkMYHxYDvnCBzwW2t/Jefv1DuL+yshNVVbP9VmAY1kFJxj2j/tV2VG0llpvIXYWw4uzE64f5FNhOdxdKHASdqGpZB56sT9mcLZ/QY5MmKEaXkD9A3dTPT6CXxGz+Wdc8P59LZhU13CZeKD2NCQ4HW5rI0yosNNTm4AdUU2sRVfJsDFkbdZcup3SA0R6evfFX+ghkehyLMtfFZ9yB297uBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se2XXdmAGnsG1AqGsC8sj9J2xe5VvP4IxEq6taXdiLY=;
 b=Hd+zBFiLsZek6prjXmqvYafKgfmQ3xe0Kjz/0gtSfhUZsWlRm0IQ+RGtQzxOEd7EjblQn0JGcNjJ5tn5LGmcrYskSDWVbpOZSaNX3xKZJMSIhtzDulRvj/37iNjlgSNzfiyfUod1Rt82secWyC1H3TSa0WLSP79qAUc7pzhObm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB6565.namprd05.prod.outlook.com (2603:10b6:a03:eb::33)
 by IA0PR05MB9395.namprd05.prod.outlook.com (2603:10b6:208:441::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 21:32:04 +0000
Received: from BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129]) by BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129%3]) with mapi id 15.20.6631.035; Tue, 1 Aug 2023
 21:32:04 +0000
From:   Brennan Lamoreaux <blamoreaux@vmware.com>
To:     stable@vger.kernel.org
Cc:     akaher@vmware.com, amakhalov@vmware.com, vsirnapalli@vmware.com,
        ankitja@vmware.com, Brennan Lamoreaux <blamoreaux@vmware.com>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
Date:   Tue,  1 Aug 2023 14:30:44 -0700
Message-Id: <20230801213044.68581-1-blamoreaux@vmware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <86FA1210-9388-4376-B4A3-5F150E33B19F@vmware.com>
References: <86FA1210-9388-4376-B4A3-5F150E33B19F@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:a03:100::16) To BYAPR05MB6565.namprd05.prod.outlook.com
 (2603:10b6:a03:eb::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB6565:EE_|IA0PR05MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c2e951-18e3-4e07-7811-08db92d6bf89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8Mswl8jH7BNF60SiLBvyaWSChpPwG0QS8M2ovKPFmzT9gCNy6oKwqvG5LPQbRFMAQ53jUjJ+zptWmPQ1Vr3cFDETkMEL9+PcdR2paH837m8SWewXqwtT+qaPtFyc8YvYUw71j+8p4PmY12alERr51tgWXu7KtPeFHpuSp90ImhyC8/Mo2SMhFwmNIaJO8ce1otVAC1bd3nN3lOMgLVjdrYJUfIj3281Fa1tyVtKBOmys+9NAc5GSEhGDxJzvJkDIgnuiQypnlZUcroYI4enHe/IIPul2snGOOdiIla/VkSxXqHHymUYdWWQd0h5zwd+SYuV3g3XlbGiQw2Wf52eSRsbIoZGYC9ygUP+zyQ936twimgYz5NrT4PyI4nHHfgAbzT02YNJ3qGjVr6MziC2L6hRZrbx6LZyYf5a3yAIQy2yayvwaPlHZi7iUci9y08qXdPYYScML9lNMv3gmiBV0m6KH1DgGjqvHRFgSJrJLY/qoujVbFHdDg4bDW2Dg7nNoJ3+uxz+pWGw+mJezuCEfpjFIWNE1pxph3HTy1kWOo6yHHO4xNJKsvOTNW8n/W8KJhnYqWMjSsB0z3p0PzFInn1czXa8adkz4Hi4TbIS5gj9Wedto25SwkfUgGvAW0L6/pS++ID7yBzwINqJKH4cIM7ovc1t0RJDiciNYeoojYGAFsi5NCo4QowkqOIP875t4h05TmIif96vLeOC5kxl0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6565.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(6916009)(4326008)(478600001)(52116002)(6666004)(38100700002)(38350700002)(66476007)(66556008)(66946007)(6486002)(54906003)(316002)(966005)(6512007)(83380400001)(41300700001)(86362001)(2906002)(36756003)(30864003)(5660300002)(2616005)(8676002)(8936002)(26005)(1076003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUxvmS+jAgfuclKdzeGu7csECsk9jNYAfeadMB/5FNMUPcGKxklk5BYmO947?=
 =?us-ascii?Q?4gZF6kc2UrzxFuZWLMwl6HcjOVlFuxV6CYPjc8fqbb+SGHiz86i4XOPyRgEx?=
 =?us-ascii?Q?2eSnTSVvteB4cvgrIjCQagS0tA/DG1hn66r46Um5VbVtgBgVdCRR38yH+JLl?=
 =?us-ascii?Q?TOorCLpDF0Qu8DZWJPPbg374z5uHa/PPCvZPC0fbuI2RZriDDgFfrHs0Btf+?=
 =?us-ascii?Q?XeVZSxoMF8y6Mq3UIxCA+KgWdmmGxZ2GY1ATO4hQJUa2nzITFthnxa3iSLLG?=
 =?us-ascii?Q?v+y9zZ0nhcjrv47qRwZpDEwrs6ct3UgTZ4qx/cPAXc8JJxXIykqsNCK5tNia?=
 =?us-ascii?Q?G/5dDxkrC94YprUDPypFwq3/EQUBMn3zBINFDFkXCfjlrXoQTDgjlQI7BQEl?=
 =?us-ascii?Q?SnaH3fHfJ5shAgSxnSVq6EiVRktgl332KhpMuNih7B1E+iyzdhTYxW/MPYER?=
 =?us-ascii?Q?qjKH3rAbu70gMX8hVLIrEqpYfC1pmZYOuW/Xuu5OTjp4Thj9zA5+aAljcgnR?=
 =?us-ascii?Q?O4L9Vllrz0KwnZyk8a+EXBHv5cPl4htOtqcwBG72LUt8+89bnbmBNI4Kn4W/?=
 =?us-ascii?Q?7F21opqlxaUD/xzrUB3di6XEvtTVTBYOJCIG8mGf48JKZceWcDI5nt7IioMc?=
 =?us-ascii?Q?FOjrdib+ViM9Djz7t7XNZcgUyJ2SwiGf3PpsSmuJqjjqF0lQfvG4jA+u816f?=
 =?us-ascii?Q?zNwu22r7Tmtm4DbVPkjxK7y5dfI/ffkLZ9AkgWNnZWFcU3jbv17XXUSl+2ZS?=
 =?us-ascii?Q?xfOLV4lcenmFujECYSfQUcGZzUwuzYCPxs0xTHEkBskQoyaaI4Mc/gHJiGQb?=
 =?us-ascii?Q?pK+pK9RQH4WjqT+mVD8OlEOppEdf4Nq5SPOFT53kY1oeXywhOxqa0bvpAURS?=
 =?us-ascii?Q?/mpzNoPma1vSVJEj0iTIQcJ0WncwmBdX8YEsf+VoaI80hiBlTtJzznSO29Wj?=
 =?us-ascii?Q?aI5RnUEJE+DGXXFxlY0pRwniION+aTbzsIRCdP+lSG5vwG+ZwTdDNSs3tiOS?=
 =?us-ascii?Q?flpwslu2xmZ2pCj4+3RrtouSolBepNv8w1nZl3JQagLQtCtfZpAh2MRlWzzE?=
 =?us-ascii?Q?qP+O2oL5A+Avt1As/FXjpLjJPptnCX1b3GMDUSGKSTP6PBLZQ1Hur5cz06Bu?=
 =?us-ascii?Q?sCDTDhTT38dSwC4nK4tXebQUllkAHZi/8n5OwVtwOfS8c3pp2HgXfiJUtYnl?=
 =?us-ascii?Q?bggCAzW7FOkCmF/tyVjHAqGHynxNnlerwTUAi1CJh7bAwsxZJ8V4ovLAcPcP?=
 =?us-ascii?Q?Uk5Pc9ct24Ff4c2IMgZ/WUKAATPPG8D046aXEIY2988DxymFCuoEunUbiOVC?=
 =?us-ascii?Q?H15tMgyEUTQi8WsnBce67XC9SKA3F019q+OL8gANSuWQtIWe+HqCEPdyGQ+w?=
 =?us-ascii?Q?vzt/yNeWgRvIlZ+q6zQHaRpACzEHaujgFTHIbQagkznvVx2nD2FsCU39nImR?=
 =?us-ascii?Q?7h9Ds5ygWhm2SQZtN72Ynl1RGUZreWOcRKW5UGKRIuCfJDl+5sO/ZDd5nY4/?=
 =?us-ascii?Q?seBsVj1vgwiJzkZNJSk6enoLf+fZmbJzk6tI1+pjYMUE9ZeB+8AgoKFI8Uqd?=
 =?us-ascii?Q?s5pzNbt9AulTNJ5uxZkUCGai35wJik65FJdO8J4b?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c2e951-18e3-4e07-7811-08db92d6bf89
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6565.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 21:32:03.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHX5YZ7uDMO+8JDr7Jo88/PFtge7s2c2je4xDre79KW3Heb+PNYDNDcUlpGcj1t0+SPQ3bYmS/TOl+aD07C42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR05MB9395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Joe Perches <joe@perches.com>

commit aa838896d87af561a33ecefea1caa4c15a68bc47 upstream

Convert the various sprintf fmaily calls in sysfs device show functions
to sysfs_emit and sysfs_emit_at for PAGE_SIZE buffer safety.

Done with:

$ spatch -sp-file sysfs_emit_dev.cocci --in-place --max-width=80 .

And cocci script:

$ cat sysfs_emit_dev.cocci
@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	...
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/r/3d033c33056d88bbe34d4ddb62afd05ee166ab9a.1600285923.git.joe@perches.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Brennan : Regenerated for 4.19 to fix CVE-2022-20166 ]
Signed-off-by: Brennan Lamoreaux <blamoreaux@vmware.com>
---
 drivers/base/arch_topology.c            |  2 +-
 drivers/base/cacheinfo.c                | 18 ++++-----
 drivers/base/core.c                     |  8 ++--
 drivers/base/cpu.c                      | 30 +++++++--------
 drivers/base/firmware_loader/fallback.c |  2 +-
 drivers/base/memory.c                   | 24 ++++++------
 drivers/base/node.c                     |  8 ++--
 drivers/base/platform.c                 |  2 +-
 drivers/base/power/sysfs.c              | 50 ++++++++++++-------------
 drivers/base/soc.c                      |  8 ++--
 10 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..d89f618231cb 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -44,7 +44,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ce015ce2977c..51eb403f89de 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -372,7 +372,7 @@ static ssize_t size_show(struct device *dev,
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%uK\n", this_leaf->size >> 10);
+	return sysfs_emit(buf, "%uK\n", this_leaf->size >> 10);
 }
 
 static ssize_t shared_cpumap_show_func(struct device *dev, bool list, char *buf)
@@ -402,11 +402,11 @@ static ssize_t type_show(struct device *dev,
 
 	switch (this_leaf->type) {
 	case CACHE_TYPE_DATA:
-		return sprintf(buf, "Data\n");
+		return sysfs_emit(buf, "Data\n");
 	case CACHE_TYPE_INST:
-		return sprintf(buf, "Instruction\n");
+		return sysfs_emit(buf, "Instruction\n");
 	case CACHE_TYPE_UNIFIED:
-		return sprintf(buf, "Unified\n");
+		return sysfs_emit(buf, "Unified\n");
 	default:
 		return -EINVAL;
 	}
@@ -420,11 +420,11 @@ static ssize_t allocation_policy_show(struct device *dev,
 	int n = 0;
 
 	if ((ci_attr & CACHE_READ_ALLOCATE) && (ci_attr & CACHE_WRITE_ALLOCATE))
-		n = sprintf(buf, "ReadWriteAllocate\n");
+		n = sysfs_emit(buf, "ReadWriteAllocate\n");
 	else if (ci_attr & CACHE_READ_ALLOCATE)
-		n = sprintf(buf, "ReadAllocate\n");
+		n = sysfs_emit(buf, "ReadAllocate\n");
 	else if (ci_attr & CACHE_WRITE_ALLOCATE)
-		n = sprintf(buf, "WriteAllocate\n");
+		n = sysfs_emit(buf, "WriteAllocate\n");
 	return n;
 }
 
@@ -436,9 +436,9 @@ static ssize_t write_policy_show(struct device *dev,
 	int n = 0;
 
 	if (ci_attr & CACHE_WRITE_THROUGH)
-		n = sprintf(buf, "WriteThrough\n");
+		n = sysfs_emit(buf, "WriteThrough\n");
 	else if (ci_attr & CACHE_WRITE_BACK)
-		n = sprintf(buf, "WriteBack\n");
+		n = sysfs_emit(buf, "WriteBack\n");
 	return n;
 }
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6e380ad9d08a..0332800dffd8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -994,7 +994,7 @@ ssize_t device_show_ulong(struct device *dev,
 			  char *buf)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
+	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
@@ -1019,7 +1019,7 @@ ssize_t device_show_int(struct device *dev,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
@@ -1040,7 +1040,7 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
@@ -1273,7 +1273,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	device_lock(dev);
 	val = !dev->offline;
 	device_unlock(dev);
-	return sprintf(buf, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t online_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 878ed43d8753..7e4a60edce8c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -156,7 +156,7 @@ static ssize_t show_crash_notes(struct device *dev, struct device_attribute *att
 	 * operation should be safe. No locking required.
 	 */
 	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
-	rc = sprintf(buf, "%Lx\n", addr);
+	rc = sysfs_emit(buf, "%Lx\n", addr);
 	return rc;
 }
 static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
@@ -167,7 +167,7 @@ static ssize_t show_crash_notes_size(struct device *dev,
 {
 	ssize_t rc;
 
-	rc = sprintf(buf, "%zu\n", sizeof(note_buf_t));
+	rc = sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
 	return rc;
 }
 static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
@@ -264,7 +264,7 @@ static ssize_t print_cpus_offline(struct device *dev,
 						      nr_cpu_ids, total_cpus-1);
 	}
 
-	n += snprintf(&buf[n], len - n, "\n");
+	n += sysfs_emit(&buf[n], "\n");
 	return n;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
@@ -280,7 +280,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(isolated));
+	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
@@ -294,7 +294,7 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 {
 	int n = 0, len = PAGE_SIZE-2;
 
-	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 
 	return n;
 }
@@ -328,7 +328,7 @@ static ssize_t print_cpu_modalias(struct device *dev,
 	ssize_t n;
 	u32 i;
 
-	n = sprintf(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+	n = sysfs_emit(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
 		    CPU_FEATURE_TYPEVAL);
 
 	for (i = 0; i < MAX_CPU_FEATURES; i++)
@@ -520,56 +520,56 @@ static void __init cpu_dev_register_generic(void)
 ssize_t __weak cpu_show_meltdown(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v1(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_l1tf(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_srbds(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 821e27bda4ca..2116926cc1d5 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -215,7 +215,7 @@ static ssize_t firmware_loading_show(struct device *dev,
 		loading = fw_sysfs_loading(fw_sysfs->fw_priv);
 	mutex_unlock(&fw_lock);
 
-	return sprintf(buf, "%d\n", loading);
+	return sysfs_emit(buf, "%d\n", loading);
 }
 
 /* one pages buffer should be mapped/unmapped only once */
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index e270abc86d46..5dbe00a5c7c1 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -121,7 +121,7 @@ static ssize_t show_mem_start_phys_index(struct device *dev,
 	unsigned long phys_index;
 
 	phys_index = mem->start_section_nr / sections_per_block;
-	return sprintf(buf, "%08lx\n", phys_index);
+	return sysfs_emit(buf, "%08lx\n", phys_index);
 }
 
 /*
@@ -145,7 +145,7 @@ static ssize_t show_mem_removable(struct device *dev,
 	}
 
 out:
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 /*
@@ -163,17 +163,17 @@ static ssize_t show_mem_state(struct device *dev,
 	 */
 	switch (mem->state) {
 	case MEM_ONLINE:
-		len = sprintf(buf, "online\n");
+		len = sysfs_emit(buf, "online\n");
 		break;
 	case MEM_OFFLINE:
-		len = sprintf(buf, "offline\n");
+		len = sysfs_emit(buf, "offline\n");
 		break;
 	case MEM_GOING_OFFLINE:
-		len = sprintf(buf, "going-offline\n");
+		len = sysfs_emit(buf, "going-offline\n");
 		break;
 	default:
-		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
-				mem->state);
+		len = sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n",
+				 mem->state);
 		WARN_ON(1);
 		break;
 	}
@@ -384,7 +384,7 @@ static ssize_t show_phys_device(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	return sprintf(buf, "%d\n", mem->phys_device);
+	return sysfs_emit(buf, "%d\n", mem->phys_device);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -422,7 +422,7 @@ static ssize_t show_valid_zones(struct device *dev,
 		 */
 		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
 					  &valid_start_pfn, &valid_end_pfn))
-			return sprintf(buf, "none\n");
+			return sysfs_emit(buf, "none\n");
 		start_pfn = valid_start_pfn;
 		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
 		goto out;
@@ -456,7 +456,7 @@ static ssize_t
 print_block_size(struct device *dev, struct device_attribute *attr,
 		 char *buf)
 {
-	return sprintf(buf, "%lx\n", get_memory_block_size());
+	return sysfs_emit(buf, "%lx\n", get_memory_block_size());
 }
 
 static DEVICE_ATTR(block_size_bytes, 0444, print_block_size, NULL);
@@ -470,9 +470,9 @@ show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	if (memhp_auto_online)
-		return sprintf(buf, "online\n");
+		return sysfs_emit(buf, "online\n");
 	else
-		return sprintf(buf, "offline\n");
+		return sysfs_emit(buf, "offline\n");
 }
 
 static ssize_t
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 60c2e32f9f61..aaff37510664 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -69,7 +69,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 	struct sysinfo i;
 
 	si_meminfo_node(&i, nid);
-	n = sprintf(buf,
+	n = sysfs_emit(buf,
 		       "Node %d MemTotal:       %8lu kB\n"
 		       "Node %d MemFree:        %8lu kB\n"
 		       "Node %d MemUsed:        %8lu kB\n"
@@ -96,7 +96,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(sum_zone_node_page_state(nid, NR_MLOCK)));
 
 #ifdef CONFIG_HIGHMEM
-	n += sprintf(buf + n,
+	n += sysfs_emit(buf + n,
 		       "Node %d HighTotal:      %8lu kB\n"
 		       "Node %d HighFree:       %8lu kB\n"
 		       "Node %d LowTotal:       %8lu kB\n"
@@ -106,7 +106,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh));
 #endif
-	n += sprintf(buf + n,
+	n += sysfs_emit(buf + n,
 		       "Node %d Dirty:          %8lu kB\n"
 		       "Node %d Writeback:      %8lu kB\n"
 		       "Node %d FilePages:      %8lu kB\n"
@@ -612,7 +612,7 @@ static ssize_t print_nodes_state(enum node_states state, char *buf)
 {
 	int n;
 
-	n = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
+	n = sysfs_emit(buf, "%*pbl",
 		      nodemask_pr_args(&node_states[state]));
 	buf[n++] = '\n';
 	buf[n] = '\0';
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2f89e618b142..1819da6889a7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -927,7 +927,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = sprintf(buf, "%s\n", pdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738ce796..c61b50aa1d81 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -101,7 +101,7 @@ static const char ctrl_on[] = "on";
 static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
@@ -127,7 +127,7 @@ static ssize_t runtime_active_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	ret = sysfs_emit(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -140,7 +140,7 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n",
+	ret = sysfs_emit(buf, "%i\n",
 		jiffies_to_msecs(dev->power.suspended_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
@@ -175,7 +175,7 @@ static ssize_t runtime_status_show(struct device *dev,
 			return -EIO;
 		}
 	}
-	return sprintf(buf, p);
+	return sysfs_emit(buf, p);
 }
 
 static DEVICE_ATTR_RO(runtime_status);
@@ -185,7 +185,7 @@ static ssize_t autosuspend_delay_ms_show(struct device *dev,
 {
 	if (!dev->power.use_autosuspend)
 		return -EIO;
-	return sprintf(buf, "%d\n", dev->power.autosuspend_delay);
+	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay);
 }
 
 static ssize_t autosuspend_delay_ms_store(struct device *dev,
@@ -214,11 +214,11 @@ static ssize_t pm_qos_resume_latency_us_show(struct device *dev,
 	s32 value = dev_pm_qos_requested_resume_latency(dev);
 
 	if (value == 0)
-		return sprintf(buf, "n/a\n");
+		return sysfs_emit(buf, "n/a\n");
 	if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
 		value = 0;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
@@ -258,11 +258,11 @@ static ssize_t pm_qos_latency_tolerance_us_show(struct device *dev,
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
 	if (value < 0)
-		return sprintf(buf, "auto\n");
+		return sysfs_emit(buf, "auto\n");
 	if (value == PM_QOS_LATENCY_ANY)
-		return sprintf(buf, "any\n");
+		return sysfs_emit(buf, "any\n");
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_latency_tolerance_us_store(struct device *dev,
@@ -294,8 +294,8 @@ static ssize_t pm_qos_no_power_off_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					& PM_QOS_FLAG_NO_POWER_OFF));
+	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					  & PM_QOS_FLAG_NO_POWER_OFF));
 }
 
 static ssize_t pm_qos_no_power_off_store(struct device *dev,
@@ -323,9 +323,9 @@ static const char _disabled[] = "disabled";
 static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%s\n", device_can_wakeup(dev)
-		? (device_may_wakeup(dev) ? _enabled : _disabled)
-		: "");
+	return sysfs_emit(buf, "%s\n", device_can_wakeup(dev)
+			  ? (device_may_wakeup(dev) ? _enabled : _disabled)
+			  : "");
 }
 
 static ssize_t wakeup_store(struct device *dev, struct device_attribute *attr,
@@ -511,7 +511,7 @@ static DEVICE_ATTR_RO(wakeup_prevent_sleep_time_ms);
 static ssize_t runtime_usage_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
+	return sysfs_emit(buf, "%d\n", atomic_read(&dev->power.usage_count));
 }
 static DEVICE_ATTR_RO(runtime_usage);
 
@@ -519,8 +519,8 @@ static ssize_t runtime_active_kids_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%d\n", dev->power.ignore_children ?
-		0 : atomic_read(&dev->power.child_count));
+	return sysfs_emit(buf, "%d\n", dev->power.ignore_children ?
+			  0 : atomic_read(&dev->power.child_count));
 }
 static DEVICE_ATTR_RO(runtime_active_kids);
 
@@ -528,12 +528,12 @@ static ssize_t runtime_enabled_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
-		return sprintf(buf, "disabled & forbidden\n");
+		return sysfs_emit(buf, "disabled & forbidden\n");
 	if (dev->power.disable_depth)
-		return sprintf(buf, "disabled\n");
+		return sysfs_emit(buf, "disabled\n");
 	if (dev->power.runtime_auto == false)
-		return sprintf(buf, "forbidden\n");
-	return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "forbidden\n");
+	return sysfs_emit(buf, "enabled\n");
 }
 static DEVICE_ATTR_RO(runtime_enabled);
 
@@ -541,9 +541,9 @@ static DEVICE_ATTR_RO(runtime_enabled);
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	return sprintf(buf, "%s\n",
-			device_async_suspend_enabled(dev) ?
-				_enabled : _disabled);
+	return sysfs_emit(buf, "%s\n",
+			  device_async_suspend_enabled(dev) ?
+			  _enabled : _disabled);
 }
 
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 7e91894a380b..23bc9eb794a2 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -72,13 +72,13 @@ static ssize_t soc_info_get(struct device *dev,
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
 	if (attr == &dev_attr_machine)
-		return sprintf(buf, "%s\n", soc_dev->attr->machine);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->machine);
 	if (attr == &dev_attr_family)
-		return sprintf(buf, "%s\n", soc_dev->attr->family);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
-		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->revision);
 	if (attr == &dev_attr_soc_id)
-		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->soc_id);
 
 	return -EINVAL;
 
-- 
2.39.0

