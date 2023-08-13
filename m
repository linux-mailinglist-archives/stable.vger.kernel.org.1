Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8275C77ACF0
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjHMVit (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHMVis (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03A10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFB16379F
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A015AC433C8;
        Sun, 13 Aug 2023 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962730;
        bh=NN/eqOZXS7wT3jpbo6YSXlVEQyQHTlH1ly8FxJZOlC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VT/d4FHCFQhk4KjBUjWuEm/CXqfs6prGF4U/1FLYi1Yz1ODRCgUUEb4K8tT/nek7b
         ysl/E88C6dzDUi1Qh9iz+PxtCIqb596AuTl0OmlVB2e8GuXIYG/LjLb7dOh4U7STrK
         hsbVeaqDrUZjgjAhXoi4ADXIZkueLjl9wBg2GEkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 101/149] wifi: cfg80211: fix sband iftype data lookup for AP_VLAN
Date:   Sun, 13 Aug 2023 23:19:06 +0200
Message-ID: <20230813211721.802689407@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

commit 5fb9a9fb71a33be61d7d8e8ba4597bfb18d604d0 upstream.

AP_VLAN interfaces are virtual, so doesn't really exist as a type for
capabilities. When passed in as a type, AP is the one that's really intended.

Fixes: c4cbaf7973a7 ("cfg80211: Add support for HE")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/20230622165919.46841-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/cfg80211.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -562,6 +562,9 @@ ieee80211_get_sband_iftype_data(const st
 	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
 		return NULL;
 
+	if (iftype == NL80211_IFTYPE_AP_VLAN)
+		iftype = NL80211_IFTYPE_AP;
+
 	for (i = 0; i < sband->n_iftype_data; i++)  {
 		const struct ieee80211_sband_iftype_data *data =
 			&sband->iftype_data[i];


