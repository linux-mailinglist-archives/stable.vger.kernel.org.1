Return-Path: <stable+bounces-233298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMuFCHCB0WlAKgcAu9opvQ
	(envelope-from <stable+bounces-233298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:24:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17639C988
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BA1F300D9CB
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9CE3537FF;
	Sat,  4 Apr 2026 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="o0ulnqFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBD34EEE8
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775337831; cv=none; b=l+GySC6bczFAxchIxCGm+ls2BdD9TSgZIp13kvLN2AVPt9JQfxSwqzcVgF0vLS43YTMb+kEaDOjaFK2EQ+O3SnwRYjbL1s3m9fxpqLN1HxG5QEEghrgJ+ZcEgmzifWIifGMyIMzOQnmSv2AYCiwx8VqFBwZXiFIp3iwHm+GjbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775337831; c=relaxed/simple;
	bh=ImHF9g3IcLUfW3xffXB/XPmED2TBy07Abf8+8fzJJus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQOA2p+2CRrC7Cm6sFrHjeS6j7wxky5qcceA1smPV5jaoWyZfQDsjtVQaak6yFTSdNt0MduUQ+JW2gSnRvAFbDfD+foqDzsdlIklcBrgWtY2rfd46KoSFHBr+oR9Jp3dvHqIPkd5r9bYeIHQ9N8p0qBHhxF6sJGJkHvqnFCnWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=o0ulnqFm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F9113F181
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1775337819;
	bh=BpUSN0Z1IHSioYzVwD8gPk5Nfoeljdg8BmOBofC9qpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=o0ulnqFmOIz8JdcBHCGEtjP3tMp8MlirYfhdkIeYOL5fHjv6Pm4XGClOQdvjlHzii
	 RvmJGiSFDcJomyTtDNhMo3raNGBCWM1jb/OERsrgaW6L2JxqcxTQSKSMFzqoHOjbDK
	 WtlZ3zAoZMlh57AbJr7PoEft/4gbNsh4lU+N9A9lnu1J0pqnz6WTsa7TeYy3ZYixWs
	 kOoVu664M0V82Ldcyye0F3eGAXcW+nskEYF8L3tFnz1glb2dHcTxG86f3qgTuAAvnu
	 xxEUW/d9cMWmbwQvUncKl5Z7CbbDMrCJ0dsd4deJjnh18OurUB5QwH8GkZQ8bafFGf
	 CQhBNWyEGYvZVKrTrBsLsX/UdhbGNUsdQwk8kU8xtqWlwB7p0cR3Usu8bPPSGy0I0y
	 W+3G4sl+8Pe4laJOQ73uIb8DC4CJhhBWqp/yQnAkOcDCCDbhDE0gPS6thO2RTxQnJx
	 cnGFYTq3Z0MEX8NYVksRvbL8Ur6njaIRV/s2hQwRSfhdZW0yDbvPBOq5dVxqRqBd22
	 d8AJHKWuVnW4nZXx5eKI7TqnH1XBPXurZoBFUPw8qjkuioQPSkf1qa68MjdHg4b1kW
	 oNglJzChv3uUscBdLADc6ArjXSK2+l8jD4zX9LpsT5xi7XPZF84ocijImvYtOmokaA
	 sFIa4yfQ8Wa2D3HeMUvSx6Ws=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso19140245e9.2
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 14:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775337819; x=1775942619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpUSN0Z1IHSioYzVwD8gPk5Nfoeljdg8BmOBofC9qpc=;
        b=YKGlTycf6FubO+iIZfDyrSTQ4xZRk/T6rt5UwasQ+l1dP/uKAZ4DOyoHy5243Xp1Ip
         WG0ffaGTq6VvA/S/InniN/+hw1iZzcNElSL2HztROkwOb835/CFklPtBCSOqLoMRXpVx
         ExfnuVE8O+avsMLzdq8QpxnH83fza//zr0hebrq3LdagnSaUJJ3DFKvp0H0ypUomfJW8
         tsCgTlfxa6xKtUJpmDEE3z79mjx2DuzGSiD8rsS1BqbTZEPYavBIl9Ii8xBMTLmJHnZm
         GURbkGqV39lw7b+5xrcvMce7cUdubCnrjDcIpDVF6BFIX6GXO+6gKEQ2vLwFAdiCcDKT
         lLow==
X-Gm-Message-State: AOJu0YytjHvH1syX2GvfcUeZm4HjHDb7KMfzUzGWiKigRiFQO+Ec4xiD
	khhwRiYYTnHdA9+a5m8Ir3kVrGo5znBfW/Es4rJzk3YeHlC4DrPt+Y2pyynSlj4H0c3wlEowj+R
	9a+YkRubdiiVj3ZQKxiVQpYNf4CQrLn7cgvtKXH4XxJVX3PKwGE4IkN37yoxrITYg/vThr8mi4W
	AFOQv3cA==
X-Gm-Gg: AeBDietHIqf/lU1OMlF2Qa+tIpoaOxbCrgWiiqkyCw5eGTuYySjfX217qT/fpo6L19K
	G3RX0V+ijlrz7OD4FELrVuSXVQfQlZUovuoi7l9TnK0Q9dqreU6mbYa/7RN03/6bCdskMIxe6Ga
	9MfHW7yjyHqXRnxM6IFU4SwX08LBe5k67sjYRSTqbN28Qy+9m3JsRiHNWYLc7uIk6ZKuK6YN4n0
	mNKr+FUj2pcHoIbcGisoQLZzTCvM7FYa167bfmL7mHbR8nTDdH4jgwKR9AE9iYDr6FuQ3hi1oGJ
	7+dfX32B/xpgvoJk19ieOK/C7/z4Ldov2m/W7Fy8+0P4eFqsm4EbS687aAWGYoEBx471sk9vUv/
	Z13kca2MNXWyr4pfMZXYvU9I=
X-Received: by 2002:a05:600c:c8d:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488997a6883mr104507615e9.23.1775337818694;
        Sat, 04 Apr 2026 14:23:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c8d:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488997a6883mr104507345e9.23.1775337818231;
        Sat, 04 Apr 2026 14:23:38 -0700 (PDT)
Received: from localhost ([176.41.26.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488940e075esm211104355e9.9.2026.04.04.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:23:37 -0700 (PDT)
From: Cengiz Can <cengiz.can@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	ioerts@kookmin.ac.kr,
	sagi@grimberg.me,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Sun,  5 Apr 2026 00:23:36 +0300
Message-ID: <20260404212336.1808498-1-cengiz.can@canonical.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233298-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cengiz.can@canonical.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,grimberg.me:email]
X-Rspamd-Queue-Id: 8D17639C988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The stable backport of commit 52a0a9854934 ("nvmet-tcp: add bounds
checks in nvmet_tcp_build_pdu_iovec") placed the bounds checks after
the iov_len calculation:

    while (length) {
        u32 iov_len = min_t(u32, length, sg->length - sg_offset);

        if (!sg_remaining) {    /* too late: sg already dereferenced */

In mainline, the checks come first because C99 allows mid-block variable
declarations. The stable backport moved the declaration to the top of the
loop to satisfy C89 declaration rules, but this ended up placing the
sg->length dereference before the sg_remaining and sg->length guards.

If sg_next() returns NULL at the end of the scatterlist, the next
iteration dereferences a NULL pointer in the iov_len calculation before
the sg_remaining check can prevent it.

Fix this by moving the iov_len declaration to function scope and
keeping the assignment after the bounds checks, matching the ordering
in mainline.

Fixes: 42afe8ed8ad2 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Cc: stable@vger.kernel.org
Cc: YunJe Shin <ioerts@kookmin.ac.kr>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8f7984c53f3f..c6cc1dfef92c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -312,7 +312,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
-	u32 length, offset, sg_offset;
+	u32 length, offset, sg_offset, iov_len;
 	unsigned int sg_remaining;
 	int nr_pages;
 
@@ -329,8 +329,6 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
-		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
-
 		if (!sg_remaining) {
 			nvmet_tcp_fatal_error(cmd->queue);
 			return;
@@ -340,6 +338,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 			return;
 		}
 
+		iov_len = min_t(u32, length, sg->length - sg_offset);
+
 		iov->bv_page = sg_page(sg);
 		iov->bv_len = iov_len;
 		iov->bv_offset = sg->offset + sg_offset;
-- 
2.43.0


