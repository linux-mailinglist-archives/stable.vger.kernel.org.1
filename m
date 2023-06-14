Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F672C1FA
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjFLLBv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjFLLB2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F009910E0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 855E8624C6
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B36C433EF;
        Mon, 12 Jun 2023 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566924;
        bh=jPd3oQP6IQWDJTDpe9ZlRbaeQO6aI4FBCJ81SeKomBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+ut8nqv7SF7HJ+EMh8kyNUDoIVI5khwVBBX9/u5+6mX4FayTHyX/l8HiTlr/Rl/D
         G1wRWFvmbCtqNeJhkmlK/tTl4z/ssxz+4GBxNLiHVKo0f8qFv7qZZmtnkx90DpFQNP
         v4BiAPeBHerguP27/u0NyB6j2QNZZjjP3u0KM+tU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eelco Chaudron <echaudro@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Aaron Conole <aconole@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 055/160] net: openvswitch: fix upcall counter access before allocation
Date:   Mon, 12 Jun 2023 12:26:27 +0200
Message-ID: <20230612101717.535304489@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Eelco Chaudron <echaudro@redhat.com>

[ Upstream commit de9df6c6b27e22d7bdd20107947ef3a20e687de5 ]

Currently, the per cpu upcall counters are allocated after the vport is
created and inserted into the system. This could lead to the datapath
accessing the counters before they are allocated resulting in a kernel
Oops.

Here is an example:

  PID: 59693    TASK: ffff0005f4f51500  CPU: 0    COMMAND: "ovs-vswitchd"
   #0 [ffff80000a39b5b0] __switch_to at ffffb70f0629f2f4
   #1 [ffff80000a39b5d0] __schedule at ffffb70f0629f5cc
   #2 [ffff80000a39b650] preempt_schedule_common at ffffb70f0629fa60
   #3 [ffff80000a39b670] dynamic_might_resched at ffffb70f0629fb58
   #4 [ffff80000a39b680] mutex_lock_killable at ffffb70f062a1388
   #5 [ffff80000a39b6a0] pcpu_alloc at ffffb70f0594460c
   #6 [ffff80000a39b750] __alloc_percpu_gfp at ffffb70f05944e68
   #7 [ffff80000a39b760] ovs_vport_cmd_new at ffffb70ee6961b90 [openvswitch]
   ...

  PID: 58682    TASK: ffff0005b2f0bf00  CPU: 0    COMMAND: "kworker/0:3"
   #0 [ffff80000a5d2f40] machine_kexec at ffffb70f056a0758
   #1 [ffff80000a5d2f70] __crash_kexec at ffffb70f057e2994
   #2 [ffff80000a5d3100] crash_kexec at ffffb70f057e2ad8
   #3 [ffff80000a5d3120] die at ffffb70f0628234c
   #4 [ffff80000a5d31e0] die_kernel_fault at ffffb70f062828a8
   #5 [ffff80000a5d3210] __do_kernel_fault at ffffb70f056a31f4
   #6 [ffff80000a5d3240] do_bad_area at ffffb70f056a32a4
   #7 [ffff80000a5d3260] do_translation_fault at ffffb70f062a9710
   #8 [ffff80000a5d3270] do_mem_abort at ffffb70f056a2f74
   #9 [ffff80000a5d32a0] el1_abort at ffffb70f06297dac
  #10 [ffff80000a5d32d0] el1h_64_sync_handler at ffffb70f06299b24
  #11 [ffff80000a5d3410] el1h_64_sync at ffffb70f056812dc
  #12 [ffff80000a5d3430] ovs_dp_upcall at ffffb70ee6963c84 [openvswitch]
  #13 [ffff80000a5d3470] ovs_dp_process_packet at ffffb70ee6963fdc [openvswitch]
  #14 [ffff80000a5d34f0] ovs_vport_receive at ffffb70ee6972c78 [openvswitch]
  #15 [ffff80000a5d36f0] netdev_port_receive at ffffb70ee6973948 [openvswitch]
  #16 [ffff80000a5d3720] netdev_frame_hook at ffffb70ee6973a28 [openvswitch]
  #17 [ffff80000a5d3730] __netif_receive_skb_core.constprop.0 at ffffb70f06079f90

We moved the per cpu upcall counter allocation to the existing vport
alloc and free functions to solve this.

Fixes: 95637d91fefd ("net: openvswitch: release vport resources on failure")
Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/datapath.c | 19 -------------------
 net/openvswitch/vport.c    | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index fcee6012293b1..58f530f60172a 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -236,9 +236,6 @@ void ovs_dp_detach_port(struct vport *p)
 	/* First drop references to device. */
 	hlist_del_rcu(&p->dp_hash_node);
 
-	/* Free percpu memory */
-	free_percpu(p->upcall_stats);
-
 	/* Then destroy it. */
 	ovs_vport_del(p);
 }
@@ -1858,12 +1855,6 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		goto err_destroy_portids;
 	}
 
-	vport->upcall_stats = netdev_alloc_pcpu_stats(struct vport_upcall_stats_percpu);
-	if (!vport->upcall_stats) {
-		err = -ENOMEM;
-		goto err_destroy_vport;
-	}
-
 	err = ovs_dp_cmd_fill_info(dp, reply, info->snd_portid,
 				   info->snd_seq, 0, OVS_DP_CMD_NEW);
 	BUG_ON(err < 0);
@@ -1876,8 +1867,6 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	ovs_notify(&dp_datapath_genl_family, reply, info);
 	return 0;
 
-err_destroy_vport:
-	ovs_dp_detach_port(vport);
 err_destroy_portids:
 	kfree(rcu_dereference_raw(dp->upcall_portids));
 err_unlock_and_destroy_meters:
@@ -2322,12 +2311,6 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		goto exit_unlock_free;
 	}
 
-	vport->upcall_stats = netdev_alloc_pcpu_stats(struct vport_upcall_stats_percpu);
-	if (!vport->upcall_stats) {
-		err = -ENOMEM;
-		goto exit_unlock_free_vport;
-	}
-
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_NEW, GFP_KERNEL);
@@ -2345,8 +2328,6 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	ovs_notify(&dp_vport_genl_family, reply, info);
 	return 0;
 
-exit_unlock_free_vport:
-	ovs_dp_detach_port(vport);
 exit_unlock_free:
 	ovs_unlock();
 	kfree_skb(reply);
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 7e0f5c45b5124..972ae01a70f76 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -124,6 +124,7 @@ struct vport *ovs_vport_alloc(int priv_size, const struct vport_ops *ops,
 {
 	struct vport *vport;
 	size_t alloc_size;
+	int err;
 
 	alloc_size = sizeof(struct vport);
 	if (priv_size) {
@@ -135,17 +136,29 @@ struct vport *ovs_vport_alloc(int priv_size, const struct vport_ops *ops,
 	if (!vport)
 		return ERR_PTR(-ENOMEM);
 
+	vport->upcall_stats = netdev_alloc_pcpu_stats(struct vport_upcall_stats_percpu);
+	if (!vport->upcall_stats) {
+		err = -ENOMEM;
+		goto err_kfree_vport;
+	}
+
 	vport->dp = parms->dp;
 	vport->port_no = parms->port_no;
 	vport->ops = ops;
 	INIT_HLIST_NODE(&vport->dp_hash_node);
 
 	if (ovs_vport_set_upcall_portids(vport, parms->upcall_portids)) {
-		kfree(vport);
-		return ERR_PTR(-EINVAL);
+		err = -EINVAL;
+		goto err_free_percpu;
 	}
 
 	return vport;
+
+err_free_percpu:
+	free_percpu(vport->upcall_stats);
+err_kfree_vport:
+	kfree(vport);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(ovs_vport_alloc);
 
@@ -165,6 +178,7 @@ void ovs_vport_free(struct vport *vport)
 	 * it is safe to use raw dereference.
 	 */
 	kfree(rcu_dereference_raw(vport->upcall_portids));
+	free_percpu(vport->upcall_stats);
 	kfree(vport);
 }
 EXPORT_SYMBOL_GPL(ovs_vport_free);
-- 
2.39.2



