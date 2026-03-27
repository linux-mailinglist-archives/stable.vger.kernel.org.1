Return-Path: <stable+bounces-230693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPzyNoa4xmnoNwUAu9opvQ
	(envelope-from <stable+bounces-230693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:04:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5F348026
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF3783018777
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029635B65F;
	Fri, 27 Mar 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO/YDPnk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB237271A7C
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630593; cv=none; b=R4rCbNB5q6AsR2oRdpDCap8ugkyFyJkOXzZUBz/kEZsagJwsMbA+3G9dCMGp7pDcvSequ1oEzjDKDoPwrqxbIm9w4ITqG+f0adbAEb39FdbUQ/EO60NhEqXD1t34eHfAMmwbhFj0eDQgfDpRuWB3F4uw3/c5+39ZdEDcSc7rHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630593; c=relaxed/simple;
	bh=mW82cped2hCiw5sDJqn+wjxsIZQeXzzzX4YwQALG0Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+UO1VUjFGxtXdr7MYheSKhxgHkD493MMM9OmRI4iQndGHPD2W5SXY7UZ6k6bB2dbgMX3gGFmxzouw+ZCaYzmGOcMNjBhHV+v+5+hEq5PqQWi69oeIh2I4ztMX++oe0ZFAV8tMFYOkVzO368lEWeJXy/BM0ruPJYRCOAfVq6uOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO/YDPnk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so22595805e9.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630590; x=1775235390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsJ2oBBJ557jnH70rKnLDSkb5/BQjqsRz3QFg17o8Uk=;
        b=lO/YDPnk50RG54B1rqITcmZBB+OEx/AS9CfT6JdmYz2tuz6BUIy1jmB2wp6nIClsmQ
         Mh9R2MqS8zgv3ZV8WZfRyPObzLtjiAdQC2mITFzmj0TFbFxhBPOKCMJEhxFqa/m4JbPQ
         dpWl1KgYWt+IJ4NJBCiIt2puKauptx5QlCO3t4CWPBZYkmL2thXjkaHp0yHWkUqXUGg/
         41ztQQeOM/BJX0sTcAcYrxEWMg2tqYFIbVMm6p+c9lHGwtC/w1TfMjWngpJ55LMixTos
         a0hTaaToOk528SNsqWkpP4Qgk+tSLGhIPHq/3uHf1MsGIeqVLkWZTennFkGec9RYtRqG
         G/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630590; x=1775235390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsJ2oBBJ557jnH70rKnLDSkb5/BQjqsRz3QFg17o8Uk=;
        b=KvI+GX8JNPidkkxxSvO0FEHY7oVnZFuviLWTcSdGzW6m+Vcnw5FN1vqwJtR+CsVpCh
         c0OvkOJxQ/L+sNe+PrY5XGRYtTKvRj+vf7zoc6McXn3ETKIYQTyfW1KNtlnVWBzBFpL4
         8efkxrTCUOVeYZoL6PDB5rHAjqGlUwi3wTRiYxuf1iaHrMF8884fR803wqGc8jCUnb37
         +8oMvCFT2fCrqadZl6LKOzfmEFgXLLyV0NkXCCJ/5qJO9f85I7FztgltNDkZ2junRgN8
         2knQRPvxgA9xAQzWhsxAEjZUB+jDSv4A4Xof3whVwEZsq9JngUDJZ3bBxyBWiPVEGB/m
         jdDA==
X-Gm-Message-State: AOJu0Yys2Y1IFXRUcV2yjdUOPM8jF8sKLkbh0RDjoZKL2Cp0I1EUsKPd
	kSupLWaFSVVmnc+EwcZT9HFZL6KHGGr1PjZJT51pGS0y1FQs2fcFsJ5f/sVuUiUw
X-Gm-Gg: ATEYQzxmHXQjlFPYCYGay7eptMhdDU/e7jyvcZokqq1ZWLIs70l8yGW/Vy0/vFWrdFB
	s8DjfQItNZ6NRtFQ5heNL6jcj4nWpX+XXRGl1w01EDGJmYEFvC5ysJz8wjo+UWARfqbp88YpSnd
	opeefCAoYe78OB+cBdOeqNYkdIS1eA0gNYD1V6evoINj9oUpqe0KTJAjAi35zkqgQT1wTIN4TJq
	9rXtKrrzHJeCI28mmzvGm6q1qibPWBjNbz2pLzXDy9eVzLuOJ74O4yXVhQPQryC/SDS5IaViRWK
	k3Nvf0fJ3ggQ8cX7SEdFvQ+2+fFGvmt/Zya7mftEH9jaanS+JIl520cMNxhAIf8/oVQpvBcIz4R
	m/XN9vegh0c4rnyZjbsjfNJ18CCE80Mz8lVuCo5WjpRmqa1TXoPxtBvLoyNUQnfv92rAnFZbzho
	hfBMS4KjnYEMzf54BEfA==
X-Received: by 2002:a05:600c:c493:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-48727ef0b7dmr54779745e9.23.1774630589574;
        Fri, 27 Mar 2026 09:56:29 -0700 (PDT)
Received: from tux ([2a00:a041:e07d:7c00:1ac0:4dff:feb8:fd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c845b8sm95410675e9.4.2026.03.27.09.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:56:28 -0700 (PDT)
From: Liav Mordouch <liavmordouch@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	npitre@baylibre.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vt: discard stale unicode buffer on alt screen exit after resize
Date: Fri, 27 Mar 2026 19:55:18 +0300
Message-ID: <20260327165519.15969-1-liavmordouch@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230693-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0A5F348026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Following up on the bug report I sent earlier. I've done some further digging
and found the root cause, and I'm including a patch that fixes it. I've tested
it and confirmed it resolves the crash on my system.

Root cause analysis:

The crash I reported in csi_J is caused by a size mismatch between
vc_uni_lines and the actual console dimensions. Here's what happens:

  1. Console starts at 80x25. vc_uni_lines is allocated for 80x25
     (25 pointers + 25*80 u32s, contiguous).

  2. Something enters the alternate screen (\033[?1049h). enter_alt_screen()
     saves vc_uni_lines (80x25) into vc_saved_uni_lines and sets
     vc_uni_lines = NULL.

  3. Console gets resized to 240x67 (amdgpu fbcon takes over). vc_do_resize()
     checks "if (vc->vc_uni_lines)" -- it's NULL, so it skips reallocation.
     But vc_saved_uni_lines (still 80x25) is never touched by the resize.

  4. Something leaves the alternate screen (\033[?1049l). leave_alt_screen()
     calls vc_uniscr_set(vc, vc->vc_saved_uni_lines), blindly restoring the
     stale 80x25 buffer. Now vc_uni_lines points to an 80x25 allocation but
     vc_rows=67, vc_cols=240.

  5. Next clear screen (csi_J CSI_J_VISIBLE) calls
     vc_uniscr_clear_lines(vc, 0, 67), which iterates 67 rows with
     memset32(..., 240). For rows 0-24, each row only has space for 80 u32s
     so memset32 overflows into adjacent rows. At row 25, vc_uni_lines[25]
     reads from the data area (past the 25-entry pointer array), getting
     0x0000002000000020 (two u32 space values read as a pointer) -- page
     fault, crash.

This is confirmed by the registers from the oops:
  RDI = 0x0000002000000020  (bogus pointer = two space chars)
  RCX = 0xf0 = 240          (vc_cols, count for memset32)
  RSI = 0xc8 = 200 = 25*8   (byte offset = row index 25)
  RDX = 0x218 = 536 = 67*8  (loop end = 67 rows)
  RAX = 0x20                 (space character, fill value)

The same faulting address (0x0000002000000020) showed up across 3 separate
crash boots, which makes sense since the memory layout is deterministic.

The fix: in leave_alt_screen(), check if the console dimensions changed while
in the alternate screen. If they did, discard the stale vc_saved_uni_lines
instead of restoring it. The unicode screen will be lazily rebuilt via
vc_uniscr_check() when next needed. This is consistent with how the regular
screen buffer restore in the same function already handles dimension
mismatches using min(saved_rows, current_rows).

I added a comment in the patch explaining the non-obvious reason for the
conditional -- without it, a future reader would have no context for why
vc_saved_uni_lines isn't unconditionally restored, and might "simplify" the
code back into the buggy version.

Tested on my system (Gentoo, 6.19.10, AMD Ryzen 5 5600X, RX 7800 XT with
amdgpu). Previously crashed 4 out of 5 boots, now boots cleanly with the
patch applied.

Note: writing of this email was assisted by AI for grammar and flow. Sorry in
advance if anything reads off.

---
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

