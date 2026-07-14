Return-Path: <stable+bounces-274210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FaXpAtEkVmrFzwAAu9opvQ
	(envelope-from <stable+bounces-274210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:00:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4E754320
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CRVhmLQX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274210-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274210-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C1C0308BA21
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979463955D8;
	Tue, 14 Jul 2026 11:51:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57938A728
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:51:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029908; cv=none; b=SsoECyJAwc9AmbofQ/qemUWiGFkfZmH1SqZq0EhAVudFtkBDFD6855y+DSSnhobe4Idlpb/P3r+P2BTnBAQYA9a/i3IIgbjSdRGE8ATn0+kFJSVxYballnRcmQCbPH1paXxWTh+4gDXN/C5OFB1mGsvIptr1cW2tAqR016YcvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029908; c=relaxed/simple;
	bh=JpnDZ8ql3IabuVoCGMVqUfzzVcIrlI9D12dRWum7fzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1jC/PYsgkq97ynduVOmdJUqFv5ifxZvATVQEx1CNGCHU2d2z6JTa9cqF0HfDiBehOLEVYQa2wcybHYSZYHCaTcRLZq/QLwaLeki0qyWDwaJEV9gY3op0Q2cOFkzGr/Ccm9l4M1/WS/lNq7BtcAG4ABQyVBf9d14FrZEmwRdeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRVhmLQX; arc=none smtp.client-ip=209.85.222.172
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92ea24a2dbfso315323485a.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029906; x=1784634706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9p/+/UmywR6wfRNM0SB+tDIf7SPmlvrUuoPqzMH3Bt8=;
        b=CRVhmLQXuYhcFRtawFDba1mWcn4TLI7Fvbe9G0vaiskeR7OGKsIbUehmcqtEQgN4lc
         xs6aKQQ7ivcDrDSwcR/OyRfAkJvdmBLGPftqJ+NwhhWfRyzHWGDNCfLaUFHCU8cj3Q/l
         cscvRFLY0Tl3/T1y/huqIlDBtp/HI39b9retGyyQHhYB7tXUdx4XiOHvhs0KqcXuO8CP
         P6IlLNR/dPVkVFYtIRGOHbdug6FtMmdL1vEprxRMktiJT6D0lCRygE11p7LrwU3kVYRU
         WIn28rmJAqZCFsxc6PYI7XMtrbOYwTTGn6IOAP5kxIu8FWEUujEi8tDgMUK73jSWcWD4
         OxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029906; x=1784634706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9p/+/UmywR6wfRNM0SB+tDIf7SPmlvrUuoPqzMH3Bt8=;
        b=VsZgWlEQETjAQgIjSx+3JPJg1z2IZb9weasufU9LckvzMfPOfoTYxOwWoypFTtwaol
         cu5gCGnoFYjP/H/HY+j0JXr9LGapgC7qYIGzIdsQqsh2FVzbnAm3tOYEcy9SVaeiMias
         oWPonpCIEu9XqVs/tQ3Tz+SZLKw4K1gYtIjs0G3z51BeUMzG+Pz+q267LKjqD/2BEIUe
         L6dC981syU+qteAFzNjmpRxVdH9wyBLaJDLQP9dsK4epRtZ1e2ZcpyK6GUYlKax+ds3r
         aEVIljoxtKcrpehAqDVpSrIvfWiuRSytelwY5DAAYjhrZnXqu71MtN2qnJ0dNl9nZyLu
         vSGg==
X-Forwarded-Encrypted: i=1; AHgh+RoCnzWfyVOGrXATNvo9y1FMg/tDUJOprPm7BBqrBFwQ3N9NkIJelMN58L9QSNTwjC4gyxVHiBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbi08R3NCbvacRDPzIXgqtXoTnjyzrwwejSaTaD39bpLSdAYE/
	O/F3jy1on8+0InPdpI2KC1+IbSJnoiWcHBUnSSiECSiyQzrzv2yLJDrc
X-Gm-Gg: AfdE7clJdPd3k2WsmvfG+j1BQHx0lPu9qXTUdIFN2eE3xIPhJH3A2qUUBuUYXyFtXCn
	T4GFryIBsmwGGdTiHZ16lrE8cwMVTouCT+4oEqQZTH/JzXi6qE5q+E2PFICGGTNfoZ+EPO78emO
	ov88EivFFJAKLsFT8a8bGDhqIgOxdoVg1gDxfdCLrk4ic7BOKejaT++Zy/dwz8xVFJh/iAcNseQ
	3Ra50O+ANoA0dv1TCaEKuGk4U+oZunhclSgIthdfxqXvIar5C25nfmG6T623XerQzBBhxx/EpYN
	vkb6nLlmRAxXcm7rJ/EK/zZZv/vqK1ie72kfnxqp3PTJVG0U6QbHvP8dVcZ6Un4NlCD/0rZakpl
	ggmpboiNStwE8qwAH/iKnw50RxH2/EFckoCBQQIrw/izRttPlqFzVi69FRMxvmk8k58AL3G6dtc
	3FCx6GkAe0tg7BEDamrPgF5rz+/lVfRn7t5PATYo/zFelmeh8/NkdAfQCgqLXlQurvNdLDVIDcv
	ZsJn2CA7w==
X-Received: by 2002:a05:620a:2790:b0:92e:c117:9eae with SMTP id af79cd13be357-92ef2e57c99mr1073038685a.92.1784029905785;
        Tue, 14 Jul 2026 04:51:45 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1479415585a.46.2026.07.14.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:51:45 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] libceph: validate OSD extent maps before cursor advance
Date: Tue, 14 Jul 2026 07:51:39 -0400
Message-ID: <20260714115141.3768034-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115141.3768034-1-michael.bommarito@gmail.com>
References: <20260714115141.3768034-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:idryomov@gmail.com,m:slava@dubeyko.com,m:ceph-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274210-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0A4E754320

net/ceph/osd_client.c:osd_sparse_read() validates that the sparse-read
data length matches the summed extent lengths, but it does not validate
that each OSD-supplied extent is monotonic and lies inside the original
request range. A malformed authenticated OSD reply can advertise a
far-forward nonzero extent offset with a matching data length and make
the client advance the message-data cursor beyond the request buffer.
This reaches the BUG_ON(!*length) assertion in ceph_msg_data_next() from
the client receive path.

Impact: A malicious or compromised authenticated Ceph OSD peer can crash
a kernel Ceph client via a malformed sparse-read reply.

Reject sparse extent maps that overflow, move backwards, overlap, or
extend outside the original sparse-read request before advancing the
cursor.

Fixes: f628d7999727 ("libceph: add sparse read support to OSD client")
Cc: stable@vger.kernel.org
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ceph/osd_client.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c1810..76ba3abdad9b1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -6,6 +6,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -5799,6 +5800,31 @@ static inline void convert_extent_map(struct ceph_sparse_read *sr)
 }
 #endif
 
+static bool sparse_extent_map_valid(struct ceph_sparse_read *sr)
+{
+	u64 req_end, pos;
+	int i;
+
+	if (check_add_overflow(sr->sr_req_off, sr->sr_req_len, &req_end))
+		return false;
+
+	pos = sr->sr_req_off;
+	for (i = 0; i < sr->sr_count; i++) {
+		struct ceph_sparse_extent *ext = &sr->sr_extent[i];
+		u64 end;
+
+		if (ext->off < pos)
+			return false;
+		if (check_add_overflow(ext->off, ext->len, &end))
+			return false;
+		if (end > req_end)
+			return false;
+		pos = end;
+	}
+
+	return true;
+}
+
 static int osd_sparse_read(struct ceph_connection *con,
 			   struct ceph_msg_data_cursor *cursor,
 			   char **pbuf)
@@ -5856,6 +5882,10 @@ static int osd_sparse_read(struct ceph_connection *con,
 	case CEPH_SPARSE_READ_DATA_PRE:
 		/* Convert sr_datalen to host-endian */
 		sr->sr_datalen = le32_to_cpu((__force __le32)sr->sr_datalen);
+		if (!sparse_extent_map_valid(sr)) {
+			pr_warn_ratelimited("invalid sparse extent map\n");
+			return -EREMOTEIO;
+		}
 		for (i = 0; i < count; i++)
 			len += sr->sr_extent[i].len;
 		if (sr->sr_datalen != len) {
-- 
2.53.0


