Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C1A75CF37
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjGUQ2o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjGUQ1s (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4246B1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD7F61D2A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD5C433C8;
        Fri, 21 Jul 2023 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956685;
        bh=YQjaQs+1ccR62jAFmAIXNwuYZ9Et5ZFmwreYA8BAVX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYm6xP8Z1+In3/H4uonFKWf2mNd+3+cHBI6ZCFfbj0lT03nrB3zC4DDL/QV23tH6v
         p5FmkngXiSJ8E0mfpigOAxNOVq3ywWpTLeKLF61noWLrtLouqnj3EkRKx9l+WHBvar
         0dIsztbmYwK5hy3Q+E3XAc82567b+IG/JEwdScFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.4 263/292] selftests: mptcp: sockopt: return error if wrong mark
Date:   Fri, 21 Jul 2023 18:06:12 +0200
Message-ID: <20230721160540.229819852@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 9ac4c28eb70cd5ea5472a5e1c495dcdd597d4597 upstream.

When an error was detected when checking the marks, a message was
correctly printed mentioning the error but followed by another one
saying everything was OK and the selftest was not marked as failed as
expected.

Now the 'ret' variable is directly set to 1 in order to make sure the
exit is done with an error, similar to what is done in other functions.
While at it, the error is correctly propagated to the caller.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -128,6 +128,7 @@ check_mark()
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			ret=1
 			return 1
 		fi
 	done
@@ -227,11 +228,11 @@ do_transfer()
 	fi
 
 	if [ $local_addr = "::" ];then
-		check_mark $listener_ns 6
-		check_mark $connector_ns 6
+		check_mark $listener_ns 6 || retc=1
+		check_mark $connector_ns 6 || retc=1
 	else
-		check_mark $listener_ns 4
-		check_mark $connector_ns 4
+		check_mark $listener_ns 4 || retc=1
+		check_mark $connector_ns 4 || retc=1
 	fi
 
 	check_transfer $cin $sout "file received by server"


