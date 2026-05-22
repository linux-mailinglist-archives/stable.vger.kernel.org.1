Return-Path: <stable+bounces-253751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOM+ENQvEGrIUgYAu9opvQ
	(envelope-from <stable+bounces-253751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:28:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B75B214D
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29B62302458D
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A53CAA3E;
	Fri, 22 May 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKn6JC0r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502F3CB8F5
	for <stable@vger.kernel.org>; Fri, 22 May 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445250; cv=none; b=ZplZrap48n8jhcmzJYMVbCzum7TxujpOM4nKltDpEGBwi8/IUsvREQgPCiyZXgfI2gzh1zZ9uYv8UOQqte/9s/T5E8dhoH8jrKxXX4rbL6dms6/KfvwrN28/VhxfKIFOThe4DpQNgV7iy6eHUHQQusK1CUpy3MXZNIVwCs7yvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445250; c=relaxed/simple;
	bh=CqqfADRIYdy2j/+p5yLnh5aLdmAPFqsu0MNRmXCNItE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvN3MUEenrkFVUoDJL3P6HkfyN+3ZYbXP0EUK6VSbNf2O2tusVIv5HUmrYncd1dcnHgHgSsMatxkJ/CCoI37hq8ZudftrpiJ6jvxB7fE+jAUcms8eKGv3rckyMr58Jr+OsAgdlLYoTI+EOpi16sabQEzRbDVNtG31zKN/1Jkw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKn6JC0r; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7979304c0cso620940a12.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779445248; x=1780050048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGF3BRrejRrTaJFBtcO7t80MSvJtsYjl3QazzV4jG8M=;
        b=AKn6JC0rJME5dKelu613J4AmnNJeh8RFoPZjk5s7fpJzGNmpFd6rz3zNLP78ewEfPD
         R0BRTADB8h6LZ6Dju/Sdv2jTfZV7Ho9K45+F7/4dcpU/d89v8H3Y/SM6X+fEZV0L+K97
         M4MhlJQrAULo5U0R6CtZpp9wIMgeaVupMdqeASZHa4Ih+jGKGd8mZci4paQ2LGjlSw/M
         0N3JxX5nxXMrVTAoZs18ZdDX4+NsYum+0XQrn8OgxYR5bgtP6kd9C91qN7dyibnxcM8Z
         j5zRAEMZvAO3XQZhgilu3kP24vZmQ8cdZynkR5ZEWpzsHAYhFS794v4dw65YbKudCurX
         Xp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779445248; x=1780050048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGF3BRrejRrTaJFBtcO7t80MSvJtsYjl3QazzV4jG8M=;
        b=QOQEhUe8ma5zKbOTXDY5W2PODSb5woh8RLyfCgiBgfq3sWxyAVgEDnodL1ZU8QOVbN
         232HO5yWeBe0bESCm805ZnaV0Txw35F6bC/qdEPTAeN0pIwSnqHMAD0O86UwayZ7GXQZ
         6H5QGITVu42VJFtssRmcz+C9k3t7WR87YUDvXyUrICmlOvY6C0NZeUhZ0LJ+Vzwn0gqE
         jQenzP6dgDlA81c2VMz863lHnR58+6a/ig3rjnA/D10ZkSQbWJVVqDG5DKPrkqlztmp0
         N4h1aioMHfgEOxTyFBgyHyzvnC+tTnFFcMfAXGshOupbDlVje4PQFz6Azy4+uQXp/a21
         dqiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Bpc+6/yZsEG6KBk96hGDwbGTCX+O8KPKxja26fN/c7HZZFCM9ZNVjRCXW3rV50mFKeWnNnJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItgsx7cJQTsm7wZ3J0Stwu0y6hdf3OQIyHwD1RFsyaHbp5MrZ
	46A3bi/UiJtzPl9Ef44dwrW9gjTCU5rDzsDtw6rCT3hFEXnmSGCG0HMv
X-Gm-Gg: Acq92OECC2XBJA88X0gO+OypaKaKgIezrli5ul1h1a99TBdoVX8bYXZuyHp74jI3yrU
	LHKGEmc+zZVtzQrmHZJXgLoCO6VFiVaXHKlljo8GcZl51tYg6xZ+aWa7XOmQ0UwylEPBA28j8lw
	UsChdR2pTGYgq9wbnUV+SxFkWRHbxulx9pn93IndGJGRARRLvyaU5QnYj2ZAioyh22tjcb5Svl+
	tNDUpY/T2uDJOfAROkWgNgtK35U4evcApzAVVIKykHRoNHvH13pRVUwWxn95XQp1oRQ07g+4yDC
	d/e0w4xZqyzMQFsJgxjpcd6fjeBQd7/gPXhMM2V0+58I1Cx0lQ81ImM+vYCW2Q3P4XIKEEfJPD1
	AvJ2MjXJcZb39NSn+9QvHeK8nITfBgr5QP7QjvaOZNhdLXjM477+BTq9fSa6qR9kAGgZ/2BtJjQ
	BSl+WVJ5o933XGdGGhWg==
X-Received: by 2002:a05:6a20:5481:b0:3a0:b812:3a84 with SMTP id adf61e73a8af0-3b328ce6862mr1642445637.1.1779445247567;
        Fri, 22 May 2026 03:20:47 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea09a9sm1881827b3a.31.2026.05.22.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:20:46 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ceph: fix OOB read in decode_watchers() via missing bounds check
Date: Fri, 22 May 2026 06:19:32 -0400
Message-ID: <20260522101932.304458-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521140807.204657-1-jhapavitra98@gmail.com>
References: <20260521140807.204657-1-jhapavitra98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,dubeyko.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253751-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 161B75B214D
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
directly to kzalloc_objs() as the watcher count.

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
v2: Correct commit message. v1 overstated the impact:

  - "unbounded alloc": retracted. kzalloc_objs() uses size_mul()
    internally which returns SIZE_MAX on overflow, causing kmalloc
    to return NULL. The large garbage value from the OOB read will
    simply fail allocation with -ENOMEM.

  - "decode_watcher() writing attacker-controlled data into it":
    retracted. ceph_start_decoding() calls ceph_decode_need() for
    its 6-byte header, which catches p==end and returns -ERANGE
    before any copy occurs. Verified with a follow-up KASAN harness.

  The fix itself is unchanged.
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


