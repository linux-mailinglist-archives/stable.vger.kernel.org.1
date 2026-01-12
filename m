Return-Path: <stable+bounces-208093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCC6D11F96
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24BE30D1BD4
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE231AA9B;
	Mon, 12 Jan 2026 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+nbMjJT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387527A123
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214513; cv=none; b=CnDXEYADB49NeoI6bFwuwbJUGD96bN6FCCj0Kuq4m/yVg44Cu48j9gIQvwlheOVMtcDT1y5pC6lQkddNIRm/rFcMy4AUW1SPTdAwqVI3VdhyDh5TNuyRsdirFUqIkuWb9TqejtMmWs/fjDG6lQrgWrxy7xLSqhLKBYy8z/9fE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214513; c=relaxed/simple;
	bh=P+iil04i8li4TRA36yB/DoHAr8Jr6Xm/9L4drTYKxxY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mUrC6Bq0Eg2FejB2G31FN03aI+osqPIZy6utXHpADuNwhH/k22yqPnQbk3VIWt+7m6dDJ+n60RbAiMnMJXJTUOJtHgy6KqpoNNP4LnIN8Q5swVy8i6C47ZL+J0X2uJacwzJ0CIvl1Up4EbAPeDdZsQAqBYEv/sL40uU7yKE28fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+nbMjJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380E1C19421;
	Mon, 12 Jan 2026 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214512;
	bh=P+iil04i8li4TRA36yB/DoHAr8Jr6Xm/9L4drTYKxxY=;
	h=Subject:To:Cc:From:Date:From;
	b=O+nbMjJTxKamriXV0nF+m/KRfk9qpDYORmjMORjsCkgW2x+pAvRFpOMqYJBb8Q1V0
	 MBN+ldhlMmfULofjIO4zrGKJGGOkM9e5gkVw6qw+wnDjR1+corTnbQ0KU483UJWB6N
	 2sIuMxWQLmW2GLDNm8dQF0m0MsIg9YJJIHRTtMng=
Subject: FAILED: patch "[PATCH] ALSA: ac97: fix a double free in" failed to apply to 6.6-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:41:39 +0100
Message-ID: <2026011239-sustained-underpass-b703@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 830988b6cf197e6dcffdfe2008c5738e6c6c3c0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011239-sustained-underpass-b703@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


