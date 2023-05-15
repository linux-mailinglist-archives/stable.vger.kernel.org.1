Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B00703B17
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbjEOR7P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbjEOR6r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C463189BB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 188E062FF0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2EEC433D2;
        Mon, 15 May 2023 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173376;
        bh=D1GtJnp1crPI/CgHevZZgWK1yPv+KTZC7pmAGrdnMXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vm3nOkVBtpZAUixInrOK7mO/ZLLePLqY5b2/pe856B+oC0/egIQmhtewwqFnqx2Zf
         TxHB1PhG78l/SGhios0rpIs2H+YNaAkzGeNLre2L4+rlFvn5PIPLjEh1s5Shws4XZf
         VRBOsE+jMYToMpHLS5KHtFl9BiyEllkuOdd32iF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 045/282] media: uapi: add MEDIA_BUS_FMT_METADATA_FIXED media bus format.
Date:   Mon, 15 May 2023 18:27:03 +0200
Message-Id: <20230515161723.613443621@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

[ Upstream commit 6ad253cc3436269fc6bcff03d704c672f368da0a ]

MEDIA_BUS_FMT_METADATA_FIXED should be used when
the same driver handles both sides of the link and
the bus format is a fixed metadata format that is
not configurable from userspace.
The width and height will be set to 0 for this format.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: eed9496a0501 ("media: av7110: prevent underflow in write_ts_to_decoder()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/uapi/v4l/subdev-formats.rst         | 27 +++++++++++++++++++
 include/uapi/linux/media-bus-format.h         |  8 ++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/media/uapi/v4l/subdev-formats.rst b/Documentation/media/uapi/v4l/subdev-formats.rst
index 15e11f27b4c8f..b89a2f6c91552 100644
--- a/Documentation/media/uapi/v4l/subdev-formats.rst
+++ b/Documentation/media/uapi/v4l/subdev-formats.rst
@@ -7794,3 +7794,30 @@ formats.
       - 0x5001
       - Interleaved raw UYVY and JPEG image format with embedded meta-data
 	used by Samsung S3C73MX camera sensors.
+
+.. _v4l2-mbus-metadata-fmts:
+
+Metadata Formats
+^^^^^^^^^^^^^^^^
+
+This section lists all metadata formats.
+
+The following table lists the existing metadata formats.
+
+.. tabularcolumns:: |p{8.0cm}|p{1.4cm}|p{7.7cm}|
+
+.. flat-table:: Metadata formats
+    :header-rows:  1
+    :stub-columns: 0
+
+    * - Identifier
+      - Code
+      - Comments
+    * .. _MEDIA-BUS-FMT-METADATA-FIXED:
+
+      - MEDIA_BUS_FMT_METADATA_FIXED
+      - 0x7001
+      - This format should be used when the same driver handles
+	both sides of the link and the bus format is a fixed
+	metadata format that is not configurable from userspace.
+	Width and height will be set to 0 for this format.
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index 16c1fa2d89a42..052c8308b995c 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -155,4 +155,12 @@
 /* HSV - next is	0x6002 */
 #define MEDIA_BUS_FMT_AHSV8888_1X32		0x6001
 
+/*
+ * This format should be used when the same driver handles
+ * both sides of the link and the bus format is a fixed
+ * metadata format that is not configurable from userspace.
+ * Width and height will be set to 0 for this format.
+ */
+#define MEDIA_BUS_FMT_METADATA_FIXED		0x7001
+
 #endif /* __LINUX_MEDIA_BUS_FORMAT_H */
-- 
2.39.2



