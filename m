Return-Path: <stable+bounces-109345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607EFA14B02
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 09:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE483A0FE8
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE61F8900;
	Fri, 17 Jan 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HO+D1oDm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883811F8699
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102017; cv=none; b=fJJMWX4nuySvfyyMJ0OcYO419XM1t2JQKhasBUuGR2HzR5i3tGO6clUfq7sCflu1yEL8iJPUinQM8vQcvgs9uhZrtCkcKLw/exo8YvwY1IA7vw3Ju71Tsiln2giuqA8g+bCF9I0odgvElespxzdD82Gr7dGoPBQXekn1gQ1qUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102017; c=relaxed/simple;
	bh=/Y0NUz/bouJ57UHjGCZSqsghp0RyhT5B+8KEXF5mSHs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=SG8wrob8IwCCLq7LZPxTE3RjIEcz1G7bmDgAo1HSXQjqwCNzqyQYHhAkNkKxm3Z+za3NNe3tvnQRkqeSAHjYa94efRBUnfRSaU2TjI4OwiynlM0QtQ64LhXFyvwLwlt2TDyrrbYufXQOudw/0eYoyi2v/maP314o0k4kVsR5C+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HO+D1oDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935E5C4CEDD;
	Fri, 17 Jan 2025 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737102017;
	bh=/Y0NUz/bouJ57UHjGCZSqsghp0RyhT5B+8KEXF5mSHs=;
	h=Subject:To:From:Date:From;
	b=HO+D1oDmcBHOCEnjHZRtDpbOK0F6gQ8bxzFf2yV+zSTXnHP8uEZg/+xYXPdHbgOfK
	 U2kUGBRH4n9UvBWHkDww8oXKyA2otSP3IX2jaG3OLJnI528a5XfGZvXI2GJ/pFMzfi
	 1J5eQokCTJOUQN3ZwUkLEPt2rhqYboNnX9jWZIRU=
Subject: patch "USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()" added to usb-next
To: qasdev00@gmail.com,gregkh@linuxfoundation.org,johan@kernel.org,stable@vger.kernel.org,syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 17 Jan 2025 09:20:04 +0100
Message-ID: <2025011704-undercook-batboy-9f78@gregkh>
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
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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



