Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7173A53B
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjFVPnV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjFVPnU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 11:43:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0143EA
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 08:43:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa71db41b6so9194765e9.1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687448597; x=1690040597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RL2ww5BhWG5HnLODSjWyX0LPEFZNLOp9429c6VUhcsg=;
        b=zRbtUkr47Bors4qz9RCh81gmBky2QP9LRtmLksWsD1Uo4TgICVH+R8aqVsfEPp2V9a
         XIpfs0Zh8pP0HuP6miqH5gKXkx+ZUV1Ye5X010p22NR0br6qSJGXhe369sGD5+8hFS2j
         ialQDyovZorm39xrj29JAWhn3g6P2Msw9yGGuUbMhmcM59lWNOfAN0w/Of+AkAybiU7z
         XDBai01QM3HgPzJuGg5urh/WFCIJfDrcTOfOwQpPzml+SewGH2DLN7+pc0RD6sJwBfvY
         WWeQjNjJ4Xr34R4n6u0ukNMElQhvT33U17rxMkbYLQj9NyPRyegcLcSAZ93+Gu9c6OWT
         WlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687448597; x=1690040597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL2ww5BhWG5HnLODSjWyX0LPEFZNLOp9429c6VUhcsg=;
        b=CLEWoH1R1RRy1ehgqYd3BFAiw0DfQ3OS+BAOZ/D0Wh+mb4w0Voj6NdZUgiTGNoaEV9
         KFNPodQ+FV3nrvbqfRPeAqgG8g6lstPkqN1SEQ5MmjyZSa98oD23Kw0bpwjzG/WFX9Pf
         EJGcHp7UvN5Ae//hCaK6O10P9QCk2LkgVrYehTJB+dYesp9j4voII8ZYvwt8fsFTHvfm
         3kKW9fmw4wPHX4PGIBFttYAYPgISO0JnQzEmsB+EonbNzruJGonq4wWuAk8ppzkPXTv7
         Lp4gp+Vij5JiH3wkythVmSsqPyry8AigC4Q6n+Z1Fn2/mlxPmtBwSPUHGdt0Q5VLPrrb
         nveg==
X-Gm-Message-State: AC+VfDzpK/a6MgdJyLRbMOUTmhln0fwX7qP/I2kLOftn0PFYDzNFWvh3
        aV6z0vKuwVXHci5KawXP9y+fIuEfrv9YIsHM6H3HgSkN
X-Google-Smtp-Source: ACHHUZ6TdIaTIuV2ZZvYJyiNoQhA+63sLgCnnOkLIphaq8JI7v3c6LkN6eLRdEHiz8qBU8OmVQv+GQ==
X-Received: by 2002:a05:600c:2288:b0:3fa:3188:5ee5 with SMTP id 8-20020a05600c228800b003fa31885ee5mr1885515wmf.38.1687448596197;
        Thu, 22 Jun 2023 08:43:16 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003f8126bcf34sm19043176wmc.48.2023.06.22.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:43:15 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 6.1.y] selftests: mptcp: join: fix "userspace pm add & remove address"
Date:   Thu, 22 Jun 2023 17:43:07 +0200
Message-Id: <20230622154307.3362179-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=/COgABNFKEmpsVCn7H/JN7gcVURv0ckEQOgHuis7UI0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklGwLVua3X/RURsj8DnGYtHqlF+hZllNDkyTq7
 16IaUAvspiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJRsCwAKCRD2t4JPQmmg
 c2mqEADgCKv85HPLCHKCDN1XTe2DNRDjh4eht/LiQIl/wMOVYTUlZP8MysTkTHQCiP/k2QUNEgK
 kReldYPu8AZUVamnEOyYSHDSafth95i5hQ6icIn9jFhRR+sNJE93dwAcI8t5gPwDCdAGOKrb0yb
 43Dmt8zdcIGEstCToazlMV3/Ezojv9NYJ4G3aXkJl2NjMcMJZ5VvaMiV/2N4YZIwt9QGuDeTeiD
 XlzKtKPQm9FLvsWlG2ZOP2CzaS2HkxB9SJFr6Q4Z08JxdyxSlWh+N33JDMitFBrRKbnpideQNSQ
 55iJDtMwzrsRO/0aUvh+tZzvOXlEkbm4WD0atR5OMaRQZMshZIT8HzoakcZqrpwENlP56kC29KY
 FAh8bg59qUALoNiKiqy0A40rTg0uzw6GUaEWH8veuVJqf4YgPcl5/9LnBC8ZRgjszwz3bWb1fXQ
 oecPLmb9VgA+qQHc1U0M8Tr4YUCfP+oxtumNsJU7/QyRhKXJE1eoq5qkz4syxFYk4kZw1E3n8yh
 QOoo5/qJZ7h5t7OdqobMojKq9Ak8KBX7fEFsLFwaBvGrMF/RFH9nNbJ7vTS+rn5uW2Dj0Bwx//f
 e16dY2LsP3nj1ozQGWRHXFJlKa52MIcVZdKxc+BgvIeXKnQUrHttA2AYWh156vi43wZpS4vA74q pxDScUtj+Qc0Rxg==
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

It looks like this test was broken in v6.1 after the backport of commit
48d73f609dcc ("selftests: mptcp: update userspace pm addr tests").

It was not working because the commit ad3493746ebe ("selftests: mptcp:
add test-cases for mixed v4/v6 subflows") is not in v6.1. This commit
changes how the connections are being created in mptcp_join.sh selftest:
with IPv6 support always enabled. But then in v6.1, the server still
create IPv4 only connections, so without the v4-mapped-v6 format with
the "::ffff:" prefix like we have in v6.3.

The modification here adds a support for connections created in v4 as
well so it fixes the issue in v6.1. This patch is not needed for the
selftests in v6.3 because only IPv6 listening sockets are being created.

Fixes: 8f0ba8ec18f5 ("selftests: mptcp: update userspace pm addr tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2a238ae842d8..7b65003ee8cf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -946,11 +946,12 @@ do_transfer()
 				sp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				     sed -n 's/.*\(daddr[46]:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				echo "$da" | grep -q ":" && addr="::ffff:$addr"
 				dp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "$addr" \
 							lport $sp rip $da rport $dp token $tk
 			fi
 
-- 
2.40.1

