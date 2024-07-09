Return-Path: <stable+bounces-58542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B752A92B787
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC4B1C22B43
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F9F158219;
	Tue,  9 Jul 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AduzAIoI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E94158208;
	Tue,  9 Jul 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524252; cv=none; b=hOE+S9fTHaYXMmMMIvHHEeH63G/7wHf4BibsW/VZqhrCm2XNkBMmFqptb6kcAnL8+16okQIUqnAkhhTV4kwWf64KfGhaJWqdnNkzxBOI15GQVL+e45FQJzKaKDQnQ4k7J0/WLdBg2TyHMbs34746jlhrJRs3+KyiIKGRugGMyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524252; c=relaxed/simple;
	bh=yH7oMxNJKe93tgbgGsqZ/sVAAmEKfwnUZN+8DSGDXnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxyyv78NwF919384JlWdXzsPwAxSmeEwae1tOSJhJlsj0Az7Fvp1vxDOsT+186D+2obi6ATWS+cJDl3i5MOLSUZh7WVkC3HG/hE/c3ZHeqi3Ldh5qYSO4Hh30H4Wa7a8a39PJQH1gkrZ/+3H/3dT+HVj5hIyWdjFgSHq0pv+BLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AduzAIoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8010BC3277B;
	Tue,  9 Jul 2024 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524251;
	bh=yH7oMxNJKe93tgbgGsqZ/sVAAmEKfwnUZN+8DSGDXnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AduzAIoI8loiPuOao+0ayNqJGxdZYB7FWMrp2/AsP5ywjcd0ZHNqqZFdiQH/DYIAo
	 URKdyCUHq/3qUdTyv2ocm7f8FEUtwdJx/G33XfYwt4wdsmhfZbyLwem86geDPfr+QR
	 v24+N3o1j7WqPFQqKX4NQkh4k6GPbdWm1Re07oaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.9 121/197] ice: Reject pin requests with unsupported flags
Date: Tue,  9 Jul 2024 13:09:35 +0200
Message-ID: <20240709110713.635305196@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit be2a9d12e6dad894b27361c06ea3752d67a45b49 ]

The driver receives requests for configuring pins via the .enable
callback of the PTP clock object. These requests come into the driver
with flags which modify the requested behavior from userspace. Current
implementation in ice does not reject flags that it doesn't support.
This causes the driver to incorrectly apply requests with such flags as
PTP_PEROUT_DUTY_CYCLE, or any future flags added by the kernel which it
is not yet aware of.

Fix this by properly validating flags in both ice_ptp_cfg_perout and
ice_ptp_cfg_extts. Ensure that we check by bit-wise negating supported
flags rather than just checking and rejecting known un-supported flags.
This is preferable, as it ensures better compatibility with future
kernels.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20240702171459.2606611-4-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 38 ++++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  1 +
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e983e56b342b7..f46d879c62d26 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1612,14 +1612,23 @@ void ice_ptp_extts_event(struct ice_pf *pf)
  * @store: If set to true, the values will be stored
  *
  * Configure an external timestamp event on the requested channel.
+ *
+ * Return: 0 on success, -EOPNOTUSPP on unsupported flags
  */
-static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
-			      struct ice_extts_channel *config, bool store)
+static int ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
+			     struct ice_extts_channel *config, bool store)
 {
 	u32 func, aux_reg, gpio_reg, irq_reg;
 	struct ice_hw *hw = &pf->hw;
 	u8 tmr_idx;
 
+	/* Reject requests with unsupported flags */
+	if (config->flags & ~(PTP_ENABLE_FEATURE |
+			      PTP_RISING_EDGE |
+			      PTP_FALLING_EDGE |
+			      PTP_STRICT_FLAGS))
+		return -EOPNOTSUPP;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	irq_reg = rd32(hw, PFINT_OICR_ENA);
@@ -1660,6 +1669,8 @@ static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
 
 	if (store)
 		memcpy(&pf->ptp.extts_channels[chan], config, sizeof(*config));
+
+	return 0;
 }
 
 /**
@@ -1717,6 +1728,9 @@ static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
 	u32 func, val, gpio_pin;
 	u8 tmr_idx;
 
+	if (config && config->flags & ~PTP_PEROUT_PHASE)
+		return -EOPNOTSUPP;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	/* 0. Reset mode & out_en in AUX_OUT */
@@ -1856,7 +1870,6 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 	bool sma_pres = false;
 	unsigned int chan;
 	u32 gpio_pin;
-	int err;
 
 	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
 		sma_pres = true;
@@ -1885,14 +1898,14 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 			clk_cfg.gpio_pin = chan;
 		}
 
+		clk_cfg.flags = rq->perout.flags;
 		clk_cfg.period = ((rq->perout.period.sec * NSEC_PER_SEC) +
 				   rq->perout.period.nsec);
 		clk_cfg.start_time = ((rq->perout.start.sec * NSEC_PER_SEC) +
 				       rq->perout.start.nsec);
 		clk_cfg.ena = !!on;
 
-		err = ice_ptp_cfg_clkout(pf, chan, &clk_cfg, true);
-		break;
+		return ice_ptp_cfg_clkout(pf, chan, &clk_cfg, true);
 	}
 	case PTP_CLK_REQ_EXTTS:
 	{
@@ -1917,14 +1930,11 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 		extts_cfg.gpio_pin = gpio_pin;
 		extts_cfg.ena = !!on;
 
-		ice_ptp_cfg_extts(pf, chan, &extts_cfg, true);
-		return 0;
+		return ice_ptp_cfg_extts(pf, chan, &extts_cfg, true);
 	}
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return err;
 }
 
 /**
@@ -1937,19 +1947,18 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
 				    struct ptp_clock_request *rq, int on)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
-	int err;
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 	{
 		struct ice_perout_channel clk_cfg = {};
 
+		clk_cfg.flags = rq->perout.flags;
 		clk_cfg.gpio_pin = PPS_PIN_INDEX;
 		clk_cfg.period = NSEC_PER_SEC;
 		clk_cfg.ena = !!on;
 
-		err = ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
-		break;
+		return ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
 	}
 	case PTP_CLK_REQ_EXTTS:
 	{
@@ -1959,14 +1968,11 @@ static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
 		extts_cfg.gpio_pin = TIME_SYNC_PIN_INDEX;
 		extts_cfg.ena = !!on;
 
-		ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
-		return 0;
+		return ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
 	}
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index f1171cdd93c86..e2af9749061ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -29,6 +29,7 @@ enum ice_ptp_pin_e810t {
 struct ice_perout_channel {
 	bool ena;
 	u32 gpio_pin;
+	u32 flags;
 	u64 period;
 	u64 start_time;
 };
-- 
2.43.0




