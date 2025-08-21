Return-Path: <stable+bounces-172120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDDB2FB25
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205C1AE683A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DD343D65;
	Thu, 21 Aug 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e5Km9CFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7534321A
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783383; cv=none; b=q56YhJdWE0TRP8/Ta+mF9067e2XMEK+U7BngP+gAYCKSNe+zufDbDuJP3IAhu+VuFhNn6xthy6F2YzSHHS6fq2kXmmT0KqH5qbir2sKUJoZAuV1zIsauKf9GMBn2Bg8tgUsCj1l/jefUe6EtC1lFZAfNcIQ81XEX6rqqOitZHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783383; c=relaxed/simple;
	bh=xU1L7uo+/yHtbJFkGvI0RjqjMMwJ0kl7L+pMiGc9fPE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a1uqa99sQUAa5w78c2xYvN3228W/Gwmf8YDvI7DEm1d2sEHYMkZHNah5EjcxCMN8F6fCkzDVrJBupAyvqLml4Zz6YsZQtJcS/aHpxwN94UBmnLiby90qhOyDOCiJ06RIg4vydEW2AR9qJpu3HXvWvER6uEjAB4ED1CnXS3pZCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e5Km9CFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F263C4CEEB;
	Thu, 21 Aug 2025 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783383;
	bh=xU1L7uo+/yHtbJFkGvI0RjqjMMwJ0kl7L+pMiGc9fPE=;
	h=Subject:To:Cc:From:Date:From;
	b=e5Km9CFXrygIB3iqgBsJ3CztHbw+qr7Hl62iAmeEf2kVTvh/Yz6syReFgivNfxWOw
	 SHnClaiWQ9L+bU+JQZnXaCLAVqj0i2Di09Qjo7L/ovy15FtQrVRsTYXP72ucfWD9q0
	 1L1/deIMNYTyEzE6kgRTuSlOAS2wnPmEJf+xLdF8=
Subject: FAILED: patch "[PATCH] media: rainshadow-cec: fix TOCTOU race condition in" failed to apply to 5.4-stable tree
To: hanguidong02@gmail.com,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:36:20 +0200
Message-ID: <2025082119-december-ranking-b3a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7af160aea26c7dc9e6734d19306128cce156ec40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082119-december-ranking-b3a3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7af160aea26c7dc9e6734d19306128cce156ec40 Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Fri, 6 Jun 2025 03:04:59 +0000
Subject: [PATCH] media: rainshadow-cec: fix TOCTOU race condition in
 rain_interrupt()

In the interrupt handler rain_interrupt(), the buffer full check on
rain->buf_len is performed before acquiring rain->buf_lock. This
creates a Time-of-Check to Time-of-Use (TOCTOU) race condition, as
rain->buf_len is concurrently accessed and modified in the work
handler rain_irq_work_handler() under the same lock.

Multiple interrupt invocations can race, with each reading buf_len
before it becomes full and then proceeding. This can lead to both
interrupts attempting to write to the buffer, incrementing buf_len
beyond its capacity (DATA_SIZE) and causing a buffer overflow.

Fix this bug by moving the spin_lock() to before the buffer full
check. This ensures that the check and the subsequent buffer modification
are performed atomically, preventing the race condition. An corresponding
spin_unlock() is added to the overflow path to correctly release the
lock.

This possible bug was found by an experimental static analysis tool
developed by our team.

Fixes: 0f314f6c2e77 ("[media] rainshadow-cec: new RainShadow Tech HDMI CEC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/cec/usb/rainshadow/rainshadow-cec.c b/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
index ee870ea1a886..6f8d6797c614 100644
--- a/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
+++ b/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
@@ -171,11 +171,12 @@ static irqreturn_t rain_interrupt(struct serio *serio, unsigned char data,
 {
 	struct rain *rain = serio_get_drvdata(serio);
 
+	spin_lock(&rain->buf_lock);
 	if (rain->buf_len == DATA_SIZE) {
+		spin_unlock(&rain->buf_lock);
 		dev_warn_once(rain->dev, "buffer overflow\n");
 		return IRQ_HANDLED;
 	}
-	spin_lock(&rain->buf_lock);
 	rain->buf_len++;
 	rain->buf[rain->buf_wr_idx] = data;
 	rain->buf_wr_idx = (rain->buf_wr_idx + 1) & 0xff;


