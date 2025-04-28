Return-Path: <stable+bounces-136932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34AA9F728
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C253AD8D6
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24621270EBC;
	Mon, 28 Apr 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="panyLA5t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615422DFAD
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860781; cv=none; b=hKwSW+Yc3TxnYONKMsiKNk1cgrC9V8fiCRUOAaycqyiF9/6HjTeB+RY2e09YoeFiziJZOHWwwJT1WeiROWIBlEWjvz0u53CQWdTiVN4EpOunYj9OZCZ3RgNctzw+UUzGQsPhE9bSWWke9C49asa6RjHKw+mHvM+NIpPq46MC43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860781; c=relaxed/simple;
	bh=+aQ816wWvfVsO/MlWwd3OVMgeFeVN4Nd4YFpTkRTn0E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rwk4LuCFz3ns1sushERuUcuew3DzokgXo4EGTZNY/uJ4NoxpnYz58mpkmqTHpMBFLyMtF9A9Ps7lFPF/5myFLSZ/ULFHudfGFbItbchiK+mbnagv2CaN+cOr0pyWsO0JkkKrwT8UAv7JNhsnblMrv3ky1pcpdJ/vdbO873hLnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=panyLA5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2369C4CEE4;
	Mon, 28 Apr 2025 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860781;
	bh=+aQ816wWvfVsO/MlWwd3OVMgeFeVN4Nd4YFpTkRTn0E=;
	h=Subject:To:Cc:From:Date:From;
	b=panyLA5ty29Zun7Avc2sqqpFTbahtPmOIijYtSbxwlbjvBlCwahV/Wp3fMn0xWzQy
	 HwjHSWXqRPieZHcN0xm8gC3GRSNTH7OfLrCiHKTEti8m/B72Q/IU3w+Uw25Zja/4Bz
	 N8ToyW1Q0AIqlFUHm4BpTVbODVzIDqk/Zi+Gt8Vs=
Subject: FAILED: patch "[PATCH] usb: typec: class: Invalidate USB device pointers on partner" failed to apply to 6.12-stable tree
To: akuchynski@chromium.org,bleung@chromium.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:19:38 +0200
Message-ID: <2025042838-staple-purr-ea46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 66e1a887273c6b89f09bc11a40d0a71d5a081a8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042838-staple-purr-ea46@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66e1a887273c6b89f09bc11a40d0a71d5a081a8e Mon Sep 17 00:00:00 2001
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 21 Mar 2025 14:37:27 +0000
Subject: [PATCH] usb: typec: class: Invalidate USB device pointers on partner
 unregistration

To avoid using invalid USB device pointers after a Type-C partner
disconnects, this patch clears the pointers upon partner unregistration.
This ensures a clean state for future connections.

Cc: stable@vger.kernel.org
Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C partner")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://lore.kernel.org/r/20250321143728.4092417-3-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index eadb150223f8..3df3e3736916 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1086,10 +1086,14 @@ void typec_unregister_partner(struct typec_partner *partner)
 	port = to_typec_port(partner->dev.parent);
 
 	mutex_lock(&port->partner_link_lock);
-	if (port->usb2_dev)
+	if (port->usb2_dev) {
 		typec_partner_unlink_device(partner, port->usb2_dev);
-	if (port->usb3_dev)
+		port->usb2_dev = NULL;
+	}
+	if (port->usb3_dev) {
 		typec_partner_unlink_device(partner, port->usb3_dev);
+		port->usb3_dev = NULL;
+	}
 
 	device_unregister(&partner->dev);
 	mutex_unlock(&port->partner_link_lock);


