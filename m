Return-Path: <stable+bounces-164672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153CB110D1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C4758862A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F82EBBAC;
	Thu, 24 Jul 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="ihiICQNm"
X-Original-To: stable@vger.kernel.org
Received: from smtp87.iad3b.emailsrvr.com (smtp87.iad3b.emailsrvr.com [146.20.161.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BB2ECD0A
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381365; cv=none; b=E5NRCVtThTCeQJEey9D3TaPCcQg5Em2iOUCvv+DWAp+PeLvS8OBx9z0fcmMyhVzB6v/63AfbxlSvzKl+BoX8KcN+47j1TceSkLaqZNH8QElccv3IcKgGaLMspQFUCe4IZLV3r1reNSzZjSD5JfItbqUV64+INT5569g1moS2EBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381365; c=relaxed/simple;
	bh=opyOpUi/c/HhemT4R/i4iZM4FYSbLOd/cxJi0Wx7T8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6v9UQnyV40X33XhiQX0n173QW3kcfrWAs2hSj5FfOax0mT3EdF+3OxDftfUeT1/3nl4sMBB1yPVzeDBdwJD5ctJl0nEKkhwkuOcR5eFUne8k6c7VdE9Cg5ad6IaRwWyp+Y0IO174x+ZRrP6ZSDItblyuCXQqYwr62OOX3T10hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=ihiICQNm; arc=none smtp.client-ip=146.20.161.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381356;
	bh=opyOpUi/c/HhemT4R/i4iZM4FYSbLOd/cxJi0Wx7T8Y=;
	h=From:To:Subject:Date:From;
	b=ihiICQNm4tahoaJpWWhndCd4xQteToBjgqMGPB88FvHF1EpxVvfyh7ken/D6aQl1O
	 R741Oxy4B/GGEcqa2GH8fHijV40CpKwWkANjUpw5hwClxPYIT836kTUUHu/hqM8ZRD
	 UH3CreHWOcZJN1didGdHh+U00Dx/ihEm1EUHmEoc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CCEEE40189;
	Thu, 24 Jul 2025 14:22:35 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: Fix initialization of data for instructions that write to subdevice
Date: Thu, 24 Jul 2025 19:22:17 +0100
Message-ID: <20250724182218.292203-8-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 37f560bb-803e-4662-97aa-d3cd335e777b-8-1

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
[ Reworked for before commit bac42fb21259 ("comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat") ]
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/comedi_fops.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 413863bc929b..e4dfb5e7843d 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1544,7 +1544,7 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	if (copy_from_user(&insnlist, arg, sizeof(insnlist)))
 		return -EFAULT;
 
-	ret = check_insnlist_len(dev, insnlist32.n_insns);
+	ret = check_insnlist_len(dev, insnlist.n_insns);
 	if (ret)
 		return ret;
 	insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
@@ -1580,21 +1580,27 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	}
 
 	for (i = 0; i < insnlist.n_insns; ++i) {
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
@@ -1661,6 +1667,10 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			ret = -EFAULT;
 			goto error;
 		}
+		if (insn.n < MIN_SAMPLES) {
+			memset(&data[insn.n], 0,
+			       (MIN_SAMPLES - insn.n) * sizeof(unsigned int));
+		}
 	}
 	ret = parse_insn(dev, &insn, data, file);
 	if (ret < 0)
-- 
2.47.2


