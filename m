Return-Path: <stable+bounces-269504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L8umC/XvQGqQjgkAu9opvQ
	(envelope-from <stable+bounces-269504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 11:57:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6B6D38C1
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 11:57:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BlRvGMne;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269504-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269504-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EC60300516A
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6A357D1E;
	Sun, 28 Jun 2026 09:57:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB83370EC
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:56:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640622; cv=none; b=XzkTMNf7qXibwHYHNPfbUJEWR/H1IZ9UtsxeZ7nS6QryjfRUdIaPfeORvNdZ6B4vCKxJFXC1wRIhH9JVG40V4t/0dVFl6uUQYnSxXtNu1q/1ZTXMtDxHzjQV42YNiYI3SFMZHefMv4LpK8jdxMaOnFwa3X6AfXVt2OMgiAxjPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640622; c=relaxed/simple;
	bh=iI6UpRpfUgXDkri4EcJW5TuLXyA/5MefvjbCl/LO6PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn0w0En62qjBXQfVNPHAePdTQUXpXg6MXJohAtaML9yXBJuruteWrxhV2tiUo1tCN1LWp32QUNO43Dx7UNTXcXAmTUffRleRgaHFVMxHLMgJ0712VOSpoBPqNdxjcQElWZUDSHOFD4fxVeM+PORB+L24iAgRe8z1ZLs1/84CatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlRvGMne; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4626fdc829aso1477042f8f.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782640617; x=1783245417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg43f+XEb4q5xqiQSXTBL+eF+ouBz+XEK14Aa67BdH8=;
        b=BlRvGMneybrpiyDA7FgSdX//ugILgGi6Cm3Es0POJq3ejan/qfFn6kklnAfuMo1Hzw
         p7F7GADnOqunXDLlOknalzGaKZYU43NnMcOWp77R3d3n/BLTf/6v5FniKVonl3i/Ex5S
         zcjdIRSVY6y4JCTfguSioHD6QSoFCcSv9AT4LkDrSk29esJKnHw/nUqR3o5NWiyPlzQy
         LXCWZSW2O6QzUVBM/66tle3HZuHxstJYS5VXIzbycydtz+u474mnV1/wi4HkIAmzWHCp
         w4N47xKp94mmYJN3WoC7xQzZXYXBQkey8I68R74TLs4NP0ctaeUs4RQf2geHOmJ1nlqE
         loTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782640617; x=1783245417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg43f+XEb4q5xqiQSXTBL+eF+ouBz+XEK14Aa67BdH8=;
        b=eJ8XaAl6ashoS5Q/agM+Kf4+kLb0OXDk5PXIorhkmrnn24eOdXACasq/BWIlgghdVn
         uAV5YeidRK6MOPWIDMcuISMVc7eRIubGNgnzdMCiRjghTwAVBRKmqTPl8MGG2aqgbOpV
         iMiWIgCN6EboKfwNBvDRQgxefCoG48kpyZlW1YP95poFRza9p2DP92txMn5v0J3S8r+t
         s5fRtn3lYbQPAp9xPptP5yGQbfgoOFF3c1gyLqSXZeIBVYoZP7lxonPrkbB7P53IuIZx
         cO4Y/oFmztzJZqvHD20u4do37Ma2NwdpJhyeVgzlwUyU7xSY2AUr6IFNf345mNUiqvSM
         XIZA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2WLfeUrXnO9Ub3ynMFghLDGho0/LNK0nNHanFZKCB8CjXNKuRYTjwcRAh9i9IZWo3JhplfbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRH49O7O5N4ZLw3QGDYGXJIj8zK7QXuEa3i+0JvWh7xwPUfXL
	g/V54IJGMlpX+VKex/4f5p1paGkZBNC5FIpxgiWXY+TXltuYutiP3TzK
X-Gm-Gg: AfdE7clhGQ4vJkwIoFANI165SyyhzHj26pSxN/xj8NqPTkaASaaLPQnDLbsZIUS2rKJ
	BuOJarKIXC6t2cah2PZWkN/YNhrKmhFiuasxV7hYD3m33toEP7a6F4ylKB1gs1Ln1wJS9X7vKRe
	gz8EDqXCxpP5sLI31xK6J9hmizmryPWcwHZ1OKinHbktGLzmuVeIFttKEyWNRKdary6rhSROWHd
	b9ygsXsFgD3hh+LzD8+NyeAFBvOK6aogREAgqdtregjvH6QTHz4q1JpK+oFoyPK732PX5cdHvad
	meDIty73b7ba9tM6BQEh5A7WxmWvvGIgwPGK/8BCdBLzAi3u9S1xTehmdfZIewzovYI+2NaJl7H
	gM0sxQztizcAmciiuAd5w1htPetmFh0JKMqIwryTHdnDShZ6n44LAa+440jSd9i3v58xxF7pzGA
	ZJFXiXb/oIw8eVAAd9IUzJFm6h212+P3J2PDTq
X-Received: by 2002:a05:6000:4286:b0:45e:e9ac:42e8 with SMTP id ffacd0b85a97d-46dc0839ffbmr20802510f8f.18.1782640617140;
        Sun, 28 Jun 2026 02:56:57 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47327c47122sm2959694f8f.34.2026.06.28.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:56:56 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+45ef5a8d661162757547@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] ntfs3: bound index head insertions by buffer capacity
Date: Sun, 28 Jun 2026 11:55:59 +0200
Message-ID: <20260628095559.47891-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269504-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:almaz.alexandrovich@paragon-software.com,m:ntfs3@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+45ef5a8d661162757547@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,45ef5a8d661162757547];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22C6B6D38C1

hdr_insert_head() shifts the existing index entries by ins_bytes without
checking that the resulting used size fits within hdr->total. A directory
index root larger than the newly allocated index buffer can therefore make
the memmove write beyond the buffer.

Reject insertions whose size would exceed the index header capacity and
make both split callers unwind the new node when that happens.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Reported-by: syzbot+45ef5a8d661162757547@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=45ef5a8d661162757547
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 fs/ntfs3/index.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 5344b29b0577..64e1be9b7aca 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -594,6 +594,8 @@ static const struct NTFS_DE *hdr_insert_head(struct INDEX_HDR *hdr,
 
 	if (!e)
 		return NULL;
+	if (size_add(used, ins_bytes) > le32_to_cpu(hdr->total))
+		return NULL;
 
 	/* Now we just make room for the inserted entries and jam it in. */
 	to_move = used - le32_to_cpu(hdr->de_off);
@@ -1743,7 +1745,10 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_total = le32_to_cpu(hdr->total);
 
 	/* Copy root entries into new buffer. */
-	hdr_insert_head(hdr, re, to_move);
+	if (!hdr_insert_head(hdr, re, to_move)) {
+		err = -EINVAL;
+		goto out_put_n;
+	}
 
 	/* Update bitmap attribute. */
 	indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
@@ -1881,7 +1886,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	/* Copy all the entries <= sp into the new buffer. */
 	de_t = hdr_first_de(hdr1);
 	to_copy = PtrOffset(de_t, sp);
-	hdr_insert_head(hdr2, de_t, to_copy);
+	if (!hdr_insert_head(hdr2, de_t, to_copy)) {
+		err = -EINVAL;
+		put_indx_node(n2);
+		goto out;
+	}
 
 	/* Remove all entries (sp including) from hdr1. */
 	used = used1 - to_copy - sp_size;
-- 
2.54.0


