Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F37ED302
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjKOUpr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjKOUpk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:45:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F8818D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BE9C433C9;
        Wed, 15 Nov 2023 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081130;
        bh=VmaoimEdUq77hxAEhBTykEfbd1v/IuUJiO/V8nnVMEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCMtTMAmDoLf6/AAXYAWVOfULvrzLR9lHn/LYd5X5qMF/WJ3STgDL674ww8gcBjUW
         GzBdo6V7KSr2C2dqAn8YIKDel3lclsBrTj8al74QJuQ0RWuvVJHLffn9L4Vo9mgGBa
         JeOEhumvee37Qqp3fKqCLyWTZwiutRwwi5VGOFO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chenyuan Mi <michenyuan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 57/88] tools: iio: iio_generic_buffer: Fix some integer type and calculation
Date:   Wed, 15 Nov 2023 15:36:09 -0500
Message-ID: <20231115191429.570835411@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenyuan Mi <michenyuan@huawei.com>

[ Upstream commit 49d736313d0975ddeb156f4f59801da833f78b30 ]

In function size_from_channelarray(), the return value 'bytes' is defined
as int type. However, the calcution of 'bytes' in this function is designed
to use the unsigned int type. So it is necessary to change 'bytes' type to
unsigned int to avoid integer overflow.

The size_from_channelarray() is called in main() function, its return value
is directly multipled by 'buf_len' and then used as the malloc() parameter.
The 'buf_len' is completely controllable by user, thus a multiplication
overflow may occur here. This could allocate an unexpected small area.

Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
Link: https://lore.kernel.org/r/20230725092407.62545-1-michenyuan@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 2d3dff577dd0 ("tools: iio: iio_generic_buffer ensure alignment")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_generic_buffer.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 9a5af0f6592dc..8360605f01db8 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -53,9 +53,9 @@ enum autochan {
  * Has the side effect of filling the channels[i].location values used
  * in processing the buffer output.
  **/
-static int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
-	int bytes = 0;
+	unsigned int bytes = 0;
 	int i = 0;
 
 	while (i < num_channels) {
@@ -346,7 +346,7 @@ int main(int argc, char **argv)
 	ssize_t read_size;
 	int dev_num = -1, trig_num = -1;
 	char *buffer_access = NULL;
-	int scan_size;
+	unsigned int scan_size;
 	int noevents = 0;
 	int notrigger = 0;
 	char *dummy;
@@ -616,7 +616,16 @@ int main(int argc, char **argv)
 	}
 
 	scan_size = size_from_channelarray(channels, num_channels);
-	data = malloc(scan_size * buf_len);
+
+	size_t total_buf_len = scan_size * buf_len;
+
+	if (scan_size > 0 && total_buf_len / scan_size != buf_len) {
+		ret = -EFAULT;
+		perror("Integer overflow happened when calculate scan_size * buf_len");
+		goto error;
+	}
+
+	data = malloc(total_buf_len);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
-- 
2.42.0



