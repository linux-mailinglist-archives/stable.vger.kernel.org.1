Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785E173E7A6
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFZSRQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFZSRP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B73EB
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C374660F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7AEC433C8;
        Mon, 26 Jun 2023 18:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803433;
        bh=qK7TlT94elqx1MVlR8o1gjntJshecXnUQuO2zEh6bMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3nHwHjqHkeCiOPeZlLOGJGD0etZPi3CT+JOgOHN5iZmeH0n+XqL1E33gKXeu3Suw
         nBsPb0KSNmy71E7ySx5iwjAbKWQJqJRx3EGPu1iej/nz6yfrbgjqcvGgcpc72/sjR+
         +HFZWolSkBQXQk6ElH15WoMe4meCXwPjuYlHhjak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 031/199] selftests: mptcp: userspace pm: skip if ip tool is unavailable
Date:   Mon, 26 Jun 2023 20:08:57 +0200
Message-ID: <20230626180806.985910348@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 723d6b9b12338c1caf06bf6fe269962ef04e2c71 upstream.

When a required tool is missing, the return code 4 (SKIP) should be
returned instead of 1 (FAIL).

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -8,7 +8,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"
-	exit 1
+	exit ${KSFT_SKIP}
 fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED


