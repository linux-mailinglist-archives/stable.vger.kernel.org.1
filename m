Return-Path: <stable+bounces-222648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM1OHw7BpWknFgAAu9opvQ
	(envelope-from <stable+bounces-222648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:55:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F02381DD51A
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DC03304F30F
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106A423A67;
	Mon,  2 Mar 2026 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKyi3rCa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EC2EB5AF
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470451; cv=none; b=sB0DE/PWFHlWvcN/jubsOFp/e8orRxiylfls0TQ3OV6ErSoWuPdxQ+8YnT8smHLOsObXQeQPLsYY6TxhzfCookAEgeOabj1g2Bvel1menvFYbFDlFar/Q9+n8jhcGlgNXYJ+fA54Cq3E1gazR3udxDqWhMtVOP0vBFoBy4YJqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470451; c=relaxed/simple;
	bh=kc8iwplI4+6/uyCaevkQTAXAZbzUN9DA1g+qBLu+C3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLM9tRNPIVn7hU6YvCX5gtvrlqBlkfmQc3NzuHAd71ChPgMmybRl5G/osTpOXhwOQaWYwoG8AJhyeimkWSVINSQnSJRDp9YT5jVDA/UraRUHDQH+g1kPhy50WyMw8YWISZ/4cuO3XluTsTYU8h974ir5W9B1c6izAcRh5BShWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKyi3rCa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso51052275e9.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772470448; x=1773075248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGqxOkm99t6MTgJtsdTyveUBsFR1EhvjyfpYHp7K/eo=;
        b=bKyi3rCaLbWbV352JvWxrqfDOePOLXpZOq2j6f3+rbXrDDPQaMP4HSyMrwmx/lRS0G
         KX31f90iwGMyhcHz4IvZl1pc8m0keOcSAOqMLYFzU8ExVg1/zMqjgp0PeNhq6V6dTmMF
         k0AtvZgKSBqVBkwf5IeLjacbwvo4tLjf/E55iXVNYXp+mQBCDoPPfjxX1i5ZOrX8ZttV
         g4vbjBc0VVF0uVoEFGKp+y6GeVC7W+Fanka51ZxQXfFZJESuX5EfSF/kXA/COk8H0bPe
         H54cqco9+INB/i9O64uQVBwjqoyTFEEpYg7lv31UMerHkDoeIXgfBFo+sZ32o27Z/dIq
         6jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772470448; x=1773075248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGqxOkm99t6MTgJtsdTyveUBsFR1EhvjyfpYHp7K/eo=;
        b=u4uU/SczA43WmuY9kexvYpUBWxodGSGX7Lgpwprxx6wa+ejuPtT/aP1njAMCUgOU7A
         BzFcP042MMDS0ixZQmtfqj+I2UsY7d21nhDxNMMqQUdioKd3I+mq2o40qWFV47qX/5Au
         /rlvHsifww97M1+9Z+0tXPpwitM0aO5aBaJ2tO+CdBO2BkVkyWUQQqDy0DKb6oV2av31
         gKlmp0++AcK+K9dCsdzjRkFL3SkHeFQdkBOOA8B0IxTXStFt45i7A4zzc/dKj/u9Qr22
         njV/qu3tdtbOK7rGrbhQw3z2FCG44C+MLrRU5JPkQOkcdriIGlT2O7+1Ug81SNf2FHyv
         BzGg==
X-Forwarded-Encrypted: i=1; AJvYcCX6TiSZ0MvVYGYdOAci4UJpjcO3zQzmRdsjCliLuZ4E9kqKXb0y/tcomBEhoaRjIvs4Jy/BYQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBz3/bgd2ZEoqFDyk94KG0C5rXujdCd+FicEGPGTxvEJboVR5
	+30NSYG4N78xHBWVL0ddX3HUJ0l5SQI17DghlOJ6VmNnXgakOQs3VBmA
X-Gm-Gg: ATEYQzx31PKYjgS0/z3LcqkpORg/U5N7H4pbo994ceMQusyInXQRdJV/iCgi8ssnKgX
	fEyA5GN2vNSb5+gqFQfllzNNqk92qe8Z4C1Zd64IuEEC1GsPIMm4t7Qoej67JMCmbuWACxSx2bP
	zB0QUcsE/x0Lj1dimlKfka8JRPmumM7YzYsFGQe4X+E+Qml3IvA/Xe5yE0yUnIy722GUG0EAFGO
	yRnc4AUcIzxmGIoDkI8cy0vpbj15ca46jvanTbakqTLYrXrFu5lswuyvJdHL1rT5KlT2E1UeXqw
	J7lmY89z419bJ5zZh/MhLxRb7BzycTqkPfuIJ0DU6J9AlCmO0fblpurHyF6akOuyAR3XYUmAt0N
	BRC7k5OnKdxfGnvU//pAGREO/LIHu1c5qLuvn9bgtCX3TkUxW0QkCq5spxc2bHGDBbPoJl77sn/
	SZtcjMIKQ2tXnM8XoMIhRvxEhLdwm2FQkE/muX+v6C2EMbymQ8YDon1KuqAGD/2+TaCQyj0JWFL
	vUhwF32oRWyBO81hx9RUTwldToX2H6fG0Y+OG/iJFCdM/Nqfspiv/v9hqjCJI9zrwSIN8HFgPNE
	RMpge98k9JV1YxP8Xte0
X-Received: by 2002:a05:600c:8711:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-483c9b9701amr262555955e9.2.1772470448088;
        Mon, 02 Mar 2026 08:54:08 -0800 (PST)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm253689675e9.5.2026.03.02.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:54:07 -0800 (PST)
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] regulator: pf9453: Respect IRQ trigger settings from firmware
Date: Mon,  2 Mar 2026 17:53:55 +0100
Message-ID: <20260302165357.1797803-2-fra.schnyder@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302165357.1797803-1-fra.schnyder@gmail.com>
References: <20260302165357.1797803-1-fra.schnyder@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F02381DD51A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222648-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Franz Schnyder <franz.schnyder@toradex.com>

The datasheet specifies, that the IRQ_B pin is pulled low when any
unmasked interrupt bit status is changed, and it is released high once
the application processor reads the INT1 register. As it specifies a
level-low behavior, it should not force a falling-edge interrupt.

Remove the IRQF_TRIGGER_FALLING to not force the falling-edge interrupt
and instead rely on the flag from the device tree.

Fixes: 0959b6706325 ("regulator: pf9453: add PMIC PF9453 support")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
v2: No changes
---
 drivers/regulator/pf9453-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
index 779a6fdb0574..eed3055d1c1c 100644
--- a/drivers/regulator/pf9453-regulator.c
+++ b/drivers/regulator/pf9453-regulator.c
@@ -809,7 +809,7 @@ static int pf9453_i2c_probe(struct i2c_client *i2c)
 	}
 
 	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL, pf9453_irq_handler,
-					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					IRQF_ONESHOT,
 					"pf9453-irq", pf9453);
 	if (ret)
 		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
-- 
2.43.0


