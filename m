Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16746FA84B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjEHKjN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjEHKjI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943223A28
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403156281C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3A1C433A0;
        Mon,  8 May 2023 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542345;
        bh=XGwsXE6/ApRlUfbHixNKxyjJulWG0jhTKh7N6iYWVKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ok95mkUWr9nJvFWcwdk6sv4FLR/aN5P0NgAuFedmeV92zpB5KQJioshsWu781RF4W
         T2dVv/UsMaroICiCsD8U5f/yoDZs1D4sCGXcuxz/Ec55vivni+H4yLS/+/z1ocKwXb
         WeCJilJUvVIHemsn+3hNTU3jNQr3QgajOeMGSzuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 406/663] netfilter: conntrack: restore IPS_CONFIRMED out of nf_conntrack_hash_check_insert()
Date:   Mon,  8 May 2023 11:43:52 +0200
Message-Id: <20230508094441.248603562@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index e1af14e3b63c5..24002bc61e07e 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -381,6 +381,7 @@ struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
 	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
 	int err;
 
+	nfct->status |= IPS_CONFIRMED;
 	err = nf_conntrack_hash_check_insert(nfct);
 	if (err < 0) {
 		nf_conntrack_free(nfct);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 19e3afb23fdaf..cf731546e865b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -934,7 +934,6 @@ nf_conntrack_hash_check_insert(struct nf_conn *ct)
 		goto out;
 	}
 
-	ct->status |= IPS_CONFIRMED;
 	smp_wmb();
 	/* The caller holds a reference to this object */
 	refcount_set(&ct->ct_general.use, 2);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d095d3c1ceca6..a68391e228f0e 100644
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



