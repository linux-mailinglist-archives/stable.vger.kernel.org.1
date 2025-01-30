Return-Path: <stable+bounces-111288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A49EA22E50
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8641016800A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A41E7C08;
	Thu, 30 Jan 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lou3dSNs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1601E573F;
	Thu, 30 Jan 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245574; cv=none; b=KjmFq8XrKXG5rGi4DZSiKP7/1iTH80iEPLlBYkgXTo73G9a4mN6Bx+WdErIbxSsjRQOaZIhiS2vApYEUN4UYXynvJ5g3IK0jCkguf2fezFQk5CbXS8vSn8p+RHjwT2GemroDjK7DwHMhGnJ+4PYt39S33AtfcwGkIgg7c05gUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245574; c=relaxed/simple;
	bh=XMF5C/bw6Y/tqI9IH6BsdNMJbRnAJm762Qhou3EY82c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxJgdeHYpVk3l/12SzKWXIVZZuZcHK/QPQzJBHvt6KlaNAzugsBYZf9Ujwx+8FRTQ4BMyVwMyLrVfDYrMHmeLeIG0PAUH7FthlZSfyAk4G+dackkaOnr5ldEcT1azVYR4rsb9DFNx0ivEVpeX9qEhNAY03A9CnsWB/rZ3gGlCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lou3dSNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DD9C4CED2;
	Thu, 30 Jan 2025 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738245573;
	bh=XMF5C/bw6Y/tqI9IH6BsdNMJbRnAJm762Qhou3EY82c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lou3dSNsEmXZw59EnHRGPzEFNfaaA9/FiU9n5HjOrJ6u/eSAnnXjKtXM7coLcDgsr
	 d29IhzI0Tr0fjIIvS1aOy5EN10TzN3IFHcokd5j0M+O6EXrsDfdrrTaKYgBR7YOl/R
	 eC9WEL2tDagQNN2CB7yUT5+9dzQZprGercF1GI9o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.13 13/25] USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()
Date: Thu, 30 Jan 2025 14:58:59 +0100
Message-ID: <20250130133457.461470458@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
References: <20250130133456.914329400@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit 575a5adf48b06a2980c9eeffedf699ed5534fade upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/quatech2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -503,7 +503,7 @@ static void qt2_process_read_urb(struct
 
 				newport = *(ch + 3);
 
-				if (newport > serial->num_ports) {
+				if (newport >= serial->num_ports) {
 					dev_err(&port->dev,
 						"%s - port change to invalid port: %i\n",
 						__func__, newport);



