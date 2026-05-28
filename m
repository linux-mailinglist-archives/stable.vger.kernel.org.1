Return-Path: <stable+bounces-254970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBguBaU2GGqkgwgAu9opvQ
	(envelope-from <stable+bounces-254970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:35:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A037A5F221B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CC3C30AB71C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0768D3EE1F5;
	Thu, 28 May 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLRQNVQT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A853EDADB
	for <stable@vger.kernel.org>; Thu, 28 May 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971380; cv=none; b=UWLkSTtem3CTOb3qrWmMaO7JNrkG6RmectfUVgqd+3FzJ7QPmDlmbJfgUmvz3o3dovEdjCAJJpbE8CNSk7MwhFZ89336ROlIU1MJ7XZloX7RqDOzO85SL1+jNcqm3rihqalaIXiQKfK4aJIQ5496TIzDaxyCMRm+4rP3ad2RGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971380; c=relaxed/simple;
	bh=35MlVezcupd5yPlUzqBMIYnD/JJzM6+1PLVhgoDe12M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIoAPoMPnrXRNqWkqaU9+y+JLy+tyweDmqubtitokNB7lZRNHVQ/R+OQrrJjc/HAEJyEgi7CwEa0l0crunOtfkK6ppsUL0418avg60iaGVmckTRE8apeSKfJAchkdd668oPbeUAfL596UaL8auQvJaTF1aHI57Ga/UuKVn0vgu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLRQNVQT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bc6e4556d8so20903555ad.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779971377; x=1780576177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaXEq4usvj1KBBTVFhHU4aIk2csiMoZYWm1hpe477sc=;
        b=pLRQNVQTrV/IoyFPETRhbVwpwgegKG8Yzv3iwt4E8lTKUhYpi+Mdd/HR20xTxPLzog
         zJCx7c4Pq79VkvMgE8YKTTW4LOjx1+5T/+kVGxoABvI4uitiY/WV4dSfIKHF21HHdZTA
         1GhGeOkHOQhZkhnYkQ/lk5WTfgbdTYNwnniZSoKROV5foRtyKMcLKA2DRgVg4q6zdRQH
         6XSUPjuVKfabAXZeI5+2V9DsDtZ8AW19+ktnPDr38GOljH4j1vEGrfKG8lmyvxOdiXf2
         13zvPVipbseZ7cs2qiCaW9AV0+M+hJ87UwdYHULK8NSd4olaUSqoFwX0kz5rtOc3qyIK
         967g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779971377; x=1780576177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaXEq4usvj1KBBTVFhHU4aIk2csiMoZYWm1hpe477sc=;
        b=cXpr/UkhM31/VQ6nbOJeoNou4UXcuWU5poHBalFLXx5RVo/x+ylG0uqB4XblR8yY15
         I1ubZsfTfmK2pPKcta68VYOagx6c4UYXGWt4nxvFHjrUXKXBAjtfRA8CLPW/3U2D6iqx
         YDFiA3EmTX6LGA2DafLnrWiNI7dNMI5d22CvmEtccP3oFU8jUmR90LSg3ZpTl9AuJb27
         X+Csc+dI6X7B5YanYH7U5eAvvkyDR7NFTEekeqV9VvqB105KcKsOpSfDb8g8cOpoMiow
         /+LzCP5t0Y1QtALL0cgrT/9i4NbqBsXAjwv2HXFsxq48hd79y6f5PlnqAJ+Ycg4PHX88
         iVwg==
X-Forwarded-Encrypted: i=1; AFNElJ9zPSrcMQYI8qCEbuwUYjccIsPTXIDNmkyVeE3XY5lUHjQzVj98jZsssZQxfW5NQ3TFm3Pmjps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNdRVhAIsih/CHmw35TDEn7gIKlD3s/9P6wvQPUe9pIeNR1Nm
	KguzV7hKgMX4tjWH2n8Pf+1TuSHuVmr3M/TsKKhuptC9uRbfVyoEKJCR
X-Gm-Gg: Acq92OH9iopN3nw2qpMpyInuSlkGhZKa8AZAX6BfTpDMQjw9O2XrVSkw6Lv9SzZpTqs
	GHwq+DMPgMOMIdsmOiTXDACZKhPsZ+LLPxARiap0zTzJJiDCk0V7C92avT5QsWenM0vVzAkflbi
	YtqnDaS0vJ8J4GUOE3fw+6zEZQsLn4BAazgVJvnVuXJYei+0y04MXzmgAR3DhIdAA/n7Rnftvgd
	OL7pLjaZ71i95GMLY/ElMOZm/yjk9S2XkQ8X/OLlre6DIOhQF51CNbL9y0gwlHvrP2nYNZe+Zpw
	Yv83lzGkpP2j+WQCc0vux76zpWzhzVieOJHglwt2WKAcGagzM4pQoo5xlD3MzYzz9cUX/qM0vzy
	0x9V0xPHW/+mmNsgY8b/QXI8fKCt7pfPNdJsxEuYI6/5Z5rzU+i2dTv3DctdcqCReYb4RGKRNK6
	gDwePFKGb+xWd/EJnPWgLgA+HyqjoI
X-Received: by 2002:a05:6a21:3a85:b0:3a3:1814:20a2 with SMTP id adf61e73a8af0-3b328fa5bbemr14257538637.5.1779971377056;
        Thu, 28 May 2026 05:29:37 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b3867sm14320967a12.11.2026.05.28.05.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:29:36 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ceph: fix OOB read in ceph_osdc_list_watchers via uncapped outdata_len
Date: Thu, 28 May 2026 08:29:11 -0400
Message-ID: <20260528122911.813491-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <71578c12a1b9d37aa2a39c8d1415084e0dea9216.camel@ibm.com>
References: <71578c12a1b9d37aa2a39c8d1415084e0dea9216.camel@ibm.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254970-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A037A5F221B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The OSD reply header field op->payload_len is wire-controlled and is
copied directly into m->outdata_len[i] without any bounds check:

  m->outdata_len[i] = le32_to_cpu(op->payload_len);

This value propagates unchecked to req->r_ops[0].outdata_len and is
then used to set the decode boundary in ceph_osdc_list_watchers():

  void *const end = p + req->r_ops[0].outdata_len;

The actual data allocation is always exactly one page:
  ceph_alloc_page_vector(1, GFP_NOIO)
  ceph_osd_data_pages_init(..., PAGE_SIZE, ...)

The messenger caps the copy to PAGE_SIZE bytes, but the decode window
end is set from the uncapped wire value. A malicious OSD can send
outdata_len=0x10000, causing _safe decoder boundary checks to pass
while the physical reads cross the slab allocation boundary.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  ==================================================================
  BUG: KASAN: slab-out-of-bounds in ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
  Read of size 4 at addr ffff88800a229f9e by task insmod/57

  CPU: 0 UID: 0 PID: 57 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4d/0x70
   print_report+0x170/0x4f3
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   kasan_report+0xda/0x110
   ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   ? __pfx_ceph_oob2_init+0x10/0x10 [ceph_oob2_poc]
   ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   do_one_initcall+0x9a/0x3a0
   ? __pfx_do_one_initcall+0x10/0x10
   ? kasan_unpoison+0x44/0x70
   do_init_module+0x27c/0x790
   ? __pfx_do_init_module+0x10/0x10
   ? __kasan_slab_free+0x47/0x70
   ? kfree+0x15f/0x3b0
   load_module+0x4a9a/0x6350
   ? __pfx_load_module+0x10/0x10
   ? security_file_permission+0x24/0x50
   ? kernel_read_file+0x2ed/0x770
   ? init_module_from_file+0x15c/0x180
   init_module_from_file+0x15c/0x180
   ? __pfx_init_module_from_file+0x10/0x10
   ? tick_nohz_handler+0x2a3/0x640
   ? _raw_spin_lock+0x7e/0xd0
   idempotent_init_module+0x21f/0x750
   ? __pfx_idempotent_init_module+0x10/0x10
   ? fdget+0x4e/0x4a0
   ? fdget+0x4e/0x4a0
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   ? exc_page_fault+0x66/0xb0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 57:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   ceph_oob2_init+0x44/0xff0 [ceph_oob2_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_YSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88800a229000
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 3998 bytes inside of
   allocated 4000-byte region [ffff88800a229000, ffff88800a229fa0)

  Memory state around the buggy address:
   ffff88800a229e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff88800a229f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff88800a229f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
                                 ^
   ffff88800a22a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff88800a22a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

  val=0xccccaaaa (OOB garbage from KASAN redzone)

Fix by introducing buf_len to hold the allocation size, using it in
both ceph_osd_data_pages_init() and the min_t() decode boundary cap,
so the two are guaranteed to stay in sync if the buffer size changes.

Attacker model: a malicious or compromised OSD in a multi-tenant
Ceph deployment can trigger this against any client issuing
CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
    independently in ceph_osd_data_pages_init() and the min_t() cap,
    per Viacheslav Dubeyko's review.
---
 net/ceph/osd_client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a67093cf4..7545d3608 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5063,6 +5063,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	struct ceph_osd_request *req;
 	struct page **pages;
 	int ret;
+	const size_t buf_len = PAGE_SIZE;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
 	if (!req)
@@ -5081,7 +5082,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
 	ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
 						 response_data),
-				 pages, PAGE_SIZE, 0, false, true);
+				 pages, buf_len, 0, false, true);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	if (ret)
@@ -5091,7 +5092,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
 		void *p = page_address(pages[0]);
-		void *const end = p + min_t(u32, req->r_ops[0].outdata_len, PAGE_SIZE);
+		void *const end = p + min_t(u32, req->r_ops[0].outdata_len, buf_len);
 
 		ret = decode_watchers(&p, end, watchers, num_watchers);
 	}
-- 
2.53.0


