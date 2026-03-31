Return-Path: <stable+bounces-231455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED3YDLTty2m5MgYAu9opvQ
	(envelope-from <stable+bounces-231455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1636C249
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F41CB304FA3A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710DF411615;
	Tue, 31 Mar 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="MknPGXTr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A24411624
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971830; cv=none; b=ubuz+zdjnX/umOCUfx/cBm9amRXvhX6guQscddptrdKssecKe+sAYgdBRsHy0YQQF0a4nXG4Sy/4lDJTu/HD0EsYZal6CCnT5QyV0Lsy/0btof427foSzUxDqT+oJ7obVgWG7SeWUrWmJ2OFooh2ZemH5+ecJvUgWAHpishnpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971830; c=relaxed/simple;
	bh=Lak4zcWpFwfXjCXPbBnc4yBKiesb3cWUXZkq+I+QBCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MjkY2bwEcW2QyFqhILZyjfuNCBXTtDyodU/E8uV+Dn878wm5PmCfDmCnCjB+M+VSjhc7KwQ1qseqUGZz6OoczB/STIuCqVzHcFHLsnC8jl/LzQwwNrI3GLk37enuqSXptL0GNZlTasj6QxXynmtZHSDJgTIN+7UIipBoIsQEyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=MknPGXTr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso59092405e9.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971827; x=1775576627; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=py3e1w6KMUuyJpztK2fw9vXLuizsBVQDCyepeMdTu4I=;
        b=MknPGXTrRCR8++ycFypzpqIkF9kCxkjzGSp2X8DCtBFyeUiY4AltsaGEOBUuqAplUV
         8DZ0N2bXO8bISlOVt80YV6NMDtTljI0l3AwcnamV9zu1PxPr24nW+zBmXI2IL4YNTjcb
         e3UPhDaEpvZQAa0i00oHvQKJ19xcP2nBxUlm1hsuXNngg25JGEmFwVTors2rNgfujgWI
         GVWF+Y22BnjYHStSop2j+jOFqBulBB75s981TaUmZSL7FtdkBm5tSVXCxHwc40oQkEFm
         MKa9hR/XOvUTfzJCVusI1CbPyqKvYvniDt7/iRWCI4R8J2m+6vUm7pw2mayqC4+l3YVU
         y4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971827; x=1775576627;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py3e1w6KMUuyJpztK2fw9vXLuizsBVQDCyepeMdTu4I=;
        b=MfYzECWKU22hMSIMr8Kj2Q3PZAEUsWqtUn459mVIUsu3hKIkDNOeGZqvqrpIMW1Giw
         I4PmLEyYxtFp8oixBPyDb4HI5AN2oCV9LCkvk51N1aDnBURjcxCsnIHMagZiiojKqo03
         tLInVllIayFP1h3sUYZlqwYMSdCOV4vwuB2kgIgrPfSH1BGpytoE/MpMQMJYnmD2EQif
         e2KMGRKLNx4WJTr5MEykOLKLwxyg4r1ivyTeVOFDytwt7G5OH3RCBUYfFq+uqFLnkXAV
         yGpPhRbw19hYEAzkLCDso4ZLirI+A3rBuPqPYXM18S/zxI2w1Spei8xf3t1Bc541oPnc
         c+uA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ROvvJlrx9agHkHAgPCTUSuFguZGYRtunXLpOj45JkEitm/n9LPonebHYve0gUXH5QgoF8Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCRqJ7D/ZlUlOW7oWtvQZ8bNxTmKxWfK1TXd5UEzcxV4YUmGX
	e49sjN403RZRniIcGHG1oKGFmLEoAIUNd77E5MpAAAKagTaIlt2zge7lhApR6ZD1OUM=
X-Gm-Gg: ATEYQzzn221unzQpVWEPgir2wxqe0BVDx6r7WGDkSEv4NlAvSdrMYJaSvXSYpbKkBxJ
	+gBAkXWsAXgjQkA7oNF+XfhErLXi+5PNVbyoeOY4z4GTJf4A6/PkKIXO7CgTJ1P/Qtdd5MJ0WbN
	VJeZZ/7EM77+V+lde6buIjKfQLnenrQLhK++VcJPH+I3k6J55D1i9Be0KAI8p2nPy1SB0HPl2fp
	SUBPPIUg2WNUsQjpK5uGdtjIbb5jdltSFhKxZ9/L4RDJqjIMA+h0Eypfky1B1OmhJblr0b6gkPU
	zpdQtSC7bNWCB6vCmFUvV0qWCS+v49CeDQ++/S+2ffdA2KOLpVOQm/vxqdpkS5H1HWv3J+VpZWp
	mJemPVkO06V7IdoHKe+8zV3/Wth1afIwSOWgStWijU6qVcsEFhc/FsHbHHQzpcmftK9eibTV+R8
	kpXpuSywQ2VnnDYip63URskSpsAIhcAQVjxtp3Q5vBIl+yyBA+QBjOrXVqFweJGgfPFhimz+kFg
	C9m6Q==
X-Received: by 2002:a05:600c:4744:b0:485:2a4b:7bc3 with SMTP id 5b1f17b1804b1-48727d5d6femr284014105e9.4.1774971827114;
        Tue, 31 Mar 2026 08:43:47 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:43:46 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v6 00/11] Add support for the TI BQ25792 battery charger
Date: Tue, 31 Mar 2026 19:43:37 +0400
Message-Id: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnry2kC/2XOwW6DMAwG4Fepcl4mx47dsNPeY9oBiLNGmigNF
 dpU8e4LvcDE8bf8/fbDTFqyTubt9DBF5zzl61CDvJxMf2mHL7U51mwQUICAbHdDPjdowRG2fZD
 gJZq6PRZN+efZ9PFZ8yVP92v5fRbPbp0eO2ZnwaooKwCR5/CevvM4ankd9G7Wlhn3UjZZH7DCD
 aNvoqiko6SddLBJqhIwBUXCKNQdpd9Lt0lf5RkdecexUe2PkncS/SZ5vdmidhz65Fz8L5dl+QN
 rVXNriAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4161; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Lak4zcWpFwfXjCXPbBnc4yBKiesb3cWUXZkq+I+QBCM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr1eLv3I3dnefgoarKt4n7KHOEy9dbDoh5O+2zIL0
 Z7729KPdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDV3OEM/+zWzTi/Q4HD43+z4WI1+YKao0p5Zzflb9lwLOynA8PTTy8ZGSaIufx
 SE7bIaXr1TbZO/M8C2Vvf1sVUu4plyFzYeGBjBgcA
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
	TAGGED_FROM(0.00)[bounces-231455-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2B1636C249
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v6:
- Changed -EINVAL to -ENODEV for non-match cases in the MFD driver, to stay
  in line with what other drivers do in similar situations (Lee Jones)
- Link to v5: https://lore.kernel.org/r/20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net

Changes in v5:
- Added non-OF match data and switched to i2c_get_match_data() to support
  non-OF platforms (Lee Jones)
- Shifted the types in the enum to start at 1 to avoid confusion with
  zero-initialized data and non-match cases (Lee Jones)
- Reinstated the const qualifier on the MFD cell array (Lee Jones)
- Link to v4: https://lore.kernel.org/r/20260311-bq25792-v4-0-7213415d9eec@flipper.net

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
base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
change-id: 20260303-bq25792-0132ac86846d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


