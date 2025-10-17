Return-Path: <stable+bounces-187220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D840DBEAACE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013AE9438DB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70632E144;
	Fri, 17 Oct 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ec4ERuhv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAE335068;
	Fri, 17 Oct 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715456; cv=none; b=QBhQKqeAPcmq2LAwCrW04cXWa70Lw/vD2V5TklIUsTSzJYzLC8T5Xgq/iR3nAyvE48obWg4w23LOwUH/CeraY4c4SXln6c0lXG3e/PlXqSTWRTRkO3bQc6Ow9cHM1rvGVFGh6w7vE4MS0WYFmfO6RFXQZ0ia5/z+nVgQuawYxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715456; c=relaxed/simple;
	bh=TrGMOE+OiE5qInsZzlaG6RXBDVmNohLPhRWBtlKHkCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5+W5vRFXbXKPMvW+qptWBDjHRHJY9ae/UGHnPFR4mMjN0AoK8zppCQb/GnQlJTNgiNrQEsL8yYJ0rNREf94977Ou0706SdM0A8IsgkPhPNsmLjdOJfI+fPshYb4NwqJBqWvdR8dHuW/RnRtD2jRzG7cFO+Z6Cw3jmm6lm48IgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ec4ERuhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FCCC4CEE7;
	Fri, 17 Oct 2025 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715455;
	bh=TrGMOE+OiE5qInsZzlaG6RXBDVmNohLPhRWBtlKHkCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ec4ERuhvCZNCbPUpxQmctVvZiJEEz7XsTyVEy/M4pjG1GzalN1RKrj+bkoo7J/pmG
	 Mo4tAaZQjBe4wYeBvn6zFCmdGxSkt53mP1XxKsd+IeoMcOhXvCeGt2zj8/gGsg2NUn
	 ysWNjowhWBWzCESjcINoDHIfxsam31mz6+MwsbeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.17 222/371] iio: frequency: adf4350: Fix prescaler usage.
Date: Fri, 17 Oct 2025 16:53:17 +0200
Message-ID: <20251017145210.118600071@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Hennerich <michael.hennerich@analog.com>

commit 33d7ecbf69aa7dd4145e3b77962bcb8759eede3d upstream.

The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/9.
When set to 4/5, the maximum RF frequency allowed is 3 GHz.
Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/9.
In this context not the RF output frequency is meant
- it's the VCO frequency.

Therefore move the prescaler selection after we derived the VCO frequency
from the desired RF output frequency.

This BUG may have caused PLL lock instabilities when operating the VCO at
the very high range close to 4.4 GHz.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250829-adf4350-fix-v2-1-0bf543ba797d@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/frequency/adf4350.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -149,6 +149,19 @@ static int adf4350_set_freq(struct adf43
 	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
 		return -EINVAL;
 
+	st->r4_rf_div_sel = 0;
+
+	/*
+	 * !\TODO: The below computation is making sure we get a power of 2
+	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
+	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
+	 * and friends.
+	 */
+	while (freq < ADF4350_MIN_VCO_FREQ) {
+		freq <<= 1;
+		st->r4_rf_div_sel++;
+	}
+
 	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
 		prescaler = ADF4350_REG1_PRESCALER;
 		mdiv = 75;
@@ -157,13 +170,6 @@ static int adf4350_set_freq(struct adf43
 		mdiv = 23;
 	}
 
-	st->r4_rf_div_sel = 0;
-
-	while (freq < ADF4350_MIN_VCO_FREQ) {
-		freq <<= 1;
-		st->r4_rf_div_sel++;
-	}
-
 	/*
 	 * Allow a predefined reference division factor
 	 * if not set, compute our own



