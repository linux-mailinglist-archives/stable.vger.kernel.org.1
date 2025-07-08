Return-Path: <stable+bounces-160489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A0BAFCC58
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65D51AA7A61
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 13:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06525B1EA;
	Tue,  8 Jul 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="q7PMcCMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp95.ord1d.emailsrvr.com (smtp95.ord1d.emailsrvr.com [184.106.54.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457D1F949
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982110; cv=none; b=YgZ4ZDzWvX/3Iq9aMsY42wn/2KJUvK9Ylqj2uCluXiFn//zuYiooNd8/MMsswnFzIw2I3MFpnkkyFwrjhr/qSe4UPePKCurAY2PrQxI67wYTeRm2zj6u1wlWIOpX4iqXVLhJCSOhbkbek6R6Tdsh+83fS/yJDE6PK9k/iAXOKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982110; c=relaxed/simple;
	bh=dxPZ+Fuaa5k1y4O0VEmhEEArJ3pZOb3duRBLFdvU4y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6glBaSmiAX53mDlH2YbOQjkmw6C5VQV4wYsGmyRuLY1m4y5b6Hjiy2P29op8jrAnftPPHTbAYUutFvbAXiDdVc2xEKixfHzn30Q9Bz1tSFYesMuoRrvQxV5AaoTLkyfAkIONuVBFmQd+s1VrWu8+2oD7elgJTB1m6k6cjeNDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=q7PMcCMY; arc=none smtp.client-ip=184.106.54.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1751979996;
	bh=dxPZ+Fuaa5k1y4O0VEmhEEArJ3pZOb3duRBLFdvU4y0=;
	h=From:To:Subject:Date:From;
	b=q7PMcCMYko7/gJnkF+z8FLNgz9c+caLCnd5/vAgpZomXqbQwfnqUrLUULR+dAflON
	 FKD7wkOabS273e2px2viZIxJdYirtUUchubv8W9IiGbsKi/FwT9VRDj3EO3uIwcU2e
	 gwFHHs0o9DM3/i9qXYki45TW4ayAzgvyzTKRBs9E=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A3A6DC01E0;
	Tue,  8 Jul 2025 09:06:35 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Tue,  8 Jul 2025 14:06:27 +0100
Message-ID: <20250708130627.21743-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: fe9b16f4-105d-419e-8554-d2e3f51285c9-1-1

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
Cc: <stable@vger.kernel.org> # 6.15+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch fails to apply to kernels before 6.15, requiring backports.
---
 drivers/comedi/drivers/comedi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.47.2


