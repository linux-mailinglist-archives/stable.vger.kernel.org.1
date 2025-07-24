Return-Path: <stable+bounces-164665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CCAB110CA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3BF3B5F59
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8162ECE80;
	Thu, 24 Jul 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="yxIcrchV"
X-Original-To: stable@vger.kernel.org
Received: from smtp79.iad3b.emailsrvr.com (smtp79.iad3b.emailsrvr.com [146.20.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6572615
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381329; cv=none; b=mtCIMmkfaEOB3ww5wKCKHvWtpE3Ko10Xt22EfNGe/xFn2t9/fwOyLePFymUX+jS6PTOGvx4ZpEIuh1wJs9MxS6/BbBylnGqevIBY9pts2bKHK+9OENFsA3kSK30zFoQvnPjmKTQHXoxiD9+F9H2Brr9pRT4yjAznwm1rCeLJhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381329; c=relaxed/simple;
	bh=6zIzgNYA5Uo967av3T2XVIKJqiEP/TGM22wEDB+Rydw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0wstVMiuDuGWYqBkXZlIwoePszNc2toeS/vZ2Cz4UArcDpKwES0xwxbdOcesmt/HWUamCa/eVO6iY7qXhoSHqCyaPtAZCg7MNHND2K68Yc6Ol16OTJZ+IAtgO0yjG65K+se09pMs1YySbfpChzrU0MZO0RDW/JqMYsndYNhol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=yxIcrchV; arc=none smtp.client-ip=146.20.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753380806;
	bh=6zIzgNYA5Uo967av3T2XVIKJqiEP/TGM22wEDB+Rydw=;
	h=From:To:Subject:Date:From;
	b=yxIcrchVlx8tSLVo6aEXDAShD3mfG/t6FCxrEvDV1Poqj4V0PoH3nxU+6RRSds6EX
	 6exTu9pjmSu/YrFVNWgPlllappGLyi+CLxyaYZGgV/QjrMa7REPVO9Lixs7/zkHf+r
	 kM9BabvmuUT5eguVqePc1PPr3Bn0vpam1+xT95jg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0CA58E01AC;
	Thu, 24 Jul 2025 14:13:25 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+c52293513298e0fd9a94@syzkaller.appspotmail.com,
	"Enju, Kohei" <enjuk@amazon.co.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: das16m1: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:12:51 +0100
Message-ID: <20250724181257.291722-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724181257.291722-1-abbotti@mev.co.uk>
References: <20250724181257.291722-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e379e1bc-6f74-4a9e-9d5c-30262cc57a91-3-1

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


