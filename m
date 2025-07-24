Return-Path: <stable+bounces-164682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47738B1111B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126EA161510
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F42ED15E;
	Thu, 24 Jul 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Uk9eopHH"
X-Original-To: stable@vger.kernel.org
Received: from smtp80.iad3b.emailsrvr.com (smtp80.iad3b.emailsrvr.com [146.20.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D262ED15C
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382524; cv=none; b=Ss3qQAdM5rSBvGCJqDoh3ALEonndp7D6gh8gjELPnphWVu8z7pJTNHAxqZG9yADvUUYrth29acXN8J8HQMhSMyhznEjxMnXC9bkZAkgUXBG9nounT9rWyJhnu2PClPblNsB1qkxnXSjGTgimzcElcTNK61VxYZl1/KJS3ylUoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382524; c=relaxed/simple;
	bh=N6AT8f1ihP3IlHberphoq3jL664TKuz/sJnksGXnoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7LBsUnhUPMUbg9sZWSCVzgE3eE0/DqE6huJ66KmSsgC/cmX6i5AaE8carsJyIxloKKTUCy3OlttPqKKjH7TFe6sNWCmHqUdbJdRnC0USSI0iEOiUVoMymBbT33cnDrhrlRi7w/u9J8ZVj1Y7loG+VQwtXtWrk94ghORnGTmU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Uk9eopHH; arc=none smtp.client-ip=146.20.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381351;
	bh=N6AT8f1ihP3IlHberphoq3jL664TKuz/sJnksGXnoUc=;
	h=From:To:Subject:Date:From;
	b=Uk9eopHHLo1+4qN8mMngqE5DhNWuaANTMlyPx9K+kTz8mKjtSfjn8DO6N8tYUdy4g
	 zp5zoct+yrW96Wxf84TOWpg9aKpvT07XO7r+J/4Wy62ZGXHqQzf73tE0dukQVhL6pC
	 NERjVfybb0YP4hngEGNP6qCOjsstIWv86r4SpkrA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 80FCE40118;
	Thu, 24 Jul 2025 14:22:30 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: Fix some signed shift left operations
Date: Thu, 24 Jul 2025 19:22:11 +0100
Message-ID: <20250724182218.292203-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 37f560bb-803e-4662-97aa-d3cd335e777b-2-1

[ Upstream commit ab705c8c35e18652abc6239c07cf3441f03e2cda ]

Correct some left shifts of the signed integer constant 1 by some
unsigned number less than 32.  Change the constant to 1U to avoid
shifting a 1 into the sign bit.

The corrected functions are comedi_dio_insn_config(),
comedi_dio_update_state(), and __comedi_device_postconfig().

Fixes: e523c6c86232 ("staging: comedi: drivers: introduce comedi_dio_insn_config()")
Fixes: 05e60b13a36b ("staging: comedi: drivers: introduce comedi_dio_update_state()")
Fixes: 09567cb4373e ("staging: comedi: initialize subdevice s->io_bits in postconfig")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707121555.65424-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index 750a6ff3c03c..6bb7b8a1e75d 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -339,10 +339,10 @@ int comedi_dio_insn_config(struct comedi_device *dev,
 			   unsigned int *data,
 			   unsigned int mask)
 {
-	unsigned int chan_mask = 1 << CR_CHAN(insn->chanspec);
+	unsigned int chan = CR_CHAN(insn->chanspec);
 
-	if (!mask)
-		mask = chan_mask;
+	if (!mask && chan < 32)
+		mask = 1U << chan;
 
 	switch (data[0]) {
 	case INSN_CONFIG_DIO_INPUT:
@@ -382,7 +382,7 @@ EXPORT_SYMBOL_GPL(comedi_dio_insn_config);
 unsigned int comedi_dio_update_state(struct comedi_subdevice *s,
 				     unsigned int *data)
 {
-	unsigned int chanmask = (s->n_chan < 32) ? ((1 << s->n_chan) - 1)
+	unsigned int chanmask = (s->n_chan < 32) ? ((1U << s->n_chan) - 1)
 						 : 0xffffffff;
 	unsigned int mask = data[0] & chanmask;
 	unsigned int bits = data[1];
@@ -625,8 +625,8 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	if (insn->insn == INSN_WRITE) {
 		if (!(s->subdev_flags & SDF_WRITABLE))
 			return -EINVAL;
-		_data[0] = 1 << (chan - base_chan);		    /* mask */
-		_data[1] = data[0] ? (1 << (chan - base_chan)) : 0; /* bits */
+		_data[0] = 1U << (chan - base_chan);		     /* mask */
+		_data[1] = data[0] ? (1U << (chan - base_chan)) : 0; /* bits */
 	}
 
 	ret = s->insn_bits(dev, s, &_insn, _data);
@@ -709,7 +709,7 @@ static int __comedi_device_postconfig(struct comedi_device *dev)
 
 		if (s->type == COMEDI_SUBD_DO) {
 			if (s->n_chan < 32)
-				s->io_bits = (1 << s->n_chan) - 1;
+				s->io_bits = (1U << s->n_chan) - 1;
 			else
 				s->io_bits = 0xffffffff;
 		}
-- 
2.47.2


