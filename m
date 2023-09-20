Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A56C7A7D4B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjITMIO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjITMIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:08:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7CFA3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:08:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ACDC433C8;
        Wed, 20 Sep 2023 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211687;
        bh=JWUeEW/2wRF3OVfZp0jr1Cn3NgJUpHDhxnwpwaB3IVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vYC/1w/j7sl/Tlx8SJ7r3yKH4zXQXdjaNCwOTkYqDsUUrlVF2xKuGlWxyb4UVQsEE
         D1c59L/Zdng6hBJqKDZ6yEWVNkZYCbxSVOpU/IuftP8mFhTbNZmqjVAts/E0NwETrq
         ADRqh5+OwtJAKVpWBX63Y63bbe7CmTqzkrFpQd2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, valis <sec@valis.email>,
        Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        M A Ramdhan <ramdhan@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATCH 4.14 185/186] net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
Date:   Wed, 20 Sep 2023 13:31:28 +0200
Message-ID: <20230920112843.555347765@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: valis <sec@valis.email>

commit 76e42ae831991c828cffa8c37736ebfb831ad5ec upstream.

When fw_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: e35a8ee5993b ("net: sched: fw use RCU")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: M A Ramdhan <ramdhan@starlabs.sg>
Link: https://lore.kernel.org/r/20230729123202.72406-3-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Fixed small conflict as 'fnew->ifindex' assignment is not protected by
  CONFIG_NET_CLS_IND on upstream since a51486266c3 ]
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_fw.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -281,7 +281,6 @@ static int fw_change(struct net *net, st
 			return -ENOBUFS;
 
 		fnew->id = f->id;
-		fnew->res = f->res;
 #ifdef CONFIG_NET_CLS_IND
 		fnew->ifindex = f->ifindex;
 #endif /* CONFIG_NET_CLS_IND */


