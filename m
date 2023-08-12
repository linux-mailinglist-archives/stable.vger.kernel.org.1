Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0928777A1CF
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHLSfY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLSfY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8C10C0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EE1260CF4
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913FBC433C8;
        Sat, 12 Aug 2023 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865325;
        bh=MUqCtghsouZEUHIzO+bHIXlZPfNn5AfoKyEyXrcAcls=;
        h=Subject:To:Cc:From:Date:From;
        b=fj6bePuiiIXou4C6SOawAB5eu67YZ8KVaOsWxPuNs2aY7Yv5ZC6PLvkktya2NZGKC
         19ZscSDi/ZqFMKqz4jLrEMl182fSaLPftiGsQ1k7Oc8aQoTw3gLaOJiddScv+YFjRQ
         LkHQz4JtOWvIMhulUlj6TtZq8gt0wDoLb7PrCxvE=
Subject: FAILED: patch "[PATCH] net/mlx5e: Unoffload post act rule when handling FIB events" failed to apply to 6.1-stable tree
To:     cmi@nvidia.com, roid@nvidia.com, saeedm@nvidia.com,
        vladbu@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:35:23 +0200
Message-ID: <2023081223-sketch-resolved-8c1e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6b5926eb1c034affff3fb44a98cb8c67153847d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081223-sketch-resolved-8c1e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6b5926eb1c03 ("net/mlx5e: Unoffload post act rule when handling FIB events")
ef78b8d5d6f1 ("net/mlx5e: TC, Use common function allocating flow mod hdr or encap mod hdr")
c43182e6db32 ("net/mlx5e: TC, Add tc prefix to attach/detach hdr functions")
82b564802661 ("net/mlx5e: TC, Pass flow attr to attach/detach mod hdr functions")
5e72f3f1c558 ("net/mlx5e: TC, Keep mod hdr actions after mod hdr alloc")
f86488cb4685 ("net/mlx5e: TC, initialize branch flow attributes")
8facc02f22f1 ("net/mlx5e: TC, reuse flow attribute post parser processing")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b5926eb1c034affff3fb44a98cb8c67153847d8 Mon Sep 17 00:00:00 2001
From: Chris Mi <cmi@nvidia.com>
Date: Wed, 26 Jul 2023 09:06:33 +0300
Subject: [PATCH] net/mlx5e: Unoffload post act rule when handling FIB events

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

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 0c88cf47af01..1730f6a716ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -1461,10 +1461,12 @@ static void mlx5e_invalidate_encap(struct mlx5e_priv *priv,
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

