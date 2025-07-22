Return-Path: <stable+bounces-164308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017CDB0E610
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31514AA2E87
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A29285C89;
	Tue, 22 Jul 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1wcveUs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45B284690
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221836; cv=none; b=apShPKl5IrHHzSIVQc2oX4uQRqiKqVRLaYqWB8gmgfLIy1+BepAn3HxP2r4q2DAFZnsKHOvKyH5KpEwU4gFHOxPvn6uAgRiiTP2nQQYW3tHIXb0LYNLw/eTWU3RLyKyG2ea+wCPzEcTbYGIBdIN52BLprLoaEKQ/Ntxo5aaet40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221836; c=relaxed/simple;
	bh=epCI0xhNwFBfoMOPTDbq/c7NOQiOrgr71I9lOyVrqaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clz/jcPGORhihVmSqGw8OKg+NGnoSI3cJqhqW7FHqsJ6Pd5GFKg8ppF03fVYIdLCU18ktO7p3OtAT8n054n5Ic95NwIxyoVOMI1suWPEj3jjXG+8qdY1SkFS2jfePmPgcoo5sa7M8qK6hwIQ/U+J4H992LjAHGlNqrZudHIxOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1wcveUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6C2C4CEEB;
	Tue, 22 Jul 2025 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221836;
	bh=epCI0xhNwFBfoMOPTDbq/c7NOQiOrgr71I9lOyVrqaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1wcveUs8KDF2QGtXVXlKFtJ/kvqaE3GdPKplBjkSxn5GGZn5z8S64Js3Mlcqtsm6
	 AcE2Mi3Ngn2QecKXbaCv3QcJWoPtyNKaEiU+Gby7+p2ZJQP1HxGoisq+ggPa7Vv4To
	 VO5ElwCP8LHVa6t3M3+BgbXMZhNKb3jxY35vl1CtNOy6ftzNP3xsQn3tdIzUfA3wjh
	 Aeb/HX/L+utJZx//1jNQJG4OpeTwYsaeaAJZAZ7c57U8TTpoo+Aaqm0eBpz5Gikdvr
	 eCEieNkpuMH56DwPixLMCxW0sJ0X0Uguf812iOQrR3acU/dbG2vU63sTJW8OiS72dH
	 XgVUZSYA4BJyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] comedi: Fix initialization of data for instructions that write to subdevice
Date: Tue, 22 Jul 2025 18:03:52 -0400
Message-Id: <20250722220352.981909-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072152-submitter-sterile-1681@gregkh>
References: <2025072152-submitter-sterile-1681@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Abbott <abbotti@mev.co.uk>

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
[ Based on the conflict resolution documentation and code analysis, the adaptation was:

changed pointer notation insn->n to struct notation insn.n to match 5.4 code style ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/comedi/comedi_fops.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 8b2337f8303d8..9ce5d29365604 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1567,21 +1567,27 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
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
@@ -1648,6 +1654,10 @@ static int do_insn_ioctl(struct comedi_device *dev,
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
2.39.5


