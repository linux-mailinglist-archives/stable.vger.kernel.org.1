Return-Path: <stable+bounces-87001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C19A5D81
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17061C20B09
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C71E0DF3;
	Mon, 21 Oct 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgE90HQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39E1E0B67
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496963; cv=none; b=T7l5kFF1bOoGFYgsSAYK5jcVZt/qSGbAVcbO2WMCRwRV3c6eSVL4meCRGv6yimVwckcGKsaJ973NeIWeKw0+NAGB/LMJjPNzzRpSKBuH3XHt4EwpKDuvV6ktd8OfC1gkYKjaOllRBiihoPL7PYdHqpz7Hel+1bWXLGmnnUS9vFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496963; c=relaxed/simple;
	bh=HWZHUI5832m/TAzuBgFHLZPD8Cj+yBn0HxxYD1EOlKQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VBFTdLfOrcaI3HK4AV0seOP6+GIWDDyKdYiuCXDLtoggu5R/mWIYeFpHOUvmqjOWDsXHsxlYCopYHJP8ntxpd6hyH7mZaSL4DjLZyNaMC8jX5AyM0IlcJ0Iok3fDj+iSU6X9jkYli3Z/Q689GiNAtJ+KHhdNbblLYYOYqSfbY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgE90HQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB1FC4CEC3;
	Mon, 21 Oct 2024 07:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729496963;
	bh=HWZHUI5832m/TAzuBgFHLZPD8Cj+yBn0HxxYD1EOlKQ=;
	h=Subject:To:Cc:From:Date:From;
	b=bgE90HQ/kAmq9vK1NJUkO0D2xfc0k4jXp2zWb/gHxCtow8NN6H4PN1RBAzP7tiAQY
	 7dXvhNh7CiviZGKwKVeH6UQhWdtV6QpKOZF5Dj4gFfEEBj2VC5PI/gAB2s13FIQLJY
	 VYe8nIS7vcriFZuZZrmL0yIEyCIw5el07fL92uLg=
Subject: FAILED: patch "[PATCH] xhci: Mitigate failed set dequeue pointer commands" failed to apply to 5.10-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 09:49:20 +0200
Message-ID: <2024102120-valid-uncured-dcca@gregkh>
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
git cherry-pick -x fe49df60cdb7c2975aa743dc295f8786e4b7db10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102120-valid-uncured-dcca@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe49df60cdb7c2975aa743dc295f8786e4b7db10 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Wed, 16 Oct 2024 16:59:58 +0300
Subject: [PATCH] xhci: Mitigate failed set dequeue pointer commands

Avoid xHC host from processing a cancelled URB by always turning
cancelled URB TDs into no-op TRBs before queuing a 'Set TR Deq' command.

If the command fails then xHC will start processing the cancelled TD
instead of skipping it once endpoint is restarted, causing issues like
Babble error.

This is not a complete solution as a failed 'Set TR Deq' command does not
guarantee xHC TRB caches are cleared.

Fixes: 4db356924a50 ("xhci: turn cancelled td cleanup to its own function")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241016140000.783905-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4d664ba53fe9..7dedf31bbddd 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1023,7 +1023,7 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 					td_to_noop(xhci, ring, cached_td, false);
 					cached_td->cancel_status = TD_CLEARED;
 				}
-
+				td_to_noop(xhci, ring, td, false);
 				td->cancel_status = TD_CLEARING_CACHE;
 				cached_td = td;
 				break;


