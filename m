Return-Path: <stable+bounces-236142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKWFC7EN3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:37:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34E3EE0D5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9F1306B083
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5813C457C;
	Mon, 13 Apr 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdph6dUd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313291A680E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094292; cv=none; b=gUqtwLSFZhZBIu0lguaDgq5EY/xHy+D0Rm7659O8IJOSp+LqSKZcaRVxQRzo7CcqqA0MfYNUiHCNi+mhYrN6JNvPIkGz4mySUJOvvHLCO105YuNFo7iFx0V0cgnSoVFEx9tuUT8Py8GULnRA9sRSWlvtVPy4cMXBrk4Hy4Kfyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094292; c=relaxed/simple;
	bh=2Gq73zrEvKFb2Ww2j/DZ6lomDXLUZXge8zXGm46n/mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLFuxi2YNvlb9VFnI+8Knt7pY2EQYKgM3/7eOjSN7oiKeMGcwmhnInk9a7TFGpNaxuUbgbJ4zueD2cCCMtc3Sr1g6pkoZIvcatWleVBGh7GXnXTC3hl1akwfI/i0qpUrMCHBtlRothp6jYbjUHiN8JMHosRsrTwSDhJ/Eun/ho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdph6dUd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2853655a91.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776094290; x=1776699090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQTuLDD9uHjmSb0q/D/D00Qi76jFLaRH/PnSP6cbt5M=;
        b=gdph6dUdEAL1p4rNZ7YDctR/A715NWuISjnAOz1P8njlFYoITOieCP7pHFxt/7q40y
         9FM7n2N35VJ7eQQoSMRdopag6+Di16Oc4wQWSofmMgz5vJFI4GXa7PXhvpn8zVY0poWo
         3oMtiFxHnJ4LTOLwFtnBibTvFig8138t4iQ4MTrjkjvFIADT6/ybFQH722gwHjIuOGeB
         /6dhkuXyV+pOvUVNzFBWVP17jdve0svjoSrD2eppry8T9+BXHimS+dQRA/JwnChNw5NZ
         wE7Q55h5naISVu9Hhp9O0TwcLn2P7bA1uLp6jJ1em9oSy3Kuuaq4uxsQmMgjQjX/38dD
         7vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094290; x=1776699090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQTuLDD9uHjmSb0q/D/D00Qi76jFLaRH/PnSP6cbt5M=;
        b=X//AlIheiBNOAJ1o2LnWtfql4dYYR7bfGN2VQ5A4W/NPajfMpSB3SfNe1KItMvvg2e
         fXom0ssf/PyqC/x1jWrY7I7f7jgYziP8pKO/Ntc4+j7CKTiuN6UO93SfPjI6KZmyhthq
         yCDQc+oykhfL8runfoc11nT5F+irRA3lE90cf/Vgbb/MfBWUqI3Zxuou3/MMpX97zGZw
         OpZLbmLu1bSRXK77EXjAY0Jj4YUazMW5WseFdjSOZA5pWwFz+Arh5/AJaX9a8wqPctZm
         oOL4M1Y9AIyZPy+35lvX1Tp/bdt4ZAhjjgOouD4K24T4SYVxOunqBO4nZHeHKJqtTusy
         2jqg==
X-Forwarded-Encrypted: i=1; AFNElJ+o2umjD54IP3WsdayX8R35TCDv6CCkKajaO47fW7w41Mz9Tfmm1W11LsQaNvXQWSkCOloAixA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpHMhIWYN1SgUOWWaKewTBnm+eIUNy8TbKPofheG3zqqU1zOtR
	WksCZjouMF5uqngTAA/jjlovOquwGZXeAf2jUwVCYBHXrbCAngMtTxex
X-Gm-Gg: AeBDievI9OHRCU3MNUHYIfV9suDqfmym7dBPd97I6ivIUWPdO4bsxCB7tukSAfv3yES
	1FE09qPCRyN7nNFrn1MJAdJnsrit0PLyOyE7kAn12cw8A4ruHQghvUFk4xfcGQRRmzfI2m4OsHx
	4ct2bSogmIgrah02u1tagFEZMdYhTT6nQJIsYzW5stLMT6y+K6pzWkNP2i9MAqsOoNGa7FsBOKD
	L/HvpyZtdVnflU5GGfgjCqjgg0vCEHOnIgDTK9rweCLRUeHJiXJuxkiDucLZTHJNnu755kIfCOw
	U9xjYEuZdbK98ADURY2hJqfbXFFsKH8++3HCsGPCwlWmCL+EHsM7rHJLMDhMqmBZ5zWGRHaNIY3
	fDfQExbkkNC/GMmP7iZqiAVH0JwiirPV3RGj8xoLD6/h/JZuqUkTNdZLqU7jOrANTlL6XaKHt2n
	vqo8qSP0R+FbpiGDca6LD4Ed6MfNEZep4u
X-Received: by 2002:a17:90b:33ca:b0:35f:b4c7:b626 with SMTP id 98e67ed59e1d1-35fb4c7bb12mr4856393a91.18.1776094289095;
        Mon, 13 Apr 2026 08:31:29 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:edd0:8593:d07a:ab64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm12981328a91.3.2026.04.13.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:31:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] floppy: fix reference leak on platform_device_register() failure
Date: Mon, 13 Apr 2026 23:31:14 +0800
Message-ID: <20260413153114.3040093-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-236142-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A34E3EE0D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in do_floppy_init(), the embedded
struct device in floppy_device[drive] has already been initialized by
device_initialize(), but the failure path jumps to out_remove_drives
without dropping the device reference for the current drive.

Previously registered floppy devices are cleaned up in out_remove_drives,
but the device for the drive that fails registration is not, leading to
a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling put_device() for the
current floppy device before jumping to the common cleanup path.

Fixes: 94fd0db7bfb4a ("[PATCH] Floppy: Add cmos attribute to floppy driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/block/floppy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c28786e0fe1c..d9afe495d5c2 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4724,8 +4724,10 @@ static int __init do_floppy_init(void)
 		floppy_device[drive].dev.groups = floppy_dev_groups;
 
 		err = platform_device_register(&floppy_device[drive]);
-		if (err)
+		if (err) {
+			put_device(&floppy_device[drive].dev);
 			goto out_remove_drives;
+		}
 
 		registered[drive] = true;
 
-- 
2.43.0


