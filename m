Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46C6FAA81
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjEHLDY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjEHLCs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB22DD64
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06BB62A4C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98FBC433EF;
        Mon,  8 May 2023 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543726;
        bh=YBxukJGR+Z4MZDQL9OT/ARigY31GV56WL3MOaLKqHRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7hDEzFJsNrnE2kuzDd8tHtcs5OvOn5XKnTtZuFDkblHmMbkInX3AZJkgD8Yq6SOk
         sx2kM+Pq+UYt+GdVtrJCwocoOSt/Nh/oBpVydayVOF1Lo40hJJAUifEzRlENlea8Ue
         mowNfN94jK4Ope6Ufb5m2FCmpKuw62H9PamvEwpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 150/694] accel/ivpu: PM: remove broken ivpu_dbg() statements
Date:   Mon,  8 May 2023 11:39:45 +0200
Message-Id: <20230508094437.307414643@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 17ab1ea679be48d905559d968a7622f5f212de6e ]

When CONFIG_PM is disabled, the driver fails to build:

drivers/accel/ivpu/ivpu_pm.c: In function 'ivpu_rpm_get':
drivers/accel/ivpu/ivpu_pm.c:240:84: error: 'struct dev_pm_info' has no member named 'usage_count'
  240 |         ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
      |                                                                                    ^
include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
  223 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
  249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
  272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
      |         ^~~~~~~~~~~~~~~~~~
include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
  155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~
drivers/accel/ivpu/ivpu_drv.h:65:17: note: in expansion of macro 'dev_dbg'
   65 |                 dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);          \
      |                 ^~~~~~~
drivers/accel/ivpu/ivpu_pm.c:240:9: note: in expansion of macro 'ivpu_dbg'
  240 |         ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
      |         ^~~~~~~~

It would be possible to rework these statements to only conditionally print
the reference counter, or to make the driver depend on CONFIG_PM, but my
impression is that these are not actually needed at all if the driver generally
works, or they could be put back when required. Just remove all four of these
to make the driver build in all configurations.

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230126163804.3648051-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_pm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index bde42d6383da6..aa4d56dc52b39 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -239,8 +239,6 @@ int ivpu_rpm_get(struct ivpu_device *vdev)
 {
 	int ret;
 
-	ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
-
 	ret = pm_runtime_resume_and_get(vdev->drm.dev);
 	if (!drm_WARN_ON(&vdev->drm, ret < 0))
 		vdev->pm->suspend_reschedule_counter = PM_RESCHEDULE_LIMIT;
@@ -250,8 +248,6 @@ int ivpu_rpm_get(struct ivpu_device *vdev)
 
 void ivpu_rpm_put(struct ivpu_device *vdev)
 {
-	ivpu_dbg(vdev, RPM, "rpm_put count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
-
 	pm_runtime_mark_last_busy(vdev->drm.dev);
 	pm_runtime_put_autosuspend(vdev->drm.dev);
 }
@@ -321,16 +317,10 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
 	pm_runtime_allow(dev);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
-
-	ivpu_dbg(vdev, RPM, "Enable RPM count %d\n", atomic_read(&dev->power.usage_count));
 }
 
 void ivpu_pm_disable(struct ivpu_device *vdev)
 {
-	struct device *dev = vdev->drm.dev;
-
-	ivpu_dbg(vdev, RPM, "Disable RPM count %d\n", atomic_read(&dev->power.usage_count));
-
 	pm_runtime_get_noresume(vdev->drm.dev);
 	pm_runtime_forbid(vdev->drm.dev);
 }
-- 
2.39.2



