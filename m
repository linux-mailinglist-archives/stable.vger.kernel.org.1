Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E6472AAB0
	for <lists+stable@lfdr.de>; Sat, 10 Jun 2023 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFJJf7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 10 Jun 2023 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Jun 2023 05:35:58 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9E269A
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 02:35:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 4DB45601B6;
        Sat, 10 Jun 2023 11:35:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686389753; bh=nfkHECzGnR9k+5dmUNZ/8eJV+Thnd/QEjr92nL33ZM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SmiwN5WvI2xREN3BGh1mSW6DVB49GyACsv6dvZ2g9tGPJIc2PfQJCiVIIVFHguTUM
         NYnU12PHo7ZGNFnN8QUdE8J+8PxKkyBT7hZDkwJIU2bmzr9tlHZjMhWHjXR08P5BNm
         tby7VhB+ArYMJ9LgBio6EEeu22jOBIOtapn2qz4th557OVRDtrVnL5UVZhtbkrNI/D
         lxjjriH3rFQJSz5hWifvWVhjtnT2uf+xhZ2k5aN2Isk8zHJjO91FjPUCLy9RKpE6aE
         TuesL+Z9EXT6vYECPyInt89Q23swbeBApZr6G+e2/HSi8AUAnSk5bOfE/w7UZq/dD1
         KEdc+HT2DZkMQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QgXzsHIH21Rw; Sat, 10 Jun 2023 11:35:50 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id F2F77601B5;
        Sat, 10 Jun 2023 11:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686389750; bh=nfkHECzGnR9k+5dmUNZ/8eJV+Thnd/QEjr92nL33ZM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eolJtDTxVXzzXs51opDoQLkXCuheyGeuKl9wZkxkVgJqzomRI0EzN05pe/ixa4TTs
         v/DTcfytabH/6r76eOvJpzdH/mme+RMYwGpBwYV2zQkU2M2pBw69RPVSu4kGGjisoB
         be7jJnF/JISuB9uBj7YcxMZcd3bdbXdVxIK2TH42G+02W2ub/pLFPBMwFWB5RjpNqT
         CWe6dIYiySLi3rPgN72a2YhnXvOpISlcD5gNOJjkPd5TQrpMCWtLtM9birZySUplyY
         hESpfXWe4zPTGBjOrQhLDAsV6zgJweU7bMeAld4fX8YBOJWKfQmPwShMYdGO5ux7PQ
         hk8PMNioe30gg==
Message-ID: <e3e80409-d3ca-7304-6234-ff7cb8bae3e9@alu.unizg.hr>
Date:   Sat, 10 Jun 2023 11:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: FAILED: patch "[PATCH] test_firmware: prevent race conditions by
 a correct" failed to apply to 5.15-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        error27@gmail.com, mcgrof@kernel.org, rdunlap@infradead.org,
        russell.h.weight@intel.com, shuah@kernel.org,
        tianfei.zhang@intel.com, tiwai@suse.de
Cc:     stable@vger.kernel.org
References: <2023060753-dowry-untried-a3d2@gregkh>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023060753-dowry-untried-a3d2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/7/23 14:22, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 4acfe3dfde685a5a9eaec5555351918e2d7266a1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060753-dowry-untried-a3d2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h

Hi, Mr. Greg,

Is there something wrong with the patch and do I need to resubmit?

Regards,
Mirsad

> ------------------ original commit in Linus's tree ------------------
> 
>>From 4acfe3dfde685a5a9eaec5555351918e2d7266a1 Mon Sep 17 00:00:00 2001
> From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Date: Tue, 9 May 2023 10:47:45 +0200
> Subject: [PATCH] test_firmware: prevent race conditions by a correct
>   implementation of locking
> 
> Dan Carpenter spotted a race condition in a couple of situations like
> these in the test_firmware driver:
> 
> static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
> {
>          u8 val;
>          int ret;
> 
>          ret = kstrtou8(buf, 10, &val);
>          if (ret)
>                  return ret;
> 
>          mutex_lock(&test_fw_mutex);
>          *(u8 *)cfg = val;
>          mutex_unlock(&test_fw_mutex);
> 
>          /* Always return full write size even if we didn't consume all */
>          return size;
> }
> 
> static ssize_t config_num_requests_store(struct device *dev,
>                                           struct device_attribute *attr,
>                                           const char *buf, size_t count)
> {
>          int rc;
> 
>          mutex_lock(&test_fw_mutex);
>          if (test_fw_config->reqs) {
>                  pr_err("Must call release_all_firmware prior to changing config\n");
>                  rc = -EINVAL;
>                  mutex_unlock(&test_fw_mutex);
>                  goto out;
>          }
>          mutex_unlock(&test_fw_mutex);
> 
>          rc = test_dev_config_update_u8(buf, count,
>                                         &test_fw_config->num_requests);
> 
> out:
>          return rc;
> }
> 
> static ssize_t config_read_fw_idx_store(struct device *dev,
>                                          struct device_attribute *attr,
>                                          const char *buf, size_t count)
> {
>          return test_dev_config_update_u8(buf, count,
>                                           &test_fw_config->read_fw_idx);
> }
> 
> The function test_dev_config_update_u8() is called from both the locked
> and the unlocked context, function config_num_requests_store() and
> config_read_fw_idx_store() which can both be called asynchronously as
> they are driver's methods, while test_dev_config_update_u8() and siblings
> change their argument pointed to by u8 *cfg or similar pointer.
> 
> To avoid deadlock on test_fw_mutex, the lock is dropped before calling
> test_dev_config_update_u8() and re-acquired within test_dev_config_update_u8()
> itself, but alas this creates a race condition.
> 
> Having two locks wouldn't assure a race-proof mutual exclusion.
> 
> This situation is best avoided by the introduction of a new, unlocked
> function __test_dev_config_update_u8() which can be called from the locked
> context and reducing test_dev_config_update_u8() to:
> 
> static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
> {
>          int ret;
> 
>          mutex_lock(&test_fw_mutex);
>          ret = __test_dev_config_update_u8(buf, size, cfg);
>          mutex_unlock(&test_fw_mutex);
> 
>          return ret;
> }
> 
> doing the locking and calling the unlocked primitive, which enables both
> locked and unlocked versions without duplication of code.
> 
> The similar approach was applied to all functions called from the locked
> and the unlocked context, which safely mitigates both deadlocks and race
> conditions in the driver.
> 
> __test_dev_config_update_bool(), __test_dev_config_update_u8() and
> __test_dev_config_update_size_t() unlocked versions of the functions
> were introduced to be called from the locked contexts as a workaround
> without releasing the main driver's lock and thereof causing a race
> condition.
> 
> The test_dev_config_update_bool(), test_dev_config_update_u8() and
> test_dev_config_update_size_t() locked versions of the functions
> are being called from driver methods without the unnecessary multiplying
> of the locking and unlocking code for each method, and complicating
> the code with saving of the return value across lock.
> 
> Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Colin Ian King <colin.i.king@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: stable@vger.kernel.org # v5.4
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: https://lore.kernel.org/r/20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 05ed84c2fc4c..35417e0af3f4 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -353,16 +353,26 @@ static ssize_t config_test_show_str(char *dst,
>   	return len;
>   }
>   
> +static inline int __test_dev_config_update_bool(const char *buf, size_t size,
> +				       bool *cfg)
> +{
> +	int ret;
> +
> +	if (kstrtobool(buf, cfg) < 0)
> +		ret = -EINVAL;
> +	else
> +		ret = size;
> +
> +	return ret;
> +}
> +
>   static int test_dev_config_update_bool(const char *buf, size_t size,
>   				       bool *cfg)
>   {
>   	int ret;
>   
>   	mutex_lock(&test_fw_mutex);
> -	if (kstrtobool(buf, cfg) < 0)
> -		ret = -EINVAL;
> -	else
> -		ret = size;
> +	ret = __test_dev_config_update_bool(buf, size, cfg);
>   	mutex_unlock(&test_fw_mutex);
>   
>   	return ret;
> @@ -373,7 +383,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
>   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>   }
>   
> -static int test_dev_config_update_size_t(const char *buf,
> +static int __test_dev_config_update_size_t(
> +					 const char *buf,
>   					 size_t size,
>   					 size_t *cfg)
>   {
> @@ -384,9 +395,7 @@ static int test_dev_config_update_size_t(const char *buf,
>   	if (ret)
>   		return ret;
>   
> -	mutex_lock(&test_fw_mutex);
>   	*(size_t *)cfg = new;
> -	mutex_unlock(&test_fw_mutex);
>   
>   	/* Always return full write size even if we didn't consume all */
>   	return size;
> @@ -402,7 +411,7 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
>   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>   }
>   
> -static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
> +static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
>   {
>   	u8 val;
>   	int ret;
> @@ -411,14 +420,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
>   	if (ret)
>   		return ret;
>   
> -	mutex_lock(&test_fw_mutex);
>   	*(u8 *)cfg = val;
> -	mutex_unlock(&test_fw_mutex);
>   
>   	/* Always return full write size even if we didn't consume all */
>   	return size;
>   }
>   
> +static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
> +{
> +	int ret;
> +
> +	mutex_lock(&test_fw_mutex);
> +	ret = __test_dev_config_update_u8(buf, size, cfg);
> +	mutex_unlock(&test_fw_mutex);
> +
> +	return ret;
> +}
> +
>   static ssize_t test_dev_config_show_u8(char *buf, u8 val)
>   {
>   	return snprintf(buf, PAGE_SIZE, "%u\n", val);
> @@ -471,10 +489,10 @@ static ssize_t config_num_requests_store(struct device *dev,
>   		mutex_unlock(&test_fw_mutex);
>   		goto out;
>   	}
> -	mutex_unlock(&test_fw_mutex);
>   
> -	rc = test_dev_config_update_u8(buf, count,
> -				       &test_fw_config->num_requests);
> +	rc = __test_dev_config_update_u8(buf, count,
> +					 &test_fw_config->num_requests);
> +	mutex_unlock(&test_fw_mutex);
>   
>   out:
>   	return rc;
> @@ -518,10 +536,10 @@ static ssize_t config_buf_size_store(struct device *dev,
>   		mutex_unlock(&test_fw_mutex);
>   		goto out;
>   	}
> -	mutex_unlock(&test_fw_mutex);
>   
> -	rc = test_dev_config_update_size_t(buf, count,
> -					   &test_fw_config->buf_size);
> +	rc = __test_dev_config_update_size_t(buf, count,
> +					     &test_fw_config->buf_size);
> +	mutex_unlock(&test_fw_mutex);
>   
>   out:
>   	return rc;
> @@ -548,10 +566,10 @@ static ssize_t config_file_offset_store(struct device *dev,
>   		mutex_unlock(&test_fw_mutex);
>   		goto out;
>   	}
> -	mutex_unlock(&test_fw_mutex);
>   
> -	rc = test_dev_config_update_size_t(buf, count,
> -					   &test_fw_config->file_offset);
> +	rc = __test_dev_config_update_size_t(buf, count,
> +					     &test_fw_config->file_offset);
> +	mutex_unlock(&test_fw_mutex);
>   
>   out:
>   	return rc;
