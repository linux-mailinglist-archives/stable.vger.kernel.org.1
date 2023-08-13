Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D077AC82
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjHMVd5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjHMVd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DEF10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C17B62C4B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E424C433C7;
        Sun, 13 Aug 2023 21:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962437;
        bh=HkkzLu+tmFeUpnrXMfZTq/oDnzvaFhYmeagV0z7zy5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYi+saxcDsykMEt/42FWIG0HRBREWl1iY5NcaKeTnbtdpWfGEr4CKl2+c6QaZnXeo
         NgeY+IMr5gz5b6YftMEh82UqeXhruxwg1dk6puJMyuv+zydDQJxcDGQPUZbCPPcw87
         AjCZjuiSI7P1eqtnJ61QzXDWgxqF27nVxyhZg2xQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Keith Yeo <keithyjy@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 009/149] wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()
Date:   Sun, 13 Aug 2023 23:17:34 +0200
Message-ID: <20230813211719.075708601@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Keith Yeo <keithyjy@gmail.com>

commit 6311071a056272e1e761de8d0305e87cc566f734 upstream.

nl80211_parse_mbssid_elems() uses a u8 variable num_elems to count the
number of MBSSID elements in the nested netlink attribute attrs, which can
lead to an integer overflow if a user of the nl80211 interface specifies
256 or more elements in the corresponding attribute in userspace. The
integer overflow can lead to a heap buffer overflow as num_elems determines
the size of the trailing array in elems, and this array is thereafter
written to for each element in attrs.

Note that this vulnerability only affects devices with the
wiphy->mbssid_max_interfaces member set for the wireless physical device
struct in the device driver, and can only be triggered by a process with
CAP_NET_ADMIN capabilities.

Fix this by checking for a maximum of 255 elements in attrs.

Cc: stable@vger.kernel.org
Fixes: dc1e3cb8da8b ("nl80211: MBSSID and EMA support in AP mode")
Signed-off-by: Keith Yeo <keithyjy@gmail.com>
Link: https://lore.kernel.org/r/20230731034719.77206-1-keithyjy@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5378,8 +5378,11 @@ nl80211_parse_mbssid_elems(struct wiphy
 	if (!wiphy->mbssid_max_interfaces)
 		return ERR_PTR(-EINVAL);
 
-	nla_for_each_nested(nl_elems, attrs, rem_elems)
+	nla_for_each_nested(nl_elems, attrs, rem_elems) {
+		if (num_elems >= 255)
+			return ERR_PTR(-EINVAL);
 		num_elems++;
+	}
 
 	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
 	if (!elems)


