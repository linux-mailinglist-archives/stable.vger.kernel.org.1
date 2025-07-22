Return-Path: <stable+bounces-163744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B7B0DB59
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C42F3BCE8A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E8D23B614;
	Tue, 22 Jul 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UOYsfBZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30A15624B;
	Tue, 22 Jul 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192067; cv=none; b=tfnEijhB/ZAr8RVRioE3Aul/+zXkgjA8i10SKuVt8LzvuTT/2pwWftFSGWloxLlVgXnktecdNy74bRPUxxwe7ZWzlFc8OO/r78sVXbjAqA6qZYDkC0gC3oXoFzu0h6n9Lu26vuV3G3Z1tUGSDnXT5qTvhCs3tvQnx8jo57G/03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192067; c=relaxed/simple;
	bh=ddscDTM1H2Oi8WfwxXvLsiMp7agqCKR47fWyEAFrh0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IURdhFe26hHwAoCRE+UuoNjE67pxCo2BdAM2hfqkvlgu/jeAyuXFeMh4zLfhfiACa2PnAj4aJrojUbP/Pt0aIFIgGKOi59YRXFcUOFyo4ZY5QTEnaJjvzXM4RO24OYuhL6G700QndPPLACnAObQ1O2ZJbvFqNu+UHFkF0g606jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UOYsfBZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA63DC4CEEB;
	Tue, 22 Jul 2025 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192067;
	bh=ddscDTM1H2Oi8WfwxXvLsiMp7agqCKR47fWyEAFrh0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOYsfBZSjbaJ1v5OCJuwQVjy5ivzvybAIm14z8Vgwr8Osv1ZSqgkWuIOWdQjfJnaB
	 2iXweZ36zLCk4WIAKn8emc4bQO3ZqEqyZUZ0cG48hRlYBqnzC6qDQ61PkqXZaUYQbO
	 l99rAbdjZRfI4XsBeHKdL2wjexcC6uA3D59RFqMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+32de323b0addb9e114ff@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.1 34/79] comedi: pcl812: Fix bit shift out of bounds
Date: Tue, 22 Jul 2025 15:44:30 +0200
Message-ID: <20250722134329.622150591@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit b14b076ce593f72585412fc7fd3747e03a5e3632 upstream.

When checking for a supported IRQ number, the following test is used:

	if ((1 << it->options[1]) & board->irq_bits) {

However, `it->options[i]` is an unchecked `int` value from userspace, so
the shift amount could be negative or out of bounds.  Fix the test by
requiring `it->options[1]` to be within bounds before proceeding with
the original test.  Valid `it->options[1]` values that select the IRQ
will be in the range [1,15]. The value 0 explicitly disables the use of
interrupts.

Reported-by: syzbot+32de323b0addb9e114ff@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=32de323b0addb9e114ff
Fixes: fcdb427bc7cf ("Staging: comedi: add pcl821 driver")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707133429.73202-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/pcl812.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/comedi/drivers/pcl812.c
+++ b/drivers/comedi/drivers/pcl812.c
@@ -1149,7 +1149,8 @@ static int pcl812_attach(struct comedi_d
 		if (!dev->pacer)
 			return -ENOMEM;
 
-		if ((1 << it->options[1]) & board->irq_bits) {
+		if (it->options[1] > 0 && it->options[1] < 16 &&
+		    (1 << it->options[1]) & board->irq_bits) {
 			ret = request_irq(it->options[1], pcl812_interrupt, 0,
 					  dev->board_name, dev);
 			if (ret == 0)



