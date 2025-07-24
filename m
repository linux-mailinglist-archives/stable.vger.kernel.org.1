Return-Path: <stable+bounces-164683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7AB11116
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5C11CE64A4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC4B2ED159;
	Thu, 24 Jul 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="xCh2/WBx"
X-Original-To: stable@vger.kernel.org
Received: from smtp80.iad3b.emailsrvr.com (smtp80.iad3b.emailsrvr.com [146.20.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D992EE97D
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382524; cv=none; b=Z+1XU49YzMUVASl31RRoxBkzLOoxUj2hl2Hf8i0yaSegN7lmOws5OTBHqTxg93JpqHFHfWiMjjSpnq0/SctuNMHM3AGNiL/V0eZ1CzfHtTJqMQHEHBT7xFFIdMc/I4xH2hghPegdVFbSqNzGx38t1yySBuXSmviHQEmLhvWBOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382524; c=relaxed/simple;
	bh=0TtR7zh8BLyRZwm2SZb7EpQn4/PLYH/D0hu7W+kVls4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjQ3siZvDAfS+/gVM7lEmfBcocC7u2w1qo/69vzVXgus1iCJ7atS7Qqyw9PAknmPaobaUM0too7z/veACWU3HVNd6Kh2WJhhULr06jSYeusaY337MPdrKV+F8C/an2yLmfVekif9W7uh/dIk/mNSMrTYh5TIkmBg6IWGD/CZilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=xCh2/WBx; arc=none smtp.client-ip=146.20.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381350;
	bh=0TtR7zh8BLyRZwm2SZb7EpQn4/PLYH/D0hu7W+kVls4=;
	h=From:To:Subject:Date:From;
	b=xCh2/WBx+hVz4xsiS2MUrAiBvCsXYRETF1DakDCdNmIXO4/uqWfQyB8YUR4/JmuFW
	 pHnh9Lf7fpwHqKZFrhIdGvoGdRQwD9EMkU4dHoOT53eYXrTFO7OmF1oZAuK5mvdMJO
	 uS+3pT+pOpkE9AH5LOTnqBEiMCZstBYTFMNWNNDQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8C96740128;
	Thu, 24 Jul 2025 14:22:29 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+d6995b62e5ac7d79557a@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Thu, 24 Jul 2025 19:22:10 +0100
Message-ID: <20250724182218.292203-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 37f560bb-803e-4662-97aa-d3cd335e777b-1-1

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
[ Reworked for before commit bac42fb21259 ("comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat") ]
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/comedi_compat32.c |  3 +++
 drivers/staging/comedi/comedi_fops.c     | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/staging/comedi/comedi_compat32.c b/drivers/staging/comedi/comedi_compat32.c
index 36a3564ba1fb..2f444e2b92c2 100644
--- a/drivers/staging/comedi/comedi_compat32.c
+++ b/drivers/staging/comedi/comedi_compat32.c
@@ -360,6 +360,9 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 	if (err)
 		return -EFAULT;
 
+	if (n_insns > 65536)	/* See MAX_INSNS in comedi_fops.c */
+		return -EINVAL;
+
 	/* Allocate user memory to copy insnlist and insns into. */
 	s = compat_alloc_user_space(offsetof(struct combined_insnlist,
 					     insn[n_insns]));
diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 8b2337f8303d..413863bc929b 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1502,6 +1502,16 @@ static int parse_insn(struct comedi_device *dev, struct comedi_insn *insn,
 	return ret;
 }
 
+#define MAX_INSNS   65536
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
  * COMEDI_INSNLIST ioctl
  * synchronous instruction list
@@ -1534,6 +1544,9 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	if (copy_from_user(&insnlist, arg, sizeof(insnlist)))
 		return -EFAULT;
 
+	ret = check_insnlist_len(dev, insnlist32.n_insns);
+	if (ret)
+		return ret;
 	insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
 	if (!insns) {
 		ret = -ENOMEM;
-- 
2.47.2


