Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BA7501D8
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGLIj6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjGLIjm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 04:39:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4B1BEB
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 01:39:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b734aea34aso16238821fa.0
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1689151163; x=1691743163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLlj4t6QPx5xJLcwgRWmKZxZiK7pcRIx6k2WdSSMdZQ=;
        b=JgVxyO3qrCe0u7rxhWXqyJ3IzCpumfzOWEtRhqEdBNDNyVbkZ5laTpcRG55aW3fwdF
         pc1OrGqiwhA4pUS+awbFeArDNJ2aoQGWOIMoSss2VxU1+GvvGsCeO0HSTxK5vYKN3iLW
         nZLf0MlrW2hXoGPwUR+kkFcYuMvj1ys+TB5INw4wbqvF8Bdv6H+Z86hM5pQV5om5ztO0
         GVL63eQJsDaXskF2e/xyL+HGlu/PGDeiky5DTPhbdd9LvE7eOv7NouDSeMNKn5h+d04C
         7cSWG8U10aV9jVpyaMO2bokk2FBNrufCOAQ1jlqOsTwQw3egEwVJ0pVJTI0D0tl3g0n5
         7LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151163; x=1691743163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLlj4t6QPx5xJLcwgRWmKZxZiK7pcRIx6k2WdSSMdZQ=;
        b=DPC2ADs3UGUnWFOclbmSFfutpxurf+R7DZWSjhO+cd7ZqbOm7O/1506iWoRSigiRJH
         yB7x3FROB564g76LhFSAvxeuTvlxOyUM0rb6V8msUi74Z6cgg4OGDrD56qB0MeKe3HpK
         +Q/U+3gGtJyUyhGw+7aAmgt0tFiyNOvoAoNvDMfF+M4A+4X3EuX/YJ1nFJmEZLcp2t+C
         Yr7joDXjrWZWm7xRLoM+aED96EWWXwS49RliyJwVb6hK0O7KcobWXKcTMSmDQbvfZB8h
         ThJ6CDLyNibseLRsdUHI84+eUHXknmONWub869MQ9S/GbMiOHTfylaNisVIjszuiYH5+
         MhJA==
X-Gm-Message-State: ABy/qLbSvfx5lXe/u5EIl61QAC6NXVJ8d7RnKwyBWLVnpejRvI9eI+37
        5LQJpLubbQjBWZAmYS6RyMtEqg==
X-Google-Smtp-Source: APBJJlFwgIN1+rxXltXzrqRBbaiuAin6N9z0EDqNSQWwQPePOoweBZ/rsjz1y7F01jHw+RZn5Pa8vQ==
X-Received: by 2002:a2e:9b8e:0:b0:2b6:dfef:d526 with SMTP id z14-20020a2e9b8e000000b002b6dfefd526mr13191954lji.11.1689151163091;
        Wed, 12 Jul 2023 01:39:23 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:4ca:30f::4e:5f])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bca48000000b003fbdd9c72aasm4471698wml.21.2023.07.12.01.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:39:22 -0700 (PDT)
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
To:     linux-wireless@vger.kernel.org
Cc:     Koen Vandeputte <koen.vandeputte@citymesh.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH] wifi: nl80211: fix mbssid nesting
Date:   Wed, 12 Jul 2023 10:38:41 +0200
Message-Id: <20230712083841.222607-1-koen.vandeputte@citymesh.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Executing command NL80211_CMD_GET_WIPHY and parsing it's output
natively without libnl shows following attributes as part of
the nl80211 generated netlink message (part 16):

GetWiphy: Type: 1
GetWiphy: Type: 2
GetWiphy: Type: 46
GetWiphy: Type: 33074 <-- wrong enum value, above MAX also ..
GetWiphy: Type: 316

Switching to nla_nest_start_noflag() which ommits the NLA_F_NESTED
flag (like most other similar functions do) fixes this:

GetWiphy: Type: 1
GetWiphy: Type: 2
GetWiphy: Type: 46
GetWiphy: Type: 306 <-- correct enum value
GetWiphy: Type: 316

Fixes: dc1e3cb8da8b ("nl80211: MBSSID and EMA support in AP mode")
Signed-off-by: Koen Vandeputte <koen.vandeputte@citymesh.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: John Crispin <john@phrozen.org>
Cc: Aloka Dixit <alokad@codeaurora.org>
Cc: stable@vger.kernel.org # 5.16
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0da2e6a2a7ea..4d4860f9428d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2359,7 +2359,7 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	if (!wiphy->mbssid_max_interfaces)
 		return 0;
 
-	config = nla_nest_start(msg, NL80211_ATTR_MBSSID_CONFIG);
+	config = nla_nest_start_noflag(msg, NL80211_ATTR_MBSSID_CONFIG);
 	if (!config)
 		return -ENOBUFS;
 
-- 
2.34.1

