Return-Path: <stable+bounces-110313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F22BA1A8EC
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2161887AA6
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA454142E6F;
	Thu, 23 Jan 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J83qGHwN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F513DDD3
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653244; cv=none; b=BtB60mtkaIJ7xht6bP5xE28H0ljzMi2fJ1c+ZRgbOkXpDpQbmWf8THbcnP0z1lWv4OrQ+XESjnrVYwJk1zTEFgkx/K9+sUTj8NV8QUkoIZ5QNpO/OPZpbZTdCQ9gr0FhKiok73QAd1ZHdLbHZ+AsfS4t0HYUo5x68wf1e2pz5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653244; c=relaxed/simple;
	bh=5VcL1KJGY48tpjWVdAmlb3DjPOdtc97/ATAxZx5gYXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dxdhscLQ6cvbVu4Kvk/pp7h6ibliZgSfG5Dqy0fMbOEPDrcCJ7XE5V61gwNvoAyxp7TKiYfmHflyMOR1vMs8Zn/JMfADwjsiOcnF3HsqaxPf0B4WkEgPzrYU5mdcWKLlsTm58f6ma8F14onjpHmtpxjLJ42mSIbLRMO6PhG9OxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J83qGHwN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa679ad4265so467198966b.0
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 09:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737653240; x=1738258040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OW4Kcq4MU1554DBuiBZTdsTL2Qlr9Xu/MuxWp82QmXc=;
        b=J83qGHwN/tAIY3I3Yk4nsg8777YWRg5sBEbL53VALz5QuxcyqkcL1+PiA5dHc6yzDs
         TWn9xbpsIbMYiqq8TOiHoRHRdPszcofPe5bXjMNUMiUPYAkvzr3+U9aFMlEG6nfhMSNx
         iahhksERYk+uscg05CbqltKhzKE+3myI/3WqT+WjzyWlb/bfrt0Zg3LpYiMPnExSbAfL
         wwnDRcXAA8aGCfkN0bEoIZeSduMbuyOXXtAP+M/FFdTKsh6j7fkJfLD/t3Qc08p/tLbK
         gKyCXlXvHpo2UBL4/9KVQrsCD2iyRhmGDkgl85mhNRdgV9Bo9JUx9g5Z+IluzsKpTe5O
         3TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653240; x=1738258040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OW4Kcq4MU1554DBuiBZTdsTL2Qlr9Xu/MuxWp82QmXc=;
        b=ZxOc8RHmXxgb0ef2Gy/knQ2VcYXleCfy8yrRcZB7RdRrozjow392g5/8/MXcrBEo6b
         BQkpSF1NrEicyF0M4nMOhzj36wNZkqMdfy4AhgTyVSl4m9kHBwOC6FhnMIcQO1wNsQt+
         T+rb3vSXhCU10PDTK6SlmlRGZLrNKs62DUo7tFj9JqXT4IQY9aCnSb1m7xUsaeaLsygT
         X7h+6uQj26/go6aVonXqNpRHOtUqIMumX6l/zOEhtuhO7b1gaF1FAyHfnC2Gejv8+GvD
         z7O5NDiE9FxC99p5b+g6iN5GTdOSroTtZbutoRME8VFGjKFk34ix0ZV5hxRf6MyrI8ow
         MMIw==
X-Gm-Message-State: AOJu0YzcAppeuoziiqdLQGFaY8GvQsq3HsU0NRBqHqqZi0nrqFs65oDB
	0o5VptHD5yo0sD/4TWkt3rv6ZSd41GBN2snb9Ip1ga/GAYLZaKoJAWyaEriA8CU=
X-Gm-Gg: ASbGncud7liXMJm4SnLFO8VkCtt52OPClqa978MY6rPylUewJAR4tGcvI/L9NGUR+a0
	H3GMXx3PHSJseLD2N+PnXeSaUv17YTPPg13CxG/UKyP5UddkK/aa03zXG7t4fatEHnbYpU+eafe
	UK51zS+J3FgMAi8w5ju0r+D6G9x+LU2Cg1QtltwgtDC0CfDE2HZi2RfhimOrL1OC0Ggfb1bhSe6
	nT2Up004FP9FCLZCHTAUFtyi/yLfFUVi97EbdmkmFXUE25OXe6g5Rx8VF9QBM4xP3XxLN92x/Lw
	BCedTT7AuHzmUFngQKfWGLqYRcy2+St+FN5J4zicE7Izdsw=
X-Google-Smtp-Source: AGHT+IG+rMtYPI9i1zGELP9CcOm9R4pDZpJOWL7R/bF86HgB0WzYRRkQA427ujy0zDS/T/UeAP/jTA==
X-Received: by 2002:a17:907:7b96:b0:ab6:36fe:4c73 with SMTP id a640c23a62f3a-ab6745c45dfmr14901666b.10.1737653239936;
        Thu, 23 Jan 2025 09:27:19 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c60751sm1096903666b.30.2025.01.23.09.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:27:19 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pwm: Ensure callbacks exist before calling them
Date: Thu, 23 Jan 2025 18:27:07 +0100
Message-ID: <20250123172709.391349-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=5VcL1KJGY48tpjWVdAmlb3DjPOdtc97/ATAxZx5gYXE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvRJ1W+fF+8Lzbn3uFyBycctu+JRcZ+r3ZKUa7PYbyftd 1h4ly25k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ+E7nYOh+HWDcNVOk4dW6 5kaGDd90H1tJhM9/1dhUXOPoaW3+icl2gk34ltvV8w43dD8ptZSao1HEqLJ9K/Nxgc/uGbI1JS6 PMn9ZHJQ7Ux/76VSTm9lD26Orrc9q8jAZLWvfbp8xn+nMgQ+nrUWD1nkG3Gm61vi8m8Eg3vr2Jn mFz39Os2zt0eMQmqfwa+8tVuksd6VP21sSe6a0+S97pi3BqmkjMp33+a3Q6gh7MdXljBMtmQ4Yn C+7J/pxKp+Ad/URCz6L1NeFt7aqm3+0PcgUwVQ634iN0UDESEFoe2a5udSkjUeK45lu6W7luV10 hv37C/XG63vW6//Onmq/JOSw+OJ/ulNWWInEPzyRMe0mAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If one of the waveform functions is called for a chip that only supports
.apply(), we want that an error code is returned and not a NULL pointer
exception.

Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for waveforms")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

assuming nobody spots a problem I will send this patch to Linus next week for
inclusion in -rc1.

Best regards
Uwe

 drivers/pwm/core.c  | 13 +++++++++++--
 include/linux/pwm.h | 17 +++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9c733877e98e..1a36ee3cab91 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -242,6 +242,9 @@ int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
+	if (!pwmchip_supports_waveform(chip))
+		return -EOPNOTSUPP;
+
 	if (!pwm_wf_valid(wf))
 		return -EINVAL;
 
@@ -294,6 +297,9 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
+	if (!pwmchip_supports_waveform(chip) || !ops->read_waveform)
+		return -EOPNOTSUPP;
+
 	guard(pwmchip)(chip);
 
 	if (!chip->operational)
@@ -320,6 +326,9 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
+	if (!pwmchip_supports_waveform(chip))
+		return -EOPNOTSUPP;
+
 	if (!pwm_wf_valid(wf))
 		return -EINVAL;
 
@@ -592,7 +601,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	    state->usage_power == pwm->state.usage_power)
 		return 0;
 
-	if (ops->write_waveform) {
+	if (pwmchip_supports_waveform(chip)) {
 		struct pwm_waveform wf;
 		char wfhw[WFHWSIZE];
 
@@ -746,7 +755,7 @@ int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 	if (!chip->operational)
 		return -ENODEV;
 
-	if (ops->read_waveform) {
+	if (pwmchip_supports_waveform(chip) && ops->read_waveform) {
 		char wfhw[WFHWSIZE];
 		struct pwm_waveform wf;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 78827f312407..b8d78009e779 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -347,6 +347,23 @@ struct pwm_chip {
 	struct pwm_device pwms[] __counted_by(npwm);
 };
 
+/**
+ * pwmchip_supports_waveform() - checks if the given chip supports waveform callbacks
+ * @chip: The pwm_chip to test
+ *
+ * Returns true iff the pwm chip support the waveform functions like
+ * pwm_set_waveform_might_sleep() and pwm_round_waveform_might_sleep()
+ */
+static inline bool pwmchip_supports_waveform(struct pwm_chip *chip)
+{
+	/*
+	 * only check for .write_waveform(). If that is available,
+	 * .round_waveform_tohw() and .round_waveform_fromhw() asserted to be
+	 * available, too, in pwmchip_add().
+	 */
+	return chip->ops->write_waveform != NULL;
+}
+
 static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
 {
 	return chip->dev.parent;

base-commit: e8c59791ebb60790c74b2c3ab520f04a8a57219a
prerequisite-patch-id: f5f481d393ddd1fd20a685c86cd4e93dd40d26c7
-- 
2.47.1


