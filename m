Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30E75D369
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGUTKU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGUTKT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336982D4A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4DBF61D02
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8132C433C7;
        Fri, 21 Jul 2023 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966618;
        bh=MJ8HLrCDxprasW1LpGoGY00A/Ud1Pxcfoh+1wfxwNHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2OK49ntPcfjI5dFM2bOB9LtvgoxtnCOIetH5hyctnTQLc3/kJ88eqYBUvWb1//5//
         +dbkHozwl8InlCPzIN+mTlFRZX6zv+QuLlzOWP7xnDmEY897inS68L/g5HD2tiGEFz
         XqIlinxGtj0UhKozTttwClbzxIx7rP0m9kbeKdsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florent Revest <revest@chromium.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.15 380/532] netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
Date:   Fri, 21 Jul 2023 18:04:44 +0200
Message-ID: <20230721160635.100180420@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florent Revest <revest@chromium.org>

commit 6eef7a2b933885a17679eb8ed0796ddf0ee5309b upstream.

If nf_conntrack_init_start() fails (for example due to a
register_nf_conntrack_bpf() failure), the nf_conntrack_helper_fini()
clean-up path frees the nf_ct_helper_hash map.

When built with NF_CONNTRACK=y, further netfilter modules (e.g:
netfilter_conntrack_ftp) can still be loaded and call
nf_conntrack_helpers_register(), independently of whether nf_conntrack
initialized correctly. This accesses the nf_ct_helper_hash dangling
pointer and causes a uaf, possibly leading to random memory corruption.

This patch guards nf_conntrack_helper_register() from accessing a freed
or uninitialized nf_ct_helper_hash pointer and fixes possible
uses-after-free when loading a conntrack module.

Cc: stable@vger.kernel.org
Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Florent Revest <revest@chromium.org>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_helper.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -405,6 +405,9 @@ int nf_conntrack_helper_register(struct
 	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
 
+	if (!nf_ct_helper_hash)
+		return -ENOENT;
+
 	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
 		return -EINVAL;
 
@@ -595,4 +598,5 @@ void nf_conntrack_helper_fini(void)
 {
 	nf_ct_extend_unregister(&helper_extend);
 	kvfree(nf_ct_helper_hash);
+	nf_ct_helper_hash = NULL;
 }


