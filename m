Return-Path: <stable+bounces-226951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLeVOBIQumk2RAIAu9opvQ
	(envelope-from <stable+bounces-226951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 03:38:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E2A2B53C0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 03:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46D5C304B83F
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B14274B39;
	Wed, 18 Mar 2026 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uaw8Yzqb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31326FD97
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801481; cv=none; b=EewcLX08CLOOr4BVOeDfiVKe5WdBQsMjBg3XVaehali/QcEDL+hblAdraSkebZfkD3owSsHh8+TDNkZaXYgakU7z2ht21SmsQbQ1yPzawTzsKlOIqdmnnHIl7rjz2TncG2lWVd5VV7SuBUtafqHjm2BrlbYC5ILAUWUR2/A57dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801481; c=relaxed/simple;
	bh=n0w6e/nOGgYAcidng5lDiAq12GtXKpGxxsbG7TpMjxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3nmIS3t1YqHSXMGUNaMk9Pa8WtgVAIzmXjjTGg8+tiUty1SrZ/JNWMn8hPCi31nXzSrHk/LG54NsabVmD2CGPELAt6KdbteZA1VsMRzjVygh2Eh+TbBdcUPVgp4oMXUhu5OZLvvMKQG5uDzTAK0D5Krk6Nd0wA4wFBue8n1Q4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uaw8Yzqb; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d741f61ee5so5436164a34.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 19:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773801479; x=1774406279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHBZTmx3gpGoOcOvI5wr45XrMLqrJh4cbl+ScbRtWNE=;
        b=Uaw8YzqbmszcT7KbRQpAqaawKS3M3JDNRi5ZGai01YXZf8xpha/3Ugs84HZu7NJSI2
         KakJ6579ALRu2QoRmdeqkVh8QHqDWG2++ZZxr9vph7qOkVz3I2ysGw20F/qEgcYRK24T
         iS+oSZuW5IYr/CFd9LKEAxh+qHk8nu7dEA7X++MXEFNyeUZUJ0iASz/KyXicEwjaMOJs
         Lvtgmp/fAJq6JOMjTtgEHrOfYrB/P4nbuCzDfzzOZupVn9vYijtc20U1WuEjL0QEh4ph
         tvGu5Io/9HUb9ZlMcE3PxBnVwUefpY0+aKEBEwe9BkdfuwGheK3ZMBuxzAtAIQrUVfiD
         Wn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773801479; x=1774406279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHBZTmx3gpGoOcOvI5wr45XrMLqrJh4cbl+ScbRtWNE=;
        b=rO0S02pufj+5tKNc86Ei8RBPVqrbjQqKMjQGvT688MEGIeJZVSSrOiHJXaPBV8IqLY
         wDx7c6A9XdrGBXanN3uVmevXMJPuHfFbAHpHvTtQt+WaFTbLxi7p0AKcoxXkIpq+vfqJ
         d/K7CI/+OKOgOXDuScof77oZ+LYE0vnAYOEuStrIVgHIZg1Ax9PZ0EZRMRAPfqGuHYwG
         1mv8Ci00VUng3KYElTliyANGqNRzCNIejD9i4mOwP/m/T4UHVTeCQEFjHY1ufVqMv3RQ
         WAlqYTdMGBs6ZxBPAB67jh5nESiOrD49jqAI2PYi8uQL5xQfssKhVmABUOb102tSVNJs
         KUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQhX2i0jm+vbMS9Oif191fBatEz9CTYW50+/M0UERzu4u5T8XP/aVVJSPvB5Zk/a0Cq11bl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04EDeykHPwpHDdHTkgjftvdLwNGcCtvazYlQsfZwDMG9Zm2sF
	/MIgpcUNbZraXZ2vjxe6PiUaJPNBl7dy9QdRcYTIgxeBrfiO90yrwhEA
X-Gm-Gg: ATEYQzyW2vgEQbNx6iu0chpjGAE4l6Qes/8azjiy7j95Ro9oRb5Pw369l2UGIPv5vH3
	aBAuwSYs/iCHljZuAmHlLpHT5HtPHXB6YvWnZ+mJrdyh3Mavqjn2OnjLMaNgpehUviaNHSVhAJl
	N7iij1n1c/wwoy1rkgteL1/mIxvDfUQhb0aXCqRmNioEaiaEvNKsdDTdv990fQKKt47Yz3YbRSC
	TPBzVju6CD3IwOYgbzZ4BmIPXads8gpMxOybuwXVNz4BC8j+CSIcqvikfJGE9zHfq4ZJjzx+9Hl
	iAjIqLz8VWT2N519wIKnA3kw0N2pvc61g/97BRQLvXi4Iowb06sIBGXcHLsiYeX+UaseCUFxWzI
	py4DQXHFXxitkAtxM2VieTHV5igjspLK0WlYoCcHvX3VlzPH4cX3oLuUZJ1OLjospbEqnR9vVn+
	tqgA93mugdx/Ydrvd7bDMm0cdgNO1pPkJmANOqa/FRZuwdncXsVjgfR+W9iua4xdgp+Ig2NWXW
X-Received: by 2002:a05:6820:2d43:b0:67b:c368:136b with SMTP id 006d021491bc7-67c0da8c338mr1059481eaf.29.1773801478708;
        Tue, 17 Mar 2026 19:37:58 -0700 (PDT)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d88c5bbsm880101eaf.10.2026.03.17.19.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 19:37:58 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Milind Changire <mchangir@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when crypto allocation fails
Date: Tue, 17 Mar 2026 19:37:33 -0700
Message-ID: <20260318023733.116789-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226951-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 64E2A2B53C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

move_dirty_folio_in_page_array() may fail if the file is encrypted, the
dirty folio is not the first in the batch, and it fails to allocate a
bounce buffer to hold the ciphertext. When that happens,
ceph_process_folio_batch() simply redirties the folio and flushes the
current batch -- it can retry that folio in a future batch.

However, if this failed folio is not contiguous with the last folio that
did make it into the batch, then ceph_process_folio_batch() has already
incremented `ceph_wbc->num_ops`; because it doesn't follow through and
add the discontiguous folio to the array, ceph_submit_write() -- which
expects that `ceph_wbc->num_ops` accurately reflects the number of
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);

This issue can be reproduced on affected kernels by writing to
fscrypt-enabled CephFS file(s) with a 4KiB-written/4KiB-skipped/repeat
pattern (total filesize should not matter) and gradually increasing the
system's memory pressure until a bounce buffer allocation fails.

Fix this crash by decrementing `ceph_wbc->num_ops` back to the correct
value when move_dirty_folio_in_page_array() fails, but the folio already
started counting a new (i.e. still-empty) extent.

The defect corrected by this patch has existed since 2022 (see first
`Fixes:`), but another bug blocked multi-folio encrypted writeback until
recently (see second `Fixes:`). The second commit made it into 6.18.16,
6.19.6, and 7.0-rc1, unmasking the panic in those versions. This patch
therefore fixes a regression (panic) introduced by cac190c7674f.

Cc: stable@vger.kernel.org # v6.18+
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Fixes: cac190c7674f ("ceph: fix write storm on fscrypted files")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---

Changes v1->v2:
- Added a paragraph to the commit log briefly explaining the I/O pattern to
  reproduce the issue (thanks Slava)

- Additionally Cc'd regressions@lists.linux.dev as required when handling
  regressions

Feedback not addressed:
- "Commit message should link to the mentioned BUG_ON line in a source listing"
    (link would not really help anyone, and the line is a moving target anyway)

- "Commit message should indicate that ceph_wbc->num_ops is passed to
   ceph_osdc_new_request() to explain why ceph_wbc->num_ops == req->r_num_ops"
    (ceph_wbc->num_ops is easy enough to search; and the cause->effect of the
     BUG_ON() is secondary to the central point that ceph_process_folio_batch()
     is responsible for ensuring ceph_wbc->num_ops is correct before returning)

- "An issue should be filed in the Ceph Redmine, linked via Closes:"
    (thanks Ilya for clarifying this is unnecessary)

---
 fs/ceph/addr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee8..f366e159ffa6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1366,6 +1366,10 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			/* Did we just begin a new contiguous op? Nevermind! */
+			if (ceph_wbc->len == 0)
+				ceph_wbc->num_ops--;
+
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.52.0


