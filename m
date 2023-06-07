Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B5A726D99
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjFGUoD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjFGUoC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43CA26B6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C32964643
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF97AC433D2;
        Wed,  7 Jun 2023 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170587;
        bh=Jrx5AqNyDo6f1DuY6Z3TjzGPoXekA2bWPZ1k1kbP1UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhIEvdbptAxPSHwdABl4lDbD6lgHkbyqq5gAPZ6CbyDCwWYAvc/SMPQ3Akwf8O8D5
         Tr9gMCvu+6pvtZ2wtSrXjRWX96dmRjdmM4evUcQ/M/dcY7Uxm1qlJ/JvF0lBbLv9R/
         XZh8+Z1vW0++oQ2DEfI0gWoIHrK2jatDxZk0d/jI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marius Hoch <mail@mariushoch.de>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 141/225] iio: accel: st_accel: Fix invalid mount_matrix on devices without ACPI _ONT method
Date:   Wed,  7 Jun 2023 22:15:34 +0200
Message-ID: <20230607200918.998388491@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 79b8ded9d9c595db9bd5b2f62f5f738b36de1e22 upstream.

When apply_acpi_orientation() fails, st_accel_common_probe() will fall back
to iio_read_mount_matrix(), which checks for a mount-matrix device property
and if that is not set falls back to the identity matrix.

But when a sensor has no ACPI companion fwnode, or when the ACPI fwnode
does not have a "_ONT" method apply_acpi_orientation() was returning 0,
causing iio_read_mount_matrix() to never get called resulting in an
invalid mount_matrix:

[root@fedora ~]# cat /sys/bus/iio/devices/iio\:device0/mount_matrix
(null), (null), (null); (null), (null), (null); (null), (null), (null)

Fix this by making apply_acpi_orientation() always return an error when
it did not set the mount_matrix.

Fixes: 3d8ad94bb175 ("iio: accel: st_sensors: Support generic mounting matrix")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Marius Hoch <mail@mariushoch.de>
Link: https://lore.kernel.org/r/20230416212409.310936-1-hdegoede@redhat.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/st_accel_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1289,12 +1289,12 @@ static int apply_acpi_orientation(struct
 
 	adev = ACPI_COMPANION(indio_dev->dev.parent);
 	if (!adev)
-		return 0;
+		return -ENXIO;
 
 	/* Read _ONT data, which should be a package of 6 integers. */
 	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
 	if (status == AE_NOT_FOUND) {
-		return 0;
+		return -ENXIO;
 	} else if (ACPI_FAILURE(status)) {
 		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
 			 status);


