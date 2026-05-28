Return-Path: <stable+bounces-256437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN5GOj3KGGrrnQgAu9opvQ
	(envelope-from <stable+bounces-256437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:05:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8065FB2D8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25D173039C6D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC9367F45;
	Thu, 28 May 2026 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k34oXTWO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2935A3AF
	for <stable@vger.kernel.org>; Thu, 28 May 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009529; cv=none; b=LLmqn5N5gu0ub8Ri9n8m4biBUbWX3VmF9Mb2tXiDv49H2fRM0tcw6/VZoamToR9oEQn7ZZDVcl47x9MrxNX0Cnh52lnR7YOrUSYZHna5URTjApKQyOIel0UjQxwPTrtokaoI+AQ6NIzEEMpV2TXt60GKTD+EQ95rT11+IU51EG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009529; c=relaxed/simple;
	bh=Xg2im5Hkp/43fZS92x7APxylnjOyO9JjrcVqTNEe9dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCxY5FfDiZA9/r+WuVvViW9DQEl9Jl6AMWSYr3EBpf7wvQAZBXfaZjTcENV4nWVx4q4kxdRrb7XlLfBbWEPBtV+CEkoa+cpSncE4dfi9N/xAfLCWl2wCcjPZutjKEjgt4HLOp4cl0HmmP8V7f1CDZ1t0bcgjXt/7K1oYHY0ilJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k34oXTWO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dbfebfbf50so22195357b3.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780009527; x=1780614327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n67LtAkr/SxQ2OZ3lCmEnLtOrexGe+CGUrE5BVYjjNY=;
        b=k34oXTWOEzb1gEyjLITOrWj6EsQiyYcCcSdKLgscNiLZp+u1Hi/CbwnoSfE3nLHMOO
         M7qEK3fzIU1VYbn63xTYw4txAZXu9imf4EC81jN//MBs4QYXDvUGFtOcLrQ1JLiTv920
         JyLuyvD1qAtW1O1huBER13JRhHQLqwkm1Bbv1y5zWdy4Q6AkJCTXoz8XR6OPxlD81FA4
         xe0qHheNgr9/iHizv4E1roSsCO0Xa3err2OKDDCTKIfy+33InH3PxjIw5qL8YsAH3w4k
         Tmpmoplpo+e3Kr3sioJMicXWnJzEKfotLJGBsFbh6HaXklz+UxZV7Szcj1/qZesKUhn7
         vftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009527; x=1780614327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n67LtAkr/SxQ2OZ3lCmEnLtOrexGe+CGUrE5BVYjjNY=;
        b=RqHtNpZlD23oLBwPAjZO28fuKMcSL0CgDk+Er/gch5AF9rF3cOf376p2g+IYiz1eNL
         rknXl2/E13Gqtm07hyHUeg2iPmmEZKlgAfSLsVo0zfzLJqPfzCrfXn+QjQsBNMdepzZw
         QquerPMfuSDDyHfhYHO2FsP9Kca5jnQuzy4465tQ2dBgsmtzSg9jIQgGQ1pdqZa+cNS2
         Ehq+X4p3POraa5mFf3enwMFp8UU1SK2/otn+81f1Zc28isWgvtRd4P9uKOKVWFXC52Tu
         lXfrVcywrlDn0czlXLW3KhUzN+v4uanbjrBMrbcxyv9jmdc+PAR3FKhee41sE6u80ble
         BxXA==
X-Forwarded-Encrypted: i=1; AFNElJ8YAgSYZ1exaJO9j4HTM5vEaJBJxuF276uFjKZY4HYliOgwTdNSyNGlgTl6HiMarUbIR57Civc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGmrCFKys9ztuNznyyDd11sF8pAG0yi4CsOCXmkKoaeBR/Mk5
	r9QyEwNBC4Yq7fmg0WAEXIspyNUbwQ0Z6hC7/ZgRA1cXBPNrvmY22Ic6fW2ezSDF
X-Gm-Gg: Acq92OHbwU8DCrKYZ0wHSNOd234/+eoD3iR6OgbrBn2X2q/CPsiMAFa+AooGLiSvWX6
	qNFFZsvT+RL5BFj1xidnapCo7JinZ4kT4ZaP+i1EmwPHS5ztLZE5wkncHqpOBBtcJ7IVBpt+l79
	5D0Lw+XNdafc8/s56ZgWGEPFrbRqPZbefZBs2e7A9i49tkth3M3ZQ+fere24aOrpKidndaEb8jg
	1n/QWBGdF2DG6FaNuWMUiHY9Ijx11ExSEZRVSJFznvMF/i1YtGtdABTFnSrpYGIsB+9i0gAI7Go
	EqaIt/lLCOMQSQldrQVcXc4iPRVIqp6Ybi141XZCWSaGV63G3pDq4nQOAXtRBXlDUiAzvxfyQ0A
	iMDCjV1b6KWjg0W7st+XmJMwuwFyA47sfRaJWYEVCQIioSdXPuYtl3NgWJGMrYOJCV9zHlZFDZF
	PS9s7M8KWqicGORY9tkT2kCP8+ZcNCUtjHUYCTxxBkrxkS/fvpuVHV4H50vbICtqQZssl9dbuLk
	kdVR0sw4rFEKQ==
X-Received: by 2002:a05:690c:6984:b0:798:7879:1ab4 with SMTP id 00721157ae682-7de4c0f5e2emr2556137b3.37.1780009527167;
        Thu, 28 May 2026 16:05:27 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6e580c35sm22787b3.45.2026.05.28.16.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:05:26 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] alpha: marvel: Fix lock ordering in init_io7_irqs()
Date: Thu, 28 May 2026 19:05:16 -0400
Message-ID: <20260528230516.1839694-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528230516.1839694-1-mattst88@gmail.com>
References: <20260528230516.1839694-1-mattst88@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256437-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattst88@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB8065FB2D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move irq_set_chip_and_handler() and irq_set_status_flags() calls
outside the io7->irq_lock raw spinlock.  These functions take
sparse_irq_lock, which is a mutex, and taking a sleeping lock while
holding a raw spinlock is invalid.  The raw spinlock only needs to
protect the hardware CSR accesses.

This fixes the following lockdep splat during boot:

  [ BUG: Invalid wait context ]
  swapper/0/0 is trying to lock:
  sparse_irq_lock{....}-{4:4}, at: irq_mark_irq
  other info that might help us debug this:
  context-{5:5}
  1 lock held by swapper/0/0:
   #0: &io7->irq_lock{....}-{2:2}, at: init_io7_irqs.constprop.0

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/sys_marvel.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git ./arch/alpha/kernel/sys_marvel.c ./arch/alpha/kernel/sys_marvel.c
index bebeea3c286d..a37707e05e34 100644
--- ./arch/alpha/kernel/sys_marvel.c
+++ ./arch/alpha/kernel/sys_marvel.c
@@ -263,6 +263,18 @@ init_io7_irqs(struct io7 *io7,
 	 */
 	printk("  Interrupts reported to CPU at PE %u\n", boot_cpuid);
 
+	/* Set up the lsi irqs.  */
+	for (i = 0; i < 128; ++i) {
+		irq_set_chip_and_handler(base + i, lsi_ops, handle_level_irq);
+		irq_set_status_flags(base + i, IRQ_LEVEL);
+	}
+
+	/* Set up the msi irqs.  */
+	for (i = 128; i < (128 + 512); ++i) {
+		irq_set_chip_and_handler(base + i, msi_ops, handle_level_irq);
+		irq_set_status_flags(base + i, IRQ_LEVEL);
+	}
+
 	raw_spin_lock(&io7->irq_lock);
 
 	/* set up the error irqs */
@@ -272,12 +284,6 @@ init_io7_irqs(struct io7 *io7,
 	io7_redirect_irq(io7, &io7->csrs->STV_CTL.csr, boot_cpuid);
 	io7_redirect_irq(io7, &io7->csrs->HEI_CTL.csr, boot_cpuid);
 
-	/* Set up the lsi irqs.  */
-	for (i = 0; i < 128; ++i) {
-		irq_set_chip_and_handler(base + i, lsi_ops, handle_level_irq);
-		irq_set_status_flags(base + i, IRQ_LEVEL);
-	}
-
 	/* Disable the implemented irqs in hardware.  */
 	for (i = 0; i < 0x60; ++i) 
 		init_one_io7_lsi(io7, i, boot_cpuid);
@@ -285,13 +291,6 @@ init_io7_irqs(struct io7 *io7,
 	init_one_io7_lsi(io7, 0x74, boot_cpuid);
 	init_one_io7_lsi(io7, 0x75, boot_cpuid);
 
-
-	/* Set up the msi irqs.  */
-	for (i = 128; i < (128 + 512); ++i) {
-		irq_set_chip_and_handler(base + i, msi_ops, handle_level_irq);
-		irq_set_status_flags(base + i, IRQ_LEVEL);
-	}
-
 	for (i = 0; i < 16; ++i)
 		init_one_io7_msi(io7, i, boot_cpuid);
 
-- 
2.53.0


