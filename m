Return-Path: <stable+bounces-254029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH1zIpACE2od6AYAu9opvQ
	(envelope-from <stable+bounces-254029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:52:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F905C29E5
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D81D330039A9
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE491397E6A;
	Sun, 24 May 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IexDHLM6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8514AD0D
	for <stable@vger.kernel.org>; Sun, 24 May 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630730; cv=none; b=ROihfqbx6pAmlsDkuscMXHEb+KUmVNOeCMPGZ3HgUVkJEY9A+w/RJPH9UQeBq/20MNGUsNqyANa5N4/NuBiz+K0KdK10sY1txTMg78EHdsWSmFIRR9ePONniDlqyS98Dl3aoUxNTgCKE9f0dlvWuS7X82H6qvf1b7MUrGzC6KVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630730; c=relaxed/simple;
	bh=fvQwEMYX6BDOUBNVbw3xkM0WWl+t9x/Se3AcK+dqC4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thT40zJIFLS+dUW9poh3hfFR6ZOLYJ5eddbXitR4leVnAFshVKq1nDcUczM2HSGIiWusVrJ2YIpeqkKw6ihOCmJUzEp0lM3+DBzMQIUn0s/Pem7bU/9dBiwp+nzwzxyFRHdleyrlqT/Y/rlUxLUwQPE1+03Vlobhs6PTLJnyqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IexDHLM6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36936dcf19dso4283247a91.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779630728; x=1780235528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzPGquotkKW/US/d7GbfP4YoBT5ndTm9l3GA2srn+2A=;
        b=IexDHLM6uitCis3KLrz00Eap4Vj5kLtNYuc4kqbZ7JVNq+6Ptahg2Zvkb4fNOGpkzp
         ZU+M2rcBEpXyESXIprGHCNxVq668JJgDpL1/aJ7ce/v0bRc1VowsU5nAuIoxuRDRx8wV
         GTKNQrF+NTWyl0i+iHd/1PLjFw9M24Ru/byYtEvcP9gS5cHiImSHL1nUx4aSnzK07Aq/
         9Yz5egu6hmLQ81FnZphmL9l/iH/+wX3AMAfhzfn7R9X8vqF4aTI9RxXo66RDz9wFE24i
         UFqJmxWkNopxjMMCL21DbIqJtVwYlM5oW+rrM0u6whF0T5HB9QA5ir9Y1kW8dTxQUFUp
         3qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779630728; x=1780235528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzPGquotkKW/US/d7GbfP4YoBT5ndTm9l3GA2srn+2A=;
        b=WrI3ivyxldBrfPDUXdWpc5vYsBr+I6+8Kj6v/W/mHXnJrgaTW6CvfSIgVx7pPZ6MKl
         /wfIn3mnc0ASuzQD0DPYhgKT8DGtbSBYKgiuak+EAi2NOVnfOsJGdPnbFvN3GsV0c2zk
         snIHoj43VfHZG/qiSPraWt6FFykDDki8hcGob6vQGvYZ0M2cw3SwIXU32ElLXotOUV7C
         FPhmXqED2wCANWbecACPWguPVergfJDkL3tRqZ80XzOADfnv+IA7kKo82RaOz+Iu6gJX
         nPQeSeA2naE28wUCJxtQRBsR4enMVIQI1s0lhD3cAxuDaVBy8ahOck6vOqECCH++Mimg
         FJXg==
X-Forwarded-Encrypted: i=1; AFNElJ/3WiaoAL22H+u4lYKCpDn/vKVlOojsULMlqFqftp84K4PBL/7f44Sq8KDJi88ToexJbMzxsjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDY/W0ctCNAvbv2wpknsYbEJZLWh7cgve1mmaATkN/gHB96uOr
	NvK42oEjXrmNcVmpZDLVGYNQrgIJJbj8/C07UHKa49KLHf0RqBVDC+yu
X-Gm-Gg: Acq92OEZH7g+CsPPPQl//b2VJ4W/oooEpQ9XVvnkY40HhNVEgGS8ZNh5C3UQED8WyW8
	aeR1k2wR8JDvI7KMRnGXhBRfcBkkKeN2qHMrnZ5bdA+KjWwYOusTE03SIkI+h1OYiY8vosd4rGl
	YUvbwA9YDdqDLcacf1KYCc29nEiiDFOvko6XcKqWbdKj3UUr3UMIG+2Prp95+3o8x/jVGa4IrGw
	kWYXqo/IY3TCdJTrLYVbuKmKcu0Zww0AFzMtl46sHqKA+i7ZXKH1WsdnOtJwSd2ictoAC7iyFyL
	c40LTN9bp6U4rOTgrRgy4CFF9/lt0nxBJcRktfp0TmPaSgcVTVNC5ipqXF9BKJjaBwpzqc4LhLs
	zum2aWekcA6rzv5YVZY1XMRDZfB57IhvK2L6GBaXw8UV1X/cwz1mcx+FGxD21gaAoPSgdzIgu5M
	hxLURSlhCr5ji1Ya4kSex0MX8oj1KAFq/rLc50r4oCIuyt89NvAp7qVpjp6A/rPF0lY7kKxw==
X-Received: by 2002:a17:90a:d885:b0:369:e4d4:79c6 with SMTP id 98e67ed59e1d1-36a6782a785mr9844596a91.20.1779630727617;
        Sun, 24 May 2026 06:52:07 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ca35sm7073833a91.9.2026.05.24.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:52:07 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Jason Gerecke <jason.gerecke@wacom.com>,
	Ping Cheng <ping.cheng@wacom.com>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/1] HID: wacom: fix slab-out-of-bounds write in kfifo_copy_in
Date: Sun, 24 May 2026 22:52:02 +0900
Message-ID: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254029-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 15F905C29E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I found the following slab-out-of-bounds write in the wacom HID driver
while fuzzing with syzkaller on v7.1.0-rc4-next-20260522:

  BUG: KASAN: slab-out-of-bounds in kfifo_copy_in+0xf3/0x130 lib/kfifo.c:106
  Write of size 3842 at addr ffff888009179000 by task syz.3.9362/61135

  CPU: 1 UID: 0 PID: 61135 Comm: syz.3.9362 Not tainted 7.1.0-rc4-next-20260522-dirty #3 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0x97/0xe0 lib/dump_stack.c:120
   print_address_description mm/kasan/report.c:378 [inline]
   print_report+0x157/0x4c9 mm/kasan/report.c:482
   kasan_report+0xce/0x100 mm/kasan/report.c:595
   check_region_inline mm/kasan/generic.c:186 [inline]
   kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
   __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
   kfifo_copy_in+0xf3/0x130 lib/kfifo.c:106
   __kfifo_in_r lib/kfifo.c:442 [inline]
   __kfifo_in_r+0x1b2/0x230 lib/kfifo.c:434
   wacom_wac_queue_insert drivers/hid/wacom_sys.c:65 [inline]
   wacom_wac_pen_serial_enforce drivers/hid/wacom_sys.c:165 [inline]
   wacom_raw_event+0x900/0xa90 drivers/hid/wacom_sys.c:179
   __hid_input_report.constprop.0+0x39a/0x4d0 drivers/hid/hid-core.c:2161
   uhid_dev_input2 drivers/hid/uhid.c:618 [inline]
   uhid_char_write+0xa8a/0xfa0 drivers/hid/uhid.c:776
   vfs_write+0x2c0/0xe40 fs/read_write.c:686
   ksys_write+0x1f8/0x250 fs/read_write.c:740
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xee/0x590 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 4174:
   kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
   kasan_save_track+0x14/0x30 mm/kasan/common.c:78
   poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
   __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:415
   kasan_kmalloc include/linux/kasan.h:263 [inline]
   __do_kmalloc_node mm/slub.c:5309 [inline]
   __kmalloc_node_noprof+0x19a/0x4e0 mm/slub.c:5315
   _kmalloc_array_node_noprof include/linux/slab.h:1269 [inline]
   __kfifo_alloc_node+0x11e/0x260 lib/kfifo.c:44
   __kfifo_alloc include/linux/kfifo.h:932 [inline]
   wacom_devm_kfifo_alloc drivers/hid/wacom_sys.c:1315 [inline]
   wacom_parse_and_register+0x2b4/0x5640 drivers/hid/wacom_sys.c:2381
   wacom_probe+0x8d5/0xc40 drivers/hid/wacom_sys.c:2880

  The buggy address belongs to the object at ffff888009179000
   which belongs to the cache kmalloc-256 of size 256
  The buggy address is located 0 bytes inside of
   allocated 256-byte region [ffff888009179000, ffff888009179100)

  Memory state around the buggy address:
   ffff888009179000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff888009179080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff888009179100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                     ^
   ffff888009179180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff888009179200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

This is a regression from commit 5e013ad20689 ("HID: wacom: Remove
static WACOM_PKGLEN_MAX limit"), first present in v6.15-rc1. Before
that commit, wacom_raw_event() rejected reports exceeding
WACOM_PKGLEN_MAX (361 bytes) and the kfifo was sized at 512 bytes
(361 rounded up). After the commit, the size cap was removed and the
kfifo is dynamically sized as min(PAGE_SIZE, 10 * pktlen), which can
be as small as 256 bytes.

wacom_wac_queue_insert() passes the report size directly to kfifo_in()
without validating that it fits. When a UHID_INPUT2 event delivers a
report up to 4096 bytes (UHID_DATA_MAX), kfifo_copy_in() writes up to
3840 bytes past the end of the kmalloc-256 slab object.

The fix adds a bounds check in wacom_wac_queue_insert() to reject
reports that exceed the kfifo capacity.

Thanks,
Jinmo

Jinmo Yang (1):
  HID: wacom: validate report size before kfifo insert

 drivers/hid/wacom_sys.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.53.0


