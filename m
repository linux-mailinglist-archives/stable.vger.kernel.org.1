Return-Path: <stable+bounces-230694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JUgEDW9xmnoNwUAu9opvQ
	(envelope-from <stable+bounces-230694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:24:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BEE34844B
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7125B30A6DF8
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B6735E94B;
	Fri, 27 Mar 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4xmMvZf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350D352C44
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630999; cv=none; b=GKkq+FUXdUj+TJUdrCAjQJHlxCXPu7pGIi3/e+ld86/FTDasUymgWj8hWZgSHQL1t4VsBJ+WHgnM957ATlwVzGZ5q5ity8pvf99NCbFEGWXL4EwUAN9c9ZyGb9Ggyq90KxXhgt0dPXsejCeOBv/NKlDEzH1fSVf/1m28s0Gry6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630999; c=relaxed/simple;
	bh=XF387l1iSQ3JkQCBcOvMlB0b0a6/XXCleJmbhWho1Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPf3hjivPPm+xxEfZ29nBUK1wrgz4Szv9AIJRwlW2MK4LifZFdFXm3aiKZHq6A6IjRJdVuwoZauLEr4zcQtiSJe7ZuZhfXjeCO6Vcdgt+oCROgbCNU4PRj17n6UV4dj1QvYZvNEKsvvK3kPUCHXTVz2j1973uc3z++qjohZw4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4xmMvZf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso20616895e9.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630996; x=1775235796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGa1Fe6pEa0kmcSO0r7Ez3fp7Jynbk4KITXYq/Ow8IU=;
        b=S4xmMvZfaAhYK32nf8aC8DHDGCmGMc8jKvoAQ1DHZwH6rsDBlpZfMemJHAYg24LZR6
         h2T83CRRdveIrK0pnsDKVlQHF64E+3uv4d9rmzMCgtuYCPlr/2QhwSuA+X7YroAyF9iq
         i8E//rnRn3J8Bcx81xOHZ2yGu7h4+0bZ1a6RqOBTCBH/jAjTy0cSduEaF5OKyiYfJcHP
         JQ/YKOaUQknaGGoACVF5UdQ9rl/0HvkqBFq5zWmPuFH3Qz5ILF4YBfJrC9fvSjELGiKh
         1fDUCbraX1id9hFB/3yE4JBG9h32EyUSLBtwcf3KE0jmi35yaPFznlvmYvFCj4XDxf1Z
         j0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630996; x=1775235796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGa1Fe6pEa0kmcSO0r7Ez3fp7Jynbk4KITXYq/Ow8IU=;
        b=kw0jxCaWTNoTjMmPUhSPOykCkikzsOCdDGxrdlg5icsmJoStzPBVc3Dc825ZV35WQp
         vu5snw8kOkwfAbr0EFEqg9GAUQ0w9n+vl8JgfRQlT55fzk5TvBPlyk9yQ1TauMTYN00y
         laBmbaNiY6bEgru+3I8P4mopAJD5IZBINEeB/ZNEJVodiaAq79RN5j2C4BQn2945F7le
         QCieM0F3KP3fieBqh2tv6uLjMAfN7Z/hJxdPzp1J0yGctdym34M4llpvo0WSSXzqCRUq
         DdbFn1+NlePrm8qDP2t90VY83xn4vRszGJikZwth2zeriNcERg+gakfT3nnyOwhyWcRZ
         kUWw==
X-Gm-Message-State: AOJu0YzPcCLfEhTKnaMgoDPio2FTEo2MRuS6/PF19bCq96G0criEais4
	oDvmgHkmXo/FHGiGa2D+02o8UKnKP3sTw2IYcOHOskEelqZciFf2v0T+zvqzTYe7
X-Gm-Gg: ATEYQzxbqvhZUiEkmgQ9eKiJteTpfsgUuLEzw0Pha8ihEfla3ZLNJVlxx2rJ+SFggFi
	TXiC5pFqFOJc7C7epM8ywj2XTTDgyWZGXrYaHj3Fo77RiZF+h3QYB2LkpmJcN+5v2PTjoFoWxAM
	S+MLEN2/wOK8dGkjinHq1mqSlTJAYt9JxWeD05ZCH8A1GWNrmijqShiKlfhnfu8n6aYxQzVOcv7
	zSjEv4mmeLXbKnod7K1tUQep0+3B+YGgXjtW8CSnQRgE4m9FvDoxmaEUUwF0Wh9oGqiWAp1bFnI
	CtPGRsjtOhYl7BjPNsZaj+NZN+QyrxY+s2WUVxTjQHqE1hmX3IgxyBlEif5OTKG8Mk6wG05gf7a
	XdOmBK6Nuwym6WUn120qIk/JJyOejDADhATeE7/L4rHcpsEensvbNFb8E/b8zc3iAcAoRxBGNEX
	rM+oWP4FLsEJZ2R5lxBg==
X-Received: by 2002:a05:600c:1f11:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-48727d5a31emr58021875e9.7.1774630995986;
        Fri, 27 Mar 2026 10:03:15 -0700 (PDT)
Received: from tux ([2a00:a041:e07d:7c00:1ac0:4dff:feb8:fd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c65989sm164553475e9.2.2026.03.27.10.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:03:15 -0700 (PDT)
From: Liav Mordouch <liavmordouch@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	npitre@baylibre.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vt: discard stale unicode buffer on alt screen exit after resize
Date: Fri, 27 Mar 2026 20:02:04 +0300
Message-ID: <20260327170204.29706-1-liavmordouch@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327160050.31631-1-liavmordouch@gmail.com>
References: <20260327160050.31631-1-liavmordouch@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230694-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[liavmordouch@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52BEE34844B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When enter_alt_screen() saves vc_uni_lines into vc_saved_uni_lines and
sets vc_uni_lines to NULL, a subsequent console resize via vc_do_resize()
skips reallocating the unicode buffer because vc_uni_lines is NULL.
However, vc_saved_uni_lines still points to the old buffer allocated for
the original dimensions.

When leave_alt_screen() later restores vc_saved_uni_lines, the buffer
dimensions no longer match vc_rows/vc_cols. Any operation that iterates
over the unicode buffer using the current dimensions (e.g. csi_J clearing
the screen) will access memory out of bounds, causing a kernel oops:

  BUG: unable to handle page fault for address: 0x0000002000000020
  RIP: 0010:csi_J+0x133/0x2d0

The faulting address 0x0000002000000020 is two adjacent u32 space
characters (0x20) interpreted as a pointer, read from the row data area
past the end of the 25-entry pointer array in a buffer allocated for
80x25 but accessed with 240x67 dimensions.

Fix this by checking whether the console dimensions changed while in the
alternate screen. If they did, free the stale saved buffer instead of
restoring it. The unicode screen will be lazily rebuilt via
vc_uniscr_check() when next needed.

Fixes: 5eb608319bb5 ("vt: save/restore unicode screen buffer for alternate screen")
Cc: stable@vger.kernel.org
Tested-by: Liav Mordouch <liavmordouch@gmail.com>
Signed-off-by: Liav Mordouch <liavmordouch@gmail.com>
---
v1 -> v2: Reformatted as a proper patch with commit message, Fixes tag,
          and Signed-off-by. v1 was sent as an inline analysis + diff.

Note: writing of this patch and analysis was assisted by AI for grammar
and flow. Apologies in advance if anything reads off.

 drivers/tty/vt/vt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1907,6 +1907,7 @@
 	unsigned int rows = min(vc->vc_saved_rows, vc->vc_rows);
 	unsigned int cols = min(vc->vc_saved_cols, vc->vc_cols);
 	u16 *src, *dest;
+	bool uni_lines_stale;
 
 	if (vc->vc_saved_screen == NULL)
 		return; /* Not inside an alt-screen */
@@ -1915,7 +1916,18 @@
 		dest = ((u16 *)vc->vc_origin) + r * vc->vc_cols;
 		memcpy(dest, src, 2 * cols);
 	}
-	vc_uniscr_set(vc, vc->vc_saved_uni_lines);
+	/*
+	 * If the console was resized while in the alternate screen,
+	 * vc_saved_uni_lines was allocated for the old dimensions.
+	 * Restoring it would cause out-of-bounds accesses. Discard it
+	 * and let the unicode screen be lazily rebuilt.
+	 */
+	uni_lines_stale = vc->vc_saved_rows != vc->vc_rows ||
+			  vc->vc_saved_cols != vc->vc_cols;
+	if (uni_lines_stale)
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+	else
+		vc_uniscr_set(vc, vc->vc_saved_uni_lines);
 	vc->vc_saved_uni_lines = NULL;
 	restore_cur(vc);
 	/* Update the entire screen */

