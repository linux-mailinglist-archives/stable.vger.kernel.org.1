Return-Path: <stable+bounces-163570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F4B0C2E4
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E763BD3D3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C729C32B;
	Mon, 21 Jul 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2f8rUx63"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C929B782
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097299; cv=none; b=ePjkdrj0NB1MurFVh6pNuHxuwBWuYRw7WG+RsoT4dqqJirkgoxLrYWmW+VuX53Ag8dWijO31zJgICNy1rZw0OVG7jLzPDBr3UNlYL2hzH+cYtsAXU4RqdSycQjQ+ZsEi58Nw1Jg2wTa6Bvw0cpidie0YLuACkNfYj/1RN2TqYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097299; c=relaxed/simple;
	bh=XKE5Cs+hauFs9av9HG4Y4hQJGPtlbC02Gr5xdBiyVZs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jgnDGyCqYjpidM/9Xai+ntKArySLAs6eAEYaMG8+mKsjUR41dT5l1CgItj8i0CSnlqN+4Rrq+F1FVKX80hROAY9Nn+BZ2gGfMOzVsos4/1wTXvjo2L7rRN6ncfYIsTSRVdz5xleJmkGByJp/ASzQtKl8jYSlD3YjNxcbBWzLmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2f8rUx63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D7DC4CEF4;
	Mon, 21 Jul 2025 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753097299;
	bh=XKE5Cs+hauFs9av9HG4Y4hQJGPtlbC02Gr5xdBiyVZs=;
	h=Subject:To:Cc:From:Date:From;
	b=2f8rUx63d3ggDOf5Ubs4u/j/SbRPb5+A8rOfrDtT+isw2114PHE9APqUxGaPnPKvQ
	 xbuGAUCPuJznqe5rlcfDFh3JfVZXYZ9zr/fbEEuL6C26WPuLDn9/fBGaWYid1UujIT
	 6yueAyfcjl0AOUb9YXuruxkuIMER2joE1hEv3vKs=
Subject: FAILED: patch "[PATCH] comedi: comedi_test: Fix possible deletion of uninitialized" failed to apply to 5.4-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:27:56 +0200
Message-ID: <2025072156-salt-despair-a696@gregkh>
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
git cherry-pick -x 1b98304c09a0192598d0767f1eb8c83d7e793091
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072156-salt-despair-a696@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


