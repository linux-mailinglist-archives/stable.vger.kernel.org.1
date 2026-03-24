Return-Path: <stable+bounces-230205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHNBDNrLwmkBmQQAu9opvQ
	(envelope-from <stable+bounces-230205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:37:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D531A234
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EA153010915
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC240758C;
	Tue, 24 Mar 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxkX9Zi9"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FB391E55
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373735; cv=none; b=PfmdSAg0GvAhvb1b8Rv2wsHGqhbSbxE/GmbPGSIefiVVn5m22JycqUtNixDsclz985Zijecd/trMTd7OHGXso19PAR3DtFn+8PIucj8gMwA3DOowPeSo++HSMktnGHwXIsIahefqNCIWCgNpvqY/7ATVh/+jLdLIw/6M9hsfvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373735; c=relaxed/simple;
	bh=ovVs3AWOZjlyKru7AE1DWVSZIN+/WI9oHTLy46VoejQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3lWbynps1wuA3ccHJnXCl2FvNSDVUbwihwKB1vvi8isgbwUYiZzuqYblMpMrmXEY6A8qhn/5I80TfsDDoVa2c+vg2vwbD68Qbrmx+CCFhJ7nfuL+wkAzjq8xSdEm4iJjKIoTJw6JLX6ZnQwh9sPpYewBUuFun0Ktboi0mVZ1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxkX9Zi9; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56b890d1687so1230830e0c.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774373733; x=1774978533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyYn06XDchtaJ0qC9SwQHF6RATVlz66/knGROoEPpBE=;
        b=oxkX9Zi9HxEiKfCtqdjJhPdCph1anegLeatQSlYHx4pTYvB1m+aTJqxB0kCZsOtEVY
         cFIGDEluvoklptcI1FMS2TaeMDPevGpxYDAToj7UjA0czz4jcLkyJ23ZfJNgJQNvo0wc
         D/Glaeg4XDyXu75Vl/y3tzVqQC6QiVuShvS6bTaKD3P/Yq6r1p8XUAFQmyLe+Ndf3yYX
         jeT5R2F7Zu0ZrrTQC6u1/jb6vuUUmnZqyWU52sFiJNtHC32DHdE7UhQHeg27RN+E7M3h
         5dBMwaJtrhiUALSstvMF6ifbC/wb/nINIK6PHHjts2Martw7e1bRhjq5jQOsKqq6E7N1
         ifgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373733; x=1774978533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyYn06XDchtaJ0qC9SwQHF6RATVlz66/knGROoEPpBE=;
        b=UjaMwFXef7Cm7qZ+7qGx+h3m9dYlRiz5SCLqpnxNhpxHacZx7Gu6TEeR8NMM0bJ3Hn
         yxtxSwGp8gNF4nVG8yYOjfmAgb/wkE/4sI7vR9SVF6nyZC4HBvjd049vMdOCqX5QVreb
         QqyZlanzMhj30aMhd3y/LJLkbejnq5xvYSMnenUnf9iKdgMbStZvfhxlI5FRIXDo3wfj
         FCfq+lbR76q//vrXGYz+7ySWQz+Iwnug55sG45i18cqpVCoUhAWfuoZQKPzqozoqRD5x
         hlLhXsGZO4dgboRupvQ6NCMTqDBZmb6YqWus2AaBPUTO7sZpykWGJHbYPnG1Azbc33+/
         j/sA==
X-Forwarded-Encrypted: i=1; AJvYcCX2vPBpb5sydwXh+8/mKciirmsilSIdfeaNOzTtoZ86htN+iASCLpqQrL34RKilsoB8yB1xdQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMyvC7mJv55fKLZ/49Dl7QuKj41twAOWBSzdngsBo8MMapvkwJ
	bt1le/QZkZCChZzOUHYTsc0ZpomNd7ut1caZDuhJ46IO3GkpgCoEg3mW
X-Gm-Gg: ATEYQzz6WgXiHg974SOoC3GugPdtPnoelP9xElmgNlhJ/+Ms/M05iadzrjWQZPoMFPO
	ZiB4HuxoRHNCQtZ+yGqoT4j03wRJr/5ee9XT7BWA1ploUMOpanq13gUz+FoNgZ7mbRJlsfQkEJw
	so3bDFDwHE2prsDy60FaFoWwxYHQakLsIqVYjve56RUcquvGAJZVY9vXs+wlBRyzHeRPDix6uBl
	Zt/2XphHxDxDc7Ltj4WFN5sqQDyLTrPMCylvZR/VlZtGV7PFSNUzft5FWMfKEI3cVdtC9GVmdpE
	XdItMJBlajHxFGh3I2e/tg0inpSuOm3LTOWrBgxZyoWzX7TmqG+E2U1Zsotw/WSjNDszPWbOs7p
	tRSXsFujc1wDsy+40jQ0a+sVSl+ZvLS6OM68kNb+EZzGk58wmwO5MMBo7qS64i+zN+Bwp2aitu/
	1mrMtg7Jq1xfWpHRSXMLwtJWNc
X-Received: by 2002:a05:6122:e1ae:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-56d2207aecamr479688e0c.12.1774373733002;
        Tue, 24 Mar 2026 10:35:33 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6dd:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cdd9f7c6fsm16844594e0c.0.2026.03.24.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:35:32 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: michael.zaidman@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: ft260: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 11:35:27 -0600
Message-ID: <20260324173527.11321-1-sebasjosue84@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230205-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 757D531A234
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ft260_raw_event() casts the raw data buffer to a
ft260_i2c_input_report struct and accesses its fields without
validating the size parameter. Since __hid_input_report() invokes
the driver's raw_event callback before hid_report_raw_event()
performs its own report-size validation, a device sending a
truncated HID report can cause out-of-bounds heap reads in the
kernel.

In the I2C response path, xfer->length (data[1]) is used as the
length for a memcpy into dev->read_buf. While xfer->length is
checked against dev->read_len, there is no check that size is large
enough to actually contain xfer->length bytes of data starting at
offset 2. A malicious USB device could therefore cause an OOB read
from the kernel heap, with the result accessible from userspace via
the I2C read interface.

FT260 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected, and log a
warning to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-ft260.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80..7ca323992 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,6 +1068,12 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	/* FT260 always sends 64-byte reports */
+	if (size < 64) {
+		hid_warn(hdev, "report too short: %d < 64\n", size);
+		return 0;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-- 
2.43.0


