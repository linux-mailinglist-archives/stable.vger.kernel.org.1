Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B9A7D261B
	for <lists+stable@lfdr.de>; Sun, 22 Oct 2023 23:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjJVVdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjJVVdH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 17:33:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEBA93
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 14:33:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56389C433C8;
        Sun, 22 Oct 2023 21:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698010385;
        bh=g/hyyzZKVQ0+FqD1E/Rm91HvO2Mq26Gkt1fpii+h/RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stJA1F04zw6ln+ofRBvcNUOBwGACk5aPUrMxmg5j/dyS0uXYDtNk8GeKTYvYv8Cea
         y9LUBROfNQHFXBJGeTwHV2utSP4GVS3GIM1XkIfaurm1loeAQRzo8B5eOQU+BlWOYL
         BAX1VZtJlp0CQ72Y39agNWSoiLyhdI4KJ1svhGlS8dF6Dyi7AnY3J2Gz5L3/lf8PXr
         vyvzmygvsbNJvhGXNUVQqn57gv+qx3YvR7C2/Ucy7CB1s0W0lD5A+KubGsGy7VpBkh
         bpC3CefJbQPLjrGSKdMcc8puX0FfhtGN/7XpktjXShHToDNFd4yBIUlEInWkwyWEB3
         yTAPeyl7UuxuA==
From:   Matthieu Baerts <matttbe@kernel.org>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Matthieu Baerts <matttbe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: no RST when rm subflow/addr
Date:   Sun, 22 Oct 2023 23:32:29 +0200
Message-Id: <20231022213229.3394813-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102046-haven-jargon-a683@gregkh>
References: <2023102046-haven-jargon-a683@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192; i=matttbe@kernel.org; h=from:subject; bh=g/hyyzZKVQ0+FqD1E/Rm91HvO2Mq26Gkt1fpii+h/RY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlNZTtEfdDxr1Qwvec71bo4uHW+QUidaAKS7C4u SZUggWbTCmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZTWU7QAKCRD2t4JPQmmg c0psD/9DmsEowzfz24d0+KHBcfTprCVcSgwOUotBoOOhORC2n2oYm0E5AnwXMIoSw/q3+/qaHbW d+N/HxXft9z+z0NmsKIN7ugoANbhr2cTs5ZAIfnrB06BQ8K8C1W3sgtutMeNqQhK27hwA47Sa+N TpGGV6rgOTCqYbA2fg/u81JnIrBViV4Zg0rSxV6pgrr0nHHHHAmZes7ncWC//VowsdZAoBKx732 c1AsB1XK5JPYQMhQM1Nf4G9w3mhZ/Ww48+qC4rI16xnz1u378DyOZq4fHWMIZd9LTIOKVjueZlO SzqUrrIbaBWmDS7lxvs2vsYN0PewRCKuPDwoKBg0Dg7iwSUkk9DwDlNxBmsA/RNGKSLOXxASiR8 fAfmsariEv3T6A2BhQDoTAEhn8GMVVHzyUzjbM2djRVpyLQpQ+YjXdZMjTM3ZLrtraZK6EI0PcD uYFAaCPSXm595yM3p5VYo0mZjpuK+xhF1MIaR8wlvP3xieyrp4s0+mlFT52Qv/zdyUzyhTo6/5o z/lN1/khpzJQPlfb3jnmEHXSdCqVAgeB9JXvvS/37hR7RNTvPeYVuPGiUbw728Az851XOFlFhS8 18YPaRMLbxlSYVgFyDIpZiyC4/GWuI0TzS86dgajkSSOuDbC0mhkSYZMNIFQvDxD1u7N6woR5hf lzQ8R9ilmJ3XONQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
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

commit 2cfaa8b3b7aece3c7b13dd10db20dcea65875692 upstream.

Recently, we noticed that some RST were wrongly generated when removing
the initial subflow.

This patch makes sure RST are not sent when removing any subflows or any
addresses.

Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-5-17ecb002e41d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Backport notes
  - No conflicts
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8dcfcdba58c6..ea6fc59e9f62 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2263,6 +2263,7 @@ remove_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# multiple subflows, remove
@@ -2274,6 +2275,7 @@ remove_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# single address, remove
@@ -2285,6 +2287,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflow and signal, remove
@@ -2297,6 +2300,7 @@ remove_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, remove
@@ -2310,6 +2314,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# addresses remove
@@ -2323,6 +2328,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses remove
@@ -2336,6 +2342,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, flush
@@ -2349,6 +2356,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# subflows flush
@@ -2366,6 +2374,7 @@ remove_tests()
 		else
 			chk_rm_nr 3 3
 		fi
+		chk_rst_nr 0 0
 	fi
 
 	# addresses flush
@@ -2379,6 +2388,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses flush
@@ -2392,6 +2402,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 subflow
@@ -2402,6 +2413,7 @@ remove_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 address
@@ -2413,6 +2425,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0 invert
 	fi
 }
 
-- 
2.40.1

