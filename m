Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C872C18F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjFLK7B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbjFLKyo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F8198D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83717612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC9DC433D2;
        Mon, 12 Jun 2023 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566475;
        bh=I9tw31ccXAiapgDco5eiqTsmhE7JKVcE+ti8f88OeGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukhSxIOnBBVPkbcPYJ+uK19TzsSkShTE0R0QH5HUuqw0ntqmkqrZ+29Vb4hvNKp1B
         6iwKvuLmWMNWMvzpAFTeGKtpDYyZ/7K2e5zOg4r74XYmjx8YhKiUYXf4O9HnyWY3O9
         hPdF+/DaXHyeCkxsD5JbN/fnOHFEHCfZbt5icrwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/132] wifi: mac80211: mlme: fix non-inheritence element
Date:   Mon, 12 Jun 2023 12:26:02 +0200
Message-ID: <20230612101711.515390402@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 68c228557d52616cf040651abefda9839de7086a ]

There were two bugs when creating the non-inheritence
element:
 1) 'at_extension' needs to be declared outside the loop,
    otherwise the value resets every iteration and we
    can never really switch properly
 2) 'added' never got set to true, so we always cut off
    the extension element again at the end of the function

This shows another issue that we might add a list but no
extension list, but we need to make the extension list a
zero-length one in that case.

Fix all these issues. While at it, add a comment explaining
the trim.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230604120651.3addaa5c4782.If3a78f9305997ad7ef4ba7ffc17a8234c956f613@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0125b3e6175b7..dc9e7eb7dd857 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1143,6 +1143,7 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 					       const u16 *inner)
 {
 	unsigned int skb_len = skb->len;
+	bool at_extension = false;
 	bool added = false;
 	int i, j;
 	u8 *len, *list_len = NULL;
@@ -1154,7 +1155,6 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 	for (i = 0; i < PRESENT_ELEMS_MAX && outer[i]; i++) {
 		u16 elem = outer[i];
 		bool have_inner = false;
-		bool at_extension = false;
 
 		/* should at least be sorted in the sense of normal -> ext */
 		WARN_ON(at_extension && elem < PRESENT_ELEM_EXT_OFFS);
@@ -1183,8 +1183,14 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 		}
 		*list_len += 1;
 		skb_put_u8(skb, (u8)elem);
+		added = true;
 	}
 
+	/* if we added a list but no extension list, make a zero-len one */
+	if (added && (!at_extension || !list_len))
+		skb_put_u8(skb, 0);
+
+	/* if nothing added remove extension element completely */
 	if (!added)
 		skb_trim(skb, skb_len);
 	else
-- 
2.39.2



