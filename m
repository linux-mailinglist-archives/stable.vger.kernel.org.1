Return-Path: <stable+bounces-253873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCyiDS4HEWqeggYAu9opvQ
	(envelope-from <stable+bounces-253873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:47:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893425BC65C
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2B730075FE
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDF2264A8;
	Sat, 23 May 2026 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSnKDcOI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7123741
	for <stable@vger.kernel.org>; Sat, 23 May 2026 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500797; cv=none; b=lQcdzEyUlyN/etsBG9TLQk/1mtQJRElHfQNbiIfvH5b/zeUQV2ZbpBbGv/Mrf+c3VVIsg/ZnV6iezAMb1CYZVqAhjnsFDnB9En62xZ/FYqSdAzdcRIQRMUiQ/TA6qsXyT38mB7oIoZCPzcH0EDhB0RR1C8zq7RmutNusSks4Sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500797; c=relaxed/simple;
	bh=zdxhHhrViIfEwF5J3j7zcDiG3ivWBXlHP8EYGSBKzvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5xGewcRxuJXfKgwZz+uEl3ynnS50fIe0MWbcxrPachYnXDOVu+NpLXWxwu4srUpcg0EDRnsz+e+sKKwCsDOQZqEf9qYo5lCo/7jH+0wPjyHuLtut7FmYLbbo5A/2jcyRPTAioE2XqEwmxNqbyD5nHaHLLM0V3lx9xA+SWD8bkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSnKDcOI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bd5b3f8a98so14561525ad.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500795; x=1780105595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOQrKDZc/dG2AWZBKhQgSSl4D1RpjT3t8YquPC5sl+0=;
        b=iSnKDcOI4ry9FPO2ku+9RfoKlntnqlxBEEXVktjWQXp1Jl49Ie8kPlYgIf2DG1T+EG
         SdtAtUg6KBCz4EyxQRdrHiLE81FnlWKxJW2+3uINFaUby8JNGwwoPLGlNSLfxFNubch5
         iq9E7ox4X5qiRvoy2r3gppgkaJXnljflYVP5uBwI3hPiYC0BmcMoJnyqWMBWIw1sjSmr
         Wg2skpV35x0rpuJ4iyCdu++t+uDbbm2N++M3fMWFleIranFrKyfoTH3+I3hwaH9LP39S
         peo6x0Kq4+tX16H7E6mYyJZ6tGEnBUMvwcnr9PQ7fRKAn72xEePUTamWMuk9j7PN8Aq/
         bGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500795; x=1780105595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOQrKDZc/dG2AWZBKhQgSSl4D1RpjT3t8YquPC5sl+0=;
        b=U0TBSjJbLGTH9Tk3ILDDODVnzQwn8sWNHksCHZmm6DJJ+IGpws+ZXOml9uo677QZQz
         OtwPEe/RV1gHwd95VnJXS6mfUTpsptE4ja/fSt/Clz1IvPXXXfl6FRyzy54xQRW/F8Uy
         hxXXY72Ozj53yzZMh7s7zT+g2eCdVmvLaLwBiJ0LCysGnPQjxu+YIc7Ax+ZpEcZlQY2m
         abdFCNPlNvheqgaYUBqgycwhd+91TluBBQp38kDaka+k8s7cQlvqM5iPUmh+WJH7OYrB
         yTr1mje+nOZVnBV/SVxfjGMCGLMMsGZYAEW7PK/v9sDWi1MNHdSabtUoY6D3pf4zj8zf
         pqQA==
X-Forwarded-Encrypted: i=1; AFNElJ8tCE6X6gveblsPb7FFbacBsg57SfmQdj2VozDNIxiogaSXHfh9IMhwEPH/2tLiqV6cs/M/t2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3I3fjdxjxt/PMkbIcwisAZ+N9oCmTI4zlxb06Nykehlg5upz
	2rAUzqgiKSrT88Uzi3Tqnqk/ZlfprgisanxGvgYt/mOEOW8LDfxH2KOq
X-Gm-Gg: Acq92OFtWSf1LBtnQMzamZTcGrX0qd5BtPIFaolPf6DOTm+Jc1D3rK6y9wyJffgyN04
	sJouRpMC6FdnZf4NRjIY0rr6s3p2J+XMz14+IiQw8rpIIVFVMUgf2lJqA1IQGsH3jpkW113o4tx
	USddhOMymTTRnHQTJsnglmKETlUIGVpupm5AjCH0ZHpnbKhJTLCpapMkwCSbkJVbEW8F0OTz9Lz
	3fy6a7CGeWbkRzrW/uFMW/ymoLU6KF4gw3StZ79F4Exwsjostp3dH0RZwNX/L70UeFgqsRPO/OW
	E/xQ37VSNSekHjzMAxmqFEEerpVEwpF9CCtJbz1M11e+evkeywnD0nCVOJfip7CyqStiJ1MYHg0
	yqMe2hBJArqRN7plCLA4pTNAePGG7bUzdAzHl8eS75IUmWCs9ZFpYBpKXYV/zylAWjfwwm8ScNk
	YEqoDaUNFDEKEegTPQPA==
X-Received: by 2002:a17:903:2ec3:b0:2ba:1e94:d03b with SMTP id d9443c01a7336-2beb06acd0fmr32174025ad.6.1779500794568;
        Fri, 22 May 2026 18:46:34 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2d47sm36675695ad.45.2026.05.22.18.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:46:34 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] ceph: fix OOB read in decode_lockers() via missing bounds check
Date: Fri, 22 May 2026 21:46:07 -0400
Message-ID: <20260523014607.426417-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,dubeyko.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253873-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 893425BC65C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ceph_start_decoding() accepts struct_len=0 as valid:
ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
compromised OSD sends a cls_lock_get_info_reply with struct_len=0,
ceph_start_decoding() returns success with p == end, leaving zero
bytes guaranteed for subsequent reads.

The immediately following bare ceph_decode_32(p) in decode_lockers()
has no preceding bounds check. With p == end this is a 4-byte read
past the validated buffer boundary. The garbage value is then passed
to kzalloc_objs() as the locker count.

The sibling function decode_watchers() in osd_client.c already uses
the safe variant ceph_decode_32_safe() after its own
ceph_start_decoding() call. decode_lockers() is the only site using
the bare variant, confirming an oversight.

Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
*num_lockers, err_inval), adding a new err_inval label that returns
-EINVAL directly without attempting to free an uninitialized lockers
pointer.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in ceph_oob3_init+0x251/0xff0 [ceph_oob3_poc]
  Read of size 4 at addr ffff88800a29b76e by task insmod/58

  CPU: 0 UID: 0 PID: 58 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4d/0x70
   print_report+0x170/0x4f3
   kasan_report+0xda/0x110
   ceph_oob3_init+0x251/0xff0 [ceph_oob3_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 58:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   ceph_oob3_init+0x4d/0xff0 [ceph_oob3_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88800a29a000
   which belongs to the cache kmalloc-8k of size 8192
  The buggy address is located 5998 bytes inside of
   allocated 6000-byte region [ffff88800a29a000, ffff88800a29b770)

  Memory state around the buggy address:
   ffff88800a29b600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff88800a29b680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff88800a29b700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
                                                               ^
   ffff88800a29b780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

  num_lockers=0xccccaaaa (OOB garbage from KASAN redzone)

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition)
without any further privileges beyond OSD session establishment.

Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 net/ceph/cls_lock_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index c6956f1df..78276273c 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -299,7 +299,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	if (ret)
 		return ret;
 
-	*num_lockers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_lockers, err_inval);
 	*lockers = kzalloc_objs(**lockers, *num_lockers, GFP_NOIO);
 	if (!*lockers)
 		return -ENOMEM;
@@ -320,6 +320,8 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	*tag = s;
 	return 0;
 
+err_inval:
+	return -EINVAL;
 err_free_lockers:
 	ceph_free_lockers(*lockers, *num_lockers);
 	return ret;
-- 
2.53.0


