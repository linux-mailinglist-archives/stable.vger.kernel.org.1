Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE876AFCC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjHAJuK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjHAJt5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582B1FCE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 213D561502
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0024FC433C8;
        Tue,  1 Aug 2023 09:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883366;
        bh=DRupaaE+vVPUtPS1r1zBnTBKkmlKU9OdyYBHqE8qY7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2l3P/FPY7dPl8za4sgQHZrMLo0axnVO/0fj2r8/QljQ1rvtj5DYrzTc9CV6huplgN
         I2WX/u9SjYT5yrtNWCe/qCm6s8pihYmxKDSilLf0o+fSyCy12F7f+Nr6mI/8R6YnWZ
         W9s5vPptw5rCXjIDXtKfNQI0ypJpbu4lwQU08Mhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 210/239] selftests: mptcp: join: only check for ip6tables if needed
Date:   Tue,  1 Aug 2023 11:21:14 +0200
Message-ID: <20230801091933.412455659@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 016e7ba47f33064fbef8c4307a2485d2669dfd03 upstream.

If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
used instead of 'ip6tables'. So no need to look if 'ip6tables' is
available in this case.

Cc: stable@vger.kernel.org
Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -156,9 +156,7 @@ check_tools()
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
-	fi
-
-	if ! ip6tables -V &> /dev/null; then
+	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
 		exit $ksft_skip
 	fi


