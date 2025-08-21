Return-Path: <stable+bounces-171986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F3B2F88A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953AB1CE282D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AC31E104;
	Thu, 21 Aug 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UlFwjIGd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F231076E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780147; cv=none; b=Tx97K3+rYQpbA5ys1xKNrEEf2t1VQpH0TfxQsIJzZsMQtLvWpFoALg9cB05QC2ZxTyuQO1KfRFAtZlV5SFu/nogpPzaH9WbJKed5cyYgQeRUQJJLS2/i3pq2iBVaeu/0BuBQstu3CdVaotuoh4V7xs6VfqSC4xEJSTJkWwudOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780147; c=relaxed/simple;
	bh=u/87tt3WI7v50EJS34B2WZbUL/qC+NjLTE9E29E87mQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ojnhdL+0Gaw76WOtRY+NBy09E3EzHLX31550x7f7YDhTginq8tI+jwj3Xw/WBG/Af1lHYdkhmSrAXtIyoyUE6gEU8jPEXHt32m0gOUyEIQK3TqgOOWsfrD9P1A9Y5e5FGYG3dRC1/rLhvxXJQ4AzQT87KgPf5scAwDh48kN48cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UlFwjIGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED45C4CEEB;
	Thu, 21 Aug 2025 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780146;
	bh=u/87tt3WI7v50EJS34B2WZbUL/qC+NjLTE9E29E87mQ=;
	h=Subject:To:Cc:From:Date:From;
	b=UlFwjIGdHPbwYIKsSMLGIH5MoeDv4tb1iJnZIWYhQWJbOaEVDucmrcFO4kzqTHHyx
	 vwKH6usD3dI7w6WixslCv0129aMxSz7K5Qs09VMRCy6MSGkEuvaSZAoeVC+zn4ByJP
	 uvk2fkd4c83ZgVLou04ECEdRRql1IXp7RRNAymE0=
Subject: FAILED: patch "[PATCH] platform/chrome: cros_ec: Unregister notifier in" failed to apply to 5.10-stable tree
To: tzungbi@kernel.org,bleung@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:42:12 +0200
Message-ID: <2025082112-segment-delta-e613@gregkh>
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
git cherry-pick -x e2374953461947eee49f69b3e3204ff080ef31b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082112-segment-delta-e613@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2374953461947eee49f69b3e3204ff080ef31b1 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@kernel.org>
Date: Tue, 22 Jul 2025 12:05:13 +0000
Subject: [PATCH] platform/chrome: cros_ec: Unregister notifier in
 cros_ec_unregister()

The blocking notifier is registered in cros_ec_register(); however, it
isn't unregistered in cros_ec_unregister().

Fix it.

Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW")
Cc: stable@vger.kernel.org
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://lore.kernel.org/r/20250722120513.234031-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 110771a8645e..fd58781a2fb7 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -318,6 +318,9 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
+	if (ec_dev->mkbp_event_supported)
+		blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+						   &ec_dev->notifier_ready);
 	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
 	mutex_destroy(&ec_dev->lock);


