Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC57CA20E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJPIpU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjJPIpT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:45:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2CDDC
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:45:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C82C433C7;
        Mon, 16 Oct 2023 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445917;
        bh=6BtfgaXFzKikIq7aTaLEdFu3oXTHQMNHPrx+En19wio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=am3SD5EQ2fKwtkSVzVf5QEAHelN4F0UTycPWDh4WQ6tyN2msOiEiq1SE9ujKQdU5q
         X5xDcsba0cVLCW/1HTp64OzmdNl68OeVdVWx/STOJeOhIU38HPvKmPz7ovz3t8Y0Ip
         G6kYIM9nObHFms5bGle13n1ZX8j5xASiT8ELbQK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 037/102] ethtool: Fix mod state of verbose no_mask bitset
Date:   Mon, 16 Oct 2023 10:40:36 +0200
Message-ID: <20231016083954.689738238@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kory Maincent <kory.maincent@bootlin.com>

[ Upstream commit 108a36d07c01edbc5942d27c92494d1c6e4d45a0 ]

A bitset without mask in a _SET request means we want exactly the bits in
the bitset to be set. This works correctly for compact format but when
verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
bits present in the request bitset but does not clear the rest. The commit
6699170376ab fixes this issue by clearing the whole target bitmap before we
start iterating. The solution proposed brought an issue with the behavior
of the mod variable. As the bitset is always cleared the old val will
always differ to the new val.

Fix it by adding a new temporary variable which save the state of the old
bitmap.

Fixes: 6699170376ab ("ethtool: fix application of verbose no_mask bitset")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231009133645.44503-1-kory.maincent@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/bitset.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 0515d6604b3b9..883ed9be81f9f 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -431,8 +431,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 			      ethnl_string_array_t names,
 			      struct netlink_ext_ack *extack, bool *mod)
 {
+	u32 *orig_bitmap, *saved_bitmap = NULL;
 	struct nlattr *bit_attr;
 	bool no_mask;
+	bool dummy;
 	int rem;
 	int ret;
 
@@ -448,8 +450,22 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 	}
 
 	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
-	if (no_mask)
-		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
+	if (no_mask) {
+		unsigned int nwords = DIV_ROUND_UP(nbits, 32);
+		unsigned int nbytes = nwords * sizeof(u32);
+
+		/* The bitmap size is only the size of the map part without
+		 * its mask part.
+		 */
+		saved_bitmap = kcalloc(nwords, sizeof(u32), GFP_KERNEL);
+		if (!saved_bitmap)
+			return -ENOMEM;
+		memcpy(saved_bitmap, bitmap, nbytes);
+		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
+		orig_bitmap = saved_bitmap;
+	} else {
+		orig_bitmap = bitmap;
+	}
 
 	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
 		bool old_val, new_val;
@@ -458,13 +474,14 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		if (nla_type(bit_attr) != ETHTOOL_A_BITSET_BITS_BIT) {
 			NL_SET_ERR_MSG_ATTR(extack, bit_attr,
 					    "only ETHTOOL_A_BITSET_BITS_BIT allowed in ETHTOOL_A_BITSET_BITS");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		ret = ethnl_parse_bit(&idx, &new_val, nbits, bit_attr, no_mask,
 				      names, extack);
 		if (ret < 0)
-			return ret;
-		old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
+			goto out;
+		old_val = orig_bitmap[idx / 32] & ((u32)1 << (idx % 32));
 		if (new_val != old_val) {
 			if (new_val)
 				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
@@ -474,7 +491,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(saved_bitmap);
+	return ret;
 }
 
 static int ethnl_compact_sanity_checks(unsigned int nbits,
-- 
2.40.1



