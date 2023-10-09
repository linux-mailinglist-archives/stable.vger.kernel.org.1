Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90407BDF6A
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377001AbjJIN3s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjJIN3r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:29:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67223B7
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:29:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FF3C433C7;
        Mon,  9 Oct 2023 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858186;
        bh=tf3drTAHvw0ZXXtLi7ScIfxNchNEeBFgfRg0dGWGbGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1rYO1MeHZLN/pMvIKoZRRtxItUjTsGOMMbY64llzM38KQ7uFOsv5+wxiuLD8dt9O
         FVAiPzRMMpX+HSMR1OtZWRASBQPwdHCQyI0/sspAKERJBNVSj6oECO0nGYJn6uMlsb
         VcvEYfn+n+vqVwhmYYRCbeCp7vRfM6uJJ/U65kog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 016/131] selftests/tls: Add {} to avoid static checker warning
Date:   Mon,  9 Oct 2023 15:00:56 +0200
Message-ID: <20231009130116.815713656@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit f50688b47c5858d2ff315d020332bf4cb6710837 ]

This silences a static checker warning due to the unusual macro
construction of EXPECT_*() by adding explicit {}s around the enclosing
while loop.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: c326ca98446e ("selftests: tls: swap the TX and RX sockets in some tests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/tls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 0ea44d975b6c1..032e08e8ce016 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -314,8 +314,9 @@ TEST_F(tls, sendmsg_large)
 		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
 	}
 
-	while (recvs++ < sends)
+	while (recvs++ < sends) {
 		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+	}
 
 	free(mem);
 }
-- 
2.40.1



