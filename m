Return-Path: <stable+bounces-164663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDDB110C8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5FB58855E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4B2ECD3C;
	Thu, 24 Jul 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="h1mewsgb"
X-Original-To: stable@vger.kernel.org
Received: from smtp72.iad3b.emailsrvr.com (smtp72.iad3b.emailsrvr.com [146.20.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6052ECD06
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381322; cv=none; b=pGl7H2meLKLiPwWnvqUOsxzKQXNmC9MqIugVz1t16mmPtXoZx5cfhI2w73j5fA4l1sSwmQeaMUIIW8alG8NqhZl5b2LTaWRllwYyoltTlnkRcMJCwK/APNKSCUAr36ezRizqrXFQtSyF3Ru1V6P9JjN0ltm19fstX/rohdlZ3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381322; c=relaxed/simple;
	bh=HRYY3V5znbUVlnchUPSKUBKCHvTpJLZERQEO9dNuWc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rtjdz/EGjvD2UIHbeBDMCWtHVVV9UPIjpQf9ThhboWxnHZwCe8L7jecUMawAhZLCnWkwnGfSJcdG0exsDjzGx41StnELGB28lONmizd4FxSEKTYfle38UMtCO8aQCoNgECZggPZz6q9On7fxLbPckhQEMMdsIc60y35vp1tHByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=h1mewsgb; arc=none smtp.client-ip=146.20.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753380811;
	bh=HRYY3V5znbUVlnchUPSKUBKCHvTpJLZERQEO9dNuWc8=;
	h=From:To:Subject:Date:From;
	b=h1mewsgbqfMzJnvS4Fp7WOXiAvOihA0SmN2o/4tNZt1dzKKmTHxDLy6zubY+Li3pY
	 i31mNvZCmjAVSnW6bkfMlHvyV+QJ73kupIdJ16N3Cx0MtgWSgpwbX1MdCZjFRAh6Yk
	 czgBXCRxLSNfmOJVZJ05bZ0g0kxvagyhRZAnCHaY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 45FC4E01DB;
	Thu, 24 Jul 2025 14:13:31 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Thu, 24 Jul 2025 19:12:57 +0100
Message-ID: <20250724181257.291722-9-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724181257.291722-1-abbotti@mev.co.uk>
References: <20250724181257.291722-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e379e1bc-6f74-4a9e-9d5c-30262cc57a91-9-1

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
index bea9a3adf08c..f5199474c0e9 100644
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


