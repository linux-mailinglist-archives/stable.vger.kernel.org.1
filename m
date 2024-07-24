Return-Path: <stable+bounces-61285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A893B1FB
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BA8281FC1
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D0158DD0;
	Wed, 24 Jul 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AW5wLz9R"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0013E020
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829096; cv=none; b=IJBkGX/dyUpZuyAmQImUVwLzT09QKi/bygg3Tt3D85BRtxyNzqmdHmvtv1HG7SxyY3cSdRfB8tAgRvWnIidprg/CPSsiW+57h3RTjDzdDbzVdPVh+JrsvXjVQoMFVshogBVnfnKZqtA2RDFvwdPJx/K/EsD2DVFtLtMu/AiD9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829096; c=relaxed/simple;
	bh=SsSkhNGn7QJejrmFIGvtXvlDi/a721Ld8Pj4EOwWE9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HBxo69wgaNKsBzaoS+Dpl4h90/8ujVUXZ8h5+ormB+fqj5XPy4LufhONibTX5Wgqj5THnXSH+eINQfuOQkERXWFmqWKETqeXL47XSMlhxOhjw60h3R+2KYADRElrKaw1KM3KMsxu+Gsk0HUsFfSBSIG3d8Jvg18TUngTpOm2I1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AW5wLz9R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650ab31aabdso179682797b3.3
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721829093; x=1722433893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RrSVcz2VewJByKdMTTCyLdkt0Sk8iz5c/M167BcRneY=;
        b=AW5wLz9RIirxjwNsnGeKKn57OpR1l5gRSpRbrzXsw11ssdXqmVzLSxxTFPNV+TFfxA
         0IJjzjiowdKl5dOclPWRCVjarJP6E2fqs9O5N0IJ/j+np4F4g3zqd1sFRQTTnuDfxK32
         tqOKp8nEOKDdxcdfb9MYUMXmskYdB1rOFX0jXPnugZ+CbdvSqcNNIpR774xRD9zHnlTR
         4ihIqT2dTkZrtwOQQUAnTYRmviUOHxGSAsm1RAukB1OT8uYe+nOkw2oBsug4t71dxtSz
         UFWE9JXv5VV1ZOIH++wj+x0/+oIQrdU9Te35ifqnoirh0X284eCL03JjqXLNnoD+xdF1
         w1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829093; x=1722433893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrSVcz2VewJByKdMTTCyLdkt0Sk8iz5c/M167BcRneY=;
        b=CvKg/mPUvhKlje/xoIhxvy4nCy2C5UNvURTv7YXfRKDWgqeprnkkVH13epmRAgdDlG
         v6+KgbH0wayGlauk9ZdeCzdqjRAlePhp5PeCxlVw/SR2PfeJiJ0POC96PfUQ8KhyU0e6
         /kWL20tZCsYpzvHq/qMvUnQ7XM0EKY33SfWLU/byIPu1j3vgViDi8GIct+hQvn42NPhO
         U/jQcKf8GH9vn9NSZ2JuMPpIwMlkyT9YSFVup+Q/cqoPha3eaTwfvcAf6qeecJ/b3HiI
         lJJ+tJ8y5QSa3kPMi/Vm1VmO7f/kWY+MX8bOjsC49/KsocUMkERUreZJTmtWpjKb0KjE
         zKIw==
X-Forwarded-Encrypted: i=1; AJvYcCUAEFlDgynbvwlUAF7eeKkEpEfBhhr3Ag8DAyA6qjgFN92Ok8lk2ftYO0XrIUURWimj5vkBfka42C6RgXsp/uOWrvewGE3c
X-Gm-Message-State: AOJu0YwXsydwUIEx5+tPlq7w8LUkLke6IDMWOSc1WfTJGHhL06Frxo5Y
	7/0eK2wrLC+edUkAU5s7nP4Dwg4eU/WhiIqjewa0LIXywXSZkUcaO11WKZt4KfGLrCGKmzhTUBZ
	KOY5PPwLzCb4YDcTD70vcke38UDgPaA==
X-Google-Smtp-Source: AGHT+IHbNtAEuIYXFpzA3YyBaOuWG4DbFIf/VUQVlqhnq9b7xo1ygHVyCorff/HREiUTR/35hKqZj6/k+Rc0jmFFM1pJ
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:810:b0:673:b39a:92ce with
 SMTP id 00721157ae682-673b39aa039mr103587b3.3.1721829092669; Wed, 24 Jul 2024
 06:51:32 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:21:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724135126.1786126-1-vamshigajjela@google.com>
Subject: [PATCH] scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp
 updating logic
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: Yaniv Gardi <ygardi@codeaurora.org>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

The ufshcd_add_delay_before_dme_cmd() always introduces a delay of
MIN_DELAY_BEFORE_DME_CMDS_US between DME commands even when it's not
required. The delay is added when the UFS host controller supplies the
quirk UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS.

Fix the logic to update hba->last_dme_cmd_tstamp to ensure subsequent
DME commands have the correct delay in the range of 0 to
MIN_DELAY_BEFORE_DME_CMDS_US.

Update the timestamp at the end of the function to ensure it captures
the latest time after any necessary delay has been applied.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: cad2e03d8607 ("ufs: add support to allow non standard behaviours (quirks)")
Cc: stable@vger.kernel.org
---
 drivers/ufs/core/ufshcd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index dc757ba47522..406bda1585f6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4090,11 +4090,16 @@ static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 			min_sleep_time_us =
 				MIN_DELAY_BEFORE_DME_CMDS_US - delta;
 		else
-			return; /* no more delay required */
+			min_sleep_time_us = 0; /* no more delay required */
 	}
 
-	/* allow sleep for extra 50us if needed */
-	usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	if (min_sleep_time_us > 0) {
+		/* allow sleep for extra 50us if needed */
+		usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	}
+
+	/* update the last_dme_cmd_tstamp */
+	hba->last_dme_cmd_tstamp = ktime_get();
 }
 
 /**
-- 
2.45.2.1089.g2a221341d9-goog


