Return-Path: <stable+bounces-89298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF09B5C05
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 07:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5681F21BBA
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3571D433B;
	Wed, 30 Oct 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d16hlFRX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29521D27B9;
	Wed, 30 Oct 2024 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270998; cv=none; b=Kaovan4OL/X10RUwJiYhQWLRLdH5MPek7oOxviDz1Vk6vepd5ue6bsz4qhIpKMe8TRwdWB+JXI6JVBOd+2QYGaixXvGcaBXe/hYGwr0yvvsf1ZTdd/O2sd2Rq/ndF14Hwb6k9YhSzy8sLCq6+vfzOXT2TrN05F/qG4bRGSbPuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270998; c=relaxed/simple;
	bh=zJw3UJbl3CQMX8ZV+7LJ0VvBC/OyJZT7GPijwALV71Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKPq6jjuuxzHBqHxAfT6CMhfJwgSgk2feXpz6osnmxeEUMWGWhNA7d1y8eL1kBJFxEaFQBMsHEVgFGRbYYi04CtodRe4XZ/z3AGF8VgDtDxqGsqg/OJh0CZM3BzeaQVNQ752plU+2wq671z4nikao0htvGcWlEoRA/EUZkEeqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d16hlFRX; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso4780709a91.3;
        Tue, 29 Oct 2024 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270996; x=1730875796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9htrK+K47j7plwDzFY6/YbL058OrTTXAWjNvqdUBAiM=;
        b=d16hlFRXj8q6rgqv2R6ChuTMsUDjIPMtSLcisvi8Ba3miJX5hbcXkB65M9Y8TaPIeN
         AvDqeauAQjjA2hEOB5UihxnoCQTpS0ADe3GfVF6LgIBO5c8nHpKsHPsGas8LblbcoBUM
         8xSkStO0sR96PTyDIvXSCF+pZfsIwluT/l7bGNMkkty7OQsKa1Un5pTRkD+MybUzn7iA
         R0XfScTn3nBfSglAr3tlRjuUPvUJ4Kmq4V9GeIuZk4hNYpRbUhAW+vylss0EA9qe3WF+
         x75tiK7n5JkGbO52GFqePEPb03/k1sDBvy4Mg05OUVAZzPtbDceVhJM78QbkimQ17PhD
         FZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270996; x=1730875796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9htrK+K47j7plwDzFY6/YbL058OrTTXAWjNvqdUBAiM=;
        b=mqXIs0ZNV3W9X8KlS3QVbA7yUv421Dmrj9LBJok3Es/5QpmEG7d9GIo7OhqUN+qGl0
         pFNCpZxEJdnjIDLHReGam+N2VOudoupnru9lDgoNVJCglewpzJIsMKVIwlfFqJHlt7r1
         ZX1UJBeyFzTNFhEdQR0NQaD/Y1XIEsbega5OvCSxvplBt4B1mRkVuY+cItplCX3TljDe
         8oNk06sqJC2YaJRX3V6qdJi46vnakydDOCHEwWJQjVysxPBSwXjgC5PW21BDcC+V4oPh
         U5qPs1v0cyFVKAKDKYes4TK6w9HKVDsHdYcxtX6xIDskb4wJc6rJAz6RrwWz0LgLQ8Ri
         TIGA==
X-Forwarded-Encrypted: i=1; AJvYcCWL/8pwjw12qrmEBbfGWZxlWKfL7kaX8MJZwuQXv6EfKfl5UMuGfBQjwcQaAguE3NU4AAmZAUrkvd3Zsps=@vger.kernel.org, AJvYcCWwNC6m4BKkMGcazsdefrlTPfmJXzuAqmNoU9FAeLpUlm20AAqdcVplnLE319YlvhDfXC4kH0Zx@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOz9jzfIzBdPE36mh/MSMcDXtPnMglDlEEONlxJDuJ6F1MIAI
	Bt3muoIGsX22r5LYwci246RHN7iSCHdblKioofLOrItrPjhAyyHo
X-Google-Smtp-Source: AGHT+IG1g9EtCsXxXn/Kg/bVUnlmd7QEjXsIawXwB5EKSR6LpuCF6dIPqV971MOh+qh6EqqNoSYruw==
X-Received: by 2002:a17:90b:300c:b0:2e2:bd32:f60 with SMTP id 98e67ed59e1d1-2e8f11ac92fmr15554606a91.32.1730270996173;
        Tue, 29 Oct 2024 23:49:56 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92f90c6ddsm885993a91.0.2024.10.29.23.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:49:55 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] virtio: console: Fix atomicity violation in fill_readbuf()
Date: Wed, 30 Oct 2024 14:49:49 +0800
Message-Id: <20241030064949.6255-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atomicity violation issue is due to the invalidation of the function 
port_has_data()'s check caused by concurrency. Imagine a scenario where a 
port that contains data passes the validity check but is simultaneously 
assigned a value with no data. This could result in an empty port passing 
the validity check, potentially leading to a null pointer dereference 
error later in the program, which is inconsistent.

To address this issue, we added a separate validity check for the variable 
buf after its assignment. This ensures that an invalid buf does not proceed
further into the program, thereby preventing a null pointer dereference 
error.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 203baab8ba31 ("virtio: console: Introduce function to hand off data from host to readers")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2: 
The logic of the fix has been modified.
---
 drivers/char/virtio_console.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c62b208b42f1..54fee192d93c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -660,6 +660,10 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 		return 0;
 
 	buf = port->inbuf;
+
+	if (!buf)
+		return 0;
+
 	out_count = min(out_count, buf->len - buf->offset);
 
 	if (to_user) {
-- 
2.34.1


