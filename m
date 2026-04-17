Return-Path: <stable+bounces-238529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELPKEm3D4mlN+AAAu9opvQ
	(envelope-from <stable+bounces-238529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:34:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71941F2EF
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AC5309B000
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634134DB7B;
	Fri, 17 Apr 2026 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY5tAm08"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB352282F2C
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776468790; cv=none; b=Nsvnacnp1jJN5zfvkdgT6LqT0jMdRgkBA/SZVBoYiV/FQGhT9tqiWwc9gyg0IFF8qO7DgQRojiGuORBaU2BtLhhCpzgqu8UmcqcpU0BgVozPIruQiegWJZHQgtud2ixjPyz2vnll2tFwuecb53wdYsP+sQPapKBvKqh7vaJItyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776468790; c=relaxed/simple;
	bh=ZEi/cXh1iFeFEuzHRRsXi1pBdEeLdy+9xs/YHLYCT44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCv4Jc3S36Neezm870oiTZ9k64Zy3ubBEvudvrhWFHdPpeJ58C/eO7Qg8cBapgWgqnvt1gbxTbccEkyhk2NXPB7ypJYjzsemPeLLxjdLn4N23UV0YMWtrz8OSN1/LohLlMG5ddh7pjFVa+etojhz+dMNrGliidFUJICgUAs6Ob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY5tAm08; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a1e1817db6so9555816d6.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776468788; x=1777073588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWzyw9UpnNiqz+F9Ms8EKKcgZP/weNGJV02JLocqn4U=;
        b=MY5tAm08ngFSWDjHG8LvsI7Q6wIdyJmV/q8DcV/OrEkObP6pemxhDaWMU0k0GkJATt
         uPGVY83zP+44LN1haqKnZX2ySZlR5kQdPdJ/D7GCZ6CMbiaG10dJ71ILTDAVuGJK0Og3
         iI7Gd4EFYqfSurMBI9JGn/pS8kyBs0UaTn0vBGd6rNemwdxl1Vy3vxRvGGwpL8X0tY5n
         d33Ky/A9wXYNZtmvZF0S6V7nSWvxzXEMMXUR1Wc+VrmC+GTbx4kcYZKyobJLELKn1sIY
         572Oelsgkcry/DXP+FJYJizZThP1A7VpAgrneRce7l/assX2mXIoFpwOp5tIst2JJX4u
         VBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776468788; x=1777073588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWzyw9UpnNiqz+F9Ms8EKKcgZP/weNGJV02JLocqn4U=;
        b=MKP0DO/g+01c3sh8B3konlylHVNy4PH2CDC2ZXgt1yocGjErgOubBqGgtEP9JUg9VI
         T47uKV9ujUwEiG5sOi7zOzCs8+NPJIKOmd9HjrTGx+qCX7iCyqT3OklhWyyBn3gsUtbX
         YQmndkqiRt6XzsxpjD2yDdBcTilh6Evj930KuFx8KNmhNn3NAIv2cgQthYNLk35oCYYy
         hOE0qRpljXT7XK9rQrMulbCm+C31CNGUnELglKEBcJ23BQCG975J6/b11cxjD8Gi9Qub
         l7n7x7EUfy5o3/yOJkg2fANEGUv3Ooa7OpTXmn4S9jJEIYlY7IVXyoxZFGufqHZ6X8qr
         4Qmg==
X-Forwarded-Encrypted: i=1; AFNElJ8sHRx65g3Zx8isxbQs5ICUgxX6KN/Mbbz702V93CrldS9GYwKjStmEjGqoacdTMos4bnBUy0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXD/TIZ6pNSPimmaAq7sHPwdMCB6mkqiyt5a9ru/rnDeujE+wk
	azSQskK4+5aJaw9HG0uL2qAe/2X1wyXR/isgCZ2+8qjBQSXPzoYUF7GY
X-Gm-Gg: AeBDiesV5J4HiCpwcGzJjsXmGz/zjHQNg9RZS4WoFqmxh3WNfoAm36SxwaopVP6NPwP
	BuoJZfIMGl65zvWF4KNZuDF5xA4IzKfLeK5AG9TT0xVbjP8fZDj0t3kOOp+YfUasYgtsAWUVeYt
	3Jo0f9sb8rJyGYiHHOAn9YrccQ0kr0uCTm3SHPfFujlE5M5JTJrwHftAjhRAVeHebUQmphCVooF
	M8yBQQtoirDigvwdeEmREaKmLMxhdOsrHllaDbG26+to8hFgT8C3hf6mbsT3ZG32wiJBIyKj5JX
	1iSH1zg86iuCMNt4n0C7J4rvdkMXjoOf8KvlsxrzhTGIPe/AaXwLE6td+M08Lrj1ExxJxfz4RGp
	3px+d0CjRxsdTOV8XvqQDVHiNIgiRal2wFnAtfZLvBpX0UHKTLigXSNr0+x4xSdpjA6XLf+j771
	8xAb2zuLqzooMWiNK7bFaSnuYoSdNWKazWLaUupgWg8IPUlj7uDfub/twSNz1RDsMpbBTkQXRG+
	P7SFWEF32oAv6aLkq5wj1XAaTU8LfgRl2UrUipSj+1L2Vst49bZFQ==
X-Received: by 2002:a05:6214:8085:b0:8ac:a2f6:fbf7 with SMTP id 6a1803df08f44-8b02812ba4amr64724626d6.40.1776468787802;
        Fri, 17 Apr 2026 16:33:07 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac429e9sm21701246d6.3.2026.04.17.16.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:33:07 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs3: bound to_move in indx_insert_into_root before hdr_insert_head
Date: Fri, 17 Apr 2026 19:33:05 -0400
Message-ID: <20260417233305.1787096-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238529-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: AD71941F2EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

indx_insert_into_root() promotes a full resident $INDEX_ROOT into
$INDEX_ALLOCATION and copies all non-last resident root entries into
a newly allocated INDEX_BUFFER via hdr_insert_head(). The source
byte count 'to_move' is summed from the on-disk resident entry sizes
and is independent of the destination buffer size, which comes from
root->index_block_size (via indx->index_bits).

A crafted NTFS image that keeps a valid, full resident root but
shrinks root->index_block_size down to 512 after the root has been
populated makes hdr_insert_head() memcpy attacker-controlled resident
entry bytes past the end of the kmalloc(1u << indx->index_bits)
allocation returned by indx_new(). For a 512-byte destination and a
resident root whose non-last entries total 560 bytes, the memcpy
overruns by 120 bytes and a following memmove extends the highest
written offset to 136 bytes past the allocation. The overflow bytes
are a direct copy of on-disk entries (via kmemdup), so they are
fully attacker-controlled.

The write is reachable from unprivileged open(O_CREAT) on a mounted
crafted NTFS image: a single sufficiently long create in a directory
whose resident root is already full forces root promotion and
triggers the copy.

This is a controlled out-of-bounds write of 120-136 bytes past a
kmalloc(index_block_size) allocation, with attacker-controlled
content. It is a bounded adjacent-heap corruption primitive; it is
not an arbitrary-address write. Successful exploitation into a named
victim object depends on the surrounding slab layout.

Reject the copy at the sink. The destination's INDEX_HDR already
reports hdr_total (the payload capacity of the new buffer) and
hdr_used (the bytes already consumed by the terminal END entry
installed by indx_new()); require that to_move fits in the remaining
payload before calling hdr_insert_head(). On mismatch, fail with
-EINVAL and mark the filesystem as having a detected on-disk
inconsistency, which is the same behaviour as the surrounding
validation in this function.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

 - FYI, like the sp_size patch, I have a larger refactor that might
   make this easier to avoid long term.  It's a mount-time variant
   that adds the cross-check between root->index_block_size and
   the resident root attribute size to indx_init() instead of the
   sink, closing the whole "root entries do not fit declared
   index_block_size" class for any future caller that reaches
   hdr_insert_head from elsewhere.  Happy to send it as v2 if
   you prefer the wider change;  otherwise, this minimal guard is
   scoped to the minimal memcpy overrun site and is easier to
   backport.

 fs/ntfs3/index.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 2c43e7c27861..b7633b721d19 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1740,6 +1740,22 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_used = le32_to_cpu(hdr->used);
 	hdr_total = le32_to_cpu(hdr->total);
 
+	/*
+	 * The destination INDEX_BUFFER has 'hdr_total' bytes of payload
+	 * available after the header, of which 'hdr_used' are already
+	 * consumed by the single terminal END entry installed by
+	 * indx_new(). A crafted image can present a resident root whose
+	 * non-last entries (summing to 'to_move') exceed what fits in
+	 * this buffer; copying them unchecked would overrun the
+	 * kmalloc(1u << indx->index_bits) allocation backing the new
+	 * buffer. Reject the copy in that case.
+	 */
+	if (to_move > hdr_total - hdr_used) {
+		err = -EINVAL;
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		goto out_put_n;
+	}
+
 	/* Copy root entries into new buffer. */
 	hdr_insert_head(hdr, re, to_move);
 
-- 
2.53.0


