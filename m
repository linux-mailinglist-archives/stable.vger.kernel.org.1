Return-Path: <stable+bounces-88914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2909B280D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AF3B2131D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963B18EFF1;
	Mon, 28 Oct 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfTtJwTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826718EFEB;
	Mon, 28 Oct 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098408; cv=none; b=eRvMbbMOPdsepyt5zzlgjTRpAzeqfS/9Q65z+YxtrJ8QYEukIcWzBVTnKKNpD0y19ZivQIc/QMTyrbvPDXQjkPqTLMYnev7RnNJEyVDX8hiDZjckjXtBeCWFrvDhbjpRXh4RPuOGomJIvjSSvDsZbvD7XO8iggQ2ejbVaUzdsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098408; c=relaxed/simple;
	bh=jhOFO7AYf8x33NcQ8G8q+x++CAwEIlXSGTRRpqCaAqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzYAD6EkPsJt9xMWPIV2ct57WuPTwLWDsCMA7SGY0Ba9aUzyM8d3OPN3zOg4WCX/ylVwQySpi/q63Q7JkiWIM+EZPS0C194IVKP0ufrLLnrsapr9PFsbT4o25NUGJrDoTtASJybzUc+f7BaEq8sJVaK5mmhI4dJicR9ZADZR7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KfTtJwTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD93DC4CEC3;
	Mon, 28 Oct 2024 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098408;
	bh=jhOFO7AYf8x33NcQ8G8q+x++CAwEIlXSGTRRpqCaAqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KfTtJwTx7a/3F/R7vdBipG38X4K7jWHu+/v/J/vVZT+RrZkGYdvW8vb4jBbhlN9wQ
	 tkti2XTm0YRiBTJYIgvEH54C2U4bFTyWM0TUqZn4oHLVJl9BclYeYMLXdKoqqEDnxs
	 QchMj/iiMvaVdpesyDzuURSeUuFMkLeaNkoDbGh4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Shenghao Yang <me@shenghaoyang.info>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 178/261] net: dsa: mv88e6xxx: read cycle counter period from hardware
Date: Mon, 28 Oct 2024 07:25:20 +0100
Message-ID: <20241028062316.467481553@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shenghao Yang <me@shenghaoyang.info>

[ Upstream commit 7e3c18097a709e9b958e721066e5fe76e563739b ]

Instead of relying on a fixed mapping of hardware family to cycle
counter frequency, pull this information from the
MV88E6XXX_TAI_CLOCK_PERIOD register.

This lets us support switches whose cycle counter frequencies depend on
board design.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 60 ++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 1d003a9deafa7..a546822408396 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -409,6 +409,7 @@ struct mv88e6xxx_chip {
 	struct cyclecounter	tstamp_cc;
 	struct timecounter	tstamp_tc;
 	struct delayed_work	overflow_work;
+	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 
 	struct ptp_clock	*ptp_clock;
 	struct ptp_clock_info	ptp_clock_info;
@@ -732,7 +733,6 @@ struct mv88e6xxx_ptp_ops {
 	int arr1_sts_reg;
 	int dep_sts_reg;
 	u32 rx_filters;
-	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 };
 
 struct mv88e6xxx_pcs_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 641af44e00af9..a409b8661fadd 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -32,10 +32,10 @@ struct mv88e6xxx_cc_coeffs {
  * simplifies to
  * clkadj = scaled_ppm * 2^7 / 5^5
  */
-#define MV88E6250_CC_SHIFT 28
-static const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
-	.cc_shift = MV88E6250_CC_SHIFT,
-	.cc_mult = 10 << MV88E6250_CC_SHIFT,
+#define MV88E6XXX_CC_10NS_SHIFT 28
+static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
+	.cc_shift = MV88E6XXX_CC_10NS_SHIFT,
+	.cc_mult = 10 << MV88E6XXX_CC_10NS_SHIFT,
 	.cc_mult_num = 1 << 7,
 	.cc_mult_dem = 3125ULL,
 };
@@ -47,10 +47,10 @@ static const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
  * simplifies to
  * clkadj = scaled_ppm * 2^9 / 5^6
  */
-#define MV88E6XXX_CC_SHIFT 28
-static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_coeffs = {
-	.cc_shift = MV88E6XXX_CC_SHIFT,
-	.cc_mult = 8 << MV88E6XXX_CC_SHIFT,
+#define MV88E6XXX_CC_8NS_SHIFT 28
+static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
+	.cc_shift = MV88E6XXX_CC_8NS_SHIFT,
+	.cc_mult = 8 << MV88E6XXX_CC_8NS_SHIFT,
 	.cc_mult_num = 1 << 9,
 	.cc_mult_dem = 15625ULL
 };
@@ -96,6 +96,31 @@ static int mv88e6352_set_gpio_func(struct mv88e6xxx_chip *chip, int pin,
 	return chip->info->ops->gpio_ops->set_pctl(chip, pin, func);
 }
 
+static const struct mv88e6xxx_cc_coeffs *
+mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
+{
+	u16 period_ps;
+	int err;
+
+	err = mv88e6xxx_tai_read(chip, MV88E6XXX_TAI_CLOCK_PERIOD, &period_ps, 1);
+	if (err) {
+		dev_err(chip->dev, "failed to read cycle counter period: %d\n",
+			err);
+		return ERR_PTR(err);
+	}
+
+	switch (period_ps) {
+	case 8000:
+		return &mv88e6xxx_cc_8ns_coeffs;
+	case 10000:
+		return &mv88e6xxx_cc_10ns_coeffs;
+	default:
+		dev_err(chip->dev, "unexpected cycle counter period of %u ps\n",
+			period_ps);
+		return ERR_PTR(-ENODEV);
+	}
+}
+
 static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
@@ -217,7 +242,6 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	int neg_adj = 0;
 	u32 diff, mult;
 	u64 adj;
@@ -227,10 +251,10 @@ static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 		scaled_ppm = -scaled_ppm;
 	}
 
-	mult = ptp_ops->cc_coeffs->cc_mult;
-	adj = ptp_ops->cc_coeffs->cc_mult_num;
+	mult = chip->cc_coeffs->cc_mult;
+	adj = chip->cc_coeffs->cc_mult_num;
 	adj *= scaled_ppm;
-	diff = div_u64(adj, ptp_ops->cc_coeffs->cc_mult_dem);
+	diff = div_u64(adj, chip->cc_coeffs->cc_mult_dem);
 
 	mv88e6xxx_reg_lock(chip);
 
@@ -377,7 +401,6 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
@@ -401,7 +424,6 @@ const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6250_cc_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
@@ -425,7 +447,6 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
@@ -450,7 +471,6 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs,
 };
 
 static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
@@ -485,11 +505,15 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	int i;
 
 	/* Set up the cycle counter */
+	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
+	if (IS_ERR(chip->cc_coeffs))
+		return PTR_ERR(chip->cc_coeffs);
+
 	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
 	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
 	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
-	chip->tstamp_cc.mult	= ptp_ops->cc_coeffs->cc_mult;
-	chip->tstamp_cc.shift	= ptp_ops->cc_coeffs->cc_shift;
+	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
+	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;
 
 	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc,
 			 ktime_to_ns(ktime_get_real()));
-- 
2.43.0




