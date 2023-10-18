Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D07CE648
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjJRSYI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjJRSYG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:24:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1422114
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:24:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254BFC433BF;
        Wed, 18 Oct 2023 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697653444;
        bh=KZ6N65Nkl5YNxcN1w6vYt0uy5Mo7hWRtrXVthBvScVQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qgHppDzn1lteN27ftYSRGn1OItTRhdHkeXOxxWx3DlIhx2Z4kqwxj56FDfE7Z4WAs
         5r1ytCFEPMxUiKwTWXeOIBxjyOH00RfS1S3JZrUt2pC6yUs9WmpGYf3JRGRYv93+9W
         Srjd0CY6+A6JoOe46C6oOfemi2d3H+Tmckq0GkDCv53G4wxNblQnK1HOsXae+7H0t3
         4fP0ZpvqYbtqGXEGN36rGj6ykYTlhHRyVnfqZE2H/if6lN1eJtSzax3qXYnw/xZXJn
         UTG1B7v0gWze0fQKWkpW7gmaO6Ivjmh8SjEU22nH7UhVFaRtslZfsixec/oVlYMbHC
         ij4MjqjEneoWg==
From:   Mat Martineau <martineau@kernel.org>
Date:   Wed, 18 Oct 2023 11:23:56 -0700
Subject: [PATCH net 5/5] selftests: mptcp: join: no RST when rm
 subflow/addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-send-net-20231018-v1-5-17ecb002e41d@kernel.org>
References: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
In-Reply-To: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matttbe@kernel.org>

Recently, we noticed that some RST were wrongly generated when removing
the initial subflow.

This patch makes sure RST are not sent when removing any subflows or any
addresses.

Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 27953670206e..dc895b7b94e1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2309,6 +2309,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# multiple subflows, remove
@@ -2321,6 +2322,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# single address, remove
@@ -2333,6 +2335,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflow and signal, remove
@@ -2346,6 +2349,7 @@ remove_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, remove
@@ -2360,6 +2364,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# addresses remove
@@ -2374,6 +2379,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses remove
@@ -2388,6 +2394,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, flush
@@ -2402,6 +2409,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# subflows flush
@@ -2421,6 +2429,7 @@ remove_tests()
 		else
 			chk_rm_nr 3 3
 		fi
+		chk_rst_nr 0 0
 	fi
 
 	# addresses flush
@@ -2435,6 +2444,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses flush
@@ -2449,6 +2459,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 subflow
@@ -2460,6 +2471,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 address
@@ -2472,6 +2484,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0 invert
 	fi
 }
 

-- 
2.41.0

