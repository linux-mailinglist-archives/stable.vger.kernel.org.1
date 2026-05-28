Return-Path: <stable+bounces-254975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFPyICY9GGo1hggAu9opvQ
	(envelope-from <stable+bounces-254975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:03:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 030695F26BE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB9863063C5F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C7F3F0AB9;
	Thu, 28 May 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRkN5RdC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57B212D7C
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973314; cv=none; b=sJhZ4VLjWzu4+yEyVyEfLzha1s/IdQrfl4iBIpmU4oCZeW5xpzn65YDszNuuNNjIcZMv+nyVxW44jMaLXvOAgT1ZlXRdWwh28uynBnVck/1LOp5VJL4ueuylsFwHK/kjeeF+kj8gc41rIYqgh9CL7wsVoIS8PeWjQo8OJXlTAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973314; c=relaxed/simple;
	bh=lcDSJ87bV6vJQfy6PinO61G0LDBvkB6EAIMbHfc6P9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5GRmo46S1anC9208vjjM28ihJtDCZGHkzMqfpfXMUchAw/9/RHPK6HuR6y1eWJuiAVnQObz0sJK2RWrdy3xNfMlXhSDUaZltZ+0iRwoP6xKs4I0Bb24dZNahXpoYLRc6ng2uIEUDKQt6gD14lNVTe+V5bHu9iQFyMn585zKhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRkN5RdC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9a18f53afso13671045ad.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973312; x=1780578112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4XT7mBcrAQilbyNGQo5M9t2//fft6f/hb3lp/Dz9ek=;
        b=CRkN5RdCNdBHumB54hS4MbGcndzBsIWtQ/lhFuRvTnylUU1Qzb26uxBYqaNLQdrYxK
         tcZA+MrB999zXJrkk7PfCO9RMu9s0uRMqDlyThW11GDO4wB/3KE3w40C7r5I7JJqcEiq
         XJUFFNDkgczInZ4b5F4BmGXdcooKw2cScDkust8jS+2MEZcE9wMRfErUvHst6eVUOSJ4
         KCTneZ2L+7RTx4LvW9rWJw9ZxcDTuZ9cw6G85l4vFGj9nF+vqfMY2nF8B9asVErmPUG9
         AN1jpix/ESiPmVrEKNA/L3oRzGnJ9S9182ka7u7faq3MteArhbKX3s2JwvCHDo92jSGm
         18zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973312; x=1780578112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4XT7mBcrAQilbyNGQo5M9t2//fft6f/hb3lp/Dz9ek=;
        b=oxqujVj07s7dLCK/0Ry0erFWkqp/dDHpTr2L9ZqQoKr0Sfqnjd6F1OZHyGZ/9biJeP
         pOHl/l/Y2zCe2WWdVeulyLBZPfaX4v59tVIRSni/v4wLspFq+Z12qqs9vDHnf5E7oEAJ
         Im0Sa7sxi/kVO56hjWUG+PPwhinax5nks0Eas+w0xUvfbbs/Zl1z15d8pGU1HxLts3/8
         FmqitM0RIp+AvvN3x7Oz1ZfCRb0Yv2Ly8UWIo69f90wsdfnFhDu7AGEkaQwhcpjGye0C
         chvhMeKWaTsYstznni2G7xSnlf6G7X7qW8ICbBF+pio1jwpTZoyLynt1aLAtBhp3CuXU
         LLpw==
X-Forwarded-Encrypted: i=1; AFNElJ+j9BUeoaEk3zrALneHqTMRjO/Whk7G1Op6rYU7GTUn7qhnhusg3nLknAvodxBPcRQJqP5RX2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wPFvwKCUppfz6mNdmhLteAYumMGBrKfvLRDO+1gJJtSSMdwi
	8WMTIck2giacAvu7HhlUH7K4i2tObqLEYXdwGmCdkbGWyZIdVUMDpcPt
X-Gm-Gg: Acq92OGb1QyohiW/BnltwM3E0w8A7YaPG5U3iZbaScbRyl0Kbb697m6M2dMchgXK/aR
	/bbZvpkPNh9VwWbvpc8HUXC/PWZw6QJYY/1yI8QXcskqKXSCzA1gvyzx3jVG6sINuNBkZ4HOOfG
	sTyX1haRKEBKzGdXjpr/Tu0gk6F6MuCiQ7Wl5yyS4TYBsJMhEYAAYcnEuyfU4yFz0Ii+aWwqbzZ
	1dQ9MBUGQiAncWs+CRZJp0E3SZ8xHrUHyoCOsjf08PGfegMHCmDVZNrykAiHE/Ar3BSepkk++pE
	Jv6qXFcKXgB5FjtpqvG2hQ7hqy2WHp0IrUsBcRrMqwy7fFT9bwj3j6vOrW4tg2LSy5XwEQqtawK
	LMjO0g57o1d2fOV8iNz5U1WT5gpJrYoQjaNnj6x7BDdBt6AO9ejl9HuvhTfiCUAuU1eO1pbKgCu
	nBC7bRsZYJ6QJaKc6yzCVGKfyamk7kdt6aPuaQTls=
X-Received: by 2002:a17:903:2392:b0:2be:8d29:d5a7 with SMTP id d9443c01a7336-2bf02eff093mr19004395ad.2.1779973311622;
        Thu, 28 May 2026 06:01:51 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf0534e4c2sm23772905ad.5.2026.05.28.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:01:50 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ceph: fix multiple unsafe decodes in decode_locker()
Date: Thu, 28 May 2026 09:01:13 -0400
Message-ID: <20260528130114.830041-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b8ccb15776c8b9770c09b884d1a908d4994ac936.camel@ibm.com>
References: <b8ccb15776c8b9770c09b884d1a908d4994ac936.camel@ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254975-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 030695F26BE
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

A new out_bad: label is added to return -EINVAL on any bounds
violation. -EINVAL is appropriate here: the data received from the OSD
is structurally malformed, which is an invalid argument to the decode
contract regardless of whether the caller or the wire is at fault.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  [   26.183969] ceph_oob4_poc: buf=ffff888009e31000 end=ffff888009e31fa0
  [   26.186087] ceph_oob4_poc: struct_v=1 struct_len=0 p==end: 1
  [   26.186738] ceph_oob4_poc: triggering bare ceph_decode_32 past slab boundary...
  [   26.187679] ==================================================================
  [   26.188236] BUG: KASAN: slab-out-of-bounds in ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236] Read of size 4 at addr ffff888009e31fa0 by task insmod/59
  [   26.188236] CPU: 0 UID: 0 PID: 59 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  [   26.188236] Call Trace:
  [   26.188236]  <TASK>
  [   26.188236]  dump_stack_lvl+0x4d/0x70
  [   26.188236]  print_report+0x170/0x4f3
  [   26.188236]  kasan_report+0xda/0x110
  [   26.188236]  ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236]  do_one_initcall+0x9a/0x3a0
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
  [   26.188236]  ffff888009e31f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
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
v2: Move inline comments above ceph_decode_skip_n calls to stay within
    the 80-column limit, and rename label bad -> out_bad, per
    Viacheslav Dubeyko's review.
---
 net/ceph/cls_lock_client.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 78276273c..4f27b3d15 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -259,7 +259,7 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
+	ceph_decode_copy_safe(p, end, &locker->id.name, sizeof(locker->id.name), out_bad);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
@@ -270,19 +270,23 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	*p += sizeof(struct ceph_timespec); /* skip expiration */
+	/* skip expiration */
+	ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), out_bad);
 
 	ret = ceph_decode_entity_addr(p, end, &locker->info.addr);
 	if (ret)
 		return ret;
 
-	len = ceph_decode_32(p);
-	*p += len; /* skip description */
+	ceph_decode_32_safe(p, end, len, out_bad);
+	/* skip description */
+	ceph_decode_skip_n(p, end, len, out_bad);
 
 	dout("%s %s%llu cookie %s addr %s\n", __func__,
 	     ENTITY_NAME(locker->id.name), locker->id.cookie,
 	     ceph_pr_addr(&locker->info.addr));
 	return 0;
+out_bad:
+	return -EINVAL;
 }
 
 static int decode_lockers(void **p, void *end, u8 *type, char **tag,
-- 
2.53.0


