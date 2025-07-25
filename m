Return-Path: <stable+bounces-164741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF505B11FF5
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD70956628B
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE3F1E5B70;
	Fri, 25 Jul 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="XAo7NM2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp126.iad3a.emailsrvr.com (smtp126.iad3a.emailsrvr.com [173.203.187.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAD1E86E;
	Fri, 25 Jul 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453008; cv=none; b=s0oZdt1UDQVpJATMMIlZ8VZcaM0hKCwYQFVD7rXgeO22qFoIyyYk2ZMIgTrgq9AFcDw8yW3ixJCFLaJDdH9UWbCNrQLOLS2c2VEtK2IQ6vwS+ybmgRMWcdcJebH0O4xAW4FIqdw7Ajfxey5ayUtRkfveAMgOi5twasAf1FPB+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453008; c=relaxed/simple;
	bh=ROLl58S+gJn/fUlsYyFBY1CY+gNDyUCGFs17XipEzP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plpHY723eLdPb/+nsd0zln/EjaHFOK9ctnC9dk1PWMfXIj6xWOhIQ3d0oJkBf/sKPhCWuO9hm4KUbtYOV1C6Ahqd3KNvnYfHELPiu/SkISiOt3Qt90ayaHvwVJsHm5UnB6IrgnaA2amOgESLfJqzt/YosMhCsEzVo0dMr2FpNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=XAo7NM2g; arc=none smtp.client-ip=173.203.187.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753452644;
	bh=ROLl58S+gJn/fUlsYyFBY1CY+gNDyUCGFs17XipEzP4=;
	h=From:To:Subject:Date:From;
	b=XAo7NM2gg0RCt1UO0i718dYffzgkoMzIHTpa0Oy6ODLRKIiJEa5UWhi71VAYX6PqH
	 RDPHp2IG9oFTMl9ZQG6yaIKIPT3F/U4fkYW9s2QBwyMAB/OoqKiRV1TaIVv8whgxqf
	 Y4SqeGlZ3zddUguroZzFLWRM3jt5jK7Op2yKYw+0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 24C2C50C5;
	Fri, 25 Jul 2025 10:10:44 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: Make insn_rw_emulate_bits() do insn->n samples
Date: Fri, 25 Jul 2025 15:10:34 +0100
Message-ID: <20250725141034.87297-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 27552962-6841-452b-823c-acad1dc1325a-1-1

The `insn_rw_emulate_bits()` function is used as a default handler for
`INSN_READ` instructions for subdevices that have a handler for
`INSN_BITS` but not for `INSN_READ`.  Similarly, it is used as a default
handler for `INSN_WRITE` instructions for subdevices that have a handler
for `INSN_BITS` but not for `INSN_WRITE`. It works by emulating the
`INSN_READ` or `INSN_WRITE` instruction handling with a constructed
`INSN_BITS` instruction.  However, `INSN_READ` and `INSN_WRITE`
instructions are supposed to be able read or write multiple samples,
indicated by the `insn->n` value, but `insn_rw_emulate_bits()` currently
only handles a single sample.  For `INSN_READ`, the comedi core will
copy `insn->n` samples back to user-space.  (That triggered KASAN
kernel-infoleak errors when `insn->n` was greater than 1, but that is
being fixed more generally elsewhere in the comedi core.)

Make `insn_rw_emulate_bits()` either handle `insn->n` samples, or return
an error, to conform to the general expectation for `INSN_READ` and
`INSN_WRITE` handlers.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
For 5.4.y and 5.10.y, this patch conflicts with submitted patches for
upstream commit e9cb26291d00 ("comedi: Fix use of uninitialized data in
insn_rw_emulate_bits()").
---
 drivers/comedi/drivers.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index f1dc854928c1..c9ebaadc5e82 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -620,11 +620,9 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	unsigned int chan = CR_CHAN(insn->chanspec);
 	unsigned int base_chan = (chan < 32) ? 0 : chan;
 	unsigned int _data[2];
+	unsigned int i;
 	int ret;
 
-	if (insn->n == 0)
-		return 0;
-
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;
@@ -635,18 +633,21 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	if (insn->insn == INSN_WRITE) {
 		if (!(s->subdev_flags & SDF_WRITABLE))
 			return -EINVAL;
-		_data[0] = 1U << (chan - base_chan);		     /* mask */
-		_data[1] = data[0] ? (1U << (chan - base_chan)) : 0; /* bits */
+		_data[0] = 1U << (chan - base_chan);		/* mask */
 	}
+	for (i = 0; i < insn->n; i++) {
+		if (insn->insn == INSN_WRITE)
+			_data[1] = data[i] ? _data[0] : 0;	/* bits */
 
-	ret = s->insn_bits(dev, s, &_insn, _data);
-	if (ret < 0)
-		return ret;
+		ret = s->insn_bits(dev, s, &_insn, _data);
+		if (ret < 0)
+			return ret;
 
-	if (insn->insn == INSN_READ)
-		data[0] = (_data[1] >> (chan - base_chan)) & 1;
+		if (insn->insn == INSN_READ)
+			data[i] = (_data[1] >> (chan - base_chan)) & 1;
+	}
 
-	return 1;
+	return insn->n;
 }
 
 static int __comedi_device_postconfig_async(struct comedi_device *dev,
-- 
2.47.2


