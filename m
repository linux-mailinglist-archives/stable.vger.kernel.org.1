Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7BC7A8034
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjITMdw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjITMdv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:33:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39722CE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:33:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F76C433C7;
        Wed, 20 Sep 2023 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213224;
        bh=pjpVI0jV1UpnyDR2JDr1wd8E/nMZrACk7Lc6+dDuKbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6QRNTtIW7tO9Blgw4v5V/+maBKEPWj7wVY/BkAerhAwEQ6UPKjyHVrhN+Xe4HUv6
         sWdpdg+t3Sv831vf8na8rGC0yZb0UGOUgROjhhlttMABhdb4O8+RBiHCCieEndJcA3
         6U2xuO34cDtd9I7oq9MP1i1mRiLcTKoiQsC5f8Q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wander Lairson Costa <wander@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 206/367] netfilter: xt_u32: validate user space input
Date:   Wed, 20 Sep 2023 13:29:43 +0200
Message-ID: <20230920112903.951474259@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wander Lairson Costa <wander@redhat.com>

commit 69c5d284f67089b4750d28ff6ac6f52ec224b330 upstream.

The xt_u32 module doesn't validate the fields in the xt_u32 structure.
An attacker may take advantage of this to trigger an OOB read by setting
the size fields with a value beyond the arrays boundaries.

Add a checkentry function to validate the structure.

This was originally reported by the ZDI project (ZDI-CAN-18408).

Fixes: 1b50b8a371e9 ("[NETFILTER]: Add u32 match")
Cc: stable@vger.kernel.org
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_u32.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/net/netfilter/xt_u32.c
+++ b/net/netfilter/xt_u32.c
@@ -96,11 +96,32 @@ static bool u32_mt(const struct sk_buff
 	return ret ^ data->invert;
 }
 
+static int u32_mt_checkentry(const struct xt_mtchk_param *par)
+{
+	const struct xt_u32 *data = par->matchinfo;
+	const struct xt_u32_test *ct;
+	unsigned int i;
+
+	if (data->ntests > ARRAY_SIZE(data->tests))
+		return -EINVAL;
+
+	for (i = 0; i < data->ntests; ++i) {
+		ct = &data->tests[i];
+
+		if (ct->nnums > ARRAY_SIZE(ct->location) ||
+		    ct->nvalues > ARRAY_SIZE(ct->value))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct xt_match xt_u32_mt_reg __read_mostly = {
 	.name       = "u32",
 	.revision   = 0,
 	.family     = NFPROTO_UNSPEC,
 	.match      = u32_mt,
+	.checkentry = u32_mt_checkentry,
 	.matchsize  = sizeof(struct xt_u32),
 	.me         = THIS_MODULE,
 };


