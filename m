Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEF7ECEE8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjKOTpE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjKOTpD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969BB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7F0C433C8;
        Wed, 15 Nov 2023 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077499;
        bh=4M1cDiXhpZx7PqVu20dAoEe3o7DWPe5bt3kjJHS9ja4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoGf12hXvJPEMQa3JerEA/5Oga/48r2IbPAaxoLaS9kHjWxm0PHiUP6h81J3yBZ4n
         rcvz+tgiDHsW7ikPeyb+l4hyXvhx2pqonTiCVoR5SbIRSHb5LTgTgp+hnCX2Hmri6c
         msGGc+/1tzef58hcBVQyluHWq4urbnV90kQ2+QZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 340/603] crypto: ccp - Fix DBC sample application error handling
Date:   Wed, 15 Nov 2023 14:14:45 -0500
Message-ID: <20231115191637.063642829@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 70f242c1933e9e881c13c31640bb6d56e8b7e738 ]

The sample application was taking values from ioctl() and treating
those as the error codes to present to a user.

This is incorrect when ret is non-zero, the error is stored to `errno`.
Use this value instead.

Fixes: f40d42f116cf ("crypto: ccp - Add a sample python script for Dynamic Boost Control")
Fixes: febe3ed3222f ("crypto: ccp - Add a sample library for ioctl use")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/crypto/ccp/dbc.c  | 16 ++++++++--------
 tools/crypto/ccp/dbc.py |  3 +--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/crypto/ccp/dbc.c b/tools/crypto/ccp/dbc.c
index 37e813175642f..7774e981849fa 100644
--- a/tools/crypto/ccp/dbc.c
+++ b/tools/crypto/ccp/dbc.c
@@ -8,6 +8,7 @@
  */
 
 #include <assert.h>
+#include <errno.h>
 #include <string.h>
 #include <sys/ioctl.h>
 
@@ -22,16 +23,14 @@ int get_nonce(int fd, void *nonce_out, void *signature)
 	struct dbc_user_nonce tmp = {
 		.auth_needed = !!signature,
 	};
-	int ret;
 
 	assert(nonce_out);
 
 	if (signature)
 		memcpy(tmp.signature, signature, sizeof(tmp.signature));
 
-	ret = ioctl(fd, DBCIOCNONCE, &tmp);
-	if (ret)
-		return ret;
+	if (ioctl(fd, DBCIOCNONCE, &tmp))
+		return errno;
 	memcpy(nonce_out, tmp.nonce, sizeof(tmp.nonce));
 
 	return 0;
@@ -47,7 +46,9 @@ int set_uid(int fd, __u8 *uid, __u8 *signature)
 	memcpy(tmp.uid, uid, sizeof(tmp.uid));
 	memcpy(tmp.signature, signature, sizeof(tmp.signature));
 
-	return ioctl(fd, DBCIOCUID, &tmp);
+	if (ioctl(fd, DBCIOCUID, &tmp))
+		return errno;
+	return 0;
 }
 
 int process_param(int fd, int msg_index, __u8 *signature, int *data)
@@ -63,9 +64,8 @@ int process_param(int fd, int msg_index, __u8 *signature, int *data)
 
 	memcpy(tmp.signature, signature, sizeof(tmp.signature));
 
-	ret = ioctl(fd, DBCIOCPARAM, &tmp);
-	if (ret)
-		return ret;
+	if (ioctl(fd, DBCIOCPARAM, &tmp))
+		return errno;
 
 	*data = tmp.param;
 	return 0;
diff --git a/tools/crypto/ccp/dbc.py b/tools/crypto/ccp/dbc.py
index 3f6a825ffc9e4..3956efe7537ac 100644
--- a/tools/crypto/ccp/dbc.py
+++ b/tools/crypto/ccp/dbc.py
@@ -27,8 +27,7 @@ lib = ctypes.CDLL("./dbc_library.so", mode=ctypes.RTLD_GLOBAL)
 
 
 def handle_error(code):
-    val = code * -1
-    raise OSError(val, os.strerror(val))
+    raise OSError(code, os.strerror(code))
 
 
 def get_nonce(device, signature):
-- 
2.42.0



