Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3087A7AAB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjITLoz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjITLoz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6864F2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:44:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B0FC433C8;
        Wed, 20 Sep 2023 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210287;
        bh=vEn0YEfMj/eShRok9dUFyD0uq1mnKSjwHcn/uVEClew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL0JPVYo8+BickPkj/9Ac5KJUgmA04jhzuvurcRGxmAZxfLKNxcCkpoKGXMq8n8EN
         xg2v55aVI5lha+OadBq+Vt5Jjq9yy42L9vhidMcVwDDgoW1Wbq+pkKm1XhtLIkNc51
         uFiIXSWtpg9Qw3gOgkJSKgQ9vivJzlvstWnQpog8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 021/211] selftests/nolibc: prevent out of bounds access in expect_vfprintf
Date:   Wed, 20 Sep 2023 13:27:45 +0200
Message-ID: <20230920112846.462961982@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 9c5e490093e83e165022e0311bd7df5aa06cc860 ]

If read() fails and returns -1 (or returns garbage for some other
reason) buf would be accessed out of bounds.
Only use the return value of read() after it has been validated.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 55628a25df0a3..8e7750e2eb97c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -769,7 +769,6 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	lseek(fd, 0, SEEK_SET);
 
 	r = read(fd, buf, sizeof(buf) - 1);
-	buf[r] = '\0';
 
 	fclose(memfile);
 
@@ -779,6 +778,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 		return 1;
 	}
 
+	buf[r] = '\0';
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 
-- 
2.40.1



