Return-Path: <stable+bounces-230143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDtEHQV5wmnqdAQAu9opvQ
	(envelope-from <stable+bounces-230143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:44:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB93077D4
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52C4F3031B28
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CDB3822A5;
	Tue, 24 Mar 2026 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="43Kle8uh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36803EBF05
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352305; cv=none; b=ak3rQ+EMyZC5TLakFl3qkLaHZJxp0C+g/FR6VhAuPOC21s4hLKZIR/cEsgrq2nj6H7h9n7VHSE64DLWsPJCMTWoT4eHm786QHtYb7EUSQBHaH4bfNW+vqHgy+L9oHEE9A6ALT1kBEW63U6WsLfkEgPSPz9rMlzLJlxbI8n7fdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352305; c=relaxed/simple;
	bh=YmH5NT1h3YC+K4Nq6anzE6uxklzwUGPRneUbJJptAPI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g+qQv02oDbrTBGKubcQgkJerFrZyzbcH1RoiNAVWEACGrZcSZonphSiwQq40k/70zeLIHIgzgNZrj0Lvs9CJk2J8kqC8eHlnKnppOJGN26Z2jpSORHgt51CsRKyF2yQHSlkKWmaIx3W8XlSB6qtomnqtnUCWD9Uzf00nk+2ZMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=43Kle8uh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso44253245e9.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352302; x=1774957102; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=355qHMBuMuTWoaZ72E3VJJAus+s9skXoXEPDnMR6Oys=;
        b=43Kle8uhMphE7bW9jccIKXON1aMpC9CkWYUVKH/PGVCWJ6KhmRv7RfV0Vux79OLjQe
         ocINYt4XvY9RD0QJ+mmWDOlyqAbgWvVF0ahnXEQYQ4J1CZJ9YwQtWTGDAk/UC6JXRhwt
         E3yqdOEbq7BkvvYe1ZO1g5jaAksMfFkAtYKKpwCTU7Vby1RVQIOfU7FZGUp4Rq5Zu87U
         aOQJPDp2rq1lmu0lYlMnX3t545A44AsmvkhvcXtoAT7RnsWN7a68PpM0ISwlhvwwNoo7
         tSVD+XCD3WkhSaGvRk5gKBzUz/c3UZ2ovN+jSwyF20Wg8coSfFLBAEbcUjJlUZ2zp6jL
         IYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352302; x=1774957102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=355qHMBuMuTWoaZ72E3VJJAus+s9skXoXEPDnMR6Oys=;
        b=S8+qAaCbJFeReocxjUaFLZfoaOfm1+vKlmN9VeycLXzicSak/KtLSJIt/c7sMlb5AH
         Cby46HE1sAutK6VYjKXe9WWW1zBX5pg33t7ctS3rigKGnvUDxz9rIrq5hr9wRysa0VTq
         NX0uf3UZSZaoWEZCi8oPH81+PsNY+80WthacwqGPcCpOFo8fqyIsn0NpDowoP1WTAgJp
         sfjJ1HRh5igils+wcUhOA2sRfm6v1iJl5qt7oqPJzrGkLzzfT1Q+lQRITpVPCXRKvBNj
         RftlD1m4yXKx2kJxtV7ttfrna/YLBVqF8uACs6Z5Zv5ak3yXmhq7C+FjGWzgTJ0HNJ+g
         Ta+w==
X-Forwarded-Encrypted: i=1; AJvYcCVRpyqkXtuon9zcaTE8VanwkHdvMhzVtO601uvwhyYJawDMMY7U4QNOHeKCcEjlssbq+WK2yW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfdwJ+2Q334wJRecx6fI5ze2OKNWyJNeh2PYbx45qZfBn8sGCF
	3vvBpPYW70zjqHFV+QWgRChQoTP8UTuqLfS/QdVykjB/flHievocV9KNz8Fa+GfFJxY=
X-Gm-Gg: ATEYQzxL61FpDf9znbOHcEx0tXDiqDQ7bJm/BlDreCoFSVwohHI/woo2igOtj21Twr5
	/OHQQy8DtqjPEeZ7SXbygrjLIiSY+KJHAZ+ojtmMZLhbyXf746jlLYGY7NruRbXrgJrVbJpJL3a
	DsM/OnFqg9OC24BAYkhTzcjfUKLcVhUk0WD0oGikM9T+PME5Yz35Lynl+B+o78SRsw2qGL9BjeK
	AqaViAAtVgx5kxiaZaRskOckA1rQy8Qorz4zoz6rOTOJ82cNKJ/1gg3Llq5dCCC/FimT+z75yHO
	uzdLrwBSoNKrsGnhK0fSK3oZxPmuameXbxLKjPTANiTatcnfMnloBQyttnc4Zezm4tTHP9A/P1T
	QFMUaBGHZlBmoFDcYvrpMZ8MjHK5x5zboDxG16GPirSKc+eWDit8qz9FtiKd6deA3mY5Rhxgzs6
	sSeiU6cIa6o/NvJOLPt3bx494Y0ZUFupYJN32TVBY3MGFcK4Tv7aFr0bfvT/zcHUsyVduXZX1Lw
	JAl0w==
X-Received: by 2002:a05:600c:3b8c:b0:486:d76c:fa51 with SMTP id 5b1f17b1804b1-486ff03ffa5mr211986125e9.27.1774352302120;
        Tue, 24 Mar 2026 04:38:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:21 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v5 00/11] Add support for the TI BQ25792 battery charger
Date: Tue, 24 Mar 2026 15:38:05 +0400
Message-Id: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ53wmkC/2XOQQ6CMBCF4auYrq2ZzrQjuPIexgXSQZoYwEKIh
 nB3qxswLN+k359OqpcYpFen3aSijKEPbZOG2+9UWRfNXXTwaSsEZCAgfXuiO+aowRAWZcaZZa/
 S6y5KFV6/0uWadh36oY3vX3g03+u2MRoNWlicABBZl52rR+g6iYdGBvWtjLiWvMj0Ac0ud2hzz
 8LVVtJKGlgkJQlYZYKEnum2lXYtzSJtkkc0ZI3zuUj5L+d5/gDOnMM0TgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3906; i=alchark@flipper.net;
 h=from:subject:message-id; bh=YmH5NT1h3YC+K4Nq6anzE6uxklzwUGPRneUbJJptAPI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl/yo+hLhH9nyYmY9Qd4bA9oB4R4p4joVN2tusQ6c
 1109py9HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEx1cBzDP+uiuRPuC10p9DzNYS/LntUlGPHyo7rh9BNcBhP0fGeFezL8T2/esPH
 +rKVGGQY7fHcd+5ftIb3w046zD4uOdvNrn7V15wQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-230143-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[flipper.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E5BB93077D4
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
base-commit: 09c0f7f1bcdbc3c37a5a760cbec76bf18f278406
change-id: 20260303-bq25792-0132ac86846d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


