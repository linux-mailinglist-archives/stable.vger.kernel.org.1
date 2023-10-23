Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3377D31A8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJWLLm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJWLLm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:11:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B9C5
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:11:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923ADC433C7;
        Mon, 23 Oct 2023 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059499;
        bh=X5SEx12bApcOGg2fww70UtIsTHN/K15ElC4dTYG/02Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPvNSyWOydcC1Ib6ZRId2OY1xfI3ZIVU+OGaN7qx/jq4bekFn+CJOW+JqCkTdB6iW
         ARbpD46tGDh6/QECzAt3eBdjObG+TO7cIoMx1wtPECDtZfoIVdqJcpC9qk6r/oeHq0
         Cuntox/qm35krJrC4ZFmgs7O2mxKgSstP5DkrDCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gil Fine <gil.fine@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.5 197/241] thunderbolt: Call tb_switch_put() once DisplayPort bandwidth request is finished
Date:   Mon, 23 Oct 2023 12:56:23 +0200
Message-ID: <20231023104838.669907021@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gil Fine <gil.fine@linux.intel.com>

commit ec4405ed92036f5bb487b5c2f9a28f9e36a3e3d5 upstream.

When handling DisplayPort bandwidth request tb_switch_find_by_route() is
called and it returns a router structure with reference count increased.
In order to avoid resource leak call tb_switch_put() when finished.

Fixes: 6ce3563520be ("thunderbolt: Add support for DisplayPort bandwidth allocation mode")
Cc: stable@vger.kernel.org
Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/tb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index dd0a1ef8cf12..27bd6ca6f99e 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1907,14 +1907,14 @@ static void tb_handle_dp_bandwidth_request(struct work_struct *work)
 	in = &sw->ports[ev->port];
 	if (!tb_port_is_dpin(in)) {
 		tb_port_warn(in, "bandwidth request to non-DP IN adapter\n");
-		goto unlock;
+		goto put_sw;
 	}
 
 	tb_port_dbg(in, "handling bandwidth allocation request\n");
 
 	if (!usb4_dp_port_bandwidth_mode_enabled(in)) {
 		tb_port_warn(in, "bandwidth allocation mode not enabled\n");
-		goto unlock;
+		goto put_sw;
 	}
 
 	ret = usb4_dp_port_requested_bandwidth(in);
@@ -1923,7 +1923,7 @@ static void tb_handle_dp_bandwidth_request(struct work_struct *work)
 			tb_port_dbg(in, "no bandwidth request active\n");
 		else
 			tb_port_warn(in, "failed to read requested bandwidth\n");
-		goto unlock;
+		goto put_sw;
 	}
 	requested_bw = ret;
 
@@ -1932,7 +1932,7 @@ static void tb_handle_dp_bandwidth_request(struct work_struct *work)
 	tunnel = tb_find_tunnel(tb, TB_TUNNEL_DP, in, NULL);
 	if (!tunnel) {
 		tb_port_warn(in, "failed to find tunnel\n");
-		goto unlock;
+		goto put_sw;
 	}
 
 	out = tunnel->dst_port;
@@ -1959,6 +1959,8 @@ static void tb_handle_dp_bandwidth_request(struct work_struct *work)
 		tb_recalc_estimated_bandwidth(tb);
 	}
 
+put_sw:
+	tb_switch_put(sw);
 unlock:
 	mutex_unlock(&tb->lock);
 
-- 
2.42.0



