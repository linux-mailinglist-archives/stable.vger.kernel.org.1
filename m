Return-Path: <stable+bounces-223347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGAPNL/lqmkTYAEAu9opvQ
	(envelope-from <stable+bounces-223347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:33:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77633222BB0
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02C0830364E0
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF4271A94;
	Fri,  6 Mar 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="hb07hmKV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B94331A57
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807606; cv=none; b=RcF9D6pq4xLVNRbYkjHEezpB8CwSXBmWZnbIlksTB9IrjRtCcPw4IxeHXQsBF2UIKnIGyFXKsCMV0+mt+58zBAfKOZxZY4QFILhBMT2nCZPrXSMMaDb/kCveOw93L1GadLIV1Y0N/RfhQ2x47XdQL9+Yuhoo6yCkd61noLnZODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807606; c=relaxed/simple;
	bh=Q9D7eBKxq86MNvlgm1qDMnqHysA/422W4yV9eBroyC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCmElnTDRWmmjsuO1NLxS5Rd2QpUuPQwEAcgIDoC7uZ6lcjMa6GHR6RiGzFLpLTgZgjc7HQejQc0A3CWX/vYL+20jlzhSF4mKiAkGgci1AFUPDbF74pgypuofbR45SkC2r7pTCtvvjDfZ/D3oPf8mf5Ut6tuGmAP8DFmg9gpJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=hb07hmKV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439ac15f35fso5942094f8f.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807604; x=1773412404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz4biLahYPKsT9J1ufLdEia90vJM1vdO3bq5iy8XGEM=;
        b=hb07hmKVFklaYksufnqvG4Dtv82VpVtF284kZVDLekZ0Hlo9DqXt9fT5waLAqEe6zW
         EsaajfcccqaDX+qHghQidCN5OYGIpkR+TZNcbOR4iUu+TGflTsANcqu3O6OHBX8atPBa
         rjxLvfDX1kH+jpaguxpa0ezpG83xwZB2LUE+gV0tV4/Q80I7LBHExvu/9E/HHHM7oBEJ
         jXHBg1chLmBy5KRpTveuGfmJlhTvYO9gPZyXAyDVTnk1cs+qxwJeDCPNkPtz/jImCadY
         83PvoEm3N6Loi8P0aMss9ElA9l3ZRE9uIY5FF3BFaXq4IJtj9tpmoz/vIZGdTMYLGDsf
         vKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807604; x=1773412404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sz4biLahYPKsT9J1ufLdEia90vJM1vdO3bq5iy8XGEM=;
        b=lgm1wnT3+41ksqAbbqQIC0zhp19NoelHYJ52RkLENao0OGCAjxFme/33Sl3g2+3edn
         Zr9Isma1pV4wEFdNs+cpxwECa7v3oYBOi13pL01ecpLncsKI2GGd0/Dzagru36cJ0KsS
         9kTB7xHRDVKC4uMSMq4m4V+pkAyHXjX6LNkR0gPqgwh2FsKCT44FzWZZe/OhV5wZp9JI
         FOhuJ1tggjcG2tYZHRSoJ+xF5lFHSMci4VqSrHH7ZIJocyckifwuMJXmEqJYZLx4uD4V
         //eAg+TQkR0ciYwsH73wjqmFWv2lhuKY+ZhdwfD1OHdZtcnEmJGBcxNV0lfCivp62FAY
         RBsA==
X-Forwarded-Encrypted: i=1; AJvYcCUiqGqjgb+1nq4FnX73vDVrFqbafb1wsa97Bx5dPqDGyQyuPPQLnjlLkKawsUwbg8hPUxcgpaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZULGXdmB5UEG4h1g/QbTKYefGz2+n8dpJxl6bTUS8bwxuX5k8
	v74SFttJfz4Y9KP28PGvHwkdVayznWK38GybF0Wm5B9mKHoNAHsfEIWOKrN2YLCgmXg=
X-Gm-Gg: ATEYQzwzIZPntfN3UxkCMKJh5N2NpDEHHi9d6bM1OKHomCkmnXWVrXKb7uaw9Dkz+Qs
	obzySWPJj513p7mxqTd9nAu6NHb5oBCxYDsMLq8M8jf4bR8gWg6em/JjJFMmEn+MnkGRNFpv4b5
	gLYZVDABroL5Hz4UOxxtEvbVAOdkA4mWKND9nqlUsc7j0aN5DkNCI9WqBgXP2+A0kqm5Hj3MRlq
	98C4dXESVxPzow5WFXiov62pV+m3p/5/2kb7F4PAhM1XDBP7aeiZLx5Xek64q5VJiofbQE5hviF
	qPhFk864N3vm4wSLlLFdYygorTa7J6v9TwemP7y0b0wpRGd+JNRf85aEedFOojQ4mx5Y0OyKAeL
	j6NPiv+vuVfTT2bFhBPQ4Jex2LDJdH9EXgB2OGLZJEeHDMqoqp2Eo1ixJ2RQ7KjjHOKPGQABJvR
	iABbr3b9VTg5AQF0thQZlbJ+sQCX8TIe4cP1qQEdNEW1+UfVHxaaZvZzNcgwbnjM4o92aXLAYX0
	YInENNnC7AQyJ3u
X-Received: by 2002:a05:6000:1843:b0:439:c9b2:6571 with SMTP id ffacd0b85a97d-439da3697a9mr4240301f8f.41.1772807603922;
        Fri, 06 Mar 2026 06:33:23 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:23 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:05 +0400
Subject: [PATCH v2 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-5-6595249d6e6f@flipper.net>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
In-Reply-To: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Q9D7eBKxq86MNvlgm1qDMnqHysA/422W4yV9eBroyC4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerpE+vDa17tWlximfOM7VrhvSUAK8zyHheyO53Xnl
 rdY82/w65jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQ2RKSBAQhYGPhyE/NKjXSM9Ey1DfUM
 DXWMdYwYuDgFYKp7PzP8M//80iNKkmFiwPTSVjahl+VfuOfK3/8m9Om+59sddeppiQx/BQWXTFr
 woJp39uYHy4J1nTRuVzd86xO5b8EnXVLct+AWGwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 77633222BB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223347-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email,flipper.net:mid]
X-Rspamd-Action: no action

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
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


