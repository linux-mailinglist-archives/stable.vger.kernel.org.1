Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B073A01F
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFVLzw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 07:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVLzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 07:55:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C97198
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 04:55:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so78478715e9.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687434947; x=1690026947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVao/hK8VZsegV6qs3KkWNwFP5NQSX2BJeu15YkZ3l4=;
        b=LYD2a0jN496MqDvBqTJCap8oVErm/LbJHKlc8R35/K7rwWye450tH3OikuwU6oeaX/
         FNzNFWGQ6OAB21V7O79x7mqEZxzrVidX4acP/FZrEZ/KM90MU/c6n+pSlXiz7Gr18BNC
         0e/J3drEiuUM8W9DtywaetK+yXdnxBeuhS90+zZCrIooAzEVMtklllGKP4yG9kJiN7t3
         PLvj8bA7AvhHnVeCEyrNUD7qystXCtJ1EHiHigaenIsHXFRFt8AePqt+a84ujd/GLskv
         M3fRcQEoYzfleS4wGJPD71bf0rDKeEqzXTO6IlXsTyBmwRL7ziSoavTvDnRuVgdGNdnc
         hKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687434947; x=1690026947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVao/hK8VZsegV6qs3KkWNwFP5NQSX2BJeu15YkZ3l4=;
        b=RIA/7upLp1vRjJyHI6ejd/1axq8s7FvxP+zLE0u8y2hv5/Jln+T39UiTj1uX9K//hf
         aSBwhvUjEys5pDT0VFlihPNnr2XQeK9iwSXzvQEojC9KkoyYJslzI+wIw4Fb2sXRUn5D
         avkVvC1ppQfijOhrsp/p1nEk7hmgsWt1m5evESO+z1Xi0+BJfBzCT+6pr85grELwz1Nk
         22u+Oy5OHA+1Lztyr3Sk6675g3tN4Ioaw3e8QGfh8Z5AXtsxJwIXsZ/L6kIKAo1ptJU0
         NdBfev+ZdrMrlD0l0q9RHRrqQbJDqsViOmh7otMN3k2FDaAiLcqEkpbQdn+FFtb1jFj+
         X7Gw==
X-Gm-Message-State: AC+VfDxyMb/+igua2WKBXqxRcXkzIRCXUH7f83LHh1wLO1/OsFz6Dh3B
        6mec+eEhxy+f986ZpQk0NIELNJZSl+YEOHtA48nosw==
X-Google-Smtp-Source: ACHHUZ76NBh+FVOOxgIVXYRvQwCBY9zekguKBK5qm7qayDORihRhqaBP1ZjiUumZqK5w9peNoDRquQ==
X-Received: by 2002:a7b:c399:0:b0:3f9:bb88:7086 with SMTP id s25-20020a7bc399000000b003f9bb887086mr5714163wmj.38.1687434946903;
        Thu, 22 Jun 2023 04:55:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003f8126bcf34sm18533280wmc.48.2023.06.22.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:55:46 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: pm nl: remove hardcoded default limits
Date:   Thu, 22 Jun 2023 13:55:38 +0200
Message-Id: <20230622115538.3103008-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062216-ungodly-humorous-f47d@gregkh>
References: <2023062216-ungodly-humorous-f47d@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=t7rYmd9A5I+NicucipL0k2/6tGFCaLRTE/7LlaMSedg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklDa6fq4fCwDWy1M1i6Yoplnf0MtmEi+IVHc0q
 3/ddXvqZuSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJQ2ugAKCRD2t4JPQmmg
 c9SWD/9qKOGJ9jKpKMK1sTfZHXVBzRzYk2B3Pvh4bnBoMj3Ubg4HzMkTlQhe2A8WXV2J15PpU4r
 FPSCcQYz6iH2T771miaUuQAgo7SYdc7zAa4RQLvq3MmaYZDYC5c7vgYbZ0pT9gTl92hIILt1Yfp
 WH1G7rt0ZZLhQN3Qkz9g2H6aTmDPG6krSKN1AoofHwvMTU63Wi5YFEM9GTM7ngPA1lmnGvEYVn3
 2HxTUep3aCDVf6e2O0G6oEUBINuaZsm+7CkF3jP1VAAZ25GKDvlCnB/osrXHp08oWSNO0pZClQy
 hJuSsIPKvuCuYWvl8oh7JthKeb02+B8R+lPnc5lN+qq4TOsG1AoK65pRiBLhJtYeQddqsyDi17F
 DqSwQLkNx7usiwB6IvzE491nXu7Fv6MrjbFyj7TeV4EbMr94uP8J2DND9lZRxxA+IZ9vAQk5a6o
 BpSQE6woSZeydsTAxW36HPkw0FL6goLyzs+j9H7aPBVapJhhT4B9aYvILUmxQRRRueGkcHH2uGz
 scVkqQYO6SQyOwADat5iAStgvhIc3bIPXvrrBJwHbLE26T390e3mImLpzz9tf0q7PQlyU0n+oj5
 tkuvpLd+X6wVhqUYNdv6JqNYOWj6y2c2rlHiqttbkjyIc6CrQgp/xPjqbEQrAbC6+x4g1L65RJb 11GEvOmq8CdSzmg==
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
Applied on top of stable-rc/linux-5.15.y: d2efde0d1c2e ("Linux 5.15.119-rc1").
Conflicting with commit 72bcbc46a5c3 ("mptcp: increase default max
additional subflows to 2") as expected: the old hardcoded values have
been used here.
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 7fb06c854852..306372b1526a 100755
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
@@ -121,12 +125,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
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

