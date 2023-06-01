Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3A719D5C
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjFANWb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjFANW1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043F13D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF803611B6
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE1DC433D2;
        Thu,  1 Jun 2023 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625745;
        bh=7qfgA5nJCgVbaXXii7SkqXch5xCs/LNXXLaLlH0JOro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9sWQVyLmn7ezTHJd1rXdh+O7Bx7eFYf9/LQPaRA4ccgpxA2Qefo39w6F8R7aRXVY
         g+64FsBGF88PJi68qf+lBOULnkGCYmmFVXA5b9Mpn5mzslmvXgBJZj1p3s5OHw5kfd
         ImdbTaY9++LaznQ48kRBc8qPen1PH09Mb47XHnew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Blakey <paulb@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Demi Marie Obenour <demi@invisiblethingslab.com>
Subject: [PATCH 5.4 16/16] netfilter: ctnetlink: Support offloaded conntrack entry deletion
Date:   Thu,  1 Jun 2023 14:21:11 +0100
Message-Id: <20230601131932.704331175@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
References: <20230601131931.947241286@linuxfoundation.org>
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

From: Paul Blakey <paulb@nvidia.com>

commit 9b7c68b3911aef84afa4cbfc31bce20f10570d51 upstream.

Currently, offloaded conntrack entries (flows) can only be deleted
after they are removed from offload, which is either by timeout,
tcp state change or tc ct rule deletion. This can cause issues for
users wishing to manually delete or flush existing entries.

Support deletion of offloaded conntrack entries.

Example usage:
 # Delete all offloaded (and non offloaded) conntrack entries
 # whose source address is 1.2.3.4
 $ conntrack -D -s 1.2.3.4
 # Delete all entries
 $ conntrack -F

Signed-off-by: Paul Blakey <paulb@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_netlink.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1229,9 +1229,6 @@ static const struct nla_policy ct_nla_po
 
 static int ctnetlink_flush_iterate(struct nf_conn *ct, void *data)
 {
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status))
-		return 0;
-
 	return ctnetlink_filter_match(ct, data);
 }
 
@@ -1294,11 +1291,6 @@ static int ctnetlink_del_conntrack(struc
 
 	ct = nf_ct_tuplehash_to_ctrack(h);
 
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
-		nf_ct_put(ct);
-		return -EBUSY;
-	}
-
 	if (cda[CTA_ID]) {
 		__be32 id = nla_get_be32(cda[CTA_ID]);
 


