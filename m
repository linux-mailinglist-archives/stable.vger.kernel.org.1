Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353A177AC42
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjHMVbA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjHMVa5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7371110D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09BBD62B1A
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154DAC433C8;
        Sun, 13 Aug 2023 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962258;
        bh=C/s5a0qGQ6U1QkV3pl0eoK9wVRAdHpYp6I6dE22JqWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUTp5lqRt3MvLvNQwmybm4SjlHlK+YfKTLmr/EAmghKEpUHlPDpv2487rBWODKcNR
         0UtJD7h2kookcSnNSt7XZqG+XxozM1zbWTLk/tDT3xmErtk5STWGtvV/J01qO52eHA
         6OvzLBUcmx1JC54CVEBUzxO5yB0E5fXnU1/U2OUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mi <cmi@nvidia.com>,
        Vlad Buslov <vladbu@nvidia.com>, Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.4 171/206] net/mlx5e: Unoffload post act rule when handling FIB events
Date:   Sun, 13 Aug 2023 23:19:01 +0200
Message-ID: <20230813211729.920073419@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Chris Mi <cmi@nvidia.com>

commit 6b5926eb1c034affff3fb44a98cb8c67153847d8 upstream.

If having the following tc rule on stack device:

filter parent ffff: protocol ip pref 3 flower chain 1
filter parent ffff: protocol ip pref 3 flower chain 1 handle 0x1
  dst_mac 24:25:d0:e1:00:00
  src_mac 02:25:d0:25:01:02
  eth_type ipv4
  ct_state +trk+new
  in_hw in_hw_count 1
        action order 1: ct commit zone 0 pipe
         index 2 ref 1 bind 1 installed 3807 sec used 3779 sec firstused 3800 sec
        Action statistics:
        Sent 120 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
        backlog 0b 0p requeues 0
        used_hw_stats delayed

        action order 2: tunnel_key  set
        src_ip 192.168.1.25
        dst_ip 192.168.1.26
        key_id 4
        dst_port 4789
        csum pipe
         index 3 ref 1 bind 1 installed 3807 sec used 3779 sec firstused 3800 sec
        Action statistics:
        Sent 120 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
        backlog 0b 0p requeues 0
        used_hw_stats delayed

        action order 3: mirred (Egress Redirect to device vxlan1) stolen
        index 9 ref 1 bind 1 installed 3807 sec used 3779 sec firstused 3800 sec
        Action statistics:
        Sent 120 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
        backlog 0b 0p requeues 0
        used_hw_stats delayed

When handling FIB events, the rule in post act will not be deleted.
And because the post act rule has packet reformat and modify header
actions, also will hit the following syndromes:

mlx5_core 0000:08:00.0: mlx5_cmd_out_err:829:(pid 11613): DEALLOC_MODIFY_HEADER_CONTEXT(0x941) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1ab444), err(-22)
mlx5_core 0000:08:00.0: mlx5_cmd_out_err:829:(pid 11613): DEALLOC_PACKET_REFORMAT_CONTEXT(0x93e) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x179e84), err(-22)

Fix it by unoffloading post act rule when handling FIB events.

Fixes: 314e1105831b ("net/mlx5e: Add post act offload/unoffload API")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -1461,10 +1461,12 @@ static void mlx5e_invalidate_encap(struc
 		attr = mlx5e_tc_get_encap_attr(flow);
 		esw_attr = attr->esw_attr;
 
-		if (flow_flag_test(flow, SLOW))
+		if (flow_flag_test(flow, SLOW)) {
 			mlx5e_tc_unoffload_from_slow_path(esw, flow);
-		else
+		} else {
 			mlx5e_tc_unoffload_fdb_rules(esw, flow, flow->attr);
+			mlx5e_tc_unoffload_flow_post_acts(flow);
+		}
 
 		mlx5e_tc_detach_mod_hdr(priv, flow, attr);
 		attr->modify_hdr = NULL;


