Return-Path: <stable+bounces-240063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJRgMWwo52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:34:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26B437A57
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73FC3019121
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4448382F04;
	Tue, 21 Apr 2026 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvB2zik+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E034CFC2
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756835; cv=none; b=GxMXl8Gpj78BG5/lg6xlMdMPlwf4vdpB5+njyGmJ1bBr4P89XcdhaRuVmDP1Ovmlw6tstNdoO5dIaDKgHNbNOfpvR6OUP15bYbXJuKEWBbUB7JeiCNWJS0XPPVWSxIMty1gMEBLaJz3JH8CEJlcGMGoUl6jxZlB+zCloPvQgKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756835; c=relaxed/simple;
	bh=kacipmRh/ARA/yj251suNKvUgkiVHzItJyjKIF1jCv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FBHb5HuZRPu1dLdox3/eEl/MJ02xlRCLI+saNGogI285+eYPa7p07R5QH2pV3l74vn0f6AuJTzRqGvUvP24V2tnszJSntVwdqZ4IIeOwV7FYPKFrAZD/Vv/+0nDd6gq8Ibzenee3Rq63kmqY/z/WTsHfPESi0gJM/D7eWvVO6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvB2zik+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so3773693a91.3
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776756834; x=1777361634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tN5kwaSs4mUzaWaK2mJMmR2b/ZFzAdC6nGIO7bzkSw=;
        b=XvB2zik+You16ZAqXsdCCWXx9ivmehqG4NGlR1hGiIdeluO3DKYjN3qkYYmVvsBwmY
         ia6oqVGIdWrxxT2lmQ2XdbAXrEwnVvrd6mqNCA9m9+ppJUxS0qxkmRsGBcxkK9mfg7Us
         28Y26XviCjkbVV73NUsimZpofjkuaKNIqQ2Ddw1/jvG0nUceikMFUHTj5JUeGbh5aOH4
         cJ9xHok2gmQkCEYPEKDvgKZHVzsKsXAf9sGd5HviNASSqf2DTdCeP4ysicHQHRo3pNEo
         SH4Ae44vLrae0OTLGA5sWzPuzElh1NLH0OPDZpTvwksgpAEu91D0SAKK0ThdJfX2OSss
         4QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756834; x=1777361634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tN5kwaSs4mUzaWaK2mJMmR2b/ZFzAdC6nGIO7bzkSw=;
        b=g9yt8rob/6mo0L7Laa2In0+K4z3WgklF0An2pg2XKIRfPc8I9i7gd/R/6HbSiiAAIR
         WLNlK+7uPTOe20hd1uLZPikymtAKF5NuOmpGTj+dgKF4Z01D8MlTkmzZ5GuS6u3pnxhG
         EF0pb6xh7ZUc46nn4l/dSsPWp10LVg8IHeG1kZCs/I45y38/pAes0iPdvR7Mt48NH3e5
         9hmitnPv0A6XfD6HSiWT5ACcwij5vgrPjcPa0xjbBv9Sd4FgfvN2F0NEYXlEGUNcsb5c
         gw1wRBXqTB4hiEWMeknRNxzvxKyiRlMhzG9DZmYJO4okBNRIG6jN8wHon0WrDaaEjpOZ
         jtlQ==
X-Forwarded-Encrypted: i=1; AFNElJ88/Tcxthd7y2LW/Z8L4blGcZBhG/p/iLob46OEVz4ACc4l0M6BlglFuUl/hPJMkEAGATu5LvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2KNlwsFG0fUpgDkbcOtBU6/Y6cJuBpM1kZLA+uuKuYOnoiRG
	sXtoQacUTE8I2V3mm+BFumctuPwAHViHr89jIuWeyC93pCFJaRVnzu59zIi4vh9X
X-Gm-Gg: AeBDietym6YuTkQuYfD9ui12akwrTytsivojwr6bIjjDUOyZzmcXN/M42LbFDwS9WlF
	1fOFolQJ00TulXE419A+/6ZzzSTJG+gPwPeA80EP8czkEBjHsagNm8pGX7EgTcyNVYVGHJxCGn1
	P6Jw9XnyUrdGikqqLrNQ3/L4eBTf4stHBgFB0Gyb4rONP0DMLXPIKOZuYx+9JHxy+zkQaV9kSU2
	JAJC4VaVTjcFESbGDICfjyfIkvJ4zLkAAkaYNeD7YTFhj1/7/1wx02oyQPALKmL4mJ0OCvLrUnk
	/OHwHanZQ4Xr3uzp+KqRQcYx25jzmKmFFYS2/PLe0adS6JNAZMim+2rW4moBv94vbkJ4Ut5I0V1
	Sg/nOv2wZGfZx53d8EVTTGKezWgxqJ+/NRVJXwPh/68zPrGYoiUJw8Tp6vG+xmV8b8fHpN83d/t
	VJaxB0KLv78bicn4EYxfbCOCiDnFM6FX4PwMgbKcap+w2YxPiVzsM9Gx6AbUtSG3G+w/VsLI5Hh
	d6gaejZM9k=
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id 98e67ed59e1d1-36140493410mr18530382a91.23.1776756833615;
        Tue, 21 Apr 2026 00:33:53 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a8f0sm12411902a91.12.2026.04.21.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 00:33:53 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Tue, 21 Apr 2026 13:02:59 +0530
Message-Id: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-240063-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F26B437A57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ca8210_spi_transfer() allocates cas_ctl with kzalloc_obj(GFP_ATOMIC)
and relies entirely on the SPI completion callback
ca8210_spi_transfer_complete() to free it.

The spi_async() API only invokes the completion callback on successful
submission.  On failure it returns a negative error code without ever
queuing the callback, which leaves cas_ctl and its embedded spi_message
and spi_transfer orphaned.  Every kfree(cas_ctl) in the driver is
inside the completion callback, so there is no other reclamation path.

ca8210_spi_transfer() is called from ca8210_spi_exchange(), the
interrupt handler ca8210_interrupt_handler(), and from the retry path
inside the completion callback itself.  The exchange and interrupt
handler paths loop on -EBUSY, so under sustained SPI bus contention
every retry iteration leaks a fresh cas_ctl (~600 bytes per
occurrence).

Fix it by freeing cas_ctl on the spi_async() error path.  While here,
correct the misleading error string: the function calls spi_async(),
not spi_sync().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ieee802154/ca8210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index ed4178155a5d..bf837adfebb2 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -919,9 +919,10 @@ static int ca8210_spi_transfer(
 	if (status < 0) {
 		dev_crit(
 			&spi->dev,
-			"status %d from spi_sync in write\n",
+			"status %d from spi_async in write\n",
 			status
 		);
+		kfree(cas_ctl);
 	}
 
 	return status;
-- 
2.25.1


