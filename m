Return-Path: <stable+bounces-235830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AZFNA3O22nmGwkAu9opvQ
	(envelope-from <stable+bounces-235830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:53:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 084563E4EEB
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7043300D440
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C472F0C74;
	Sun, 12 Apr 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAtEcCxh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1B2D47F4
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012808; cv=none; b=LE7+WZFzAJx4qKJcywUbpSvWiiaAe7q8R9vQsWgYPS1lCCsXA83dDQFPJSSP3Kcqts3kStaNQkvKJ+KeBLdNuJFxree5WyUFFR5yRWnOPdRCydZbAshzuSQP/esB86XJA+f8kgOz5uBZlsrvaPDsemDOmwg9g1Seof3E7JO6Ow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012808; c=relaxed/simple;
	bh=MOPO5wfn7Q3HWfymgJrVMz+WptlVpp+6qfHmgyBDKsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPPEfd9hJN85lsfsHF3lgpiaA2pbWew63Aik626kpeeeWvCvjjU4+JNKKwwW2WYJxfvIxMjTM3ddjhH0qVdmEx/zsSLnUT+528M7N6NGQ+Mp1NPKvaRmu6yMou90fiD8gQW2HkC2UQvPnVOF5tpjbETsrNaWSAeOz0hzTb8kafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAtEcCxh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so2101259a91.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776012807; x=1776617607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl2owXRkWl9OSU4yU3CKzA/toNE+OIFlfE2UaXgvdSI=;
        b=UAtEcCxh1lZwFG0DvrCRK6w9UOmELd2kIpLtbN/4+ksoTZczL9PGLZHJwT4jafyDxO
         GDS/pfRZMc75tdzHHLVfMfQDDBZynPQ5gvUwi3+oHBTdBcoF1ybw0zTZe63Yp9YcywDn
         ybU+PEbjGHC7GRcytLXYrSA7W649Njn3EXyH8u+AzimQwu3DluPJvLwajLVcEUjNs4so
         pLhIaZg9SkXCr9AmPP0ns+HU0+fzPNIV+jUD+gUoulrYYlNhykqihvHP8VCM1bkpPApm
         gzLcbWq7nsxtAyYYQHDPFqg5J11dJ0atY7bwy3dqzvRwlk+jNGtUFwW1i7GfHCJLhw70
         VZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776012807; x=1776617607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl2owXRkWl9OSU4yU3CKzA/toNE+OIFlfE2UaXgvdSI=;
        b=mes/kIWKYaXXOtlyQiwZ+oHZZh/2V61dQMIbszcXIYC3SjIz1ST6RJEnzhTJJoSx00
         kaJPYnyecKjFQy9DhI0BQCLMfDjJYLUmlW+djUm/Kcyv2IqYAAEwpxdPuMe1WG04Wef+
         PqcO4dvncSHvtBFD7xiueEk+CsxTiMTioClq6VvWuK9KIsCCFfg1+btCqJnrx1DMB2mr
         x2vWCZ3yzMCFCD5KZsyy0gX8QUPBuKroUuiD6bS939uHS2F28RF6ZCNYgb94rWcQN5XD
         1QjWGFksVS/2dy76zfSsRZRe+7nkdnozdMxsBzemg07zHSb2p9gM1Ik7qM1hIESg0o2J
         gvYw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q+KUrB9Ip2QKchLum2s4gJqYCwk/6jjcWGhafAU3zVGyOmxxH8QKeuux2V066IAJ4dzsiCtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5S93KLpSqWZp8bMJEAZmjucQwJJWqcJtkzX6h+01WillfzLwc
	+PfgSfvm5wGsedhyIfPOr8CDn29iELfbnEj110M2pCNbGAYb5lhSe3k2
X-Gm-Gg: AeBDiev4tZK6Mhb8wcW7eP0B+TvsZW6/qk7KTlKKa4r5lcsWXydoRVuIUX5/UWs0pER
	EFuq0Qf+ba2M81H9vTgViguMAQeXYMoKVTreQatvcqfWidmXWPZjV0OJ+vAMk8DoKb9BtFNd1sI
	81B7gm3wkxa80P1ifOGWDAz0ffeFCXB8pXMBk46qykHhvhZ6UtqRaNC8b4KiEfMdRGgDcTBlmDe
	4SahLwaSJoN3rhXIb7p4TUdtpusXxRGiprHUJ+K1/w7IuviMbJdtUQHRKPlM5j0RCOW8x2RAZch
	7XRNVSQZtHE7PE+stNYnPYdo5E/PXIoOkvWoL6aC1XecGrswALm7Kk61Njt3TMuy4nSgc89zDDc
	BNGJLXHIQlqRskfuOy7imKYI7f/VzSkREySfj/0wu01VUezXcPQ64yvFmsr3y+qXKBhKjeqRO32
	qVwqDmoGShbd75UA==
X-Received: by 2002:a17:90b:3bcc:b0:35f:b64f:bf99 with SMTP id 98e67ed59e1d1-35fb64fc0eemr931236a91.29.1776012807196;
        Sun, 12 Apr 2026 09:53:27 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e5755ea3csm1635448a91.1.2026.04.12.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 09:53:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb-serial: fix port device refcount leak when device_add() fails
Date: Mon, 13 Apr 2026 00:53:11 +0800
Message-ID: <20260412165311.2578501-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235830-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 084563E4EEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

usb_serial_probe() initializes each port device with
device_initialize() before registering it with device_add().

If device_add() fails, the current code only logs an error and
continues, but does not drop the reference acquired by
device_initialize(). This leaves the failed port device referenced
until a later teardown path, if any.

Fix it by calling put_device() when device_add() fails. Also clear
serial->port[i] after put_device() so destroy_serial() will not try
to put the same device again.

Fixes: 41bd34ddd7aa ("usb-serial: change referencing of port and serial structures")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/serial/usb-serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index c78ff40b1e5f..78e3eaf2874b 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1148,8 +1148,11 @@ static int usb_serial_probe(struct usb_interface *interface,
 		device_enable_async_suspend(&port->dev);
 
 		retval = device_add(&port->dev);
-		if (retval)
+		if (retval) {
 			dev_err(ddev, "Error registering port device, continuing\n");
+			put_device(&port->dev);
+			serial->port[i] = NULL;
+		}
 	}
 
 	if (num_ports > 0)
-- 
2.43.0


