Return-Path: <stable+bounces-78262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0BA98A4E2
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 15:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E2F1C2120F
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B208190075;
	Mon, 30 Sep 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZjK9Z1Se"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456118EFE0
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702749; cv=none; b=Y3NwcHA3RITfXJce5Q++2GxClIPxgzvPBQ3v0XquEyw+CdLDYCU+BVXkqDwhqNzW3kZ9NwHNIDLOja1m0kuPNU2QNpoc/BI81sUHqzKEOKHzJWpqv1KZfH0oHSo+ZSm4k7yl469IiwHuIa7wZtW+KIqKX9rq8grL8pGESqFNgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702749; c=relaxed/simple;
	bh=Av4CXXStWsX6mmH+9S0gi4lUeah9PLWddaSpw7zdhlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rgTQCLcSeIrBt57eAljuyw9IrmyGfzgnfhqIL7+0eEG3Epq2L3/gybKNI0foau39SNfgEjwVtwXW2QquK3MLtudybtXjBWr3kuIQtl2l0Mlen7wBcENMMz6McGreFupLaq8Hb31EFuuTolia8AUZUX96ktJmkFOCzjXoAALxDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZjK9Z1Se; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so4800520a12.1
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727702746; x=1728307546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veRGAu1TLItOCjiq+jcFbEtqPkIegH7aVbL6vbBFLow=;
        b=ZjK9Z1Se8Un5SzLiGASJyUcyhMckAsD9ckmTOlNa+JWLfYKSwj4Ix6a2E5zXpapxAu
         bUITcbgtxkAQOud14llixwjZ+UQ9iH8f219dymClxyJN2HRWt6xjl5n/WvBNn0Sg5wbR
         DsJKlCp/C2zknPAjiSGToJ2Mt3TKgyu7WMgM7gW4MxC5JBuqGL4a/BjhlRZzK+Ikqdzg
         1gBvc0Hsr/XUIbvO/ylFZOJ0v9D2rGWiMaPIzaXssvMtBiw7gMbIFo89sbkrfkzOkn2t
         QnRb+nK5CBx39ckuPAtgjc2qJedUe8iB/UgGWaF/SIqtoOV/jrPowipbitF0dcyfF0gw
         0mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702746; x=1728307546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veRGAu1TLItOCjiq+jcFbEtqPkIegH7aVbL6vbBFLow=;
        b=TDimAbKG7NkD2VUcT3L7+W68dhhOCPbazvCTNWlXHMfmrQUs/knPzHV07De36bSswk
         5K9MORZGoTORVy/mTSS9MK4QtSIhZRufUNJjuhdS0laIriTkRYzS5+PsEOJxipYT0EKy
         hOEdswi7wI1OJsH9tKYVoBwwScYieUjWvtp2LmYqByUh3N8Df/K0miekrsbyptT1rDiU
         8FfsB4KTloRqfrkjTputMrVXSheqlavKnbAcKIV+rey1YpA19dGLn68eVu42LddDfMi0
         hCUa4UvsLlK3SkwgqxN1G1mCcotBKqvva1D6xxcT6TVGpcSxxNAimM7eviJP7GvOxYBS
         FTsA==
X-Forwarded-Encrypted: i=1; AJvYcCVSjWI9xD4PHGeko8DYFHMEbqqji5zmr9zPESCM7OSBUqk99yR8HlTGLROw/VXF6+OqWVsVJq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXOI9y+QIhxeNmDjk3okUzksPUtR/jznY1n0AjleVjJWkf/g5
	Rxfiqlu/1YecBWrqgUnxFH5NO8IbeX8sB1IoggSIbmRlZemq5OeClJgh11tgpd8=
X-Google-Smtp-Source: AGHT+IGfJ8pY2NAzdt7tCd27ZNRhmZSZgXuPiTc3RPYlDQRBLq/UfSZIOYf7teZEQd7GwrAW5brfmg==
X-Received: by 2002:a17:907:1c17:b0:a86:95ff:f3a0 with SMTP id a640c23a62f3a-a93c48e8ecamr1420825966b.3.1727702745507;
        Mon, 30 Sep 2024 06:25:45 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a93c27c590asm533455966b.71.2024.09.30.06.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 06:25:45 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <jejb@linux.vnet.ibm.com>,
	Lee Duncan <lduncan@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <mwilck@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: fnic: move flush_work initialization out of if block
Date: Mon, 30 Sep 2024 15:25:17 +0200
Message-ID: <20240930132517.70837-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a work
queue"), it can happen that a work item is sent to an uninitialized work
queue.  This may has the effect that the item being queued is never
actually queued, and any further actions depending on it will not proceed.

The following warning is observed while the fnic driver is loaded:

kernel: WARNING: CPU: 11 PID: 0 at ../kernel/workqueue.c:1524 __queue_work+0x373/0x410
kernel:  <IRQ>
kernel:  queue_work_on+0x3a/0x50
kernel:  fnic_wq_copy_cmpl_handler+0x54a/0x730 [fnic 62fbff0c42e7fb825c60a55cde2fb91facb2ed24]
kernel:  fnic_isr_msix_wq_copy+0x2d/0x60 [fnic 62fbff0c42e7fb825c60a55cde2fb91facb2ed24]
kernel:  __handle_irq_event_percpu+0x36/0x1a0
kernel:  handle_irq_event_percpu+0x30/0x70
kernel:  handle_irq_event+0x34/0x60
kernel:  handle_edge_irq+0x7e/0x1a0
kernel:  __common_interrupt+0x3b/0xb0
kernel:  common_interrupt+0x58/0xa0
kernel:  </IRQ>

It has been observed that this may break the rediscovery of fibre channel
devices after a temporary fabric failure.

This patch fixes it by moving the work queue initialization out of
an if block in fnic_probe().

Signed-off-by: Martin Wilck <mwilck@suse.com>

Fixes: 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a work queue")
Cc: stable@vger.kernel.org
---
 drivers/scsi/fnic/fnic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 0044717d4486..adec0df24bc4 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -830,7 +830,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		spin_lock_init(&fnic->vlans_lock);
 		INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
 		INIT_WORK(&fnic->event_work, fnic_handle_event);
-		INIT_WORK(&fnic->flush_work, fnic_flush_tx);
 		skb_queue_head_init(&fnic->fip_frame_queue);
 		INIT_LIST_HEAD(&fnic->evlist);
 		INIT_LIST_HEAD(&fnic->vlans);
@@ -948,6 +947,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&fnic->link_work, fnic_handle_link);
 	INIT_WORK(&fnic->frame_work, fnic_handle_frame);
+	INIT_WORK(&fnic->flush_work, fnic_flush_tx);
 	skb_queue_head_init(&fnic->frame_queue);
 	skb_queue_head_init(&fnic->tx_queue);
 
-- 
2.46.1


