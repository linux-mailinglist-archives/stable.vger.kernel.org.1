Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512F178330E
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHUUG4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjHUUG4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC0AA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F297764980
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1B4C433C7;
        Mon, 21 Aug 2023 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648413;
        bh=PriA6zDK3soTxJ2EJUzuv+TuUa22NkLq0iVM4/w07bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDvMAeRJQaoQtufkBtnBQ6TmbWsW3Mx3T67X9TO+ynxk36qAtDMD3tDRT8AL6s+dd
         dG6RpQ6LXb3uKaHKwvZTd+unqM2JvWbsJA686ZYwx7acFPKbO1CphHgwdyh+SHanP+
         d73Qk+J0LdoLcCC1051jGNr87hbcqcg8TtJQb1tw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com,
        Leon Romanovsky <leonro@nvidia.com>,
        Aaron Conole <aconole@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 167/234] net: openvswitch: reject negative ifindex
Date:   Mon, 21 Aug 2023 21:42:10 +0200
Message-ID: <20230821194136.213325738@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit a552bfa16bab4ce901ee721346a28c4e483f4066 ]

Recent changes in net-next (commit 759ab1edb56c ("net: store netdevs
in an xarray")) refactored the handling of pre-assigned ifindexes
and let syzbot surface a latent problem in ovs. ovs does not validate
ifindex, making it possible to create netdev ports with negative
ifindex values. It's easy to repro with YNL:

$ ./cli.py --spec netlink/specs/ovs_datapath.yaml \
         --do new \
	 --json '{"upcall-pid": 1, "name":"my-dp"}'
$ ./cli.py --spec netlink/specs/ovs_vport.yaml \
	 --do new \
	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'

$ ip link show
-65536: some-port0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 7a:48:21:ad:0b:fb brd ff:ff:ff:ff:ff:ff
...

Validate the inputs. Now the second command correctly returns:

$ ./cli.py --spec netlink/specs/ovs_vport.yaml \
	 --do new \
	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'

lib.ynl.NlError: Netlink error: Numerical result out of range
nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
	error: -34	extack: {'msg': 'integer out of range', 'unknown': [[type:4 len:36] b'\x0c\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x03\x00\xff\xff\xff\x7f\x00\x00\x00\x00\x08\x00\x01\x00\x08\x00\x00\x00'], 'bad-attr': '.ifindex'}

Accept 0 since it used to be silently ignored.

Fixes: 54c4ef34c4b6 ("openvswitch: allow specifying ifindex of new interfaces")
Reported-by: syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://lore.kernel.org/r/20230814203840.2908710-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/datapath.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index a6d2a0b1aa21e..3d7a91e64c88f 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1829,7 +1829,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	parms.port_no = OVSP_LOCAL;
 	parms.upcall_portids = a[OVS_DP_ATTR_UPCALL_PID];
 	parms.desired_ifindex = a[OVS_DP_ATTR_IFINDEX]
-		? nla_get_u32(a[OVS_DP_ATTR_IFINDEX]) : 0;
+		? nla_get_s32(a[OVS_DP_ATTR_IFINDEX]) : 0;
 
 	/* So far only local changes have been made, now need the lock. */
 	ovs_lock();
@@ -2049,7 +2049,7 @@ static const struct nla_policy datapath_policy[OVS_DP_ATTR_MAX + 1] = {
 	[OVS_DP_ATTR_USER_FEATURES] = { .type = NLA_U32 },
 	[OVS_DP_ATTR_MASKS_CACHE_SIZE] =  NLA_POLICY_RANGE(NLA_U32, 0,
 		PCPU_MIN_UNIT_SIZE / sizeof(struct mask_cache_entry)),
-	[OVS_DP_ATTR_IFINDEX] = {.type = NLA_U32 },
+	[OVS_DP_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
 };
 
 static const struct genl_small_ops dp_datapath_genl_ops[] = {
@@ -2302,7 +2302,7 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	parms.port_no = port_no;
 	parms.upcall_portids = a[OVS_VPORT_ATTR_UPCALL_PID];
 	parms.desired_ifindex = a[OVS_VPORT_ATTR_IFINDEX]
-		? nla_get_u32(a[OVS_VPORT_ATTR_IFINDEX]) : 0;
+		? nla_get_s32(a[OVS_VPORT_ATTR_IFINDEX]) : 0;
 
 	vport = new_vport(&parms);
 	err = PTR_ERR(vport);
@@ -2539,7 +2539,7 @@ static const struct nla_policy vport_policy[OVS_VPORT_ATTR_MAX + 1] = {
 	[OVS_VPORT_ATTR_TYPE] = { .type = NLA_U32 },
 	[OVS_VPORT_ATTR_UPCALL_PID] = { .type = NLA_UNSPEC },
 	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED },
-	[OVS_VPORT_ATTR_IFINDEX] = { .type = NLA_U32 },
+	[OVS_VPORT_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
 	[OVS_VPORT_ATTR_NETNSID] = { .type = NLA_S32 },
 	[OVS_VPORT_ATTR_UPCALL_STATS] = { .type = NLA_NESTED },
 };
-- 
2.40.1



