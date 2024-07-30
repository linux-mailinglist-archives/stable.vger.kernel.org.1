Return-Path: <stable+bounces-62713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD9E940DEF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF67B27CD1
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1E195B18;
	Tue, 30 Jul 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qtzdi92z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63752194AF2
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331835; cv=none; b=IIlcvawf96EStWRJMB0c1cwdmA3jash7kmibMtRmp214H69YEQBZJ3X5BI9fgnAXHgobLWS5I8L1boCZFajX2xE3nC1v10PAwyhfL+QJOEfIYJ3lF8wL2c7N/jgPpyxANOGkvUgtOeYLe1LOLn2WqA4p6F1+WCIMMmEDz5m3KYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331835; c=relaxed/simple;
	bh=pPBZ/w95b17pwX591XoK+FDswJGBU67JdW2a59EW1cU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ftHD9JAIJUIU3dFqBufc3KXIZ0QUxKeZvPXU5qZepvCB9xC3QiSLbLWH7BIBa4WurLJkH6bqq2S7DUkv/NIodLac8LCh2/8kd+eOhsfkihWPOC3/AChFZAvUxgfpApg6nKH5xXF3Ox/CLh/JlDNxoD7pk25kqkxY0ood0G6z6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qtzdi92z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2AC4AF0B;
	Tue, 30 Jul 2024 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331834;
	bh=pPBZ/w95b17pwX591XoK+FDswJGBU67JdW2a59EW1cU=;
	h=Subject:To:Cc:From:Date:From;
	b=Qtzdi92zROZvlKncCB1nyU6D8qjyPz75Qkbk/jgzxruzktD6YfjoE9bfOotJTmBj3
	 4+YGwaD1QQL1nTsCTPMWqhVETqx284En0bgwzA/4wujy0PUfTwpaSJ6K7lJOByFXt2
	 eqJgGXvGIoGrzSl2k0JODXjnlmSHBnZGjxzAyTa0=
Subject: FAILED: patch "[PATCH] drm/dp_mst: Fix all mstb marked as not probed after" failed to apply to 5.15-stable tree
To: Wayne.Lin@amd.com,daniel@ffwll.ch,hwentlan@amd.com,imre.deak@intel.com,jani.nikula@intel.com,lyude@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:30:31 +0200
Message-ID: <2024073031-survivor-unaudited-6efd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d63d81094d208abb20fc444514b2d9ec2f4b7c4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073031-survivor-unaudited-6efd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d63d81094d20 ("drm/dp_mst: Fix all mstb marked as not probed after suspend/resume")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d63d81094d208abb20fc444514b2d9ec2f4b7c4e Mon Sep 17 00:00:00 2001
From: Wayne Lin <Wayne.Lin@amd.com>
Date: Wed, 26 Jun 2024 16:48:23 +0800
Subject: [PATCH] drm/dp_mst: Fix all mstb marked as not probed after
 suspend/resume

[Why]
After supend/resume, with topology unchanged, observe that
link_address_sent of all mstb are marked as false even the topology probing
is done without any error.

It is caused by wrongly also include "ret == 0" case as a probing failure
case.

[How]
Remove inappropriate checking conditions.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: stable@vger.kernel.org
Fixes: 37dfdc55ffeb ("drm/dp_mst: Cleanup drm_dp_send_link_address() a bit")
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240626084825.878565-2-Wayne.Lin@amd.com

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7f8e1cfbe19d..68831f4e502a 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2929,7 +2929,7 @@ static int drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* FIXME: Actually do some real error handling here */
 	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
-	if (ret <= 0) {
+	if (ret < 0) {
 		drm_err(mgr->dev, "Sending link address failed with %d\n", ret);
 		goto out;
 	}
@@ -2981,7 +2981,7 @@ static int drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	mutex_unlock(&mgr->lock);
 
 out:
-	if (ret <= 0)
+	if (ret < 0)
 		mstb->link_address_sent = false;
 	kfree(txmsg);
 	return ret < 0 ? ret : changed;


