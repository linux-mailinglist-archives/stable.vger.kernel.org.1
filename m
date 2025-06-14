Return-Path: <stable+bounces-152646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F03AD9EE2
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E6B177431
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B702E6D11;
	Sat, 14 Jun 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNqLTmB6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0931DFE12;
	Sat, 14 Jun 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924908; cv=none; b=qiYUh6vYc5Fh4n9LduDERPTD3Lroou4KtW5UvooUC7EpuS/vTrnHbnonMG+FZkvVorpu7QXjJphbaAb9NIQBLtI+8CRZ9jlKHmlGWba1DVeQQKvifmMIwiaGlg5WzHZta/9rzZAXWtkFcJcbv2GyDUE5Oji/8QUdehEm83a+FA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924908; c=relaxed/simple;
	bh=iJiCJI7sEDUMdHrBPmtVqIaCr02IcgWh7GEhyL7jHyM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VPKMAn6yS5rFesKV5YKQo6Y1cICqVp9w+pY13hdiycVBRkJTszlgdQmfJJj9X6VZcyeXrxIV29hUA4WFlbITyZioyvL0VQVs/WvWP6KTJOMtFXTMgBi6s/KaFjJIeUza16BX5lblFH3t7f3t1JjUhHMAiYDveccVmL28xFajQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNqLTmB6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4533a53a6efso5618925e9.0;
        Sat, 14 Jun 2025 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749924904; x=1750529704; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVu3ELHj03qw6JVbHO+qBJXkWeB0FzNWWpqUWGfylOM=;
        b=bNqLTmB6WnJw/DZ7P1Uss2fi4EXoq2sFhf/2+67wTmkY9ZLiNf/VuiwMcDt74naa5b
         zFWRPF7Yh6PJ5aCFyv6wm+kQKyd/UYrnieZse07c6+vHKyubOBhZUICkquWJtZWDDDhs
         26/Igl+Q4maClTIUZ1etPrFInswWg5SXjxmelb9HSGoB3WkWe4ZJHF5J56lPv5X9QdZI
         xRdfsey1VvpkkMdRqkG1okbncFx+e5flllLTCzTi/FSUqNw6olzQYma9QCNJsHRm3pfz
         jQs4DTpGWINFla6e1EIAFkll/ThsJ1WSeUqhSD9UGujDKCQgwXJJPX+H4vvIoQL490/b
         GMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749924904; x=1750529704;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVu3ELHj03qw6JVbHO+qBJXkWeB0FzNWWpqUWGfylOM=;
        b=pY9sZ35RImU0E0j8Zj3imk279ODUVbbQaigrZCGnjE5Wr4MYbNM10FSWl13V/2YfcG
         beKQoa75nyctgt3ZB1ny3e1r9zhfQpPySoeJKy6CLk2ofAbv9la2gSfhf/FDkip4bEN+
         WCws1GZTqjGWa2u7yM+tUx+twTUG2OMSbStDoC0sqAVYMcRwbjQpYtDoE1DLNAwxHbJF
         GGi/vZbLrvo0eziOaxQvQrqzuB7LGxmAFhoK6mCq8raWIIFKkMfPA1qWUIE1mvK5CexU
         NojBa/LR+2bbB35WkMEp2l6GYz5tigsCZPQyDDXH7709M9GzZ4AaSOplJq2iwCL844zB
         WISA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLyi/PbW2Ia7dgJN7q2x3giYdPw+f7loiJq74xtnItSUZV3GVAJqBH0rv7GY4lzhCx6cantuvmAi3da8=@vger.kernel.org, AJvYcCVnzBjdPSNOnZp2BFZJQtkMIxoVwyrT/4UIcxTLqwWS2sKgpILj/Kw1SBwce0NwTS9WRhrGu+cC@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdNrdQCZ+SK2USKBncice2YxjGloeSL6HXNAHsjVMl+wj5AKb
	c+CVRj9FWRslADTzb0TU0cNW6KTtiooBxgy3QZsdZ1yOhQaEdtXEtDnn
X-Gm-Gg: ASbGncsNrjQ1ZeAZTp97TwskkOmUokkv6XOStJmLbRGIArF9auaqvixMGwTQsFKAA/d
	dClbpwAc7/3REQEu6Kb0sFmG8dAKfOSKlhZhTTFTZCLV6prjI9OmnvkyCYvMkAnk/1CLlWyG53Y
	cxESkJzAXd2lwnMTIeIrDrMiIVISeP90spqCORGP/U57AaIUNXX/Fnfx29ZRvOrk+5HAKmIN+GP
	RsbeL4Anbjj6GW6bbb3v5bzOWX/nuXhKfIs64ImwXBA4wqjAvU+NeBH5Uq7WdhQWeVVCexcTwwr
	7lKouZ+oCWNzTRagbE2h4igeiEFzx8vqO7/2VPMNixe62FLvTtRJtsXHFIweJJ87mHgSvz7TJjG
	tKA==
X-Google-Smtp-Source: AGHT+IF7S6DdjgB9HqBLnkqzUP5clevKdsXdT1UzIJZ2T7UBIuvG2KsfubEYBL9quR0XBdxCQQ+4lQ==
X-Received: by 2002:a05:600c:3acd:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-4533c8c22b0mr43443515e9.3.1749924904197;
        Sat, 14 Jun 2025 11:15:04 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm88195255e9.4.2025.06.14.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 11:15:03 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v2 0/4] arm64: dts: rockchip: enable further peripherals on
 ArmSoM Sige5
Date: Sat, 14 Jun 2025 22:14:32 +0400
Message-Id: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAu8TWgC/13MywrCMBCF4VcpszaSiaYRV30P6SJpx3bAXsjUo
 pS8u7HgxuV/4HwbCEUmgWuxQaSVhacxhzkU0PR+7EhxmxuMNlaX2ijhjqx6zq1fSJTH0gSr0WN
 AyJ850p1fu3erc/csyxTfO7/id/1Jpz9pRaWVQ0eXhs4+OFd1g+fHsZkGqFNKH/5eTxKqAAAA
X-Change-ID: 20250602-sige5-updates-a162b501a1b1
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>, stable@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749924902; l=1743;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=iJiCJI7sEDUMdHrBPmtVqIaCr02IcgWh7GEhyL7jHyM=;
 b=oOTtK42sNKGPgFOk88atAKW1HsdVOAjslHToD41tGwccGRU4iV1vaf7dEgC9xqs8fGrvk6VF3
 OBy1U/DvlysA5II5eNVOuw+Z9iQ2A03G1eX9PiLbW3nFMRKNB8KT9Bg
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Link up the CPU regulators for DVFS, enable WiFi and Bluetooth.

Different board versions use different incompatible WiFi/Bluetooth modules
so split the version-specific bits out into an overlay. Basic WiFi
functionality works even without an overlay, but OOB interrupts and
all Bluetooth stuff requires one.

My board is v1.2, so the overlay is only provided for it.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v2:
- Expand the commit message for the patch linking CPU regulators and add
  tags for stable (thanks Nicolas)
- Fix the ordering of cpu_b* nodes vs. combphy0_ps (thanks Diederik)
- Drop the USB patch, as Nicolas has already posted a more comprehensive
  series including also the Type-C stuff (thanks Nicolas)
- Pick up Nicolas' tags
- Split out board version specific WiFi/Bluetooth stuff into an overlay
- Link to v1: https://lore.kernel.org/r/20250603-sige5-updates-v1-0-717e8ce4ab77@gmail.com

---
Alexey Charkov (4):
      arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5
      arm64: dts: rockchip: add SDIO controller on RK3576
      arm64: dts: rockchip: add version-independent WiFi/BT nodes on Sige5
      arm64: dts: rockchip: add overlay for the WiFi/BT module on Sige5 v1.2

 arch/arm64/boot/dts/rockchip/Makefile              |  5 ++
 .../rockchip/rk3576-armsom-sige5-v1.2-wifibt.dtso  | 49 +++++++++++++
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      | 85 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 16 ++++
 4 files changed, 155 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250602-sige5-updates-a162b501a1b1

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


