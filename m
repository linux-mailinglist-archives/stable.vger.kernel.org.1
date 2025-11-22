Return-Path: <stable+bounces-196602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75FC7D4D4
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D58834AABF
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6E27F171;
	Sat, 22 Nov 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnrAa+h4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3427CB04
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763833054; cv=none; b=rujOL9+VsS5xpiUy/ejmW0rvU1YgYzpY0e4uYcR5P57NrOow+eKWuKEoxlUtKvrSQrbtqmsbCYpc47szh/dgCD2lj3K2mk0ai5bJf/nm1EtHsaK60bk3H31Dl7llz5ZeOB3R1VTjpfVmb7ptSlXYdO29lponJBy+rThvCqLmliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763833054; c=relaxed/simple;
	bh=jgSpPfKX7nKuDlbS1ie3b78ZMi4lnqU28xD8BnkyxRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZQoqdHyta0CUkKUC9UJrhx6A6RtphgHARkmUlLIzXolIDhOz+OcCpFP2DEI6iSuCr+qdhXztajbDZUAKmAiNmh/wzPGsJTefvsMQMlpRAg+DjOkzpPSyVfxnt8sF5l0yT5ffU6BuyNeF8s60yfBloyrGm09QAhPgVStggy1DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnrAa+h4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a1c28778so33887425e9.3
        for <stable@vger.kernel.org>; Sat, 22 Nov 2025 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763833051; x=1764437851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNcsW5vBnLmxdCKt7kb43zPkWdZHd7JLYgIeVgNn+Ng=;
        b=GnrAa+h4VoONSlN3XqKtSFagoITSpngz1hHBNfl58ezjc04F54QtizrFnVa7lX4lLj
         MJsHBMXWFI80lOKbEzw4bW7rE5B61GkipO1i8Ctp4meR2leKgX1fdnapz1p9cJy3EGrX
         zrZAoI9zXvPXGOnY/0KaD1Tcdlg36dV113fPRLRY4joytGoD3vKJibYnEei33/LV0pqp
         isRO/x1179k21aSTxWFQ3llhJEuXJwf5EM6NOmkSIOKCZ2Lr3lK+1daK4GHO4BznlcgB
         ehIRzVVOUeGz9KCiOmf5/n92HZ46iKvzLbkEqByhNi36jnmuGO09KTKkIZ/Xnb2Tl6ir
         W1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763833051; x=1764437851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNcsW5vBnLmxdCKt7kb43zPkWdZHd7JLYgIeVgNn+Ng=;
        b=ehHXviJKz3l86RPscGEiYbrwWw/XnN/4sUxzVUlmu5cTLit8N6T6omZMtr1qXt/hxb
         /1dYubs1GjJY9T+80ZW9QSAETbd9KADHmd4mx2qTKTMqJMIC9Sv7R/q+Jmz57SKmn7ai
         g2U5z390Lje9cellk4BmRX3dIJcJyqgXlLcgwovFomRlsO8T0z0LVIVBNJnzcjn0yFOR
         5G31Gf7WhOV3kA9ME8ON8GMMR3tSOVcnoTE872BF+T3HgtUMlR73nqS97mzcTCw3E+ss
         Ly/ARsDzPcNFkAivMuKvrCERvE/MWgxBkRGpNrbDCCXDSuJuzwPnyIlfLzRPqmXcXhy7
         Fcpg==
X-Forwarded-Encrypted: i=1; AJvYcCWL8eegcFn4UvbjhyCjj5AAsRBemASsfINxiny8hO2b8Xott8g7WN3T5sA5Ox+fQ4je4m7/AFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYretF2HTmm34K5y72oe9AdeznoMvTfylUZ0UrKKwCazNkX5B
	9kt8CcVQKz01OWBZYBjC0HcWrmmIMD2bfpFUq9+2qZJOu4NGp9qowNrs
X-Gm-Gg: ASbGnctKrGDxac8VuJvQ3RnXs8cUVILK75nnXI27F0lbM7F7I1Tzd4dKJ6V5KMcF/8L
	bJgSPlayB/ntImGsYcLuiweK59Mvw0AfAeI0Cfq+hxM0R3g0w/RVFFiAlYB9noSwmj3f98F6HPh
	+pC+HeN7M9+SogiNn/Phwkgee0myRXFF5hgWosL2kSWErtsHf/5xW5F+A5P0cMJcBStCCrUkVN8
	eA/vwxw+maRYPvlwYnsz/Du2k8qk7me4Sa6Mn8ksGR3o4I2e7Z5HDTSR9t/OI6FWpzRy2VhuiOH
	gaZ9v99oXBLho39A8bCpRfCojpSAKMfkCxF0O82jJ5WRb2e3HBZnTUygS40tPIJPUnJtdQcoFll
	6hm4V09knwKztZgxdY26zWU0UYC/c6IbAnzX4eJphDIm9qHt8D7ZQ3XN248d9uGUMqv5LkSUOLC
	LtAStZj1JrVar6gD0qdb8auxC6UQNB
X-Google-Smtp-Source: AGHT+IGsTfGxHQxgZgJIIPv8CKF40nlldzUGw8hZ4M8Uj5zOydPQyKyC7DmLvOxFKHiXw3+JrzWB8w==
X-Received: by 2002:a05:6000:220e:b0:42b:3978:1587 with SMTP id ffacd0b85a97d-42cc1d27ac6mr5941658f8f.36.1763833050375;
        Sat, 22 Nov 2025 09:37:30 -0800 (PST)
Received: from ekhafagy-ROG-Strix.. ([197.46.88.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm18115824f8f.39.2025.11.22.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 09:37:29 -0800 (PST)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: roderick.colenbrander@sony.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	max@enpas.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eslam Khafagy <eslam.medhat1993@gmail.com>,
	syzbot+4f5f81e1456a1f645bf8@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] HID: memory leak in dualshock4_get_calibration_data
Date: Sat, 22 Nov 2025 19:37:12 +0200
Message-ID: <20251122173712.76397-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function dualshock4_get_calibration_data allocates memory to pointer
buf .However, the function may exit prematurely due to transfer_failure
in this case it does not handle freeing memory.

This patch handles memory deallocation at exit.

Reported-by: syzbot+4f5f81e1456a1f645bf8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/691560c4.a70a0220.3124cb.0019.GAE@google.com/T/
Tested-by: syzbot+4f5f81e1456a1f645bf8@syzkaller.appspotmail.com
Fixes: 947992c7fa9e0 ("HID: playstation: DS4: Fix calibration workaround for clone devices")
Cc: stable@vger.kernel.org
Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
v3:
* Address issues reported by checkpatch and re-format commit message
for better readability
* kfree() is safe so no need to check for NULL pointer

v2: https://lore.kernel.org/all/20251116022723.29857-1-eslam.medhat1993@gmail.com/
* Adding tag "Cc: stable@vger.kernel.org"

v1: https://lore.kernel.org/all/20251115022323.1395726-1-eslam.medhat1993@gmail.com/
 

 drivers/hid/hid-playstation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 128aa6abd10b..05a8522ace4f 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1994,9 +1994,6 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 	acc_z_plus       = get_unaligned_le16(&buf[31]);
 	acc_z_minus      = get_unaligned_le16(&buf[33]);
 
-	/* Done parsing the buffer, so let's free it. */
-	kfree(buf);
-
 	/*
 	 * Set gyroscope calibration and normalization parameters.
 	 * Data values will be normalized to 1/DS4_GYRO_RES_PER_DEG_S degree/s.
@@ -2043,6 +2040,9 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 	ds4->accel_calib_data[2].sens_denom = range_2g;
 
 transfer_failed:
+	/* First free buf if still allocated */
+	kfree(buf);
+
 	/*
 	 * Sanity check gyro calibration data. This is needed to prevent crashes
 	 * during report handling of virtual, clone or broken devices not implementing
-- 
2.43.0


