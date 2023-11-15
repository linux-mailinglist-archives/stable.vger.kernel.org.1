Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD687ED31C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjKOUqQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjKOUqP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B02C1B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E52C433C8;
        Wed, 15 Nov 2023 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081170;
        bh=jnTR+mRx/2fZAs8dULeecJwLWdGJaKOWxWO097nnXrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WULhDVMcCrdEVvI4GGOs+Z9SD6ZzkL0kblA9tAi0J9TA/bYZKSOJZsZcv/Kv7EU2Q
         AdvGbi69Q3CmXStWk2DaYh966W9eHfx2Ey70fFcLSevv6zV1Go45MN8v+an0nLCRLe
         9maGfZ/1DOb0Ro3PuLbqCmv/UDjhcSyPy/gS/+6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 56/88] tools: iio: privatize globals and functions in iio_generic_buffer.c file
Date:   Wed, 15 Nov 2023 15:36:08 -0500
Message-ID: <20231115191429.513731015@linuxfoundation.org>
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

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit ebe5112535b5cf389ca7d337cf6a0c1d885f9880 ]

Mostly a tidy-up.
But also helps to understand the limits of scope of these functions and
globals.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210215104043.91251-24-alexandru.ardelean@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 2d3dff577dd0 ("tools: iio: iio_generic_buffer ensure alignment")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_generic_buffer.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 84545666a09c4..9a5af0f6592dc 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -53,7 +53,7 @@ enum autochan {
  * Has the side effect of filling the channels[i].location values used
  * in processing the buffer output.
  **/
-int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+static int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
 	int bytes = 0;
 	int i = 0;
@@ -72,7 +72,7 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 	return bytes;
 }
 
-void print1byte(uint8_t input, struct iio_channel_info *info)
+static void print1byte(uint8_t input, struct iio_channel_info *info)
 {
 	/*
 	 * Shift before conversion to avoid sign extension
@@ -89,7 +89,7 @@ void print1byte(uint8_t input, struct iio_channel_info *info)
 	}
 }
 
-void print2byte(uint16_t input, struct iio_channel_info *info)
+static void print2byte(uint16_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -112,7 +112,7 @@ void print2byte(uint16_t input, struct iio_channel_info *info)
 	}
 }
 
-void print4byte(uint32_t input, struct iio_channel_info *info)
+static void print4byte(uint32_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -135,7 +135,7 @@ void print4byte(uint32_t input, struct iio_channel_info *info)
 	}
 }
 
-void print8byte(uint64_t input, struct iio_channel_info *info)
+static void print8byte(uint64_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -171,9 +171,8 @@ void print8byte(uint64_t input, struct iio_channel_info *info)
  *			      to fill the location offsets.
  * @num_channels:	number of channels
  **/
-void process_scan(char *data,
-		  struct iio_channel_info *channels,
-		  int num_channels)
+static void process_scan(char *data, struct iio_channel_info *channels,
+			 int num_channels)
 {
 	int k;
 
@@ -242,7 +241,7 @@ static int enable_disable_all_channels(char *dev_dir_name, int enable)
 	return 0;
 }
 
-void print_usage(void)
+static void print_usage(void)
 {
 	fprintf(stderr, "Usage: generic_buffer [options]...\n"
 		"Capture, convert and output data from IIO device buffer\n"
@@ -261,12 +260,12 @@ void print_usage(void)
 		"  -w <n>     Set delay between reads in us (event-less mode)\n");
 }
 
-enum autochan autochannels = AUTOCHANNELS_DISABLED;
-char *dev_dir_name = NULL;
-char *buf_dir_name = NULL;
-bool current_trigger_set = false;
+static enum autochan autochannels = AUTOCHANNELS_DISABLED;
+static char *dev_dir_name = NULL;
+static char *buf_dir_name = NULL;
+static bool current_trigger_set = false;
 
-void cleanup(void)
+static void cleanup(void)
 {
 	int ret;
 
@@ -298,14 +297,14 @@ void cleanup(void)
 	}
 }
 
-void sig_handler(int signum)
+static void sig_handler(int signum)
 {
 	fprintf(stderr, "Caught signal %d\n", signum);
 	cleanup();
 	exit(-signum);
 }
 
-void register_cleanup(void)
+static void register_cleanup(void)
 {
 	struct sigaction sa = { .sa_handler = sig_handler };
 	const int signums[] = { SIGINT, SIGTERM, SIGABRT };
-- 
2.42.0



