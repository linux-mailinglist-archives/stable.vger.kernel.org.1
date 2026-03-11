Return-Path: <stable+bounces-224677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HDJIm1YsWmGtwIAu9opvQ
	(envelope-from <stable+bounces-224677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:56:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF62633CD
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B5E0300E259
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F83DE42E;
	Wed, 11 Mar 2026 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="1sdouiJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C113DD526
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230182; cv=none; b=iaXXgTgIQJfY3uPHHek44Y9ZJmkT4cI2NFdUE75tGe0vWwTGiKdSXF25MW98TS6NtlyeIpIoiv5DtTmGEEQFGnyXg+l8U4Xkn1tiZ/lRvlOE+QV4CWwB+FO6pw+iYPmaLVH8/quJ85DD6Rxp35O8mye1lvWbeHWc3kfVdGMGwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230182; c=relaxed/simple;
	bh=x5H+Ty35z/JQ0YvCd3YuUitbcY1C+rVXjfO5WNFbeIo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z+VvOWzNGpfn9LBSI7Z923H2q059ly6Ok1k4z4T6v12xFbuPSw9alBRklA+d5SKtJa5/tNVO+FvPcCzBBQJntDbobMXQr+9HR/nwu2zjGTyM+Gc+yAj1SwVjWfMhnrd83fwYVnKzDWhYrvXwaq3oSNDFXLsuox14xbxwe8dT1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=1sdouiJE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so31063575e9.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230179; x=1773834979; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1Cht8uRSf2FyMM2VofwaPUErjVTJDATYO+ETNMehnE=;
        b=1sdouiJE1eKBSrVKSE48EIViGrek6TmeSJC6W+4e/TarbFJDlrdt4RaeIQOgIqFHlm
         WzIustyfC6xg4ve8R1qYcWprncv2nXy6CF+uVT6s97hMfejyyofkuK0UnlQbiXo0NbgS
         PG6Bjzwty4NUU+CwsjV/qrXchlgINrGgTyW3Kml/kjMRnKkX+ZnZEuxZ0MWnqvt2OpNB
         R3G0XonVw75WMZeL48EdtuXlGKNWjlZZzSPIVBH0lM+X2HAxwBMeUH6Ism3ipzZhKJB6
         rbmeRW/H3W2b/VeA2xV0KChZ4cQSdrm3LW4E0SVZzmY9JjU/JD3oskYuyrW9Y/Y4nlKx
         vYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230179; x=1773834979;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1Cht8uRSf2FyMM2VofwaPUErjVTJDATYO+ETNMehnE=;
        b=RkvvTleHpJqroGd1UKRUC9KORpx73zSpoPZT+bVXGzC3G2N6IZhG0RHLz5rtyc0dZ/
         Nk54Yyzo6FljEKcyNpRmRuIk/S4m4aXWE4f52yWa1EmbBX+UklVvU4y7zoGYKZEh8xo5
         D6CllVsleYeyZAA11F0StxYQtZVmwoQ9eIyv2EEKrENxKp5EzT1SDz0AIoVv7Ij71pFS
         x9CjaL/5pDbsNwvDcXBdoieraUqdy+KEwWO9slqCCr7yU80Xg69/+wmVZR9EDm/Nw0aM
         3arT6/yqPmeAmCmgKr8kYEnNWDS+Cta295TTdzUYb2FeB9L9CRdIDQPKld0x4wXwuSo5
         XgJg==
X-Forwarded-Encrypted: i=1; AJvYcCWArEaXAN7Kyn6503Qq79FxkxpHYhdMjZwLlEmVP650gFrchiCjJqXd0GAh8eJZY8tOsAap1p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOs28TWktJorGQc2IAaByNLUuRnQkPYm4pinOJYnsnYUs0lvy
	22DKL16FrTzTveaeAsIF6kt5L6f3Qt83ykcRYYvuk5ASy7ZZ+tF1/idWJtBChdHGiHs=
X-Gm-Gg: ATEYQzxu7YPtRZXgYeiguKXgp1i1/LvLwAJGrhIitlflsi1LTyj5iWAEs8NNTsp5Avu
	NaUIDXNuHQonho72RKUMEbENnVguwXfz4bR+RR5V1xb3XEM9qq/l62I/6y6wQ848g/jVfSiAyRn
	QAc2URssedz7PzYxY5sOcYsz4EPLBaivPm2kvSRrlHCCNUW/3nS7Usjx8qEZfYcOkN4i6GyXqXP
	8GDiLB3chQsbIPrVZssWXdwoERKdbtp4FmsSkvHAW4EPhB9JusV/LC1WdB0fdmPLwPgkMdIm27c
	u7wnbeyB+oJ/kTwaxCskyYSy380fBk/nyZD2eNMk4jKqxuspWdhbY51BqGwgeAJkI0wvChIDMA0
	hxZfQq3iMf9W+NoxJAh0guApqPLOFxxZ+CyCpDBXUzaDLXmfo52+3y97akKPsDuPBA9L3XD6HwI
	KXj6Rv2nxd1ukvdLeJzE9OptsvECr4P/QN3x3l289nPCtxPVeOMA0Aa7klZHJgyHFpbTmVzQaY5
	3UcuQ==
X-Received: by 2002:a05:600c:314e:b0:485:3e00:9452 with SMTP id 5b1f17b1804b1-4854b10f5cbmr41854135e9.24.1773230179285;
        Wed, 11 Mar 2026 04:56:19 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 00/11] Add support for the TI BQ25792 battery charger
Date: Wed, 11 Mar 2026 15:56:13 +0400
Message-Id: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1YsWkC/2XOTQ6CMBCG4auQrq0ZZugIrryHccHPIE0MYEuIh
 nB3CxswLL9JnzedlBdnxatrNCkno/W2a8NITpEqm7x9irZV2AoBGQhIF280lww1xIR5mXKacKX
 C695JbT9r6f4Iu7F+6Nx3DY/xcj02xliDFhYjAESJSW/1y/a9uHMrg1oqI+4lbzJ8QLPJDCZZx
 cL1UdJOxrBJChKwTgUJK6biX87z/AOmK6RgFAEAAA==
X-Change-ID: 20260303-bq25792-0132ac86846d
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=alchark@flipper.net;
 h=from:subject:message-id; bh=x5H+Ty35z/JQ0YvCd3YuUitbcY1C+rVXjfO5WNFbeIo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEjqfM3wiP3Fxf09MWLbZrH+WfnldYrMpaIdvufUQ
 xzmWLOqdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVvayMDB3aJtejja8dttf36vbQkFqkfWN2hfTOqUUWWfvyjFj2BjD8r/8ZumV
 Kh6tT7w+71oUfhM3W/DsvtfDlnO7/bI+2zDn0jBsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 12AF62633CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224677-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This adds support for the TI BQ25792 battery charger, which is similar in
overall logic to the BQ25703A, but has a different register layout and
slightly different lower-level programming logic.

The series is organized as follows:
- Patch 1 adds the new variant to the existing DT binding, including the
  changes in electrical characteristics
- Patches 2-4 are minor cleanups to the existing BQ25703A OTG regulator
  driver, slimming down the code and making it more reusable for the new
  BQ25792 variant
- Patch 5 is a logical fix to the BQ25703A clamping logic for VSYSMIN
  (this is a standalone fix which can be applied independently and may be
  backported to stable)
- Patches 6-8 are slight refactoring of the existing BQ25703A charger
  driver to make it more reusable for the new BQ25792 variant
- Patch 9 adds platform data to distinguish between the two variants in
  the parent MFD driver, and binds it to the new compatible string
- Patches 10-11 add variant-specific code to support the new BQ25792
  variant in the regulator part and the charger part respectively,
  selected by the platform data added in patch 9

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v4:
- Avoid additional data structures and pass 'type' within the existing
  struct bq257xx_device instead (Lee Jones)
- Move comments for new struct fields to the patches where those fields
  are added (Sebastian Reichel)
- Collect tags from Sebastian Reichel (thanks!)
- Link to v3: https://lore.kernel.org/r/20260310-bq25792-v3-0-02f8e232d63b@flipper.net

Changes in v3:
- Move MFD cell definitions back out of the probe function (Lee Jones)
- Collect tags from Mark Brown, Krzysztof Kozlowski and Chris Morgan (thanks!)
- Enable ship FET functionality at init for BQ25792
- Link to v2: https://lore.kernel.org/r/20260306-bq25792-v2-0-6595249d6e6f@flipper.net

Changes in v2:
- Fix an error in DT schema (thanks Rob's bot)
- Ensure the broadest constraints for all variants remain in the common
  part of the schema, per writing-schema doc (thanks Krzysztof)
- Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e0033458@flipper.net

---
Alexey Charkov (11):
      dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
      regulator: bq257xx: Remove reference to the parent MFD's dev
      regulator: bq257xx: Drop the regulator_dev from the driver data
      regulator: bq257xx: Make OTG enable GPIO really optional
      power: supply: bq257xx: Fix VSYSMIN clamping logic
      power: supply: bq257xx: Make the default current limit a per-chip attribute
      power: supply: bq257xx: Consistently use indirect get/set helpers
      power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' states
      mfd: bq257xx: Add BQ25792 support
      regulator: bq257xx: Add support for BQ25792
      power: supply: bq257xx: Add support for BQ25792

 .../devicetree/bindings/mfd/ti,bq25703a.yaml       |  73 ++-
 drivers/mfd/bq257xx.c                              |  54 ++-
 drivers/power/supply/bq257xx_charger.c             | 534 ++++++++++++++++++++-
 drivers/regulator/bq257xx-regulator.c              | 121 ++++-
 include/linux/mfd/bq257xx.h                        | 412 ++++++++++++++++
 5 files changed, 1156 insertions(+), 38 deletions(-)
---
base-commit: 343f51842f4ed7143872f3aa116a214a5619a4b9
change-id: 20260303-bq25792-0132ac86846d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


