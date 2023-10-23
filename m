Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4177D30E9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjJWLDk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJWLDj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:03:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF777D7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B0C433C9;
        Mon, 23 Oct 2023 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059017;
        bh=3cMHVZyOCNfWcJpUuGcgYZEoiqEJdt09gXYlWck0Fq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKVzlK0CIq0PQyGRovHEMo9ZxWsTmiI+7ksD3N59KsBNyqau81erIbxioiwnjt5kl
         nRwBzKnFtWAPiVB5b6zHWaiLF0UORqF+Li78KknrziKyzqVjXRay0RD3MHRsetlc4x
         mc3fNiwgc7p7ttJG/TPlWeGFwFNac7VcdJVkRPVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 028/241] selftests: mptcp: join: no RST when rm subflow/addr
Date:   Mon, 23 Oct 2023 12:53:34 +0200
Message-ID: <20231023104834.613132414@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2282,6 +2282,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# multiple subflows, remove
@@ -2294,6 +2295,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# single address, remove
@@ -2306,6 +2308,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflow and signal, remove
@@ -2319,6 +2322,7 @@ remove_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, remove
@@ -2333,6 +2337,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# addresses remove
@@ -2347,6 +2352,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses remove
@@ -2361,6 +2367,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, flush
@@ -2375,6 +2382,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# subflows flush
@@ -2394,6 +2402,7 @@ remove_tests()
 		else
 			chk_rm_nr 3 3
 		fi
+		chk_rst_nr 0 0
 	fi
 
 	# addresses flush
@@ -2408,6 +2417,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses flush
@@ -2422,6 +2432,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 subflow
@@ -2433,6 +2444,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 address
@@ -2445,6 +2457,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0 invert
 	fi
 }
 


