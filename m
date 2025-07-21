Return-Path: <stable+bounces-163567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44148B0C2E1
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C087A3D4C
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A944F29B229;
	Mon, 21 Jul 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xZdPDKLr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943B12E7F
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097283; cv=none; b=TpyNNJZRolERy0tDQ8B/mIetOMVA4qktfmDc3YOyV9GM2QR7V215CXgItDjNID1bv3fYXlr1GDgFcJJzbVksvvdIkdQoyfVQtQyN58d9FOkk3dhhlqWyhz9rzPdVZvDIUNBLjlGaN8DLpbKHA4fJvLcWRwGp2LbjsLQlkhlGHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097283; c=relaxed/simple;
	bh=PaFyylPwe33zoO+3o2nBH7wZ+n5rLca+p2yJsH/udW0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HiNAc9UD5YXCUASpHrF4JDhcDHinzXHQi8JbgoU+7yMM0YUD3EGQVXjIGGKOw7e71O336BzIpMQ0wRS4Q/DFBZPUe6mdXkQD+Zh2piMzljeznd7sPgazEt/OGGFYnHB+e1oGCzVBiGeroHJ8GsCbhpcWRY3nlgAC8FRIN0VAkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xZdPDKLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4DCC4CEF1;
	Mon, 21 Jul 2025 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753097283;
	bh=PaFyylPwe33zoO+3o2nBH7wZ+n5rLca+p2yJsH/udW0=;
	h=Subject:To:Cc:From:Date:From;
	b=xZdPDKLrF/CMsQL+cmLtfbiXA6zZ7jhsPOYX/7Q7uHEyg6SLIkZL0z6lFfi+7Be1F
	 QINNc/WYvYDbLh6BB8LjPH7niBSIBxVexFC6eiJ7nIzBhXmTWFzFYFMxYfrfBZw+gh
	 6G2QZhdPPPcR+axUj3mWEFKbArcTlacJAEQB+1D8=
Subject: FAILED: patch "[PATCH] comedi: comedi_test: Fix possible deletion of uninitialized" failed to apply to 6.6-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:27:54 +0200
Message-ID: <2025072153-splinter-buckshot-87f5@gregkh>
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
git cherry-pick -x 1b98304c09a0192598d0767f1eb8c83d7e793091
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072153-splinter-buckshot-87f5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b98304c09a0192598d0767f1eb8c83d7e793091 Mon Sep 17 00:00:00 2001
From: Ian Abbott <abbotti@mev.co.uk>
Date: Tue, 8 Jul 2025 14:06:27 +0100
Subject: [PATCH] comedi: comedi_test: Fix possible deletion of uninitialized
 timers

In `waveform_common_attach()`, the two timers `&devpriv->ai_timer` and
`&devpriv->ao_timer` are initialized after the allocation of the device
private data by `comedi_alloc_devpriv()` and the subdevices by
`comedi_alloc_subdevices()`.  The function may return with an error
between those function calls.  In that case, `waveform_detach()` will be
called by the Comedi core to clean up.  The check that
`waveform_detach()` uses to decide whether to delete the timers is
incorrect.  It only checks that the device private data was allocated,
but that does not guarantee that the timers were initialized.  It also
needs to check that the subdevices were allocated.  Fix it.

Fixes: 73e0e4dfed4c ("staging: comedi: comedi_test: fix timer lock-up")
Cc: stable@vger.kernel.org # 6.15+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250708130627.21743-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 9747e6d1f6eb..7984950f0f99 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -792,7 +792,7 @@ static void waveform_detach(struct comedi_device *dev)
 {
 	struct waveform_private *devpriv = dev->private;
 
-	if (devpriv) {
+	if (devpriv && dev->n_subdevices) {
 		timer_delete_sync(&devpriv->ai_timer);
 		timer_delete_sync(&devpriv->ao_timer);
 	}


