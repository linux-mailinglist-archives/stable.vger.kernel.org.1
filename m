Return-Path: <stable+bounces-247203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD98HTnLBWrvbQIAu9opvQ
	(envelope-from <stable+bounces-247203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:16:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F65422A8
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DF0330080BE
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C43DFC71;
	Thu, 14 May 2026 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgKB6fyI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5038A726
	for <stable@vger.kernel.org>; Thu, 14 May 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764596; cv=none; b=Sf+WwNFro/pFgqxipHexUbDHtdB0l8+byOcjsy0oKs5LNIgtlpGv/AkEg7+oyNjTezoIyIqHAA/1a7tjigiLXzM4WFra3rOWzdK8uDWN/fkYPxXy9jrYRSedyK41Zi9clKNBtwCxPSDNTsKuoiEfHde3wsxKFSvRknw3uk+PzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764596; c=relaxed/simple;
	bh=jl08X3NCLgmcZoiX/JRkZFjNthe8bvfBiVgfd+XVW5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QldawVMzRMgeu1PyGjW5AP85EgnwtHVhlhaFHZiIhZJewiy3a93e6TKQBMSO9BKyC4w1QRnSypGNK9XZaKisjnnvLou8ylyKvlu3xNBT/K6WkLz7L9tpqpQFgvFdZ6miV3zatWnXLFm956QkV/e0oI9M+NdvD+30GeLkYpsd5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgKB6fyI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba1e9d3687so52369105ad.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778764594; x=1779369394; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxjsDTEPx7x+FMifRYMV1hqCeB1iIjDkPxo6+pakXPM=;
        b=YgKB6fyIxmkvEQ/e5HjhkfBnD0diRPyLV36UdaEobnsMsGKEHbeSSi/1oiyamTbB57
         VsZNXXLvg9mMcHhpUbZsphR9RBIaUGnbway8RKLTMzNBS2x0PXWoAr3uIR4EoKq76kpr
         IEan/0Qz1QQXC1kfZZdQPY+LOeLnLABeak0/12GwoFTf7YMKhOGgj31h1ZtDbat/2LEt
         nuxI8tbUH0dBx+dOk1tL+zYq+2nQBu0Mnt6JR6Qdgyf2I9pyNu5/BEa3zpwmzvS5wxMv
         s+5NArS5mavtJhpa7cJ3cH1jKy3Ef/V79RrTM6LzGAKvzbs0yyjwhVzNwjrG/qAbPywO
         RANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764594; x=1779369394;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxjsDTEPx7x+FMifRYMV1hqCeB1iIjDkPxo6+pakXPM=;
        b=NZW1AmxqYfDPCvEi48fmkVXjmvx+ZmKe2/4Q+96iYTzcucQq6Sz5YZPhlRtHei6igE
         smL78yFHEvic93lILGlHc85+ugoeDoK8c1MDZmIMyGyO2yn/sn6/y1zOk5CskYDo9mlf
         iZF0OLhNApj9xaaJGmnAtFSG7ON0sgx8yUN3W7D6YwmzEeEi7a9rBdRBWCHBb80GB4Q6
         wnEsAsueQKlJkBU/U4Wp8H0opCWd/CNwLQB6J72FGbS+53qHl+EDD4fL29+IXB3hRkDU
         ex3xvDvSSJXw1SVliZ3YP2eNY/fDuANJagnhq5kdyq3yqj2u/t8wqUC9A5+kzvLtbLu6
         WCnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CRmz+WBtfqxPM8bNDslRP+wRyK09r342NeA1mJj67rRq+2YTY8P/lrS4lHJqEEcEElt6K/LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywEGxkUor8o3ww5jfwNl7Q7Sbz/TdnITWenDH9p0eSI1AzUef8
	bDkrycuAfd/beN793TGr7BYh3n7h0uSBwzoMZbtODfsBe1fpV2MEQMji
X-Gm-Gg: Acq92OFqYD45PE3P4Aps29dOf7JSbVelMA3vLTlLJ/1YwdSAvOCZ722LNScCX7MUKvK
	uPyHf8AX/usr41AfH6HdLaCvl/ctDmgedfrSdZi13kA7jkNJAksAws6jYlHti+pZ9sFTLvCjP0u
	I+R49o6brMsS2gG1gSZTAnsY0zxD3j9p1sX7k6DylaFVco1ndeo9ueKsooU7vI3PILZMXq+bB45
	Aol+XLVQlQ3KOWDzxWt1BBZxknbHHXxyUheieU24SqN6/Cgj/XRPE2F/TeGjB5HthhQNr2CULJG
	LiBwfIg0BRm5W2XidjNMhuoNLmaHFtnsnUNmiiItkcPe8tHHwwxXFJBjmQcmyyUuD5p+DQDufrW
	UzA4oxvgxY89M22/rXS8D16nXBOSThikNwZqX0IQII+aqrAdqru1optzkO3kpkGhqE3uZvGqSLo
	4JEdpQpG/MpadF5g9VfNJEXvtRUKqnS128Als=
X-Received: by 2002:a17:903:388c:b0:2bc:e62a:979b with SMTP id d9443c01a7336-2bd30333de6mr80854555ad.30.1778764594127;
        Thu, 14 May 2026 06:16:34 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2bd5bd5f30bsm30953275ad.16.2026.05.14.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:16:33 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 14 May 2026 21:16:01 +0800
Subject: [PATCH v2] nvme-apple: Reset q->sq_tail during queue init
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RhaqFZW3sOwQPzCJECxJY2Gc
 HcrB3D5XvLfXynACwJV2UoeUYK4KYE+ZNT2zdSB5ZGYdK5PuVElT3EEN/M8gMOLPQIWNgW0hrX
 t+Z5TWs4eT3nv1VuduJewOP/ZT6L62f+9qFixvRQKpTHaKly7sZHh2LqR6m3bvmtHeGy2AAAA
X-Change-ID: 20260514-nvme-apple-sq-reset-53e22e88c7b0
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=jl08X3NCLgmcZoiX/JRkZFjNthe8bvfBiVgfd+XVW5g=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqBcsvQUZgV7lMIoBJkU6SplIAUQALX59m3rswM
 Ju0qI6zlQ6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCagXLLwAKCRABygi3psUI
 JN8JEACwOZAPoKWuJZMLfBID3QAgWkZEOfVVIl1hXXM5d17MAF1zrTZA8DDoNnOxJJhQJiRsOlp
 +QA8rVCZkVF2d3eukmBADzOGA2sLHHgzFHdHsMiC1TzaVmyOyHlosVYQ4QpCOrntfYn8Ief+kf1
 dU2C8V6wfmrP69rmjJWBOxIWG/ITq2+A+PgNZFJw8rvIYw7EmdvudX8Ad+9YnsgyRlsTUEBg1zE
 SPe4LTeH1C9DL0SFhyCuAOsQ3YGr7L0E923wAgUPYmUzmATooVEhyGVouKE0p80jPPTSWjkTq+2
 sIBrK9qlOFgLaWFxUgYP6/Y2R6NFal9KSyn9nQtcuc+JrnbXisbX2XRYRnW4T3zIFqBPJeIwaBr
 HEKQfto0SI0mOrxyueKQsge5FMYjDF5noX0ZqsOmPs9j9yJOI2lAk0PBlAa2trKC3NL1Giz5XuV
 6pyftpibUZeTTMDlCKryZCaa7P2htuazpMHGUktU6f3mlGDXKPXLu2KW5kZwRovQFlp6HaMR9/1
 4q+WnDsfn8R3j0qo7VGd1uXtbS4gAGtOJHimc54QP82uq/92L8GUEQu2THl1jhNTbPmZ0XSD1Qq
 JE32qAW2gU2Bskqmit3QUg9ywWgIG/qsW0aqk+BVCKXsASJL2YkOZxQQP1YuKftd/zp6yR95cvp
 29qFsWAWPK+XS6Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-Rspamd-Queue-Id: 776F65422A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247203-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[towinchenmi@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fixes a "duplicate tag error for tag 0" firmware crash during controller
reset while setting up the admin queue on Apple A11 / T8015.

Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Cc: stable@vger.kernel.org
Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Cc stable
- Details on how controller reset is fixed
- Link to v1: https://lore.kernel.org/r/20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 423c9c628e7b..c692fc73babf 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1009,6 +1009,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 	unsigned int depth = apple_nvme_queue_depth(q);
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
+	q->sq_tail = 0;
 	q->cq_head = 0;
 	q->cq_phase = 1;
 	if (anv->hw->has_lsq_nvmmu)

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260514-nvme-apple-sq-reset-53e22e88c7b0

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


