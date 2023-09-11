Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB8379B3B2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbjIKV3J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbjIKOxq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ABA118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE8FC433C7;
        Mon, 11 Sep 2023 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444021;
        bh=fyw+3XP10gEP9AcZSmgBKZgo9A/EhEzkbUMpO7L/l0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDLh2yiXrbUDDe7DGXf/Wl2r6e4KbqsTESk3VtiuzzqNEngJDPa3kGM75ruQHM3m+
         vmvzpGwy0VnPx2lvMziVX8LVHb6ECjuHlOxrRSHFwLT9xwTwDb/9/gtDZz0LX9p6cA
         YI9d2TxIraoWdTUvsq3EgclNOuvMhGty1ddUGKu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 554/737] media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings
Date:   Mon, 11 Sep 2023 15:46:53 +0200
Message-ID: <20230911134706.031981888@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 284be5693163343e1cf17c03917eecd1d6681bcf ]

When ipu_bridge_parse_rotation() and ipu_bridge_parse_orientation() run
sensor->adev is not set yet.

So if either of the dev_warn() calls about unknown values are hit this
will lead to a NULL pointer deref.

Set sensor->adev earlier, with a borrowed ref to avoid making unrolling
on errors harder, to fix this.

Fixes: 485aa3df0dff ("media: ipu3-cio2: Parse sensor orientation and rotation")
Cc: Fabian Wüthrich <me@fabwu.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index 3c2accfe54551..7fba87736b6b8 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -308,6 +308,11 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		}
 
 		sensor = &bridge->sensors[bridge->n_sensors];
+		/*
+		 * Borrow our adev ref to the sensor for now, on success
+		 * acpi_dev_get(adev) is done further below.
+		 */
+		sensor->adev = adev;
 
 		ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
 						   &sensor->ssdb,
-- 
2.40.1



