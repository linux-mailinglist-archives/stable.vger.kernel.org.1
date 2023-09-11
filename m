Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DBF79B3A4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbjIKU7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbjIKPXy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D2D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:23:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F33C433C8;
        Mon, 11 Sep 2023 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445830;
        bh=OLDUhQT2KQa8FiztKy0EWxjqo5AJUn/pscCzHLZ5gD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRfep93JxYfYJZCOnQtPJqXA4s/UPGB3Yn9O+hlsv4T6KC4HER03+sE2YB4Zy8zAy
         EZzGvTff307tHX6as+yPrxMkNuxVuvkOimQ186lbi24a4EADtyE8K8BGs7K7k7SRCz
         0z9jWmA74fpXsANGeA0JOYNp3Uz0iwfx+qRAYTvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Gow <davidgow@google.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 460/600] drivers: base: Free devm resources when unregistering a device
Date:   Mon, 11 Sep 2023 15:48:13 +0200
Message-ID: <20230911134647.231037830@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Gow <davidgow@google.com>

[ Upstream commit 699fb50d99039a50e7494de644f96c889279aca3 ]

In the current code, devres_release_all() only gets called if the device
has a bus and has been probed.

This leads to issues when using bus-less or driver-less devices where
the device might never get freed if a managed resource holds a reference
to the device. This is happening in the DRM framework for example.

We should thus call devres_release_all() in the device_del() function to
make sure that the device-managed actions are properly executed when the
device is unregistered, even if it has neither a bus nor a driver.

This is effectively the same change than commit 2f8d16a996da ("devres:
release resources on device_del()") that got reverted by commit
a525a3ddeaca ("driver core: free devres in device_release") over
memory leaks concerns.

This patch effectively combines the two commits mentioned above to
release the resources both on device_del() and device_release() and get
the best of both worlds.

Fixes: a525a3ddeaca ("driver core: free devres in device_release")
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20230720-kunit-devm-inconsistencies-test-v3-3-6aa7e074f373@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e30223c2672fc..af90bfb0cc3d8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3855,6 +3855,17 @@ void device_del(struct device *dev)
 	device_platform_notify_remove(dev);
 	device_links_purge(dev);
 
+	/*
+	 * If a device does not have a driver attached, we need to clean
+	 * up any managed resources. We do this in device_release(), but
+	 * it's never called (and we leak the device) if a managed
+	 * resource holds a reference to the device. So release all
+	 * managed resources here, like we do in driver_detach(). We
+	 * still need to do so again in device_release() in case someone
+	 * adds a new resource after this point, though.
+	 */
+	devres_release_all(dev);
+
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_REMOVED_DEVICE, dev);
-- 
2.40.1



