Return-Path: <stable+bounces-110890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F77DA1DC12
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 19:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E160165E32
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C018A6C5;
	Mon, 27 Jan 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D8J8JaQ9"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080618BC2F
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002642; cv=none; b=Qo227ykC6CVFm84NkLN8Wj382l/N9z+GEXsMBzXQUXX1uJyXh+0Shfv6lVh1itCXxZQWiCJa/yCMpZfCEju0p3/QXP+6aGxzwYso4ZmK/xP38GL60RCJeEMBW4Dj6kXJm5s7SMrbkndCroK668aspA3qCX7MPjLFRQVTtGYmsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002642; c=relaxed/simple;
	bh=FDMoQ4XRViIJoQ3qqT+EdVHYb40Y1f9JqwTTTkHttn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiLcqSIpAQtWjFRuP9SOu2iAtYSwqpEkZF/WXTiocEop9PjaD99GGranYa3pMHikkOhPaUIkkdgluyo8UC9pGffQnE1i+DZBi5j4TGzuWIMfpWtkU8QrNpice8rcBBYwzLzDEM0qmqKVvdsckacs/C9QL6I7e7p8TRzGjzVvnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D8J8JaQ9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB8192037160;
	Mon, 27 Jan 2025 10:30:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB8192037160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738002640;
	bh=unRnvKBOuGtXSe7YT2LLqyANjo/95lFIcwDxWF2H5es=;
	h=From:To:Cc:Subject:Date:From;
	b=D8J8JaQ9igXoR1v4RFE3a0/2qeVROu5guw/dARxDCPDUWdvTsUpP/ETJnMD3CaP0q
	 vfzuZ4vM7yIBOT7ZMIFtaSLduN2gSorko0CDBY7q47CfsqqNB/1u9owtjidmF+/91m
	 Qg9RkMjVlEqyLxOb2vd7jh/YoD+WFmZDbgqeR4a0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1.y] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Mon, 27 Jan 2025 18:30:30 +0000
Message-ID: <20250127183030.68130-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream

If there's a persistent error in the hypervisor, the SCSI warning for
failed I/O can flood the kernel log and max out CPU utilization,
preventing troubleshooting from the VM side. Ratelimit the warning so
it doesn't DoS the VM.

Closes: https://github.com/microsoft/WSL/issues/9173
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 0685cbe7f0eb..d47adab00f04 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -171,6 +171,12 @@ do {								\
 		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#define storvsc_log_ratelimited(dev, level, fmt, ...)				\
+do {										\
+	if (do_logging(level))							\
+		dev_warn_ratelimited(&(dev)->device, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 struct vmscsi_request {
 	u16 length;
 	u8 srb_status;
@@ -1168,7 +1174,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
-		storvsc_log(device, loglevel,
+		storvsc_log_ratelimited(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
-- 
2.43.0


