Return-Path: <stable+bounces-256459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEzODmjuGGohpAgAu9opvQ
	(envelope-from <stable+bounces-256459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:39:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9765E5FC0D1
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7672E304CF60
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0A35E1DB;
	Fri, 29 May 2026 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJcoYQ5q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7737352F85
	for <stable@vger.kernel.org>; Fri, 29 May 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018781; cv=none; b=Oh+rbUT8CYJuIvr9Fn6oGxDQ30WEwuC8513eK4wm3GaJBC41laAeI8Lqw6yDUjkSy4/fqHzUbKgzCWASZx0Lo1lqtD1loua6M+dP4vQ2s1OycdAExKvpyazI6rLEi8DaxyxB7+nLbZWlSdbx2gOahXmbQubrBafuYq07hJjGrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018781; c=relaxed/simple;
	bh=R+b0dMhfdCvXX7tTYJwUEr5LPeqp/sASGbu3bzIUePE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ETWkegu726e7V8lLksDxD7gRO14zFjDnBQAuQPa6H2Fp4vpgytIikBVw5DfTD/pEJfrDqJxLp968ZW5S8+ZJZRs2rGV3tnNIRIyPoTlrMzZG6wm2u4xqC/DeJhnM1Kt+7PPaIPEmNTdx/hjJiyy+jXywPBd5AkVsrldknAmPEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJcoYQ5q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so1127703a91.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 18:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780018779; x=1780623579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YrQLWRT7P2B9ehvuGmHa/4OwVk6y3qDhXkQzP89SaE=;
        b=pJcoYQ5qtLVEvR/ixH93dqH8N3M/GTcUT/kvHVdzP7+YXGAvuaKptS5HoHhCy6VAND
         gVEG/9uNdQSWYLsOSVEhhdLM0MA9NdHtQx5eK5nnqg9DxCT6V5NVRqx5Rh6TRLY5nmVI
         73etQROo6KN2I2koDznmggM+VnrJcq5Vhny17rWW3tVvL8XvGEyYC4O5fYHFlzyL4pcw
         P9zJ2BdVoggvp/aiLs2CCcLxgFBo9QIG8dndvumSboSF9apadW1JP+5On9oujpgHY/eI
         zCvWGoZVZAO9/WS0/K0zpajvbR1xekZp6qXpce/78yDEs2KP2ODakZ7pWtWb2RejU6RL
         iQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780018779; x=1780623579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YrQLWRT7P2B9ehvuGmHa/4OwVk6y3qDhXkQzP89SaE=;
        b=J+yEktTBAuAQMreMq0DDYY5PuRxSTZXWGoNcAGlxP5E/1y+zlEQwwuIVn/gbZtZjAE
         jMhfAxBrsGJgErb8aZq4vbJHC7X1lp/BmLd40/wD+UmDXwrJyxywCYimV5OUZjD0kSBK
         oernI3rcyEf8GCooYuZJhZc0CGOw8nNV6SjVsOYISOaHBGCjANkJzBs/52tNSUqMsWzZ
         dXW47c3fjgzgzinL49ic6XcWeFlggv2WHrSlBq7p4hvuYg1ngo3KMY2qRI47kyosRQ8X
         V00pMwKt26gpBF7x/OgYzcpI+cYNRMa+bs/kzonoGwJMs4Cuxns7v9YoZNCJz3pBleGn
         50yg==
X-Forwarded-Encrypted: i=1; AFNElJ9ltEScxnbJiczYG4DXSKzvqoz+QfL0yXOb0+d8eLlHU5X0OFFtMCJZTzSZxiVmnI66Ip+EMFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAfg1oWYNxLkW8WU6I3yJ5scplKn2JKzPcY7Vfs4DD410wuyU
	vhkxf0KyXMa+3i1VqxFcEqhjk2OlDSgXpZrZJ7XikxAxDT55mdJ/0nbc
X-Gm-Gg: Acq92OFZY7jQX9zi3ziLMBL29Utu3Xz8K3kvKv4lolIUhsXiaZ//2eZJE+lm7MBC2mR
	PxQbKJaKmvjmBqlRfoMNZ8uV3rp8909YF5IbZQMJN8JD0xIMliV9nxDQ6/Xe6TEqmP9JQB9/AMw
	a8EPMCp/lIZ1lIOn1K4X4IthOe9tRor7UqbDJqvA3Q5cke/643ZDj8E+xlyJ2SaX2tkRfFVjZLM
	vOLpe7VJivjNcyNJoIc2A0phItgRCqnEuP9vzn6hoQDGJb4DmDUb83N2R/z/JXKvq68xnOwP4Wm
	5Ybp9c76UUdrk6pnrUzXtL75URNFj3qxh8kqXyOp+V2RS1yMFjdylzqowO1HLzgZeeP9fcBjAoE
	zretFMH9UiyhGF9Ymn6cgI1/fXIaqJA03aT8Cn71hEeYRMMwW79m58PHd/qHoy1TboU98FDgurH
	B6g++8EU3RhVLT6iO9wfWKjW1teXPgM2xwFsMQu3EjHIp8HYE8dP4FEiyKQaqclpU2Zq5yxTKx3
	4ah4u0R
X-Received: by 2002:a17:903:2283:b0:2bd:8dbb:293e with SMTP id d9443c01a7336-2bf206324f5mr10817595ad.14.1780018778908;
        Thu, 28 May 2026 18:39:38 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([120.236.174.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e7019sm721585ad.11.2026.05.28.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:39:38 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH] Input: tca8418_keypad - enable overflow mode per datasheet (SCPS215G)
Date: Fri, 29 May 2026 09:39:00 +0800
Message-Id: <20260529013900.43854-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256459-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liangzhan5dev@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9765E5FC0D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver currently sets only the overflow interrupt enable bit
(OVR_FLOW_IEN) in the configuration register, leaving the overflow
mode bit (OVR_FLOW_M) at its default value of 0.

According to the TCA8418 datasheet (SCPS215G, Section 8.6.4.1
"Overflow Errata - Description"), both OVR_FLOW_M (Bit_5) and
OVR_FLOW_IEN (Bit_3) must be set high for the overflow interrupt
to be generated. If only OVR_FLOW_IEN is set, FIFO overflow events
are silently lost without notifying the host.

Fix this by setting OVR_FLOW_M alongside OVR_FLOW_IEN in the
configuration register.

Note: I do not have access to hardware to test this change.
Testing by generating 11+ key events without reading the FIFO
would be appreciated. Full handling of overflow events in the
interrupt handler is left for future improvement.

Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 68c0afafee7b..b124e576feca 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -254,7 +254,7 @@ static int tca8418_configure(struct tca8418_keypad *keypad_data,
 		return error;
 
 	error = tca8418_write_byte(keypad_data, REG_CFG,
-				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_KE_IEN);
+				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_OVR_FLOW_M | CFG_KE_IEN);
 
 	return error;
 }
-- 
2.34.1


