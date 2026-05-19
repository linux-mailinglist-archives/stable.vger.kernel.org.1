Return-Path: <stable+bounces-249655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IPIHHyiDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:48:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9715834B2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5083E3010C07
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411A48A2DD;
	Tue, 19 May 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp5hW1Zy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7C3CF94E
	for <stable@vger.kernel.org>; Tue, 19 May 2026 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212910; cv=none; b=ENdS2+PDdAoWlM/BKhMMNeU5V+2FxhCX5OGLbJBmD1rl9IoQtkiTqmmglpnTniCxQ8tWDtMUAhvgdL2mmE+HYZtbQ4843C8Wh0Uo/p0S8zTDGV/62396haMZQ0MmJMJ/brTMwtr9xl9G/zre76aOpUuTncr3/bvskTg53y3WnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212910; c=relaxed/simple;
	bh=JKne1dBLa7FzCCy78inKoxP0nBg3Ro/HwFau2hSNvE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBKEuA2jIqfZ+a1FYh16TtNl2oTamniqo1/m5if+EIZaN6+FQudVnLJzsR/qs/dPDOspUX69hdsZF1yvrN2AtATYcDipduApUOI1g3znvAWPmF69ihuu86PD+7l3NWBUxClA/FJ/CCKeDOcjZceYRjvbLXlJ7dLo4pP38iM2FM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp5hW1Zy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so790193666b.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779212905; x=1779817705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuqPpYNItKvbmM3JkB0XkVVRp2zvwe7MMuOyTFq6M7E=;
        b=Wp5hW1ZynbDrZG2MBIyp0Ko/z1z6LLw9LnYoNYqXztpJ9vUagKjKCo6KmWECVNq+Ro
         d4dQ8zgAjGyeJq1MfxT50ZaChKivAmWts6x7MW9jQ2SB6ZdO9Ieg1xK7q//KsFQzo5vq
         Nq7LxscVP7DuBrY+08ZS3SzRW0yjub2T7yUpGiJPWfwDnNWQPCYNj8gCOO4zCseaDv0u
         cYEZjjacROdO98zmLS0sSIeuLqLE10rubE6oJn/eUQ6KP13b6LejlAajCQnPVzlap1t+
         wWzV0g6KP6NDxPRua1O4VsA2jn2hBssfw7kQWCEvO24M71JhfvE5RB7sRiR05A/hF80z
         321g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779212905; x=1779817705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AuqPpYNItKvbmM3JkB0XkVVRp2zvwe7MMuOyTFq6M7E=;
        b=XwDEuIHbuPQicqLotYdZFzDzfk3qn3UnDtFr7XC6mbhLChqR6sz9NzNl5UBIQG8d6D
         8Io/FpwkEbRDQB/zsDgi355CYTmrNV55OZcJwrfw0AzSutJMNiozc7IM0w11LsPW3t1Y
         npDrCL+x+2uk/uPHhBzpeODmPsK/UInVbw3NvwWuFwyT55rB+47num48cSb2ja6foCbN
         EIIvOkmDNqZD0G23gnOu9WUk0tlBdciRwDcL1aJ1f9cfi1kpvq9aO7/AfSkmMKw3IC1w
         HLKTmj0rD19XYwRLvnDBHY5FLejVxfMuOSLoWf3LiBm8Cgrao0jZzhlD2d4ASNqgQdKG
         Tf/w==
X-Gm-Message-State: AOJu0YwMHUWRM8G3nwB7lq5yEl8orEZKikVrDVvnuYetS3XRZ6rNA/5g
	4kqKhkZ75SuwYzORn+q+4vnbXBXUPhCpZkzh/opr9SASoAXhQKIFvSPnqn+cqW2W/gg=
X-Gm-Gg: Acq92OEEqcNIOw03WsyFuO658ndYFG25pSM6avoGmZ9GgXX1x9JdScwaG4+p4W8fzg5
	5pJX1ROIWmCpxPCoVwqG6VKg0dA5bpmtbvoOcnjmlQi7jgMC2e4xwpVvure7+qDoj/ir6g5Sbb7
	Mg2oVk24cxMcN2/vPiiqRRdndEvX3UQWXo4BwixtoWlkwZpG/C13ZIG02MljecEEc1g1L4a8ScO
	eJ7yltQQ4SLN55ZP4SfyertoVt67LMJWU1jlnVUJWiNjhgCiqXAgC/YMhUS22AUP2NV3vr5d3Vc
	GBPonyqhcZGY8hfI/I5GN2S2sXmytkEqr6tMKxV7EWOUsnCIf4MC9bKhYeux16jrAIroggeXuW4
	pDeG8zpguWcnxm+W4ruxuh4Qsm6QFbT5AaUVjK5Mj8GauISKcgV9T3LwvRApNyW996JFPawQHoz
	ATtAc6uOx0/CX6XAwn
X-Received: by 2002:a17:907:160a:b0:baa:1d9:66ff with SMTP id a640c23a62f3a-bd5177f4e85mr1371009866b.20.1779212905008;
        Tue, 19 May 2026 10:48:25 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e21b1esm737917666b.44.2026.05.19.10.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:48:24 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH 6.18.y v2] fuse: avoid 0x10 fault in fuse_readahead when max_pages == 0
Date: Tue, 19 May 2026 10:48:16 -0700
Message-ID: <20260519174816.3983940-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518182602.3107764-1-vlad.wing@gmail.com>
References: <20260518182602.3107764-1-vlad.wing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,szeredi.hu,gmail.com,vger.kernel.org,debian.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladwing@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B9715834B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 4ea907108a5c ("fuse: use iomap for readahead") ]

The upstream fix is the iomap conversion in commit 4ea907108a5c
("fuse: use iomap for readahead"), which rewrote fuse_readahead()
entirely and removed the buggy loop along with it.  That refactor
is too invasive to backport to the pre-iomap readahead path still
used by 6.18.y (and earlier stable branches), so this is a minimal,
equivalent fix to the same bug on those branches.

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

Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
Reported-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
v1: https://lore.kernel.org/all/20260518182602.3107764-1-vlad.wing@gmail.com/

Changes since v1:
 - Add "[ Upstream commit 4ea907108a5c ... ]" anchor.
 - No code changes.

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


