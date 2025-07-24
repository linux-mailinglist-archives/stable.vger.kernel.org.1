Return-Path: <stable+bounces-164666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE027B110CB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE65E588500
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E82ECD3F;
	Thu, 24 Jul 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="OfkuWFk3"
X-Original-To: stable@vger.kernel.org
Received: from smtp79.iad3b.emailsrvr.com (smtp79.iad3b.emailsrvr.com [146.20.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD72ECD1B
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381330; cv=none; b=XJ18IQNbOBwSnLpT+c2uduHh9fJ03XKPJQgQmJ2+emc4Des3A56RjRD4BysKoi+DDjXFuZfmWjlV3DtfjOvtAbk5xCSE823syeFyozkN1oUP5KoSmqepn6PmAVnAkySgc1fM/jP0iNNZ1uR91yn5sks1STXmJiZITRNyuEeSsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381330; c=relaxed/simple;
	bh=N69xt124ke5qNqdC4veBQEMGML5xUc/HiX8S6zvM2DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7wV3L4lkTfgr3Rr9L+qTPK7S6iL7RJanBTEy7iwBYY91YL3BKfU/eVU79dpsXTO3KDWFwuE81HTOj1/DyAVr0pZ0FFp55RBUKE/lNAVVaO765CpUIDk2gRdWpx0pRTzQeC6hbk288e3ygQu5V7i3jAmBn6aC0mpOxWrJvHaCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=OfkuWFk3; arc=none smtp.client-ip=146.20.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753380807;
	bh=N69xt124ke5qNqdC4veBQEMGML5xUc/HiX8S6zvM2DY=;
	h=From:To:Subject:Date:From;
	b=OfkuWFk3bAH0I08Yr3NfuEGbhoeJH8J/Ddh9baH8BGgifZFN2XiN7AeX0VN8yomS6
	 oPBvHykaeC6UThRcwpzez6PmUvnp0I7XQ2t35BdHQ2z66ABkHU9LuUC4uXhXABHMcY
	 LirTJUIDrYY2heY414vdPGUfVrHynZtvfhTex/YU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0FA2FE01C8;
	Thu, 24 Jul 2025 14:13:26 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+32de323b0addb9e114ff@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: pcl812: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:12:52 +0100
Message-ID: <20250724181257.291722-4-abbotti@mev.co.uk>
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
X-Classification-ID: e379e1bc-6f74-4a9e-9d5c-30262cc57a91-4-1

[ Upstream commit b14b076ce593f72585412fc7fd3747e03a5e3632 ]

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
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707133429.73202-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/pcl812.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/pcl812.c b/drivers/staging/comedi/drivers/pcl812.c
index b87ab3840eee..fc06f284ba74 100644
--- a/drivers/staging/comedi/drivers/pcl812.c
+++ b/drivers/staging/comedi/drivers/pcl812.c
@@ -1151,7 +1151,8 @@ static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		if (!dev->pacer)
 			return -ENOMEM;
 
-		if ((1 << it->options[1]) & board->irq_bits) {
+		if (it->options[1] > 0 && it->options[1] < 16 &&
+		    (1 << it->options[1]) & board->irq_bits) {
 			ret = request_irq(it->options[1], pcl812_interrupt, 0,
 					  dev->board_name, dev);
 			if (ret == 0)
-- 
2.47.2


