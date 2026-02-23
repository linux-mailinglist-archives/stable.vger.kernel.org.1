Return-Path: <stable+bounces-217700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BAWpCUwFnGlk/AMAu9opvQ
	(envelope-from <stable+bounces-217700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:44:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC6172CB4
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04365300574A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C253344DA8;
	Mon, 23 Feb 2026 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnpur1T4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861E25393B
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832648; cv=none; b=ADhmTa65dfENaElG6M4BuBGrPosldewgry/3FcY3L/Di9COqhXEjiAkYillTgjADxX6s771X30SDpWo+3iBz0ZcmOu9ZaLRTUNYefwEA8EKrgqEtSsIB3zALPx39qzceEg9ZgiTq75Si2BlXyjdvbVejaTvVr9jAtXovJtIkAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832648; c=relaxed/simple;
	bh=L8QsT2aSqZQj7qlHLJ1z5nvMQuW1ZgUvhpK6w+zUpOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjmK9APEfD5xIZN+pd/c+hyxdPbwRKwqBQPnXFXdY4nwvLQpcM7U0G5sODiROiKvSPnX9tg8UL/FlNOljGN/wAza1bkflGaKvWJBBUAoBnCNXYoi2cCs4xu18SavypZfOBvKS0HK1fejluRUJkWQX1h62prRwgaXaUtD7ZEoqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnpur1T4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2935397f8f.2
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771832645; x=1772437445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl9uNEPPppEML5fgEDGNwxM5o8rZw7NJ0hoq1ERXk8c=;
        b=dnpur1T4wypDdAd9Z/zAkQagHMllzxPtnRwRhW8tprGwSbDO0itIC1fnyY3PzgSJr3
         GiXW+kShNWdRgxHiDESmRPKSouqTa/s6HXb5alsdZbGhcCzymgmOL5Im9lVQ3tKp/LZK
         UVfpM4gJpI+aC7XOPHjIewBs0f/1x3vhOLMgCz2LMCVl6S9XJvOVQsQYoggJ1xoN9l4C
         MQGHCz1H1iKKvilE89FfPmOpxxpHQNjMxLp8WuVr4YKBspI6TR5SoUV4pfTdMJolDFj+
         +xMCi7DH1cVnBkQNikLxzdgLk0Aexg+2M/B3x1Sk1dDPyznLYKm8dMtoIB8Ph1kXpHNJ
         XV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771832645; x=1772437445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl9uNEPPppEML5fgEDGNwxM5o8rZw7NJ0hoq1ERXk8c=;
        b=h0Pspl9v7BFk22Yq3gFklmh2HPlF8yfPSho488GHfoCaJqpdtpjgpSjvU5tTTOrPP9
         vQIL6glvoJr+o6ej6yO05fiTLsn8RsbD2aqyLX6tPCPK4lpoGUOj9KH/JS7syBRmU+jM
         2btLR8vbRJp3RvN3pXoMHvtACn5Wq19yLzmLiy32d2ARRK5XogBQxIpT3qOlywlryCmY
         7L5XQFl1cDrI11V1msjY1ZocCODQd/IP4h04uuaFSg7RzScg5kj/MfMPaRtJNU9bnZ/V
         PKXX3M+ttqaLb9nuo3K6CLSgqIoA0+bi6NKVO3FaOna77cbNmEw2WrWO7koUcDfUHXQ5
         JQHw==
X-Gm-Message-State: AOJu0YyPWFq2U5OIO90DQzRA+5QFb4WvAR6D6uvWgsl9mZPlayEtN23v
	vin0QeVjKVHmAsqx+o9FcnOm1179hQdO21s0k9s++IlLtdmzeIZnItaIIEVlJQ==
X-Gm-Gg: AZuq6aLLH4zLBDMLx8LRZYq61NdyIKmHG6ftziclhYSVBSfwl5d9HyaPYybh83cGC7q
	QVu2sHlhjlQNBL7vKQMH5aNnPzyig3eJnGEE8gcut0mfa19jnhA36XLYnPGLvvbGazCx9OOEVZJ
	/glX3bdEkX3Qj3+741pCNaQ277S9q/TJgbKBTSTw756olrZcssMsv9csgA8XXukaI448a1IhufA
	85Em2yzlbP++jCIaCuNcuPK5dBaLCrXySONgdmUVYLWtuOBVttQqEO4aUwfRpY8+QAuaEivqy/n
	zIru4Zo/wTu/L2qoAXNB0+iSXslGhHEmitYjEaY6Z7cUMBSUWipLJSmPzBzjuxXXXchYH1Lx0dA
	UCD/My5l7aG/R/KvBtbVvo+uCNrJlZbtsuIsHTwc+VyVJ7vdc1JCge4KhrTVJCVXU3bnaHAz/92
	IO5tQQm65slKPQRQvbIX8iWLurAhG8Dcy79igN35ecXleHhWMqTsFBJMUe1hY2F9lCDncdTdpfk
	fYAC5/0Qkico4ZSkEfgGsa3eMu11A1/CTe6TstCmmTQew==
X-Received: by 2002:a05:6000:420c:b0:435:9d70:f299 with SMTP id ffacd0b85a97d-4396f174178mr12548396f8f.22.1771832644733;
        Sun, 22 Feb 2026 23:44:04 -0800 (PST)
Received: from koko-VirtualBox ([105.109.123.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff6dsm18319251f8f.25.2026.02.22.23.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:44:04 -0800 (PST)
From: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>
To: stable@vger.kernel.org
Cc: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>
Subject: [PATCH] scsi: backport fix for NULL deref in scsi_queue_rq to 5.10.y
Date: Sun, 22 Feb 2026 23:43:57 -0800
Message-ID: <20260223074357.7507-1-aminekhemissi61@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-217700-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aminekhemissi61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78EC6172CB4
X-Rspamd-Action: no action

This backports upstream commits 35fe6fa57b99 and 6ca9818d1624 to 5.10 LTS.

The original fix prevents a NULL pointer dereference in scsi_queue_rq()
when a BSG ioctl is issued with a zero-length request and a NULL cmnd
pointer. Without this fix, a local user with access to /dev/bsg/* can
trigger a kernel panic.

The crash occurs in scsi_command_size() when it dereferences a NULL
cmnd pointer. This was confirmed on kernel 5.10.0+ with a 100%
reproducible exploit.

CVE-2021-47552

Signed-off-by: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>
---
 drivers/scsi/scsi_lib.c    | 6 ++++++
 include/scsi/scsi_common.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 03c6d0620..4e86bfd3e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1174,6 +1174,12 @@ static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 
+	/* Check for NULL command pointer */
+	if (!cmd->cmnd) {
+		scsi_req(req)->result = DID_NO_CONNECT << 16;
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Passthrough requests may transfer data, in which case they must
 	 * a bio attached to them.  Or they might contain a SCSI command
diff --git a/include/scsi/scsi_common.h b/include/scsi/scsi_common.h
index 5b567b43e..1d9dcadb3 100644
--- a/include/scsi/scsi_common.h
+++ b/include/scsi/scsi_common.h
@@ -21,6 +21,8 @@ extern const unsigned char scsi_command_size_tbl[8];
 static inline unsigned
 scsi_command_size(const unsigned char *cmnd)
 {
+	if (!cmnd)
+		return 0;
 	return (cmnd[0] == VARIABLE_LENGTH_CMD) ?
 		scsi_varlen_cdb_length(cmnd) : COMMAND_SIZE(cmnd[0]);
 }
-- 
2.51.0


