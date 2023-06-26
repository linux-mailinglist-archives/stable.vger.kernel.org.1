Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA673E812
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjFZSWS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjFZSWK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7731702
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82BE260F57
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E918C433C8;
        Mon, 26 Jun 2023 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803682;
        bh=Y3dU+evQdbvEAfFTbXaCTSTe3vJeJZBHTQG3j2EQOtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZbtPfr4muyYP0FtSDYOw+PSlDiTKQoT/xL18R8dHTy+nuqVjaWvIAJmwu1z4OT4B
         H4E6Gb4BJ6/GOOHx+MfdRzSshr61oQ6yDvFUht0xzzjjumhVj2uvBl6pj/GfI+8AIQ
         VNVMVjtUVIro1Ma5pvc8zMe9AbVyk370K/y+i0S4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danielle Ratson <danieller@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 141/199] selftests: forwarding: Fix race condition in mirror installation
Date:   Mon, 26 Jun 2023 20:10:47 +0200
Message-ID: <20230626180811.788715170@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Danielle Ratson <danieller@nvidia.com>

[ Upstream commit c7c059fba6fb19c3bc924925c984772e733cb594 ]

When mirroring to a gretap in hardware the device expects to be
programmed with the egress port and all the encapsulating headers. This
requires the driver to resolve the path the packet will take in the
software data path and program the device accordingly.

If the path cannot be resolved (in this case because of an unresolved
neighbor), then mirror installation fails until the path is resolved.
This results in a race that causes the test to sometimes fail.

Fix this by setting the neighbor's state to permanent in a couple of
tests, so that it is always valid.

Fixes: 35c31d5c323f ("selftests: forwarding: Test mirror-to-gretap w/ UL 802.1d")
Fixes: 239e754af854 ("selftests: forwarding: Test mirror-to-gretap w/ UL 802.1q")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Link: https://lore.kernel.org/r/268816ac729cb6028c7a34d4dda6f4ec7af55333.1687264607.git.petrm@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh  | 4 ++++
 .../testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
index c5095da7f6bf8..aec752a22e9ec 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
@@ -93,12 +93,16 @@ cleanup()
 
 test_gretap()
 {
+	ip neigh replace 192.0.2.130 lladdr $(mac_get $h3) \
+		 nud permanent dev br2
 	full_test_span_gre_dir gt4 ingress 8 0 "mirror to gretap"
 	full_test_span_gre_dir gt4 egress 0 8 "mirror to gretap"
 }
 
 test_ip6gretap()
 {
+	ip neigh replace 2001:db8:2::2 lladdr $(mac_get $h3) \
+		nud permanent dev br2
 	full_test_span_gre_dir gt6 ingress 8 0 "mirror to ip6gretap"
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
index 9ff22f28032dd..0cf4c47a46f9b 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
@@ -90,12 +90,16 @@ cleanup()
 
 test_gretap()
 {
+	ip neigh replace 192.0.2.130 lladdr $(mac_get $h3) \
+		 nud permanent dev br1
 	full_test_span_gre_dir gt4 ingress 8 0 "mirror to gretap"
 	full_test_span_gre_dir gt4 egress 0 8 "mirror to gretap"
 }
 
 test_ip6gretap()
 {
+	ip neigh replace 2001:db8:2::2 lladdr $(mac_get $h3) \
+		nud permanent dev br1
 	full_test_span_gre_dir gt6 ingress 8 0 "mirror to ip6gretap"
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
-- 
2.39.2



