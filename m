Return-Path: <stable+bounces-238525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPZOJt664mmA9gAAu9opvQ
	(envelope-from <stable+bounces-238525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:57:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0182041EF6B
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B31304C949
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732737F01C;
	Fri, 17 Apr 2026 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1gAGGYT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199736AB50
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466649; cv=none; b=cPqJnPzHnRXElC6kJrmQdHJqt4lmMh6gEtQ67M78SPSfXE3oB36wL7+CLfnvDmYsPZZN478LT37rID//HUV+WKsDaN1a+hx+U37mD1c0gMXFIQi+9S7htu0V+kHIZ63axCdxuHHGkD4wmeLUvx/iAkBIJby//VPbpcCiUZ13iCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466649; c=relaxed/simple;
	bh=sPqyP5bAWRLVQUQ1xHjl8LHnserzJPjwHB0RoAyAe1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKMId4OGWJ3xZ1KUGgsBBQwQjMvoRPgMlxZ0AQwk3W/cs5oxYtb0MHBcbxpMhMrADqkrQoNWu8LORQTroKPlOygnRHUFDm754lbeHEQg5hC2Trh4RdoRvNs6WKixLvOMbadjHZM61KIhXFwDUZN2a26l4FXXyxyeN4hYSsrfcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1gAGGYT; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acb7f2586bso12792616d6.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776466646; x=1777071446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8lfDYWV8wgoMG9u/N/hKMSAzR1cznOubbXPV8IlRC8=;
        b=L1gAGGYTSJDa7OHzBmSP6td0m8QVMYBxKLit49AgRe/Lygh6VnIzDO8/FcCBX22KYl
         e2n3MdTj/QCXe0XqW+xoruoIKqk8OHwrk/1uO4bQJDFIwyMBN5V5mjjvvtYGx1bTCNTW
         PaVmZdvR8hh+WkQ9VJ4zepCJ3yFUubMxhD+jv9RKqMe2p6kcQNvoWnaGfOvt6Gf0GMq4
         +IRN3Ar2nlEh4ER7y/wBbUTpZD4Lpd8LINbSNbqqUY79ISS5P4IWPE7S51h/oOgfkoY9
         lrzTWtNVk3s4qV8huBE6Aw00h5nH2iWM9r0UlVne/3+HEoX7a4+t9HRPKYGQwDS5EdAu
         1FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776466646; x=1777071446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8lfDYWV8wgoMG9u/N/hKMSAzR1cznOubbXPV8IlRC8=;
        b=WCSC6539lliF6BPxzVFROPoSXPRWX2t83G92BJFTCuXj3++EaJtc+tDUR1qdG2F4bi
         cNZqb+I/FXSk7+Iv+yAQt6dy5lcPIPiFfJFbNwDu8sdLp8UxV5oiqMtzQKMOJKasf6mw
         GecJ++V/mGbgW9/pah7dznFUmYUCJDFlX28kWMBKxZix/OSth7ukrxR/gXvZ6eTtp8xQ
         MlmUo69GFwRdAPkjmxgmodWtotJ2ziufouIqCPTWqMMYHaLtiEHBZKaWpMNMW98DzMvC
         fPx1f0wOYAV8+Nww80TOQUWJINZW7CdqWPPqpx1EIE5g53hnqMhir8BEkm4iGkilyhLW
         y8Dg==
X-Forwarded-Encrypted: i=1; AFNElJ+hxM18zvKEgQ3nHVE5/wOwsAUNiijQt7bXYAxK+neDnRczbUoNHOpdFruoG+lufQKbSuOOZYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sKCk3fosbuwBZpMnBBgeSsTrl553PRCTlar0/ErPQ+cx4stt
	mQ3oPSJWZFW72pFEqBaacZ0hbJWSqNeZKyNYyPfOcXP/KJmgXd5hpWU/a5itp2Y1
X-Gm-Gg: AeBDietryDgh+7bbol+JSR5kqz90iw0XXVrAkAQWgXpzvduQtiAzlVEfksxbtppL6xV
	wEp9NaGqVXM1u4yHeT1eeWaYGPKhM0wtKcF29IY/pV1r/PnQ+hQQEGdXwz4O3zwB+hIESJ0Rj42
	2lmrCDsmyPniGz1DefkExk0FHbnUBOkkoSMdE5bBzedNP2vyH6v/34wlfIGHvrrJPWZMy8Zm8fg
	fAOzDsqCvvxMhx39zblLt/b/AbSyVcKR5AwRORamfbS24tDrLDjdHgDOzcKusgQQtvDBFZA92ny
	E2H0txNdgBcQJtoJebwKlYsuUI9BkhaPJv7yJ/AHNe123Mei0oTEJQXkSL7YlAayvKuDBBt4fLC
	ogJAy8OOBJc1NJ4/Uk4zUwjlgHJGQ5DZAioM/Xz52jucoRvVJ0xq2tRmjk5FsHBvs78nlmBL8qX
	uFUqCuXKMTa9pABzEOTmxfaVQ/SkJx9RcK0yjbHPpAU8APk8bBMXJ3vT1zUbrz0TG1WCBFyDbRV
	4jQ7c322Czf506Vh2xXu90XG061CHgdr4eWis+T+wL1HcvUSv+JA2Fl6h0L2Ml1
X-Received: by 2002:a05:6214:4019:b0:89c:da2b:4903 with SMTP id 6a1803df08f44-8b02822c9cfmr76690446d6.46.1776466645910;
        Fri, 17 Apr 2026 15:57:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c4b9sm28948896d6.28.2026.04.17.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:57:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs3: validate split-point offset in indx_insert_into_buffer
Date: Fri, 17 Apr 2026 18:57:12 -0400
Message-ID: <20260417225712.1736320-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0182041EF6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

indx_insert_into_buffer() computes

    used = used1 - to_copy - sp_size;
    memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));

where sp and sp_size come from hdr_find_split().  hdr_find_split()
walks entries by le16_to_cpu(e->size) without validating that each
step stays within hdr->used or that the size field is at least
sizeof(struct NTFS_DE).  index_hdr_check(), the on-load gatekeeper,
only validates header-level fields (used, total, de_off) and does
not walk per-entry sizes.

A crafted NTFS image whose leaf INDEX_HDR reports used == total but
contains one interior NTFS_DE with size = 0xFFF0 therefore passes
validation, descends to indx_insert_into_buffer() through the
ntfs_create() -> indx_insert_entry() path, and makes hdr_find_split()
return an sp whose sp_size (0xFFF0) greatly exceeds the remaining
bytes in the buffer.  The u32 subtraction underflows and the memmove
count becomes a near-4-GiB value, producing an out-of-bounds kernel
write that corrupts adjacent allocations and panics the kernel.

Reproduced on 7.0.0-rc7 with UML + KASAN via a crafted image and a
single 'touch' inside the mounted directory; crash site resolves to
fs/ntfs3/index.c at the memmove.  Trigger requires only local mount
of an attacker-supplied filesystem image (USB, loopback, or removable
media auto-mount).

Reject the split whenever the chosen sp plus its declared size
already extends past hdr1->used.  This is the minimal fix; it
preserves the existing hdr_find_split() contract and relies on the
same out: cleanup path as the pre-existing error returns.

A prior OOB read in the very same indx_insert_into_buffer() memmove
was fixed in commit b8c44949044e ("fs/ntfs3: Fix OOB read in
indx_insert_into_buffer") by tightening hdr_find_e(), but that fix
does not cover the split-point size field path addressed here: sp is
returned by hdr_find_split(), not hdr_find_e(), and the underflow is
driven by sp->size rather than hdr->used exceeding hdr->total.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---

 - FYI, I have a larger refactor variant that migrates
   hdr_find_split() to the validated hdr_next_de() helper and closes
   the whole per-entry size-read class for that walker.  Happy to
   send it as v2 if you prefer the wider change; otherwise this
   minimal guard is scoped to the actual memmove underflow site and
   is easier to backport.

 fs/ntfs3/index.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 2c43e7c27861..24add048b4b5 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1844,6 +1844,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	memcpy(up_e, sp, sp_size);
 
 	used1 = le32_to_cpu(hdr1->used);
+
+	/*
+	 * hdr_find_split does not validate per-entry sizes, so a crafted
+	 * NTFS_DE whose le16 size field is out of range can place sp such
+	 * that (PtrOffset(hdr1, sp) + sp_size) exceeds used1. Without this
+	 * guard the u32 'used = used1 - to_copy - sp_size' underflows and
+	 * the subsequent memmove count becomes a near-4-GiB value,
+	 * triggering an out-of-bounds kernel write.
+	 */
+	if (PtrOffset(hdr1, sp) + sp_size > used1) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
 	if (!hdr1_saved) {
 		err = -ENOMEM;
-- 
2.53.0


