Return-Path: <stable+bounces-247055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H8AHegNBWqBRwIAu9opvQ
	(envelope-from <stable+bounces-247055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:48:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D353C218
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7651303075C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EF32D29C8;
	Wed, 13 May 2026 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqSjwDsJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A9392811
	for <stable@vger.kernel.org>; Wed, 13 May 2026 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716133; cv=none; b=SKbEYiyDd3JIl2yPT2KsyoHLwDuUACkmtsYZeFZSQXvcNVmk2nhEAsNd6tlBupUC9QCphkNCEve94QEAf0GxKUXAfFpa1NwUBNzvuzuA7A/3gWB5eiUEM1zaQR2yhA5B811bYZZ5CKxWKVcHn+xxm/4lf9kDP1vzx08l3cQwPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716133; c=relaxed/simple;
	bh=7RnweES/3BBDREpOLoaPAoFF0/byxvWbvetddrWEPaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WsJD9qZmgG6jsFTlRQumVAqQP0wfBA0JV+lr46Lzpl+vum3GzbKDU+OFwyTXCrA6S4lRa9sr6U66Xsu6mOIwOp5c38rADv7wyRPzkrlMd//qMBOHQhigVURE28AUjNxB3cDT5h3Ei/7NrOHYz6kYqdmP1MNt3ANsKP+GFgV1Iyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqSjwDsJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so3426163a12.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778716131; x=1779320931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrZms1YGy08pfMZYjXbQCN+Raqs8ZCHu2rMaAiJhY8g=;
        b=cqSjwDsJnIdEGI301VSh+BLefBggpYL1crDvdzGoO7KMnpzks3FqsNNpzRfQxYjESq
         mYmkOv4Myl9Gx8RVLoqqsfumnIMrCxGUVIeXbuqTW7x4Zt4fIFu3oqi5PQVMgXdo6Hj0
         CBfm83g2YaO42FwDFlCytMmNd+XC4fPaUCh47esXX1978vAHLOjfhDM3xSNMiPIuOCAm
         mw9cp7A3afFraj6GsSfK+B0Dkaw/XqXlk4xWi4/2juU8qjaJJZZbKmbiS1PNLM6X/Lnb
         4jkTRrQEDH0T/9bCA08NnwFTeuZvD6v0M9umo1861n3LPeyvvU4W0aQukyNLXwSvCZuB
         MSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778716131; x=1779320931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrZms1YGy08pfMZYjXbQCN+Raqs8ZCHu2rMaAiJhY8g=;
        b=do4OKpFwyZgkmDvosfDeEbIkCWGwP1YbLF+T9NYOXYomXXsIRZesfZ97yKGvxz86Sm
         WtpOdgquoVU/SZFyYHf90QPOSkfg7aI1bBv4etDW4GUNPWYCjrwMyBsbqi6bwkpkwmIn
         U+4qRk7aPt7E4fSLPjdpsJfqaiFSQmJTvpdKTFDFT7y63oMHBmJuDwdAvdoEuX19VySi
         NY2f98EukWXymEjSba8G7qYu4sYoLqneF22YC1Hd1KolKCrkhSqyU7tYLC4dSfiGVCuq
         yXmcBhSAXR4PCw/e9WYUaAXecWz0+NW1Kmrfabu7454F4nuLifcTNyLSDCD+CtaqhRS5
         gAnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Lw7t03bKyqm/1tpwg/XHleTlKrsXLi+ugbVo9W6W3V2N0cn6Xtu11YXGddvboBWCINhAOosc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaf0ZsiuQKHPNF6oiRme63bHIkKsqoeaKEy57HR0O7RQPYKdsY
	0xn5CNPPpUl/OdFKnbKDUQbjXRGJILxxTQuZnBz2r00oltzW2CHSV+Psu4p1e6vl
X-Gm-Gg: Acq92OH+uzm9xbHIwA9C0eUwxW1BXrDX1WhRX329vgTZ8pJch1pwIg6eyld7uLcTzGd
	HCyvQrVLRLnbW9ZirG5TJb52KHdAZuLJAuaPXoptF5ByfnvV4Iammn9OVWAqinHYpz6pH+D23R+
	1n7tUp6V5/P2nB4ZSKs1EI6vdgFUb+rzD+dvkHykmh90SiaM/l7RNFuP74GzGy4gyvLyMAFblQy
	gtf/1u2/hYv24yNhQM8HVT8X8crEKFPE+HxSKHRCTmSLQIM7hI63SQgBTNZv6IbchViA1VBcZVU
	pHGszEVzQmNcGfJ6TJ+gpMaDDhE7p3QD3f6dbB1HwG0MY55BpVRmBccXkCf9Q/WoMwQJeLvKFXp
	7CofOFeT7BryzVPfnLJbrUsSXQbFI403/FsAJoYph3lZVb/wzwITtWRP6P/GNY8IjPuaWNWf4tf
	1LsI8PflisTcBn4Hn10vrAq3WRRbbtNxbFVZMXKuC6Xx5qGigYDUuX32Wz7cRXCZg77/c3rD39e
	4wx6Q==
X-Received: by 2002:a05:6a20:94c8:b0:3a2:e0d3:37d2 with SMTP id adf61e73a8af0-3afaf61f28dmr5796571637.35.1778716131079;
        Wed, 13 May 2026 16:48:51 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([203.194.102.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1156absm365440a12.27.2026.05.13.16.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:48:50 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: linux-media@vger.kernel.org
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] media: mxl111sf: fix null pointer dereference in mxl111sf_ctrl_msg
Date: Wed, 13 May 2026 23:46:14 +0000
Message-Id: <20260513234614.8889-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E59D353C218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247055-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[mokshpanicker7@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When mxl111sf_ctrl_msg() is called during early probe, state->d
may not yet be initialized, causing a null pointer dereference in
dvb_usbv2_generic_write() when it accesses d->usb_mutex.

Add a null check for d before proceeding with the USB transfer.

Fixes: d90b336f3f65 ("[media] mxl111sf: Fix driver to use heap allocate buffers for USB messages")
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Fixes: d90b336f3f65 ("<subject of that commit>")
Cc: stable@vger.kernel.org
---
 drivers/media/usb/dvb-usb-v2/mxl111sf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf.c b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
index 870ac3c8b085..9908675c355e 100644
--- a/drivers/media/usb/dvb-usb-v2/mxl111sf.c
+++ b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
@@ -56,6 +56,9 @@ int mxl111sf_ctrl_msg(struct mxl111sf_state *state,
 	int wo = (rbuf == NULL || rlen == 0); /* write-only */
 	int ret;
 
+	if (!d)
+		return -ENODEV;
+
 	if (1 + wlen > MXL_MAX_XFER_SIZE) {
 		pr_warn("%s: len=%d is too big!\n", __func__, wlen);
 		return -EOPNOTSUPP;
-- 
2.34.1


