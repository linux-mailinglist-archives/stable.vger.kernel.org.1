Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9D7D3706
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjJWMlz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 08:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjJWLnw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:43:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775B210F4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:43:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D5EC433C8;
        Mon, 23 Oct 2023 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061427;
        bh=hpkBzb2QqZxP0NWOw+5RAX9FqazzxszG1FkVhfghsvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYDTpgs5nYUyjx76zLPn/TzdhKGabHq2s+0qbL8ij4F/ZDfN1Hju8V3jaujyRz97n
         blcn5pzHgPDAEA7uBoSpnDPflieoFjeJDb3ucD5OwG9rJuoYL2buNh36Hr6IpOuuoS
         mJglUlKukNxkw8ta1I6Qu3W8xwCVztbsSQKn3QXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20=C5=A0anta?= <teslan223@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.10 044/202] thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding
Date:   Mon, 23 Oct 2023 12:55:51 +0200
Message-ID: <20231023104827.872826411@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2303,6 +2303,13 @@ int tb_switch_lane_bonding_enable(struct
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


