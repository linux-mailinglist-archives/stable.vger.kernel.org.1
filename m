Return-Path: <stable+bounces-223840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAkpFWLnr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:41:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E45248AF6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F1D31FBAA7
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AA9441021;
	Tue, 10 Mar 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="fyw3i/Rr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901743E9FD
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134963; cv=none; b=P08+PRmd+xneqdxT+RtH4EyO6U/4rZO6jG8Yq4s2gAzzlr5hs4qvNIuiSvA7duGlbH4q+yoB4B+YVD+CRfkueo2udNJn3SsSm2uIA4LQL8AudE4xW6PGRQ7GBSXhJMS7++EyrSGYvOuMvMDSHudTwJrGw872h82bfCVXDxIGr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134963; c=relaxed/simple;
	bh=O1aC8On/MA8Asa48gmfFpo6774HHdkmtVifIcPxem2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtb8vFg/Y9SnAiU00WVoB1GdeCfwhg8Ewqi2NqrZmHzSPI9FE+9HzRPZ4Vfa3Dz79+ZLdllkEY2jiBYIQxW3xbdZW8fXFbCjpgQI1xBl64YKS4MFf/ujxgu38CbIBCWTlyuN/yRCALvsbeD4roGe+OC8Rbj/ukT7pqhvfgWcuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=fyw3i/Rr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48534237460so26276465e9.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134961; x=1773739761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8lhk/WPiNJlz/hNCzMa0IHLyNJ22cQxP3R/xv+M6DI=;
        b=fyw3i/Rrm00HEOoIRYHjF3EXAmK7464c3QQljL7q+yHQ0XgZht7QeUXnTImJiGHk6r
         5YWewpcTdmUU+IrO66JT9hcmvX59fZ0yg6OJq9Uzy30z9thzYbXsLlqoDVQwNkDWgPGe
         k1Bvm7U2+f52zbWQ0+SPMSqSHS3l22uo85fWyAMFrpHXwY7TM0w1Q32N7+E114Uq8qkq
         DqtAKEldFQ2G/5XfPejuBreSV3vQbt8SSLTBXG4tv6c8zRGzGqWWBpOgT1kzz/TTRntD
         D7LsFcdXPQTEzTx9kXwKwa0+nDvJLt9x5hdb3xd1aVFnzLLL4S6GR8CfpjEjVH3uTirg
         ODyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134961; x=1773739761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8lhk/WPiNJlz/hNCzMa0IHLyNJ22cQxP3R/xv+M6DI=;
        b=ttn8jnBEXFycYgLi8BcW7HdLB0QhJQ8AgJVlfppRZOVihj9gYVDeEa9gAWoOBXrkya
         8SWyFoKsjnCSe9yY5jKy8OGJJO668VcE1JVpWEWGoUFMq53iErG0c4kDcck0t08Zl2yS
         yIGPu1br9nqpMBdP/j6xsKpJK10jpiEq/u8ybNlnH5CTxZWcX6gkM740itfVfGVDI6wi
         NAFeg9b4qGqMayE59FSjNk6Soh8PEuC3m0oKKl1YkGLq/No1Ci13ZPKhJ6NSZQcxYfLj
         p6r+pgaZO9wzDp34ZQjFYhDOG2hh5wVNA/JV0SmgjOAnfOecHDJbSYrQIzOhIAtuQgiR
         THMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXijwUT07iZorlCoDfG5OHzQQntiKkZNx0smjEKs1pF91dg9BOXdt63j7DCHX5HN1lgpbUnC/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPedYi0nnan+J2qWI2G+7T11lUlUf+l3xsVgsbDIWayazBSge
	xs6MbNHk3M28YRPHPXx1XNHvIoT++DFn5/joA6iJq+wJC/yf0/zB4UNtsnSuYyCQiaZqtzZqr/W
	U0p/z
X-Gm-Gg: ATEYQzwAC2guw3a9AOjVXYybOZtDkZVUIOpUXbA5/FrzyOd8fX0ehXjkuidqI+EXaKy
	K1bgtb/89cqafqJp0WQlsfFSPdTLQ+QA8zYARQGlJ2PGVSVJMdCZjO7qVVUFP+Kx63sCrllPM55
	6+DN3LKBDp6COTVgWujpXGBBTgjdrWILUeoNiZVchjM2KqhYBF98DV6WgEY4oP6/riO60sBs30z
	yMiaKfCByFVacRuVMv/2/6wpern75iCXXbHLEvEsE35QKFkzInmH/W1mRZODcYWr259ahztzXbP
	hSO3wnK+PCsNalsNzxMdDYnmW4Y7ZAgSIkwvL/PTd9vm30/QAItFO3SxFCMcptnQL/0XIAiLJUx
	qnnd8WTvj8WhpC1zoGX0bX49aO7YiDYaploH+ShfxMnUwjRDaFUq5YG7ScoBUT81/cFqbr8EMFw
	fU/nU8+lFmzi2n6vUx3Kdlq0EMq/p2DimsYIhgMJNQAPFuVVv+HitF2OpAC4TrQXxLHZl4fooQQ
	wfTDA==
X-Received: by 2002:a05:600c:4505:b0:485:40c6:f527 with SMTP id 5b1f17b1804b1-48540c6f6d6mr65321075e9.32.1773134960593;
        Tue, 10 Mar 2026 02:29:20 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:29 +0400
Subject: [PATCH v3 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-5-02f8e232d63b@flipper.net>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
In-Reply-To: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=alchark@flipper.net;
 h=from:subject:message-id; bh=O1aC8On/MA8Asa48gmfFpo6774HHdkmtVifIcPxem2k=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5K4UWSxcOobJnZOz4qvgUcqbh45tWuNZXPY0j05h
 g2ZAociOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZhqGzmGfwa7+m/b7VyhoHXp0CW1DO9lf5h/bp10ZLJMjp/Po7JIhX8M/wMrWET
 SDTaLtHIm/Q6/KLMrQ2zRGlX/KR9ZGHwNrtXwcAEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: D7E45248AF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223840-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 02c7d8b61e82..7ca4ae610902 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -128,9 +128,8 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
  * @vsys: voltage value to set in uV.
  *
  * This function takes a requested minimum system voltage value, clamps
- * it between the minimum supported value by the charger and a user
- * defined minimum system value, and then writes the value to the
- * appropriate register.
+ * it between the user defined minimum system value and the maximum supported
+ * value by the charger, and then writes the value to the appropriate register.
  *
  * Return: Returns 0 on success or error if an error occurs.
  */
@@ -139,7 +138,7 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 	unsigned int reg;
 	int vsys_min = pdata->vsys_min;
 
-	vsys = clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
+	vsys = clamp(vsys, vsys_min, BQ25703_MINVSYS_MAX_UV);
 	reg = ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
 	reg = FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
 

-- 
2.52.0


