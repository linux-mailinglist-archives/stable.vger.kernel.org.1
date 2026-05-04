Return-Path: <stable+bounces-243022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAK/LrmV+GkOwwIAu9opvQ
	(envelope-from <stable+bounces-243022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:48:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC74BD361
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D6D301BCC0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854263D75DD;
	Mon,  4 May 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTV0ng8r"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317203D3CF6
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898930; cv=none; b=nILajZmOthqlIJ10sjsvy4qUW1HA5N14YlfpBeI4lpURM4lGP5UBq1rTbJKHu0Jgk+kU29B6HHFJAe2M45McpB9rm7RC/JfRU59lekMdBPX2U8M/Z/C+wmfwRT3sry1yt8E41KH6DXEXx4Z6TI6U89AzFtZw9RLSmmDlXKcRDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898930; c=relaxed/simple;
	bh=lH1s4f1DsUeMWlf3k4JQdvGtPacKmGPSl5TfO1+bXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3/3qjmDYktGftwaEbLGAkGSH06/iON7iKhtVmHtA+iLFIzYYYS+DhuCuyIpUu6QZa5BWSJyHBDiCmr00rEJOi10b9mCPGGhypPQaXCWh3MraABBwmnGAlB0NQfJnCnkgmUzrtyjwp8MgeRjHV9I48rPeZK+Y4iXCjwbxpRF4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTV0ng8r; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so4721151e87.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 05:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898924; x=1778503724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hp5CCZAjAcFJLhnHM/r6dRzm24SM3LtlL2s2xjPAQQ=;
        b=kTV0ng8rUOnQWbzbNTt64ZahPZULzCKBET07M0IVlowy6KeRD47g+/f+TVHXEzdyfw
         n5QfygX51wuIz+mW9dlgVrgcCcg7FseRb+D3cM2flqIa9Yc3sv2eV35bz+5tp6ZlUNq2
         3gGa21lgOL8nkdaNZnXMowAKXbMkW5EmK6h3In3DlWIddsCSDkdfSEYtfj3QGSe11SEU
         PYwikP2CTeRhx5Bgq2fb8iuWhW2qjhQ7l91CclnyI6/Z/Sr/RuQOPMLFoQqZ5TxSf6c+
         t4qFitoMqX1oRTUOzkm0Mi9O5h8JpH5YjbwU/DE22tcX3pAWnTuX/tsyMpwGt2cpFq/S
         eLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898924; x=1778503724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Hp5CCZAjAcFJLhnHM/r6dRzm24SM3LtlL2s2xjPAQQ=;
        b=CbT8OfIcdyNDf4OKoomS6xKSyySivhNbK0KxdZJjWmoCNYpnAzxsFdM3CTK0wv6NYR
         5C3yTvq1thAmjJBHXRwZsf2kua0BAh7hRjBGHShRr8//SPU62LetCEDIRxwbromtlIcx
         8xh8dVaBSpfBJ8kAeKUHNyQ3s/D9yWSmEEE91xmZovKzAc0yue6a3PoueGDd3BLPECBK
         TLOjwAqm7BnIpxHaEItgDTOXJyYmMYlFf71DNrFXMs47K8sD0jM+YPHK9oCgME1kXenq
         R2k7UaYpxJ6Cw7T2SEI8wvvAnshDbNMcPFg5VrPvkMSQ++PmVtvDQ09x8IFj9s4A1Uxu
         vrHA==
X-Forwarded-Encrypted: i=1; AFNElJ+/hHWSe4o51wEfaTfp+LDI3RaBkmiiyxl+bKcxXL2o3wZAFHkYWR6RzvXfd/30B/cSyBVgqP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmypuiTneUwA2SOrDFJpL7FmM15JJur2qbpJYQrWyH7FpPWb1
	Zgnx9rPQDuZsmb9EYAjok4en+z7L8wMfW1SZj45asxsjBau0eOQAi0/H
X-Gm-Gg: AeBDieswD2XZ7+PTyRJ/oWvl+qOa5T0UZaknN3eloe0kqDk3aEFAsSGXIRGHIu7KCIg
	bMCMY9mustPReeovyKVVHEvbDT2iXfvZEv0uZKIanpdKjlOP8IzFUtfeybq/UOeLbMiMHab9LD/
	uNDTKugeqQmGp04z7i56sv6V8JiMfPgstMqVbZiIrGBZr7CEWq2fNIcedmZKXxECFcqafB4KLOa
	hzbEq/m5BcZnPy+Qlf/DzMFoWNsVbu3x+he6ojUpR/apZLXJVXAl+SKZTrdSiVJffk+3lDVIP/D
	xa+c+6I9VnDXwLzfMa6C/l/284KbO3M6JDQbx8BNEDuTZ+5atK+ikUxENYE567KChvQGlpcVbL2
	shQ9nIbEXdCN+U2G0T6ahlI54hDDDvOSf6b9s6QnmchircgFHUvfgbPl4RHjoQBLHvPq8RG24O3
	HZb5KgfQTIOIhfChkr8bxX9nqpYTlHBtEjyoiFSAbj3q2At5F4ieeQp0ym+42feGHVZURM/DX2v
	dYw1ElE4w==
X-Received: by 2002:a05:6512:3b0a:b0:5a8:5276:f0db with SMTP id 2adb3069b0e04-5a862fbccfcmr2796502e87.15.1777898924030;
        Mon, 04 May 2026 05:48:44 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c34165esm2922831e87.56.2026.05.04.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:48:43 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Ben Dooks <ben@fluff.org.uk>,
	Vincent Sanders <vince@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mfd: sm501: fix reference leak on failed device registration
Date: Mon,  4 May 2026 15:48:41 +0300
Message-ID: <20260504124841.443496-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <6b4a9f5ae8a316b6f07f72f2fe3f0b8fc5f18dff.1777889235.git.vebohr@gmail.com>
References: <6b4a9f5ae8a316b6f07f72f2fe3f0b8fc5f18dff.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 42EC74BD361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[fluff.org.uk,arm.linux.org.uk,linux-foundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-243022-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


