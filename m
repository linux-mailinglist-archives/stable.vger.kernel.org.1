Return-Path: <stable+bounces-231456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODC7J9vty2m5MgYAu9opvQ
	(envelope-from <stable+bounces-231456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:52:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5969D36C258
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B94830ADC88
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4973421EFB;
	Tue, 31 Mar 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="IOblLjR7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8C41324D
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971843; cv=none; b=D5MPgBriB/+klE79KrdM6pNNJC2AfN/0lCtywVKPGkXVMm7MvIJhdMBZftAPxOPhmGe8KZ/bMD7MtVMUUlkucR1joFiq/YgwlrumXBZ1F/N36G+pTt7Z8kkqZLGB3Qqv5rOe4K93txk5e1zebWx4PjkyKlIhcer8Olm7RWIJow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971843; c=relaxed/simple;
	bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJTCni6TQSSkJA5FZGBwS6opZXTjSpzvnF+VhJKKMx83gIUxqLsq7IX+z9oGfI0S0XW/+6ToXTo2Nzg/6g1x1yYKggzon6v8ASnMl30G+s1AcRjzE4qFRGA7cS7VAOV1b4G2RvMoqnCQLz+yUIqx04tQwqr05QqC1IwU1uuTwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=IOblLjR7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so145615e9.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971840; x=1775576640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=IOblLjR7HQd71W849/IK9hJ6liawmOg+zs3cacx0vsxLrWpHxEKTJP3Q1VlgwEddBQ
         57cCJEJYHr+qT0/HV5drJuRhCrWHKVY0H+a4hWazNcQP26VgW6RYhR4vTnIZYKVb0RrM
         NqMM8TV5ELdLF8ujsONhClD9tQaWKuJNd/3AI1YB0prpOnjlirEZ+7GfYipWSAIh+Nyv
         c3PXxjTi7YTiiTUKUD5uSQpYHDs84t2RI5O4bk7QiiJ+Xo5YuADf2Qt37HXDpAEEJR5N
         1+2ZOL61/G5DGRa9EPbX8roNIT/khWZP621RxIylfqNt1XRgL4xOLKVh5nKxQ+sEgODR
         fv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971840; x=1775576640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=XmygyNzlNakC7viA1Bt9hnADPz+S2+TL3ByFqsPNnp54U8se6NtuiyBIJ3NU7pztFo
         JxRME9OFssi3S/0nBsKVtwruijrklDbEnZo8tQtf2gnfBIYQsT1IQvn50qJcO6OQ6xqp
         xQbxRjmwlkZcuePJ7Az42icFAWrJKdRWBHpXw+3kHhY3LN/ui92vivLud1U/3QUZYGDw
         syUav1TW8J0z3ukUJm1Py3Sa6cyS5gt2kIie6MUfkUndIBnibZ2okk5TqXasXnFHsSvr
         T6jOfRi5pf0vSL9Y4u6WRNUEpbaYxfo38MY7/WBIC67vz/sGUodZo8WvfDTDE7ZG2lXn
         fj6w==
X-Forwarded-Encrypted: i=1; AJvYcCWEkgUyYCLhkCPONUQ0Ry6XjEBcRoPQUt/AJVnBDLFjvXYzgaFJbRNcox1p7KhlGj50zCcl6mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19l5enDPL9EXIuenOii5MGe8EGkQ0Jrkxfh/ds7maXgBZvGUI
	jRbk0nG0K+6i1+00dPyo5n21V+5/rLzMt4UtFDhqsnCAiXxJL3AQHhTT8+N4NfOBoFY=
X-Gm-Gg: ATEYQzxX1i1L5M9p/vmMcYxZrwctxO8esUtE3Sx98BWet5ZpgL05i/HrxSPzz2jARpt
	Pn5VL1LXjtAfzmSBBsubucw2p/tpocI2at9os8u9sNPn9cPzj2oGm2HQ3LXqbAdco9pR0I/7Fw0
	0uf9nDKdNgta8dck8s31DED0NNOoZ5KDHtRsoytiOc5qHL3U3hqnHytO6p8yEhzUNYYC5+Dac9X
	DE/jvSUysaxo77w8V8Jq2DA+kwKRHOFFWzF6D1fINRg9nOhezK5EGRmkYqpzYVnAzSLpBw0lRkS
	qUuHmI2ywgq+68q8Pggq0HAWn6qWNxtCoI8SMa2cbeYT2LG/KGH56mt344LuBf31Pev81bIunvR
	3GAaiDEDM9s3OTEYhKCJLs66elAd3dmX9Y+/3TzxLkc2DjMA8XoQRKr74u+eLdNZau+DSLY4Vdw
	kO7Ri2TQfWW7Ndu+iS7ld35y4ct+QxmlAqFW5gHGlongxHtL0SlRfeVbaNV+aQ3PHkRuBmtwKlG
	ocu2A==
X-Received: by 2002:a05:600c:8907:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4887818678emr52899635e9.1.1774971840282;
        Tue, 31 Mar 2026 08:44:00 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:44:00 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:42 +0400
Subject: [PATCH v6 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-5-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr0+sjLgRVHOB6OerPmLpvscZ0m3erZk50a32q+Xl
 yo03Nwxs2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICpjgln+M0aXljvxlI0N3xyguz3uHsTJTN+HJ7//cK3usm3Qg++kY5gZLiS+zs
 /qOGy11x7lmXyqpdNzdx0xS7I9GmwvF58e7LsHm4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231456-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 5969D36C258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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


