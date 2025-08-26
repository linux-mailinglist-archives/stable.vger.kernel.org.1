Return-Path: <stable+bounces-173257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC96B35C45
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C87C46C1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11817332C;
	Tue, 26 Aug 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zo8WsSPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5EE322524;
	Tue, 26 Aug 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207778; cv=none; b=krsb89bz0ML52xpeW5cDkSpQZFT/nqXHFerV8xFdoJduIFWPMPzPlCCYhQXfZedcWzqH8q8sq1DsQq9WjoKuThjOcZFW6WpfmQtV4MC5bT9xBvpvR1Xpe+1q7Q0FrZ9Ws4W6/4gmQ/ZTIUUS8kNf+xIKMPAaFnrMltimdvv5o5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207778; c=relaxed/simple;
	bh=mFZViN5VC1X9DzRVEqrm30rCdxZYcCisiLOd9e51B5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlt06XpNgvltLN1tOy9TgU7riRCkXv1Zz1tnWYNwzHxYDIM3kcrvv5ycqRhwGRfmbrimAqD880HY11nuRZRORL9s+NM0Xu4VylWN6erKvLitbS4fLDCsd+2jO5Um1YWsDt275RJX+cl1hWDplsj/B6QrD3UkXCkdlkrfioUYcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zo8WsSPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD04C4CEF1;
	Tue, 26 Aug 2025 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207778;
	bh=mFZViN5VC1X9DzRVEqrm30rCdxZYcCisiLOd9e51B5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zo8WsSPHTa1HVSFuUI2g8UtzrDtYIsDujRAqFLKf2in0kPFDtu+/XTavbaMxwkHC5
	 TkkFCKJnHpnvDUruy4P1PbnUmXuy+0n4vhcINtm3Cw8A/iE6CidygBUEqftfS+pqlZ
	 /jIzBrnoA99dh2uOPY7l7TrztBttfYIcyDPJSwsU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>
Subject: [PATCH 6.16 312/457] comedi: pcl726: Prevent invalid irq number
Date: Tue, 26 Aug 2025 13:09:56 +0200
Message-ID: <20250826110945.071777415@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -328,7 +328,8 @@ static int pcl726_attach(struct comedi_d
 	 * Hook up the external trigger source interrupt only if the
 	 * user config option is valid and the board supports interrupts.
 	 */
-	if (it->options[1] && (board->irq_mask & (1 << it->options[1]))) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (board->irq_mask & (1U << it->options[1]))) {
 		ret = request_irq(it->options[1], pcl726_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {



