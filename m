Return-Path: <stable+bounces-218775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGfRB5JTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B888918F903
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F6DB307DE40
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6A275AE8;
	Wed, 25 Feb 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xsmm4Dz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073C256C8B;
	Wed, 25 Feb 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983647; cv=none; b=UVQ07JT3NBFOaI7YZGK+DKKQc4WUhNipkvSDHwKqpW+/QjVStLjJeTY4nPpcrkXXe/+Td9IHQQUpbpkpERvKDczVW0yjNYmw9GRLjPaQNHpZFlZvhqacfQyWlXKP3Rw2zHT6G8fIfEeocLRiOeoJ0F196Obk76A43wswJHnMvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983647; c=relaxed/simple;
	bh=868/8SyeUw4KEpVYTFDky8MpE2uLlOYLLstGlG5xeJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi2AQE8y+fHSpSKjsvzw/nV4kQ2ZMueH1k5FCDUOTwVlOOUbwkZXTyo+vNp2hIZ/YyBRCLqoAIIPsghB9y16SOVsjkoz7rIG+KOLtsbP8qv28QY1Zi/cL3eokgv0XKlXXDoZEuA9l5aEa/HAremM6DFS6yFdYZBJupF4MMAFAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xsmm4Dz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C1CC116D0;
	Wed, 25 Feb 2026 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983647;
	bh=868/8SyeUw4KEpVYTFDky8MpE2uLlOYLLstGlG5xeJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xsmm4Dz5xMr1bnKRmNC1+2fW+OTm7HwuQVp7KNUDOlNxP2qdPcViC5tQmev/neLcs
	 YBfM+hz3n7Hy1kbZJrytJIvyPoPxmRf5zJfw9IZaxXZS4+3mJoxF1vQQH52PhTtWFq
	 hHgGyyBHtbdBkDZVmkONdHHqsjKPtkcQj53ATJzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	Tj <tj.iam.tj@proton.me>
Subject: [PATCH 6.19 734/781] gpio: amd-fch: ionly return allowed values from amd_fch_gpio_get()
Date: Tue, 24 Feb 2026 17:24:03 -0800
Message-ID: <20260225012417.733536548@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218775-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,kernel.org,proton.me];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B888918F903
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit fbd03587ba732c612b8a569d1cf5bed72bd3a27c ]

As of 86ef402d805d ("gpiolib: sanitize the return value of
gpio_chip::get()") gpiolib requires drivers implementing GPIOs to only
return 0, 1 or negative error for the get() callbacks. Ensure that
amd-fch complies with this requirement.

Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Reported-and-tested-by: Tj <tj.iam.tj@proton.me>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://patch.msgid.link/aZTlwnvHt2Gho4yN@google.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-amd-fch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-amd-fch.c b/drivers/gpio/gpio-amd-fch.c
index e6c6c3ec7656e..9f329938202bf 100644
--- a/drivers/gpio/gpio-amd-fch.c
+++ b/drivers/gpio/gpio-amd-fch.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -120,15 +121,15 @@ static int amd_fch_gpio_get(struct gpio_chip *gc,
 			    unsigned int offset)
 {
 	unsigned long flags;
-	int ret;
+	u32 val;
 	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
 	void __iomem *ptr = amd_fch_gpio_addr(priv, offset);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	ret = (readl_relaxed(ptr) & AMD_FCH_GPIO_FLAG_READ);
+	val = readl_relaxed(ptr);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return ret;
+	return FIELD_GET(AMD_FCH_GPIO_FLAG_READ, val);
 }
 
 static int amd_fch_gpio_request(struct gpio_chip *chip,
-- 
2.51.0




