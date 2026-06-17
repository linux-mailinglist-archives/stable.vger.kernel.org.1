Return-Path: <stable+bounces-266647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BgdWHWhDMmqexgUAu9opvQ
	(envelope-from <stable+bounces-266647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:49:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82CB696F19
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chromium.org header.s=google header.b=kaBAo7kI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266647-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266647-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=chromium.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9713B312A007
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173693B7767;
	Wed, 17 Jun 2026 06:45:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958433B776C
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:45:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678757; cv=none; b=rMCxDmJTP6YVTKSCNZCHiQ7p8EaraO+zbu17HfAehk0CaKSLaKFnGQKTYu2iBCjqmvuRVDh1B2NdZWtmY63gIvJBlLEbZ4D2VPyLOXh0ow3pz55zHztkdt8QmeZAZ5UrWiOkwOrQ9+1peRQqPIdaQdx/I3YKLV6tirgfW3/TupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678757; c=relaxed/simple;
	bh=4Z8MER+upsXsPgDv1PcDe7VVV+NEP+nEb0Z9kgnbjwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEuT7QL74o5HWDObJqCbJ8sqDqWPbB0eKOHBVyyatVwSjHk/S0yAajBbP0Z1tTnIktM4iKcwqlZhNcpRjNmKk+rPBujy9c+KwEd614+XrslS5jTm5yoDUoVWH9EgMirkTBmX+52rUJPLdSdTmyGkGbRDNooPf+kebCt2EmcjSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kaBAo7kI; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so5336475ad.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781678756; x=1782283556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=kaBAo7kIU1eHL2en5N6HyLiNOzbXs7kHrkCSAvtFmCtEdqJWoyA/nDul4oxvxzwPaY
         XNHozPt5Os4tdImsMsLZTTMbq/mxZAVKrQsDVcMi3LG8PosBIOrrMgZXi3syFrlAgyrh
         5qm5/qe5vxDBE2fmFL/SbSLipXpRBpoZTUZcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678756; x=1782283556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=lio35yicOR4jbJ6bMbPFX7EcG0yCNTdFcqEGuy+Unlb//DMb+LzqDy3VgfKeRJK0pa
         5KkmA2GuvYUtLcwjhZXeG8tKtko3mNyDZroflvqCA5RPNMQjSXs4jRw91EXw4HGOMuuV
         wkpBg1oINRxQwKZOmeKMdqlo1jYDTYey7RSuOmoGNKQiRj3AMNnPBUHymVxRzxj+d60i
         1EV3ugFc7qv32FcazHhPbDOgsoVie4d/dKfTlvX9EpSrlBk2q2AIs4AlVLfzYyIoTCO2
         eW9WiDcPAURqW9cB3PbaFLN5wcwhsKY6lJMp62ZQng/QpHxAJptZl+DyD2oOCVBgFoFe
         d13g==
X-Forwarded-Encrypted: i=1; AFNElJ9SNQlsfT75bayAfO6xTtVxEjDn1+a6f/uo9uJfnJVGj342hYio+sIT59DpJipyoAztbK45gmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5bQnMHvjolfkIF2o77qziAwePz68jGzEkVqejrmQMhLvavBa
	GKil1FQhfGjYz8VjGCCHNBfaf6JXJgaUbRcXB97UoA91u4oFTAbNGbmFUXPQvbAgtw==
X-Gm-Gg: AfdE7cl85Ug/wcYwyi/s0/tz+kuJ6w5cPx6ZKyb/M/fAtH1L/2EEdnpSRL6T6mhmdec
	UVtIC2l3lnXdNHT0yHztCn/McwuP16jJMT62RAlyg8OzXZAYIBOlbjoRl3B1NO/T5UrWeoc6OYl
	aJmX3iglGh8SogLstLxmYrjK431i8EVYPAPJGAj+gM1ALN6ZpPfYNqWRp8kQsTZA9qCvGee6GkE
	3gTSt0JPhIIvclCJqzscINRsT8Xp8V0YvvjXQk1LuY1CShSpw9qOUPuwFHcqgnT3I+MalQLO8mZ
	kehgTYxQ+WliygbdpNHMGJbjshnMhy0U1gse8Q9RXQEjGSshPUPh5V8ebNKq4OQDtDTKxRbyKea
	dGTZmfr/U43XfAPQdMs7Hhg1jpIzvW7vjrSNJtGwnPkrEx0Kvycfzif19GN4fEgTD6HYEcmgj/T
	czeOxzXoHZOSdq+V597M+AVjyZaXuaLmfyg/TmmHuBYbxIRmc5OWyMlFXyqMc2UmI9wLvGP6D/7
	+k=
X-Received: by 2002:a17:903:32d1:b0:2bc:f1ef:2e64 with SMTP id d9443c01a7336-2c6bc0c8905mr27041175ad.12.1781678756057;
        Tue, 16 Jun 2026 23:45:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6af931f19sm24365675ad.74.2026.06.16.23.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:45:55 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mark-yw Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
Date: Wed, 17 Jun 2026 15:45:31 +0900
Message-ID: <20260617064543.574704-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260617064543.574704-1-senozhatsky@chromium.org>
References: <20260617064543.574704-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266647-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:mark-yw.chen@mediatek.com,m:sean.wang@mediatek.com,m:tfiga@chromium.org,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:senozhatsky@chromium.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,mediatek.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chromium.org:dkim,chromium.org:email,chromium.org:mid,chromium.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C82CB696F19

btmtksdio_txrx_work() loop termination condition checks for
int_status being non-zero, however, this evaluates to true
even when sdio_readl() encounters BUS I/O error (in which
case int_status is 0xffffffff).  Break out of the loop if
sdio_readl() errors out.

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e90..d8c8d2857527 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -574,7 +574,9 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	txrx_timeout = jiffies + 5 * HZ;
 
 	do {
-		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, NULL);
+		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, &err);
+		if (err < 0 || int_status == 0xffffffff)
+			break;
 
 		/* Ack an interrupt as soon as possible before any operation on
 		 * hardware.
-- 
2.54.0.1136.gdb2ca164c4-goog


