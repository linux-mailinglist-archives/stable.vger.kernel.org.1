Return-Path: <stable+bounces-270250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JWKtBrp+RWqdBAsAu9opvQ
	(envelope-from <stable+bounces-270250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 22:55:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C986F1ACE
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 22:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CJBjvnl3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270250-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270250-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4D13070E11
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B03B47E3;
	Wed,  1 Jul 2026 20:53:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7B33A9D95
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 20:53:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939205; cv=none; b=ChQ164TrUbkJiPZg5cMMdxpeGOf7yVDiV+kJcciQGVKOS1v6ryPBOHwAoZR8JF37D528llQV69KpKLmMBZPUXoWSNjCYvcO+bI/oMAUaLcJnxPJuwqGGoI/Bxig3DMZnSNnmD6i2U0KJ+Nmm133KexcF7a9CVBdoADfZzI5+crU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939205; c=relaxed/simple;
	bh=+ytVn4F8B82MF7fCTwoeLkSOK6REUhITxK2y1XWLzJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8IB18TKY4Rx8NVpcKv8YNrtp4GYkGTWbBX7gjJqZnpTM3DiAh+OscNdN6PYaDmco5wftlRFfGuPqsoTak4LTMHBibaDaOf6CLon0GCWO8S4Vu/OTRIGDBNH6D8tz/pWdfYQ7i43tqUujCIZx+BBpc8gbgPcKNR479R4D/KaJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJBjvnl3; arc=none smtp.client-ip=209.85.208.174
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b030e889aso10413161fa.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782939202; x=1783544002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTEVuNHRith4UNmKhVedI/AI7ZCuYkzxvsw4lmOysQk=;
        b=CJBjvnl3HjhG4mVGoRhvnR2KvXPhBDoUJgm/dJheH49tIlfqQ5AxABjfzi+1Y9USaV
         GjCNyJH2/bgtI/JrFm6X55r0rkcqW+w1r4YOdNN4ACnRaptjEhS6m+Gq/Ewb4HUaHtfC
         SXLs6j8csv6A4yeTwD2PpVYSC+iItImivZ4jUKCfdJ9xqAeJj+jpL9v0UXPG86is0QoB
         qDS1xM6+fQ+qUoBDx2+XNgIBGyj9LWRHgMFFuRH+utTtR0P9zgk8YyrJz/SIb1MoTc5m
         K2Bu4YcJA6B31JnYRBUPfOeLtNXjihMJb5ygWkVdGQCMqdlz8FNwYjHEsbIfJDOynwAn
         2gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782939202; x=1783544002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTEVuNHRith4UNmKhVedI/AI7ZCuYkzxvsw4lmOysQk=;
        b=c2xJ8PcgCh5Ib9amI66YAj2Fwp0KZyOhlooeszvtdPndQ3JvtGN62/edpBhyKxJX+q
         LdsqZ9Yu8asxF6nXzkdbNYb5rh4/pUd89MZ0b198JBkcYzeEr5itDD+IxxuPLxn0D0Hs
         lTpcV5ZNZisaABceT6OiJQ0wBjSPCr4ifhDBZUGalbUJi4Qgm9drSyoS+SlizQqs0wGv
         ONhaQFhfg20EYWRbedETg3s1t8JqIUFd1gVKA91ugFUBSDPLRYtHiTedNg9DWOc2/CMc
         ybv9IEkF8USvq50Mi0lkvrphdVjd+cALKHxOSvrt8AMEMIQQJ9SpbLnjw0TamSZX78rI
         Pnuw==
X-Forwarded-Encrypted: i=1; AHgh+RqQOvglZOdQRWqiJffClhDlUDPRvvhAMdxv4mZi+j71RVxB28GCV/E3MBYagVu+VaFm9FzcbQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvGSCvpSJobXu8ZCsz3QW8zlcIaTyXWdClllQlcgEU+tScYIS
	A3/gvtcLm4QQtjsX55D8VK57Cx+tNiL8SUA+17rzUhP+DapQI2xYP0gx
X-Gm-Gg: AfdE7cmWtCKgwPXqKDHtNge3xlCGu4LdBgFL/sJwsJhz3mbHfTHX9vwWsIZgAgivp3A
	atXT5u6BKznEZPzEpuKhkFGNXva8Kh6Mxsr+Fv0W+Hkh5JBaZZGDd3MpuS6k1nUUJin+W6bZApj
	Bx7QKqA6Cdx2NhjL4DAK2Kd2FN3hlyEKiMIb3tk5vJ1d0jNCUkW78rUyIJncTaP9sOcgSz4lKzx
	bLGqFOmXhqE4pFVZjXeDBfTnfPXXaJkkljRy/BpT5nT7UZIjwLoWKplgLhWdN2K/EoqIZOfSDre
	DuMkO/ByGxGsNmdUs/1kIWWHCKSLXrJpc2r6G6tBSq6cCuR9c1cLRl41hWbUVNIQaB0W4avEjrx
	+fnSBbNxPv15Cj/ZJuf6zSMNEg3d4v+YnZWYu0lSJBe3PqXH1+nHz1+K/Ma2EsQKe9JFXj/Ovks
	flkQ8Vu7dJysMmGcsGaWwPuDLn+qF0/9U=
X-Received: by 2002:a2e:a99f:0:b0:39a:e7f6:49a7 with SMTP id 38308e7fff4ca-39b340d4031mr8050511fa.28.1782939201478;
        Wed, 01 Jul 2026 13:53:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fe594fsm2237911fa.31.2026.07.01.13.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:53:20 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: printer: fix infinite loop in printer_read()
Date: Wed,  1 Jul 2026 22:53:20 +0200
Message-Id: <20260701205320.227791-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-270250-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:security@kernel.org,m:mlbnkm1@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mlbnkm1@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlbnkm1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89C986F1ACE

printer_read() uses the same variable for the requested copy size and
the number of bytes actually copied to user space. copy_to_user()
returns the number of bytes not copied, so when it fails to copy
anything, the computed copied length becomes zero.

In that case len, buf, current_rx_bytes and current_rx_buf are left
unchanged. If RX data is available and the user buffer remains
unwritable, the read loop can repeat indefinitely.

Track the copied length separately and return -EFAULT, or the number of
bytes already copied, if an iteration makes no progress.

Fixes: b185f01a9ab7 ("usb: gadget: printer: factor out f_printer")
Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
A small userspace model/reproducer is available to maintainers on request.

 drivers/usb/gadget/function/f_printer.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index e4f7828ae7..e346e4c26e 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -432,7 +432,7 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 {
 	struct printer_dev		*dev = fd->private_data;
 	unsigned long			flags;
-	size_t				size;
+	size_t				size, not_copied, copied;
 	size_t				bytes_copied;
 	struct usb_request		*req;
 	/* This is a pointer to the current USB rx request. */
@@ -525,14 +525,16 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		else
 			size = len;
 
-		size -= copy_to_user(buf, current_rx_buf, size);
-		bytes_copied += size;
-		len -= size;
-		buf += size;
+		not_copied = copy_to_user(buf, current_rx_buf, size);
+		copied = size - not_copied;
+
+		bytes_copied += copied;
+		len -= copied;
+		buf += copied;
 
 		spin_lock_irqsave(&dev->lock, flags);
 
-		/* We've disconnected or reset so return. */
+		/* We have disconnected or reset so return. */
 		if (dev->reset_printer) {
 			list_add(&current_rx_req->list, &dev->rx_reqs);
 			spin_unlock_irqrestore(&dev->lock, flags);
@@ -543,6 +545,17 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		if (dev->interface < 0)
 			goto out_disabled;
 
+		if (!copied) {
+			dev->current_rx_req = current_rx_req;
+			dev->current_rx_bytes = current_rx_bytes;
+			dev->current_rx_buf = current_rx_buf;
+			spin_unlock_irqrestore(&dev->lock, flags);
+			mutex_unlock(&dev->lock_printer_io);
+			return bytes_copied ? bytes_copied : -EFAULT;
+		}
+
+		size = copied;
+
 		/* If we not returning all the data left in this RX request
 		 * buffer then adjust the amount of data left in the buffer.
 		 * Othewise if we are done with this RX request buffer then
-- 
2.39.5


