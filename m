Return-Path: <stable+bounces-253912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NFXGvlsEWpLlwYAu9opvQ
	(envelope-from <stable+bounces-253912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:01:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9F45BE145
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E08C301724D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067DE37FF65;
	Sat, 23 May 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/PWrlph"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2E37FF43
	for <stable@vger.kernel.org>; Sat, 23 May 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779526786; cv=none; b=gkaqkOOeurqF2UlUn+1kXX1ucMqu7q+1WeLUh38prGy7vJPr+SYmN80qH/YsXErXOqj7uamaMr7/bQeJBcoogGhqD3rAR9oltTxa5Rr5p1QlTiGX6LWvJ/zkbQ1L6kNEyDlU+5iuzB9a9/BR6wacTPRQcGKmjP+LpQ6I1B8bm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779526786; c=relaxed/simple;
	bh=JVNLwiPtXCyMV1uRjjpMghimPebbtQ44GeZ/L5I6yMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFpHDeZkh48dAS6bt7PL2+2Qx3SgBQ+OEQ06c9aHMqB3OO6VOiUYqjkcjltCsEbdjn2kuLfAlzBFjuFz9CSRQFTZXXd6iKaChVPpCmAMP4S+Gx8hmlQhzslSE5nsTzjLYWVDsoXj/iK8x0zzBJXNMGxcmUATOT9q18lqNblmP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/PWrlph; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83f9ed33da7so351600b3a.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779526784; x=1780131584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvyRGKblMsa85uNp1iOm2E+XE8wdYLKtD/IRDH9iso4=;
        b=H/PWrlph2jVfux0bnLqrNUuOu/Oa6PZpjwffR3wsXrYoIZTqVM2enQ9aijwC3v98mg
         pnXJFEHhshwJAY+riflVAW8Tqtx9eTYfA/2h6PXaAsqRD6/B7YfRaqO0Bl8yCf7/iNmQ
         ith0w4BCSdjaVDlLQy4c9HrKz8UejVJSdO6+q4SfU1J7NP4Go35bMeSgrlMidI8vLbvz
         g5NIwzDmk74j7u/zpa4uPRZ4jHIpbEI34zhsXR8i6weTQ01OqO+EQFsAbyJlJT6U6bm/
         qXX69IWRNVPNSe4vrYwCNWaSMajcgDGXS5ZlrLLajpG0aZHJ7+BA2seoCAYvZSGPzm4M
         ol/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779526784; x=1780131584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvyRGKblMsa85uNp1iOm2E+XE8wdYLKtD/IRDH9iso4=;
        b=HBS11YkhmE+t+4o5Phdpchu/NNbJH9pNjgs0cHQ7YF+VDSSmF9FHs6mYjsl4j6Cmb4
         UlsKuc7Yx/I71l9Wj84iOx9YlRW3EaBrQKg1bczCixEZ/BsNDss5LT/KjXh76hMMzQMo
         IXh9LUReZPrwrO3MZkKDg1I7OCrBAcsrCOgtz7Nhy5JHN8bxHRx8CZb+AFb+jBuNnSVB
         G4whoTG+kDFTW913GXplQGIPJVnY9doyePhFEhOXPcBQPjNq1Ibr6WcNjMkCjTS3vw+Y
         A7ZObACh+tNRBZuDpCTUo4CjY2NzSmgHvh8IkZMxAEx7vWEJIJ8NJaZz+WsLqaa+P0GG
         w4mw==
X-Forwarded-Encrypted: i=1; AFNElJ9ryoFAPep3JzmZJHN8sWHNPKcLRRx9H6Dh7zLbumXINcrI/YBCZF6CAvc4U+PJgEUsTQYcZLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJK99rsaHxJlilCGe3LfrcAjehw3+OM9xKnottyaerM5fKapF
	Cs4i4u5fJn68cJUjyZHD34YkQgTwMdwREx2qtQS4RWPhT5YBMLFJWB3a
X-Gm-Gg: Acq92OHGEh8vI8qCF/eeTEkZHd1udSd1dVvS/LOPX1+WGEtIlpfdLv9UytZvN8BFDl4
	PKYGgRpDz+q6MqYDs4TWCfvstRF9YJEMZv9mvucTk2nqcQCZI2f++9Cpuw6gpHcwSClGXNPaGgL
	xaTv/ok9uuCI9Apzg8Jkn7GZoOVqYCYyhAF/H0rP7fCWXKBiJ5+TuWCKEwRJ4bEtmuJTn0lQT5M
	HoqBBMkp4yoxFXzbU4dv59EQ3PZkryhSIBenrJFQaBTcpeeJk3qYh1oTyvSRtsJjcJ7VBlvmFKY
	ZKVyGE8CJLzl8F+xfskacRBx4WEbwl3QMlCc5eULVxFhq0YH7Rk1T3qw+/AVNog9Ouf+kedM1TQ
	0DQgLD8nJt96LEoSYqxRC9mdsMr4nxvfaUv4ZgEQ6HlYNkemYFj/VAc0KszwsD0PzjJ6dfCe74J
	Prr1lNQTQUwRQQfWe7V368oV29Sg4=
X-Received: by 2002:a05:6a21:4c11:b0:3b3:cff:cb54 with SMTP id adf61e73a8af0-3b328cde60emr3597088637.2.1779526783906;
        Sat, 23 May 2026 01:59:43 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164b0427bsm4696739b3a.22.2026.05.23.01.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:59:43 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] ceph: fix multiple unsafe decodes in decode_locker()
Date: Sat, 23 May 2026 04:59:02 -0400
Message-ID: <20260523085902.502821-1-jhapavitra98@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-253912-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D9F45BE145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

decode_locker() in cls_lock_client.c contains three unsafe decode
operations that allow a malicious or compromised OSD to trigger
slab-out-of-bounds reads:

1. ceph_decode_copy() at the locker_id_t name field has no preceding
   bounds check. With p == end after ceph_start_decoding() accepts
   struct_len=0, this reads sizeof(ceph_entity_name) = 9 bytes past
   the validated buffer boundary.

2. *p += sizeof(struct ceph_timespec) after the locker_info_t header
   is an unchecked pointer advance. A malicious OSD can position p
   past end, causing all subsequent _safe checks to pass against a
   bogus boundary.

3. len = ceph_decode_32(p) has no preceding bounds check, and the
   immediately following *p += len is uncapped. A malicious OSD can
   send len=0xffffffff, advancing p gigabytes past end and escaping
   the decode window entirely.

Fix all three by replacing bare operations with their safe variants:
  ceph_decode_copy   -> ceph_decode_copy_safe
  *p += sizeof(...)  -> ceph_decode_skip_n
  ceph_decode_32(p)  -> ceph_decode_32_safe
  *p += len          -> ceph_decode_skip_n

A new bad: label is added to return -EINVAL on any bounds violation.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  [   26.183969] ceph_oob4_poc: buf=ffff888009e31000 end=ffff888009e31fa0
  [   26.186087] ceph_oob4_poc: struct_v=1 struct_len=0 p==end: 1
  [   26.186738] ceph_oob4_poc: triggering bare ceph_decode_32 past slab boundary...
  [   26.187679] ==================================================================
  [   26.188236] BUG: KASAN: slab-out-of-bounds in ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236] Read of size 4 at addr ffff888009e31fa0 by task insmod/59
  [   26.188236] CPU: 0 UID: 0 PID: 59 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  [   26.188236] Tainted: [O]=OOT_MODULE
  [   26.188236] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  [   26.188236] Call Trace:
  [   26.188236]  <TASK>
  [   26.188236]  dump_stack_lvl+0x4d/0x70
  [   26.188236]  print_report+0x170/0x4f3
  [   26.188236]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  [   26.188236]  kasan_report+0xda/0x110
  [   26.188236]  ? ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236]  ? ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236]  ? __pfx_ceph_oob4_init+0x10/0x10 [ceph_oob4_poc]
  [   26.188236]  ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236]  do_one_initcall+0x9a/0x3a0
  [   26.188236]  ? __pfx_do_one_initcall+0x10/0x10
  [   26.188236]  do_init_module+0x27c/0x790
  [   26.188236]  load_module+0x4a9a/0x6350
  [   26.188236]  init_module_from_file+0x15c/0x180
  [   26.188236]  idempotent_init_module+0x21f/0x750
  [   26.188236]  __x64_sys_finit_module+0xba/0x120
  [   26.188236]  do_syscall_64+0xe2/0x570
  [   26.188236]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [   26.188236]  </TASK>
  [   26.188236] The buggy address belongs to the object at ffff888009e31000
  [   26.188236]  which belongs to the cache kmalloc-4k of size 4096
  [   26.188236] The buggy address is located 0 bytes to the right of
  [   26.188236]  allocated 4000-byte region [ffff888009e31000, ffff888009e31fa0)
  [   26.188236] Memory state around the buggy address:
  [   26.188236]  ffff888009e31f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  [   26.188236] >ffff888009e31f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
  [   26.188236]                                ^
  [   26.188236]  ffff888009e32000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  [   26.188236] ==================================================================
  [   26.255513] ceph_oob4_poc: len=0xcccccccc (OOB garbage from KASAN redzone)

  0xCCCCCCCC is KASAN redzone poison, confirming the read landed in
  the slab redzone immediately past the 4000-byte allocation.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition)
without any further privileges beyond OSD session establishment.

Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 net/ceph/cls_lock_client.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 78276273c..00f0309a6 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -259,7 +259,7 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
+	ceph_decode_copy_safe(p, end, &locker->id.name, sizeof(locker->id.name), bad);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
@@ -270,19 +270,21 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	*p += sizeof(struct ceph_timespec); /* skip expiration */
+	ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), bad); /* skip expiration */
 
 	ret = ceph_decode_entity_addr(p, end, &locker->info.addr);
 	if (ret)
 		return ret;
 
-	len = ceph_decode_32(p);
-	*p += len; /* skip description */
+	ceph_decode_32_safe(p, end, len, bad);
+	ceph_decode_skip_n(p, end, len, bad); /* skip description */
 
 	dout("%s %s%llu cookie %s addr %s\n", __func__,
 	     ENTITY_NAME(locker->id.name), locker->id.cookie,
 	     ceph_pr_addr(&locker->info.addr));
 	return 0;
+bad:
+	return -EINVAL;
 }
 
 static int decode_lockers(void **p, void *end, u8 *type, char **tag,
-- 
2.53.0


