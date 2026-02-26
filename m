Return-Path: <stable+bounces-219804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBpjJnxHoGk9hwQAu9opvQ
	(envelope-from <stable+bounces-219804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:15:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F281A6381
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F1E9305D526
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7097324B31;
	Thu, 26 Feb 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/EiG1Kw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3D313264
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111503; cv=none; b=Mw632pkyHyTT5i2quFonD9sbHQ/uGIcreadkre7PJFwCBAgE5Rp5WjXRjNCZV0DsTy4Vo0mKmnjx8kGJsRx9iGxw4hryg6fl32FS2T87qACrZkgX1kvcP5UuZEee7/tcvbhAEdfTc/PS3k0VPdAx9r5c1WhkT1d2wbVfyXi1hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111503; c=relaxed/simple;
	bh=BjoqhXFbnW4O6mRBJ4tlQbQzL834URssLT4o7VANrbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiH08631XEzU4JbJSyKIdpcFzR3TBxcNqsIFnp+99GjhYjoNT9pbmGKSWMgFY5NXiSTWbyA+hxyflrXpmZ6t+5eooe43QVEXzHqecY6z2L/5629D2Yl/ztgG5eeluENDtRMzzwZTfLyE05Q5/x2kHf6HQM94kMsT3DB9leH/JJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/EiG1Kw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so5142605e9.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772111498; x=1772716298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gpTv0cQ1xaud3+6Hv+n3cMevQTI+cIYX2yYWA3C2vw=;
        b=R/EiG1Kwf3dl2WGPK8JaAdZwH/pZCfau/wpmzbhY3w0KUBWfrGLeN+K8h+ZChIJru6
         k/oCSOFX8xzdxuhj0hDQTOMl7qIn86OQWYeRk7EPUmjw19qAfghgy3O2yq3tL78bd1Uy
         qf1XiTiTVYGF1EaEm2GW3U3U8QUaq5FqaBAE/dahkYD6H4GOEclP76Cb4008mFVRXkWC
         TYh+4z5KYOi2JRPUaiYtauuTTioiyrekKXQRJsZZbZWuzUQMbnjdcyXM6EBaXzrv6372
         HOHajvY3NeUr7xVD8kc+7MFEP1h8qh1fVLt8qAps1iN2v+jm8LzEnB27MgFmY7tL6nyF
         Bayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111498; x=1772716298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0gpTv0cQ1xaud3+6Hv+n3cMevQTI+cIYX2yYWA3C2vw=;
        b=JcloVdMgRYmYfbL+c+ai8LcJeP3Oz+ajRMv3E6JkOmh7BGDT9kI63Ml3yKpnBrsv4d
         Dxpi/F+vyJFNu0EvVqdwV5Sp4NhS0HPxi6ejOiSKDrW20Owv8pRJG8gp/+MT//st8U+S
         1NvGyvEaLLLrf8v9YQkEn3hf409uilpwG2U3JNTUDvFzo+RE3oTP9ZEyXeYSSBXfrcu+
         n+slUcjxxp1Gcfee54nZbvDQsOgDyMCbrp6lEphpV6uJ/NuZ1nJRCWb8aLyFNUHIHZ1+
         gkS60dwCWqvGb5EXGY8AGtcT3EHDzfwTgx30MBJkFfXb0Tq+zIu+7ZlB3S1oKQm+WP5H
         ME/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA9b1H+omgiPnrHZ4B1NHv4mmtuOXdeMeuBR7HtuLHvyNF3AK14UbQKMN0hBxc/2iKU2EXroI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVm1MOJXOJlVQ2+Yf5x1zykQV1WGnPPMaij1namEG+79L0bxq6
	AIPZ15VZl7rsVvyb4UzKYuPkRxd21JnzwVARSnutzSgpJfe/JwCy0bVT
X-Gm-Gg: ATEYQzzSV/PoNXdv4UcrdoTYTvmCo3+eJA+wKuHskJDJVjmBVuAW78pjdlHDfAI4G0Q
	smykys+EXSlD0wuJBYZvDXR+++r8Z6dQFcIGVflrNxAcOViT6UBWtj2jfoP7/rj/Hej36DY73x4
	pTd6nQkxgnizgJ5IQ24+fXoTwBN9+B2qJ0dW+CwGXcNWv3MNoFiCdH7OKc6xdZlQXssH/0Ytq4v
	AiiPdtLfiIqTB1WE9vntriwI+p4RWWJNZFMm7LU07mEZh4zYgYMBnASZEdFa8MlhKDCgGQOANgI
	sLi2/1YMpLquxkn4a9Na9XO0YzOGz6Z8WAm/kVzBtsnklO7V8NR/HI4wsDkQzOyqZvZpOGSN1xu
	RqhJNK5gJyQ4Pj+bqdMJxgWTgkSFjcJMbfefx7YHTSDTg8DxPPng119T0CxzBZnAXxaduFBo+Dj
	tNkgzjT051Sgy68L29EVElcZ8w3cLPBYho6vI5SgIFUrvmvAHOnk2zkENmwk6LeyU=
X-Received: by 2002:a05:600c:83ce:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-483c21a9ab7mr73637575e9.31.1772111497833;
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfb789efsm64827145e9.2.2026.02.26.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 26 Feb 2026 14:11:27 +0100
Subject: [PATCH v4 1/2] i2c: pxa: defer reset on Armada 3700 when recovery
 is used
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-i2c-pxa-fix-i2c-communication-v4-1-797a091dae87@gmail.com>
References: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
In-Reply-To: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Hanna Hawa <hhhawa@amazon.com>
Cc: Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219804-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sartura.hr,vger.kernel.org,lists.infradead.org,gmail.com,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,renesas,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sartura.hr:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0F281A6381
X-Rspamd-Action: no action

The I2C communication is completely broken on the Armada 3700 platform
since commit 0b01392c18b9 ("i2c: pxa: move to generic GPIO recovery").

For example, on the Methode uDPU board, probing of the two onboard
temperature sensors fails ...

  [    7.271713] i2c i2c-0: using pinctrl states for GPIO recovery
  [    7.277503] i2c i2c-0:  PXA I2C adapter
  [    7.282199] i2c i2c-1: using pinctrl states for GPIO recovery
  [    7.288241] i2c i2c-1:  PXA I2C adapter
  [    7.292947] sfp sfp-eth1: Host maximum power 3.0W
  [    7.299614] sfp sfp-eth0: Host maximum power 3.0W
  [    7.308178] lm75 1-0048: supply vs not found, using dummy regulator
  [   32.489631] lm75 1-0048: probe with driver lm75 failed with error -121
  [   32.496833] lm75 1-0049: supply vs not found, using dummy regulator
  [   82.890614] lm75 1-0049: probe with driver lm75 failed with error -121

... and accessing the plugged-in SFP modules also does not work:

  [  511.298537] sfp sfp-eth1: please wait, module slow to respond
  [  536.488530] sfp sfp-eth0: please wait, module slow to respond
  ...
  [ 1065.688536] sfp sfp-eth1: failed to read EEPROM: -EREMOTEIO
  [ 1090.888532] sfp sfp-eth0: failed to read EEPROM: -EREMOTEIO

After a discussion [1], there was an attempt to fix the problem by
reverting the offending change by commit 7b211c767121 ("Revert "i2c:
pxa: move to generic GPIO recovery""), but that only helped to fix
the issue in the 6.1.y stable tree. The reason behind the partial succes
is that there was another change in commit 20cb3fce4d60 ("i2c: Set i2c
pinctrl recovery info from it's device pinctrl") in the 6.3-rc1 cycle
which broke things further.

The cause of the problem is the same in case of both offending commits
mentioned above. Namely, the I2C core code changes the pinctrl state to
GPIO while running the recovery initialization code. Although the PXA
specific initialization also does this, but the key difference is that
it happens before the controller is getting enabled in i2c_pxa_reset(),
whereas in the case of the generic initialization it happens after that.

Change the code to reset the controller only before the first transfer
instead of before registering the controller. This ensures that the
controller is not enabled at the time when the generic recovery code
performs the pinctrl state changes, thus avoids the problem described
above.

As the result this change restores the original behaviour, which in
turn makes the I2C communication to work again as it can be seen from
the following log:

  [    7.363250] i2c i2c-0: using pinctrl states for GPIO recovery
  [    7.369041] i2c i2c-0:  PXA I2C adapter
  [    7.373673] i2c i2c-1: using pinctrl states for GPIO recovery
  [    7.379742] i2c i2c-1:  PXA I2C adapter
  [    7.384506] sfp sfp-eth1: Host maximum power 3.0W
  [    7.393013] sfp sfp-eth0: Host maximum power 3.0W
  [    7.399266] lm75 1-0048: supply vs not found, using dummy regulator
  [    7.407257] hwmon hwmon0: temp1_input not attached to any thermal zone
  [    7.413863] lm75 1-0048: hwmon0: sensor 'tmp75c'
  [    7.418746] lm75 1-0049: supply vs not found, using dummy regulator
  [    7.426371] hwmon hwmon1: temp1_input not attached to any thermal zone
  [    7.432972] lm75 1-0049: hwmon1: sensor 'tmp75c'
  [    7.755092] sfp sfp-eth1: module MENTECHOPTO      POS22-LDCC-KR    rev 1.0  sn MNC208U90009     dc 200828
  [    7.764997] mvneta d0040000.ethernet eth1: unsupported SFP module: no common interface modes
  [    7.785362] sfp sfp-eth0: module Mikrotik         S-RJ01           rev 1.0  sn 61B103C55C58     dc 201022
  [    7.803426] hwmon hwmon2: temp1_input not attached to any thermal zone

Link: https://lore.kernel.org/r/20230926160255.330417-1-robert.marko@sartura.hr #1

Cc: stable@vger.kernel.org # 6.3+
Fixes: 20cb3fce4d60 ("i2c: Set i2c pinctrl recovery info from it's device pinctrl")
Tested-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
  - rebase on tip of i2c/i2c-host-fixes
  - add Tested-by tag from Robert
  - Link to v3: https://lore.kernel.org/r/20250827-i2c-pxa-fix-i2c-communication-v3-1-052c9b1966a2@gmail.com

Changes in v3:
  - rebase on tip of i2c/for-current
  - rework the patch and use a different approach which does not requires
    modification in the I2C core code and update commit description
    acccordingly
  - remove Imre's SoB tag, it should have been a Reviewed-by tag, but due
    to the rework this is an entirely different patch so that does not
    apply anyway
  - use Link tag for the URL of the referenced LKML thread
  - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-communication-v2-2-ca42ea818dc9@gmail.com

Changes in v2:
  - rebase and retest on tip of i2c/for-current
  - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-communication-v1-2-e9097d09a015@gmail.com
---
 drivers/i2c/busses/i2c-pxa.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 09af3b3625f1107d2722cb026e67b69b07cca2e3..f55840b2eb9ab70aad43bd7f4f44c39aa4d9c67f 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -268,6 +268,7 @@ struct pxa_i2c {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*pinctrl_default;
 	struct pinctrl_state	*pinctrl_recovery;
+	bool			reset_before_xfer;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -1144,6 +1145,11 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap,
 {
 	struct pxa_i2c *i2c = adap->algo_data;
 
+	if (i2c->reset_before_xfer) {
+		i2c_pxa_reset(i2c);
+		i2c->reset_before_xfer = false;
+	}
+
 	return i2c_pxa_internal_xfer(i2c, msgs, num, i2c_pxa_do_xfer);
 }
 
@@ -1521,7 +1527,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		}
 	}
 
-	i2c_pxa_reset(i2c);
+	/*
+	 * Skip reset on Armada 3700 when recovery is used to avoid
+	 * controller hang due to the pinctrl state changes done by
+	 * the generic recovery initialization code. The reset will
+	 * be performed later, prior to the first transfer.
+	 */
+	if (i2c_type == REGS_A3700 && i2c->adap.bus_recovery_info)
+		i2c->reset_before_xfer = true;
+	else
+		i2c_pxa_reset(i2c);
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0)

-- 
2.53.0


