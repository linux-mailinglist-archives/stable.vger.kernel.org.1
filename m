Return-Path: <stable+bounces-48314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3B8FE879
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04459281575
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E1196C8E;
	Thu,  6 Jun 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tUZPKKAo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77677196C92;
	Thu,  6 Jun 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682898; cv=none; b=pBqu4NyHWlFnKpQOyfT8FskllOeG0ciyDvMXF+CTfE7NJ2q/bEfty6jUzT0sSYR7FMXOSQHeuU9DAwjB/5a0B+poIkZ1NVLOPade1OeHYF076A2KCV1lABuzEoGZ4RCrcd+PjbeX6vlOC4NsOQjYzihXHLgjgUlPdm14FPhP0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682898; c=relaxed/simple;
	bh=d6oUuIiSH5RIYtrIX59soETYUps3fsid7bteCaPRqKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhmH1FxY0SDqVFaYV0j4Bz7JR4ZdgZ1i/QEW5V05kWtHHxougTxrol48qR3ALFehRhyNApS6azHvcZi/Ay6VZz7+FL7BcHNT8xuQcrNgSEAPN9a9xyurlN5O9Wq3W+/DbC5MFLkDzKTqHyJVNgWkiEp4km8kKraaljwb1B8n9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tUZPKKAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8F9C32781;
	Thu,  6 Jun 2024 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682898;
	bh=d6oUuIiSH5RIYtrIX59soETYUps3fsid7bteCaPRqKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUZPKKAoP+fA2kZYX0VJuvA0uiyu8kAOr3ptAxhijbU62KC1Vwic40ShNZqRPZ7ql
	 oqJwLfBrdZuwx/F8ZVWc6VcIhWI9w12W27ScN/mEoekZ4nhvv0WsRej6TGUZozhuEf
	 G/NlQTBEB/t0Xe1UncpRGRu+7g7l88hj/whIGNX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tengfei Fan <quic_tengfan@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 007/374] dt-bindings: pinctrl: qcom: update functions to match with driver
Date: Thu,  6 Jun 2024 15:59:46 +0200
Message-ID: <20240606131651.967564842@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

From: Tengfei Fan <quic_tengfan@quicinc.com>

[ Upstream commit 842ecb5fcf8de17dfde11d4ec5f41930f0076887 ]

Some functions were consolidated in the SM4450 pinctrl driver, but they
had not been updated in the binding file before the previous SM4450
pinctrl patch series was merged.
Update functions in this binding file to match with SM4450 pinctrl
driver. Some functions need to be consolidated and some functions need
to be removed.
The following functions are removed:
  - atest_char0, atest_char1, atest_char2, atest_char3
  - atest_usb00, atest_usb01, atest_usb02, atest_usb03
  - audio_ref
  - cci_async
  - cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4
  - cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3
  - coex_uart1
  - cri_trng0, cri_trng1
  - dbg_out
  - ddr_pxi0, ddr_pxi1
  - dp0_hot
  - gcc_gp1, gcc_gp2, gcc_gp3
  - ibi_i3c
  - jitter_bist
  - mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3
  - mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s2_data0,
    mi2s2_data1, mi2s2_sck, mi2s2_ws, mi2s_mclk0, mi2s_mclk1
  - nav_gpio0, nav_gpio1, nav_gpio2
  - phase_flag0, phase_flag1, phase_flag10, phase_flag11, phase_flag12,
    phase_flag13, phase_flag14, phase_flag15, phase_flag16,
    phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
    phase_flag21, phase_flag22, phase_flag23, phase_flag24,
    phase_flag25, phase_flag26, phase_flag27, phase_flag28,
    phase_flag29, phase_flag3, phase_flag30, phase_flag31, phase_flag4,
    phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9
  - pll_bist, pll_clk
  - prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3
  - qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12,
    qdss_gpio13, qdss_gpio14, qdss_gpio15, qdss_gpio2, qdss_gpio3,
    qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7, qdss_gpio8,
    qdss_gpio9
  - qlink0_wmss
  - qup0_se5, qup0_se6, qup0_se7, qup1_se5, qup1_se6
  - sd_write
  - tb_trig
  - tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3
  - tmess_prng0, tmess_prng1, tmess_prng2, tmess_prng3
  - tsense_pwm1, tsense_pwm2
  - uim0_clk, uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
    uim1_present, uim1_reset
  - usb0_hs, usb0_phy
  - vsense_trigger

The following functions are added:
  - atest_char
  - atest_usb0
  - audio_ref_clk
  - cci
  - cci_async_in0
  - cmu_rng
  - coex_uart1_rx, coex_uart1_tx
  - dbg_out_clk
  - ddr_pxi0_test, ddr_pxi1_test
  - gcc_gp1_clk, gcc_gp2_clk, gcc_gp3_clk
  - ibi_i3c_qup0, ibi_i3c_qup1
  - jitter_bist_ref
  - mdp_vsync
  - nav
  - phase_flag
  - pll_bist_sync, pll_clk_aux
  - prng_rosc
  - qlink0_wmss_reset
  - sd_write_protect
  - tb_trig_sdc1, tb_trig_sdc2
  - tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout, tgu_ch3_trigout
  - tmess_prng
  - tsense_pwm1_out, tsense_pwm2_out
  - uim0, uim1
  - usb0_hs_ac, usb0_phy_ps
  - vsense_trigger_mirnat
  - wlan1_adc_dtest0, wlan1_adc_dtest1

Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Message-ID: <20240312025807.26075-3-quic_tengfan@quicinc.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 52 +++++++------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
index bb675c8ec220f..1b941b276b3f8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
@@ -72,40 +72,24 @@ $defs:
         description:
           Specify the alternative function to be configured for the specified
           pins.
-        enum: [ gpio, atest_char, atest_char0, atest_char1, atest_char2,
-                atest_char3, atest_usb0, atest_usb00, atest_usb01, atest_usb02,
-                atest_usb03, audio_ref, cam_mclk, cci_async, cci_i2c,
-                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
-                cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, cri_trng,
-                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
-                dp0_hot, gcc_gp1, gcc_gp2, gcc_gp3, host2wlan_sol, ibi_i3c,
-                jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
-                mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws,
-                mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, mi2s_mclk0,
-                mi2s_mclk1, nav_gpio0, nav_gpio1, nav_gpio2, pcie0_clk,
-                phase_flag0, phase_flag1, phase_flag10, phase_flag11,
-                phase_flag12, phase_flag13, phase_flag14, phase_flag15,
-                phase_flag16, phase_flag17, phase_flag18, phase_flag19,
-                phase_flag2, phase_flag20, phase_flag21, phase_flag22,
-                phase_flag23, phase_flag24, phase_flag25, phase_flag26,
-                phase_flag27, phase_flag28, phase_flag29, phase_flag3,
-                phase_flag30, phase_flag31, phase_flag4, phase_flag5,
-                phase_flag6, phase_flag7, phase_flag8, phase_flag9,
-                pll_bist, pll_clk, prng_rosc0, prng_rosc1, prng_rosc2,
-                prng_rosc3, qdss_cti, qdss_gpio, qdss_gpio0, qdss_gpio1,
-                qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
-                qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5,
-                qdss_gpio6, qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink0_enable,
-                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
-                qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss,
-                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4, qup0_se5,
-                qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3,
-                qup1_se4, qup1_se5, qup1_se6, sd_write, tb_trig, tgu_ch0,
-                tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
-                tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk,
-                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
-                uim1_present, uim1_reset, usb0_hs, usb0_phy, vfr_0, vfr_1,
-                vsense_trigger ]
+        enum: [ gpio, atest_char, atest_usb0, audio_ref_clk, cam_mclk,
+                cci_async_in0, cci_i2c, cci, cmu_rng, coex_uart1_rx,
+                coex_uart1_tx, cri_trng, dbg_out_clk, ddr_bist,
+                ddr_pxi0_test, ddr_pxi1_test, gcc_gp1_clk, gcc_gp2_clk,
+                gcc_gp3_clk, host2wlan_sol, ibi_i3c_qup0, ibi_i3c_qup1,
+                jitter_bist_ref, mdp_vsync0_out, mdp_vsync1_out,
+                mdp_vsync2_out, mdp_vsync3_out, mdp_vsync, nav,
+                pcie0_clk_req, phase_flag, pll_bist_sync, pll_clk_aux,
+                prng_rosc, qdss_cti_trig0, qdss_cti_trig1, qdss_gpio,
+                qlink0_enable, qlink0_request, qlink0_wmss_reset,
+                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4,
+                qup1_se0, qup1_se1, qup1_se2, qup1_se2_l2, qup1_se3,
+                qup1_se4, sd_write_protect, tb_trig_sdc1, tb_trig_sdc2,
+                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
+                tgu_ch3_trigout, tmess_prng, tsense_pwm1_out,
+                tsense_pwm2_out, uim0, uim1, usb0_hs_ac, usb0_phy_ps,
+                vfr_0_mira, vfr_0_mirb, vfr_1, vsense_trigger_mirnat,
+                wlan1_adc_dtest0, wlan1_adc_dtest1 ]
 
         required:
           - pins
-- 
2.43.0




