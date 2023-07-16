Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC533755210
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGPUDY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGPUDX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B029D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BD2F60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1BAC433C7;
        Sun, 16 Jul 2023 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537801;
        bh=TukPhmvxnHNVGIj+rydqQQiaM1s8jdt/fw4LTDA9EXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2abMgscLumxuESFfvIIBEKZvS3Effzq80/78orFhkORH4pU/Vmzi3KioD/gk61TKD
         XRMTlotJ4M0/NzVj69fjg3IoHKDdaYwyrnis8zLM2xzRgau+gMH8eemI7BdlkYIXgK
         tB52y5sLnqp1o5Af3DE3UiOcEVB2bgQugbzxBZiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
        Simon Horman <simon.horman@corigine.com>,
        Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 208/800] selftests: rtnetlink: remove netdevsim device after ipsec offload test
Date:   Sun, 16 Jul 2023 21:41:01 +0200
Message-ID: <20230716194953.928966895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 5f789f103671fec3733ebe756e56adf15c90c21d ]

On systems where netdevsim is built-in or loaded before the test
starts, kci_test_ipsec_offload doesn't remove the netdevsim device it
created during the test.

Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/rtnetlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 383ac6fc037d0..ba286d680fd9a 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -860,6 +860,7 @@ EOF
 	fi
 
 	# clean up any leftovers
+	echo 0 > /sys/bus/netdevsim/del_device
 	$probed && rmmod netdevsim
 
 	if [ $ret -ne 0 ]; then
-- 
2.39.2



