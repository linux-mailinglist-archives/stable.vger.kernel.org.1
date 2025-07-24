Return-Path: <stable+bounces-164664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA48FB110C9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6AB588547
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56722EBDD7;
	Thu, 24 Jul 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Y+gADcyW"
X-Original-To: stable@vger.kernel.org
Received: from smtp78.iad3b.emailsrvr.com (smtp78.iad3b.emailsrvr.com [146.20.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA02ECD0A
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381322; cv=none; b=DHQdzGZX7LNEjisOMJdHlg6JQY/mDdrwxG6Gn047kpCMrDOpX0psJ9TD1HUxRw1XyHZTbaiFQ2LRyqiE42UGONYO1CHGkSTfXKYqM1nv7Qc9H2GkWZB69gDDvWMMCr9vEBfYMZkl/FxvpDmHdQteo0srSEg0/WRrEmXsAhgoAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381322; c=relaxed/simple;
	bh=N6AT8f1ihP3IlHberphoq3jL664TKuz/sJnksGXnoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkOBYTOJg1DdlFz8YIUJMkVZ+LIS0R/xg/UZUW3knq1QsjDzL9tHZxcoKZr5xqeqtXnqrcJBK8/e0QTvJ8A/EAHD52+MpyovBr8+CJEP/nSuMM2kPWrEVFfswPCwsQXQ0qLJvhNVfzcLhdbeuXfoF0u8nAMDwlM1ytnrR/fWn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Y+gADcyW; arc=none smtp.client-ip=146.20.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753380805;
	bh=N6AT8f1ihP3IlHberphoq3jL664TKuz/sJnksGXnoUc=;
	h=From:To:Subject:Date:From;
	b=Y+gADcyWDexZ8DP9AeT/dTlg66kiH3E4/9yxBYXbiy4aRAB7NX8pLPaNJFy96USHy
	 djyqNs6wmk0VOa9ygPsBgHTOzsDolHX5rqjqR5op21MoZwRAhafi2Tl5ygZhzixQTk
	 aFJpSnE7jH5MKRAmKVvKEjSiGFyzdyqXx/SU56EM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3E412E0180;
	Thu, 24 Jul 2025 14:13:25 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: Fix some signed shift left operations
Date: Thu, 24 Jul 2025 19:12:50 +0100
Message-ID: <20250724181257.291722-2-abbotti@mev.co.uk>
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
X-Classification-ID: e379e1bc-6f74-4a9e-9d5c-30262cc57a91-2-1

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


