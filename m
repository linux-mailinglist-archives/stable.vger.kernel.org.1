Return-Path: <stable+bounces-162802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D76B06039
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CEA1C2591D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815302E7648;
	Tue, 15 Jul 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H9JzEy1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2452E54BF;
	Tue, 15 Jul 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587514; cv=none; b=KLxyRuxE1/Zqjabm4NOqIVOZLhMpS50h0QyA0f9Id3tSwEsJvLdv0C4uzKIga/rrDjqa/gMDxFNmk8CBTQRFO1b8VZSykRK98wghaPjG30ujEkoXvhv31eO8LpkLV8+tqeLxSpp1iPapW+u3GdkNIHPG6eqpLwMay2/8JCwZd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587514; c=relaxed/simple;
	bh=ns3DWG+vOVqVPz8lIfyWuwqOesf1YiMjauIWwc4MbiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIJLW/ghsgVsVx36xozvnKkTOUO7ZH7Kj1S1Q8MCqvhAhdszlQ5oQecKwpMgiIFGpurh906p6FHuPerT3ANGuyek39AGN+WBCxq1JdqPDuOk540O/cc256H/G8U+6mcljxBqsZbae30bqi3ai3CpOHV9Gvjl7WwvwzslzZQe0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H9JzEy1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C9EC4CEF1;
	Tue, 15 Jul 2025 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587514;
	bh=ns3DWG+vOVqVPz8lIfyWuwqOesf1YiMjauIWwc4MbiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9JzEy1yyXs8PjYXMxHQeej8+uqQnBno3slSLKP1Mb3THAz2I9mZVARDBnDACAr8s
	 9AXBRYCUCpjEZ1o6QzkCn1Jg9rfL5ZRNQCiVwRyQfNASd/3w988BARZmljkZFuSsUt
	 N4HCiQ+Y9kyAU+2PqUXnJanvDTcxUu77gk1AmPtk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 041/208] uio_hv_generic: Query the ringbuffer size for device
Date: Tue, 15 Jul 2025 15:12:30 +0200
Message-ID: <20250715130812.604485321@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit e566ed5b64177a0c07b677568f623ed31d23406d ]

Query the ring buffer size from pre defined table per device
and use that value for allocating the ring buffer for that
device. Keep the size as current default which is 2 MB if
the device doesn't have any preferred ring size.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Link: https://lore.kernel.org/r/1711788723-8593-3-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/uio/uio_hv_generic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index f7f5106307627..03a4ca762c499 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -249,6 +249,7 @@ hv_uio_probe(struct hv_device *dev,
 	struct hv_uio_private_data *pdata;
 	void *ring_buffer;
 	int ret;
+	size_t ring_size = hv_dev_ring_size(channel);
 
 	/* Communicating with host has to be via shared memory not hypercall */
 	if (!channel->offermsg.monitor_allocated) {
@@ -256,12 +257,14 @@ hv_uio_probe(struct hv_device *dev,
 		return -ENOTSUPP;
 	}
 
+	if (!ring_size)
+		ring_size = HV_RING_SIZE * PAGE_SIZE;
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = vmbus_alloc_ring(channel, HV_RING_SIZE * PAGE_SIZE,
-			       HV_RING_SIZE * PAGE_SIZE);
+	ret = vmbus_alloc_ring(channel, ring_size, ring_size);
 	if (ret)
 		return ret;
 
-- 
2.39.5




