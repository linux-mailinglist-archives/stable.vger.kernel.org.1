Return-Path: <stable+bounces-116513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F1A373D2
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 11:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BFF188B808
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2168E18DB18;
	Sun, 16 Feb 2025 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lildSN42"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559B3D6F
	for <stable@vger.kernel.org>; Sun, 16 Feb 2025 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739702549; cv=none; b=a/cf8n3pmoAGL/5giETPgahLmCiMqJ94QoDK11dhlKOgQzxNXOLQIVem04ORDw4YXvUbld8P9NgbTHWsOWYQwEyQ/mvGqQ/+YXa3vOfT39ovgjevJJZYS5gPi8MboZE44tLD/dZjj0RoNkmII9Fh/5e2Wm1CFnImSe3zeNiJrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739702549; c=relaxed/simple;
	bh=iM7tEPV48U8WJ+hezDZwfYvVDUsqDAGnZaQFMo/SmcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVAdMuVacbC8271kn33z6ulV/wXj0L26w4rTBOMRBLPlHg35PlOedozyNgSPJCpD2Y5BoP9wEF5Qtg+PoS02aHHzl/aDq/UnIjIB/kOI6Glcm3znZkPQfFoz5QiMcuPVjfPs7p1hPIdekR2LefH20s6r5TwHvNlj2YNr/1MjcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lildSN42; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb7aecd39fso153414366b.0
        for <stable@vger.kernel.org>; Sun, 16 Feb 2025 02:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739702546; x=1740307346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LazUEOej5l43+bfR9AUy50EmWM7TfpervdeFxQxk4LA=;
        b=lildSN42E0pj8npROKstlaTjPmNebXwDHtJ9m9Ps+85I9f7aAi/GYe55HVanMAMde1
         EWVFokmF8lTj9i0hhu5WxPCLZDWSlLrDTAzqq6h+b0AaF4QuSfXdblbEWlwTQy7jfCIN
         VnUHFpuhdGuA8nxvCcFVjTTX6hi7lS4XnjPingO3MX81hIKQR7NT84fj7neU0CRycC05
         VIjaKPe6BQcY/2rK6T8BD3eOrN7zOUGiQUzOpIAu5syKD+PH00p7K1T0c9nt0Y/WWHFh
         nZX+srOVVvzcANMEWy3O4W50LrCqZrWwX3XaHK4XmhQ5eubX1SM5hig4dMQ3T3ErnWbe
         QnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739702546; x=1740307346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LazUEOej5l43+bfR9AUy50EmWM7TfpervdeFxQxk4LA=;
        b=vX2F+oHi/cDbe26LekkGYZKN9NTdQQeNkay8xHiJA1n2g43ZCWmyt9Bphce5SZ1r/P
         yDo0V0xsom5UOpeHyRcHtRoH4bqLfWbvOmaZedrrl5TsezrNVvCfN/Q3Lj7KkX91ze1H
         aN+QSMD97Q4RKnF/7fRvXUqWI/f4WuvRDIbjPPmq4asUPwCfXUKCuoCoXrP4JMXD15IJ
         9bt3bLJkeh+jqeiHnVL+QG2MVtIld9w/ivNXpwjBjbox98ePHo4YZvk9IMI4MHlr9ZbA
         gd4YzwZWPWFjYgpBbZvD2cdhMbE82AcmnbDWLKA6gt8succVZEBb8t3L486SNqsEwl7o
         1GWw==
X-Forwarded-Encrypted: i=1; AJvYcCULSz11sZRFguirKecBWzAqLR4RbPjgyioCTj0/j0+WgeNIatDIZsdLpbpI4dzdEgseNecfEVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoCHCd4Xmcjjy5yBcOdRaJ2Iu2cuqd4l7F8ycWTqhPxWq2OH7
	4Wou+HTncpx1Ia65mGg+fhLxMSiciEwXDqD/woLDbv9kDHrMOXRu
X-Gm-Gg: ASbGncuxfXfuKTStZYg050GR5Msvu1ATdmFvwNJIHqoQmJjB069gJ2ctX2fxllhGhBX
	7H3Z/1RxhbtqmqSV+mIPGOti9nWbs8HJOzpgmYot+Mv4FbIMB9KaZk6hq1A9p0hvCZqIexAcNTR
	otWe86zXgkI+L4qJ+cduo12S8eZBzof5+5G7tzZ6soMo4V1Qk+vPmwce0GKLNH9TajnwTdTOvUH
	C0NPLLgvcNkqtIYDhmgiVTyDoizaQHk4i8+4WmFJ0kUQwSlthldS4pG8k1Y7UdQAO7LAVvpfsIK
	d3Qyse5js0S/8zFQm5RH9fCHza+8ra8ClinTpTJfLUd0V8uH66VfI6/GsukkbogfEMSOtSkfdYJ
	Es7kUOxIJyLHx3sSvdHM=
X-Google-Smtp-Source: AGHT+IFGsa6CU1hUaEyWwVxvCEXG7v9unr8N3BR0cdRTJKOLWeylkLU0jSqXZL/xTVSVEDqTPm07DQ==
X-Received: by 2002:a17:906:3ca9:b0:ab2:f6e5:3f1 with SMTP id a640c23a62f3a-abb70848a57mr463921566b.8.1739702546150;
        Sun, 16 Feb 2025 02:42:26 -0800 (PST)
Received: from syrah.mazyland.net (dynamic-2a00-1028-8d1a-5dc6-7184-2e63-0011-e253.ipv6.o2.cz. [2a00:1028:8d1a:5dc6:7184:2e63:11:e253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba78ef6ed8sm422755166b.73.2025.02.16.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 02:42:25 -0800 (PST)
From: Milan Broz <gmazyland@gmail.com>
To: dm-devel@lists.linux.dev
Cc: mpatocka@redhat.com,
	snitzer@kernel.org,
	Milan Broz <gmazyland@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dm-integrity: Avoid divide by zero in table status in Inline mode
Date: Sun, 16 Feb 2025 11:42:09 +0100
Message-ID: <20250216104210.572120-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Inline mode, the journal is unused, and journal_sectors is zero.

Calculating the journal watermark requires dividing by journal_sectors,
which should be done only if the journal is configured.

Otherwise, a simple table query (dmsetup table) can cause OOPS.

This bug did not show on some systems, perhaps only due to
compiler optimization.

On my 32-bit testing machine, this reliably crashes with the following:

 : Oops: divide error: 0000 [#1] PREEMPT SMP
 : CPU: 0 UID: 0 PID: 2450 Comm: dmsetup Not tainted 6.14.0-rc2+ #959
 : EIP: dm_integrity_status+0x2f8/0xab0 [dm_integrity]
 ...

Signed-off-by: Milan Broz <gmazyland@gmail.com>
Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
Cc: stable@vger.kernel.org # 6.11+
---
 drivers/md/dm-integrity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index ee9f7cecd78e..555dc06b9422 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3790,10 +3790,6 @@ static void dm_integrity_status(struct dm_target *ti, status_type_t type,
 		break;
 
 	case STATUSTYPE_TABLE: {
-		__u64 watermark_percentage = (__u64)(ic->journal_entries - ic->free_sectors_threshold) * 100;
-
-		watermark_percentage += ic->journal_entries / 2;
-		do_div(watermark_percentage, ic->journal_entries);
 		arg_count = 3;
 		arg_count += !!ic->meta_dev;
 		arg_count += ic->sectors_per_block != 1;
@@ -3826,6 +3822,10 @@ static void dm_integrity_status(struct dm_target *ti, status_type_t type,
 		DMEMIT(" interleave_sectors:%u", 1U << ic->sb->log2_interleave_sectors);
 		DMEMIT(" buffer_sectors:%u", 1U << ic->log2_buffer_sectors);
 		if (ic->mode == 'J') {
+			__u64 watermark_percentage = (__u64)(ic->journal_entries - ic->free_sectors_threshold) * 100;
+
+			watermark_percentage += ic->journal_entries / 2;
+			do_div(watermark_percentage, ic->journal_entries);
 			DMEMIT(" journal_watermark:%u", (unsigned int)watermark_percentage);
 			DMEMIT(" commit_time:%u", ic->autocommit_msec);
 		}
-- 
2.47.2


