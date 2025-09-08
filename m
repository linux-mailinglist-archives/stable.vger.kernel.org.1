Return-Path: <stable+bounces-178820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7E3B481C6
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4403BEE37
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2F19F13F;
	Mon,  8 Sep 2025 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtJSM/we"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3B79DA;
	Mon,  8 Sep 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293780; cv=none; b=MbfWBv7FQeAXwUFpS/eawBPN+kr2yFwNP4zJu00sfT0JYfO01JmfJuKjXmdjerxyVdNDWYDMUbFseH279i9/YeIO7+Zx/StwgXoCw8Ux0qk3t66+xuN40kR612m+YmcECxOFaGJDIf0emVijb61ZP951wiUTdKuIzSbkaopHYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293780; c=relaxed/simple;
	bh=QTYKMZj7GTMqGX8ezRiVw1eO/qNMYDLCBVtIB6Rb+TE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ODyugsJwncew4ncrNE6vPF4OH+qPt3Fl0s88ByIeLl6N903N6UQtgvhm0oSw1ckooxBvF154rK3l36LfWcpA5N+fZpDx0KZFIjhzs8dG3KFceMz9uL0TicDAbEKOsxAk1n9qQE3ZGqgSdzK+BT7aVWegP2cBJGOHG+kC6mRZKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtJSM/we; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-544a1485979so1392347e0c.3;
        Sun, 07 Sep 2025 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757293778; x=1757898578; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Du3srDF6UPfhrupytVwLIPmPp60yh1EAzBmGLDyImAU=;
        b=ZtJSM/weRIu+idWhWrktojlIJOcrDs+SPxEfrI4SzsS2o+Yvq3go1Q/f897UStWm1p
         ZiEaLa2tmomdWt64BYLw9AEWVZMJgdVa5IDSGNraq1BsOXyc6cuTgSBvbJ2Kq2QRkU8C
         IVfobPl3EdpTFd8gAKfKRQFWVUXT7ha3yhl3DgsoYDU1nMFn5mk/5GHwHfQ0ZilwoMf8
         HFMI/jteGfSlaiLY0emE57/JwDsKIjiPlqyaVAajfbM6Votqj7wLRG9gvIvzaT5vtU1L
         8xaske+YZUAr8Obxmig54m/Jg2iOjsqu7l4p0mpME8hdHUpWNSaH8yG8nyGo0XyyRzsI
         I7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293778; x=1757898578;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Du3srDF6UPfhrupytVwLIPmPp60yh1EAzBmGLDyImAU=;
        b=Jm3VrF/jLrUdMbooYnGmCb+p8fH7jAL48d+8pa0tphY9X8jmc9MZTCPihsfXYR0DaB
         eBOBkOTnm4r+QNgnx/MURGxB8U5lf/fmgNzsqCOETJhlgx9yFaPVLTncr99rxW6f8iin
         Hx8/2LoIKD3/AqT3O9hMf/ym7hT068W+egFINh+jeAxVt/Fcz5NO2ztqgY6SlDMjd6Qu
         2OM3kQSB2Uymvbd2UFwNrB1G9IWxuxozAd2+SrIJpJEj3e1ty+xyVTQcNBlXMXxNQzoq
         ZE2w8RldKAuXrtjOQWyHqmblituqITZhtub3vvoVZbYwXdgvm/Codc7uZNQ7DVWyMkm/
         fHxg==
X-Forwarded-Encrypted: i=1; AJvYcCUBcEq++2GCVb5FgKt7nnyTsxdqURiOUiPWQWW594mANCMMtwxIUHQssey4eDE5pMInLf9Uel4pSf/Y@vger.kernel.org, AJvYcCUmuvCQWYa4CF65rYZErXtSKZa6P2YmQqfTedNK1IYIOagasCzkdFBKbpS/DmJcohuv0PZwi/AfO0jnbFo=@vger.kernel.org, AJvYcCVVkFyjkSMJClr5S/hxPnYpnoHSv1ucrAgn/EsZa7Pu2Fz50n2lB4piBzKY8cbfALW+cFNu3Q9WWouRzUDS@vger.kernel.org, AJvYcCXTMIBRFQpfz+ktLD7rFZFCyfWBr3kSWQAuHb+PAtRygtoNU3QVOcjxO6Do5D0kfKvyYOCvYV0Udmo0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oeY9hVrDK7B80s5qk0a+oQeLar/QrshBMLHpYBofp02jvQgC
	g9g4QV8Va8h/DACVmgeajAA9KVrHJhUm3gKbnlfQ9UyIHhbZj02Io0dt
X-Gm-Gg: ASbGncudH+F48iPD76p7PVmq/v2repV+1xQbKj4/xSA7tOe7hJd2UBGuxMGE5nOhKzN
	dIrARwKGja5RcK4OTunfND0vuZemaeYRr/CmEGXq3Zjvlp0AGhNzk/gEKJHBhgrLIzkelZAFv7y
	mgSwhnMV4JujHeCq2taNveNwPpmsdOkCy3oTGcDyFPeW8i4c/1/zyqdBdPQYqcePd8d5Nlb16fh
	xkt4G7tgSSvN0xuPacWaefRVnZmQ2cTIin3ZYiexc55KeaTYgCXXH4ZstXgDDHkkkUSAzOkiN1Z
	KkDFzDjDPxSDIHf+0Q2ueIJu2oRDokMcGJapuAhRAOjPB6aWJGUffCCVtTYbL2DqiOT1IXgItqU
	XiNPKGzKHiY8nBNJyal72xowa77IBpUegV60=
X-Google-Smtp-Source: AGHT+IE/L65Pz4ovECwY6tiyjvNc1bmIYNWno9DSougVnjlTQjhLzQHVlpmXUjU8mT8Mugw2oM7Z2w==
X-Received: by 2002:a05:6122:2a41:b0:542:1516:2701 with SMTP id 71dfb90a1353d-5473b0c6e03mr1402995e0c.8.1757293778135;
        Sun, 07 Sep 2025 18:09:38 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm9152572e0c.9.2025.09.07.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:09:37 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 0/4] hwmon: (sht21) Add devicetree support
Date: Sun, 07 Sep 2025 20:09:09 -0500
Message-Id: <20250907-sht2x-v2-0-1c7dc90abf8e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUsvmgC/13MQQ6DIBRF0a2YPy4NoNjSUffROAAE+UkVA4bYG
 PZe6rDD+/JyDkg2ok3waA6INmPCsNTglwaMV8tkCY61gVMuqKQ3kvzGdyK17BkXihonoH7XaB3
 up/MaantMW4ifk83st/4LmRFK3Cj6e9dqprv2Oc0K31cTZhhKKV+9gyXxmgAAAA==
X-Change-ID: 20250907-sht2x-9b96125a0cf5
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=QTYKMZj7GTMqGX8ezRiVw1eO/qNMYDLCBVtIB6Rb+TE=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7dM6W3m3tuFORVJRyK5k/qPeBgrAvx+prHM84/j7Wb
 xBab3u4o5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACZy4hIjQ8OxoEuHd34+U/ng
 /FKpF8e2xH6LYHTcPU/o5dnmOIPgs/cYGbZK+q08+8pS6sPha6EV7QfvTH959EN08J4jNdWcmRs
 +FLIDAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

The sht21 driver actually supports all i2c sht2x chips so add support
for those names and additionally add DT support.

Tested for sht20 and verified against the datasheet for sht25.

Thanks!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v2:
- Add a documentation cleanup patch
- Add entry for each chip instead of sht2x placeholder
- Update Kconfig too
- Link to v1: https://lore.kernel.org/r/20250907-sht2x-v1-0-fd56843b1b43@gmail.com

---
Kurt Borja (4):
      hwmon: (sht21) Documentation cleanup
      hwmon: (sht21) Add support for SHT20, SHT25 chips
      hwmon: (sht21) Add devicetree support
      dt-bindings: trivial-devices: Add sht2x sensors

 .../devicetree/bindings/trivial-devices.yaml       |  3 +++
 Documentation/hwmon/sht21.rst                      | 26 +++++++++++++---------
 drivers/hwmon/Kconfig                              |  4 ++--
 drivers/hwmon/sht21.c                              | 14 +++++++++++-
 4 files changed, 33 insertions(+), 14 deletions(-)
---
base-commit: b236920731dd90c3fba8c227aa0c4dee5351a639
change-id: 20250907-sht2x-9b96125a0cf5
-- 
 ~ Kurt


