Return-Path: <stable+bounces-237661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HowG5Rd3WmadAkAu9opvQ
	(envelope-from <stable+bounces-237661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:18:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19F3F37B6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CCE3029E72
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948340DFA7;
	Mon, 13 Apr 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMjQH1go"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2A1514F8
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114780; cv=none; b=HVEPX+8TIMvmNep14vMxSdf0yvo3lJUCG+X+k9obPlfh35pnT+vN0WhwfGMFpfjdCPVpBJyFPul9r6lvKLakGJXXY49cp2KOdCJGnjvdEvBUkWCjyC9axny+OaLYBQNJwMpfS2GP1/WhdnUt6yeIltuTuGQ/Yi1VnmLmY0bTbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114780; c=relaxed/simple;
	bh=zhwHBvxowx/CDbJvKJKLuT1kONQfkrgCboxl/nz+Drg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRgZcHcnnbfNSt70PyBPGsW90GbxXHJ5g7Y/RxHoZXBVSKWx/MosoB4hZ5+ms3EQnFJ0PEF5ye/wy3zpSgr1ULnp1lsJq6IBiURmUu1PYexS62RzqvLQ20HazevQHgljVEfD+Kr6mDW+I0TXH3Oh5QqfDnlPPGt4xBYS/1Ihkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMjQH1go; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50baafd6c4aso51614941cf.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776114778; x=1776719578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRm3QQarp6KprRAVENXxH9rbQ7MVgBtYRP8MX65QUmA=;
        b=AMjQH1goATY7LUP4WqBcAx7uObXy2Qi9B5Xhj+atCj0wOPzTi5rqvLaDmhr+7Puguk
         SEQ/THvmInMF2hH2AHJnngTTNh5N8Qrhj4GqpHqCf8W92E5udlHoSe94GDtj/+YkIJBY
         EblrsazoKIY/KCQL3NwrMKr0dwdDpaS2mLOKz+uJCfRe/6/wMuFAQXGB60HYpMjYJ1Xs
         s37v8jdO44MH/uHIZ0KcYNjDTtZ0cJ2MIXqv833v3dva47YP96NBCaXtE0ojcH1KkrHv
         0JK40uZ7a9/i0sb5Skupc2kOyLeoFIiNrcgQYE3Kr3OhWayOGy+uQ5Mlpb8Q/MNYDKyt
         X61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114778; x=1776719578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRm3QQarp6KprRAVENXxH9rbQ7MVgBtYRP8MX65QUmA=;
        b=b5xqoeVia8ALWIrGStSxwq22pyXj8as9vSHG7CGP5lW+6YW3j+X3UoUi2KRNTUn4zx
         +mKKNz+byXeWhFuYkNfe9YD/rvfuXdX71E1tzDdLFadrj5P/kGyOZ5ORypsrHezrc/MT
         1uGcKwpNkD3CUNJAGzDbAAn6wlP1pj7HH1ntpSCtg4gWnUpLk20DnhzSDA/sLeAxkXqr
         HT9nz9MKVjx2V7rlNEalKPXc1jeNYlenfAijVd//vUsRvwXjrwcT5OoffCiVO5bTRwk1
         vZxTLSjobCR88rruMEEVS31STGbExg0Qpz00Ny6T+5Nn57IaqqjRaADdViEdXj5SY9Vn
         q1QA==
X-Forwarded-Encrypted: i=1; AFNElJ9J4XaTFJMRJb1CCmx3N5+ibGFLcGzGhZdX8o2u1+0lv9uENUyyK3mBkYvia1KiGlbrt3etZ8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7thkQMmB91aJTb5yF/Fkx8LMTQPepuIutitQsMyXM9NQSHQS
	Sffnf5mjsB/Yv9nBHpsZ7ByDrqFGTA8yMoEUR9/I5ujgS3s/d6iQ6qRVuCo1SQ==
X-Gm-Gg: AeBDieuReyEAQwOVnsIWAk0bJ3cyRk/E/vGarrtGNu1bc2w6DT7lRgoVRS2URSgTNQa
	qsBlFbsUsXJLfu/I40/j9XohtjZyJsz4W7DjepHMOcdmZE018xIimPYqQxepmYcy2Sb/Fj1AJ4d
	3qH95LEOsXpb8VQA0ilIgLA54BTc7spQsnKAxWSCeQibSsQFuUp5LNWs4TzMN+FLpexWMAUNgJe
	EEGvQ+Vjc4gkHeIYswAZuLcOoQLMszs7qM4WJKWiPPtmNwMKb3SIoKWn7lNm0bs6V2kKHJsqcO6
	5IqQETmsXKzty0RnnDPI06YM1nrxOu2zRrBKcIzdVK7OYpoMHiK3jO6lxf/E8eAEfOInggHtfay
	WvzNPFUJGPCB9ophMJVcLToB8zyfkAw96AcHMTvzmpmfVZjv18bgS+DZnmi26YR79Mk0un0T4R5
	RJ8pn4e+7OFLLLxyXke1yBMK/e20ItcziwYV9Wiiklv1ck1ruvVW/xw72E12H2++zRj5CLP79+Y
	b6/9erYrEdbKYkF7HsE1MscyRYUAt8=
X-Received: by 2002:ac8:5d13:0:b0:50b:4726:f152 with SMTP id d75a77b69052e-50dd5b346demr220545431cf.8.1776114777966;
        Mon, 13 Apr 2026 14:12:57 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b3f3sm95998551cf.2.2026.04.13.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:12:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] udf: reject descriptors with oversized CRC length
Date: Mon, 13 Apr 2026 17:12:40 -0400
Message-ID: <20260413211240.853662-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237661-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE19F3F37B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

udf_read_tagged() skips CRC verification when descCRCLength +
sizeof(struct tag) exceeds the block size.  A crafted UDF image can
set descCRCLength to an oversized value to bypass CRC validation
entirely; the descriptor is then accepted based solely on the 8-bit
tag checksum, which is trivially recomputable.

Reject such descriptors instead of silently accepting them.  A
legitimate single-block descriptor should never have a CRC length that
exceeds the block.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Found during a filesystem security audit.  The CRC validation
condition in udf_read_tagged() uses OR logic: the first arm
(descCRCLength too large) short-circuits the second arm (CRC
comparison), so an oversized descCRCLength causes the function to
return the buffer head without verifying the CRC.  The descriptor
is accepted based solely on the 8-bit tag checksum.

A crafted UDF image with descCRCLength set to blocksize (e.g. 2048
on a 2048-byte-block filesystem, vs the 2032 limit) in both the
main and reserve Volume Descriptor Sequences mounts successfully
with corrupted descriptor bodies.

Reproduced on UML (ARCH=um, KASAN-enabled v7.0-rc7) with a
mkudffs-generated 20 MiB image, both LVD copies patched to
descCRCLength=2040, CRC left stale, body byte flipped, tag
checksum recomputed.  Mount succeeds (MOUNT=0) with the corrupt
LVD accepted.  With this patch applied, mount fails with EINVAL
and the new "CRC length ... exceeds block size" error is logged.

Reproducer details and UML console logs available on request.

 fs/udf/misc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 0788593b6a1d..6928e378fbbd 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -230,8 +230,12 @@ struct buffer_head *udf_read_tagged(struct super_block *sb, uint32_t block,
 	}
 
 	/* Verify the descriptor CRC */
-	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize ||
-	    le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
+	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize) {
+		udf_err(sb, "block %u: CRC length %u exceeds block size\n",
+			block, le16_to_cpu(tag_p->descCRCLength));
+		goto error_out;
+	}
+	if (le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
 					bh->b_data + sizeof(struct tag),
 					le16_to_cpu(tag_p->descCRCLength)))
 		return bh;
-- 
2.53.0


