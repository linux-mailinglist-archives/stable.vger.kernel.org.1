Return-Path: <stable+bounces-160379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9D0AFB806
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C501AA4AA4
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B24202963;
	Mon,  7 Jul 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="AEjLoP8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp99.iad3a.emailsrvr.com (smtp99.iad3a.emailsrvr.com [173.203.187.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B231E2614
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903509; cv=none; b=FZS0Zxvxzvqc2ktNm+5Cr0aHv3Azw9IMtgkEzEtyr/mnb6opxCme7Stesm7UheB9wxUWtyuWPmRHaKVOvPsYtxz0Zqc6/r4X9eTGEAq40w6tw+QDr4p0H32Xb7rti7lNnod7bPMNiTN7Dvz7aSCYcuxizARsNgOos0dckc2Kd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903509; c=relaxed/simple;
	bh=FDDpW0WZ2LFiLbJb4SDzEsmW+vtcbA/gyC5BQi9dUwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igA4GxRjfgdPNzMxt9y3ewcNDMiEUIcueJqYQrO7ndPJewLjnzV1dZK2jJJhOs/RPHscv6ODjiuqZfvsawiUvhK1yhLGQiO/IQzYuYAKh7MDFHnPe64Z/+RA1M3M5xnPU6atei/NxGr/XVMsGJCBaEd7COBMSkkbZje7ubnV87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=AEjLoP8Y; arc=none smtp.client-ip=173.203.187.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1751902445;
	bh=FDDpW0WZ2LFiLbJb4SDzEsmW+vtcbA/gyC5BQi9dUwE=;
	h=From:To:Subject:Date:From;
	b=AEjLoP8Yf23WBgsUK3eRysE19vpYr0MMTbY7oG95evb2GUyDfUoDA0GFVTbIoC6Nt
	 sngvqIBiwcVvUCzSx+ahfPfnCoYSHLqsWM+lCVepc3shqilwsU4/lUI4JDlLpBWQvL
	 Gt6qI4rL0O7HU1UjUJ4OYZXwu7HE3vZJuRJ9G884=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp21.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 831C725201;
	Mon,  7 Jul 2025 11:34:04 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	syzbot+cb96ec476fb4914445c9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
Date: Mon,  7 Jul 2025 16:33:54 +0100
Message-ID: <20250707153355.82474-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 5fedf41f-a809-4e1b-bf14-73450e5f5c67-1-1

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
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch does not apply cleanly to longterm kernels 5.4.x and 5.10.x.
---
 drivers/comedi/drivers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 376130bfba8a..98e565088289 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
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


