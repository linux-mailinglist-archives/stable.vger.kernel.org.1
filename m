Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC20F74C2A9
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGILXO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGILXN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3818C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2713E60BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35900C433C8;
        Sun,  9 Jul 2023 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901790;
        bh=C8PLL0Cav3DkvT7QU9xIFOFJBnW6+Faals+hiEkzQE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zstq8DuDgVHlN7nYb5mwi7qptQXQeUr5qZ+cr4/+k57q7CCHtximnxoh+I/SSrAjz
         kGPOWZJIbUKVoK8Te/IUnIWNM76BSbpsTjjkxs4ID2+i1S8bA+DwZNCeQunySK1Owv
         N1yZLwT82BGekHYoezWP6fNrWbvKOVb2gMQwwXZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
        Simon Horman <simon.horman@corigine.com>,
        Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 145/431] selftests: rtnetlink: remove netdevsim device after ipsec offload test
Date:   Sun,  9 Jul 2023 13:11:33 +0200
Message-ID: <20230709111454.566647842@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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
index 275491be3da2f..cafd14b1ed2ab 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -835,6 +835,7 @@ EOF
 	fi
 
 	# clean up any leftovers
+	echo 0 > /sys/bus/netdevsim/del_device
 	$probed && rmmod netdevsim
 
 	if [ $ret -ne 0 ]; then
-- 
2.39.2



