Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329146FAB44
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjEHLLI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjEHLLH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC034E0A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C880662B57
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB201C433D2;
        Mon,  8 May 2023 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544265;
        bh=lV3azTj5gRT/0cTKWI7UKGQvjWJwyzPg+ofBmObNIzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZQ3d+338ju+asFGkw5PyyFXE3Hw9EaNVBxlGM8mGKONyPqLxGNSJMIwVGYCtktfC
         fV5kNKyKlo67Et/qXL/7Zw2lJI4bnXosL7Xam8qp83jb2EcgUfm1jWMPFcwUHJb0mv
         7p0neFhWI8w232MVya55gY5+OF1Eblzp3Bk5o6ZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 347/694] selftests/bpf: Fix a fd leak in an error path in network_helpers.c
Date:   Mon,  8 May 2023 11:43:02 +0200
Message-Id: <20230508094443.819652119@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 226efec2b0efad60d4a6c4b2c3a8710dafc4dc21 ]

In __start_server, it leaks a fd when setsockopt(SO_REUSEPORT) fails.
This patch fixes it.

Fixes: eed92afdd14c ("bpf: selftest: Test batching and bpf_(get|set)sockopt in bpf tcp iter")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20230316000726.1016773-2-martin.lau@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 01de33191226b..596caa1765820 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -95,7 +95,7 @@ static int __start_server(int type, int protocol, const struct sockaddr *addr,
 	if (reuseport &&
 	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
 		log_err("Failed to set SO_REUSEPORT");
-		return -1;
+		goto error_close;
 	}
 
 	if (bind(fd, addr, addrlen) < 0) {
-- 
2.39.2



