Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5AA7D334C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjJWL3D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjJWL2y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:28:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7D10A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:28:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EBFC433C7;
        Mon, 23 Oct 2023 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060531;
        bh=shja3mgg3GP9nhfP2Ma8mh2W8x4lAK1hufwrv7RS2zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUW7BhXaVZmY2j7iNGIlCfVzcEFXm6+K5r7eP6yc9Gx9YeKTH7f3ITctTuDzD7AIg
         BGh5jnMMnL3BYPC/J04ZuZ4tA5BvbNz44wQu/ErLSDfFHMhgiEncdaC+FkwkC8GfHl
         0ubKWioEqyvwRo2axJLtETN/GejhfgKCXURDxtW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 196/196] selftests: mptcp: join: no RST when rm subflow/addr
Date:   Mon, 23 Oct 2023 12:57:41 +0200
Message-ID: <20231023104833.892438227@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts <matttbe@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   13 +++++++++++++
 1 file changed, 13 insertions(+)

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
 


