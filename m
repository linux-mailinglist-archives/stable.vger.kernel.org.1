Return-Path: <stable+bounces-183337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD7BB8558
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FA41897D87
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630C274B3D;
	Fri,  3 Oct 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="juXrh8uB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774D2727FA
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531270; cv=none; b=sB6WEYfxldHx7xpk1BN2s3DfMvT+8ZuTaQqqREQhWqK/1H6SoRctwLT8DT3IxQsbQr7fNiSVaLxoc6r+Pc/YmB72DVw/JigQcS6mrpLL4wLN+Voud6p1SQQZpXhyFbF0xv43zqB2YfNN/BkXGImea0KOdh7zy9QZK4FM31suu9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531270; c=relaxed/simple;
	bh=Vrqm526ny5yTVpXvwE3LjdEtjEskvLSj+n2tmpclw6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G76FSMaxJMi9nLavW5/K8AgSlFtjoVuuBqlLP14/NDnFhZEHgpI4jB5TKcYQIYjwkaeQRs0FFQhuRknvy135qhryhUjfdASGR3z6XEIOzxIrCDh6e+DhmSakLEVsccDNgeB5S/9fLxVm3zz15SwZZ7fxlWvc9A41GrLzkV4LUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=juXrh8uB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2815022b3a.2
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759531268; x=1760136068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeicDYAmN1c9l354hBnKMGXATeP19C1JWHBKyR4ISl4=;
        b=juXrh8uB0u3TCSnPfmH+6PLd/ZqqgtZIVvf7wC4hwkhQZRTpafvN2eScML4P3bHeuh
         wUrNUBcKxwQUoGmwFLr6kOUVKkwh2B1DfbbjP73M4Ab1iv/cwZQus+x6vvl3uOsNiWZA
         Xh2G16M3VC3ffeBiOqhLiLSvLeGduWMfK0yOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759531268; x=1760136068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeicDYAmN1c9l354hBnKMGXATeP19C1JWHBKyR4ISl4=;
        b=O6dYE1YXy9oY9Vn1ES4yScV8+CG+PtVk8TgViLHR9z/m9om/u4ZD2kkmbSe967rirv
         VP1h2B4nGmQqaKd9zPJqXI39ZsR+a2tcqwzZTGeSggJvBsjCXlHLN+e8Ck7yfFztxqNb
         dcgtp3kU5j3odNUSgdrCVGu9PmtMEGyg7z/2x2uTU06MMtqufZrojehkAnDn0Wj/2NEa
         66/WN0hSl8bPAGSvm1FawvDJOjTOJCQlVCtkHXm2ilhCNrKFD7fPPC/aAdXRT1Sx2yEf
         HEeEdf4UqJSf5h/aKm8NCPPIh3TQbMOBnubL6JTURMzr4X4fttsDw1+WTZ5rmjUHUghP
         jQIw==
X-Forwarded-Encrypted: i=1; AJvYcCX2BTRZXwJYZExvOkPFSbkwEBCDGR1HQDYJcaQwiyUlnWjm+u8Ii97kUYSuFayNaoPsu71BEEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjBrCohSJbgFmtfM8ut7lZMaOoZiby+rZtFhLlqiU0hrhaROF
	WzpnzNGH1CDn+ihUb7bkbPeQl+VrpdyAIwzgh+oecJkxd07GFAkYqdTBNbB+WYkRHg==
X-Gm-Gg: ASbGnctFA7c183w19TGC/5heuTRl3FnNC2nM9c9y9CxvgJH/Db9rMw7UvOvawPWZ2UG
	itHKJ8dRouS+Gpbg8kbbaaNdm6csZ2D/J86n3/Qq4gSmk44AjqtwYoZb6SX+NbnqodoUOzdShv5
	o3ykAHNOBstcddwI+IsUlED+v5xTNBzgvAM/1qWYgKTblve2k3PrRWlvUx7pXwt9eVGlpX+7+9q
	4L3OkyfBETrKepSLXV3Hj7jLmPJA/Qw4QlsoYpFfitgT5/eL+Ag0mG+FFjw4q86njFgTR3TR9MW
	eI+nuNpu7csoiGbTTYF1AW6C+VlygUPlOGEHzpVVPer9JhU+XamEpVZt+CtODBi+Dz3ipqNvvRc
	Ddfc5aQc/Pntckhlm2jUTymmUXWJ82vty028dZ62HRkMrO2nV3GdAr+c8AIrszQ+K3j5gq9uQk9
	yYopDSnW9pifoW/g4OVg==
X-Google-Smtp-Source: AGHT+IHuxZQfqBTYgVR3eorEaq34j8jAIC8x1/0Ean6DRRMQBKylmJCxcOPARTWj8v8GLQv95Shadw==
X-Received: by 2002:a05:6a00:139e:b0:776:228c:4ac0 with SMTP id d2e1a72fcca58-78c98a6a73bmr5556620b3a.11.1759531268189;
        Fri, 03 Oct 2025 15:41:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:9212:ce9:ffd0:9173])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78b01f9a364sm5892754b3a.6.2025.10.03.15.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 15:41:07 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Date: Fri,  3 Oct 2025 15:40:09 -0700
Message-ID: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

When transitioning to D3cold, __pci_set_power_state() will first
transition a device to D3hot. If the device was already in D3hot, this
will add excess work:
(a) read/modify/write PMCSR; and
(b) excess delay (pci_dev_d3_sleep()).

For (b), we already performed the necessary delay on the previous D3hot
entry; this was extra noticeable when evaluating runtime PM transition
latency.

Check whether we're already in the target state before continuing.

Note that __pci_set_power_state() already does this same check for other
state transitions, but D3cold is special because __pci_set_power_state()
converts it to D3hot for the purposes of PMCSR.

This seems to be an oversight in commit 0aacdc957401 ("PCI/PM: Clean up
pci_set_low_power_state()").

Fixes: 0aacdc957401 ("PCI/PM: Clean up pci_set_low_power_state()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..7517f1380201 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1539,6 +1539,9 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	if (state == dev->current_state)
+		return 0;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
-- 
2.51.0.618.g983fd99d29-goog


