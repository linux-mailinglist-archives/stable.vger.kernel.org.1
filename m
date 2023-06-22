Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492473A276
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 16:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFVOAM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjFVOAL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 10:00:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C310D2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:00:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so9096670e87.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687442407; x=1690034407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a5J59GVql3BgVtfmlqQaU3vg9QV5AJeyGRWsWBUKug=;
        b=eern3npGg8q/Pa9WOa91deLqOjVe7N3ktx79sZf+8Hp5zJsm3JY+loq5FUmRNm7kSd
         tkBIthopUjVkOGjU7cVk7VfIbdLv6kq+Vyzqh8RRVBrrhcKpyy/7GwUS0487IJ+YQrYz
         eYDma6HY3f7Z+KRiXieP3cBktbstshXm1AXo9bQ1IAZqo4wcX/cneuF48WJF5icec2LY
         uiV2rn9CHSxZ9Gan04LYPwyBCO08VgI4Ucu3ygIdlhc8Ee38cXUOQ1TocNW3pOQPvzoB
         /Gmuz2+bHMe2E0rEtk4Y7v2BIEyxfIjqh9OxlNpP/F5ClEcukrCcIyUi5Dn4uQ60LxYv
         p9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442407; x=1690034407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a5J59GVql3BgVtfmlqQaU3vg9QV5AJeyGRWsWBUKug=;
        b=Z5Cotv/2iQ30aYwLpitTYWpfkmCUhtrEQ3FqVEficlzHewB9tnks6ZE33rVea1eEmC
         BwaJV/Sx0+aYrE5boSd3tKpYS/qg1AGysrVS0hixb97c/1nBuBV3yhZOocp4+SW4VMyA
         4Ys4/ceojuzgdJOLVmY4zZXSA7p5NABo/TmJvHg0j9FTCZ+TuKsViQ2//wwE2gY0l9Og
         3tjbf6w0NEahBwxipz9kltUGJ2v8tpqCl02JbIGazUETZibCRIbXX1qa79OoIWXICeu+
         N4OAW/JJnthDxUSjtbbaRXcucJsV9TKSSi7dh0HjBkzSRwPlvvIrS2/+a0jBi0vGjs5z
         j8WQ==
X-Gm-Message-State: AC+VfDySWez+Xn5pipb0/sfkKnMtB51HJdH/JRLoSrX0XZnGjA59Cd78
        RLV2YJKIlyAbr+eP22TgsSCwVqwWvIFYsNJidsoc9g==
X-Google-Smtp-Source: ACHHUZ7ptJoIYAUY5ulcUkVhP3r6D9nweVfEwkyoDKYB9zD9Rd3W9Ol2COCCvoTNIVGkbOBXwP+YaA==
X-Received: by 2002:a05:6512:60a:b0:4f8:5635:2ccf with SMTP id b10-20020a056512060a00b004f856352ccfmr12470115lfe.8.1687442407478;
        Thu, 22 Jun 2023 07:00:07 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u16-20020a7bc050000000b003f080b2f9f4sm18868083wmc.27.2023.06.22.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:00:07 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 1/2] selftests: mptcp: pm nl: remove hardcoded default limits
Date:   Thu, 22 Jun 2023 15:59:47 +0200
Message-Id: <20230622135948.3245451-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062217-never-sedan-c4bd@gregkh>
References: <2023062217-never-sedan-c4bd@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2831; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=YnUxKN7nqPk9pCDkrnamxSIiEa1HUL3Wc6d3f8Ej/ko=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklFPULi5lzD/j+pulQM4Gf5fMXGCxHlAezJ4di
 y9xRQ5XY4SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJRT1AAKCRD2t4JPQmmg
 c42oD/9BMWoCdRUfKpaIwFbLZW0fVV3vSHDMwi31Ahw6/VwFYs4sk1LhOG+CkVC157fWXK3tNYk
 3SUzQlR+L2zmPsCcvDPRCEM2tArcOy/w5FYl2R2CXuafHWOW6y43HevN/eAN7Iqq7qEDJVo8+CA
 gRNZC/nK5k71W47YEtAn6IQ8sCwZCQzvew52FqoozFMGzU02IhC+A2veeAdkMFwaOo4bhMxmd2z
 991krgGn4nseFRl0e4jEgvkPerUwA00uvBRyTaLiLItRNgoKRMxALI3FcwqZiV+cm07dXqMs6jj
 PebVbZ7RTbOQcOjnGnWea+YkST79Uyd+TzAXylDSlF0+J2QyPNbKWKPppng/etryrFVCIypeeJr
 MSWX7vmUYYvPl2z9USdkvn8U3/KkGGAJAERpys404Lf3TWLJ/+O7xPl1SYRhrigsxx25H9Jb1Qy
 u3KHLdNGU/uhTXHR9kqwCRq8o3VtmtVp3K+oWdeluLHLj0fAVb11/KsS9BLHfsdAutazGiq+rKi
 rLaWD6F/S8IWMg1eIOiyHlvGmDVRPI6uIflJbLdVJMNiBvHjRe+MRQuH+W2W/lit7wq3qRpzSxO
 Kpbyq7s1vg12zcjnMnwhXn3K8RZgzM+gk4/Qjj7U8+lQ3kXeUV8k0DOHOHsYh4WAfq9FmI4gyQx RwKTuMGTsi5E3kw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 2177d0b08e421971e035672b70f3228d9485c650 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the checks of the default limits returned by the MPTCP
in-kernel path-manager. The default values have been modified by commit
72bcbc46a5c3 ("mptcp: increase default max additional subflows to 2").
Instead of comparing with hardcoded values, we can get the default one
and compare with them.

Note that if we expect to have the latest version, we continue to check
the hardcoded values to avoid unexpected behaviour changes.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Applied on top of stable-rc/linux-5.10.y: e4636b6297b0 ("Linux 5.10.186-rc1").
Conflicting with commit 72bcbc46a5c3 ("mptcp: increase default max
additional subflows to 2") as expected: the old hardcoded values have
been used here. Same fix as the one proposed for v5.15.y.
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index f7cdba0a97a9..fff6f74ebe16 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -73,8 +73,12 @@ check()
 }
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+
+default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+if mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
 subflows 0" "defaults limits"
+fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -120,12 +124,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 0" "rcv addrs above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 0" "subflows above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-- 
2.40.1

