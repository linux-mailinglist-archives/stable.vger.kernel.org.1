Return-Path: <stable+bounces-164680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D839EB110EF
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0127B020E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF42B9B9;
	Thu, 24 Jul 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="mgSZSOo9"
X-Original-To: stable@vger.kernel.org
Received: from smtp80.iad3b.emailsrvr.com (smtp80.iad3b.emailsrvr.com [146.20.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26811DFE22
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381931; cv=none; b=tmjCNH1QCvhCoovP9CyKdL7CJqPpv4xfK/uNZy93PN/N/KZns0jXaa+Ni85Ck4kSf0eFf1inWzEOaxSyX7AejrASbPIBc9q09f1mv4A5rbMWMkRPP4kPY9fpelTaNyEpEGj6G0NTOrorw7qym/x4t4g8R0yaXn8cFw9hVdnXMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381931; c=relaxed/simple;
	bh=IQTIK1y18x7ZjYVmkq/QWvuNn9jhwMU38n3D0efG/mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFaZjZvJXKbz0r4IQlZZCb5bZgAAW+pPIjjwl0PKEL1catWLIjC8Y9Qp130b0krbIA2WbC++osAmMIK4jeE059LGpcT/8iIiZ9z4q0tMLerSLpY7YM8er9fnthfJLBe6lzgXYFSLQtW/Lpdy4v7heE0/RjqvoZrVbWwCGuLwkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=mgSZSOo9; arc=none smtp.client-ip=146.20.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381357;
	bh=IQTIK1y18x7ZjYVmkq/QWvuNn9jhwMU38n3D0efG/mY=;
	h=From:To:Subject:Date:From;
	b=mgSZSOo92mAthEaqSTYoSWS2TfqhT+rA478C7T8Of+KLlmVzfDOsGVXGRvUwHWhId
	 Nj3QdTDmYxsWG/CG8dZJyf/XSKI+1d/fL+iPr2lhmgQ2M7S7hPTuwnM6WBbTP7n1s7
	 VpZZUr2AvBPA4IELGAsdcCx5g7uZmRaX//Qk65E4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9DC0A4019A;
	Thu, 24 Jul 2025 14:22:36 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Thu, 24 Jul 2025 19:22:18 +0100
Message-ID: <20250724182218.292203-9-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 37f560bb-803e-4662-97aa-d3cd335e777b-9-1

[ Upstream commit 1b98304c09a0192598d0767f1eb8c83d7e793091 ]

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
[ changed timer_delete_sync() to del_timer_sync() ]
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/comedi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/comedi_test.c b/drivers/staging/comedi/drivers/comedi_test.c
index 9e60d2a0edc1..7397495de4d6 100644
--- a/drivers/staging/comedi/drivers/comedi_test.c
+++ b/drivers/staging/comedi/drivers/comedi_test.c
@@ -790,7 +790,7 @@ static void waveform_detach(struct comedi_device *dev)
 {
 	struct waveform_private *devpriv = dev->private;
 
-	if (devpriv) {
+	if (devpriv && dev->n_subdevices) {
 		del_timer_sync(&devpriv->ai_timer);
 		del_timer_sync(&devpriv->ao_timer);
 	}
-- 
2.47.2


