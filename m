Return-Path: <stable+bounces-238513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB74MAmJ4mlq7AAAu9opvQ
	(envelope-from <stable+bounces-238513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:24:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B23541E379
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8165830A1941
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA563557F3;
	Fri, 17 Apr 2026 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaY4Q3TY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4D34A3C5
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453640; cv=none; b=kGPrO19a9EqkpE41sl4+ffu6arBc7v1SDyYfU/L88+uamYqqL8yle5LND3EjFry63QYbDRoVJgpX9K1xyloy2Ce8kLx0M8wk9Ap/DskVIxMt6R0HVgsgqkGl3xLt/mxPiF82HYsmtaZklWZse+cXn3BDxjL73SL8bGwxb/IOCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453640; c=relaxed/simple;
	bh=D5kZnVaQ/vTrsXOqYWEl96J7QGlRpg6INGoI6xYfsZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dawRzjZh8rgJmOGeVRDusEJtrdZtNuRJkcVgw/9yo7ki3rEaK9WQE8k20uUbjCzAwWHehg8dw9VFUVk2CQHg3L15fIusIKFa86fUdzWNhDZ+GtWl5tpwX1/G44dLE+5HDIsPGXA7w06+SYmNWwNyYnVvmhza5pDBpdT3AO6TCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaY4Q3TY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso7754705e9.0
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776453638; x=1777058438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qejIuAQOnYrB0ta1vlKG9Tsn1R8vB7zz59IN9WHpiB4=;
        b=NaY4Q3TY0Ni6uB6vXusebzSWOBOlo27f34yAICcMhw0szVdYrak1xSJ01IYZQBu7Uv
         7umFB+tCTz1Re2qQDUzY4rhvgaclwpz8QNHeaGNrxj+Ts5DIQl062JQCDu9Eiy6jnxGb
         d8lOHUUnZE0EehsQjE9JNcq189zx/z0rV6ijvTlCUYwCyDo8MEfe3XatSUQfJbTmz5T7
         Uuew08B8W6acFracgTG2afs6cvp9TU0P11nyPMpT0pDwaMhw1ivjY4XUQg7GJaly9Sa3
         UrFds4oYcyA9wSVanQO4ZRQsWmdNdRMnEVOK5aF2PIEuGsi9YPwv41KwmwzCcSMxpRBO
         RJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453638; x=1777058438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qejIuAQOnYrB0ta1vlKG9Tsn1R8vB7zz59IN9WHpiB4=;
        b=tZJMVSKJX8sTSTbyGzHdH2tC+8tMF++wXRlrqx5CaSpOUTr4Cbj3V68lyS1OB3jX72
         mto8/rIZ/D5ns4NedducBgrDhkkhReE9ilaPuZ3J1lI08aymjbaJ2LAFTRn4THziWenR
         3x9Ts0D/Pq1cWowm7oQzII7YY1NmWkA7bztqO4KD12ldXAhnMPfP7ezQ6AcgwNLfzj83
         CXQH+WCWRU4lmMl+5G5VQNILm9V64ZzarO0Vofalny6DDRjavtrq8/QyniH4FsrY6UVD
         T/mJCTZVXhC5cd2/FcPSgAUfS5ngDf3jCypfHh+Hlkv9brWHUlaPkf/p4fEHGMS4pWn4
         6O7A==
X-Forwarded-Encrypted: i=1; AFNElJ+kvEHlZ9aSkOoDxr0Toa+lUY53F+XeQ687yxTaldbxMye3UksPQW7rFt0CSoJTjs7ZcH0QhM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBlOpndvmfSEeLYoS+LbhDdqkhz/ueE71INDGavqz26GOjqhx
	68GIVhqAJtI8AAkkKHC6VDid6oeuLmTQWhpHD4g+Zctw6pVJdsYK7ew=
X-Gm-Gg: AeBDiese6YgXEta3h4qj2FqssHtkwu+IRCSzYiYY0mhuyCAA0IA5a5j2Drgclhill+m
	x0fLV83Ro86A1GmUouF33Nv4Yd0Y5Ao4ftnBiltxk3ITPuDmSd0Y/PsFlk9p1r1iaGsOXdnmWwW
	i9MK0gYI5DxpVdd/XcGWRHep1pFwW1bNkfgAffokR+3w1tpUoCXLor1OaSIlB8VzQ2byfieNwrT
	S/AAFegaytI9tlyUPlX/CON7Fvu9KCiPLgZarMzUnVd2UXG+tq/0tvQzHbB5vGY7XiKDdwC/X36
	xmE7fvm3JPx37NcZD43L2OKAu8fDkXdRqAkKBqLsX1Q4Qj8t3U+2A95tJ5wb7HM/a3aaXs4gDzB
	DZU3zuRkWEUHNz6ajz7AE6Pvz9fBdOrjho4WlETG32jz6z+EybpiBcmzYst9Vnk8cZj6cW/4IDl
	gPNiYbmMHwNDsRU/60K3goKvVmt7k=
X-Received: by 2002:a05:600c:8706:b0:488:d6eb:e635 with SMTP id 5b1f17b1804b1-488fb753abdmr66604615e9.12.1776453637660;
        Fri, 17 Apr 2026 12:20:37 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm61147675e9.9.2026.04.17.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:20:37 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment
Date: Fri, 17 Apr 2026 19:20:36 +0000
Message-ID: <20260417192036.268452-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-238513-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B23541E379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smb2_get_ea() applies 4-byte alignment padding via memset() after
writing each EA entry. The bounds check for buf_free_len is performed
before the value memcpy, but the alignment memset fires unconditionally
afterward with no check. When the EA value exactly fills the remaining
buffer space (buf_free_len == 0 after value subtraction), the alignment
memset writes 1-3 NUL bytes past the buf_free_len boundary.

Add a bounds check before the alignment memset to prevent writing past
the authorized buffer space.

This is the same bug pattern as commit beef2634f81f ("ksmbd: fix
out-of-bounds write in get_file_all_info() for compound requests")
and commit fda9522ed6af ("ksmbd: fix out-of-bounds write in
ksmbd_vfs_get_sd_xattr() for compound requests"), both of which
added bounds checks before unconditional writes in QUERY_INFO
response formatting.

Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/smb/server/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee32e61b6d3c7..407173d2175af 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4821,6 +4821,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		/* align next xattr entry at 4 byte bundary */
 		alignment_bytes = ((next_offset + 3) & ~3) - next_offset;
 		if (alignment_bytes) {
+			if (buf_free_len < alignment_bytes)
+				break;
 			memset(ptr, '\0', alignment_bytes);
 			ptr += alignment_bytes;
 			next_offset += alignment_bytes;
-- 
2.47.3


