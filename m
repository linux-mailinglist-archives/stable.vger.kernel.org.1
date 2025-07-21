Return-Path: <stable+bounces-163566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96344B0C2E0
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635501AA0E85
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73F29B772;
	Mon, 21 Jul 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWzi9hG7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3812E7F
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097280; cv=none; b=dWdN5cMGvofU5RMxom9RYjKph/F/EHYHZDV71K7EmLh9arlXGrlCSOvkxp9pi/tBWfOFZOVNTG7+wx1yx/Pro4KW/0OMLkkEi2tdImPSBEUCiO/CpsCL/NwBnyXJscum19ojxNiSICdAbxYd+T2gvUxI7Njcn3MyDLcvW4MkDcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097280; c=relaxed/simple;
	bh=qLW1iXhpzasuvnTlsXZVyZMRvPlRFM/LgXBP+FkDf7k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LPDSJAjNeHmSJ7p5fVXKaIlVJMGtwfmaeHEwX2Qxs1bEz1H00bXxfESd4F2UoWGJLaeaVYPHm0B1cpuH49/XZcpp6VL6c2ZV36fHg9/I5SXVhvIu7PWayb9KdT5A9P1Waw00RbgsGgpY1m+ElzYn8CVmWJi8n4wmsX4fWINzoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWzi9hG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710F5C4CEED;
	Mon, 21 Jul 2025 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753097279;
	bh=qLW1iXhpzasuvnTlsXZVyZMRvPlRFM/LgXBP+FkDf7k=;
	h=Subject:To:Cc:From:Date:From;
	b=YWzi9hG7dnKQzAl+o48KXYIVASnkHqHHu0XjQQ+aiaHkRbDQ+oMpsHJnJRfoBajPb
	 V/A+d5UgWvV6aXcUixUrbx6FdmgLSG8VUYfznNY167BBsnQnAcCajICaJqhGpUh1Hv
	 6C8qIl3Hj/HPylBwlymYIQqQkFVF7reVpvIvxv2Y=
Subject: FAILED: patch "[PATCH] comedi: comedi_test: Fix possible deletion of uninitialized" failed to apply to 6.1-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:27:54 +0200
Message-ID: <2025072154-unchain-champion-e3d6@gregkh>
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
git cherry-pick -x 1b98304c09a0192598d0767f1eb8c83d7e793091
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072154-unchain-champion-e3d6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


