Return-Path: <stable+bounces-209471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4336DD26BDE
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2688E3072C26
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE854C81;
	Thu, 15 Jan 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="a4CE9ruh"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E63B530F;
	Thu, 15 Jan 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498790; cv=none; b=qOWeX7s+ASfDmEMcjShgcnWrCwJy5Pl6o+yhOZLrRP6l1t+vDOusSw7mwZ/k4nI6VnBI07gMdAGYB6FB2itm+KJRz1lHTgTyh6nwH5gVeoipMGGsw0wR+EScbzsOXOC2k2HfrBUTpA+BUNgjIv/9+QwVBzbrRviGAZRygXOi+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498790; c=relaxed/simple;
	bh=7G5qJva8kEgcIdql+fopTH00footO5aKLmaDEIgtvtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUN3g+Es+MNK1+93fMvWWEXjer+an5o1mEJBvQ0tv953kvHdCwQn+sCuIb1gb0N7IN30i42VZdBvrl7++DC9koXNn3/htvzTnwNatY3Z23Mnk5BeO2wzuQgF+EYdrXB9VFrAzK7sB8XQSh7PeuSlqTYZVbrtcJOW/YF9aoDC/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=a4CE9ruh; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3091210D986;
	Thu, 15 Jan 2026 18:39:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768498785; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=jJK7/HBQq5iLn2lod1iYqQec69bfPxsnCkgX840p8wA=;
	b=a4CE9ruhNel06QNj+8FwXvI3lS7lRzyRczkFmJqeQ4Kmp7FkgrJNzYt9ErJd7FOo/A+AR1
	V/xM3v0M/evw6ukwTvmhT95qhg4e8A3VnE+zQEoAn03q+XxcMDIGygP53P6abAys84e5BC
	X+8f7f67scYJ6RNN8IyeLXQWPTSt0odettfUMlVrARbVuYZXoStXL4vXNY2BR4aaUVj4Px
	Ha0qsz2KJhw5MJf3JeADwg6vYYhTXJ/iAIgq30SY1Go0YBzqls+o/9bN5Yw3siNCqqmpkm
	NiIwGT+wJHz2LrVOJImOK+re0KECJif6ISPZIGnwP/puyTKEMgJjEDXfL4Xw/A==
From: Marek Vasut <marex@nabladev.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pascal PAILLET-LME <p.paillet@st.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Sean Nyekjaer <sean@geanix.com>,
	kernel@dh-electronics.com
Subject: [PATCH v2] mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
Date: Thu, 15 Jan 2026 18:39:06 +0100
Message-ID: <20260115173943.85764-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Attempt to shut down again, in case the first attempt failed.
The STPMIC1 might get confused and the first regmap_update_bits()
returns with -ETIMEDOUT / -110 . If that or similar transient
failure occurs, try to shut down again. If the second attempt
fails, there is some bigger problem, report it to user.

Cc: stable@vger.kernel.org
Fixes: 6e9df38f359a ("mfd: stpmic1: Add PMIC poweroff via sys-off handler")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Lee Jones <lee@kernel.org>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Nyekjaer <sean@geanix.com>
Cc: kernel@dh-electronics.com
---
V2: - Use a retry loop
    - Cc stable
---
 drivers/mfd/stpmic1.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 081827bc05961..9caf2b8740829 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -121,9 +121,24 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 static int stpmic1_power_off(struct sys_off_data *data)
 {
 	struct stpmic1 *ddata = data->cb_data;
-
-	regmap_update_bits(ddata->regmap, MAIN_CR,
-			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
+	int i, ret;
+
+	for (i = 0; i < 2; i++) {
+		ret = regmap_update_bits(ddata->regmap, MAIN_CR, SOFTWARE_SWITCH_OFF,
+					 SOFTWARE_SWITCH_OFF);
+		if (!ret)
+			return NOTIFY_DONE;
+
+		/*
+		 * Attempt to shut down again, in case the first attempt failed.
+		 * The STPMIC1 might get confused and the first regmap_update_bits()
+		 * returns with -ETIMEDOUT / -110 . If that or similar transient
+		 * failure occurs, try to shut down again. If the second attempt
+		 * fails, there is some bigger problem, report it to user.
+		 */
+		if (i)
+			dev_err(ddata->dev, "Failed to access PMIC I2C bus (%d)\n", ret);
+	}
 
 	return NOTIFY_DONE;
 }
-- 
2.51.0


