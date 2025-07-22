Return-Path: <stable+bounces-164161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8556B0DD82
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F41137B2E25
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E12ED85E;
	Tue, 22 Jul 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2PcF4VW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3C2ED854;
	Tue, 22 Jul 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193449; cv=none; b=CGxxNCnbgy+JsKu3PzzaPu3c5XDzotX6myRGRh8Xl3daJcrsHEzXZTyY8gEJ8MZ0HtajNVasa2nBMlg7xodb3spgA9PN+IkyUEraoz13NdncMqrsoHtP/wtvxXRJ1Z/qICD0TMk4x8Odg/qKJcd/l96d4yGQ1WmJjHlkTUBaKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193449; c=relaxed/simple;
	bh=pKSad+thLNSGiYKHO0GfL4AWn8S/TmyDAlALIxD3Gn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYabsJus4LxiIL3Yvja4xpMhOfeZUdfVu+E3h9T8iqRyjHwMRXbf8DaMVq6I8voEXx7pKaoYP+/wf/3g9BQf0GDkDzrf8lquQHvbW4CMz9DRkncAWGv8g/voQhjCkmx0mplcv5KyP3mleltvf0lc0ohd/AtU03XFoGy/JkSkiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2PcF4VW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A973EC4CEEB;
	Tue, 22 Jul 2025 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193449;
	bh=pKSad+thLNSGiYKHO0GfL4AWn8S/TmyDAlALIxD3Gn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2PcF4VW1I2LIEmQFbYRDLdV4Ya3v9/oLHp7lJuf/huT9WXFWxcl3x7wX5bzU1jQi
	 NmaUtE1g3Fk+ml7zvz62yy0fjGRL8OEXoBmGw3WhyNFVU8mqTXRI2CfxC0icK+m5x3
	 livKnXS9f3BtWmwF3mSvP/K+L6Szjcv4UHIFR7Ig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+cb96ec476fb4914445c9@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.15 095/187] comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
Date: Tue, 22 Jul 2025 15:44:25 +0200
Message-ID: <20250722134349.301568964@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit e9cb26291d009243a4478a7ffb37b3a9175bfce9 upstream.

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
 drivers/comedi/drivers.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -615,6 +615,9 @@ static int insn_rw_emulate_bits(struct c
 	unsigned int _data[2];
 	int ret;
 
+	if (insn->n == 0)
+		return 0;
+
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;



