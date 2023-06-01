Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F53719E26
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjFAN3i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjFAN31 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA48E44
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7F16450C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63197C433EF;
        Thu,  1 Jun 2023 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626144;
        bh=MILY39kd8rCMkR/XdLUoPwEY904DFCAaG/DiuQJQ4f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRL62wKcNRR1s5AxmLq44W+vwSF09LZvuybWDtln+qlN52KsI/ddRmVLDabqFf/kB
         haLbgl+13w6VuGYS+YrhhjO1VByzThOWTkO0ZfvnBsuyGwaSUmcmFfTyCxv6S6Uc23
         F0fDe2y1PtrCuqs+EErHaDRPrWI/kwfDluJjZK/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Blakey <paulb@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Demi Marie Obenour <demi@invisiblethingslab.com>
Subject: [PATCH 6.1 41/42] netfilter: ctnetlink: Support offloaded conntrack entry deletion
Date:   Thu,  1 Jun 2023 14:21:50 +0100
Message-Id: <20230601131940.905506316@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -1559,9 +1559,6 @@ static const struct nla_policy ct_nla_po
 
 static int ctnetlink_flush_iterate(struct nf_conn *ct, void *data)
 {
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status))
-		return 0;
-
 	return ctnetlink_filter_match(ct, data);
 }
 
@@ -1631,11 +1628,6 @@ static int ctnetlink_del_conntrack(struc
 
 	ct = nf_ct_tuplehash_to_ctrack(h);
 
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
-		nf_ct_put(ct);
-		return -EBUSY;
-	}
-
 	if (cda[CTA_ID]) {
 		__be32 id = nla_get_be32(cda[CTA_ID]);
 


