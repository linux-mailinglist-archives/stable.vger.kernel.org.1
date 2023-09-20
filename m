Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0C7A7EEA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjITMWC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjITMWB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:22:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A25D8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:21:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BFDC433CA;
        Wed, 20 Sep 2023 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212514;
        bh=ICpQIpEHX8hQuzcc2BHMAS+1DL/dliPrnk1WFijzjZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFOTUcaUoaf1wIKBrkQBVOnPomk42rpiOjTb57oeqcnxtgJoEqlxhWW/tVyXt3kHW
         aSHvcE23mfcubUipkGTStoj07+hBIR17djUX5BLgWwJtRv6Jpo4SL5jHHLYz2hh+J0
         849RdDBXR0Wfv4+mU7RiXX9bXwRpo72z6Rx7mgWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>, GONG@vger.kernel.org
Subject: [PATCH 5.10 22/83] netfilter: ebtables: fix fortify warnings in size_entry_mwt()
Date:   Wed, 20 Sep 2023 13:31:12 +0200
Message-ID: <20230920112827.543890044@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: GONG, Ruiqi <gongruiqi1@huawei.com>

[ Upstream commit a7ed3465daa240bdf01a5420f64336fee879c09d ]

When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
warning appears:

In function ‘fortify_memcpy_chk’,
    inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler is complaining:

memcpy(&offsets[1], &entry->watchers_offset,
                       sizeof(offsets) - sizeof(offsets[0]));

where memcpy reads beyong &entry->watchers_offset to copy
{watchers,target,next}_offset altogether into offsets[]. Silence the
warning by wrapping these three up via struct_group().

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
 net/bridge/netfilter/ebtables.c                |  3 +--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index a494cf43a7552..b0caad82b6937 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -182,12 +182,14 @@ struct ebt_entry {
 	unsigned char sourcemsk[ETH_ALEN];
 	unsigned char destmac[ETH_ALEN];
 	unsigned char destmsk[ETH_ALEN];
-	/* sizeof ebt_entry + matches */
-	unsigned int watchers_offset;
-	/* sizeof ebt_entry + matches + watchers */
-	unsigned int target_offset;
-	/* sizeof ebt_entry + matches + watchers + target */
-	unsigned int next_offset;
+	__struct_group(/* no tag */, offsets, /* no attrs */,
+		/* sizeof ebt_entry + matches */
+		unsigned int watchers_offset;
+		/* sizeof ebt_entry + matches + watchers */
+		unsigned int target_offset;
+		/* sizeof ebt_entry + matches + watchers + target */
+		unsigned int next_offset;
+	);
 	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 8335b7e4bcf6f..bab14186f9ad5 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2001,8 +2001,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
-- 
2.40.1



