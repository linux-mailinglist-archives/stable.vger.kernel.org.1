Return-Path: <stable+bounces-243899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGaPKsPr+Gmi3AIAu9opvQ
	(envelope-from <stable+bounces-243899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:56:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 425044C2D0C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729D9303DD21
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DEC3E63B1;
	Mon,  4 May 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhEnL2ps"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795B3E7140
	for <stable@vger.kernel.org>; Mon,  4 May 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920897; cv=none; b=HF3IMxeBUd25aOwwMTPUuLqXjZZnU3Qwh6eJAJPR72t68cnXRLiDCnpGfyVIn1WQdoYZV02M5e/R7+46TgfMnAx2dVpVwz+115B1dx1Q7G3zHFUPHYB7RckdsxQoLNRlDbLlAooUZeBzZrZlXNwIdUmFiU3k7VCreULeVZjigls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920897; c=relaxed/simple;
	bh=X6ZP4AbUQhy+1vK6aIjWYBb64FGoaXW4biQJ9vXhYmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXVKHfZwIqnPMtmUDj6mzI2jdfiKswAkGz3fWymg0ImPKddLgqd+5hqorYR4FM2hYf4yctDgaJyWVjq2UFVWJmLu23EhTdTvAGulI52WBxiaJDCwyAMiUTZ6Y/aa1mRc0D/ULgXTfZNLeNF2vqigle/qeNQm/UMw4KBEp2Cz+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhEnL2ps; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so10320025eec.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777920893; x=1778525693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW2xmDUvOx56Zunc2V2z3nQF+PhXC6PyTRu9F8brLyc=;
        b=OhEnL2psm1IRKY7LoVKxmvCGv/CRp3EjHaUjIu6k97BBg4sWDPBkbyP7RGN3eZ7Wgv
         cGGeQyg6ngfKOt6Eb3Ht/YCGXhgECWm8sXjyMbq8VFnNuOEUU+Px6p+qS6m1cKibQ25y
         ueLRc/1E57bOBJFYU2ljquV8La3AtrXj84bQkADu2SavoYQ4CAoWbRhkC4mIkHNFBD1Z
         riXiRZSXBr6cWKb0FlNxU66OpDP/wmngwoyq+iKyicDjAPGCs9k1XsJpRh8yLuUHq5V7
         V2TuXAGJFjqzzNIUa492UgfVSsBCvH68UexUtjC5SZ9tzzB/u59ArEs/yxd2cUVF3el7
         zuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920893; x=1778525693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW2xmDUvOx56Zunc2V2z3nQF+PhXC6PyTRu9F8brLyc=;
        b=VQNE9swY25cDs8IsjQldqkkEsSo9ACT/Bhpu8BaQeeS8fviFVAh7aYVWxFLEw9P8qD
         Li65n26OBn/sZSLH1yG9KjxeXZSLWqyNt6q1Fh90e8sbaEQc9e5/rsXIDCdb5cy9A3r+
         ldJRkbMjdmqoTxsMaSES+Fg3FVJ1+P658KAxX8HXD2hlnv98e1DMEMZpH7bvCTfKdmEF
         4Er6GNzDEF48LWDmo+5jRmuviLng4itS3KUsa9c1q2NaTJ65oYlLM5vUC+nqJ4wN5wNQ
         9Fn/Y1XoTLAL827itJwEZwvFrgOpnEnHvS4c0zaVAN4C57cykG8dYx+HrHguCtbYig+g
         Od3A==
X-Forwarded-Encrypted: i=1; AFNElJ9jGNT85z7D+8ktpvojozz3Hhiz21OZ4H6Fu93C5XTS0Buq0ODxTQEVZYMDZr8PCm3bUzjILOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrvQZBqPUxBAIS0yGAqOiUevvwt1zegWz//hjoUULTchhOeaz
	kKBgMiXJ65vDgIpmgZTLkgw09W8AA8PsnCbIk/m9lqjFgcwZZkxGTBy3wNceLA==
X-Gm-Gg: AeBDieu2Hth94MSsni1wqs+p82LOJo2VkzbFLKkXbULcd/r5o15ZOU1wW2LNkJ+ugQf
	KQuPCqcZ/eUlTX0U+0h1xzT9x2sazk/t7k6eanHYfokZlYGqdNBBD5OHN7swqj3QzTE1SR4ocSJ
	NXI0EoVD0YxaYeRtXtpE5SUjb1UGcLqLlCgtqmnWaEawcTz/0lv8dxp6wFZQn1/k7FeaWiHsTGf
	qyIF8r8mI5O2n4mS9b7BP95Yk9F7QxQ+CjApqIXMuHRLQkbEQwI9JZvXQoSdEde5CR1ItIioNmE
	ZIbjbSwedtP4fkh/bPjlasa30RY04a+ncUEKt8JONobPIl1lfhpH+Jw5osqfSFakMAPALfxUhmG
	iZBj1nLJlyHb0XHb8Ca6tGllDLIhFl7J3kdKGLIkTSZgl6ey9WkApz44yfA/4lahsjQ0LVhz4/e
	YZsatyXajuh0jxcNARlQKk95+v62uAGZkedhcbIlns2OIzukNrYkBnnmxnbxQhGL9RmGGiZO7Kp
	+jDdVGc7j1ZZ81W3LXiQog05A==
X-Received: by 2002:a05:7300:2316:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2efb7ad86b0mr4848561eec.4.1777920892917;
        Mon, 04 May 2026 11:54:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6812asm16830718eec.28.2026.05.04.11.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:54:52 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Dyer <nick@shmanahar.org>,
	linux-input@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem
Date: Mon,  4 May 2026 11:54:45 -0700
Message-ID: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 425044C2D0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243899-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When a configuration file provides an object size that is larger than the
driver's known mxt_obj_size(object), the driver intends to discard the
extra bytes.

The loop iterates using for (i = 0; i < size; i++). Inside the loop, the
condition to skip processing extra bytes is:

    if (i > mxt_obj_size(object))
        continue;

Since i is a 0-based index, the valid indices for the object are 0 through
mxt_obj_size(object) - 1.

When i == mxt_obj_size(object), the condition evaluates to false, and the
code processes the byte instead of discarding it.

This causes the code to calculate byte_offset = reg + i - cfg->start_ofs
and writes the byte there, overwriting exactly one byte of the adjacent
instance or object.

Update the boundary check to skip extra bytes correctly by using >=.

Fixes: 50a77c658b80 ("Input: atmel_mxt_ts - download device config using firmware loader")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d62bf2c95578..28b2bd889c70 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1503,7 +1503,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 			}
 			cfg->raw_pos += offset;
 
-			if (i > mxt_obj_size(object))
+			if (i >= mxt_obj_size(object))
 				continue;
 
 			byte_offset = reg + i - cfg->start_ofs;
-- 
2.54.0.545.g6539524ca2-goog


