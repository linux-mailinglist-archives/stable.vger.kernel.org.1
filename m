Return-Path: <stable+bounces-263669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avKfCn0wMWpXdgUAu9opvQ
	(envelope-from <stable+bounces-263669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:16:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA668EB70
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:16:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chromium.org header.s=google header.b=HnSlpc6B;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263669-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263669-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=chromium.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F64B31B98CC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1143901C;
	Tue, 16 Jun 2026 11:12:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A597436379
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:12:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608378; cv=none; b=jPJgWp+hMgK8IRxzIpiFlutDwDtP2hI4LB8Xv1M4Fxgx/mU1VAQxI6HFEWt07zylxtZu0lfSSJejxrJ/+Wg2TJ/5mhApUqCOpPRSxMG4R8DAc80WJ9oe/MsJ0FAfnDxrObb+eu04ZIurDLqBvtJlgrdgtxeu+7j9GMXaTivMMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608378; c=relaxed/simple;
	bh=4Z8MER+upsXsPgDv1PcDe7VVV+NEP+nEb0Z9kgnbjwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xqmy8++IPKMJBtqiFmhvePgi8PBn9x+pW8DbqtPJSdsdrizGv9AMQgdoGrfPrZk05Pr9fHqj1u6BmohjeP+MHZ99dLjK6LgyNzUEePyFNOgwhXbwZVzO3Y/KZetKR3hDqG94dZB7Zz00gJerTVSH41AMXPe2L6/DjU1hcIdLcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HnSlpc6B; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84275887a3fso3657487b3a.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781608372; x=1782213172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=HnSlpc6BanbzaypVi1/pSWe0awb1WpbFqWJyPOUjEzaGWQrMR0OwNWSZ+L80iWYKiW
         9S7RybzC5142ldnyDO9lgSd6DDGc5lBzgdriv0h3fKmpywM+7TnVbYM7fp0FAkXtj6+w
         AG6hzNTMcSIP5J5iDIGrrlNKCtXx6H8NnjFn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608372; x=1782213172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=fD1OrufusuxYpb6vcsiGRucQ/co8OHS+BOPrTV1uqP6e/veErA6PW0FSbm/l6uwIvb
         eVkcdhJTmUvVNYJJ37XOFS+QIHfBPn+tB8aLLUSfMseQIKeNA+F5/TzZvKxTo78LYeHz
         Tf8Z+2b9DYgFsPLdGXdP3KR8NL17ZEVQ0SDyaMT/FstAeCUcjTEfkrcf9CYHtxwPX/hL
         H75tBk9KlbYTsUshByJ7qhpftmwsotyd8gA+ygVNDPXM9DCTwA2jNxDQspd5BGCM38PB
         pgpEK45tgy2SztNA+H027JYnpSRctdHk0F5CLWZMMCBumXb8hmh1A/oOmH/KwkVwm4rY
         vL+w==
X-Forwarded-Encrypted: i=1; AFNElJ9CEHDOiw4fQJK6WNAA4GBso7YxE8WXITWbFtlhpc2TeLNuycw1bomtMcBq7ANeGQhUEFt7Yqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXQgWFbGkbvCwZ23oYr2Ujrh1Bo609vK4pMYVLpaUDFRk7dYH
	y7xw1IUr1Dj3CuaxVMSvdC7MS1GKkOOB9j8o+s8oDsXP94Fm3i4GRWzgy14Q9/FPWw==
X-Gm-Gg: Acq92OH3wlvT7h0KFFQuiyO+4WRp3kiPxi0Lz2FePfSWKGocMFVEJYGVdzL8iJ9dS3k
	311lNXH5WOLYO5zHMk2J85pDV0rWMN9Uaho/vmcB7Z2+u1t6g+SrFRQDzclK5xip9IREPHkD2h5
	25KwBfKHLbvQEw0BZKphRCEX99OS2ny7z3x8XUHnZYHPKsMNflzkH5hO6BIgqtD8M8YD6utymM+
	0YvCqAk1yg791VykYIEo8r7bsTu4/xSxwFq5zJyfEz8udZbBWbGbYSD51RY2BgtuGwVDVP3U3z8
	FkH/ovbzwGFFi+WUOAAXcdIXZUutlYHqE/XSyOffxsdXQcKAsb2UDF32RNL5eADrAwm3HZtUUfV
	d4l9QjhxkgpQB/40LVWbtet1rwi9xnkQQAst22wDZzYrWFvyFKaPDKKfcsF4dFK5zTPneoQ2HL+
	DKzU4vFIQZcnn1ZXHjehthL5S/z8oT3S4JSGUoaqXLJidokjFbceqGNq+6xMTlNQONn+ZNKsVWU
	2XlXlXYd6fc
X-Received: by 2002:a05:6a00:6f55:b0:842:6344:f33a with SMTP id d2e1a72fcca58-84513e1747fmr2470656b3a.3.1781608372537;
        Tue, 16 Jun 2026 04:12:52 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm12906321b3a.59.2026.06.16.04.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:12:52 -0700 (PDT)
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
Subject: [PATCH v2 2/3] Bluetooth: btmtksdio: test for bug IO errors in btmtksdio_txrx_work()
Date: Tue, 16 Jun 2026 20:12:07 +0900
Message-ID: <20260616111224.152140-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616111224.152140-1-senozhatsky@chromium.org>
References: <20260616111224.152140-1-senozhatsky@chromium.org>
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
	TAGGED_FROM(0.00)[bounces-263669-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chromium.org:dkim,chromium.org:email,chromium.org:mid,chromium.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0FA668EB70

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


