Return-Path: <stable+bounces-246766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FVFDiIkBGoZEwIAu9opvQ
	(envelope-from <stable+bounces-246766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:11:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3552E712
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A43F9302E97E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007333D566E;
	Wed, 13 May 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkqUwRsc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B033D47BC
	for <stable@vger.kernel.org>; Wed, 13 May 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656284; cv=none; b=GlbeA9eo9e0rxFmXgMB0L3SQHxzMEP4ZAICBuoq0+PrNKhGbzF9j6DpdwOQ6Mb1FffLjsS6Qc1ZyIyDmypAh6dCwjyXCbbBZRmN7NGgC9Ean+fL9SYesaWP5IlZuKkaFQQiTyvxgmtnEoozKDtKSw/UtxSUSZ+SMdH1JfRjb9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656284; c=relaxed/simple;
	bh=h207wMrvvV1Ldhg9nEqnfEuJuI1hYIKUwGDHp11u7W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ip9lef5JGYYigv8VRUMBmmrkdpG/GkSbpnhBPxuxEIwJyFrTKugG9w8Mq6tF7xOK7UxAtNiR9toa03ec9AkokJby/mpULStbTuY0k5Kqr5ZmS4xmAIYpm3uj/XPBX02IFrEJd71Dx44rBMP/gkVZtbHqHVj9ItFPuxkWXJ/aF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkqUwRsc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c80170db7d6so2466973a12.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778656283; x=1779261083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAUm05/737IqhRNlo9FHhqv1K5HUvIKv2GcQLIvOcf0=;
        b=fkqUwRscrIpiH5S4k59HNWP6tdm9p4fhLeZqKE6uwF9QcRdWlPXOlzsKYCqQQi50s6
         cYtGGmgRZ7S2vnArXNH+pAVC2hiO7+xCW8qo25t1bivGduMMsu9KLXMoCMRlY4iyKzvq
         jJ8sgwFtg79lqFWArqsmL+dVcQzRnbXzYZfZsxUWEAdnSTWliY9sOlJV2iY5teS9usig
         9gq+W08qB1vH+tkBDBDz5iHO9qrK9GjWfMGJYkE8BtG06k3dRpk9BMevHmHBH9g0/aVj
         8t0RxuXTYY9s4IlnSm8Mj+VtC8VdTJ0k6O5i+bVfDAL0I7gtGmxLzPW+YEApWbPOh/vi
         GyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778656283; x=1779261083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAUm05/737IqhRNlo9FHhqv1K5HUvIKv2GcQLIvOcf0=;
        b=nu7kQUFEV7gJgHQDxF/SEl4nqWdWFmsCUFg17i4MXgcJ07Po+pjn6yOcTcf+5HIVel
         XND0YEiwmul/A0aGZscey+ppXnRou+fEfF4GB914MF73begiCsiDqDp1Avx0FmLpiuCO
         e5+p2nN1wtepbpn6sIUdMy5X0Af9dNjNB0DBjVbHNLn4B03fbwzvKsw8i6uocr58+uw8
         +6ihhhejtBBxUwUGX5lHRxgI5Z1lBC5gtEs8K8oqTqBeP9MYBLg/qiwyMJy9a86nyAjO
         p7IPaFHOQ+Olk/5yfmQy7008eCZ4+aMiPgaAEKWIk0+B1WgzLHLmp2ZWYmtvb3EUMj2K
         I6jA==
X-Forwarded-Encrypted: i=1; AFNElJ9D8yE7DpoU9vHJmhUrfIwj02v4859ukmSDf0nT87p3C0IWqGkEtcrb4ehvBIPeUdvxIGAPMKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrw6o5ySmKrrNcvRrpe6qwX6vZ45Av60iGZQUs91AK+nk+IFiB
	zs9BzAvXg+TuGgWWi/cWncAq5N+ZXpruFSjA7zKvX57Ub3R5kXZ16pI=
X-Gm-Gg: Acq92OGZK5/ps/pGk5h8SCmQ4SQHEYuxGyJA8/8oyhz7trSXE6Sa+zU7jcaQ4fVdD6p
	QDwF0zdTfBKRiNsnYTP2dtctdGciPR9uXhBY/fkpT2oPPJ8Wuu5zqgGWpPdLSTxkKl87YqI9fqa
	7sUFrsWffPW7or8LVCnNjvHwtniJWJFHuvML4+nyevMssYKl3VtEzYdl6A8XkD2eL0KJJJoAOFK
	4AQUTssq343Y/zKh8a2lmF7sM0JCTHyg01tANnFcFVyk6FJ6qwV3Huws2P8jN4Wc2Q2Xi5+6nHd
	nHUHwRimWhyQuxoSre/Sp8B7d0Vlc65EGueNbrHmiDBFiX1VrRsvQh2Xa7BrLRsDRcj6bRIPaCc
	7ZW1565zbAx1r5d4QQlADSQWeoR9m4AOYda9v0L/eMyAs/WpGx9/Z2O0OyGw+HH1Ob8SzARLe7+
	xql38UQJWSkWdlHiuCuHcY80OBIjpM6KR2dxc+0j4kdIG3iB7OWTERJ/SKhBE2aWr2RO2Zng5h/
	zYNZPKjElQ1cFi1ue/o+oZl4JxpKKFxAWuTDtg=
X-Received: by 2002:a17:903:1448:b0:2bd:2458:50d4 with SMTP id d9443c01a7336-2bd27706be2mr20525425ad.41.1778656282606;
        Wed, 13 May 2026 00:11:22 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405efsm165677855ad.23.2026.05.13.00.11.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 00:11:22 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] media: rc: sunxi-cir: unregister rc device on probe failure
Date: Wed, 13 May 2026 16:11:03 +0900
Message-ID: <20260424000000.558-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBB3552E712
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-246766-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Myeonghun Pak <mhun512@gmail.com>

After rc_register_device() succeeds, later probe failures must undo the
registration with rc_unregister_device(). The current error path jumps to
the allocation cleanup label and only calls rc_free_device(), leaving the
rc device registration and resources created by rc_register_device()
behind.

Add a registered-device unwind label for the IRQ lookup, IRQ request, and
hardware initialization failure paths. Keep rc_free_device() for failures
before rc_register_device() succeeds.

Fixes: b4e3e59fb59c ("[media] rc: add sunxi-ir driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/rc/sunxi-cir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 92ef4e7c6f..cc64a68dfe 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -344,22 +344,26 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 	ir->irq = platform_get_irq(pdev, 0);
 	if (ir->irq < 0) {
 		ret = ir->irq;
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 	}
 
 	ret = devm_request_irq(dev, ir->irq, sunxi_ir_irq, 0, SUNXI_IR_DEV, ir);
 	if (ret) {
 		dev_err(dev, "failed request irq\n");
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 	}
 
 	ret = sunxi_ir_hw_init(dev);
 	if (ret)
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 
 	dev_info(dev, "initialized sunXi IR driver\n");
 	return 0;
 
+exit_unregister_dev:
+	rc_unregister_device(ir->rc);
+	return ret;
+
 exit_free_dev:
 	rc_free_device(ir->rc);
 
-- 
2.50.1

