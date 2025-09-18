Return-Path: <stable+bounces-175383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1530B367BE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5168A9840A7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2134AAE3;
	Tue, 26 Aug 2025 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPwKat0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB02FDC44;
	Tue, 26 Aug 2025 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216893; cv=none; b=Ky9ij8P6oUNlTN/zCmVOclAtcj9RzYsRvvvwIQUs1WaxNIfINXQNTdP1mE1oyR8sNQN/PymAytHWN8R3ja+XUb4M1g9qHL7LdKm5H6vI5mQX3d/IuRRs9nkt9g5rq7r+h1U2yM6ETYKgHoBWwDuYjzbigrqGCaREeKIKwNGRGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216893; c=relaxed/simple;
	bh=YLG4lUru4EHVLeYLRsrv1eHpkpxd+NIR8Fh5ngMY77Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnlQaetlMP4C5BjSmJwnUXqUsxVPrQfYVgvo/XY0nDzqle/hfyRe3QwyUyoVZIHgOTubL1EqX1nRBIWLwl0tSio8b8oUQ9wIoqDcxhAu/4LsZxFcK5UKrJMIe7fls2/I27e9kqT+psrDkKg9nhviCdTStJrkBjwM4vrcwCibum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPwKat0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00799C4CEF1;
	Tue, 26 Aug 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216893;
	bh=YLG4lUru4EHVLeYLRsrv1eHpkpxd+NIR8Fh5ngMY77Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPwKat0TLm3HgQcJDw/0gRQ0J63gG6DbYuyN5HbPDNDKvZlBjqRt1voQOWpWi4KmS
	 jay/F8oLH6FMUZ0IiodpjZgrXoK/ZzYsD3alq3s4dX8FfOxOSg5RxENctRsLVbN9e0
	 X1ZRtNpwG4DyETL6OdDVcqFeteoEFynqkCkS4mMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 583/644] comedi: pcl726: Prevent invalid irq number
Date: Tue, 26 Aug 2025 13:11:14 +0200
Message-ID: <20250826111000.979809522@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

commit 96cb948408b3adb69df7e451ba7da9d21f814d00 upstream.

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
Cc: stable <stable@kernel.org> # 5.13+
Reported-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5cd373521edd68bebcb3
Tested-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/tencent_3C66983CC1369E962436264A50759176BF09@qq.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/pcl726.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/comedi/drivers/pcl726.c
+++ b/drivers/comedi/drivers/pcl726.c
@@ -329,7 +329,8 @@ static int pcl726_attach(struct comedi_d
 	 * Hook up the external trigger source interrupt only if the
 	 * user config option is valid and the board supports interrupts.
 	 */
-	if (it->options[1] && (board->irq_mask & (1 << it->options[1]))) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (board->irq_mask & (1U << it->options[1]))) {
 		ret = request_irq(it->options[1], pcl726_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {



