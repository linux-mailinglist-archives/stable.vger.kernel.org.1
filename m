Return-Path: <stable+bounces-249359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD5CA7NaC2oCGAUAu9opvQ
	(envelope-from <stable+bounces-249359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:30:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4F572459
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C804730283FA
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB3387363;
	Mon, 18 May 2026 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEOOYRjr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416D18C933
	for <stable@vger.kernel.org>; Mon, 18 May 2026 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128772; cv=none; b=nvsy4tmTwDqbmSb8Z6S5BRTnIrUyyvNBfa8uMYn4kdgglnzEQrGEiZTaRi85ip5tLMeEnYp7sAZ4gMZX214kEZ25UGiHmd9oPlLjs4LqrgWAhVjpZxLnUxebVytXrbwLg8BNN7d21Ly98BIU7Yh6Ql7LK23ECMLyf/gwdU5cYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128772; c=relaxed/simple;
	bh=AJQ8X8vekQbsX2A2arXJ8CBDC1jAwqSdrm7rYzzgrNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMjBauIcE8WjsK9g5cfFR1A3XMkhQtRupDNov1JHilh1/ulHXK2QD+EixRrkgVng7fEmp7c/jYhc4H6o6DBwcg5gxdYVdZgzpbfgqOcP+P7ItvttlupSAfXPV8kjKwurFsSjJel9RJcihkIpboE2yvgGuOFdDNKnck/QTOWEw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEOOYRjr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso4624570a12.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128767; x=1779733567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjppO2+PwKNhaclh25OQ0CMNeNNbO/jvr0ag7TFBQ9k=;
        b=GEOOYRjr7jabRzKpTfVGB0uROawVxK9+gZC7t6JzLZuza8bI8fA5GU8No9N5/RJD4q
         /nYGbgo2h5IBgIRtLW7/+0KGvVAmcSPNAp4MC9y840M2z6OfodXPqgs3yzflzxjcOVbm
         O6dt8LJQLosfx+DPnFjPEc4iw70Rjuo93T+B2IaCFFoak8Ccs17MGNtHvC4sDZ2Jvbaz
         PCuJdzzLKpCwByYP6F+9CwTmfsh7bGEnxviW2j8E3GZhiRaKjnFYaRlHAh/s+G4Bsy39
         QXYiUT5qrmafgcv1hdLCmmXP121m3c+d9MH17sCgnpLDZj+23cApWZjF5eLktsqNFjJO
         MwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128767; x=1779733567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjppO2+PwKNhaclh25OQ0CMNeNNbO/jvr0ag7TFBQ9k=;
        b=EQPxKuima+q1fG+r3KP2wTV3mPwli8D7esTlvLErJf+oiIZIpXOMhYwAwCI/a6zZPj
         faJ3Lehuhy2bmxNXbD8lT+Z7PL4/GNr2AXqKf67Funl07aPFMlqnoWpR4bjKtZtLCwWS
         zZmDQuNUDbczv1bauonMxm20rrJ8LsQNDVJcj3O+Wd04SPVrKe5YaAqMECvorNMbEFKl
         oMfzXJpBCxA7zbeHcsA3OQJu9zvbOwITvJiohN58rWIRJhN3mNjzgkVwYHb/kBHD42P4
         YPhbg6cmITCIKZBIO5GoX2B3vIv9RnH9B1bxfhFnuMDg0YQS3zpEtGF98YGd6c4YgOrH
         OwEA==
X-Forwarded-Encrypted: i=1; AFNElJ8aMejnAaPqOhWfsnWqYygp0yLSRbWgQ9epg96MtEUOkFx+uMjCPW680ykIvo2Fi5Cc8JN+0SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyemLJl3kVvbZp365eGc14TGDlXvyTzGLwpc2DvWb+dfdoc2MUA
	u2F6IYlQnNWwR5YK8K+z4DXCLUjvEmrGhlC6VH1kAzFjcPT2o1Nzra9xBk++VWVGXqosFA==
X-Gm-Gg: Acq92OGg1obozvT/cbExuZLpI1f7a1pWxjqw5v/GrmFkWHUJDFUsOldOOJbljy7b8D9
	a37/I2vLCnPSw8//+QuKuB0AB+eBOjeXVMumiWCHyZttck4zrX2FbpxbFNZ8B0FkC+var0643/T
	Yyjr230FeqWb5V6PnnLOeeDLHpB4lr5NzJbLxIgnBUqiFGg0Tcxm0PoGxgCqpPX3Dp5lzB3i/4x
	ilzx5XzEM7qGSITDaw4TognmTLm6iB8k03ogJG0WUn0eqtEyK374woHFfsD8k0+D5qhvcO2D7kb
	zG1mOSPN103R9egqHJIssn0q4ywDt0zQBmQ9f5T7cjjbGT0G7a6v6ddW1XMurAXsIwb/Wb8li0d
	eB3eXaGsYJjVG3/HUOesJrnGLFLJon8cOxMd0Os0eEOPkf/tqyqk2PbF7dUhFAiSRxqCgkjTXb5
	ME0J4Pe1rrT+cAffaN
X-Received: by 2002:aa7:c652:0:b0:681:5b68:b26d with SMTP id 4fb4d7f45d1cf-683bc4b5ae7mr5810099a12.6.1779128767128;
        Mon, 18 May 2026 11:26:07 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b3e973sm5691646a12.3.2026.05.18.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:26:05 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.18.y] fuse: avoid 0x10 fault in fuse_readahead when max_pages == 0
Date: Mon, 18 May 2026 11:26:02 -0700
Message-ID: <20260518182602.3107764-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249359-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,debian.org,toxicpanda.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladwing@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 02F4F572459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When fc->max_read is smaller than PAGE_SIZE (common on aarch64 with
64K base pages if the FUSE server advertises a small max_read in INIT),
max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE) is 0, so
cur_pages is 0 on every outer iteration.

fuse_io_alloc(NULL, 0) then calls fuse_folios_alloc(0, ...), which
calls kzalloc(0, ...) and gets back ZERO_SIZE_PTR == (void *)16.
The "if (!ia->ap.folios)" guard in fuse_io_alloc does not catch
ZERO_SIZE_PTR, so fuse_io_alloc happily returns an ia whose
ap.folios is 0x10.

The inner "while (pages < cur_pages)" loop runs zero times, then
fuse_send_readpages(ia, ...) dereferences ap->folios[0] in
folio_pos(), faulting at virtual address 0x10:

  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000010
   fuse_readahead+0x14c/0x490
   read_pages+0x80/0x318
   page_cache_ra_unbounded+0x1c0/0x2b0
   page_cache_ra_order+0xb8/0x368
   page_cache_sync_ra+0x210/0x320
   filemap_get_pages+0x290/0xdb0
   generic_file_read_iter+0xd0/0x540
   fuse_file_read_iter+0x8c/0x158
   __arm64_sys_read+0x1a0/0x488

addr2line on the aarch64 vmlinux maps fuse_readahead+0x14c to
fs/fuse/file.c:897 inlined into :999, i.e. "folio_pos(ap->folios[0])"
inside fuse_send_readpages.  The faulting instruction "ldr x8, [x8]"
loads ap->folios[0]; ap->folios was previously loaded as 0x10
(ZERO_SIZE_PTR).

Without this fix the function would also spin forever, since
"nr_pages -= pages" makes no progress when pages stays 0; in practice
the NULL deref masks the spin.

Bail out of the outer loop if cur_pages is 0 -- there is no work we
can issue via FUSE in this iteration, and remaining folios will be
handled by read_pages() falling back to ->read_folio.

Note: this code was rewritten in mainline by commit 4ea907108a5c
("fuse: use iomap for readahead"), which switched fuse_readahead to
iomap and removed the buggy loop entirely.  This patch therefore
applies only to stable branches that still carry the pre-iomap
readahead path.

Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
Reported-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 fs/fuse/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6014d588845c..782178124512 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -974,6 +974,16 @@ static void fuse_readahead(struct readahead_control *rac)
 		unsigned cur_pages = min(max_pages, nr_pages);
 		unsigned int pages = 0;
 
+		/*
+		 * If max_pages == 0 (e.g. fc->max_read < PAGE_SIZE on a
+		 * 64K-page kernel), cur_pages is 0 and we cannot make
+		 * progress.  Bailing here avoids passing 0 to fuse_io_alloc,
+		 * which would return an ia whose ap.folios is ZERO_SIZE_PTR
+		 * (0x10) -- later dereferenced by fuse_send_readpages.
+		 */
+		if (!cur_pages)
+			break;
+
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
 			/*
-- 
2.53.0-Meta


