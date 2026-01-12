Return-Path: <stable+bounces-208094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2476D11F99
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47ADC30D3AF5
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259E31AA9B;
	Mon, 12 Jan 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VTYKqo53"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827A27A123
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214515; cv=none; b=JU1dyKUJShWdc63YaZtzHrklu6WpVKYAr5+ws8iq7QRIDfLl6WlfIAXqHRxQz90HmdJwL2YZX0HZYHnAE9Xjwy2Lg1vfASZn+UsFJ8vemBLQpXO9HztBSZ9crOvcwEVVH5RbrfavaVAuwRYPAZ55yUYqI24OKR2MEtmELQx2PmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214515; c=relaxed/simple;
	bh=uzdz3dxitLGYIir8G/09NbKsBhB4jBNT0/oSozVF0TQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gLkIMR114x+6AJ9pb2CnsbI4Tiv5w4o1E1fLfxiA+I+1lS8N2SeOThenoJ3uzlDqaXOtIUdf5KIRL2IKLi/tffg5uymOo4HvpVztk3Vh6pLa29TKncN6FP5QlGd7T0OQ9CQgG8MCKo9wzu95kISY8sB+7l+q3dflpP3nce+7Yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VTYKqo53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02ACC16AAE;
	Mon, 12 Jan 2026 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214515;
	bh=uzdz3dxitLGYIir8G/09NbKsBhB4jBNT0/oSozVF0TQ=;
	h=Subject:To:Cc:From:Date:From;
	b=VTYKqo53r6AcVCwjxHHcShsl8oeMyJv+QF6bZohinXMseg+AUxLDGgcuAaZshHKdR
	 lt8UFjhoON6bxqKNLY3SUZh1er2daOXNnMMfXQBkKeDRBFWfTMsaCqjXnSCh8MsAUJ
	 FLfucA5NLC6gOagCSnj8gC21oCMqbh+REYDbpmBs=
Subject: FAILED: patch "[PATCH] ALSA: ac97: fix a double free in" failed to apply to 5.10-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:41:40 +0100
Message-ID: <2026011240-gaming-kiln-4da4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 830988b6cf197e6dcffdfe2008c5738e6c6c3c0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011240-gaming-kiln-4da4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 830988b6cf197e6dcffdfe2008c5738e6c6c3c0f Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Sat, 20 Dec 2025 00:28:45 +0800
Subject: [PATCH] ALSA: ac97: fix a double free in
 snd_ac97_controller_register()

If ac97_add_adapter() fails, put_device() is the correct way to drop
the device reference. kfree() is not required.
Add kfree() if idr_alloc() fails and in ac97_adapter_release() to do
the cleanup.

Found by code review.

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Link: https://patch.msgid.link/20251219162845.657525-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index f4254703d29f..bb9b795e0226 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -298,6 +298,7 @@ static void ac97_adapter_release(struct device *dev)
 	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
 	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
 		dev_name(ac97_ctrl->parent));
+	kfree(ac97_ctrl);
 }
 
 static const struct device_type ac97_adapter_type = {
@@ -319,7 +320,9 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 		ret = device_register(&ac97_ctrl->adap);
 		if (ret)
 			put_device(&ac97_ctrl->adap);
-	}
+	} else
+		kfree(ac97_ctrl);
+
 	if (!ret) {
 		list_add(&ac97_ctrl->controllers, &ac97_controllers);
 		dev_dbg(&ac97_ctrl->adap, "adapter registered by %s\n",
@@ -361,14 +364,11 @@ struct ac97_controller *snd_ac97_controller_register(
 	ret = ac97_add_adapter(ac97_ctrl);
 
 	if (ret)
-		goto err;
+		return ERR_PTR(ret);
 	ac97_bus_reset(ac97_ctrl);
 	ac97_bus_scan(ac97_ctrl);
 
 	return ac97_ctrl;
-err:
-	kfree(ac97_ctrl);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(snd_ac97_controller_register);
 


