Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1429F7552C2
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGPULg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGPULf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9691A9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B8B60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BCEC433C8;
        Sun, 16 Jul 2023 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538293;
        bh=32bIBJrzYt4IWeuS1C9n0+wAAujBPREGIex+VnxGCfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aX5Ro6CF1wcHfs86BU416ZbX+p+sIVR5ZbkLOCtPaxRhecyv0qGrKEJQPGuPcBW1A
         ChMf295SSh4k9Tyi/cheoqME1HsQatqdTE5aQPejFQlKfnOU5DoNQVbwLjh37CR2mk
         iTpmzID7oeTfuO3Hav0Yy2pROWMztXtMXqfbt6bA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 346/800] drm/i915: Fix limited range csc matrix
Date:   Sun, 16 Jul 2023 21:43:19 +0200
Message-ID: <20230716194957.117528114@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 404c3acda4b65924c05bc63242e94f954f84c165 ]

Our current limited range matrix is a bit off. I think it
was originally calculated with rounding, as if we wanted
the normal pixel replication type of behaviour.
That is, since the 8bpc max value is 0xeb we assumed the
16bpc max value should be 0xebeb, but what the HDMI spec
actually says it should be is 0xeb00.

So to get what we want we make the formula
 out = in * (235-16) << (12-8) / in_max + 16 << (12-8),
with 12 being precision of the csc, 8 being the precision
of the constants we used.

The hardware takes its coefficients as floating point
values, but the (235−16)/255 = ~.86, so exponent 0
is what we want anyway, so it works out perfectly without
having to hardcode it in hex or start playing with floats.

In terms of raw numbers we are feeding the hardware the
post offset changes from 0x101 to 0x100, and the coefficient
changes from 0xdc0 to 0xdb0 (~.860->~.855). So this should
make everything come out just a tad darker.

I already used better constants in lut_limited_range() earlier
so the output of the two paths should be closer now.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230329135002.3096-2-ville.syrjala@linux.intel.com
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Stable-dep-of: 19db2062094c ("drm/i915: No 10bit gamma on desktop gen3 parts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_color.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 36aac88143ac1..3c3e2f5a5cdec 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -116,10 +116,9 @@ struct intel_color_funcs {
 #define ILK_CSC_COEFF_FP(coeff, fbits)	\
 	(clamp_val(((coeff) >> (32 - (fbits) - 3)) + 4, 0, 0xfff) & 0xff8)
 
-#define ILK_CSC_COEFF_LIMITED_RANGE 0x0dc0
 #define ILK_CSC_COEFF_1_0 0x7800
-
-#define ILK_CSC_POSTOFF_LIMITED_RANGE (16 * (1 << 12) / 255)
+#define ILK_CSC_COEFF_LIMITED_RANGE ((235 - 16) << (12 - 8)) /* exponent 0 */
+#define ILK_CSC_POSTOFF_LIMITED_RANGE (16 << (12 - 8))
 
 /* Nop pre/post offsets */
 static const u16 ilk_csc_off_zero[3] = {};
-- 
2.39.2



