Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FCC79B618
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355258AbjIKV5j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240946AbjIKO5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:57:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F4E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:57:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F30EC433CA;
        Mon, 11 Sep 2023 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444259;
        bh=/kpNMW48JpbR8w1YiJc+WFmEQOnM0KPTZTsAjJxjehA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkN1UkIakOXcAPybgQ71NUxIHb/lXutrfbAvOp2YCSIFb5bHp4JbOCynMwigczoLy
         hU2JfZRcawP+mteYUcPo94Md9QPIcimI+3o5iXIhqePV9Bb6hcjUCHLtKpWUodXEKs
         MBvsykXwMoN3HXw7Xgwsb7a9dyFDuhF/TYih8bA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Swapnil Patel <swapnil.patel@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 666/737] drm/amd/display: register edp_backlight_control() for DCN301
Date:   Mon, 11 Sep 2023 15:48:45 +0200
Message-ID: <20230911134709.148260336@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

commit 1611917f39bee1abfc01501238db8ac19649042d upstream.

As made mention of in commit 099303e9a9bd ("drm/amd/display: eDP
intermittent black screen during PnP"), we need to turn off the
display's backlight before powering off an eDP display. Not doing so
will result in undefined behaviour according to the eDP spec. So, set
DCN301's edp_backlight_control() function pointer to
dce110_edp_backlight_control().

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2765
Fixes: 9c75891feef0 ("drm/amd/display: rework recent update PHY state commit")
Suggested-by: Swapnil Patel <swapnil.patel@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -75,6 +75,7 @@ static const struct hw_sequencer_funcs d
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,


