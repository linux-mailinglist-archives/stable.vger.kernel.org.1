Return-Path: <stable+bounces-109344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822DFA14AFF
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 09:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF9B161CCD
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865FA1F866E;
	Fri, 17 Jan 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="baEy9UsS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AD1F7066
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101991; cv=none; b=qkW9EsjCFnsL1MrQ0eNjB9BiaJcoq0JOOG++vsbAdpz0SW+L1L6pAl1yQ526BXwDnYGbCnwpIxFM7fQnkRaVX5g5OIHAlF4DJVsQLUuJ6pWyh8nWJPRWsoh9FbfSonkKrC4nEOlXwR5ElxFYs7KFIV18uosXBZe7Vmr8i6K8P/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101991; c=relaxed/simple;
	bh=tux2UJzNaDbsRLFTbIvhKwgnyOd/PRLw8HX7+/x3U7Q=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jllV4rsqBD9noR9iBcllfVsPxqJYyQnoQHu9EVH5wmg9gCdt/EWrCY1txiCI4aRTf+SxLm1+KB+0CYy9QUBA6bu0oykFFpahGrJUCOd+4xuiEHNnVJPKB4W/77189Bp8V1EXNbUYREN5epNyaa2S5SmIpff+RtuZxqOvzyHvwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=baEy9UsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C22C4CEDD;
	Fri, 17 Jan 2025 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737101990;
	bh=tux2UJzNaDbsRLFTbIvhKwgnyOd/PRLw8HX7+/x3U7Q=;
	h=Subject:To:From:Date:From;
	b=baEy9UsSvkn81j/V65JEsqEcRVfAbBUqw9tgb7sUtxNBEOcp4JBuE86tN0ZjwKZ5z
	 FvdKBWU5/vy1RodW384z8TIYo8aM64xmwyPqKncVSoqc6PACfcOhLp422lg/z7sL0p
	 2dFTp7dx28zduQa1YfFM1oRVdUE+9U4p0ve7bdls=
Subject: patch "USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()" added to usb-testing
To: qasdev00@gmail.com,gregkh@linuxfoundation.org,johan@kernel.org,stable@vger.kernel.org,syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 17 Jan 2025 09:19:40 +0100
Message-ID: <2025011740-polio-childless-ffe2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the usb-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 575a5adf48b06a2980c9eeffedf699ed5534fade Mon Sep 17 00:00:00 2001
From: Qasim Ijaz <qasdev00@gmail.com>
Date: Mon, 13 Jan 2025 18:00:34 +0000
Subject: USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

This patch addresses a null-ptr-deref in qt2_process_read_urb() due to
an incorrect bounds check in the following:

       if (newport > serial->num_ports) {
               dev_err(&port->dev,
                       "%s - port change to invalid port: %i\n",
                       __func__, newport);
               break;
       }

The condition doesn't account for the valid range of the serial->port
buffer, which is from 0 to serial->num_ports - 1. When newport is equal
to serial->num_ports, the assignment of "port" in the
following code is out-of-bounds and NULL:

       serial_priv->current_port = newport;
       port = serial->port[serial_priv->current_port];

The fix checks if newport is greater than or equal to serial->num_ports
indicating it is out-of-bounds.

Reported-by: syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=506479ebf12fe435d01a
Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
Cc: <stable@vger.kernel.org>      # 3.5
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/quatech2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index a317bdbd00ad..72fe83a6c978 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -503,7 +503,7 @@ static void qt2_process_read_urb(struct urb *urb)
 
 				newport = *(ch + 3);
 
-				if (newport > serial->num_ports) {
+				if (newport >= serial->num_ports) {
 					dev_err(&port->dev,
 						"%s - port change to invalid port: %i\n",
 						__func__, newport);
-- 
2.48.1



