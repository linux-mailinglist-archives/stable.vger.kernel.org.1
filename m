Return-Path: <stable+bounces-164671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DBB110D0
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463831C23D60
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A552ECD2C;
	Thu, 24 Jul 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="a5j1rh3Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAF2ECD0A
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381363; cv=none; b=OY/QRDCLjsWH6uE4V29nwaElphzrCW9HI+01rUK0lHSJn1YKKi+wd3UTkBTNKyKqd7fz9VoZw/MBXnwlFi73SvhTcP+V+/Wk2YW4y4FG9ncwuNN+Oa5fn/dDVe6uX2oJBuP1XZL3NmSmFAiYi50/G/Db2J+dBPMBZZEw5BsgQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381363; c=relaxed/simple;
	bh=Leo4xEua+DJmLj7wnbWxNJvIHz1ZVl7kQqMIq7WC2ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRAWGNEkAaBMkumBHwy6Eq7NxmvvKZXl67wYkDb75LbR6UYEatmUKBMxeCVFwSrHRl+M/mxvNnm199IYLTg9gazLX5xx/xgIl0250AGEsw0X4HKTymE3tXuYig7VmnoPHA9tXgsELMnCrjlG/3XW/L5zYIkbiR1GeMy8NPXfaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=a5j1rh3Z; arc=none smtp.client-ip=146.20.161.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381355;
	bh=Leo4xEua+DJmLj7wnbWxNJvIHz1ZVl7kQqMIq7WC2ss=;
	h=From:To:Subject:Date:From;
	b=a5j1rh3ZRfoATxelv0FTn5ihVsP2QhLrfoVaem9N99ikwyjzFWfEomW+h/MM/ZCig
	 IoX4MfQTlzvEciojoGSbsafBkv3/of2Za8PHSkMdV02HsKMumFhyv9Uu377sVv2fTI
	 SHvRnS5jPUFhO9vB0nSdVls02oQShj1Ar67I4Pgc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DEB284017D;
	Thu, 24 Jul 2025 14:22:34 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+cb96ec476fb4914445c9@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
Date: Thu, 24 Jul 2025 19:22:16 +0100
Message-ID: <20250724182218.292203-7-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 37f560bb-803e-4662-97aa-d3cd335e777b-7-1

[ Upstream commit e9cb26291d009243a4478a7ffb37b3a9175bfce9 ]

For Comedi `INSN_READ` and `INSN_WRITE` instructions on "digital"
subdevices (subdevice types `COMEDI_SUBD_DI`, `COMEDI_SUBD_DO`, and
`COMEDI_SUBD_DIO`), it is common for the subdevice driver not to have
`insn_read` and `insn_write` handler functions, but to have an
`insn_bits` handler function for handling Comedi `INSN_BITS`
instructions.  In that case, the subdevice's `insn_read` and/or
`insn_write` function handler pointers are set to point to the
`insn_rw_emulate_bits()` function by `__comedi_device_postconfig()`.

For `INSN_WRITE`, `insn_rw_emulate_bits()` currently assumes that the
supplied `data[0]` value is a valid copy from user memory.  It will at
least exist because `do_insnlist_ioctl()` and `do_insn_ioctl()` in
"comedi_fops.c" ensure at lease `MIN_SAMPLES` (16) elements are
allocated.  However, if `insn->n` is 0 (which is allowable for
`INSN_READ` and `INSN_WRITE` instructions, then `data[0]` may contain
uninitialized data, and certainly contains invalid data, possibly from a
different instruction in the array of instructions handled by
`do_insnlist_ioctl()`.  This will result in an incorrect value being
written to the digital output channel (or to the digital input/output
channel if configured as an output), and may be reflected in the
internal saved state of the channel.

Fix it by returning 0 early if `insn->n` is 0, before reaching the code
that accesses `data[0]`.  Previously, the function always returned 1 on
success, but it is supposed to be the number of data samples actually
read or written up to `insn->n`, which is 0 in this case.

Reported-by: syzbot+cb96ec476fb4914445c9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb96ec476fb4914445c9
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707153355.82474-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index 6bb7b8a1e75d..ced660663f0d 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -615,6 +615,9 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	unsigned int _data[2];
 	int ret;
 
+	if (insn->n == 0)
+		return 0;
+
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;
-- 
2.47.2


