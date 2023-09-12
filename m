Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4969079B3A5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbjIKU5u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbjIKP02 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:26:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9FD8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:26:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369E8C433C8;
        Mon, 11 Sep 2023 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445982;
        bh=h1JriQ9BxLA0zUmqRZ5a8Uur5v0qAm1pIU5R41fsrzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibVvw4OPr1A9RxvOFa5gwKpOL14PEDUiaQn3jthFJp3vHBpN5MzIW3XNBU6i/7oFm
         5zP1TmmRmTyujbB8vq96+x1yZtkvld10ooFbBElPBCbSAF3ySspFDbTv5aOLJ/idY7
         7gaSsX1ywvDfyKAyBlQdQWUi4Vw1vsgmv5kTAvlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 514/600] Drivers: hv: vmbus: Dont dereference ACPI root object handle
Date:   Mon, 11 Sep 2023 15:49:07 +0200
Message-ID: <20230911134648.786563420@linuxfoundation.org>
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

From: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

[ Upstream commit 78e04bbff849b51b56f5925b1945db2c6e128b61 ]

Since the commit referenced in the Fixes: tag below the VMBus client driver
is walking the ACPI namespace up from the VMBus ACPI device to the ACPI
namespace root object trying to find Hyper-V MMIO ranges.

However, if it is not able to find them it ends trying to walk resources of
the ACPI namespace root object itself.
This object has all-ones handle, which causes a NULL pointer dereference
in the ACPI code (from dereferencing this pointer with an offset).

This in turn causes an oops on boot with VMBus host implementations that do
not provide Hyper-V MMIO ranges in their VMBus ACPI device or its
ancestors.
The QEMU VMBus implementation is an example of such implementation.

I guess providing these ranges is optional, since all tested Windows
versions seem to be able to use VMBus devices without them.

Fix this by explicitly terminating the lookup at the ACPI namespace root
object.

Note that Linux guests under KVM/QEMU do not use the Hyper-V PV interface
by default - they only do so if the KVM PV interface is missing or
disabled.

Example stack trace of such oops:
[ 3.710827] ? __die+0x1f/0x60
[ 3.715030] ? page_fault_oops+0x159/0x460
[ 3.716008] ? exc_page_fault+0x73/0x170
[ 3.716959] ? asm_exc_page_fault+0x22/0x30
[ 3.717957] ? acpi_ns_lookup+0x7a/0x4b0
[ 3.718898] ? acpi_ns_internalize_name+0x79/0xc0
[ 3.720018] acpi_ns_get_node_unlocked+0xb5/0xe0
[ 3.721120] ? acpi_ns_check_object_type+0xfe/0x200
[ 3.722285] ? acpi_rs_convert_aml_to_resource+0x37/0x6e0
[ 3.723559] ? down_timeout+0x3a/0x60
[ 3.724455] ? acpi_ns_get_node+0x3a/0x60
[ 3.725412] acpi_ns_get_node+0x3a/0x60
[ 3.726335] acpi_ns_evaluate+0x1c3/0x2c0
[ 3.727295] acpi_ut_evaluate_object+0x64/0x1b0
[ 3.728400] acpi_rs_get_method_data+0x2b/0x70
[ 3.729476] ? vmbus_platform_driver_probe+0x1d0/0x1d0 [hv_vmbus]
[ 3.730940] ? vmbus_platform_driver_probe+0x1d0/0x1d0 [hv_vmbus]
[ 3.732411] acpi_walk_resources+0x78/0xd0
[ 3.733398] vmbus_platform_driver_probe+0x9f/0x1d0 [hv_vmbus]
[ 3.734802] platform_probe+0x3d/0x90
[ 3.735684] really_probe+0x19b/0x400
[ 3.736570] ? __device_attach_driver+0x100/0x100
[ 3.737697] __driver_probe_device+0x78/0x160
[ 3.738746] driver_probe_device+0x1f/0x90
[ 3.739743] __driver_attach+0xc2/0x1b0
[ 3.740671] bus_for_each_dev+0x70/0xc0
[ 3.741601] bus_add_driver+0x10e/0x210
[ 3.742527] driver_register+0x55/0xf0
[ 3.744412] ? 0xffffffffc039a000
[ 3.745207] hv_acpi_init+0x3c/0x1000 [hv_vmbus]

Fixes: 7f163a6fd957 ("drivers:hv: Modify hv_vmbus to search for all MMIO ranges available.")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/fd8e64ceeecfd1d95ff49021080cf699e88dbbde.1691606267.git.maciej.szmigiero@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/vmbus_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b03cb7ae7fd38..e9c3f1e826baa 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2452,7 +2452,8 @@ static int vmbus_acpi_add(struct acpi_device *device)
 	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
 	 * firmware) is the VMOD that has the mmio ranges. Get that.
 	 */
-	for (ancestor = acpi_dev_parent(device); ancestor;
+	for (ancestor = acpi_dev_parent(device);
+	     ancestor && ancestor->handle != ACPI_ROOT_OBJECT;
 	     ancestor = acpi_dev_parent(ancestor)) {
 		result = acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
 					     vmbus_walk_resources, NULL);
-- 
2.40.1



