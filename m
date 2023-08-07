Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA0772BF9
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHGRDs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHGRDq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 13:03:46 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0A10D4
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 10:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIWbUzzUeYG58wFFNEEAsdie6XIogTSaO54RwgH4kZLE607vFDU5+63i4sfTmFjH1lrXn/V32a8AdVLqZcsZ85H4LMNfdQVpv3BMpUA1qsxt6ozZ/rMxI4ws+/rtXBxkGom+SCsRWdxMNmC9NGSu5Urfybm1sgD6+mgx4WGOQqDImNMQcbWUE1b5By1CQPNFYdCmHW29DnNCl/pp0hXoxuN1ubYUFhg7kXWndF37juEYOLI4/37SKXfZWm2S/TmI2q5vgIJWisHVL1rBUQAvGHDp/vBw+Sd6DOr1zqKJ3HMzk7URczCdsPk0CoJmE/A+SAPIdPPVQDSiPuzleBDPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooIa6bVIQ4w44ZRbvz+0W2mnjZHeWx/59ig2tz+SJ+w=;
 b=LNUOruh35ScSd4iN5d0CMEAw1nhscsmbDC6z776TX/1hDn2J9+NMMMJ4v/w79/sX8VSMmW7BYjbg6iyV/kZqIUxTQqdgUCHP8EB5BTf39ORR7U6WMN0Eo125VTJErXbyjrdT6SBtdOjRFRAplFW2wWHaYkTstBrwAWYUfD+pwUPd120BaoU3EvjWBPlYIDKSmMwdFuvK6vK/u4vMV9vLRYduolU+WD3lc3zIEvGh5ZATfqu1pC32OGl/YBzLb4EZnu7Co/LdfWuQJigatwIBimjidGHyDATx74I7ZhJdbd8Jhq7LlYuMO7DGpSHWINRd+59c8ZMbe34VUQmMogOvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooIa6bVIQ4w44ZRbvz+0W2mnjZHeWx/59ig2tz+SJ+w=;
 b=o8Fs0Bx+CP26KWGsBLL8UE5M3+6VOS/uVBi17q79KxDbhqW5vbwew0qcBjbQFAQtmu/IgP0zxiBHR0ZLYuOfc0k8nW24daFP9ynPaOdCGTNc5t3ieYnM/B16KpVZFPPmrTPfv5qPYMRyu1uJ1TPQR4v8O9VZmQmy85m+Klm+mcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB6565.namprd05.prod.outlook.com (2603:10b6:a03:eb::33)
 by CO6PR05MB7796.namprd05.prod.outlook.com (2603:10b6:5:340::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 17:03:40 +0000
Received: from BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129]) by BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 17:03:40 +0000
From:   Brennan Lamoreaux <blamoreaux@vmware.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     amakhalov@vmware.com, vsirnapalli@vmware.com, akaher@vmware.com,
        ankitja@vmware.com, Brennan Lamoreaux <blamoreaux@vmware.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
Date:   Mon,  7 Aug 2023 10:02:42 -0700
Message-Id: <20230807170242.82203-1-blamoreaux@vmware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8A065896-FA1C-4868-AEA1-698166232149@vmware.com>
References: <8A065896-FA1C-4868-AEA1-698166232149@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To BYAPR05MB6565.namprd05.prod.outlook.com
 (2603:10b6:a03:eb::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB6565:EE_|CO6PR05MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: e64591b3-e0a4-4789-aefa-08db97683f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2Q5Ji8cX0GzZ/M2phWiHF1wUy5CU2FFtHhEj8AluA39Pnz7uZ9bHbwp7RTJriVMrpPcIQcNYpaAbr3IK8Sh76EyGsDXbL8P++k8WCKZZldMHRkY8y12g5QxCNM5VZKQ8aDW+w7kNfsCv4daJtfrUtmgQZB/2xqsC7nqLz6/1b8w+R3JNM3Ztqy/M7lFx3Eqi3c6sZOCkb70aSiR84E7IPYKggPs2a0I+boO4WIPkrQv6glpeKJgvMRXhx2l4hCEz0udQUN6X62wc3xtfEoJCYlDFe1N1KzyNGrlD6G+uAxaCNui0n8agS8q58cUmpqVHLSHOTizFHMCWVdhnEZdolU7Rwe2DRgnhLmAy7gX1nlN9zQftVkacufxvTES41vqozFfC3tehIrO1zP6T0lgjBRbweFIYmwaEjfSAU4axtgnPSJd2q+DAZViPf9L6wzHxqkVYFd+ykIpZ3oj0m3oGNxuoJ0d/vu9iVYr/xdEB7YhDe5pKCkQ68DiCs+4sAQj5bMj8QdceRLrOxaB2ozc/riIHUG6YOkeZsKi5XDY7fZQ/7Dd4gKmsGlEmWPE8OWp3ldEMVuM4EeECnE9codv+Cm3GMvTqiSIht3g8olv1wpwMafzU8Vx+TLb4967hhDwMn1GmeJq4yV9rAB42kYw3obzbtgMgID4SyyxR+XZQz0aKkw29huUKru5UbexOS0LZQECOqZgZdXx5TrrD0OBog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6565.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(186006)(1800799003)(5660300002)(8936002)(8676002)(30864003)(316002)(41300700001)(2906002)(6512007)(966005)(2616005)(52116002)(6486002)(6506007)(1076003)(26005)(4326008)(66946007)(66556008)(66476007)(54906003)(478600001)(83380400001)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/tPFZ5h+gsdOvD5ydGd7JFlcOjwACgByMsNwMsac2ACRUx9H1skkcQQN1dr?=
 =?us-ascii?Q?Dz/Opq7FxuDb47RXvpgt361X+lGDQ2+DuaCz95fHJI3t1lpk7mqnP1QlGnSO?=
 =?us-ascii?Q?xyIQsoFQoPl8y1MA3abyeSFBV9G+6zHMQgbYzBWiBbpLdP/hh/VzojVkSS1q?=
 =?us-ascii?Q?X2AfJWYS8xnDISw0VOIpwkTuAJGEUJTzIT+wBhY5XzJfz8dGsfRZ2tZ9YXGv?=
 =?us-ascii?Q?JZcWrTK1sdRxa5m44zwmNGGII25afaeu8eNekg4gemsRwLAr8I+A8SakzeOA?=
 =?us-ascii?Q?Q2mK1hNNvuT5oSvUOzAPzTsmvkwK0cPUTmbqWVvdCrwu1vo8IDN/FW8xVHWk?=
 =?us-ascii?Q?FhBGbBMBuo9ZuzgyJfgVPbB2V+35j7SPfcHBNfq/ERuZrECALs3ZwATxGIBI?=
 =?us-ascii?Q?0jYMiV2f1Ca06ZBcVfKS7ygTzI+gKCbZ6/WhD8iJSwplmIN/c+t5MAq9Qr3N?=
 =?us-ascii?Q?WKu6HTzvcQOQb1yi8eVNzVU40YKkx/rrYVTGZcOudey3l2/YxtXkxpYxnxFf?=
 =?us-ascii?Q?D4ui0dxhcp2E+x24kVb1L+FMWT+D0Dru8wqz/uw3NKBjlpCyJFQ/eQ2Ck0dM?=
 =?us-ascii?Q?nehNxFhnUP2VptQ5ITwakTsslsT8pSOr0HSkYo/s1H95s6Rz+nv8uHpRS7g/?=
 =?us-ascii?Q?FDEF0Uyn5MeBcaBw48gmHbHk4IUPCjxQfIIMsvDy9fU5obQb6zBqwCkTP9ay?=
 =?us-ascii?Q?s3SUqBzn8pIGK/U9ivn5G+TjAHzp+yb5PxhpnEzrS7lvnjVm/j/JPMbRonOf?=
 =?us-ascii?Q?MhXIjbh9Ib/ZYQw/kSOcw988f79FCCR5AsbNJe6MfbwFugDLNgaymD39jibu?=
 =?us-ascii?Q?rDp9r/DDTMEvboNG0XtxOSiR/0008q6TVawUooqyL+r7e7Ad34StHNLIkkZR?=
 =?us-ascii?Q?TmQyXpYSJkY8nU2IIP2Hl9mHIWQ31K9Hd8zppz95Zp6aU/6rcKwJv9itffVO?=
 =?us-ascii?Q?uR7BTjE58Oaorz3cqCFOdHuE7AHuOdAaGlWpDJ9IW/QR1L8qo07TkLMZL/Ej?=
 =?us-ascii?Q?iCu6RfZ5mrBG4PyQTuUG5RBeAmf69uUVEvYKuHMH8HaskH6kCEcF2+MEfXR0?=
 =?us-ascii?Q?oLQOjxoBxivF3+LtueRCBZcyPEwHYlDlmLmiLaJwYp3wCcP0o0X+bF1TNiKq?=
 =?us-ascii?Q?+KdHZK2/If6ZYtrcTsTt1DsEkomRcuOAS7sYe+pRjZUiOZGNJ+3qMArNWD2J?=
 =?us-ascii?Q?nV45uGKSJzLF1gD9LbbSzN3SVTkZ15YLWqIcjErX77WZrD4Kh0TdmZNkRe31?=
 =?us-ascii?Q?kB/RYVmxQP3KUjg+mWJ4i4JFpKRcXmfiasI6iGtuyfrEgYv1pp7ShT7mAsHh?=
 =?us-ascii?Q?lGdyVkN6uPF0QhSwHV8cY30rWBtv92mpVWirLA2rt5akYZaVHB7NbMB/ju2G?=
 =?us-ascii?Q?4V8udmcL6PnhCOU0jKYo4pUDQYl488GjkflK6sH5xjY04BhLXJKSeEgtSx1Z?=
 =?us-ascii?Q?INLoux0lSiFa7eKQTRTBREAkxHke93WzXFmSs0v1j7I7wf7OY+A7jQZhiCx0?=
 =?us-ascii?Q?N9ZiIPk0pFivWHXSElM50v2wGnmF3YZyYrUweltcWWXGGYEfYnXSR+OYgbCs?=
 =?us-ascii?Q?Ra2nhaBZJ0N7ETJs0XvYxny6nJQ4+Dy7GiH1f9k/?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64591b3-e0a4-4789-aefa-08db97683f61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6565.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 17:03:40.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkYPmDdpPvS00br68NuSc/Lk5ZjPKLohvYDM4MSaCDBn+wTVVCTJokB2s8J9Df5UQqmRgGVvTxZ16m9oZlWG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/base/cpu.c                      | 34 ++++++++---------
 drivers/base/firmware_loader/fallback.c |  2 +-
 drivers/base/memory.c                   | 24 ++++++------
 drivers/base/node.c                     | 34 ++++++++---------
 drivers/base/platform.c                 |  2 +-
 drivers/base/power/sysfs.c              | 50 ++++++++++++-------------
 drivers/base/soc.c                      |  8 ++--
 10 files changed, 91 insertions(+), 91 deletions(-)

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
index 878ed43d8753..b19a92604005 100644
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
@@ -272,7 +272,7 @@ static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
+	int n = 0;
 	cpumask_var_t isolated;
 
 	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
@@ -280,7 +280,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(isolated));
+	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
@@ -292,9 +292,9 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
+	int n = 0;
 
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
index 60c2e32f9f61..8defeace001e 100644
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
@@ -162,19 +162,19 @@ static DEVICE_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf,
-		       "numa_hit %lu\n"
-		       "numa_miss %lu\n"
-		       "numa_foreign %lu\n"
-		       "interleave_hit %lu\n"
-		       "local_node %lu\n"
-		       "other_node %lu\n",
-		       sum_zone_numa_state(dev->id, NUMA_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_MISS),
-		       sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-		       sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_LOCAL),
-		       sum_zone_numa_state(dev->id, NUMA_OTHER));
+	return sysfs_emit(buf,
+			  "numa_hit %lu\n"
+			  "numa_miss %lu\n"
+			  "numa_foreign %lu\n"
+			  "interleave_hit %lu\n"
+			  "local_node %lu\n"
+			  "other_node %lu\n",
+			  sum_zone_numa_state(dev->id, NUMA_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_MISS),
+			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
+			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
+			  sum_zone_numa_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
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

