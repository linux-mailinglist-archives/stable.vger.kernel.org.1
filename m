Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF36FABCF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjEHLRj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjEHLRi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03AB37848
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7272062C27
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81299C433EF;
        Mon,  8 May 2023 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544654;
        bh=jyKiYOIG4Fdb+UEAd2DnaLU/27tPCePGWURpg8OEK+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ebR1N1p4JZxTBybBZkb2A8YbU4kIeALw6zH1B1w6f4sL7q1t3SFuFAX7a3dNAP38
         8RKY1Lka+42p15Fesc7YVtUXv4tn7gGU6/mDctDfqJZJB5QhWTaGsbhIXr1f1ohsJR
         0mRAeB8jZRgfJ4WZZprzkRvpiZ2Xmy+Naqj0H5/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 451/694] netfilter: conntrack: restore IPS_CONFIRMED out of nf_conntrack_hash_check_insert()
Date:   Mon,  8 May 2023 11:44:46 +0200
Message-Id: <20230508094448.202501993@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 2cdaa3eefed83082923cf219c8b6a314e622da74 ]

e6d57e9ff0ae ("netfilter: conntrack: fix rmmod double-free race")
consolidates IPS_CONFIRMED bit set in nf_conntrack_hash_check_insert().
However, this breaks ctnetlink:

 # conntrack -I -p tcp --timeout 123 --src 1.2.3.4 --dst 5.6.7.8 --state ESTABLISHED --sport 1 --dport 4 -u SEEN_REPLY
 conntrack v1.4.6 (conntrack-tools): Operation failed: Device or resource busy

This is a partial revert of the aforementioned commit to restore
IPS_CONFIRMED.

Fixes: e6d57e9ff0ae ("netfilter: conntrack: fix rmmod double-free race")
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Tested-by: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_bpf.c     | 1 +
 net/netfilter/nf_conntrack_core.c    | 1 -
 net/netfilter/nf_conntrack_netlink.c | 3 +++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index cd99e6dc1f35c..34913521c385a 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -381,6 +381,7 @@ __bpf_kfunc struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
 	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
 	int err;
 
+	nfct->status |= IPS_CONFIRMED;
 	err = nf_conntrack_hash_check_insert(nfct);
 	if (err < 0) {
 		nf_conntrack_free(nfct);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index c6a6a6099b4e2..7ba6ab9b54b56 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -932,7 +932,6 @@ nf_conntrack_hash_check_insert(struct nf_conn *ct)
 		goto out;
 	}
 
-	ct->status |= IPS_CONFIRMED;
 	smp_wmb();
 	/* The caller holds a reference to this object */
 	refcount_set(&ct->ct_general.use, 2);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index bfc3aaa2c872b..d3ee188546982 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2316,6 +2316,9 @@ ctnetlink_create_conntrack(struct net *net,
 	nfct_seqadj_ext_add(ct);
 	nfct_synproxy_ext_add(ct);
 
+	/* we must add conntrack extensions before confirmation. */
+	ct->status |= IPS_CONFIRMED;
+
 	if (cda[CTA_STATUS]) {
 		err = ctnetlink_change_status(ct, cda);
 		if (err < 0)
-- 
2.39.2



