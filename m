Return-Path: <stable+bounces-253853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPozGmzHEGoudgYAu9opvQ
	(envelope-from <stable+bounces-253853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:15:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D559F5BA475
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DD0B3017F9C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD04346E64;
	Fri, 22 May 2026 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjWIVnS+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9B225788
	for <stable@vger.kernel.org>; Fri, 22 May 2026 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484521; cv=none; b=AO4qEBBUpYIt92HMez9LT4JzXETmPGuP6eX5fve0oeuqu9ZpgzveYpjx4BaQwnok0Xqwu5HZWbRBZAEnvoaY2TH3dujrC+jo2SC2dUhhZSSwOX/e3WlMSSYX1ez8/hq6Zst9Mx4brED6jiFMe9J6+mlHZ00ymlXrDDmQYVpzjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484521; c=relaxed/simple;
	bh=0bQw2teXIDcwN3yYNKQ7goKkNy4catNzdl4bx9r8JhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vubxd9VduzK21CT6ZmTnOK6w13SkoCo+MzexRUiaIq5Tj2Aqth7/HnOWpj65HpSCa+Gl7ocJNfBSus30qFZHVq5DrAAr0o+YoVaOUg37Yy6FSIPGmcHvujY5dSvuTZkmgJ7cpGulcgk26fYLFtMrUeunEXPhUEvFNxswtPUD7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjWIVnS+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso18585455e9.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779484518; x=1780089318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4E9RiNY5xxeH8v0CHIC9N3hVDQi7OzQEt/odZrgvSk=;
        b=BjWIVnS+4iDsOZHuOvx7rVAX1oR9dESF23xWClOqOt+gwrrUwH9vYVIdYHpTT1fQuZ
         NkD91LEAILe7823YFbStEOdMOxrtK91OH5KuUML9pfeYjr46inRAbUf+Yhr8I6exRgnG
         B3KGpHBbX8uk4XrU5ueDs2UFSYJbhStOoLcANX4Zt0ZivWIBXNFQu1KMjgW9XLgiDW4T
         sSd9D6QgB/hy1Ev3a5SUvhKM/KlXK+dtq9ufBLFVN72AxM09xp1zGcdkD08he6PacF9N
         nT/o62lIpIJJCZzhYtwOEBXe4gGOSmiCeUfSoZ9ZyJ1P++DXxt9xL+eXNr4l/cJmHKFD
         ehzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484518; x=1780089318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4E9RiNY5xxeH8v0CHIC9N3hVDQi7OzQEt/odZrgvSk=;
        b=hXCme2mlirlpjt8iMt1nLYqoI7TY/ZvHqGNjs6XM1KFutonUXSh4qq7g3KvVVYn4M2
         u1Nt5kr8FUZPj6jfn0o6XxaEci/nMg7JxcHuE9NvkE7CxoXcydEhYTNv0SCItqZP2xUE
         cKgdFLRw3XPXoUI6fDdAZhmCreAHHQuf8TKrgQG3x6KxTG1Jx4tMXT4p7PMtV7d4LVPo
         wkyZIGcYcg+90cgSqT1kQ5Fa+lZ1X8Py9vMQOcevVJVdWU49sy0S7oTI+uXl2ne1tfbF
         K/jvD+u+qdXzCIW7wyaQDghnylrTDxk9v+KlbFx9sZRMj9v2ezaFORgPCXc2eF701s+T
         VQiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qUculC+F0pcWu5oRBUx9GAe0KQ5xrDrsUjQ/lTWBzaWNqZvb1vwSc/eZg7zgla7BBCBRhS9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvAaLNZ3UTxmd0YJOmyRk6xBSX9W6hR6YQ3qE58ocjigxmlV/
	HC+duJT8aLN8BlOz3icxh6s8xb85yJBsurL7BAzguigAASGyRx9DaUOp
X-Gm-Gg: Acq92OFPDvWcuKVmc7DAhhNNy1HlxLloecH0Vb4E5smN2UMv9jubo7K14RSOLGbC3da
	l1prUHYOl0J6FN3FxVbaMs2wwJ8YBvQsbYjZ6XYBFuvMEC+yPtHjkrcXXoF9JjJfVliZwMmu7qn
	hLk91pXswfUNZ5cRsFM/RRkacudgCjIEQ3lWgSwWpcmlFYmsiEURvgGjJQleHRVGN5LdAM+Mbr0
	aiD2Y19Pl0a5TQBgxap/oksO0VPWyRATDWEWb1zmiSwm1tKR/TFN9TxZiwMUtIogNHg1xUGj6Z/
	Gej1jvU3CiB9N8Vpnu/Ij/dJ1vLIjsnBtdaGH//8ftkBzsWF/17TR/rZLpucz97LeeDevyK1eya
	bdfGv1GsouBW9QJBLNLuatc08eZxXXNCSQ/tQHwMpiJauBxtLRy5nL5JcrwU7pwsgUCxnII4eCA
	5wB2pfZ3H+orEvB9xBVBt9CtUlwAhJjgZN9QSq1qGQA+snljecvsihkCBdtvc1cFTSkSR9v88hZ
	7dSgE34NrT1o6N5WDASkGTB+KdbEznTNfcTP2v1ujs/OffQL0a07KNdnRFZnrKlfTnmga2qRPg3
	h7vqTYaQPLriGEOBafKz843oSwBMeoTfbkP3LTX+pw==
X-Received: by 2002:a05:600c:4ecc:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-490426cd8a4mr74193815e9.21.1779484517821;
        Fri, 22 May 2026 14:15:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ada3-3901-ad33-2cf3-cf37-617f.310.pool.telefonica.de. [2a02:3100:ada3:3901:ad33:2cf3:cf37:617f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49044775266sm22135525e9.33.2026.05.22.14.15.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 May 2026 14:15:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linusw@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] ARM: entry: use byte load for KASAN VMAP stack shadow
Date: Fri, 22 May 2026 23:15:03 +0200
Message-Id: <20260522211503.25219-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,armlinux.org.uk,lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253853-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmehltretter@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D559F5BA475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 44e9a3bb76e5 ("ARM: 9430/1: entry: Do a dummy read from
VMAP shadow") added a dummy read from the KASAN VMAP stack shadow in
__switch_to(). The read uses ldr, but KASAN shadow memory is
byte-granular and the computed shadow address is not guaranteed to be
word aligned.

Booting the QEMU versatilepb machine with an ARM926EJ-S CPU and
CONFIG_KASAN=y, CONFIG_KASAN_VMALLOC=y and CONFIG_VMAP_STACK=y faults
before init:

  Unhandled fault: alignment exception (0x001) at 0xb91037f6
  PC is at __switch_to+0x64/0x88

Use ldrb for the dummy shadow access. The code only needs to fault if
the shadow mapping is missing, so a byte load is sufficient and matches
the granularity of KASAN shadow memory.

Fixes: 44e9a3bb76e5 ("ARM: 9430/1: entry: Do a dummy read from VMAP shadow")
Cc: stable@vger.kernel.org # v6.13+
Assisted-by: Codex:gpt-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm/kernel/entry-armv.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index ef6a657c8d13..a3d050ce9b79 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -567,7 +567,7 @@ ENTRY(__switch_to)
 	@ are using KASAN
 	mov_l	r2, KASAN_SHADOW_OFFSET
 	add	r2, r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
-	ldr	r2, [r2]
+	ldrb	r2, [r2]
 #endif
 #endif
 
-- 
2.39.5 (Apple Git-154)

