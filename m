Return-Path: <stable+bounces-158405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BAAE669A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB7D18925E2
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263ED2C08C8;
	Tue, 24 Jun 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/ReQUi3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F8291C35
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771988; cv=none; b=RXRpNRe3wWBIO3scbPHGki7hcC8muS/geGUuujsO1By86UfAjIx7C4NTqupPdGZ+10KBAqc49C6r3layGxREef8eu6i++rOmyuhliSR4CnmWqDeudOS0CrWiFwR/fSGFce+vIMfevPf89NmYXYDEYNVD9JdTW6Eb7l12rFmnnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771988; c=relaxed/simple;
	bh=2aYjxn/XjyqfROJtwhDsYywKfhT/JjZo+9HmvBofW1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BH4gZeNxmOz6ZCOXSOQ1HvhyUhAXIX6xjBxQUZ3ez4c9Qd3zb55Oa3pP2YcyH1orRBteYNXyhh6SieSNx3+/Frpc+/yb8LQ074O038kHEDXbj89dyVANSPEk++j5+s7C/QyUewVJCsqB8cnCZEe9mPLXRPKj8tmTl6jw+IZ30yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K/ReQUi3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad88d77314bso92317166b.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750771985; x=1751376785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tkj6v/oyYjnLDQvdndgBTk2Muh6SQTWgkcZpBQ/t9Hg=;
        b=K/ReQUi3eOOJcY1jqxMDEaPmV8o/99W2V21rfnkTbPHZBkJL70o+rihqgCxoynfV0m
         EwZFTtQXi9Qenv+w4ZKIRfxQYZXycEnsb5dlofEYuDhrljHNypCqQ1TmXCB5Mjvodej5
         05vro4Rk4zdHEv7uC3l0wjr48IgKTuaH5+3/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750771985; x=1751376785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tkj6v/oyYjnLDQvdndgBTk2Muh6SQTWgkcZpBQ/t9Hg=;
        b=dP/+FPKtIo3pJeTw03BGoaNAdly3rgYqe2Rh52xNLYpUtDoHVmgJRm/AYCUqqcNLT6
         3jFCwR3FOeoMxbKnWqK9XnEVsSkFmhVfJu6HZLQKnsKjiUipHs9N8YHFIWsNf2v+0KgH
         xDeRRsOc3kbma8vOfteGBCUc+Z/DI4PEszsr2vvXE3/SdQj0dtcnRwPRwxBfQHFOlEGL
         /nQnx8M8iSo09E2g5vnclF2T/OqRqrASuiqkl3wdzeOOm+EPDhvicRTPr7y5n2vQyMJe
         9SiptrQuM8ZCUalJXoWimQYPSppP8SYXfLM2OSRICZ1p/ISOjT7rW706pbo9pDT35waw
         IKcg==
X-Forwarded-Encrypted: i=1; AJvYcCUPgdjWiJk89TfiZ3iJtBwqJf0dcuSBIZ0k8qAMlGzL4WgdwAruMAyk3NZjyTGjv1ugbJ3hkMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HdCIRVFYaKueHnkT3No+5+q/0upJYqUNoJ4EANLp+ckLeAjE
	v+5uNSGa/Ik7OCmK6/p3t8C+NGmvmUyQhohGydbgRKxhBaPHhSgD9IoT0tEzIqBEoT6nxgAfH7Y
	6ajbXb7Lq
X-Gm-Gg: ASbGncu1MrVSC+uTej7zWY/V8GySUuOGSaSZaf24YAmf3O2OrJzKdbPosEYd2Em0kWo
	Xe9ORJJ5H4Uky0y9BOx/gs7vDXUXEhCNwxp82mPkrvskpHufDOeVjdjdaBpjodtd7SYmKbzdhsx
	qAYokT+Hd3avhK5/8XjhrDu2eHgcBnwh0fQKQU+ubocu5v/+p0I11efsB3TNq/W0HzsC/O26DpU
	Urecr4g9NhxtbD332j0E4DK2DSNMuwis8rvFLB46i9iQC5fjzOvIrVPYdTA1Bf9fWTB9v8Cb/5D
	w6czJUtr/7l8dqvpR4hH6QtWVsWlxm74cyx4bWvudVD3IqNhXCVVay7czb1W31ZlEinCBegFG27
	cASWgiGvhH4lqf80Au9OCPYMua7GFMeYBsPDGK3BDbK8if/tib9gQ
X-Google-Smtp-Source: AGHT+IEe0SD7CtPOT2GsU04+3bSuhfq+kqQCtC4tVp5owq6ZynhgbyzhdLvK/T4ZiLjHJSHP8BIZCw==
X-Received: by 2002:a17:907:948a:b0:ade:bf32:b05a with SMTP id a640c23a62f3a-ae0576a05f2mr1363893566b.0.1750771985028;
        Tue, 24 Jun 2025 06:33:05 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (72.144.91.34.bc.googleusercontent.com. [34.91.144.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0f5sm888265966b.59.2025.06.24.06.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 06:33:04 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jos Wang <joswang@lenovo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: displayport: Fix potential deadlock
Date: Tue, 24 Jun 2025 13:32:46 +0000
Message-ID: <20250624133246.3936737-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deadlock can occur due to a recursive lock acquisition of
`cros_typec_altmode_data::mutex`.
The call chain is as follows:
1. cros_typec_altmode_work() acquires the mutex
2. typec_altmode_vdm() -> dp_altmode_vdm() ->
3. typec_altmode_exit() -> cros_typec_altmode_exit()
4. cros_typec_altmode_exit() attempts to acquire the mutex again

To prevent this, defer the `typec_altmode_exit()` call by scheduling
it rather than calling it directly from within the mutex-protected
context.

Cc: stable@vger.kernel.org
Fixes: b4b38ffb38c9 ("usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/altmodes/displayport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index b09b58d7311d..2abbe4de3216 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -394,8 +394,7 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 	case CMDT_RSP_NAK:
 		switch (cmd) {
 		case DP_CMD_STATUS_UPDATE:
-			if (typec_altmode_exit(alt))
-				dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
+			dp->state = DP_STATE_EXIT;
 			break;
 		case DP_CMD_CONFIGURE:
 			dp->data.conf = 0;
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


