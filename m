Return-Path: <stable+bounces-160371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F8AFB53C
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D04A0FFE
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CD255F28;
	Mon,  7 Jul 2025 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="HeYnO4Dm"
X-Original-To: stable@vger.kernel.org
Received: from smtp79.iad3b.emailsrvr.com (smtp79.iad3b.emailsrvr.com [146.20.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D4298CB1
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896302; cv=none; b=tRB6Fs73f8/v7ULH1zHRUCiIG6hQEy6NqUPOfzW6lN3UWPNjNMYPesNmC6+H4yXK78OLSqdCyvYpstKqOe5Xb9FEnDv41lAoYOiV875qOU8UHOPdysgisKKjdSMQzDXLOMwdXIu4iKI7WSR/HxdUkV44XhpuWA/u3qFKvnGWGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896302; c=relaxed/simple;
	bh=F6TLP7RxSLc86v4OJcnDbSakXy8hmn4QJph5g43BHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RP84tZ3APSHdfjLfyI1hz5/t1PYODnS533DQE69OCwxoA+v8ostQYghJs0Clgdn3aN3dEeB9kftGDc6V9q4fyK63y+tBcu3g603nSnW11SGepSWimxWI/tLpwYxovQ1NZsIn7f/Ob0H9+51HUPCrzhc3LIBAA1UW89TdeyokAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=HeYnO4Dm; arc=none smtp.client-ip=146.20.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1751895279;
	bh=F6TLP7RxSLc86v4OJcnDbSakXy8hmn4QJph5g43BHPY=;
	h=From:To:Subject:Date:From;
	b=HeYnO4Dm8Xhd+Bbh2iV34+oBhCqFY7iPzGPb0/ucHQoNVAAaXyxYYOJVmeAzXS/ih
	 vTT4TX2T5gElT0fbOouzTBgKv2xCMEcSkSv2e289FFQh6PiqtlTE/nRumK+WX/nNu2
	 xcwusHP1gmY1YCAoYvE3vvtHU9cxeNnvyb1kL75I=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp18.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 11B5AE021F;
	Mon,  7 Jul 2025 09:34:38 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	syzbot+32de323b0addb9e114ff@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] comedi: pcl812: Fix bit shift out of bounds
Date: Mon,  7 Jul 2025 14:34:29 +0100
Message-ID: <20250707133429.73202-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 1e8ffcc9-0a2f-41b8-877b-4512870c96d1-1-1

When checking for a supported IRQ number, the following test is used:

	if ((1 << it->options[1]) & board->irq_bits) {

However, `it->options[i]` is an unchecked `int` value from userspace, so
the shift amount could be negative or out of bounds.  Fix the test by
requiring `it->options[1]` to be within bounds before proceeding with
the original test.  Valid `it->options[1]` values that select the IRQ
will be in the range [1,15]. The value 0 explicitly disables the use of
interrupts.

Reported-by: syzbot+32de323b0addb9e114ff@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=32de323b0addb9e114ff
Fixes: fcdb427bc7cf ("Staging: comedi: add pcl821 driver")
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch does not apply cleanly to longterm kernels 5.4.x and 5.10.x.
---
 drivers/comedi/drivers/pcl812.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/pcl812.c b/drivers/comedi/drivers/pcl812.c
index 0df639c6a595..abca61a72cf7 100644
--- a/drivers/comedi/drivers/pcl812.c
+++ b/drivers/comedi/drivers/pcl812.c
@@ -1149,7 +1149,8 @@ static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		if (IS_ERR(dev->pacer))
 			return PTR_ERR(dev->pacer);
 
-		if ((1 << it->options[1]) & board->irq_bits) {
+		if (it->options[1] > 0 && it->options[1] < 16 &&
+		    (1 << it->options[1]) & board->irq_bits) {
 			ret = request_irq(it->options[1], pcl812_interrupt, 0,
 					  dev->board_name, dev);
 			if (ret == 0)
-- 
2.47.2


