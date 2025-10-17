Return-Path: <stable+bounces-187713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE34BEBED0
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBC82354527
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563E2D8DCA;
	Fri, 17 Oct 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="is6msNhq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056A1FECBA
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740259; cv=none; b=spYHSsVKJn9y8PEg1cknHodcJBfyqMNL1aED12LgPqgei3awmQPhK8n5LK5Fbaef4NcGSG5M4sbUyKESjkoZYVKxh6cLJuN9hs4Yp8G/4cKXPdV6cwbHYchlHDGhxm8VFkQkHeeLGus2J7iXIUDiBQfgabCt90+TrWoo8kdniC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740259; c=relaxed/simple;
	bh=coMsoCZvoHbuI23XThH1BMIfJtV8x1r7cZz+hCzRR5I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PU3aHzxfJwTOnzDCy+xyI7rSEQGqQuB0vtXwZ7jE4m+BVYLNN7SBufAw00+d0qexpZCMP3Bl/G8JA1MheU0PjWnvGc8MnPfX+YwowUcQmfDhMidn9beKccrPaVIcxfjrKImE/TaWpr/mrjhNXZ2VgW+Yt91oR5gIX93/0xPFGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=is6msNhq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290cd61855eso14698455ad.1
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760740257; x=1761345057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1aGvnCfkCxuG7nRHD5qS3K0Ns2/mfOtufedzaaye1sE=;
        b=is6msNhqyFq7lsWi2gi9bkEIarskO6dC2FOUHkmGJcw4/fe+R2PL7Wht2cCSCDcw0S
         6DXYysCHLmnENIQwYxuRAiKvtb7Qcj+2lQQYLapYocBCyyOTkPUw5F3bWIBOo6y32Fdj
         nKJx7G10osH3l7YdE5SV5MuIZJGsI3twYkUBkILz+MiZ2MU27SC5En72SHPLtUA3IbhM
         8PR6aOVILGRNk8iLORtzIXd52X2CJSt7VQMJ8X5BiDFbpKbEoZxMGSO/+j2rz5g3BR2N
         9CktZnTvI5hQ+rasVFPGEFODcsTMBf/HnCwEr3jZTI5NGZiPMrgUGs0wYcb7luRjH+11
         TY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760740257; x=1761345057;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aGvnCfkCxuG7nRHD5qS3K0Ns2/mfOtufedzaaye1sE=;
        b=KiQhN+FCuivI3lYzY9zwwIETAJFGpjGGA+bJ/U2D7EXsNLSZZDijYSQGXBtGLWVsD4
         WGyWHrhsIOXup3M1OzVNNqdOyuVrBKEJC5H9p5TnPOHOBJU0WXFTYXMoFGk5c/RzzOGy
         N5leEHAEXH43oOzO3c1ATy3FYSjetkXpZUoDhzMBLwmq9cczExrVhJHeJAkTHgbdjNdx
         FAYqDvOrtBFMbz28dWoY769N7FSsGOaZShVU2WuES6Ac/lm5A527YoWwrMXuCOlkuAdI
         /oJSsLzu9QAsdpdDbO9RKbTN8Mpu/Y3sOAcKGz0UTTER9rGAkSdsi2mGY+2nSIbp7OVw
         2koA==
X-Forwarded-Encrypted: i=1; AJvYcCWHst6U3nf3l+nSFngEk5Z3FcZk+NkUip/f0laStKvpdHBnbAEtgSxgahVzG2V/Re6CyBhXvXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2eS0S5cGnhWEpxtQN+lCAm1qsaYScSlzzFZXc8dT9eoyPQRB
	sI7+5xRBAEvN0He+QqAQb40s8Xu2PLEMm/OkBKZDs5lqBK9evQTCJtO9dGOwNdqwedPVd9Ir1ly
	ooo3SRQ==
X-Google-Smtp-Source: AGHT+IHuhlr6TeDMM+a8D4kE0RCHmOBllgF8IF7LrOLrHYShECDzzqQ+4s+GJlaM19IdbjQW26f4OH4XTqk=
X-Received: from plho8.prod.google.com ([2002:a17:903:23c8:b0:290:d4c5:90ad])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d485:b0:28e:c75e:61d9
 with SMTP id d9443c01a7336-290caf83210mr63165865ad.38.1760740256772; Fri, 17
 Oct 2025 15:30:56 -0700 (PDT)
Date: Fri, 17 Oct 2025 22:30:53 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017223053.2415243-1-jthies@google.com>
Subject: [PATCH v2] usb: typec: ucsi: psy: Set max current to zero when disconnected
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

v2 changes:
- added cc stable tag to commit message

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
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


