Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF45F719DA2
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjFANZT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjFANYw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD95E63
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1FC364477
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0343C433D2;
        Thu,  1 Jun 2023 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625870;
        bh=/i8cVbrsxox/1u1kytPlBJvj9NijBCt8ysKkYrnlYUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dX7xITjFK3yS+rL6QGTueIVYISe166NrvYAbbuUV37LibIOTSMLqwRxVY7l71Lw+B
         VHclHacgKJKuw9NbkRhy28yV45FSOd2v+KyClQ0dDCpHRGtdxI0B4pv9JHLTFVNYMN
         PbN5/7F6ndx07JpBvIEAmtBBy1Ke12VkHlmFG6BE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jay Vosburgh <jay.vosburgh@canonical.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 25/42] Bonding: add arp_missed_max option
Date:   Thu,  1 Jun 2023 14:21:12 +0100
Message-Id: <20230601131937.846051492@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 5944b5abd8646e8c6ac6af2b55f87dede1dae898 ]

Currently, we use hard code number to verify if we are in the
arp_interval timeslice. But some user may want to reduce/extend
the verify timeslice. With the similar team option 'missed_max'
the uers could change that number based on their own environment.

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9949e2efb54e ("bonding: fix send_peer_notif overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/bonding.rst | 11 +++++++++++
 drivers/net/bonding/bond_main.c      | 17 +++++++++--------
 drivers/net/bonding/bond_netlink.c   | 15 +++++++++++++++
 drivers/net/bonding/bond_options.c   | 28 ++++++++++++++++++++++++++++
 drivers/net/bonding/bond_procfs.c    |  2 ++
 drivers/net/bonding/bond_sysfs.c     | 13 +++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  1 +
 include/uapi/linux/if_link.h         |  1 +
 tools/include/uapi/linux/if_link.h   |  1 +
 10 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index c0a789b008063..ab98373535ea6 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -422,6 +422,17 @@ arp_all_targets
 		consider the slave up only when all of the arp_ip_targets
 		are reachable
 
+arp_missed_max
+
+	Specifies the number of arp_interval monitor checks that must
+	fail in order for an interface to be marked down by the ARP monitor.
+
+	In order to provide orderly failover semantics, backup interfaces
+	are permitted an extra monitor check (i.e., they must fail
+	arp_missed_max + 1 times before being marked down).
+
+	The default value is 2, and the allowable range is 1 - 255.
+
 downdelay
 
 	Specifies the time, in milliseconds, to wait before disabling
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a2ce9f0fb43c5..b4d613bdbc060 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3145,8 +3145,8 @@ static void bond_loadbalance_arp_mon(struct bonding *bond)
 			 * when the source ip is 0, so don't take the link down
 			 * if we don't know our ip yet
 			 */
-			if (!bond_time_in_interval(bond, trans_start, 2) ||
-			    !bond_time_in_interval(bond, slave->last_rx, 2)) {
+			if (!bond_time_in_interval(bond, trans_start, bond->params.missed_max) ||
+			    !bond_time_in_interval(bond, slave->last_rx, bond->params.missed_max)) {
 
 				bond_propose_link_state(slave, BOND_LINK_DOWN);
 				slave_state_changed = 1;
@@ -3240,7 +3240,7 @@ static int bond_ab_arp_inspect(struct bonding *bond)
 
 		/* Backup slave is down if:
 		 * - No current_arp_slave AND
-		 * - more than 3*delta since last receive AND
+		 * - more than (missed_max+1)*delta since last receive AND
 		 * - the bond has an IP address
 		 *
 		 * Note: a non-null current_arp_slave indicates
@@ -3252,20 +3252,20 @@ static int bond_ab_arp_inspect(struct bonding *bond)
 		 */
 		if (!bond_is_active_slave(slave) &&
 		    !rcu_access_pointer(bond->current_arp_slave) &&
-		    !bond_time_in_interval(bond, last_rx, 3)) {
+		    !bond_time_in_interval(bond, last_rx, bond->params.missed_max + 1)) {
 			bond_propose_link_state(slave, BOND_LINK_DOWN);
 			commit++;
 		}
 
 		/* Active slave is down if:
-		 * - more than 2*delta since transmitting OR
-		 * - (more than 2*delta since receive AND
+		 * - more than missed_max*delta since transmitting OR
+		 * - (more than missed_max*delta since receive AND
 		 *    the bond has an IP address)
 		 */
 		trans_start = dev_trans_start(slave->dev);
 		if (bond_is_active_slave(slave) &&
-		    (!bond_time_in_interval(bond, trans_start, 2) ||
-		     !bond_time_in_interval(bond, last_rx, 2))) {
+		    (!bond_time_in_interval(bond, trans_start, bond->params.missed_max) ||
+		     !bond_time_in_interval(bond, last_rx, bond->params.missed_max))) {
 			bond_propose_link_state(slave, BOND_LINK_DOWN);
 			commit++;
 		}
@@ -5886,6 +5886,7 @@ static int bond_check_params(struct bond_params *params)
 	params->arp_interval = arp_interval;
 	params->arp_validate = arp_validate_value;
 	params->arp_all_targets = arp_all_targets_value;
+	params->missed_max = 2;
 	params->updelay = updelay;
 	params->downdelay = downdelay;
 	params->peer_notif_delay = 0;
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 5d54e11d18fa5..1007bf6d385d4 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -110,6 +110,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 					    .len  = ETH_ALEN },
 	[IFLA_BOND_TLB_DYNAMIC_LB]	= { .type = NLA_U8 },
 	[IFLA_BOND_PEER_NOTIF_DELAY]    = { .type = NLA_U32 },
+	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -453,6 +454,15 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_MISSED_MAX]) {
+		int missed_max = nla_get_u8(data[IFLA_BOND_MISSED_MAX]);
+
+		bond_opt_initval(&newval, missed_max);
+		err = __bond_opt_set(bond, BOND_OPT_MISSED_MAX, &newval);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -515,6 +525,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		nla_total_size(ETH_ALEN) + /* IFLA_BOND_AD_ACTOR_SYSTEM */
 		nla_total_size(sizeof(u8)) + /* IFLA_BOND_TLB_DYNAMIC_LB */
 		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_PEER_NOTIF_DELAY */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_MISSED_MAX */
 		0;
 }
 
@@ -650,6 +661,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.tlb_dynamic_lb))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_MISSED_MAX,
+		       bond->params.missed_max))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index b93337b5a7211..2e8484a91a0e7 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -78,6 +78,8 @@ static int bond_option_ad_actor_system_set(struct bonding *bond,
 					   const struct bond_opt_value *newval);
 static int bond_option_ad_user_port_key_set(struct bonding *bond,
 					    const struct bond_opt_value *newval);
+static int bond_option_missed_max_set(struct bonding *bond,
+				      const struct bond_opt_value *newval);
 
 
 static const struct bond_opt_value bond_mode_tbl[] = {
@@ -213,6 +215,13 @@ static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
 	{ NULL,      -1,    0},
 };
 
+static const struct bond_opt_value bond_missed_max_tbl[] = {
+	{ "minval",	1,	BOND_VALFLAG_MIN},
+	{ "maxval",	255,	BOND_VALFLAG_MAX},
+	{ "default",	2,	BOND_VALFLAG_DEFAULT},
+	{ NULL,		-1,	0},
+};
+
 static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 	[BOND_OPT_MODE] = {
 		.id = BOND_OPT_MODE,
@@ -270,6 +279,15 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.values = bond_intmax_tbl,
 		.set = bond_option_arp_interval_set
 	},
+	[BOND_OPT_MISSED_MAX] = {
+		.id = BOND_OPT_MISSED_MAX,
+		.name = "arp_missed_max",
+		.desc = "Maximum number of missed ARP interval",
+		.unsuppmodes = BIT(BOND_MODE_8023AD) | BIT(BOND_MODE_TLB) |
+			       BIT(BOND_MODE_ALB),
+		.values = bond_missed_max_tbl,
+		.set = bond_option_missed_max_set
+	},
 	[BOND_OPT_ARP_TARGETS] = {
 		.id = BOND_OPT_ARP_TARGETS,
 		.name = "arp_ip_target",
@@ -1186,6 +1204,16 @@ static int bond_option_arp_all_targets_set(struct bonding *bond,
 	return 0;
 }
 
+static int bond_option_missed_max_set(struct bonding *bond,
+				      const struct bond_opt_value *newval)
+{
+	netdev_dbg(bond->dev, "Setting missed max to %s (%llu)\n",
+		   newval->string, newval->value);
+	bond->params.missed_max = newval->value;
+
+	return 0;
+}
+
 static int bond_option_primary_set(struct bonding *bond,
 				   const struct bond_opt_value *newval)
 {
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index f3e3bfd72556c..2ec11af5f0cce 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -115,6 +115,8 @@ static void bond_info_show_master(struct seq_file *seq)
 
 		seq_printf(seq, "ARP Polling Interval (ms): %d\n",
 				bond->params.arp_interval);
+		seq_printf(seq, "ARP Missed Max: %u\n",
+				bond->params.missed_max);
 
 		seq_printf(seq, "ARP IP target/s (n.n.n.n form):");
 
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index b9e9842fed94e..22aa22f4e0882 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -303,6 +303,18 @@ static ssize_t bonding_show_arp_targets(struct device *d,
 static DEVICE_ATTR(arp_ip_target, 0644,
 		   bonding_show_arp_targets, bonding_sysfs_store_option);
 
+/* Show the arp missed max. */
+static ssize_t bonding_show_missed_max(struct device *d,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct bonding *bond = to_bond(d);
+
+	return sprintf(buf, "%u\n", bond->params.missed_max);
+}
+static DEVICE_ATTR(arp_missed_max, 0644,
+		   bonding_show_missed_max, bonding_sysfs_store_option);
+
 /* Show the up and down delays. */
 static ssize_t bonding_show_downdelay(struct device *d,
 				      struct device_attribute *attr,
@@ -779,6 +791,7 @@ static struct attribute *per_bond_attrs[] = {
 	&dev_attr_ad_actor_sys_prio.attr,
 	&dev_attr_ad_actor_system.attr,
 	&dev_attr_ad_user_port_key.attr,
+	&dev_attr_arp_missed_max.attr,
 	NULL,
 };
 
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index e64833a674eb8..dd75c071f67e2 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -65,6 +65,7 @@ enum {
 	BOND_OPT_NUM_PEER_NOTIF_ALIAS,
 	BOND_OPT_PEER_NOTIF_DELAY,
 	BOND_OPT_LACP_ACTIVE,
+	BOND_OPT_MISSED_MAX,
 	BOND_OPT_LAST
 };
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index de0bdcc7dc7f9..0db3c5f36868b 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -121,6 +121,7 @@ struct bond_params {
 	int xmit_policy;
 	int miimon;
 	u8 num_peer_notif;
+	u8 missed_max;
 	int arp_interval;
 	int arp_validate;
 	int arp_all_targets;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index eebd3894fe89a..4ac53b30b6dc9 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -858,6 +858,7 @@ enum {
 	IFLA_BOND_TLB_DYNAMIC_LB,
 	IFLA_BOND_PEER_NOTIF_DELAY,
 	IFLA_BOND_AD_LACP_ACTIVE,
+	IFLA_BOND_MISSED_MAX,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index b3610fdd1feec..4772a115231ae 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -655,6 +655,7 @@ enum {
 	IFLA_BOND_TLB_DYNAMIC_LB,
 	IFLA_BOND_PEER_NOTIF_DELAY,
 	IFLA_BOND_AD_LACP_ACTIVE,
+	IFLA_BOND_MISSED_MAX,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.39.2



