Return-Path: <stable+bounces-249166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RAGdJjxwCmpq1QQAu9opvQ
	(envelope-from <stable+bounces-249166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:49:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C765C564DF8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3E0300D94A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF091EB5E3;
	Mon, 18 May 2026 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaoG/+Tm"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D671A2392
	for <stable@vger.kernel.org>; Mon, 18 May 2026 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068981; cv=none; b=dyQpfY4Q+ViDYNYSBvIySgL8AsWHzsZnD1hhjU+16qcun6XvBv5pWsToCpUUjpz7DLinivXhRF7edsYxGZWOAD2IHJZkJ0+TXdwMh0sAiGr32fpxhujvBevfBIlCcT+KiCI4oN8x5xyc/cyYwASV/lv9wzMI+tuHq8VIAlGeSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068981; c=relaxed/simple;
	bh=uPCRlvKUPk9+7sfZNIWSRnHs09MMlBPmoSJ/3rtQ/7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGSKjKMNkp1QSgjm9UFQJCy0nlxiUUOGwOooQS8mvPFoeyKPZGR5ISyI9/B/SCA9ZzXzEI+KZKjTO5B+PqFT1eYLBslNf7aTBTfXI39soHSkFHEXuqnOwQNTQ0zSV5w0BWQ62YJchPLxotKSW4H35CiELiDyx8QxU6JfUfQSlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaoG/+Tm; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so7227774eec.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779068980; x=1779673780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo1ANKt2AnPbyfOMzXRqEqyKaR/EpdFhiCwQ4FFZO/4=;
        b=CaoG/+TmsvrHJtRDal0nZ+36PTSc3StDXKilRWWcvybenuPCe7thY6C2o56h0gt5rP
         pfcJVOmbi1rwAQAhClUO+oVlfDOZFU2wh9XJrw2zV7QTW0v237P3qcBk6zrwOmRdNy7X
         1QmWHvHax9esxPbETKdr4rLOimAHhtkI3ePMV3lshXWuHA0D9fk2Bes4LnvvIe0JP0Gu
         cn+Vl3yIwRzLR1IpJJcz1IJwkGPRLi9DKX1xq8r3AddRbVUxhbFWvf0BN7+LptGAGrjw
         cOltiK80OA2YY7IYJTtkdtU2MiLQ3TLXg2iH/i3iDBIoLOp5sDHduTmh5Q3eMnQOEblx
         /JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779068980; x=1779673780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo1ANKt2AnPbyfOMzXRqEqyKaR/EpdFhiCwQ4FFZO/4=;
        b=W+MxgVDkSmWzpJXqGAqhXgnPtluPypm2UWaRNxJynUgdltzqWGTXbM2IzQgczKED++
         04rcBjrgRHJsNyCfAVP4KgET0y9SNKo+mDhCv/qdTs1NRxukAlEwNn+Ot4c/fNPQeEML
         K57q82sDe/0jorCn2wsT68UFAm9V3G4waIAsXgIRJ1NB5n74ES46Co/AliW5sPfM0y5g
         ivb/vkCfVboBi9iVVXUsE9pmf0zLX9IlJZEoV5ftefMmEIYO1UN9jgacaEdVnoxhjLMr
         7L6c12h8SRAB+7rQGNkSBiDUduJcgd23SQ08tUTkQNMWRwLQUBb2O+C+hL3CxjqBWoNZ
         aWaA==
X-Forwarded-Encrypted: i=1; AFNElJ8+t7aAqAOf6f/dpRRPW8ZtAI8EatxnExBgNpzxc2a/WKtR5W7MwLY9VwYhYhEf7hh9zAj8jHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3z0p91OyBtCn6qPobmaYxQE2vAh0D8H01Taga36omXHQCI9hh
	IU7l8AINk/ioE76D8PCerMVNshFZNC1OLmaYmMY0d2QSLSgPweMDV1ed
X-Gm-Gg: Acq92OGLsF2hCxELqSNpKgLL/iDpTv0eUHkeHX9IxBegg1VLIfEJHOIEkLkRnHNhrVX
	BUfbA63NSphS2fkpd3ds8IlYnlqFT04dYKvYYgIMYGChSsMuKEOJFcD/1uG7tW8n9KFp7rrYrba
	Z1rgB2Kt13UslkxAIXfdB/UANm9jioxjaeVqZvkxrrlRt0mpz3MaDfBhHEAR+OM5J13eUXGYwse
	fgHTz3P44+FHwog1/WSaX9idLjyrLMPfN924QUH1Wk8bN8BK1OL953ZYnA/AvcwrCxYDDD+hWDa
	+98ejoE53zJb01HLef1IUfa+FTwjgGgYsnfdRiYFB0AMehbLz04zFITXCXMcx9Hu+uEQUQSBXXw
	rNbAsgZzMV5auS79IPwgRjobvfYCMQItXgBIlXmD03bzM/FjqIRx/yNq7+Sb02pAe6Uy9mc/+2L
	X2+KODXQEQ91rQxHAfwaprRgpPynrciVFtLmKfhGTATFuDcI4I9Jpfya8h4+5HtWTRVtMt5EYy4
	XQF/c5lnfqCjjlRBlnacm7POYGPqIRbxjoVuLlgZXxvRL5Z01HP9LObQubuOGs5zUQZeP8WVKtp
	kbEGpVfdIQ8078RhCA==
X-Received: by 2002:a05:7300:ad30:b0:2e6:e504:5435 with SMTP id 5a478bee46e88-303982be4c5mr6340680eec.12.1779068979663;
        Sun, 17 May 2026 18:49:39 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc8ddsm12335857eec.21.2026.05.17.18.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:49:39 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linusw@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
Date: Sun, 17 May 2026 18:49:17 -0700
Message-ID: <20260518014920.135011-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C765C564DF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,armlinux.org.uk,arndb.de,kernel.org,linutronix.de,infradead.org,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-249166-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The eBPF JIT unconditionally generates ldrh/strh instructions, which do
not function correctly on the Risc PC because its bus is unable to
signal half-word accesses. Work around this issue by disabling the eBPF
JIT when building for ARMv3 (the Risc PC is the only currently
supported ARMv3 machine).

Fixes: 39c13c204bb1 ("arm: eBPF JIT compiler")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1155c78bb6aa..8185d013e5d1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -98,7 +98,7 @@ config ARM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
 	select HAVE_ARM_SMCCC if CPU_V7
-	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
+	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32 && !CPU_32v3
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_BUILDTIME_MCOUNT_SORT
-- 
2.43.0


