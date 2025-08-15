Return-Path: <stable+bounces-169699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C9DB277CD
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 06:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEE41C249E4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 04:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E28212B31;
	Fri, 15 Aug 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgM7E4fX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB41C6FFA
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755232582; cv=none; b=Th9+SkDkoXs+bTxkou2Jlv0OcsN1/NOAnVMkBYHIZ9GKYXOt4wwbzQJMtyWamYVV2g4eq4O5t02mFOJlHG+4vkDCS1ze8miZtaZ9mYKlrabj/DWIwmwcYLlWhUhdcs9/vzoswL6Fe9SSycIztLNulnVsUFd52Nk/4ceoK/5O8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755232582; c=relaxed/simple;
	bh=tTcjmNoAKUIOWvUxGA4inczldKCH30dCx3uQYTFgBms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeyJFHwmEacFATw6IDkh1T21nYJhLv+aGifeEUQ5NN75NNOumG0oKWWlLYAkDErkoVU0MSScRw+1dLNai+Mel/YuEtGS9v4IfWTVYRipCeR8tYoI1NtfN10WXezevxGMHpWdC2cTLlPV+eiNvIU/SrLaoeWs7xNy1NaFvTSiKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgM7E4fX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso1602746b3a.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755232580; x=1755837380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSZ1ZLO4rs+2qnXJGmwQggHJJKhO3xQDq09pj4KIW+M=;
        b=BgM7E4fXCUTKJH2Ej15sBY8D04WeM2JPS6qYduEGb++heeW78v3NrEnBB8v9dWqOmA
         5EdIRVT2G0t3N6md26TwH8JMaX5B6GmRiir/psCSRYM1Q4iE5+PqWY6lbqT6nIeblw6b
         O4S3C2Es0wd2Zex97lFtr6BBE3QtMBewsuGCFEYVqHmbGwEk7Cg3QFgZwzM5XzxbQGwL
         hry1XIcJgwAPj1uUyYgNajkEOSms4Jkp5ved49o3x563QPT2KYP6imUI8Q+j28YBkdYx
         EavIICYj1XrC0reToUCgJLp3qH4ZMkRrF9XFZyjpdjhK2k7ayx5njdeBAdRvQv+KHpNE
         fvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755232580; x=1755837380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSZ1ZLO4rs+2qnXJGmwQggHJJKhO3xQDq09pj4KIW+M=;
        b=APvrR15vA/Eh0pbe0Lakpko+xGD3XCaCAtqj3wh91gNqmYrIkHQ49PYeMv0QlxaIUs
         5DQitMGZc/2QLKXiQVBLcLRgT8VDNo7e8LiNi9bDlBJI3vm7ER5LPOlSj418Zgo2wgUC
         7irIsqKY6d6Mdm/iT85qDkMqPbQu6aLMiPu3uFj4cezC33edpet8dSS5H/Xyf4uQ1z4E
         pYJK/Dcm9uQ9Q4UHXBbfEn7D3GVNn60ylsBvXFWcLoqRpO6kcqy6uCwL+4GNERhhvw6x
         gS7vJa4Py/GpYBpagknBKYU2u1jB2uMHNxEHA+tVD88JOpv1Q1XQjt8zB3tZg2VlqQwx
         xwig==
X-Forwarded-Encrypted: i=1; AJvYcCVxr0SZmhI3WCAR6RAvzZEWjE+YOHqrruZeoqQ24DKVn8kg0k/7TTKb8aeL1Zokv+aXW2uAw3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOFZLwTPDyglhxAZ5e7+RJcOMOYpx5i5bciAi3xRLkHzkKKL3
	wVyxjykuU3FPcs9kEcXAI2IkTe+7r2FlmxdGMWTANbu12m6Hbat0cUUV8/4hBHD7
X-Gm-Gg: ASbGncuDayuGzPQ9ALrts8Uq6e3ERP1VBt9tbuafqSRynErciRUDZEstV/XLdxmCLIB
	IoCIJppaU3BLFueQXfgMvq88Fh9+92MhiD7GmlELAPB+RYwf10wltdv1h3yajwi1t60JENRTDdS
	CZVK4xFtoitrOt/OkPBjp27eppfx7Y+ZSSW8xr4v25ufdA+zD7/3xEJTFWhy9NNcbj153tiODHu
	cH5CiTg8xIUFaRYoSf0tFGe8Li+8rVFTDUTLc9CEYZe5pon1E3alWLcNrobrTT1HBiIABqDSQ04
	1Z7e83I2HIE8FzvHYAbAIebJnJh2c1iGx6XiZ7vmRWZXuM5ghzzGfNqf0A9sL+pdWUuhYNnhbE1
	GWA0syKAh3Ed0WU7IC+mj+zJa5bS6ljzq+mmpNO0=
X-Google-Smtp-Source: AGHT+IGyx2S+ogloaFAuPG0qmwpc2+SP6YPRaCRThFyI2f5/KDNkLyemgcYReND6MMDsRkpP+4TuaQ==
X-Received: by 2002:a05:6a21:33a2:b0:240:198:7790 with SMTP id adf61e73a8af0-240d2da30d9mr1445979637.10.1755232580282;
        Thu, 14 Aug 2025 21:36:20 -0700 (PDT)
Received: from malepu-dileep.. ([2405:201:c00c:2854:8ff6:e896:7d63:c076])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452665acsm264275b3a.3.2025.08.14.21.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 21:36:19 -0700 (PDT)
From: malepudileep.111@gmail.com
To: malepudileep7@gmail.com
Cc: Qasim Ijaz <qasdev00@gmail.com>,
	stable@vger.kernel.org,
	Orlando Chamberlain <orlandoch.dev@gmail.com>,
	Aditya Garg <gargaditya08@live.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/5] HID: apple: validate feature-report field count to prevent NULL pointer dereference
Date: Fri, 15 Aug 2025 10:06:12 +0530
Message-ID: <20250815043613.44963-1-malepudileep.111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qasim Ijaz <qasdev00@gmail.com>

commit 1bb3363da862e0464ec050eea2fb5472a36ad86b upstream.

A malicious HID device with quirk APPLE_MAGIC_BACKLIGHT can trigger a NULL
pointer dereference whilst the power feature-report is toggled and sent to
the device in apple_magic_backlight_report_set(). The power feature-report
is expected to have two data fields, but if the descriptor declares one
field then accessing field[1] and dereferencing it in
apple_magic_backlight_report_set() becomes invalid
since field[1] will be NULL.

An example of a minimal descriptor which can cause the crash is something
like the following where the report with ID 3 (power report) only
references a single 1-byte field. When hid core parses the descriptor it
will encounter the final feature tag, allocate a hid_report (all members
of field[] will be zeroed out), create field structure and populate it,
increasing the maxfield to 1. The subsequent field[1] access and
dereference causes the crash.

  Usage Page (Vendor Defined 0xFF00)
  Usage (0x0F)
  Collection (Application)
    Report ID (1)
    Usage (0x01)
    Logical Minimum (0)
    Logical Maximum (255)
    Report Size (8)
    Report Count (1)
    Feature (Data,Var,Abs)

    Usage (0x02)
    Logical Maximum (32767)
    Report Size (16)
    Report Count (1)
    Feature (Data,Var,Abs)

    Report ID (3)
    Usage (0x03)
    Logical Minimum (0)
    Logical Maximum (1)
    Report Size (8)
    Report Count (1)
    Feature (Data,Var,Abs)
  End Collection

Here we see the KASAN splat when the kernel dereferences the
NULL pointer and crashes:

  [   15.164723] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN NOPTI
  [   15.165691] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
  [   15.165691] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.15.0 #31 PREEMPT(voluntary)
  [   15.165691] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  [   15.165691] RIP: 0010:apple_magic_backlight_report_set+0xbf/0x210
  [   15.165691] Call Trace:
  [   15.165691]  <TASK>
  [   15.165691]  apple_probe+0x571/0xa20
  [   15.165691]  hid_device_probe+0x2e2/0x6f0
  [   15.165691]  really_probe+0x1ca/0x5c0
  [   15.165691]  __driver_probe_device+0x24f/0x310
  [   15.165691]  driver_probe_device+0x4a/0xd0
  [   15.165691]  __device_attach_driver+0x169/0x220
  [   15.165691]  bus_for_each_drv+0x118/0x1b0
  [   15.165691]  __device_attach+0x1d5/0x380
  [   15.165691]  device_initial_probe+0x12/0x20
  [   15.165691]  bus_probe_device+0x13d/0x180
  [   15.165691]  device_add+0xd87/0x1510
  [...]

To fix this issue we should validate the number of fields that the
backlight and power reports have and if they do not have the required
number of fields then bail.

Fixes: 394ba612f941 ("HID: apple: Add support for magic keyboard backlight on T2 Macs")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Reviewed-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
Tested-by: Aditya Garg <gargaditya08@live.com>
Link: https://patch.msgid.link/20250713233008.15131-1-qasdev00@gmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index d900dd05c335..c00ce5bfec4a 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -890,7 +890,8 @@ static int apple_magic_backlight_init(struct hid_device *hdev)
 	backlight->brightness = report_enum->report_id_hash[APPLE_MAGIC_REPORT_ID_BRIGHTNESS];
 	backlight->power = report_enum->report_id_hash[APPLE_MAGIC_REPORT_ID_POWER];
 
-	if (!backlight->brightness || !backlight->power)
+	if (!backlight->brightness || backlight->brightness->maxfield < 2 ||
+	    !backlight->power || backlight->power->maxfield < 2)
 		return -ENODEV;
 
 	backlight->cdev.name = ":white:" LED_FUNCTION_KBD_BACKLIGHT;
-- 
2.43.0


