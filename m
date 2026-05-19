Return-Path: <stable+bounces-249561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOgdHORMDGrjdQUAu9opvQ
	(envelope-from <stable+bounces-249561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:43:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B237757DE1E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2286E30118D2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52035201C;
	Tue, 19 May 2026 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6aZw9Ch"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF55332612
	for <stable@vger.kernel.org>; Tue, 19 May 2026 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190253; cv=none; b=sG7Gv6bfQtflm/oIvNbSQM11rxZq7f7M+S7whPHQzvTzVM+RxMaHPSUX6ym3DyOC01GEHvBwuWMS45qsBwuFOUAdgI4xMucpd6v9pMSKo+DNjF4sDyuQyaUrRV/HC60U4+o4CQhEPvELayZKWfZVzLfulL5zr7iMsFes+IxRDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190253; c=relaxed/simple;
	bh=2zdbSDYo2a4iqVuU9shfVMNQnc3dcNJq5nqcEPmoTd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNYCkNXo1Y5opcl1Mhm0YFSPisRQvmzLloBMbl0QCm9NdmtYFrtmuwckAyFrOk4PoS+JZacVs4O9R8rwMoridgbMIYrZXst5OZ9yVuY/auJz/1Wqaq+MrQFCZiz7SthzcN2D2e6h9g8TjK/cuL7AIlS+km/L1EaKmk9KsMnCOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6aZw9Ch; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-911dfc86903so410451885a.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779190250; x=1779795050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdnoiIWTikhhiv4xZc+nEe/cpMOrkcgd3lQkjWYtbHs=;
        b=g6aZw9Ch4UtPKi/LjUypQDlcdjIICFxfAqt097JPkHwgKCXWPdXcxnN0avWS9KaTrd
         6YsvdHohDfWHegvxnhSwgPPKSENz0EZyWeWDgB7WoB5XpQ80lyi4yj5c6lYw2ecNba2c
         nZUcfjQmsNNWZkPAc8sHk/OEyo9ELKCYJ/n9SO7B0d+6gtdwyshm9RtgQ2dXsP8rqbiL
         qJaZN1GdXR30aK3aJ1eAWpOsXgzC5WlNXrq1IkuKM28yTowBl2q5JnNh+hFrHF2X2PWw
         NFY6MRjifIbqA51nFbyTNy7JOjA6jC3uH972SuYYy8Rijjizrg2+9Gj7gQYJy2vx3p8r
         vrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779190250; x=1779795050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdnoiIWTikhhiv4xZc+nEe/cpMOrkcgd3lQkjWYtbHs=;
        b=BuahfgTHouaDUyOey2+jsfIT+LT0VWgGg3LMxRoq+el0+y0aVFpnOiOUViPZZoplmP
         ijrIDMroxJfHTklRQj6QdzbGfLXgxfY/pLTEvAMjAORebfDekIrq/eV4/aw1PbhDO7CZ
         kAj5Z+QR0DrLKJow1lwBAjp/HYhYBfrCn2p6C3g8B+MBkn6wxZ8kX5yAj88e9JvOPOmO
         RwJ/foVmzuPuBvZhI6Ccg6KndOBYqdnR0q+kL2dEbHoYebH4VrBJFPF7+REtAes9Y4nh
         clsudIyX8gH9XO+hQAGCW5dm0VYJ1XJ2ZRHRsnnPHPQloXvTum3CHxDRNCvv/Yj2Yx89
         +RbA==
X-Forwarded-Encrypted: i=1; AFNElJ8U6rD8o9hjoXnS+a5Ye0LDseBVvDQpS5LaTu2xQEKF3zRBfd07SzoRAJLSiqvRkVejWpOek3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBIByaB9zyROifMkwcOaDpX/pkgrGFRrPiDbxe9Klxg/2dRgU
	vrkLJRkHyGT0XtyO+Nzggl1ZUaCsv7dOwHa8mRHdaftta1+jkqpQD8d3
X-Gm-Gg: Acq92OGOULgI1CdDuloL7F+MbTSCxoDEElFmu7pd6itKkdehZ5oXyCHDIs+ZrboDhFz
	mNTSyugLc/BrjfbWyu2XQLrUxhRUyMmZfO/YGc35QEHmOqWdIy3ysGIi9/+igUlFqaV2NKnKqBP
	gruWrNMJFuL9xKKIpbBpoCO6Klyv+0E5s9CPiaPhR9oMcVcvXpHIZmAN+1Kcj9X9wlJEI93sziX
	CbxCmkBvgt1/YxpTPV4bQwRkS5LqzpxCBdqrP43FHP4PRHI0MLKJrDCPcdhcnWSGsIqGCl1DBkg
	e8FvpTDI+P6mXGmQ68vdcl2uLRfEt9WAJXkesmrHgzSb94Zt7YhCjHbKJEYEoTe/4q/c2Ga49VO
	uGjbXIZnC4E313HtlFc/HygypRoiqZiLxv2CEarS8kVAzdBbsslPk7whh4CP33N9YJEjAfRwdYR
	2+Drb/21mjHXtuJN+1KPN9G2Gn11MneZQfmnFP3LgcVw8T4ibhMZDNuMwM4U0zsuodkKy4C81uF
	6sWGmCbpymwX4Siw2oI
X-Received: by 2002:a05:620a:4406:b0:8ef:ed0b:c235 with SMTP id af79cd13be357-911d087dccamr2744259685a.56.1779190236546;
        Tue, 19 May 2026 04:30:36 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37762sm1880795585a.36.2026.05.19.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:30:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ceph: bound num_split_inos and num_split_realms in ceph_handle_snap()
Date: Tue, 19 May 2026 07:30:17 -0400
Message-ID: <20260519113017.1851462-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249561-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B237757DE1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A peer that can deliver a CEPH_MSG_CLIENT_SNAP to the kernel CephFS
client (a compromised or malicious MDS, or an attacker who has
forged/replayed a cephx session on the cluster network) can cause an
out-of-bounds slab read in ceph_update_snap_trace() by sending
num_split_inos or num_split_realms as a small negative __le32.
ceph_handle_snap() parses both counts into signed int and then
advances the decode pointer with `p += sizeof(u64) * num_split_inos`;
the multiplication is in size_t, so the signed operand is widened
modulo 2**64 and a wire value like -32 produces an attacker-chosen
byte offset that walks p backwards into the slab. The subsequent
ceph_decode_need(&p, e, sizeof(*ri), bad) passes (end - p is huge),
ri = p, and the next 4-byte read inside ceph_update_snap_trace() is
performed from attacker-positioned memory. The same arithmetic and
the same pointer hand-off exist in the non-split branch.

Promote num_split_inos and num_split_realms to u32 to match the
on-wire __le32 fields, compute each array's byte length with
array_size() so a size_t overflow saturates to SIZE_MAX instead of
wrapping, sum the two lengths with check_add_overflow(), and verify
the total against the remaining front-buffer length before any
pointer bump. Re-use the validated byte counts for the bumps in both
the split and non-split branches.

The MDS is an authenticated peer under cephx, but the kernel client
is still expected to validate metadata it accepts over the wire;
this hardens the input-validation boundary that snap-message decode
crosses.

Fixes: 963b61eb041e8 ("ceph: snapshot management")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduced on x86_64 QEMU/KVM, KASAN_INLINE generic, two ways:

  - In-tree harness that allocates an upstream struct ceph_msg via
    ceph_msg_new(), writes num_split_inos = (u32)-32,
    num_split_realms = 0, op = CEPH_SNAP_OP_UPDATE into the front
    buffer, and calls ceph_handle_snap(&mdsc, &session, msg)
    directly.

  - End-to-end over a real TCP connection from a real ceph-mds
    daemon to the kernel CephFS client, with num_split_inos
    rewritten to (u32)-32 in the front buffer and the messenger
    v1 footer.front_crc recomputed so the kernel libceph receive
    path accepts the message. The KASAN report fires from the
    tcp_recvmsg softirq path through ceph_handle_snap+0x345 into
    ceph_update_snap_trace+0x23bf, confirming the bug is reached
    via the normal MDS->client receive path and not only by
    direct harness invocation.

A stock v7.1-rc3 kernel produces:

  BUG: KASAN: slab-out-of-bounds in ceph_update_snap_trace+0x23bf/0x31a0
  Read of size 4 at addr ffff8880012be1f8 by task init/1
    ceph_update_snap_trace+0x23bf/0x31a0
    ? ceph_handle_snap+0x312/0x900
    ceph_handle_snap+0x345/0x900
  The buggy address is located 248 bytes to the right of
   allocated 256-byte region [ffff8880012be000, ffff8880012be100)

With this patch applied, the same trigger (both via the harness
and via the wire path) hits the new validator's goto bad path,
logs "corrupt snap message from mds0", calls ceph_msg_dump(), and
returns cleanly with no KASAN report. Harness and wire-injection
scripts available on request.

The kernel ships no fs/ceph selftests and no ceph KUnit module that
exercises ceph_handle_snap, so no in-tree selftest delta to report.

fs/ceph/snap.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 52b4c2684f922..7c4487eb2708a 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1027,9 +1027,10 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *e = p + msg->front.iov_len;
 	struct ceph_mds_snap_head *h;
-	int num_split_inos, num_split_realms;
+	u32 num_split_inos, num_split_realms;
 	__le64 *split_inos = NULL, *split_realms = NULL;
-	int i;
+	size_t split_inos_bytes, split_realms_bytes, split_bytes;
+	u32 i;
 	int locked_rwsem = 0;
 	bool close_sessions = false;

@@ -1048,6 +1049,24 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	trace_len = le32_to_cpu(h->trace_len);
 	p += sizeof(*h);

+	/*
+	 * Validate that the two MDS-supplied counts cannot wrap when
+	 * multiplied by sizeof(u64), and that the two arrays together
+	 * fit in the remaining front buffer before any of the pointer
+	 * bumps below.  Without this, a malformed (or malicious) snap
+	 * message can cause 'p += sizeof(u64) * num_split_inos' to land
+	 * at an attacker-chosen offset via the size_t * int widening,
+	 * bypassing ceph_decode_need() and making the subsequent
+	 * 'ri = p; ri->created' read out of bounds.
+	 */
+	split_inos_bytes   = array_size(num_split_inos,   sizeof(u64));
+	split_realms_bytes = array_size(num_split_realms, sizeof(u64));
+	if (split_inos_bytes == SIZE_MAX || split_realms_bytes == SIZE_MAX ||
+	    check_add_overflow(split_inos_bytes, split_realms_bytes,
+			       &split_bytes) ||
+	    (size_t)(e - p) < split_bytes)
+		goto bad;
+
 	doutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
 	      ceph_snap_op_name(op), split, trace_len);

@@ -1064,9 +1083,9 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * child.
 		 */
 		split_inos = p;
-		p += sizeof(u64) * num_split_inos;
+		p += split_inos_bytes;
 		split_realms = p;
-		p += sizeof(u64) * num_split_realms;
+		p += split_realms_bytes;
 		ceph_decode_need(&p, e, sizeof(*ri), bad);
 		/* we will peek at realm info here, but will _not_
 		 * advance p, as the realm update will occur below in
@@ -1144,8 +1163,8 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * positioned at the start of realm info, as expected by
 		 * ceph_update_snap_trace().
 		 */
-		p += sizeof(u64) * num_split_inos;
-		p += sizeof(u64) * num_split_realms;
+		p += split_inos_bytes;
+		p += split_realms_bytes;
 	}

 	/*
--
2.53.0


