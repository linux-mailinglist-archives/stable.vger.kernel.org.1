Return-Path: <stable+bounces-160367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F1AFB430
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC353A912F
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1829DB6C;
	Mon,  7 Jul 2025 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="hjHI+TV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp79.ord1d.emailsrvr.com (smtp79.ord1d.emailsrvr.com [184.106.54.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E842957DE
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894206; cv=none; b=sCYb/G2Yoot+HCE/pnhH1dEHCzD/DcOv77tQUlLPEZ6ff4RVT+59acG0eeySJK28caHmkIpxJsORnPGsF8QrB6Cu0m647ekLgBw6y+Co3OEuBHALDvDLHZbY4Zjhw2lZKdG04LlNMR2h9h5OGScpSdbboI7KNTTQd89ASJDPIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894206; c=relaxed/simple;
	bh=+MQNrRajYzgRvJT9hs9COOwWego2BbwUc1ZTW5K/jsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufSQSnAUvHLH0IgOOLKvixgOR7wCZ/pncW4vzFEi8uwekIljy4p76mNhbTu+2m+xf3D9rNudQFJpanjnUa3aTIvP1f3lxo7BDmPaV9vSPU9rdDobQA+vdUYypgpZASXpYdsvXJikK+1VYkDLwpNobDhrvab/qhv7my7McfZen4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=hjHI+TV1; arc=none smtp.client-ip=184.106.54.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1751893769;
	bh=+MQNrRajYzgRvJT9hs9COOwWego2BbwUc1ZTW5K/jsc=;
	h=From:To:Subject:Date:From;
	b=hjHI+TV16vJ28lA73bl0OFuRRqePNCgVDLiDuZP/HJJZg87fNC0Ojta2iE8khUHPE
	 gCJMNhj7OKHyet9Ojt85ak7bv/7IXbZZ0+Rsy1heGDMBfRXU1NaepvAlycdkSa42uu
	 sFc00qaOazzoqCRMzqbBaBLCqcg2P6BV5+H/qHeU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 5C9C4A0219;
	Mon,  7 Jul 2025 09:09:28 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	syzbot+c52293513298e0fd9a94@syzkaller.appspotmail.com,
	"Enju, Kohei" <enjuk@amazon.co.jp>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: das16m1: Fix bit shift out of bounds
Date: Mon,  7 Jul 2025 14:09:08 +0100
Message-ID: <20250707130908.70758-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: c1dbfb42-cac4-4372-8215-e9f6cc597d88-1-1

When checking for a supported IRQ number, the following test is used:

	/* only irqs 2, 3, 4, 5, 6, 7, 10, 11, 12, 14, and 15 are valid */
	if ((1 << it->options[1]) & 0xdcfc) {

However, `it->options[i]` is an unchecked `int` value from userspace, so
the shift amount could be negative or out of bounds.  Fix the test by
requiring `it->options[1]` to be within bounds before proceeding with
the original test.

Reported-by: syzbot+c52293513298e0fd9a94@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c52293513298e0fd9a94
Fixes: 729988507680 ("staging: comedi: das16m1: tidy up the irq support in das16m1_attach()")
Tested-by: syzbot+c52293513298e0fd9a94@syzkaller.appspotmail.com
Suggested-by: "Enju, Kohei" <enjuk@amazon.co.jp>
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch does not apply cleanly to longterm kernels 5.4.x and 5.10.x.
---
 drivers/comedi/drivers/das16m1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
index b8ea737ad3d1..1b638f5b5a4f 100644
--- a/drivers/comedi/drivers/das16m1.c
+++ b/drivers/comedi/drivers/das16m1.c
@@ -522,7 +522,8 @@ static int das16m1_attach(struct comedi_device *dev,
 	devpriv->extra_iobase = dev->iobase + DAS16M1_8255_IOBASE;
 
 	/* only irqs 2, 3, 4, 5, 6, 7, 10, 11, 12, 14, and 15 are valid */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] >= 2 && it->options[1] <= 15 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], das16m1_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
-- 
2.47.2


