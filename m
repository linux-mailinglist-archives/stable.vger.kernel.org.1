Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015C572C1C3
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbjFLLAX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbjFLK7u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C3421D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 390C96246A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A03DC433D2;
        Mon, 12 Jun 2023 10:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566811;
        bh=XfOhGVN0v3hG1viVczaSizwo/DtWCgAmZJl6dL9mBfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCzBqg/P3ws94iQF2k9bG2tQGiXfbgTn95jLKWTH8l79o1GE92OgACIktyJQRr9Pa
         J80KNcEzGRWnygpjzfZLT8rMJeEwP3SS5NRzVxkMR9TON6I1UNl/NtUIJknlAAOkWV
         GaV9ThPKyowX7GUAJsj6kJ7fKmD91A8apcGE2qt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 040/160] selftests/bpf: Fix sockopt_sk selftest
Date:   Mon, 12 Jun 2023 12:26:12 +0200
Message-ID: <20230612101716.877934734@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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
index 4512dd808c335..05d0e07da3942 100644
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



