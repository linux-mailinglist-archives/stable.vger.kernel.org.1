Return-Path: <stable+bounces-211222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLAaF2wUcmksawAAu9opvQ
	(envelope-from <stable+bounces-211222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:13:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196F667A3
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B7FC70B819
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D2034FF7D;
	Thu, 22 Jan 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="jVNCIP4z"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7943CEF8;
	Thu, 22 Jan 2026 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080470; cv=none; b=oUkQiYXyTtaH58f2iWKTyqlVUtCLIjqN4PfblmR1VemuXVjweGGnyI/aU0czZj+d8Bcz9Ybd8/kMxb/5RhO11s75ojYDsPHo8Rm+JbHV+mCfzxiHcFT9lCYkMn3rZqjUjxhIenFzTprqQtLjc+OZiad8TIatE3S15TDaUn4l6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080470; c=relaxed/simple;
	bh=KMXnHjcVP+Dic9ae46yMQMb2pqnDQPcVbnMbRIY5KIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=So1IwzBt0YrsDly2f9PDv3cqqy6qzLeKNQvu1qXwlPDtoWTFiZPE0P/+O5cUz/Jl+4MNQX+KHEMrlLEeO+B2XwPXdJC7bAVtrKfAOj01F/4iRXIPvKDaLLuBwLnNTjbwiuwScc7KFtdDgTKLi8WAcuVTYGAKbSv363xZtujaUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=jVNCIP4z; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D485F101EFF;
	Thu, 22 Jan 2026 12:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769080466; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=tSEU4Qn5141dWvsEb87q1JsnC2fOoJgbp7RUPUGNmek=;
	b=jVNCIP4zo22LfCciLLlDb71ztcCbet1ihmNKqgTtsX++BA4GeXy+fFwjSZlhFc521slrl4
	7a/tO+fMwX1zn8Uq7SbXBiauv4vlT2hLpD6tu+s+r2Vg+BJBmYH7VbVIY7B92oM9fRsHip
	fn1cCsY/oBHGSfGoMZ4x56uoLnW3tpsgWUehwFDbWf1I2RE98DlPq05YzofeQrGD+3NQiU
	KUjmAEUCUW2qUD1osj8FTyK0nv8rBMRNvF8OhJSkX8SCMsdGN17OwabPSWRnPVwYK1NBt3
	JoRbjkZoPnZK3A0StKnphpC0xhTbpSB2ZTGV6L8ljpKILfqq2fsS1WO/dmsM1w==
From: Marek Vasut <marex@nabladev.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pascal PAILLET-LME <p.paillet@st.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Sean Nyekjaer <sean@geanix.com>,
	kernel@dh-electronics.com
Subject: [PATCH v3] mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
Date: Thu, 22 Jan 2026 12:13:21 +0100
Message-ID: <20260122111423.62591-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-211222-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nabladev.com,reject];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,nabladev.com:dkim,nabladev.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,dh-electronics.com:email,geanix.com:email]
X-Rspamd-Queue-Id: 2196F667A3
X-Rspamd-Action: no action

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
V3: Adjust the loop further, define STPMIC1_MAX_RETRIES, rename
    the loop control variable, print error message only when the
    loop ran STPMIC1_MAX_RETRIES times
---
 drivers/mfd/stpmic1.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 081827bc05961..7c677b0344c60 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -16,6 +16,8 @@
 
 #include <dt-bindings/mfd/st,stpmic1.h>
 
+#define STPMIC1_MAX_RETRIES 2
+
 #define STPMIC1_MAIN_IRQ 0
 
 static const struct regmap_range stpmic1_readable_ranges[] = {
@@ -121,9 +123,23 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 static int stpmic1_power_off(struct sys_off_data *data)
 {
 	struct stpmic1 *ddata = data->cb_data;
+	int ret;
+
+	/*
+	 * Attempt to shut down again, in case the first attempt failed.
+	 * The STPMIC1 might get confused and the first regmap_update_bits()
+	 * returns with -ETIMEDOUT / -110 . If that or similar transient
+	 * failure occurs, try to shut down again. If the second attempt
+	 * fails, there is some bigger problem, report it to user.
+	 */
+	for (int retries = 0; retries < STPMIC1_MAX_RETRIES; retries++) {
+		ret = regmap_update_bits(ddata->regmap, MAIN_CR, SOFTWARE_SWITCH_OFF,
+					 SOFTWARE_SWITCH_OFF);
+		if (!ret)
+			return NOTIFY_DONE;
+	}
 
-	regmap_update_bits(ddata->regmap, MAIN_CR,
-			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
+	dev_err(ddata->dev, "Failed to access PMIC I2C bus (%d)\n", ret);
 
 	return NOTIFY_DONE;
 }
-- 
2.51.0


