Return-Path: <stable+bounces-74722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0F9730FC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB13287A54
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7832191F9E;
	Tue, 10 Sep 2024 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzPxmr3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A41191F88;
	Tue, 10 Sep 2024 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962636; cv=none; b=h+p5gNhsrMQybxOHu91xfW3iS+OA+mwzkE2a3p7EHu3Yu97WslLPGH0Xu9ZG7W4gg74Aw82FxRMKHDl9rum7tAn56VkfXIhQvOSfiYT69mtbgUn7ahFayk4Vszu7+s3Ccx3IrWAh6BnKvEZ9ockNddhpCM9kHKm2ckdqSIfyU74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962636; c=relaxed/simple;
	bh=PukoYfYXxtX7JJGPcPvMgF96YY+SDiZSlL3R8Zy813E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU60KzfBWt8KtPqK5Yk9IsMSwo0yJycd5hnDbgccQ/D9waCEeBJjKBTxK7bC9HoZbks+aHQWnri1PJ7AT3ln4ahQpP6JEyJ7y6p9vwGN7b9fc8hy9uA4gP53X2ZTWFFohh/Pvhj/gG/O3U2LInZLNYLCQFFfM+vHVJZcYEc+rU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzPxmr3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC0FC4CEDB;
	Tue, 10 Sep 2024 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962636;
	bh=PukoYfYXxtX7JJGPcPvMgF96YY+SDiZSlL3R8Zy813E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzPxmr3Eh49KjaRaE/li1RNtNTEuH5nmMsretuql06E2RnLhHOtkJiX0kKuHARlYk
	 fYmfVQOfspVEeXVm7uah9KddimZaOk8w63ygqFOi/JT2BdcNmf91JKC36a+DIHTa/f
	 45zMOmNqAnRV8ZY2Lzf2AcKgQPD2lAGk+RO2RnW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH 5.4 101/121] uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind
Date: Tue, 10 Sep 2024 11:32:56 +0200
Message-ID: <20240910092550.639569101@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saurabh Sengar <ssengar@linux.microsoft.com>

commit fb1adbd7e50f3d2de56d0a2bb0700e2e819a329e upstream.

For primary VM Bus channels, primary_channel pointer is always NULL. This
pointer is valid only for the secondary channels. Also, rescind callback
is meant for primary channels only.

Fix NULL pointer dereference by retrieving the device_obj from the parent
for the primary channel.

Cc: stable@vger.kernel.org
Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Link: https://lore.kernel.org/r/20240829071312.1595-2-namjain@linux.microsoft.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio_hv_generic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -104,10 +104,11 @@ static void hv_uio_channel_cb(void *cont
 
 /*
  * Callback from vmbus_event when channel is rescinded.
+ * It is meant for rescind of primary channels only.
  */
 static void hv_uio_rescind(struct vmbus_channel *channel)
 {
-	struct hv_device *hv_dev = channel->primary_channel->device_obj;
+	struct hv_device *hv_dev = channel->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
 	/*



