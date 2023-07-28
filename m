Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80976768E
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 21:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjG1Tst (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjG1Tso (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 15:48:44 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A683C07
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 12:48:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 92FC660177;
        Fri, 28 Jul 2023 21:48:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690573709; bh=frV9MHtDALk1CqIlm+dfTY36CTdzsvB58QZC2JhgrYQ=;
        h=Date:To:Cc:From:Subject:From;
        b=qCu0ENwOuIBNPhC2bP6E/WFHzppWTA03aSdkoK5V1PsAAo38Xpp3NqrEugYk/kB63
         wqfca8438ATUxzusWWOvKJv3LovfKpMrUYUNCUuuisLqe4vcO8KzgUIT9/uoHZSljs
         FBrCpZ7xUsKFfDcXyu2/ot4M48QqXZA7w69I0Gbq2C3yZDLiC+23S2O/VoDxJ/Pwmf
         1H3puWKIxERGkQZ8nA5vSTyu9V5Qdx0/k+OR3+IQcgEZU5G4ZtTeK3KkY1bsqp0Ead
         hUvIzx4XmxY325SMtucMuiqDJXYceTy7iVfM1wYIxj0li25925Tcf3ZS9qNcyUnaw3
         hZrNCMYRI+ZSA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gf-Qn1-b6vhD; Fri, 28 Jul 2023 21:48:26 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 1248E6016E;
        Fri, 28 Jul 2023 21:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690573706; bh=frV9MHtDALk1CqIlm+dfTY36CTdzsvB58QZC2JhgrYQ=;
        h=Date:To:Cc:From:Subject:From;
        b=z7hYWWluwasP0OvWVUrCcv46ze5nflD6a9p09+aK70zWa4VMU+PPPTIrmrBKSC5o0
         6GVX6vvcCmT+1ZyeOI96IwkDAqkq0aZ2e7skeaOpImV3C5mLInI42xyzJuaot1PzS9
         HXxUJ0uh08HDnTuNBoIHOEDFMoINhBjMhdjK/STln9sKAK928dAfiXsj+9cVH6N7Yq
         CDS2MvPJzjAPbgCCuL5cJt/bjUL7tvdMsFhweWIbYotUU+hZHjjzCHIDZYaMP/jp/D
         pOxrG69JoNco5thYgSAyDESL+C15YZlHCrqzVycuka1TneNcu72c4/xakk5ZRBiED+
         wBybmR+dLOKwg==
Message-ID: <84fde847-e756-3727-c357-104775ef1c4f@alu.unizg.hr>
Date:   Fri, 28 Jul 2023 21:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH RESEND v4 1/1] test_firmware: fix some memory leaks and racing
 conditions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Some functions were called both from locked and unlocked context, so
the lock was dropped prematurely, introducing a race condition when
deadlock was avoided.

Having two locks wouldn't assure a race-proof mutual exclusion.

__test_dev_config_update_bool(), __test_dev_config_update_u8() and
__test_dev_config_update_size_t() unlocked versions of the functions
were introduced to be called from the locked contexts as a workaround
without releasing the main driver's lock and causing a race condition.

This should guarantee mutual exclusion and prevent any race conditions.

Locked versions simply allow for mutual exclusion and call the unlocked
counterparts, to avoid duplication of code.

trigger_batched_requests_store() and trigger_batched_requests_async_store()
now return -EBUSY if called with test_fw_config->reqs already allocated,
so the memory leak is prevented.

The same functions now keep track of the allocated buf for firmware in
req->fw_buf as release_firmware() will not deallocate this storage for us.

Additionally, in __test_release_all_firmware(), req->fw_buf is released
before calling release_firmware(req->fw),
foreach test_fw_config->reqs[i], i = 0 .. test_fw_config->num_requests-1

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Tianfei zhang <tianfei.zhang@intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v3 -> v4
  - fix additional memory leaks of the allocated firmware buffers
  - fix noticed racing conditions in conformance with the existing code
  - make it a single patch

  lib/test_firmware.c | 81 +++++++++++++++++++++++++++++++++++----------
  1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..1d7d480b8eeb 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -45,6 +45,7 @@ struct test_batched_req {
  	bool sent;
  	const struct firmware *fw;
  	const char *name;
+	const char *fw_buf;
  	struct completion completion;
  	struct task_struct *task;
  	struct device *dev;
@@ -175,8 +176,14 @@ static void __test_release_all_firmware(void)
  
  	for (i = 0; i < test_fw_config->num_requests; i++) {
  		req = &test_fw_config->reqs[i];
-		if (req->fw)
+		if (req->fw) {
+			if (req->fw_buf) {
+				kfree_const(req->fw_buf);
+				req->fw_buf = NULL;
+			}
  			release_firmware(req->fw);
+			req->fw = NULL;
+		}
  	}
  
  	vfree(test_fw_config->reqs);
@@ -353,16 +360,26 @@ static ssize_t config_test_show_str(char *dst,
  	return len;
  }
  
-static int test_dev_config_update_bool(const char *buf, size_t size,
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
  				       bool *cfg)
  {
  	int ret;
  
-	mutex_lock(&test_fw_mutex);
  	if (kstrtobool(buf, cfg) < 0)
  		ret = -EINVAL;
  	else
  		ret = size;
+
+	return ret;
+}
+
+static int test_dev_config_update_bool(const char *buf, size_t size,
+				       bool *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_bool(buf, size, cfg);
  	mutex_unlock(&test_fw_mutex);
  
  	return ret;
@@ -373,7 +390,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
  }
  
-static int test_dev_config_update_size_t(const char *buf,
+static int __test_dev_config_update_size_t(
+					 const char *buf,
  					 size_t size,
  					 size_t *cfg)
  {
@@ -384,9 +402,7 @@ static int test_dev_config_update_size_t(const char *buf,
  	if (ret)
  		return ret;
  
-	mutex_lock(&test_fw_mutex);
  	*(size_t *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
  
  	/* Always return full write size even if we didn't consume all */
  	return size;
@@ -402,7 +418,7 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
  }
  
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
  {
  	u8 val;
  	int ret;
@@ -411,14 +427,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
  	if (ret)
  		return ret;
  
-	mutex_lock(&test_fw_mutex);
  	*(u8 *)cfg = val;
-	mutex_unlock(&test_fw_mutex);
  
  	/* Always return full write size even if we didn't consume all */
  	return size;
  }
  
+static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_u8(buf, size, cfg);
+	mutex_unlock(&test_fw_mutex);
+
+	return ret;
+}
+
  static ssize_t test_dev_config_show_u8(char *buf, u8 val)
  {
  	return snprintf(buf, PAGE_SIZE, "%u\n", val);
@@ -471,10 +496,10 @@ static ssize_t config_num_requests_store(struct device *dev,
  		mutex_unlock(&test_fw_mutex);
  		goto out;
  	}
-	mutex_unlock(&test_fw_mutex);
  
-	rc = test_dev_config_update_u8(buf, count,
-				       &test_fw_config->num_requests);
+	rc = __test_dev_config_update_u8(buf, count,
+					 &test_fw_config->num_requests);
+	mutex_unlock(&test_fw_mutex);
  
  out:
  	return rc;
@@ -518,10 +543,10 @@ static ssize_t config_buf_size_store(struct device *dev,
  		mutex_unlock(&test_fw_mutex);
  		goto out;
  	}
-	mutex_unlock(&test_fw_mutex);
  
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->buf_size);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->buf_size);
+	mutex_unlock(&test_fw_mutex);
  
  out:
  	return rc;
@@ -548,10 +573,10 @@ static ssize_t config_file_offset_store(struct device *dev,
  		mutex_unlock(&test_fw_mutex);
  		goto out;
  	}
-	mutex_unlock(&test_fw_mutex);
  
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->file_offset);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->file_offset);
+	mutex_unlock(&test_fw_mutex);
  
  out:
  	return rc;
@@ -652,6 +677,8 @@ static ssize_t trigger_request_store(struct device *dev,
  
  	mutex_lock(&test_fw_mutex);
  	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
  	test_firmware = NULL;
  	rc = request_firmware(&test_firmware, name, dev);
  	if (rc) {
@@ -752,6 +779,8 @@ static ssize_t trigger_async_request_store(struct device *dev,
  	mutex_lock(&test_fw_mutex);
  	release_firmware(test_firmware);
  	test_firmware = NULL;
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
  	rc = request_firmware_nowait(THIS_MODULE, 1, name, dev, GFP_KERNEL,
  				     NULL, trigger_async_request_cb);
  	if (rc) {
@@ -794,6 +823,8 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
  
  	mutex_lock(&test_fw_mutex);
  	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
  	test_firmware = NULL;
  	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOUEVENT, name,
  				     dev, GFP_KERNEL, NULL,
@@ -856,6 +887,8 @@ static int test_fw_run_batch_request(void *data)
  						 test_fw_config->buf_size);
  		if (!req->fw)
  			kfree(test_buf);
+		else
+			req->fw_buf = test_buf;
  	} else {
  		req->rc = test_fw_config->req_firmware(&req->fw,
  						       req->name,
@@ -895,6 +928,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
  
  	mutex_lock(&test_fw_mutex);
  
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
  	test_fw_config->reqs =
  		vzalloc(array3_size(sizeof(struct test_batched_req),
  				    test_fw_config->num_requests, 2));
@@ -911,6 +949,7 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
  		req->fw = NULL;
  		req->idx = i;
  		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
  		req->dev = dev;
  		init_completion(&req->completion);
  		req->task = kthread_run(test_fw_run_batch_request, req,
@@ -993,6 +1032,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
  
  	mutex_lock(&test_fw_mutex);
  
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
  	test_fw_config->reqs =
  		vzalloc(array3_size(sizeof(struct test_batched_req),
  				    test_fw_config->num_requests, 2));
@@ -1010,6 +1054,7 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
  	for (i = 0; i < test_fw_config->num_requests; i++) {
  		req = &test_fw_config->reqs[i];
  		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
  		req->fw = NULL;
  		req->idx = i;
  		init_completion(&req->completion);
-- 
2.30.2
