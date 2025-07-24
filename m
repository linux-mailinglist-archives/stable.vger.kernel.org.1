Return-Path: <stable+bounces-164674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66546B110DA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497F53ADE1F
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D52ECD0A;
	Thu, 24 Jul 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="md6bhAB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp119.iad3b.emailsrvr.com (smtp119.iad3b.emailsrvr.com [146.20.161.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB932701D6
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381625; cv=none; b=PzkK4YGdhXIX+vf/eoE5znuMCp6lEIHYtSGEXx8pb7NCeRCnpVVA6dg0EmZEnohuOIu66F3CZhSupCLjjfk3aomC9CfqMDbTX75FiCif+mABcocZHtC9f462aW/AwBe3SfKQNR5EuXeBVAv+5yDCM63SB1fUN76gs7r7maufXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381625; c=relaxed/simple;
	bh=N6AT8f1ihP3IlHberphoq3jL664TKuz/sJnksGXnoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n01SDDkKbFMX3ZK7JIJmpum0yMR8Ijd5unDa1QA+QXPxKE+wcnifjctoLLRDIn0mr+Ks8K6ZCxBdFqoRKL/94/oQGa6r7iuj8dcp9A5dgQV+4fX5zKkTKfsNjeUjkU/yZfJ808AInu2osdaIeRys9/wb0bNu7zsUDvfNqZEkR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=md6bhAB6; arc=none smtp.client-ip=146.20.161.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381021;
	bh=N6AT8f1ihP3IlHberphoq3jL664TKuz/sJnksGXnoUc=;
	h=From:To:Subject:Date:From;
	b=md6bhAB6K9YDuk8+rx1lW914XpB9lcq1oerSqgvQzSRnHv6TFInP1f674A8WiJ5NL
	 AmEudNaWWoZHF0ifT+TDQwmLf7dXfHJkFC1mt4nKJYHRkC99prSqI6ZMX0Iezo8kUy
	 Dq/ebqT0cZOay9iBzfnmQfz96o8neWUDMYLF6q0w=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 129A160164;
	Thu, 24 Jul 2025 14:17:00 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: Fix some signed shift left operations
Date: Thu, 24 Jul 2025 19:16:39 +0100
Message-ID: <20250724181646.291939-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-2-1

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


