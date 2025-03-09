Return-Path: <stable+bounces-121611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5931A58810
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF1A188B98D
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8F13C690;
	Sun,  9 Mar 2025 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIj4Z/pP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93419211C
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741551683; cv=none; b=muB21ryaNa2uT/PoqrN9ImR2f/JJQ7uJfNiuCboxgktgLoTKj3Esy8UC3fIJ4YEU8LGSbF51gEVQTOk8w/S9g4hfPxNnUrtmd83sQxuk0AY6XaZg5TYNBjS85iHZQi3mGeXdg0nmVdRXvenAfGAKxDEt/KYXazacfnvMdGAD0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741551683; c=relaxed/simple;
	bh=LXN9frbHeypIWnoFj07lQznh3fZJGMtoh4Mzlm2gW+0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Tb7tVajiWG7JN4sJKseKpVP+lIc4dm7hJe5yYT48p+43PcD9MnZMY9FvE1CzdSSsO7hwVlCT7BeyHBIgtkyw2ZbNgRIP8jMjpkqlFfWofUZTA0XnOY78b0QZZsoP8zphvZ3WJq2DGYTUbIz8KdZ1Qvf1W+Y4lzKv0Zr69gyLWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIj4Z/pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AE9C4CEE3;
	Sun,  9 Mar 2025 20:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741551683;
	bh=LXN9frbHeypIWnoFj07lQznh3fZJGMtoh4Mzlm2gW+0=;
	h=Subject:To:Cc:From:Date:From;
	b=QIj4Z/pPyjOVF+60Qg4TTteK+51HfVFl9E2ubVoJrlzKoUIYU8BTvXQ7O/cG2Lbfg
	 swLawiF2iJlTVZs//cRnkvRtFGLG8SbPUkzJ9NhCDczR1jFpG9ByJ+c9TqzkNtDvv3
	 s44kIt8ON247fto6FRmjsQQpCwemufufUWIYj+Dw=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Fix NULL pointer access" failed to apply to 6.1-stable tree
To: akuchynski@chromium.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 21:21:20 +0100
Message-ID: <2025030920-fancy-such-266d@gregkh>
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
git cherry-pick -x b13abcb7ddd8d38de769486db5bd917537b32ab1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030920-fancy-such-266d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b13abcb7ddd8d38de769486db5bd917537b32ab1 Mon Sep 17 00:00:00 2001
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Wed, 5 Mar 2025 11:17:39 +0000
Subject: [PATCH] usb: typec: ucsi: Fix NULL pointer access

Resources should be released only after all threads that utilize them
have been destroyed.
This commit ensures that resources are not released prematurely by waiting
for the associated workqueue to complete before deallocating them.

Cc: stable <stable@kernel.org>
Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250305111739.1489003-2-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7a56d3f840d7..2a2915b0a645 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
 
 err_unregister:
 	for (con = connector; con->port; con++) {
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
-		if (con->wq)
-			destroy_workqueue(con->wq);
 
 		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
 		con->port_sink_caps = NULL;
@@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
-		ucsi_unregister_partner(&ucsi->connector[i]);
-		ucsi_unregister_altmodes(&ucsi->connector[i],
-					 UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(&ucsi->connector[i]);
 
 		if (ucsi->connector[i].wq) {
 			struct ucsi_work *uwork;
@@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
 			destroy_workqueue(ucsi->connector[i].wq);
 		}
 
+		ucsi_unregister_partner(&ucsi->connector[i]);
+		ucsi_unregister_altmodes(&ucsi->connector[i],
+					 UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(&ucsi->connector[i]);
+
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
 		ucsi->connector[i].port_sink_caps = NULL;
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);


