Return-Path: <stable+bounces-235753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PgWBzKE2mnI3QgAu9opvQ
	(envelope-from <stable+bounces-235753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE583E1045
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 917DC3074066
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29583921DC;
	Sat, 11 Apr 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifg7ekE7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC63559F5
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928345; cv=none; b=t42d7XxxTfknosSs7Tpn9v9jPhh0xzrifqAwpHuhaj9CN0sUEMAlR+kPUiPJZxRAopKhEIUkzqpeMqTtPTHy2eq4/TD+Xg/pP7rs71oR7LgF3l/Ip4Mn5d3yzLobqA+xWxicBALIh7NgxW4dFTMbdTAWor6jmtywEoBbltyHGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928345; c=relaxed/simple;
	bh=BYqC83A8zTQVLCU9POBwg0dY9bxEakCTwwfMYSgk/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKktPwP/YOQNy/hbTtHD9D5K1vvhux1ejMbQjYnXreNlABOzoJ2G0ELIMxo2Ls5pcrF2rNwuAwEyz/xA7rcpj52sH1TbeFqSmw78MM6JyF4RfJ5Fn/lL5PWVx0ql1HbDEPxioHVKka6D2ilPgdub4jhxRI06oVE5pjEw2iXGQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifg7ekE7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4888375f735so28978225e9.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775928343; x=1776533143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+2kzE1Uy+0YpvuWhiuVakov5m+Oa7pSGVxJwpmI3mE=;
        b=Ifg7ekE7NeyAPsssO4J2iDpVVTQkNBkq//kOTjhxfVQp8ub0NEAPPVhMD38HhSGean
         f9ly0YYtPvEHJZuRXgxLoc0l6WPSTZ66l3m+Mton+KZHfVqOzpKc+OtAGEioHRk3OhU7
         dq6COULyuQWKzHtiJ8EkPIZux8MCcyJKFFsfAW2RacWsMRvQz2+9ZAMFEhaAo/zNXkWJ
         eZzTXQv3qoF5wLDqaPSZGl3nOvg/x7iYBIaQzVV8UpknPDlZczUYBs5dKkiNHinKa+BE
         lH2IsERyVDdbccuNthi4bSkC2au0dIThQ5Fi0Ksp9LM+EycMIN21uXtpwtsU0wQQW5OS
         q6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928343; x=1776533143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+2kzE1Uy+0YpvuWhiuVakov5m+Oa7pSGVxJwpmI3mE=;
        b=ZghtGtfOCiB5VM+Lb1tXVv+61T2eRxwH/J9cMyCICirtFvAPjVkIFgIcRgTkuLARiO
         z8aZ5QYzzM2sW4zQ+8ZkSFy44Wk7zmfj+U2i5O3lpJhlzn/ELlwRu7Xre0aTgQNZSp+l
         VHZgFOue9jdH4/VlOGuuKGH2Pv8ydNoZVNZ7DNQn939PuLiaJz1kzJEaiqcKVZhsKRq4
         R1rnn8hgaFA8ELwWZTH1+2vnbXJsYCkTlr6xJAKUbyajBCDyWTwvp/hRt0xue2HaMbVA
         roY/LjYMItpCAI7SmniAKkri7WSEPwoJJTb3PpfXwGUcbFcU9MEzPPz8yNeg/H7SbLWU
         rNyQ==
X-Gm-Message-State: AOJu0YzYE25w5zAfGPXYryobX/hLmHp8zKaWSpkejhSxH6W9zYevF77j
	XRtQLAcAVFsHaF/BELa9hWAq5Jzff+r65iserLo9iCQSwdrWdQor7TeBC7SisWBP
X-Gm-Gg: AeBDieuLthftonKr9CEri/ycMfOTR2/AG+AQG+sPy4wtnlRHt1b8lAJ92NSrlCtXLxs
	PLv7XRjLdgvtVLYj5kkQBDDNMXARY3tQOUaokixw+GWVbQyWSWceu6C1R5BdmE8TqTu9UEUdXH7
	j1qaV8qh3mobJWQujxp+mi/aIaaUdg/GNPjL3K/l5OYzPVZFeC6Ow5XDPYPQb3/xYPR7CxzVrB3
	LoHgNOKGb1GP6i6qwoGtokZFw/ZH+aD+1vAEw9uF1M1XyxjdM4Wyjn30noEq/7/ki84SdJS0yZY
	028qBXLNa8bM1SDa5u7Y3SbYMB0g029gcKSglJNUytlwyeJRWzHIT8oi0P0QBSdJEk6tTgFEvpi
	OmWMO9mOelGHQ5KD46l/C4m+IbndlaC57uDasVe9N30LcKycSVMXOLFIJ8cNWanWh0RIErjghkW
	OE/DY7E80ZZ3FBe0yPldNjntAzPfhHGOapBI6Kfp4=
X-Received: by 2002:a05:600c:5487:b0:488:ae26:435e with SMTP id 5b1f17b1804b1-488d683d4f0mr95332785e9.16.1775928342842;
        Sat, 11 Apr 2026 10:25:42 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm64176515e9.5.2026.04.11.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:25:42 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 5/6] gpib: Add attach routine for pci_xl board
Date: Sat, 11 Apr 2026 19:25:10 +0200
Message-ID: <20260411172511.26546-6-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411172511.26546-1-dpenkler@gmail.com>
References: <20260411172511.26546-1-dpenkler@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235753-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAE583E1045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add new attach routine for 72130 based boards.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/ines/ines_gpib.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.c
index 118e6c7b0ff1..af9693c33b23 100644
--- a/drivers/gpib/ines/ines_gpib.c
+++ b/drivers/gpib/ines/ines_gpib.c
@@ -350,6 +350,7 @@ static irqreturn_t ines_interrupt(struct gpib_board *board)
 }
 
 static int ines_pci_attach(struct gpib_board *board, const struct gpib_board_config *config);
+static int ines_pci_xl_attach(struct gpib_board *board, const struct gpib_board_config *config);
 static int ines_pci_accel_attach(struct gpib_board *board, const struct gpib_board_config *config);
 static int ines_isa_attach(struct gpib_board *board, const struct gpib_board_config *config);
 
@@ -932,6 +933,24 @@ static int ines_pci_attach(struct gpib_board *board, const struct gpib_board_con
 	return 0;
 }
 
+static int ines_pci_xl_attach(struct gpib_board *board, const struct gpib_board_config *config)
+{
+	struct ines_priv *ines_priv;
+	struct nec7210_priv *nec_priv;
+	int retval;
+
+	retval = ines_common_pci_attach(board, config);
+	if (retval < 0)
+		return retval;
+
+	ines_priv = board->private_data;
+	ines_priv->pci_chip_type = PCI_CHIP_INES_72130;
+	nec_priv = &ines_priv->nec7210_priv;
+	nec7210_board_online(nec_priv, board);
+
+	return 0;
+}
+
 static int ines_pci_accel_attach(struct gpib_board *board, const struct gpib_board_config *config)
 {
 	struct ines_priv *ines_priv;
-- 
2.53.0


