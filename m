Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D014F7ECD1F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjKOTea (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjKOTe2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD01AC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F315C433C8;
        Wed, 15 Nov 2023 19:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076865;
        bh=Y5II0h3nvSYgVGcIAvDjn/uFG44X0OgBk9Q2kXX57BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFkwPz5KhwKq3gFYVy6RbckD8Fd0hyAoikO4eGQKJawJavTVt+18VeM6mb1U3gPPU
         htXK47NHcU6RYCffIGTg/7LjCFRDF6BP/l54Cs3r4zUY6jY5T1X0/2eLEq4+PqZW2h
         +kxWEpJVA7YHfL0NqFon0pzhYIgJKGrNM0KwNh+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 429/550] modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host
Date:   Wed, 15 Nov 2023 14:16:53 -0500
Message-ID: <20231115191630.509148416@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 7f54e00e5842663c2cea501bbbdfa572c94348a3 ]

When MODULE_DEVICE_TABLE(tee, ) is built on a host with a different
endianness from the target architecture, it results in an incorrect
MODULE_ALIAS().

For example, see a case where drivers/char/hw_random/optee-rng.c
is built as a module for ARM little-endian.

If you build it on a little-endian host, you will get the correct
MODULE_ALIAS:

    $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
    MODULE_ALIAS("tee:ab7a617c-b8e7-4d8f-8301-d09b61036b64*");

However, if you build it on a big-endian host, you will get a wrong
MODULE_ALIAS:

    $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
    MODULE_ALIAS("tee:646b0361-9bd0-0183-8f4d-e7b87c617aab*");

The same problem also occurs when you enable CONFIG_CPU_BIG_ENDIAN,
and build it on a little-endian host.

This issue has been unnoticed because the ARM kernel is configured for
little-endian by default, and most likely built on a little-endian host
(cross-build on x86 or native-build on ARM).

The uuid field must not be reversed because uuid_t is an array of __u8.

Fixes: 0fc1db9d1059 ("tee: add bus driver framework for TEE based devices")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/file2alias.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7056751c29b1f..70bf6a2f585ce 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1348,13 +1348,13 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
 /* Looks like: tee:uuid */
 static int do_tee_entry(const char *filename, void *symval, char *alias)
 {
-	DEF_FIELD(symval, tee_client_device_id, uuid);
+	DEF_FIELD_ADDR(symval, tee_client_device_id, uuid);
 
 	sprintf(alias, "tee:%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
-		uuid.b[0], uuid.b[1], uuid.b[2], uuid.b[3], uuid.b[4],
-		uuid.b[5], uuid.b[6], uuid.b[7], uuid.b[8], uuid.b[9],
-		uuid.b[10], uuid.b[11], uuid.b[12], uuid.b[13], uuid.b[14],
-		uuid.b[15]);
+		uuid->b[0], uuid->b[1], uuid->b[2], uuid->b[3], uuid->b[4],
+		uuid->b[5], uuid->b[6], uuid->b[7], uuid->b[8], uuid->b[9],
+		uuid->b[10], uuid->b[11], uuid->b[12], uuid->b[13], uuid->b[14],
+		uuid->b[15]);
 
 	add_wildcard(alias);
 	return 1;
-- 
2.42.0



