Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B813770C9D4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjEVTwg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjEVTwW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1F133
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5F362B25
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3ACC4339B;
        Mon, 22 May 2023 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785112;
        bh=jjV+KCVi+vVsQ9e6G29qaHadYSqH5V2oSSXsT42SAt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMsDAtH+LJLxtTvHwcOgfU5ijJ8fRr1XfJUl9zinOv6gAwGpPSPb7RyWiL5we0pDs
         R7V832WN6DJE5tCAhyuwmFfe+pDAqaWG40HjI9AkSJwT/G1axqHgLUBraAlkmVJXJt
         weFC1Az52GtGCCBDqbixjhB5h+572SKbAxiQG99Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
        Benjamin Poirier <bpoirier@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 285/364] net: selftests: Fix optstring
Date:   Mon, 22 May 2023 20:09:50 +0100
Message-Id: <20230522190419.868537293@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Benjamin Poirier <bpoirier@nvidia.com>

[ Upstream commit 9ba9485b87ac97fd159abdb4cbd53099bc9f01c6 ]

The cited commit added a stray colon to the 'v' option. That makes the
option work incorrectly.

ex:
tools/testing/selftests/net# ./fib_nexthops.sh -v
(should enable verbose mode, instead it shows help text due to missing arg)

Fixes: 5feba4727395 ("selftests: fib_nexthops: Make ping timeout configurable")
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_nexthops.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index a47b26ab48f23..0f5e88c8f4ffe 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -2283,7 +2283,7 @@ EOF
 ################################################################################
 # main
 
-while getopts :t:pP46hv:w: o
+while getopts :t:pP46hvw: o
 do
 	case $o in
 		t) TESTS=$OPTARG;;
-- 
2.39.2



