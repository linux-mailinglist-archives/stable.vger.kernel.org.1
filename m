Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2DB767D96
	for <lists+stable@lfdr.de>; Sat, 29 Jul 2023 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjG2JRw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Jul 2023 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG2JRv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Jul 2023 05:17:51 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1CF2D4D
        for <stable@vger.kernel.org>; Sat, 29 Jul 2023 02:17:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C92E860177;
        Sat, 29 Jul 2023 11:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690622268; bh=kpD8KSfH6g3ST2uqStkM077PQkg1i0nge/5l7O/bkqo=;
        h=Date:To:Cc:From:Subject:From;
        b=BgxT4So1B/sezLZ1ngPhKMOBlvVJEkbLwzLuQCJUf7Eej25SwGyLvF59ZYlD2jJma
         K/msXpBJuGJ2/s04sUGhKe0dBNuEGPeeF4tTCUzohzanc91DycKTwX1wviMQdOlN2k
         IJzNeVSqDcA/P3ZcVY8VUfdLn2GBHAlTj/fAqA+YT6m7y9joUN+8RJguzH//OAsP6i
         bIEkU520QPZHrmxiZhjSSFNnQn1csLTkkU/QUalrBhbj2Gayy8P3AVNBJYzQ/Pn0E5
         LpFv1BsstbxphjxeHDLVxa+7F9MIRYgEbuld3fTrorq4SR4GcD44dnGFKVkWfym3hp
         69tWgeN3W3xJw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pLmy2L4IPnSy; Sat, 29 Jul 2023 11:17:46 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id E7B936015E;
        Sat, 29 Jul 2023 11:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690622266; bh=kpD8KSfH6g3ST2uqStkM077PQkg1i0nge/5l7O/bkqo=;
        h=Date:To:Cc:From:Subject:From;
        b=Fo32ekggg2+Wir6EVEFcKiyvYO1g0/ULxw+gM7W9nVFQLc3niAtf5j3wOrvxdadOY
         /rrg6R2kUMoMBXsdKDmol0KFfk+t+h/5ay6i3pF3uaZpny7CdmnMfksVb4t5tnDGbi
         ijA0dWxfiFU3medUS2f7lMP5HEjMurUpMWyPyJev1BU23OAYWM62uPIFVHv9uWEiaQ
         YElHogXvcxt9B1Igg0gi1eolwCnUFbCReW4WQWRW1S2TuiFNgsIkqZLUI2H7YqgDre
         g12/CPnzLR2Phkxv6Pgfz9XTcpaOutwPINATJBbrvVYhPVVdkrG0kbebcLde0ZO1nq
         6JOYkp5dQFAjw==
Message-ID: <1a2a428f-71ab-1154-bd50-05c82eb05817@alu.unizg.hr>
Date:   Sat, 29 Jul 2023 11:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [RESEND PATCH v5 1/3] test_firmware: prevent race conditions by a
 correct implementation of locking
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

Dan Carpenter spotted a race condition in a couple of situations like
these in the test_firmware driver:

static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
{
         u8 val;
         int ret;

         ret = kstrtou8(buf, 10, &val);
         if (ret)
                 return ret;

         mutex_lock(&test_fw_mutex);
         *(u8 *)cfg = val;
         mutex_unlock(&test_fw_mutex);

         /* Always return full write size even if we didn't consume all */
         return size;
}

static ssize_t config_num_requests_store(struct device *dev,
                                          struct device_attribute *attr,
                                          const char *buf, size_t count)
{
         int rc;

         mutex_lock(&test_fw_mutex);
         if (test_fw_config->reqs) {
                 pr_err("Must call release_all_firmware prior to changing config\n");
                 rc = -EINVAL;
                 mutex_unlock(&test_fw_mutex);
                 goto out;
         }
         mutex_unlock(&test_fw_mutex);

         rc = test_dev_config_update_u8(buf, count,
                                        &test_fw_config->num_requests);

out:
         return rc;
}

static ssize_t config_read_fw_idx_store(struct device *dev,
                                         struct device_attribute *attr,
                                         const char *buf, size_t count)
{
         return test_dev_config_update_u8(buf, count,
                                          &test_fw_config->read_fw_idx);
}

The function test_dev_config_update_u8() is called from both the locked
and the unlocked context, function config_num_requests_store() and
config_read_fw_idx_store() which can both be called asynchronously as
they are driver's methods, while test_dev_config_update_u8() and siblings
change their argument pointed to by u8 *cfg or similar pointer.

To avoid deadlock on test_fw_mutex, the lock is dropped before calling
test_dev_config_update_u8() and re-acquired within test_dev_config_update_u8()
itself, but alas this creates a race condition.

Having two locks wouldn't assure a race-proof mutual exclusion.

This situation is best avoided by the introduction of a new, unlocked
function __test_dev_config_update_u8() which can be called from the locked
context and reducing test_dev_config_update_u8() to:

static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
{
         int ret;

         mutex_lock(&test_fw_mutex);
         ret = __test_dev_config_update_u8(buf, size, cfg);
         mutex_unlock(&test_fw_mutex);

         return ret;
}

doing the locking and calling the unlocked primitive, which enables both
locked and unlocked versions without duplication of code.

The similar approach was applied to all functions called from the locked
and the unlocked context, which safely mitigates both deadlocks and race
conditions in the driver.

__test_dev_config_update_bool(), __test_dev_config_update_u8() and
__test_dev_config_update_size_t() unlocked versions of the functions
were introduced to be called from the locked contexts as a workaround
without releasing the main driver's lock and thereof causing a race
condition.

The test_dev_config_update_bool(), test_dev_config_update_u8() and
test_dev_config_update_size_t() locked versions of the functions
are being called from driver methods without the unnecessary multiplying
of the locking and unlocking code for each method, and complicating
the code with saving of the return value across lock.

Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org # v5.4
Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v5.1
  resending to v5.4 stable branch verbatim according to Luis Chamberlain instruction

  lib/test_firmware.c | 52 ++++++++++++++++++++++++++++++---------------
  1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..35417e0af3f4 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -353,16 +353,26 @@ static ssize_t config_test_show_str(char *dst,
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
@@ -373,7 +383,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
  }
  
-static int test_dev_config_update_size_t(const char *buf,
+static int __test_dev_config_update_size_t(
+					 const char *buf,
  					 size_t size,
  					 size_t *cfg)
  {
@@ -384,9 +395,7 @@ static int test_dev_config_update_size_t(const char *buf,
  	if (ret)
  		return ret;
  
-	mutex_lock(&test_fw_mutex);
  	*(size_t *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
  
  	/* Always return full write size even if we didn't consume all */
  	return size;
@@ -402,7 +411,7 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
  }
  
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
  {
  	u8 val;
  	int ret;
@@ -411,14 +420,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
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
@@ -471,10 +489,10 @@ static ssize_t config_num_requests_store(struct device *dev,
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
@@ -518,10 +536,10 @@ static ssize_t config_buf_size_store(struct device *dev,
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
@@ -548,10 +566,10 @@ static ssize_t config_file_offset_store(struct device *dev,
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
-- 
2.30.2

