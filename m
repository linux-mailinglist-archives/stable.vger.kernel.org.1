Return-Path: <stable+bounces-164676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A802B110DC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1695481DF
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C92ECD3C;
	Thu, 24 Jul 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="wmSfppkL"
X-Original-To: stable@vger.kernel.org
Received: from smtp119.iad3b.emailsrvr.com (smtp119.iad3b.emailsrvr.com [146.20.161.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A32701D6
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381627; cv=none; b=jv8MgTt2FH3ToILj9Szgy5CfTPtu1xeZe67i98pQVjbRNfc66kwjkmWxfUI/HuHpAlDr+zU0Wv7oMmWADyROhXeW/FlrNjRFusN+/XidHNNx8DUBNjzvIFXmeZA5Ku7cKSvDCFNqK5l2CbsWPoI38VN0v46bOK2fxdkBGgkOLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381627; c=relaxed/simple;
	bh=N69xt124ke5qNqdC4veBQEMGML5xUc/HiX8S6zvM2DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NddFSJ7YWJqZZ5iRdOlAcJ/X/RGQVfl7j0TVlr0c8GmMwcm+X2EgEMsYOcbe9ldUE7YWHHruY9NeMIRvA9ik71Z9KV5OWI9VCOoUxvan68MM+Z6BoQoCLWN7M/t47bpwTR+xSWHrUOEII1R98Dm43z0qbAN97pWQRC08PuYkOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=wmSfppkL; arc=none smtp.client-ip=146.20.161.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381023;
	bh=N69xt124ke5qNqdC4veBQEMGML5xUc/HiX8S6zvM2DY=;
	h=From:To:Subject:Date:From;
	b=wmSfppkLZCRj9iswJn+WczVvhJFreb/zNYM+tJZgSjUSvMy5is2/AQ6JXKAu0jxXI
	 a88Gi3FF2s57GMM37F7n3F/CYsNEnHZUTIIitn0x1XoKrGzLBsGErEKDmR2BlcahrD
	 B2EOTUkYpaKMqc7iAJxy41HXcsnaKFQvoHZn9C6I=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DF9FF60198;
	Thu, 24 Jul 2025 14:17:02 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+32de323b0addb9e114ff@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: pcl812: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:16:41 +0100
Message-ID: <20250724181646.291939-4-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-4-1

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


