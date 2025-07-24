Return-Path: <stable+bounces-164657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D2B110BA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFC13AD548
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4D2EBBBA;
	Thu, 24 Jul 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="sGSbj4OQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp113.iad3b.emailsrvr.com (smtp113.iad3b.emailsrvr.com [146.20.161.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5452ECE8D
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381031; cv=none; b=i8j/7LCnQu/P1gv3ypMLY4F+to8uLwsb9S2uAXAzBdlZHp/YzwxzlF2auQXMTWRu4OR2Q5aku2ZQqJCak8eYaXpOpF0D3hpdMy7MqyBR0cDdsIUua/gje3oC4fWJuyV0QbarsFV1mJygDFrrwwBi10XYFgjeeZFNNeSW909tWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381031; c=relaxed/simple;
	bh=wz7IptRrmNRopGYGibql2bq4dIirRiZMWssCXi+Az1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Op/Nw+7ET2EE6orXBAABQQzMCrM7onGjWlppMxOTc61qnKVbH9hfgjxK4MoyZ4ZZ2sB3SuZ0lEMBI77WeifTfMSAeUo5/dazvAnvAjAA1D9A0B0zz6PkNFtRE2QrjfcAisJT283BrMS51Wd4POjwIwDaZKTr8awLVXWDPL0ouA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=sGSbj4OQ; arc=none smtp.client-ip=146.20.161.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381027;
	bh=wz7IptRrmNRopGYGibql2bq4dIirRiZMWssCXi+Az1k=;
	h=From:To:Subject:Date:From;
	b=sGSbj4OQobPXJ8cvv00ErfwKV92HPZ5PWfEMg02ghoG+XvZ8/Y87tliow10mi70W4
	 ezsCnzumODimWuvETj5jcm8XRUs8jRDr1knSxCFd8VHUcCtN2FmG53qtUQt9iK5XfI
	 kUAm8ykRdw50KOxMO3mEUH5NwrpgqsnIuCG4+IN8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6F1DD601A1;
	Thu, 24 Jul 2025 14:17:06 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: Fix initialization of data for instructions that write to subdevice
Date: Thu, 24 Jul 2025 19:16:45 +0100
Message-ID: <20250724181646.291939-8-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-8-1

[ Upstream commit 46d8c744136ce2454aa4c35c138cc06817f92b8e ]

Some Comedi subdevice instruction handlers are known to access
instruction data elements beyond the first `insn->n` elements in some
cases.  The `do_insn_ioctl()` and `do_insnlist_ioctl()` functions
allocate at least `MIN_SAMPLES` (16) data elements to deal with this,
but they do not initialize all of that.  For Comedi instruction codes
that write to the subdevice, the first `insn->n` data elements are
copied from user-space, but the remaining elements are left
uninitialized.  That could be a problem if the subdevice instruction
handler reads the uninitialized data.  Ensure that the first
`MIN_SAMPLES` elements are initialized before calling these instruction
handlers, filling the uncopied elements with 0.  For
`do_insnlist_ioctl()`, the same data buffer elements are used for
handling a list of instructions, so ensure the first `MIN_SAMPLES`
elements are initialized for each instruction that writes to the
subdevice.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707161439.88385-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/comedi_fops.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 5aa6a84d1fa6..96d68cc8f449 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1551,21 +1551,27 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	}
 
 	for (i = 0; i < n_insns; ++i) {
+		unsigned int n = insns[i].n;
+
 		if (insns[i].insn & INSN_MASK_WRITE) {
 			if (copy_from_user(data, insns[i].data,
-					   insns[i].n * sizeof(unsigned int))) {
+					   n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_from_user failed\n");
 				ret = -EFAULT;
 				goto error;
 			}
+			if (n < MIN_SAMPLES) {
+				memset(&data[n], 0, (MIN_SAMPLES - n) *
+						    sizeof(unsigned int));
+			}
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
 			goto error;
 		if (insns[i].insn & INSN_MASK_READ) {
 			if (copy_to_user(insns[i].data, data,
-					 insns[i].n * sizeof(unsigned int))) {
+					 n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_to_user failed\n");
 				ret = -EFAULT;
@@ -1638,6 +1644,10 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			ret = -EFAULT;
 			goto error;
 		}
+		if (insn->n < MIN_SAMPLES) {
+			memset(&data[insn->n], 0,
+			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
+		}
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)
-- 
2.47.2


