Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCFD713D89
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjE1T00 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjE1T0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC93B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F9761C2F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7842DC433EF;
        Sun, 28 May 2023 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301981;
        bh=RbjbjmXiVcKCAlEtYvAx2GzwsCBKb/1elEmkaVwhe9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ls+50DEpoSJeKh0kizecwLkLiex8MufOYiU2rg0ccBIQLcA1ZKW0MUMMS4bTypL0T
         fjkQsKwbT1WozAPlsreFAbBlqnqFGb5+weoQveSbx21hcdKz+Lk9RBlen4td/vjKiJ
         0E1k8laNSqYR/DrinJQW2oJanwo4zuA5LUsFaDBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ping Cheng <ping.cheng@wacom.com>,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 5.4 114/161] HID: wacom: Add new Intuos Pro Small (PTH-460) device IDs
Date:   Sun, 28 May 2023 20:10:38 +0100
Message-Id: <20230528190840.691495755@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ping Cheng <pinglinux@gmail.com>

commit 0627f3df95e1609693f89e7ceb4156ac5db6e358 upstream.

Add the new PIDs to wacom_wac.c to support the new model in the Intuos Pro series.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Cc: Ping Cheng <pinglinux@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4840,6 +4840,10 @@ static const struct wacom_features wacom
 static const struct wacom_features wacom_features_0x3c8 =
 	{ "Wacom Intuos BT M", 21600, 13500, 4095, 63,
 	  INTUOSHT3_BT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4 };
+static const struct wacom_features wacom_features_0x3dd =
+	{ "Wacom Intuos Pro S", 31920, 19950, 8191, 63,
+	  INTUOSP2S_BT, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 7,
+	  .touch_max = 10 };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC, .oVid = HID_ANY_ID, .oPid = HID_ANY_ID };
@@ -5019,6 +5023,7 @@ const struct hid_device_id wacom_ids[] =
 	{ BT_DEVICE_WACOM(0x393) },
 	{ BT_DEVICE_WACOM(0x3c6) },
 	{ BT_DEVICE_WACOM(0x3c8) },
+	{ BT_DEVICE_WACOM(0x3dd) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },


