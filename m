Return-Path: <stable+bounces-164926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4805B13AAA
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEDA3A62E6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2427263F34;
	Mon, 28 Jul 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Ut4KEuh+"
X-Original-To: stable@vger.kernel.org
Received: from smtp84.iad3a.emailsrvr.com (smtp84.iad3a.emailsrvr.com [173.203.187.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C6BA3F
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706515; cv=none; b=Cx3XFnyIx8d9T3SnZl5C2sv7ICRdfAkzEo1/CJ23o1CmJqQzTiQeuWk7CdHyywKQv40w3gdI3L2R7I9f8l7/M0cAPoE7ZTeO1VsoCqwPTyXsqv3tyU2RK4XaeVJ86IGtDkgFmdFpjqmFC1055x9bXwBUr7j1TD1gE11fsLvXJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706515; c=relaxed/simple;
	bh=iD9eUYzoWytN7iv8vkIVASrFkj5Z3cLXcA/g6bv+mtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRLjX8VXom1GdcE3lSCXGAfB2yhOKWeSvgdjudD1xO1eCeQa/sGYDkmhsJJW6uTQuqxsIAHb8wBr9ch+P97qx3P7aorDjKOc+Jy2rUFZiDAumv8f2V3VIclO2rZPqghNlFMt5qhRDWoYxuz5t79AppbxfhRUE1Sd3FBuYFsEKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Ut4KEuh+; arc=none smtp.client-ip=173.203.187.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753705331;
	bh=iD9eUYzoWytN7iv8vkIVASrFkj5Z3cLXcA/g6bv+mtE=;
	h=From:To:Subject:Date:From;
	b=Ut4KEuh+l3rzSYhgnThEdOYBmJbdYPvA7j9UgUJg+6HJmXTCe9jUNp6asNMC/As2k
	 dyGMwj0ijCG4Kr0odLPfihLFLGA3HFPpTWddgCarPo5i3VSH+lWKDOtZtpfPVZzwFY
	 wtieRdvautDpFeZ1DtpVSG2dJC5AQdEA+zUFUw/Y=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 523E623A1F;
	Mon, 28 Jul 2025 08:22:11 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 5.4] comedi: Fix initialization of data for instructions that write to subdevice
Date: Mon, 28 Jul 2025 13:21:56 +0100
Message-ID: <20250728122156.276222-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <1753468023-5d115273@stable.kernel.org>
References: <1753468023-5d115273@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 174d8415-f9a7-4cf1-9f10-8cad79dc46ac-1-1

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
v2: Fixed a patch application error due to fixing up the wrong commit.
---
 drivers/staging/comedi/comedi_fops.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 45e868badee4..e4dfb5e7843d 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
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


