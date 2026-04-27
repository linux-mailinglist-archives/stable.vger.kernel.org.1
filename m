Return-Path: <stable+bounces-241282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPokH0Au72mb8wAAu9opvQ
	(envelope-from <stable+bounces-241282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:37:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808846FFE7
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EACE300E702
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389034C806;
	Mon, 27 Apr 2026 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzUE9KhO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F383A1D01
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282615; cv=none; b=QF7HXvpZv+Ep2dpG1RMSIXJbbx1DZpkPER1bVnqDKwAhQmyvGk1ILTLBUNfTlDgTNN1tXIJLQaVbbLqDcI0v5NzZ+EMj+SDUGQqAZVR0+3D9djFl78ynlPAlZFOjmYwlne4mmivsGWcioBPb9qr0EJtNLKIltWFdl0Na5snv618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282615; c=relaxed/simple;
	bh=8AsHCJTrp6oTPAWoi4XYz5UZQNzkOr1rry65yDMLIek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNyXYpX2A/eb18cOV8jYmDQJtPocAY6+KghNYXNJE3WYhRYesmZ12SlgWs/P4zAhi6Zy0tMgzF1+tboelCNvPHjdikuhhg7eWg85CxZEQJzIOP8c6nU+4P9dy1HAsSbNM+XDK9/mfg/ow+MmA8yS6Mpyztq7gtKDuxX7tieTUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzUE9KhO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so3924237b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282614; x=1777887414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7/9M8ts84ru1FYHlgZaneEVjguv4ZNz/ttVD2wMfr4=;
        b=lzUE9KhOfOxACVxxuOcyG+POrjsSp9OzDu7iNUQOet2+ydqkp6i/+oBcvbCQiTH7BC
         /NH7NiwoPJ0JlKR9koa26kvTfB7PbUZgGgoZGaQmK39dwwrCFd/WM20C0/MDoUAng736
         UZdHI1G4RfR1zQamMgkTo3059mwI43M/WvCgY4dXLhoS/E4c2jVg2OPBU8c4uwmgFhHT
         ky0ovQOCsJhf1PrS/J6dqhiCQTDPF7AzbU/IJ5BtnnLJP5eqWdW3qMpV+DmOkDGtThPN
         JzNgM8mxczsaynnK4Fsw7aF3ZrfL5gVuNDkRBQbZSe1Ril1BsjWDzleNTcCWBtR/5o5c
         EmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282614; x=1777887414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7/9M8ts84ru1FYHlgZaneEVjguv4ZNz/ttVD2wMfr4=;
        b=YiYHXIZ9LVFS9hBYDW8ehPduEqDTqs/1Y/tlm2GGVJzLVSMajNyktR7lSb9GlXCC6m
         cjEKRHA/8QjwCi9B7Y9cArYq1i3jDBejmS5MvA86mfEx6FFGHwUfvvzV5fbXVBMlzqYx
         8/sXuSTz21XnpwlNmgka8PLqTy1/DdWYap/LIhJ7+8vGto6GPtQhhcI4JzKpGhqWv+rr
         pJdxFlom/pKEhKcGRkjrhl9Ye42QaVTuU2xt2CEy+eqU72wP8cg183ori6LT0syuj6/Y
         veHGWcZsS909+HZoccpEkStRP8a9YgVNV1DJGExUJRTuDP2jlo1QjCNAVzwLgp0bd+Td
         ud5g==
X-Forwarded-Encrypted: i=1; AFNElJ+SjeoZmcGvH/LXlSdYIiUR6WfW0oOljowJLWtPxMcXdwgx/1rTO8Nkta7szjMtXzlcptv3KsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5P6FPBALv/YP3SCb8jyj3bDmzHxz54U4S6dmNuehAtWgj04ia
	vnY3I59aVMDur+YNRMYAEzopRZJY9BALBHVkkbl+ErqcbL6Ld5AqijYKbf0rJRkYDDQGaw==
X-Gm-Gg: AeBDieufaaTPR0NyfvnMcB8v2VaoenEClm0ZXla18svXBKNwqdudzwGVepWNxiL0/YT
	8ynLDQY3vloRG19X//92cXZnRIzMLvHeQabcqGOsGnzroSDUsws/0v2X/Kl5wYlVPDSvNYEts7D
	zvwsXTB2WQePozfPh7OuBY5HviWpEF03FY0QZZBQFyXDERxLey2RrqPpr2MoaQpbdnpqBsKPjLL
	UrhmB8N5LllG9iV+OEWm7LvJUYSP3bf89+z/AMIF9fRQvSmnhFeXLeCYsAYKbnJzWaU/ypJuueQ
	YPyBYWHHjfI4QHBuhsJxfqZ+m3GXgyKnSKTt+uiXqkhx1+n82gO0eH8UW3bgVj2Bp0TNWNUsXRX
	QJWSJ7+A6AtQuAvVm87zr+H4eFYT/Qsqme7NQwfwOKN8RP5/+dxn0HBIJtDGIxFuuY+EixHQ0hF
	8PctLfcOVvqTlROPOweWV1gI0tsNJIhiFgeA==
X-Received: by 2002:a05:6a00:1bc6:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-82f8c99159emr44806198b3a.33.1777282613662;
        Mon, 27 Apr 2026 02:36:53 -0700 (PDT)
Received: from lgs.. ([112.224.166.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3829sm33248160b3a.31.2026.04.27.02.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:36:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	James Smart <James.Smart@Emulex.Com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: scsi_transport_fc: Use put_device() on vport setup failure
Date: Mon, 27 Apr 2026 17:36:38 +0800
Message-ID: <20260427093638.328142-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1808846FFE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241282-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

fc_vport_setup() initializes the embedded device with device_initialize().
After that point, the device is managed by the driver core reference
counting rules. The initial reference should be dropped with
put_device().

The error path currently releases dev->parent and frees the fc_vport
directly. This bypasses fc_vport_dev_release(), leaving the embedded
device lifetime outside the driver core release path.

Keep the existing unwind of the transport and fc_host bookkeeping, but
drop the device reference with put_device(). The release callback will
release the parent device reference and free the fc_vport object. This
issue was found by a static analysis tool I am developing.

Fixes: a53eb5e060c0 ("[SCSI] FC Transport support for vports based on NPIV")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/scsi_transport_fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index dce95e361daf..04b754907587 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -3982,8 +3982,7 @@ fc_vport_setup(struct Scsi_Host *shost, int channel, struct device *pdev,
 	scsi_host_put(shost);			/* for fc_host->vport list */
 	fc_host->npiv_vports_inuse--;
 	spin_unlock_irqrestore(shost->host_lock, flags);
-	put_device(dev->parent);
-	kfree(vport);
+	put_device(dev);
 
 	return error;
 }
-- 
2.43.0


