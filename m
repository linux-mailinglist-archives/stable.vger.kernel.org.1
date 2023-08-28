Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCC78AA21
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjH1KTE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjH1KSl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A83983
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1999863778
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2FCC433CA;
        Mon, 28 Aug 2023 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217905;
        bh=nr/CPPwyKFq0/GRtKHySGtFiS+hF4Q1EnJ2rB8lGq+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBTzxp17y5vYxpAvfOm5crK2/sFZN2S9Mnxc96obhrbJTMtad7GbQVUPZwiAzCZnf
         gGjIyf1TJ2nqC620u6vTJVghYjkVgbNSvJ5y7DIpkvKb0xi5w3qibGGwpK+6j905C0
         2TZg0WfgboOdYcJEPRRwbN2tBYjr8JcE0SbVX/NA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 025/129] selftests: mlxsw: Fix test failure on Spectrum-4
Date:   Mon, 28 Aug 2023 12:11:44 +0200
Message-ID: <20230828101158.228530789@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit f520489e99a35b0a5257667274fbe9afd2d8c50b ]

Remove assumptions about shared buffer cell size and instead query the
cell size from devlink. Adjust the test to send small packets that fit
inside a single cell.

Tested on Spectrum-{1,2,3,4}.

Fixes: 4735402173e6 ("mlxsw: spectrum: Extend to support Spectrum-4 ASIC")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/f7dfbf3c4d1cb23838d9eb99bab09afaa320c4ca.1692268427.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/drivers/net/mlxsw/sharedbuffer.sh  | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
index 7d9e73a43a49b..0c47faff9274b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
@@ -98,12 +98,12 @@ sb_occ_etc_check()
 
 port_pool_test()
 {
-	local exp_max_occ=288
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
+	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
 		-t ip -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
@@ -126,12 +126,12 @@ port_pool_test()
 
 port_tc_ip_test()
 {
-	local exp_max_occ=288
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
+	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
 		-t ip -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
@@ -154,16 +154,12 @@ port_tc_ip_test()
 
 port_tc_arp_test()
 {
-	local exp_max_occ=96
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
-	if [[ $MLXSW_CHIP != "mlxsw_spectrum" ]]; then
-		exp_max_occ=144
-	fi
-
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -A 192.0.1.1 -t arp -q
+	$MZ $h1 -c 1 -p 10 -a $h1mac -A 192.0.1.1 -t arp -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-- 
2.40.1



