Return-Path: <stable+bounces-159854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C266AF7B0C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370173B248D
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBB2F2727;
	Thu,  3 Jul 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6FGG8o9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D42F0C69;
	Thu,  3 Jul 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555566; cv=none; b=IZ293agvcvIOPUa15muzhuDkIS1U+zaR7szKwISETyVHttY/bDRVejx6pZhhvw44mCcSih0Xz/J8LUKnIb3bL7UIoskFVCpRhkrCz8ZefQsLZZ2vMckiKmcuagsaecVy9viOjqwKOKVsqaPcZe5Mk2D8L2QGIBhCyn5OtjMWtOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555566; c=relaxed/simple;
	bh=jy7BmY6YCxdDhudWTbP+9nCsn9/spcZNddz3lxHCTKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym54RNkqXxl2/C4IErd3wpevhDQFmJqZKebRHV1OsCP5j7tC1gM82HVh82Bpqsutc5QxLKxKsFeMygy+BqHP9bKCJdxQACyZizo/Guaz31F+wwCS9BI6ZUNu6vaAwqpyYGQc2FmSrjqJTVXRRJjzhrKQdZvTaZCDjWjxo75hh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6FGG8o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF25C4CEE3;
	Thu,  3 Jul 2025 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555566;
	bh=jy7BmY6YCxdDhudWTbP+9nCsn9/spcZNddz3lxHCTKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6FGG8o9DVR5hrqq7YrsrOVqB45gZNYQFz0SSsnmOpOXsJpkWOluCQEu04SXr/X0c
	 P71TYiJl/KteYqcUGZCWUSPaa+i2s3N0FudofUHuKbM/MIXjyWA5Y4rgWC7CjOnT8C
	 8F9ZkEMG/Syoj2CnjrrkATb803JOvAblG/cCUvUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 053/139] Drivers: hv: vmbus: Add utility function for querying ring size
Date: Thu,  3 Jul 2025 16:41:56 +0200
Message-ID: <20250703143943.240786977@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit e8c4bd6c6e6b7e7b416c42806981c2a81370001e ]

Add a function to query for the preferred ring buffer size of VMBus
device. This will allow the drivers (eg. UIO) to allocate the most
optimized ring buffer size for devices.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Link: https://lore.kernel.org/r/1711788723-8593-2-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/channel_mgmt.c | 15 ++++++++++++---
 drivers/hv/hyperv_vmbus.h |  5 +++++
 include/linux/hyperv.h    |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 2f4d09ce027a3..3c6011a48dabe 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -120,7 +120,9 @@ const struct vmbus_device vmbus_devs[] = {
 	},
 
 	/* File copy */
-	{ .dev_type = HV_FCOPY,
+	/* fcopy always uses 16KB ring buffer size and is working well for last many years */
+	{ .pref_ring_size = 0x4000,
+	  .dev_type = HV_FCOPY,
 	  HV_FCOPY_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
@@ -140,12 +142,19 @@ const struct vmbus_device vmbus_devs[] = {
 	  .allowed_in_isolated = false,
 	},
 
-	/* Unknown GUID */
-	{ .dev_type = HV_UNKNOWN,
+	/*
+	 * Unknown GUID
+	 * 64 KB ring buffer + 4 KB header should be sufficient size for any Hyper-V device apart
+	 * from HV_NIC and HV_SCSI. This case avoid the fallback for unknown devices to allocate
+	 * much bigger (2 MB) of ring size.
+	 */
+	{ .pref_ring_size = 0x11000,
+	  .dev_type = HV_UNKNOWN,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
 	},
 };
+EXPORT_SYMBOL_GPL(vmbus_devs);
 
 static const struct {
 	guid_t guid;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 787b150686418..34b60009114a6 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -419,6 +419,11 @@ static inline bool hv_is_perf_channel(struct vmbus_channel *channel)
 	return vmbus_devs[channel->device_id].perf_device;
 }
 
+static inline size_t hv_dev_ring_size(struct vmbus_channel *channel)
+{
+	return vmbus_devs[channel->device_id].pref_ring_size;
+}
+
 static inline bool hv_is_allocated_cpu(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b5bf5315ca8c1..e4ad9760774e1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -820,6 +820,8 @@ struct vmbus_requestor {
 #define VMBUS_RQST_RESET (U64_MAX - 3)
 
 struct vmbus_device {
+	/* preferred ring buffer size in KB, 0 means no preferred size for this device */
+	size_t pref_ring_size;
 	u16  dev_type;
 	guid_t guid;
 	bool perf_device;
-- 
2.39.5




