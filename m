Return-Path: <stable+bounces-167171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353AB22B93
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45FEE4E2462
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84E32C85;
	Tue, 12 Aug 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqd5wc7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28452ED850
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012138; cv=none; b=Lt2f8nEnPTq7H1PzcBXnemEyRXPtdgMu6yFhEFYpaL1BXkcJVgCxrvk5FfQ6fQXr4htwPqoKA7IQ1OCz++uUmFzvkt+Gkm2OUpO/+HJyVO2gCQbrid6ynf/KkUoRtm+aOEvFlrSG/PyWev505KOPeHFg+A2NjschBNajyi25s8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012138; c=relaxed/simple;
	bh=OegmPpfYkMAf9JWqwYqgsu8Xy44T/NAEMoOMmmXN1uY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ftjJ/XpqLFSmoLVYjiVsFe3wi0japBARpJLoUqRwLkk2koqxn4AK4gisBlgk3I3NWLvpkVWB0JFW4SQ7RR71TZij8mEZNkBqOuF3WCDMdfN3/hQFId7ezlPSxqQM7y/lDySAeKbXYDBGh9aFZ1E7xoUq8rJtHPmYNzyQJ0kcz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqd5wc7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DFCC4CEF0;
	Tue, 12 Aug 2025 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755012137;
	bh=OegmPpfYkMAf9JWqwYqgsu8Xy44T/NAEMoOMmmXN1uY=;
	h=Subject:To:Cc:From:Date:From;
	b=hqd5wc7CbecN1WD8k3PkMAnw5zPgn/Pg9KNk/RzmT/GpscFyPbcMB9vizUNmzIkxs
	 CyRMLHWAXCAJMyGJQmypZQf3Jx2wZUUd6L3rXmVWT+ntTsUUz/3LxmAkkoNLgFMrJM
	 JTjSsRblmHvue6Bbdj0nWjNF6ccAkoY2JMyaP5wc=
Subject: FAILED: patch "[PATCH] net: usbnet: Fix the wrong netif_carrier_on() call" failed to apply to 5.4-stable tree
To: ammarfaizi2@gnuweeb.org,horms@kernel.org,sprite@gnuweeb.org,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 17:22:06 +0200
Message-ID: <2025081206-rejoicing-democrat-be9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8466d393700f9ccef68134d3349f4e0a087679b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081206-rejoicing-democrat-be9e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8466d393700f9ccef68134d3349f4e0a087679b9 Mon Sep 17 00:00:00 2001
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Date: Wed, 6 Aug 2025 07:31:05 +0700
Subject: [PATCH] net: usbnet: Fix the wrong netif_carrier_on() call

The commit referenced in the Fixes tag causes usbnet to malfunction
(identified via git bisect). Post-commit, my external RJ45 LAN cable
fails to connect. Linus also reported the same issue after pulling that
commit.

The code has a logic error: netif_carrier_on() is only called when the
link is already on. Fix this by moving the netif_carrier_on() call
outside the if-statement entirely. This ensures it is always called
when EVENT_LINK_CARRIER_ON is set and properly clears it regardless
of the link state.

Cc: stable@vger.kernel.org
Cc: Armando Budianto <sprite@gnuweeb.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com
Closes: https://lore.kernel.org/netdev/CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com
Closes: https://lore.kernel.org/netdev/0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org
Fixes: 0d9cfc9b8cb1 ("net: usbnet: Avoid potential RCU stall on LINK_CHANGE event")
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index a38ffbf4b3f0..511c4154cf74 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1120,6 +1120,9 @@ static void __handle_link_change(struct usbnet *dev)
 	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
 		return;
 
+	if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+		netif_carrier_on(dev->net);
+
 	if (!netif_carrier_ok(dev->net)) {
 		/* kill URBs for reading packets to save bus bandwidth */
 		unlink_urbs(dev, &dev->rxq);
@@ -1129,9 +1132,6 @@ static void __handle_link_change(struct usbnet *dev)
 		 * tx queue is stopped by netcore after link becomes off
 		 */
 	} else {
-		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
-			netif_carrier_on(dev->net);
-
 		/* submitting URBs for reading packets */
 		queue_work(system_bh_wq, &dev->bh_work);
 	}


