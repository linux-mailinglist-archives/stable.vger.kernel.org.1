Return-Path: <stable+bounces-140726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16677AAAAD2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9695D4C1767
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F45386694;
	Mon,  5 May 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2aZHd/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2A2DC130;
	Mon,  5 May 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486070; cv=none; b=dQ/L1v04hakCKq8r3DjKwmLKKSmXwwJjKugO9YcPmw5iQrAi2SGPPXeK0Rnh4E0vPBNK93BUGrsQgja7CLQ1FOPHk1t27mDJoelxdl+erhUI7J671pmr/ZbY8XKivd8ieYdJgABpbGEhvFCvYY4vlRynRB5dXjPGfOcO36lTXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486070; c=relaxed/simple;
	bh=jmBe8RlPmzPNhBELAiZYpP4K0/UpJqbRvS97RoG22fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=if+u1YjNZcxfYBstgjtoK0BU4ct72zvgeB6DJu1wXt5S/dY5r55SHFYni3ElxM3CXjwVlUM3z3W1WR6GraeMF3zNeay5FGFVM0FqqG3Gu3I3k4o+NTxS6RsNjMELxHcJy4LJjJgdK3C9t9Hli/ThAbsBrNXQKFWhy2dNxI2zwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2aZHd/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38E1C4CEEE;
	Mon,  5 May 2025 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486068;
	bh=jmBe8RlPmzPNhBELAiZYpP4K0/UpJqbRvS97RoG22fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2aZHd/mF3fY7Pzb+RKUCwb6oUVNXCzs/9Wg6tBRJ4vsjd5XRuMpBqyDzRKto6D21
	 i/aPOhoYL2fgagO+btZ4HbaRS7cXbHOstdlKyqf+x02cdD+3xGzIxIW+wTlp4TUhLs
	 Zghloe89EZbwDXMSc39MsZtWxVOy8bluRs9TMftujQo38J2BgJwTisqoCfdSEqpPMy
	 NWaemqCFO57ou0mHygYHCgKUE+UeqkAw+1svZs37onPZHRRieF3gIXCGb1eTMSyYly
	 nZVehwD23NkYAefQBYHpslibdZE6JQkphWABnY6ocneHpRZGoGASdLRBIXsrV+B3xh
	 HFnC/Po/A8ROA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Sven Peter <sven@svenpeter.dev>,
	Sasha Levin <sashal@kernel.org>,
	j@jannau.net,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 138/294] soc: apple: rtkit: Implement OSLog buffers properly
Date: Mon,  5 May 2025 18:53:58 -0400
Message-Id: <20250505225634.2688578-138-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit a06398687065e0c334dc5fc4d2778b5b87292e43 ]

Apparently nobody can figure out where the old logic came from, but it
seems like it has never been actually used on any supported firmware to
this day. OSLog buffers were apparently never requested.

But starting with 13.3, we actually need this implemented properly for
MTP (and later AOP) to work, so let's actually do that.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Link: https://lore.kernel.org/r/20250226-apple-soc-misc-v2-2-c3ec37f9021b@svenpeter.dev
Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/apple/rtkit-internal.h |  1 +
 drivers/soc/apple/rtkit.c          | 56 ++++++++++++++++++------------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/apple/rtkit-internal.h b/drivers/soc/apple/rtkit-internal.h
index 24bd619ec5e48..1da1dfd9cb199 100644
--- a/drivers/soc/apple/rtkit-internal.h
+++ b/drivers/soc/apple/rtkit-internal.h
@@ -48,6 +48,7 @@ struct apple_rtkit {
 
 	struct apple_rtkit_shmem ioreport_buffer;
 	struct apple_rtkit_shmem crashlog_buffer;
+	struct apple_rtkit_shmem oslog_buffer;
 
 	struct apple_rtkit_shmem syslog_buffer;
 	char *syslog_msg_buffer;
diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index b9c5281c445ee..2c37216f423d2 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -66,8 +66,9 @@ enum {
 #define APPLE_RTKIT_SYSLOG_MSG_SIZE  GENMASK_ULL(31, 24)
 
 #define APPLE_RTKIT_OSLOG_TYPE GENMASK_ULL(63, 56)
-#define APPLE_RTKIT_OSLOG_INIT	1
-#define APPLE_RTKIT_OSLOG_ACK	3
+#define APPLE_RTKIT_OSLOG_BUFFER_REQUEST 1
+#define APPLE_RTKIT_OSLOG_SIZE GENMASK_ULL(55, 36)
+#define APPLE_RTKIT_OSLOG_IOVA GENMASK_ULL(35, 0)
 
 #define APPLE_RTKIT_MIN_SUPPORTED_VERSION 11
 #define APPLE_RTKIT_MAX_SUPPORTED_VERSION 12
@@ -256,15 +257,21 @@ static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
 					    struct apple_rtkit_shmem *buffer,
 					    u8 ep, u64 msg)
 {
-	size_t n_4kpages = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg);
 	u64 reply;
 	int err;
 
+	/* The different size vs. IOVA shifts look odd but are indeed correct this way */
+	if (ep == APPLE_RTKIT_EP_OSLOG) {
+		buffer->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg);
+		buffer->iova = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg) << 12;
+	} else {
+		buffer->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg) << 12;
+		buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
+	}
+
 	buffer->buffer = NULL;
 	buffer->iomem = NULL;
 	buffer->is_mapped = false;
-	buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
-	buffer->size = n_4kpages << 12;
 
 	dev_dbg(rtk->dev, "RTKit: buffer request for 0x%zx bytes at %pad\n",
 		buffer->size, &buffer->iova);
@@ -289,11 +296,21 @@ static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
 	}
 
 	if (!buffer->is_mapped) {
-		reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
-				   APPLE_RTKIT_BUFFER_REQUEST);
-		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE, n_4kpages);
-		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
-				    buffer->iova);
+		/* oslog uses different fields and needs a shifted IOVA instead of size */
+		if (ep == APPLE_RTKIT_EP_OSLOG) {
+			reply = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE,
+					   APPLE_RTKIT_OSLOG_BUFFER_REQUEST);
+			reply |= FIELD_PREP(APPLE_RTKIT_OSLOG_SIZE, buffer->size);
+			reply |= FIELD_PREP(APPLE_RTKIT_OSLOG_IOVA,
+					    buffer->iova >> 12);
+		} else {
+			reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
+					   APPLE_RTKIT_BUFFER_REQUEST);
+			reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE,
+					    buffer->size >> 12);
+			reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
+					    buffer->iova);
+		}
 		apple_rtkit_send_message(rtk, ep, reply, NULL, false);
 	}
 
@@ -487,25 +504,18 @@ static void apple_rtkit_syslog_rx(struct apple_rtkit *rtk, u64 msg)
 	}
 }
 
-static void apple_rtkit_oslog_rx_init(struct apple_rtkit *rtk, u64 msg)
-{
-	u64 ack;
-
-	dev_dbg(rtk->dev, "RTKit: oslog init: msg: 0x%llx\n", msg);
-	ack = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE, APPLE_RTKIT_OSLOG_ACK);
-	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_OSLOG, ack, NULL, false);
-}
-
 static void apple_rtkit_oslog_rx(struct apple_rtkit *rtk, u64 msg)
 {
 	u8 type = FIELD_GET(APPLE_RTKIT_OSLOG_TYPE, msg);
 
 	switch (type) {
-	case APPLE_RTKIT_OSLOG_INIT:
-		apple_rtkit_oslog_rx_init(rtk, msg);
+	case APPLE_RTKIT_OSLOG_BUFFER_REQUEST:
+		apple_rtkit_common_rx_get_buffer(rtk, &rtk->oslog_buffer,
+						 APPLE_RTKIT_EP_OSLOG, msg);
 		break;
 	default:
-		dev_warn(rtk->dev, "RTKit: Unknown oslog message: %llx\n", msg);
+		dev_warn(rtk->dev, "RTKit: Unknown oslog message: %llx\n",
+			 msg);
 	}
 }
 
@@ -787,6 +797,7 @@ int apple_rtkit_reinit(struct apple_rtkit *rtk)
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->oslog_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
 
 	kfree(rtk->syslog_msg_buffer);
@@ -967,6 +978,7 @@ void apple_rtkit_free(struct apple_rtkit *rtk)
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->oslog_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
 
 	kfree(rtk->syslog_msg_buffer);
-- 
2.39.5


