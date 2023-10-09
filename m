Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFFE7BDDF1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376725AbjJINOS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376940AbjJINOQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C28BA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A9C433CA;
        Mon,  9 Oct 2023 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857252;
        bh=kbOVa35yRMEukuu34/0kkFql2hEK3UajKYWi3OW67/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJGMLSpCzp4pm6Sd3mElmrbgokXHANAHY80GB151IWgIofos1vU+AWdY+Z8uMLW2L
         xs6AAUjl++1/Gr6Rw+vP4TGakzkRuBjBjueQf6YcG3negwe9zavYUrnrVAaOSX8LCG
         4LpCC8vS8k4UAskiG39k3dzkNrpyB7hwj9ZEOWFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Sutter <phil@nwl.cc>,
        Richard Guy Briggs <rgb@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.5 121/163] netfilter: nf_tables: Deduplicate nft_register_obj audit logs
Date:   Mon,  9 Oct 2023 15:01:25 +0200
Message-ID: <20231009130127.379944289@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 0d880dc6f032e0b541520e9926f398a77d3d433c ]

When adding/updating an object, the transaction handler emits suitable
audit log entries already, the one in nft_obj_notify() is redundant. To
fix that (and retain the audit logging from objects' 'update' callback),
Introduce an "audit log free" variant for internal use.

Fixes: c520292f29b8 ("audit: log nftables configuration change events once per table")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Paul Moore <paul@paul-moore.com> (Audit)
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c                 | 44 ++++++++++++-------
 .../testing/selftests/netfilter/nft_audit.sh  | 20 +++++++++
 2 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 976a9b763b9bb..be5869366c7d3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7868,24 +7868,14 @@ static int nf_tables_delobj(struct sk_buff *skb, const struct nfnl_info *info,
 	return nft_delobj(&ctx, obj);
 }
 
-void nft_obj_notify(struct net *net, const struct nft_table *table,
-		    struct nft_object *obj, u32 portid, u32 seq, int event,
-		    u16 flags, int family, int report, gfp_t gfp)
+static void
+__nft_obj_notify(struct net *net, const struct nft_table *table,
+		 struct nft_object *obj, u32 portid, u32 seq, int event,
+		 u16 flags, int family, int report, gfp_t gfp)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct sk_buff *skb;
 	int err;
-	char *buf = kasprintf(gfp, "%s:%u",
-			      table->name, nft_net->base_seq);
-
-	audit_log_nfcfg(buf,
-			family,
-			obj->handle,
-			event == NFT_MSG_NEWOBJ ?
-				 AUDIT_NFT_OP_OBJ_REGISTER :
-				 AUDIT_NFT_OP_OBJ_UNREGISTER,
-			gfp);
-	kfree(buf);
 
 	if (!report &&
 	    !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
@@ -7908,13 +7898,35 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 err:
 	nfnetlink_set_err(net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
 }
+
+void nft_obj_notify(struct net *net, const struct nft_table *table,
+		    struct nft_object *obj, u32 portid, u32 seq, int event,
+		    u16 flags, int family, int report, gfp_t gfp)
+{
+	struct nftables_pernet *nft_net = nft_pernet(net);
+	char *buf = kasprintf(gfp, "%s:%u",
+			      table->name, nft_net->base_seq);
+
+	audit_log_nfcfg(buf,
+			family,
+			obj->handle,
+			event == NFT_MSG_NEWOBJ ?
+				 AUDIT_NFT_OP_OBJ_REGISTER :
+				 AUDIT_NFT_OP_OBJ_UNREGISTER,
+			gfp);
+	kfree(buf);
+
+	__nft_obj_notify(net, table, obj, portid, seq, event,
+			 flags, family, report, gfp);
+}
 EXPORT_SYMBOL_GPL(nft_obj_notify);
 
 static void nf_tables_obj_notify(const struct nft_ctx *ctx,
 				 struct nft_object *obj, int event)
 {
-	nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid, ctx->seq, event,
-		       ctx->flags, ctx->family, ctx->report, GFP_KERNEL);
+	__nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid,
+			 ctx->seq, event, ctx->flags, ctx->family,
+			 ctx->report, GFP_KERNEL);
 }
 
 /*
diff --git a/tools/testing/selftests/netfilter/nft_audit.sh b/tools/testing/selftests/netfilter/nft_audit.sh
index 0b3255e7b3538..bb34329e02a7f 100755
--- a/tools/testing/selftests/netfilter/nft_audit.sh
+++ b/tools/testing/selftests/netfilter/nft_audit.sh
@@ -85,6 +85,26 @@ do_test "nft add set t1 s2 $setblock; add set t1 s3 { $settype; }" \
 do_test "nft add element t1 s3 $setelem" \
 "table=t1 family=2 entries=3 op=nft_register_setelem"
 
+# adding counters
+
+do_test 'nft add counter t1 c1' \
+'table=t1 family=2 entries=1 op=nft_register_obj'
+
+do_test 'nft add counter t2 c1; add counter t2 c2' \
+'table=t2 family=2 entries=2 op=nft_register_obj'
+
+# adding/updating quotas
+
+do_test 'nft add quota t1 q1 { 10 bytes }' \
+'table=t1 family=2 entries=1 op=nft_register_obj'
+
+do_test 'nft add quota t2 q1 { 10 bytes }; add quota t2 q2 { 10 bytes }' \
+'table=t2 family=2 entries=2 op=nft_register_obj'
+
+# changing the quota value triggers obj update path
+do_test 'nft add quota t1 q1 { 20 bytes }' \
+'table=t1 family=2 entries=1 op=nft_register_obj'
+
 # resetting rules
 
 do_test 'nft reset rules t1 c2' \
-- 
2.40.1



