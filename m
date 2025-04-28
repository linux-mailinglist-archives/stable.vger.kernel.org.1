Return-Path: <stable+bounces-136922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BBA9F711
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438575A704C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C6928CF48;
	Mon, 28 Apr 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YnIgMvFi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8E28BA9E
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860402; cv=none; b=ad33dUba4C0qXptvX7rUsoYo5D6JjRIZd+lZZxr9ac/bniYp4DLfmgmhGL0A2J4LpEtKJV+TTlq/u4/bWkiQ2U7lD/9YW+CiyNW3HsOyV9ARy0NitsUIRNquBP+64QK4H+wNl/JkWgvkFmRSKuyyR2YjURWR9HzomGl0b13qHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860402; c=relaxed/simple;
	bh=mtaHOxQG7hsCnvI+mq7Na/coopywkNamDNEKJqvzgmk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GuPMbO382JON0Uv4Fc29wmGkGagAGwiX2kKKUwUn1+kkepL5OqHbADb/JLQIV/tAAEJDPerSm03D48VQLkZb7187PGy8PHhl4DaDAfh9aKIaZX7f0mduI7X+rfxVYab/9jdNxpgclREWEUq5GWg35N8wZxzHk1hA2YwThCPB7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YnIgMvFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9AAC4CEEC;
	Mon, 28 Apr 2025 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860400;
	bh=mtaHOxQG7hsCnvI+mq7Na/coopywkNamDNEKJqvzgmk=;
	h=Subject:To:Cc:From:Date:From;
	b=YnIgMvFi106+pdEr+uD6BCs+o+RcbLWCkyhuQn84OHc05eguI5JDSJ1PylBF3jtUn
	 xm51ge1t5/XjzjmVQIw5/fvasqSNK/cX2ZGt8RzJP3X7SNdZrSAyyxP0WyQoIiQhIx
	 yCBbk+1u6VyeOyRH7SzaMmrIVQgH/az6lMmvfZUI=
Subject: FAILED: patch "[PATCH] comedi: jr3_pci: Fix synchronous deletion of timer" failed to apply to 6.12-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:13:06 +0200
Message-ID: <2025042806-snowy-deftly-db68@gregkh>
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
git cherry-pick -x 44d9b3f584c59a606b521e7274e658d5b866c699
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042806-snowy-deftly-db68@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


