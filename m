Return-Path: <stable+bounces-164669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708D7B110CE
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DEC3BAA5C
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABA2EBDD7;
	Thu, 24 Jul 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="G8ZoFF4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp83.iad3b.emailsrvr.com (smtp83.iad3b.emailsrvr.com [146.20.161.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93572615
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381360; cv=none; b=P/AAdbaUS1JS003QyqXv9ZGSszn8NlllseCFlmi+WVXQD0jyVoiJsMqGJ2xiCqqeZ1c67vgUaSvkGywgYQOJOePHXtjjPzmi2O8tt+WAnJavdiuobhYaJaC6Fhtv9OkzDzvTsT48uoHsQkkFYAAZMR0kCKeOIT4wDfdEkMboSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381360; c=relaxed/simple;
	bh=A1BAiNDxZhvUQKx3nZgFVIl+gVCF4HMP/IJFeVe9J+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fau9sO6BO/oyZ2H3wEqtapLYFBLKKBenxREK6fKtrvOQ2plgI8mB6LpGangLhYYuKyVtembYcA2UT++aajVZ/Habg58RpuEXOvZuXAH//1U/IHsVrRqkiOthiXbjTlGevAwQ3K0mtZnT+Q/z9yC34VMwxNKgLJuJYYrQzXMenoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=G8ZoFF4h; arc=none smtp.client-ip=146.20.161.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381352;
	bh=A1BAiNDxZhvUQKx3nZgFVIl+gVCF4HMP/IJFeVe9J+Y=;
	h=From:To:Subject:Date:From;
	b=G8ZoFF4hhhh39I49cdjnK/qZzMrjY2fW6ymY8kDvKXAChgYf/19v7TQwpvL947j8p
	 6zwD/OIffL2C/Jj2ESa0AFq/uazD8DBkg9H2TwcEUnJpxFpTG7xcQmVXSOUP5QnNCK
	 i5ZrQEbGeCBSkRzyNEp5YsiuTug/SfN8f/lA5cxk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4FD7440163;
	Thu, 24 Jul 2025 14:22:31 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	syzbot+c52293513298e0fd9a94@syzkaller.appspotmail.com,
	"Enju, Kohei" <enjuk@amazon.co.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: das16m1: Fix bit shift out of bounds
Date: Thu, 24 Jul 2025 19:22:12 +0100
Message-ID: <20250724182218.292203-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 37f560bb-803e-4662-97aa-d3cd335e777b-3-1

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
index 4e36377b592a..16e4c1637d0b 100644
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


