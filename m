Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E94719C64
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjFAMog (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjFAMog (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 08:44:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E2124
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685623475; x=1717159475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ql3wh7W4mwjNCrhA1cUM3C4lTDO4gRUqvzrLSBdXhZ4=;
  b=JNeBRu7PQqmL3/Q30eLN5DnlVp28FOIWSHqyX0GOkE9745Hnmj7R4tat
   W3IBG07FVChEchJmzHDcuQtTRvIAxAEyVcIiZhPkrfW8MR46d143vZeOV
   N8Vt6yplEp2Z0uU9pjc5O9/XD8mdu/8OdhgJltWVP3D78eFSNMcn0vHh5
   n1hevG2c3HsGCYU3+DQ6SH9iJq0ixonvaql82IimRnDMSJiNPIG4XYcJ/
   ZIka6CEoOzp/h5iPLIgr5KKqKjwwvOABAeAJiGZgYtZ7YCZ8LBeZe2lH+
   faH4dAcQG56WthM8rs1OBTKfUzYZEXPJqTEksjeTpjdtSPBgkV0Rm0zpJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354397841"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="354397841"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 05:44:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="954061070"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="954061070"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.9.133]) ([10.213.9.133])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 05:44:27 -0700
Message-ID: <6897a425-8217-8fca-d0a0-fc02073f6b45@intel.com>
Date:   Thu, 1 Jun 2023 14:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [Intel-gfx] [PATCH] drm/i915/gt: Use the correct error value when
 kernel_context() fails
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Intel GFX <intel-gfx@lists.freedesktop.org>,
        DRI Devel <dri-devel@lists.freedesktop.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20230526124138.2006110-1-andi.shyti@linux.intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230526124138.2006110-1-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 26.05.2023 14:41, Andi Shyti wrote:
> kernel_context() returns an error pointer. Use pointer-error
> conversion functions to evaluate its return value, rather than
> checking for a '0' return.
> 
> Fixes: eb5c10cbbc2f ("drm/i915: Remove I915_USER_PRIORITY_SHIFT")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Chris Wilson < chris@chris-wilson.co.uk>
> Cc: <stable@vger.kernel.org> # v5.13+

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
>   drivers/gpu/drm/i915/gt/selftest_execlists.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> index 736b89a8ecf54..4202df5b8c122 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> @@ -1530,8 +1530,8 @@ static int live_busywait_preempt(void *arg)
>   	struct drm_i915_gem_object *obj;
>   	struct i915_vma *vma;
>   	enum intel_engine_id id;
> -	int err = -ENOMEM;
>   	u32 *map;
> +	int err;
>   
>   	/*
>   	 * Verify that even without HAS_LOGICAL_RING_PREEMPTION, we can
> @@ -1539,13 +1539,17 @@ static int live_busywait_preempt(void *arg)
>   	 */
>   
>   	ctx_hi = kernel_context(gt->i915, NULL);
> -	if (!ctx_hi)
> -		return -ENOMEM;
> +	if (IS_ERR(ctx_hi))
> +		return PTR_ERR(ctx_hi);
> +
>   	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
>   
>   	ctx_lo = kernel_context(gt->i915, NULL);
> -	if (!ctx_lo)
> +	if (IS_ERR(ctx_lo)) {
> +		err = PTR_ERR(ctx_lo);
>   		goto err_ctx_hi;
> +	}
> +
>   	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
>   
>   	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);

