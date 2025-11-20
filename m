Return-Path: <stable+bounces-195335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F7C75450
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1C3CE294E6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F502EA16A;
	Thu, 20 Nov 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2taClqW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5B3587A1
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655235; cv=none; b=NKNqolow8QCOooxREc7km8C5pZRYtqGaqKXffZrjNkiOibjJWbvS3c2r29zFRSPeTRCBDmKywZbZMTEt8RQM4sWkpOrSMYD3rqf9X4yXBAu70JnNnHWj1zVTRBwNHjzHRV0x7ERGOfdmS8d00/RX4ynwhjasah3fHQlYKhrV/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655235; c=relaxed/simple;
	bh=gN67dPn5HJkDHA9rzNNREU8a/Ke/QYzy2kebu4ZH7qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ge8l9LS7fKGcOCrxkfj2oeYxx7d7WQ8SNljz61ETQQeTBxPyegwauuvzvJo9HGqBJT7CVBEGxir7lccXAeJ4tmyfwxY2ZtP+f9HAJTVzUQvJGVk4/sN/kvYLYsGKn8Yor02x9YV4VUqd+9ItVzkhqe9mV0TyHjBtCQ3Byhgk/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G2taClqW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aace33b75bso955399b3a.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 08:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763655232; x=1764260032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaSUH4/iI6K4vkTA9vG1I3sRuhxHn3+OXrhAbv97RTc=;
        b=G2taClqWYtKUSxwEEDx58IeMu9UyMJjgb+yYAadw+ZxMczLRv5arrjbM4DxctarPLv
         Bx/M0GofidmCEXJGRNhp2TpuKOpCbatOpfkW0zRXjqtR5WQkf64+4t/zLnvGLVf4dflf
         490KdbQdGvfagPoI0kKMEna3vIwbieOpXJ47I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763655232; x=1764260032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaSUH4/iI6K4vkTA9vG1I3sRuhxHn3+OXrhAbv97RTc=;
        b=VT1elkSTel93nwhPkfvOb/5tmw0oGqURrL35qUlOIFhL1QCLcA66fCGCDCAz7YVUrj
         CVcWZRUvorPXc1tPtk+Dqme6x2gIgpfX5NOgCVaDu1EyxnURKscOpb75s0bIMBCnMSsv
         SkeQ23uCfZRpAlPP6v907Q/i9pr4pal22H41nAk75yYnOqy7daibYTtxfkRuE7wtdk4Y
         YgUI3skAW2tAYJlNtOUNjZqzBqLJ5eDvSgU9rpvRR1BCyKnUqNX3VQoLmyubKVUdEO0q
         Ckm52C9ice5n/kFpmlTV9B0xQCm3KcvUU028v8QUb3rW6Pa+n0Lr2611329XnNY8/XxD
         /lBg==
X-Forwarded-Encrypted: i=1; AJvYcCVzhMmNJP4/HQ901o85/TZ+BNvrewf0/Xc+LNy8KPyCfnmZJEFbfKT5xNkRxkeyf8U/P1TD65Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkjO9vWB6AKiTuljPy1Qk20GRwPJtUUPpmPzj91vGH68WesKK
	X7Lo1gbsANfXAVZPZFejrU6azoDoePkYIA67thiQJo+KWpW4sFgihnp4605n15dccw==
X-Gm-Gg: ASbGncsKN0kOhLXrrUZGoGs+G/gWaw3gKzXq/2KQMkRBGsIjjJb9CFyBHa+saml0jkC
	uQjRXNVXk8dDMQRzrxdzNg4QvOxH589jN1Pzx4KI2sYTJKUGZr8NxR6GKdOfnxQXD3Uf0gtdJuo
	ZeVa+pq49Jmypm8SQ4/3Fu2mc4JRYEqYdSh6VyJ/d0eEipl5+IsRst4xBVxu8RT/KK8nqnrJ6u5
	vtpxM2aaFpZORA5oqFgclHEzv8NqZdz5pZelWaFSchMXEhrnkVwJI05W4qFmE3f+J2bm+a7VSZq
	GoKnJwr/pKxw+UVoUX06OL+PISlPau0oidgGDUPEmIQxk5VpVz2OayIp86X5TVY+XTXZCQYdD56
	aofHl0c5MDAUtz4LQpm560/cjiNuhmQupLN20xIMZjqe+uxJIzEnCot4QY3MewWeWJiS8yiTl9b
	sH6sPvGRiopBcZTZo72yfD773S+AjVhAM7ElrXS2IkzqpUihpbK9Jj5sNRb4R6NOYuxvtM8Sk=
X-Google-Smtp-Source: AGHT+IHXE1Lf/Npuwj0zFjBOEWKicuzA3UumJeheDegj7w9jH2aGLxpoO1AX2E47uPWOL3GSil4eRA==
X-Received: by 2002:a05:7022:b88:b0:11b:9386:826b with SMTP id a92af1059eb24-11c938a5da8mr1482106c88.48.1763655232027;
        Thu, 20 Nov 2025 08:13:52 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:b075:e64a:7168:da0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm14316777eec.2.2025.11.20.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:13:51 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev,
	incogcyberpunk@proton.me,
	johan.hedberg@gmail.com,
	sean.wang@mediatek.com,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
Date: Thu, 20 Nov 2025 08:12:28 -0800
Message-ID: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
  usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)

That function can return NULL in some cases. Even when it returns
NULL, though, we still go on to call btusb_mtk_claim_iso_intf().

As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
when `btmtk_data->isopkt_intf` is NULL will cause a crash because
we'll end up passing a bad pointer to device_lock(). Prior to that
commit we'd pass the NULL pointer directly to
usb_driver_claim_interface() which would detect it and return an
error, which was handled.

Resolve the crash in btusb_mtk_claim_iso_intf() by adding a NULL check
at the start of the function. This makes the code handle a NULL
`btmtk_data->isopkt_intf` the same way it did before the problematic
commit (just with a slight change to the error message printed).

Reported-by: IncogCyberpunk <incogcyberpunk@proton.me>
Closes: http://lore.kernel.org/r/a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info
Fixes: e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()")
Cc: stable@vger.kernel.org
Tested-by: IncogCyberpunk <incogcyberpunk@proton.me>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Added Cc to stable.
- Added IncogCyberpunk Tested-by tag.
- v2: https://patch.msgid.link/20251119092641.v2.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid

Changes in v2:
- Rebase atop commit 529ac8e706c3 ("Bluetooth: ... mtk iso interface")
- v1: https://patch.msgid.link/20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid

 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fcc62e2fb641..683ac02e964b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2751,6 +2751,11 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	if (!btmtk_data)
 		return;
 
+	if (!btmtk_data->isopkt_intf) {
+		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
+		return;
+	}
+
 	/*
 	 * The function usb_driver_claim_interface() is documented to need
 	 * locks held if it's not called from a probe routine. The code here
-- 
2.52.0.rc1.455.g30608eb744-goog


