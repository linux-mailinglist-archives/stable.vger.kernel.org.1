Return-Path: <stable+bounces-164675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C1AB110DB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AD81CE1B29
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC9274FD6;
	Thu, 24 Jul 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="toqdKcel"
X-Original-To: stable@vger.kernel.org
Received: from smtp119.iad3b.emailsrvr.com (smtp119.iad3b.emailsrvr.com [146.20.161.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AF1DA23
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381627; cv=none; b=AgMROG/IidQBqcWVoHqjrBsbYOUGwuhH+CXqQVZ6NLSSer3FS4jM9iljYEYRh9XsFxujifaKXSO4pj0rJD87asWwBsNQjWwLQyujY+nNFkiKxZWvMABlsbK5gdz6hY5ZJlATzOFu/rECQ89nPF6VHX6JXHfGgkpG91Mw0CdJNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381627; c=relaxed/simple;
	bh=6zIzgNYA5Uo967av3T2XVIKJqiEP/TGM22wEDB+Rydw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edVAzHqwtHEJ90lnxjgEpaEZa7gJ2e/H1JrP5/JQYsADTIpX2pfJ1qFa0E24vUvvCA2Lkd2Wy5Wz80kONzDUjv9/YyhVwrGLNiY6WKMoC481FizYHjMdiv8/XRVgpSqWp8bc25M799QMyeXhnUYIhjIDPtpqpwTkhZkGAaT8Y6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=toqdKcel; arc=none smtp.client-ip=146.20.161.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381022;
	bh=6zIzgNYA5Uo967av3T2XVIKJqiEP/TGM22wEDB+Rydw=;
	h=From:To:Subject:Date:From;
	b=toqdKcelhnjnLbwRhs0RAJj81Q6+kcoEMw6FSHVdztA7o20ZVkw5QHJNz7zMy5YRg
	 3kDggfhETSabJbrDzlEI0UueBZSKUYL0c1i1eIXJFccBbS3zsSZ/bqkcngrvXVE5qT
	 M7w7xCt1ZYrONI2IcgJR6HCAv/hezz2A+p+s/32w=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D7E746018C;
	Thu, 24 Jul 2025 14:17:01 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+c52293513298e0fd9a94@syzkaller.appspotmail.com,
	"Enju, Kohei" <enjuk@amazon.co.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: das16m1: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:16:40 +0100
Message-ID: <20250724181646.291939-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: d9dea1d7-0c3d-4a32-a1eb-78b88e148596-3-1

[ Upstream commit ed93c6f68a3be06e4e0c331c6e751f462dee3932 ]

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
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707130908.70758-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/das16m1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/das16m1.c b/drivers/staging/comedi/drivers/das16m1.c
index 75f3dbbe97ac..0d54387a1c26 100644
--- a/drivers/staging/comedi/drivers/das16m1.c
+++ b/drivers/staging/comedi/drivers/das16m1.c
@@ -523,7 +523,8 @@ static int das16m1_attach(struct comedi_device *dev,
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


