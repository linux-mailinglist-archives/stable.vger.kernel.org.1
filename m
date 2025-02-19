Return-Path: <stable+bounces-118253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B65A3BE1C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124973B50C9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBA1E0B66;
	Wed, 19 Feb 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsR6S0xH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E961DF755;
	Wed, 19 Feb 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968241; cv=none; b=Q3nnQSOaWAjkAPSqxptJ0PoJ3FplnqD3jqlJLtCV4163bmrSnHrgUctsI56uciucWhTPL42w/X+eIyx/4w7eq39JIWtxIq49WAKuFGWMiCU04Qnd+QLQPQy2pIAFryaf2T7ycq4peULFCV7RhYcErGiI8gMlN/Cwp9csfr9iBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968241; c=relaxed/simple;
	bh=ztDgWvwz+CZSZ7CQPPdu/7HdN7wQIMweiboHpzxoiWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYKdcsEON/poA/odFq6vyXaWwXpnBkmpFOCy8EWR6+/fy4+wZOfvDMPldZ85EciofMQee0gUIEJNkqlhIKe4pEHAlo9V7ZvcuDrzEw5dvbkzVnOWYO+eCd8aNGU6l2dKBdSrenwzCEgSdWeF4xXtjvfVp9FQa9cFSIiz5oIYav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsR6S0xH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so122286035ad.0;
        Wed, 19 Feb 2025 04:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968239; x=1740573039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYxtuN+FHDHDJ1UtgUUZtfJNaXcnoTaEgSZ1XZNBNzw=;
        b=DsR6S0xHbZWBjb8wktPU8nH7WqaUXZ19KrTg7W4CRcg4RboFTvCS5c06gZCAbFuXMm
         YcX2A7xLCFR5Wp3jtYT11jNHC27AsYTwUEJhTBdydOD+CZfsMh4OBy55uqwAhd1vH7Kl
         TOZOxntNg6tjtFG5OjkGiwLKgvECLF+qmy6inZXHFu8NZacYLhHUjzM2Ki/Zht/389Us
         b1T+yCaEiFJ5wS3WMPlTHQvKKaXD+OOuwUskuoEPSqUeqcmgq5TlCAdUudaYavLD8QH3
         h2KJzi8lbJ3xzARdn6ESykTN3Lhvbd4y2ARZYOD933+0cg51C0BEOQ/oaI1nTRhEQSMn
         8sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968239; x=1740573039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYxtuN+FHDHDJ1UtgUUZtfJNaXcnoTaEgSZ1XZNBNzw=;
        b=u50EU4mCOQlue4eGCTR/wcaEwOkqWTpDU/Tr1M33hbia6qVdwtQbgRVst0EkOoGRQv
         CAjJpwvGCc9+Gl+zU6gk4TNXrYgJdv/4md084PKMrLOvvi0jwUoA5FcaaEoAPETLvMqw
         sF9dz+CPx9O1JwK8kJDYCurQ86miYawxm9ctfXPouMiwRpNB2ggze8gZFohmctfZdf1O
         HCfUkFj5X9wLhtt2/mpVIp/+Vq/juLs46xK1y8sHWpU8I4psfD358NbLAYu+TJeTwaje
         4Uz/8p5WXiU9V46EdxAHq80ndDU3hNt2sJsWRI220tOTLIuKSf5crOpxoZS2R1/K2yM3
         5CUw==
X-Forwarded-Encrypted: i=1; AJvYcCW1pFT2oMB0OzhGXn9RqBS9Rz3E6/s+etext39Tq6f8M+NuSBlSn8EjO5JkCzmVbbFayPrUJAwU@vger.kernel.org, AJvYcCWVVrIcVeg72VsqI5llBggeON9hzsFCT7JH6FGWdtQEJ9qcwXZ8yrGadJ7kt0vIlCmWx7Kbl3BjrbjFog==@vger.kernel.org, AJvYcCXPvyI/cPVtAwpjIdxfbCv550uxyyZwUfuES4NrIRLZZTAjoOcMfrBpp0VN5aJ2mAI7JZvhtqqcXDxy827A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3v/2dP+3makg8Rb1LwUbwcLmnmVcacAXHUbqrQea1Cz8oG4SF
	friO1iHSuWQ3KfddQ6cS0oQhWOJjh5SwgjmZV8xqTpeM2N4sOTPs
X-Gm-Gg: ASbGnctPRP4QJhNt3flrJwXu6HuSYfL9FnNEfpB8fV8TL6lkvkI12LlB2IvQxVbdMZm
	1wTio2ULRUngBPeoMth8itRmnYh5URkBxkhS3cnLrAzrSnRwCVsnOZDmw2+Ttcz0QU1hl7iE4S1
	pjYrTGE/a8g8CBwBusjCQkeLqMYGsqdNOsYw3rWa9Kqn9EtoLQwkavWUyc6r905qA0abas3sJB7
	M8oG7RmScRA5xocOrt27GDyTr+QBxCkosCIKSAr5IyU//wlD3+Ei5UQbrtEqVCPF4USVKn9pCxd
	WQkempKZQqaZ8XopMrk=
X-Google-Smtp-Source: AGHT+IFHs043Az3sOgkW8oNKMParbw6enY+JvxfeqIdEzf8wa0Ef/I2EUsS+62XtazqXNwwof3B8Rw==
X-Received: by 2002:a05:6a00:180f:b0:730:98ac:ad79 with SMTP id d2e1a72fcca58-732617d97b8mr27800074b3a.12.1739968238240;
        Wed, 19 Feb 2025 04:30:38 -0800 (PST)
Received: from ubuntuxuelab.. ([58.246.183.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327e17440esm5575536b3a.76.2025.02.19.04.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:30:37 -0800 (PST)
From: Haoyu Li <lihaoyu499@gmail.com>
To: danielt@kernel.org
Cc: chenyuan0y@gmail.com,
	deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	jingoohan1@gmail.com,
	lee@kernel.org,
	lihaoyu499@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	stable@vger.kernel.org,
	zichenxie0106@gmail.com
Subject: [PATCH] drivers: video: backlight: Fix NULL Pointer Dereference in backlight_device_register()
Date: Wed, 19 Feb 2025 20:29:50 +0800
Message-Id: <20250219122950.7416-1-lihaoyu499@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z65fFRKgqk-33HXI@aspen.lan>
References: <Z65fFRKgqk-33HXI@aspen.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per Jani and Daniel's feedback, I have updated the patch so that
the `wled->name` null check now occurs in the `wled_configure`
function, right after the `devm_kasprintf` callsite. This should
resolve the issue.
The updated patch is as follows:

In the function "wled_probe", the "wled->name" is dynamically allocated
(wled_probe -> wled_configure -> devm_kasprintf), and it is possible
for it to be NULL.

To avoid dereferencing a NULL pointer (wled_probe ->
devm_backlight_device_register -> backlight_device_register),
we add a null-check after the allocation rather than in
backlight_device_register.

Fixes: f86b77583d88 ("backlight: pm8941: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/video/backlight/qcom-wled.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 9afe701b2a1b..3dacfef821ca 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1409,6 +1409,11 @@ static int wled_configure(struct wled *wled)
 	if (rc)
 		wled->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
 
+	if (!wled->name) {
+		dev_err(wled->dev, "Fail to initialize wled name\n");
+		return -EINVAL;
+	}
+
 	switch (wled->version) {
 	case 3:
 		u32_opts = wled3_opts;
-- 
2.34.1


