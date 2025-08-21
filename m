Return-Path: <stable+bounces-171984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C09AB2F888
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1941CE275D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D9311C13;
	Thu, 21 Aug 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8BlpmY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D4311C09
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780136; cv=none; b=MsBWfEncGYHxUcNWHoMhkElNIhmj8hNfU0p5OSlkuNwLzhVWFuN1OJHndlXkLMSOZ6yZDytCo1J2k4DoCiDf6660hVPz5nmogvfdOBr0K8V3x5hOsM6K2uHcYIUR9iDQ0bcF5YeQ+h+XxaTD6ZWGAklVsHuKmIEN4cmmx2VLJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780136; c=relaxed/simple;
	bh=A/CVqSy8UptO+dS0XHl6fmghg7x4QWiz2KsaW7BAi70=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BZHhD/YGsGi5eAd+FEeu56bQOHQ1qjwSTWRjgnr1g3gLwXgUwQbuFgMj6ITqmMQnHYewzpybuRbEq23UQ4++alWBZLYJIf5BDgsNWoc4K7Qick/KHnHkDVeIyO610iUzCWYCiAhaJqqbO/Ep2RQl0NjxApXFg5LkV17XAgSjMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8BlpmY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB37C2BC87;
	Thu, 21 Aug 2025 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780135;
	bh=A/CVqSy8UptO+dS0XHl6fmghg7x4QWiz2KsaW7BAi70=;
	h=Subject:To:Cc:From:Date:From;
	b=y8BlpmY5/UFOS84MEIlc+ZH/+KW7zGa17tHf2UQUd4kuPxcfZFrXXEKJTK7pGFmkW
	 WxZwJj7/JFihGnV7uknt4KGbBgZbmMwlmXs2zvpQ+dC2dm33lZu+crUyGD/S81Ztt/
	 xCfeuzKjMuxLL4KebdQlS9rWIdTKQ1diviP2KSWw=
Subject: FAILED: patch "[PATCH] platform/chrome: cros_ec: Unregister notifier in" failed to apply to 6.1-stable tree
To: tzungbi@kernel.org,bleung@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:42:12 +0200
Message-ID: <2025082112-exemplary-explode-1646@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e2374953461947eee49f69b3e3204ff080ef31b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082112-exemplary-explode-1646@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


