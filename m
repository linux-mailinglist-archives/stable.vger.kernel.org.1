Return-Path: <stable+bounces-231253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Jh/JH+cymmg+QUAu9opvQ
	(envelope-from <stable+bounces-231253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:53:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BF135E358
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E35304CA5A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2AC36DA15;
	Mon, 30 Mar 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn3Cm7fO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33136C5BF
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885411; cv=none; b=WT5mVfAFi5DAHgFffF4FxtA1qcP3sxF6uZPRSncBQBZOY62od1YCMBTtuqoruY3UDf7HJVxH8JgOtA0VKp5f/3BSzdZFZa6zh99T5C4/zHPJq7IGx9gjjojEh9lSZF4g6ECCBjQTvhmb8yUku18ClxLpbmC2EiTaqsUimtyhTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885411; c=relaxed/simple;
	bh=8AA78bo6gDi6k5n+uSlrguBGNGx2x4N4ETCxeBlmgUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apULrHyPkh4kCDEY3WXID/bX6YQaHuibCuh3zPnCDS1ISMpZG9K9Fb/fQAP11eyj/RaV5TXCBeNfQIbGmtHNTSofeMnQRvejyGOItXaCEEZREJC6vNOeKd+8Ba7giHgyhJm3D+zJBTjxqgGDX59PsFx9G60nr4DQnbS07rIKfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn3Cm7fO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853a485721so6605675e9.3
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774885408; x=1775490208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tO3ofX4oRPeqN1ii3JJFXpJAdRDWRpLKYddtaDkaAMM=;
        b=nn3Cm7fOFQykfCUMbjcKv0YNiEUm6VcNj2G+WNEyR1owWwYjH3z7h7zCC4ducD9irs
         GggNHe82eSfv+nqb+N2yV6CI21YLEiWReGzDlOtD8cbam5PX1ufNbXp6B25bE5XCTQxf
         3kST2IhLzMayuQAcecMiV71fU/NAVlJOCHk7p84uodcjVZWWp9Wr3SZpuB0LpTA9AfTy
         k+AmM6ki5DOqiCwxRB5/5lcTc02MaFlG8+bPonTFoTY2ZELaZtshDWPi3jNwtJ557DNw
         8e0+sUZsl35qFqbgIrAosREe9sNVBkOO5ijUnDqArhU3TvfZFoAEtnqvF+ROBBaAaaG0
         cDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774885408; x=1775490208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO3ofX4oRPeqN1ii3JJFXpJAdRDWRpLKYddtaDkaAMM=;
        b=lzmM6/4evyAgdNiHghKz77u4dvFZvycmxzRkImU6EatwKiJCaqElYPD65WJ+4FMMaE
         kBdwhWbL4tiUHBSXES89i7ovBrTY0AY2A8FpL8Yb6zIbFxIqOzRHwJRqAA4VjoxD3H62
         yJoqSAOs7PnB4v0ens+C67eww9hAmKNcQ0G+3o7E528oAZogpwhNgKbNzVzoq0oLtayv
         FQ5+gYCbf3DORyRnkF44W+BRKjjJ6BN9Fxiisa1UW7zn8sSS1e+2v9SfZ0Eq71RNhPIy
         9/75qqmxtmgELljJlL1audIGBmPLIIvPEGz4HMBfUru0pbcPz3uuda5Vv/EHhFV87CPj
         +MFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfdy7AIFIX+cIo6BDp2C0Et1TGjeUjcq6J/GV6y0+3BYHpmq6ZsMq9t3nxb0dSzL5hyjMl8vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqiwgUayIxptE2+dG54Q/e77RAkcjrmohqkI8mR2T08E/jgSNM
	8uGce+OhVn2tDV1eSPbzJGRC3HJVO4iDWme3JOhqhpjn1lWV5IeLd52enOETItOx
X-Gm-Gg: ATEYQzzPNd58caze8P0Co6FGQ15nJgJNDMDFv7ZkCxFBszRDQgPegbyzKhIOMewM5Jo
	xbRAiaKvbmAgli3Z4aVdQ4v1v6FHFd3I8G17G1e7Q9Mc+SFWAS0YnGLX3ptpE42vdD3oSvrpylw
	B/MZBaTbjSemn0nsZ5hR3e+4JCVj1SFchB7c+6gxAkceu5+id2VADwg7rKs3ZhkGhhgetndUPqZ
	fciYfsBCAsAH6mz3t4IHDtuj0WT3jx0q2GFOQ134Jn9119xj2EflXh3fwes/IeEXrTRKI1ixEuh
	7uvRDnDUBSYd13Nm0XVYCRu/SYTKny0NvEs1V5+L5VqtnpAzXzNQ/+4vCU8/9dhANlXha7NfRQi
	AwpyKoWjVT6rkYr4SWn5NMMSNZkORy/KyDro7648xtIOpDEsV5MEncoLKCeshxhvBntWrGbVI+R
	OY8jKJ3Pr8d2Zf21aMJkTvfkg2j/7f9epsv6CcTgnuiyDba+ijXjt17er/c4QKQvcvlPfcwljnM
	PXg/sc/bIKglvh49Kd1
X-Received: by 2002:a05:600c:524f:b0:486:fb8a:fd9 with SMTP id 5b1f17b1804b1-48727c82fa8mr113297715e9.0.1774885408204;
        Mon, 30 Mar 2026 08:43:28 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48722c6b4d0sm281883215e9.3.2026.03.30.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:43:27 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] can: sja1000: Fix pci_iounmap() buffer
Date: Mon, 30 Mar 2026 17:42:31 +0200
Message-ID: <20260330154236.98665-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231253-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,pengutronix.de,kernel.org,grandegger.com,davemloft.net];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20BF135E358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The base_addr is mapped in kvaser_pci_init_one() and the pointer is
copied to priv->reg_base in kvaser_pci_add_chan() with offset
channel * KVASER_PCI_PORT_BYTES but unmapped without the offset.

Cancel the offset before calling pci_iounmap().

Fixes: 255a9154319d ("can: sja1000: stop misusing member base_addr of struct net_device")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/can/sja1000/kvaser_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index 95fe9ee1ce32..213fd0eb07e7 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -161,6 +161,7 @@ static void kvaser_pci_del_chan(struct net_device *dev)
 {
 	struct sja1000_priv *priv;
 	struct kvaser_pci *board;
+	void __iomem *base_addr;
 	int i;
 
 	if (!dev)
@@ -186,7 +187,8 @@ static void kvaser_pci_del_chan(struct net_device *dev)
 	}
 	unregister_sja1000dev(dev);
 
-	pci_iounmap(board->pci_dev, priv->reg_base);
+	base_addr = priv->reg_base - board->channel * KVASER_PCI_PORT_BYTES;
+	pci_iounmap(board->pci_dev, base_addr);
 	pci_iounmap(board->pci_dev, board->conf_addr);
 	pci_iounmap(board->pci_dev, board->res_addr);
 
-- 
2.43.0


