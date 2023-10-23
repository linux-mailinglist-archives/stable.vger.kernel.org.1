Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC77D3457
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjJWLip (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjJWLio (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:38:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2010C3
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:38:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20969C433C7;
        Mon, 23 Oct 2023 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061121;
        bh=PgSUZ6jwJ1E8bSMUed5TUCf9XwrYeM8595ZtnC2cm7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESnYeIVqpFJOUBIWYA3kpf0MWYO7pWPi1sB4BUbtwMDlTM54/dZJbyA7rbyXVNK7B
         KB2NVkYhM7J5lmK30Q++7w/OCA6W4/O4b6B871xJPFhSOsPJ/RjblAkz1qOBwD+kRD
         1ZRNKngpM8HYOABODLW7GT1YBZPG4IqdtlFS95T8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 052/137] iio: Un-inline iio_buffer_enabled()
Date:   Mon, 23 Oct 2023 12:56:49 +0200
Message-ID: <20231023104822.760459341@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 2f53b4adfede66f1bc1c8bb7efd7ced2bad1191a ]

As we are going to hide the currentmode inside the opaque structure,
this helper would soon need to call a non-inline function which would
simply drop the benefit of having the helper defined inline in a header.

One alternative is to move this helper in the core as there is no more
interest in defining it inline in a header. We will pay the minor cost
either way.

Let's do like the iio_device_id() helper which also refers to the opaque
structure and gets defined in the core.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20220207143840.707510-10-miquel.raynal@bootlin.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 7771c8c80d62 ("iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c | 12 ++++++++++++
 include/linux/iio/iio.h         | 11 +----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a7f5d432c95d9..f95a95fd9d0a5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -184,6 +184,18 @@ int iio_device_id(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_device_id);
 
+/**
+ * iio_buffer_enabled() - helper function to test if the buffer is enabled
+ * @indio_dev:		IIO device structure for device
+ */
+bool iio_buffer_enabled(struct iio_dev *indio_dev)
+{
+	return indio_dev->currentmode
+		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
+		   INDIO_BUFFER_SOFTWARE);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_enabled);
+
 /**
  * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
  * @array: array of strings
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 324561b7a5e86..0346acbbed2ee 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -542,6 +542,7 @@ struct iio_dev {
 };
 
 int iio_device_id(struct iio_dev *indio_dev);
+bool iio_buffer_enabled(struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
@@ -671,16 +672,6 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
 __printf(2, 3)
 struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
-/**
- * iio_buffer_enabled() - helper function to test if the buffer is enabled
- * @indio_dev:		IIO device structure for device
- **/
-static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
-{
-	return indio_dev->currentmode
-		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
-		   INDIO_BUFFER_SOFTWARE);
-}
 
 /**
  * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
-- 
2.40.1



