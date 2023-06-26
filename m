Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF4973E78C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjFZSQ1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjFZSQV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:16:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3FE4D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B959360F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C091AC433C0;
        Mon, 26 Jun 2023 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803378;
        bh=15cpEt/2ZOjvbDy36we6yeoFVbBI1oFrA7Y8fmbmqmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPCM1iDHmzlANwUYJPZ/SiWFy9rdEGCdJsZeES4BB07YBgs02yGyH2b8t5QdLkUV/
         hQs1SkqkfcjRs2efKXji4SGWQJaqEyc8J6ekMkbCnQKQPD4ZbHAsHgte4TNnKpxdPJ
         BbdZx8RXK3kwrvAmSzTcbAJ9u42TSRKctFq1T6Ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 041/199] selftests: mptcp: join: support RM_ADDR for used endpoints or not
Date:   Mon, 26 Jun 2023 20:09:07 +0200
Message-ID: <20230626180807.390649836@linuxfoundation.org>
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 425ba803124b90cb9124d99f13b372a89dc151d9 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

At some points, a new feature caused internal behaviour changes we are
verifying in the selftests, see the Fixes tag below. It was not a UAPI
change but because in these selftests, we check some internal
behaviours, it is normal we have to adapt them from time to time after
having added some features.

It looks like there is no external sign we can use to predict the
expected behaviour. Instead of accepting different behaviours and thus
not really checking for the expected behaviour, we are looking here for
a specific kernel version. That's not ideal but it looks better than
removing the test because it cannot support older kernel versions.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2354,7 +2354,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
-		chk_rm_nr 0 3 simult
+
+		if mptcp_lib_kversion_ge 5.18; then
+			chk_rm_nr 0 3 simult
+		else
+			chk_rm_nr 3 3
+		fi
 	fi
 
 	# addresses flush


