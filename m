Return-Path: <stable+bounces-164684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0FB11119
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A976AA6FB0
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D302EBB8F;
	Thu, 24 Jul 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="PPEjZpUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp116.iad3b.emailsrvr.com (smtp116.iad3b.emailsrvr.com [146.20.161.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262642ECE8D
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382531; cv=none; b=OHoqSwueuRMwyrccUp0HSS7azgnxLMYPLVJ7uyGAEewAOPoYgRKbBGNLCyEnMVzxIRHs6iHs7o6QFV+zNWNHEvXeBcgblK0a+e8qu/SSFrzbG9X949LC8gZiCD+dmGWXk0uKbTom2C8NuhxgSz3+DH9jKawVOLstJhWETRPzbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382531; c=relaxed/simple;
	bh=Got3kUBn8nFZhKRyOgM/UuoHCCHUsCnDPMSH4QXzBG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6gUxWjPbzovl4idZdw+UVdxyAuo7ts50B2JT1BL5n8wHDa4IpyDWA1+IBoQx4cDBhcLg9mIUDWYEUiPoxVUM+ZwzVJK+wamS2ZNQO89u1BLzsOzvQdCcdjSoVcw7G25wzzP4pf4Uog/4Rc/N51MWaKIEg8tqRzxhuyH3dVv0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=PPEjZpUt; arc=none smtp.client-ip=146.20.161.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381020;
	bh=Got3kUBn8nFZhKRyOgM/UuoHCCHUsCnDPMSH4QXzBG0=;
	h=From:To:Subject:Date:From;
	b=PPEjZpUt2PDKd//k81g0lJ8I12D0EwlPMkMzfLTbOBh43Za+cSor4bX2yatk3n2RE
	 xRmYywYUJtZB6r7/lENXpjcprI9vCx9aL+GfGsxVUWUQjGcJYdgPBJ71HoheHGhn/s
	 oCpu0hGnPq/pExNLVkHFbDzjpfAc7Qc/wFue0NUA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 20CB060147;
	Thu, 24 Jul 2025 14:17:00 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+d6995b62e5ac7d79557a@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Thu, 24 Jul 2025 19:16:38 +0100
Message-ID: <20250724181646.291939-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-1-1

[ Upstream commit 08ae4b20f5e82101d77326ecab9089e110f224cc ]

The handling of the `COMEDI_INSNLIST` ioctl allocates a kernel buffer to
hold the array of `struct comedi_insn`, getting the length from the
`n_insns` member of the `struct comedi_insnlist` supplied by the user.
The allocation will fail with a WARNING and a stack dump if it is too
large.

Avoid that by failing with an `-EINVAL` error if the supplied `n_insns`
value is unreasonable.

Define the limit on the `n_insns` value in the `MAX_INSNS` macro.  Set
this to the same value as `MAX_SAMPLES` (65536), which is the maximum
allowed sum of the values of the member `n` in the array of `struct
comedi_insn`, and sensible comedi instructions will have an `n` of at
least 1.

Reported-by: syzbot+d6995b62e5ac7d79557a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d6995b62e5ac7d79557a
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Tested-by: Ian Abbott <abbotti@mev.co.uk>
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250704120405.83028-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/comedi_fops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 8f896e6208a8..5aa6a84d1fa6 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1584,6 +1584,16 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	return i;
 }
 
+#define MAX_INSNS   MAX_SAMPLES
+static int check_insnlist_len(struct comedi_device *dev, unsigned int n_insns)
+{
+	if (n_insns > MAX_INSNS) {
+		dev_dbg(dev->class_dev, "insnlist length too large\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * COMEDI_INSN ioctl
  * synchronous instruction
@@ -2234,6 +2244,9 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 			rc = -EFAULT;
 			break;
 		}
+		rc = check_insnlist_len(dev, insnlist.n_insns);
+		if (rc)
+			break;
 		insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
 		if (!insns) {
 			rc = -ENOMEM;
@@ -3085,6 +3098,9 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 	if (copy_from_user(&insnlist32, compat_ptr(arg), sizeof(insnlist32)))
 		return -EFAULT;
 
+	rc = check_insnlist_len(dev, insnlist32.n_insns);
+	if (rc)
+		return rc;
 	insns = kcalloc(insnlist32.n_insns, sizeof(*insns), GFP_KERNEL);
 	if (!insns)
 		return -ENOMEM;
-- 
2.47.2


