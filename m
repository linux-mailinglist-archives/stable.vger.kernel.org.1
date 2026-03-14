Return-Path: <stable+bounces-225431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H/cFOKStWnL2AAAu9opvQ
	(envelope-from <stable+bounces-225431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 17:54:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB73228DFBA
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 17:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24F373034DD4
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7FA30F7F3;
	Sat, 14 Mar 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPrP7LnS"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E603195F9
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507264; cv=none; b=muFS6IjGVYuf/cj8PB+xr/LlY4EUGMhp4msUt9gyg3egLSOPWmc5FSh+apOtELEmRupjnJzx78VmJvn39ZqEqz4g2XOumGUShaza5DHdSjhF+Qavt1jS4dHxuu/gJmKqrweHHwlpnYJYT8YPsUplfYH37hF6bJWe5oSBYVvRxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507264; c=relaxed/simple;
	bh=Jij9gi3TsnS7xUAJHX5L0HW3kLeYqNjfpTF6uWaPqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXHNZe9KEh6PsX4h4oyp5FhzrA5DgM4HgfQTQWnAOn3hNDyywVhgJqYQtVgZtwv+KPaVN7G0rHzzx/2vV3Ms/QfijestZHgRtPdpO5XablY8R3Ou8zJ2JLHxEBfkEy5zh7WFOZXVO6OXCvxKj2a7sJS24oNLIPOYvLYLgvxvScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPrP7LnS; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a6ac6f389so42764466d6.3
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773507260; x=1774112060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPyKAj/9uBDc/GZMXJxB4GAuk/lnBgwa2DYDtcJI+Qs=;
        b=PPrP7LnSWGe3DEd/JsWPEIPXmKmYN8fls0kUZwcCnMiMp3f+fUj+kpJuHHJBwaxCL+
         lIEMu5FTCD/Z41wL7UnBo1h8AxM/leCvC8A2w31WdebNsZhBvIQ2aTOoN189GEoBfv2y
         XRmL8jSzY6BhFA9cZ2HLaJV869+DqruLZiyVXW1FdvwAe2WIzOp39ZWZ4T7AAFBYkuBX
         iDohF8ycvb4mYF7FDLzt/ysal+BuYc3iiF1fEM+KgE2ps6RczOFKt3deOVMo0Cm3VstH
         wz3BhVykjCuu0BSy9DDMRuvbSTYzWDVpdoT867KWkbXCf+XCUHivI1RyC5HdJPN8O73f
         /bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773507260; x=1774112060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPyKAj/9uBDc/GZMXJxB4GAuk/lnBgwa2DYDtcJI+Qs=;
        b=IpsMpimTXL0Z8lZM8MbGaaqjNtG8QX/hOZ6i32Dw0PjYNieEYVQOm9wByC6bksTxwK
         bGHfDW00Mdyly9uPb48J5wL09AkzC75B4jVNVx/XuDTMKpL/eoJQz72LhDfKm5XeDCnI
         wfZK2D21B6TiZCyjRQjS++uzwnvasrC5zx5A0DHLN+dB9tHyJVVYRmgztM/qxYrCttyw
         rUfgFx07Ax034nx/1SuzwPJ94R2j4rAHjfibPmGsxgNOShd0toNfxg0bE0DmHJ4TZweY
         Qijqbu3YSUp/rRrqRy5CNHVDRrZXwwhkxqU09XMGt0NQL+Yh/2hA4q2f7MFhPKKRl2Ug
         yBDg==
X-Forwarded-Encrypted: i=1; AJvYcCXbgkFNhAWBL3oL6v1vn3XbKGzWAr4Bodkoh1KCOLK2Z0VJYlVpCAQvkBkKUinEujHkMlAz62E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4CG/m6Qk0i0g/yKvS7FCwbKPeAinvwIPrYmT5DYz7pDL7IHJ
	osVC5mLLKzfptYT3AFWkTZrahI2jymPoV2zKrrSPfBbGey+l0d+L/ZZI
X-Gm-Gg: ATEYQzx/p4Y87ATdvj+av16Vqn1YTmQO0CWIY1Spz9MsgyKHaWQ+LebW/6jF6TvaQUC
	oTqwF6YzBSynPois3anGTxBeybW8FRi0g7pdOGs6LGEgIelGJeCzDspygBLntSSFOYg5AJ1K4+G
	TNnsKwiSxaenRKtvnkcnyHbsuQNZKJz7JYv0E57lvijDNexSFg1+V9/lvy6ugEXpL3S/EvC2p/k
	E6puPinDUeyXxlJRKlKgi4hDFE1fY8XwexAlC0+WkQbUwjlpfQ9XAmToAPYhsti38Z24mQ5AAep
	H3BjnTvxtRWqHMQEcR0U97zdLZpmoPAoK+LsKpC81c1SsvTbxA31rBJbwhUEBYUoNCWNFM/pHbr
	STo7BQkhOFwGMjjQAs0uizCi4JCjT7/+W2lXgVTt5ZgvHFrkArDNQ20fGvzrxwc/aZiUk8sO9mF
	NLIuyL4L9W/GJyEzxIs0Go9yCOHp3XCayOlsTdyYTiRy/5Hp7/6d1i0J15L7voOL8UXo4HsrAxV
	emj
X-Received: by 2002:a05:6214:529d:b0:89a:f10:996e with SMTP id 6a1803df08f44-89a81cb9887mr107045666d6.6.1773507260019;
        Sat, 14 Mar 2026 09:54:20 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cd7f49sm83527896d6.34.2026.03.14.09.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:54:19 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ibmasm: fix OOB reads in command_file_write due to missing size checks
Date: Sat, 14 Mar 2026 11:53:54 -0500
Message-ID: <20260314165355.548119-1-LivelyCarpet87@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,northwestern.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-225431-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB73228DFBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The command_file_write() handler allocates a kernel buffer of exactly
count bytes and copies user data into it, but does not validate the
buffer against the dot command protocol before passing it to
get_dot_command_size() and get_dot_command_timeout().

Since both the allocation size (count) and the header fields (command_size,
data_size) are independently user-controlled, an attacker can cause
get_dot_command_size() to return a value exceeding the allocation,
triggering OOB reads in get_dot_command_timeout() and an out-of-bounds
memcpy_toio() that leaks kernel heap memory to the service processor.

Fix with two guards: reject writes smaller than sizeof(struct
dot_command_header) before allocation, then after copying user data
reject commands where the buffer is smaller than the total size declared
by the header (sizeof(header) + command_size + data_size). This ensures
all subsequent header and payload field accesses stay within the buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/misc/ibmasm/ibmasmfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index f68a8957b98f..dfdfa9ba4747 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -303,6 +303,8 @@ static ssize_t command_file_write(struct file *file, const char __user *ubuff, s
 		return -EINVAL;
 	if (count == 0 || count > IBMASM_CMD_MAX_BUFFER_SIZE)
 		return 0;
+	if (count < sizeof(struct dot_command_header))
+		return -EINVAL;
 	if (*offset != 0)
 		return 0;
 
@@ -319,6 +321,11 @@ static ssize_t command_file_write(struct file *file, const char __user *ubuff, s
 		return -EFAULT;
 	}
 
+	if (count < get_dot_command_size(cmd->buffer)) {
+		command_put(cmd);
+		return -EINVAL;
+	}
+
 	spin_lock_irqsave(&command_data->sp->lock, flags);
 	if (command_data->command) {
 		spin_unlock_irqrestore(&command_data->sp->lock, flags);
-- 
2.43.0


