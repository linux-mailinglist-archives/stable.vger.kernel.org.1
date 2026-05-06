Return-Path: <stable+bounces-244421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE3SDOVh+2kuaQMAu9opvQ
	(envelope-from <stable+bounces-244421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:44:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C79804DD80D
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A6DB304DE6C
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDA494A10;
	Wed,  6 May 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDKkztDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC747D95D
	for <stable@vger.kernel.org>; Wed,  6 May 2026 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082052; cv=none; b=nG70n2C2/nvb6Y1lOVS4+caUckAbKwBqkhi/P4GwtaxuTEi8tnHTwSET6WC1FQ+vvfj3Sz9nogAT+/biHU3u9xf9Em6Wib6mCG/b53ZqkVPhLAe83ZdD7bgbBDCEiyzyzLdL+Dg0beDSBe+lGj+zqVxk25ldi/kBUIdBtgydt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082052; c=relaxed/simple;
	bh=lH1s4f1DsUeMWlf3k4JQdvGtPacKmGPSl5TfO1+bXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGLRB6bHhX6HVI62dG6iC0RH7S8vlwcaulwxXDNzTGoKiyeBxnnI0vlmyI1n9JfScLL2Xl2jhg4gBHX0BHuvgI1rjRYhGufP0zKf6FPKxLSc2ylKhWrVuExdXOtX/WWlaqn1kEbqeQZl7LIcIFStwmI0p/9mXIH8hCT5d9fOl9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDKkztDg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a748d5ece4so7094330e87.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778082043; x=1778686843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hp5CCZAjAcFJLhnHM/r6dRzm24SM3LtlL2s2xjPAQQ=;
        b=BDKkztDgOIKqwqIzIxm+RXYycD+wW6HSWH0e1t6o7OgpsY47Bq4GHBsGC7vMvtR8aS
         468h5JYudYUtGKMXznxTb15XSqRq8Oqs48odgCdM2jEgKMuB8jowaYNh+XTLBCxfNJRi
         PayC0jiznQxlsQCmH2RIFThnGjfR10kudipQ4SkBbWThtTq9HS8/nrdmA04j8nFGlHr8
         e/WxzMEpS+oy4Upr9Nud5o9FCKMM6AkYNfeVtg0fOeY6YdOkxKNO8wqt5SrQlnS92wwP
         baqmjlsraYAJJb5DbP8RvlU7pzoOqqrcgLlYVcSDegv/lZpEXKNf7FNZwEJOP0vIBF1q
         RRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082043; x=1778686843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Hp5CCZAjAcFJLhnHM/r6dRzm24SM3LtlL2s2xjPAQQ=;
        b=JXTJsYn9G0H1ojTOfr5ciAiIIbFlyvh+FWCP9mjQmb42r5WiBpiyzLCIMzIU7qkjQP
         +Z+AmmkhVJo+YxDECahwSRd3Ox+I3CsJ7/ZLO3n8JzKsmxzUoD4KmJ5vhynCwDxu86Fk
         R03/XAChTmcH3kkMZg7aGIohOXxHQAaKN3GJhV63oDA/ayq5e860afXpdo2gzDdusg7R
         OtO3t2QMRtVSwN/f574/aJfgEwDgQPCryq5dvJAkmDxUTATE6oPFORVTzNRHe0E/41gP
         uYapvX7BJPAEfu+R6CQUHZpbeSrE9F+h15kN8I9TISCf+yUL8WhgnwqwperlOH+eJbno
         v9tA==
X-Forwarded-Encrypted: i=1; AFNElJ+vdiU+9JrbztOKAgnRWc3VYVIN4IIPV2wpIJcBKkQscP9ndYAbwwu6NWZFqKyLFLwkVMTg8Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIL7TyV+TfvaQh2iJ4rhqFfYamDbgbaousRRW/I0H3s0m3q4PA
	IKAdTcLyJET2Jux/vMoYKGvWbOuxxhnsf+pQw1PYMngFB2NXaPzpqOuuxYFn3Z+LoZtxQxZwSFc
	=
X-Gm-Gg: AeBDieto4beJ703XTIeCEYk9KrJtOItf3MdbY7yZF88NiMKqvczdGmcqlddK1z3f0Jx
	epYzGqt3RbT266zYjc0PPxImnCQ/dJs0MO1hb+8/MrI/fsr/hpuajXMQtLU87AU0ibaYs+Gfxrv
	Fyw/zXyRbs3DhFdjrkSOlyMoNYXxnjwazAWjW/7wedchWmdaiUVxjt4h9epSlXx7kxfMX6J5zlV
	O50GCfOYxxDciH/YFumz7cmQhBxG86oeW3dRBCLH41E89TENtHdp1MIyn/rp0yJeDnMc25vAKaz
	WeSibK++o9F84+z9ZYVf00QKS3sEcJO6HM+0hAX7bH4Hn6u73+ROyInU0jDFjarAWITeo2FZjgq
	DF2SJVySvMGJYH9A3mI+uNZUQkCz1vXdOOPIZiZe33may6YK9vGPaAkQRiLAY5utzZ+Rx2ExyQo
	J24YWmO326PrmsnR455BZuVrIR60WD8yDSBLKCQmtmhBsl7dI+VCKLX7QY8PvNsFHYdqXj/vQ=
X-Received: by 2002:a05:6512:12ce:b0:5a8:5277:12c with SMTP id 2adb3069b0e04-5a887ae3e8dmr1492467e87.17.1778082042812;
        Wed, 06 May 2026 08:40:42 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a888d59084sm643334e87.2.2026.05.06.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:40:42 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mfd: sm501: fix reference leak on failed device registration
Date: Wed,  6 May 2026 18:40:40 +0300
Message-ID: <20260506154040.672860-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260504124841.443496-1-vebohr@gmail.com>
References: <20260504124841.443496-1-vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C79804DD80D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

When platform_device_register() fails in sm501_register_device(), the
platform device allocated by sm501_create_subdev() has its struct device
initialized by device_initialize() inside platform_device_register(). The
error path logs the error but returns without dropping the device reference,
leaking the memory allocated by sm501_create_subdev():

  sm501_register_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)   /* kref = 1 */
       -> platform_device_add(pdev)       /* fails */
    <- dev_err() called, kref still 1, sm501_device_release never called

The device's release callback (sm501_device_release) calls kfree() on the
containing sm501_device structure. Without platform_device_put(), this
memory is never freed.

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch, which
triggers sm501_device_release() and frees the allocated memory.

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
 drivers/mfd/sm501.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 0ee6d8940e69..8276456b142f 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -704,9 +704,11 @@ static int sm501_register_device(struct sm501_devdata *sm,
 	if (ret >= 0) {
 		dev_dbg(sm->dev, "registered %s\n", pdev->name);
 		list_add_tail(&smdev->list, &sm->devices);
-	} else
+	} else {
 		dev_err(sm->dev, "error registering %s (%d)\n",
 			pdev->name, ret);
+		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
2.51.0


