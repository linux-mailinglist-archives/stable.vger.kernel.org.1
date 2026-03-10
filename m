Return-Path: <stable+bounces-223839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMv/Io3kr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:29:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE882486D3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9AA0304A567
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447243D51A;
	Tue, 10 Mar 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Jz88+QXG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E143D502
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134949; cv=none; b=QK+9wk2XXjhqSgo5hlAlDRpxD/0QwVUtUVv+2baQWxcezfceForeRL9RVNtlZsmrGQbzTi1OxdXJEghxtKfGxUY88vPtGPmHQBi5F/OAeJE+Go4Sri9JiWfh86lhE06Js4brFgGPmxVZZMyloRWPz4T2zmBzQYoEPyIHgKN0J7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134949; c=relaxed/simple;
	bh=V5YSqsc7mks2SF/nUdlDxogCbbBj+0pDE2z2UGEJ4Ro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mL5nbtNGV47PSDia1SiGeNiTSJLucP6b/U46lWaViDsnWImbkclh0d0xm3Cu0f7Aa7aFCfGN+2SDHhTkts53CeDdQdpawIfWybkkdm6uG1Yq3qQoyObTiDwimLVrB6QD7ngTrolxrcgc2viGqollE5jfEQejQiXr7XEkiUwjTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Jz88+QXG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-485409ab264so8824765e9.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134947; x=1773739747; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpA639p95WypbYLFKutmL4S7cIH8gNiEyA3iWl4bY1M=;
        b=Jz88+QXGSlJ5l3TkAm6BOqMKfOW8Xjc43znlACW8FdGQKtPRcNcVi9Kq2blfoH7GFK
         swkfKm5YVOMWdD7d/fDZvfvBvADe0zSd5ybyV229CT0JaKux6lP8CmwYeEWi9N0olgsM
         ibmfG1jYFtWWqqmHDGduy8t95HI2aDlyXF/rVy2P53w34ixEeXMFdoW9e1vOnDkWiA2d
         Ioi49j+b8OTZQIh4nkCXU8cY8bdZ+s6tSbWCm6+5MQSuxCUqUEQx0gg2YSXmy6q1VQ94
         kjXt5cWOA55CeNCG8pbcoQdQZtrgNEDecjBna10wIYpGMi3zHiltIwTRdBIf4EK1lOU1
         1kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134947; x=1773739747;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpA639p95WypbYLFKutmL4S7cIH8gNiEyA3iWl4bY1M=;
        b=hbdfIBZWGv3u7uOcQ0hikO9ks4CAdIl+jybYEy2cyDduGOEJ4uERmtI6PE75LE2UmI
         eba9BlTu6S6avDY+ENQeG8eBYrNjUb8KT8VFjz0u6lE/knG2GWqOd4ibigCAHjwtsbXW
         GpKH1PY/FvNWaC+gZF3G1EFsndVyf9ZVuwoDslK48nIMlxXnBvuwZYR28nsnfdlY+SZZ
         ZCiv0IEZiEnPNnLRX/v5eQQFK97DpwB3A1+j5gBM30f8d876Xfd16heuImpNAHrvAKJ4
         IMNA44LWI8WNSGCbNAcG6SfwC9Y/iYbuFMQlTGpxFnOGu+ykHzMjEOGi0PTKHHnhDe22
         0vYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnn4EDImPSb7ISD63VXQz+/rtn2naTUiTZDvbO4q9r3ZAJYK401O628lZV1fYjHb8y0eSFcME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylo85vh0up2tR3uqLMGBckVWfD08R7mFikwVuEbYETwf0XVbQK
	tMTmYLt5ZiHnHKsJq0dCr9dBsytd1yTJt7UTXLKGt3cl6uuNruQ1iBhvYsoJdMYxbBXAeQJXdXo
	Adlk+
X-Gm-Gg: ATEYQzy4GX8vdHo076WoBNQcmwvRMgC55aouV3POL1RpAOE+ncKeSbxOioQZYA6QsY0
	FYKkNPr9vvYuWlnbuXQPX3+2qkSzOvnyBwnbLPj3z6IgGjReiEQOLRyN1GZbIWE+K39Ey0Ehken
	UuHTxbsyT1W4BJBMV2OcPeeLIcesEAb2DkA7XJI5w+gtpy4KLr5AuvaE53jCTx0QngBN7bgxY0A
	lZ8h2TD/zBM2P8AkKmhMciBJfGTi4xVCywXa/zRJu4JYluVbu4OhXmQeaPiHpUGAysfudmNjjLy
	mSvBpJWC2bFiCG7kxNdvtt7V7Xf3zbbxxhrK/pcXmahE9i6KX+8GDrN2t6QLISjoPtUZmgeAznN
	OzMzuCrxUWBiQOs31e6kncosblpr3ZNVeEURs7aSWLW4F5GX3GtuZ31JUc1RSLf5crkfRAoB/dW
	OVUSEVJRzLG7X6U5iDNnhPYffGHj09/ThdcDfHdzjMMmQf35HZH6g/4SolUVM5oIaYwNs8YCQeU
	xB6OB2IX6RS6jr8
X-Received: by 2002:a05:600c:628b:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48541a0d032mr35337915e9.13.1773134946685;
        Tue, 10 Mar 2026 02:29:06 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:06 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 00/11] Add support for the TI BQ25792 battery charger
Date: Tue, 10 Mar 2026 13:28:24 +0400
Message-Id: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjkr2kC/2WOQQ6CMBBFr0Jmbc3Q0hFceQ/jAmGQSQzUljQaw
 t0tbNS4fD/zXmaGwF44wDGbwXOUIOOQwOwyaPp6uLGSNjFo1IQGjbo+tD1UWmFudN2UVBbUQrp
 2njt5bqXzJXEvYRr9awvHfF3/GzFXqJjYMqIxhS1P3V2cY78feIK1EvW3SR8zPaDIVlYXVUtM3
 a+5LMsb8BzTqtoAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3119; i=alchark@flipper.net;
 h=from:subject:message-id; bh=V5YSqsc7mks2SF/nUdlDxogCbbBj+0pDE2z2UGEJ4Ro=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf+Ic+nTDQqay1V+7rFP9Pi/rFviz71P6psmsVh7S6
 yYd8D2Z2TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBU97Qw/NN8+WXRggWbJr/J//DwbfZ54zLFU5kp0trnrzuoHVgwPfgww//8HZv
 aZvyv3SumJ9v0bG1nXOTinlsOPyey5C7cJ8t0yoMVAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 0CE882486D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223839-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email,flipper.net:mid]
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
 drivers/mfd/bq257xx.c                              |  64 ++-
 drivers/power/supply/bq257xx_charger.c             | 535 ++++++++++++++++++++-
 drivers/regulator/bq257xx-regulator.c              | 123 ++++-
 include/linux/mfd/bq257xx.h                        | 415 ++++++++++++++++
 5 files changed, 1170 insertions(+), 40 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260303-bq25792-0132ac86846d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


