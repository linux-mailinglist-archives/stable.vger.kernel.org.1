Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D888975CF36
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjGUQ2n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjGUQ1u (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2B46B8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFB961D4C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B314C433C8;
        Fri, 21 Jul 2023 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956689;
        bh=bVElW7s5iEAUG2g+i06jPZaAZUCjPejyyvGsyttrzUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXu4UkI4TsbCGPiPajkjk6T4CtboEv7aulu/JzWhgdtTNkuytuM6fKZgjEXz6DtWg
         mVKSgDtyXq+Q5Tui+Hl3KRCGKNc4yS4ofCtVdAQgZ2YTNT9VVGvtkJ+BN7BBwQ5PJ/
         8vQH1PpOfDcG/IbAWO/GSQtWclf+1EgYtPp6hYpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.4 264/292] selftests: mptcp: userspace_pm: use correct server port
Date:   Fri, 21 Jul 2023 18:06:13 +0200
Message-ID: <20230721160540.270999461@linuxfoundation.org>
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

commit d8566d0e03922217f70d9be2d401fcb860986374 upstream.

"server4_port" variable is not set but "app4_port" is the server port in
v4 and the correct variable name to use.

The port is optional so there was no visible impact.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ca188a25d43f ("selftests: mptcp: userspace PM support for MP_PRIO signals")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -848,7 +848,7 @@ test_prio()
 	local count
 
 	# Send MP_PRIO signal from client to server machine
-	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$server4_port"
+	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$app4_port"
 	sleep 0.5
 
 	# Check TX


