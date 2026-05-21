Return-Path: <stable+bounces-253571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /ALGMT8dD2ocGAYAu9opvQ
	(envelope-from <stable+bounces-253571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:57:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD325A7C39
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0B98328F745
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11ED3112DA;
	Thu, 21 May 2026 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enhV25uK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316032BDC29
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372636; cv=none; b=j4u+Q9D1ro4UrP9ZMC0beUlro118OiAUbuAKI2cqo9JYmvmPn9Wr5lK2cpKFMdX6Kk0ifKVD+2t7cL/CuRI2C9Oxws44z8BmoNCr4UybtHgaV7A4YsacF548yvof3C/epOaQ2H0q2RqUAwCMNQ6bIs00FqF7JOkdKDHZeAcpiZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372636; c=relaxed/simple;
	bh=6RlyQ3PoQLb/mFu/rZlnILn3W+UF3uXxp2l5YOXKYho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0gF9plQk/eWLf1sTPJ9EfSLvXLk5Im9zm1hjK0QDjp82NZPAw2SJsvwA/KvoOXXpo/kuk4p0y7TJdR0K5/s575kXy9ekXFUwIaaLTM2AjyqKabBAGAwny4PMBrCGjfW8D16c7ZYc87306zVMy+EuXRExfyB00Z7oLk+fV/P/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enhV25uK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2be3781e543so5292185ad.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779372633; x=1779977433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TEFoD15Gehd8ToTlGMdZgCg4EXx05S17FiyO5aZVIY=;
        b=enhV25uKKdbr0QBlFohTu3F8bcvYgTjpOstHctvfhwMi39VrNeKJRD6ji1ngsySRQ2
         c+Gt7euizKvOWTtGcmk2MGCRyWC8AugcB+m5IviWT2tgQv2vez2qpPuEcAxukzVs6mXM
         kO7bk03ntynEzGFR7yqiZRYsuN+NJAGygMCerlZofWxXzQ6RtB2xZr6XZxBezTUCulSB
         vMskNRt1OfIqXRkhtzFj1SVF4VmO93PBfYYNu1P5zDHuuhoDeAhAN25MRVHENo9VwVvf
         6MBF7vbXFrSPJJAnCg+lYI4Kyxp22ZNd9MCYPdCFsbxjHA2YYkqdTIwiFsTYxM5GPCoy
         4psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372633; x=1779977433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TEFoD15Gehd8ToTlGMdZgCg4EXx05S17FiyO5aZVIY=;
        b=k4EZLYhL0MaHPqGyBYDIKxB9G6/w1wrSnfn3ujITab6HGYQbsvJUAALGj6Lz7BdgIB
         4DhH3flo8AuiO2ssdXUjIolPLMQ5gEkHPQZgWzA1A9AGgTqhq8XwMXYon4f2Qc4DuCyj
         W02CnRKaRu4WrppMn99nqapdvNvIhbpjVqDPqJUQeDuaJLREG9UpfXPhokV0mNBJ1004
         V4HnaOaU5adjFsv4INt6HAyz3gzDtHleJHKvaabVBXtrz8CnIk2TOS4jMv5kDBmZzjvx
         3lvppVQFEq1xW2+SwENXUGn1RtW+stcEtjMeuQJryBN7i5eBl5buQTdDE+IJpyS9GCkS
         D3FA==
X-Forwarded-Encrypted: i=1; AFNElJ+HSk9a/1a1DRWfU2BTFgctUNG0jXV9hN+CqZiT3jMC96IVX6r5AKQHfwVPxhoTGBYfMu7lXY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRRGZ93+obz2mx9R5WoSZRRPsIsG1dCa1iB12J9a0qeZd4Llz
	fpTTnk3O25jy387SJDz6w8sJ1qRWB1dQLCJTCZJlF4UGhgG0Xr6X6VhC
X-Gm-Gg: Acq92OG7T3ybZjuCGPScJod9wzQ8MO652cVhdk482ggdWKDEUq46zBo/3rZKYH6/1ww
	pTC1oluDP5Ta42s7g43MiOUY8YFdCBWQeR6QqA001JfdiQa/4+ig3+MYJ89rtmRh1CAShkMUtOC
	w5pd2hL52vn72drxlNKxztCJ9s7U4Wlt0C6jPKdSsiyQE1m/L/BAUaGGS40RyHmEwDI8lyp0see
	gMFLbZXBy6y5bRa0Tm0bWuKuFTV3d1JOazm8ciLPMeNwYaoNqopilVzkoTPtkObfgJ3BpG/rEKt
	tbSOo9LQab0p+HWmbtypADbYw0Ch6FyX8oNEcZ9g6thhxQBQS7dxgU4aChNy82kWRM365aYagyE
	39l9GhiUZ6JnMeU8fm8tQUYrp02swa0pMnokIPRFDk3DIoMs5UqMcVVDe9MVhAjd+SIVxbAR/0V
	sqiqqheJPHZSR8JEd4
X-Received: by 2002:a17:902:d488:b0:2b0:ac1e:972e with SMTP id d9443c01a7336-2bea33712c9mr15265625ad.8.1779372633369;
        Thu, 21 May 2026 07:10:33 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9902e0dsm12345245ad.61.2026.05.21.07.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:10:32 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix OOB read and unbounded alloc in decode_watchers()
Date: Thu, 21 May 2026 10:08:06 -0400
Message-ID: <20260521140807.204657-1-jhapavitra98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,dubeyko.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253571-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CD325A7C39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ceph_start_decoding() validates that struct_len bytes remain in the
buffer after the encoding header, but accepts struct_len=0 as valid:
ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
compromised OSD sends an obj_list_watch_response_t reply with
struct_len=0, ceph_start_decoding() returns success with p == end,
leaving zero bytes guaranteed for subsequent reads.

The immediately following ceph_decode_32(p) in decode_watchers() has
no preceding bounds check. With p == end this is a 4-byte read past
the validated buffer boundary. The garbage value is then passed
directly to kzalloc_objs() with no upper bound, allowing an OSD to
drive an allocation of up to ~4 GiB worth of struct ceph_watch_item
objects under GFP_NOIO pressure, or -- if adjacent slab bytes happen
to contain a small value -- a legitimately-sized allocation followed
by decode_watcher() writing attacker-controlled data into it.

The sibling function decode_watcher() already uses the safe variants
(ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
after its own ceph_start_decoding() call. decode_watchers() is the
only site that uses the bare variant, confirming an oversight.

Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
*num_watchers, e_inval), consistent with the established pattern.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  [   72.047085] ceph_oob_poc: buf=ffff8880085936c8 end=ffff8880085936ce
  [   72.048685] ceph_oob_poc: ceph_start_decoding OK: struct_v=1
  struct_len=0 p==end: 1
  [   72.049477] ceph_oob_poc: triggering OOB read past slab boundary...
  [   72.050699] ==================================================
  [   72.051427] BUG: KASAN: slab-out-of-bounds in
  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
  [   72.051427] Read of size 4 at addr ffff8880085936ce by task insmod/61
  [   72.051427] CPU: 0 UID: 0 PID: 61 Comm: insmod Tainted: G O
  [   72.051427]  7.0.0-rc7-g9c2abf69da83-dirty #14 PREEMPT(lazy)
  [   72.051427] Call Trace:
  [   72.051427]  dump_stack_lvl+0x4d/0x70
  [   72.051427]  print_report+0x170/0x4f3
  [   72.051427]  kasan_report+0xda/0x110
  [   72.051427]  kasan_check_range+0x125/0x200
  [   72.051427]  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
  [   72.051427]  do_one_initcall+0x9a/0x310
  [   72.051427]  do_init_module+0x186/0x410
  [   72.051427]  load_module+0x2ba7/0x2e50
  [   72.051427]  init_module_from_file+0x15c/0x180
  [   72.051427]  idempotent_init_module+0x19f/0x430
  [   72.051427]  __x64_sys_finit_module+0x78/0xc0
  [   72.051427]  do_syscall_64+0xe2/0x570
  [   72.051427]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [   72.051427] The buggy address belongs to the object at ffff8880085936c8
  [   72.051427]  which belongs to the cache kmalloc-8 of size 8
  [   72.051427] The buggy address is located 0 bytes to the right of
  [   72.051427]  allocated 6-byte region [ffff8880085936c8, ffff8880085936ce)
  [   72.051427] Memory state around the buggy address:
  [   72.051427] >ffff888008593680: fc fc fc fc fc fc fc fc fc 06 fc fc fc fc fc fc
  [   72.051427]                                               ^
  [   72.051427] ==================================================
  [   72.129720] ceph_oob_poc: num_watchers=3435973836 (OOB garbage)

  0xCCCCCCCC (3435973836) is KASAN redzone poison, confirming the read
  landed in the slab redzone immediately past the 6-byte allocation.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment (e.g. cloud) can trigger this against any kernel client
that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
beyond OSD session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 net/ceph/osd_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c..0148e4c40 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, e_inval);
 	*watchers = kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5044,6 +5044,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+e_inval:
+	return -EINVAL;
 }
 
 /*
-- 
2.53.0


