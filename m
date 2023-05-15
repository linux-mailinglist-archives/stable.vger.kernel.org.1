Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF50D7039BC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbjEORpe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbjEORpO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004966E92
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D550162E49
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8813C433EF;
        Mon, 15 May 2023 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172577;
        bh=iWbCCRy1Spjcf836iiuBVoDOigsexpBSKY30+3yNyjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=be8neLZF9AodVs4lDk6AIKtDtOJ5IPBvKdO4fPlac24AkLT+kjuHI9jMX2/7qkl6+
         9sgdw/orW7CVWlLY2EiHoUyUrU+9ue8Ua0Uhbffjs7lwYmsSMqTmCtMDYkW2Df/XgY
         xNNyMn9Ve86AlVbwWvfEz3/SbRTDXepscKqe0EUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 160/381] selftests/bpf: Wait for receive in cg_storage_multi test
Date:   Mon, 15 May 2023 18:26:51 +0200
Message-Id: <20230515161744.033983594@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: YiFei Zhu <zhuyifei@google.com>

[ Upstream commit 5af607a861d43ffff830fc1890033e579ec44799 ]

In some cases the loopback latency might be large enough, causing
the assertion on invocations to be run before ingress prog getting
executed. The assertion would fail and the test would flake.

This can be reliably reproduced by arbitrarily increasing the
loopback latency (thanks to [1]):
  tc qdisc add dev lo root handle 1: htb default 12
  tc class add dev lo parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
  tc qdisc add dev lo parent 1:12 netem delay 100ms

Fix this by waiting on the receive end, instead of instantly
returning to the assert. The call to read() will wait for the
default SO_RCVTIMEO timeout of 3 seconds provided by
start_server().

[1] https://gist.github.com/kstevens715/4598301

Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
Link: https://lore.kernel.org/bpf/9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev/
Fixes: 3573f384014f ("selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress")
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Link: https://lore.kernel.org/r/20230405193354.1956209-1-zhuyifei@google.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 643dfa35419c1..48dc5827daa7f 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -56,8 +56,9 @@ static bool assert_storage_noexist(struct bpf_map *map, const void *key)
 
 static bool connect_send(const char *cgroup_path)
 {
-	bool res = true;
 	int server_fd = -1, client_fd = -1;
+	char message[] = "message";
+	bool res = true;
 
 	if (join_cgroup(cgroup_path))
 		goto out_clean;
@@ -70,7 +71,10 @@ static bool connect_send(const char *cgroup_path)
 	if (client_fd < 0)
 		goto out_clean;
 
-	if (send(client_fd, "message", strlen("message"), 0) < 0)
+	if (send(client_fd, &message, sizeof(message), 0) < 0)
+		goto out_clean;
+
+	if (read(server_fd, &message, sizeof(message)) < 0)
 		goto out_clean;
 
 	res = false;
-- 
2.39.2



