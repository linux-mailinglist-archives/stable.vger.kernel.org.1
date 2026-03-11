Return-Path: <stable+bounces-224678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePEpJqhYsWmGtwIAu9opvQ
	(envelope-from <stable+bounces-224678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:57:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9CB263435
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68D32304768E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FDF3E0240;
	Wed, 11 Mar 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="j/snTdrG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035643E022B
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230195; cv=none; b=hE5mOBbC5W5iaHNwndQGUdLjL6lUGKNhi83I3+Bew04MxjbYl74D8KXv5z/8YfQPAuPiukcMwWaRbut5mlP1CmNkxaTUmSPpYbzsVEJQVqfANX33zhe+kX1tFuTRRkaI2yBCHO0Xiq4GsmjUrigZv8ycq4pz8LjFgjqm82XOap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230195; c=relaxed/simple;
	bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8jI90obFhM8OFUqfWoU+wLOO5Le8sw/aHemh3nm/krsGI2t3ZGKpdtqjqA6FIuf3gCuMJmigr444AO7fFVPnjxAcdegKVByo8He95cd5eOviDlAC1ZrzLaPMv/hTCaogmT7Fq/rQf1KM5MOQPlxmOkf8AT8vXfUolzLx+ErFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=j/snTdrG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso127347845e9.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230192; x=1773834992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=j/snTdrG27oLf/uCezauuFlD49o9fNjd0IndTm/3x/L1kqWEAKsp019S6PsHtLmQpu
         T24b2Ixz7rtaE15Nn6T7dYUJrYIUi4SnzeUvhVb7R2OguQNx1JD19I9w0FnH+7MKDmRF
         wzC7CwscL+wrR26vifi9uEKV4Jgffn5cader64cmHZjpYS+aG01Gq+xPL4syDk8C9FCJ
         Zk7In3/1nfOYZOb0mDBM7o9W3JhBmqhugdVlcCppiHbu+wn2D/AmK2KG1r4+TR2pcKpZ
         TD60OoPVFsBgV2SGKIyN9/i+VZvV13GF0DnNAo+2zL3Bf+vafYiTb3vfErvJQEnb4Xry
         5b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230192; x=1773834992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=nZZbzKC8FQTfU4zXbwQw+k0t0AiFztmniJSvM4bi4JtW+stpskvTbiL+MP1lNNd6Jz
         lnQgfaziR7aWQuROY8qWtbbNmS00VzmAshZEnunVyZ7+sTsU66lBPbYkS8Sa4dR7au+r
         OpZHDvqSJ0h7rLsZtVRcSTatKy0dwaK63PVYInYbSunm99nTIG5BM/DMpZTcG3kQ2Zw8
         7k+120H0kPXBhGLoo4uGUDPOCtbJhy2HkKuhQPLKk0esMuTfVIAp8KhhXuB0nC7j9ZuQ
         7Oh3GAfhtT3WZQSRcqwmmXf28l/XulKe7mpTWU+bJ6Mnasnj+PFJnuzjZc4ZGpWU/3fq
         hv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDgFBVfUip3IcLiY5lYpazOeT2lo7Hpzv+6sqe09pcvJgMYyfyfDx7npdk+HUVYMvFzXJVH+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6zI3SAlw2KuYuz3wfGxOvonvSz9e7EyUb4oQTO35Z0Ko7JE6
	TqaEFbtCh/tMIOzICA6Th131LAdaa6u8XCGr0gX48WzfcB4rhoXDGr6/hE7SzyEQMVA=
X-Gm-Gg: ATEYQzzUjYW94/2a7zZ1y08IGagAJZTQy66VPUhKkwrUUmYbg0mIjO3CnrKOu1kznD3
	5CvTNZ2plhA51Tcz/6nccfswd0Mg13knU0aLynW5TVyLyQaqWH8doyJlqoehOdTX3elKzGyq2jx
	f8II7++xTh5karV7qOgZNiBSzS90uC956NK1RJqKLy1K/bV4LSgKhgqMxwDfRJb9CP5P4ZhgVOj
	E0wDSu47KwekRtUsBmq3JDp/2r/8fr10/10K5vudotZ4G8rDA0rmcqUGU2J6vdRueejJNdYpPyi
	GYWDbMK+iD+hlR7ErthueJZruMp1h/XeXaVgi4/v3UdzRm/YtsIavHbezvZZ31NID9Nd1/L1NP8
	mgeNMMHgC95WoksfvYpmucLL/+kRBI58WwkrBjs0IBiEVi7xIOSI+QQMrAU6rld1IjXELBkNK4H
	je+2+aksN1OAhCXQtZyZVONqF82tjfqIQwdlIlKdJh8oQK/hhmzNimkE8hKhzdBVShrou7TP0qM
	+kSng==
X-Received: by 2002:a05:600c:1f10:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-4854b0a5471mr41617415e9.1.1773230192293;
        Wed, 11 Mar 2026 04:56:32 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:32 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:18 +0400
Subject: [PATCH v4 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-5-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEgWT/ucbxX14DGrGb/3Ad1dh87rCMvdO63tkLm+/
 u6bw0FRHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEy1EDfDf2eTRTziSYc4pghLXi6PuOqjy7lq5U2Vr8Ip4p4ZP3+mHGdkOOWaoP1
 7berHE98NUw8vnXvhqEMGU+Z3Q34l02MZbMte8AMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 4A9CB263435
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
	TAGGED_FROM(0.00)[bounces-224678-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email,flipper.net:mid,collabora.com:email]
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


