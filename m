Return-Path: <stable+bounces-75371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9260A973433
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B2728C72F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3218EFE4;
	Tue, 10 Sep 2024 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ehVTliyX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5218C913;
	Tue, 10 Sep 2024 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964537; cv=none; b=FWNIQnt4EU64MOrsC33OdqdODCyjdelCVvYwL6iGjwQ+8MyfjuMxjBCcq9uctgg2LVHSpqC7fsxDenUFjvDOMVAMlb3/dhw5XofQiEcxTVhwhBrNU2ewNzp7EpyIGzuYjQux5sP1BmmzfH6/IZC8IJSLwE2q1GxGOKGJ1LN33wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964537; c=relaxed/simple;
	bh=yon1wladcf0lKJSdUINJUIu49aKyNATIp2dgwv08/IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0suvrl+1F89NJUFjZPFECzB6CZssGXevVaZZkyroG2dRd41jZSNKgfBP3HU8YsNOUXrCyQoJ8xZxXyy6CSUFakUfRVpd2Fduac2fT8PX60qUQp/YfzUYi1xZrXzYl7r2GamxVVM7tbTzKex6yXqNufWFdy+Up4/zvc+Vj+HBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ehVTliyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B63FC4CEC3;
	Tue, 10 Sep 2024 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964537;
	bh=yon1wladcf0lKJSdUINJUIu49aKyNATIp2dgwv08/IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehVTliyX3+/2Av+mHmKp0UH0r1fL9UnwLuvDInGM5DQ2Ktt3MkYByaiQU6KacgHJg
	 PKMJP5PFSpPyEYW8R4DyqM36BYMwVdonOElpYFYkIVuqjlKLp2sE7J5TVl6p7h+tsZ
	 X+FncjcScMfTSDEqtgtcjiKq0itXYnVAkQa+ld08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH 6.6 217/269] uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind
Date: Tue, 10 Sep 2024 11:33:24 +0200
Message-ID: <20240910092615.722491763@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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



