Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35446FA63E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjEHKR4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjEHKRq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639CED058
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEABE624E4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F319C433D2;
        Mon,  8 May 2023 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541053;
        bh=pGb6w6HtaXDEx24a+2DlEuJmROdO44tRP8LP0Vi4lNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdxsesZgcEYeJWN0AmX+ISp9kHA+zvQ/qpM2Dbg666M6D+79lYuYlXz1Bhm3r2YoP
         hzo/GG9XUc7MEEvpft3nI7Y4BiaYau5RGO01munQI/UxltzYG1tOhR5gusC4aCZl+4
         e8a5rw1a4Nq1ox61G3wJxOhErXW+e5uM4Kzr7V7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.1 599/611] thunderbolt: Use correct type in tb_port_is_clx_enabled() prototype
Date:   Mon,  8 May 2023 11:47:21 +0200
Message-Id: <20230508094441.373592693@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

commit d31137619776f9c173a46a79bc7733a2b106061f upstream.

tb_port_is_clx_enabled() generates a valid warning with gcc-13:
  drivers/thunderbolt/switch.c:1286:6: error: conflicting types for 'tb_port_is_clx_enabled' due to enum/integer mismatch; have 'bool(struct tb_port *, unsigned int)' ...
  drivers/thunderbolt/tb.h:1050:6: note: previous declaration of 'tb_port_is_clx_enabled' with type 'bool(struct tb_port *, enum tb_clx)' ...

I.e. the type of the 2nd parameter of tb_port_is_clx_enabled() in the
declaration is unsigned int, while the definition spells enum tb_clx.
Synchronize them to the former as the parameter is in fact a mask of the
enum values.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/tb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1058,7 +1058,7 @@ void tb_port_lane_bonding_disable(struct
 int tb_port_wait_for_link_width(struct tb_port *port, int width,
 				int timeout_msec);
 int tb_port_update_credits(struct tb_port *port);
-bool tb_port_is_clx_enabled(struct tb_port *port, enum tb_clx clx);
+bool tb_port_is_clx_enabled(struct tb_port *port, unsigned int clx);
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_switch_find_cap(struct tb_switch *sw, enum tb_switch_cap cap);


