Return-Path: <stable+bounces-271676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1pnsKzltR2p5YAAAu9opvQ
	(envelope-from <stable+bounces-271676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 10:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94D6FFDDE
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 10:05:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cFb1tIMs;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271676-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271676-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358073178F6E
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B95370AE9;
	Fri,  3 Jul 2026 07:54:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D262357CE9
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:54:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065275; cv=none; b=M6h9g1RNlUhqxkx6XnLo0TtiRbdNT4K1SU04TOf+K7P3EOfA+G0UPCV9zAKuKD1kG2ErOmugX2EaLnHI5jSA9Mu9OWx20xD6tS8x7ONqejIpfKDFt83jGNez8U3cP/obTQrPInAbLmspD0JMJlYNViLFgeVMK7Nsgf1iN1H1jB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065275; c=relaxed/simple;
	bh=uUEaGr257SVcEghz/VrSWTnDL6TlG6Mg+al6N5GpqDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndEA6BCWGvdclasyVJQBXVLku0N0y/A3fZmJkM2v0+hfVnUrN2MTncksZx2h/m1UigyYyW+Zmu2c/wbdyMldOrdybMx5640DZpAaLTncNq7l4iHavIImTalNaXNJY8A31Bu+G9iPlrv25yV3AWUNVXlC8B+9qNmY9j20Ga2Juwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFb1tIMs; arc=none smtp.client-ip=209.85.167.50
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso356164e87.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783065272; x=1783670072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0uc9u/smgtycisGY64visu/9W154DzGDHnBARqQPUc=;
        b=cFb1tIMsIhpgVHLSScCl6MNZtqfZPl9bpUvqT1HafhXU7CNHe4/mHl6KmmT/47WpJ/
         rx9wO02iIfFd+imkKIs2jT4Xvxk1hmo+pZT2H7CAyIrt/n8ZwAf8UtFnbnksnMdROoAu
         gPRw8ddATUbZK5z87sivuizKhEoY9v3RlHF+/NsoUcFh/beVh9UvPVS/F3fgB6cEWAS6
         y0Cd4PO1dw8jn0SVy+QmdTY+kMWEtGmCkaii1h6P9XEOqo8XmbOQuIXNcLpU7jif12gP
         fBvntK/BF/CtFO5qdybest2i/INeJvrdiqoOmda6SzhNO06pyzwPqgdx3Y0/W0frQnjf
         gMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065272; x=1783670072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0uc9u/smgtycisGY64visu/9W154DzGDHnBARqQPUc=;
        b=akjpoCQiawg2e7hNMHwY/3fHzK3hjcR3Aog+wu/412ljtGOigq9YKd2bQa6DgFvHZf
         VIGJ6JVC7G8qOJoifsI6td0H0pr5jcHbRj1DcWDhNnNo3yZz6hs7TCY85g6OGvuGD84q
         nReK/C5of6DpGzPAA0FlEQyw3Sa0AJhJBm42bc0qKI+nb6LYm8k9rl7H6A+Fp683rsJN
         6P76CvrOZegCkCjcoSeP/hk5Bo1QRciZzdrTHpjU4lRgRClR6DuhQT1J2Gch1lwg8GW6
         9GbhW2BwYSkuMWkJ0gFS4Xyi2uT1Wial9qJsQtVXqkv7UpA39vXjRe8S8RGFfhFQIkSh
         YbJw==
X-Forwarded-Encrypted: i=1; AHgh+Rrj0+PHL6FvSSpYJGFt0Z775CM+ntpWrlBarctPzg64aPGYielSdns4RVmiIayokuaqlRPerug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2hMwfcInplpBM2v+9Icadyqjx04hQ3Eg2WJ5nzRV3dfLhBIhh
	WA/zZu4/tVnSgQxoOx+yh9dkEFoxpI3fl9m7iU5dINLR242FfK16KhRv
X-Gm-Gg: AfdE7cltg1liZWiw3OuB/vIMdOl00AXmDmJRTcVSO8Z/2bHYKDvxp6D1KakFuJWuVe+
	cjfoqT+lSXQ+hmyEI2ORXysaMM+huR0JuxxXNrnxo1+S/ozh+X3s5zhfnSCY0cP+VWvwNVc0amV
	GoHphp5WI47mwsgAzKKi+3l61y7Abxyhh60LZ9rzjwbESFQ+MCwlnaaRY+uo0TWFwq9w8e42WtO
	6Nl43C3cbApljjjENiWhQa4gt58FBC4RvM6bY8vg/Zys5/YPgbOde54VzXqNxZtjYSv3STYaOe5
	md/HGlJwocdlDd8XqUrZ8b7sPvWxVR3SFi2aApbxoTE3f0wbWjoh4gXWpB2oK5GBXCjKKOIC2C0
	RbGZEniAFoFuuimzak+0fUqmbde8fyR5ZOICcAbkjcuNx90vy/CTSz5l4oo0OcpS0OpRk0oaQkz
	1OnWdxPMI5f1UEUC0e+sXkZ1trUBuMxb4=
X-Received: by 2002:a05:6512:a354:b0:5aa:6c66:e343 with SMTP id 2adb3069b0e04-5aec68b72f8mr1670652e87.38.1783065272010;
        Fri, 03 Jul 2026 00:54:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb768sm285986e87.52.2026.07.03.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:54:30 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>,
	stable@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH v2] usb: gadget: printer: fix infinite loop in printer_read()
Date: Fri,  3 Jul 2026 09:54:29 +0200
Message-Id: <20260703075429.302687-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701205320.227791-1-mlbnkm1@gmail.com>
References: <20260701205320.227791-1-mlbnkm1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-271676-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:peter.chen@kernel.org,m:stable@vger.kernel.org,m:mlbnkm1@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C94D6FFDDE

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
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
Changes in v2:
- Drop unrelated comment wording change.
- Add Reviewed-by tag from Peter Chen.

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


