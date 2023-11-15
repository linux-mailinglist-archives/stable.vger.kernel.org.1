Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541AC7ECF6C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjKOTsS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjKOTsS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DB01A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3E3C433C9;
        Wed, 15 Nov 2023 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077694;
        bh=DNKrQyDwX8lppB9ei+gOHQPN8ibOeLv64Af+wHATMHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBZVuP+mn02lCUEhUPEAPVgFNgBJ9gZcw5RXHNmwVuB6Fwy0hIUYBSD0KwqGw4MMb
         GqVAMLYDRQsfR5OFqw40wNpu4vLOMyBIX1r8+e5VBiOPyrOLZWegYUG53x/SwZcDbN
         6tlqp/cmjAqb6UTUsTshfNhPJDmPFT986iQ7FHaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 443/603] tools: iio: iio_generic_buffer ensure alignment
Date:   Wed, 15 Nov 2023 14:16:28 -0500
Message-ID: <20231115191643.437659133@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit 2d3dff577dd0ea8fe9637a13822f7603c4a881c8 ]

The iio_generic_buffer can return garbage values when the total size of
scan data is not a multiple of the largest element in the scan. This can be
demonstrated by reading a scan, consisting, for example of one 4-byte and
one 2-byte element, where the 4-byte element is first in the buffer.

The IIO generic buffer code does not take into account the last two
padding bytes that are needed to ensure that the 4-byte data for next
scan is correctly aligned.

Add the padding bytes required to align the next sample with the scan size.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e58537ccce73 ("staging: iio: update example application.")
Link: https://lore.kernel.org/r/ZRvlm4ktNLu+qmlf@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_generic_buffer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 44bbf80f0cfdd..0d0a7a19d6f95 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -54,9 +54,12 @@ enum autochan {
 static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
 	unsigned int bytes = 0;
-	int i = 0;
+	int i = 0, max = 0;
+	unsigned int misalignment;
 
 	while (i < num_channels) {
+		if (channels[i].bytes > max)
+			max = channels[i].bytes;
 		if (bytes % channels[i].bytes == 0)
 			channels[i].location = bytes;
 		else
@@ -66,6 +69,14 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
 		bytes = channels[i].location + channels[i].bytes;
 		i++;
 	}
+	/*
+	 * We want the data in next sample to also be properly aligned so
+	 * we'll add padding at the end if needed. Adding padding only
+	 * works for channel data which size is 2^n bytes.
+	 */
+	misalignment = bytes % max;
+	if (misalignment)
+		bytes += max - misalignment;
 
 	return bytes;
 }
-- 
2.42.0



