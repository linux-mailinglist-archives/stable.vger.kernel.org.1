Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00076BE29
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjHATzV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHATzV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 15:55:21 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011001.outbound.protection.outlook.com [40.93.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CD2102
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 12:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVNI2WlUIDqEqBg3q/EbSaalWSt6efoy3NyB+CN0I033qN72ZTUIAAg8gLMjPcJbuUwm29usUkr4InSDaRrVCPwVAGWtp586AXh1kfSKkLoKDuHChpLVNlJVHrxDOtcIJAl7PNrwg+9kM76ttTQ5cMmvu5P/Kbvsr+vvlGnc+UmHFYYTPXBMhK/Ul0+y08gI3K8dlZaSiyp+nLSseHS9LyBWiBbJ+7bEnZBrmkK5ANqV+4VdLCS/8F74NzYbnxfa8QuviAvhGMNq4suG8LiYzZqim76eQUv6IauGc7ybGRVAa3bWbOXe03p5HiZ4WjXHbsaEZmnRuyPq7iQBGUhvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OWRbG4R5qEOU4/NhOHGCBVodXouJUEimZGi2DWUelM=;
 b=H+Lia0gUayZbHA9l6bQQgRkxUUJFKKvTeH+LdDlL0j9CcwM2wMJhPnueJDF80WRnAgHy9GpoqqCE3QNsLNRyRgviMSTADlF3CNNuK84bF1Ti/5D2/asxWzAOJa5q1S9cCwrni9PVvq4D6JFTyhlTiWBCesE0JAcF/lDJtjYryOl643xgIGtbmgCoPpJGuP4l+I1+F0FyvsTCVd4HnmYI0DPV7psFo/owXx9otFx2DkDU3dyobS8lcEPwmHcoRh7eENgmZeqrpPISHB4iYYh4wH5+IGhRMQfq2pKYEy0QUIDtzIMdvVzIxXxhSFupH5dr2ZpGFgvOSIMko+B70+xoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OWRbG4R5qEOU4/NhOHGCBVodXouJUEimZGi2DWUelM=;
 b=LuOYYGnz/5dp12R15b2aBwINk5qFnN7ZetjgI1O/4Zo92EuEug/AHHhqUAu321SUcGhCX/XXu8sJY8OPL38JYz4Iysw09S5xjwcbzO3BTgLsUcJqdwc9u80UxhozOhuai1B/fD9tvsHI7q5/l/UOj1eugmkBfD410heye1RoIlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB6565.namprd05.prod.outlook.com (2603:10b6:a03:eb::33)
 by SA3PR05MB10420.namprd05.prod.outlook.com (2603:10b6:806:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 19:55:14 +0000
Received: from BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129]) by BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129%3]) with mapi id 15.20.6631.035; Tue, 1 Aug 2023
 19:55:14 +0000
From:   Brennan Lamoreaux <blamoreaux@vmware.com>
To:     stable@vger.kernel.org
Cc:     akaher@vmware.com, amakhalov@vmware.com, vsirnapalli@vmware.com,
        ankitja@vmware.com, Brennan Lamoreaux <blamoreaux@vmware.com>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
Date:   Tue,  1 Aug 2023 12:52:38 -0700
Message-Id: <20230801195238.68158-1-blamoreaux@vmware.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To BYAPR05MB6565.namprd05.prod.outlook.com
 (2603:10b6:a03:eb::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB6565:EE_|SA3PR05MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: 03641d39-d3dd-4edf-f9f6-08db92c93892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: io/w5+8CxaqMsHap9pjX8hFt5Tuz+j0IyOB3QR3KgVM4rBQg07D1HPLvzpXfxTGKzo9vACRIkxgA4TJHcvQmHqCGc0Tw065kk1pqY1fCLFzWERpKuSeIbB3DvWPW1KSgzaGSlMG0etAJZUEI9AHNgO+9Ih3h3/l2S+SKFy8epDRJnIp3pi4qjYZPUZLPIZHlXUaokEvpasaN7TUXgAhPjf0+Gz+y/KadLXwfSEX88VmcTS11Xb8E7ohkUUUmZkJkgj2h14NKogUJuTn0BK76H8ciHeYuupWEYnPNtgxPH2RyTmS2MzQZNaTvrJKzheYU1SvUF2l2IvlQIrJEVt4EiXo6YRysBeaMxkh4fTEQQIhdCsoI6bP0b7Hd0eJ7an8kGHFx3q0RZZsMNohRQIBEwS3AU2ChlHYTHUXuxnyZrbDLgrwEbkEg0N+1CrNzwva6tzxD8G40xJEB1KAo1x9AiK0hch5nFmdB/3hJbYQy6YpAPwRDfcvkkkwxzqBVvh8Zfjsr0AD+dpkeYSWECF1diB4P1/XkoNEFxCbUJ5LpPzM6Yliab7bmiDvT2/IKU/NTJGEutEKs1c4KXqyGLpWzLbUFSV1CsnXw6fN//CTWTA2OWvH51GomD4azvK0FduKMW32EUSzXosTuxenUCXL3gIj7BLJe1k5RdDTBZ9uHSiIrQLjGjpwd2S1Wy2ip6KWJ5ZIA1LdSB97rOjygrwd7xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6565.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(6506007)(1076003)(26005)(38350700002)(38100700002)(186003)(2616005)(83380400001)(2906002)(36756003)(30864003)(5660300002)(8676002)(478600001)(8936002)(86362001)(6666004)(54906003)(966005)(6512007)(52116002)(6486002)(41300700001)(316002)(4326008)(66946007)(6916009)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8uZBL+Nj9HIimRY6dTXZ/upaNWtgKWbtbc1/6wf12AVNQ3KYf19CxiDDTwgU?=
 =?us-ascii?Q?e14JONLLUspNkclLQxwLi9Ad4XUszceWnXS8RhMwXFArywobEC+bxW/PWKWe?=
 =?us-ascii?Q?zfspWCYLhYVcT4FIKAxsx3Rx/rJhfxTSt7UFyYmE8xs4ZP7BCdComb4Vl7PT?=
 =?us-ascii?Q?kOMFVRW7XQjYOmzCmlAm9QVucQAK6YpHEE8d+kDIMPMlwjtLO8Kdd5N1vKd5?=
 =?us-ascii?Q?Vtn+wnE1RZnr3IOUJHQanyE13O/7ECUeuRW2ZDEWNNSxii11SesVSW1J14pi?=
 =?us-ascii?Q?CNQwX14D7wM5WZULzdS17Cn2ydfGTNSaN91n47gfyM4p2+w1i9wlrmVWcTU8?=
 =?us-ascii?Q?+GaX7Pnh6Bljnys205pvwq6svgNpPh9tVbvtcb+QVXAXoLDJ+8dcgzVgzvkQ?=
 =?us-ascii?Q?WAK/TfSXo8KLRwRe+zBNnAnyz7Siy0VdNZ0GtkZiJIWdkYDlrgSE3pSYI098?=
 =?us-ascii?Q?M/G+KAogWLp+NvkSY3GuAbhEL9+angKRtQfnvjECrqN5zonftVnPMtmSQOnB?=
 =?us-ascii?Q?pcL9UjTzuR6c3CE06FqalxV6gKnLn5DftJ71HsMb+d2tOTW3TbeHMqMYR+MV?=
 =?us-ascii?Q?WYYyRUFrQo4/LNu2rlozBD+DVHkwjHkV1z+HZVQ3+TbcjmzrRvCTFS9hC2m5?=
 =?us-ascii?Q?iRLoKp4hh2CQaesna7TY5yEuJ7+rVKDZv+53QO5g1tZw1Z6m2A3y6ugcQg4A?=
 =?us-ascii?Q?Z2WH/Z3HIDiAxoZOouXFKrOI9LFU5Z7JGNDzY8MOuFQkFGqNM9BWXa+Ha/Ps?=
 =?us-ascii?Q?Kp7IZeB5x0zFSpKjinEiYJj/h0iwstGLdA/X/yDDi20uiQ5JTiyTCns+5bnJ?=
 =?us-ascii?Q?L6y+zBpcEbIYS8qI2HDRRQ4JR2CHl8JehRwzSgfRv0QFl9tF+poXXtN+7PSU?=
 =?us-ascii?Q?hoMkZsPtGRHAEH8kHurSAeo/Xu2/OV6QZETOFSLktU6QjbaeozvdUkLvIOH0?=
 =?us-ascii?Q?eK72N2Tnc7h4dC//zJojPN+EiJbwZLwS9lCeHCh+v5y19I56BN/40svLO9jW?=
 =?us-ascii?Q?k56VrGXjic2rYweS0lwzM38/MXY5VRWnjBJX0HfS+9bZU9CsEjkHcrKjwb7p?=
 =?us-ascii?Q?3B7nYGYe7F5uf7O0bq8LMO0zIhYgx/3z3zsjtkQMOa5HLEjs78r2T4yMUZtt?=
 =?us-ascii?Q?fTtkKjsUbzZu8a9ATxBWrh25YgVazfI41uEDIN9GAf6ttr4Dmgm45aTDKrGQ?=
 =?us-ascii?Q?erMpvrVYKu2m1270WRtunnzp0OW7bHDCYpMWuwLOHQFdHpHMTe2MFAW5xgW6?=
 =?us-ascii?Q?RYQxDrQq3+olPmwYa4G8eJMzuBL9Tu5HcdDO0OK4vuUN/qZXv/9HFUdGgdjA?=
 =?us-ascii?Q?/wLrm9wxpen8Zg9NvsuG2uPGhIOv5ckN+/i/3zlRFJQI6Q+Pusxkr3hDMN3p?=
 =?us-ascii?Q?ZhfLxXkDr06ZVq8yPqbo7qF1K/lGHKhvVi8ymPR47l6wv9Q1gz9brSjlS2F/?=
 =?us-ascii?Q?Ql2njpZtKUoBRz9lTk3WFHf0BKK0JchGI2sycbKlQQvlXqD7S/+XYuy7odJ6?=
 =?us-ascii?Q?7Oo6wy5N5VVRvbX488Ab2T0rhQnQ+Eqnzsc/95Zzt9drM56xEpkYfZJPAAXb?=
 =?us-ascii?Q?cSd3l4SUZabJqSzeNxkxkxFtlKt6ylZInpkNjfqE?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03641d39-d3dd-4edf-f9f6-08db92c93892
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6565.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 19:55:14.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmdL8sj//5BfSZwO2XbCWlp5vcGBBHmh8AcBKEY+VO44T6MZnqfJSqflcUr6+e+HpLezrW1M9wUQAsYMZmqTOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB10420
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
 drivers/base/cpu.c                      | 32 ++++++++--------
 drivers/base/firmware_loader/fallback.c |  2 +-
 drivers/base/memory.c                   | 24 ++++++------
 drivers/base/node.c                     | 10 ++---
 drivers/base/platform.c                 |  2 +-
 drivers/base/power/sysfs.c              | 50 ++++++++++++-------------
 drivers/base/soc.c                      |  8 ++--
 10 files changed, 78 insertions(+), 78 deletions(-)

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
index 878ed43d8753..849bcb1e9164 100644
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
@@ -260,11 +260,11 @@ static ssize_t print_cpus_offline(struct device *dev,
 		if (nr_cpu_ids == total_cpus-1)
 			n += snprintf(&buf[n], len - n, "%u", nr_cpu_ids);
 		else
-			n += snprintf(&buf[n], len - n, "%u-%d",
+			n += snprintf(&buf[n], len - n, "%u-%d",
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
index 60c2e32f9f61..23c028588268 100644
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
@@ -187,7 +187,7 @@ static ssize_t node_read_vmstat(struct device *dev,
 	int n = 0;
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n", vmstat_text[i],
+		 n += sprintf(buf+n, "%s %lu\n", vmstat_text[i],
 			     sum_zone_node_page_state(nid, i));
 
 #ifdef CONFIG_NUMA
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
2.34.1
