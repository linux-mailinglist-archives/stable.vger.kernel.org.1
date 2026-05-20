Return-Path: <stable+bounces-251719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPd5FocADmp+5QUAu9opvQ
	(envelope-from <stable+bounces-251719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0C459708C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 305803125718
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B679376A0C;
	Wed, 20 May 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="HzLV9YI3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189B3ED136
	for <stable@vger.kernel.org>; Wed, 20 May 2026 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298714; cv=none; b=Cbow3Lry/qAGwCkInTQE5PkaJRu/ZKchd9sqMxJsYAj66sefnTJFlcih/CW7XsA05MyK0ET7fKeqg5SWu1UXhG4/xdAiRkafeS4vN4Y7OtQPEdQSv2pVp6KxvqeGKqVRdR3U/ADENEZT6RxRqHy0Xzv61pay5ykanMPGwdtgVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298714; c=relaxed/simple;
	bh=Vg4Zslqe7SjoCnFKmHm7qyuWAc7it1YKp5e/dkZrgNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JeJA3OI8FmiHNFGsk+4fNEHujc7eCYTqR/fF8IO3p5UqdLxvmVZWAtfNpXNPGojKSkIZbyokSBfabSeQdeYXmIHy+hEA0PZHr6rU60K6Uevj9n2lg/LN7X+CbEuL3rvNvE7SftQd/JcoDLmZ6FEOvt4sQibotu7FzD2AN6d2pds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=HzLV9YI3; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1332772f6b3so6628427c88.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779298712; x=1779903512; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2bO/S2M4ZO9tGObEW+TLEYBhi+U5tc3VfFtB+GMS2s=;
        b=HzLV9YI3ldsWt0LUxnPlBszZqRn9FB3PoNsBu1UDb+ehZ3shybL8vKZEwyEwrRXaRo
         2NdtE5ogyQiRRdc0p30HiJaDdo/O36+yrnbpa07GKmfqZkUtneOXZsMvi9e2cWRg2sMZ
         fehLeui0pBv2YCUjerp0lMzr+35PEwvM28MmtpNWGYThXV6kKIo1/MXIJHNIpeXHLsMA
         TvnqTxzTnbzgKrgx63gacXWqQlxcy4/PJL5tpNzwxf45RTnO/clTBcXngq59kUETS0r7
         tQPYGieN43wS6CsPYwDAIx7zFdmN1igoUw5GAxBQFweqkQ9OIImqam7g5U1/+M5qK8pp
         qXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298712; x=1779903512;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2bO/S2M4ZO9tGObEW+TLEYBhi+U5tc3VfFtB+GMS2s=;
        b=nhrnWD2vu8St8WmK89oADwxwSWlLkX3JalxJCobiuuLCQEv0E5RiCKUyiwBWSnUnxG
         3xXjqVxGrsUtpsTeXj5tkkILHWmqraBu9qLHyLzfi59/nO+B0CFV83/ZJ8ISKoLNBW+5
         WdDY8xkSK74PZ/Bv4Hk7c/YoTbR0WHl3NLY2XPqHH6hgx8OnAxX28EbMcrLvJyMFdRXK
         C44Vdx17ONxFk/Xu7XKNvgNwmpNnnIcRLYTxEFN64p8lTuxU3Uu3UNLhZG+OZ1inCKxo
         lyyTYS9GvCAu4nROM4q3I9zC4LxTCl6CaEDdnnsof55lxtFgGH0ukXGWJCjtKUrBHVMW
         MeMg==
X-Forwarded-Encrypted: i=1; AFNElJ//e2cMZD1Mh8a/zoU6H499i9tqhB826t+JTVgEIdR3FHkPVc9QXYa9JbwNfL3xw/3beumEAQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwpP6Xo3dNrf/SNhE4qjIo65HcyGcQt0+6AFgfosxXjVO0VdA
	7IO35eBoarTCOx/t7ZvNzDsEIX/wwKQWYuiLfvLdx8J40MSF2VlKia2MoF7ggvLfHtg=
X-Gm-Gg: Acq92OE+73aWKpSyiGsTzzov14gx4oz5MsvnMK6sjBgd3f8XMGKLB6stq/kUkKfQlYn
	qXW8BbwJn4bQH+oUCT8HnqFRQCCXM8hVAmRHeC0BpV112cBWTdPeCKkSpdyAlJABRF6c2VJkHNf
	DU8/c9/KqB4fdlpiObOUpQbi2TD2Jvo7OblsZxRVSwcn1KpTe/r1MLkm3VJ6/yfi/rueT7GxE1s
	PNEVdtkYfzVHmIjSlVs5iZ9rNIWQIEclNC1sj1fV3htPbm5PTjCEU5lzq1UYtAwfqwJY4/eqvm0
	p35eXhVfKoAIFg0OoI0TDeF29L3cNJTxc+6y+XKJyF7eZGIYeI9r3HS41RxuwlmmiW13qbOjOp3
	Yex+G68Jv7c/GnmHjJz9diLmTpaMK1buAlMEwMptI55T58vRExGCr0ykFs7Io2L5S9ZmS2qDsUz
	WrNu6SpgBlQTXz38nGUQBZMDgOnTdSmRBQbd8s
X-Received: by 2002:a05:7022:62aa:b0:12d:ca31:f1b6 with SMTP id a92af1059eb24-1350441d726mr10921226c88.18.1779298711544;
        Wed, 20 May 2026 10:38:31 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm27316733c88.5.2026.05.20.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:38:31 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 20 May 2026 10:38:28 -0700
Subject: [PATCH] hwmon: (pmbus/adm1266) serialize firmware_revision debugfs
 read with pmbus_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-adm1266-fwrev-fix-v1-1-8a78c94a53ef@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAJPxDWoC/yWMQQqDMBBFryKz7kASMFSvIi4SM7FTqErSVkFyd
 0ddvs9/b4dMiSlDW+2Q6M+Z50lAPyoYXm4aCTkIg1HGqtoodOGjjbUYV7lj5A2d0jo2nurm6UC
 8JZHMV7Prb84//6bhe4aglAOPDrV4dQAAAA==
X-Change-ID: 20260520-adm1266-fwrev-fix-a011f9be598a
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779298710; l=2357;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=Vg4Zslqe7SjoCnFKmHm7qyuWAc7it1YKp5e/dkZrgNU=;
 b=1gbpnr1MpEB8jgGcRDRh/aaUKjUOrDgdQK3CjzNZG7iBt37KbIQmRmiCWtE5wUicRAW3lUa7S
 J/YLkLpPqQCCO652DccH0z22QE5TPy02ob8fVUEZrxyvaww3HfKsmbg
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251719-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B0C459708C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

adm1266_firmware_revision_read() backs the firmware_revision debugfs
entry and issues an i2c_smbus_read_block_data(client,
ADM1266_IC_DEVICE_REV, buf) without taking pmbus_lock.  pmbus_core
holds pmbus_lock around its own multi-transaction sequences
(notably the "set PAGE, then read paged register" pattern used by
hwmon attributes), so an unlocked debugfs reader can land between
a PAGE write and the subsequent paged read in another thread.
IC_DEVICE_REV itself is not paged, so it cannot corrupt PAGE in
flight, but the same defensive serialisation applied to the other
adm1266 direct-device accessors applies here: any direct device
access from outside pmbus_core should be ordered with respect to
pmbus_core's own.

Take pmbus_lock at the top of adm1266_firmware_revision_read()
via the scope-based guard(), matching the pattern just applied to
adm1266_state_read() and the GPIO/NVMEM accessors.

Fixes: 7c99762af5c1 ("hwmon: (pmbus/adm1266) add firmware_revision debugfs entry")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Assisted-by: Claude-Code:claude-opus-4-7
---
The previous "GPIO, NVMEM, and debugfs accessor fixes" series [1]
locked all the adm1266 direct-device accessors except this one,
which slipped through because firmware_revision was already in
hwmon-next when the fixes were written.  Same defensive-locking
reason as adm1266_state_read() got there; same Fixes: shape
(stable backport candidate against the original firmware_revision
patch).

[1] https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai
---
 drivers/hwmon/pmbus/adm1266.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index aadca716fe7f..7f4dbc98d92a 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -359,6 +359,7 @@ static int adm1266_firmware_revision_read(struct seq_file *s, void *pdata)
 	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_block_data(client, ADM1266_IC_DEVICE_REV, buf);
 	if (ret < 0)
 		return ret;

---
base-commit: 7e63dac55e2de42a7947613c01e3d3c0fb9c15fc
change-id: 20260520-adm1266-fwrev-fix-a011f9be598a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


