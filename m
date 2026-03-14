Return-Path: <stable+bounces-225433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FlXIrKTtWnL2AAAu9opvQ
	(envelope-from <stable+bounces-225433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 17:58:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FC28E025
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 17:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EA41300BCA5
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A403090C1;
	Sat, 14 Mar 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkeLzWI/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967363009DA
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507500; cv=none; b=TrJu9Byfh8BZXm4cPdpf+t0jyGD87E65UI/KgcHHk+62quqjCUE4KnFnvvgrXgHBLQMytKZunIdeXTznxYzTv7JzvvI34LogJMphWFUePSJSNx/F76k5MWTfgTBo/YKCJtsWyofQNoq5cW4uTtr8Ux1daOHPmETCsGQ2WgZIMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507500; c=relaxed/simple;
	bh=RJQligzopvcVnL3GVik1MA/7l4yn/T/8LnZtjy7Rnlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sw2rZiw5V7tWY9A7sNAOUzARrqJMIjtO8WTOOG0HXwK5sJNnQjXKTf78QEAbOTU7NbNWJCWVP6ZH9VWyZIKM8E+6/4lMPkNJtAb96g+HCMzb4dSJUtwg5vxT+E/djF8Hi/CwUdwsX6V+c7FS16ze1R9UA/yXuxsN2zpks4lQM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkeLzWI/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899ee491af3so38439906d6.1
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773507498; x=1774112298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FJSg6yO8bqCihG6mTbOKq9sLeSeUKoFCGVbsYkTlRw=;
        b=IkeLzWI/iBvDvXNW4+ZaUSE7RYQ2knUgcTWlkFxkEZ2PCW8chAMpNq6I19ypcp8LGi
         +4sA/VxvoYlGAPNxn6aO36Capz9HB6PiJ8HabwP2/WOlV5fDE1tSzx5fWW67rq0p3zPG
         vh6wi/WH15rF+Stf61wQ/2SLnHc+4ZLLoUNYb0bcI5AHTAtLqxx9OYmvD2K44VaIdzV+
         1PiMRmu/tydi054JwILTE7ZwOHIFIanpaixjUXWRBLt/r0bzKJ9zgjBqaGSPVbY20DWd
         1BBzNv/aE6aS0audULPGVcXqO8o7LQ6EyXN/Cq7yfezSmE0h+ysQY6Nt0/wAm/zmcxtx
         yhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773507498; x=1774112298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FJSg6yO8bqCihG6mTbOKq9sLeSeUKoFCGVbsYkTlRw=;
        b=K0LZahdU3WXZ0HdWoeGiOADIExMWU0muQVfPkFJoidmTS4u6LdzmDMUtyYAMXmrPaF
         UdbGIP4GBV29qlAsAOVvi21azgWtpiP8MIlv6ZF3jRf9c3z114A9pKK2nangFpVOqqtf
         qVZt9Y5o1DI0NXSGeM4X7GgKE1sWqVpVuldlvfCstJ+9GTv3C/jrWatwT/qGk1pc/1zx
         igMmnndxiEMRDOsVLlwlT8NE3J9BcdRcbgVupYt3zH44pmRqNADPbiQpGr5R4vO1sFRg
         F3p7rDRCUR25cnYZgJA6fmN/1Rx/2Z6V+gG7/QTalhA/9+LVggolTtMu8fUAUQWWfVU8
         1p5w==
X-Forwarded-Encrypted: i=1; AJvYcCV9g8rdSlG8cl0yVawNOwjhNoGhfIvgB15xMe+DuzWWYgP3KqwuprkxBqOyBpSZVaAB2HTs/iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DukS4y+wfBdC+yKa0l2zWQKytvS/f7Q6GT7PKvmL6/ni8mjF
	lgb3cRdXVoqiP70034qMyaenHFXeiqA0w41zOq/NY3OdGwYM1NTj7kFvQs+yVUAQ
X-Gm-Gg: ATEYQzzRy8PM+uwsNrcJn7LAESPkQ+UcxuqNmRdGzPYqLWYV5A2jJUDQ86PdWzm1kBC
	mxjGzreq2qXylhRqRUmC7JcGMzuIaWIR5xBbvtDlkTuL6uSP6fARqXppA5eIu7sVoyOx3fjF1ru
	IwILyjBFA4tjLR26kTzD4hgjiMQxjlGVmrR/YuND0XipLWrM2snCMofyZXWXTBsFgLRIKXYZaif
	pkrE8Nx59lm9CyuPKxk35l70FORsSdBWgB1O9qd3XpdXgLj8dWueGXPeAKsYicrYRhuuPfVbwvd
	eRMxEl6bEJKw9rbaNkmHXvmPbVRGyy0SJtIeIR7XlK7Bn/KAaL74N+0v1sv8ycAQl92hqv8bkrA
	KHEKqSW24vDRIa8ATnvZwTjPXrMv8oQoip/U+Epan917Athuqjfw9nWj28W1MgLhCvEO9mmqPrO
	hjuxUYHpUhIp65ROHTTY07+PWDdCgCXGp9X28kVvyu18kOgm/epzRdpB+OoIqxZjuOZ8GaLEbLJ
	0cZXhc4ej8NICM=
X-Received: by 2002:a05:6214:1c0b:b0:89a:ff2:b8d4 with SMTP id 6a1803df08f44-89a81ef3356mr114611416d6.36.1773507498590;
        Sat, 14 Mar 2026 09:58:18 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm80958236d6.8.2026.03.14.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:58:18 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] ibmasm: fix heap over-read in ibmasm_send_i2o_message()
Date: Sat, 14 Mar 2026 11:58:05 -0500
Message-ID: <20260314165805.548293-1-LivelyCarpet87@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,northwestern.edu];
	TAGGED_FROM(0.00)[bounces-225433-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 863FC28E025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ibmasm_send_i2o_message() function uses get_dot_command_size() to
compute the byte count for memcpy_toio(), but this value is derived from
user-controlled fields in the dot_command_header (command_size: u8,
data_size: u16) and is never validated against the actual allocation size.
A root user can write a small buffer with inflated header fields, causing
memcpy_toio() to read up to ~65 KB past the end of the allocation into
adjacent kernel heap, which is then forwarded to the service processor
over MMIO.

Silently clamping the copy size is not sufficient: if the header fields
claim a larger size than the buffer, the SP receives a dot command whose
own header is inconsistent with the I2O message length, which can cause
the SP to desynchronize. Reject such commands outright by returning
failure.

Validate command_size before calling get_mfa_inbound() to avoid leaking
an I2O message frame: reading INBOUND_QUEUE_PORT dequeues a hardware
frame from the controller's free pool, and returning without a
corresponding set_mfa_inbound() call would permanently exhaust it.

Additionally, clamp command_size to I2O_COMMAND_SIZE before the
memcpy_toio() so the MMIO write stays within the I2O message frame,
consistent with the clamping already performed by outgoing_message_size()
for the header field.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/misc/ibmasm/lowlevel.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
index 1a59d1b8e05e..xxxxxxxxxxxx 100644
--- a/drivers/misc/ibmasm/lowlevel.c
+++ b/drivers/misc/ibmasm/lowlevel.c
@@ -19,17 +19,21 @@ static struct i2o_header header = I2O_HEADER_TEMPLATE;
 int ibmasm_send_i2o_message(struct service_processor *sp)
 {
 	u32 mfa;
-	unsigned int command_size;
+	size_t command_size;
 	struct i2o_message *message;
 	struct command *command = sp->current_command;

+	command_size = get_dot_command_size(command->buffer);
+	if (command_size > command->buffer_size)
+		return 1;
+	if (command_size > I2O_COMMAND_SIZE)
+		command_size = I2O_COMMAND_SIZE;
+
 	mfa = get_mfa_inbound(sp->base_address);
 	if (!mfa)
 		return 1;

-	command_size = get_dot_command_size(command->buffer);
-	header.message_size = outgoing_message_size(command_size);
-
+	header.message_size = outgoing_message_size((unsigned int)command_size);
 	message = get_i2o_message(sp->base_address, mfa);

 	memcpy_toio(&message->header, &header, sizeof(struct i2o_header));
-- 
2.39.0

