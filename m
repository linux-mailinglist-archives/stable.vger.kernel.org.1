Return-Path: <stable+bounces-217836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJxZGB3gnGnCLwQAu9opvQ
	(envelope-from <stable+bounces-217836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:17:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC017F1CF
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958C7319113C
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 23:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1D37E2F4;
	Mon, 23 Feb 2026 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYRYR4Pv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88C37E301
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888449; cv=none; b=PhTM03PBQJBnj1mj3srjIwiODD9+WEe2WlwiGlHPGgiHfSTwyUiKtoODFcJQaowJHOXaG6IeaPT5ZaZwlClnfEPEZ7LfkVQaoyApXBC5y4AwZzgHZLLFLbVG7LhaOMC93xMZGE3RShX5jjGFxnmq6SiipXWEe/LGnqCv/CaFq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888449; c=relaxed/simple;
	bh=78/SO2vk9H9jOc9asTUSigUWFRzQ13E5ey6GoRlAU3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=beW+NvZCObCA2V9qtUyaQ/L/ba2Pzr6e04rBtwhjjuJD1Qv05theX9CCA78UMHPIMEFJIXIfwSKBAHa/r89iJ0VfRB0IUmZ7bNfSJAnLJfEOstlBDUNBRv3XPVbxFp1ELcwXuzXrIJngOG3LxKrMxrv7sscjOBIg2HPJ45Cy1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYRYR4Pv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so42572495e9.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771888447; x=1772493247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8V0rD3rDR6BU275miJPHJ2o3wbN8SV4IkOTXBMc74o=;
        b=cYRYR4Pvhet/znBX+dvT3b9O/5oaUbl2swFgfYbqvvm/DxUkjILhEfPIpGviGgTRBN
         KwhiYqYQlG/our0dirUY5oQb3R7F5LcZv2lTECAbLSNpLjduDL4lolz7YIpQ2OAZhHw4
         ptGPfpKc6g0sxEVudvhgwBW5tu+Go/kMop+X9pb1c3hcwVgOYjEuFpdkVFrmqMb8lzBC
         4l83w2jlWyZ8lVyzOKZ1Tdl21DTiXxjVD1Kripga8NO++iuykmqDxRA46xPnlZpyG+Pw
         lEU/C/AN71Cru8Gs0RPQ5kEss3I4CSXUvG3gccLmDh2gKfM3c5jFUB3P2q/yhi1nRFVI
         8cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771888447; x=1772493247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8V0rD3rDR6BU275miJPHJ2o3wbN8SV4IkOTXBMc74o=;
        b=MftDujBSU6fyM+u5o5K4y/zxCZXqMOk9C2erjgBXHe9r3J7BvviN748bWEaQMp6+Qw
         Omzf7qmr4I1kOZ75CswG5hCBC+SQFQQBBYqsnBSRCi8Q4+ggQ0SYH9QCduLehvQpugwl
         KJuP/jhh1q3Gm8BNNr/YROfwSy/fFkf7oN2Vcjfv4HrUiUXN/nUi1RLuldKhP85PsN8U
         B8hmPs9/uMLvNdqq//G2QRWyKCunrRDGRjzeFLi1p3gQ/LFFwQUIX/GZbGcYnBMJvH4I
         vXtJlpfCUEQLiQNXmhjNcpX3n1/Q6A0jafT51GtBT4SZXBqkFF+4BtvzP3fnN0T1HlbK
         VMyA==
X-Gm-Message-State: AOJu0YwFy9LbO9n9rFC94XHuObvD1YmHpwavskbNW6zaWipERqFtbi/+
	qxY/cEs4hrjhUunP+aPtn/z3kWDFhmS1mC7h3a/2rkGXfSVAfDDwfZgTZQwmzg==
X-Gm-Gg: AZuq6aKyQ8pEGQxMsbcS72/e/6A1w1Lg+uLNShLTAOwQKfzSbNpKMo5BH1KWF7Uj4bt
	7jkyuWfAgNkBYM9o27AAOdeFzJRMnbEtfLETMN3lSeWoEtJHdoRMHOeQinJ4//7vGLmgjFmbp7D
	OIWaUmywnsmbHdNYJavEC0F2taoqFpuqxkKne5HNSManOCSaU67bhFY0BWtGmXfm/oY0hsh67MW
	BCc/IOVJ404kQp8psojf15XaTKilwTGMqmeOG1T8GXTAI68B/ufxV5ru5oXuGQjRmB7jmWPWdN0
	6MPyOv3TBo7CSt1K/ZpDAtqnY2Hc8C2+zGv0GYFcn/hQM610INyRaPe8pwnLAG2JaPUDnHkMd44
	H7/gfDOApNTx4hNaBl3/253B00QRiwRGybvDE/rvyy848XmhUCOCRf5mnMHgSAmKQsd4iRdJmwa
	7e1SiG8+NXdj9+hJHiBkU2jQr3qaVQ4Eor/JKTETDG9KiJr3MuSO9T5WbO8PM9dnyezdqo0HzKt
	x7DgdElqSdebVsjhLGOF11AK3Dywn7k1K5r
X-Received: by 2002:a05:600c:4452:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-483a95a859dmr167075915e9.6.1771888446387;
        Mon, 23 Feb 2026 15:14:06 -0800 (PST)
Received: from koko-VirtualBox ([197.202.199.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm322325985e9.0.2026.02.23.15.14.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 15:14:05 -0800 (PST)
From: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH] scsi: Fix NULL pointer dereference in scsi_setup_scsi_cmnd()
Date: Mon, 23 Feb 2026 15:14:03 -0800
Message-ID: <20260223231403.14069-1-aminekhemissi61@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217836-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[aminekhemissi61@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCEC017F1CF
X-Rspamd-Action: no action

A NULL pointer dereference can occur in scsi_setup_scsi_cmnd() when handling
BSG ioctls with zero-length requests. The function calls scsi_command_size()
before cmd->cmnd is initialized, leading to a kernel oops when the pointer
is dereferenced.

The crash occurs in the following sequence:
1. BSG ioctl issued with sg_io_v4.request = NULL, request_len = 0
2. scsi_setup_scsi_cmnd() invoked via scsi_queue_rq()
3. If scsi_req(req)->cmd_len == 0, code calls scsi_command_size(cmd->cmnd)
4. cmd->cmnd has not been set yet (still NULL or uninitialized)
5. scsi_command_size() dereferences the NULL pointer without checking
6. Kernel NULL pointer dereference oops

This issue affects Linux 5.10 LTS . Local users with access to
/dev/bsg/* device nodes can trigger this crash.

Fix this by:
1. Adding a NULL check in scsi_command_size() to handle NULL input gracefully
2. Adding a NULL check in scsi_setup_scsi_cmnd() before calling
   scsi_command_size()

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

