Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479172C0BA
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjFLKyR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbjFLKyE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C8425A1C
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49F8B612F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD89C433D2;
        Mon, 12 Jun 2023 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566356;
        bh=//s1/Y9TiccQV7CdfuHHEuhwSTnzvmeM0oOHHbjQ/Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxkqnYF3Ue7GpGe/vhmptPscD6OxYBZMafej/zK9ZM2zvjdzqdYR0/OdUF7o2fc/N
         ouu5gWxKvsA1SVmmrMO02wG7ut7hJjE08yFsnAgFfkJ2LdQdu4zFmfP404fAWbuAlU
         EqUDXt6COOamo+TOPXgjS0Mn6apM//zngWUGwruc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 73/91] arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards
Date:   Mon, 12 Jun 2023 12:27:02 +0200
Message-ID: <20230612101705.114123869@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 3a735530c159b75e1402c08abe1ba4eb99a1f7a3 ]

In general, the three SKUs of sc7180 (lite, normal, and pro) are
handled dynamically.

The cpufreq table in sc7180.dtsi includes the superset of all CPU
frequencies. The "qcom-cpufreq-hw" driver in Linux shows that we can
dynamically detect which frequencies are actually available on the
currently running CPU and then we can just enable those ones.

The GPU is similarly dynamic. The nvmem has a fuse in it (see
"gpu_speed_bin" in sc7180.dtsi) that the GPU driver can use to figure
out which frequencies to enable.

There is one part, however, that is not so dynamic. The way SDRAM
frequency works in sc7180 is that it's tied to cpufreq. At the busiest
cpufreq operating points we'll pick the top supported SDRAM frequency.
They ramp down together.

For the "pro" SKU of sc7180, we only enable one extra cpufreq step.
That extra cpufreq step runs SDRAM at the same speed as the step
below. Thus, for normal and pro things are OK. There is no sc7180-pro
device tree snippet.

For the "lite" SKU if sc7180, however, things aren't so easy. The
"lite" SKU drops 3 cpufreq entries but can still run SDRAM at max
frequency. That messed things up with the whole scheme. This is why we
added the "sc7180-lite" fragment in commit 8fd01e01fd6f ("arm64: dts:
qcom: sc7180-lite: Tweak DDR/L3 scaling on SC7180-lite").

When the lite scheme came about, it was agreed that the WiFi SKUs of
lazor would _always_ be "lite" and would, in fact, be the only "lite"
devices. Unfortunately, this decision changed and folks didn't realize
that it would be a problem. Specifically, some later lazor WiFi-only
devices were built with "pro" CPUs.

Building WiFi-only lazor with "pro" CPUs isn't the end of the world.
The SDRAM will ramp up a little sooner than it otherwise would, but
aside from a small power hit things work OK. One problem, though, is
that the SDRAM scaling becomes a bit quirky. Specifically, with the
current tables we'll max out SDRAM frequency at 2.1GHz but then
_lower_ it at 2.2GHz / 2.3GHz only to raise it back to max for 2.4GHz
and 2.55GHz.

Let's at least fix this so that the SDRAM frequency doesn't go down in
that quirky way. On true "lite" SKUs this change will be a no-op
because the operating points we're touching are disabled. This change
is only useful when a board that thinks it has a "lite" CPU actually
has a "normal" or "pro" one stuffed.

Fixes: 8fd01e01fd6f ("arm64: dts: qcom: sc7180-lite: Tweak DDR/L3 scaling on SC7180-lite")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230515171929.1.Ic8dee2cb79ce39ffc04eab2a344dde47b2f9459f@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
index d8ed1d7b4ec76..4b306a59d9bec 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
@@ -16,3 +16,11 @@ &cpu6_opp11 {
 &cpu6_opp12 {
 	opp-peak-kBps = <8532000 23347200>;
 };
+
+&cpu6_opp13 {
+	opp-peak-kBps = <8532000 23347200>;
+};
+
+&cpu6_opp14 {
+	opp-peak-kBps = <8532000 23347200>;
+};
-- 
2.39.2



