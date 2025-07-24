Return-Path: <stable+bounces-164656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B6B110B9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374A11CE83A1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063562EB5D8;
	Thu, 24 Jul 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="ZABj3cXi"
X-Original-To: stable@vger.kernel.org
Received: from smtp113.iad3b.emailsrvr.com (smtp113.iad3b.emailsrvr.com [146.20.161.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447854723
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381030; cv=none; b=m2/BUVovt/FOCGHu7vH17AQLf7Vh92+FFBc2kF89d2Cc2qS5ssXw0Lzh1NkGoS672Nzt0+LpiTtK9QVAbXQp/l1V0gGdoxLIBgwYpbHY8hAe1YuufyR5QVuGqQ+bu0f+IEbbCnyBRkkQqthuDs0qw2gxTb2RyMC6HwD3AUnuFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381030; c=relaxed/simple;
	bh=Leo4xEua+DJmLj7wnbWxNJvIHz1ZVl7kQqMIq7WC2ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLHxO1/aNf7Q1ET1NKgnyKNyTAxUuIWjQmrXr7xeCKsNJvpqK77p2gNywmdIWAcXZJIcMfz1VK8xku7xy3j8dmk3gcZTqZVw3zo4KDVHrkCJVvXCc+maLt2GjhRuUUmBfnN0y/Xh4HZskcP9kBWeHrTdAadAfmRQ7L+RK4QSm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=ZABj3cXi; arc=none smtp.client-ip=146.20.161.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381026;
	bh=Leo4xEua+DJmLj7wnbWxNJvIHz1ZVl7kQqMIq7WC2ss=;
	h=From:To:Subject:Date:From;
	b=ZABj3cXiaE8zHV6FGqEOShepui1teT7l3tSWmvyi+mZD4kMxocifKzkDgZ3Fduty4
	 6lZts3BMhUqj/x04aLYIGZAAq4s8pkq2ct0XKIXBPJ70ZWCws03bzh/ZGjOqi9Gohd
	 lWumpYg08Ism/MQ8uK6GPx81pFtDUGl9UIOG34kU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7C4986019C;
	Thu, 24 Jul 2025 14:17:05 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+cb96ec476fb4914445c9@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
Date: Thu, 24 Jul 2025 19:16:44 +0100
Message-ID: <20250724181646.291939-7-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-7-1

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


