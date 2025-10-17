Return-Path: <stable+bounces-186219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D04BE5D8E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 02:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7940C356C69
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14383FCC;
	Fri, 17 Oct 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuRknbAs"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521EC3208
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659276; cv=none; b=ivAmjABz60iIlbnzdiMp7OAFJ05R10tCfLiz0qPbxa4IzoZjQI8vkUXvzj5wiALNINkjQshgI/Hq96ZQ1Z9fLZbFWzOKDhZD9NDDGtvFqIQGAIau1iX7aN6yi9ojUXPRhNsX7DymTSiuCDPfQOp790zHECzbeGn4WXnbb4LEizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659276; c=relaxed/simple;
	bh=d3vMgGjtDBOyl9OMQildPrcV91xSXzk0ehLUQ/v8Xv0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kj6xaOehoeymygxuUg1Y3O1tF7guGRBHar16Nankh/GdjSyLQTxPGmM7R8VfdNPD0UCILaIoFW0ktqFWKeKH7x6Xk6M2aM3mCP56zn/gkBJzn2dErgPtR2I1qxVMlve2v47jvxCUbYSzIBj53zkucnHF4+GKdlkiVRP2XxvD3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuRknbAs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71e7181cddeso19725417b3.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659273; x=1761264073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A78b5qm3ewGLH/hUPVAkK/xpFE0iF757uAxcChhA++c=;
        b=QuRknbAsGyKsxrzZ5JEAbo3dZPm2D83FQXEkDMLZGUW9IXCm6tm52h0apq7XphmU+f
         gcx49zQ1+1IaCIgRBFTmu1dtGFU+x2lCBzih1DsZrM6D/jrdZCmEwLONc5z2NtfYfavV
         9ZBYSLfnT7fdfo6qHPhLY54+VEWptUZ+iaPq7i0XAZR98tguDZWBS575xDAmAeG7XzP4
         g1U2mlP63v418SsrADoJViIykwlp4hn1HL8P7BB4Z1ULv4FR5WYxU+xsI7UnItHPa68q
         0UftWxKEHtGoZi12H2KSK8elHJOqMyTxuzjVLsi9GlhTyrKBafvVKvT9a7elEUpc5J2s
         Rd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659273; x=1761264073;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A78b5qm3ewGLH/hUPVAkK/xpFE0iF757uAxcChhA++c=;
        b=B8fWbTP/+skJ2XZw/Fay1cAACRI4tmDlaagRzfsY66Wo/n2ob9u0OzFlS8uceobdSS
         UNEMk9vUt4p2tFYY1PRCJng1f9xsUiuZg7ZR4T9dkuyUTcjYQP7Um7eIhcAU2/3tBEez
         RShOTfXvYt0zzuAFyxlbNHjbQHUVf1RO8raGHIb58O9fEXXcHay+OxqOpVjDBy39U0JG
         2UKnYgMHccLhi07HQD5XQ950G0tyeHlCZNf9LyR3zXBQ8DQ6IT0314vCUK492rBKHhcD
         +tV7P+SotZsYboySRW63LLUNVtCMY9kwsZHaiR/YxBSCst6OcP2M9sDOF3ek0R6vmm47
         tI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzfBZKbsZpxFdoOAFNs79OImaJR8cQCmqOXIMni4lrX2IJORw2BKpLn+z/H5k/YM6feEiNrcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+HuNKM/GlRstLTK8VoSHCuhpNNkoK+/k8XVOyVG+u4NnKc+P
	ZzLk2DMeF9rclb8qUjC6noF4C88UjmIqpdVHFBRrvSHpcLizqDhKtdXDOzruAXwnsZEfw3EWTbR
	gFnW8sQ==
X-Google-Smtp-Source: AGHT+IFylybvNrf3hXc+GFgB8oGAf1c3GA993gedEMW8xHo1GeQ+Z1gBgex+rl8Insn441vHeB3Esg0x1As=
X-Received: from ywbik3.prod.google.com ([2002:a05:690c:4a03:b0:783:2d0e:3443])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7089:b0:781:64f:2b63
 with SMTP id 00721157ae682-7836d3a2c7bmr19754167b3.63.1760659273157; Thu, 16
 Oct 2025 17:01:13 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:00:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017000051.2094101-1-jthies@google.com>
Subject: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, kenny@panix.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/psy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62a9d68bb66d..8ae900c8c132 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {

base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662
-- 
2.51.0.858.gf9c4a03a3a-goog


