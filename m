Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223667CA23A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjJPIrY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjJPIrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:47:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F295F3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:47:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5086CC433C7;
        Mon, 16 Oct 2023 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446034;
        bh=Dqvw0ovAf1yXELfFlOU0MrezIeyWKw9ZueMRdN/iuN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrbdP/U5WKXddlJO2eIDWl3zkHiqpXtxBhNwvtPR/d2aXnPZQs5UZgihpB0DJM26d
         aURicp3I20Q3l3VpLizAlkhydbgW13SfsSRLG0wAk2XA+/gmhOpcD7UAepS34Vr/zJ
         Jsii9RF3U4SyhjdplQxvkn1A8wGaMPbI9qeVvC8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20=C5=A0anta?= <teslan223@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.15 064/102] thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding
Date:   Mon, 16 Oct 2023 10:41:03 +0200
Message-ID: <20231016083955.409551587@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit a9fdf5f933a6f2b358fad0194b1287b67f6704b1 upstream.

Marek reported that when BlackMagic UltraStudio device is connected the
kernel repeatedly tries to enable lane bonding without success making
the device non-functional. It looks like the device does not have lane 1
connected at all so even though it is enabled we should not try to bond
the lanes. For this reason check that lane 1 is in fact CL0 (connected,
active) before attempting to bond the lanes.

Reported-by: Marek Šanta <teslan223@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217737
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/switch.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2552,6 +2552,13 @@ int tb_switch_lane_bonding_enable(struct
 	    !tb_port_is_width_supported(down, 2))
 		return 0;
 
+	/*
+	 * Both lanes need to be in CL0. Here we assume lane 0 already be in
+	 * CL0 and check just for lane 1.
+	 */
+	if (tb_wait_for_port(down->dual_link_port, false) <= 0)
+		return -ENOTCONN;
+
 	ret = tb_port_lane_bonding_enable(up);
 	if (ret) {
 		tb_port_warn(up, "failed to enable lane bonding\n");


