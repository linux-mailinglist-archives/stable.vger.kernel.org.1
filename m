Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65175CED4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjGUQYy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjGUQYj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BEF4EC4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B70D61D47
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4D1C433CD;
        Fri, 21 Jul 2023 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956475;
        bh=c/Yp+B4Q9yNTi1j3rAndLSzImf8aViYu5VPwTKTTsqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezHy4sdTTG+IQAbsdhRekV+YSW7e/08kcnkYybRWMmffkDG0of7WMnPJchEM4i8D4
         1bbAhHwShMsn4qfQ5SEkcqYtwiKX9ffdShP6S5rezRAKnhd98o0BEK1N5YLcyrnPY3
         4/N1RgdDtf/CYCl0RDzFvasvo1tEhlh5Hs2l2k8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wenjing Liu <wenjing.liu@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Ilya Bakoulin <ilya.bakoulin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 206/292] drm/amd/display: Fix 128b132b link loss handling
Date:   Fri, 21 Jul 2023 18:05:15 +0200
Message-ID: <20230721160537.733630194@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

commit ed83fe2abcace898fdec5c2ba0455703178ac9a3 upstream.

[Why]
We don't check 128b132b-specific bits in LANE_ALIGN_STATUS_UPDATED DPCD
registers when parsing link loss status, which can cause us to miss a
link loss notification from some sinks.

[How]
Add a 128b132b-specific status bit check.

Cc: stable@vger.kernel.org # 6.3+
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../display/dc/link/protocols/link_dp_irq_handler.c   | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index ba95facc4ee8..b1b11eb0f9bb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -82,8 +82,15 @@ bool dp_parse_link_loss_status(
 	}
 
 	/* Check interlane align.*/
-	if (sink_status_changed ||
-		!hpd_irq_dpcd_data->bytes.lane_status_updated.bits.INTERLANE_ALIGN_DONE) {
+	if (link_dp_get_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING &&
+			(!hpd_irq_dpcd_data->bytes.lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b ||
+			 !hpd_irq_dpcd_data->bytes.lane_status_updated.bits.CDS_INTERLANE_ALIGN_DONE_128b_132b)) {
+		sink_status_changed = true;
+	} else if (!hpd_irq_dpcd_data->bytes.lane_status_updated.bits.INTERLANE_ALIGN_DONE) {
+		sink_status_changed = true;
+	}
+
+	if (sink_status_changed) {
 
 		DC_LOG_HW_HPD_IRQ("%s: Link Status changed.\n", __func__);
 
-- 
2.41.0



