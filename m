Return-Path: <stable+bounces-203167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537BCD431A
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 17:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660B83007696
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F82206AC;
	Sun, 21 Dec 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nChQO6YV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J9tSBme2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BE26AC3
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766336267; cv=none; b=m6RLJBYynEwMO45k46fuebOSPfMBavWP6dPdZmUckkg7TfEhUppfamPY81Am9oIG3WVsO9htyQTo81FsKDBpTA5E7D3ssqjMcBvOp+9rsGV5f1qK460UTvalWqnlHqYON+i+DMgCvEtEGjBDogqYJxjNjm8JgZKPLcRvy3lzKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766336267; c=relaxed/simple;
	bh=gtXcanUpV0NFaNGqdgZgrqiwcUkd9mEi2yY0vi3IH9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tM2YtXzJAYUsp0lh/Pxzxg40BBiXRSw3tKVapjnGFPSFLEsIeT6QNdg8iIrMAIr0xkOy5dfMV3Rev+AbQFHvDPNcM8PL/q8IXJD08fBKVF1SXAVtJLidXOMFwtLeqTiIlhXs5UpL/M7zE4gJ5dzzSLvCQf37n12yuiidEIXUdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nChQO6YV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J9tSBme2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKNOBxG992786
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 16:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bN7W8KuZTb2DirG3bJS9nOTczWMfVRtYjIE
	WaxsTlhQ=; b=nChQO6YVdWJ/36aFmgJFoyt2k0fZLABFDaX178In4m2hbQlkGut
	W0o35lFehl7X208DYvazaGVarSrStAgyhsDP+06pyJjp1dNJ50cBkjSMwmTAscS+
	On9ILbLrjf3FGOoWDPq1XDTZg/Auj1ePMjtL+k2gGqtTyBBMO+d5vCn3AfdjPmHw
	FYrVWl/Bf6qMdVd0vMKuMTGbofm0dIIIEM/JiG/TkBjaWac9yIeFy2mbmwIEq/+m
	UO8JuLcLwbB1WaD+GHz+Rg59nwB46d8Pbhgwl1PdXIYlpb3IWRFrpEUGPWSM9u3b
	uMJfc6dmDkdYegLwE0nG7xU1Z6nyp8bABRQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mrtan2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 16:57:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a2f8e7d8dso88884266d6.1
        for <stable@vger.kernel.org>; Sun, 21 Dec 2025 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766336263; x=1766941063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bN7W8KuZTb2DirG3bJS9nOTczWMfVRtYjIEWaxsTlhQ=;
        b=J9tSBme2z4ZGydG1Xfj3f1Pry5hu4Q8mRha33SfwWKPWCk/z1cgjvrS2qWEpfb8Tn1
         Jm6sIHnQ6vJHypghj5r4c92igLr8e2ZgFwze1/xn/BNhfKUXE2v6gjmoiGRWIY2H6CS2
         SLU1wpYepHl1kGvZe9IMjUvn2q8+pjlr2RYtivxQDD3FgAW9ytCbSeboqI8F9C6jDgoe
         JBSMTKI/969qZ4GFAPH3VwW2x24ZvQEA6cffM0SbjHAYefhAeTQcqX26M8NMn3WyJOaL
         rOUM5H0W9S2oQtQDB+qsmr+1F6q5H6MOTtUORzwzCWnBq5wJaKa0KAaGPyKz1jCNKLAe
         jffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766336263; x=1766941063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN7W8KuZTb2DirG3bJS9nOTczWMfVRtYjIEWaxsTlhQ=;
        b=i2Pt7aRFCsmg58d462oFqDqcSpZqQReKodJTdxy05QUqF9S697+DA4o0CR/bUQmsnG
         KiNDqHlUDsBLfqul2bKnYwwxtfSNdyo1tOwbLTPVZqa1qIVi5SOqi4fIIOJhSihBjIoc
         a2zv+kj3f8zDs+P8S7i7PgJfad/VhvHfXzvlJ/Gvq2UpCPQEve4Qa74hBHjzK7EcwW9H
         TRWAethTfvI6tYKLMOS3LjTRnOhhlKUuhwE0HyL0Ik2F444zNTN5VGzQ15UCkYEx00s2
         H1K9LHURf5iivPJpHE0a+P5wnqU1whAoGeiXj4DkMz0ZoWcXPZRcbysVCJrT7gJBVtCn
         /NvA==
X-Forwarded-Encrypted: i=1; AJvYcCWaQINxEp5tjC8juoJfIN3fZmMPGg0ASWrKTfkKEH+8YtEYmTy7mCYErCXBhNUFYSyqqhi1MX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7lF0WusWt6vVXA5LBsVj+Vz2jXtzKZ6xkoj39fJBrLEy8AAw
	GN0MzS9pSlCotw1WaO0AaYdCRHwquYKiYoWBYhertUtTkNiskt5r1DViQWh5mcgduwauaKL7MXI
	duE9MQEmCDoVrrSK4Kg4ybXxRh9XobXJxz9MB5Avt7xvfkzZbS8qAMg0OGvA=
X-Gm-Gg: AY/fxX5QeE3s9uj/evQ8YXokR1GTuRxeynCCSAygoUIU0UZ5YNkU+SoaWfBleMM9vJM
	6kd4yk7dwpnV6Ciwnl4wYThIZMriFrmUmcQnL5Rg7YrkRC4XsQDFceQeED/hS3GRzC1+03GkMVG
	KZSC82sPF/D5FUXk5pk2VI1YK+n1+RyH3iPB826UD+ooOYXhN8/HZGENoDM6UZIpHpWcazQR8nw
	GA6qTxJ9qwBhnOAj6+BDyQW1ze5Uyh7QuPqDll5hhFiYQW9qTwbJ3EtrCtxVHd90dEbTzL/fyIs
	5qatsQjB0rYUxKdv16NpQp4UhRSDEsVSfZ0ZzEUmAKdjjQQ4a9GS7ppBlEGaT+jz0TnnZrZ70yx
	4rsIvQwUMJKSeprb6Zc1RlBYDU/yPqZRYCdjMgAIqrpDGxpc5QdOjCqWZNGQ0SlVTGLfejab59S
	NSdKsxZMUOd4SuEgYQSuQiIiuy
X-Received: by 2002:a05:622a:588e:b0:4f0:24e2:8de6 with SMTP id d75a77b69052e-4f4abd9765emr147790511cf.64.1766336263060;
        Sun, 21 Dec 2025 08:57:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDrLWQigAphc9gZx4ySp95tJ7pg8YC1s9DqWguNVNoGK8HW9bCnd0hfLpMD8fq2gEg1xMSCw==
X-Received: by 2002:a05:622a:588e:b0:4f0:24e2:8de6 with SMTP id d75a77b69052e-4f4abd9765emr147790231cf.64.1766336262551;
        Sun, 21 Dec 2025 08:57:42 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f09149sm807070166b.47.2025.12.21.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 08:57:41 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        stable@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] fbdev: Use device_create_with_groups() to fix sysfs groups registration race
Date: Sun, 21 Dec 2025 17:57:40 +0100
Message-ID: <20251221165740.15821-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0iKMMTu455gcc2ETq8_HEOhoUGQumbSt
X-Proofpoint-GUID: 0iKMMTu455gcc2ETq8_HEOhoUGQumbSt
X-Authority-Analysis: v=2.4 cv=CeEFJbrl c=1 sm=1 tr=0 ts=69482708 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mFxE72mproX8ypq736UA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDE1OSBTYWx0ZWRfXwHTtHj99VIgf
 wGa13s3aDml0eqfdBs+aCU+Hawd5lnaYjrsJmYYMTN8Q9AQOHsXtwgQ0Nbirw9hFhrXeU5YGpQN
 HdDgMsj9NJk1FbwCfqAe5x8Bj0AqpKRzEonXBGQEy9BPyXqo68qHInQq2/zzgx3XJXRd6MQ/lv6
 BYLaCoCOMk7oLDsjPAiCdF8JaCec+kMMivGWIqfUiYGKYmoLM9qr1oLaC5MDLbLYEbFGuNyWNBJ
 Q+L33h3YV9CRk0P/f1LFkVJmNs2iWN72Z4zYi485xPsyKvf/WkQ1chmJrBAKyQiwB4HQzOSzZzU
 VRBTExFU4SGcXdyZwHc4sn+yOiSdkSnePtWQa9emPyqabXCFw+PjqSLCDRYrf/2ghHBy+7Qa4VP
 N+ipNC44wsNmG9SSdvBvyoLb8bHuL73/K8fL9EL5TjfdtsXTPULuJZLioH4hrn7ZLmTtTMwIGDJ
 HIGZk0x5/Zd9/BKqdlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_04,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512210159

The fbdev sysfs attributes are registered after sending the uevent for
the device creation, leaving a race window where e.g. udev rules may
not be able to access the sysfs attributes because the registration is
not done yet.

Fix this by switching to device_create_with_groups(). This also results in
a nice cleanup. After switching to device_create_with_groups() all that
is left of fb_init_device() is setting the drvdata and that can be passed
to device_create[_with_groups]() too. After which fb_init_device() can
be completely removed.

Dropping fb_init_device() + fb_cleanup_device() in turn allows removing
fb_info.class_flag as they were the only user of this field.

Fixes: 5fc830d6aca1 ("fbdev: Register sysfs groups through device_add_group")
Cc: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Note the fixes tag is technically wrong. This race has existed forever.
The commit I picked for the fixes tag is a dependency of this change not
the commit introducing the race. I don't believe that backporting this
back any further is useful which is why I went with this commit.
---
 drivers/video/fbdev/core/fbsysfs.c | 36 +++---------------------------
 include/linux/fb.h                 |  1 -
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index b8344c40073b..baa2bae0fb5b 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -12,8 +12,6 @@
 
 #include "fb_internal.h"
 
-#define FB_SYSFS_FLAG_ATTR 1
-
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
 	int err;
@@ -451,33 +449,7 @@ static struct attribute *fb_device_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group fb_device_attr_group = {
-	.attrs          = fb_device_attrs,
-};
-
-static int fb_init_device(struct fb_info *fb_info)
-{
-	int ret;
-
-	dev_set_drvdata(fb_info->dev, fb_info);
-
-	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
-
-	ret = device_add_group(fb_info->dev, &fb_device_attr_group);
-	if (ret)
-		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
-
-	return 0;
-}
-
-static void fb_cleanup_device(struct fb_info *fb_info)
-{
-	if (fb_info->class_flag & FB_SYSFS_FLAG_ATTR) {
-		device_remove_group(fb_info->dev, &fb_device_attr_group);
-
-		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
-	}
-}
+ATTRIBUTE_GROUPS(fb_device);
 
 int fb_device_create(struct fb_info *fb_info)
 {
@@ -485,14 +457,13 @@ int fb_device_create(struct fb_info *fb_info)
 	dev_t devt = MKDEV(FB_MAJOR, node);
 	int ret;
 
-	fb_info->dev = device_create(fb_class, fb_info->device, devt, NULL, "fb%d", node);
+	fb_info->dev = device_create_with_groups(fb_class, fb_info->device, devt, fb_info,
+						 fb_device_groups, "fb%d", node);
 	if (IS_ERR(fb_info->dev)) {
 		/* Not fatal */
 		ret = PTR_ERR(fb_info->dev);
 		pr_warn("Unable to create device for framebuffer %d; error %d\n", node, ret);
 		fb_info->dev = NULL;
-	} else {
-		fb_init_device(fb_info);
 	}
 
 	return 0;
@@ -505,7 +476,6 @@ void fb_device_destroy(struct fb_info *fb_info)
 	if (!fb_info->dev)
 		return;
 
-	fb_cleanup_device(fb_info);
 	device_destroy(fb_class, devt);
 	fb_info->dev = NULL;
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05cc251035da..c3302d513546 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -497,7 +497,6 @@ struct fb_info {
 #if defined(CONFIG_FB_DEVICE)
 	struct device *dev;		/* This is this fb device */
 #endif
-	int class_flag;                    /* private sysfs flags */
 #ifdef CONFIG_FB_TILEBLITTING
 	struct fb_tile_ops *tileops;    /* Tile Blitting */
 #endif
-- 
2.52.0


