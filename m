Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413EF7E238F
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjKFNMw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjKFNMw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:12:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3211134
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:12:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D49C433C9;
        Mon,  6 Nov 2023 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276368;
        bh=eX/QOd8o+z5qHcOAnIhsy0vZMD6G1UNKrYvYAY9SMmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1y0A3KCzaUZ/cFAKWERy1tuQ0tGMckO4H8jSr+rDknHcjDy0resEUpMc1RePB7wR
         uZsIxqLMK+Sc6wzyZWhvLMUvzmwVTXGnYJfTiVc5PYadhdjyVMcbF8PS3BZmY5YtNv
         qJoODbdWmgWsALZ52ioy8faVoR1jjSDDW3rADmoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 19/62] netfilter: nfnetlink_log: silence bogus compiler warning
Date:   Mon,  6 Nov 2023 14:03:25 +0100
Message-ID: <20231106130302.509115261@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 2e1d175410972285333193837a4250a74cd472e6 ]

net/netfilter/nfnetlink_log.c:800:18: warning: variable 'ctinfo' is uninitialized

The warning is bogus, the variable is only used if ct is non-NULL and
always initialised in that case.  Init to 0 too to silence this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309100514.ndBFebXN-lkp@intel.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index d97eb280cb2e8..c5ff699e30469 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -690,8 +690,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen = 0;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
-- 
2.42.0



