Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB33703817
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbjEOR1O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbjEOR05 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54361328B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBFB062CF1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD03C433D2;
        Mon, 15 May 2023 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171548;
        bh=M7GBqfX5ce6zJ8h0MOog4Pd7G7biwvALEcKTt4Qkmj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJvoL/zqyxMxcwtyWyX12Tec0Mt0z/NO5yWMObQzxmTrdI++e2OzFapiobfwFiCpf
         z5OVPAE7ss7K4j0FxmlPb3gRhZY3NaBDfxk7mEojq8geepmfYkOWsVkeKRZ7zzLMel
         u561ghfViSy3j4CMxsoUQyAi/xZGEOgBnddgJnLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vinod Govindapillai <vinod.govindapillai@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 6.2 237/242] drm/dsc: fix DP_DSC_MAX_BPP_DELTA_* macro values
Date:   Mon, 15 May 2023 18:29:23 +0200
Message-Id: <20230515161729.017310801@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

commit 0d68683838f2850dd8ff31f1121e05bfb7a2def0 upstream.

The macro values just don't match the specs. Fix them.

Fixes: 1482ec00be4a ("drm: Add missing DP DSC extended capability definitions.")
Cc: Vinod Govindapillai <vinod.govindapillai@intel.com>
Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230406134615.1422509-2-jani.nikula@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/drm/display/drm_dp.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -286,8 +286,8 @@
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_HI        0x068   /* eDP 1.4 */
 # define DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK  (0x3 << 0)
-# define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  0x06
-# define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  0x08
+# define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  (0x3 << 5)	/* eDP 1.5 & DP 2.0 */
+# define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  (1 << 7)	/* eDP 1.5 & DP 2.0 */
 
 #define DP_DSC_DEC_COLOR_FORMAT_CAP         0x069
 # define DP_DSC_RGB                         (1 << 0)


