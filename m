Return-Path: <stable+bounces-254966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDF5EJUvGGpwfggAu9opvQ
	(envelope-from <stable+bounces-254966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:05:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0C5F1D52
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A62E303455B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469AC3E7161;
	Thu, 28 May 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW47772w"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC23E3DA5
	for <stable@vger.kernel.org>; Thu, 28 May 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969606; cv=none; b=luDk0W3vYrQyiR7WDrtW89MnN47gSYcrzLtUOaARKaM2lX7C6qE7rJ8d0YmOOhvnR85sA3fq/+3TpFIuii4m8HpeSzsBN/ENbBoevjrUskg2ixA7cdzNdUC3Vl8uw7gW2XsTHHP2Wa1R4v11sR8rTwvOrJv3tvUjCe4Hu6SRgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969606; c=relaxed/simple;
	bh=htFmoUdtvWDyUgG8uCJCoUFye9ZJ8o4lYS0AS9twxvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOaoAiA5LneY9gnjCzQYVzMYeo/tYpyUSPKXkoJsT6j2qMKVLUK+9J7LolCHBtIrX4B/tjaImmAufqKofjSpDB+bKhlTOpxgumNLZh8VEjXFqDkplbdmEZ9KTF3/lnWWT6TGUJT6115RTTs3DU1yMfvBzx+WQIq067iMugm7/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW47772w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83538fcdda8so1025848b3a.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779969603; x=1780574403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5vl3C5jPSAv3GytCPh8lvvkDSsugrJeALohk3VsT+s=;
        b=hW47772wN8AK3PT1uNAy3S4iNleMu5A21P/RFK7zghBX6kUFIG1b/s9SlIbIftLO7F
         5exn4l1THxUnlfM8FrdRVonHSbcw/mXeEuDzp+0SwDp4p4H8KgLm1SrRpLx5vtdwqjsn
         2pAPmTLTBlIc0kDOSJxxlgL47wYUFfnPVdigqWdOBnOHSBhN3kYrXI3QzkbpS/1FdhFt
         bbkhQJ6R8dPyTpcQCIPYkZ1XFtLvu0qIR8caR3+z/14w7awqvbTthTTnBxeLSO+yC6Dk
         GhVrri2/duLBZYFdViU3XHbA7yIMsaOgdHvfRWif0U1nRZE2gx3BamFeiCv+5OdMi7pu
         16VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779969603; x=1780574403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5vl3C5jPSAv3GytCPh8lvvkDSsugrJeALohk3VsT+s=;
        b=GvnE+0YciHG3/Ojb1k5DYEfEvjtJDANWWlBeT1rAZhsY/2hZz90IDe99X8YImWHB2Z
         hsv4g+xsBM6niFNDBQL7fZ2rgDDl7Z99gpa9Zi+hkM28j5NmxP4EAWDxnvnio11Aabt+
         +h9IbcGnyygpUUUtLMyG+s+y0MIDcJ2P026OSVDSQmBtWAuaGGpGUXxgGi1oWIePcKBk
         ehF1K4oIBCGNDOz+HMMDDImPhP1lSQ7W/5PxyPACBcOtemRa83Xw62UV7bjo2UDjwYpQ
         j1rCDyToMGItYlw1FEhZ4EnjEzQ06NUNK/xOvIDHPL+uZsxh31S7+5BvOLp6XkFAIOce
         YWuA==
X-Forwarded-Encrypted: i=1; AFNElJ9IwDwKgXiTN4Mi3vGv89PzWOe8b7zlfZFg0vbgTNN0IrZBozxQhPOI0aXEWHaCu4Sf9Q/pfBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLBPtbPGVz0dcNeX0QnNDGaKNngDS87hfkbVavG9Ctv6DIfw4
	X7Sdhkc+XVCvrH5KUdl4Tp6IyOAyEdYCm1BCSztj9HsKyxEiL8m2+dSu
X-Gm-Gg: Acq92OEsOKEOQ5k2RXOvz8cJ/NWvTJRDXxczuqGFc7UsFE6+1WQotAjLsT3zzEz7bBt
	/NTfMi6CbWjHR5V2DaYNmNyIjoG3lFBPKq4uGe0pzrBIn23IIx3RFYhW+wxAHCrRFz5M9zyl8nf
	atlgt7sR956IZ8ZnRrSZteSIDiO0IM54UebhIe8q3NMlt2TICoMwDLifoy9OHzurmO+o2KN8Wc2
	NM5yXvy2YHuxaJD7oQHUC7wYCGFhzoX6DhewuGgTfGRMivqb0L+Z82iiLL2BXRnY6UHk0K5Q3wT
	E1PSeCL57RxXpMmM95uINnd4WIyZiR7OC3Lc04zkxZNqWR72a8FVl4wOy4jvyJ3TfebXnWQhwxQ
	kmESLn9l+NfxLEpE+s1PoE5eoMTzSaxoccVQlGe+5WlrHo/jhbn+0/CXo8iZ/Gjk3PuF5bF8kI+
	kmJJCKGBqj6Dcx93mqj/Z5l7IXqfE4
X-Received: by 2002:a05:6a21:4d8c:b0:3b0:77d6:4b9c with SMTP id adf61e73a8af0-3b3f0fe79d0mr1672819637.6.1779969603200;
        Thu, 28 May 2026 05:00:03 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6ed19c2sm4678126b3a.25.2026.05.28.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:00:02 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v3] ceph: fix OOB read in decode_watchers() via missing bounds check
Date: Thu, 28 May 2026 07:59:16 -0400
Message-ID: <20260528115916.796696-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fb2206a9cc8519e54d269b6e5aa772edddfe6fec.camel@ibm.com>
References: <fb2206a9cc8519e54d269b6e5aa772edddfe6fec.camel@ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,dubeyko.com,vger.kernel.org,gmail.com,ibm.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254966-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97D0C5F1D52
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
*num_watchers, bad), consistent with the established pattern.

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
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v3: Rename error label e_inval -> bad per Slava Dubeyko's review.
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
 net/ceph/osd_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a67093cf4..9058de08e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	ceph_decode_32_safe(p, end, *num_watchers, e_inval);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5045,7 +5045,7 @@ static int decode_watchers(void **p, void *end,
 
 	return 0;
 
-e_inval:
+bad:
 	return -EINVAL;
 }
 
-- 
2.53.0


