Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6738C7A3974
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjIQTtx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbjIQTtY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850729F;
        Sun, 17 Sep 2023 12:49:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B549DC433CD;
        Sun, 17 Sep 2023 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980159;
        bh=B5DqDUM2XbeQIDrH47tq2TTQ3eVn0cfDgVEFaUw2H6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjGOI4RMqCPQ8zkmJDgh2WTbiOMp2kNuTEjnwDsZML6g39ylcsdHH14JDbPPspXQY
         EYkhv8IkkhqZK1EftwkV+vcSFBzpkwc8MzyGO7FuBQppC6vzS0DPpbcZnocfvJX5Dc
         5q4QuEptukkuaHu1UwQpRaiaHEEdE36Lc7Wzlq8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 094/285] accel/ivpu: refactor deprecated strncpy
Date:   Sun, 17 Sep 2023 21:11:34 +0200
Message-ID: <20230917191054.946681501@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit 4b2fd81f2af7147e844ecec0c5c07a16bca6b86e ]

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

Also remove extraneous if-statement as it can never be entered. The
return value from `strncpy` is it's first argument. In this case,
`...dyndbg_cmd` is an array:
| 	char dyndbg_cmd[VPU_DYNDBG_CMD_MAX_LEN];
             ^^^^^^^^^^
This can never be NULL which means `strncpy`'s return value cannot be
NULL here. Just use `strscpy` which is more robust and results in
simpler and less ambiguous code.

Moreover, remove needless `... - 1` as `strscpy`'s implementation
ensures NUL-termination and we do not need to carefully dance around
ending boundaries with a "- 1" anymore.

Fixes: 5d7422cfb498 ("accel/ivpu: Add IPC driver and JSM messages")
Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230824-strncpy-drivers-accel-ivpu-ivpu_jsm_msg-c-v1-1-12d9b52d2dff@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_jsm_msg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 831bfd2b2d39d..bdddef2c59eec 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -118,8 +118,7 @@ int ivpu_jsm_dyndbg_control(struct ivpu_device *vdev, char *command, size_t size
 	struct vpu_jsm_msg resp;
 	int ret;
 
-	if (!strncpy(req.payload.dyndbg_control.dyndbg_cmd, command, VPU_DYNDBG_CMD_MAX_LEN - 1))
-		return -ENOMEM;
+	strscpy(req.payload.dyndbg_control.dyndbg_cmd, command, VPU_DYNDBG_CMD_MAX_LEN);
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_DYNDBG_CONTROL_RSP, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
-- 
2.40.1



