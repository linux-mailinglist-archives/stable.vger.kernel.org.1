Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA872C071
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjFLKwY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjFLKv7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C89EC5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E13F623DC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784EAC433D2;
        Mon, 12 Jun 2023 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566194;
        bh=UGXocY9wVPSHlcz+/oexm0XugP5Gdwa4c/MYdI4JeBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clcJEmOIZOqFFcetWo3SqH3sDXMcoQcKOpUyrLq1deSRCZiJW0tjZCZv+RW821w22
         C+FsQk1H/gAc+9CvZNga/sUruALBy7xwSY5BJ+uNqnW2vs7EowD+mXSrTx0/vaOJkx
         M3nqHSBuetKltbpeGoJZIJEKBzsk0TLZMXG59Zqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 30/91] selftests/bpf: Fix sockopt_sk selftest
Date:   Mon, 12 Jun 2023 12:26:19 +0200
Message-ID: <20230612101703.363188034@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 69844e335d8c22454746c7903776533d8b4ab8fa ]

Commit f4e4534850a9 ("net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report")
fixed NETLINK_LIST_MEMBERSHIPS length report which caused
selftest sockopt_sk failure. The failure log looks like

  test_sockopt_sk:PASS:join_cgroup /sockopt_sk 0 nsec
  run_test:PASS:skel_load 0 nsec
  run_test:PASS:setsockopt_link 0 nsec
  run_test:PASS:getsockopt_link 0 nsec
  getsetsockopt:FAIL:Unexpected NETLINK_LIST_MEMBERSHIPS value unexpected Unexpected NETLINK_LIST_MEMBERSHIPS value: actual 8 != expected 4
  run_test:PASS:getsetsockopt 0 nsec
  #201     sockopt_sk:FAIL

In net/netlink/af_netlink.c, function netlink_getsockopt(), for NETLINK_LIST_MEMBERSHIPS,
nlk->ngroups equals to 36. Before Commit f4e4534850a9, the optlen is calculated as
  ALIGN(nlk->ngroups / 8, sizeof(u32)) = 4
After that commit, the optlen is
  ALIGN(BITS_TO_BYTES(nlk->ngroups), sizeof(u32)) = 8

Fix the test by setting the expected optlen to be 8.

Fixes: f4e4534850a9 ("net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report")
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230606172202.1606249-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index ced75783bacfa..f3cd8db26bf7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -209,7 +209,7 @@ static int getsetsockopt(void)
 			err, errno);
 		goto err;
 	}
-	ASSERT_EQ(optlen, 4, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
+	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
 
 	free(big_buf);
 	close(fd);
-- 
2.39.2



