Return-Path: <stable+bounces-164932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159EB13AD4
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363193A4504
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877F2652A2;
	Mon, 28 Jul 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Ie423cZW"
X-Original-To: stable@vger.kernel.org
Received: from smtp71.iad3a.emailsrvr.com (smtp71.iad3a.emailsrvr.com [173.203.187.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016462472B9
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707410; cv=none; b=pNOJ9lCHpPfYBJEWkDneBMo36RFZi01XXyMOtd4j6TBhjsNUnz3V/tDqQRD8VSFXTw2itDUs1tr+whuHrk8DLyBfeAC0YP5Y7TqujSyv2RU7XoaSP0hFa3YQhZxR/R0gBj6SkJyr01BFXmyl5MHYsE6gH+8/9zlNY7fKXG3IY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707410; c=relaxed/simple;
	bh=QJ/7UbXymraTObVV8jrq+8OTPb9ZOQcbZxTJe7t6qBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuKTUylG2w0wQbpg9d2CJQ+hp15pbNiMMa0eDM+IK9ajcfd6LCZKcFBJq2B0re9CAuNzZRcr4Gu+n9NFf74p0tcN7k1IYHwollC8fWzGM6U8WUbW6sv8r+84zW81QHeOdp1SnYMjlT74OKEbLymYsdx3+WrvllstUFyJFwzzOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Ie423cZW; arc=none smtp.client-ip=173.203.187.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753705128;
	bh=QJ/7UbXymraTObVV8jrq+8OTPb9ZOQcbZxTJe7t6qBw=;
	h=From:To:Subject:Date:From;
	b=Ie423cZWUJHdwoY7e5IPa1AJIDBi7cbwMKC2wATkLFO66FBsh1EulNNz4c4XZ779Y
	 sZsNf7SkgNDw4bDbZCTSJ9r8udyP6xtzBtlh5kIla96KQViEVu3mHWllWOugmkHZcz
	 1w+FMapNfK6XBs0YhF3Cb/k+3L6zioAsdFp3t6IQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EE41B56F9;
	Mon, 28 Jul 2025 08:18:47 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+d6995b62e5ac7d79557a@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 5.4] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Mon, 28 Jul 2025 13:18:20 +0100
Message-ID: <20250728121821.276086-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <1753465192-da4c3231@stable.kernel.org>
References: <1753465192-da4c3231@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: daabff01-c746-4990-9a3f-61e3a38b6dd7-1-1

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
v2: Fixed a build error due to applying a fixup to the wrong commit.
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
index 8b2337f8303d..45e868badee4 100644
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
 
+	ret = check_insnlist_len(dev, insnlist.n_insns);
+	if (ret)
+		return ret;
 	insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
 	if (!insns) {
 		ret = -ENOMEM;
-- 
2.47.2


