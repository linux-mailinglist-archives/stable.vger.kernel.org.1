Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54775D4DE
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGUTZs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjGUTZr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:25:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D112D47
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC49661D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0DBC433C8;
        Fri, 21 Jul 2023 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967546;
        bh=w2rkzb4Guf2O8Lwab5b7FrP6HKqGDDF5uA1mgG/Cbxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcO9YuZ90C9SIK9l2JEuj9Ufdw0V1pWe1/b2fFvNR397ubl0EGjYekhw/5vUd83Ld
         DScYWJL4yDJpRo0ceOqEOmMpp1/W2qtVWWW8uzHmmOtpUwONDcOTcHUdayBLo/w5cM
         CHt9YBly/mUF1lKvPHztNr7xmZ/sgHqcO78VEidQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 199/223] selftests: mptcp: userspace_pm: report errors with remove tests
Date:   Fri, 21 Jul 2023 18:07:32 +0200
Message-ID: <20230721160529.361423250@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 966c6c3adfb1257ea8a839cdfad2b74092cc5532 upstream.

A message was mentioning an issue with the "remove" tests but the
selftest was not marked as failed.

Directly exit with an error like it is done everywhere else in this
selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -387,6 +387,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -401,6 +402,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR from the client to server machine


