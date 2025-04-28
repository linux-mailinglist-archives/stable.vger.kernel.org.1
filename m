Return-Path: <stable+bounces-136925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4779A9F703
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF5817C5D2
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEFD255E52;
	Mon, 28 Apr 2025 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9B/AqVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E222423C
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860410; cv=none; b=nm3E5BuqBzClqYnxbwxxt8a+0cvUGgBDbWD6q4bpCauNrHUCRpUygCzKQxY5jqZnBo1GmarKe6SkLTHynrdYSgW3AYcz++f87X2eQCHX1jZo34zZjunS5Kl+v2h1owaPOI06aWxFmRtsfN+B1lUmYogKQz4R5LWlxu5WPpgF/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860410; c=relaxed/simple;
	bh=VnqkJxJzpqijSYhArabQXW6nRaGYJbFRIEBoM0pniAM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=idsBphFZ9+sMoFqTUo4sbdXxEtJ8y8ilc9G6risvaaX/cDqmo3uWchDPg7J4TfGfovVsC8Omj/O6TeIdGtPxOp9gXU44aEdW2Nm3DNwZdJOnsvv4UJCNISZcGodN175L14R5m76GYeD+1kGgLs9wOdEKj9se6pAORVhBFFzf6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d9B/AqVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FD3C4CEE4;
	Mon, 28 Apr 2025 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860410;
	bh=VnqkJxJzpqijSYhArabQXW6nRaGYJbFRIEBoM0pniAM=;
	h=Subject:To:Cc:From:Date:From;
	b=d9B/AqVbjCAXvsN5YOwaAPFNtbz7JedzitseX2mGWKNrfBbWjfE8SIikbuZC2CeIg
	 T69TA4MHxXId6FFKVWlGAtb2rTCY8zOzvKBG8mnr/kfKKOa6YAolVz6WIxm0fQAhE/
	 fiI5duJeZu6owCLBk/GdajcYgKhdD4HYjRa3C00E=
Subject: FAILED: patch "[PATCH] comedi: jr3_pci: Fix synchronous deletion of timer" failed to apply to 5.4-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:13:08 +0200
Message-ID: <2025042808-vastly-armrest-7811@gregkh>
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
git cherry-pick -x 44d9b3f584c59a606b521e7274e658d5b866c699
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042808-vastly-armrest-7811@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44d9b3f584c59a606b521e7274e658d5b866c699 Mon Sep 17 00:00:00 2001
From: Ian Abbott <abbotti@mev.co.uk>
Date: Tue, 15 Apr 2025 13:39:01 +0100
Subject: [PATCH] comedi: jr3_pci: Fix synchronous deletion of timer

When `jr3_pci_detach()` is called during device removal, it calls
`timer_delete_sync()` to stop the timer, but the timer expiry function
always reschedules the timer, so the synchronization is ineffective.

Call `timer_shutdown_sync()` instead.  It does not matter that the timer
expiry function pointer is cleared, because the device is being removed.

Fixes: 07b509e6584a5 ("Staging: comedi: add jr3_pci driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250415123901.13483-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index cdc842b32bab..75dce1ff2419 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -758,7 +758,7 @@ static void jr3_pci_detach(struct comedi_device *dev)
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
 	if (devpriv)
-		timer_delete_sync(&devpriv->timer);
+		timer_shutdown_sync(&devpriv->timer);
 
 	comedi_pci_detach(dev);
 }


