Return-Path: <stable+bounces-160185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC03AF9235
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E63B1CA3E7B
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB32D5424;
	Fri,  4 Jul 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="QES4IK8o"
X-Original-To: stable@vger.kernel.org
Received: from smtp119.ord1d.emailsrvr.com (smtp119.ord1d.emailsrvr.com [184.106.54.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF32C15AB
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631107; cv=none; b=iZOKzZQz6/5o5IOSA4YpzIrJXE8+69DGdkA5NWjcSyNNgM1+NyNkeE2B4fqHCjvYmwePqEUPHTfTYDxUeocWt+6UZBVX8TRMh22yydP66suGB89YLJi3oIA0NZLf5c3ZIdl5K+6uqYF5iFo6RHXY1UPGYo0R0S+v4tnC/2L/ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631107; c=relaxed/simple;
	bh=mbNJ73AwNFbOOurBy9lmYSY4ZrqhqELSTtqfAnVdZoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9ivwai4kIissf2Mi0xsF1M78GemiwnG3RwQiatjUb2p92hsIv9tLtGcjUsSb/3nLdszqHPkKp12Ao6z5u/pTM8OG4MFtuwFCeJkhqp6Xe4wc/3MndjCqsKvzzuuIZZpm+jPQJYqlmCiKqohrJz9Mk1U8W9/RoLmzs6MML+6vvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=QES4IK8o; arc=none smtp.client-ip=184.106.54.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1751630659;
	bh=mbNJ73AwNFbOOurBy9lmYSY4ZrqhqELSTtqfAnVdZoM=;
	h=From:To:Subject:Date:From;
	b=QES4IK8oDv2qCodRvE5DVhBgS+0kFo0lFO/I4eiOHfAOXrq1z3tatwM5dSCBNEXu5
	 Yq2EPiVv2CP5vtzC+rJDOhMOvv/6Q0pCBWaD4szsjtUTAeDQfTlMpfd4f8HJr1JwyO
	 /I4dTugGkhvnwNgcIURIhoUT0M0cMfENBlvtPrCA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E3E9820159;
	Fri,  4 Jul 2025 08:04:18 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	syzbot+d6995b62e5ac7d79557a@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Fri,  4 Jul 2025 13:04:05 +0100
Message-ID: <20250704120405.83028-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b11d4159-b39c-4b63-b0e7-eb76e318031a-1-1

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
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch does not apply cleanly to longterm kernels 5.4.x and 5.10.x.
---
 drivers/comedi/comedi_fops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 3383a7ce27ff..962fb9b18a52 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1589,6 +1589,16 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
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
@@ -2239,6 +2249,9 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 			rc = -EFAULT;
 			break;
 		}
+		rc = check_insnlist_len(dev, insnlist.n_insns);
+		if (rc)
+			break;
 		insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
 		if (!insns) {
 			rc = -ENOMEM;
@@ -3142,6 +3155,9 @@ static int compat_insnlist(struct file *file, unsigned long arg)
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


