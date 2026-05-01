Return-Path: <stable+bounces-242295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEPLBIWI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:03:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0914ABD96
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57F9B3008D2F
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36E39B4AE;
	Fri,  1 May 2026 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARtVswET"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CD18DB01
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633354; cv=none; b=BRo0AfL5t3lqS8YNm82nJGXCh2w2ZBffdVFLp5IrxFrgQszmQzYNcI8/alwZBUp9pLSNhWbFSrv7yg2n4iEh/nDYkm6uSCiZNQ7VvU+4qj9/e4gKwdu4AnhMrGrbqecJ4lw1x2Kfs9JfJ1QwhiHWDOO1HVbgN+L8N6cPul7swqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633354; c=relaxed/simple;
	bh=BMlgiKuNUB87uCclPwjrQJNkQdhuSRNK/Uz+046IXJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIOMSc/E5yOoK377SXjeUrByXsO5l0JvN0oeMMThXJuoJ7F0NASBpiDFOg8y+1LzxqNWkZyyRx3rRlylGrkHbX/nJ92JBpu9TCO2ipo+VYLfGSG2b+tdg1RYFhp5rfj+gtktI1El8U8SdVuRny+Rndl5ZQpdTiUwKeOD7C7nLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARtVswET; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso21067275e9.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633352; x=1778238152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSMUlgDj9Yg4wJLFghvuChRmTRTTzjZGS4h4LzcAju4=;
        b=ARtVswETxobMFA8V/Js2/1mg/4fG0VlM9sMCl6g7XRtwRTHNF/7uP+3jweLtwCja4Z
         /WDfiVSQLMS7DGsJ2L9hDJcmiaaInCBa/DNQoH04bRelGVmN2JLz1pFs/NATUvShOyYt
         /iYupK8O+EFikkC/zvwMsVc3HgDfZOzmJE/gNNVmKh8WQ176W9I/Tei6zWl1D5aXGda5
         yJj4fpLfkZRVQ2hxlz+JGVeIkcltnnc0VK/vdie94PvdvgXJdMe1QZjCRqVgL29fbF98
         DR6ghWMBk6nGgam6E/J4nFEz+O97XgRZYOIsJ7cQIMo1lgwfQqHuVSnQKcI+YB4Qt1ka
         Nkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633352; x=1778238152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSMUlgDj9Yg4wJLFghvuChRmTRTTzjZGS4h4LzcAju4=;
        b=qyFLxhXqtSZVAcEHP0rVxz0vAVvNiIM6yAa+c2h3iEQPWZ7CSyzozIqgYJQAJ6SL0R
         c0ETy6JTHDPkhq9N0cY5152U59XemuUoaxj4s2u8HOTPWYud0kiSSzaBzbmfUs2JhV0m
         GreA/37vnsDAHKw3Vfar8HKBbUKqgGKpmQTUjiV5fsnPpdPyBmbXlwjOzw020XJwFOku
         PwVORb8+nA0+gwy+Cjdka1wQFWgmguG3I0lHCzl5w9gIyPFqCVrUcEkymTODvqyDbo0M
         TQTYxDe9j93pkn4B2SNHw+d2H/W/FLaxW8itvbZIxS+hQ+n8fcMs2pfKCIwGnUNJgn5h
         My1A==
X-Forwarded-Encrypted: i=1; AFNElJ+qS6oaDn5tR814ty+YkO9YzfVru2tIOrGRjKiiqrwOHNSaxYcSPi3Lhtp2+XoWXojb98reXWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IK/+8qVbRwfO09QftGPU02hdyF/eCGQ9aKjRWFbYMBqIyXZD
	5lZdIP3OJjuLw2Zyii1XfzuQkSnZATR6/oSjGj8wRnq022IdqQRFZUs=
X-Gm-Gg: AeBDievE2/aYNYUmgxqqcLkf3CkxyeFlYhes/Kyelz1+I4zVQzflgHb2U/+1yzD7Hr0
	K958pn2iToyRIAbv/q5cf2hFWvph60XbN0ZTD4kzZVJi+VC6gp4TMv4SxjKeEH41zEUcfn6iWEN
	y5DlOICTOORtzXar4vI8oIeFPLfCqkijoApOzDj2S9e3CMSomuTB346FQdSw100oifveN5fj2bC
	tKr1/M4qjztdqP8OHxgSpQiEdxB4/oDeDFleJk4hJvw7Y7Je5EtMUkiHi1be4Gx6KYILwK1Q40i
	QQCD3cHlvjeLClC4tYC4x6lGcsCbQ+jAI0Wq3wMKn35ezSg/TCTIljaw1RDHO5H1ZhByjGPUPLT
	hMSmkQR7AET/FufG49aE8PMfdaIbLrMUrsTamXeBlyfgpiCaNZLe0LtUey8dUG6Z33dBX1mW6ga
	mV9fI=
X-Received: by 2002:a05:600c:c4b7:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-48a8447b30bmr105729195e9.20.1777633351503;
        Fri, 01 May 2026 04:02:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aa70dsm4457999f8f.25.2026.05.01.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:30 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com
Subject: [PATCH] jfs: validate lv bounds in diWrite to prevent slab-out-of-bounds
Date: Fri,  1 May 2026 11:02:30 +0000
Message-ID: <20260501110230.38407-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E0914ABD96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242295-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,aa6df9d3b383bf5f047f];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,talencesecurity.com:email]

From: Tristan Madani <tristan@talencesecurity.com>

diWrite() copies btree root data from the in-memory inode to the
on-disk dinode using lv->offset and lv->length from the transaction
lock without bounds checking.  When a corrupted JFS filesystem image
provides inconsistent dtree or xtree metadata, the transaction log
entries can reference slots beyond the root node boundaries
(DTROOTMAXSLOT or XTROOTMAXSLOT), causing a slab-out-of-bounds write
in the subsequent memcpy.

For example, with a crafted directory inode where the dtree metadata
produces lv->offset + lv->length > DTROOTMAXSLOT (9), the memcpy in
the dtree copy loop writes 32 bytes past the dinode boundary into
adjacent slab memory.

Add bounds validation before each memcpy in both the xtree and dtree
copy loops to ensure lv->offset + lv->length does not exceed
XTROOTMAXSLOT (18) or DTROOTMAXSLOT (9) respectively.

Reported-by: syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa6df9d3b383bf5f047f
Tested-by: syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/jfs/jfs_imap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index b84ba4d7dfb44..70d6a33597273 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -726,6 +726,11 @@ int diWrite(tid_t tid, struct inode *ip)
 		xp = &dp->di_xtroot;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
+			if (lv->offset + lv->length > XTROOTMAXSLOT) {
+				jfs_err("diWrite: xtree lv out of bounds");
+				release_metapage(mp);
+				return -EIO;
+			}
 			memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
 			       lv->length << L2XTSLOTSIZE);
 		}
@@ -750,6 +755,11 @@ int diWrite(tid_t tid, struct inode *ip)
 		xp = (dtpage_t *) & dp->di_dtroot;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
+			if (lv->offset + lv->length > DTROOTMAXSLOT) {
+				jfs_err("diWrite: dtree lv out of bounds");
+				release_metapage(mp);
+				return -EIO;
+			}
 			memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
 			       lv->length << L2DTSLOTSIZE);
 		}
-- 
2.47.3


