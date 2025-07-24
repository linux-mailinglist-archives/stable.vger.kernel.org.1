Return-Path: <stable+bounces-164599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F55B1097D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D9D3B3134
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA61DE2B5;
	Thu, 24 Jul 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="hVFxuh/p"
X-Original-To: stable@vger.kernel.org
Received: from smtp114.iad3a.emailsrvr.com (smtp114.iad3a.emailsrvr.com [173.203.187.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6576025
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357610; cv=none; b=KkNvhXgIO78FokXPzZuuAQWvfrK7ANfrJMG72p3Bo2DfowPXIXBcCQ/xvwKoXaGe12X4sn9Fx2wuQlyeHhC7HhayMNVJg3AGaigjVYpVILi6P22Hhz6bLyqpLP7Ec0jVAiuVF9JFyg3hhy9JrsyKxvcUBV3yAYbMMWSBrEOuTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357610; c=relaxed/simple;
	bh=FgikwVrQ/haYskWg5QjV35IHi0o0Gmu+BMVh7fy950c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZynwLOYIt6CFBU403SLvnrA2lMIvVqb4ABzjRcH5gK73MONcq1tmMZbbzXtm95GumO/oBqSRwHpf2iFxAGwCTrZep7yE41ungmvIvSPwOMVeE+ZsbS0tUNQv/BHHv931Hw1ILYqM1UDE2T7r+BOAiU7JVqtBs/4NTN3eg+LNVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=hVFxuh/p; arc=none smtp.client-ip=173.203.187.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753355293;
	bh=FgikwVrQ/haYskWg5QjV35IHi0o0Gmu+BMVh7fy950c=;
	h=From:To:Subject:Date:From;
	b=hVFxuh/ph1fFxIiEemCBcufQSwxF3ah8i+HcQqx3UY9kOgITgW1YDSZEp+UUjhtg1
	 1HkKhsOf2z7mj5LW0RtRmk1Uws5o6PdHbe/ko3Hv8O8TrzCjMU/CbHcUPEQ3SiYYug
	 xvxWN2YElH4mCR5KSBQK591pet0BC7cubIjsvTJI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 01C6E250C1;
	Thu, 24 Jul 2025 07:08:11 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Edward Adam Davis <eadavis@qq.com>,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH V3 REPOST] comedi: pcl726: Prevent invalid irq number
Date: Thu, 24 Jul 2025 12:07:36 +0100
Message-ID: <20250724110754.8708-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <tencent_3C66983CC1369E962436264A50759176BF09@qq.com>
References: <tencent_3C66983CC1369E962436264A50759176BF09@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 56291058-866a-4d1e-89ad-fca7897b07d3-1-1

From: Edward Adam Davis <eadavis@qq.com>

The reproducer passed in an irq number(0x80008000) that was too large,
which triggered the oob.

Added an interrupt number check to prevent users from passing in an irq
number that was too large.

If `it->options[1]` is 31, then `1 << it->options[1]` is still invalid
because it shifts a 1-bit into the sign bit (which is UB in C).
Possible solutions include reducing the upper bound on the
`it->options[1]` value to 30 or lower, or using `1U << it->options[1]`.

The old code would just not attempt to request the IRQ if the
`options[1]` value were invalid.  And it would still configure the
device without interrupts even if the call to `request_irq` returned an
error.  So it would be better to combine this test with the test below.

Fixes: fff46207245c ("staging: comedi: pcl726: enable the interrupt support code")
Cc: <stable@vger.kernel.org> # 5.13+
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5cd373521edd68bebcb3
Tested-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/pcl726.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/pcl726.c b/drivers/comedi/drivers/pcl726.c
index 0430630e6ebb..b542896fa0e4 100644
--- a/drivers/comedi/drivers/pcl726.c
+++ b/drivers/comedi/drivers/pcl726.c
@@ -328,7 +328,8 @@ static int pcl726_attach(struct comedi_device *dev,
 	 * Hook up the external trigger source interrupt only if the
 	 * user config option is valid and the board supports interrupts.
 	 */
-	if (it->options[1] && (board->irq_mask & (1 << it->options[1]))) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (board->irq_mask & (1U << it->options[1]))) {
 		ret = request_irq(it->options[1], pcl726_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
-- 
2.47.2


