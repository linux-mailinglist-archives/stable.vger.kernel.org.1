Return-Path: <stable+bounces-269521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uL06CJwjQWpVlQkAu9opvQ
	(envelope-from <stable+bounces-269521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 15:37:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E666D3E8E
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 15:37:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y0dB8ZEO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269521-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269521-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7A2E3004DF8
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93A3A873D;
	Sun, 28 Jun 2026 13:37:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B03A6418
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 13:37:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782653849; cv=none; b=QNs9bOUmVx0L/rebUmb6zv5R5jXoGulZb7MFInmanNnJn1zeVSqSeRZsMsNgDuG0a+ezwf9DFLWtT5ZAFyXtWV5RJSpSvVbJrtJ4todKtrEml0hoDWEAdrRJypVBUX6IekbyragpDebZz90KX1iCuPdDMHX/+MRDFtnw/5CW+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782653849; c=relaxed/simple;
	bh=APeQAyYxz2gOaufxE9Y/rggiGKFvWex60lbtGRy4358=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eg4+jlavwPCOt71kHyYNn6qGqwnYHBfl8dMPEz3pEoqO3RpjGAzJ9sOaggjPbka/lKL0ikeb9WAq8NGWW4zrotSOUj74PQ/hi9H0oGvvqxlJHN5Mdv/5IAMMBNsIenwRUhJ8tbjxSX/VkLJFjRng3JQ5nG9euHOAoo8NFZDpUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0dB8ZEO; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7ebfb63c6so15141825ad.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782653846; x=1783258646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/ERgMpgZ/aBHq6dAj6hhrHv3kdwwLXAdxeqFG4lEq0=;
        b=Y0dB8ZEOidzMJfdk1+U47Q+7NOTG6Qkf6vAYdnCSMATZ7MHyzBjRSCOuzE93vSweQS
         G9uN9V1PyJqpjjj073XZnZE7y3T2fjYz9PAk17lKc3XXsn/Oi5UjJ2HwviZfn7tWziAk
         eVcZCoW4odUhCG+9L5jY0Pk/8Ax6hkvT/BrkTHFcU7P9lDyI+HEd+i7IYRcERpHneFgU
         FSpY2D/ttLkLJQ2v5BJKa5lNqys1zsoDywxjzwaWXsXjFI3gYxh7oeEkZQ5Oo7S9CshX
         uGOGBH+wTUJa805lWdzYX2S/tjW6aQHjO04dqSi/icuyOIUPSOw2k4czQFuBmOQnANNA
         hFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782653846; x=1783258646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/ERgMpgZ/aBHq6dAj6hhrHv3kdwwLXAdxeqFG4lEq0=;
        b=W9RIdTnw6q5Z1lNkFRVr+bBtsnkPnRQMSZVFFMZ6ebeC+jqiaTMmtK9WopRGjUR6Hu
         RJr1Grm03f+n7RVeAcov56ujA1wZm+61h6aM3KIvsiJ9Q0zgX5qW+QBvxfl9mJ3ewVPz
         +PBCknVWduSHDbpsVnSNq+/4MBwnXyPGhgettEYD8uV/FHY1h8WUbRTWtsTIYh8zOrCk
         XesnX8hWeDteVnHRCLwRTW52WpzD0u6H84sY4GCdYqlT6TTKaJENE6ue2DiZMw/gh4WW
         Ub5uKycp7pc48J/Z4pT66ZsgQ0GDFTg2EvCseUSy1fgVZjNmc4IDbAexdPcgfyTB4+cU
         GGaQ==
X-Forwarded-Encrypted: i=1; AHgh+RryafBOH4FflQyEYnHw7/IlmRV2R9+9Ua4Ujhps13doVnq5aECYzmV+PXE0iIu17YjX+5JXAKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGZ5nQ3P2huWrRHWVjcQyT8cNhv7Kery9jE4rKfJYyoTf/mL/
	AjC6+RTJd5YKrWAVNZ5wARB0RVgr5lmLKNckwK01Cl3LuxgRZ3RUw7Ch
X-Gm-Gg: AfdE7cnDK+ne2HKgc/NeQmAGr0l4s1DV2hsyP2z60wolpZgt6/JuuCJjt1mCb+C732E
	M9uuBApgh4ibuu2iDo+E++MzqS6c3scCfBsD+kiA+DPYQYgNrl+fOBhUorglxSz16MvLCIcAMt0
	kUdGbc7596T9BYrBnQbQ1cub6LJ6hmT2/uXoyQmRQsF3XfXatG3FA4rpVfin1AG2tjdLeKWPOdm
	Cquf4kx/5D1JTzMEXANANzDhCPygp7PR46f2HyQEhvKNYrmG+fPyS/+r8Q5N3yxtsTzdHvRuIkh
	ie/tZZAFvPjXHytaCAESp1yOuxL/3upowqujpKFaTJWdSejJaVdABB7vKSU1/SqVr6eeyJTgzem
	/pmvEblhKqd+GgPqWdLuh0GsyWihjt0kstG17t2wDb1qd05dSlLpa+A3yG1TDytK8O+0YRpJxV7
	Dkqr1D0aaytYepRsYZTgAQnHBV/qPCnOeBM120x2eiwooO2PajG2WvgpsArc3DtYFpaS1FjOdSK
	+a5jw==
X-Received: by 2002:a17:903:2305:b0:2c9:e266:e32e with SMTP id d9443c01a7336-2c9e266e610mr19470105ad.47.1782653846132;
        Sun, 28 Jun 2026 06:37:26 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9dbd09695sm14537525ad.81.2026.06.28.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:37:25 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: validate report size before copy
Date: Sun, 28 Jun 2026 22:37:17 +0900
Message-ID: <20260628133717.941389-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269521-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:even.xu@intel.com,m:xinpeng.sun@intel.com,m:jikos@kernel.org,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sammiee5311@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sammiee5311@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sammiee5311@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99E666D3E8E

write_cmd_to_txdma() builds an output report in qsdev->report_buf, a heap
buffer allocated in quickspi_alloc_report_buf() to the device-descriptor
derived max_report_len (a few hundred bytes for a touch controller).  It
copies the caller-supplied report into that buffer:

	memcpy(write_buf->content, report_buf, report_buf_len);

The HID core caps a report at HID_MAX_BUFFER_SIZE (16384) by default, and
quickspi_hid_ll_driver does not set max_buffer_size, so the length reaches
the driver unbounded.  A hidraw SET_REPORT/SET_FEATURE ioctl carrying a
report larger than max_report_len therefore overflows report_buf with
attacker-controlled length and content.

Record the report_buf allocation size and reject reports that do not fit
before copying, matching the equivalent guard in the intel-quicki2c
sibling (quicki2c_init_write_buf()) and the hid-goodix-spi fix.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c      | 2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h      | 1 +
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 4ae2e1718b30..1695efd5961d 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -559,6 +559,8 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	if (!qsdev->report_buf)
 		return -ENOMEM;
 
+	qsdev->report_buf_size = max_report_len;
+
 	return 0;
 }
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index bf5e18f5a5f4..0ed964bfe3dd 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -157,6 +157,7 @@ struct quickspi_device {
 	u8 *report_descriptor;
 	u8 *input_buf;
 	u8 *report_buf;
+	u32 report_buf_size;
 	u32 report_len;
 
 	wait_queue_head_t reset_ack_wq;
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index cb19057f1191..db6054843e77 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -30,6 +30,9 @@ static int write_cmd_to_txdma(struct quickspi_device *qsdev,
 
 	write_buf = (struct output_report *)qsdev->report_buf;
 
+	if (HIDSPI_OUTPUT_REPORT_SIZE(report_buf_len) > qsdev->report_buf_size)
+		return -EINVAL;
+
 	write_buf->output_hdr.report_type = report_type;
 	write_buf->output_hdr.content_len = cpu_to_le16(report_buf_len);
 	write_buf->output_hdr.content_id = report_id;
-- 
2.43.0


