Return-Path: <stable+bounces-238590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO/MJ7yJ42kDIQEAu9opvQ
	(envelope-from <stable+bounces-238590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:40:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F306421385
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FBD7300B184
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536D37D132;
	Sat, 18 Apr 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6toEGRi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E227B35F
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776519608; cv=none; b=LWbcv9RsAXkQV1pGvaGUNq29Bgl0Nnc+c/EfHrTWe/3xbk+ijh8DpRHoXAS25KUIiWYaBigurn5YKKaeKYAGzn8oJM7FtJqS/3XmZkQckXzcx+9+DSBLIwa7Ey7+nM10ml0GqHQbHjAwzcALovI81qQ6GHPiRuY4Wzp1LjTuqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776519608; c=relaxed/simple;
	bh=8MGctQEOIhl95n3bDj3JshVvxuraofGdmA3XHCuYTQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1+qkDm1gH+i1g44HVcbtqACYuXbrOR0bf7TziPCHTxoYwp33QraoJY8krQlyjJfSmcwBoDfqzpIMnn42yCbPYhnIo0NIxonORGpOit+xbMqFDQDkY1vIioxT3RkYSNEoGHVkzzzr/uPlYNkNX/mgdqcReQH1mzN3bYoOyJF+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6toEGRi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-482f454be5bso25828245e9.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776519606; x=1777124406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdkJlOycHCsM6bLsz9d13zXHPZkF37qpGvGtla3eQ2s=;
        b=q6toEGRis1owxKyD/wRGaZVaYoLucP4EvAtysMDofGFo0zQCJ5G8XLOYSolU8DRUnL
         pCSqRAYzQgZeNkd1y4LJo3mD/0gySFqeSWbpTUK7wa+QOV9EX9H2mSt8cegwdivkQT0U
         gdqXpp0XGmP0DQVUSbeOhkt03qhEJ2JMksPszzz3QeeCmlubm209FJ7MCeZf+V5r6Xxl
         4oJFcDBU8P+zP4ibYhZMeYIEeoor4yWlRhDx2ZSnkDRLcHw95D/snvkjCQn1qJIw0QIr
         DUsTiqoT68OGzYRjcIxBMvbBWO0wWmiDHUENBZfTzoz1buuBZyzX33vC4K9LgRU8nEhg
         setw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776519606; x=1777124406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdkJlOycHCsM6bLsz9d13zXHPZkF37qpGvGtla3eQ2s=;
        b=Yv2bmAxngk79WuJGKJjFsmpQ42DtK+lu0WUro9pRK1S8kOVMOn9DLx86topU+buDpt
         10fkwPiLtZ6Jb70UxUXcS+vQu6oF55O/DmevZ6BI3dk0iTHQs14ZecoXnZeIxqIqpk0H
         A5xerP2riHpbn7RusjpcQHbw5QiV0ARZwcrdyJCw2ij5OeWiumDv+MaHDAJVPM9bLsng
         sPUxs8qHysSB0TZ4V+9DJ5bF16sis6tJwcqcOHoQyGrVEyeFAutZUVcqk5BmzrOWQQqy
         QvVaJXEUu4QclEg6Z0Ubh82G+DmToOnHacXzZ8oPxhBbyG9nz8juIL1ZJws0ifov9puQ
         9FUg==
X-Forwarded-Encrypted: i=1; AFNElJ++0QFw2X0lTZ9fEVBh2Nvzf9o5KYplP37DPrfHDzk0XffTc4tb6H9zaUPRrjPDcmV1KEZeRtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUN2Tjp6BYfcF1zJILseRJ/32WW/HYNeJyE6yRo/Er4izyydsV
	c9bbEn/InuMxUBTlXzQtHz5vZedLqNoHtGxUIlTRY4lM9Z+BvHhlbX6yN4yrXUM=
X-Gm-Gg: AeBDiesBuuLLKHoloosuZWWCbe2OdCjXmlPrw+B9pnvACi2odxlPoaDS+/pRSsT4LV6
	443lTxLGdXO4YlFa6SGyl8QRGQGU2o0zV47VZZSZY68XQURovmYDDwCKesGXecYihelbcFoWds/
	tI47wZBeUX0QDWF0xVw54sbH5FaI+YYYRXzdYO1B192ytZbqydeiZCe5UYt8ogcaRoV27xweIh3
	6Ld5ec9GYX3aEeZlRweYlzDsQcQmsauLCsZu2t6HtKD41UXawm8vv4wu3O2M6KeTfyVEs+gOjIs
	RbWgI2UDc8C9bE3rnW8G+fWHHC+4DDMk1wrxQSybZgbZrQkHcsdguQ1ibXEOgpP1kdzQn/IhAEf
	SiKX+6tvUvBngThVYEC1EyAFF3vakV1e1ULMymgaqIbmiwkkQfunvKk6gCAzldbV/vI3KEBo2IY
	byFhDjGfs919Afi43j
X-Received: by 2002:a05:600c:4749:b0:488:c6e9:1e0c with SMTP id 5b1f17b1804b1-488fb889385mr87201475e9.5.1776519605846;
        Sat, 18 Apr 2026 06:40:05 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb735d3dsm88527395e9.2.2026.04.18.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:40:05 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] hfsplus: zero-initialize buffer in hfs_bnode_read
Date: Sat, 18 Apr 2026 13:40:02 +0000
Message-ID: <20260418134003.1719393-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238590-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.945];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,217eb327242d08197efb];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,talencesecurity.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 2F306421385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hfs_bnode_read() can return early without initializing the output
buffer when the offset is invalid or the requested length is
corrected to zero by check_and_correct_requested_length().  Callers
such as hfs_bnode_read_u16() pass stack-allocated buffers and use the
result unconditionally, leading to KMSAN uninit-value reports.

Rather than initializing at each individual call site, zero the buffer
at the start of hfs_bnode_read() before any validation checks.  This
ensures the buffer is always in a known state regardless of which
early-return path is taken.

Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfsplus/bnode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff5..14d1af2c7ba93 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -25,6 +25,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 	struct page **pagep;
 	u32 l;
 
+	memset(buf, 0, len);
+
 	if (!is_bnode_offset_valid(node, off))
 		return;
 
-- 
2.47.3


